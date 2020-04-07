abgabecol = createColSphere(2483.384765625,-2110.2294921875,13.114736557007, 40)
abgabecolA = createColRectangle(2241.9189453125, 2434.1201171875, 55, 58)

createBlip(2447.8000488281, -2120.8999023438, 13.60000038147, 51, 1, 0, 0, 0, 255, 0, 255, getRootElement())

function abschleppNullSystem()

    if (isDevServer()) then
        return;
    end

    local shape = createColSphere(0, 0, 0, 20)
    local vehicles = getElementsWithinColShape(shape, "vehicle")
    for _, theVehicle in ipairs(vehicles) do
        if (isVehiclePrivate(theVehicle)) then

            if (getPlayerFromName(vioGetElementData(theVehicle, "besitzer"))) then
                outputChatBox(string.format("Dein Fahrzeug im Slot %s wurde vom Abschleppsystem abgeschleppt! (Nullspawn)", vioGetElementData(theVehicle, "slotid")), getPlayerFromName(vioGetElementData(theVehicle, "besitzer")), 255, 0, 0)
                vioSetElementData(getPlayerFromName(vioGetElementData(theVehicle, "besitzer")), "slot" .. vioGetElementData(theVehicle, "slotid"), -2)
            else
                save_offline_message(vioGetElementData(theVehicle, "besitzer"), "Abschleppsystem", string.format("Dein Fahrzeug im Slot %s wurde vom Abschleppsystem abgeschleppt! (Nullspawn)", vioGetElementData(theVehicle, "slotid")))
            end
            save_car(theVehicle)

            log_tow_police(vioGetElementData(theVehicle, "slotid"), vioGetElementData(theVehicle, "besitzer"), "Abschleppsystem-Nullspawn");

            MySql.helper.update("user_vehicles", {
                SpawnX = 0,
                SpawnY = 0,
                SpawnZ = 0,
                SpawnRX = 0,
                SpawnRY = 0,
                SpawnRZ = 0,
                abgeschleppt = 1,
                lastDamageStates = toJSON(getVehicleDamageParts(theVehicle)),
                lastPosition = '[{0,0,0,0,0,0}]',
                lastHealth = getElementHealth(theVehicle)
            }, { ID = vioGetElementData(theVehicle, "dbid") });

            for tableKey, theTable in ipairs(privVeh) do
                if (theTable[3] == source) then
                    table.remove(privVeh, tableKey)
                end
            end

            table.insert(privVeh, { vioGetElementData(theVehicle, "besitzer"), vioGetElementData(theVehicle, "slotid"), -2 })

            destroyElement(theVehicle)
        end
    end
end

function createabschleppNullSystem_Timer()
    setTimer(abschleppNullSystem, 900000, 0)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createabschleppNullSystem_Timer)

addEvent("abgeschleppt_Event", true)
function abgeschleppt_police_click(theVehicle, grund)
    if (isBeamter(source) or isAdminLevel(source, 0)) then
        if isElement(theVehicle) then
            if (isElementWithinColShape(theVehicle, abgabecol) or isElementWithinColShape(theVehicle, abgabecolA) or (isAdminLevel(source, 0))) then

                if (getPlayerFromName(vioGetElementData(theVehicle, "besitzer"))) then
                    outputChatBox(string.format("Dein Fahrzeug im Slot %s wurde von %s abgeschleppt, weil: %s", vioGetElementData(theVehicle, "slotid"), getPlayerName(source), grund), getPlayerFromName(vioGetElementData(theVehicle, "besitzer")), 255, 0, 0)
                    vioSetElementData(getPlayerFromName(vioGetElementData(theVehicle, "besitzer")), "slot" .. vioGetElementData(theVehicle, "slotid"), -2)
                else
                    save_offline_message(vioGetElementData(theVehicle, "besitzer"), "Abschleppsystem", string.format("Dein Fahrzeug im Slot %s wurde von %s abgeschleppt, weil: %s", vioGetElementData(theVehicle, "slotid"), getPlayerName(source), grund))
                end
                save_car(theVehicle)

                log_tow_police(vioGetElementData(theVehicle, "slotid"), vioGetElementData(theVehicle, "besitzer"), getPlayerName(source), grund);

                MySql.helper.update("user_vehicles", {
                    SpawnX = 0,
                    SpawnY = 0,
                    SpawnZ = 0,
                    SpawnRX = 0,
                    SpawnRY = 0,
                    SpawnRZ = 0,
                    abgeschleppt = 1,
                    lastPosition = '[{0,0,0,0,0,0}]',
                    lastDamageStates = toJSON(getVehicleDamageParts(theVehicle)),
                    lastHealth = getElementHealth(theVehicle)
                }, { ID = vioGetElementData(theVehicle, "dbid") });

                for theKey, theTable in ipairs(privVeh) do
                    if (theTable[3] == source) then
                        table.remove(privVeh, theKey)
                    end
                end

                table.insert(privVeh, { vioGetElementData(theVehicle, "besitzer"), vioGetElementData(theVehicle, "slotid"), -2 })

                destroyElement(theVehicle)
                outputChatBox("Du hast das Fahrzeug erfolgreich abgeschleppt!", source, 255, 0, 0)
            else
                outputChatBox("Das entsprechende Fahrzeug steht nicht am Garagentor auf der Verwahrungsstelle.", source, 255, 0, 0)
            end
        end
    end
end
addEventHandler("abgeschleppt_Event", getRootElement(), abgeschleppt_police_click)

function attachAbschleppingCar(theTruck)
    if (isPoliceCar(theTruck) and isVehiclePrivate(source)) then
        setElementFrozen(source, false)
    end
end
addEventHandler("onTrailerAttach", getRootElement(), attachAbschleppingCar)

function deattachAbschleppingCar(theTruck)
    if (isPoliceCar(theTruck)) then
        if (vioGetElementData(source, "locked")) then
            setElementFrozen(source, true)
        end
    end
end
addEventHandler("onTrailerDetach", getRootElement(), deattachAbschleppingCar)

local abholpreis = 1000

function createAbholPickup_abschleppt()
    local abschlepppickup = createPickup(2447.8000488281, -2120.8999023438, 13.60000038147, 3, 1239)
    addEventHandler("onPickupHit", abschlepppickup, showAbschleppInfo)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createAbholPickup_abschleppt)

function showAbschleppInfo(thePlayer)
    outputChatBox("Hier kannst du deine Abgeschleppten Fahrzeuge abholen!", thePlayer, 211, 22, 0)
    outputChatBox(string.format("Pro Fahrzeug kostet dich das %s$ Bearbeitungsgebühr!", abholpreis), thePlayer, 211, 22, 0)
    outputChatBox("Abholen kannst du die Fahrzeuge in den du HIER folgenden Command nutzt:", thePlayer, 211, 22, 0)
    outputChatBox("/getcar [ID]", thePlayer, 211, 22, 0)
end

function getcar_func(thePlayer, cmd, IDs)
    local px, py, pz = getElementPosition(thePlayer)
    if (getDistanceBetweenPoints3D(px, py, pz, 2447.8000488281, -2120.8999023438, 13.60000038147) < 10) then

        if (IDs) then
            if (tonumber(IDs)) then
                local id = tonumber(IDs)
                if (vioGetElementData(thePlayer, "slot" .. id) == -2) then
                    if (getPlayerMoney(thePlayer) < abholpreis) then
                        outputChatBox(string.format("Du hast nicht genügend Geld bei dir! Du benötigst %s$", abholpreis), thePlayer, 211, 22, 0)
                    else
                        for theKey, theTable in ipairs(privVeh) do
                            if (theTable[1] == getPlayerName(thePlayer) and (tonumber(theTable[2]) == tonumber(id))) then
                                table.remove(privVeh, theKey)
                            end
                        end

                        local result = MySql.helper.getSync("user_vehicles", "*", {
                            Besitzer = getPlayerName(thePlayer),
                            SlotID = id
                        });

                        local daSatz = result[1];
                        local theVehicle = thePlayer;

                        if not (isPlane(tonumber(daSatz["Model"])) or isHeli(tonumber(daSatz["Model"])) or isBoat(tonumber(daSatz["Model"])) or isWaterPlane(daSatz["Model"])) then
                            theVehicle = createVehicle(daSatz["Model"], 2459.900390625, -2114.5, 13.5, 0, 0, 0, daSatz["Besitzer"])
                        elseif (isBoat(tonumber(daSatz["Model"])) or isWaterPlane(daSatz["Model"])) then
                            theVehicle = createVehicle(daSatz["Model"], 801.3193359375, -2054.2001953125, -0.44321331381798, 3.702392578125, 4.691162109375, 0.010986328125, daSatz["Besitzer"])
						elseif (isHeli(tonumber(daSatz["Model"]))) then
							theVehicle = createVehicle(daSatz["Model"], 2654.1000976563, -2092, 19.39999961853, 0, 0, 90, daSatz["Besitzer"])
                        else
                            theVehicle = createVehicle(daSatz["Model"], 1945.5, -2316.3, 16.7, 0, 0, 184, daSatz["Besitzer"])
                        end

                        setElementHealth(theVehicle, daSatz["lastHealth"]);
                        setVehicleDamageParts(theVehicle, fromJSON(daSatz["lastDamageStates"]));

                        vioSetElementData(thePlayer, "slot" .. id, theVehicle)
                        vioSetElementData(theVehicle, "abgeschleppt", 0)

                        MySql.helper.update("user_vehicles", {
                            SpawnX = 0,
                            SpawnY = 0,
                            SpawnZ = 0,
                            SpawnRX = 0,
                            SpawnRY = 0,
                            SpawnRZ = 0,
                            abgeschleppt = 0
                        }, { ID = daSatz["ID"] });

                        local colors = {}
                        local counter = 0
                        local countlast;
                        for color = 0, 3, 1 do
                            countlast = counter

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
                        for _, theTuning in ipairs(tuning) do
                            if (theTuning ~= 0) then
                                addVehicleUpgrade(theVehicle, theTuning)
                            end
                        end

                        vioSetElementData(theVehicle, "besitzer", daSatz["Besitzer"])
                        vioSetElementData(theVehicle, "model", daSatz["Model"])
                        vioSetElementData(theVehicle, "dbid", tonumber(daSatz["ID"]))
                        vioSetElementData(theVehicle, "slotid", daSatz["SlotID"])
                        vioSetElementData(theVehicle, "spawnx", 0)
                        vioSetElementData(theVehicle, "spawny", 0)
                        vioSetElementData(theVehicle, "spawnz", 0)
                        vioSetElementData(theVehicle, "spawnrx", 0)
                        vioSetElementData(theVehicle, "spawnry", 0)
                        vioSetElementData(theVehicle, "spawnrz", 0)
                        vioSetElementData(theVehicle, "colors", daSatz["Colors"])
                        vioSetElementData(theVehicle, "falter", daSatz["fahrzeugalter"])
                        vioSetElementData(theVehicle, "tuning", daSatz["Tuning"])
                        vioSetElementData(theVehicle, "paintjob", daSatz["paintjob"])
                        vioSetElementData(theVehicle, "tank", daSatz["Tank"])
                        vioSetElementData(theVehicle, "abgeschleppt", 0)
                        vioSetElementData(theVehicle, "Lichterfarbe", daSatz["Lichterfarbe"])
                        vioSetElementData(theVehicle, "kaufpreis", tonumber(daSatz["kaufpreis"]))
                        vioSetElementData(theVehicle, "kmstand", daSatz["kmstand"])
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
                        local slot = tonumber(daSatz["SlotID"])

                        vioSetElementData(theVehicle, "motor", false)
                        vioSetElementData(theVehicle, "locked", true)
                        table.insert(privVeh, { vara, slot, theVehicle })

                        outputChatBox("Parke dieses mal dein Fahrzeug richtig und beachte dabei die geltenden Regeln! (mit /park)", thePlayer, 255, 0, 0)
                        changePlayerMoney(thePlayer, -abholpreis, "fahrzeug", "Abgeschleppt")
                        local vx, vy, vz = getElementPosition(theVehicle)
                        setElementPosition(thePlayer, vx, vy, vz)
                        warpPedIntoVehicle(thePlayer, theVehicle, 0)
                    end
                else
                    outputChatBox("Du hast eine ungültige ID eingegeben!", thePlayer, 211, 22, 0)
                end
            end
        end
    else
        outputChatBox("Du bist nicht am Abholplatz", thePlayer, 211, 11, 0)
    end
end
addCommandHandler("getcar", getcar_func, false, false)
