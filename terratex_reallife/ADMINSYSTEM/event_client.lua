--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 21.10.2016
-- Time: 10:34
-- To change this template use File | Settings | File Templates.
--

local isRecording = false;
local barrier = {};

function barrier_func(cmd, command, ext)
    if (isAdminLevel(thePlayer, 3)) then
        if (cmd == "rec") then
            isRecording = true;
            barrier = {};
            showError(getLocalPlayer(), "Recording started. Use '/barrier stoprec' to stop recording");
        elseif (cmd == "stoprec") then
            isRecording = false;
            showError(getLocalPlayer(), "Recording stopped");
        elseif (cmd == "create") then
            triggerServerEvent("createBarrier_event", getLocalPlayer(), barrier);
        elseif (cmd == "destroy") then
            triggerServerEvent("destroyBarrier_event", getLocalPlayer(), ext);
        else
            showError(getLocalPlayer(), "SubCommands: rec, stoprec, create, destroy ['all'/id]");
        end
    end
end
addCommandHandler("barrier", barrier_func, false, false);

function onBarrierRecord()
    if (isRecording) then
        local x,y,z = getElementPosition(getLocalPlayer());
        table.insert(barrier, {x:x, y:y, z:z});
    end
end
addEventHandler("onClientRender", getRootElement(), onBarrierRecord)