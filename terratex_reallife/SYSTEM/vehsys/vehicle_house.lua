--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 10.05.14
-- Time: 14:06
-- To change this template use File | Settings | File Templates.
--

function getMaxVehicleWert(houseID)
    if (not houseID) then
        houseID = 0;
    end

    local hrid = houseID
    local hid = math.abs(houseID)

    if (hid == 0) then
        return 3320
    else
        local haus = haeuser[hid]
        local hwert = haus:getPreis()
        if (hrid < 0) then
            hwert = hwert * 0.75
        end

        if (hwert > 1000000) then
            return 1000000000
        end

        local vWert = 0.2638 * hwert + 3320
        return vWert
    end
end

function canPlayerHaveVehicle(thePlayer, vWert)
    local hrid = vioGetElementData(thePlayer, "hkey")
    local maxVWert = getMaxVehicleWert(hrid)
    if (vWert > maxVWert and config["feature.stardard_of_living"]) then
        return false
    else
        return true
    end
end

function stealTooExpensiveVehicles()
    if (not config["feature.stardard_of_living"]) then
        return
    end
    setTimer(stealTooExpensiveVehicles, (4 * 60 * 60 * 1000), 1)

    local allVehicles = getElementsByType("vehicle")
    for theKey, theVehicle in ipairs(allVehicles) do
        if (isVehiclePrivate(theVehicle)) then
            local buyWert = vioGetElementData(theVehicle, "kaufpreis")
            local besitzer = vioGetElementData(theVehicle, "besitzer")
            local player = getPlayerFromName(besitzer)
            local hkey = 0
            if (player) then
                hkey = vioGetElementData(player, "hkey")
            else
                hkey = MySql.helper.getValueSync("user_data", "newhkey", { Nickname = besitzer });
            end
            local maxWert = getMaxVehicleWert(hkey)
            if (buyWert > maxWert) then
                if (math.random(1, 4) == 2) then
                    if (player) then
                        outputChatBox(string.format("Dein Fahrzeug im Slot %s wurde von der Polizei nach einem Diebstahl gefunden.", vioGetElementData(theVehicle, "slotid")), player, 255, 0, 0)
                        vioSetElementData(player, "slot" .. vioGetElementData(theVehicle, "slotid"), -2)
                    else
                        save_offline_message(besitzer, "Abschleppsystem", string.format("Dein Fahrzeug im Slot %s wurde von der Polizei nach einem Diebstahl gefunden.", vioGetElementData(theVehicle, "slotid")))
                    end
                    save_car(theVehicle)

                    log_tow_police(vioGetElementData(theVehicle, "slotid"), nameofCar, "Diebstahl wegen zuviel Wert");

                    MySql.helper.update("user_vehicles", {
                        SpawnX = 0,
                        SpawnY = 0,
                        SpawnZ = 0,
                        SpawnRX = 0,
                        SpawnRY = 0,
                        SpawnRZ = 0,
                        abgeschleppt = 1,
                        lastDamageStates = toJSON(getVehicleDamageParts(theVehicle)),
                        lastHealth = getElementHealth(theVehicle)
                    }, { ID = vioGetElementData(theVehicle, "dbid") });

                    for theKey, theTable in ipairs(privVeh) do
                        if (theTable[3] == source) then
                            table.remove(privVeh, theKey)
                        end
                    end

                    table.insert(privVeh, { besitzer, vioGetElementData(theVehicle, "slotid"), -2 })
                    destroyElement(theVehicle)
                end
            end
        end
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), stealTooExpensiveVehicles)
