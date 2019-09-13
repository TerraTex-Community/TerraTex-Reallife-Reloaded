--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 14.10.2016
-- Time: 14:16
-- To change this template use File | Settings | File Templates.
--

local attackElement = createElement("SyncElement", "GFSync");
local gfPositions = {};

function createGFPositions()
    local gfs = MySql.helper.getSync("faction_gangfights", "*");

    for theKey, theGfPosition in ipairs(gfs) do
        local gfPositionElement = createElement("GfPosition", "gf-" .. theGfPosition.ID);
        local pickup = createPickup(theGfPosition.X, theGfPosition.Y, theGfPosition.Z, 3, 1313, 0);
        addEventHandler("onPickupHit", pickup, hitGfPositionPickup);

        vioSetElementData(gfPositionElement, "pickup", pickup);
        vioSetElementData(pickup, "gfElement", gfPositionElement);

        if (tonumber(theGfPosition.HoursWithoutAttack) > 120) then
            theGfPosition.HoursWithoutAttack = 0;
            theGfPosition.Owner = -1;
        end
        theGfPosition.lastFight = 0;

        vioSetElementData(gfPositionElement, "data", theGfPosition)
        table.insert(gfPositions, gfPositionElement);
    end

    -- set default options to attackElement
    vioSetElementData(attackElement, "data", {
        attackInProcess = false,
        attackFaction = 0,
        defendFaction = 0,
        attackers = {},
        defenders = {},
        roundsAttackers = 0,
        timerEnd = 0,
        roundsDefenders = 0,
        timer = false,
        round = 0,
        attack = false
    });

    setTimer(calcAndSaveGfPositionIncome, 3600000, 0);
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createGFPositions)

function sladen(thePlayer)
    local frak = vioGetElementData(thePlayer, "fraktion");

    outputChatBox("Läden in eurer Kontrolle: ", thePlayer)

    for theKey, thePosition in ipairs(getElementsByType("GfPosition")) do
        local data = vioGetElementData(thePosition, "data");
        if (data.Owner == frak) then
            outputChatBox("- " .. data.Name, thePlayer);
        end
    end
end
addCommandHandler("sladen", sladen, false, false);

function hitGfPositionPickup(thePlayer)
    if (getElementType(thePlayer) == 'player') then
        local data = vioGetElementData(attackElement, "data");
        local gfElement = vioGetElementData(source, "gfElement");
        local elementData = vioGetElementData(gfElement, "data");

        if (not data.attackInProcess or data.attackId ~= tonumber(elementData.ID)) then

            if (tonumber(elementData.Owner) == -1) then
                local gfName = elementData.Name;
                outputChatBox(gfName .. " - Besitzer: Niemand", thePlayer);
            else
                local faction = fraktionbezeichner[tonumber(elementData.Owner)];
                local gfName = elementData.Name;
                outputChatBox(gfName .. " - Besitzer: " .. faction, thePlayer);
            end

        else
            local gfName = elementData.Name;
            outputChatBox(gfName .. " - Besitzer: -=Umstritten=-", thePlayer);

        end
    end
end

function calcAndSaveGfPositionIncome()
    for theKey, theGfPositionElement in ipairs(gfPositions) do
        local theGfPosition = vioGetElementData(theGfPositionElement, "data");
        theGfPosition.HoursWithoutAttack = tonumber(theGfPosition.HoursWithoutAttack) + 1;

        if (theGfPosition.HoursWithoutAttack > 120) then
            theGfPosition.HoursWithoutAttack = 0;
            theGfPosition.Owner = -1;
        end

        if (tonumber(theGfPosition.Owner) > 0) then
            if (tonumber(theGfPosition.Type) == 0) then
                -- Give only Money
                frakkasse[tonumber(theGfPosition.Owner)] = frakkasse[tonumber(theGfPosition.Owner)] + 1500
                frakdepot_log(tonumber(theGfPosition.Owner), 1, 100, "Geldladen")

            elseif (tonumber(theGfPosition.Type) == 1) then
                -- Give Money and Drugs
                frakdrogen[tonumber(theGfPosition.Owner)] = frakdrogen[tonumber(theGfPosition.Owner)] + 250
                frakdepot_log(tonumber(theGfPosition.Owner), 3, 100, "Drogenladen")
                frakkasse[tonumber(theGfPosition.Owner)] = frakkasse[tonumber(theGfPosition.Owner)] + 500
                frakdepot_log(tonumber(theGfPosition.Owner), 1, 100, "Drogenladen")

            elseif (tonumber(theGfPosition.Type) == 2) then
                -- Give Money and Mats
                frakmun[tonumber(theGfPosition.Owner)] = frakmun[tonumber(theGfPosition.Owner)] + 500
                frakdepot_log(tonumber(theGfPosition.Owner), 2, 100, "Waffenladen")
                frakkasse[tonumber(theGfPosition.Owner)] = frakkasse[tonumber(theGfPosition.Owner)] + 500
                frakdepot_log(tonumber(theGfPosition.Owner), 1, 100, "Waffenladen")
            end
        end

        if (not isDevServer()) then
            MySql.helper.update("faction_gangfights", {
                Owner = theGfPosition.Owner,
                HoursWithoutAttack = theGfPosition.HoursWithoutAttack
            }, {
                ID = theGfPosition.ID
            });
        end

        vioSetElementData(theGfPositionElement, "data", theGfPosition);
    end
end

function getNearGfPosition(thePlayer)
    for theKey, theGfPosition in ipairs(gfPositions) do
        local theGfPositionData = vioGetElementData(theGfPosition, "data");
        if (getElementsDistanceToPoint(thePlayer, theGfPositionData.X, theGfPositionData.Y, theGfPositionData.Z) < 30) then
            return theGfPosition, theGfPositionData;
        end
    end

    return false, false;
end
