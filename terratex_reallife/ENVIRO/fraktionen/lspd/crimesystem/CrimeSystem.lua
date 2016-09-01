--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 21.07.2016
-- Time: 16:16
-- To change this template use File | Settings | File Templates.
--
CrimeSystem.syncObject = false;
function createCrimeSystemSyncObject()
    CrimeSystem.syncObject = createElement("SyncElement", "CrimeSystem");
    CrimeSystem.loadCrimeTableToSyncObject();
    setTimer(CrimeSystem.loadCrimeTableToSyncObject, 1800000, 0);
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createCrimeSystemSyncObject)

function CrimeSystem.loadCrimeTableToSyncObject()
    local query = dbQuery(MySql._connection, "SELECT  dcl.ID, dcl.Name, dcl.CategorieID, dcl.MinPercentage, dcl.Percentage, dcc.CategorieName, dcc.hidden FROM data_crimes_list AS dcl LEFT JOIN data_crimes_categories AS dcc ON dcl.CategorieID = dcc.ID ORDER BY dcl.CategorieID ASC, dcl.ID ASC");
    local result = dbPoll(query, -1);

    local crimesById = {};
    local crimesByCategorieIdById = {};

    for theKey, theRow in ipairs(result) do
        crimesById[tonumber(theRow.ID)] = theRow;
        if (not crimesByCategorieIdById[tonumber(theRow.CategorieID)]) then
            crimesByCategorieIdById[tonumber(theRow.CategorieID)] = {
                name = theRow.CategorieName,
                hidden = theRow.hidden,
                crimes = {}
            };
        end
        crimesByCategorieIdById[theRow.CategorieID].crimes[tonumber(theRow.ID)] = theRow;
    end

    vioSetElementData(CrimeSystem.syncObject, "CrimesById", crimesById);
    vioSetElementData(CrimeSystem.syncObject, "CrimesByCategorieIdById", crimesByCategorieIdById);
end

function CrimeSystem.getCrimePercentage(thePlayer)
    local query = "SELECT sum(CrimePercentage) as CrimeLevel FROM user_crimes WHERE Nickname = ?";
    local executedQuery = dbQuery(MySql._connection, query, getPlayerName(thePlayer));

    local result = dbPoll(executedQuery, -1);

    if (result and result[1]) then
        local crimeLevel = tonumber(result[1].CrimeLevel);
        if (crimeLevel) then
            if (crimeLevel > 100) then
                return 100;
            else
                return crimeLevel;
            end
        else
            return 0;
        end
    else
        return 0;
    end
end

function CrimeSystem.getSuspects()
    local playersTotal = getElementsByType("player");
    local playerNamesLoggedIn = {};

    for theKey, thePlayer in ipairs(playersTotal) do
        if (vioGetElementData(thePlayer, "loggedin")) then
            table.insert(playerNamesLoggedIn, getPlayerName(thePlayer));
        end
    end

    local query = "SELECT sum(CrimePercentage) as CrimeLevel, Nickname FROM user_crimes WHERE Nickname IN (";

    local y = 0;
    local size = table.getSize(playerNamesLoggedIn);
    for y = 0, size, 1 do
        if (y > 0) then
            query = query .. ",";
        end

        query = query .. "??";
    end

    query = query .. ") GROUP BY Nickname";

    local executedQuery = dbQuery(MySql._connection, query, unpack(playerNamesLoggedIn));

    local result = dbPoll(executedQuery, -1);

    return result;
end

--- whoGives can be: userelement or string or table {display = , user = }
function CrimeSystem.addNewCrime(thePlayer, crimeId, whoGives, additionalComment)

    local query = "SELECT dcl.Percentage FROM data_crimes_list AS dcl ";
    query = query .. "LEFT JOIN data_crimes_categories as dcc ON dcl.CategorieID = dcc.ID ";
    query = query .. "WHERE dcl.ID = ? ";
    if (isElement(whoGives)) then
        if (not isAdminLevel(whoGives, 0) and isBeamter(whoGives)) then
            query = query .. "AND dcc.hidden = 0";
        end
    end

    local handler = dbQuery(MySql._connection, query, crimeId);
    local result, countRows = dbPoll(handler, -1);

    if (countRows > 0 or table.getSize(result) > 0) then

        if not additionalComment then additionalComment = "" end

        local percentage = MySql.helper.getValueSync("data_crimes_list", "Percentage", {ID = crimeId});

        local pName = thePlayer;
        if (isElement(thePlayer)) then
            pName = getPlayerName(thePlayer);
        end

        local columnData = {
            Nickname = getPlayerName(thePlayer),
            CrimeID = crimeId,
            CrimePercentage = percentage,
            AdditionalReason = additionalComment
        };

        if type(whoGives)== "table" then
            columnData.ReporterUser = getPlayerName(whoGives.user);
            columnData.ReporterDisplay = whoGives.display
        elseif type(whoGives) == "userdata" then
            columnData.ReporterUser = getPlayerName(whoGives);
        else
            columnData.ReporterDisplay = whoGives
        end

        local addCrime = MySql.helper.insertSync("user_crimes", columnData);

        if (isElement(thePlayer)) then
            vioSetElementData(thePlayer, "crimeLevel", CrimeSystem.getCrimePercentage(thePlayer));
        end

        return addCrime;
    else
        return false;
    end
end

function CrimeSystem.clear(thePlayer)
    MySql.helper.delete("user_crimes", {Nickname = getPlayerName(thePlayer)});
    vioSetElementData(thePlayer, "crimeLevel", 0)
end

function CrimeSystem.getCrimeName(crimeId)
    local exist = MySql.helper.existSync("data_crimes_list", {ID = crimeId});

    if (exist) then
        local name = MySql.helper.getValueSync("data_crimes_list", "Name", {ID = crimeId});

        return name;
    end
end