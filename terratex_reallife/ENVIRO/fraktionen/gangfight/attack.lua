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
                if (gfPosition.lastFight > getRealTime().timestamp - (3 * 60 )) then
                    showError(thePlayer, "Ein Laden kann nur alle 3 Stunden angegriffen werden!");
                    return;
                end

--              @todo: replace this namelisting with UI
                local players = {...};
                local playersElements = {};
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

                        if vioGetElementData(player, "fraktion") ~= vioGetElementData(thePlayer, "fraktion") then
                            showError(thePlayer, "Der Spieler ".. theUserName .. " ist kein Mitglied deiner Fraktion!");
                            return;
                        end
                        table.insert(playersElements, player);
                    end

                    if (table.getSize(players) <= getMaxDefenders(tonumber(gfPositionData.Owner))) then
                        local gfElement = getElementByID("GFSync");
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
                                outputChatBox("Einer eurer Läden wird angegriffen! Fahrt hin und verteidigt ihn (mit bis zu " .. table.getSize(players) .. " Teilnehmern)!", theMember, 255, 0, 0);
                            end

                            data.attackInProcess = true;
                            data.attack = gfPosition;
                            data.attackFaction = vioGetElementData(thePlayer, "fraktion");
                            data.defendFaction = tonumber(gfPositionData.Owner);
                            data.attackers = playersElements;
                            data.defenders = {};
                            data.round = 0;
                            data.timer = setTimer(noDefendersOnGf, (10 * 60 * 1000), 1);
                            data.blip = blip;
                            data.roundsAttackers = 0;
                            data.roundsDefenders = 0;

                            vioSetElementData(gfElement, "data", data);

                            for theKey, player in ipairs(players) do
                                showError(player, "Der Angriff wurde gestartet, bitte warte auf die Verteidiger!");
                                setElementDimension(player, 1337);
                            end
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
    local gfElement = getElementByID("GFSync");
    local data = vioGetElementData(gfElement, "data");


    for theKey, theMember in ipairs(team[data.defendFaction]) do
        outputChatBox("Ihr seid zu spät! Ihr habt den Laden verloren!", theMember, 255, 0, 0);
    end

    for theKey, player in ipairs(data.attackers) do
        showError(player, "Der Laden gehört nun euch!");
        setElementDimension(player, 0);
    end

    destroyElement(data.blip);
    local gfPosition = data.attack;

    local gfPositionData = vioGetElementData(data.attack, "data")
    gfPositionData.Owner = data.attackFaction;
    gfPositionData.lastFight = getRealTime().timestamp;
    gfPositionData.HoursWithoutAttack = 0;
    vioSetElementData(gfPosition, "data", gfPositionData);
    calcAndSaveGfPositionIncome();

    data.attackInProcess = false;
    data.attack = false;
    data.attackFaction = 0;
    data.defendFaction = 0;
    data.attackers = {};
    data.defenders = {};
    data.round = 0;
    data.roundsAttackers = 0;
    data.roundsDefenders = 0;
    data.timer = false;
    data.blip = false;
    vioSetElementData(gfElement, "data", data);
end

function cmdDefend(thePlayer, cmd, ...)
    local gfElement = getElementByID("GFSync");
    local data = vioGetElementData(gfElement, "data");

    if (data.attackInProcess) then

        local gfPosition = data.attack;
        local gfPositionData = vioGetElementData(gfPosition, "data");

        if (data.attackFaction == vioGetElementData(thePlayer, "fraktion")) then
--            @todo: implement ui for that
            local players = {...};
            local playersElements = {};
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

                    if vioGetElementData(player, "fraktion") ~= vioGetElementData(thePlayer, "fraktion") then
                        showError(thePlayer, "Der Spieler ".. theUserName .. " ist kein Mitglied deiner Fraktion!");
                        return;
                    end
                    table.insert(playersElements, player);
                end

                if (table.getSize(players) <= table.getSize(data.attackers)) then
                    data.defenders = playersElements;
                    if (isTimer(data.Timer)) then killTimer(data.Timer) end

                    local costDef = table.getSize(data.defenders) * 2500;
                    local costAttack = table.getSize(data.attackers) * 5000;

                    frakmun[data.attackFaction] = frakmun[data.attackFaction] - costAttack;
                    frakmun[data.defendFaction] = frakmun[data.defendFaction] - costDef;

                    for theKey, theMember in ipairs(data.defenders) do
                        outputChatBox("Die Kosten von " .. costDef .. " Materialien für den GF wurden vom Depot eingezogen.", theMember);
                        outputChatBox("Der Gangfight beginnt in wenigen Sekunden .... ", theMember, 255, 0, 0)
                        setElementDimension(theMember, 1337);
                    end
                    for theKey, theMember in ipairs(data.attackers) do
                        outputChatBox("Die Kosten von " .. costAttack .. " Materialien für den GF wurden vom Depot eingezogen.", theMember);
                        outputChatBox("Der Gangfight beginnt in wenigen Sekunden .... ", theMember, 255, 0, 0)
                    end

                    data.timer = setTimer(startGf, 5000, 1);
                    vioSetElementData(gfElement, "data", data);


                else
                    showError(thePlayer, "Ihr seid zuviele! Es stehen nur " .. table.getSize(data.attackers) .. " Angreifer zur Verfügung.");
                end
            else
                showError(thePlayer, "Usage: /defend name1 name2 name3 ...");
            end
        end
    end
end
addCommandHandler("defend", cmdDefend, false, false)