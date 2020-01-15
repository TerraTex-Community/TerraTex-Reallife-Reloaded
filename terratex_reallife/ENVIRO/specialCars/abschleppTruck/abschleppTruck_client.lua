abschleppTruck_Aufladen_GUI = function(lastclicked)
    local truck = getPedOccupiedVehicle(getLocalPlayer())
    if (isElement(truck) and getElementData(truck, "isAbschleppTruck") and not getElementData(truck, "abschleppTruck_AttachedVehicle")) then
        local driverCounter = 0
        for seat, player in pairs(getVehicleOccupants(lastclicked)) do
            driverCounter = driverCounter + 1
        end
        if (driverCounter == 0) then
            local vehicleType = getVehicleType(lastclicked)
            if (getElementType(lastclicked) == "vehicle" and getElementData(lastclicked, "besitzer") and (vehicleType == "Automobile" or vehicleType == "Bike" or vehicleType == "BMX" or vehicleType == "Boat" or vehicleType == "Quad" or vehicleType == "Monster Truck") and (getElementData(truck, "AbschleppTruck_PoliceTruck") or getElementData(lastclicked, "besitzer") == getPlayerName(getLocalPlayer()))) then
                local speedx, speedy, speedz = getElementVelocity(truck)
                local actualspeed = (speedx ^ 2 + speedy ^ 2 + speedz ^ 2) ^ (0.5)
                local kmh = actualspeed * 180
                if (kmh <= 2.0) then
                    local testVeh = createVehicle(getElementModel(lastclicked), 0, 0, 0)
                    local x0, y0, z0, x1, y1, z1 = getElementBoundingBox(testVeh)
                    destroyElement(testVeh)
                    local laenge = y1 - y0
                    if (laenge <= 7.92) then
                        local z = getElementDistanceFromCentreOfMassToBaseOfModel(lastclicked)
                        setElementData(truck, "abschleppTruck_AttachedVehicle", lastclicked)
                        triggerServerEvent("abschleppTruck_Aufladen", getLocalPlayer(), lastclicked, z)
                        outputChatBox("Das Fahrzeug wird in 10 Sekunden aufgeladen")
                    else
                        showError(getLocalPlayer(), "Das Fahrzeug ist zu lang!")
                    end
                else
                    showError(getLocalPlayer(), "Du bist zu schnell zum Aufladen!")
                end
            else
                showError(getLocalPlayer(), "Dieses Fahrzeug kann nicht aufgeladen werden")
            end
        else
            showError(getLocalPlayer(), "In dem aufzuladenen Fahrzeug befindet sich ein Spieler!")
        end
    end
end

local abschleppTruckPreview = nil
abschleppTruck_Abladen_GUI = function()
    closeFahrzeugGUI_Reset()
    setTimer(function()
        local truck = getPedOccupiedVehicle(getLocalPlayer())
        if (isElement(truck) and getElementData(truck, "isAbschleppTruck")) then
            local attached = getElementData(truck, "abschleppTruck_AttachedVehicle")
            if (isElement(attached)) then
                if ((getElementData(attached, "besitzer") and getElementData(attached, "besitzer") == getPlayerName(getLocalPlayer())) or getElementData(truck, "AbschleppTruck_PoliceTruck")) then
                    local variant1, variant2 = getVehicleVariant(attached)
                    abschleppTruckPreview = createVehicle(getElementModel(attached), 0, 0, 0, 0, 0, 0, getVehiclePlateText(attached), variant1, variant2)
                    setVehiclePaintjob(abschleppTruckPreview, getVehiclePaintjob(attached))
                    setVehicleEngineState(abschleppTruckPreview, getVehicleEngineState(attached))
                    for light = 0, 3, 1 do
                        setVehicleLightState(abschleppTruckPreview, light, getVehicleLightState(attached, light))
                    end
                    setVehiclePaintjob(abschleppTruckPreview, getVehiclePaintjob(attached))
                    local upgrades = getVehicleUpgrades(attached)
                    for upgradeKey, upgradeValue in ipairs(upgrades) do
                        addVehicleUpgrade(abschleppTruckPreview, upgradeValue)
                    end
                    setElementCollisionsEnabled(abschleppTruckPreview, false)
                    setElementAlpha(abschleppTruckPreview, 0)
                    addEventHandler("onClientRender", getRootElement(), abschleppTruck_Abladen_Preview)
                    addEventHandler("onClientClick", getRootElement(), abschleppTruck_Abladen_Click)
                else
                    showError(getLocalPlayer(), "Dieses Fahrzeug kann nicht abgeladen werden")
                    showCursor(false)
                end
            end
        end
        addEventHandler("onClientPlayerVehicleExit", getRootElement(), abschleppTruck_Abladen_EndPreview)
    end, 300, 1);
end

function abschleppTruck_Abladen_Preview()
    local truck = getPedOccupiedVehicle(getLocalPlayer())
    if (isElement(truck) and getElementData(truck, "isAbschleppTruck")) then
        local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
        if (worldx and worldy and worldz) then
            local px, py, pz = getCameraMatrix()
            if (px and py and pz) then
                local hit, x, y, z, elementHit = processLineOfSight(px, py, pz, worldx, worldy, worldz)
                if (x and y and z) then
                    local tx, ty, tz = getElementPosition(truck)
                    local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
                    if (distance and distance < 8.0) then
                        local zd = getElementDistanceFromCentreOfMassToBaseOfModel(abschleppTruckPreview)
                        setElementPosition(abschleppTruckPreview, x, y, z + zd)
                        setVehicleColor(abschleppTruckPreview, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255)
                        local rx, ry, rz = getElementRotation(truck)
                        setElementRotation(abschleppTruckPreview, rx, ry, rz)
                        setElementAlpha(abschleppTruckPreview, 128)
                    else
                        setElementAlpha(abschleppTruckPreview, 0)
                    end
                else
                    abschleppTruck_Abladen_EndPreview()
                end
            else
                abschleppTruck_Abladen_EndPreview()
            end
        else
            abschleppTruck_Abladen_EndPreview()
        end
    end
end

function abschleppTruckLeave(theVehicle, seat)
    if (theVehicle and isElement(theVehicle) and getElementData(theVehicle, "isAbschleppTruck")) then
        local attachedElements = getAttachedElements(theVehicle)
        if (attachedElements) then
            for ElementKey, ElementValue in ipairs(attachedElements) do
                if (getElementType(ElementValue) == "vehicle") then
                    setElementCollisionsEnabled(ElementValue, true)
                end
                break
            end
        end
    end
end
addEventHandler("onClientPlayerVehicleExit", getRootElement(), abschleppTruckLeave)

function abschleppTruckEnter()
    local theVehicle = getPedOccupiedVehicle(source)
    if (getElementData(theVehicle, "isAbschleppTruck")) then
        local attachedElements = getAttachedElements(theVehicle)
        if (attachedElements) then
            for ElementKey, ElementValue in ipairs(attachedElements) do
                if (getElementType(ElementValue) == "vehicle") then
                    setElementCollisionsEnabled(ElementValue, false)
                end
                break
            end
        end
    end
end
addEventHandler("onClientPlayerVehicleEnter", getRootElement(), abschleppTruckEnter)

addEvent("abschleppTruck_SetClientAttachedVehicle", true)
function abschleppTruck_SetClientAttachedVehicle(theVehicle)
    local abschleppTruck = getPedOccupiedVehicle(source)
    if (isPedInVehicle(source) and getElementData(abschleppTruck, "isAbschleppTruck")) then
        setElementData(abschleppTruck, "abschleppTruck_AttachedVehicle", theVehicle)
    end
end
addEventHandler("abschleppTruck_SetClientAttachedVehicle", getRootElement(), abschleppTruck_SetClientAttachedVehicle)

addEvent("abschleppTruck_SetClientAttachedVehicleCollisionsEnabled", true)
function abschleppTruck_SetClientAttachedVehicleCollisionsEnabled(theVehicle, bool)
    setElementCollisionsEnabled(theVehicle, bool)
end
addEventHandler("abschleppTruck_SetClientAttachedVehicleCollisionsEnabled", getRootElement(), abschleppTruck_SetClientAttachedVehicleCollisionsEnabled)

function abschleppTruck_Abladen_EndPreview()
    if (isElement(abschleppTruckPreview)) then
        destroyElement(abschleppTruckPreview)
        abschleppTruckPreview = nil
        removeEventHandler("onClientRender", getRootElement(), abschleppTruck_Abladen_Preview)
        removeEventHandler("onClientClick", getRootElement(), abschleppTruck_Abladen_Click)
        removeEventHandler("onClientPlayerVehicleExit", getRootElement(), abschleppTruck_Abladen_EndPreview)
    end
end

function abschleppTruck_Abladen_Click()
    local truck = getPedOccupiedVehicle(getLocalPlayer())
    if (abschleppTruckPreview) then
        local x, y, z = getElementPosition(abschleppTruckPreview)
        local rx, ry, rz = getElementRotation(abschleppTruckPreview)
        abschleppTruck_Abladen_EndPreview()
        local truck = getPedOccupiedVehicle(getLocalPlayer())
        if (isElement(truck) and getElementData(truck, "isAbschleppTruck") and x and y and z) then
            local attached = getElementData(truck, "abschleppTruck_AttachedVehicle")
            if (isElement(attached)) then
                local speedx, speedy, speedz = getElementVelocity(truck)
                local actualspeed = (speedx ^ 2 + speedy ^ 2 + speedz ^ 2) ^ (0.5)
                local kmh = actualspeed * 180
                if (kmh <= 2.0) then
                    local tx, ty, tz = getElementPosition(truck)
                    local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
                    if (distance and distance < 8.0) then
                        triggerServerEvent("abschleppTruck_Abladen", getLocalPlayer(), attached, x, y, z, rx, ry, rz)
                        setElementData(truck, "abschleppTruck_AttachedVehicle", nil)
                        setElementCollisionsEnabled(attached, true)
                    else
                        abschleppTruck_Abladen_EndPreview()
                    end
                    showCursor(false)
                else
                    showError(getLocalPlayer(), "Du bist zu schnell zum Abladen!")
                end
            end
        end
    end
end

function abschleppTruckAttachedNoEnter(player, seat, jacked)
    local attachedTo = getElementAttachedTo(source)
    if (attachedTo and getElementData(attachedTo, "abschleppTruck_AttachedVehicle") == source and getElementData(attachedTo, "isAbschleppTruck")) then
        cancelEvent()
        showError(player, "Du kannst in das aufgeladene Fahrzeug nicht einsteigen!")
    end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), abschleppTruckAttachedNoEnter)

function abschleppTruckAttachedNoEnter_Loading(player, seat, jacked)
    if (getElementData(source, "abschleppTruckAttached_Loading")) then
        cancelEvent()
        showError(player, "Du kannst in das Fahrzeug nicht einsteigen, da es gerade aufgeladen wird!")
    end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), abschleppTruckAttachedNoEnter_Loading)
