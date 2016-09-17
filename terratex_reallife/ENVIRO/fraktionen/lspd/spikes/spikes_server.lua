local spikes = {}
local spikeLimit = 10

addEvent("requestSpikeTable", true)
function requestSpikeTable()
    sendSpikeTable(source)
end
addEventHandler("requestSpikeTable", getRootElement(), requestSpikeTable)

function sendSpikeTable(player)
    triggerClientEvent(player, "setSpikeTable", player, spikes)
end

addEvent("wheelsInSpike", true)
function wheelsInSpike(vehicle, wheelstates)
    local toSet = {getVehicleWheelStates(vehicle)}
    for theKey, wheelState in ipairs(wheelstates) do
        if (wheelState ~= toSet[theKey] and wheelState == 1) then
            toSet[theKey] = 1
        end
    end
    setVehicleWheelStates(vehicle, unpack(toSet))
end
addEventHandler("wheelsInSpike", getRootElement(), wheelsInSpike)

addEvent("createSpike", true)
function createSpike(x, y, z, rotZ, minX, minY, maxX, maxY)
    if (isBeamter(source)) then
        if (table.getn(spikes) <= spikeLimit) then
            local alpha = rotZ * math.pi / 180
            local c = math.cos(alpha)
            local s = math.sin(alpha)
            minX = minX + x - 0.4
            minY = minY + y - 0.4
            maxX = maxX + x + 0.8
            maxY = maxY + y + 0.8
            local mx = (minX + maxX) / 2
            local my = (minY + maxY) / 2
            local x1 = c * (minX - mx) - s * (minY - my) + mx
            local y1 = c * (minY - my) + s * (minX - mx) + my 
            local x2 = c * (maxX - mx) - s * (minY - my) + mx 
            local y2 = c * (minY - my) + s * (maxX - mx) + my 
            local x3 = c * (minX - mx) - s * (maxY - my) + mx 
            local y3 = c * (maxY - my) + s * (minX - mx) + my 
            local x4 = c * (maxX - mx) - s * (maxY - my) + mx 
            local y4 = c * (maxY - my) + s * (maxX - mx) + my
            
            local _obj = createObject(2892, x, y, z, 0, 0, rotZ)
            setElementCollisionsEnabled(_obj, false)
            local _bigCol = createColSphere(x, y, z, 40)
            local _poly = {x = {x1, x2, x3, x4}, y = {y1, y2, y3, y4}}
            table.insert(spikes, {obj = _obj, bigCol = _bigCol, poly = _poly})
            sendSpikeTable(getRootElement())
            outputChatBox("Das Nagelband wurde erfolgreich ausgelegt", player)
        else
            outputChatBox("Es wurden bereits "..spikeLimit.." Nagelbänder ausgelegt", player)
        end
    end
end
addEventHandler("createSpike", getRootElement(), createSpike)

function letPlayerCreateSpike(player)
    if (isBeamter(player)) then
        triggerClientEvent(player, "createSpike", player)
    end
end
addCommandHandler("cspikes", letPlayerCreateSpike)

function deleteSpikeInRange(player)
    if (isBeamter(player) and table.getn(spikes) > 0) then
        local nearestSpikeKey = 1
        local nearestSpikeDistance = 1000000
        local x1, y1, z1 = getElementPosition(player)
        for theKey, spike in ipairs(spikes) do
            local x2, y2, z2 = getElementPosition(spike.obj)
            local distance = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
            if (distance and distance < nearestSpikeDistance) then
                nearestSpikeDistance = distance
                nearestSpikeKey = theKey
            end
        end
        if (nearestSpikeDistance < 5.0) then
            destroyElement(spikes[nearestSpikeKey].obj)
            table.remove(spikes, nearestSpikeKey)
            sendSpikeTable(getRootElement())
            outputChatBox("Das Nagelband wurde erfolgreich wieder eingepackt", player)
        end
    end
end
addCommandHandler("dspikes", deleteSpikeInRange)

function deleteAllSpike(player)
    if (isBeamter(player) and table.getn(spikes) > 0) then
        for theKey, spike in ipairs(spikes) do
            destroyElement(spike.obj)
        end
        spikes = {}
        sendSpikeTable(getRootElement())
        outputChatBox("Die Nagelbänder wurden erfolgreich abgebaut", player)
    end
end
addCommandHandler("dspikes_all", deleteAllSpike)
