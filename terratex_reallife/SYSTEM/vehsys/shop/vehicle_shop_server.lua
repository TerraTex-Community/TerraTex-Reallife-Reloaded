local carDealer = {
    -- billigautohaus
    {
        spawn = { 2126.619140625, -1140.4541015625, 24.910829544067, 4.7955322265625, 358.32458496094, 358.62121582031 },
        marker = { 2130.4326171875, -1149.8203125, 23.70613861084 },
        type = "land"
    },

    -- motorrad autohaus
    {
        spawn = { 545.529296875, -1277.7919921875, 17.028762817383, 358.77502441406, 0, 298.15246582031 },
        marker = { 555.669921875, -1292.025390625, 16.748237609863 },
        type = "bike"
    },

    -- sportautohaus
    {
        spawn = { 1086.232421875, 2396.1416015625, 10.464502334595, 359.57153320313, 359.97802734375, 87.379760742188 },
        marker = { 1110.8375244141, 2373.0610351563, 10.495311737061 },
        type = "land"
    },

    --flugzeughändler
    {
        spawn = { 1945.5, -2316.3, 16.7, 0, 0, 184 },
        marker = { 1977.130859375, -2308.94921875, 13.046875 },
        type = "air"
    },

    --bootshaus
    {
        spawn = { 802.79998779297, -2077.1999511719, 1.7999999523163, 0, 0, 183 },
        marker = { 813.54803466797, -2079.9807128906, 2.1609375476837 },
        type = "water"
    }
}

function createVehicleShops()
    for theKey, theShop in ipairs(carDealer) do
        createBlip(theShop.marker[1], theShop.marker[2], theShop.marker[3], 55, 0.5, 255, 0, 0, 255, 0, 255, getRootElement())
        local marker = createMarker(theShop.marker[1], theShop.marker[2], theShop.marker[3], "cylinder", 2.0, 0, 0, 150, 150, getRootElement())
        vioSetElementData(marker, "vehicleShopMarkerDef", theShop)
        vioSetElementData(marker, "isVehicleShopMarker", true)
        addEventHandler("onMarkerHit", marker, onVehicleShopMarkerHit)
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createVehicleShops)

function onVehicleShopMarkerHit(thePlayer)
    if (getElementType(thePlayer) == "player" and not isPedInVehicle (thePlayer)) then
        -- @todo: check for no wanteds
        -- @todo: generate Vehicle List
        outputChatBox("open vehicle shop", thePlayer)
    end
end




--outputDebugString(tostring(table.getn(autohausVehicles)) .. " Cars loaded in Carhouse!")
--for theKey, thevehicle in ipairs(autohausVehicles) do
--    vioSetElementData(thevehicle[1], "isAutohausVehicle", true)
--    setVehicleDamageProof(thevehicle[1], true)
--    setElementFrozen(thevehicle[1], true)
--
--    --RabattCars
--end
--local i = 1;
--for i = 1, 7, 1 do
--    local rand = math.random(1, table.getSize(autohausVehicles))
--    if (not table.hasValue(rabattCars, rand)) then
--        local rabatt = (math.random(20, 80) / 100);
--        autohausVehicles[rand][4] = autohausVehicles[rand][4] * rabatt;
--
--        table.insert(rabattCars, rand)
--        table.insert(rabattCarsReduce, rabatt)
--    end
--end

--local rabattPickup = createPickup(1051.06640625, 1007.8193359375, 11, 3, 1239, 5000)
--addEventHandler("onPickupHit", rabattPickup, sendRabattCarMessage, false)
--function showRabbatCars_func(thePlayer)
--    if (vioGetElementData(thePlayer, "fraktion") == 3) then
--        outputChatBox("Folgende Fahrzeuge sind heute rabattiert: ", thePlayer)
--        for m, z in ipairs(rabattCars) do
--            local percentage = 100 - (rabattCarsReduce[m] * 100);
--            outputChatBox(autohausVehicles[z][2] .. ": " .. toprice(autohausVehicles[z][4]) .. " (" .. percentage .. " %)", thePlayer)
--        end
--    end
--end
--addCommandHandler("rabattcars", showRabbatCars_func, false, false)
--
--function sendRabattCarMessage(player)
--    outputChatBox("Folgende Fahrzeuge sind heute rabattiert: ", player)
--    for m, z in ipairs(rabattCars) do
--        local percentage = 100 - (rabattCarsReduce[m] * 100);
--        outputChatBox(autohausVehicles[z][2] .. ": " .. toprice(autohausVehicles[z][4]) .. " (" .. percentage .. " %)", player)
--    end
--end
--
