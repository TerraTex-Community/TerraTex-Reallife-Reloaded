--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 21.10.2016
-- Time: 10:34
-- To change this template use File | Settings | File Templates.
--

local isRecording = false;
local barrier = {};

function barrier_func(cmd, cmd, ext)
    if (isAdminLevel(getLocalPlayer(), 3)) then
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
        if (isPedInVehicle(getLocalPlayer())) then
            local nx,ny,nz = getVehicleComponentPosition ( getPedOccupiedVehicle(getLocalPlayer()), "wheel_lf_dummy", "world" );
            if not nz then
                nx,ny,nz = getVehicleComponentPosition ( getPedOccupiedVehicle(getLocalPlayer()), "wheel_rear", "world" );
            end
            table.insert(barrier, {x=x, y=y, z=(nz - 0.45)});
        else
            table.insert(barrier, {x=x, y=y, z=(z - 1)});
        end
    end
end
addEventHandler("onClientRender", getRootElement(), onBarrierRecord)