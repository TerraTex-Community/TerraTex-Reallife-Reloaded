function oncreateChurchIcon()
    local churchicon = createPickup(2546.7568359375, -1243.529296875, 21164.931640625, 3, 1239, 5000)
    setElementInterior(churchicon, 2)
    addEventHandler("onPickupHit", churchicon, onHitChurchIcon)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), oncreateChurchIcon)


function onHitChurchIcon(thePlayer)
    outputChatBox("Heiraten mit /heirat", thePlayer, 255, 0, 0)
end

--triggerServerEvent("startHeiratEvent",getlocalPlayer(),verlobte,Trauzeugin,Trauzeuge)

addEvent("startHeiratEvent", true)
function finishHeirat(source, verlobteName, TrauzeuginName, TrauzeugeName)
    --outputChatBox(getPlayerName(source).." "..verlobteName.." "..TrauzeuginName.." "..TrauzeugeName)

    local verlobte = source
    source = verlobteName
    local Trauzeugin = getPlayerFromIncompleteName(TrauzeuginName)
    local Trauzeuge = getPlayerFromIncompleteName(TrauzeugeName)
    if (verlobte) and (Trauzeugin) and (Trauzeuge) then
        if (vioGetElementData(verlobte, "verheiratet") == 0) and (vioGetElementData(source, "verheiratet") == 0) then
            local vx, vy, vz = getElementPosition(verlobte)
            local tx, ty, tz = getElementPosition(Trauzeugin)
            local tnx, tny, tnz = getElementPosition(Trauzeuge)
            local vdis = getDistanceBetweenPoints3D(vx, vy, vz, 2547.42578125, -1243.5126953125, 21164.9296875)
            local tdis = getDistanceBetweenPoints3D(tx, ty, tz, 2547.42578125, -1243.5126953125, 21164.9296875)
            local tndis = getDistanceBetweenPoints3D(tnx, tny, tnz, 2547.42578125, -1243.5126953125, 21164.9296875)
            if (vdis < 10 and tdis < 10 and tndis < 10) then
                if (getPlayerMoney(source) > 199999.99) then
                    changePlayerMoney(source, -200000, "sonstiges", "Hochzeit")
                    vioSetElementData(source, "verheiratet", vioGetElementData(verlobte, "DBID"))
                    vioSetElementData(verlobte, "verheiratet", vioGetElementData(source, "DBID"))
                    outputChatBox("Die Hochzeitsglocken läuten!")
                    outputChatBox(string.format("%s und %s geben ein süßes Hochzeitspaar ab!", getPlayerName(source), getPlayerName(verlobte)))
                    outputChatBox(string.format("Trauzeugen sind %s und %s.", getPlayerName(Trauzeuge), getPlayerName(Trauzeugin)))
                    local chatSphere = createColSphere(2547.42578125, -1243.5126953125, 21164.9296875, 2000)
                    local nearbyPlayers = getElementsWithinColShape(chatSphere, "player")
                    destroyElement(chatSphere)

                    for index, nearbyPlayer in ipairs(nearbyPlayers) do
                        if (nearbyPlayer == verlobte) then
                            table.remove(nearbyPlayers, index)
                        end
                    end
                    for index, nearbyPlayer in ipairs(nearbyPlayers) do
                        if (nearbyPlayer == source) then
                            table.remove(nearbyPlayers, index)
                        end
                    end

                    local randomPlayer = math.random(1, table.getn(nearbyPlayers))
                    outputChatBox(string.format("%s hat den Brautstraauß gefangen!", getPlayerName(nearbyPlayers[randomPlayer])))
                    giveWeapon(nearbyPlayers[randomPlayer], 14)
                    changePlayerMoney(nearbyPlayers[randomPlayer], 100, "sonstiges", "Blumenstrauß gefangen")
                    outputChatBox("Du hast 100$ im Brautstrauß gefunden!", nearbyPlayers[randomPlayer])
                    triggerClientEvent(source, "closeChurchEvent", source)
                    triggerClientEvent(getRootElement(), "playHeiratSound", source)
                    vioSetElementData(source, "verheiratetMitName", getPlayerName(verlobte))
                    vioSetElementData(verlobte, "verheiratetMitName", getPlayerName(source))
                    local with = vioGetElementData(source, "mariageWith")
                    vioSetElementData(source, "mariageWith", false)
                    vioSetElementData(source, "isMarryMaster", false)
                    vioSetElementData(source, "mariageTrauzeugin", false)
                    vioSetElementData(source, "mariageTrauzeuge", false)
                    vioSetElementData(source, "isAtSayYes", false)
                    vioSetElementData(with, "mariageWith", false)
                    vioSetElementData(with, "isMarryMaster", false)
                    vioSetElementData(with, "mariageTrauzeugin", false)
                    vioSetElementData(with, "mariageTrauzeuge", false)
                    vioSetElementData(with, "isAtSayYes", false)

                else
                    showError(source, "Eine Hochzeit kostet 200.000$!")
                end
            else
                showError(source, "Einer dieser Spieler ist nicht beim Altar!")
            end
        else
            showError(source, "Deine Verlobte/r ist bereits verheiratet!")
        end
    else
        showError(source, "Einer dieser Spieler existiert nicht!")
    end
end

function onChatInChruch(message)
    if (source) then
        if (vioGetElementData(source, "isAtSayYes")) then

            if (string.find(string.lower(message), "ja")) then
                if (vioGetElementData(source, "isMarryMaster")) then
                    local with = vioGetElementData(source, "mariageWith")
                    local chatSphere = createColSphere(2547.42578125, -1243.5126953125, 21164.9296875, 2000)
                    local nearbyPlayers = getElementsWithinColShape(chatSphere, "player")
                    destroyElement(chatSphere)
                    for index, nearbyPlayer in ipairs(nearbyPlayers) do
                        outputChatBox(string.format("Und du %s willst du %s zu deinen angetrauten Ehepartner nehmen?", getPlayerName(with), getPlayerName(source)), nearbyPlayer)
                    end
                    vioSetElementData(source, "isAtSayYes", false)
                    vioSetElementData(with, "isAtSayYes", true)
                else
                    local with = vioGetElementData(source, "mariageWith")
                    vioSetElementData(source, "isAtSayYes", false)
                    --outputChatBox(tostring(vioGetElementData(source,"mariageWith")).." "..tostring(vioGetElementData(with,"mariageTrauzeugin")).." "..tostring(vioGetElementData(with,"mariageTrauzeuge")))
                    finishHeirat(source, vioGetElementData(source, "mariageWith"), vioGetElementData(with, "mariageTrauzeugin"), vioGetElementData(with, "mariageTrauzeuge"))
                end
            elseif (string.find(string.lower(message), "nein")) then
                local with = vioGetElementData(source, "mariageWith")
                vioSetElementData(source, "mariageWith", false)
                vioSetElementData(source, "isMarryMaster", false)
                vioSetElementData(source, "mariageTrauzeugin", false)
                vioSetElementData(source, "mariageTrauzeuge", false)
                vioSetElementData(source, "isAtSayYes", false)
                vioSetElementData(with, "mariageWith", false)
                vioSetElementData(with, "isMarryMaster", false)
                vioSetElementData(with, "mariageTrauzeugin", false)
                vioSetElementData(with, "mariageTrauzeuge", false)
                vioSetElementData(with, "isAtSayYes", false)
            end
        end
    end
end

addEventHandler("onPlayerChat", getRootElement(), onChatInChruch)

function finishHeiratstart(verlobteName, TrauzeuginName, TrauzeugeName)
    local verlobte = getPlayerFromIncompleteName(verlobteName)
    local Trauzeugin = getPlayerFromIncompleteName(TrauzeuginName)
    local Trauzeuge = getPlayerFromIncompleteName(TrauzeugeName)
    if (verlobte) and (Trauzeugin) and (Trauzeuge) then
        if (vioGetElementData(verlobte, "verheiratet") == 0) and (vioGetElementData(source, "verheiratet") == 0) then
            if (verlobte ~= source) and (Trauzeugin ~= source) and (Trauzeuge ~= source) and (Trauzeugin ~= Trauzeuge) and (Trauzeuge ~= verlobte) and (Trauzeugin ~= verlobte) then
                local vx, vy, vz = getElementPosition(source)
                local tx, ty, tz = getElementPosition(source)
                local tnx, tny, tnz = getElementPosition(source)
                local vdis = getDistanceBetweenPoints3D(vx, vy, vz, 2547.42578125, -1243.5126953125, 21164.9296875)
                local tdis = getDistanceBetweenPoints3D(tx, ty, tz, 2547.42578125, -1243.5126953125, 21164.9296875)
                local tndis = getDistanceBetweenPoints3D(tnx, tny, tnz, 2547.42578125, -1243.5126953125, 21164.9296875)
                if (vdis < 10 and tdis < 10 and tndis < 10) then
                    if (getPlayerMoney(source) > 19999.99) then
                        vioSetElementData(source, "mariageWith", verlobte)
                        vioSetElementData(verlobte, "mariageWith", source)
                        vioSetElementData(source, "isMarryMaster", true)
                        vioSetElementData(source, "mariageTrauzeugin", TrauzeuginName)
                        vioSetElementData(source, "mariageTrauzeuge", TrauzeugeName)
                        vioSetElementData(source, "isAtSayYes", true)
                        triggerClientEvent(source, "closeChurchEvent", source)
                        local chatSphere = createColSphere(2547.42578125, -1243.5126953125, 21164.9296875, 2000)
                        local nearbyPlayers = getElementsWithinColShape(chatSphere, "player")
                        destroyElement(chatSphere)

                        for index, nearbyPlayer in ipairs(nearbyPlayers) do
                            outputChatBox(string.format("Möchtest du %s %s zu deinen Angetrauten Ehepartner nehmen?", getPlayerName(source), getPlayerName(verlobte)), nearbyPlayer)
                        end

                    else
                        showError(source, "Eine Hochzeit kostet 200.000$!")
                    end
                else
                    showError(source, "Einer dieser Spieler ist nicht beim Altar!")
                end
            else
                showError(source, "Es müssen verschiedene Personen sein!")
            end
        else
            showError(source, "Deine Verlobte/r ist bereits verheiratet!")
        end
    else
        showError(source, "Einer dieser Spieler existiert nicht!")
    end
end

addEventHandler("startHeiratEvent", getRootElement(), finishHeiratstart)


function scheidung_func(thePlayer)
    if (vioGetElementData(thePlayer, "verheiratet") == 0) then
        outputChatBox("Du bist nicht verheiratet!", thePlayer, 255, 0, 0)
    else
        local missMariage = false
        for theKey, thePlayers in ipairs(getElementsByType("player")) do
            if (vioGetElementData(thePlayers, "DBID") == vioGetElementData(thePlayer, "verheiratet")) then
                missMariage = thePlayers
            end
        end
        if (missMariage) then
            if (getPlayerMoney(thePlayer) < 1000.00) then
                outputChatBox("Du hast nicht genügend Geld dich Scheiden zu lassen (Kosten 10,000.00$)!", thePlayer, 255, 0, 0)
            else
                changePlayerMoney(thePlayer, -1000, "sonstiges", "Scheidung")
                vioSetElementData(thePlayer, "verheiratet", 0)
                vioSetElementData(missMariage, "verheiratet", 0)
                outputChatBox(string.format("%s hat sich von dir Scheiden lassen!", getPlayerName(thePlayer)), missMariage)
                outputChatBox(string.format("%s ist nun nicht mehr dein Ehepartner!", getPlayerName(missMariage)), thePlayer)
            end
        else
            if (getPlayerMoney(thePlayer) < 15000.00) then
                outputChatBox("Du hast nicht genügend Geld dich Scheiden zu lassen (Kosten 15,000.00$)!", thePlayer, 255, 0, 0)
            else
                local Nickname = MySql.helper.getValueSync("user", "Nickname", { ID = vioGetElementData(thePlayer, "verheiratet") });

                if Nickname then
                    MySql.helper.update("user_data", { verheiratet = 0 }, { Nickname = Nickname});
                    save_offline_message(Nickname, getPlayerName(thePlayer), "Tut mir leid, ich habe mich soeben von dir Scheiden lassen!")
                end
                changePlayerMoney(thePlayer, -15000, "sonstiges", "Scheidung")
                vioSetElementData(thePlayer, "verheiratet", 0)
                outputChatBox(string.format("%s ist nun nicht mehr dein Ehepartner!", tostring(Nickname)), thePlayer)
            end
        end
    end
end

addCommandHandler("scheidung", scheidung_func, false, false)








