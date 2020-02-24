createAbschleppTruck = function(x, y, z, rx, ry, rz)
    local abschleppTruck = createVehicle(578, x, y, z, rx, ry, rz)
    setAsAbschleppTruck(abschleppTruck)
    return abschleppTruck
end

setAsAbschleppTruck = function(theTruck)
    if (getElementModel(theTruck) == 578) then
        setElementData(theTruck, "isAbschleppTruck", true)
    end
end

setAbschleppTruckAsPoliceTruck = function(theTruck)
    if(getElementModel(theTruck) == 578 and getElementData(theTruck, "isAbschleppTruck")) then
        setElementData(theTruck, "AbschleppTruck_PoliceTruck", true)
    end
end


addEvent("abschleppTruck_Aufladen", true)
function abschleppTruck_Aufladen(theVehicle, z)
    local abschleppTruck = getPedOccupiedVehicle(source)
    local player = source
    if (isPedInVehicle(source) and getElementData(abschleppTruck, "isAbschleppTruck")) then

        if (table.getSize(getVehicleOccupants(theVehicle)) == 0) then
            local vehicleType = getVehicleType(theVehicle)
            if (getElementType(theVehicle) == "vehicle" and getElementData(theVehicle,"besitzer") and (vehicleType == "Automobile" or vehicleType == "Bike" or vehicleType == "BMX" or vehicleType == "Boat" or vehicleType == "Quad" or vehicleType == "Monster Truck") and (getElementData(abschleppTruck, "AbschleppTruck_PoliceTruck") or getElementData(theVehicle,"besitzer") == getPlayerName(source))) then
                local ax, ay, az = getElementPosition(abschleppTruck)
                local bx, by, bz = getElementPosition(theVehicle)
                local distance = getDistanceBetweenPoints3D(ax, ay, az, bx, by, bz);
                if (distance and distance < 8.0) then
                    setElementData(theVehicle, "abschleppTruckAttached_Loading", true)
                    setElementFrozen(abschleppTruck, true)
                    if (isElementFrozen(theVehicle)) then
                        setElementData(abschleppTruck, "abschleppTruck_AttachedVehicleWasFrozen", true)
                    else
                        setElementData(abschleppTruck, "abschleppTruck_AttachedVehicleWasFrozen", nil)
                    end
                    setElementFrozen(theVehicle, true)
                    setTimer(function()
                        if (isElement(theVehicle) and isElementFrozen(abschleppTruck)) then
                            if (table.getSize(getVehicleOccupants(theVehicle)) == 0) then
                                attachElements(theVehicle, abschleppTruck, 0, -1.5, z/2+0.05)
                                setElementData(abschleppTruck, "abschleppTruck_AttachedVehicle", theVehicle)
                                triggerClientEvent(player, "abschleppTruck_SetClientAttachedVehicle", player, theVehicle)
                                triggerClientEvent(player, "abschleppTruck_SetClientAttachedVehicleCollisionsEnabled", player, theVehicle, false)
                            end
                            setElementFrozen(abschleppTruck, false)
                            setElementFrozen(theVehicle, false)
                            setElementData(theVehicle, "abschleppTruckAttached_Loading", nil)
                        else
                            setElementData(abschleppTruck, "abschleppTruck_AttachedVehicle", nil)
                            triggerClientEvent(player, "abschleppTruck_SetClientAttachedVehicle", player, nil)
                        end
                    end, 10000, 1)
                end
            else
                showError(source, "Dieses Fahrzeug kann nicht aufgeladen werden")
                triggerClientEvent(source, "abschleppTruck_SetClientAttachedVehicle", source, nil)
            end
        else
            showError(source, "In dem aufzuladenen Fahrzeug befindet sich ein Spieler!")
            triggerClientEvent(source, "abschleppTruck_SetClientAttachedVehicle", source, nil)
        end
    end
end
addEventHandler("abschleppTruck_Aufladen", getRootElement(), abschleppTruck_Aufladen)

-- @todo: why first parameter theVehicle then?
addEvent("abschleppTruck_Abladen", true)
function abschleppTruck_Abladen(theVehicle, x, y, z, rx, ry, rz)
    local abschleppTruck = getPedOccupiedVehicle(source)
    if (isPedInVehicle(source) and getElementData(abschleppTruck, "isAbschleppTruck")) then
        local attachedVehicle = getElementData(abschleppTruck, "abschleppTruck_AttachedVehicle")
        if (isElement(attachedVehicle) and ((getElementData(attachedVehicle,"besitzer") and getElementData(attachedVehicle,"besitzer") == getPlayerName(source)) or getElementData(abschleppTruck,"AbschleppTruck_PoliceTruck"))) then
            local tx, ty, tz = getElementPosition(abschleppTruck)
            local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz);
            if (distance and distance < 8.0) then
                detachElements(attachedVehicle, abschleppTruck)
                setElementCollisionsEnabled(attachedVehicle, true)
                setElementPosition(attachedVehicle, x, y, z+1)
                setElementRotation(attachedVehicle, rx, ry, rz)
                setElementFrozen(attachedVehicle, false)
                setElementVelocity(attachedVehicle, 0,0,2/180)
                if (getElementData(abschleppTruck, "abschleppTruck_AttachedVehicleWasFrozen")) then
                    setTimer(function()
                        setElementFrozen(attachedVehicle, true)
                    end, 1000, 1)
                end
                setElementData(abschleppTruck, "abschleppTruck_AttachedVehicle", nil)
                setElementData(abschleppTruck, "abschleppTruck_AttachedVehicleWasFrozen", nil)
                triggerClientEvent(source, "abschleppTruck_SetClientAttachedVehicle", source, nil)
            end
        else
            showError(source, "Dieses Fahrzeug kann nicht abgeladen werden")
            triggerClientEvent(source, "abschleppTruck_SetClientAttachedVehicle", source, attachedVehicle)
        end
    end
end
addEventHandler("abschleppTruck_Abladen", getRootElement(), abschleppTruck_Abladen)

function abschleppTruckEnter(theVehicle, seat)
    if (getElementData(theVehicle, "isAbschleppTruck")) then
        local attached = getElementData(theVehicle, "abschleppTruck_AttachedVehicle")
        if (isElement(attached) and seat == 0) then
            triggerClientEvent(source, "abschleppTruck_SetClientAttachedVehicle", source, attached)
        end
    end
end
addEventHandler("onPlayerVehicleEnter", getRootElement(), abschleppTruckEnter)
