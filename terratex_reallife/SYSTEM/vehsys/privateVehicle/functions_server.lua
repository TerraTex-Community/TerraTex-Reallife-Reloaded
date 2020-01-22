

function setVehiclePrivate(vehicle, isPrivate)
    if (isPrivate == nil) then
        isPrivate = true;
    end

    vioSetElementData(vehicle, "isPrivateCar", isPrivate)
end

function isVehiclePrivate(theVehicle)
    outputDebugString(vioGetElementData(theVehicle, "isPrivateCar"))
    return vioGetElementData(theVehicle, "isPrivateCar") == true
end
