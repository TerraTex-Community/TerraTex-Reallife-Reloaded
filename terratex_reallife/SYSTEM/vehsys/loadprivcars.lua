privVeh = {}

addEvent("setElementCollisionsEnabled_Event", true)
function setElementCollisionsEnabled_Event_func(bool)
    setElementCollisionsEnabled(source, bool)
end

addEventHandler("setElementCollisionsEnabled_Event", getRootElement(), setElementCollisionsEnabled_Event_func)

function loadPrivCars()

    local result = MySql.helper.getSync("user_vehicles", "*");

    for theKey, daSatz in ipairs(result) do
        local theVehicle = createVehicle(daSatz["Model"], daSatz["SpawnX"], daSatz["SpawnY"], daSatz["SpawnZ"], daSatz["SpawnRX"], daSatz["SpawnRY"], daSatz["SpawnRZ"], daSatz["Besitzer"])
        local colors = {}

        if (tonumber(daSatz["Model"]) == 409 and daSatz["Besitzer"] == "[TTeam]Johann") then
            vehicleLightsJohann(theVehicle)
        end

        local counter = 0
        for color = 0, 3, 1 do
            local countlast = counter
            if (color < 3) then
                counter = string.find(daSatz["Colors"], "|", countlast)
                colors[color] = string.sub(daSatz["Colors"], countlast, counter - 1)
            else
                colors[color] = string.sub(daSatz["Colors"], countlast)
            end
            counter = counter + 1
        end
        setVehicleColor(theVehicle, tonumber(colors[0]), tonumber(colors[1]), tonumber(colors[2]), tonumber(colors[3]))
        local tun = daSatz["Tuning"]
        if (tun == "") then
            tun = "0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
        end
        local tuning = getStringComponents(tun)
        for theKey, theTuning in ipairs(tuning) do
            if (theTuning ~= 0) then
                addVehicleUpgrade(theVehicle, theTuning)
            end
        end
        local abgeschleppt = 0
        abgeschleppt = tonumber(daSatz["abgeschleppt"])
        if (tonumber(daSatz["SpawnX"]) == 0 and tonumber(daSatz["SpawnY"]) == 0 and tonumber(daSatz["SpawnZ"]) == 0) and not (abgeschleppt == 1) and not (isDevServer()) then
            abgeschleppt = 1
            local name = "Fahrzeugspawnsystem"
            local nameofCar = daSatz["Besitzer"]
            local message = "Fahrzeugslot " .. daSatz["SlotID"] .. " | Besitzer " .. nameofCar .. " | Abschlepper " .. name
            save_offline_message(daSatz["Besitzer"], "Abschleppsystem", "Dein Fahrzeug im Slot " .. daSatz["SlotID"] .. " wurde abgeschleppt, da es keinen Parkplatz hatte (/park)")

            MySql.helper.update("user_vehicles", { abgeschleppt = 1 }, { ID = daSatz["ID"] });

            log_tow_police(daSatz["SlotID"], nameofCar, name);
        end
        vioSetElementData(theVehicle, "besitzer", daSatz["Besitzer"])
        vioSetElementData(theVehicle, "model", daSatz["Model"])
        vioSetElementData(theVehicle, "dbid", tonumber(daSatz["ID"]))
        vioSetElementData(theVehicle, "slotid", tonumber(daSatz["SlotID"]))
        vioSetElementData(theVehicle, "spawnx", daSatz["SpawnX"])
        vioSetElementData(theVehicle, "spawny", daSatz["SpawnY"])
        vioSetElementData(theVehicle, "spawnz", daSatz["SpawnZ"])
        vioSetElementData(theVehicle, "spawnrx", daSatz["SpawnRX"])
        vioSetElementData(theVehicle, "spawnry", daSatz["SpawnRY"])
        vioSetElementData(theVehicle, "spawnrz", daSatz["SpawnRZ"])
        vioSetElementData(theVehicle, "colors", daSatz["Colors"])
        vioSetElementData(theVehicle, "falter", daSatz["fahrzeugalter"])
        vioSetElementData(theVehicle, "tuning", daSatz["Tuning"])
        vioSetElementData(theVehicle, "paintjob", daSatz["paintjob"])
        vioSetElementData(theVehicle, "tank", tonumber(daSatz["Tank"]))
        vioSetElementData(theVehicle, "kaufpreis", tonumber(daSatz["kaufpreis"]))
        vioSetElementData(theVehicle, "Lichterfarbe", daSatz["Lichterfarbe"])
        vioSetElementData(theVehicle, "no_handel", tonumber(daSatz["no_handel"]))
        vioSetElementData(theVehicle, "kmstand", daSatz["kmstand"])

        setElementHealth(theVehicle, daSatz["lastHealth"]);
        setVehicleDamageParts(theVehicle, fromJSON(daSatz["lastDamageStates"]));

        local position = fromJSON(daSatz["lastPosition"]);

        if position and config["feature.spawnVehiclesToLastPosition"] then
            if position[1] and position[2] and position[3] and (position[1] ~= 0 or position[2] ~= 0 or position[3] ~= 0) then
                setElementPosition(theVehicle, position[1], position[2], position[3])
            end

            if position[4] and position[5] and position[6] and (position[4] ~= 0 or position[5] ~= 0 or position[6] ~= 0) then
                setElementRotation(theVehicle, position[4], position[5], position[6])
            end
        end
        vioSetElementData(theVehicle, "damageAfterFreeze", fromJSON(daSatz["lastDamageStates"]))

        setElementFrozen(theVehicle, true)

        setVehicleDamageProof(theVehicle, true)

        vioSetElementData(theVehicle, "premColor", "-1")

        local lights = getStringComponents(vioGetElementData(theVehicle, "Lichterfarbe"))
        setVehicleHeadLightColor(theVehicle, tonumber(lights[1]), tonumber(lights[2]), tonumber(lights[3]))
        vioSetElementData(theVehicle, "premColor", daSatz["premColors"])
        if (vioGetElementData(theVehicle, "premColor") ~= "-1") then
            local premcolor = getStringComponents(vioGetElementData(theVehicle, "premColor"))
            setVehicleColor(theVehicle, tonumber(premcolor[1]), tonumber(premcolor[2]), tonumber(premcolor[3]), tonumber(premcolor[4]), tonumber(premcolor[5]), tonumber(premcolor[6]))
        end

        setVehiclePaintjob(theVehicle, tonumber(daSatz["paintjob"]))
        setVehiclePrivate(theVehicle, true)

        local vara = daSatz["Besitzer"]
        local slot = daSatz["SlotID"]
        vioSetElementData(theVehicle, "motor", false)
        vioSetElementData(theVehicle, "locked", true)
        if (abgeschleppt == 1) then
            destroyElement(theVehicle)
            table.insert(privVeh, { vara, slot, -2 })
        else
            table.insert(privVeh, { vara, slot, theVehicle })
            vioSetElementData(theVehicle, "abgeschleppt", 0)
        end

    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadPrivCars)

function vehicleLightsJohann (veh)
    setVehicleSirens(veh, 1, -0.800, 3.600, -0.300, 255, 255, 255, 255, 255)     -- vorne L
    setVehicleSirens(veh, 2, -0.900, -3.800, 0.300, 255, 0, 0, 255, 255)            -- hinten L
    setVehicleSirens(veh, 3, 0.900, -3.800, 0.300, 0, 0, 255, 255, 255)            -- hinten R
    setVehicleSirens(veh, 4, -0.100, 1.400, 0.700, 255, 0, 0, 255, 255)            -- Winschutzscheibe L
    setVehicleSirens(veh, 5, 0.100, 1.400, 0.700, 0, 0, 255, 255, 255)            -- Windschutzscheibe R
    setVehicleSirens(veh, 6, 0.100, -2.500, 0.600, 0, 0, 255, 255, 255)            -- Heckscheibe R
    setVehicleSirens(veh, 7, -0.100, -2.500, 0.600, 255, 0, 0, 255, 255)            -- Heckscheibe L
    setVehicleSirens(veh, 8, 0.800, 3.600, -0.300, 255, 255, 255, 255, 255)        -- vorne R
    addVehicleSirens(veh, 8, 2, true, false, false, true)
end

function onVehicleDisableFire(thePlayer)
    if (vioGetElementData(source, "besitzer")) then
        toggleControl(thePlayer, "vehicle_fire", false)
        toggleControl(thePlayer, "vehicle_secondary_fire", false)
    end
end

addEventHandler("onVehicleEnter", getRootElement(), onVehicleDisableFire)

function onVehicleEnableFire(thePlayer)
    toggleControl(thePlayer, "vehicle_fire", true)
    toggleControl(thePlayer, "vehicle_secondary_fire", true)
end

addEventHandler("onVehicleExit", getRootElement(), onVehicleEnableFire)

function save_priv_carsB()
    if isDevServer() then
        return;
    end

    for theKey, thetable in ipairs(privVeh) do
        if (isElement(thetable[3])) then
            local x, y, z = getElementPosition(thetable[3])
            local rx, ry, rz = getElementRotation(thetable[3])
            local position = { x, y, z, rx, ry, rz };

            MySql.helper.update("user_vehicles", {
                Tank = vioGetElementData(thetable[3], "tank"),
                kmstand = vioGetElementData(thetable[3], "kmstand"),
                lastPosition = toJSON(position),
                lastDamageStates = toJSON(getVehicleDamageParts(thetable[3])),
                lastHealth = getElementHealth(thetable[3])
            }, { ID = vioGetElementData(thetable[3], "dbid") });
        end
    end
end

addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), save_priv_carsB)

function save_car(veh)
    if isDevServer() then
        return;
    end

    if not (vioGetElementData(veh, "tuning")) then
        vioSetElementData(veh, "tuning", "0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0")
    end

    MySql.helper.update("user_vehicles", {
        Tuning = vioGetElementData(veh, "tuning"),
        Colors = vioGetElementData(veh, "colors"),
        paintjob = vioGetElementData(veh, "paintjob"),
        Tank = vioGetElementData(veh, "tank"),
        kmstand = vioGetElementData(veh, "kmstand"),
        Lichterfarbe = vioGetElementData(veh, "Lichterfarbe"),
        premColors = vioGetElementData(veh, "premColor"),
        lastDamageStates = toJSON(getVehicleDamageParts(veh)),
        lastHealth = getElementHealth(veh)
    }, { ID = vioGetElementData(veh, "dbid") });
end

function onVehicleExplode_func()
    if (isElement(source)) then
        local passengers = getVehicleOccupants(source)
        for theKey, thePassenger in pairs(passengers) do
            killPed(thePassenger, nil, 63, 255, false)
        end
    end

    if (isVehiclePrivate(source)) then
        if isDevServer() then
            return;
        end

        if vioGetElementData(source, "locked") and isElementFrozen(source) then
            setTimer(respawnVehicle, 10000, 1, source)
            vioSetElementData(source, "motor", false)
            return ;
        end

        MySql.helper.delete("user_vehicles", { ID = vioGetElementData(source, "dbid") });

        for theKey, theTable in ipairs(privVeh) do
            if (theTable[3] == source) then
                table.remove(privVeh, theKey)
            end
        end

        local ownerName = vioGetElementData(source, "besitzer");
        local owner = getPlayerFromName(ownerName)
        local slotId = vioGetElementData(source, "slotid")

        log_car_delete(ownerName, slotId, getElementModel(source), "crash", "system");

        local versicherung = false;
        if (owner) then
            versicherung = vioGetElementData(owner, "versicherung");
        else
            versicherung = MySql.helper.getValueSync("user_data", "versicherung", { Nickname = ownerName});
        end

        local satz = 0.55
        local wert  = vioGetElementData(source, "kaufpreis")

        if (owner) then
            outputChatBox(string.format("Ihr Fahrzeug im Slot %s wurde zerstört", slotId), owner, 255, 0, 0)

            if (versicherung or versicherung == 1) then
                outputChatBox("Eine Versicherung hat ihnen 55% vom Einkaufspreis (" .. toprice(satz * wert) .. ") wieder gutgeschrieben!", owner, 255, 0, 0)
                changePlayerMoney(owner, satz * wert, "fahrzeug", "Versicherungszahlung wegen zerstörten Fahrzeug")
            end

            vioSetElementData(owner, "slot" .. slotId, -1)
        else

            if (versicherung or versicherung == 1) then
                MySql.helper.insert("user_gifts", {
                    Nickname = ownerName,
                    Grund = "Fahrzeugsystem: Eine Versicherung hat ihnen 55%  (" .. toprice(satz * wert) .. ") vom Einkaufspreis wieder gutgeschrieben!",
                    Geld = (wert * satz)
                });
            end

            save_offline_message(ownerName, "Fahrzeugsystem", "Ihr Fahrzeug im Slot " .. slotId .. " wurde zerstört")
        end

        destroyElement(source)
    end
end
addEventHandler("onVehicleExplode", getRootElement(), onVehicleExplode_func)

function onVehicleDamage_func(loss)
    if (isElement(source)) then
        if (vioGetElementData(source, "locked") and isElementFrozen(source)) then
            if (isVehiclePrivate(source)) then
                if not (getVehicleOccupant(source)) then
                    if (getElementHealth(source) > 500) then
                        if (getElementHealth(source) + loss > 1000) then
                            local damageAfterFreeze = vioGetElementData(source, "damageAfterFreeze");
                            setVehicleDamageParts(source, damageAfterFreeze);
                            setTimer(recheckVehicleFreezeDamage, 2000, 1, source, damageAfterFreeze);
                        end
                    end
                end
            end

            local xc, yc, zc = getElementPosition(source)
            vioSetElementData(source, "lastX", xc)
            vioSetElementData(source, "lastY", yc)
            vioSetElementData(source, "lastZ", zc)
            if (getElementHealth(source) < 400) then
                setVehicleEngineState(source, false)
                vioSetElementData(source, "motor", false)
                vioSetElementData(source, "motornum", 0)
            end
        end
    end
end
addEventHandler("onVehicleDamage", getRootElement(), onVehicleDamage_func)

function recheckVehicleFreezeDamage(vehicle, damageAfterFreeze)
    if (isElement(vehicle)) then
        if (vioGetElementData(vehicle, "locked") and isElementFrozen(vehicle)) then
            setVehicleDamageParts(vehicle, damageAfterFreeze);
        end
    end
end

function getElementLastPostion(vehicle)
    return vioGetElementData(source, "lastX"), vioGetElementData(source, "lastY"), vioGetElementData(soruce, "lastZ")
end

function onPlayerQuitVehicle(thePlayer)
    if (isVehiclePrivate(source)) then
        vioSetElementData(source, "lastLeavePlayer", thePlayer)
        if (isTimer(vioGetElementData(source, "lastLeavePlayerTimer"))) then
            killTimer(vioGetElementData(source, "lastLeavePlayerTimer"))
        end
        local timer = setTimer(checkPlayerQuitVehicleOffline, 10000, 1, source)

        vioSetElementData(source, "lastLeavePlayerTimer", timer)
    end
end

addEventHandler("onVehicleStartExit", getRootElement(), onPlayerQuitVehicle)

function checkPlayerQuitVehicleOffline(source)
    if (isElement(source)) then
        local player = vioGetElementData(source, "lastLeavePlayer")
        if (not isElement(player) and not isAnyOneInVehicle(source)) then
            if (getElementHealth(source) < 300) then
                blowVehicle(source, true)
            end
            if (isVehicleOnRoof(source)) then
                blowVehicle(source, true)
            end
        end
    end
end

function checkPlayerQuitVehicleOffline_varianteB()
    if (isPedInVehicle(source)) then
        local vehicle = getPedOccupiedVehicle(source)
        if (not isAnyOneInVehicle(vehicle)) then
            if (getElementHealth(vehicle) < 300) then
                blowVehicle(vehicle, true)
            end
            if (isVehicleOnRoof(vehicle)) then
                blowVehicle(vehicle, true)
            end
        end
    end
end

addEventHandler("onPlayerQuit", getRootElement(), checkPlayerQuitVehicleOffline_varianteB)

function onVehicleRespawn_private(exploded)
    if (isVehiclePrivate(source)) then
        vioSetElementData(source, "locked", true)
        local seats = getVehicleOccupants(source)
        if not (seats[0]) and not (seats[1]) and not (seats[2]) and not (seats[3]) then
            setElementFrozen(source, true)
        end
    end
end
addEventHandler("onVehicleRespawn", getRootElement(), onVehicleRespawn_private)








