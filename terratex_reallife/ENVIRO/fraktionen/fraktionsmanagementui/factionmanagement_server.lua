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

addEvent("getFactionMemberData", true);
function getFactionMemberData_func(returnEvent)
    if not returnEvent then returnEvent = "sendFactionMemberData" end

    local fraktion = vioGetElementData(source, "fraktion");
    local names, fraktionsmember = getAllMemberNamesFromFaction(fraktion);

    local memberByRanks = {};
    local rankId = 1
    for rankId = 1, 6, 1 do
        local tmpTable = {
            rankName = fraktionsrange[fraktion][rankId],
            members = {}
        };
        table.insert(memberByRanks, tmpTable);
    end

    for theKey, theMember in ipairs(fraktionsmember) do
        table.insert(memberByRanks[theMember.Fraktionsrang].members, theMember);
    end

    triggerClientEvent(source, returnEvent, source, memberByRanks);
end
addEventHandler("getFactionMemberData", getRootElement(), getFactionMemberData_func)

function getAllMemberNamesFromFaction(fraktion)
    local onlinePlayers = getPlayersByDataValue("fraktion", fraktion )
    --local members = MySql.helper.getSync("user_data", { "Nickname", "Fraktionsrang"  }, { Fraktion = fraktion });
    local query = "SELECT user_data.Nickname, user_data.Fraktionsrang, user.LastLogin, user.AktiveDays FROM user_data LEFT JOIN user ON user_data.Nickname = user.Nickname WHERE user_data.Fraktion = ?";
    local result = dbQuery(MySql._connection, query, fraktion);
    local members = dbPoll(result, -1);

    local fraktionsMemberOnlyNames = {};
    local fraktionsMember = {};

    for theKey, theList in ipairs(members) do
        if (not getPlayerFromName(theList.Nickname)) then
            table.insert(fraktionsMember, theList);
            table.insert(fraktionsMemberOnlyNames, theList.Nickname);
        end
    end

    for theKey, thePlayer in ipairs(onlinePlayers) do
        if (not table.hasValue(fraktionsMemberOnlyNames, getPlayerName(thePlayer))) then
            table.insert(fraktionsMember, {
                Nickname = getPlayerName(thePlayer),
                Fraktionsrang = vioGetElementData(thePlayer, "fraktionsrang"),
                LastLogin = "ist gerade Online",
                AktiveDays = 0
            });
            table.insert(fraktionsMemberOnlyNames, getPlayerName(thePlayer));
        end
    end

    return fraktionsMemberOnlyNames, fraktionsMember;
end

function factionManagementKickMember_func(nickname)
    if (getPlayerFromName(nickname)) then
        local player = getPlayerFromName(nickname);
        if (vioGetElementData(player, "fraktion") == vioGetElementData(source, "fraktion")) then
            vioSetElementData(player, "fraktion", 0)
            vioSetElementData(player, "fraktionsrang", 0)

            outputChatBox("Du wurdest von " .. getPlayerName(source) .. " aus der Fraktion geworfen.");
            showError(source, "Du hast " .. nickname .. " aus der Fraktion geworfen!");

            triggerClientEvent(source, "factionManagementMemberKick", source, nickname);
        end
    else
        local exist = MySql.helper.existSync("user_data", {
            Fraktion = vioGetElementData(source, "fraktion"),
            Nickname = nickname
        });

        if (exist) then
            MySql.helper.update("user_data", {Fraktionsrang = 0, Fraktion = 0}, {
                Fraktion = vioGetElementData(source, "fraktion"),
                Nickname = nickname
            });

            save_offline_message(nickname, getPlayerName(source), "Du wurdest aus deiner Fraktion entfernt.");
            showError(source, "Du hast " .. nickname .. " aus der Fraktion geworfen!");
            triggerClientEvent(source, "factionManagementMemberKick", source, nickname);
        end
    end
end
addEvent("factionManagementKickMember", true);
addEventHandler("factionManagementKickMember", getRootElement(), factionManagementKickMember_func)

function factionManagementGiveRankMember_func(nickname, rank)
    if (getPlayerFromName(nickname)) then
        local player = getPlayerFromName(nickname);
        if (vioGetElementData(player, "fraktion") == vioGetElementData(source, "fraktion")) then
            vioSetElementData(player, "fraktionsrang", rank)

            outputChatBox("Du wurdest von " .. getPlayerName(source) .. " auf Rang ".. rank .." gesetzt.");
            showError(source, "Du hast " .. nickname .. " auf Rang ".. rank .." gesetzt.");

            triggerClientEvent(source, "factionManagementMemberGiveRank", source, nickname, rank);
        end
    else

        local exist = MySql.helper.existSync("user_data", {
            Fraktion = vioGetElementData(source, "fraktion"),
            Nickname = nickname
        });

        if (exist) then
            MySql.helper.update("user_data", {Fraktionsrang = rank}, {
                Fraktion = vioGetElementData(source, "fraktion"),
                Nickname = nickname
            });

            save_offline_message(nickname, getPlayerName(source), "Du wurdest auf Rang ".. rank .." gesetzt.");
            showError(source, "Du hast " .. nickname .. " auf Rang ".. rank .." gesetzt.");
            triggerClientEvent(source, "factionManagementMemberGiveRank", source, nickname, rank);
        end
    end
end
addEvent("factionManagementGiveRankMember", true);
addEventHandler("factionManagementGiveRankMember", getRootElement(), factionManagementGiveRankMember_func)