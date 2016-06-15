function startEngine_func(playerSource)
    local theVehicle = getPedOccupiedVehicle(playerSource)
    -- Check if the player is in any vehicle and if he is the driver
    if theVehicle and getVehicleController(theVehicle) == playerSource and not (vioGetElementData(theVehicle, "isInTankProcedur")) and not (vioGetElementData(theVehicle, "isInRepairProcedur")) then
        local state = getVehicleEngineState(theVehicle)
        if ((tostring(getVehicleType(theVehicle)) == "Plane") and getElementID(theVehicle) ~= "539") then -- Wenn das Fahrzeug ein Flugzeug ist und keine Vortex
        if (vioGetElementData(theVehicle, "motor")) then -- Motor ausschalten
        if (StartMotorPlane(playerSource, theVehicle, false)) then
            return false
        end
        else -- Motor einschalten
        if (StartMotorPlane(playerSource, theVehicle, true)) then
            return false
        end
        end
        end
        setVehicleEngineState(theVehicle, not state) -- Vor dem die Flugzeuge abfangen und extra behandeln
        vioSetElementData(theVehicle, "motor", not state)
        if (vioGetElementData(theVehicle, "motor")) then
            vioSetElementData(theVehicle, "motornum", 1)
        else
            vioSetElementData(theVehicle, "motornum", 0)
        end
    end
    if (privCars[theVehicle]) or frakcars[theVehicle] then
        if (vioGetElementData(theVehicle, "tank")) then
            if tonumber(vioGetElementData(theVehicle, "tank")) then
                vioSetElementData(theVehicle, "tank", tonumber(vioGetElementData(theVehicle, "tank")))
                if (vioGetElementData(theVehicle, "tank") <= 0) or (getElementHealth(theVehicle) < 350) then
                    setVehicleEngineState(theVehicle, false)
                    vioSetElementData(theVehicle, "motor", false)
                    vioSetElementData(theVehicle, "motornum", 0)
                end
            end
        end
    end
end

addEvent("shutdownMotor", true)

motorAnTimer = {} -- Timer der Flugzeuge die auf einen Motor start/stop warten
function StartMotorPlane(thePlayer, theVehicle, start)
    if (thePlayer) then -- Wir haben einen Spieler
    if (theVehicle) then -- Wir haben ein Flugzeug
    local state = getVehicleEngineState(theVehicle)
    if (not isVehicleOnGround(theVehicle)) then -- Wenn das Flugzeug NICHT am Boden ist
    local myTimer = motorAnTimer[getPlayerName(thePlayer)]
    if (isTimer(myTimer)) then
        local rest = select(1, getTimerDetails(myTimer))
        if (state) then
            showError(thePlayer, "Die Motoren werden bereits gestopt.\n Das stopen dauert noch ca. " .. (rest / 1000) .. " Sekunden.")
        else
            showError(thePlayer, "Die Motoren werden bereits gestartet.\n Das starten dauert noch ca. " .. (rest / 1000) .. " Sekunden.")
        end
        return true
    else
        local newTimer
        if (state) then
            newTimer = setTimer(StartMotorPlaneTimerElapsed, math.random(1, 10) * 1000, 1, thePlayer, theVehicle, start)
        else
            newTimer = setTimer(StartMotorPlaneTimerElapsed, math.random(5, 10) * 1000, 1, thePlayer, theVehicle, start)
        end
        motorAnTimer[getPlayerName(thePlayer)] = newTimer
        if (state) then
            showError(thePlayer, "Die Motoren werden nun gestopt.\n Das wird ca. " .. (select(1, getTimerDetails(newTimer)) / 1000) .. " Sekunden dauern.")
        else
            showError(thePlayer, "Die Motoren werden nun gestartet.\n Das wird ca. " .. (select(1, getTimerDetails(newTimer)) / 1000) .. " Sekunden dauern.")
        end
        return true
    end
    else
        local myTimer = motorAnTimer[getPlayerName(thePlayer)]
        if (myTimer) then
            if (isTimer(myTimer)) then
                killTimer(motorAnTimer[getPlayerName(thePlayer)])
            end
        end
    end
    else
        outputDebugString("Error: (start_Veh.lua) Kein Flugzeug übergeben")
    end
    else
        outputDebugString("Error: (start_Veh.lua) Kein Spieler übergeben")
    end
    return false
end

function StartMotorPlaneTimerElapsed(thePlayer, theVehicle, start)
    if (isElement(theVehicle) and isElement(thePlayer)) then
        local state = getVehicleEngineState(theVehicle)
        if (isTimer(motorAnTimer[getPlayerName(thePlayer)])) then
            killTimer(motorAnTimer[getPlayerName(thePlayer)])
        end
        if (privCars[theVehicle] or frakcars[theVehicle]) then
            if (vioGetElementData(theVehicle, "tank")) then
                if (tonumber(vioGetElementData(theVehicle, "tank"))) then
                    vioSetElementData(theVehicle, "tank", tonumber(vioGetElementData(theVehicle, "tank")))
                    if (vioGetElementData(theVehicle, "tank") <= 0 or getElementHealth(theVehicle) < 350) then
                        setVehicleEngineState(theVehicle, false)
                        vioSetElementData(theVehicle, "motor", false)
                        vioSetElementData(theVehicle, "motornum", 0)
                        return false
                    end
                end
            end
        end
        setVehicleEngineState(theVehicle, start)
        vioSetElementData(theVehicle, "motor", start)
        if (start) then
            start = 1
        else
            start = 0
        end
        vioSetElementData(theVehicle, "motornum", start)
    end
end

function shutdownMotor_func()
    setVehicleEngineState(source, false)
    vioSetElementData(source, "motor", false)
    vioSetElementData(source, "motornum", 0)
end

addEventHandler("shutdownMotor", getRootElement(), shutdownMotor_func)

function startLight_func(playerSource)
    local theVehicle = getPedOccupiedVehicle(playerSource)
    if theVehicle and getVehicleController(theVehicle) == playerSource then
        -- Check if the player is in any vehicle and if he is the driver
        if (getVehicleOverrideLights(theVehicle) ~= 2) then -- if the current state isnt 'force on'
        switchLight(theVehicle, 2) -- force the li
        else
            switchLight(theVehicle, 1) -- force the lights on
        end
    end
end


function switchLight(theVehicle, state)
    setVehicleOverrideLights(theVehicle, state) -- force the lights on
    vioSetElementData(theVehicle, "lightstate", state)
    if (getVehicleTowedByVehicle(theVehicle)) then
        switchLight(getVehicleTowedByVehicle(theVehicle), state)
    end
end

function motor_light_off()
    if (getVehicleOverrideLights(source) == 0) then -- if the current state isnt 'force on'
    setVehicleOverrideLights(source, 1) -- force the lights on
    end
    if (vioGetElementData(source, "motor") == false) then
        setVehicleEngineState(source, false)
    else
        setVehicleEngineState(source, true)
    end
end

addEventHandler("onVehicleEnter", getRootElement(), motor_light_off)

function setCarBinds()
    unbindKey(source, "x")
    unbindKey(source, "l")
    bindKey(source, "x", "down", startEngine_func, source)
    bindKey(source, "l", "down", startLight_func, source)
end

addEventHandler("onPlayerJoin", getRootElement(), setCarBinds)

function rebind_func(thePlayer)
    source = thePlayer
    unbindKey(source, "x")
    unbindKey(source, "l")
    bindKey(source, "x", "down", startEngine_func, source)
    bindKey(source, "l", "down", startLight_func, source)
end

addCommandHandler("rebind", rebind_func, false, false)

function prepare(thevehicle, frakid)
    vioSetElementData(thevehicle, "frakid", frakid)
    vioSetElementData(thevehicle, "respawn", 1)
    vioSetElementData(thevehicle, "motor", false)
    vioSetElementData(thevehicle, "motornum", 0)
end

function onvehicleexplode_func()
    if not (privCars[source]) then
        if (vioGetElementData(source, "respawn") == 1) then
            if (vioGetElementData(source, "frakid") ~= 0) then
                if (frakkasse[vioGetElementData(source, "frakid")] >= (100 - vioGetElementData(source, "tank")) * serversettings["tankpreis"] * 2) then
                    frakkasse[vioGetElementData(source, "frakid")] = frakkasse[vioGetElementData(source, "frakid")] - (100 - vioGetElementData(source, "tank")) * serversettings["tankpreis"] * 2

                    changeBizKasse(7, (100 - vioGetElementData(source, "tank")) * serversettings["tankpreis"] * 2, "Tankrespawn")
                    if ((100 - vioGetElementData(source, "tank")) * serversettings["tankpreis"] * 2) ~= 0 then
                        frakdepot_log(vioGetElementData(source, "frakid"), 1, -((100 - vioGetElementData(source, "tank")) * serversettings["tankpreis"] * 2), "Frakzeugtank")
                    end
                    vioSetElementData(source, "tank", 100)
                end
            else
                vioSetElementData(source, "tank", 100)
            end
            setTimer(respawnVehicle, 10000, 1, source)
            vioSetElementData(source, "motor", false)
        else
            destroyElement(source)
        end
    end
end

addEventHandler("onVehicleExplode", getRootElement(), onvehicleexplode_func)

function respawntheVehiclebyadmin_func(vehicle)
    if (isAdminLevel(source, 0)) then
        local theVehicle = vehicle
        if not (isAnyOneInVehicle(theVehicle)) then
            setElementPosition(theVehicle, vioGetElementData(theVehicle, "spawnx"), vioGetElementData(theVehicle, "spawny"), vioGetElementData(theVehicle, "spawnz"))
            setElementRotation(theVehicle, vioGetElementData(theVehicle, "spawnrx"), vioGetElementData(theVehicle, "spawnry"), vioGetElementData(theVehicle, "spawnrz"))
            triggerClientEvent(source, "showErrorText", source, source, "Das Fahrzeug wurde erfolgreich respawned!")
        end
    end
end

addEvent("respawnVehicleByAdmin", true)
addEventHandler("respawnVehicleByAdmin", getRootElement(), respawntheVehiclebyadmin_func)

function deletetheVehiclebyadmin_func(vehicle, grund)
    if (isAdminLevel(source, 1)) then
        local id = vioGetElementData(vehicle, "dbid")
        triggerClientEvent(source, "showErrorText", source, source, "Das Fahrzeug wurde erfolgreich geloescht!")
        save_offline_message(vioGetElementData(vehicle, "besitzer"), getPlayerName(source), string.format("Dein Fahrzeug in Slot %s wurde gelöscht, weil: %s", vioGetElementData(vehicle, "slotid"), grund))

        MySql.helper.delete("user_vehicles", {ID = id});
        elementData[vehicle] = nil
        destroyElement(vehicle)
    end
end

addEvent("deleteVehicleByAdmin", true)
addEventHandler("deleteVehicleByAdmin", getRootElement(), deletetheVehiclebyadmin_func)

function killWaterVehicle(timestamp)
    setTimer(checkNewWaterKill, 1000, 1, source, 0)
end

addEventHandler("onVehicleEnterWater", getRootElement(), killWaterVehicle)

function checkNewWaterKill(vehicle, timerCounter)
    if (isElement(vehicle)) then
        if (isElementInWater(vehicle)) then
            if (timerCounter < 10) then
                setTimer(checkNewWaterKill, 1000, 1, vehicle, timerCounter + 1)
            else
                if (isElement(vehicle) and not (isWetterEventID == 2) and not (isWetterEventID == 3)) then
                    if (privCars[vehicle]) then
                        onvehicleexplode_exec(vehicle)
                    else
                        if (isElement(vehicle)) then
                            local passengers = getVehicleOccupants(vehicle)
                            for theKey, thePassenger in pairs(passengers) do
                                killPed(thePassenger, nil, 63, 255, false)
                            end
                        end
                        triggerEvent("onVehicleExplode", vehicle)
                    end
                end
            end
        end
    end
end








