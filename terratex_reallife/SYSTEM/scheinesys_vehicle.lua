local truckerlicveh = { [403] = true, [406] = true, [407] = true, [408] = true, [431] = true, [437] = true, [455] = true, [514] = true, [515] = true, [524] = true, [544] = true, [573] = true }
local spezlic = { 406, 432, 444, 449, 481, 486, 530, 532, 537, 538, 539, 556, 557, 573, 601 }

function save_last_driver(thePlayer, seat)
    if (seat == 0) then
        vioSetElementData(source, "last_driver", getPlayerName(thePlayer))
    end
end
addEventHandler("onVehicleEnter", getRootElement(), save_last_driver)

function enterVehicle(thePlayer, seat, jacked, door)
    local vehid = getElementModel(source)
    if (seat == 0) then
        if not (isNoLicensCar(vehid)) then
            if (isTruck(vehid)) then
                if (vioGetElementData(thePlayer, "truckLic") < 1) then
                    showError(thePlayer, "Du kannst das nicht benutzen. Sie besitzen keine Truckerlizens!")
                    cancelEvent()
                end
            elseif (isPlane(vehid)) then
                if (vioGetElementData(thePlayer, "planeLic") < 1) then
                    showError(thePlayer, "Du kannst das nicht benutzen. Sie besitzen keine Fluglizens!")
                    cancelEvent()
                end
            elseif (isCar(vehid)) then
                if (vioGetElementData(thePlayer, "autoLic") < 1) then
                    showError(thePlayer, "Du kannst das nicht benutzen. Sie besitzen keinen Fuehrerschein!")
                    cancelEvent()
                end
            elseif (isBike(vehid)) then
                if (vioGetElementData(thePlayer, "bikeLic") < 1) and vehid ~= 448 then
                    showError(thePlayer, "Du kannst das nicht benutzen. Sie besitzen keinen Motoradfuehrerschein!")
                    cancelEvent()
                end
            elseif (isHeli(vehid)) then
                if (vioGetElementData(thePlayer, "heliLic") < 1) then
                    showError(thePlayer, "Du kannst das nicht benutzen. Sie besitzen keine Helicopterlizens!")
                    cancelEvent()
                end
            elseif (isBoat(vehid)) then
                if (vioGetElementData(thePlayer, "boatLic") < 1) then
                    showError(thePlayer, "Du kannst das nicht benutzen. Sie besitzen keine Bootslizens!")
                    cancelEvent()
                end
            elseif (isQuad(vehid)) then
                if (vioGetElementData(thePlayer, "quadLic") < 1) then
                    showError(thePlayer, "Du kannst das nicht benutzen. Sie besitzen keine Quadlizense!")
                    cancelEvent()
                end
            else
                if (vioGetElementData(thePlayer, "sonstigeLic") < 1) then
                    showError(thePlayer, "Du kannst das nicht benutzen. Sie besitzen keinen Spezialfuehrerschein!")
                    cancelEvent()
                end
            end
            if (isSpezVehicle(vehid)) then
                if (vioGetElementData(thePlayer, "sonstigeLic") < 1) then
                    showError(thePlayer, "Du kannst das nicht benutzen. Sie besitzen keinen Spezialfuehrerschein!")
                    cancelEvent()
                end
            end
        end
    end
end
addEventHandler("onVehicleStartEnter", getRootElement(), enterVehicle)

function hasTheLicenseFor(thePlayer, vehid)
    if type(vehid) == "userdata" then vehid = getElementModel(vehid) end
    if (isNoLicensCar(vehid)) then
        return true;
    end

    if (isTruck(vehid)) then
        if (vioGetElementData(thePlayer, "truckLic") < 1) then
            return false
        else
            return true
        end
    elseif (isPlane(vehid)) then
        if (vioGetElementData(thePlayer, "planeLic") < 1) then
            return false
        else
            return true
        end
    elseif (isCar(vehid)) then
        if (vioGetElementData(thePlayer, "autoLic") < 1) then
            return false
        else
            return true
        end
    elseif (isBike(vehid)) then
        if (vioGetElementData(thePlayer, "bikeLic") < 1) then
            return false
        else
            return true
        end
    elseif (isHeli(vehid)) then
        if (vioGetElementData(thePlayer, "heliLic") < 1) then
            return false
        else
            return true
        end
    elseif (isBoat(vehid)) then
        if (vioGetElementData(thePlayer, "boatLic") < 1) then
            return false
        else
            return true
        end
    elseif (isQuad(vehid)) then
        if (vioGetElementData(thePlayer, "quadLic") < 1) then
            return false
        else
            return true
        end
    else
        if (vioGetElementData(thePlayer, "sonstigeLic") < 1) then
            return false
        else
            return true
        end
    end

    if (isSpezVehicle(vehid)) then
        if (vioGetElementData(thePlayer, "sonstigeLic") < 1) then
            showError(thePlayer, "Du kannst das nicht benutzen. Sie besitzen keinen Spezialfuehrerschein!")
            cancelEvent()
        end
    end
end


function isSpezVehicle(vehid)
    if type(vehid) == "userdata" then vehid = getElementModel(vehid) end
    if (table.hasValue(spezlic, vehid)) then
        return true
    else
        return false
    end
end

function isTruck(vehid)
    if type(vehid) == "userdata" then vehid = getElementModel(vehid) end
    if (truckerlicveh[vehid]) then
        return true
    else
        return false
    end
end

function isCar(vehid)
    if type(vehid) == "userdata" then vehid = getElementModel(vehid) end
    if (truckerlicveh[vehid]) then
        return false
    else
        if (getVehicleType(vehid) == "Automobile") then
            return true
        else
            return false
        end
    end
end

function isPlane(vehid)
    if type(vehid) == "userdata" then vehid = getElementModel(vehid) end
    if (getVehicleType(vehid) == "Plane") then
        return true
    else
        return false
    end
end

function isWaterPlane(vehid)
    if type(vehid) == "userdata" then
        vehid = getElementModel(vehid)
    end
    if (getVehicleType(vehid) == "460") then
        return true
    else
        return false
    end
end

function isBike(vehid)
    if (getVehicleType(vehid) == "Bike" and not (isNoLicensCar(vehid))) then
        return true
    else
        return false
    end
end

function isHeli(vehid)
    if type(vehid) == "userdata" then vehid = getElementModel(vehid) end
    if (getVehicleType(vehid) == "Helicopter") then
        return true
    else
        return false
    end
end

function isBoat(vehid)
    if type(vehid) == "userdata" then vehid = getElementModel(vehid) end
    if (getVehicleType(vehid) == "Boat") then
        return true
    else
        return false
    end
end

function isQuad(vehid)
    if type(vehid) == "userdata" then vehid = getElementModel(vehid) end
    if (getVehicleType(vehid) == "Quad") then
        return true
    else
        return false
    end
end

local noLizenseCar = { [462] = true, [448] = true }
function isNoLicensCar(vehid)
    if type(vehid) == "userdata" then vehid = getElementModel(vehid) end
    if (noLizenseCar[vehid]) then
        return true
    else
        return false
    end
end
