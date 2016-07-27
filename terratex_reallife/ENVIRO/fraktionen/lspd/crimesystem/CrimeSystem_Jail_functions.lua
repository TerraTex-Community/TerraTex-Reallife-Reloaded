--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 27.07.2016
-- Time: 15:58
-- To change this template use File | Settings | File Templates.
--

CrimeSystem.Jail = {};

-- @todo: deArrest Function
-- setPedSkin(thePlayer,vioGetElementData(thePlayer,"skinid"))
--vioSetElementData(thePlayer,"kaution",0)
--vioSetElementData(thePlayer,"knastzeit",0)
--vioSetElementData(thePlayer,"alkaknast",0)
--

function CrimeSystem.Jail.getRandomJailSpawn(jailId)
    local jailTextId = CrimeSystem._jailIdToText(jailId);
    local spawnTable = CrimeSystem._jails[jailTextId];

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

-- @todo refactor
function knastTimer()
    for theKey, thePlayer in ipairs(getElementsByType("player")) do
        if (isPlayerLoggedIn(thePlayer)) then
            if (vioGetElementData(thePlayer, "knastzeit") > 0) then
                vioSetElementData(thePlayer, "knastzeit", vioGetElementData(thePlayer, "knastzeit") - 1)
                toggleControl(thePlayer, "fire", false)
                triggerClientEvent(thePlayer, "addFood", thePlayer, 2.8)
                if (vioGetElementData(thePlayer, "knastzeit") == 0) then
                    setElementInterior(thePlayer, 0)
                    if (vioGetElementData(thePlayer, "alkaknast") == 2) then
                        setElementPosition(thePlayer, 2290.5244140625, 2422.5546875, 10.8203125)
                    elseif (vioGetElementData(thePlayer, "alkaknast") == 1) then
                        setElementPosition(thePlayer, 2866.173828125, 42.822265625, 19.252059936523)
                    else
                        setElementPosition(thePlayer, 1543.9755859375, -1676.669921875, 13.557506561279)
                    end
                    vioSetElementData(thePlayer, "kaution", 0)
                    vioSetElementData(thePlayer, "alkaknast", 0)
                    vioSetElementData(thePlayer, "knastzeit", 0)
                    toggleControl(thePlayer, "enter_exit", true)
                    toggleControl(thePlayer, "fire", true)
                    if (vioGetElementData(thePlayer, "fraktion") > 0) then
                        setPedSkin(thePlayer, vioGetElementData(thePlayer, "FrakSkin"))
                    else
                        setPedSkin(thePlayer, vioGetElementData(thePlayer, "skinid"))
                    end
                end
            end
        end
    end
    setTimer(knastTimer, 60000, 1)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), knastTimer)