local vehicleShopCars = {}
local carDealer = {
    -- billigautohaus
    {
        spawn = { 2126.619140625, -1140.4541015625, 24.910829544067, 4.7955322265625, 358.32458496094, 358.62121582031 },
        marker = { 2130.4326171875, -1149.8203125, 23.50613861084 },
        buyType = "land"
    },

    -- motorrad autohaus
    {
        spawn = { 545.529296875, -1277.7919921875, 17.028762817383, 358.77502441406, 0, 298.15246582031 },
        marker = { 555.669921875, -1292.025390625, 16.548237609863 },
        buyType = "bike"
    },

    -- sportautohaus
    {
        spawn = { 1086.232421875, 2396.1416015625, 10.464502334595, 359.57153320313, 359.97802734375, 87.379760742188 },
        marker = { 1110.8375244141, 2373.0610351563, 10.295311737061 },
        buyType = "land"
    },

    --flugzeughändler
    {
        spawn = { 1945.5, -2316.3, 16.7, 0, 0, 184 },
        marker = { 1977.130859375, -2308.94921875, 12.846875 },
        buyType = "air"
    },

    --bootshaus
    {
        spawn = { 802.79998779297, -2077.1999511719, 1.7999999523163, 0, 0, 183 },
        marker = { 813.54803466797, -2079.9807128906, 1.9609375476837 },
        buyType = "water"
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

    generateVehicleShopList()
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createVehicleShops)

function onVehicleShopMarkerHit(thePlayer)
    if (getElementType(thePlayer) == "player" and not isPedInVehicle(thePlayer)) then
        if (CrimeSystem.getCrimePercentage(thePlayer) >= 15) then
            outputChatBox("Solange du gesucht wirst, kannst du bei uns nicht einkaufen!", thePlayer, 255, 0, 0);
            return;
        end
        local shopData = vioGetElementData(source, "vehicleShopMarkerDef");

        local shopVehicleList = {}
        for theKey, theVehicle in ipairs(vehicleShopCars) do
            if (theVehicle.buyType == shopData.buyType) then
                table.insert(shopVehicleList, theVehicle);
            end
        end

        local transferJson = toJSON(shopVehicleList);
        vioSetElementData(thePlayer, "activeVehicleShop", shopData)
        triggerClientEvent(thePlayer, "openVehicleShop", thePlayer, transferJson)
    end

    local reduceIcon = createPickup(1051.06640625, 1007.8193359375, 11, 3, 1239, 5000)
    addEventHandler("onPickupHit", reduceIcon, showReducedCars, false)
end

function generateVehicleShopList()
    local json = readFile(":terratex_reallife\\SYSTEM\\vehsys\\shop\\vehicle_shop.json");
    vehicleShopCars = fromJSON(json);
    outputDebugString("loaded " ..  table.getSize(vehicleShopCars) .. " vehicles for shops")

    -- generate random reduced cars
    local i;
    for i = 1, 10, 1 do
        local rand = math.random(1, table.getSize(vehicleShopCars))
        local rabatt = math.random(20, 80);
        vehicleShopCars[rand].inSellPercentage = rabatt;
        vehicleShopCars[rand].inSell = true

        outputDebugString(getVehicleNameFromModel(theCar.modelId) .. ": " .. toprice(reducedPrice) .. " (" .. theCar.inSellPercentage .. " %)")
    end
end

function showReducedCars(thePlayer)
    outputChatBox("Folgende Fahrzeuge sind heute rabattiert: ", thePlayer)
    for theKey, theCar in ipairs(vehicleShopCars) do
        if (theCar.inSell) then
            local reducedPrice = theCar.price * (100 - theCar.inSellPercentage) / 100;
            outputChatBox(getVehicleNameFromModel(theCar.modelId) .. ": " .. toprice(reducedPrice) .. " (" .. theCar.inSellPercentage .. " %)", thePlayer)
        end
    end
end

function showReducedCarsCmd(thePlayer)
    if (vioGetElementData(thePlayer, "fraktion") == 3) then
        showReducedCars(thePlayer);
    end
end
addCommandHandler("rabattcars", showReducedCarsCmd, false, false)

