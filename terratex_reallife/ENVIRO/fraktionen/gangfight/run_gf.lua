--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 17.10.2016
-- Time: 15:17
-- To change this template use File | Settings | File Templates.
--
-- DB:
--Name = Name,
--Type = Type,
--X = X,
--Y = Y,
--Z = Z,
--ASpawnX = ASpawnX,
--ASpawnY = ASpawnY,
--ASpawnZ = ASpawnZ,
--RSmall = RSmall,
--RLarge = RLarge

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