--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 17.10.2016
-- Time: 15:17
-- To change this template use File | Settings | File Templates.
--

local colshapes = {};
local disableSpawnCollision;
local startedRound = false;

function startGf()
    local gfElement = getElementByID("GFSync");
    local data = vioGetElementData(gfElement, "data");
    local gfPosition = data.attack;
    local gfPositionData = vioGetElementData(gfPosition, "data");

--    create ColShapes
    disableSpawnCollision = createColCircle ( gfPositionData.X, gfPositionData.Y, 1.5 );
    table.insert(colshapes, disableSpawnCollision);
    setElementDimension(disableSpawnCollision, 1337);
    addEventHandler("onColShapeLeave", disableSpawnCollision, resetElementCollision);

    disableSpawnCollision = createColCircle ( gfPositionData.ASpawnX, gfPositionData.ASpawnY, 1.5 );
    table.insert(colshapes, disableSpawnCollision);
    setElementDimension(disableSpawnCollision, 1337);
    addEventHandler("onColShapeLeave", disableSpawnCollision, resetElementCollision);

    local killPlayerColShape = createColCircle ( gfPositionData.X, gfPositionData.Y, gfPositionData.RSmall );
    table.insert(colshapes, killPlayerColShape);
    setElementDimension(killPlayerColShape, 1337);
    vioSetElementData(killPlayerColShape, "gfColType", 1);
    addEventHandler("onColShapeLeave", killPlayerColShape, sendKillWarning);

    local killPlayerColShape = createColCircle ( gfPositionData.ASpawnX, gfPositionData.ASpawnY, gfPositionData.RLarge );
    table.insert(colshapes, killPlayerColShape);
    setElementDimension(killPlayerColShape, 1337);
    vioSetElementData(killPlayerColShape, "gfColType", 2);
    addEventHandler("onColShapeLeave", killPlayerColShape, sendKillWarning);

    startRound();
end

function sendKillWarning(element, matchDim)
    if (matchDim) then
        local gfElement = getElementByID("GFSync");
        local data = vioGetElementData(gfElement, "data");

        local type = vioGetElementData(killPlayerColShape, "gfColType");
        if (type == 1) then
            --        attacker colshape
            if (data.round % 2 == 1) then
                if (data.attackFaction == vioGetElementData(element, "fraktion"))then
                    triggerClientEvent(element, "sendGfKillWarning", source, 10);
                end
            else
                if (data.defendFaction == vioGetElementData(element, "fraktion"))then
                    triggerClientEvent(element, "sendGfKillWarning", source, 10);
                end
            end
        else
            --        defender colshape
            if (data.round % 2 == 1) then
                if (data.defendFaction == vioGetElementData(element, "fraktion"))then
                    triggerClientEvent(element, "sendGfKillWarning", source, 10);
                end
            else
                if (data.attackFaction == vioGetElementData(element, "fraktion"))then
                    triggerClientEvent(element, "sendGfKillWarning", source, 10);
                end
            end
        end
    end
end

function resetElementCollision(element, matchDim)
    if (matchDim) then
        setElementCollisionsEnabled ( element, true);
    end
end

-- clean up after GF
function destroyAllColShapes()
    for theKey, theColShape in ipairs(colshapes) do
        destroyElement(theColShape);
    end
    colshapes = {};
end

-- GF
function startRound()
--    Spawn Players Team Attack
    local gfElement = getElementByID("GFSync");
    local data = vioGetElementData(gfElement, "data");
    local gfPosition = data.attack;
    local gfPositionData = vioGetElementData(gfPosition, "data");

    for theKey, thePlayer in ipairs(data.attackers) do
        killPed(thePlayer);
    end

    for theKey, thePlayer in ipairs(data.defenders) do
        killPed(thePlayer);
    end

    setTimer(spawnFirstTeam, 5000, 1);
end

function spawnFirstTeam()

    local gfElement = getElementByID("GFSync");
    local data = vioGetElementData(gfElement, "data");
    local gfPosition = data.attack;
    local gfPositionData = vioGetElementData(gfPosition, "data");

    data.round = data.round + 1;
    if (data.round % 2 == 1) then
        -- in rounds 1,3 and 5 spawn Attacker Team
        for theKey, thePlayer in ipairs(data.attackers) do
            if (isElement(thePlayer)) then
                spawnPlayer ( thePlayer, gfPositionData.X, gfPositionData.Y, gfPositionData.Z, 0, getElementModel(thePlayer), 0, 1337);
                setElementCollisionsEnabled(thePlayer, false);
                setElementFrozen(thePlayer, false);
                outputChatBox("Und die nächste Runde beginnt... bereitet euch vor und verteidigt den Laden! Das Gegnerteam spawned in 30 Sekunden.", thePlayer);
                givePlayerGFWeapons(thePlayer);
            end
        end
    else
        -- in rounds 2,4 spawn Defender Team
        for theKey, thePlayer in ipairs(data.defenders) do
            if (isElement(thePlayer)) then
                spawnPlayer ( thePlayer, gfPositionData.X, gfPositionData.Y, gfPositionData.Z, 0, getElementModel(thePlayer), 0, 1337);
                setElementCollisionsEnabled(thePlayer, false);
                setElementFrozen(thePlayer, false);
                outputChatBox("Und die nächste Runde beginnt... bereitet euch vor und verteidigt den Laden! Das Gegnerteam spawned in 30 Sekunden.", thePlayer);
                givePlayerGFWeapons(thePlayer);
            end
        end
    end

    setTimer(spawnOtherGFTeam, 60000, 1);
end

function spawnOtherGFTeam()
    local gfElement = getElementByID("GFSync");
    local data = vioGetElementData(gfElement, "data");
    local gfPosition = data.attack;
    local gfPositionData = vioGetElementData(gfPosition, "data");

    if (data.round % 2 == 1) then
        -- in rounds 1,3 and 5 spawn Attacker Team
        for theKey, thePlayer in ipairs(data.defenders) do
            if (isElement(thePlayer)) then
                spawnPlayer ( thePlayer, gfPositionData.ASpawnX, gfPositionData.ASpawnY, gfPositionData.ASpawnZ, 0, getElementModel(thePlayer), 0, 1337);
                setElementCollisionsEnabled(thePlayer, false);
                setElementFrozen(thePlayer, false);
                outputChatBox("Und die nächste Runde beginnt... Erobert den Laden!", thePlayer);
                givePlayerGFWeapons(thePlayer);
            end
        end
    else
        -- in rounds 2,4 spawn Defender Team
        for theKey, thePlayer in ipairs(data.attackers) do
            if (isElement(thePlayer)) then
                spawnPlayer ( thePlayer, gfPositionData.ASpawnX, gfPositionData.ASpawnY, gfPositionData.ASpawnZ, 0, getElementModel(thePlayer), 0, 1337);
                setElementCollisionsEnabled(thePlayer, false);
                setElementFrozen(thePlayer, false);
                outputChatBox("Und die nächste Runde beginnt... Erobert den Laden!", thePlayer);
                givePlayerGFWeapons(thePlayer);
            end
        end
    end

    startedRound = true;

    data.timer = setTimer(gfRoundTimeUp, 300000, 1);
    vioSetElementData(gfElement, "data", data);
end

function checkEndGfOrNextRound()
    local gfElement = getElementByID("GFSync");
    local data = vioGetElementData(gfElement, "data");
    local gfPosition = data.attack;
    local gfPositionData = vioGetElementData(gfPosition, "data");

    if (data.roundsDefenders >= 3) then
        for theKey, thePlayer in ipairs(data.defenders) do
            if (isElement(thePlayer)) then
                outputChatBox("Ihr habt den Gangfight gewonnen, ihr behaltet den Laden!", thePlayer, 0, 255, 0);
                spawnPlayer ( thePlayer, gfPositionData.X, gfPositionData.Y, gfPositionData.Z, 0, getElementModel(thePlayer), 0, 0);
            end
        end
        for theKey, thePlayer in ipairs(data.attackers) do
            if (isElement(thePlayer)) then
                outputChatBox("Ihr habt den Gangfight verloren!", thePlayer, 0, 255, 0);
                spawnPlayer ( thePlayer, gfPositionData.X, gfPositionData.Y, gfPositionData.Z, 0, getElementModel(thePlayer), 0, 0);
            end
        end

        destroyElement(data.blip);
        local gfPosition = data.attack;

        local gfPositionData = vioGetElementData(data.attack, "data")
        gfPositionData.lastFight = getRealTime().timestamp;
        gfPositionData.HoursWithoutAttack = 0;
        vioSetElementData(gfPosition, "data", gfPositionData);
        calcAndSaveGfPositionIncome();

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
        setElementDimension(disableSpawnCollision, 0);
        setTimer(destroyAllGFColshapes, 60000, 1);

    elseif (data.roundsAttackers >= 3) then
        for theKey, thePlayer in ipairs(data.defenders) do
            if (isElement(thePlayer)) then
                outputChatBox("Ihr habt den Gangfight verloren, ihr verliert den Laden!", thePlayer, 0, 255, 0);
                spawnPlayer ( thePlayer, gfPositionData.X, gfPositionData.Y, gfPositionData.Z, 0, getElementModel(thePlayer), 0, 0);
            end
        end
        for theKey, thePlayer in ipairs(data.attackers) do
            if (isElement(thePlayer)) then
                outputChatBox("Ihr habt den Gangfight gewonnen, ihr habt den Laden erobert!", thePlayer, 0, 255, 0);
                spawnPlayer ( thePlayer, gfPositionData.X, gfPositionData.Y, gfPositionData.Z, 0, getElementModel(thePlayer), 0, 0);
            end
        end

        destroyElement(data.blip);
        local gfPosition = data.attack;

        local gfPositionData = vioGetElementData(data.attack, "data")
        gfPositionData.lastFight = getRealTime().timestamp;
        gfPositionData.Owner = data.attackFaction;
        gfPositionData.HoursWithoutAttack = 0;
        vioSetElementData(gfPosition, "data", gfPositionData);
        calcAndSaveGfPositionIncome();

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
        setElementDimension(disableSpawnCollision, 0);
        setTimer(destroyAllGFColshapes, 60000, 1);
    else
        -- Es hat noch keiner gewonnen
        setTimer(startRound, 5000,1);
        for theKey, thePlayer in ipairs(data.defenders) do
            if (isElement(thePlayer)) then
                outputChatBox("Die nächste Runde beginnt in wenigen Sekunden!", thePlayer, 0, 255, 0);
            end
        end

        for theKey, thePlayer in ipairs(data.attackers) do
            if (isElement(thePlayer)) then
                outputChatBox("Die nächste Runde beginnt in wenigen Sekunden!", thePlayer, 0, 255, 0);
            end
        end
    end

    vioSetElementData(gfElement, "data", data);
end

function destroyAllGFColshapes()
    disableSpawnCollision = false;
    for theKey, theColShape in ipairs(colshapes) do
        destroyElement(theColShape);
    end

    local gfElement = getElementByID("GFSync");
    local data = vioGetElementData(gfElement, "data");
    data.attackInProcess = false;
    vioSetElementData(gfElement, "data", data);
end

function gfRoundTimeUp()
    if (startedRound) then
        local gfElement = getElementByID("GFSync");
        local data = vioGetElementData(gfElement, "data");
        data.timer = false;

        if (data.round % 2 == 1) then
            -- defenders win
            data.roundsDefenders = data.roundsDefenders + 1;

            for theKey, thePlayer in ipairs(data.defenders) do
                if (isElement(thePlayer)) then
                    outputChatBox("Diese Runde habt ihr gewonnen (Zeit abgelaufen)!", thePlayer, 0, 255, 0);
                end
            end

            for theKey, thePlayer in ipairs(data.attackers) do
                if (isElement(thePlayer)) then
                    outputChatBox("Diese Runde habt ihr verloren (Zeit abgelaufen)!", thePlayer, 255, 0, 0);
                end
            end
            vioSetElementData(gfElement, "data", data);
            checkEndGfOrNextRound();
        else
            -- attackers win
            data.roundsAttackers = data.roundsAttackers + 1;

            for theKey, thePlayer in ipairs(data.attackers) do
                if (isElement(thePlayer)) then
                    killPed(thePlayer);
                    outputChatBox("Diese Runde habt ihr gewonnen (Zeit abgelaufen)!", thePlayer, 0, 255, 0);
                end
            end

            for theKey, thePlayer in ipairs(data.defenders) do
                if (isElement(thePlayer)) then
                    killPed(thePlayer);
                    outputChatBox("Diese Runde habt ihr verloren (Zeit abgelaufen)!", thePlayer, 255, 0, 0);
                end
            end
            vioSetElementData(gfElement, "data", data);
            checkEndGfOrNextRound();
        end
        startedRound = false;
    end
end

function gfPlayerDeath()
    if (vioGetElementData(source, "inGf") and startedRound) then
        local gfElement = getElementByID("GFSync");
        local data = vioGetElementData(gfElement, "data");

        if (not data.timer) then
            return false;
        end
        if (not isTimer(data.timer)) then
            return false;
        end

        local countFrakA = 0;
        for theKey, thePlayer in ipairs(data.attackers) do
            if (isElement(thePlayer)) then
                if (not(isPedDead(thePlayer))) then
                    countFrakA = countFrakA + 1;
                end
            end
        end

        local countFrakD = 0;
        for theKey, thePlayer in ipairs(data.defenders) do
            if (isElement(thePlayer)) then
                if (not(isPedDead(thePlayer))) then
                    countFrakD = countFrakD + 1;
                end
            end
        end

        if (countFrakA == 0) then
            killTimer(data.timer);
            data.Timer = false;
            data.roundsDefenders = data.roundsDefenders + 1;

            for theKey, thePlayer in ipairs(data.defenders) do
                if (isElement(thePlayer)) then
                    startedRound = false;
                    outputChatBox("Diese Runde habt ihr gewonnen!", thePlayer, 0, 255, 0);
                end
            end

            for theKey, thePlayer in ipairs(data.attackers) do
                if (isElement(thePlayer)) then
                    startedRound = false;
                    outputChatBox("Diese Runde habt ihr verloren!", thePlayer, 255, 0, 0);
                end
            end
            vioSetElementData(gfElement, "data", data);
            checkEndGfOrNextRound();
        elseif (countFrakD == 0) then
            killTimer(data.timer);
            data.Timer = false;
            data.roundsAttackers = data.roundsAttackers + 1;

            for theKey, thePlayer in ipairs(data.attackers) do
                if (isElement(thePlayer)) then
                    startedRound = false;
                    outputChatBox("Diese Runde habt ihr gewonnen!", thePlayer, 0, 255, 0);
                end
            end

            for theKey, thePlayer in ipairs(data.defenders) do
                if (isElement(thePlayer)) then
                    startedRound = false;
                    outputChatBox("Diese Runde habt ihr verloren!", thePlayer, 255, 0, 0);
                end
            end
            vioSetElementData(gfElement, "data", data);
            checkEndGfOrNextRound();
        end
    end
end
addEventHandler("onPlayerWasted", getRootElement(), gfPlayerDeath)

function givePlayerGFWeapons(thePlayer)
    setPedArmor(thePlayer, 100);

    takeWeapon(thePlayer, 5);
    giveWeapon(thePlayer, 5, 1);

    takeWeapon(thePlayer, 24);
    giveWeapon(thePlayer, 24, 50);

    takeWeapon(thePlayer, 25);
    giveWeapon(thePlayer, 25, 10);

    takeWeapon(thePlayer, 29);
    giveWeapon(thePlayer, 29, 1500);

    takeWeapon(thePlayer, 30);
    giveWeapon(thePlayer, 30, 1500);

    vioSetElementData(thePlayer, "inGf", true);
end