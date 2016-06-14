spawnDiscconectPlayers = {}
function disconnectSetSpawn()
    if not (vioGetElementData(source, "inArena")) then
        if (isPlayerLoggedIn(source)) then
            if (not isPedDead(source)) then
                local px, py, pz = getElementPosition(source)
                local int = getElementInterior(source)
                local dim = getElementDimension(source)
                local name = getPlayerName(source)
                local timer = setTimer(deleteDisconnectPlayerTable, 600000, 1, name)
                spawnDiscconectPlayers[name] = { px, py, pz, int, dim, timer }
            end
        end
        --	table.insert(spawnDiscconectPlayers,{name,px,py,pz,int,dim,timer})
    end
end

addEventHandler("onPlayerQuit", getRootElement(), disconnectSetSpawn)

function deleteDisconnectPlayerTable(name)
    spawnDiscconectPlayers[name] = false
end


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


        if (vioGetElementData(source, "todezeit") == 0) then
            if (vioGetElementData(source, "knastzeit") > 0) then
                local x, y, z = getKnastKoordinaten(source)
                local int = getKnastInterior(source)
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
                    if (spawn == 0) then --noobspawn
                    spawnPlayer(source, 1742.8310546875, -1862.2724609375, 13.576497077942, 355.60266113281, skinid, 0, 0, team[fraktion])
                    elseif (spawn == 1) then --fraktionsspawn

                    --[[if(frakid==attackerFraktionOfDepot)and(isAttackofDepot)then
                        outputChatBox("Während eines Angriffs werdet ihr in einer sicheren Umgebung gespawned!",source,255,0,0)
                        spawnPlayer(source, 1307.62890625,-874.5673828125,39.578125,302.96084594727 ,skinid,0,0,team[fraktion]) -- flutspawn
                    else]] --Attacker werden an ihrer Base gespawned
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
                    elseif (spawn == 2) then --hausspawn
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
                    elseif (spawn == 3) and not (spawnDiscconectPlayers[name]) then

                        local time = getRealTime()
                        local nickname = getPlayerName(source)
                        local premiumOutTime = MySql.helper.getValueSync("user_premium", "PremiumUntil", { Name = nickname }) - time.timestamp;
                        if (premiumOutTime > 0) then
                            local slot = vioGetElementData(source, "PremiumSpawn")
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
                        end
                    elseif (spawn == 5) then
                        local time = getRealTime()
                        local nickname = getPlayerName(source)
                        local premiumOutTime = MySql.helper.getValueSync("user_premium", "PremiumUntil", { Name = nickname }) - time.timestamp;
                        if (premiumOutTime > 0) then
                            if vioGetElementData(source, "job") > 0 then
                                --outputChatBox(tostring(vioGetElementData(source,"job")))
                                --outputChatBox(tostring(JobPickups[vioGetElementData(source,"job")]))
                                local pickele = JobPickups[vioGetElementData(source, "job")][1]
                                local int = getElementInterior(pickele)
                                local dim = getElementDimension(pickele)
                                local posx, posy, posz = getElementPosition(pickele)
                                spawnPlayer(source, posx, posy, posz, 0, skinid, int, dim, team[fraktion])

                            else
                                spawnPlayer(source, 1742.8310546875, -1862.2724609375, 13.576497077942, 355.60266113281, skinid, 0, 0, team[fraktion])
                                vioSetElementData(source, "spawnplace", 0)
                            end
                        else
                            spawnPlayer(source, 1742.8310546875, -1862.2724609375, 13.576497077942, 355.60266113281, skinid, 0, 0, team[fraktion])
                            vioSetElementData(source, "spawnplace", 0)
                        end
                    elseif (spawn == 4) then --- parkhaus
                    spawnPlayer(source, 2262.560546875, 1382.1240234375, 10.8203125, 169.44744873047, skinid, 0, 0, team[fraktion])

                    else
                        spawnPlayer(source, 1742.8310546875, -1862.2724609375, 13.576497077942, 355.60266113281, skinid, 0, 0, team[fraktion])
                    end
                else
                    outputChatBox("Aufgrund einer Flut wurden Sie an einen sicheren Platz gebracht!", source, 255, 0, 0)
                    spawnPlayer(source, 1307.62890625, -874.5673828125, 39.578125, 302.96084594727, skinid, 0, 0, team[fraktion]) -- flutspawn
                end
            end
            local frakid = vioGetElementData(source, "fraktion")
            local fraktionsrang = vioGetElementData(source, "fraktionsrang")
            if (firstspawn) then
                if ((firstspawn == 113)) then

                    local thePlayer = source
                    vioSetElementData(source, "firstspawn", false)
                    local nickname = getPlayerName(thePlayer)
                    local hp = MySql.helper.getValueSync("user_inventory", "Offline_HP", { Nickname = nickname });
                    local armor = MySql.helper.getValueSync("user_inventory", "Offline_Armor", { Nickname = nickname });
                    local weapons = MySql.helper.getValueSync("user_inventory", "Offline_Weapons", { Nickname = nickname });
                    local ammo = MySql.helper.getValueSync("user_inventory", "Offline_Ammo", { Nickname = nickname });
                    local source = thePlayer

                    local resetweapons = MySql.helper.getValueSync("user_data", "resetWeaponsAtNextLogin", { Nickname = nickname });
                    if (tonumber(hp) > 0) then
                        setElementHealth(source, hp)
                    end
                    if (tonumber(armor) > 0) then
                        setPedArmor(source, armor)
                    end

                    if (weapons ~= "0") then
                        local weapon = getStringComponents(weapons)
                        local ammos = getStringComponents(ammo)

                        for p = 0, 12, 1 do
                            n = p + 1
                            if (tonumber(weapon[n]) ~= nil) and (tonumber(ammos[n]) ~= nil) then
                                if (tonumber(weapon[n]) ~= 0) and (tonumber(ammos[n]) ~= 0) then
                                    --outputChatBox(tonumber( weapon[n]).." "..tonumber(ammos[n] ),source)
                                    local yes = giveWeapon(source, tonumber(weapon[n]), tonumber(ammos[n]))
                                    --outputChatBox(tostring(yes))
                                end
                            end
                        end
                    end
                end
            end
            setPlayerSpawnWeapons(source, frakid, fraktionsrang)

        else
            loadKrankenhaus(source)
        end


        if (spawnDiscconectPlayers[name]) then
            if (not (vioGetElementData(source, "knastzeit") > 0)) then
                setElementDimension(source, spawnDiscconectPlayers[name][5])
                setElementInterior(source, spawnDiscconectPlayers[name][4])
                setElementPosition(source, spawnDiscconectPlayers[name][1], spawnDiscconectPlayers[name][2], spawnDiscconectPlayers[name][3])
            end
            killTimer(spawnDiscconectPlayers[name][6])
            spawnDiscconectPlayers[name] = false
        else
            spawnDiscconectPlayers[name] = false
        end
    end
end


function setPlayerSpawnWeapons(thePlayer, Fraktion, Rang)


    if (vioGetElementData(thePlayer, "job") == 7) then
        setPedArmor(thePlayer, 150)
        giveWeapon(thePlayer, 34, 25)
        giveWeapon(thePlayer, 24, 200)
        giveWeapon(thePlayer, 4)
    end
    if (Fraktion == 3) then
        giveWeapon(thePlayer, 43, 9999)
        -- giveWeapon(thePlayer,41,2000)
    elseif (Fraktion == 10) then
        giveWeapon(thePlayer, 41, 2000)
    elseif (Fraktion == 4) then
        giveWeapon(thePlayer, 41, 2000)
    elseif (Fraktion == 7) then
        giveWeapon(thePlayer, 3)
        giveWeapon(thePlayer, 29, 1000)
        giveWeapon(thePlayer, 24, 550)
        setPedArmor(thePlayer, 100)
        giveWeapon(thePlayer, 31, 1500)

        if (Rang > 2) then
            setPedArmor(thePlayer, 150)
            giveWeapon(thePlayer, 31, 1500)
        end
    end
    local nickname = getPlayerName(thePlayer)
    local resetweapons = MySql.helper.getValueSync("user_data", "resetWeaponsAtNextLogin", { Nickname = nickname });
    if (resetweapons == 1) then
        takeAllWeapons(thePlayer)
        MySql.helper.update("user_data", { resetWeaponsAtNextLogin = 0 }, { Nickname = nickname});
    end
end

function setPlayerAusrustung()
    if (checkMunKistenDistance(source)) then
        setPlayerRearmWeapons(source, vioGetElementData(source, "fraktion"), vioGetElementData(source, "fraktionsrang"))
        outputChatBox("Standardwaffenpaket für 2000 Munition erhalten!", source, 0, 255, 0)
    end
end

function setPlayerRearmWeapons(thePlayer, Fraktion, Rang)
    takeAllWeapons(thePlayer)
    if (vioGetElementData(thePlayer, "job") == 7) then --HITMAN
    setPedArmor(thePlayer, 150)
    giveWeapon(thePlayer, 34, 25)
    giveWeapon(thePlayer, 24, 200)
    giveWeapon(thePlayer, 4)
    end
    if (Fraktion == 1) or (Fraktion == 9) then --PDS
    setPedArmor(thePlayer, 100)
    if (Rang == 1) then
        giveWeapon(thePlayer, 3)
        giveWeapon(thePlayer, 22, 500)

    elseif (Rang == 2) then
        giveWeapon(thePlayer, 3)
        giveWeapon(thePlayer, 22, 500)
        giveWeapon(thePlayer, 29, 950)

    elseif (Rang == 3) then
        giveWeapon(thePlayer, 3)
        giveWeapon(thePlayer, 24, 250)
        giveWeapon(thePlayer, 29, 1350)

    elseif (Rang == 4) then
        giveWeapon(thePlayer, 3)
        giveWeapon(thePlayer, 24, 250)
        giveWeapon(thePlayer, 29, 1350)
        giveWeapon(thePlayer, 31, 750)

    elseif (Rang == 5) then
        giveWeapon(thePlayer, 3)
        giveWeapon(thePlayer, 24, 250)
        giveWeapon(thePlayer, 29, 1500)
        giveWeapon(thePlayer, 31, 1500)

    elseif (Rang == 6) then
        giveWeapon(thePlayer, 3)
        giveWeapon(thePlayer, 24, 250)
        giveWeapon(thePlayer, 29, 1500)
        giveWeapon(thePlayer, 31, 1500)
        giveWeapon(thePlayer, 34, 50)
    end



    elseif (Fraktion == 2) then --grove
    if (2000 < frakmun[2]) then
        frakmun[2] = frakmun[2] - 2000
        abzug = 2000

        frakdepot_log(2, 3, -abzug, "Spawn-" .. getPlayerName(thePlayer))
        setPedArmor(thePlayer, 100)
        if (Rang == 1) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 23, 100)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 100)

        elseif (Rang == 2) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 23, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 350)
            giveWeapon(thePlayer, 30, 100)

        elseif (Rang == 3) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 100)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 550)
            giveWeapon(thePlayer, 30, 750)

        elseif (Rang == 4) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)

        elseif (Rang == 5) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)

        elseif (Rang == 6) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)
            giveWeapon(thePlayer, 34, 20)
        end
    end
    elseif (Fraktion == 12) then --violetta
    if (2000 < frakmun[12]) then

        frakmun[12] = frakmun[12] - 2000
        abzug = 2000

        frakdepot_log(12, 3, -abzug, "Spawn-" .. getPlayerName(thePlayer))
        setPedArmor(thePlayer, 100)
        if (Rang == 1) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 23, 100)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 100)

        elseif (Rang == 2) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 23, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 350)
            giveWeapon(thePlayer, 30, 100)

        elseif (Rang == 3) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 100)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 550)
            giveWeapon(thePlayer, 30, 750)

        elseif (Rang == 4) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)

        elseif (Rang == 5) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)

        elseif (Rang == 6) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)
            giveWeapon(thePlayer, 34, 20)
        end
    end
    elseif (Fraktion == 13) then --violetta
    if (2000 < frakmun[13]) then

        frakmun[13] = frakmun[13] - 2000
        abzug = 2000

        frakdepot_log(13, 3, -abzug, "Spawn-" .. getPlayerName(thePlayer))
        setPedArmor(thePlayer, 100)
        if (Rang == 1) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 23, 100)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 100)

        elseif (Rang == 2) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 23, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 350)
            giveWeapon(thePlayer, 30, 100)

        elseif (Rang == 3) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 100)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 550)
            giveWeapon(thePlayer, 30, 750)

        elseif (Rang == 4) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)

        elseif (Rang == 5) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)

        elseif (Rang == 6) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)
            giveWeapon(thePlayer, 34, 20)
        end
    end
    elseif (Fraktion == 3) then --NEWS
    giveWeapon(thePlayer, 43, 9999)
    elseif (Fraktion == 5) then --SEK
    setPedArmor(thePlayer, 100)
    if (Rang == 1) then
        giveWeapon(thePlayer, 3)
        giveWeapon(thePlayer, 23, 100)
        giveWeapon(thePlayer, 25, 10)
        giveWeapon(thePlayer, 29, 350)
        giveWeapon(thePlayer, 31, 100)

    elseif (Rang == 2) then
        giveWeapon(thePlayer, 3)
        giveWeapon(thePlayer, 24, 100)
        giveWeapon(thePlayer, 25, 10)
        giveWeapon(thePlayer, 29, 800)
        giveWeapon(thePlayer, 31, 250)

    elseif (Rang == 3) then
        giveWeapon(thePlayer, 3)
        giveWeapon(thePlayer, 24, 100)
        giveWeapon(thePlayer, 25, 10)
        giveWeapon(thePlayer, 29, 800)
        giveWeapon(thePlayer, 31, 1000)

    elseif (Rang == 4) then
        giveWeapon(thePlayer, 3)
        giveWeapon(thePlayer, 24, 150)
        giveWeapon(thePlayer, 25, 10)
        giveWeapon(thePlayer, 29, 800)
        giveWeapon(thePlayer, 31, 1500)

    elseif (Rang == 5) then
        giveWeapon(thePlayer, 3)
        giveWeapon(thePlayer, 24, 150)
        giveWeapon(thePlayer, 25, 10)
        giveWeapon(thePlayer, 29, 1500)
        giveWeapon(thePlayer, 31, 1500)
    elseif (Rang == 6) then
        giveWeapon(thePlayer, 3)
        giveWeapon(thePlayer, 24, 150)
        giveWeapon(thePlayer, 25, 10)
        giveWeapon(thePlayer, 29, 1500)
        giveWeapon(thePlayer, 31, 1500)
        giveWeapon(thePlayer, 34, 20)
    end
    elseif (Fraktion == 7) then --Name
    giveWeapon(thePlayer, 3)
    giveWeapon(thePlayer, 29, 1000)
    giveWeapon(thePlayer, 24, 550)
    setPedArmor(thePlayer, 100)
    giveWeapon(thePlayer, 31, 1500)
    if (Rang > 5) then
        giveWeapon(thePlayer, 34, 20)
    end
    if (Rang > 2) then
        setPedArmor(thePlayer, 150)
        giveWeapon(thePlayer, 31, 1500)
    end
    elseif (Fraktion == 6) then --LLS
    if (2000 < frakmun[6]) then

        frakmun[6] = frakmun[6] - 2000
        abzug = 2000

        frakdepot_log(6, 3, -abzug, "Spawn-" .. getPlayerName(thePlayer))
        setPedArmor(thePlayer, 100)
        if (Rang == 1) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 23, 100)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 100)

        elseif (Rang == 2) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 23, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 350)
            giveWeapon(thePlayer, 30, 100)

        elseif (Rang == 3) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 100)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 550)
            giveWeapon(thePlayer, 30, 750)

        elseif (Rang == 4) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)

        elseif (Rang == 5) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)

        elseif (Rang == 6) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)
            giveWeapon(thePlayer, 34, 20)
        end
    end
    elseif (Fraktion == 11) then --CF
    if (2000 < frakmun[11]) then

        frakmun[11] = frakmun[11] - 2000
        abzug = 2000

        frakdepot_log(11, 3, -abzug, "Spawn-" .. getPlayerName(thePlayer))
        setPedArmor(thePlayer, 100)

        if (Rang == 1) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 23, 100)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 100)

        elseif (Rang == 2) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 23, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 350)
            giveWeapon(thePlayer, 30, 100)

        elseif (Rang == 3) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 100)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 550)
            giveWeapon(thePlayer, 30, 750)

        elseif (Rang == 4) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)

        elseif (Rang == 5) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)

        elseif (Rang == 6) then
            giveWeapon(thePlayer, 5)
            giveWeapon(thePlayer, 24, 150)
            giveWeapon(thePlayer, 25, 10)
            giveWeapon(thePlayer, 29, 1500)
            giveWeapon(thePlayer, 30, 1500)
            giveWeapon(thePlayer, 34, 20)
        end
    end
    end
end

addEvent("giveMeStandardAusrustung", true)
addEventHandler("giveMeStandardAusrustung", getRootElement(), setPlayerAusrustung)










