--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 21.07.2016
-- Time: 16:16
-- To change this template use File | Settings | File Templates.
--

function getCrimePercentage(thePlayer)
    local query = "SELECT sum(CrimePercentage) as CrimeLevel FROM user_crimes WHERE Nickname = ?";
    local executedQuery = dbQuery(MySql._connection, query, getPlayerName(thePlayer));

    local result = dbPoll(executedQuery, -1);

    if (result and result[1]) then
        local crimeLevel = tonumber(result[1].CrimeLevel);
        if (crimeLevel > 100) then
            return 100;
        else
            return crimeLevel;
        end
    else
        return 0;
    end
end

-- @todo: optional: Who gives that?
function addNewCrime(thePlayer, crimeId, additionalComment)
    local exist = MySql.helper.existSync("data_crimes_list", {ID = crimeId});

    if (exist) then
        if not additionalComment then additionalComment = "" end

        local percentage = MySql.helper.getValueSync("data_crimes_list", "CrimePercentage", {ID = crimeId});

        MySql.helper.insert("user_crimes", {
            Nickname = getPlayerName(thePlayer),
            CrimeID = crimeId,
            CrimePercentage = percentage,
            AdditionalReason = additionalComment
        });

        vioSetElementData(thePlayer, "crimeLevel", getCrimePercentage(thePlayer));
    else
        return false;
    end
end

-- @todo: addCustomCrime