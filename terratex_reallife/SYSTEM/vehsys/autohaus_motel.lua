


function clickOnBuyVehicle(button, state, element)
    if (isPlayerLoggedIn(source)) then
        if (button == "left" and state == "down") then
            for theKey, thevehicle in ipairs(autohausVehicles) do
                if (element == thevehicle[1]) then
                    triggerClientEvent(source, "closeAutohausFahrzeugGuiagain", source)
                    triggerClientEvent(source, "showAutohausGui_Event", source, getElementModel(thevehicle[1]), thevehicle[4], thevehicle[2], thevehicle[1])
                end
            end
        end
    end
end

addEventHandler("onPlayerClick", getRootElement(), clickOnBuyVehicle)

function autohaustimer_func(timerid)
    autohaustimer[timerid] = 0
end

function buyCar(thevehicle)
    local freeslots = 0
    local firstfreeslot = 0
    for zah = vioGetElementData(source, "maxslots"), 1, -1 do
        if tonumber(vioGetElementData(source, "slot" .. zah)) == -1 then
            freeslots = freeslots + 1
            firstfreeslot = zah
        end
    end
    if (freeslots == 0) then
        showError(source, "Du hast keinen freien Slot mehr!")
    else
        for theKey, vehicle in ipairs(autohausVehicles) do
            if (vehicle[1] == thevehicle) then
                if (canPlayerHaveVehicle(source, vehicle[4])) then
                    if (hasTheLicenseFor(source, thevehicle)) then
                        if (getPlayerMoney(source) < vehicle[4]) then
                            showError(source, "Du hast nicht genügend Geld!")
                            outputChatBox("Du hast nicht genügend Geld!", source, 255, 0, 0)
                        else
                            changePlayerMoney(source, -vehicle[4], "fahrzeug", "Fahrzeugkauf")
                            local spawnVeh = createVehicle(getElementModel(vehicle[1]), autohausspawns[vehicle[3]][1], autohausspawns[vehicle[3]][2], autohausspawns[vehicle[3]][3], autohausspawns[vehicle[3]][4], autohausspawns[vehicle[3]][5], autohausspawns[vehicle[3]][6])
                            vioSetElementData(source, "slot" .. firstfreeslot, spawnVeh)
                            vioSetElementData(spawnVeh, "besitzer", getPlayerName(source))
                            vioSetElementData(spawnVeh, "slotid", firstfreeslot)
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

                            table.insert(privVeh, { getPlayerName(source), firstfreeslot, spawnVeh })
                            privCars[spawnVeh] = true

                            local dbid = MySql.helper.insertSync("user_vehicles", {
                                SlotID = firstfreeslot,
                                Besitzer = getPlayerName(source),
                                Model = getElementModel(spawnVeh),
                                SpawnX = 0,
                                SpawnY = 0,
                                SpawnZ = 0,
                                SpawnRX = 0,
                                SpawnRY = 0,
                                SpawnRZ = 0,
                                Colors = "0|0|0|0",
                                kaufpreis = vehicle[4]
                            });

                            --                            outputDebugString("Buyed Car dbid:" .. tostring(dbid))
                            vioSetElementData(spawnVeh, "dbid", dbid)
                            warpPedIntoVehicle(source, spawnVeh)
                            showError(source, "Du hast dieses Fahrzeug erfolgreich gekauft! Bitte parke es auf einen PARKPLATZ Reallife mäßig mit /park. Parkst du es nicht wird es an den Koordinaten 0 0 0 spawnen und eventuell gelöscht!")
                            outputChatBox("Du hast dieses Fahrzeug erfolgreich gekauft! Bitte parke es auf einen PARKPLATZ Reallife mäßig mit /park.", source, 255, 0, 0)
                            outputChatBox("Parkst du es nicht wird es an den Koordinaten 0 0 0 spawnen und eventuell gelöscht!", source, 255, 0, 0)
                            if (vioGetElementData(source, "Erfolg_Autoeinsteiger") ~= 1) then
                                vioSetElementData(source, "Erfolg_Autoeinsteiger", 1)
                                triggerClientEvent(source, "onClientCreatePokalGUI", source, "Autoeinsteiger", "Kaufe ein Auto!")
                            end
                        end
                    else
                        showError(source, "Du hast nicht die nötigen Lizensen!")
                    end
                else
                    showError(source, "Dieses Fahrzeug kostet mehr als dein Lebensstandard hergibt.")
                end
            end
        end
    end

    local freeslots = 0
    local firstfreeslot = 0
    for zah = vioGetElementData(source, "maxslots"), 1, -1 do
        if tonumber(vioGetElementData(source, "slot" .. zah)) == -1 then
            freeslots = freeslots + 1
            firstfreeslot = zah
        end
    end
    if ((vioGetElementData(source, "maxslots") - (freeslots - 1)) > 10) then
        if (vioGetElementData(source, "Erfolg_10erFahrzeugrausch") ~= 1) then
            vioSetElementData(source, "Erfolg_10erFahrzeugrausch", 1)
            triggerClientEvent(source, "onClientCreatePokalGUI", source, "10er Fahrzeugrausch", "Besitze 10 Fahrzeuge!")
        end
    end
    if ((vioGetElementData(source, "maxslots") - (freeslots - 1)) > 15) then
        if (vioGetElementData(source, "Erfolg_20erFahrzeugrausch") ~= 1) then
            vioSetElementData(source, "Erfolg_20erFahrzeugrausch", 1)
            triggerClientEvent(source, "onClientCreatePokalGUI", source, "15er Fahrzeugrausch", "Besitze 15 Fahrzeuge!")
        end
    end
    if ((vioGetElementData(source, "maxslots") - (freeslots - 1)) > 20) then
        if (vioGetElementData(source, "Erfolg_50erFahrzeugrausch") ~= 1) then
            vioSetElementData(source, "Erfolg_50erFahrzeugrausch", 1)
            triggerClientEvent(source, "onClientCreatePokalGUI", source, "20er Fahrzeugrausch", "Besitze 20 Fahrzeuge!")
        end
    end
end

addEvent("buyCar_Event", true)
addEventHandler("buyCar_Event", getRootElement(), buyCar)


