--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 10.08.2016
-- Time: 11:41
-- To change this template use File | Settings | File Templates.
--

addEvent("showLastDriver", true);
function showLastDriver_func(vehicle)
    if (
        getElementData(vehicle, "last_driver") and
                (isAdminLevel(source, 0) or
                        (vioGetElementData(vehicle, "frakid") == vioGetElementData(source, "fraktion")
                                and vioGetElementData(source, "fraktionsrang") > 4)
                )
    ) then
        outputChatBox(string.format("Letzter Fahrer: %s", getElementData(vehicle, "last_driver")), 255, 0, 0)
    end
end

addEventHandler("showLastDriver", getRootElement(), showLastDriver_func);

