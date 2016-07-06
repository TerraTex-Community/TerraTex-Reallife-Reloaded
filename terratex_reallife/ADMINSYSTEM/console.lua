--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 05.07.2016
-- Time: 15:58
-- To change this template use File | Settings | File Templates.
--
-- @description In This File are Commands and Functions only for Serverconsole usage
--

function consoleListPlayers(thePlayer)
    if (isConsole(thePlayer)) then
        local userNames = {};
        for theKey, theUser in ipairs(getElementsByType("player")) do
            table.insert(userNames, getPlayerName(theUser));
        end

        outputDebugString("Players Online: " .. table.concat(userNames, ", "));
    end
end
addCommandHandler("listplayers", consoleListPlayers, false, false)
