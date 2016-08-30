--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 29.08.2016
-- Time: 17:15
-- To change this template use File | Settings | File Templates.
--

local blitzerMax = 10;
local blitzerArray = {};

function createBlitzerDummysOnStartUp()
    local c = 1;
    for c = 1, blitzerMax, 1 do
        local blitzerElement = createElement("blitzer");
        vioSetElementData(blitzerElement, "object", false);
        vioSetElementData(blitzerElement, "state", false);

        -- not implemented yet
        vioSetElementData(blitzerElement, "destroyed", false);
        vioSetElementData(blitzerElement, "defect", false);

        vioSetElementData(blitzerElement, "executed", false);
        vioSetElementData(blitzerElement, "marker", false);
        vioSetElementData(blitzerElement, "createdBy", false);
        vioSetElementData(blitzerElement, "deletedBy", false);
        vioSetElementData(blitzerElement, "id", c);
        setElementID(blitzerElement, "blitzer-" .. c);
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createBlitzerDummysOnStartUp)

function createBlitzer_func(thePlayer, cmd, blitzerid)
    if (isBeamter(thePlayer) and not (isPedInVehicle(thePlayer))) then
        if (blitzerid) then
            blitzerid = tonumber(blitzerid)
            if (blitzerid) then
                if (blitzerid <= blitzerMax or blitzerid > 0) then
                    local blitzerElement = getElementByID("blitzer-" .. blitzerid);

                    if (vioGetElementData(blitzerElement, "state")) then
                        outputChatBox("Der Blitzer ist zur Zeit in Benutzung! Weitere Infos unter /sblitzer", thePlayer, 255, 0, 0)
                    else

                        local px, py, pz = getElementPosition(thePlayer)
                        local isZuNah = false
                        for theKey, blitzeri in ipairs(getElementsByType("blitzer")) do
                            if (vioGetElementData(blitzeri, "state")) then
                                local blitzerObject = vioGetElementData(blitzeri, "object")
                                local bx, by, bz = getElementPosition(blitzerObject)
                                if (getDistanceBetweenPoints3D(px, py, pz, bx, by, bz) < 50) then
                                    isZuNah = true
                                end
                            end
                        end

                        if (isZuNah) then
                            outputChatBox("Ein anderer Blitzer is bereits in der Nähe aufgebaut! Infos unter /sblitzer", thePlayer, 255, 0, 0)
                        else
                            local rx, ry, rz = getElementRotation(thePlayer, "default")
                            local obj = createObject(1250, px, py, pz - 0.5, 0.0, 0.0, rz - 180.0)
                            setElementPosition(thePlayer, px, py, pz + 0.5)
                            local marker = createMarker(px, py, pz - 0.5, "cylinder", 30, 0, 0, 0, 0, getRootElement())
                            addEventHandler("onMarkerHit", marker, checkClearLineBetweenBlitzerAndPlayer)

                            vioSetElementData(blitzerElement, "state", true);
                            vioSetElementData(blitzerElement, "object", obj);
                            vioSetElementData(blitzerElement, "marker", marker);
                            vioSetElementData(blitzerElement, "createdBy", getPlayerName(thePlayer));
                            vioSetElementData(blitzerElement, "deletedBy", false);

                            vioSetElementData(obj, "blitzerElement", blitzerElement);
                            vioSetElementData(marker, "blitzerElement", blitzerElement);

                            outputChatBoxForPolice(string.format("Der Blitzer %s wurde von %s aufgebaut!", blitzerid, getPlayerName(thePlayer)))
                            outputChatBox("Der Blitzer wurde erfolgreich aufgebaut! Abbauen mit /dblitzer [ID]", thePlayer, 255, 0, 0)
                        end
                    end
                else
                    outputChatBox("Nutzung: /cblitzer [1-" .. blitzerMax .. "]", thePlayer, 255, 0, 0)
                end
            else
                outputChatBox("Nutzung: /cblitzer [1-" .. blitzerMax .. "]", thePlayer, 255, 0, 0)
            end
        end
    end
end
addCommandHandler("cblitzer", createBlitzer_func, false, false)

function dblitzer_func(thePlayer, cmd, blitzerid)
    if (isBeamter(thePlayer)) then
        if (blitzerid) then
            blitzerid = tonumber(blitzerid)
            if (blitzerid) then
                local blitzerElement = getElementByID("blitzer-" .. blitzerid);

                if (vioGetElementData(blitzerElement, "state")) then

                    if (isElement(vioGetElementData(blitzerElement, "object"))) then
                        destroyElement(vioGetElementData(blitzerElement, "object"))
                    end
                    if (isElement(vioGetElementData(blitzerElement, "marker"))) then
                        destroyElement(vioGetElementData(blitzerElement, "marker"))
                    end

                    vioSetElementData(blitzerElement, "state", false);
                    vioSetElementData(blitzerElement, "object", false);
                    vioSetElementData(blitzerElement, "marker", false);
                    vioSetElementData(blitzerElement, "createdBy", false);
                    vioSetElementData(blitzerElement, "deletedBy", getPlayerName(thePlayer));

                    outputChatBox("Der Blitzer wurde erfolgreich abgebaut!", thePlayer, 255, 0, 0)
                    outputChatBoxForPolice(string.format("Der Blitzer %s wurde von %s abgebaut!", blitzerids, getPlayerName(thePlayer)))
                else
                    outputChatBox("Der Blitzer ist zur Zeit nicht in Benutzung! Weitere Infos unter /sblitzer", thePlayer, 255, 0, 0)
                end
            elseif (blitzerid == "all") then
                for theKey, blitzerElement in ipairs(getElementsByType("blitzer")) do
                    if (vioGetElementData(blitzerElement, "state")) then

                        if (isElement(vioGetElementData(blitzerElement, "object"))) then
                            destroyElement(vioGetElementData(blitzerElement, "object"))
                        end
                        if (isElement(vioGetElementData(blitzerElement, "marker"))) then
                            destroyElement(vioGetElementData(blitzerElement, "marker"))
                        end

                        vioSetElementData(blitzerElement, "state", false);
                        vioSetElementData(blitzerElement, "object", false);
                        vioSetElementData(blitzerElement, "marker", false);
                        vioSetElementData(blitzerElement, "createdBy", false);
                        vioSetElementData(blitzerElement, "deletedBy", getPlayerName(thePlayer));
                    end
                end
                outputChatBox("Alle Blitzer wurden erolgreich abgebaut!", thePlayer, 255, 0, 0)
                outputChatBoxForPolice(string.format("Alle Blitzer wurden von %s abgebaut!", getPlayerName(thePlayer)))
            end
        end
    end
end
addCommandHandler("dblitzer", dblitzer_func, false, false)

function sblitzer_func(thePlayer)
    if (isBeamter(thePlayer)) then
        outputChatBox("Blitzer der Beamten:", thePlayer, 255, 0, 0)
        local px, py, pz = getElementPosition(thePlayer)
        for theKey, blitzerElement in ipairs(getElementsByType("blitzer")) do
            if (vioGetElementData(blitzerElement, "state")) then
                local blitzerObject = vioGetElementData(blitzerElement, "object")
                local bx, by, bz = getElementPosition(blitzerObject)
                local dis = getDistanceBetweenPoints3D(px, py, pz, bx, by, bz)

                if (vioGetElementData(thePlayer, "fraktionsrang") >= 5) then
                    outputChatBox(string.format("Nr. %s: Ort: %s Entfernung: %s Aufgebaut von %s",
                        theKey,
                        getZoneName(bx, by, bz),
                        math.round(dis),
                        vioGetElementData(blitzerElement, "createdBy")
                    ), thePlayer, 255, 0, 0)
                else
                    outputChatBox(string.format("Nr. %s: Ort: %s Entfernung: %s", theKey, getZoneName(bx, by, bz), math.round(dis)), thePlayer, 255, 0, 0)
                end
            else
                if (vioGetElementData(blitzerElement, "deletedBy") and vioGetElementData(thePlayer, "fraktionsrang") >= 5) then
                    outputChatBox(string.format("Nr. %s: nicht in Benutzung (Abgebaut von %s)!", getElementID(blitzerElement), vioGetElementData(blitzerElement, "deletedBy")), thePlayer, 255, 0, 0)
                else
                    outputChatBox(string.format("Nr. %s: nicht in Benutzung!", theKey), thePlayer, 255, 0, 0)
                end
            end
        end
    end
end
addCommandHandler("sblitzer", sblitzer_func, false, false)

function checkClearLineBetweenBlitzerAndPlayer(HitElement)
    if (getElementType(HitElement) == "player") then
        if (isPedInVehicle(HitElement)) then
            local blitzerElement = vioGetElementData(source, "blitzerElement");
            if not (vioGetElementData(blitzerElement, "executed")) then
                vioSetElementData(blitzerElement, "executed", true);
                outputChatBox("should be triggered")
                triggerClientEvent(HitElement, "CheckClearLine_Blitzer", blitzerElement)
                setTimer(resetBlitzerChecker, 1000, 1, blitzerElement)
            end
        end
    end
end

function resetBlitzerChecker(blitzerElement)
    vioSetElementData(blitzerElement, "executed", false);
end

---source = blitzerElement
addEvent("blitzme_event", true)
function playerInBlitzer(HitElement)
    outputChatBox("recieved event")
    if (getElementType(HitElement) == "vehicle") then
        if (math.random(1,10) == 10) then return end

        local tx, ty, tz = getElementVelocity(HitElement)
        local speed = 180 * math.sqrt(tx * tx + ty * ty + tz * tz)
        local anzeigespeed = speed
        speed = math.round(speed - (speed / 10), 2)
        if (speed > 110) then

            local driver = getVehicleOccupant(HitElement)

            vioSetElementData(source, "executed", true);
            setTimer(resetBlitzerChecker, 20000, 1, source);

            triggerClientEvent(driver, "setBlitzerEnabled", driver)

            if (vioGetElementData(driver, "inRacing")) then
                outputChatBoxForPolice(string.format("Ein Fahrer eines Fahrzeuges ist zu schnell durch Blitzer %s gefahren. Es handelt sich um ein illegales Straßenrennen.", tostring(id)))
                return false
            end

            local rechspeed = speed - 100
            local stvo = math.round(rechspeed / 20, 0, "ceil")
            local geldstrafe = math.round(math.round(rechspeed / 20, 2) * 55) + 450

            if (((vioGetElementData(HitElement, "frakid") == 0) or (not (vioGetElementData(HitElement, "frakid")))) and not (vioGetElementData(HitElement, "atomveh")) and not (vioGetElementData(HitElement, "muntruck"))) then
                if (speed > 120) then
                    vioSetElementData(driver, "stvo", vioGetElementData(driver, "stvo") + stvo)
                    outputChatBox(string.format("Du wurdest mit %s km/h geblitzt! Du erhälst dafür %s StVO-Punkte vom Blitzersystem", anzeigespeed, stvo), driver, 0, 0, 255)
                    outputChatBox(string.format("Du hast jetzt %s StVO-Punkte", vioGetElementData(driver, "stvo")), driver, 0, 0, 255)
                    if (vioGetElementData(driver, "stvo") >= 20) then
                        vioSetElementData(driver, "autoLic", -5)
                        vioSetElementData(driver, "bikeLic", -5)
                        vioSetElementData(driver, "truckLic", -5)
                        outputChatBox("Du hast somit gerade deinen Fuehrerschein verloren", driver, 0, 0, 255)
                        vioSetElementData(driver, "stvo", 0)
                    end

                    outputChatBox(string.format("Zusätzlich musst du %s Strafe zahlen!", toprice(geldstrafe)), driver, 0, 0, 255)
                    changePlayerMoney(driver, -geldstrafe, "sonstiges", "Blitzer")

                    local id = vioSetElementData(source, "id")
                    outputChatBoxForPolice(string.format("%s hat %s StVO-Punkte erhalten! Grund: Mobiler Blitzer NR %s", getPlayerName(driver), stvo, id))

                    if (vioGetElementData(driver, "stvo") > 0) then
                        outputChatBoxForPolice(string.format("Er hat %s StVO-Punkte!", vioGetElementData(driver, "stvo")))
                    else
                        outputChatBoxForPolice("Er hat somit gerade seinen Fuehrerschein verloren")
                    end

                    vioSetElementData(driver, "stvoFreePayDays", 0)
                else
                    outputChatBox(string.format("Du wurdest mit %s km/h geblitzt!", speed), driver, 0, 0, 255)
                    outputChatBox("Du musst daher 100$ Verwarngeld bezahlen", driver, 0, 0, 255)
                    changePlayerMoney(driver, -100, "sonstiges", "Blitzer")
                end
            end
            outputChatBox("Die maximal zulässige Höchstgeschwindigkeit in der Stadt beträgt 100 km/h", driver, 255, 0, 0)
        end
    end
end
addEventHandler("blitzme_event", getRootElement(), playerInBlitzer)
