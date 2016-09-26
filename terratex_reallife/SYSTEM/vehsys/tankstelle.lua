local blipcoord = {}
local fuelStations = {};

function createTankstellenMarker()

    local stations = MySql.helper.getSync("objects_fuel_stations", "*");

    for theKey, theStation in ipairs(stations) do
        local pumps = {}
        local pumpData = fromJSON(theStation.GasPumps);
        for theKey, thePump in ipairs(pumpData) do
            local marker = createMarker(thePump.x, thePump.y, thePump.z, "cylinder", thePump.size);
            if (tonumber(thePump.size) > 2) then
                vioSetElementData(marker, "repairMarker", true)
            end

            addEventHandler("onMarkerHit", marker, TankenMarkerHit)
            setElementShowText(marker, 0xFFFF00FF, "Tankpreis: ", false, thePump.size * 15, 2, 1.5)
            table.insert(pumps, marker);
            vioSetElementData(marker, "fuelStationID", tonumber(theStation.ID));
        end

        local x,y,z = getElementPosition(pumps[1]);
        table.insert(blipcoord, { x,y,z });
        table.insert(fuelStations, tonumber(theStation.Price), {
            id = tonumber(theStation.ID),
            pumps = pumps,
            price = tonumber(theStation.Price)
        });
    end

    debug.print(fuelStations);
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createTankstellenMarker)

function onPlayerJoinTransferBlips()
    setTimer(loadBlips, 10000, 1, source)
end
addEventHandler("onPlayerJoin", getRootElement(), onPlayerJoinTransferBlips)

function loadBlips(source)
    if (isElement(source)) then
        for theKey, thecoordPaar in ipairs(blipcoord) do
            triggerClientEvent(source, "createCustomBlip_event", source, thecoordPaar[1], thecoordPaar[2], 12, 12, "FILES/IMAGES/blips/tanke.png", 255)
        end
    end
end

function globalTankTimer()
--- GLOBAL TANKPRICE FOR FACTION-CALCULATIONS
    local aenderung = ((math.random(1, 300) / 100) - 1.5) / 10
    if ((serversettings["tankpreis"] + aenderung) < 3.80) then
        serversettings["tankpreis"] = 8.80
    elseif ((serversettings["tankpreis"] + aenderung) > 15.815) then
        serversettings["tankpreis"] = 8.815
    else
        serversettings["tankpreis"] = serversettings["tankpreis"] + aenderung
    end

    for theKey, theStation in pairs(fuelStations) do
        local aenderung = ((math.random(1, 600) / 100) - 3) / 10

        if ((theStation.price + aenderung) < 1.80) then
            fuelStations[theKey].price = 8.80
        elseif ((theStation.price + aenderung) > 15.815) then
            fuelStations[theKey].price = 8.815
        else
            fuelStations[theKey].price = theStation.price + aenderung
        end

        for theKey, theMarker in ipairs(theStation.pumps) do
            changeElementShowText(theMarker, 0xFFFF00FF, string.format("Tankpreis: %s $/l", fuelStations[theKey].price))
        end

    end

    setTimer(globalTankTimer, 3600000, 1)
end

function setCreateTextDisplayInMinutes()
    setTimer(globalTankTimer, 20000, 1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), setCreateTextDisplayInMinutes)

function TankenMarkerHit(hitElement)
    if (getElementType(hitElement) == "vehicle") then
        if (vioGetElementData(hitElement, "tank") and getVehicleOccupant(hitElement)) then
            local stationID = vioGetElementData(source, "fuelStationID");


            local price = math.round((100 - vioGetElementData(hitElement, "tank")) * fuelStations[stationID].price);
            local frakPrice = 0;

            if (vioGetElementData(hitElement, "frakid")) then
                local frak = vioGetElementData(hitElement, "frakid");
                local satz = fraktanksatz[frak];
                frakPrice = price / 100 * satz;
            end

            local zahlMethode = "Bar";
            local kannTanken = false;
            if (getPlayerMoney(getVehicleOccupant(hitElement)) >= (price - frakPrice)) then
                zahlMethode = "Bar";
                kannTanken = true;
            else
                if (getPlayerBank(getVehicleOccupant(hitElement)) >= (price - frakPrice)) then
                    zahlMethode = "Bank";
                    kannTanken = true;
                else
                    zahlMethode = "Hartz4";
                end
            end

            if (kannTanken) then
                local freezetime = math.round((100 - vioGetElementData(hitElement, "tank")) * 600)
                if (isGoldBoosterActive(getVehicleOccupant(hitElement), "FuelBooster")) then
                    freezetime = math.round(((100 - vioGetElementData(hitElement, "tank")) * 600) / 4)
                end
                outputChatBox("Bitte warte... Das Fahrzeug wird aufgetankt!", getVehicleOccupant(hitElement), 255, 0, 0)
                setElementFrozen(hitElement, true)
                vioSetElementData(hitElement, "isInTankProcedur", true)
                vioSetElementData(hitElement, "motor", false)
                setVehicleEngineState(hitElement, false)
                vioSetElementData(hitElement, "motornum", 0)
                if (vioGetElementData(source, "repairMarker")) then
                    freezetime = freezetime + 5000
                end
                if (freezetime < 1000) then
                    setTankFulTanke(price, hitElement, getVehicleOccupant(hitElement), source, (100 - vioGetElementData(hitElement, "tank")))
                else
                    setTimer(setTankFulTanke, freezetime, 1, price, hitElement, getVehicleOccupant(hitElement), source, (100 - vioGetElementData(hitElement, "tank")))
                end
            else
                if (zahlMethode == "Bar") then
                    outputChatBox(string.format("Du hast leider nicht genug Bargeld!(Preis pro Liter: %s$)", serversettings["tankpreis"]), getVehicleOccupant(hitElement), 255, 0, 0);
                elseif (zahlMethode == "Bank") then
                    outputChatBox(string.format("Du hast leider nicht genug Geld auf der Bank!(Preis pro Liter: %s$)", serversettings["tankpreis"]), getVehicleOccupant(hitElement), 255, 0, 0);
                elseif (zahlMethode == "Hartz4") then
                    outputChatBox(string.format("Du besitzt nicht genug Geld zum bezahlen der Tankrechnung! Ein Tanken wird daher verweigert!(Preis pro Liter: %s$)", serversettings["tankpreis"]), getVehicleOccupant(hitElement), 255, 0, 0);
                end
            end
        end
    end
end

function setTankFulTanke(preis, hitElement, driver, marker, liter)
    if (isElement(hitElement) and isElement(driver) and isPlayerLoggedIn(driver)) then
        vioSetElementData(hitElement, "isInTankProcedur", false);
        vioSetElementData(hitElement, "tank", 100);
        if (vioGetElementData(marker, "repairMarker")) then
            if (getElementHealth(hitElement) < 950) then
                preis = preis + 1000;
                outputChatBox("Das Fahrzeug wurde repariert!", driver, 255, 0, 0);
                fixVehicle(hitElement);
            else
                outputChatBox("Da das Fahrzeug in einem sehr guten Zustand ist, wurde es nicht repariert!", driver, 255, 0, 0);
            end
        end

        local frakPrice = 0;

        if (vioGetElementData(hitElement, "frakid")) then
            local frak = vioGetElementData(hitElement, "frakid");
            local satz = fraktanksatz[frak];
            frakPrice = price / 100 * satz;
            preis = preis - frakPrice;

            frakkasse[frak] = frakkasse[frak] - frakPrice;
            frakdepot_log(frak, 1, -frakPrice, "Frakzeugtank" , "Tankstelle - " .. getPlayerName(driver));
        end

        if (getPlayerMoney(driver) >= preis) then
            changePlayerMoney(driver, -preis, "fahrzeug", "Tanken");
            outputChatBox(string.format("Du hast erfolgreich  %s l für %s (%s $/Liter) getankt!\nDer Preis wurde Bar bezahlt.", math.round(liter, 2), toprice(preis), serversettings["tankpreis"]), driver, 255, 0, 0);
        elseif (getPlayerBank(driver) >= preis) then
            changePlayerBank(driver, ((preis * 1.05) * -1), "fahrzeug", "Tanken");
            outputChatBox(string.format("Du hast erfolgreich  %s l für %s (%s $/Liter) getankt! Der Preis wurde mittels Bankomat bezahlt. Dafuer fallen 5 Prozent Bearbeitungsgebuehren an.", math.round(liter, 2), toprice(preis * 1.05), serversettings["tankpreis"]), driver, 255, 0, 0);
        end
        changeBizKasse(7, preis + frakPrice, "Tank")

        if (vioGetElementData(driver, "Erfolg_Benzin_leer") ~= 1) then
            vioSetElementData(driver, "Erfolg_Benzin_leer", 1)
            triggerClientEvent(driver, "onClientCreatePokalGUI", driver, "Benzin leer", "Gehe das erste Mal tanken")
        end
    end

    if (isElement(hitElement)) then
        setElementFrozen(hitElement, false)
    end
end

