function vehinfos_func(thePlayer)
    outputChatBox("Ihre Fahrzeuge: ", thePlayer, 255, 255, 0)
    if (vioGetElementData(thePlayer, "maxslots")) then
        for zah = 1, vioGetElementData(thePlayer, "maxslots"), 1 do
            if (vioGetElementData(thePlayer, "slot" .. zah)) then
                if not (tonumber(vioGetElementData(thePlayer, "slot" .. zah)) == -1) then
                    if (tonumber(vioGetElementData(thePlayer, "slot" .. zah)) == -2) then
                        outputChatBox(string.format("Slot %s: Dieses Fahrzeug wurde abgeschleppt und muss am PD abgeholt werden!", zah), thePlayer, 255, 0, 0)
                    else
                        local vehname = getVehicleNameFromModel(getElementModel(vioGetElementData(thePlayer, "slot" .. zah)))
                        if (vehname) then
                            outputChatBox(string.format("Slot %s: %s (%s)", zah, vehname, getElementZoneName(vioGetElementData(thePlayer, "slot" .. zah))), thePlayer, 255, 255, 0)
                        else
                            outputChatBox(string.format("Slot %s: Dieses Fahrzeug muss erst mit /towveh respawned werden!", zah), thePlayer, 255, 0, 0)
                        end
                    end
                end
            end
        end
    end
end

addCommandHandler("vehinfos", vehinfos_func, false, false)

function eject_func(thePlayer, cmd, toNamePart)
    if (isPedInVehicle(thePlayer)) then
        if (getPedOccupiedVehicleSeat(thePlayer) == 0) then
            local toPlayer = getPlayerFromIncompleteName(toNamePart)
            if (toPlayer) then
                if not (toPlayer == thePlayer) then
                    if (isPedInVehicle(toPlayer)) then
                        if (getPedOccupiedVehicle(thePlayer) == getPedOccupiedVehicle(toPlayer)) then
                            ejectPed(toPlayer)
                            showError(toPlayer, string.format("Du wurdest von %s aus dem Fahrzeug geworfen!", getPlayerName(thePlayer)))
                            showError(thePlayer, string.format("Du hast %s aus dem Fahrzeug geworfen!", getPlayerName(toPlayer)))
                        else
                            showError(thePlayer, "Dieser Spieler ist nicht in deinen Fahrzeug!")
                        end
                    else
                        showError(thePlayer, "Dieser Spieler ist nicht in deinen Fahrzeug!")
                    end
                end
            end
        end
    end
end

addCommandHandler("eject", eject_func, false, false)

function carfind_func(thePlayer, command, vehslot)
    if (vioGetElementData(thePlayer, "carfinder") > 0) then
        local SlotID = tonumber(vehslot)
        if (SlotID) then
            if not (vioGetElementData(thePlayer, "slot" .. SlotID) == nil) then
                if (not (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID)) == -1)) then
                    if (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID)) == -2) then
                        outputChatBox("Dieses Fahrzeug wurde abgeschleppt und muss am PD abgeholt werden!", thePlayer, 255, 0, 0)
                    else
                        if (isElement(vioGetElementData(thePlayer, "slot" .. SlotID))) then
                            local vx, vy, vz = getElementPosition(vioGetElementData(thePlayer, "slot" .. SlotID))
                            local blip = createBlipAttachedTo(vioGetElementData(thePlayer, "slot" .. SlotID), 0, 2, 0, 255, 0, 255, 0, 99999.0, thePlayer)
                            setTimer(killCarFinderBlip, 60000, 1, blip)
                            vioSetElementData(thePlayer, "usecarfinder", vioGetElementData(thePlayer, "usecarfinder") + 1)
                            showError(thePlayer, "Der CarFinder hat dein Fahrzeug erfolgreich geortet. Es ist der grüne Marker!")
                            if (vioGetElementData(thePlayer, "usecarfinder") > 10) then
                                vioSetElementData(thePlayer, "carfinder", vioGetElementData(thePlayer, "carfinder") - 1)
                                vioSetElementData(thePlayer, "usecarfinder", 0)
                                showError(thePlayer, "Der CarFinder hat soeben den Geistaufgegeben!")
                            end
                        else
                            outputChatBox("Bitte Respawne dein Fahrzeug vorher!", thePlayer, 255, 0, 0)
                        end
                    end
                end
            end
        end
    else
        showError(thePlayer, "Du besitzt kein CarFinder")
    end
end

addCommandHandler("carfind", carfind_func, false, false)

function killCarFinderBlip(theBlip)
    destroyElement(theBlip)
end

local noparkingcolA = createColRectangle(1696.6806640625, -1871.541015625, 114.667, 32.6465)
local noparkingcolB = createColRectangle(1511.7666015625, -1727.755859375, 36, 129)

function park_func(thePlayer)
    if (isElementWithinColShape(thePlayer, noparkingcolA) or isElementWithinColShape(thePlayer, noparkingcolB) or isInRuheZone(thePlayer)) then
        outputChatBox("Hier ist Parkverbot! Du kannst hier nicht parken!", thePlayer, 255, 0, 0)
    else
        local theVehicle = getPedOccupiedVehicle(thePlayer)
        local wasin = 0
        if (theVehicle) then
            for zah = 1, getElementData(thePlayer, "maxslots"), 1 do
                if not (tonumber(getElementData(thePlayer, "slot" .. zah)) == -1) then
                    if (getElementData(thePlayer, "slot" .. zah) == theVehicle) then
                        wasin = 1
                        local spawnx, spawny, spawnz = getElementPosition(theVehicle)
                        local spawnrx, spawnry, spawnrz = getVehicleRotation(theVehicle)
                        local colora, colorb, colorc, colord = getVehicleColor(theVehicle)
                        local colors = colora .. "|" .. colorb .. "|" .. colorc .. "|" .. colord
                        vioSetElementData(theVehicle, "spawnx", spawnx)
                        vioSetElementData(theVehicle, "spawny", spawny)
                        vioSetElementData(theVehicle, "spawnz", spawnz)
                        vioSetElementData(theVehicle, "spawnrx", spawnrx)
                        vioSetElementData(theVehicle, "spawnry", spawnry)
                        vioSetElementData(theVehicle, "spawnrz", spawnrz)
                        vioSetElementData(theVehicle, "colors", colors)
                        vioSetElementData(theVehicle, "abgeschleppt", 0)

                        MySql.helper.update("user_vehicles", {
                            SpawnX = spawnx,
                            SpawnY = spawny,
                            SpawnZ = spawnz,
                            SpawnRX = spawnrx,
                            SpawnRY = spawnry,
                            SpawnRZ = spawnrz
                        }, { ID = vioGetElementData(theVehicle, "dbid") });

                        showError(thePlayer, "Dein Fahrzeug wurde erfolgreich an dieser Position geparkt!")
                    end
                end
            end
        else
            showError(thePlayer, "Du bist nicht in deinen Privatfahrzeug!")
        end
        if (wasin == 0) then
            showError(thePlayer, "Du bist nicht in deinen Privatfahrzeug!")
        end
    end
end

addCommandHandler("park", park_func, false, false)

function lock_func(thePlayer, Command, SloteID)
    if (isPlayerLoggedIn(thePlayer)) then
        local SlotID = tonumber(SloteID)
        if (SlotID) then
            if not (vioGetElementData(thePlayer, "slot" .. SlotID) == nil) then
                if (not (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID)) == -1)) then
                    if (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID)) == -2) then
                        outputChatBox("Dieses Fahrzeug wurde abgeschleppt und muss am PD abgeholt werden!", thePlayer, 255, 0, 0)
                    else
                        if (isElement(vioGetElementData(thePlayer, "slot" .. SlotID))) then
                            local lockedstate = vioGetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "locked")
                            if (lockedstate) then
                                vioSetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "locked", false)
                                showError(thePlayer, "Du hast das Fahrzeug erfolgreich aufgeschlossen!")
                                if (isElementFrozen(vioGetElementData(thePlayer, "slot" .. SlotID))) then
                                    setElementFrozen(vioGetElementData(thePlayer, "slot" .. SlotID), false)
                                    setVehicleDamageProof(vioGetElementData(thePlayer, "slot" .. SlotID), false)
                                end
                            else
                                vioSetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "locked", true)
                                showError(thePlayer, "Du hast das Fahrzeug erfolgreich abgeschlossen!")
                                seats = getVehicleOccupants(vioGetElementData(thePlayer, "slot" .. SlotID))
                                if not (seats[0]) and not (seats[1]) and not (seats[2]) and not (seats[3]) then
                                    setElementFrozen(vioGetElementData(thePlayer, "slot" .. SlotID), true)
                                    vioSetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "damageAfterFreeze", getVehicleDamageParts(vioGetElementData(thePlayer, "slot" .. SlotID)))

                                    setVehicleDamageProof(vioGetElementData(thePlayer, "slot" .. SlotID), true)
                                end
                            end
                        else
                            outputChatBox("Respawne das Fahrzeug vorher!", thePlayer, 255, 0, 0)
                        end
                    end
                end
            end
        end
    end
end

addCommandHandler("lock", lock_func, false, false)

function towveh_func(thePlayer, command, SloteID)
    local price = 5000
    if (vioGetElementData(thePlayer, "playtime") < 51 * 60) then
        price = price / 10
    end
    local SlotID = tonumber(SloteID)
    if (SlotID) then
        if (vioGetElementData(thePlayer, "slot" .. SlotID)) then
            if (not (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID)) == -1)) then
                if (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID)) == -2) then
                    outputChatBox("Dieses Fahrzeug wurde abgeschleppt und muss am PD abgeholt werden!", thePlayer, 255, 0, 0)
                else
                    if (isElement(vioGetElementData(thePlayer, "slot" .. SlotID))) then
                        local theVehicle = vioGetElementData(thePlayer, "slot" .. SlotID)
                        if not (isAnyOneInVehicle(theVehicle)) then
                            outputChatBox(getElementID(theVehicle), getRootElement())
                            if ((not isElementInWater(theVehicle)) or getVehicleType(theVehicle) == "Boat" or tonumber(getElementModel(theVehicle)) == 539) then
                                if (getElementHealth(theVehicle) > 300) then
                                    if (getPlayerMoney(thePlayer) < price) then
                                        showError(thePlayer, string.format("Du hast nicht genügend Geld bei dir. Ein Respawn des Fahrzeugs kostet %s", toprice(price)))
                                    else
                                        setElementPosition(theVehicle, vioGetElementData(theVehicle, "spawnx"), vioGetElementData(theVehicle, "spawny"), vioGetElementData(theVehicle, "spawnz"))
                                        setElementRotation(theVehicle, vioGetElementData(theVehicle, "spawnrx"), vioGetElementData(theVehicle, "spawnry"), vioGetElementData(theVehicle, "spawnrz"))
                                        showError(thePlayer, "Das Fahrzeug wurde erfolgreich respawned!")
                                        changePlayerMoney(thePlayer, -price, "fahrzeug", "Fahrzeugrespawn")
                                    end
                                else
                                    showError(thePlayer, "Ihr Fahrzeug ist dafür zu stark beschädigt!")
                                end
                            else
                                showError(thePlayer, "Ihr Fahrzeug befindet sich derzeit an einem Ort, bei dem kein Respawn möglich ist!")
                            end
                        else
                            showError(thePlayer, "Das Fahrzeug ist nicht leer!")
                        end
                    end
                end
            end
        end
    end
end

addCommandHandler("towveh", towveh_func, false, false)

function vehhelp_func(thePlayer)
    outputChatBox("______FAHRZEUG HILFE______", thePlayer)
    outputChatBox("/vehinfos - Informationen über all deine Autos", thePlayer)
    outputChatBox("/lock [SlotID]- zum Abschliesen deiner Fahrzeuge", thePlayer)
    outputChatBox("/park - Abparken deines Fahrzeuges", thePlayer)
    outputChatBox("/deletecar - Zum Verschrotten des Fahrzeugs ", thePlayer)
    outputChatBox("/sellcar [playername] [SlotID]- Übergeben des Fahrzeugs an jemand anderes", thePlayer)
    outputChatBox("/towveh [SlotID] - Um eines deiner Fahrzeuge auf seine ParkPosition zusetzten", thePlayer)
    outputChatBox("/blinker_right /blinker_left und /blinker_warn - Blinkersystem", thePlayer)
    outputChatBox("___________________________", thePlayer)
end

addCommandHandler("vehhelp", vehhelp_func, false, false)

function privCar_not_Enter_func(thePlayer)
    if (vioGetElementData(source, "locked") == true) then
        cancelEvent()
        showError(thePlayer, "Das Fahrzeug ist abgeschlossen, du kannst die Tür nicht öffnen!")
    end
end

addEventHandler("onVehicleStartEnter", getRootElement(), privCar_not_Enter_func)

function privCar_not_Exit_func(thePlayer, seat)
    if (vioGetElementData(source, "locked") == true) and (seat == 0) then
        cancelEvent()
        showError(thePlayer, "Das Fahrzeug ist abgeschlossen, du kannst die Tür nicht öffnen!")
    end
    triggerClientEvent(thePlayer, "closeFishing", thePlayer) -- Fisch Fenster schließen Triggern
end

addEventHandler("onVehicleStartExit", getRootElement(), privCar_not_Exit_func)

function deletecar_func(thePlayer, command, SloteID)
    local SlotID = tonumber(SloteID)
    if (SlotID) then
        local carPrice = 0
        if not (vioGetElementData(thePlayer, "slot" .. SlotID) == nil) then
            if (not (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID)) == -1)) then
                if (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID)) == -2) then
                    outputChatBox("Dieses Fahrzeug wurde abgeschleppt und muss an der Verwahrungsstelle abgeholt werden!", thePlayer, 255, 0, 0)
                else
                    for theKey, theTable in ipairs(privVeh) do
                        if (theTable[3] == vioGetElementData(thePlayer, "slot" .. SlotID)) then
                            table.remove(privVeh, theKey)
                        end
                    end

                    MySql.helper.delete("user_vehicles", { ID = vioGetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "dbid") });

                    local vehicle = vioGetElementData(thePlayer, "slot" .. SlotID);
                    log_car_delete(vioGetElementData(vehicle, "besitzer"),
                            vioGetElementData(vehicle, "slotid"),
                            getElementModel(vehicle),
                            "sold by user",
                            vioGetElementData(vehicle, "besitzer"));

                    local carPrice = 0

                    if (vioGetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "kaufpreis") ~= 0) then
                        carPrice = vioGetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "kaufpreis") * 0.55
                    end

                    showError(thePlayer, "Das Fahrzeug wurde erfolgreich verschrottet. Sie haben 55% des Kaufpreises erhalten!")

                    changePlayerMoney(thePlayer, carPrice, "fahrzeug", "Fahrzeugverkauf")
                    destroyElement(vioGetElementData(thePlayer, "slot" .. SlotID))
                    vioSetElementData(thePlayer, "slot" .. SlotID, -1)
                end
            end
        end
    end
end

addCommandHandler("deletecar", deletecar_func, false, false)

function givecar_func(thePlayer, Command, newplayername, SloteID)
    if (SloteID) then
        local SlotID = tonumber(SloteID)
        if (SlotID) then
            if (not (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID) == -2))) then
                if not (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID) == -1)) and not (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID) == -2)) then
                    local newplayer = getPlayerFromIncompleteName(newplayername)
                    if (newplayer) then
                        if (isPlayerLoggedIn(newplayer)) then
                            local modelid = getElementModel(vioGetElementData(thePlayer, "slot" .. SlotID))
                            if (not (vioGetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "no_handel") == 1)) then
                                local freeslots = 0
                                local firstfreeslot = 0
                                for zah = vioGetElementData(newplayer, "maxslots"), 1, -1 do
                                    if tonumber(vioGetElementData(newplayer, "slot" .. zah)) == -1 then
                                        freeslots = freeslots + 1
                                        firstfreeslot = zah
                                    end
                                end
                                if (freeslots > 0) then
                                    vioSetElementData(newplayer, "slot" .. firstfreeslot, vioGetElementData(thePlayer, "slot" .. SlotID))
                                    local colorA = math.random(0, 126)
                                    local colorB = math.random(0, 126)
                                    local colorstring = colorA .. "|" .. colorB .. "|0|0"
                                    vioSetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "colors", colorstring)
                                    vioSetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "Lichterfarbe", "0|0|0")
                                    setVehicleHeadLightColor(vioGetElementData(thePlayer, "slot" .. SlotID), 255, 255, 255)
                                    setVehicleColor(vioGetElementData(thePlayer, "slot" .. SlotID), colorA, colorB, 0, 0)
                                    vioSetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "besitzer", getPlayerName(newplayer))
                                    vioSetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "slotid", firstfreeslot)

                                    MySql.helper.update("user_vehicles", {
                                        SlotID = firstfreeslot,
                                        Besitzer = getPlayerName(newplayer)
                                    }, {
                                        ID = vioGetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "dbid")
                                    });

                                    local vehname = getVehicleNameFromModel(getElementModel(vioGetElementData(thePlayer, "slot" .. SlotID)))
                                    showError(thePlayer, "Dieser Spieler hat das Fahrzeug erfolgreich erhalten")
                                    outputChatBox(string.format("Dir wurde von %s ein %s in deinen Slot %s übergeben!", getPlayerName(thePlayer), vehname, firstfreeslot), newplayer, 255, 255, 0)
                                    vioSetElementData(thePlayer, "slot" .. SlotID, -1)
                                    for theKey, theVars in ipairs(privVeh) do
                                        if (theVars[1] == getPlayerName(thePlayer)) and (tonumber(theVars[2]) == SlotID) then
                                            theVars[1] = getPlayerName(newplayer)
                                            theVars[2] = firstfreeslot
                                        end
                                    end
                                    if ((vioGetElementData(newplayer, "maxslots") - (freeslots - 1)) > 10) then
                                        if (vioGetElementData(newplayer, "Erfolg_10erFahrzeugrausch") ~= 1) then
                                            vioSetElementData(newplayer, "Erfolg_10erFahrzeugrausch", 1)
                                            triggerClientEvent(newplayer, "onClientCreatePokalGUI", newplayer, "10er Fahrzeugrausch", "Besitze 10 Fahrzeuge!")
                                        end
                                    end
                                    if ((vioGetElementData(newplayer, "maxslots") - (freeslots - 1)) > 15) then
                                        if (vioGetElementData(newplayer, "Erfolg_20erFahrzeugrausch") ~= 1) then
                                            vioSetElementData(newplayer, "Erfolg_20erFahrzeugrausch", 1)
                                            triggerClientEvent(newplayer, "onClientCreatePokalGUI", newplayer, "15er Fahrzeugrausch", "Besitze 15 Fahrzeuge!")
                                        end
                                    end
                                    if ((vioGetElementData(newplayer, "maxslots") - (freeslots - 1)) > 20) then
                                        if (vioGetElementData(newplayer, "Erfolg_50erFahrzeugrausch") ~= 1) then
                                            vioSetElementData(newplayer, "Erfolg_50erFahrzeugrausch", 1)
                                            triggerClientEvent(newplayer, "onClientCreatePokalGUI", newplayer, "20er Fahrzeugrausch", "Besitze 20 Fahrzeuge!")
                                        end
                                    end
                                else
                                    showError(thePlayer, "Dieser Spieler hat keinen freien Slot mehr!")
                                end
                            else
                                showError(thePlayer, "Dieses Fahrzeug ist vom Spielerhandel ausgeschlossen!")
                            end
                        else
                            showError(thePlayer, "Dieser Spieler ist nicht Online!")
                        end
                    else
                        showError(thePlayer, "Dieser Spieler ist nicht Online!")
                    end
                end
            else
                showError(thePlayer, "Abgeschleppte Fahrzeuge dürfen nicht verkauft werden")
            end
        end
    end
end

addCommandHandler("givecar", givecar_func, false, false)

function sellcar_func(thePlayer, Command, newplayername, SloteID, price)
    if (SloteID) then
        local SlotID = tonumber(SloteID)
        if (SlotID) then
            if (not (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID) == -2))) then
                if not (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID) == -1)) and not (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID) == -2)) then
                    local newplayer = getPlayerFromIncompleteName(newplayername)
                    if (newplayer) then
                        if (isPlayerLoggedIn(newplayer)) then
                            local modelid = getElementModel(vioGetElementData(thePlayer, "slot" .. SlotID))
                            if (not (vioGetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "no_handel") == 1)) then
                                local freeslots = 0
                                local firstfreeslot = 0
                                for zah = vioGetElementData(newplayer, "maxslots"), 1, -1 do
                                    if tonumber(vioGetElementData(newplayer, "slot" .. zah)) == -1 then
                                        freeslots = freeslots + 1
                                        firstfreeslot = zah
                                    end
                                end

                                if (not price) then
                                    showError(thePlayer, "Nutzung: /sellcar [Spielername] [SlotId] [Preis]");
                                    return ;
                                end

                                if (not tonumber(price)) then
                                    showError(thePlayer, "Nutzung: /sellcar [Spielername] [SlotId] [Preis]");
                                    return ;
                                end

                                price = tonumber(price);
                                if (price < 1) then
                                    showError(thePlayer, "Nutzung: /sellcar [Spielername] [SlotId] [Preis]");
                                    return ;
                                end

                                if (freeslots > 0) then
                                    if (getElementsDistance(thePlayer, newplayer) < 20) then
                                        if (getElementsDistance(thePlayer, vioGetElementData(thePlayer, "slot" .. SlotID)) < 30) then
                                            local acceptTable = {
                                                price = price,
                                                fromPlayer = thePlayer,
                                                toPlayer = newplayer,
                                                slotId = SlotID
                                            };

                                            vioSetElementData(thePlayer, "sellcar", acceptTable);
                                            vioSetElementData(newplayer, "sellcar_accept", acceptTable);

                                            outputChatBox("Der Spieler " .. getPlayerName(thePlayer) .. " hat dir sein Fahrzeug in seinen Slot " .. SlotID .. " für " .. toprice(price) .. " zum Verkauf angeboten.", newplayer);
                                            outputChatBox("Den Verkauf kannst du mit '/accept sellcar' akzeptieren", newplayer);
                                        else
                                            showError(thePlayer, "Das Fahrzeug ist nicht in eurer Nähe.")
                                        end
                                    else
                                        showError(thePlayer, "Der Spieler ist nicht in deiner Nähe.");
                                    end
                                else
                                    showError(thePlayer, "Dieser Spieler hat keinen freien Slot mehr!")
                                end
                            else
                                showError(thePlayer, "Dieses Fahrzeug ist vom Spielerhandel ausgeschlossen!")
                            end
                        else
                            showError(thePlayer, "Dieser Spieler ist nicht Online!")
                        end
                    else
                        showError(thePlayer, "Dieser Spieler ist nicht Online!")
                    end
                end
            else
                showError(thePlayer, "Abgeschleppte Fahrzeuge dürfen nicht verkauft werden")
            end
        end
    end
end
addCommandHandler("sellcar", sellcar_func, false, false)

function accept_sellcar(toPlayer)
    local acceptTable = vioGetElementData(toPlayer, "sellcar_accept");

    if (acceptTable ~= vioGetElementData(acceptTable.fromPlayer, "sellcar")) then
        outputChatBox("Das Angebot ist nicht mehr gültig", toPlayer);
    end

    local SlotID = acceptTable.slotId;
    local thePlayer = acceptTable.fromPlayer;
    local newplayer = toPlayer;
    local price = acceptTable.price;

    if (not SlotID) then
        outputChatBox("Das Angebot ist nicht mehr gültig", toPlayer);
        return ;
    end

    if (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID) == -2)) then
        outputChatBox("Das Angebot ist nicht mehr gültig", toPlayer);
        return ;
    end

    if (tonumber(vioGetElementData(thePlayer, "slot" .. SlotID) == -1)) then
        outputChatBox("Das Angebot ist nicht mehr gültig", toPlayer);
        return ;
    end

    if (price < 1) then
        outputChatBox("Das Angebot ist nicht mehr gültig", toPlayer);
        return ;
    end

    if (getPlayerMoney(toPlayer) < price) then
        outputChatBox("Du hast nicht genug Geld auf deiner Hand.", toPlayer);
        return ;
    end

    local freeslots = 0
    local firstfreeslot = 0
    for zah = vioGetElementData(newplayer, "maxslots"), 1, -1 do
        if tonumber(vioGetElementData(newplayer, "slot" .. zah)) == -1 then
            freeslots = freeslots + 1
            firstfreeslot = zah
        end
    end

    if (freeslots > 0) then
        if (getElementsDistance(thePlayer, newplayer) < 20) then
            if (getElementsDistance(thePlayer, vioGetElementData(thePlayer, "slot" .. SlotID)) < 30) then
                vioSetElementData(newplayer, "slot" .. firstfreeslot, vioGetElementData(thePlayer, "slot" .. SlotID))

                changePlayerMoney(toPlayer, -price, "fahrzeug", "Privater Fahrzeugkauf", "von " .. getPlayerName(thePlayer));
                changePlayerMoney(thePlayer, price, "fahrzeug", "Privater Fahrzeugkauf", "an " .. getPlayerName(toPlayer));

                vioSetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "besitzer", getPlayerName(newplayer))
                vioSetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "slotid", firstfreeslot)

                MySql.helper.update("user_vehicles", {
                    SlotID = firstfreeslot,
                    Besitzer = getPlayerName(newplayer)
                }, {
                    ID = vioGetElementData(vioGetElementData(thePlayer, "slot" .. SlotID), "dbid")
                });

                local vehname = getVehicleNameFromModel(getElementModel(vioGetElementData(thePlayer, "slot" .. SlotID)))
                showError(thePlayer, "Dieser Spieler hat das Fahrzeug erfolgreich gekauft")
                outputChatBox(string.format("Dir wurde von %s ein %s in deinen Slot %s verkauft!", getPlayerName(thePlayer), vehname, firstfreeslot), newplayer, 255, 255, 0)

                vioSetElementData(thePlayer, "slot" .. SlotID, -1)
                for theKey, theVars in ipairs(privVeh) do
                    if (theVars[1] == getPlayerName(thePlayer)) and (tonumber(theVars[2]) == SlotID) then
                        theVars[1] = getPlayerName(newplayer)
                        theVars[2] = firstfreeslot
                    end
                end
                if ((vioGetElementData(newplayer, "maxslots") - (freeslots - 1)) > 10) then
                    if (vioGetElementData(newplayer, "Erfolg_10erFahrzeugrausch") ~= 1) then
                        vioSetElementData(newplayer, "Erfolg_10erFahrzeugrausch", 1)
                        triggerClientEvent(newplayer, "onClientCreatePokalGUI", newplayer, "10er Fahrzeugrausch", "Besitze 10 Fahrzeuge!")
                    end
                end
                if ((vioGetElementData(newplayer, "maxslots") - (freeslots - 1)) > 15) then
                    if (vioGetElementData(newplayer, "Erfolg_20erFahrzeugrausch") ~= 1) then
                        vioSetElementData(newplayer, "Erfolg_20erFahrzeugrausch", 1)
                        triggerClientEvent(newplayer, "onClientCreatePokalGUI", newplayer, "15er Fahrzeugrausch", "Besitze 15 Fahrzeuge!")
                    end
                end
                if ((vioGetElementData(newplayer, "maxslots") - (freeslots - 1)) > 20) then
                    if (vioGetElementData(newplayer, "Erfolg_50erFahrzeugrausch") ~= 1) then
                        vioSetElementData(newplayer, "Erfolg_50erFahrzeugrausch", 1)
                        triggerClientEvent(newplayer, "onClientCreatePokalGUI", newplayer, "20er Fahrzeugrausch", "Besitze 20 Fahrzeuge!")
                    end
                end
            else
                showError(thePlayer, "Das Fahrzeug ist nicht in eurer Nähe.")
            end
        else
            showError(thePlayer, "Der Verkäufer ist nicht in deiner Nähe.");
        end
    else
        showError(thePlayer, "Du hast keinen freien Slot mehr!")
    end
end

registerAcceptHandler("sellcar", accept_sellcar, {
    requestedDataValues = { "sellcar_accept" }
});
