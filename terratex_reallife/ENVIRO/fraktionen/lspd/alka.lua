local Alka_recSetShape = createColRectangle(3340.9333496094, 102.60157775879, 26, 26) --shape vom Setzen ins alka  TEST ON SERVER
local Alka_recHitShape = createRadarArea(3131.5009765625, -195.498046875, 495, 597.4, 255, 0, 0, 150, getRootElement()) --abschuss area

function sendalkacolshape_func(player)
    triggerClientEvent(player, "alka_shape", Alka_recHitShape, Alka_recHitShape)
end

function Alka_SendWarning(hitPlayer)
    if (not (vioGetElementData(hitPlayer, "alkaknast") == 1) and not (isBeamter(hitPlayer)) and getElementInterior(hitPlayer) == 0 and getElementDimension(hitPlayer) == 0) then
        if (getElementInterior(hitPlayer) == 0 and getElementDimension(hitPlayer) == 0) then
            local ja = true
            if (isPedInVehicle(hitPlayer)) then
                if (vioGetElementData(getPedOccupiedVehicle(hitPlayer), "alkaheli") == "ja") then
                    ja = false
                end
            end
            if (ja) then
                outputChatBox("Sie haben ein Sperrgebiet betreten! Sie haben genau 5 Sekunden es zu verlassen!", hitPlayer, 255, 0, 0)
                outputChatBox("Sie werden ohne weitere Warnung abgeschossen!", hitPlayer, 255, 0, 0)
                setTimer(Alka_setsechsWanted, 5000, 1, hitPlayer)
            end
        end
    end
end

addEvent("onColShapeHit_alka", true)
addEventHandler("onColShapeHit_alka", Alka_recHitShape, Alka_SendWarning)

function Alka_setsechsWanted(hitPlayer)
    if (getElementInterior(hitPlayer) == 0 and getElementDimension(hitPlayer) == 0) then
        local x, y, z = getElementPosition(hitPlayer)
        if (isInsideRadarArea(Alka_recHitShape, x, y)) then
            if (CrimeSystem.getCrimePercentage(hitPlayer) < 70) then
                CrimeSystem.addNewCrime(hitPlayer, 904, "System");
            end

            if (isPedInVehicle(hitPlayer)) then
                triggerClientEvent(getRootElement(), "shootAlka", hitPlayer)
            end
        end
    end
end

function setAlka_func(thePlayer, cmd, toPlayerNamePart)
    if (toPlayerNamePart) then
        if (isBeamter(thePlayer)) then
            local toPlayer = getPlayerFromIncompleteName(toPlayerNamePart)
            if (toPlayer) then
                if (vioGetElementData(toPlayer, "oldJailTime") and vioGetElementData(toPlayer, "oldJailTime") > 0) then
                    if (isElementWithinColShape(toPlayer, Alka_recSetShape) and isElementWithinColShape(thePlayer, Alka_recSetShape)) then
                        vioSetElementData(toPlayer, "kaution", 0)
                        vioSetElementData(toPlayer, "knastzeit", vioGetElementData(toPlayer, "oldJailTime") + 60)
                        vioSetElementData(toPlayer, "lastknastzeit", vioGetElementData(toPlayer, "oldJailTime") + 60)
                        vioSetElementData(toPlayer, "alkaknast", 1)
                        outputChatBox("Du wurdest nun in das Alkatraz eingebuchtet!", toPlayer, 255, 0, 0)
                        outputChatBox(string.format("Du hast %s in das Alkataz gebuchtet!", getPlayerName(toPlayer)), thePlayer, 255, 0, 0)

                        local int, x, y, z = CrimeSystem.Jail.getRandomJailSpawnById(1);

                        setElementPosition(toPlayer, x, y, z)
                        setElementInterior(toPlayer, int)
                        setElementModel(toPlayer, 62)
                        vioSetElementData(toPlayer, "mussAlka", 0)
                    else
                        outputChatBox("Einer von beiden ist nicht beim Alkataz", thePlayer, 255, 0, 0)
                    end
                else
                    outputChatBox("Dieser Spieler saß in keinem Knast", thePlayer, 255, 0, 0)
                end
            else
                outputChatBox("Dieser Spieler exisitiert nicht", thePlayer, 255, 0, 0)
            end
        end
    else
        outputChatBox("Nutzung: /setalka Name", thePlayer, 255, 0, 0)
    end
end
addCommandHandler("setAlka", setAlka_func, false, false)

