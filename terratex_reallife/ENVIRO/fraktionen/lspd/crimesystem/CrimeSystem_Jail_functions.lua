--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 27.07.2016
-- Time: 15:58
-- To change this template use File | Settings | File Templates.
--

CrimeSystem.Jail = {};

function CrimeSystem.Jail.getRandomJailSpawnById(jailId)
    local jailTextId = CrimeSystem._jailIdToText(jailId);
    local spawnTable = CrimeSystem._jails[jailTextId];

    return spawnTable[math.random(1, table.getSize(spawnTable))];
end

function CrimeSystem.Jail.getRandomJailSpawnByJailName(jailId)
    local spawnTable = CrimeSystem._jails[jailId];

    return spawnTable[math.random(1, table.getSize(spawnTable))];
end

function CrimeSystem.Jail.getJailIdInArea(thePlayer)
    local x, y, z = getElementPosition(thePlayer)
    if (getElementsDistanceToPoint(thePlayer, 1552.186, -1672.38, 16.67) <= getElementsDistanceToPoint(thePlayer, 2301.05, 2437.11, 10.82)) then
        return 0
    else
        return 2
    end
end

function knastTimer()
    for theKey, thePlayer in ipairs(getElementsByType("player")) do
        if (isPlayerLoggedIn(thePlayer)) then
            if (vioGetElementData(thePlayer, "knastzeit") > 0) then
                vioSetElementData(thePlayer, "knastzeit", vioGetElementData(thePlayer, "knastzeit") - 1)
                toggleControl(thePlayer, "fire", false)
                triggerClientEvent(thePlayer, "addFood", thePlayer, 2.8)
                if (vioGetElementData(thePlayer, "knastzeit") == 0) then
                    CrimeSystem.Jail.unArrest(thePlayer)
                end
            end
        end
    end
    setTimer(knastTimer, 60000, 1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), knastTimer)

function CrimeSystem.Jail.unArrest(thePlayer)
    local pos = CrimeSystem._deArrestPositions[CrimeSystem._jailIdToText[vioGetElementData(thePlayer, "alkaknast")]];

    setElementInterior(pos[1], pos[2], pos[3], pos[4]);
    setElementPosition(pos[2], pos[3], pos[4]);

    if (vioGetElementData(thePlayer, "fraktion") > 0) then
        setPedSkin(thePlayer, vioGetElementData(thePlayer, "FrakSkin"))
    else
        setPedSkin(thePlayer, vioGetElementData(thePlayer, "skinid"))
    end

    toggleControl(thePlayer, "enter_exit", true)
    toggleControl(thePlayer, "fire", true)

    vioSetElementData(thePlayer, "kaution", 0)
    vioSetElementData(thePlayer, "alkaknast", 0)
    vioSetElementData(thePlayer, "knastzeit", 0)
end

function CrimeSystem.getNewJailTime(thePlayer, gestellt)
    if not gestellt then
        local percentage = CrimeSystem.getCrimePercentage(thePlayer);
        return math.round(percentage * CrimeSystem._jailtimePerPercentage);
    else
        local percentage = CrimeSystem.getCrimePercentage(thePlayer);
        return math.round(percentage * CrimeSystem._jailtimePerPercentageGestellt);
    end
end

function CrimeSystem.getBail(thePlayer, bot)
    if not bot then
        local percentage = CrimeSystem.getCrimePercentage(thePlayer);
        if (vioGetElementData(thePlayer, "playtime") < 1500) then
            percentage = percentage / 2;
        end
        return math.round(percentage * CrimeSystem._bailPerPercentage);
    else
        local percentage = CrimeSystem.getCrimePercentage(thePlayer);
        if (vioGetElementData(thePlayer, "playtime") < 1500) then
            percentage = percentage / 2;
        end
        return math.round(percentage * CrimeSystem._bailPerPercentageBot);
    end
end

function CrimeSystem.isNearJailPoint(thePlayer)
    for theJail, thePosition in pairs(CrimeSystem._arrestPoints) do
        if (getElementsDistanceToPoint(thePlayer, thePosition[1], thePosition[2], thePosition[3]) < 30) then
            return theJail;
        end
    end
    return false;
end