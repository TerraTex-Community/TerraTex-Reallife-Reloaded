function setPlayerSpawn(source, spawn, skinid, fraktion, firstspawn)

    local frakid = vioGetElementData(source, "fraktion")
    if (frakid == 1 or frakid == 4 or frakid == 5 or frakid == 9 or frakid == 10) then
        vioSetElementData(source, "isCopDuty", false)
        vioSetElementData(source, "isCopSwat", false)
        vioSetElementData(source, "taxi_duty", false)
        vioSetElementData(source, "isMedicDuty", false)
        skinid = vioGetElementData(source, "skinid")
    end

    if (vioGetElementData(source, "cuffed")) then
        if (vioGetElementData(source, "cuffed") ~= 0) then
            vioSetElementData(source, "cuffed", 0)
            toggleAllControls(source, true)
            toggleControl(source, "enter_passenger", true)
            setElementFrozen(source, false)
        end
    end

    if not (vioGetElementData(source, "inArena")) then
        fadeCamera(source, true)
        setCameraTarget(source, source)
        setPedHeadless(source, false)

        local name = getPlayerName(source)

        if (tonumber(getElementData(source, "todezeit")) == 0) then
            if (vioGetElementData(source, "knastzeit") > 0) then
                local int, x, y, z = CrimeSystem.Jail.getRandomJailSpawnById(vioGetElementData(source, "alkaknast"));
                spawnPlayer(source, x, y, z, 183.71893310547, 62, int, 0, team[fraktion])
                setElementFrozen(source, true)
                setTimer(setElementFrozen, 3000, 1, source, false)
            else
                if (not FlutInAction) then
                    if (spawn == 109) then
                        if (frakid == 1) then
                            frakid = 9
                            spawn = 1
                        end
                    end
                    --noobspawn
                    if (spawn == 0) then
                        spawnPlayer(source, 1742.8310546875, -1862.2724609375, 13.576497077942, 355.60266113281, skinid, 0, 0, team[fraktion])
                        --fraktionsspawn
                    elseif (spawn == 1) then

                        if (frakid == defenderFraktionOfDepot) and (isAttackofDepot) then
                            outputChatBox("Während eines Angriffs werdet ihr in einer sicheren Umgebung gespawned!", source, 255, 0, 0)
                            spawnPlayer(source, 1565.541015625, 23.0830078125, 24.1640625, 92.52001953125, skinid, 0, 0, team[fraktion])
                        elseif (frakid == 1) then
                            spawnPlayer(source, 218.6328125, 110.7275390625, 1003.21875, 7.0780639648438, skinid, 10, 0, team[fraktion]) -- policespawn
                        elseif (frakid == 2) then
                            spawnPlayer(source, 2494.2998046875, -1704.654296875, 1018.34375, 73.381561279297, skinid, 3, 0, team[fraktion]) -- grove
                        elseif (frakid == 3) then
                            spawnPlayer(source, 1033.6279296875, 1019.3505859375, 11, 308.06958007813, skinid, 0, 0, team[fraktion]) -- news
                        elseif (frakid == 4) then
                            spawnPlayer(source, 1751.154296875, -2055.955078125, 13.881997108459, 154.12683105469, skinid, 0, 0, team[fraktion])
                        elseif (frakid == 5) then
                            spawnPlayer(source, 254.4853515625, 77.443359375, 1003.640625, 179.91760253906, skinid, 6, 0, team[fraktion])
                        elseif (frakid == 6) then
                            spawnPlayer(source, 2338.341796875, -1139.8955078125, 1054.3046875, 82.379516601563, skinid, 12, 9999, team[fraktion])
                        elseif (frakid == 7) then
                            spawnPlayer(source, 223.791015625, 1860.880859375, 13.14695930481, 25.029998779297, skinid, 0, 0, team[fraktion])
                        elseif (frakid == 8) then
                            spawnPlayer(source, -405.896484375, -1433.970703125, 25.720909118652, 183.78485107422, skinid, 0, 0, team[fraktion])
                        elseif (frakid == 9) then
                            spawnPlayer(source, 215.95703125, 145.75, 1003.0234375, 183.87274169922, skinid, 3, 0, team[fraktion]) --lvpd
                        elseif (frakid == 10) then
                            spawnPlayer(source, 1607.3505859375, 1816.220703125, 10.8203125, 114.33920288086, skinid, 0, 0, team[fraktion]) --medic
                        elseif (frakid == 11) then
                            spawnPlayer(source, 2017.888671875, 1915.2509765625, 12.32729434967, 8.2920532226563, skinid, 0, 0, team[fraktion]) --cash
                        elseif (frakid == 12) then
                            spawnPlayer(source, 2797.763671875, 2226.0751953125, 10.8203125, 272.97869873047, skinid, 0, 0, team[fraktion]) --viol
                        elseif (frakid == 13) then
                            spawnPlayer(source, 2398.2744140625, 1020.8876953125, 10.8203125, 11.681396484375, skinid, 0, 0, team[fraktion]) --viol
                        else
                            spawnPlayer(source, 1742.8310546875, -1862.2724609375, 13.576497077942, 355.60266113281, skinid, 0, 0, team[fraktion])
                            vioSetElementData(source, "spawnplace", 0)
                        end
                        --hausspawn
                    elseif (spawn == 2) then
                        local iha = vioGetElementData(source, "hkey")
                        if (iha ~= 0) then
                            if (iha < 0) then iha = iha * (-1) end
                            local haus = haeuser[iha]
                            local x, y, z, int, dim = haus:getPlayerSpawn()
                            spawnPlayer(source, x, y, z, 0, skinid, int, 0, team[fraktion])
                            setElementDimension(source, dim)
                        else
                            spawnPlayer(source, 1742.8310546875, -1862.2724609375, 13.576497077942, 355.60266113281, skinid, 0, 0, team[fraktion])
                            vioSetElementData(source, "spawnplace", 0)
                        end
                    elseif (spawn == 3) and not (spawnDisconnectPlayers[name]) then
                        local time = getRealTime()
                        local nickname = getPlayerName(source)
                        local slot = vioGetElementData(source, "VehicleSpawn")
                        if isElement(vioGetElementData(source, "slot" .. slot)) then
                            if isSpawnChangeVehicle[getElementModel(vioGetElementData(source, "slot" .. slot))] then
                                if getVehicleOccupant(vioGetElementData(source, "slot" .. slot)) then
                                    outputChatBox("Das Fahrzeug in dem Sie Spawnen wollen, ist besetzt!", source, 0, 255, 0)
                                    spawnPlayer(source, 1742.8310546875, -1862.2724609375, 13.576497077942, 355.60266113281, skinid, 0, 0, team[fraktion])
                                else
                                    local vx, vy, vz = getElementPosition(vioGetElementData(source, "slot" .. slot))
                                    spawnPlayer(source, vx, vy, vz + 1, 355.60266113281, skinid, 0, 0, team[fraktion])
                                    warpPedIntoVehicle(source, vioGetElementData(source, "slot" .. slot))
                                    setElementFrozen(vioGetElementData(source, "slot" .. slot), false)
                                end
                            else
                                spawnPlayer(source, 1742.8310546875, -1862.2724609375, 13.576497077942, 355.60266113281, skinid, 0, 0, team[fraktion])
                                vioSetElementData(source, "spawnplace", 0)
                            end
                        else
                            spawnPlayer(source, 1742.8310546875, -1862.2724609375, 13.576497077942, 355.60266113281, skinid, 0, 0, team[fraktion])
                            vioSetElementData(source, "spawnplace", 0)
                        end
                        --- parkhaus
                    elseif (spawn == 4) then
                        spawnPlayer(source, 2262.560546875, 1382.1240234375, 10.8203125, 169.44744873047, skinid, 0, 0, team[fraktion])
                    else
                        spawnPlayer(source, 1742.8310546875, -1862.2724609375, 13.576497077942, 355.60266113281, skinid, 0, 0, team[fraktion])
                    end
                else
                    outputChatBox("Aufgrund einer Flut wurden Sie an einen sicheren Platz gebracht!", source, 255, 0, 0)
                    spawnPlayer(source, 1307.62890625, -874.5673828125, 39.578125, 302.96084594727, skinid, 0, 0, team[fraktion]) -- flutspawn
                end
            end
            setElementHealth(source, 100)

            setPlayerSpawnWeapons(source, frakid, fraktionsrang)

        else
            loadKrankenhaus(source)
        end
    end
end
