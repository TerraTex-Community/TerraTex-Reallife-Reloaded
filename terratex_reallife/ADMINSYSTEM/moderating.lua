function check_func(thePlayer, command, toPlayerNamePart)

    if (isAdminLevel(thePlayer, 0)) then
        if (toPlayerNamePart) then
            local toPlayer = getPlayerFromIncompleteName(toPlayerNamePart)
            if (toPlayer) then
                local Money = getPlayerMoney(toPlayer)
                local Bank = getPlayerBank(toPlayer)
                local Fraktion = vioGetElementData(toPlayer, "fraktion")
                local Frakrang = vioGetElementData(toPlayer, "fraktionsrang")
                local Job = vioGetElementData(toPlayer, "job")
                local Playtime = math.round(vioGetElementData(toPlayer, "playtime") / 60)
                local Warns = vioGetElementData(toPlayer, "warns")
                local GebT = vioGetElementData(toPlayer, "Geb_T")
                local GebM = vioGetElementData(toPlayer, "Geb_M")
                local GebY = vioGetElementData(toPlayer, "Geb_Y")
                local HP = getElementHealth(toPlayer)
                local Armor = getPedArmor(toPlayer)
                local tode = vioGetElementData(toPlayer, "tode")
                outputChatBox("Player: " .. getPlayerName(toPlayer) .. " Spielstunden: " .. Playtime, thePlayer, 255, 0, 0)
                outputChatBox("Gelddaten: Bank: " .. math.round(Bank, 2) .. " Hand: " .. math.round(Money, 2), thePlayer, 255, 0, 0)
                outputChatBox("Lebensdaten: Health: " .. HP .. " Armor: " .. Armor .. " Tode: " .. tode, thePlayer, 255, 0, 0)
                outputChatBox("Admindaten: Warns: " .. Warns, thePlayer, 255, 0, 0)
                outputChatBox("Fraktionsdaten: Fraktions-ID:" .. Fraktion .. " Rang-ID: " .. Frakrang, thePlayer, 255, 0, 0)
                outputChatBox("Sonstige: Geburstag: " .. GebT .. "." .. GebM .. "." .. GebY, thePlayer, 255, 0, 0)

            else
                outputChatBox("Der Spieler Existiert nicht", thePlayer, 255, 0, 0)
            end
        else
            outputChatBox("Der Spieler Existiert nicht", thePlayer, 255, 0, 0)
        end
    end
end
addCommandHandler("rcheck", check_func, false, false)

function rkick_func(thePlayer, command, theBeBanned, ...)
    local reasons = table.concat({ ... }, "  ")
    if (isConsole(thePlayer)) then

        local banmeele = getPlayerFromIncompleteName(theBeBanned)
        if not (banmeele == false) then
            local pname = getPlayerName(banmeele)

            outputChatBox("Der Spieler " .. pname .. " wurde von der Console gekickt. Grund " .. reasons, getRootElement(), 255, 0, 0)
            outputDebugString("Der Spieler " .. pname .. " wurde von der Console gekickt. Grund " .. reasons)
            kickPlayer(banmeele, reasons)

        else
            outputDebugString("Error: Der Spieler existiert nicht!")
        end

    else
        if (isAdminLevel(thePlayer, 0)) then

            local banmeele = getPlayerFromIncompleteName(theBeBanned)
            if isElement(banmeele) then
                local pname = getPlayerName(banmeele)
                local aname = getPlayerName(thePlayer)

                outputChatBox("Der Spieler " .. pname .. " wurde von " .. aname .. " gekickt. Grund :" .. reasons, getRootElement(), 255, 0, 0)
                kickPlayer(banmeele, thePlayer, reasons)
            else
                outputChatBox("Der Spieler existiert nicht", thePlayer, 255, 0, 0)
            end
        end
    end
end
addCommandHandler("rkick", rkick_func, false, false)

function afkkick_func(thePlayer, command, time, theBeBanned, reason, ...)
    if (not tonumber(time)) then
        reason = theBeBanned;
        theBeBanned = time;
        time = 60;
    end

    if not reason then reason = "" end
    local reasons = reason .. " " .. table.concat({ ... }, "  ")
    if (isConsole(thePlayer)) then

        local banmeele = getPlayerFromIncompleteName(theBeBanned)
        if not (banmeele == false) then
            local pname = getPlayerName(banmeele)

            vioSetElementData(banmeele, "afktime", vioGetElementData(banmeele, "afktime") + tonumber(time));

            outputChatBox("Der Spieler " .. pname .. " wurde von der Console AFK - gekickt. Grund " .. reasons, getRootElement(), 255, 0, 0)
            outputDebugString("Der Spieler " .. pname .. " wurde von der Console AFK - gekickt. Grund " .. reasons)
            kickPlayer(banmeele, reasons)

        else
            outputDebugString("Error: Der Spieler existiert nicht!")
        end

    else
        if (isAdminLevel(thePlayer, 0)) then

            local banmeele = getPlayerFromIncompleteName(theBeBanned)
            if isElement(banmeele) then
                local pname = getPlayerName(banmeele)
                local aname = getPlayerName(thePlayer)

                vioSetElementData(banmeele, "afktime", vioGetElementData(banmeele, "afktime") + tonumber(time));

                outputChatBox("Der Spieler " .. pname .. " wurde von " .. aname .. " AFK - gekickt. Grund :" .. reasons, getRootElement(), 255, 0, 0)
                kickPlayer(banmeele, thePlayer, reasons)
            else
                outputChatBox("Der Spieler existiert nicht", thePlayer, 255, 0, 0)
            end
        end
    end
end
addCommandHandler("afkkick", afkkick_func, false, false)


function ban_func(thePlayer, command, theBeBanned, ...)

    local reasons = table.concat({ ... }, "  ")

    if (isConsole(thePlayer)) then
        local banmeele = getPlayerFromIncompleteName(theBeBanned)
        if not (banmeele == false) then
            local pname = getPlayerName(banmeele)
            theBeBanned = getPlayerFromIncompleteName(theBeBanned)
            local IP = getPlayerIP(theBeBanned)
            local Serial = getPlayerSerial(theBeBanned)

            MySql.helper.insert("admin_user_bans", {
                Nickname = pname,
                Serial = Serial,
                IP = IP,
                Grund = reasons,
                Admin = "Console"
            });
            outputChatBox("Der Spieler " .. pname .. " wurde von der Console gebannt. Grund: " .. reasons, getRootElement(), 255, 0, 0)
            outputDebugString("Der Spieler " .. pname .. " wurde von der Console gebannt. Grund: " .. reasons)
            kickPlayer(banmeele, reasons)

        else
            outputDebugString("Error: Der Spieler existiert nicht!")
        end
    else
        if (isAdminLevel(thePlayer, 1)) then
            local banmeele = getPlayerFromIncompleteName(theBeBanned)
            if isElement(banmeele) then
                local pname = getPlayerName(banmeele)
                theBeBanned = getPlayerFromIncompleteName(theBeBanned)
                local aname = getPlayerName(thePlayer)
                local IP = getPlayerIP(theBeBanned)
                local Serial = getPlayerSerial(theBeBanned)

                MySql.helper.insert("admin_user_bans", {
                    Nickname = pname,
                    Serial = Serial,
                    IP = IP,
                    Grund = reasons,
                    Admin = aname
                });
                outputChatBox("Der Spieler " .. pname .. " wurde von " .. aname .. " gebannt. Grund :" .. reasons, getRootElement(), 255, 0, 0)
                kickPlayer(banmeele, thePlayer, reasons)
            else
                outputChatBox("Der Spieler existiert nicht", thePlayer, 255, 0, 0)
            end
        end
    end
end
addCommandHandler("rban", ban_func, false, false)

function tban_func(theAdmin, command, toPlayerName, zeit, reason, ...)

    if (isAdminLevel(theAdmin, 0)) or isConsole(theAdmin) then
        if (toPlayerName and zeit and reason) then
            local toPlayer = getPlayerFromIncompleteName(toPlayerName)
            if (toPlayer) then
                local timer = tonumber(zeit)
                if (timer) then

                    if (timer < 0 and timer > -60) then
                        local reason = reason .. " " .. table.concat({ ... }, " ")
                        timer = -timer
                        local adm = getPlayerName(theAdmin)
                        local pln = getPlayerName(toPlayer)
                        local pser = getPlayerSerial(toPlayer)

                        MySql.helper.insert("admin_user_timebans", {
                            Nickname = pln,
                            Serial = pser,
                            Admin = adm,
                            Grund = reason,
                            Minuten = timer
                        });
                        outputChatBox(pln .. " wurde von " .. adm .. " für " .. timer .. " Minuten gebannt! Grund:" .. reason, getRootElement(), 255, 0, 0)
                        local sreason = "Du wurdest " .. timer .. " Minuten von " .. adm .. " gebannt! Grund:" .. reason
                        kickPlayer(toPlayer, theAdmin, sreason)
                    elseif (timer > 0 and not (timer > 2 and vioGetElementData(theAdmin, "adminlvl") == 0)) then

                        local adm = getPlayerName(theAdmin)
                        local pln = getPlayerName(toPlayer)
                        local pser = getPlayerSerial(toPlayer)
                        local reason = reason .. " " .. table.concat({ ... }, " ")
                        local timers = timer * 60
                        if (timer > 24) then

                            checkAdditionalPunishment(toPlayer)

                            vioSetElementData(toPlayer, "tbans", vioGetElementData(toPlayer, "tbans") + 1)
                            if (vioGetElementData(toPlayer, "tbans") == 1) then
                                MySql.helper.update("user_data", {tban_reason1 = reason}, {Nickname = pln} );
                            end
                            if (vioGetElementData(toPlayer, "tbans") > 1) then
                                local tban_reason = MySql.helper.getValueSync("user_data", "tban_reason1", { Nickname = pln });
                                MySql.helper.update("user_data", {tban_reason1 = "no_reason"}, {Nickname = pln} );
                                local newreason = "2 Timebans: " .. tban_reason .. " + " .. reason

                                MySql.helper.insert("admin_user_warns", {
                                    Nickname = pln,
                                    Admin = adm,
                                    Grund = newreason
                                });

                                reason = reason .. " + Automatischer Warn für 2 Timebans!"
                                vioSetElementData(toPlayer, "tbans", 0)
                            end
                        end

                        MySql.helper.insert("admin_user_timebans", {
                            Nickname = pln,
                            Serial = pser,
                            Admin = adm,
                            Grund = reason,
                            Minuten = timers
                        });

                        outputChatBox(pln .. " wurde von " .. adm .. " für " .. timer .. " Stunden gebannt! Grund:" .. reason, getRootElement(), 255, 0, 0)
                        local sreason = "Du wurdest " .. timer .. " Stunden von " .. adm .. " gebannt! Grund:" .. reason
                        kickPlayer(toPlayer, theAdmin, sreason)
                    else
                        showError(theAdmin, " USAGE: /tban Name Zeit Grund!\nZeit in Minuten: negative Zahl bis 60\nZeit in Stunden positiv!")
                    end
                end
            end
        else
            showError(theAdmin, " USAGE: /tban Name Zeit Grund!\nZeit in Minuten: negative Zahl bis 60\nZeit in Stunden positiv!")
        end
    end
end
addCommandHandler("tban", tban_func, false, false)

function warn_func(thePlayer, command, theBeBanned, ...)

    local reasons = table.concat({ ... }, "  ")

    if (isAdminLevel(thePlayer, 1)) then

        local banmeele = getPlayerFromIncompleteName(theBeBanned)
        if not (banmeele == false) then
            checkAdditionalPunishment(banmeele)
            local pname = getPlayerName(banmeele)
            local aname = getPlayerName(thePlayer)

            MySql.helper.insert("admin_user_warns", {
                Nickname = pname,
                Admin = aname,
                Grund = reasons
            });

            outputChatBox("Der Spieler " .. pname .. " wurde von " .. aname .. " verwarnt. Grund :" .. reasons, getRootElement(), 255, 0, 0)
            vioSetElementData(banmeele, "warns", vioGetElementData(banmeele, "warns") + 1)

            local IP = getPlayerIP(banmeele)
            local Serial = getPlayerSerial(banmeele)
            if (vioGetElementData(banmeele, "warns") > 2) then

                MySql.helper.insert("admin_user_bans", {
                    Nickname = pname,
                    Serial = Serial,
                    IP = IP,
                    Grund = "3 Warns",
                    Admin = aname
                });
                outputChatBox("Der Spieler " .. pname .. " wurde von der Console gebannt. Grund : 3 Warns", getRootElement(), 255, 0, 0)
                kickPlayer(banmeele, reasons)
            end
        end
    end
end
addCommandHandler("warn", warn_func, false, false)

function force_nickchange(thePlayer, cmd, toPlayerPart)
    if (isAdminLevel(thePlayer, 2)) then
        if (toPlayerPart) then
            local toPlayer = getPlayerFromIncompleteName(toPlayerPart)
            if (toPlayer) then
                local nick = getPlayerName(toPlayer)
                outputChatBox(getPlayerName(toPlayer) .. " wurde vom Server gekickt und zu einem Nickchange gezwungen!", getRootElement(), 255, 0, 0)
                kickPlayer(toPlayer, thePlayer, "Dein Account wurde gesperrt, da dein Nickname nicht den Richtlinien entspricht. Beantrage einen Nickchange auf " .. config["maindomain"])

                MySql.helper.update("user", {force_nickchange = 1}, {Nickname = nick} );

            else
                showError(thePlayer, "Spieler ist nicht existent")
            end
        else
            showError(thePlayer, "Spieler ist nicht existent")
        end
    end
end
addCommandHandler("forcenick", force_nickchange, false, false)

function setplayersdm(thePlayer, cmd, toPlayerPart, staerke, direkt)
    if (isAdminLevel(thePlayer, 1)) then
        if (toPlayerPart) then
            local toPlayer = getPlayerFromIncompleteName(toPlayerPart)
            if (toPlayer) then
                checkAdditionalPunishment(toPlayer)

                vioSetElementData(toPlayer, "mussAlka", 1)
                local wanted = 3
                if (staerke) then
                    if (tonumber(staerke)) then
                        if (tonumber(staerke) == 1) then
                            wanted = 6
                        end
                    end
                end

                if (direkt) then
                    if (tonumber(direkt)) then
                        if (tonumber(direkt) == 1) then
                            direkt = true;
                        else
                            direkt = false;
                        end
                    else
                        direkt = false;
                    end
                else
                    direkt = false;
                end

                if (wanted == 3) then
                    CrimeSystem.addNewCrime(toPlayer, 1000, {user = thePlayer, "Adminsystem"}, "SDM - Deathmatch")
                else
                    CrimeSystem.addNewCrime(toPlayer, 1001, {user = thePlayer, "Adminsystem"}, "SDM - Deathmatch")
                end

                outputChatBox("Du hast vom Admin " .. getPlayerName(thePlayer) .. " einen neuen Verbrecherstatus und einen Alkabefehl erhalten, aufgrund deines erhöhten Deathmatches", toPlayer, 255, 0, 0)
                outputChatBox("Du hast " .. getPlayerName(toPlayer) .. " einen neuen Verbrecherstatus und einen Alkabefehl gegeben, aufgrund seines erhöhten Deathmatches", thePlayer, 255, 0, 0)
                outputChatBoxForPolice("Der Admin " .. getPlayerName(thePlayer) .. " hat " .. getPlayerName(toPlayer) .. " einen neuen Verbrecherstatus und einen Alkabefehl gegeben, aufgrund seines erhöhten Deathmatches")

                if (direkt) then
                    if (isPedInVehicle(toPlayer)) then
                        removePedFromVehicle(toPlayer)
                    end

                    setElementInterior(toPlayer, 0);
                    setElementDimension(toPlayer, 0);
                    vioSetElementData(toPlayer, "kaution", 0);

                    vioSetElementData(toPlayer, "knastzeit", CrimeSystem.getNewJailTime(toPlayer) + 60)
                    vioSetElementData(toPlayer, "lastknastzeit", CrimeSystem.getNewJailTime(toPlayer) + 60)
                    vioSetElementData(toPlayer, "alkaknast", 1)
                    outputChatBox("Du wurdest nun in das Alkatraz eingebuchtet!", toPlayer, 255, 0, 0)
                    outputChatBox("Du hast " .. getPlayerName(toPlayer) .. " in das Alkataz gebuchtet!", thePlayer, 255, 0, 0)

                    local int, x, y, z = CrimeSystem.Jail.getRandomJailSpawnById(1);

                    setElementInterior(toPlayer, int, x, y, z)
                    setElementPosition(toPlayer, x, y, z)
                    setElementModel(toPlayer, 62)
                    vioSetElementData(toPlayer, "mussAlka", 0)
                    CrimeSystem.clear(toPlayer);
                    outputChatBoxForPolice(getPlayerName(toPlayer) .. " wurde von einem Mitglied der Moderation/Administration direkt ins Alkatraz eingeknastet!")
                end

            else
                showError(thePlayer, "Spieler ist nicht existent")
            end
        else
            showError(thePlayer, "Spieler ist nicht existent")
        end
    end
end
addCommandHandler("sdm", setplayersdm, false, false)


function freeze_func(thePlayer, cmd, toPlayerNamePart)
    if (isAdminLevel(thePlayer, 1)) then
        if (toPlayerNamePart) then
            local toPlayer = getPlayerFromIncompleteName(toPlayerNamePart)
            if (toPlayer) then
                if (vioGetElementData(toPlayer, "adminfreeze")) then
                    vioSetElementData(toPlayer, "adminfreeze", false)
                    setElementFrozen(toPlayer, false)
                    outputChatBox("Du hast den Spieler " .. getPlayerName(toPlayer) .. " entfreezt!", thePlayer, 255, 0, 0)
                    outputChatBox("Du wurdest von " .. getPlayerName(thePlayer) .. " entfreezt!", toPlayer, 255, 0, 0)
                    if (isPedInVehicle(toPlayer)) then
                        setElementFrozen(getPedOccupiedVehicle(toPlayer), false)
                    end
                else
                    vioSetElementData(toPlayer, "adminfreeze", true)
                    setElementFrozen(toPlayer, true)
                    setTimer(setAdminFreezeDurated, 1000, 1, toPlayer)
                    outputChatBox("Du hast den Spieler " .. getPlayerName(toPlayer) .. " gefreezt!", thePlayer, 255, 0, 0)
                    outputChatBox("Du wurdest von " .. getPlayerName(thePlayer) .. " gefreezt!", toPlayer, 255, 0, 0)
                    if (isPedInVehicle(toPlayer)) then
                        setElementFrozen(getPedOccupiedVehicle(toPlayer), true)
                    end
                end
            else
                outputChatBox("unbekannter Spieler", thePlayer, 255, 0, 0)
            end
        else
            outputChatBox("Nutzung: /freeze [name]", thePlayer, 255, 0, 0)
        end
    end
end
addCommandHandler("freeze", freeze_func, false, false)

function exitbyadminfreeze(thePlayer)
    if (vioGetElementData(thePlayer, "adminfreeze")) then
        cancelEvent()
    end
end
addEventHandler("onVehicleStartExit", getRootElement(), exitbyadminfreeze)

function setAdminFreezeDurated(toPlayer)
    if (vioGetElementData(toPlayer, "adminfreeze")) then
        setElementFrozen(toPlayer, true)
        setTimer(setAdminFreezeDurated, 1000, 1, toPlayer)
        if (isPedInVehicle(toPlayer)) then
            setElementFrozen(getPedOccupiedVehicle(toPlayer), true)
        end
    end
end

function setMeSupportMode(thePlayer)
    if(isAdminLevel(thePlayer,0))then
        if(vioGetElementData(thePlayer,"smode"))then
            vioSetElementData(thePlayer,"smode",false)
            outputChatBox("Supportmodus beendet",thePlayer)
        else
            outputChatBox("Supportmodus gestartet",thePlayer)
            vioSetElementData(thePlayer,"smode",true)
        end
    end
end
addCommandHandler("smode",setMeSupportMode,false,false)

function tcheck_func(thePlayer, cmd, toPlayer)
    if (isAdminLevel(thePlayer, 0)) then
        if (toPlayer) then
            local playtime = MySql.helper.getValueSync("user_data", "PlayTime", { Nickname = toPlayer });
            if (playtime) then
                outputChatBox("Dieser Spieler hat " .. (math.round(playtime / 60)) .. " Spielstunden!", thePlayer, 255, 0, 0)
            else
                outputChatBox("In der Datenbank konnte dieser Nickname nicht gefunden werden!", thePlayer, 255, 0, 0)
            end
        else
            outputChatBox("usage: /tcheck [Name]", thePlayer, 255, 0, 0)
        end
    end
end
addCommandHandler("tcheck", tcheck_func, false, false)
