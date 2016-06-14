function nickChangeHandler(oldNick, newNick)
    cancelEvent()
end
addEventHandler("onPlayerChangeNick", getRootElement(), nickChangeHandler)

function outputAdminMessage(message, colorA, ColorB, ColorC)
    local players = getElementsByType("player")
    for theKey, thePlayer in ipairs(players) do
        if (isPlayerLoggedIn(thePlayer)) then
            if (isAdminLevel(thePlayer, 0)) then
                outputChatBox(message, thePlayer, colorA, colorB, colorC)
            end
        end
    end
end

function mark_Ruhe_Point_A(thePlayer)
    if (isAdminLevel(thePlayer, 3)) then
        local posX, posY, posZ = getElementPosition(thePlayer)
        vioSetElementData(thePlayer, "posX1", posX)
        vioSetElementData(thePlayer, "posY1", posY)
        outputChatBox("pos1 set", thePlayer)
    end
end
addCommandHandler("marka", mark_Ruhe_Point_A, false, false)

function mark_Ruhe_Point_B(thePlayer)
    if (isAdminLevel(thePlayer, 3)) then
        local posX, posY, posZ = getElementPosition(thePlayer)
        vioSetElementData(thePlayer, "posX2", posX)
        vioSetElementData(thePlayer, "posY2", posY)

        outputChatBox("pos2 set", thePlayer)
    end
end
addCommandHandler("markb", mark_Ruhe_Point_B, false, false)

function addRuheZone(thePlayer)
    if (isAdminLevel(thePlayer, 3)) then
        if (vioGetElementData(thePlayer, "posX1") and vioGetElementData(thePlayer, "posX2")) then
            local posXA = 0
            local posXB = 0
            local posYA = 0
            local posYB = 0
            if (vioGetElementData(thePlayer, "posX1") < vioGetElementData(thePlayer, "posX2")) then
                posXA = vioGetElementData(thePlayer, "posX1")
                posXB = vioGetElementData(thePlayer, "posX2")
            else
                posXA = vioGetElementData(thePlayer, "posX1")
                posXB = vioGetElementData(thePlayer, "posX2")
            end
            if (vioGetElementData(thePlayer, "posY1") < vioGetElementData(thePlayer, "posY2")) then
                posYA = vioGetElementData(thePlayer, "posY1")
                posYB = vioGetElementData(thePlayer, "posY2")
            else
                posYA = vioGetElementData(thePlayer, "posY1")
                posYB = vioGetElementData(thePlayer, "posY2")
            end

            local sizeX = posXB - posXA
            local sizeY = posYB - posYA

            local ID = MySql.helper.insertSync("objects_restareas", {
                leftX = posXA,
                buttonY = posYA,
                sizeX = sizeX,
                sizeY = sizeY
            });

            outputChatBox("Ruhezone ID " .. ID .. " created", thePlayer, 255, 0, 0)
            local area = createRadarArea(posXA, posYA, sizeX, sizeY, 0, 200, 0, 150, getRootElement())
            ruhezonen[ID] = area
            triggerClientEvent(getRootElement(), "empfangeRuhezonenData", thePlayer, ruhezonen)
        else
            outputChatBox("Sie müssen erst 2 Punkte markieren!", thePlayer, 255, 0, 0)
        end
    end
end
addCommandHandler("addruhe", addRuheZone, false, false)

function destroyRuheZone(thePlayer, cmd, ID)
    if (isAdminLevel(thePlayer, 3)) then
        if tonumber(ID) then
            if (ruhezonen[ID]) then
                destroyElement(ruhezonen[ID])
                ruhezonen[ID] = false
                triggerClientEvent(getRootElement(), "empfangeRuhezonenData", thePlayer, ruhezonen)
                MySql.helper.delete("objects_restareas", {ID = ID});
                outputChatBox("Ruhezone gelöscht", thePlayer, 255, 0, 0)
            else
                outputChatBox("ungültige ID", thePlayer, 255, 0, 0)
            end
        end
    end
end
addCommandHandler("delRZ", destroyRuheZone, false, false)

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

local gppoints = {
    ["noob"] = { 1737.099609375, -1862.0546875, 13.576762199408 }, --noob
    ["ls"] = { 1545.4775390625, -1675.560546875, 13.560440063477 }, -- ls
    ["fish"] = { 383.314453125, -2054.2255859375, 7.8359375 }, --fish
    ["truck"] = { 2769.2548828125, -2440.4267578125, 13.6484375 }, -- truck
    ["lv"] = { 2305.4169921875, 2430.0146484375, 10.8203125 } --lv
}

function gotopoint(thePlayer, cmd, point)
    if (isAdminLevel(thePlayer, 0)) then
        local ableplaces = ""
        local pointsexist = false
        for theKey, tables in pairs(gppoints) do
            if (theKey == point) then
                pointsexist = true
            end
            ableplaces = ableplaces .. theKey .. " "
        end
        if (pointsexist) then
            setElementPosition(thePlayer, gppoints[point][1], gppoints[point][2], gppoints[point][3])
            outputChatBox("Du wurdest erfolgreich zur Position " .. point .. " geportet", thePlayer, 255, 0, 0) --adminabfrage + falscher string
        else
            outputChatBox("Mögliche Orte:", thePlayer, 255, 0, 0)
            outputChatBox(ableplaces, thePlayer, 255, 0, 0)
        end
    end
end
addCommandHandler("gp", gotopoint, false, false)

function gj_func(thePlayer, cmd, jobid)
    if (isAdminLevel(thePlayer, 0)) then
        if (tonumber(jobid)) then
            if (JobPickups[tonumber(jobid)]) then
                setElementPosition(thePlayer, JobPickups[tonumber(jobid)][3], JobPickups[tonumber(jobid)][4], JobPickups[tonumber(jobid)][5])
            else
                showError(thePlayer, "ungültige jobID")
            end
        else
            showError(thePlayer, "ungültige jobID")
        end
    end
end
addCommandHandler("gj", gj_func, false, false)

function skydive_func(thePlayer, cmd, toPlayerNamePart)
    if (isAdminLevel(thePlayer, 1)) then
        if (toPlayerNamePart) then
            local toPlayer = getPlayerFromIncompleteName(toPlayerNamePart)
            if (toPlayer) then
                local x, y, z = getElementPosition(toPlayer)
                setElementPosition(toPlayer, x, y, z + 1500)
                outputChatBox("Du hast den Spieler " .. getPlayerName(toPlayer) .. " erfolgreich in die Luft geschleudert!", thePlayer, 255, 0, 0)
                outputChatBox(getPlayerName(thePlayer) .. " hat dich in die Luft geschleudert!", toPlayer, 255, 0, 0)
                giveWeapon(toPlayer, 46)
            end
        end
    end
end
addCommandHandler("sky", skydive_func, false, false)

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

function set_mark_admin(thePlayer)
    if (isAdminLevel(thePlayer, 0)) then
        local mx, my, mz = getElementPosition(thePlayer)
        local mint = getElementInterior(thePlayer)
        local mdim = getElementDimension(thePlayer)
        vioSetElementData(thePlayer, "adminMarkX", mx)
        vioSetElementData(thePlayer, "adminMarkY", my)
        vioSetElementData(thePlayer, "adminMarkZ", mz)
        vioSetElementData(thePlayer, "adminMarkInt", mint)
        vioSetElementData(thePlayer, "adminMarkDim", mdim)
        outputChatBox("Der Marker wurde gespeichert! DU kannst dich mit /gotomark hinteleportieren!", thePlayer, 255, 0, 0)
    end
end
addCommandHandler("setMark", set_mark_admin, false, false)

function gotomark_func(thePlayer)
    if (isAdminLevel(thePlayer, 0)) then
        if (vioGetElementData(thePlayer, "adminMarkX")) then
            setElementPosition(thePlayer, vioGetElementData(thePlayer, "adminMarkX"), vioGetElementData(thePlayer, "adminMarkY"), vioGetElementData(thePlayer, "adminMarkZ"))
            setElementInterior(thePlayer, vioGetElementData(thePlayer, "adminMarkInt"))
            setElementDimension(thePlayer, vioGetElementData(thePlayer, "adminMarkDim"))
            outputChatBox("Du wurdest zum Marker teleportiert!", thePlayer, 255, 0, 0)

        else
            outputChatBox("Es ist kein Marker gespeichert! Du musst erst einen mit /setmark speichern!", thePlayer, 255, 0, 0)
        end
    end
end
addCommandHandler("gotomark", gotomark_func, false, false)

function save_all_user(thePlayer)
    local consolenelement = getElementsByType("console")
    if (thePlayer == consolenelement[1] or isAdminLevel(thePlayer, 4)) then
        for theKey, thePlayers in ipairs(getElementsByType("player")) do
            triggerEvent("SaveMyData", thePlayers)
        end
    end
end
addCommandHandler("sau", save_all_user, false, false)

function ban_func(thePlayer, command, theBeBanned, ...)

    local reasons = table.concat({ ... }, "  ")
    local consolenelement = getElementsByType("console")
    if (thePlayer == consolenelement[1]) then
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
            kickPlayer(banmeele, reasons)
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
                outputChatBox("Der Spieler " .. pname .. " wurde von " .. aname .. " gebannt. Grund :" .. reason, getRootElement(), 255, 0, 0)
                kickPlayer(banmeele, thePlayer, reasons)
            else
                outputChatBox("Der Spieler existiert nicht", thePlayer, 255, 0, 0)
            end
        end
    end
end
addCommandHandler("rban", ban_func, false, false)

function tban_func(theAdmin, command, toPlayerName, zeit, reason, ...)
    local console = getElementsByType("console")
    if (isAdminLevel(theAdmin, 0)) or theAdmin == console[1] then
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

            outputChatBox("Der Spieler " .. pname .. " wurde von " .. aname .. " verwarnt. Grund :" .. reason, getRootElement(), 255, 0, 0)
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

function rkick_func(thePlayer, command, theBeBanned, ...)

    local reasons = table.concat({ ... }, "  ")
    local consolenelement = getElementsByType("console")
    if (thePlayer == consolenelement[1]) then

        local banmeele = getPlayerFromIncompleteName(theBeBanned)
        if not (banmeele == false) then
            local pname = getPlayerName(banmeele)

            outputChatBox("Der Spieler " .. pname .. " wurde von der Console gekickt. Grund " .. reasons, getRootElement(), 255, 0, 0)
            kickPlayer(banmeele, reasons)
        end

    else
        if (isAdminLevel(thePlayer, 0)) then

            local banmeele = getPlayerFromIncompleteName(theBeBanned)
            if isElement(banmeele) then
                local pname = getPlayerName(banmeele)
                local aname = getPlayerName(thePlayer)

                outputChatBox("Der Spieler " .. pname .. " wurde von " .. aname .. " gekickt. Grund :" .. reason, getRootElement(), 255, 0, 0)
                kickPlayer(banmeele, thePlayer, reasons)
            else
                outputChatBox("Der Spieler existiert nicht", thePlayer, 255, 0, 0)
            end
        end
    end
end
addCommandHandler("rkick", rkick_func, false, false)

function goto_func(theMaker, Command, thePlayerName)
    if (isAdminLevel(theMaker, 0)) then
        local thePlayer = getPlayerFromIncompleteName(thePlayerName)
        if (thePlayer) then
            if (isPedInVehicle(theMaker)) then

                local gx, gy, gz = getElementPosition(thePlayer)
                local i = getElementInterior(thePlayer)
                local d = getElementDimension(thePlayer)
                local theVehicle = getPedOccupiedVehicle(theMaker)
                setElementFrozen(theVehicle, true)
                setElementInterior(theVehicle, i)
                setElementDimension(theVehicle, d)
                setElementVelocity(theVehicle, 0, 0, 0)
                setElementPosition(theVehicle, gx + 3, gy + 3, gz + 1)
                setElementFrozen(theVehicle, false)

            else

                local gx, gy, gz = getElementPosition(thePlayer)
                local i = getElementInterior(thePlayer)
                local d = getElementDimension(thePlayer)
                setElementInterior(theMaker, i)
                setElementDimension(theMaker, d)
                setElementPosition(theMaker, gx + 1, gy + 1, gz)
            end
        else
            outputChatBox("Falscher Spielername", theMaker, 255, 0, 0)
        end
    end
end
addCommandHandler("goto", goto_func, false, false)

function gethere_func(theMaker, Command, thePlayerName)
    if (isAdminLevel(theMaker, 0)) then
        local thePlayer = getPlayerFromIncompleteName(thePlayerName)
        if (thePlayer) then
            if (isPedInVehicle(thePlayer)) then
                local gx, gy, gz = getElementPosition(theMaker)
                local i = getElementInterior(theMaker)
                local d = getElementDimension(theMaker)
                local theVehicle = getPedOccupiedVehicle(thePlayer)
                setElementInterior(theVehicle, i)
                setElementDimension(theVehicle, d)

                setElementVelocity(theVehicle, 0, 0, 0)
                setElementPosition(theVehicle, gx + 2, gy + 2, gz + 1)
            else

                local gx, gy, gz = getElementPosition(theMaker)
                local i = getElementInterior(theMaker)
                local d = getElementDimension(theMaker)
                setElementInterior(thePlayer, i)
                setElementDimension(thePlayer, d)
                setElementPosition(thePlayer, gx + 1, gy + 1, gz)
            end
        else
            outputChatBox("Falscher Spielername", theMaker, 255, 0, 0)
        end
    end
end
addCommandHandler("gethere", gethere_func, false, false)

function slap_func(theMaker, Command, thePlayerName)
    if (isAdminLevel(theMaker, 1)) then
        local thePlayer = getPlayerFromIncompleteName(thePlayerName)
        if (thePlayer) then

            local px, py, pz = getElementPosition(thePlayer)
            setElementPosition(thePlayer, px, py, pz + 1)
            setPedOnFire(thePlayer, true)
            local aname = getPlayerName(theMaker)
            outputChatBox(aname .. " hat " .. getPlayerName(thePlayer) .. " angezündet!", theMaker, 255, 255, 0)
            outputChatBox(aname .. " hat " .. getPlayerName(thePlayer) .. " angezündet!", thePlayer, 255, 255, 0)
        else
            outputChatBox("Falscher Spielername", theMaker, 255, 0, 0)
        end
    end
end
addCommandHandler("slap", slap_func, false, false)

function occ_func(theMaker, Command, ...)
    local message = table.concat({ ... }, "  ")
    if (isAdminLevel(theMaker, 0)) then
        local adminpre = ""
        if (vioGetElementData(theMaker, "adminlvl") == 1) then adminpre = "Moderator " end
        if (vioGetElementData(theMaker, "adminlvl") == 2) then adminpre = "SuperModerator " end
        if (vioGetElementData(theMaker, "adminlvl") == 3) then adminpre = "Administrator " end
        if (vioGetElementData(theMaker, "adminlvl") == 4) then adminpre = "Serverleiter " end
        if (vioGetElementData(theMaker, "SupportLVL") > 0) then adminpre = "Supporter " end
        message = "[[ " .. adminpre .. getPlayerName(theMaker) .. ": " .. message .. " ]]"
        outputChatBox(message, getRootElement(), 255, 20, 147)
    end
end
addCommandHandler("o", occ_func, false, false)

function admins_func(theMaker, command)
    outputChatBox("Adminliste:", theMaker)
    local adminpre = " "
    local adminList = {}

    if(isAdminLevel(theMaker, 1)) then
        for k, v in ipairs(getPlayersByDataValue("adminlvl", 5)) do table.insert(adminList, v) end
    end

    for k, v in ipairs(getPlayersByDataValue("adminlvl", 4)) do table.insert(adminList, v) end
    for k, v in ipairs(getPlayersByDataValue("adminlvl", 3)) do table.insert(adminList, v) end
    for k, v in ipairs(getPlayersByDataValue("adminlvl", 2)) do table.insert(adminList, v) end
    for k, v in ipairs(getPlayersByDataValue("adminlvl", 1)) do table.insert(adminList, v) end
    for k, v in ipairs(getPlayersByDataValue("SupportLVL", 1)) do table.insert(adminList, v) end

    for theKey, thePlayer in ipairs(adminList) do
        if (isPlayerLoggedIn(thePlayer)) then
            if (vioGetElementData(thePlayer, "adminlvl") == 1) then adminpre = "Moderator: " end
            if (vioGetElementData(thePlayer, "adminlvl") == 2) then adminpre = "SuperModerator: " end
            if (vioGetElementData(thePlayer, "adminlvl") == 3) then adminpre = "Administrator: " end
            if (vioGetElementData(thePlayer, "adminlvl") == 4) then adminpre = "Serverleiter: " end
            if (vioGetElementData(thePlayer, "adminlvl") == 5) then adminpre = "[Hidden]: " end
            if (vioGetElementData(thePlayer, "SupportLVL") > 0) then adminpre = "Supporter: " end
            outputChatBox(adminpre .. getPlayerName(thePlayer), theMaker)
        end
    end
end
addCommandHandler("admins", admins_func, false, false)

function report_func(theMaker, command, text, ...)
    if not (text) then
        outputChatBox("Nutzung: /report [Text]", theMaker, 255, 0, 0)
    else
        local message = text .. " " .. table.concat({ ... }, "  ")
        outputChatBox("Dein Report wurde gesendet.", theMaker)
        chat_log(theMaker, "Report: " .. message)
        local players = getElementsByType("player")
        local adminsOnline = 0
        local adminsAfk = 0
        for theKey, thePlayer in ipairs(players) do

            if (isAdminLevel(thePlayer, 0)) then
                outputChatBox("Report von " .. getPlayerName(theMaker) .. ": " .. message, thePlayer, 255, 255, 0)
                adminsOnline = adminsOnline + 1
                if (vioGetElementData(thePlayer, "afk_status") == 1) then
                    adminsAfk = adminsAfk + 1
                end
            end
        end
        if (adminsOnline == 0) then
            outputChatBox("Leider ist derzeit kein Mitglied des Supportteams online. Bei Problemen erreichst du uns im Forum http://www.tt-rl.de", theMaker)
        elseif (adminsAfk == adminsOnline) then
            outputChatBox("Derzeit sind alle TTeams abwesend. Dein Report wird möglicherweise erst verzögert bearbeitet.", theMaker)
        end
    end
end
addCommandHandler("report", report_func, false, false)

function w_func(theMaker, Command, thePlayerName, ...)
    if (isAdminLevel(theMaker, 0)) then
        local message = table.concat({ ... }, "  ")
        local thePlayeri = getPlayerFromIncompleteName(thePlayerName)
        if (thePlayeri) then
            outputChatBox("Dein Wisper wurde gesendet.", theMaker, 255, 255, 0)
            outputChatBox("Nachricht von Admin/Supporter " .. getPlayerName(theMaker) .. ": " .. message, thePlayeri, 255, 255, 0)
            outputChatBox("Du kannst mit /re antworten!", thePlayeri)
            vioSetElementData(thePlayeri, "re_able", theMaker)
            outputAdminMessage(getPlayerName(theMaker) .. " hat ein Supportchannel mit " .. getPlayerName(thePlayeri) .. " gestartet!", 255, 255, 0)
        else
            showError(theMaker, "Dieser Spieler existiert nicht!")
        end
    end
end
addCommandHandler("w", w_func, false, false)

function re_func(theMaker, Command, ...)
    local message = table.concat({ ... }, "  ")
    if isElement(vioGetElementData(theMaker, "re_able")) then
        if (getPlayerName(vioGetElementData(theMaker, "re_able"))) then
            outputChatBox("Antwort von " .. getPlayerName(theMaker) .. ": " .. message, vioGetElementData(theMaker, "re_able"), 255, 255, 0)
            outputChatBox("Du kannst mit /re antworten!", vioGetElementData(theMaker, "re_able"))
            outputChatBox("Deine Antwort wurde an " .. getPlayerName(vioGetElementData(theMaker, "re_able")) .. " gesendet!", theMaker)
            vioSetElementData(vioGetElementData(theMaker, "re_able"), "re_able", theMaker)
        else
            outputChatBox("Dir hat keine Person geschrieben!", theMaker, 255, 0, 0)
        end
    else
        outputChatBox("Dir hat keine Person geschrieben!", theMaker, 255, 0, 0)
    end
end
addCommandHandler("re", re_func, false, false)

function a_func(theMaker, Command, ...)
    local message = table.concat({ ... }, "  ")
    if (isAdminLevel(theMaker, 0)) then
        if (vioGetElementData(theMaker, "SupportLVL") == 1) then adminpre = "Supporter " end
        if (vioGetElementData(theMaker, "adminlvl") == 1) then adminpre = "Moderator " end
        if (vioGetElementData(theMaker, "adminlvl") == 2) then adminpre = "SuperModerator " end
        if (vioGetElementData(theMaker, "adminlvl") == 3) then adminpre = "Administrator " end
        if (vioGetElementData(theMaker, "adminlvl") == 4) then adminpre = "Serverleiter " end
        if (vioGetElementData(theMaker, "adminlvl") == 5) then adminpre = "[Hidden] " end
        local players = getElementsByType("player")
        for theKey, thePlayer in ipairs(players) do
            if (isPlayerLoggedIn(thePlayer)) then
                if (isAdminLevel(thePlayer, 0)) then
                    outputChatBox(adminpre .. " " .. getPlayerName(theMaker) .. ": " .. message, thePlayer, 255, 255, 0)
                end
            end
        end
    end
end
addCommandHandler("a", a_func, false, false)

local gmxtimer = false
local secondgmxtimer = false

function gmx_func(theMaker, cmd, zeitinminuten, grund, ...)

    if (grund) then
        neuergrund = grund .. " " .. table.concat({ ... }, " ")
        grund = neuergrund
    else
        grund = " Neustart ohne Angabe"
    end
    if not (zeitinminuten) then
        zeitinminuten = 1
    end
    if (zeitinminuten) then
        if (not (tonumber(zeitinminuten))) then
            zeitinminuten = 1
        end
    end
    local second = zeitinminuten * 60 * 1000
    outputDebugString("GMX Started by Console in " .. zeitinminuten .. " Minuten! Grund: " .. grund)
    local consolenelement = getElementsByType("console")
    if (isAdminLevel(theMaker, 3)) or (consolenelement[1] == theMaker) then
        if (isTimer(gmxtimer)) then
            killTimer(gmxtimer)
        end
        if (isTimer(secondgmxtimer)) then
            killTimer(secondgmxtimer)
        end
        outputChatBox("Ein Serverneustart beginnt in " .. zeitinminuten .. " Minuten! Grund: " .. grund, getRootElement(), 255, 0, 0)
        outputChatBox("Ein Serverneustart beginnt in " .. zeitinminuten .. " Minuten! Grund: " .. grund, getRootElement(), 255, 0, 0)
        outputChatBox("Ein Serverneustart beginnt in " .. zeitinminuten .. " Minuten! Grund: " .. grund, getRootElement(), 255, 0, 0)
        outputChatBox("Der Server braucht für den Restart ca. 5 Minuten!", getRootElement(), 255, 0, 0)
        secondgmxtimer = setTimer(gmxRestTime, 60000, 1, zeitinminuten)
        gmxtimer = setTimer(gmx_start, second, 1)
    end
end
addCommandHandler("gmx", gmx_func, false, false)

function shutdown_func(theMaker, cmd, zeitinminuten, grund, ...)
    if (grund) then
        neuergrund = grund .. " " .. table.concat({ ... }, " ")
        grund = neuergrund
    else
        grund = " Neustart ohne Angabe"
    end
    if not (zeitinminuten) then
        zeitinminuten = 1
    end
    if (zeitinminuten) then
        if (not (tonumber(zeitinminuten))) then
            zeitinminuten = 1
        end
    end
    local second = zeitinminuten * 60 * 1000
    outputDebugString("Shutdown Started by Console in " .. zeitinminuten .. " Minuten! Grund: " .. grund)
    local consolenelement = getElementsByType("console")
    if (isAdminLevel(theMaker, 3)) or (consolenelement[1] == theMaker) then
        if (isTimer(gmxtimer)) then
            killTimer(gmxtimer)
        end
        if (isTimer(secondgmxtimer)) then
            killTimer(secondgmxtimer)
        end
        outputChatBox("Der Server wird in " .. zeitinminuten .. " Minuten heruntergefahren! Grund: " .. grund, getRootElement(), 255, 0, 0)
        outputChatBox("Der Server wird in " .. zeitinminuten .. " Minuten heruntergefahren! Grund: " .. grund, getRootElement(), 255, 0, 0)
        outputChatBox("Der Server wird in " .. zeitinminuten .. " Minuten heruntergefahren! Grund: " .. grund, getRootElement(), 255, 0, 0)
        secondgmxtimer = setTimer(shutdownRestZeit, 60000, 1, zeitinminuten)
        gmxtimer = setTimer(startShutDown, second, 1)
    end
end
addCommandHandler("stopserver", shutdown_func, false, false)

function startShutDown()
    setServerPassword("jhkjgkjhasdgkhaghasdjkf6575")
    local players = getElementsByType("player")
    for theKey, thePlayer in ipairs(players) do
        kickPlayer(thePlayer, "ShutDown")
    end

    local schnitt = 0
    for id, num in ipairs(Tagesdurchnitte) do
        schnitt = schnitt + num
    end
    schnitt = schnitt / table.getn(Tagesdurchnitte)
    serversettings["User_Schnitt"] = schnitt
    save_priv_carsB()

    setTimer(startShutDown_end, 120000, 1)
end

function startShutDown_end()
    setServerPassword(nil)
    triggerEvent("onResourceStop", getResourceRootElement(getThisResource()))
    setTimer(shutdown, 5000, 1)
end

function shutdownRestZeit(zeit)
    if (isTimer(secondgmxtimer)) then
        killTimer(secondgmxtimer)
    end
    zeit = zeit - 1
    outputChatBox("Der Server wird in " .. zeit .. " Minuten heruntergefahren!", getRootElement(), 255, 0, 0)
    outputChatBox("Der Server wird in " .. zeit .. " Minuten heruntergefahren!", getRootElement(), 255, 0, 0)
    outputDebugString("Der Server wird in " .. zeit .. " Minuten heruntergefahren!", 3, 255, 0, 0)
    secondgmxtimer = setTimer(gmxRestTime, 60000, 1, zeit)
end

function gmxRestTime(zeit)
    if (isTimer(secondgmxtimer)) then
        killTimer(secondgmxtimer)
    end
    zeit = zeit - 1
    outputChatBox("Der Serverneustart beginnt in " .. zeit .. " Minuten!", getRootElement(), 255, 0, 0)
    outputChatBox("Der Serverneustart beginnt in " .. zeit .. " Minuten!", getRootElement(), 255, 0, 0)
    outputDebugString("Der Serverneustart beginnt in " .. zeit .. " Minuten!", 3, 255, 0, 0)
    secondgmxtimer = setTimer(gmxRestTime, 60000, 1, zeit)
end

function gmx_start()
    setServerPassword("jhkjgkjhasdgkhaghasdjkf6575")
    local players = getElementsByType("player")
    for theKey, thePlayer in ipairs(players) do
        kickPlayer(thePlayer, "GMX")
    end

    local schnitt = 0
    for id, num in ipairs(Tagesdurchnitte) do
        schnitt = schnitt + num
    end
    schnitt = schnitt / table.getn(Tagesdurchnitte)
    serversettings["User_Schnitt"] = schnitt
    save_priv_carsB()

    setTimer(gmx_end, 120000, 1)
end

function gmx_end()
    restoreAllWorldModels ()
    setServerPassword(nil)
    restartResource(getThisResource())
end

function clearChat_func(theMaker)
    if (isAdminLevel(theMaker, 0)) then
        for i = 1, 100 do
            outputChatBox(" ")
        end
    end
end
addCommandHandler("cleartext", clearChat_func, false, false)

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

function setMoney_func(thePlayer, Command, toPlayerNamePart, theMoney)
    if (isAdminLevel(thePlayer, 2)) then
        if (toPlayerNamePart and theMoney) then
            local toPlayer = getPlayerFromIncompleteName(toPlayerNamePart)
            if (toPlayer and tonumber(theMoney)) then
                vioSetElementData(toPlayer, "bank", 0)
                vioSetElementData(toPlayer, "money", tonumber(theMoney))
                setPlayerMoney(getPlayerMoney(toPlayer))
                local time = getRealTime()
                save_log("setMoney_Log.log", "[" .. time.monthday .. "." .. (time.month + 1) .. "." .. (time.year + 1900) .. " - " .. time.hour .. ":" .. time.minute .. "] " .. getPlayerName(thePlayer) .. " setsMoney of " .. getPlayerName(toPlayer) .. " to " .. toprice(theMoney))
                outputChatBox("Der Admin " .. getPlayerName(thePlayer) .. " hat dein Geld resettet und dein Handgeld auf den Betrag " .. toprice(theMoney) .. " gesetzt!", toPlayer, 255, 0, 0)
                outputChatBox("Du hast das Geld von " .. getPlayerName(toPlayer) .. " resettet und auf den Betrag " .. toprice(theMoney) .. " gesetzt!", thePlayer, 255, 0, 0)

            else
                outputChatBox("Usage: /setMoney [PlayerName] [Betrag]", thePlayer, 255, 0, 0)
            end
        else
            outputChatBox("Usage: /setMoney [PlayerName] [Betrag]", thePlayer, 255, 0, 0)
        end
    end
end
addCommandHandler("setMoney", setMoney_func, false, false)

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
                setPlayerWantedLevel(toPlayer, 6)
                vioSetElementData(toPlayer, "wanteds", vioGetElementData(toPlayer, "wanteds") + wanted)
                outputChatBox("Du hast vom Admin " .. getPlayerName(thePlayer) .. " " .. wanted .. " Wanteds und einen Alkabefehl erhalten, aufgrund deines erhöhten Deathmatches", toPlayer, 255, 0, 0)
                outputChatBox("Du hast " .. getPlayerName(toPlayer) .. " " .. wanted .. " Wanteds und einen Alkabefehl gegeben, aufgrund seines erhöhten Deathmatches", thePlayer, 255, 0, 0)
                outputChatBoxForPolice("Der Admin " .. getPlayerName(thePlayer) .. " hat " .. getPlayerName(toPlayer) .. " " .. wanted .. " Wanteds und einen Alkabefehl gegeben, aufgrund seines erhöhten Deathmatches")

                if (direkt) then
                    if (tonumber(direkt)) then
                        if (tonumber(direkt) == 1) then
                            if (isPedInVehicle(toPlayer)) then
                                removePedFromVehicle(toPlayer)
                            end
                            setElementInterior(toPlayer, 0)
                            setElementDimension(toPlayer, 0)
                            vioSetElementData(toPlayer, "kaution", 0)
                            vioSetElementData(toPlayer, "knastzeit", vioGetElementData(toPlayer, "wanteds") * 10 + 60)
                            vioSetElementData(toPlayer, "lastknastzeit", vioGetElementData(toPlayer, "wanteds") * 10 + 60)
                            vioSetElementData(toPlayer, "alkaknast", 1)
                            outputChatBox("Du wurdest nun in das Alkatraz eingebuchtet!", toPlayer, 255, 0, 0)
                            outputChatBox("Du hast " .. getPlayerName(toPlayer) .. " in das Alkataz gebuchtet!", thePlayer, 255, 0, 0)
                            local x, y, z = getKnastKoordinaten(toPlayer, 1)
                            setElementPosition(toPlayer, x, y, z)
                            setElementInterior(toPlayer, 2)
                            setElementModel(toPlayer, 62)
                            vioSetElementData(toPlayer, "mussAlka", 0)
                            vioSetElementData(toPlayer, "wanteds", 0)
                            setPlayerWantedLevel(toPlayer, 0)
                            outputChatBoxForPolice(getPlayerName(toPlayer) .. " wurde von einem Mitglied der Moderation/Administration direkt ins Alkatraz eingeknastet!")
                        end
                    end
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
