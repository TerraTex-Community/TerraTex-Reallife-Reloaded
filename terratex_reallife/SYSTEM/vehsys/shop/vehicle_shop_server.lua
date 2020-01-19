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
        local slotJson = toJSON(getPlayerSlotData(thePlayer));

        vioSetElementData(thePlayer, "activeVehicleShop", shopData);
        triggerClientEvent(thePlayer, "openVehicleShop", thePlayer, transferJson, slotJson);
    end

    local reduceIcon = createPickup(1051.06640625, 1007.8193359375, 11, 3, 1239, 5000);
    addEventHandler("onPickupHit", reduceIcon, showReducedCars, false);
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

        local reducedPrice = vehicleShopCars[rand].price * (100 - rabatt) / 100;

        outputDebugString(getVehicleNameFromModel(vehicleShopCars[rand].modelId) .. ": " .. toprice(reducedPrice) .. " (" .. vehicleShopCars[rand].inSellPercentage .. " %)")
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

-- buy Slot
function vehicleShopBuyCarSlot()
    local slotData = getPlayerSlotData(client)

    if (getPlayerMoney(client) < slotData.price) then
        triggerClientEvent(client, "event_vehicleShopBuySlot_error", client, "Du hast nicht genug Geld für einen Fahrzeugslot.");
    else
        vioSetElementData(client, "maxslots", (maxslot + 1))
        vioSetElementData(client, "slot" .. (maxslot + 1), -1)
        changePlayerMoney(client, -slotprice, "fahrzeug", "Fahrzeugslotkauf")
        outputChatBox("Du hast erfolgreich einen weiteren Slot gekauft!", client, 255, 0, 0)
        triggerClientEvent(client, "event_vehicleShopBuySlot_success", client, toJSON(getPlayerSlotData(client)));
    end
end
addEvent("event_vehicleShopBuySlot", true)
addEventHandler("event_vehicleShopBuySlot", getRootElement(), vehicleShopBuyCarSlot)

-- buy Vehicle
function vehicleShopBuyVehicle(modelId)
    local slotData = getPlayerSlotData(client)

    if (slotData.freeSlots == 0) then
        triggerClientEvent(client, "event_vehicleShopBuyCar_error", client, "Du hast keinen freien Slot mehr!");
    else
        local shopVehicleData = getVehicleShopDataByModelId(modelId)
        if (canPlayerHaveVehicle(client, shopVehicleData.price)) then
            if (hasTheLicenseFor(client, thevehicle)) then

                if (getPlayerMoney(client) < shopVehicleData.currentPrice) then
                    triggerClientEvent(client, "event_vehicleShopBuyCar_error", client, "Du hast nicht genügend Geld für dieses Fahrzeug!");
                    outputChatBox("Du hast nicht genügend Geld!", client, 255, 0, 0)
                else
                    changePlayerMoney(source, -shopVehicleData.currentPrice, "fahrzeug", "Fahrzeugkauf")
                    local currentShopData = vioGetElementData(thePlayer, "activeVehicleShop");

                    local spawnVeh = createVehicle(modelId, currentShopData.spawn[1], currentShopData.spawn[2], currentShopData.spawn[3], currentShopData.spawn[4], currentShopData.spawn[5], currentShopData.spawn[6])
                    vioSetElementData(client, "slot" .. slotData.firstFreeSlot, spawnVeh)
                    vioSetElementData(spawnVeh, "besitzer", getPlayerName(client))
                    vioSetElementData(spawnVeh, "slotid", slotData.firstFreeSlot)
                    vioSetElementData(spawnVeh, "spawnx", 0)
                    vioSetElementData(spawnVeh, "spawny", 0)
                    vioSetElementData(spawnVeh, "spawnz", 0)
                    vioSetElementData(spawnVeh, "spawnrx", 0)
                    vioSetElementData(spawnVeh, "spawnry", 0)
                    vioSetElementData(spawnVeh, "spawnrz", 0)
                    vioSetElementData(spawnVeh, "motor", false)
                    vioSetElementData(spawnVeh, "colors", "0|0|0|0")
                    vioSetElementData(spawnVeh, "locked", true)
                    vioSetElementData(spawnVeh, "tuning", "0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0")
                    vioSetElementData(spawnVeh, "paintjob", 3)
                    vioSetElementData(spawnVeh, "model", getElementModel(vehicle[1]))
                    vioSetElementData(spawnVeh, "tank", 100)
                    vioSetElementData(spawnVeh, "kmstand", 0)
                    vioSetElementData(spawnVeh, "falter", 0)
                    vioSetElementData(spawnVeh, "abgeschleppt", 0)
                    vioSetElementData(spawnVeh, "kaufpreis", vehicle[4])
                    vioSetElementData(spawnVeh, "Lichterfarbe", "255|255|255")
                    vioSetElementData(spawnVeh, "premColor", "-1")
                    fixVehicle(spawnVeh)

                    table.insert(privVeh, { getPlayerName(client), slotData.firstFreeSlot, spawnVeh })
                    privCars[spawnVeh] = true

                    local dbid = MySql.helper.insertSync("user_vehicles", {
                        SlotID = slotData.firstFreeSlot,
                        Besitzer = getPlayerName(client),
                        Model = getElementModel(spawnVeh),
                        SpawnX = 0,
                        SpawnY = 0,
                        SpawnZ = 0,
                        SpawnRX = 0,
                        SpawnRY = 0,
                        SpawnRZ = 0,
                        Colors = "0|0|0|0",
                        kaufpreis = shopVehicleData.currentPrice
                    });

                    vioSetElementData(spawnVeh, "dbid", dbid)
                    warpPedIntoVehicle(client, spawnVeh)
                    showError(client, "Du hast dieses Fahrzeug erfolgreich gekauft! Bitte parke es auf einen PARKPLATZ Reallife mäßig mit /park. Parkst du es nicht wird es an den Koordinaten 0 0 0 spawnen und eventuell gelöscht!")
                    outputChatBox("Du hast dieses Fahrzeug erfolgreich gekauft! Bitte parke es auf einen PARKPLATZ Reallife mäßig mit /park.", client, 255, 0, 0)
                    outputChatBox("Parkst du es nicht wird es an den Koordinaten 0 0 0 spawnen und eventuell gelöscht!", client, 255, 0, 0)

                    if (vioGetElementData(client, "Erfolg_Autoeinsteiger") ~= 1) then
                        vioSetElementData(client, "Erfolg_Autoeinsteiger", 1)
                        triggerClientEvent(client, "onClientCreatePokalGUI", client, "Autoeinsteiger", "Kaufe ein Auto!")
                    end

                    triggerClientEvent(client, "event_vehicleShopBuyCar_success", client)
                end
            else
                triggerClientEvent(client, "event_vehicleShopBuyCar_error", client, "Du hast nicht die nötigen Lizensen!");
            end
        else
            triggerClientEvent(client, "event_vehicleShopBuyCar_error", client, "Dieses Fahrzeug kostet mehr als dein Lebensstandard hergibt.");
        end
    end
end
addEvent("event_vehicleShopBuyCar", true)
addEventHandler("event_vehicleShopBuyCar", getRootElement(), vehicleShopBuyVehicle)

function getVehicleShopDataByModelId(modelId) 
    outputDebugString(modelId);
    for theKey, theVehicle in ipairs(vehicleShopCars) do
        if (theVehicle.modelId == modelId) then
            theVehicle.currentPrice = theVehicle.price;
            if (theVehicle.inSell) then
                theVehicle.currentPrice = theVehicle.price * (100 - theVehicle.inSellPercentage) / 100;
            end

            return theVehicle;
        end
    end

    return false;
end

function checkForCarBuyEvent(thePlayer)
    local slotData = getPlayerSlotData(thePlayer)

    if (slotData.totalSlots - slotData.freeSlots > 10) then
        if (vioGetElementData(thePlayer, "Erfolg_10erFahrzeugrausch") ~= 1) then
            vioSetElementData(thePlayer, "Erfolg_10erFahrzeugrausch", 1)
            triggerClientEvent(thePlayer, "onClientCreatePokalGUI", thePlayer, "10er Fahrzeugrausch", "Besitze 10 Fahrzeuge!")
        end
    end
    if (slotData.totalSlots - slotData.freeSlots > 15) then
        if (vioGetElementData(thePlayer, "Erfolg_20erFahrzeugrausch") ~= 1) then
            vioSetElementData(thePlayer, "Erfolg_20erFahrzeugrausch", 1)
            triggerClientEvent(thePlayer, "onClientCreatePokalGUI", thePlayer, "15er Fahrzeugrausch", "Besitze 15 Fahrzeuge!")
        end
    end
    if (slotData.totalSlots - slotData.freeSlots > 20) then
        if (vioGetElementData(thePlayer, "Erfolg_50erFahrzeugrausch") ~= 1) then
            vioSetElementData(thePlayer, "Erfolg_50erFahrzeugrausch", 1)
            triggerClientEvent(thePlayer, "onClientCreatePokalGUI", thePlayer, "20er Fahrzeugrausch", "Besitze 20 Fahrzeuge!")
        end
    end
end
