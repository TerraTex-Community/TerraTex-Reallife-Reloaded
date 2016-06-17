pizzaRoller = {}

function createPizzaVehicles()
    local vehicle = createVehicle(448, 2124.955078125, -1820.931640625, 13.149250030518, 359.40124511719, 0.0054931640625, 286.82006835938, "PIZZA")
    table.insert(pizzaRoller, vehicle)
    vehicle = createVehicle(448, 2125.09375, -1819.5263671875, 13.140615463257, 359.33532714844, 0.0054931640625, 287.16064453125, "PIZZA")
    table.insert(pizzaRoller, vehicle)
    vehicle = createVehicle(448, 2125.119140625, -1818.0048828125, 13.148089408875, 359.39575195312, 0.0054931640625, 285.27099609375, "PIZZA")
    table.insert(pizzaRoller, vehicle)
    vehicle = createVehicle(448, 2125.107421875, -1816.4697265625, 13.145067214966, 359.384765625, 0.0054931640625, 287.64404296875, "PIZZA")
    table.insert(pizzaRoller, vehicle)
    vehicle = createVehicle(448, 2125.1044921875, -1814.86328125, 13.141102790833, 359.36828613281, 0, 284.95788574219, "PIZZA")
    table.insert(pizzaRoller, vehicle)
    for key, theVehicle in pairs(pizzaRoller) do
        prepare(theVehicle, 0)
        vioSetElementData(theVehicle, "hasTank", true)
    end
    local console = getElementsByType("console")
    vioSetElementData(console[1], "adminlvl", 4)
    setTimer(respawnPizzaCars, 300000, 1)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createPizzaVehicles)

function respawnPizzaCars()
    for key, theVehicle in pairs(pizzaRoller) do
        if not (isAnyOneInVehicle(theVehicle)) then
            setVehicleOverrideLights(theVehicle, 1)
            setVehicleEngineState(theVehicle, false)
            respawnVehicle(theVehicle)
            vioSetElementData(theVehicle, "tank", 100)
        end
    end
    setTimer(respawnPizzaCars, 300000, 1)
end

pizzaAbhole = { 2095.544921875, -1806.642578125, 13.145221710205 }
-- 164.6427154541	-1394.6400146484		47.807476043701
-- outputChatBox(tostring(getDistanceBetweenPoints3D(2095.544921875,-1806.642578125,13.145221710205, 164.6427154541, -1394.6400146484, 47.807476043701)), getRootElement(), 0, 0, 0, false)
-- vioSetElementData(thePlayer,"PizzaStation")
-- vioSetElementData(thePlayer,"PizzaBlip")
-- vioSetElementData(thePlayer,"PizzaMarker")

function StartPizzaLieferant(thePlayer)
    if not (vioGetElementData(thePlayer, "PizzaStation")) then
        vioSetElementData(thePlayer, "PizzaStation", 0)
    end
    if (vioGetElementData(thePlayer, "PizzaStation") > 0) then
        outputChatBox("Du hast deine letzte Lieferung noch nicht abgeschlossen! Liefere die Ware ab!", thePlayer, 50, 255, 30)
        local ID = vioGetElementData(thePlayer, "PizzaStation")
        local haus = haeuser[ID]
        local x, y, z = haus:getCoords()
        local blip = createBlip(x, y, z, 0, 2, 50, 255, 30, 255, 0, 99999.0, thePlayer)
        local marker = createMarker(x, y, z, "checkpoint", 5, 50, 255, 30, 255, thePlayer)
        vioSetElementData(thePlayer, "PizzaBlip", blip)
        vioSetElementData(thePlayer, "PizzaMarker", marker)
        addEventHandler("onMarkerHit", marker, PizzaSetMarkerHit) --
    else
        outputChatBox("Hole die Ware vom Pizzahändler", thePlayer, 50, 255, 30)
        local blip = createBlip(pizzaAbhole[1], pizzaAbhole[2], pizzaAbhole[3], 0, 2, 50, 255, 30, 255, 0, 99999.0, thePlayer)
        local marker = createMarker(pizzaAbhole[1], pizzaAbhole[2], pizzaAbhole[3], "checkpoint", 5, 50, 255, 30, 255, thePlayer)
        vioSetElementData(thePlayer, "PizzaBlip", blip)
        vioSetElementData(thePlayer, "PizzaMarker", marker)
        addEventHandler("onMarkerHit", marker, PizzaGetMarkerHit)
    end
end

function PizzaSetMarkerHit(thePlayer)
    if (source == vioGetElementData(thePlayer, "PizzaMarker")) then
        destroyElement(vioGetElementData(thePlayer, "PizzaBlip"))
        destroyElement(vioGetElementData(thePlayer, "PizzaMarker"))
        local blip = createBlip(pizzaAbhole[1], pizzaAbhole[2], pizzaAbhole[3], 0, 2, 50, 255, 30, 255, 0, 99999.0, thePlayer)
        local marker = createMarker(pizzaAbhole[1], pizzaAbhole[2], pizzaAbhole[3], "checkpoint", 5, 50, 255, 30, 255, thePlayer)
        vioSetElementData(thePlayer, "PizzaBlip", blip)
        vioSetElementData(thePlayer, "PizzaMarker", marker)
        vioSetElementData(thePlayer, "PizzaStation", 0)
        addEventHandler("onMarkerHit", marker, PizzaGetMarkerHit)
        local px, py, pz = getElementPosition(thePlayer)
        local dis = getDistanceBetweenPoints3D(px, py, pz, pizzaAbhole[1], pizzaAbhole[2], pizzaAbhole[3])

        local betragDirekt, betragPayDay = giveJobGehalt(thePlayer, 8, 1, dis)


        outputChatBox(string.format("Du erhälst für diese Bestellung %s Gehalt und zusätzlich %s Trinkgeld.", toprice(betragPayDay), toprice(betragDirekt)), thePlayer, 50, 255, 30)

        vioSetElementData(thePlayer, "Punkte_Pizzaraser", vioGetElementData(thePlayer, "Punkte_Pizzaraser") + 1)
        if (vioGetElementData(thePlayer, "Punkte_Pizzaraser") > 1000) then
            if (vioGetElementData(thePlayer, "Erfolg_Pizzaraser") ~= 1) then
                vioSetElementData(thePlayer, "Erfolg_Pizzaraser", 1)
                triggerClientEvent(thePlayer, "onClientCreatePokalGUI", thePlayer, "Pizzaraser", "1000 Bestellungen ausgeliefert.")
            end
        end

        outputChatBox("Hole neue Ware vom Pizzahändler!", thePlayer, 50, 255, 30)
    end
end

function StopPizzaLieferant(thePlayer)
    if (isElement(vioGetElementData(thePlayer, "PizzaBlip"))) then
        destroyElement(vioGetElementData(thePlayer, "PizzaBlip"))
    end
    if (isElement(vioGetElementData(thePlayer, "PizzaMarker"))) then
        destroyElement(vioGetElementData(thePlayer, "PizzaMarker"))
    end
    vioSetElementData(thePlayer, "PizzaBlip", false)
    vioSetElementData(thePlayer, "PizzaMarker", false)
end

function PizzaGetMarkerHit(thePlayer)
    if (source == vioGetElementData(thePlayer, "PizzaMarker")) then
        destroyElement(vioGetElementData(thePlayer, "PizzaBlip"))
        destroyElement(vioGetElementData(thePlayer, "PizzaMarker"))
        vioSetElementData(thePlayer, "PizzaMarker", false)
        local hasNoCoords = 0
        local HID = 0
        while (hasNoCoords == 0) do
            HID = math.random(1, table.getMax(haeuser))
            outputDebugString("Pizzaroller to " .. HID)
            if (haeuser[HID]) then
                local haus = haeuser[HID]
                if (haus:getBesitzer() and haus:getCity() == 0) then
                    hasNoCoords = 1
                end
            end
        end
        local haus = haeuser[HID]
        local x, y, z = haus:getCoords()
        local blip = createBlip(x, y, z, 0, 2, 50, 255, 30, 255, 0, 99999.0, thePlayer)
        local marker = createMarker(x, y, z, "checkpoint", 5, 50, 255, 30, 255, thePlayer)
        vioSetElementData(thePlayer, "PizzaBlip", blip)
        vioSetElementData(thePlayer, "PizzaMarker", marker)
        vioSetElementData(thePlayer, "PizzaStation", HID)
        addEventHandler("onMarkerHit", marker, PizzaSetMarkerHit)
        outputChatBox("Liefere die Pizza an die markierte Adresse!", thePlayer, 50, 255, 30)
    end
end

function notinpizzaCarEnter(thePlayer, seat, jacked, door)
    if (seat == 0) then
        for theKey, theVehicle in pairs(pizzaRoller) do
            if (source == theVehicle) then
                if not (vioGetElementData(thePlayer, "job") == 8) then
                    showError(thePlayer, "Du kannst das nicht benutzen. Du bist kein Pizzalieferant!")
                    removePedFromVehicle(thePlayer)
                else
                    StartPizzaLieferant(thePlayer)
                end
            end
        end
    end
end

addEventHandler("onVehicleEnter", getRootElement(), notinpizzaCarEnter)

function notinpizzaCarEnter(thePlayer, seat, jacked, door)
    if (seat == 0) then
        for theKey, theVehicle in pairs(pizzaRoller) do
            if (source == theVehicle) then
                if not (vioGetElementData(thePlayer, "job") == 8) then
                else
                    StopPizzaLieferant(thePlayer)
                end
            end
        end
    end
end

addEventHandler("onVehicleExit", getRootElement(), notinpizzaCarEnter)

function onPlayerDeadPizza()
    local thePlayer = source
    if not (vioGetElementData(thePlayer, "job") == 8) then
    else
        StopPizzaLieferant(thePlayer)
    end
end

addEventHandler("onPlayerWasted", getRootElement(), onPlayerDeadPizza)








