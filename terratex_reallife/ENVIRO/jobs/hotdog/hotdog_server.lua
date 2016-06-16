addEvent("buyHotDogs", true)
local hotdogCars = {}

function onResourceCreateHotDogMarkerAndVehicles()
    local marker = createMarker(-12.7333984375, -271.951171875, 5.0367042541504, "cylinder")
    addEventHandler("onMarkerHit", marker, hitHotDogSellMarker)
    local vehicle = createVehicle(588, -57.76953125, -215.279296875, 5.3341941833496, 358.67065429688, 359.99450683594, 173.91906738281) --  hitdog 1
    table.insert(hotdogCars, vehicle)
    vehicle = createVehicle(588, -49.8330078125, -216.1337890625, 5.3326315879822, 358.65966796875, 359.99450683594, 174.40246582031) --  hotdog 2
    table.insert(hotdogCars, vehicle)
    vehicle = createVehicle(588, -42.05859375, -217.0615234375, 5.337984085083, 358.61022949219, 0.098876953125, 174.27612304688) --  hotdog 3
    table.insert(hotdogCars, vehicle)
    vehicle = createVehicle(588, -34.2080078125, -217.837890625, 5.3346524238586, 358.67065429688, 359.99450683594, 174.11682128906) --  hotdog 4
    table.insert(hotdogCars, vehicle)
    vehicle = createVehicle(588, -26.341796875, -218.7236328125, 5.3372049331665, 358.68713378906, 359.99450683594, 174.49035644531) --  hotdog 5
    table.insert(hotdogCars, vehicle)
    vehicle = createVehicle(588, -18.8388671875, -219.76953125, 5.3309893608093, 358.64868164063, 359.99450683594, 175.33081054688) --  hitdog 6
    table.insert(hotdogCars, vehicle)

    for theKey, theVehicle in ipairs(hotdogCars) do
        addEventHandler("onVehicleEnter", theVehicle, showVehicleHotDogFuel)
        addEventHandler("onVehicleStartEnter", theVehicle, donotEnterIfNotHotDog)
        vioSetElementData(theVehicle, "hotdogFuel", 0)
        vioSetElementData(theVehicle, "hasTank", true)
        prepare(theVehicle, 0)
    end
    respawnHotDogCars()
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onResourceCreateHotDogMarkerAndVehicles)

function donotEnterIfNotHotDog(thePlayer)
    if not (vioGetElementData(thePlayer, "job") == 18) then
        cancelEvent()
        showError(thePlayer, "Du bist kein Hotdogverkäufer!")
    end
end

function showVehicleHotDogFuel(thePlayer)
    outputChatBox(string.format("In diesem Hotdogwagen befinden sich %s / 500 Hotdogs", vioGetElementData(source, "hotdogFuel")), thePlayer, 0, 255, 0)
    outputChatBox("Hotdogs verkaufen mit: /sellhotdog [Menge] [Preis] [Spielername]", thePlayer, 0, 255, 0)
    outputChatBox("Menge der verbleibenden Hotdogs anzeigen mit: /hotdogs", thePlayer, 0, 255, 0)
end

function sellhotdog_func(thePlayer, cmd, mengeStr, preisStr, toPlayerNamePart)
    if (isPedInVehicle(thePlayer)) then
        if (getPedOccupiedVehicleSeat(thePlayer) == 0) then
            if (getElementModel(getPedOccupiedVehicle(thePlayer)) == 588) then
                local theVehicle = getPedOccupiedVehicle(thePlayer)
                if (mengeStr and preisStr and toPlayerNamePart) then
                    local menge = tonumber(mengeStr)
                    local preis = tonumber(preisStr)
                    if (menge and preis) then
                        if (menge < 0 or preis < 0) then
                            return false
                        else
                            local toPlayer = getPlayerFromIncompleteName(toPlayerNamePart)
                            if (toPlayer) then
                                local x, y, z = getElementPosition(thePlayer)
                                local px, py, pz = getElementPosition(toPlayer)
                                if (getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 20) then
                                    if (vioGetElementData(theVehicle, "hotdogFuel") >= menge) then
                                        if (getPlayerMoney(toPlayer) >= preis) then
                                            vioSetElementData(toPlayer, "hotDogSeller", thePlayer)
                                            vioSetElementData(toPlayer, "hotDogSellerPrice", preis)
                                            vioSetElementData(toPlayer, "hotDogSellerMenge", menge)
                                            outputChatBox(string.format("Du hast %s %s Hotdogs für %s zum verkauf angeboten!", getPlayerName(toPlayer), menge, toprice(preis)), thePlayer, 0, 155, 0)
                                            outputChatBox(string.format("Dir hat %s %s Hotdogs für %s zum verkauf angeboten!", getPlayerName(thePlayer), menge, toprice(preis)), toPlayer, 0, 155, 0)
                                            outputChatBox("Aktzeptieren mit /accept hotdog", toPlayer, 0, 155, 0)
                                        else
                                            showError(thePlayer, "Der Spieler hat nicht genug Geld dabei.")
                                        end
                                    else
                                        showError(thePlayer, "So viele Hotdogs befinden sich nicht mehr im Fahrzeug!")
                                    end
                                else
                                    showError(thePlayer, "Der Spieler ist nicht in deiner Nähe!")
                                end

                            else
                                showError(thePlayer, "Dieser Spieler existiert nicht!")
                            end
                        end
                    else
                        showError(thePlayer, "ungültige Menge oder ungültiger Preis!")
                    end
                else
                    showError(thePlayer, "Nutzung: /sellhotdog [Menge] [Preis] [Spielername]")
                end
            else
                showError(thePlayer, "Du musst dazu in einen Hotdogwagen sein!")
            end
        else
            showError(thePlayer, "Du musst dazu der Fahrer eines Hotdogwagens sein!")
        end
    else
        showError(thePlayer, "Du musst dazu in einen Hotdogwagen sein!")
    end
end
addCommandHandler("sellhotdog", sellhotdog_func, false, false)

function hotdogs_func(thePlayer)
    if (isPedInVehicle(thePlayer)) then
        if (getPedOccupiedVehicleSeat(thePlayer) == 0) then
            if (getElementModel(getPedOccupiedVehicle(thePlayer)) == 588) then
                local theVehicle = getPedOccupiedVehicle(thePlayer)
                outputChatBox(string.format("In diesem Hotdogwagen befinden sich %s / 500 Hotdogs", vioGetElementData(theVehicle, "hotdogFuel")), thePlayer, 0, 255, 0)
                outputChatBox("Hotdogs verkaufen mit: /sellhotdog [Menge] [Preis] [Spielername]", thePlayer, 0, 255, 0)
                outputChatBox("Menge der verbleibenden Hotdogs anzeigen mit: /hotdogs", thePlayer, 0, 255, 0)
            end
        end
    end
end
addCommandHandler("hotdogs", hotdogs_func, false, false)

local hotdogPrice = 0.10
function buyHotDogs_func(menge)
    local thePlayer = source
    if (menge) then
        menge = tonumber(menge)
        if (menge) then
            if (menge > 0) then
                if (isPedInVehicle(thePlayer)) then
                    if (getPedOccupiedVehicleSeat(thePlayer) == 0) then
                        if (getElementModel(getPedOccupiedVehicle(thePlayer)) == 588) then
                            local theVehicle = getPedOccupiedVehicle(thePlayer)
                            local rest = vioGetElementData(theVehicle, "hotdogFuel")
                            if (rest + menge > 500) then
                                showError(thePlayer, "Das Fahrzeug wäre mit dieser Menge an Hotdogs zu voll!")
                            else
                                local price = hotdogPrice * menge
                                if (price > getPlayerMoney(thePlayer)) then
                                    showError(thePlayer, "Du hast nicht genug Geld! Pro Hotdog: 0.10$")
                                else
                                    changePlayerMoney(thePlayer, -price, "sonstiges", "Hotdog gekauft")
                                    vioSetElementData(theVehicle, "hotdogFuel", vioGetElementData(theVehicle, "hotdogFuel") + menge)
                                    outputChatBox(string.format("In diesem Hotdogwagen befinden sich nun %s / 500 Hotdogs", vioGetElementData(theVehicle, "hotdogFuel")), thePlayer, 0, 255, 0)
                                    outputChatBox("Hotdogs verkaufen mit: /sellhotdog [Menge] [Preis] [Spielername]", thePlayer, 0, 255, 0)
                                    outputChatBox("Menge der verbleibenden Hotdogs anzeigen mit: /hotdogs", thePlayer, 0, 255, 0)
                                end
                            end
                        end
                    end
                end
            else
                showError(thePlayer, "Falsche Mengeneingabe!")
            end
        else
            showError(thePlayer, "Falsche Mengeneingabe!")
        end
    else
        showError(thePlayer, "Falsche Mengeneingabe!")
    end
end
addEventHandler("buyHotDogs", getRootElement(), buyHotDogs_func)

function respawnHotDogCars()
    for key, theVehicle in pairs(hotdogCars) do
        if not (isAnyOneInVehicle(theVehicle)) then
            setVehicleOverrideLights(theVehicle, 1)
            setVehicleEngineState(theVehicle, false)
            respawnVehicle(theVehicle)

            vioSetElementData(theVehicle, "tank", 100)
        end
    end
    setTimer(respawnHotDogCars, 600000, 1)
end

function hitHotDogSellMarker(thePlayer)
    if (getElementType(thePlayer) == "player") then
        if (isPedInVehicle(thePlayer)) then
            if (getPedOccupiedVehicleSeat(thePlayer) == 0) then
                if (getElementModel(getPedOccupiedVehicle(thePlayer)) == 588) then
                    triggerClientEvent(thePlayer, "showHotDogGUI", thePlayer)
                end
            end
        end
    end
end
