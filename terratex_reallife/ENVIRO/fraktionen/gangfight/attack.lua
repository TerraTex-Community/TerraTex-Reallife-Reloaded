--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 17.10.2016
-- Time: 11:58
-- To change this template use File | Settings | File Templates.
--

function cmdAttack(thePlayer, cmd, ...)
-- is Player in a faction that can attack?
    if (frakmun[vioGetElementData(thePlayer, "fraktion")]) then
        local gfPosition, gfPositionData = getNearGfPosition(thePlayer);
--      ist der Spieler in der Nähe eines GFs?
        if (gfPosition) then
            if (tonumber(gfPositionData.Owner) == -1) then
--              Wenn es keinen Besitzer gibt setze Fraktion gleich als Gewinner
                gfPositionData.Owner = vioGetElementData(thePlayer, "fraktion");
                outputChatBox("Ihr habt den Laden übernommen!", thePlayer);
                vioSetElementData(gfPosition, "data", gfPositionData);
                calcAndSaveGfPositionIncome();
            else
--              @todo: replace this namelisting with UI
                local players = {...};
                if (table.getSize(players) > 0) then
                    for theKey, theUserName in ipairs(players) do
                        local player = getPlayerFromIncompleteName(theUserName);
                        if not player then
                            showError(thePlayer, "Der Spieler ".. theUserName .. " existiert nicht!");
                            return;
                        end

                        if (getElementsDistanceToPoint(player, gfPositionData.X, gfPositionData.Y, gfPositionData.Z) > 30) then
                            showError(thePlayer, "Der Spieler ".. theUserName .. " ist nicht in der Nähe des Gangfights!");
                            return;
                        end
                    end

                    if (table.getSize(players) <= getMaxDefenders(tonumber(gfPositionData.Owner))) then
                        local gfElement = getElementById("GFSync");
                        local data = vioGetElementData(gfElement, "data");

                        if (not data.attackInProcess)then

                            local blip = createBlip ( gfPositionData.X, gfPositionData.Y, gfPositionData.Z, 19, 2, 255, 0, 0, 255, 0, 99999.0, getRootElement() )
                            vioSetElementData(blip, "flashing");
                            setElementVisibleTo ( blip, getRootElement(), false );
                            for theKey, theMember in ipairs(team[vioGetElementData(thePlayer, "fraktion")]) do
                                setElementVisibleTo ( blip, theMember, true );
                            end
                            for theKey, theMember in ipairs(team[tonumber(gfPositionData.Owner)]) do
                                setElementVisibleTo ( blip, theMember, true );

                                outputChatBox("Einer eurer Läden wird angegriffen! Fahrt hin und verteidigt ihn!", theMember, 255, 0, 0);
                            end

                            data.attackInProcess = true;
                            data.attack = gfPosition;
                            data.attackFaction = vioGetElementData(thePlayer, "fraktion");
                            data.defendFaction = tonumber(gfPositionData.Owner);
                            data.attackers = players;
                            data.defenders = {};
                            data.round = 0;
                            data.timer = setTimer(noDefendersOnGf, (10 * 60 * 1000), 1);
                            data.blip = blip;

                            vioSetElementData(gfElement, "data", data);
                        else
                            showError(thePlayer, "Es läuft bereits ein Gangfight!");
                        end
                    else
                        showError(thePlayer, "Ihr seid zuviele! Es stehen nur " .. getMaxDefenders(tonumber(gfPositionData.Owner)) .. " Verteidiger zur Verfügung.");
                    end
                else
                    showError(thePlayer, "Usage: /attack playername playername2 playername3 ...");
                end
            end
        else
            showError(thePlayer, "Du bist nicht in der Nähe eines Ladens!");
        end
    end
end
addCommandHandler("attack", cmdAttack, false, false)

function noDefendersOnGf()
--    @todo implement
end

function cmdDefend(thePlayer, cmd, ...)
    --    @todo implement
end
addCommandHandler("defend", cmdDefend, false, false)