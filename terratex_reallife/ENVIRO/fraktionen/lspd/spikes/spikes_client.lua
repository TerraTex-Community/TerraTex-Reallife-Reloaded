local spikes = {}

function requestSpikeTable()
    triggerServerEvent("requestSpikeTable", getLocalPlayer())
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), requestSpikeTable)

addEvent("setSpikeTable", true)
function setSpikeTableRemote(newSpikes)
    spikes = newSpikes
end
addEventHandler("setSpikeTable", getRootElement(), setSpikeTableRemote)

local wheelsAssignment = {
    wheel_lf_dummy = 1,
    wheel_lb_dummy = 2,
    wheel_rf_dummy = 3,
    wheel_rb_dummy = 4,
    wheel_front = 1,
    wheel_rear = 2
}
function checkIfWheelsAreInSpikes()
    for theKey, spike in ipairs(spikes) do
        if (isElementWithinColShape(getLocalPlayer(), spike.bigCol)) then
            for theKey2, vehicle in pairs(getElementsWithinColShape(spike.bigCol, "vehicle")) do
                local changed = false
                local wheelsInSpike = {getVehicleWheelStates(vehicle)}
                for partName in pairs(getVehicleComponents(vehicle)) do
                    if wheelsAssignment[partName] and wheelsInSpike[wheelsAssignment[partName]] == 0 then
                        local x, y, z = getVehicleComponentPosition(vehicle, partName, "world")
                        local isInSpike = pnpoly(spike.poly.x, spike.poly.y, x, y)
                        if (isInSpike and isLineOfSightClear(x, y, z, ox, oy, oz, true, false, false, true, false, false, false, spike.obj)) then
                            wheelsInSpike[wheelsAssignment[partName]] = 1
                            changed = true
                        end
                    end
                end
                if (changed) then
                    setVehicleWheelStates(vehicle, unpack(wheelsInSpike))
                    triggerServerEvent("wheelsInSpike", getLocalPlayer(), vehicle, wheelsInSpike)
                end
            end
        end
    end
end
addEventHandler("onClientRender", getRootElement(), checkIfWheelsAreInSpikes)

function pnpoly(vertx, verty, testx, testy)
    local nvert = table.getn(vertx);
    local minX = vertx[1]
    local maxX = vertx[1]
    local minY = verty[1]
    local maxY = verty[1]
    for i = 2, nvert do
        minX = math.min(vertx[i], minX)
        maxX = math.max(vertx[i], maxX)
        minY = math.min(verty[i], minY)
        maxY = math.max(verty[i], maxY)
    end
    
    if (testx < minX or testx > maxX or testy < minY or testy > maxY) then
        return false
    end
    
    local isInside = false
    local j = nvert - 1
    for i = 1, nvert do
        if (((verty[i] > testy) ~= (verty[j] > testy)) and (testx < (vertx[j] - vertx[i]) * (testy - verty[i]) / (verty[j] - verty[i]) + vertx[i])) then
            isInside = not isInside
        end
        j = i
    end
    return isInside
end

-- Erzeugen
addEvent("createSpike", true)
function createSpike()
    if (not isPedInVehicle(getLocalPlayer())) then
        local spike = createObject(2892, 0, 0, 0)
        local x, y, z    = getElementPosition(getLocalPlayer())
        z = getGroundPosition(x, y, z)
        local rx, ry, rz = getElementRotation(getLocalPlayer())
        rz = (rz + 90) % 360
        local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(spike)
        triggerServerEvent("createSpike", getLocalPlayer(), x, y, z, rz, minX, minY, maxX, maxY)
    else
        showError(getLocalPlayer(), "Du darfst nicht in einem Fahrzeug sein!")
    end
end
addEventHandler("createSpike", getRootElement(), createSpike)
