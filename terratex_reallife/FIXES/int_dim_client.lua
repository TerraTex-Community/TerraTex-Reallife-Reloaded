--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 25.07.2014
-- Time: 13:46
-- To change this template use File | Settings | File Templates.
--


_setElementDimension = setElementDimension
_setElementInterior = setElementInterior

function setElementInterior(thePed, int, x, y, z)
    if (thePed == getLocalPlayer()) then
        triggerServerEvent("clientSetElementInterior", getLocalPlayer(), getLocalPlayer(), int, x, y, z)
    else
        _setElementInterior(thePed, int, x, y, z)
    end
end

function setElementDimension(thePed, dim)
    if (thePed == getLocalPlayer()) then
        if (dim < 0) then
            local stack = debug.traceback();
            triggerServerEvent("debugClientError", getLocalPlayer(), "Error on setElementDimension", stack)
        end
        triggerServerEvent("clientSetElementDimension", getLocalPlayer(), getLocalPlayer(), dim)
    else
        _setElementDimension(thePed, dim)
    end
end








