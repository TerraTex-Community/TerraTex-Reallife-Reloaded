--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 17.10.2016
-- Time: 12:07
-- To change this template use File | Settings | File Templates.
--

--- Defender will becount if:
--  Playtime > 25h
--  AfkStatus = 0
--  Knastzeit = 0
--  Onlinetime > 10 Minutes
function getMaxDefenders(fraktion)
    local members = getPlayersInTeam(team[fraktion]);
    local counter = 0;
    for theKey, theMember in ipairs(members) do
        if (vioGetElementData(theMember, "playtime") > (25 * 60)) then
            if (vioGetElementData(theMember, "afk_status") == 0) then
                if (vioGetElementData(theMember, "knastzeit") == 0) then
                    --                    if (vioGetElementData(theMember, "loggedin") < (getRealTime().timestamp - 600)) then
                    counter = counter + 1;
                    --                    end
                end
            end
        end
    end

    return counter;
end

-- type can be: weapon, drugs, money
function addMoneyOfGFType(type, amount, splitAmountByShopCount, reason)

    if (not reason) then
        reason = "Systemeinkommen"
    end

    local typeNameToTypeID = {
        money = 0,
        drugs = 1,
        weapon = 2
    }

    local typeId = typeNameToTypeID[type];

    local gfShops = getElementsByType("GfPosition");

    if (splitAmountByShopCount) then
        local amountOfShopsByType = 0;
        for theKey, theGfPositionElement in ipairs(gfShops) do
            local theGfPosition = vioGetElementData(theGfPositionElement, "data");
            if (tonumber(theGfPosition.Type) == typeId) then
                amountOfShopsByType = amountOfShopsByType + 1;
            end
        end

        amount = amount / amountOfShopsByType;
    end

    amount = math.round(amount * 100) / 100;

    for theKey, theGfPositionElement in ipairs(gfShops) do
        local theGfPosition = vioGetElementData(theGfPositionElement, "data");

        if (tonumber(theGfPosition.Owner) > 0) then
            if (tonumber(theGfPosition.Type) == typeId) then
                frakkasse[tonumber(theGfPosition.Owner)] = frakkasse[tonumber(theGfPosition.Owner)] + amount
                frakdepot_log(tonumber(theGfPosition.Owner), 1, amount, reason)
            end
        end
    end
end



