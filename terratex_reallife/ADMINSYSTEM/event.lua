--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 21.10.2016
-- Time: 10:34
-- To change this template use File | Settings | File Templates.
--

local freezeAbleVehicles = {};

function freezeAbleVehicles_func(thePlayer, cmd, cmd_id, id)
    if (isAdminLevel(thePlayer, 3)) then
       if (tonumber(cmd_id)) then
           id = cmd_id;
           cmd_id = "create";
       end

        if (cmd_id == "create") then
            local vehmod = tonumber(id);
            local x, y, z = getElementPosition(thePlayer);
            local int = getElementInterior(thePlayer);
            local dim = getElementDimension(thePlayer);
            local veh = createVehicle(vehmod, x + 3, y + 3, z + 10);
            setElementInterior(veh, int, x + 3, y + 3, z + 10);
            setElementDimension(veh, dim);
            vioSetElementData(veh, "hasTank", false);
            vioSetElementData(veh, "freezeAbleVehicle", true);
            table.insert(freezeAbleVehicles, veh);
            showError(thePlayer, "FreezeAbleVehicle created");
        elseif (cmd_id == "destroy") then
            for theKey, theVehicle in ipairs(freezeAbleVehicles) do
                destroyElement(theVehicle);
            end
            freezeAbleVehicles = {};
            showError(thePlayer, "All FreezeAbleVehicle destroyed");
        elseif (cmd_id == "freeze") then
            if (isPedInVehicle(thePlayer)) then
                local veh = getPedOccupiedVehicle(thePlayer);
                if (vioGetElementData(veh, "FreezeAbleVehicle")) then
                    setElementFrozen ( veh, true );
                    showError(thePlayer, "FreezeAbleVehicle gefreezed");
                else
                    showError(thePlayer, "Du bist in keinem FreezeAbleVehicle!");
                end
            else
                showError(thePlayer, "Du bist in keinem Fahrzeug!");
            end
        elseif (cmd_id == "unfreeze") then
            if (isPedInVehicle(thePlayer)) then
                local veh = getPedOccupiedVehicle(thePlayer);
                if (vioGetElementData(veh, "FreezeAbleVehicle")) then
                    setElementFrozen ( veh, false );
                    showError(thePlayer, "FreezeAbleVehicle unfreezed");
                else
                    showError(thePlayer, "Du bist in keinem FreezeAbleVehicle!");
                end
            else
                showError(thePlayer, "Du bist in keinem Fahrzeug!");
            end
        elseif (cmd_id == "freezeall") then
            for theKey, theVehicle in ipairs(freezeAbleVehicles) do
                setElementFrozen(theVehicle, true);
            end
            showError(thePlayer, "All FreezeAbleVehicle freezed");
        elseif (cmd_id == "unfreezeall") then
            for theKey, theVehicle in ipairs(freezeAbleVehicles) do
                setElementFrozen(theVehicle, true);
            end
            showError(thePlayer, "All FreezeAbleVehicle unfreezed");
        else
            outputChatBox("SubCommands: create, destroy, freeze, unfreeze, freezeall, unfreezeall", thePlayer, 255,0,0);
        end
    end
end
addCommandHandler("fveh", freezeAbleVehicles_func, false, false)

