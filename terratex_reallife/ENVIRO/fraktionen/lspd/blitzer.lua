--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 29.08.2016
-- Time: 17:15
-- To change this template use File | Settings | File Templates.
--

local blitzerMax = 10;
local blitzerArray = {};

function createBlitzerDummysOnStartUp()
    local c = 1;
    for c = 1, blitzerMax, 1 do
        local blitzerElement = createElement("blitzer");
        vioSetElementData(blitzerElement, "object", false);
        vioSetElementData(blitzerElement, "state", false);
        vioSetElementData(blitzerElement, "executed", false);
        vioSetElementData(blitzerElement, "marker", false);
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createBlitzerDummysOnStartUp)

function test_blitzer()
    outputDebugString(table.getSize(getElementsByType("blitzer")));
end
addCommandHandler("tb", test_blitzer)