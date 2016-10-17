--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 17.10.2016
-- Time: 15:17
-- To change this template use File | Settings | File Templates.
--

local colshapes = {};

function startGf()
    local gfElement = getElementById("GFSync");
    local data = vioGetElementData(gfElement, "data");
    local gfPosition = data.attack;
    local gfPositionData = vioGetElementData(gfPosition, "data");

--    create ColShapes
    local disableSpawnCollision = createColCircle ( gfPositionData.X, gfPositionData.Y, 1.5 );
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
    addEventHandler("onColShapeLeave", killPlayerColShape, sendKillWarning);

    local killPlayerColShape = createColCircle ( gfPositionData.ASpawnX, gfPositionData.ASpawnY, gfPositionData.RLarge );
    table.insert(colshapes, killPlayerColShape);
    setElementDimension(killPlayerColShape, 1337);
    addEventHandler("onColShapeLeave", killPlayerColShape, sendKillWarning);

    startRound();
end

function sendKillWarning(element, matchDim)
    if (matchDim) then
        triggerClientEvent(element, "sendGfKillWarning", source, 10);
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
    local gfElement = getElementById("GFSync");
    local data = vioGetElementData(gfElement, "data");
    local gfPosition = data.attack;
    local gfPositionData = vioGetElementData(gfPosition, "data");

    for theKey, thePlayer in ipairs(data.attackers) do
        killPed(thePlayer);
    end
    for theKey, thePlayer in ipairs(data.defenders) do
        killPed(thePlayer);
    end

    data.round = data.round + 1;
    if (data.round % 2 == 1) then
        -- in rounds 1,3 and 5 spawn Attacker Team
        for theKey, thePlayer in ipairs(data.attackers) do
            if (isElement(thePlayer)) then
                spawnPlayer ( thePlayer, gfPositionData.X, gfPositionData.Y, gfPositionData.Z, 0, getElementModel(thePlayer), 0, 1337);
                setElementCollisionsEnabled(thePlayer, false);
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
                outputChatBox("Und die nächste Runde beginnt... bereitet euch vor und verteidigt den Laden! Das Gegnerteam spawned in 30 Sekunden.", thePlayer);
                givePlayerGFWeapons(thePlayer);
            end
        end
    end

    setTimer(spawnOtherGFTeam, 30000, 1);
end

function spawnOtherGFTeam()
    local gfElement = getElementById("GFSync");
    local data = vioGetElementData(gfElement, "data");
    local gfPosition = data.attack;
    local gfPositionData = vioGetElementData(gfPosition, "data");

    if (data.round % 2 == 1) then
        -- in rounds 1,3 and 5 spawn Attacker Team
        for theKey, thePlayer in ipairs(data.defenders) do
            if (isElement(thePlayer)) then
                spawnPlayer ( thePlayer, gfPositionData.ASpawnX, gfPositionData.ASpawnY, gfPositionData.ASpawnZ, 0, getElementModel(thePlayer), 0, 1337);
                setElementCollisionsEnabled(thePlayer, false);
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
                outputChatBox("Und die nächste Runde beginnt... Erobert den Laden!", thePlayer);
                givePlayerGFWeapons(thePlayer);
            end
        end
    end
end

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
end