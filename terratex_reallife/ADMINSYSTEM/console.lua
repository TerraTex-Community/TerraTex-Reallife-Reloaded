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
