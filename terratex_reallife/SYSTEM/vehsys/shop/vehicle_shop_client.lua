addEvent("openVehicleShop", true)
function openVehicleShop(vehicleJson)
    local vehicleList = fromJSON(vehicleJson);


end
addEventHandler("openVehicleShop", getRootElement(), openVehicleShop)

