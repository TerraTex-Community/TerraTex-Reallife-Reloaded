function createVehicleShopPreviewCars()
    local json = readFile(":terratex_reallife\\SYSTEM\\vehsys\\shop\\vehicle_shop_preview.json");
    local previewCars = fromJSON(json);
    for theKey, theCar in ipairs(previewCars) do
        local vehicle = createVehicle(
            theCar.modelId,
            theCar.position[1], theCar.position[2], theCar.position[3],
            theCar.rotation[1], theCar.rotation[2], theCar.rotation[3]
        );
        setElementFrozen(vehicle, true)
        vioSetElementData(vehicle, "isAutohausVehicle", true)
        setVehicleDamageProof(vehicle, true)
        addEventHandler("onVehicleStartEnter", vehicle, startEnterPreviewVehicle_func)
    end

end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createVehicleShopPreviewCars)

function startEnterPreviewVehicle_func()
    cancelEvent()
end
