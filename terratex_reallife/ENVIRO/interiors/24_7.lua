local shop247marker = {
    {marker = false, x = 999.8369140625, y = -920.1591796875, z = 42.328125, pedX = 997.8505859375, pedY = -920.826171875, pedZ = 42.1796875, interior = 18},
    {marker = false, x = 1352.0341796875, y = -1758.7646484375, z = 13.5078125, pedX = 1350.095703125, pedY = -1757.255859375, pedZ = 13.5078125, interior = 18},
    {marker = false, x = 1833.2900390625, y = -1842.6884765625, z = 13.578125, pedX = 1829.7646484375, pedY = -1842.822265625, pedZ = 13.578125, interior = 18},
    {marker = false, x = 1928.96875, y = -1776.318359375, z = 13.546875, pedX = 1931.55078125, pedY = -1776.041015625, pedZ = 13.546875, interior = 18},
    {marker = false, x = 2118.0537109375, y = 896.775390625, z = 11.1796875, pedX = 2117.78515625, pedY = 899.5888671875, pedZ = 11.1796875, interior = 18},
    {marker = false, x = 2637.0126953125, y = 1129.67578125, z = 11.1796875, pedX = 2637.3017578125, pedY = 1126.7822265625, pedZ = 11.183449745178, interior = 18},
    {marker = false, x = 2546.4013671875, y = 1972.6279296875, z = 10.8203125, pedX = 2546.53125, pedY = 1969.1064453125, pedZ = 10.8203125, interior = 18},
    {marker = false, x = 2452.5341796875, y = 2065.013671875, z = 10.8203125, pedX = 2453.345703125, pedY = 2061.294921875, pedZ = 10.8203125, interior = 18},
    {marker = false, x = 2884.3408203125, y = 2453.8310546875, z = 11.068956375122, pedX = 2887.2548828125, pedY = 2452.1826171875, pedZ = 11.068956375122, interior = 18},
    {marker = false, x = 2247.84375, y = 2397.041015625, z = 10.8203125, pedX = 2247.462890625, pedY = 2400.0712890625, pedZ = 11.25, interior = 18},
    {marker = false, x = 2097.5810546875, y = 2224.2666015625, z = 11.0234375, pedX = 2098.2880859375, pedY = 2221.0498046875, pedZ = 10.8203125, interior = 18},
    {marker = false, x = 1599.326171875, y = 2222.0673828125, z = 11.0625, pedX = 1601.99609375, pedY = 2219.8076171875, pedZ = 11.0625, interior = 18},
    {marker = false, x = -2231.7626953125, y = -2557.892578125, z = 31.921875, pedX = -2234.234375, pedY = -2555.009765625, pedZ = 31.92187, interior = 18},
    {marker = false, x = 661.3515625, y = -573.2998046875, z = 16.3359375, pedX = 657.9296875, pedY = -573.5263671875, pedZ = 16.3359375, interior = 18},
    {marker = false, x = 2318.4404296875, y = -88.8095703125, z = 26.484375, pedX = 2318.68359375, pedY = -91.609375, pedZ = 26.484375, interior = 18},
    {marker = false, x = -181.0771484375, y = 1035.16796875, z = 19.7421875, pedX = -183.787109375, pedY = 1035.4609375, pedZ = 19.7421875, interior = 18},
    {marker = false, x = -1320.3251953125, y = 2697.87109375, z = 50.26628112793, pedX = -1318.6953125, pedY = 2695.2353515625, pedZ = 50.0625, interior = 18},
    {marker = false, x = 639.1005859375, y = 1684.083984375, z = 7.1875, pedX = 637.166015625, pedY = 1687.546875, pedZ = 6.9921875, interior = 18},
    {marker = false, x = -2492.052734375, y = 2363.0693359375, z = 10.2767162323, pedX = -2489.3251953125, pedY = 2363.55078125, pedZ = 10.271138191223, interior = 18},
    {marker = false, x = -1675.908203125, y = 432.3076171875, z = 7.179687, pedX = -1671.9150390625, pedY = 429.8876953125, pedZ = 7.1796875, interior = 18},
    {marker = false, x = -2420.1533203125, y = 969.5029296875, z = 45.296875, pedX = -2418.236328125, pedY = 968.2109375, pedZ = 45.296875, interior = 18},
    {marker = false, x = 1315.51171875, y = -897.6806640625, z = 39.578125, pedX = 1315.052734375, pedY = -900.818359375, pedZ = 39.578125, interior = 18},
    {marker = false, x = 1638.934, y = 71.78, z = 37, pedX = 1636.1, pedY = 69.6, pedZ = 37.4, interior = 6} -- Tankstelle Autobahn LS<->LV
}

function get247PortTable()
    return shop247marker;
end

local shop247innenport = {}
shop247innenport[18] = {x = -31.224609375, y = -88.9921875, z = 1004.46875} --24/7 Shop 1
shop247innenport[6] = {x = -26.6, y = -54.5, z = 1004.46} --24/7 Shop 2

local shop247ExitMarker = {}
shop247ExitMarker[18] = {x = -31.05859375, y = -92.0107421875, z = 1003.5} -- 24/7 Shop 1
shop247ExitMarker[6] = {x = -26.8, y = -58.4, z = 1003.5} -- 24/7 Shop 2

function on247Create()
    for keyExitMarker, tableExitMarker in next, shop247ExitMarker do
        local mark = createMarker(tableExitMarker.x, tableExitMarker.y, tableExitMarker.z, "corona", 2.0)
        setElementInterior(mark, keyExitMarker)--ID 98
        addEventHandler("onMarkerHit", mark, portPlayerOutof247)
        for keyMarker, tableMarker in ipairs(shop247marker) do
            if (tableMarker.interior == keyExitMarker) then
                local marker = createMarker(tableExitMarker.x, tableExitMarker.y, tableExitMarker.z, "corona", 1)
                setElementInterior(marker, keyExitMarker)
                setElementDimension(marker, keyMarker)
            end
        end
    end

    for theKey, theTable in ipairs(shop247marker) do
        theTable.marker = createMarker(theTable.x, theTable.y, theTable.z, "corona", 2.0)
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), on247Create)

function onPlayerJOin_shopblip()
    setTimer(loadEinkaufBlips, 10000, 1, source)
end
addEventHandler("onPlayerJoin", getRootElement(), onPlayerJOin_shopblip)

function loadEinkaufBlips(source)
    if (isElement(source)) then
        for theKey, theTable in ipairs(shop247marker)do
            local x, y, z = getElementPosition(theTable.marker)
            triggerClientEvent(source, "createCustomBlip_event", source, x, y, 16, 16, "FILES/IMAGES/blips/kauf.png", 255)
        end
    end
end

function portPlayerIn247(thePlayer)
    if (isElement(thePlayer)) then
        if (getElementType(thePlayer)=="player") then
            if (not isPedInVehicle(thePlayer)) then
                for theKey, theTable in ipairs(shop247marker) do
                    if (theTable.marker==source) then
                        setElementDimension(thePlayer, theKey)
                        setElementInterior(thePlayer, theTable.interior)
                        vioSetElementData(thePlayer, "in247bell", theKey)
                        setElementPosition(thePlayer, shop247innenport[theTable.interior].x, shop247innenport[theTable.interior].y, shop247innenport[theTable.interior].z)
                    end
                end
            end
        end
    end
end
addEventHandler("onMarkerHit", getRootElement(), portPlayerIn247)

function portPlayerOutof247(thePlayer)
    local in247=vioGetElementData(thePlayer,"in247bell")
    setElementInterior(thePlayer, 0)
    setElementDimension(thePlayer, 0)
    setElementPosition(thePlayer, shop247marker[in247].pedX, shop247marker[in247].pedY, shop247marker[in247].pedZ)
    triggerClientEvent(thePlayer, "closeShopGUIS", thePlayer)
end
