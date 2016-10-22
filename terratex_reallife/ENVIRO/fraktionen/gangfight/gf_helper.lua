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
        if (vioGetElementData(theMember, "playtime") > (25*60)) then
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

