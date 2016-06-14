privCars = {}
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
        if (tonumber(dasatz["SpawnX"]) == 0 and tonumber(dasatz["SpawnY"]) == 0 and tonumber(dasatz["SpawnZ"]) == 0) and not (abgeschleppt == 1) then
            abgeschleppt = 1
            local name = "Fahrzeugspawnsystem"
            local nameofCar = dasatz["Besitzer"]
            local message = "Fahrzeugslot " .. dasatz["SlotID"] .. " | Besitzer " .. nameofCar .. " | Abschlepper " .. name
            save_offline_message(dasatz["Besitzer"], "Abschleppsystem", "Dein Fahrzeug im Slot " .. dasatz["SlotID"] .. " wurde abgeschleppt, da es keinen Parkplatz hatte (/park)")

            MySql.helper.update("user_vehicles", {abgeschleppt = 1}, {ID = dasatz["ID"]});

            local times = getRealTime()
            local logtext = "[" .. times.monthday .. "." .. (times.month + 1) .. "." .. (times.year + 1900) .. " - " .. times.hour .. ":" .. times.minute .. ":" .. times.second .. "] " .. name .. ": " .. message
            save_log("abschlepp", logtext)
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
        setElementFrozen(thevehicle, true)

        vioSetElementData(thevehicle, "premColor", "-1")
        local time = getRealTime()
        if (tonumber(MySql.helper.getValueSync("user_premium", "PremiumUntil", { Name = dasatz["Besitzer"] }))) then

            local premiumOutTime = MySql.helper.getValueSync("user_premium", "PremiumUntil", { Name = dasatz["Besitzer"] }) - time.timestamp;
            if (premiumOutTime > 0) then
                local lights = getStringComponents(vioGetElementData(thevehicle, "Lichterfarbe"))
                setVehicleHeadLightColor(thevehicle, tonumber(lights[1]), tonumber(lights[2]), tonumber(lights[3]))
                vioSetElementData(thevehicle, "premColor", dasatz["premColors"])
                if (vioGetElementData(thevehicle, "premColor") ~= "-1") then
                    local premcolor = getStringComponents(vioGetElementData(thevehicle, "premColor"))
                    setVehicleColor(thevehicle, tonumber(premcolor[1]), tonumber(premcolor[2]), tonumber(premcolor[3]), tonumber(premcolor[4]), tonumber(premcolor[5]), tonumber(premcolor[6]))
                end
            else
                vioSetElementData(thevehicle, "Lichterfarbe", "255|255|255")
            end
        else
            save_log("veh_dberror", tostring(dasatz["Besitzer"]) .. "\n")
        end
        setVehiclePaintjob(thevehicle, tonumber(dasatz["paintjob"]))
        privCars[thevehicle] = true
        local vara = dasatz["Besitzer"]
        local slot = dasatz["SlotID"]
        vioSetElementData(thevehicle, "motor", false)
        vioSetElementData(thevehicle, "locked", true)
        if (abgeschleppt == 1) then
            privCars[thevehicle] = false
            destroyElement(thevehicle)
            table.insert(privVeh, { vara, slot, -2 })
        else
            table.insert(privVeh, { vara, slot, thevehicle })
            vioSetElementData(thevehicle, "abgeschleppt", 0)
        end
    end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadPrivCars)

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
    outputDebugString("Started Cars Saving")
    if not (fileExists(":" .. getResourceName(getThisResource()) .. "/devmode.dev")) then
        for theKey, thetable in ipairs(privVeh) do
            if (isElement(thetable[3])) then
                MySql.helper.update("user_vehicles", { Tank = vioGetElementData(thetable[3], "tank") }, { ID = vioGetElementData(thetable[3], "dbid") });
                MySql.helper.update("user_vehicles", { kmstand = vioGetElementData(thetable[3], "kmstand") }, { ID = vioGetElementData(thetable[3], "dbid") });
            end
        end
    end
    outputDebugString("Cars saved!")
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
        premColors = vioGetElementData(veh, "premColor")
    }, {ID = vioGetElementData(veh, "dbid")});

end

function onvehicleexplode_func()
    setTimer(onvehicleexplode_exec, 3000, 1, source)
end
addEventHandler("onVehicleExplode", getRootElement(), onvehicleexplode_func)

function onvehicleexplode_exec(source)
    if (isElement(source)) then
        local passengers = getVehicleOccupants(source)
        for theKey, thePassenger in pairs(passengers) do
            killPed(thePassenger, nil, 63, 255, false)
        end
    end

    if (privCars[source]) then
        if (getPlayerFromName(vioGetElementData(source, "besitzer"))) then
            local xc, yc, zc = getElementPosition(source)
            local PlayerEle = getPlayerFromName(vioGetElementData(source, "besitzer"))
            local xp, yp, zp = getElementPosition(PlayerEle)
            local dis = getDistanceBetweenPoints3D(xc, yc, zc, xp, yp, zp)
            if (dis < 50) then

                MySql.helper.delete("user_vehicles", {ID = vioGetElementData(source, "dbid")});
                local besitzer = getPlayerFromName(vioGetElementData(source, "besitzer"))

                for theKey, theTable in ipairs(privVeh) do
                    if (theTable[3] == source) then
                        table.remove(privVeh, theKey)
                    end
                end

                local versicherung = vioGetElementData(besitzer, "versicherung")
                outputChatBox(string.format("Ihr Fahrzeug im Slot %s wurde zerstört", vioGetElementData(source, "slotid")), besitzer, 255, 0, 0)
                if (versicherung == 1 or vioGetElementData(besitzer, "premium") > 0) then
                    local satz = 0
                    local wert = 0
                    local mitPremium = false
                    local mitVersicherung = false
                    --Premium? setze Satz
                    if (vioGetElementData(besitzer, "premium") > 0) then
                        if (versicherung == 1) then
                            satz = 0.75
                            mitVersicherung = true
                        else
                            satz = 0.25
                            mitVersicherung = false
                        end
                        mitPremium = true
                    else
                        satz = 0.25
                        mitVersicherung = true
                    end
                    --WERT?
                    if (not (vioGetElementData(source, "kaufpreis")) == 0) then
                        local vehmod = getElementModel(source)
                        for theKey, theVehicle in ipairs(autohausVehicles) do
                            if (getElementModel(theVehicle[1]) == vehmod) then
                                wert = theVehicle[4]
                            end
                        end
                    else
                        wert = vioGetElementData(source, "kaufpreis")
                    end
                    --Ausgabe und Auszahlung
                    if (mitPremium and mitVersicherung) then
                        outputChatBox("Eine Versicherung hat ihnen 75% vom Einkaufspreis wieder gutgeschrieben!", besitzer, 255, 0, 0)
                    else
                        outputChatBox("Eine Versicherung hat ihnen 25% vom Einkaufspreis wieder gutgeschrieben!", besitzer, 255, 0, 0)
                    end
                    changePlayerMoney(besitzer, satz * wert, "fahrzeug", "Versicherungszahlung wegen zerstörten Fahrzeug")
                end
                vioSetElementData(besitzer, "slot" .. vioGetElementData(source, "slotid"), -1)
                destroyElement(source)
                privCars[source] = nil
            else
                setTimer(respawnVehicle, 10000, 1, source)
                vioSetElementData(source, "motor", false)
            end
        elseif (spawnDiscconectPlayers[vioGetElementData(source, "besitzer")]) then
            local xc, yc, zc = getElementPosition(source)
            local dis = getDistanceBetweenPoints3D(xc, yc, zc, spawnDiscconectPlayers[vioGetElementData(source, "besitzer")][1], spawnDiscconectPlayers[vioGetElementData(source, "besitzer")][2], spawnDiscconectPlayers[vioGetElementData(source, "besitzer")][3])
            if (dis < 50) then
                MySql.helper.delete("user_vehicles", {ID = vioGetElementData(source, "dbid")});

                local besitzer = getPlayerFromName(vioGetElementData(source, "besitzer"))

                for theKey, theTable in ipairs(privVeh) do
                    if (theTable[3] == source) then
                        table.remove(privVeh, theKey)
                    end
                end
                save_offline_message(vioGetElementData(source, "besitzer"), "Fahrzeugsystem", "Ihr Fahrzeug im Slot " .. vioGetElementData(source, "slotid") .. " wurde zerstört")
                local time = getRealTime()
                local premium = MySql.helper.getValueSync("user_premium", "PremiumUntil", { Name = vioGetElementData(source, "besitzer") }) - time.timestamp;
                local versicherung = MySql.helper.getValueSync("user_data", "versicherung", { Nickname = vioGetElementData(source, "besitzer") });

                if (versicherung == 1 or premium > 0) then
                    local satz = 0
                    local wert = 0
                    local mitPremium = false
                    local mitVersicherung = false
                    --Premium? setze Satz
                    if (premium) then
                        if (versicherung == 1) then
                            satz = 0.75
                            mitVersicherung = true
                        else
                            satz = 0.25
                            mitVersicherung = false
                        end
                        mitPremium = true
                    else
                        satz = 0.25
                        mitVersicherung = true
                    end
                    --WERT?
                    if (not (vioGetElementData(source, "kaufpreis")) == 0) then
                        local vehmod = getElementModel(source)
                        for theKey, theVehicle in ipairs(autohausVehicles) do
                            if (getElementModel(theVehicle[1]) == vehmod) then
                                wert = theVehicle[4]
                            end
                        end
                    else
                        wert = vioGetElementData(source, "kaufpreis")
                    end
                    --Ausgabe und Auszahlung
                    MySql.helper.insert("user_gifts", {
                        Nickname = vioGetElementData(source, "besitzer"),
                        Grund = "Fahrzeugsystem: Eine Versicherung hat ihnen " .. math.round(satz * 100) .. "% vom Einkaufspreis wieder gutgeschrieben!",
                        Geld = (wert * satz)
                    });
                end
                destroyElement(source)
                privCars[source] = nil
            else
                setTimer(respawnVehicle, 10000, 1, source)
                vioSetElementData(source, "motor", false)
            end
        else
            setTimer(respawnVehicle, 10000, 1, source)
            vioSetElementData(source, "motor", false)
        end
    end
end

function onVehicleDamage_func(loss)
    if (isElement(source)) then
        if (privCars[source]) then
            if not (getVehicleOccupant(source)) then
                if (getElementHealth(source) > 500) then
                    if (getElementHealth(source) + loss > 1000) then
                        setElementHealth(source, 1000)
                    else
                        setElementHealth(source, getElementHealth(source) + loss)
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

addEventHandler("onVehicleDamage", getRootElement(), onVehicleDamage_func)

function getElementLastPostion(vehicle)
    return vioGetElementData(source, "lastX"), vioGetElementData(source, "lastY"), vioGetElementData(soruce, "lastZ")
end


function onPlayerQuitVehicle(thePlayer)
    if (privCars[source]) then
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

    if (privCars[source]) then
        vioSetElementData(source, "locked", true)
        local seats = getVehicleOccupants(source)
        if not (seats[0]) and not (seats[1]) and not (seats[2]) and not (seats[3]) then
            setElementFrozen(source, true)
        end
    end
end

addEventHandler("onVehicleRespawn", getRootElement(), onVehicleRespawn_private)








