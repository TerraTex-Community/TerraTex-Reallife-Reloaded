--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 23.06.2016
-- Time: 11:48
-- To change this template use File | Settings | File Templates.
--
local timedGoldBooster = {"FoodBooster", "FuelBooster", "HufeisenBooster", "SkillBooster"}
function getTimedGoldBooster()
    return timedGoldBooster;
end


function isGoldBoosterActive(thePlayer, id)
    if (table.hasValue(timedGoldBooster, id)) then
        local value = tonumber(getElementData(thePlayer, "Gold." .. id));
        local time = getRealTime();
        local timestamp = time.timestamp;

        if value > timestamp then
            return true;
        else
            return false;
        end
    else
        return false;
    end
end

