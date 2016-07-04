--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 04.07.2016
-- Time: 16:29
-- To change this template use File | Settings | File Templates.
--

addEvent("getFactionOverviewData", true);
function getFactionOverviewData_func()
    local fraktion = vioGetElementData(source, "fraktion");

    local mats = "-";
    local drugs = "-";
    if (frakmun[fraktion]) then mats = math.Tausend(frakmun[fraktion]) end
    if (frakdrogen[fraktion]) then drugs = math.Tausend(frakdrogen[fraktion]) .. "g" end

    local members = MySql.helper.getSync("user_data", { "Nickname" }, { Fraktion = fraktion });


    local fraktionsmember = getAllMemberNamesFromFaction(fraktion);

    local resultTable = {
        frakname = fraktionbezeichner[fraktion],
        memberCount = table.getSize(fraktionsmember),
        maxMember = MySql.helper.getValueSync("faction_inventory", "max_members", { FrakID = fraktion }),
        frakkasse = toprice(frakkasse[fraktion]),
        drugs = drugs,
        mats = mats,
        tax = fraksteuer[fraktion]
    };

    triggerClientEvent(source, "sendFactionOverviewData", source, resultTable);
end
addEventHandler("getFactionOverviewData", getRootElement(), getFactionOverviewData_func)


function getAllMemberNamesFromFaction(fraktion)
    local onlinePlayers = getPlayersByDataValue("fraktion", fraktion )
    local fraktionsmember = {};

    for theKey, theList in ipairs(members) do
        if (getPlayerFromName(theList.Nickname)) then
            -- Is Player In Faction or has he left the faction?
            if (vioGetElementData(getPlayerFromName(theList.Nickname), "fraktion") == fraktion) then
                table.insert(fraktionsmember, theList.Nickname);
            end
        else
            table.insert(fraktionsmember, theList.Nickname);
        end
    end

    for theKey, thePlayer in ipairs(onlinePlayers) do
        if (not table.hasValue(fraktionsmember, getPlayerName(thePlayer))) then
            table.insert(fraktionsmember, getPlayerName(thePlayer));
        end
    end

    return fraktionsmember;
end