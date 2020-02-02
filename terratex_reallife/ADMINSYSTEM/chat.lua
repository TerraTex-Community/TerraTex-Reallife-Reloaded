--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 13.07.2016
-- Time: 13:35
-- To change this template use File | Settings | File Templates.
--

function report_func(theMaker, command, text, ...)
    if not (text) then
        outputChatBox("Nutzung: /report [Text]", theMaker, 255, 0, 0)
    else
        local message = text .. " " .. table.concat({ ... }, "  ")
        outputChatBox("Dein Report wurde gesendet.", theMaker)
        chat_log(theMaker, "Report: " .. message)
        local players = getElementsByType("player")
        local adminsOnline = 0
        local adminsAfk = 0
        for theKey, thePlayer in ipairs(players) do

            if (isAdminLevel(thePlayer, 0)) then
                outputChatBox("Report von " .. getPlayerName(theMaker) .. ": " .. message, thePlayer, 255, 255, 0)
                adminsOnline = adminsOnline + 1
                if (vioGetElementData(thePlayer, "afk_status") == 1) then
                    adminsAfk = adminsAfk + 1
                end
            end
        end
        if (adminsOnline == 0) then
            outputChatBox("Leider ist derzeit kein Mitglied des Supportteams online. Bei Problemen erreichst du uns im Forum http://www.terratex.eu", theMaker)
        elseif (adminsAfk == adminsOnline) then
            outputChatBox("Derzeit sind alle TTeams abwesend. Dein Report wird möglicherweise erst verzögert bearbeitet.", theMaker)
        end
    end
end
addCommandHandler("report", report_func, false, false)

function a_func(theMaker, Command, ...)
    local message = table.concat({ ... }, "  ")
    local adminpre = "";
    if (isAdminLevel(theMaker, 0)) then
        if (vioGetElementData(theMaker, "SupportLVL") == 1) then adminpre = "Supporter " end
        if (vioGetElementData(theMaker, "adminlvl") == 1) then adminpre = "Moderator " end
        if (vioGetElementData(theMaker, "adminlvl") == 2) then adminpre = "SuperModerator " end
        if (vioGetElementData(theMaker, "adminlvl") == 3) then adminpre = "Administrator " end
        if (vioGetElementData(theMaker, "adminlvl") == 4) then adminpre = "Serverleiter " end
        if (vioGetElementData(theMaker, "adminlvl") == 5) then adminpre = "[Hidden] " end
        if (vioGetElementData(theMaker, "adminlvl") == 1337 ) then adminpre = "1337 Gott " end

        local players = getElementsByType("player")
        for theKey, thePlayer in ipairs(players) do
            if (isPlayerLoggedIn(thePlayer)) then
                if (isAdminLevel(thePlayer, 0)) then
                    outputChatBox(adminpre .. " " .. getPlayerName(theMaker) .. ": " .. message, thePlayer, 255, 255, 0)
                end
            end
        end
    end
end
addCommandHandler("a", a_func, false, false)

function w_func(theMaker, Command, thePlayerName, ...)
    if (isAdminLevel(theMaker, 0)) then
        local message = table.concat({ ... }, "  ")
        local thePlayeri = getPlayerFromIncompleteName(thePlayerName)
        if (thePlayeri) then
            outputChatBox("Dein Wisper wurde gesendet.", theMaker, 255, 255, 0)
            outputChatBox("Nachricht von Admin/Supporter " .. getPlayerName(theMaker) .. ": " .. message, thePlayeri, 255, 255, 0)
            outputChatBox("Du kannst mit /re antworten!", thePlayeri)
            vioSetElementData(thePlayeri, "re_able", theMaker)

            for theKey, thePlayer in ipairs(getElementsByType("player")) do
                if (isAdminLevel(thePlayer, 0)) then
                    outputChatBox(getPlayerName(theMaker) .. " hat ein Supportchannel mit " .. getPlayerName(thePlayeri) .. " gestartet!", thePlayer, 255, 255, 0)
                end
            end
        else
            showError(theMaker, "Dieser Spieler existiert nicht!")
        end
    end
end
addCommandHandler("w", w_func, false, false)

function re_func(theMaker, Command, ...)
    local message = table.concat({ ... }, "  ")
    if isElement(vioGetElementData(theMaker, "re_able")) then
        if (getPlayerName(vioGetElementData(theMaker, "re_able"))) then
            outputChatBox("Antwort von " .. getPlayerName(theMaker) .. ": " .. message, vioGetElementData(theMaker, "re_able"), 255, 255, 0)
            outputChatBox("Du kannst mit /re antworten!", vioGetElementData(theMaker, "re_able"))
            outputChatBox("Deine Antwort wurde an " .. getPlayerName(vioGetElementData(theMaker, "re_able")) .. " gesendet!", theMaker)
            vioSetElementData(vioGetElementData(theMaker, "re_able"), "re_able", theMaker)
        else
            outputChatBox("Dir hat keine Person geschrieben!", theMaker, 255, 0, 0)
        end
    else
        outputChatBox("Dir hat keine Person geschrieben!", theMaker, 255, 0, 0)
    end
end
addCommandHandler("re", re_func, false, false)

function occ_func(theMaker, Command, ...)
    local message = table.concat({ ... }, "  ")
    if (isAdminLevel(theMaker, 0)) then
        local adminpre = ""
        if (vioGetElementData(theMaker, "SupportLVL") == 1) then adminpre = "Supporter " end
        if (vioGetElementData(theMaker, "adminlvl") == 1) then adminpre = "Moderator " end
        if (vioGetElementData(theMaker, "adminlvl") == 2) then adminpre = "SuperModerator " end
        if (vioGetElementData(theMaker, "adminlvl") == 3) then adminpre = "Administrator " end
        if (vioGetElementData(theMaker, "adminlvl") == 4) then adminpre = "Serverleiter " end
        if (vioGetElementData(theMaker, "adminlvl") == 5) then adminpre = "[Hidden] " end
        if (vioGetElementData(theMaker, "adminlvl") == 6) then adminpre = "Developer " end
        message = "[[ " .. adminpre .. getPlayerName(theMaker) .. ": " .. message .. " ]]"
        outputChatBox(message, getRootElement(), 255, 20, 147)
    end
end
addCommandHandler("o", occ_func, false, false)

function clearChat_func(theMaker)
    if (isAdminLevel(theMaker, 0)) then
        for i = 1, 100 do
            outputChatBox(" ")
        end
    end
end
addCommandHandler("cleartext", clearChat_func, false, false)
