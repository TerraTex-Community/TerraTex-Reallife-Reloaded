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

-- @todo checkjailtime for admin / beamte
-- "Der Spieler %s muss noch %s von %s Minuten im %s sitzen!"

-- @todo: jailtime

-- @todo: bail

-- @todo: suspects (old /wanteds - maybe fallback)
-- Alkamessage

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

function timerUnArrest(thePlayer)
    vioSetElementData(thePlayer, "oldJailTime", vioGetElementData(thePlayer, "knastzeit"));
    CrimeSystem.Jail.unArrest(thePlayer);
end