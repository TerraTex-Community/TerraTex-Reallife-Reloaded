function update_play_time_func()
    setTimer(update_play_time_func, 60000, 1)

    local playstime = 0
    for theKey, thePlayer in ipairs(getElementsByType("player")) do
        if (isPlayerLoggedIn(thePlayer)) then
            if (vioGetElementData(thePlayer, "afk_status") == 0) then
                vioSetElementData(thePlayer, "playtime", (vioGetElementData(thePlayer, "playtime") + 1))
                local paydaytime = math.mod((vioGetElementData(thePlayer, "playtime")), 60)
                if (paydaytime == 0) then
                    payday(thePlayer)
                end
                checkTimeErfolge(thePlayer, (vioGetElementData(thePlayer, "playtime") / 60))
                if (vioGetElementData(thePlayer, "playtime") < (25 * 60)) then
                    setPlayerNametagText(thePlayer, "[ROOKIE]-" .. getPlayerName(thePlayer))
                else
                    setPlayerNametagText(thePlayer, getPlayerName(thePlayer))
                end
                local minuten = math.round((math.round(vioGetElementData(thePlayer, "playtime") / 60, 2) - math.round(vioGetElementData(thePlayer, "playtime") / 60, 0, "floor")) * 60)
                if (minuten < 10) then
                    minuten = "0" .. tostring(minuten)
                else
                    minuten = tostring(minuten)
                end
                local timestring = tostring(math.round(vioGetElementData(thePlayer, "playtime") / 60, 0, "floor")) .. "|" .. minuten
                vioSetElementData(thePlayer, "playTime_formated", timestring)
            end
        end
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), update_play_time_func)

function checkTimeErfolge(thePlayer, PlayTime)
    if (PlayTime > 50) then
        if (vioGetElementData(thePlayer, "Erfolg_First_50") == 0) then
            vioSetElementData(thePlayer, "Erfolg_First_50", 1)
            triggerClientEvent(thePlayer, "onClientCreatePokalGUI", thePlayer, "First 50", "50 Spielstunden erreicht")
        end
    end

    if (PlayTime > 100) then
        if (vioGetElementData(thePlayer, "Erfolg_First_100") == 0) then
            vioSetElementData(thePlayer, "Erfolg_First_100", 1)
            triggerClientEvent(thePlayer, "onClientCreatePokalGUI", thePlayer, "First 100", "100 Spielstunden erreicht")
        end
    end

    if (PlayTime > 1000) then
        if (vioGetElementData(thePlayer, "Erfolg_First_1000") == 0) then
            vioSetElementData(thePlayer, "Erfolg_First_1000", 1)
            triggerClientEvent(thePlayer, "onClientCreatePokalGUI", thePlayer, "First 1000", "1000 Spielstunden erreicht")
        end
    end
end




function controlWeber(thePlayer)
    if math.round(vioGetElementData(thePlayer, "playtime") / 60) == 25 then
        local werber = MySql.helper.getValueSync("user", "werber", { Nickname = getPlayerName(thePlayer) });

        if (MySql.helper.existSync("user", {Nickname = werber })) then

            if (getPlayerName(thePlayer) ~= werber) then
                MySql.helper.insert("user_gifts", {
                    Nickname = werber,
                    Geld = 1500,
                    Grund = "Der von dir geworbene Spieler " .. getPlayerName(thePlayer) .. " hat 25 Spielstunden erreicht!"
                });
                dbExec(MySql._connection, "UPDATE user_data SET werbernum = werbernum + 1 WHERE Nickname = ?", werber);
                local maxwerb = MySql.helper.getValueSync("user_data", "werbernum", { Nickname = werber });

                if (maxwerb == 5) then
                    MySql.helper.update("user_data", {werbernum = 0}, {Nickname = werber});

                    MySql.helper.insert("user_gifts", {
                        Nickname = werber,
                        Geld = 10000,
                        VehSlots = 2,
                        Grund = "Es haben 5 von dir Geworbene Spieler 25 Spielstunden erreicht!"
                    });

                end
            end
        end
    end
end

function payday(thePlayer)
    triggerClientEvent(thePlayer, "spawnHufeisen", thePlayer)
    vioSetElementData(thePlayer, "todelast", 0)
    if (vioGetElementData(thePlayer, "Hufeisenhelfer") > 0) then
        vioSetElementData(thePlayer, "Hufeisenhelfer", vioGetElementData(thePlayer, "Hufeisenhelfer") - 1)
    end

    local Einnahmen = 0
    local Ausgaben = 0
    local PayDayTable = {}

    --- GEHALTS BERECHNUNG ---

    local Gehalt = 0
    local sozial = getSozialStatus(thePlayer, false)
    local canGetArbeitsGehalt = true

    local Gehalt = math.random(200, 275) * sozial
    if (vioGetElementData(thePlayer, "hkey") == 0) and (vioGetElementData(thePlayer, "playtime") > 1500) then
        outputChatBox("Du hast keine Zahlungsanschrift, du kannst kein Gehalt erhalten. Miete dich ein oder Kauf ein Haus!", thePlayer)
        Gehalt = 0
        canGetArbeitsGehalt = false
    end
    table.insert(PayDayTable, { string.format("Gehalt mit Sozialstatus %s (/social)", sozial), Gehalt, 0 })
    Einnahmen = Einnahmen + Gehalt


    local jobgehalt = vioGetElementData(thePlayer, "addPayDayGehalt")
    if (jobgehalt > 0 and canGetArbeitsGehalt) then
        vioSetElementData(thePlayer, "addPayDayGehalt", 0)
        Gehalt = Gehalt + jobgehalt
        Einnahmen = Einnahmen + jobgehalt
        table.insert(PayDayTable, { "zusätzliches Gehalt (z.B. durch Jobs)", jobgehalt, 0 })
    end

    if (vioGetElementData(thePlayer, "fraktion") > 0) then

        local bonus = MySql.helper.getValueSync("faction_inventory", "gehalt", { FrakID = vioGetElementData(thePlayer, "fraktion") });
        if not bonus then
            bonus = 0;
        end
        
        Einnahmen = Einnahmen + bonus

        if (bonus > 0) then
            table.insert(PayDayTable, { "Bonusgehalt für die Fraktion", bonus, 0 })
        end
    end

    --Serversteuerberechnung
    local steuer = math.round(Gehalt / 100 * serversettings["steuersatz"])
    if (vioGetElementData(thePlayer, "verheiratet") ~= 0) then
        steuer = steuer / 2
        table.insert(PayDayTable, { "Serversteuer mit " .. (serversettings["steuersatz"] / 2) .. " Prozent (Hälfte durch Heirat)", 0, (-steuer) })
    else
        table.insert(PayDayTable, { "Serversteuer mit " .. serversettings["steuersatz"] .. " Prozent", 0, (-steuer) })
    end
    if (math.round(vioGetElementData(thePlayer, "playtime") / 60) < 25) then
        steuer = 0
    end
    save_steuer_log(thePlayer, steuer, "steuer")
    Ausgaben = Ausgaben + steuer

    --Sozialabgabenberechnung
    local proz = serversettings["sozialabgabesatz"]
    if (math.round(vioGetElementData(thePlayer, "playtime") / 60) < 25) then
        outputChatBox("Als Rookie unter 25 Spielstunden musst du noch keine Steuern und Sozialabgaben zahlen.", thePlayer, 255, 0, 0)
        proz = 0
    end

    if (vioGetElementData(thePlayer, "lebensversicherung") == 1) then
        proz = proz + 10
    end

    local sozialabgaben = math.round(Gehalt / 100 * proz)
    save_steuer_log(thePlayer, sozialabgaben, "sozial")


    table.insert(PayDayTable, { "Sozialabgaben mit " .. serversettings["sozialabgabesatz"] .. " Prozent", 0, (-sozialabgaben) })
    Ausgaben = Ausgaben + sozialabgaben

    --Berechnung Fraktionssteuer
    if (vioGetElementData(thePlayer, "fraktion") > 0) then
        fraksteuermenge = math.round(Gehalt / 100 * (fraksteuer[vioGetElementData(thePlayer, "fraktion")]))
        table.insert(PayDayTable, { "Fraktionssteuer mit " .. fraksteuer[vioGetElementData(thePlayer, "fraktion")] .. " Prozent", 0, (-fraksteuermenge) })
        Ausgaben = Ausgaben + fraksteuermenge
        frakkasse[vioGetElementData(thePlayer, "fraktion")] = frakkasse[vioGetElementData(thePlayer, "fraktion")] + fraksteuermenge
    end

    --Berechnung Überweisungssteuer
    if (vioGetElementData(thePlayer, "ueberweisungssumme") > 50000) then
        local Ueberweisungssteuermenge = vioGetElementData(thePlayer, "ueberweisungssumme") / 100 * serversettings["Ueberweisungssteuer"]
        table.insert(PayDayTable, { "Überweisungssteuer mit " .. serversettings["Ueberweisungssteuer"] .. " Prozent", 0, (-Ueberweisungssteuermenge) })
        Ausgaben = Ausgaben + Ueberweisungssteuermenge
    end
    vioSetElementData(thePlayer, "ueberweisungssumme", 0)


    --- Berechnung Fahrzeugsteuer
    fahrzeugsteuer = 0
    local freeslots = vioGetElementData(thePlayer, "maxslots")
    for zah = vioGetElementData(thePlayer, "maxslots"), 1, -1 do
        if tonumber(vioGetElementData(thePlayer, "slot" .. zah)) == -1 then
            freeslots = freeslots - 1
        end
    end
    if (math.round(vioGetElementData(thePlayer, "playtime") / 60) > 25) then
        fahrzeugsteuer = freeslots * 2.50
    end
    if (freeslots > 2) then
        fahrzeugsteuer = 2 * 2.50 + (freeslots - 2) * 25.00
    end
    if (fahrzeugsteuer > 0) then
        table.insert(PayDayTable, { "Fahrzeugsteuer", 0, (-fahrzeugsteuer) })
        Ausgaben = Ausgaben + fahrzeugsteuer
    end

    -- versicherung
    if (vioGetElementData(thePlayer, "versicherung") == 1) then
        local zah = freeslots * 15
        Ausgaben = Ausgaben + zah
        table.insert(PayDayTable, { "Fahrzeugversicherung", 0, (-zah) })
    end


    --Spielzeitbonus
    local Spielzeitbonus = math.round(vioGetElementData(thePlayer, "playtime") / 200)
    table.insert(PayDayTable, { "Spielzeitbonus", Spielzeitbonus, 0 })
    Einnahmen = Einnahmen + Spielzeitbonus

    --Prestigebonus
    local pboni = 0
    if (vioGetElementData(thePlayer, "prestigeKey") > 0) then
        local id = vioGetElementData(thePlayer, "prestigeKey")
        local pboni = math.round(getPayDayBonus(id), 2)
        table.insert(PayDayTable, { "Prestigebonus", pboni, 0 })
        Einnahmen = Einnahmen + pboni
    end



    --Geburstagsbonus
    local dates = getRealTime()
    if (dates.month + 1 == vioGetElementData(thePlayer, "Geb_M") and dates.monthday == vioGetElementData(thePlayer, "Geb_T")) then
        local bonus = Einnahmen * 0.25
        table.insert(PayDayTable, { "Geburstagsbonus", (bonus), 0 })
        Einnahmen = Einnahmen + bonus
    end

    -- Heirat
    local heiratsabgaben = 0
    local heiratgesamt = Einnahmen - Ausgaben
    if (vioGetElementData(thePlayer, "verheiratet") ~= 0) then
        local missMariage = false
        for theKey, thePlayers in ipairs(getElementsByType("player")) do
            if (vioGetElementData(thePlayers, "DBID") == vioGetElementData(thePlayer, "verheiratet")) then
                missMariage = thePlayers
            end
        end
        if (missMariage) then
            if ((getPlayerMoney(thePlayer) + getPlayerBank(thePlayer)) > (getPlayerMoney(missMariage) + getPlayerBank(missMariage))) then
                heiratsabgaben = math.round(heiratgesamt / 10)
                changePlayerMoney(missMariage, heiratsabgaben, "sonstiges", "Ehepartnerausgleich")
                outputChatBox("Dir wurden " .. heiratsabgaben .. "$ Ausgleich von dem PayDay deines Ehepartners gezahlt!", missMariage, 0, 191, 70)
            end
        end
    end
    if (heiratsabgaben > 0) then
        table.insert(PayDayTable, { "Ehepartnerausgleich", 0, (-heiratsabgaben) })
        Ausgaben = Ausgaben + heiratsabgaben
    end
    --Berechnung Noobboni
    if (math.round(vioGetElementData(thePlayer, "playtime") / 60) < 50) then
        table.insert(PayDayTable, { "Anfängerbonus für Spieler unter 50h", Einnahmen, 0 })
        Einnahmen = Einnahmen * 2
    end

    --gesantrechnung
    local Gesamt = Einnahmen - Ausgaben
    --Miete
    local miete = 0
    local isinrent = 0
    local showMieteString = false
    if (vioGetElementData(thePlayer, "hkey") < 0) then
        local hnum = -vioGetElementData(thePlayer, "hkey")
        if (haeuser[hnum]) then
            local haus = haeuser[hnum]
            local rentcost = haus:getMiete()

            if (haus:getIRaum() == 0) then
                vioSetElementData(thePlayer, "hkey", 0)
                isinrent = -1
            end

            if (rentcost > Gesamt and not (isinrent == -1)) then
                if (getPlayerBank(thePlayer) < rentcost) then
                    vioSetElementData(thePlayer, "hkey", 0)
                    isinrent = -1
                else
                    changePlayerBank(thePlayer, -rentcost, "sonstiges", "Miete")
                    haus:changeKasse(rentcost)
                    table.insert(PayDayTable, { "Miete", 0, (-rentcost) })
                    showMieteString = true
                    isinrent = 10000
                end
            else
                haus:changeKasse(rentcost)
                Gesamt = Gesamt - rentcost
                Ausgaben = Ausgaben + rentcost
                table.insert(PayDayTable, { "Miete", 0, (-rentcost) })
                isinrent = 10000
            end
            if (isinrent > 0) then
                --Kosten der Mieter: 50$+preis/1000 aber nicht mehr als 300$
                local abzug = 50 + (haus:getPreis() / 1000);

                if (abzug < 501) then
                    haus:changeKasse(-math.round(abzug, 2))
                    outputDebugString(" House: " .. hnum .. " : " .. math.round(abzug, 2))
                else
                    haus:changeKasse(-500)
                    outputDebugString(" House: " .. hnum .. " : 500")
                end

                if (haus:getKasse() < 0) then
                    haus:setKasse(0)
                    vioSetElementData(thePlayer, "hkey", 0)
                    isinrent = -2
                    outputChatBox("Der Besitzer des Hauses kann sich keine Mieter mehr leisten", thePlayer, 255, 0, 0)
                end
            end


        else
            vioGetElementData(thePlayer, "hkey", 0)
        end
    end

    --- Show The Pay Day
    outputChatBox("|______________|PayDay|______________|", thePlayer, 0, 255, 0)
    outputChatBox(string.format("Einnahmen: %s", toprice(Einnahmen)), thePlayer, 0, 255, 0)
    outputChatBox(string.format("Ausgaben:  %s", toprice(Ausgaben)), thePlayer, 0, 255, 0)
    outputChatBox("======================================", thePlayer, 0, 255, 0)
    outputChatBox(string.format("Gesamt:    %s", toprice(Gesamt)), thePlayer, 0, 255, 0)
    outputChatBox("|______________|PayDay|______________|", thePlayer, 0, 255, 0)
    outputChatBox("Genauere Infos über den Payday mit /payday", thePlayer, 0, 255, 0)

    --Gesamt-jobgehalt
    changePlayerBank(thePlayer, (Gesamt - jobgehalt), "sonstiges", "PayDay")
    vioSetElementData(thePlayer, "bank", vioGetElementData(thePlayer, "bank") + jobgehalt)

    vioSetElementData(thePlayer, "lastPayDayberechnung", PayDayTable)
    --RESET FISCH
    vioSetElementData(thePlayer, "fisheslasthour", 0)
    -- BIZ
    if (vioGetElementData(thePlayer, "bizKey") ~= 0) then
        bizData[vioGetElementData(thePlayer, "bizKey")]["Kasse"] = bizData[vioGetElementData(thePlayer, "bizKey")]["Kasse"] + 111.11
        outputChatBox("Du hast in deinen Bizkonto 111.11$ BizBonus gutgeschrieben bekommen!", thePlayer, 0, 191, 70)
        if (vioGetElementData(thePlayer, "Erfolg_MyOwnBiz") ~= 1) then
            vioSetElementData(thePlayer, "Erfolg_MyOwnBiz", 1)
            triggerClientEvent(thePlayer, "onClientCreatePokalGUI", thePlayer, "My Own Biz", "Besitze dein eigenes Buisness")
        end
    end

    --MIETRAUSWURF
    if (isinrent == -1) then
        outputChatBox("Da du die Miete nicht bezahlen konntest, wurdest du rausgeworfen!", thePlayer, 255, 0, 0)
    end

    -- MIETE VON KONTO
    if (showMieteString) then
        outputChatBox("Da dein Gehalt nicht zum Zahlen der Miete ausreicht, wurde die Miete direkt vom Konto abgebucht!", thePlayer, 255, 0, 0)
    end

    --WERBER/STVO/POKALE
    controlWeber(thePlayer)
    vioSetElementData(thePlayer, "stvoFreePayDays", vioGetElementData(thePlayer, "stvoFreePayDays") + 1)
    if (vioGetElementData(thePlayer, "stvoFreePayDays") >= 10) then
        if (vioGetElementData(thePlayer, "stvo") > 0) then
            vioSetElementData(thePlayer, "stvo", 0)
            vioSetElementData(thePlayer, "stvoFreePayDays")
            outputChatBox("Du hast jetzt 10 PayDays keine StVO-Punkte mehr bekommen. Deine StVO-Punkte wurden gelöscht!", thePlayer, 255, 0, 0)
        end
    end

    if (vioGetElementData(thePlayer, "waffenLic") < 0) then
        vioSetElementData(thePlayer, "waffenLic", vioGetElementData(thePlayer, "waffenLic") + 1)
    end

    if (vioGetElementData(thePlayer, "truckLic") < 0) then
        vioSetElementData(thePlayer, "truckLic", vioGetElementData(thePlayer, "truckLic") + 1)
    end

    if (vioGetElementData(thePlayer, "planeLic") < 0) then
        vioSetElementData(thePlayer, "planeLic", vioGetElementData(thePlayer, "planeLic") + 1)
    end

    if (vioGetElementData(thePlayer, "heliLic") < 0) then
        vioSetElementData(thePlayer, "heliLic", vioGetElementData(thePlayer, "heliLic") + 1)
    end

    if (vioGetElementData(thePlayer, "autoLic") < 0) then
        vioSetElementData(thePlayer, "autoLic", vioGetElementData(thePlayer, "autoLic") + 1)
    end

    if (vioGetElementData(thePlayer, "bikeLic") < 0) then
        vioSetElementData(thePlayer, "bikeLic", vioGetElementData(thePlayer, "bikeLic") + 1)
    end

    if (vioGetElementData(thePlayer, "lasttruckLic") > 0) then
        vioSetElementData(thePlayer, "lasttruckLic", vioGetElementData(thePlayer, "lasttruckLic") - 1)
    end

    if (vioGetElementData(thePlayer, "lastplaneLic") > 0) then
        vioSetElementData(thePlayer, "lastplaneLic", vioGetElementData(thePlayer, "lastplaneLic") - 1)
    end

    if (vioGetElementData(thePlayer, "lastheliLic") > 0) then
        vioSetElementData(thePlayer, "lastheliLic", vioGetElementData(thePlayer, "lastheliLic") - 1)
    end

    if (vioGetElementData(thePlayer, "lastautoLic") > 0) then
        vioSetElementData(thePlayer, "lastautoLic", vioGetElementData(thePlayer, "lastautoLic") - 1)
    end

    if (vioGetElementData(thePlayer, "lastbikeLic") > 0) then
        vioSetElementData(thePlayer, "lastbikeLic", vioGetElementData(thePlayer, "lastbikeLic") - 1)
    end

    if (vioGetElementData(thePlayer, "Erfolg_Mein_erstes_Geld") ~= 1) then
        vioSetElementData(thePlayer, "Erfolg_Mein_erstes_Geld", 1)
        triggerClientEvent(thePlayer, "onClientCreatePokalGUI", thePlayer, "Mein erstes Geld", "Erhalte deinen ersten PayDay")
    end

    if (vioGetElementData(thePlayer, "hkey") > 0) then
        if (vioGetElementData(thePlayer, "Erfolg_MyOwnHome") ~= 1) then
            vioSetElementData(thePlayer, "Erfolg_MyOwnHome", 1)
            triggerClientEvent(thePlayer, "onClientCreatePokalGUI", thePlayer, "My Own Home", "Besitze dein eigenes Haus")
        end
    end

    if (vioGetElementData(thePlayer, "fraktion") > 0) then
        if (vioGetElementData(thePlayer, "Erfolg_Fraktionseinsteiger") ~= 1) then
            vioSetElementData(thePlayer, "Erfolg_Fraktionseinsteiger", 1)
            triggerClientEvent(thePlayer, "onClientCreatePokalGUI", thePlayer, "Fraktionseinsteinsteiger", "Sei in einer Fraktion")
        end
    end

    local WerberUeber25SpielstundenQuery = "SELECT * FROM user LEFT JOIN user_data ON user_data.Nickname=user.Nickname WHERE user.werber = ? and user_data.playtime>1500";
    local query = dbQuery(MySql._connection, WerberUeber25SpielstundenQuery, getPlayerName(thePlayer))
    local result = dbPoll(query, -1);
    local WerberUeber25Spielstunden = table.getSize(result);
    if (WerberUeber25Spielstunden > 4) then
        if (vioGetElementData(thePlayer, "Erfolg_TerraFriend") ~= 1) then
            vioSetElementData(thePlayer, "Erfolg_TerraFriend", 1)
            triggerClientEvent(thePlayer, "onClientCreatePokalGUI", thePlayer, "TerraFriend", "Werbe mindestens 5 User, die über 25 Spielstunden erreichen!")
        end
    end
end

function payday_cmd_func(thePlayer)
    if (vioGetElementData(thePlayer, "lastPayDayberechnung")) then
        triggerClientEvent(thePlayer, "showPayDayGui", thePlayer, vioGetElementData(thePlayer, "lastPayDayberechnung"))
    else
        outputChatBox("Du hattest seit deinem letzten Login keinen PayDay", thePlayer, 255, 0, 0)
    end
end
addCommandHandler("payday", payday_cmd_func, false, false)
