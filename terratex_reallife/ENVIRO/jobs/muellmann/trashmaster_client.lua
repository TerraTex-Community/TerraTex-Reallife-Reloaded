playerJobMarkers = {}
muellmarkers = {}
local trashPoints = 0
deponieMarker = false
deponieBlip = false

function createMuellTable()
    table.insert(muellmarkers, { 2295.96484375, -2116.6435546875, 13.610626220703 })
    table.insert(muellmarkers, { 2102.3017578125, -2045.62109375, 13.546875 })
    table.insert(muellmarkers, { 2007.671875, -2102.5712890625, 13.546875 })
    table.insert(muellmarkers, { 2070.822265625, -2159.677734375, 13.590328216553 })
    table.insert(muellmarkers, { 1920.388671875, -2125.7587890625, 13.581733703613 })
    table.insert(muellmarkers, { 1874.640625, -2041.75, 13.546875 })
    table.insert(muellmarkers, { 1698.9248046875, -2118.359375, 13.546875 })
    table.insert(muellmarkers, { 1974.80859375, -1884.6376953125, 13.546875 })
    table.insert(muellmarkers, { 2095.291015625, -1827.740234375, 13.5546875 })
    table.insert(muellmarkers, { 2063.9208984375, -1874.142578125, 13.546875 })
    table.insert(muellmarkers, { 2115.1328125, -1905.193359375, 13.546875 })
    table.insert(muellmarkers, { 1882.568359375, -1926.8134765625, 13.546875 })
    table.insert(muellmarkers, { 1914.1123046875, -1806.9541015625, 13.546875 })
    table.insert(muellmarkers, { 1933.7353515625, -1606.279296875, 13.539081573486 })
    table.insert(muellmarkers, { 1990.609375, -1785.6787109375, 13.553680419922 })
    table.insert(muellmarkers, { 2013.6708984375, -1685.0439453125, 13.546875 })
    table.insert(muellmarkers, { 2095.095703125, -1625.828125, 13.55931186676 })
    table.insert(muellmarkers, { 2225.9853515625, -1636.517578125, 15.450145721436 })
    table.insert(muellmarkers, { 2227.7080078125, -1472.599609375, 23.940847396851 })
    table.insert(muellmarkers, { 2326.0205078125, -1477.1533203125, 23.856838226318 })
    table.insert(muellmarkers, { 2222.93359375, -1393.0361328125, 24.000988006592 })
    table.insert(muellmarkers, { 2222.912109375, -1406.748046875, 24 })
    table.insert(muellmarkers, { 2206.3037109375, -1424.8720703125, 23.984375 })
    table.insert(muellmarkers, { 2247.7314453125, -1451.3798828125, 23.828125 })
    table.insert(muellmarkers, { 2253.1259765625, -1416.8701171875, 23.828125 })
    table.insert(muellmarkers, { 2203.3349609375, -1377.2763671875, 24 })
    table.insert(muellmarkers, { 2181.2177734375, -1343.3994140625, 23.984375 })
    table.insert(muellmarkers, { 2146.298828125, -1342.927734375, 23.984375 })
    table.insert(muellmarkers, { 2170.9697265625, -1433.8935546875, 23.984375 })
    table.insert(muellmarkers, { 2262.9794921875, -1292.51171875, 23.98645401001 })
    table.insert(muellmarkers, { 2242.2578125, -1261.4423828125, 23.94585609436 })
    table.insert(muellmarkers, { 2157.3466796875, -1261.2646484375, 23.990283966064 })
    table.insert(muellmarkers, { 2086, -1261.3515625, 23.992172241211 })
    table.insert(muellmarkers, { 2087.537109375, -1314.779296875, 23.984375 })
    table.insert(muellmarkers, { 2094.236328125, -1342.8251953125, 23.984375 })
    table.insert(muellmarkers, { 2137.32421875, -1207.859375, 23.920642852783 })
    table.insert(muellmarkers, { 2269.056640625, -1106.4052734375, 37.9765625 })
    table.insert(muellmarkers, { 2172.4306640625, -1111.8359375, 25.494230270386 })
    table.insert(muellmarkers, { 2034.1015625, -1104.5126953125, 24.59813117981 })
    table.insert(muellmarkers, { 2079.9326171875, -1179.708984375, 23.828052520752 })
    table.insert(muellmarkers, { 2092.6279296875, -1079.1044921875, 25.746276855469 })
    table.insert(muellmarkers, { 2186.3837890625, -1053.6455078125, 51.389442443848 })
    table.insert(muellmarkers, { 2155.8115234375, -997.8173828125, 62.9084815979 })
    table.insert(muellmarkers, { 2010.8134765625, -1034.2939453125, 24.770168304443 })
    table.insert(muellmarkers, { 1951.3916015625, -1056.244140625, 24.277559280396 })
    table.insert(muellmarkers, { 1905.7421875, -1088.021484375, 24.257881164551 })
    table.insert(muellmarkers, { 1870.392578125, -1334.5380859375, 13.553316116333 })
    table.insert(muellmarkers, { 1902.3916015625, -1365.8291015625, 13.536526679993 })
    table.insert(muellmarkers, { 1801.64453125, -1699.2587890625, 13.534524917603 })
    table.insert(muellmarkers, { 1839.333984375, -1829.5380859375, 13.585382461548 })
    table.insert(muellmarkers, { 2367.4150390625, -1653.6982421875, 13.546875 })
    table.insert(muellmarkers, { 2496.2822265625, -2410.4541015625, 13.410018920898 })
    table.insert(muellmarkers, { 2649.8994140625, -2400.466796875, 13.420581817627 })
    table.insert(muellmarkers, { 2594.341796875, -2499.861328125, 13.454496383667 })
    table.insert(muellmarkers, { 2202.591796875, -2489.7734375, 13.335213661194 })
    table.insert(muellmarkers, { 2505.474609375, -2233.0546875, 13.429344177246 })
    table.insert(muellmarkers, { 2659.8837890625, -2000.7265625, 13.265132904053 })
    table.insert(muellmarkers, { 2772.8828125, -1956.5380859375, 13.193690299988 })
    table.insert(muellmarkers, { 2449.21875, -1976.7587890625, 13.431105613708 })
    table.insert(muellmarkers, { 2484.873046875, -2014.556640625, 13.282417297363 })
    table.insert(muellmarkers, { 2348.78515625, -2006.1259765625, 13.426029205322 })
    table.insert(muellmarkers, { 2290.369140625, -1889.880859375, 13.32905292511 })
    table.insert(muellmarkers, { 2269.4072265625, -1753.1005859375, 13.265124320984 })
    table.insert(muellmarkers, { 2466.9248046875, -1754.02734375, 13.429265022278 })
    table.insert(muellmarkers, { 2670.505859375, -1459.361328125, 30.431535720825 })
    table.insert(muellmarkers, { 2686.2666015625, -1329.6474609375, 43.237724304199 })
    table.insert(muellmarkers, { 2753.2490234375, -1177.1494140625, 69.286506652832 })
    table.insert(muellmarkers, { 2611.8935546875, -1179.869140625, 63.604663848877 })
    table.insert(muellmarkers, { 2550.9775390625, -1218.3173828125, 52.959857940674 })
    table.insert(muellmarkers, { 2505.4794921875, -1231.76953125, 37.670188903809 })
    table.insert(muellmarkers, { 2585.0927734375, -1323.044921875, 40.28141784668 })
    table.insert(muellmarkers, { 2551.2939453125, -1369.5498046875, 31.492044448853 })
    table.insert(muellmarkers, { 2477.9853515625, -1327.06640625, 27.788778305054 })
    table.insert(muellmarkers, { 2447.634765625, -1372.369140625, 23.70813369751 })
    table.insert(muellmarkers, { 2392.6748046875, -1475.283203125, 23.692573547363 })
    table.insert(muellmarkers, { 2335.3154296875, -1366.818359375, 23.902801513672 })
    table.insert(muellmarkers, { 2404.1982421875, -1382.6484375, 24.098770141602 })
    table.insert(muellmarkers, { 2410.744140625, -1303.2236328125, 24.574760437012 })
    table.insert(muellmarkers, { 2375.541015625, -1217.630859375, 27.311960220337 })
    table.insert(muellmarkers, { 2432.3642578125, -1187.466796875, 35.809589385986 })
    table.insert(muellmarkers, { 2643.3681640625, -1189.15234375, 66.621765136719 })
    table.insert(muellmarkers, { 2739.5029296875, -1076.3037109375, 69.365043640137 })
    table.insert(muellmarkers, { 2542.49609375, -971.251953125, 81.943260192871 })
    table.insert(muellmarkers, { 2452.5478515625, -971.205078125, 79.950576782227 })
    table.insert(muellmarkers, { 2359.7861328125, -1040.615234375, 54.038356781006 })
    table.insert(muellmarkers, { 2489.0244140625, -1049.28515625, 67.755645751953 })
    table.insert(muellmarkers, { 2550.4443359375, -1099.05859375, 63.204471588135 })
    table.insert(muellmarkers, { 2422.90234375, -1105.958984375, 41.191425323486 })
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createMuellTable)

function resizePlayerJobMarkers()
    playerJobMarkers = {}
    playerJobMarkers = table.copy(muellmarkers)
end

function onPlayerEnterTrashMaster_func()
    local big = 0
    local big = table.getSize(playerJobMarkers)
    if (big <= 2) or (not (big)) then
        resizePlayerJobMarkers()
    end
    for theKey, theElement in ipairs(playerJobMarkers) do
        theElement[4] = createMarker(theElement[1], theElement[2], theElement[3] - 0.5, "cylinder", 3.0, 0, 0, 255)
        theElement[5] = createObject(1264, theElement[1], theElement[2], theElement[3])
        theElement[6] = createObject(1264, theElement[1] + 0.72, theElement[2], theElement[3])
        theElement[7] = createObject(1264, theElement[1] + 0.24, theElement[2] - 0.471, theElement[3])
        theElement[8] = createObject(1264, theElement[1] - 0.26, theElement[2] - 0.24, theElement[3] - 0.25)
        theElement[9] = createObject(1264, theElement[1] + 0.17, theElement[2] - 0.181, theElement[3] + 0.5)
        theElement[10] = createBlip(theElement[1], theElement[2], theElement[3], 0, 2, 0, 0, 255, 255, 0, 1200)
    end
    deponieMarker = createMarker(2181.57421875, -1983.2900390625, 12.433829307556, "cylinder", 3.0, 13, 130, 0)
    deponieBlip = createBlip(2181.57421875, -1983.2900390625, 13.433829307556, 0, 2, 13, 130, 0)
    showError(getLocalPlayer(), "Sammle den Müll ein (blaue Checkpoints) und bringe sie dann zur Mülldeponie (grüner Checkpoint)!")
end

addEvent("onPlayerEnterTrashMaster", true)
addEventHandler("onPlayerEnterTrashMaster", getRootElement(), onPlayerEnterTrashMaster_func)

function exitTrashMaster(thePlayer)
    if (thePlayer == getLocalPlayer()) then
        for theKey, theElement in ipairs(playerJobMarkers) do
            if (isElement(theElement[4])) then destroyElement(theElement[4]) end
            if (isElement(theElement[5])) then destroyElement(theElement[5]) end
            if (isElement(theElement[6])) then destroyElement(theElement[6]) end
            if (isElement(theElement[7])) then destroyElement(theElement[7]) end
            if (isElement(theElement[8])) then destroyElement(theElement[8]) end
            if (isElement(theElement[9])) then destroyElement(theElement[9]) end
            if (isElement(theElement[10])) then destroyElement(theElement[10]) end
        end
        if (isElement(deponieBlip)) then destroyElement(deponieBlip) end
        if (isElement(deponieMarker)) then destroyElement(deponieMarker) end
    end
end

addEventHandler("onClientVehicleExit", getRootElement(), exitTrashMaster)

function onPlayerDiedInMuell()
    if (source == getLocalPlayer()) then
        exitTrashMaster(source)
    end
end

addEventHandler("onClientPlayerWasted", getRootElement(), onPlayerDiedInMuell)

function enterTrashMasterCheckpoint(hitPlayer)
    if (hitPlayer == getLocalPlayer()) then
        if (tonumber(getElementData(hitPlayer, "job")) == 3) then
            for theKey, theElement in ipairs(playerJobMarkers) do
                if (theElement[4] == source) then
                    showError(getLocalPlayer(), "Der Müll wird verladen bitte warte einen Moment!")
                    setElementFrozen(getPedOccupiedVehicle(getLocalPlayer()), true)
                    setTimer(unfreezeTrashVehicle, 3000, 1, getPedOccupiedVehicle(getLocalPlayer()))
                    trashPoints = trashPoints + 1
                    outputChatBox(string.format("Du hast bereits %s Müllsäcke gesammelt!", trashPoints))
                    if (isElement(theElement[4])) then destroyElement(theElement[4]) end
                    if (isElement(theElement[5])) then destroyElement(theElement[5]) end
                    if (isElement(theElement[6])) then destroyElement(theElement[6]) end
                    if (isElement(theElement[7])) then destroyElement(theElement[7]) end
                    if (isElement(theElement[8])) then destroyElement(theElement[8]) end
                    if (isElement(theElement[9])) then destroyElement(theElement[9]) end
                    if (isElement(theElement[10])) then destroyElement(theElement[10]) end
                    table.remove(playerJobMarkers, theKey)
                end
            end
            if (source == deponieMarker) then
                triggerServerEvent("giveTrashUp", getLocalPlayer(), trashPoints)
                trashPoints = 0
                local restmarker = 0
                for theKey, theElement in ipairs(playerJobMarkers) do
                    if (isElement(theElement[4])) then
                        restmarker = restmarker + 1
                        if (isElement(theElement[4])) then destroyElement(theElement[4]) end
                        if (isElement(theElement[5])) then destroyElement(theElement[5]) end
                        if (isElement(theElement[6])) then destroyElement(theElement[6]) end
                        if (isElement(theElement[7])) then destroyElement(theElement[7]) end
                        if (isElement(theElement[8])) then destroyElement(theElement[8]) end
                        if (isElement(theElement[9])) then destroyElement(theElement[9]) end
                        if (isElement(theElement[10])) then destroyElement(theElement[10]) end
                    end
                end
                if (restmarker <= 2) then
                    resizePlayerJobMarkers()
                end
                for theKey, theElement in ipairs(playerJobMarkers) do
                    theElement[4] = createMarker(theElement[1], theElement[2], theElement[3] - 0.5, "cylinder", 3.0, 0, 0, 255)
                    theElement[5] = createObject(1264, theElement[1], theElement[2], theElement[3])
                    theElement[6] = createObject(1264, theElement[1] + 0.72, theElement[2], theElement[3])
                    theElement[7] = createObject(1264, theElement[1] + 0.24, theElement[2] - 0.471, theElement[3])
                    theElement[8] = createObject(1264, theElement[1] - 0.26, theElement[2] - 0.24, theElement[3] - 0.25)
                    theElement[9] = createObject(1264, theElement[1] + 0.17, theElement[2] - 0.181, theElement[3] + 0.5)
                    theElement[10] = createBlip(theElement[1], theElement[2], theElement[3], 0, 2, 0, 0, 255, 255, 0, 1200)
                end
            end
        end
    end
end

addEventHandler("onClientMarkerHit", getRootElement(), enterTrashMasterCheckpoint)

function unfreezeTrashVehicle(theVehicle)
    setElementFrozen(theVehicle, false)
end