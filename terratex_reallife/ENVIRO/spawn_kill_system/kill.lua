local resetKrankenhaus = {}

function setEndDeath_command_func(thePlayer, command, toPlayer)
    if (isAdminLevel(thePlayer, 3)) then
        if (toPlayer) then
            local to = getPlayerFromIncompleteName(toPlayer)
            if (to) then
                if (isTimer(vioGetElementData(to, "resetKrankenhausTimer"))) then
                    killTimer(vioGetElementData(to, "resetKrankenhausTimer"))
                end
                local Icon = vioGetElementData(to, "isDeathPlayer")
                if (isElement(Icon)) then
                    destroyElement(Icon)
                    destroyElement(vioGetElementData(to, "isDeathPlayerBlip")) -- Das wurde veergessen gegenüber dem standard (Todesmarker)
                    vioSetElementData(to, "isDeathPlayer", false)
                end
                triggerClientEvent(to, "admin_EndDeath", to) -- Nach hinten verschoben, in der hoffnung, das timer für krankenhaus damit gleich stoppt
            end
        end
    end
end
addCommandHandler("enddeath", setEndDeath_command_func, false, false)

function setDeath_command_func(thePlayer, command, toPlayer)
    if (isAdminLevel(thePlayer, 3)) then
        if (toPlayer) then
            local to = getPlayerFromIncompleteName(toPlayer)
            if (to) then
                triggerEvent("onCustomPlayerDamage", to, thePlayer, 34, 9, 500)
            end
        end
    end
end
addCommandHandler("setdeath", setDeath_command_func, false, false)

function showdeath_func(thePlayer)
    if (vioGetElementData(thePlayer, "fraktion") == 10) then
        if (vioGetElementData(thePlayer, "isShowingMedicDeathBlip")) then
            vioSetElementData(thePlayer, "isShowingMedicDeathBlip", false)
            outputChatBox("Todesanzeigen abgeschaltet!", thePlayer, 255, 0, 0)
        else
            vioSetElementData(thePlayer, "isShowingMedicDeathBlip", true)
            outputChatBox("Todesanzeigen angeschaltet!", thePlayer, 255, 0, 0)
        end
    end
end
addCommandHandler("showdeath", showdeath_func, false, false)

function onDiscoDeleteIcons()
    if (isElement(vioGetElementData(source, "isDeathPlayer"))) then
        destroyElement(vioGetElementData(source, "isDeathPlayer"))
        destroyElement(vioGetElementData(source, "isDeathPlayerBlip"))
    end
end
addEventHandler("onPlayerQuit", getRootElement(), onDiscoDeleteIcons)

function death_func(ammo, attacker, weapon, bodypart)
    local gfElement = getElementByID("GFSync");
    local gfData = vioGetElementData(gfElement, "data");

    if not (vioGetElementData(source, "inArena")) and not (table.hasValue(gfData.attackers, source)) and not (table.hasValue(gfData.defenders, source)) then

        local wasBlacklistOrWantedKill = false

        local x, y, z = getElementPosition(source)
        local int = getElementInterior(source)
        local dim = getElementDimension(source)
        local pick = createPickup(x, y, z, 3, 1254, 5000)
        vioSetElementData(pick, "isDeathPlayer", source)
        vioSetElementData(source, "isDeathPlayer", pick)
        setElementInterior(pick, int)
        setElementDimension(pick, dim)
        addEventHandler("onPickupHit", pick, medicWiederBeleben)

        local mechaBlip = createBlip(x, y, z)
        triggerClientEvent(source, "syncDeathPickupToGround", pick)
        setElementVisibleTo(mechaBlip, getRootElement(), false)
        for theKey, thePerson in ipairs(getPlayersInTeam(team[10])) do
            if (vioGetElementData(thePerson, "isShowingMedicDeathBlip")) then
                setElementVisibleTo(mechaBlip, thePerson, true)
                showError(thePerson, "Jemand ist gestorben!")
            end
        end
        vioSetElementData(source, "isDeathPlayerBlip", mechaBlip)

        local todelast = vioGetElementData(source, "todelast")

        if (not todelast) then
            todelast = 0;
        end

        local deathtime = 200 + (todelast) * 30
        todelast = todelast + 1

        local wasOnABlacklist = false
        if (attacker) then
            if (blacklist[vioGetElementData(attacker, "fraktion")]) then
                local toPlayerName = getPlayerName(source)
                local isonit = false
                local isonitkey = 0
                for theKey, thePerson in ipairs(blacklist[vioGetElementData(attacker, "fraktion")]) do
                    if (string.lower(thePerson[1])) == (string.lower(toPlayerName)) then
                        isonit = true
                        isonitkey = theKey
                        break
                    end
                end
                if (isonit) then
                    wasOnABlacklist = true;

                    MySql.helper.delete("faction_blacklist", {
                        Name = toPlayerName,
                        Fraktion = vioGetElementData(attacker, "fraktion")
                    });

                    table.remove(blacklist[vioGetElementData(attacker, "fraktion")], isonitkey);

                    wasBlacklistOrWantedKill = true;
                    for theKey, thePlayers in ipairs(getPlayersInTeam(team[vioGetElementData(attacker, "fraktion")])) do
                        outputChatBox(string.format("Der Spieler %s wurde von %s von der Blacklist getötet!", toPlayerName, getPlayerName(attacker)), thePlayers, 0, 0, 255)
                    end
                    outputChatBox("Du wurdest von einer Gang/Mafia getötet! Passe besser auf dich auf und lege dich nicht mit den falschen Leuten an!", source, 0, 0, 255)
                end
            end

            if (vioGetElementData(source, "kopfgeld") > 0) and (vioGetElementData(attacker, "job") == 7 or (vioGetElementData(attacker, "fraktion") == 8)) then
                wasBlacklistOrWantedKill = true;
                changePlayerMoney(attacker, vioGetElementData(source, "kopfgeld"), "job", "Kopfgeld Auszahlung")
                local koppgeld = vioGetElementData(source, "kopfgeld")
                vioSetElementData(source, "kopfgeld", 0)
                outputChatBox(string.format("Du hast %s getötet und erhälst %s", getPlayerName(source), toprice(koppgeld)), attacker, 0, 255, 0)
                outputChatBox("Über deiner Leiche hängt ein Nebel!", source, 0, 255, 0)
                outputChatBox("Du musst auf Grund deiner verletzungen länger im Krankenhaus liegen! (Kopfgeld Kill)", source, 0, 255, 0)
                deathtime = deathtime * 2 + 30
                destroyElement(pick)
                destroyElement(mechaBlip)
                vioSetElementData(source, "isDeathPlayer", false)
            else
                if vioGetElementData(source, "fraktion") == 0 and not (isBeamter(attacker)) and not (attacker == source) and not (wasOnABlacklist) and getElementType(attacker) == "player" then
                    local crimeId = 1100;
                    if (isInRuheZone(attacker)) then
                        crimeId = 1101;
                    end

                    CrimeSystem.addNewCrime(attacker, crimeId, "System");

                    outputChatBoxForPolice(getPlayerName(attacker) .. " hat eine neue Straftat begangen");
                end
            end

            if (bodypart == 9) then
                setPedHeadless(source, true)
            end

            if (isBeamter(attacker)) and (CrimeSystem.getCrimePercentage(source) > 0) then
                wasBlacklistOrWantedKill = true;

                vioSetElementData(source, "alkaknast", CrimeSystem.Jail.getJailIdInArea(source))

                vioSetElementData(source, "knastzeit", CrimeSystem.getNewJailTime(source, false));
                vioSetElementData(source, "lastknastzeit", CrimeSystem.getNewJailTime(source, false));

                showError(source, string.format("Du bist nun im Knast fuer %s Minuten!", vioGetElementData(source, "knastzeit")))
                CrimeSystem.clear(source)
                vioSetElementData(source, "kaution", 0)
                outputChatBox(string.format("Du hast %s erfolgreich hinter Gitter gebracht!", getPlayerName(source)), attacker, 0, 0, 255)
                outputChatBoxForPolice(string.format("%s wurde von %s hinter Gitter gebracht.", getPlayerName(source), getPlayerName(attacker)), 0, 0, 255)

                if (vioGetElementData(source, "mussAlka") == 1) then

                    outputChatBoxForPolice(string.format("%s muss nun ins Alka überführt werden (Administrativer Auftrag)!", getPlayerName(source)))
                    outputChatBoxForPolice(string.format("%s muss nun ins Alka überführt werden (Administrativer Auftrag)!", getPlayerName(source)), 255, 0, 0)
                end
            end
        end

        local timeHandled = false;
        if (vioGetElementData(source, "overwriteDeathTime")) then
            if (vioGetElementData(source, "overwriteDeathTime") > 0) then
                local newDeathTime = vioGetElementData(source, "overwriteDeathTime");
                setElementData(source, "todezeit", newDeathTime);
                timeHandled = true;
                vioSetElementData(source, "overwriteDeathTime", false);
            end
        end

        if not timeHandled then
            vioSetElementData(source, "todelast", (todelast))
            vioSetElementData(source, "tode", (vioGetElementData(source, "tode") + 1))
            setElementData(source, "todezeit", deathtime)
        end

        loadKrankenhaus(source)

        -- logging
        if (attacker and attacker ~= source and getElementType(attacker) == "player") then
            if wasBlacklistOrWantedKill then
                wasBlacklistOrWantedKill = 1
            else
                wasBlacklistOrWantedKill = 0
            end

            MySql.helper.insert("log_kills", {
                Attacker = getPlayerName(attacker),
                Target = getPlayerName(source),
                AttackerFaction = vioGetElementData(attacker, "fraktion"),
                TargetFaction = vioGetElementData(source, "fraktion"),
                BlacklistOrWantedkill = wasBlacklistOrWantedKill,
                WeaponID = weapon
            });
        end
    end
end
addEventHandler("onPlayerWasted", getRootElement(), death_func)

addEvent("killMyDeathIcon", true)
function killMyDeathIcon()
    local Icon = vioGetElementData(source, "isDeathPlayer")
    if (isElement(Icon)) then
        destroyElement(Icon)
        destroyElement(vioGetElementData(source, "isDeathPlayerBlip"))
        vioSetElementData(source, "isDeathPlayer", false)
    end
end
addEventHandler("killMyDeathIcon", getRootElement(), killMyDeathIcon)

function medicWiederBeleben(thePlayer)
    if (vioGetElementData(thePlayer, "fraktion") == 10) then
        if (not isPedInVehicle(thePlayer)) then
            if (vioGetElementData(thePlayer, "isMedicDuty")) then
                setElementFrozen(thePlayer, true)
                outputChatBox("Du beginnst diese Leiche wiederzubeleben! (Dauer 10 Sekunden)", thePlayer)
                local surriver = vioGetElementData(source, "isDeathPlayer")
                destroyElement(vioGetElementData(surriver, "isDeathPlayerBlip"))
                destroyElement(source)
                setTimer(medic_wiederbelebenende, 10000, 1, thePlayer, surriver)
            else
                outputChatBox("Du bist nicht im Dienst!", thePlayer, 255, 0, 0);
            end
        end
    end
end

function medic_wiederbelebenende(theMedic, thePickup)
    setElementFrozen(theMedic, false)
    triggerClientEvent(thePickup, "end_kill", thePickup)
    outputChatBox("Die Wiederbelebung wurde vom Bankkonto oder Versicherung gezahlt! (200$ - 100$ in Frakkasse)", theMedic)
    if (vioGetElementData(thePickup, "lebensversicherung") == 0) then
        outputChatBox("Die Sonderbehandlung eines Arztes wurde von ihrem Bankkonto bezahlt (200$)", thePickup)
        changePlayerBank(thePickup, -200, "sonstiges", "Wiederbelebung durch Medic")
    else
        outputChatBox("Die Sonderbehandlung wurde von deiner Lebensversicherung bezahlt!", thePickup)
    end
    changePlayerMoney(theMedic, 100, "fraktion", "Person wiederbelebt")
    frakkasse[10] = frakkasse[10] + 100.00
end

function loadKrankenhaus(thePlayer)
    triggerClientEvent(thePlayer, "setHalfFoodLevel", thePlayer)
    if (thePlayer) then
        setCameraMatrix(thePlayer, 1213.21826, -1326.199096, 25.8984375, 1172.643066, -1324.076171875, 14.15533638, 0, 90)
        local zeit = tonumber(getElementData(thePlayer, "todezeit"));
        triggerClientEvent(thePlayer, "beDeath", thePlayer, zeit)
        vioSetElementData(thePlayer, "resetKrankenhausTimer", setTimer(resetToKra, 10000, 1, thePlayer))
    end
end

function resetToKra(thePlayer)
    if (isElement(thePlayer)) then
        if (isPedDead(thePlayer)) then
            setCameraMatrix(thePlayer, 1213.21826, -1326.199096, 25.8984375, 1172.643066, -1324.076171875, 14.15533638, 0, 90)
            if (isTimer(vioGetElementData(thePlayer, "resetKrankenhausTimer"))) then
                killTimer(vioGetElementData(thePlayer, "resetKrankenhausTimer"))
            end
        end
    end
end

function setDeathEnd()
    setElementData(source, "todezeit", 0)
    if (vioGetElementData(source, "fraktion") > 1 and vioGetElementData(source, "fraktion") ~= 5) then
        setPlayerSpawn(source, vioGetElementData(source, "spawnplace"), vioGetElementData(source, "FrakSkin"), vioGetElementData(source, "fraktion"))

    else
        setPlayerSpawn(source, vioGetElementData(source, "spawnplace"), vioGetElementData(source, "skinid"), vioGetElementData(source, "fraktion"))
    end
end
addEvent("setTodeZeitEnd", true)
addEventHandler("setTodeZeitEnd", getRootElement(), setDeathEnd)

addEvent("setDeathBlipPos", true)
function setDeathBlipPos_func(x, y, z)
    setElementPosition(source, x, y, z)
end
addEventHandler("setDeathBlipPos", getRootElement(), setDeathBlipPos_func)








