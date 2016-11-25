--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 24.11.2016
-- Time: 14:29
-- To change this template use File | Settings | File Templates.
--

function apiGetListOfPlayers()
    local players = getElementsByType("player");
    local result = {};

    for theKey, thePlayer in ipairs(players) do
        local playerObject = {
            Name = getPlayerName(thePlayer),
            IP = getPlayerIP(thePlayer),
            Serial = getPlayerSerial(thePlayer),
            PlayerData = getAllElementData ( thePlayer )
        };
        table.insert(result, playerObject);
    end

    return result;
end

function apiIsPlayerOnline(playername)
    if (getPlayerFromIncompleteName(playername)) then
        if (isPlayerLoggedIn(playername)) then
            return true;
        else
            return false;
        end
    else
        return false;
    end
end


