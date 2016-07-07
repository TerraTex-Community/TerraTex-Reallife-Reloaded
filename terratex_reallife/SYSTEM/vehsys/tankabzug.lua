function abzugTankAnzeige()
    for theVehicle, theKey in ipairs(getElementsByType("vehicle")) do
        if (vioGetElementData(theKey, "besitzer")) then
            setNewTankVehicle(theKey)
        elseif (vioGetElementData(theKey, "hasTank")) then
            setNewTankVehicle(theKey)
        end
    end
    for theKey, theVehicle in pairs(frakcars) do
        if (isElement(theVehicle)) then
            setNewTankVehicle(theVehicle)
        end
    end
end

function setNewTankVehicle(theVehicle)
    if (isElement(theVehicle)) then
        if (getElementType(theVehicle) == "vehicle") then
            local damageFactor = 1;
            if (getElementHealth(theVehicle)) then
                if (getElementHealth(theVehicle) < 400) then
                    setVehicleEngineState(theVehicle, false)
                    vioSetElementData(theVehicle, "motor", false)
                    vioSetElementData(theVehicle, "motornum", 0)
                elseif (getElementHealth(theVehicle) < 500) then
                    damageFactor = 3
                elseif (getElementHealth(theVehicle) < 700) then
                    damageFactor = 1.5
                end
            end
            if (getVehicleEngineState(theVehicle)) then

                if not (vioGetElementData(theVehicle, "tank")) then
                    vioSetElementData(theVehicle, "tank", 100)
                end

                if not (vioGetElementData(theVehicle, "kmstand")) then
                    vioSetElementData(theVehicle, "kmstand", 0)
                end

                local ox, oy, oz = getElementPosition(theVehicle)
                if (vioGetElementData(theVehicle, "oldTankX")) then
                    ox = vioGetElementData(theVehicle, "oldTankX")
                    oy = vioGetElementData(theVehicle, "oldTankY")
                    oz = vioGetElementData(theVehicle, "oldTankZ")
                end

                local nx, ny, nz = getElementPosition(theVehicle)
                local entf = getDistanceBetweenPoints3D(ox, oy, oz, nx, ny, nz)
                vioSetElementData(theVehicle, "kmstand", vioGetElementData(theVehicle, "kmstand") + entf / 100)

                if (vioGetElementData(theVehicle, "kmstand") > 100000) then
                    giveVehicleKMPokal(theVehicle)
                end

                local speedx, speedy, speedz = getElementVelocity(theVehicle)
                local durchV = (speedx^2 + speedy^2 + speedz^2)^(0.5)
                local calcV = durchV * 180;

                -- local tankminus = (0.0000283956*calcV*calcV*calcV - 0.0000973513*calcV*calcV + 0.0000783812*calcV)/2000 + 0.002;
                local tankminus = (0.0000010958 * calcV^2 + 0.018518519);

                if (vioGetElementData(theVehicle, "hasTankFactor")) then
                    tankminus = tankminus * vioGetElementData(theVehicle, "hasTankFactor")
                elseif (getVehicleType(theVehicle) == "Plane") then
                    tankminus = tankminus / 3
                elseif (getVehicleType(theVehicle) == "Boat") then
                    tankminus = tankminus * 3
                end

                tankminus = tankminus * damageFactor;

                vioSetElementData(theVehicle, "tank", vioGetElementData(theVehicle, "tank") - tankminus)
                vioSetElementData(theVehicle, "oldTankX", nx)
                vioSetElementData(theVehicle, "oldTankY", ny)
                vioSetElementData(theVehicle, "oldTankZ", nz)
                if (vioGetElementData(theVehicle, "tank") <= 1) then
                    vioSetElementData(theVehicle, "tank", 0)
                    vioSetElementData(theVehicle, "motornum", 0)
                    vioSetElementData(theVehicle, "motor", false)
                    setVehicleEngineState(theVehicle, false)
                end
            end
        end
    end
end


function giveVehicleKMPokal(vehicle)
    local besitzer = vioGetElementData(vehicle, "besitzer")
    if (getPlayerFromName(besitzer)) then
        local source = getPlayerFromName(besitzer)
        if (vioGetElementData(source, "Erfolg_KMPokal") ~= 1) then
            vioSetElementData(source, "Erfolg_KMPokal", 1)
            triggerClientEvent(source, "onClientCreatePokalGUI", source, "Kilometerfresser", "ein Fahrzeug mit 100,000 km auf dem Tacho")
        end
    end
end

function tankcounterabzugTankAnzeige()
    --outputDebugString("TankTimer")
    setTimer(tankcounterabzugTankAnzeige, 1000, 1)
    abzugTankAnzeige()
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), tankcounterabzugTankAnzeige)


