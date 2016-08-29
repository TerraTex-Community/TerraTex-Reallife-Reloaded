--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 12.08.2016
-- Time: 14:08
-- To change this template use File | Settings | File Templates.
--


function refreshPoliceVehicles()
    local vehicleData = {};
    for theKey, theVehicle in ipairs(getElementsByType("vehicle")) do
        if (hasElementData(theVehicle, "frakid", {7, 5, 1, 9}, true)) then
            local x,y,z = unpack(getElementData(theVehicle, "_getVehicleRespawn"));

            local occupants = getVehicleOccupants ( theVehicle );
            local copsInVehicle = {};
            for seat, player in pairs(getVehicleOccupants(pseudoVehicle)) do
                if (isBeamter(player)) then
                    table.insert(copsInVehicle, player);
                end
            end

            if (getElementsDistanceToPoint(theVehicle, x, y, z) > 100 or table.getSize(copsInVehicle) > 0) then
                table.insert(vehicleData, {
                    position = getElementPosition(theVehicle),
                    beamte = copsInVehicle,
                    element = theVehicle
                });
            end
        end
    end

    setPolicePcData("vehicles", vehicleData);
end

