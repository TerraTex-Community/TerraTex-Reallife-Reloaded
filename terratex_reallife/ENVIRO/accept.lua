function accept_ticket_func(thePlayer, Command, types)
    if (types == "race") then
        acceptRace(thePlayer)
    elseif (types == "hotdog") then
        local hotDogSeller = vioGetElementData(thePlayer, "hotDogSeller")
        local hotDogSellerPrice = vioGetElementData(thePlayer, "hotDogSellerPrice")
        local hotDogSellerMenge = vioGetElementData(thePlayer, "hotDogSellerMenge")

        if (hotDogSeller and hotDogSellerPrice and hotDogSellerMenge) then
            if (getPlayerName(hotDogSeller)) then
                if (getPlayerMoney(thePlayer) >= hotDogSellerPrice) then
                    if (isPedInVehicle(hotDogSeller)) then
                        local theVehicle = getPedOccupiedVehicle(hotDogSeller)
                        if (getPedOccupiedVehicleSeat(hotDogSeller) == 0 and (getElementModel(theVehicle) == 588)) then
                            local x, y, z = getElementPosition(thePlayer)
                            local px, py, pz = getElementPosition(hotDogSeller)
                            if (getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 20) then
                                if (hotDogSellerMenge <= vioGetElementData(theVehicle, "hotdogFuel")) then
                                    vioSetElementData(theVehicle, "hotdogFuel", vioGetElementData(theVehicle, "hotdogFuel") - hotDogSellerMenge)
                                    changePlayerMoney(thePlayer, -hotDogSellerPrice, "sonstiges", "Hotdogkauf")
                                    changePlayerMoney(hotDogSeller, hotDogSellerPrice, "job", "Hotdog", "Verkauf")
                                    outputChatBox(string.format("Der Spieler %s hat deine Hotdogs gekauft!", getPlayerName(thePlayer)), hotDogSeller, 0, 155, 0)
                                    outputChatBox("Du hast die Hotdogs gekauft und gegessen!", thePlayer, 0, 155, 0)
                                    triggerClientEvent(thePlayer, "addFood", thePlayer, 25 * hotDogSellerMenge)
                                else
                                    showError(thePlayer, "Der Verkäufer ist nicht in der Lage dir die Hotdogs zu verkaufen! (keine Ausreichende Menge)")
                                end
                            else
                                showError(thePlayer, "Der Verkäufer ist nicht in deiner Nähe!")
                            end
                        else
                            showError(thePlayer, "Der Verkäufer ist nicht in der Lage dir die Hotdogs zu verkaufen! (nicht mehr im Hotdogwagen)")
                        end
                    else
                        showError(thePlayer, "Der Verkäufer ist nicht in der Lage dir die Hotdogs zu verkaufen! (nicht mehr im Hotdogwagen)")
                    end
                else
                    showError(thePlayer, "Du hast nicht genug Geld!")
                end
            else
                showError(thePlayer, "Dir wurden keine Hotdogs angeboten!")
            end
        else
            showError(thePlayer, "Dir wurden keine Hotdogs angeboten!")
        end
        vioSetElementData(toPlayer, "hotDogSeller", false)
        vioSetElementData(toPlayer, "hotDogSellerPrice", false)
        vioSetElementData(toPlayer, "hotDogSellerMenge", false)
    elseif (types == "sex") then
        if (vioGetElementData(thePlayer, "sexAngebotVon")) then
            local toPlayer = vioGetElementData(thePlayer, "sexAngebotVon")
            if (toPlayer) then
                local p1x, p1y, p1z = getElementPosition(thePlayer)
                local p2x, p2y, p2z = getElementPosition(toPlayer)
                if (vioGetElementData(toPlayer, "job") == 16) then
                    if (isPlayerInAnyHouse(thePlayer) or arePlayersInSameVehicle(thePlayer, toPlayer)) then
                        local p1x, p1y, p1z = getElementPosition(thePlayer)
                        local p2x, p2y, p2z = getElementPosition(toPlayer)
                        if (getDistanceBetweenPoints3D(p1x, p1y, p1z, p2x, p2y, p2z) < 5) then
                            setElementData(thePlayer, "sexAngebotVon", false)
                            local usedKondom = false
                            if (vioGetElementData(thePlayer, "Kondome") > 0) then
                                vioSetElementData(thePlayer, "Kondome", vioGetElementData(thePlayer, "Kondome") - 1)
                                usedKondom = true
                            elseif (vioGetElementData(toPlayer, "Kondome") > 0) then
                                vioSetElementData(toPlayer, "Kondome", vioGetElementData(toPlayer, "Kondome") - 1)
                                usedKondom = true
                            end
                            if (usedKondom or math.random(1, 2) ~= 2) then
                                triggerClientEvent(thePlayer, "stopFoodTimerForSeconds", thePlayer, 300)
                                triggerClientEvent(toPlayer, "stopFoodTimerForSeconds", toPlayer, 300)
                                outputChatBox("Ihr hattet gerade Sex und seid so gut drauf, dass ihr nun 5 Minuten nichts essen müsst!", thePlayer, 0, 255, 0)
                                outputChatBox("Ihr hattet gerade Sex und seid so gut drauf, dass ihr nun 5 Minuten nichts essen müsst!", toPlayer, 0, 255, 0)
                            else
                                triggerClientEvent(thePlayer, "krankheitsreduce", thePlayer)
                                triggerClientEvent(toPlayer, "krankheitsreduce", toPlayer)
                                if (getElementHealth(thePlayer) > 25) then setElementHealth(thePlayer, 25) end
                                if (getElementHealth(toPlayer) > 25) then setElementHealth(toPlayer, 25) end
                                outputChatBox("Da ihr keine Kondome hattet, habt ihr eine Geschlechtskrankheit bekommen!", thePlayer, 0, 255, 0)
                                outputChatBox("Da ihr keine Kondome hattet, habt ihr eine Geschlechtskrankheit bekommen!", toPlayer, 0, 255, 0)
                            end
                            if not (arePlayersInSameVehicle(thePlayer, toPlayer)) then
                                local x, y, z = getElementPosition(toPlayer)
                                setElementPosition(thePlayer, x, y, z)
                                local rx, ry, rz = getElementRotation(toPlayer)
                                setElementRotation(thePlayer, rx, ry, rz)
                                setPedAnimation(thePlayer, "sex", "sex_1_cum_w", 1, true, false)
                                setPedAnimation(toPlayer, "sex", "sex_1_cum_p", 1, true, false)
                                vioSetElementData(toPlayer, "anim", 1)
                                bindKey(toPlayer, "space", "down", stopanima)
                                showtext(toPlayer)

                                vioSetElementData(thePlayer, "anim", 1)
                                bindKey(thePlayer, "space", "down", stopanima)
                                showtext(thePlayer)
                            end
                        else
                            showError(thePlayer, "Ihr beide seit nicht beeinander!")
                        end
                    else
                        showError(thePlayer, "Sie müssen in einen Fahrzeug sein oder in einem Haus um Sex zu haben!")
                    end
                elseif (vioGetElementData(toPlayer, "DBID") == vioGetElementData(thePlayer, "verheiratet")) then
                    if (isPlayerInAnyHouse(thePlayer) or arePlayersInSameVehicle(thePlayer, toPlayer)) then

                        if (getDistanceBetweenPoints3D(p1x, p1y, p1z, p2x, p2y, p2z) < 5) then
                            setElementData(thePlayer, "sexAngebotVon", false)
                            local usedKondom = false
                            if (vioGetElementData(thePlayer, "Kondome") > 0) then
                                vioSetElementData(thePlayer, "Kondome", vioGetElementData(thePlayer, "Kondome") - 1)
                                usedKondom = true
                            elseif (vioGetElementData(toPlayer, "Kondome") > 0) then
                                vioSetElementData(toPlayer, "Kondome", vioGetElementData(toPlayer, "Kondome") - 1)
                                usedKondom = true
                            end
                            if (usedKondom or math.random(1, 4) ~= 2) then
                                triggerClientEvent(thePlayer, "stopFoodTimerForSeconds", thePlayer, 300)
                                triggerClientEvent(toPlayer, "stopFoodTimerForSeconds", toPlayer, 300)
                                outputChatBox("Ihr hattet gerade Sex und seid so gut drauf, dass ihr nun 5 Minuten nichts essen müsst!", thePlayer, 0, 255, 0)
                                outputChatBox("Ihr hattet gerade Sex und seid so gut drauf, dass ihr nun 5 Minuten nichts essen müsst!", toPlayer, 0, 255, 0)
                            else
                                local kosten = math.random(400, 1500)
                                changePlayerMoney(thePlayer, -kosten, "sonstiges", "Kindergeld (Sex)")
                                changePlayerMoney(toPlayer, -kosten, "sonstiges", "Kindergeld (Sex)")
                                outputChatBox(string.format("Ihr habt ein Kind gezeugt! Die Kosten haben sich auf %s für jeden von euch belaufen!", toprice(kosten)), thePlayer)
                                outputChatBox(string.format("Ihr habt ein Kind gezeugt! Die Kosten haben sich auf %s für jeden von euch belaufen!", toprice(kosten)), toPlayer)
                            end
                            if not (arePlayersInSameVehicle(thePlayer, toPlayer)) then
                                local x, y, z = getElementPosition(toPlayer)
                                setElementPosition(thePlayer, x, y, z)
                                local rx, ry, rz = getElementRotation(toPlayer)
                                setElementRotation(thePlayer, rx, ry, (180 - rz))
                                setPedAnimation(thePlayer, "sex", "sex_1_cum_w", 1, true, false)
                                setPedAnimation(toPlayer, "sex", "sex_1_cum_p", 1, true, false)
                                vioSetElementData(toPlayer, "anim", 1)
                                bindKey(toPlayer, "space", "down", stopanima)
                                showtext(toPlayer)

                                vioSetElementData(thePlayer, "anim", 1)
                                bindKey(thePlayer, "space", "down", stopanima)
                                showtext(thePlayer)
                            end
                        else
                            showError(thePlayer, "Ihr beide seit nicht beeinander!")
                        end
                    else
                        showError(thePlayer, "Sie müssen in einen Fahrzeug sein oder in einem Haus um Sex zu haben!")
                    end
                else
                    showError(thePlayer, "Du kannst kein Sex mit dieser Person haben!")
                end
            else
                showError(thePlayer, "Dir wurde kein Sex angeboten!")
            end
        else
            showError(thePlayer, "Dir wurde kein Sex angeboten!")
        end
    elseif (types == "stellen") then
        if (vioGetElementData(thePlayer, "canStellen")) then
            local x, y, z = getElementPosition(thePlayer)
            if (getDistanceBetweenPoints3D(x, y, z, 238.961914062, 112.734375, 1003.21875) < 10 or getDistancBetweenPoints3D(x, y, z, 233.044921875, 166.4814453125, 1003.0234375)) then
                vioSetElementData(thePlayer, "stellenInfos", vioGetElementData(thePlayer, "wanteds"))
                setTimer(StellenNow, 180000, 1, thePlayer)
                outputChatBox("Bitte warte hier 3 Minuten bis deine Anfrage bearbeitet wurde!", thePlayer, 255, 0, 0)
                vioSetElementData(thePlayer, "canStellen", false)
            end
        end
    elseif (types == "premium") then
        if (vioGetElementData(thePlayer, "buyPremiumStart") == 1947) then
            vioSetElementData(thePlayer, "buyPremiumStart", 0)
            if (getPlayerMoney(thePlayer) < 50000) then
                outputChatBox("Du hast nicht genügend Geld um Premium zu kaufen!", thePlayer, 255, 0, 0)
            else
                local time = getRealTime()
                local nickname = getPlayerName(thePlayer)

                local premiumOutTime = MySql.helper.getValueSync("user_premium", "PremiumUntil", { Name = nickname }) - time.timestamp;
                local hasPremGutSchein = MySql.helper.getValueSync("user_premium", "PremiumGutScheine", { Name = nickname });

                local thirty = 2592000
                outputChatBox("Dir wurden 30 Tage Premium gutgeschrieben!", thePlayer, 0, 255, 0)
                if (hasPremGutSchein > 0) then
                    thirty = 3196800
                    MySql.helper.update("user_premium", { PremiumGutScheine = (hasPremGutSchein - 1) }, { Name = nickname });
                    outputChatBox("Da du ein Premiumgutschein hast, wurde dir bei diesem Kauf 7 Tage mehr Premium gutgeschrieben!", thePlayer, 0, 255, 0)
                end
                if (premiumOutTime > 0) then
                    thirty = thirty + premiumOutTime
                end
                MySql.helper.update("user_premium", { PremiumUntil = (time.timestamp + thirty) }, { Name = nickname });
                vioSetElementData(thePlayer, "premium", (time.timestamp + thirty))
                outputChatBox(string.format("Du hast nun noch %s Tage Premium!", math.round((((thirty / 60) / 60) / 24))), thePlayer, 0, 255, 0)
                changePlayerMoney(thePlayer, -50000, "sonstiges", "Premium")

                MySql.helper.insert("log_premium", {
                    Nickname = getPlayerName(thePlayer),
                    how = "ingamegeld"
                });
            end
        else
            outputChatBox("Du solltest erst einen Kauf starten bevor du ihn bestätigst! (/buypremium)", thePlayer, 255, 0, 0)
        end
    elseif (types == "schutz") then
        if (vioGetElementData(thePlayer, "schutzzahlung")) then
            local frak = vioGetElementData(thePlayer, "schutzfrak")
            for theKey, thePlayers in ipairs(getPlayersInTeam(team[frak])) do
                outputChatBox(string.format("%s hat Schutzgeld gezahlt!", getPlayerName(thePlayer)), thePlayers, 255, 0, 0)
            end
            outputChatBox(string.format("Du hast Schutzgeld an die %s gezahlt!", fraktionbezeichner[frak]), thePlayer, 255, 0, 0)
            changePlayerMoney(thePlayer, -vioGetElementData(thePlayer, "schutzzahlung"), "sonstiges", "Schutzgeldzahlung")
            frakkasse[frak] = frakkasse[frak] + vioGetElementData(thePlayer, "schutzzahlung")
            frakschutz[frak][getPlayerName(thePlayer)] = true
            vioSetElementData(thePlayer, "schutzzahlung", false)
            vioSetElementData(thePlayer, "schutzfrak", false)
        else
            outputChatBox("Du hast keine offenen Schutzgeldforderungen!", thePlayer, 255, 0, 0)
        end
    elseif (types == "anwalt") then
        if (isBeamter(thePlayer)) then
            local anwalt = vioGetElementData(thePlayer, "anwaltWhoRequested")
            local verbrecher = vioGetElementData(thePlayer, "thePlayerWhoWillBeOutOfKnast")
            if (anwalt and verbrecher) then
                vioSetElementData(anwalt, "AnwaltCanGetOut", verbrecher)
                outputChatBox("Du hast dem Anwalt erlaubt den Verbrecher herauszuholen", thePlayer, 255, 0, 0)
                outputChatBox("Dir wurde erlaubt, den Verbrecher herauszuholen. Dies kannst du mit /free tun.", anwalt, 255, 0, 0)
                vioSetElementData(cop, "anwaltWhoRequested", nil)
                vioSetElementData(cop, "thePlayerWhoWillBeOutOfKnast", nil)
            else
                outputChatBox("Du wurdest um keine Erlaubnis gebeten", thePlayer, 255, 0, 0)
            end
        end
    elseif (types == "repair") then

        if (vioGetElementData(thePlayer, "mechaPrice")) then
            if (getPlayerMoney(thePlayer) < vioGetElementData(thePlayer, "mechaPrice")) then
                showError(thePlayer, "Du hast nicht genügend Geld!")
            else
                local mecha = vioGetElementData(thePlayer, "mechaPlayer")
                local toPlayer = mecha
                if (isElement(mecha)) then
                    local x, y, z = getElementPosition(thePlayer)
                    local xs, ys, zs = getElementPosition(mecha)
                    local dis = getDistanceBetweenPoints3D(x, y, z, xs, ys, zs)
                    if (dis < 20) then
                        if (isPedInVehicle(thePlayer)) then
                            local theVehicle = getPedOccupiedVehicle(thePlayer)
                            local vx, vy, vz = getElementVelocity(theVehicle)
                            local speed = math.round(math.sqrt(vx * vx + vy * vy + vz * vz))
                            if (speed == 0) then
                                changePlayerMoney(thePlayer, -vioGetElementData(thePlayer, "mechaPrice"), "sonstiges", "Mechanikerkosten")
                                vioSetElementData(toPlayer, "hasRepaired", true)
                                local timer = ((1000 - getElementHealth(theVehicle)) * 30)
                                local m, mn, mb, mv = getVehicleWheelStates(theVehicle)
                                local m = m + mn + mb + mv
                                timer = timer + m * 5000
                                if (timer < 500) then
                                    timer = 500
                                end
                                setTimer(resetHasRepaired, timer + 500, 1, toPlayer, theVehicle, thePlayer)
                                setElementFrozen(theVehicle, true)
                                vioSetElementData(theVehicle, "isInRepairProcedur", true)
                                setVehicleEngineState(theVehicle, false)
                                vioSetElementData(theVehicle, "motor", false)
                                vioSetElementData(theVehicle, "motornum", 0)
                                changePlayerMoney(toPlayer, vioGetElementData(toPlayer, "mechaPrice") - 50, "job", "Mechaniker", "Reparatur")
                                vioSetElementData(toPlayer, "mechaPrice", false)
                                vioSetElementData(toPlayer, "mechaPlayer", false)
                                --fixVehicle ( theVehicle )
                            else
                                showError(thePlayer, "Ein Fahrzeug kann nur im Stand repariert werden!")
                            end
                        else
                            showError(thePlayer, "Du bist in keinem Fahrzeug!")
                        end
                    else
                        showError(thePlayer, "Du bist nicht in der Nähe des Mechanikers!")
                    end
                end
            end
        else
            showError(thePlayer, "Kein Mechaniker hat dir eine Reparatur angeboten!")
        end
    elseif (types == "ticket") then
        if (vioGetElementData(thePlayer, "ticket")) then
            if (vioGetElementData(thePlayer, "ticket") > 0) then
                local sx, sy, sz = getElementPosition(thePlayer)
                local tx, ty, tz = getElementPosition(vioGetElementData(thePlayer, "ticketgive"))
                local dis = getDistanceBetweenPoints3D(sx, sy, sz, tx, ty, tz)
                if (dis > 10) then
                    showError(thePlayer, "Sie sind vom Polizisten zuweit entfernt!")
                else
                    changePlayerMoney(thePlayer, -vioGetElementData(thePlayer, "ticket"), "sonstiges", "Ticket bezahlt")
                    outputChatBox("Du hast das Ticket erfolgreich bezahlt", thePlayer, 255, 0, 0)
                    outputChatBox(string.format("%s hat das Ticket bezahlt!", getPlayerName(thePlayer)), vioGetElementData(thePlayer, "ticketgive"), 255, 0, 0)
                    vioSetElementData(thePlayer, "ticketgive", nil)
                    vioSetElementData(thePlayer, "ticket", nil)
                end
            else
                showError(thePlayer, "Dir wurde kein Ticket angeboten!")
            end
        else
            showError(thePlayer, "Dir wurde kein Ticket angeboten!")
        end
    elseif (types == "live") then
        if (vioGetElementData(thePlayer, "isInviteToNewsLive")) then
            if (liveLeader) then
                local px, py, pz = getElementPosition(thePlayer)
                local ix, iy, iz = getElementPosition(liveLeader)
                local dis = getDistanceBetweenPoints3D(px, py, pz, ix, iy, iz)
                if (dis < 20) then
                    table.insert(livePlayers, thePlayer)
                    vioSetElementData(thePlayer, "isInNewsLive", true)
                    outputChatBox("Du bist dem Livegespräch beigetretten!", thePlayer, 255, 150, 150)
                    outputChatBox(string.format("%s ist dem Livegespräch beigetretten!", getPlayerName(thePlayer)), liveLeader, 255, 150, 150)

                else
                    showError(thePlayer, "Du bist nicht in der Nähe des Gesprächsleiters!")
                end
            else
                showError(thePlayer, "Das Livegespraech wurde inzwischen beendet!")
            end
        else
            showError(thePlayer, "Du wurdest in kein Livegespräch eingeladen!")
        end
        vioSetElementData(thePlayer, "isInviteToNewsLive", nil)
    elseif (types == "drogen") then
        if (vioGetElementData(thePlayer, "DrugTradeFrom")) then
            local sx, sy, sz = getElementPosition(thePlayer)
            local tx, ty, tz = getElementPosition(vioGetElementData(thePlayer, "DrugTradeFrom"))
            local dis = getDistanceBetweenPoints3D(sx, sy, sz, tx, ty, tz)
            if (dis > 10) then
                showError(thePlayer, "Sie sind vom Drogendealer zuweit entfernt!")
            else
                local drugDealer = vioGetElementData(thePlayer, "DrugTradeFrom")
                if (vioGetElementData(drugDealer, "drogen") < vioGetElementData(thePlayer, "DrugTradeMenge")) then
                    showError(thePlayer, "Der DrogenDealer hat nicht mehr so viele Drogen!")
                else
                    if (getPlayerMoney(thePlayer) < vioGetElementData(thePlayer, "DrugTradePrice")) then
                        showError(thePlayer, "Du hast genuegend Geld!")
                    else
                        vioSetElementData(thePlayer, "drogen", vioGetElementData(thePlayer, "drogen") + vioGetElementData(thePlayer, "DrugTradeMenge"))
                        vioSetElementData(drugDealer, "drogen", vioGetElementData(drugDealer, "drogen") - vioGetElementData(thePlayer, "DrugTradeMenge"))
                        changePlayerMoney(thePlayer, -vioGetElementData(thePlayer, "DrugTradePrice"), "sonstiges", "Drogenkauf")
                        changePlayerMoney(drugDealer, vioGetElementData(thePlayer, "DrugTradePrice"), "job", "Drogendealer", "Verkauf")
                        outputChatBox("Du hast die Drogen erfolgreich angenohmen", thePlayer, 0, 250, 150)
                        outputChatBox(string.format("%s hat die Drogen angenohmen!", getPlayerName(thePlayer)), drugDealer, 0, 250, 150)
                    end
                end
                vioSetElementData(thePlayer, "DrugTradeFrom", false)
                vioSetElementData(thePlayer, "DrugTradePrice", false)
                vioSetElementData(thePlayer, "DrugTradeMenge", false)
            end
        end
    else
        showError(thePlayer, "Du kannst nur folgende Sachen Aktzeptieren: ticket, drogen, live")
    end
end
addCommandHandler("accept", accept_ticket_func, false, false)








