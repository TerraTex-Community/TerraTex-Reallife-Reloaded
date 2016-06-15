local isStellBoit = {}
local isStellBoit = {}

function onStellBotSpawn()
    local bot = createPed(280, 238.961914062, 112.734375, 1003.21875, 274.67611694336)
    isStellBoit[bot] = true
    setElementInterior(bot, 10)
    bot = createPed(280, 233.044921875, 166.481445, 1003.02343, 265.45846557617)
    isStellBoit[bot] = true
    setElementInterior(bot, 3)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onStellBotSpawn)

function StellenNow(thePlayer)
    if (vioGetElementData(thePlayer, "stellenInfos") == vioGetElementData(thePlayer, "wanteds")) then
        local x, y, z = getElementPosition(thePlayer)
        if (getDistanceBetweenPoints3D(x, y, z, 238.961914062, 112.734375, 1003.21875) < 5 or getDistanceBetweenPoints3D(x, y, z, 233.044921875, 166.4814453125, 1003.0234375) < 5) then
            if not (isPedDead(thePlayer)) then

                local wanted = vioGetElementData(thePlayer, "wanteds")
                vioSetElementData(thePlayer, "wanteds", 0)
                setPlayerWantedLevel(thePlayer, 0)
                vioSetElementData(thePlayer, "kaution", wanted * wanted * 30 * wanted)
                Kaution = wanted * wanted * 30 * wanted
                if (vioGetElementData(thePlayer, "playtime") > 1500) then
                    vioSetElementData(thePlayer, "kaution", wanted * 25000)
                    Kaution = wanted * 25000
                end

                vioSetElementData(thePlayer, "knastzeit", wanted * 7)
                vioSetElementData(thePlayer, "lastknastzeit", wanted * 7)
                setElementModel(thePlayer, 62)
                changePlayerMoney(thePlayer, -(2.00 * wanted * wanted), "sonstiges", "Knast mit Stellen beim Bot")
                if (Kaution == 0) then Kaution = "keine" else Kaution = toprice(Kaution) end
                outputChatBox(string.format("Du sitzt %s Minuten im Knast. Kaution: %s", (wanted * 7), Kaution), thePlayer)
                outputChatBoxForPolice(string.format("Der Stellbot hat %s eingesperrt!", getPlayerName(thePlayer)))
                local rnd = math.floor(math.random(1, 4))
                if rnd == 1 then
                    setElementPosition(thePlayer, 215.61360168457, 110.61786651611, 998.66485595703)
                elseif rnd == 2 then
                    setElementPosition(thePlayer, 219.60717773438, 110.39416503906, 998.66485595703)
                elseif rnd == 3 then
                    setElementPosition(thePlayer, 223.60034179688, 110.17053222656, 998.66485595703)
                else
                    setElementPosition(thePlayer, 227.34938049316, 110.19967651367, 998.66485595703)
                end

            else
                outputChatBox("Stellen Abgebrochen: Du bist Tod", thePlayer, 255, 0, 0)
            end
        else
            outputChatBox("Stellen Abgebrochen: Vom Stellpunkt entfernt", thePlayer, 255, 0, 0)
        end
    else
        outputChatBox("Stellen Abgebrochen: Wantedanzahl hat sich geändert", thePlayer, 255, 0, 0)
    end
end

function onStellenClick(mouseButton, buttonState, clickedElement)
    if (buttonState == "up") then
        if (isStellBoit[clickedElement]) then
            if (vioGetElementData(source, "wanteds") > 0 and not (vioGetElementData(toPlayer, "mussAlka") == 1)) then
                outputChatBox("Willst du dich stellen? Dann gebe '/accept stellen' ein", source, 255, 0, 0)
                vioSetElementData(source, "canStellen", true)
            end
        end
    end
end

addEventHandler("onPlayerClick", getRootElement(), onStellenClick)

function beamtenchat(thePlayer, command, ...)
    local reason = table.concat({ ... }, " ")
    if (isBeamter(thePlayer) or (vioGetElementData(thePlayer, "fraktion") == 10)) then
        local name = getPlayerName(thePlayer)
        local frak = fraktionbezeichner[vioGetElementData(thePlayer, "fraktion")]
        local frakrang = fraktionsrange[vioGetElementData(thePlayer, "fraktion")][vioGetElementData(thePlayer, "fraktionsrang")]
        chat_log(thePlayer, string.format("Beamtenchat: %s", reason))
        local message = string.format("**%s %s %s: %s , over **", frak, frakrang, name, reason)
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[1])) do
            outputChatBox(message, thePlayers, 255, 130, 130)
        end
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[5])) do
            outputChatBox(message, thePlayers, 255, 130, 130)
        end
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[7])) do
            outputChatBox(message, thePlayers, 255, 130, 130)
        end
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[9])) do
            outputChatBox(message, thePlayers, 255, 130, 130)
        end
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[10])) do
            outputChatBox(message, thePlayers, 255, 130, 130)
        end
    end
end

addCommandHandler("b", beamtenchat, false, false)

function outputChatBoxForPolice(message, c, d, e)
    if (not (c) or not (d) or not (e)) then
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[1])) do
            outputChatBox(message, thePlayers, 0, 0, 255)
        end
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[5])) do
            outputChatBox(message, thePlayers, 0, 0, 255)
        end
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[7])) do
            outputChatBox(message, thePlayers, 0, 0, 255)
        end
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[9])) do
            outputChatBox(message, thePlayers, 0, 0, 255)
        end
    else
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[1])) do
            outputChatBox(message, thePlayers, c, d, e)
        end
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[5])) do
            outputChatBox(message, thePlayers, c, d, e)
        end
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[7])) do
            outputChatBox(message, thePlayers, c, d, e)
        end
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[9])) do
            outputChatBox(message, thePlayers, c, d, e)
        end
    end
end

function isBeamter(thePlayer)
    if (vioGetElementData(thePlayer, "fraktion") == 1) or (vioGetElementData(thePlayer, "fraktion") == 5) or (vioGetElementData(thePlayer, "fraktion") == 7) or (vioGetElementData(thePlayer, "fraktion") == 9) then
        return true
    else
        return false
    end
end

function antiofflineflucht_func(quitType, reason, responsibleElement)
    if (isPlayerLoggedIn(source)) then
        if not (vioGetElementData(source, "cuffed")) then
            vioSetElementData(source, "cuffed", 0)
        end
        if not (vioGetElementData(source, "schutzzahlung")) then
            vioSetElementData(source, "schutzzahlung", 0)
        end
        if not (vioGetElementData(source, "wanteds")) then
            vioSetElementData(source, "wanteds", 0)
        end
        if (quitType == "Quit") then
            local x, y, z = getElementPosition(source)
            local gangInNear = 0
            local policeInNear = 0
            for theKey, thePlayer in ipairs(getElementsByType("player")) do
                if (isBeamter(thePlayer)) then
                    local px, py, pz = getElementPosition(thePlayer)
                    local dis = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
                    if (dis < 20) then
                        policeInNear = policeInNear + 1
                    end
                end
                if (vioGetElementData(thePlayer, "fraktion") == 5 or vioGetElementData(thePlayer, "fraktion") == 2) or vioGetElementData(thePlayer, "fraktion") == 12 or vioGetElementData(thePlayer, "fraktion") == 11 then
                    local px, py, pz = getElementPosition(thePlayer)
                    local dis = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
                    if (dis < 20) then
                        gangInNear = gangInNear + 1
                    end
                end
            end
            if ((vioGetElementData(source, "cuffed") == 1) or (gangInNear > 0 and vioGetElementData(source, "schutzzahlung") > 0) or (policeInNear > 0 and vioGetElementData(source, "wanteds") > 0)) then
                if (policeInNear > 0) then
                    if (vioGetElementData(source, "wanteds") > 0) then
                        vioSetElementData(source, "knastzeit", vioGetElementData(source, "wanteds") * 10 + 20)
                        vioSetElementData(source, "lastknastzeit", vioGetElementData(source, "wanteds") * 10 + 20)
                        vioSetElementData(source, "alkaknast", 1)
                        changePlayerMoney(source, -vioGetElementData(source, "wanteds") * 500, "sonstiges", "Knast mit Offlineflucht")
                        vioSetElementData(source, "wanteds", 0)
                        save_offline_message(getPlayerName(source), "Anti-Offlineflucht-System", "Da du absichtlich Offlineflucht begangen hast, wurdest du automatisch eingeknastet (+20 Min Strafe)!")
                    end
                end
                for theKey, thePlayer in ipairs(getElementsByType("player")) do
                    if (isAdminLevel(thePlayer, 1)) then
                        outputChatBox(string.format("Mögliche Offlineflucht von %s", getPlayerName(source)), thePlayer, 255, 0, 0)
                    end
                end
            end
        end
    end
end

addEventHandler("onPlayerQuit", getRootElement(), antiofflineflucht_func)

function setPlayerCuffedInVar(thePlayer)
    vioSetElementData(thePlayer, "cuffedIn", source)
end

addEventHandler("onVehicleEnter", getRootElement(), setPlayerCuffedInVar)

function frisk_func(thePlayer, Command, vonPlayerName)
    if (isBeamter(thePlayer)) then
        if (vonPlayerName) then
            local vonPlayer = getPlayerFromIncompleteName(vonPlayerName)
            if (vonPlayer) then
                local xv, yv, zv = getElementPosition(vonPlayer)
                local xt, yt, zt = getElementPosition(thePlayer)
                local dis = getDistanceBetweenPoints3D(xv, yv, zv, xt, yt, zt)
                if (dis < 10) then
                    local foundsomething = 0
                    outputChatBox(string.format("%s hat sie durchsucht!", getPlayerName(thePlayer)), vonPlayer, 0, 255, 255)
                    outputChatBox(string.format("Du hast %s durchsucht. Du hast gefunden:", getPlayerName(vonPlayer)), thePlayer, 0, 255, 255)
                    if (vioGetElementData(vonPlayer, "drogen") > 0) then
                        outputChatBox(string.format("%s Gramm Drogen", vioGetElementData(vonPlayer, "drogen")), thePlayer, 0, 255, 255)
                        foundsomething = 1
                    end
                    if (vioGetElementData(vonPlayer, "mats") > 0) then
                        outputChatBox(string.format("%s Materialien", vioGetElementData(vonPlayer, "mats")), thePlayer, 0, 255, 255)
                        foundsomething = 1
                    end
                    local hasweapons = 0
                    for n = 1, 12, 1 do
                        if not (getPedWeapon(vonPlayer, n) == 0) then
                            hasweapons = hasweapons + 1
                        end
                    end
                    if (hasweapons > 0) then
                        outputChatBox(string.format("%s verschiedene Waffen", hasweapons), thePlayer, 0, 255, 255)
                        foundsomething = 1
                    end
                    if (foundsomething == 0) then
                        outputChatBox("Nichts!", thePlayer, 0, 255, 255)
                    end
                    outputChatBox("Drogen- und Alkoholtest läuft.....", thePlayer, 0, 255, 255)
                    triggerClientEvent(vonPlayer, "checkalkdrug", thePlayer)
                end
            end
        end
    end
end

addCommandHandler("frisk", frisk_func, false, false)

addEvent("sendAlkDrugData", true)
function sendAlkDrugData_func(drug, alk)
    outputChatBox("Drogen- und Alkoholtest abgeschlossen. Ergebnis:", source, 0, 255, 255)
    outputChatBox(string.format("Drogen im Blut: %s g", math.round(drug, 2)), source, 0, 255, 255)
    outputChatBox(string.format("Alkohol im Blut: %s Promille", math.round(alk / 2, 2)), source, 0, 255, 255)
end

addEventHandler("sendAlkDrugData", getRootElement(), sendAlkDrugData_func)

function take_func(thePlayer, Command, wasstring, vonPlayerName)
    if (isBeamter(thePlayer) or isAdminLevel(thePlayer, 1)) then
        if (wasstring) and (vonPlayerName) then
            local vonPlayer = getPlayerFromIncompleteName(vonPlayerName)
            if (vonPlayer) then
                local xv, yv, zv = getElementPosition(vonPlayer)
                local xt, yt, zt = getElementPosition(thePlayer)
                local dis = getDistanceBetweenPoints3D(xv, yv, zv, xt, yt, zt)
                if (dis < 10) then
                    if (wasstring == "FahrzeugLizensen") then
                        vioSetElementData(vonPlayer, "autoLic", -5)
                        vioSetElementData(vonPlayer, "bikeLic", -5)
                        vioSetElementData(vonPlayer, "truckLic", -5)
                        outputChatBox(string.format("Ihnen wurden die Fahrzeuglizensen (Motorrad- und Autofuehrerschein) von %s abgenommen!", getPlayerName(thePlayer)), vonPlayer, 255, 0, 0)
                        outputChatBox(string.format("Du hast %s erfolgreich die Fahrzeug Lizensen (Motorrad- und Autoführerschein) abgenommen!", getPlayerName(vonPlayer)), thePlayer, 255, 0, 0)
                    elseif (wasstring == "FlugLizensen") then
                        vioSetElementData(vonPlayer, "planeLic", -5)
                        vioSetElementData(vonPlayer, "heliLic", -5)
                        outputChatBox(string.format("Ihnen wurden die Fluglizensen (Flugzeug- und Helilizens) von %s abgenommen!", getPlayerName(thePlayer)), vonPlayer, 255, 0, 0)
                        outputChatBox(string.format("Du hast %s erfolgreich die Fluglizensen (Flugzeug- und Helilizens) abgenommen!", getPlayerName(vonPlayer)), thePlayer, 255, 0, 0)
                    elseif (wasstring == "WaffenLizens") then
                        vioSetElementData(vonPlayer, "waffenLic", -10)
                        outputChatBox(string.format("Ihnen wurden die Waffenlizens von %s abgenommen!", getPlayerName(thePlayer)), vonPlayer, 255, 0, 0)
                        outputChatBox(string.format("Du hast %s erfolgreich die Waffenlizens abgenommen!", getPlayerName(vonPlayer)), thePlayer, 255, 0, 0)
                    elseif (wasstring == "illegals") then
                        vioSetElementData(vonPlayer, "drogen", 0)
                        vioSetElementData(vonPlayer, "mats", 0)
                        outputChatBox(string.format("Ihnen wurden die Drogen und Materials von %s abgenommen!", getPlayerName(thePlayer)), vonPlayer, 255, 0, 0)
                        outputChatBox(string.format("Du hast %s erfolgreich die Drogen und Materialien abgenommen!", getPlayerName(vonPlayer)), thePlayer, 255, 0, 0)
                    elseif (wasstring == "weapons") then
                        takeAllWeapons(vonPlayer)
                        outputChatBox(string.format("Ihnen wurden die Waffen von %s abgenommen!", getPlayerName(thePlayer)), vonPlayer, 255, 0, 0)
                        outputChatBox(string.format("Du hast %s erfolgreich die Waffen abgenommen!", getPlayerName(vonPlayer)), thePlayer, 255, 0, 0)
                    else
                        showError(thePlayer, "Man kann nur folgende Dinge Abnehmen: illegals, weapons")
                    end
                end
            else
                showError(thePlayer, "Falscher Spielername")
            end
        end
    end
end

addCommandHandler("take", take_func, false, false)

function goverment_message(thePlayer, cmd, ...)
    if (vioGetElementData(thePlayer, "fraktionsrang") > 4) then
        if (isBeamter(thePlayer)) then
            outputChatBox(string.format("#FF0000|____________| #00FF00Regierungsmeldung von %s #FF0000|____________|", getPlayerName(thePlayer)), getRootElement(), 255, 255, 255, true)
            local message = table.concat({ ... }, " ")
            chat_log(thePlayer, message)
            local messages = getMessageGovComponents(message)
            for theKey, messagepart in ipairs(messages) do
                if (string.len(messagepart) > 55) then
                    --outputChatBox(messagepart)
                    local partedMessage = getMessageGovLenghtspart(messagepart)
                    for theKey, theSend in ipairs(partedMessage) do
                        outputChatBox(theSend, getRootElement(), 255, 0, 0, true)
                    end

                    --[[local begin,ende=string.find (messagepart, " ",50)
                    outputChatBox(string.sub(messagepart,0,begin),getRootElement(),255,0,0,true)
                    outputChatBox(string.sub(messagepart,ende),getRootElement(),255,0,0,true)]]
                else
                    outputChatBox(messagepart, getRootElement(), 255, 0, 0, true)
                end
            end
            --outputChatBox(,getRootElement(),255,0,0,true)
            outputChatBox(string.format("#FF0000|____________| #00FF00Regierungsmeldung von %s #FF0000|____________|", getPlayerName(thePlayer)), getRootElement(), 255, 255, 255, true)
        end
    end
end

addCommandHandler("gov", goverment_message, false, false)

function getMessageGovLenghtspart(theString)
    if (theString) then
        local stringtab = {}
        local counter = 0
        local countlast
        local zahler = 1
        while string.len(theString) > 0 do
            counterlast = counter
            --outputChatBox(theString)
            counter = string.find(theString, " ", 60)
            --outputChatBox(tostring(counter))
            if (counter) then
                stringtab[zahler] = string.sub(theString, 0, counter - 1)
                theString = string.sub(theString, counter + 1)
            else
                stringtab[zahler] = string.sub(theString, counterlast)
                theString = ""
            end
            zahler = zahler + 1
        end
        return stringtab
    else
        outputDebugString("ERROR IN GETSTRINGCOMPONENTS: No STRING")
        return false
    end
end

function getMessageGovComponents(theString)
    if (theString) then
        local stringtab = {}
        local counter = 0
        local countera = 0
        local countlast
        local zahler = 1
        while countera == 0 do

            countlast = counter
            counter = string.find(theString, "|||", countlast)
            if (counter) then
                stringtab[zahler] = string.sub(theString, countlast, counter - 1)
                --- outputChatBox(stringtab[zahler])
                counter = counter + 3
            else
                stringtab[zahler] = string.sub(theString, countlast)
                --outputChatBox(stringtab[zahler])
                countera = 22
            end
            zahler = zahler + 1
        end
        return stringtab
    else
        outputDebugString("ERROR IN GETSTRINGCOMPONENTS: No STRING")
        return false
    end
end

function arrest_func(theMaker, theCommand, thePlayerName, Money, Time, Kaution)
    if (isBeamter(theMaker)) then
        local thePlayer = getPlayerFromIncompleteName(thePlayerName)
        if thePlayer then
            local mx, my, mz = getElementPosition(theMaker)
            local Px, Py, Pz = getElementPosition(thePlayer)
            local distance = getDistanceBetweenPoints3D(mx, my, mz, Px, Py, Pz)
            local distokn = getDistanceBetweenPoints3D(mx, my, mz, 215.61360168457, 110.61786651611, 998.66485595703)

            local distanceb = getDistanceBetweenPoints3D(mx, my, mz, Px, Py, Pz)
            local distoknb = getDistanceBetweenPoints3D(mx, my, mz, 198.0234375, 161.9658203125, 1003.0299682617)

            if (distance < 10) and (distokn < 20) then
                if (Money) and (Time) and (Kaution) then
                    if (vioGetElementData(thePlayer, "wanteds") > 0) then
                        if (tonumber(Money) > 0 and tonumber(Money) < 100000 and tonumber(Kaution) < 100000) then
                            vioSetElementData(thePlayer, "wanteds", 0)
                            setPlayerWantedLevel(thePlayer, 0)
                            vioSetElementData(thePlayer, "kaution", tonumber(Kaution))
                            vioSetElementData(thePlayer, "knastzeit", tonumber(Time))
                            vioSetElementData(thePlayer, "lastknastzeit", tonumber(Time))
                            setElementModel(thePlayer, 62)
                            changePlayerMoney(thePlayer, -tonumber(Money), "sonstiges", "Knast")
                            if (Kaution == 0) then Kaution = "keine" end
                            outputChatBox(string.format("Du sitzt %s Minuten im Knast. Kaution: %s", Time, Kaution), thePlayer)
                            outputChatBoxForPolice(string.format("%s hat %s eingesperrt!", getPlayerName(theMaker), getPlayerName(thePlayer)))
                            if (vioGetElementData(thePlayer, "mussAlka") == 1) then
                                outputChatBoxForPolice(string.format("%s muss nun ins Alka überführt werden (Administrativer Auftrag)!", getPlayerName(thePlayer)))
                                outputChatBoxForPolice(string.format("%s muss nun ins Alka überführt werden (Administrativer Auftrag)!", getPlayerName(thePlayer)))
                                outputChatBoxForPolice(string.format("%s muss nun ins Alka überführt werden (Administrativer Auftrag)!", getPlayerName(thePlayer)), 255, 0, 0)
                                outputChatBoxForPolice(string.format("%s muss nun ins Alka überführt werden (Administrativer Auftrag)!", getPlayerName(thePlayer)), 255, 0, 0)
                            end
                            vioSetElementData(thePlayer, "alkaknast", 0)
                            local rnd = math.floor(math.random(1, 4))
                            if rnd == 1 then
                                setElementPosition(thePlayer, 215.61360168457, 110.61786651611, 998.66485595703)
                            elseif rnd == 2 then
                                setElementPosition(thePlayer, 219.60717773438, 110.39416503906, 998.66485595703)
                            elseif rnd == 3 then
                                setElementPosition(thePlayer, 223.60034179688, 110.17053222656, 998.66485595703)
                            else
                                setElementPosition(thePlayer, 227.34938049316, 110.19967651367, 998.66485595703)
                            end
                        else
                            showError(theMaker, "Sie Überschreiten zulässige Eingabegrößen!!")
                        end
                    else
                        showError(theMaker, "Dieser Spieler hat keine Wanteds!")
                    end
                else
                    showError(theMaker, "Usage: /arrest Name Preis Time Kaution!")
                end
            elseif (distanceb < 20) and (distoknb < 30) then
                if (Money) and (Time) and (Kaution) then
                    if (vioGetElementData(thePlayer, "wanteds") > 0) then
                        if (tonumber(Money) > 0 and tonumber(Money) < 100000 and tonumber(Kaution) < 100000) then
                            vioSetElementData(thePlayer, "wanteds", 0)
                            setPlayerWantedLevel(thePlayer, 0)
                            vioSetElementData(thePlayer, "kaution", tonumber(Kaution))
                            vioSetElementData(thePlayer, "knastzeit", tonumber(Time))
                            vioSetElementData(thePlayer, "lastknastzeit", tonumber(Time))
                            setElementModel(thePlayer, 62)
                            changePlayerMoney(thePlayer, -tonumber(Money), "sonstiges", "Knast")
                            if (Kaution == 0) then Kaution = "keine" end
                            outputChatBox(string.format("Du sitzt %s Minuten im Knast. Kaution: %s", Time, Kaution), thePlayer)
                            outputChatBoxForPolice(string.format("%s hat %s eingesperrt!", getPlayerName(theMaker), getPlayerName(thePlayer)))
                            if (vioGetElementData(thePlayer, "mussAlka") == 1) then
                                outputChatBoxForPolice(string.format("%s muss nun ins Alka überführt werden (Administrativer Auftrag)!", getPlayerName(thePlayer)))
                                outputChatBoxForPolice(string.format("%s muss nun ins Alka überführt werden (Administrativer Auftrag)!", getPlayerName(thePlayer)), 255, 0, 0)
                            end
                            vioSetElementData(thePlayer, "alkaknast", 2)
                            local rnd = math.floor(math.random(1, 3))
                            if rnd == 1 then
                                setElementPosition(thePlayer, 198.0234375, 161.9658203125, 1003.0299682617)
                            elseif rnd == 2 then
                                setElementPosition(thePlayer, 197.8955078125, 175.126953125, 1003.023437)
                            else
                                setElementPosition(thePlayer, 193.51953125, 174.9072265625, 1003.0234375)
                            end
                        else
                            showError(theMaker, "Sie Überschreiten zulässige Eingabegrößen!!")
                        end
                    else
                        showError(theMaker, "Dieser Spieler hat keine Wanteds!")
                    end
                else
                    showError(theMaker, "Usage: /arrest Name Preis Time Kaution!")
                end
            else
                showError(theMaker, "Du bist nicht beim Knast oder Der Spieler ist nicht in deiner Nähe!")
            end
        else
            showError(theMaker, "Dieser Spieler Existiert nicht!")
        end
    end
end

addCommandHandler("arrest", arrest_func, false, false)
--
function m_func(thePlayer, Command, ...)
    local reason = table.concat({ ... }, " ")
    if (reason) then
        if (isPedInVehicle(thePlayer)) then
            if (isBeamter(thePlayer)) then
                local vehid = getPedOccupiedVehicle(thePlayer)
                if isPoliceCar(vehid) then

                    local posX, posY, posZ = getElementPosition(thePlayer)
                    local chatSphere = createColSphere(posX, posY, posZ, 100)
                    local nearbyPlayers = getElementsWithinColShape(chatSphere, "player")
                    destroyElement(chatSphere)
                    for index, nearbyPlayer in ipairs(nearbyPlayers) do
                        outputChatBox(string.format("[[Megafon von %s: %s]]", getPlayerName(thePlayer), reason), nearbyPlayer, 255, 255, 0)
                    end
                end
            end
        end
    end
end

addCommandHandler("m", m_func, false, false)

function tazer_func(thePlayer)
    if (not (isPedDead(thePlayer))) then
        if (isBeamter(thePlayer)) then
            if not (isPedInVehicle(thePlayer)) then
                local posX, posY, posZ = getElementPosition(thePlayer)
                local tazerSphere = createColSphere(posX, posY, posZ, 5)
                local nearbyPlayers = getElementsWithinColShape(tazerSphere, "player")
                destroyElement(tazerSphere)
                local nearestdis = 10000.123
                local nearestplayer = thePlayer
                for theKey, theNP in ipairs(nearbyPlayers) do
                    if (getElementType(theNP) == "player") then
                        if not (theNP == thePlayer) then
                            local nx, ny, nz = getElementPosition(theNP)
                            local dis = getDistanceBetweenPoints3D(posX, posY, posZ, nx, ny, nz)
                            if (dis < nearestdis) and not (isPedInVehicle(theNP)) and not (isPedDead(theNP)) then
                                nearestplayer = theNP
                                nearestdis = dis
                            end
                        end
                    end
                end
                if (nearestplayer == thePlayer) then nearestplayer = false end
                if (nearestplayer) then
                    if (vioGetElementData(thePlayer, "Tazer") == 0) then
                        local posX, posY, posZ = getElementPosition(nearestplayer)
                        local chatSphere = createColSphere(posX, posY, posZ, 10)
                        local nearbyPlayers = getElementsWithinColShape(chatSphere, "player")
                        destroyElement(chatSphere)
                        for index, nearbyPlayer in ipairs(nearbyPlayers) do
                            outputChatBox(string.format("%s hat %s getazert!", getPlayerName(thePlayer), getPlayerName(nearestplayer)), nearbyPlayer, 100, 0, 200)
                        end
                        toggleAllControls(nearestplayer, false, true, false)
                        setPedAnimation(nearestplayer, "crack", "crckdeth2", -1, true, true, true)
                        setTimer(unfreeze_tazer, 14000, 1, nearestplayer, thePlayer)
                        vioSetElementData(thePlayer, "Tazer", 1)
                    else
                        showError(thePlayer, "Du kannst den Tazer nur alle 7 Sekunden nutzen!")
                    end
                end
            else
                showError(thePlayer, "Du darfst nicht in einen Fahrzeug sein!")
            end
        end
    end
end

addCommandHandler("tazer", tazer_func, false, false)

function unfreeze_tazer(thePlayer, police)
    if (isElement(thePlayer)) then
        if (getPlayerName(thePlayer)) then
            setPedAnimation(thePlayer)
            toggleAllControls(thePlayer, true, true, true)
            vioSetElementData(police, "Tazer", 0)
            toggleControl(thePlayer, "walk", false)
            toggleControl(thePlayer, "sprint", false)
            setControlState(thePlayer, "walk", true)
            setTimer(unfreeze_tazer_toggle, 14000, 1, thePlayer)
        end
    end
    if (isElement(police)) then
        vioSetElementData(police, "Tazer", 0)
    end
end

function unfreeze_tazer_toggle(thePlayer)
    if (isElement(thePlayer)) then
        setControlState(thePlayer, "walk", false)
        toggleControl(thePlayer, "walk", true)
        toggleControl(thePlayer, "sprint", true)
    end
end

function grab_func(theMaker, Command, PlayerName)
    if (isBeamter(theMaker)) then
        if (isPedInVehicle(theMaker)) then
            local thePlayer = getPlayerFromIncompleteName(PlayerName)
            if (thePlayer) then
                local x, y, z = getElementPosition(getPedOccupiedVehicle(theMaker))
                local px, py, pz = getElementPosition(thePlayer)
                local dis = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
                if (dis < 3) then
                    local vehid = getPedOccupiedVehicle(theMaker)
                    local maxseat = getVehicleMaxPassengers(vehid)

                    if isPoliceCar(vehid) then
                        local hasaseat = 0
                        for seat = 1, maxseat, 1 do
                            local passenger = getVehicleOccupant(vehid, seat)
                            if (passenger == false) then
                                hasaseat = seat
                            end
                        end
                        if (hasaseat == 0) then
                            showError(theMaker, "Im Fahrzeug ist kein Platz frei!")
                        else
                            warpPedIntoVehicle(thePlayer, vehid, hasaseat)
                            toggleAllControls(thePlayer, false, true, false)
                            setElementFrozen(thePlayer, true)
                            vioSetElementData(thePlayer, "cuffed", 1)
                            showError(thePlayer, "Du wurdest Verhaftet und in das Polizeifahrzeug gezerrt!")
                        end
                    else
                        showError(theMaker, "Das Fahrzeug ist kein Polizeidienstfahrzeug!")
                    end
                else
                    showError(theMaker, "Der Spieler ist nicht in der Nähe!")
                end
            else
                showError(theMaker, "Der Spieler existiert nicht!")
            end
        end
    end
end

addCommandHandler("grab", grab_func, false, false)

function cuff_func(theMaker, Command, thePlayerName)
    if (isBeamter(theMaker)) or (vioGetElementData(theMaker, "fraktion") == 2) or (vioGetElementData(theMaker, "fraktion") == 8) or (vioGetElementData(theMaker, "fraktion") == 13) or (vioGetElementData(theMaker, "fraktion") == 6) or (vioGetElementData(theMaker, "fraktion") == 11) or (vioGetElementData(theMaker, "fraktion") == 12) then
        local thePlayer = getPlayerFromIncompleteName(thePlayerName)
        if (thePlayer) then
            if not (thePlayer == theMaker) and not (vioGetElementData(theMaker, "cuffed") == 1) then
                if (isPedInVehicle(thePlayer) and isPedInVehicle(theMaker)) then
                    if (getPedOccupiedVehicle(thePlayer) == getPedOccupiedVehicle(theMaker)) then
                        if (vioGetElementData(thePlayer, "cuffed") == 1) then
                            vioSetElementData(thePlayer, "cuffed", 0)
                            toggleAllControls(thePlayer, true)
                            toggleControl(thePlayer, "enter_passenger", true)
                            setElementFrozen(thePlayer, false)
                            showError(theMaker, "Du hast den Spieler entfesselt!")
                            showError(thePlayer, "Du wurdest entfesselt!")
                        else
                            if (getPedOccupiedVehicleSeat(thePlayer) ~= 0) then
                                vioSetElementData(thePlayer, "cuffed", 1)
                                toggleAllControls(thePlayer, false, true, false)
                                toggleControl(thePlayer, "enter_passenger", false)
                                setElementFrozen(thePlayer, true)
                                showError(theMaker, "Du hast den Spieler gefesselt!")
                                showError(thePlayer, "Du wurdest gefesselt!")
                            end
                        end
                    else
                        showError(theMaker, "Ihr sitzt nicht im selben Fahrzeug!")
                    end
                else
                    showError(theMaker, "Einer von euch ist nicht in einen Fahrzeug! Daher wurden alle Fesseln unschaedlich gemacht!")
                end
            else
                showError(theMaker, "Du kannst dich nicht selbst fesseln oder entfesseln! bzw. Du bist gefesselt und kannst dich nicht bewegen!")
            end
        else
            showError(theMaker, "Der Spieler existiert nicht!")
        end
    end
end

addCommandHandler("tie", cuff_func, false, false)
addCommandHandler("cuff", cuff_func, false, false)

function donotexistoutofcar(exitingPlayer)
    if (vioGetElementData(exitingPlayer, "cuffed") == 1) then
        cancelEvent()
    end
end

addEventHandler("onVehicleStartExit", getRootElement(), donotexistoutofcar)

local logoutTable = {}
function onPlayerSaveLogoutTime()
    local nickname = string.lower(getPlayerName(source))
    local timer = getRealTime()
    local timestamp = timer.timestamp
    logoutTable[nickname] = { timestamp, vioGetElementData(source, "wanteds") }
end

addEventHandler("onPlayerQuit", getRootElement(), onPlayerSaveLogoutTime)

function su_func(theMaker, Command, anzahl, thePlayerName, ...)
    if (not thePlayerName) then return 0 end

    local reason = table.concat({ ... }, " ")
    if not (tonumber(anzahl)) then
        reason = thePlayerName .. reason
        thePlayerName = anzahl
        anzahl = 1
    else
        anzahl = tonumber(anzahl)
    end
    if (anzahl < 1) then
        anzahl = 1
    end

    if (isBeamter(theMaker)) then
        if (thePlayerName) then
            local thePlayer = getPlayerFromIncompleteName(thePlayerName)
            if (thePlayer) then
                if (reason) then
                    if (vioGetElementData(thePlayer, "wanteds") <= 6) then
                        vioSetElementData(thePlayer, "wanteds", vioGetElementData(thePlayer, "wanteds") + anzahl)
                        if (vioGetElementData(thePlayer, "wanteds") > 6) then
                            vioSetElementData(thePlayer, "wanteds", 6)
                        end
                        setPlayerWantedLevel(thePlayer, vioGetElementData(thePlayer, "wanteds"))
                        outputChatBox(string.format("Du hast %s Wanted von %s erhalten! Grund: %s", anzahl, getPlayerName(theMaker), reason), thePlayer, 0, 0, 255)
                        outputChatBox(string.format("Du hast jetzt %s Wanteds", vioGetElementData(thePlayer, "wanteds")), thePlayer, 0, 0, 255)

                        outputChatBoxForPolice(string.format("%s hat %s Wanted erhalten! Grund: %s", getPlayerName(thePlayer), anzahl, reason), 0, 0, 255)
                        outputChatBoxForPolice(string.format("Er hat %s Wanteds! Reporter: %s", vioGetElementData(thePlayer, "wanteds"), getPlayerName(theMaker)), 0, 0, 255)
                    else
                        showError(theMaker, "Dieser Spieler hat bereits 6 oder mehr Wanteds!")
                    end
                else
                    showError(theMaker, "Du hast keinen Grund angegeben!")
                end
            else

                if (logoutTable[string.lower(thePlayerName)]) then
                    local timer = getRealTime()
                    local timestamp = timer.timestamp
                    if ((timestamp - 300) < logoutTable[string.lower(thePlayerName)][1]) then
                        if (reason) then
                            local wanteds = tonumber(anzahl)
                            local wantedsold = MySql.helper.getValueSync("user_data", "Wanteds", { Nickname = thePlayerName });

                            if (logoutTable[string.lower(thePlayerName)][2]) then
                                wanteds = wanteds + logoutTable[string.lower(thePlayerName)][2]
                                wantedsold = logoutTable[string.lower(thePlayerName)][2]
                            else
                                wanteds = wantedsold + wanteds
                            end
                            if (wantedsold <= 6) then
                                if (wanteds > 6) then
                                    wanteds = 6
                                end

                                MySql.helper.update("user_data", { Wanteds = wanteds }, { Nickname = thePlayerName });
                                logoutTable[string.lower(thePlayerName)][2] = wanteds
                                outputChatBoxForPolice(string.format("%s hat %s Wanted erhalten! Grund: %s", thePlayerName, anzahl, reason), 0, 0, 255)
                                outputChatBoxForPolice(string.format("Er hat %s Wanteds! Reporter: %s", wanteds, getPlayerName(theMaker)), 0, 0, 255)
                                save_offline_message(thePlayerName, "Polizeicomputer", string.format("Du hast %s Wanted von %s erhalten! Grund: %s", anzahl, getPlayerName(theMaker), reason))

                            else
                                showError(theMaker, "Dieser Spieler hat bereits 6 oder mehr Wanteds!")
                            end
                        else
                            showError(theMaker, "Du hast keinen Grund angegeben!")
                        end
                    else
                        showError(theMaker, "Der Spieler existiert nicht\n oder ist mehr als 5 Minuten Offline!")
                    end
                else
                    showError(theMaker, "Der Spieler existiert nicht\n oder ist mehr als 5 Minuten Offline!")
                end
            end
        end
    end
end

addCommandHandler("su", su_func, false, false)

function delstvo_func(theMaker, Command, anzahl, thePlayerName, ...)

    local reason = "" .. table.concat({ ... }, " ")
    if not (tonumber(anzahl)) then
        reason = thePlayerName .. reason
        thePlayerName = anzahl
        anzahl = 1
    else
        anzahl = tonumber(anzahl)
    end
    local reason = table.concat({ ... }, " ")
    if (isBeamter(theMaker)) then
        if (thePlayerName) then
            local thePlayer = getPlayerFromIncompleteName(thePlayerName)
            if (thePlayer) then
                if (reason) then
                    vioSetElementData(thePlayer, "stvo", vioGetElementData(thePlayer, "stvo") - anzahl)
                    outputChatBox(string.format("Du hast %s StVO-Punkt(e) von %s gelöscht bekommen! Grund: %s", anzahl, getPlayerName(theMaker), reason), thePlayer, 255, 255, 0)
                    outputChatBox(string.format("Du hast jetzt %s StVO-Punkte", vioGetElementData(thePlayer, "stvo")), thePlayer, 255, 255, 0)

                    for theKey, player in ipairs(getElementsByType("player")) do
                        if (isBeamter(player)) then
                            outputChatBox(string.format("%s hat %s StVO-Punkte gelöscht bekommen! Grund: %s", getPlayerName(thePlayer), anzahl, reason), player, 255, 255, 0)
                            outputChatBox(string.format("Er hat %s StVO-Punkte! Reporter: %s", vioGetElementData(thePlayer, "stvo"), getPlayerName(theMaker)), player, 255, 255, 0)
                        end
                    end

                    MySql.helper.insert("log_delstvo", {
                        Wer = getPlayerName(theMaker),
                        Wieviele = anzahl,
                        Von = getPlayerName(thePlayer),
                        Grund = reason
                    });
                end
            end
        end
    end
end
addCommandHandler("delstvo", delstvo_func, false, false)

function stvo_func(theMaker, Command, anzahl, thePlayerName, ...)
    if (anzahl) and (thePlayerName) then
        local reason = table.concat({ ... }, " ")
        if not (tonumber(anzahl)) then
            reason = thePlayerName .. reason
            thePlayerName = anzahl
            anzahl = 1
        else
            anzahl = tonumber(anzahl)
        end

        local reason = table.concat({ ... }, " ")
        if (isBeamter(theMaker)) then
            if (thePlayerName) then
                local thePlayer = getPlayerFromIncompleteName(thePlayerName)
                if (thePlayer) then
                    if (reason) then
                        vioSetElementData(thePlayer, "stvo", vioGetElementData(thePlayer, "stvo") + anzahl)
                        outputChatBox(string.format("Du hast %s StVO-Punkt von %s erhalten! Grund: %s", anzahl, getPlayerName(theMaker), reason), thePlayer, 0, 0, 255)
                        outputChatBox(string.format("Du hast jetzt %s StVO-Punkte", vioGetElementData(thePlayer, "stvo")), thePlayer, 0, 0, 255)
                        if (vioGetElementData(thePlayer, "stvo") >= 20) then
                            vioSetElementData(thePlayer, "autoLic", -5)
                            vioSetElementData(thePlayer, "bikeLic", -5)
                            vioSetElementData(thePlayer, "truckLic", -5)
                            outputChatBox("Du hast somit gerade deinen Fuehrerschein verloren", thePlayer, 0, 0, 255)
                            vioSetElementData(thePlayer, "stvo", 0)
                        end

                        outputChatBoxForPolice(string.format("%s hat %s StVO-Punkte erhalten! Grund: %s", getPlayerName(thePlayer), anzahl, reason))
                        if (vioGetElementData(thePlayer, "stvo") > 0) then
                            outputChatBoxForPolice(string.format("Er hat %s StVO-Punkte! Reporter: %s", vioGetElementData(thePlayer, "stvo"), getPlayerName(theMaker)))

                        else
                            outputChatBoxForPolice(string.format("Er hat somit gerade seinen Fuehrerschein verloren!  Reporter: %s", getPlayerName(theMaker)))
                        end

                        vioSetElementData(thePlayer, "stvoFreePayDays", 0)
                    else
                        showError(theMaker, "Du hast keinen Grund angegeben!")
                    end
                else
                    showError(theMaker, "Der Spieler existiert nicht!")
                end
            end
        end
    end
end
addCommandHandler("stvo", stvo_func, false, false)

function wanteds_func(thePlayer)

    if (isBeamter(thePlayer)) then
        local count = 0
        outputChatBox("Wantedliste:", thePlayer, 255, 255, 0)
        local wastring = ""
        for theKey, player in ipairs(getElementsByType("player")) do
            if (isPlayerLoggedIn(player)) then
                if (vioGetElementData(player, "wanteds") > 0) then
                    if (vioGetElementData(player, "mussAlka") == 1) then
                        wastring = string.format("%s %s: %s (muss Alka);", wastring, getPlayerName(player), vioGetElementData(player, "wanteds"))
                    else
                        wastring = string.format("%s %s: %s;", wastring, getPlayerName(player), vioGetElementData(player, "wanteds"))
                    end
                    count = count + 1
                    if (count == 4) then
                        count = 0
                        outputChatBox(wastring, thePlayer, 255, 255, 0)
                        wastring = ""
                    end
                end
            end
        end
        if (count > 0) then
            outputChatBox(wastring, thePlayer, 255, 255, 0)
        end
    end
end
addCommandHandler("wanteds", wanteds_func, false, false)

function clear_func(theMaker, Command, thePlayerName, ...)
    if (isBeamter(theMaker)) then
        local reason = table.concat({ ... }, " ")
        if (reason) then
            local thePlayer = getPlayerFromIncompleteName(thePlayerName)
            if (thePlayer) then
                vioSetElementData(thePlayer, "wanteds", 0)
                setPlayerWantedLevel(thePlayer, 0)
                outputChatBox(string.format("Deine Akte wurde von %s geloescht!", getPlayerName(theMaker)), thePlayer, 255, 255, 0)
                for theKey, player in ipairs(getElementsByType("player")) do
                    if (isBeamter(player)) then
                        outputChatBox(string.format("%s hat %s's Akte geloescht! Grund: %s", getPlayerName(theMaker), getPlayerName(thePlayer), reason), player, 255, 255, 0)
                    end
                end


            else
                showError(theMaker, "Der Spieler existiert nicht!")
            end
        else
            showError(theMaker, "Du hast keinen Grund angegeben!")
        end
    end
end
addCommandHandler("clear", clear_func, false, false)

function ticket_func(theMaker, Command, thePlayerName, thePrice, ...)
    if (isBeamter(theMaker)) then
        local reason = table.concat({ ... }, " ")
        if (thePlayerName) and (thePrice) then
            if (tonumber(thePrice)) then
                if not (reason == "") and tonumber(thePrice) > 0 and tonumber(thePrice) < 20000 and getPlayerFromIncompleteName(thePlayerName) then
                    local thePlayer = getPlayerFromIncompleteName(thePlayerName)
                    local xv, yv, zv = getElementPosition(theMaker)
                    local xt, yt, zt = getElementPosition(thePlayer)
                    local dis = getDistanceBetweenPoints3D(xv, yv, zv, xt, yt, zt)
                    if (dis < 10) then
                        outputChatBox(string.format("%s hat dir einen %s Strafzettel gegeben. Grund: %s", getPlayerName(theMaker), toprice(thePrice), reason), thePlayer, 255, 0, 0)
                        outputChatBox("Bezahlen mit /accept ticket", thePlayer, 255, 0, 0)
                        vioSetElementData(thePlayer, "ticket", tonumber(thePrice))
                        vioSetElementData(thePlayer, "ticketgive", theMaker)
                        outputChatBox(string.format("Du hast %s ein %s-Strafzettel gegeben!", getPlayerName(thePlayer), toprice(thePrice)), theMaker, 255, 5, 0)
                    end
                else
                    showError(theMaker, "Einige eingaben sind Fehlerhaft! Usage: /ticket Name Preis Grund")
                end
            end
        end
    end
end
addCommandHandler("ticket", ticket_func, false, false)

function sos_func(thePlayer)
    if (isBeamter(thePlayer)) then
        local red = math.random(0, 255)
        local blue = math.random(0, 255)
        local green = math.random(0, 255)
        outputChatBox("Du hast deine Position an alle Beamte übermittelt.(10s)", thePlayer, red, green, blue)
        local blip = createBlipAttachedTo(thePlayer, 0, 2, red, green, blue, 255, 0, 999999.0, thePlayer)
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[1])) do
            if (vioGetElementData(thePlayers, "Innendienst")) then
                outputChatBox(string.format("%s sendet ein SOS und zeigt allen Beamten im Innendienst seine Position. (10s)", getPlayerName(thePlayer)), thePlayers, red, green, blue)
                setElementVisibleTo(blip, thePlayers, true)
            end
        end
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[7])) do
            if (vioGetElementData(thePlayers, "Innendienst")) then
                outputChatBox(string.format("%s sendet ein SOS und zeigt allen Beamten im Innendienst seine Position. (10s)", getPlayerName(thePlayer)), thePlayers, red, green, blue)
                setElementVisibleTo(blip, thePlayers, true)
            end
        end
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[5])) do
            if (vioGetElementData(thePlayers, "Innendienst")) then
                outputChatBox(string.format("%s sendet ein SOS und zeigt allen Beamten im Innendienst seine Position. (10s)", getPlayerName(thePlayer)), thePlayers, red, green, blue)
                setElementVisibleTo(blip, thePlayers, true)
            end
        end
        for theKey, thePlayers in ipairs(getPlayersInTeam(team[9])) do
            if (vioGetElementData(thePlayers, "Innendienst")) then
                outputChatBox(string.format("%s sendet ein SOS und zeigt allen Beamten im Innendienst seine Position. (10s)", getPlayerName(thePlayer)), thePlayers, red, green, blue)
                setElementVisibleTo(blip, thePlayers, true)
            end
        end
        setTimer(destroyElement, 10000, 1, blip)
    end
end
addCommandHandler("sos", sos_func, false, false)
