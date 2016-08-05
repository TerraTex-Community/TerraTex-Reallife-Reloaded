--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 27.07.2016
-- Time: 15:40
-- To change this template use File | Settings | File Templates.
--

-- @todo arrest
-- elementdata alkaknast = 0 (ls) || 2 (lv)
-- mussAlka info
-- kaution
-- costs
-- setElementModel(thePlayer, 62)

-- @todo: bail

-- @todo: suspects (old /wanteds - maybe fallback)
-- Alkamessage

function cmdBail(thePlayer)
    if (vioGetElementData(thePlayer, "knastzeit") > 0) then
        if (vioGetElementData(thePlayer, "kaution") > 0) then
            local kaution = vioGetElementData(thePlayer, "kaution");

            local jailtime = vioGetElementData(toPlayer, "knastzeit");
            local totalJailtime = vioGetElementData(toPlayer, "lastknastzeit");

            local factor = Math.round(jailtime * totalJailtime);
            if factor < 0.1 then factor = 0.1; end
            kaution = kaution * factor;

            if (kaution <= changePlayerMoney(thePlayer)) then
                changePlayerMoney(thePlayer, -kaution, "sonstiges", "Kaution");
                CrimeSystem.Jail.unArrest(thePlayer);
            elseif (kaution <= getPlayerBank(thePlayer)) then
                changePlayerBank(thePlayer, -kaution, "sonstiges", "Kaution");
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
                        setTimer(timerUnArrest, math.random(30000,150000), 1, toPlayer);
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