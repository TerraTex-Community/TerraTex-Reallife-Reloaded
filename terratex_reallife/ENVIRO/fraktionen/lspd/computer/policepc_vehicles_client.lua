--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 12.08.2016
-- Time: 14:08
-- To change this template use File | Settings | File Templates.
--


function refreshPoliceVehicles()
    local vehicleData = {};
    local removeVehicleData = {};
    for theKey, theVehicle in ipairs(getElementsByType("vehicle")) do
        if (hasElementData(theVehicle, "frakid", {7, 5, 1, 9}, true)) then
            local x,y,z = unpack(getElementData(theVehicle, "_getVehicleRespawn"));

            local occupants = getVehicleOccupants ( theVehicle );
            local copsInVehicle = {};
            for seat, player in pairs(getVehicleOccupants(theVehicle)) do
                if (isBeamter(player)) then
                    table.insert(copsInVehicle, getPlayerName(player));
                end
            end

            if (getElementsDistanceToPoint(theVehicle, x, y, z) > 100 or table.getSize(copsInVehicle) > 0) then
                table.insert(vehicleData, {
                    position = pack(getElementPosition(theVehicle)),
                    cops = copsInVehicle,
                    element = theVehicle,
                    id = tonumber(getElementData(theVehicle, "police-car-id"))
                });
            else
                table.insert(removeVehicleData, {
                    element = theVehicle,
                    id = tonumber(getElementData(theVehicle, "police-car-id"))
                });
            end
        end
    end

    setPolicePcData("vehicles", vehicleData);
    setPolicePcData("removeVehicles", removeVehicleData);
end

