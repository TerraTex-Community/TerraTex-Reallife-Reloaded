--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 27.07.2016
-- Time: 15:40
-- To change this template use File | Settings | File Templates.
--

-- @todo: suspects (old /wanteds - maybe fallback)
-- Alkamessage

function cmdSu(thePlayer, cmd, toPlayerName, crimeCode, ...)
    if (isBeamter(thePlayer)) then
        local additionalDescription = table.concat({...}, " ");
        if (additionalDescription == "") then
            additionalDescription = false;
        end

        local toPlayer = getPlayerFromIncompleteName(toPlayerName);

        if (toPlayer) then
            if (CrimeSystem.addNewCrime(toPlayer, tonumber(crimeCode), thePlayer, additionalDescription)) then
                local crime = CrimeSystem.getCrimeName(tonumber(crimeCode));
                outputChatBoxForPolice(getPlayerName(thePlayer) .. " hat das Verbrechen " .. crime .. " zu " .. getPlayerName(toPlayer) .. "s Akte hinzugefügt.");
                if (additionalDescription) then
                    outputChatBoxForPolice("Er hat eine zusätzliche Notiz angefügt: " .. additionalDescription);
                end
            else
                showError(thePlayer, "Dieser Verbrechenscode existiert nicht!");
            end
        else
            showError(thePlayer, "Dieser Spieler existiert nicht!");
        end
    end
end
addCommandHandler("su", cmdSu, false, false);

function cmdArrest(thePlayer, cmd, toPlayerName, voluntary)
    if (isBeamter(thePlayer)) then
        local jail = CrimeSystem.isNearJailPoint(thePlayer);
        if (jail) then
            local toPlayer = getPlayerFromIncompleteName(toPlayerName);
            if (toPlayer) then
                local percentage = CrimeSystem.getCrimePercentage(toPlayer);

                if (percentage > 0) then
                    if (vioGetElementData(toPlayer, "knastzeit") == 0) then
                        if (getElementsDistance(toPlayer, thePlayer) < 20) then
                            if (tonumber(voluntary) == 0) then
                                voluntary = false;
                            end

                            local kaution = 0;
                            local jailTime = 0;

                            if (voluntary) then
                                kaution = CrimeSystem.getBail(toPlayer, false);
                                jailTime = CrimeSystem.getNewJailTime(toPlayer, true);
                            else
                                jailTime = CrimeSystem.getNewJailTime(toPlayer, false);
                            end

                            vioSetElementData(toPlayer, "knastzeit", jailTime);
                            vioSetElementData(toPlayer, "lastknastzeit", jailTime);
                            vioSetElementData(toPlayer, "kaution", kaution);

                            setElementModel(toPlayer, 62);

                            if (kaution == 0) then kaution = "keine"; else kaution = toprice(kaution); end

                            outputChatBox(string.format("Du sitzt %s Minuten im Knast. Kaution: %s", jailTime, kaution), toPlayer);
                            outputChatBoxForPolice(string.format(getPlayerName(thePlayer) .. " hat %s eingesperrt!", getPlayerName(toPlayer)));

                            local int, x,y,z = CrimeSystem.Jail.getRandomJailSpawnByJailName(jail);
                            vioSetElementData(toPlayer, "alkaknast", CrimeSystem._jailTextToId[jail]);
                            setElementPosition(toPlayer, x,y,z);

                            if (vioGetElementData(toPlayer, "mussAlka") == 1) then
                                outputChatBoxForPolice(string.format("Der Spieler %s muss in das Alkatraz gebracht werden!", getPlayerName(toPlayer)));
                            end

                            CrimeSystem.clear(toPlayer);
                        else
                            showError(thePlayer, "Der Spieler ist nicht in deiner Nähe!");
                        end
                    else
                        showError(thePlayer, "Dieser Spieler sitzt bereits im Knast!");
                    end
                else
                    showError(thePlayer, "Dieser Spieler ist kein Verbrecher!");
                end
            else
                showError(thePlayer, "Der Spieler existiert nicht");
            end
        else
            showError(thePlayer, "Du bist in der Nähe eines Knastes!");
        end
    end
end
addCommandHandler("arrest", cmdArrest, false, false);

function cmdBail(thePlayer)
    if (vioGetElementData(thePlayer, "knastzeit") > 0) then
        if (vioGetElementData(thePlayer, "kaution") > 0) then
            local kaution = vioGetElementData(thePlayer, "kaution");

            local jailtime = vioGetElementData(thePlayer, "knastzeit");
            local totalJailtime = vioGetElementData(thePlayer, "lastknastzeit");

            local factor = math.round(jailtime / totalJailtime);
            if factor < 0.1 then factor = 0.1; end
            kaution = kaution * factor;

            if (kaution <= getPlayerMoney(thePlayer)) then
                changePlayerMoney(thePlayer, (-kaution), "sonstiges", "Kaution");
                CrimeSystem.Jail.unArrest(thePlayer);
            elseif (kaution <= getPlayerBank(thePlayer)) then
                changePlayerBank(thePlayer, (-kaution), "sonstiges", "Kaution");
                CrimeSystem.Jail.unArrest(thePlayer);
            else
                showError(thePlayer, "Du konntest die Kaution (" .. toprice(kaution) .. ") weder Bar noch durch deine Bank bezahlen!");
            end
        else
            showError(thePlayer, "Du kannst nicht auf Kaution vom Knast entlassen werden!");
        end
    end
end
addCommandHandler("bail", cmdBail, false, false);

function cmdJailTime(thePlayer, cmd, toPlayerName)
    if ((isBeamter(thePlayer) or isAdminLevel(thePlayer, 1)) and toPlayerName) then
        local toPlayer = getPlayerFromIncompleteName(toPlayerName);
        if (toPlayer) then
            local jailtime = vioGetElementData(toPlayer, "knastzeit");
            local totalJailtime = vioGetElementData(toPlayer, "lastknastzeit");
            outputChatBox("Der Spieler " .. getPlayerName(toPlayer) .. " muss noch " .. jailtime .."/" .. totalJailtime .. " Minuten im Knast sitzen.", thePlayer);
        else
            showError(thePlayer, "Dieser Spieler Existiert nicht!");
        end
    else
        local jailtime = vioGetElementData(thePlayer, "knastzeit");
        local totalJailtime = vioGetElementData(thePlayer, "lastknastzeit");
        outputChatBox("Du musst noch " .. jailtime .."/" .. totalJailtime .. " Minuten im Knast sitzen.", thePlayer);
    end
end
addCommandHandler("jailtime", cmdJailTime, false, false);

function cmdDearrest(thePlayer, cmd, toPlayerName)
    if (isBeamter(thePlayer) and vioGetElementData(thePlayer, "fraktionsrang") > 1) then
        if (toPlayerName) then
            local toPlayer = getPlayerFromIncompleteName(toPlayerName);
            if (toPlayer) then
                if (vioGetElementData(toPlayer, "knastzeit") > 0) then
                    if (getElementsDistance(toPlayer, thePlayer) < 25) then
                        showError(thePlayer, "Der Spieler wird in wenigen Minuten aus seiner Zelle entlassen.");
                        showError(toPlayer, "Du wirst in wenigen Minuten aus deiner Zelle entlassen.");
                        setTimer(timerUnArrest, math.random(1000,150000), 1, toPlayer);
                    else
                        showError(thePlayer, "Du musst bei der Zelle des Spielers sein, um ihn zu entlassen.");
                    end
                else
                    showError(thePlayer, "Dieser Spieler sitzt nicht im Knast!");
                end
            else
                showError(thePlayer, "Dieser Spieler existiert nicht!");
            end
        else
            showError(thePlayer, "Usage: /dearrest [playername]");
        end
    end
end
addCommandHandler("dearrest", cmdDearrest, false, false);

function timerUnArrest(thePlayer)
    vioSetElementData(thePlayer, "oldJailTime", vioGetElementData(thePlayer, "knastzeit"));
    CrimeSystem.Jail.unArrest(thePlayer);
end