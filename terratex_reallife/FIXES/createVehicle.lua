--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 12.08.2016
-- Time: 14:25
-- To change this template use File | Settings | File Templates.
--

local _createVehicle = createVehicle

function createVehicle(model, x, y, z, rx, ry, rz, numberplate, bDirection, variant1, variant2)
    local vehicle = _createVehicle(model, x, y, z, rx, ry, rz, numberplate, bDirection, variant1, variant2);

    local spawnX, spawnY, spawnZ, spawnRX, spawnRY, spawnRZ = 0, 0, 0, 0, 0, 0;
    if x and y and z then
        spawnX = x;
        spawnY = y;
        spawnZ = z;
        if (rx) then
            spawnRX = rx;
        end
        if (ry) then
            spawnRY = ry;
        end
        if (rz) then
            spawnRZ = rz;
        end
    end

    setElementData(vehicle, "_getVehicleRespawn", {spawnX, spawnY, spawnZ, spawnRX, spawnRY, spawnRZ});
    return vehicle;
end

