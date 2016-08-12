--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 12.08.2016
-- Time: 14:46
-- To change this template use File | Settings | File Templates.
--

function isBeamter(thePlayer)
    local beamtenFraktionen = {1, 5, 7, 9}
    if (hasElementData(thePlayer, "fraktion", beamtenFraktionen, true)) then
        return true
    else
        return false
    end
end

