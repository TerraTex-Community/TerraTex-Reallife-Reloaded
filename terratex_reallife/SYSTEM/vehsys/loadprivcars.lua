privVeh = {}

addEvent("setElementCollisionsEnabled_Event", true)
function setElementCollisionsEnabled_Event_func(bool)
    setElementCollisionsEnabled(source, bool)
end

addEventHandler("setElementCollisionsEnabled_Event", getRootElement(), setElementCollisionsEnabled_Event_func)

function loadPrivCars()

    local result = MySql.helper.getSync("user_vehicles", "*");

    for theKey, dasatz in ipairs(result) do
        local thevehicle = createVehicle(dasatz["Model"], dasatz["SpawnX"], dasatz["SpawnY"], dasatz["SpawnZ"], dasatz["SpawnRX"], dasatz["SpawnRY"], dasatz["SpawnRZ"], dasatz["Besitzer"])
        local colors = {}

        if (tonumber(dasatz["Model"]) == 409 and dasatz["Besitzer"] == "[TTeam]Johann") then
            vehicleLightsJohann(thevehicle)
        end

        local counter = 0
        for color = 0, 3, 1 do
            local countlast = counter
            if (color < 3) then
                counter = string.find(dasatz["Colors"], "|", countlast)
                colors[color] = string.sub(dasatz["Colors"], countlast, counter - 1)
            else
                colors[color] = string.sub(dasatz["Colors"], countlast)
            end
            counter = counter + 1
        end
        setVehicleColor(thevehicle, tonumber(colors[0]), tonumber(colors[1]), tonumber(colors[2]), tonumber(colors[3]))
        local tun = dasatz["Tuning"]
        if (tun == "") then
            tun = "0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
        end
        local tuning = getStringComponents(tun)
        for theKey, theTuning in ipairs(tuning) do
            if (theTuning ~= 0) then
                addVehicleUpgrade(thevehicle, theTuning)
            end
        end
        local abgeschleppt = 0
        abgeschleppt = tonumber(dasatz["abgeschleppt"])
        if (tonumber(dasatz["SpawnX"]) == 0 and tonumber(dasatz["SpawnY"]) == 0 and tonumber(dasatz["SpawnZ"]) == 0) and not (abgeschleppt == 1) and not (isDevServer()) then
            abgeschleppt = 1
            local name = "Fahrzeugspawnsystem"
            local nameofCar = dasatz["Besitzer"]
            local message = "Fahrzeugslot " .. dasatz["SlotID"] .. " | Besitzer " .. nameofCar .. " | Abschlepper " .. name
            save_offline_message(dasatz["Besitzer"], "Abschleppsystem", "Dein Fahrzeug im Slot " .. dasatz["SlotID"] .. " wurde abgeschleppt, da es keinen Parkplatz hatte (/park)")

            MySql.helper.update("user_vehicles", { abgeschleppt = 1 }, { ID = dasatz["ID"] });

            log_tow_police(dasatz["SlotID"], nameofCar, name);
        end
        vioSetElementData(thevehicle, "besitzer", dasatz["Besitzer"])
        vioSetElementData(thevehicle, "model", dasatz["Model"])
        vioSetElementData(thevehicle, "dbid", tonumber(dasatz["ID"]))
        vioSetElementData(thevehicle, "slotid", tonumber(dasatz["SlotID"]))
        vioSetElementData(thevehicle, "spawnx", dasatz["SpawnX"])
        vioSetElementData(thevehicle, "spawny", dasatz["SpawnY"])
        vioSetElementData(thevehicle, "spawnz", dasatz["SpawnZ"])
        vioSetElementData(thevehicle, "spawnrx", dasatz["SpawnRX"])
        vioSetElementData(thevehicle, "spawnry", dasatz["SpawnRY"])
        vioSetElementData(thevehicle, "spawnrz", dasatz["SpawnRZ"])
        vioSetElementData(thevehicle, "colors", dasatz["Colors"])
        vioSetElementData(thevehicle, "falter", dasatz["fahrzeugalter"])
        vioSetElementData(thevehicle, "tuning", dasatz["Tuning"])
        vioSetElementData(thevehicle, "paintjob", dasatz["paintjob"])
        vioSetElementData(thevehicle, "tank", tonumber(dasatz["Tank"]))
        vioSetElementData(thevehicle, "kaufpreis", tonumber(dasatz["kaufpreis"]))
        vioSetElementData(thevehicle, "Lichterfarbe", dasatz["Lichterfarbe"])
        vioSetElementData(thevehicle, "no_handel", tonumber(dasatz["no_handel"]))
        vioSetElementData(thevehicle, "kmstand", dasatz["kmstand"])

        setElementHealth(thevehicle, dasatz["lastHealth"]);
        setVehicleDamageParts(thevehicle, fromJSON(dasatz["lastDamageStates"]));

        local position = fromJSON(dasatz["lastPosition"]);

        if position and config["feature.spawnVehiclesToLastPosition"] then
            if position[1] and position[2] and position[3] and (position[1] ~= 0 or position[2] ~= 0 or position[3] ~= 0) then
                setElementPosition(thevehicle, position[1], position[2], position[3])
            end

            if position[4] and position[5] and position[6] and (position[4] ~= 0 or position[5] ~= 0 or position[6] ~= 0) then
                setElementRotation(thevehicle, position[4], position[5], position[6])
            end
        end
        vioSetElementData(thevehicle, "damageAfterFreeze", fromJSON(dasatz["lastDamageStates"]))

        setElementFrozen(thevehicle, true)

        setVehicleDamageProof(thevehicle, true)

        vioSetElementData(thevehicle, "premColor", "-1")

        local lights = getStringComponents(vioGetElementData(thevehicle, "Lichterfarbe"))
        setVehicleHeadLightColor(thevehicle, tonumber(lights[1]), tonumber(lights[2]), tonumber(lights[3]))
        vioSetElementData(thevehicle, "premColor", dasatz["premColors"])
        if (vioGetElementData(thevehicle, "premColor") ~= "-1") then
            local premcolor = getStringComponents(vioGetElementData(thevehicle, "premColor"))
            setVehicleColor(thevehicle, tonumber(premcolor[1]), tonumber(premcolor[2]), tonumber(premcolor[3]), tonumber(premcolor[4]), tonumber(premcolor[5]), tonumber(premcolor[6]))
        end

        setVehiclePaintjob(thevehicle, tonumber(dasatz["paintjob"]))
        setVehiclePrivate(thevehicle, true)

        local vara = dasatz["Besitzer"]
        local slot = dasatz["SlotID"]
        vioSetElementData(thevehicle, "motor", false)
        vioSetElementData(thevehicle, "locked", true)
        if (abgeschleppt == 1) then
            destroyElement(thevehicle)
            table.insert(privVeh, { vara, slot, -2 })
        else
            table.insert(privVeh, { vara, slot, thevehicle })
            vioSetElementData(thevehicle, "abgeschleppt", 0)
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
    --    outputDebugString("Started Cars Saving")
    if not (fileExists(":" .. getResourceName(getThisResource()) .. "/devmode.dev")) then
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
    --    outputDebugString("Cars saved!")
end

addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), save_priv_carsB)

function save_car(veh)
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








