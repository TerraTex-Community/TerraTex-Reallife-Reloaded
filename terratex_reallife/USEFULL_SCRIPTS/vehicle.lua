function isAnyOneInVehicle(vehid)
	if(vehid)then
		local occu={}
	    occu = getVehicleOccupants (vehid)
		local seats = getVehicleMaxPassengers(vehid)
		local inthere=false
		for seat = 0, seats,1 do
			if occu[seat] then
				inthere=true
			end
		end
		return inthere
	else
		return nil
	end
end

function getVehicleRealSpeed(vehicle)
	local vx,vy,vz=getElementVelocity(vehicle)
	local speed=180*math.sqrt(vx*vx+vy*vy+vz*vz)
	return speed
end

function isVehicleOnRoof(vehicle)
    local rx, ry = getElementRotation(vehicle)
    if (rx) then
        if (rx>90 and rx<270) or (ry>90 and ry<270) then
            return true
        end
    end
    return false
end

function getVehicleDamageParts(theVehicle)
	local wheels = {};
	wheels[1], wheels[2], wheels[3], wheels[4] = getVehicleWheelStates(theVehicle);
	local panels = {
		[0] = getVehiclePanelState ( theVehicle, 0 ),
		[1] = getVehiclePanelState ( theVehicle, 1 ),
		[2] = getVehiclePanelState ( theVehicle, 2 ),
        [3] = getVehiclePanelState ( theVehicle, 3 ),
        [4] = getVehiclePanelState ( theVehicle, 4 ),
        [5] = getVehiclePanelState ( theVehicle, 5 ),
        [6] = getVehiclePanelState ( theVehicle, 6 )
	};

    local lights = {
        [0] = getVehicleLightState ( theVehicle, 0 ),
        [1] = getVehicleLightState ( theVehicle, 1 ),
        [2] = getVehicleLightState ( theVehicle, 2 ),
        [3] = getVehicleLightState ( theVehicle, 3 )
    };

    local doors = {
        [0] = getVehicleDoorState ( theVehicle, 0 ),
        [1] = getVehicleDoorState ( theVehicle, 1 ),
        [2] = getVehicleDoorState ( theVehicle, 2 ),
        [3] = getVehicleDoorState ( theVehicle, 3 ),
        [4] = getVehicleDoorState ( theVehicle, 4 ),
        [5] = getVehicleDoorState ( theVehicle, 5 )
    }

    return {
        wheels = wheels,
        panels = panels,
        lights = lights,
        doors = doors
    };
end

function setVehicleDamageParts(theVehicle, damageTable)
    if (damageTable.wheels) then
        setVehicleWheelStates ( theVehicle, damageTable.wheels[1], damageTable.wheels[2], damageTable.wheels[3], damageTable.wheels[4]);
    end

    if (damageTable.panels) then
        for thePanelId, theState in pairs(damageTable.panels) do
            setVehiclePanelState ( theVehicle, thePanelId, theState );
        end
    end

    if (damageTable.lights) then
        for theLightId, theState in pairs(damageTable.lights) do
            setVehicleLightState ( theVehicle, theLightId, theState );
        end
    end

    if (damageTable.doors) then
        for theDoorId, theState in pairs(damageTable.doors) do
            setVehicleDoorState ( theVehicle, theDoorId, theState );
        end
    end
end
