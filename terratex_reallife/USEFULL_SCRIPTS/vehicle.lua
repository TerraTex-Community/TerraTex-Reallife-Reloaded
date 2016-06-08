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
    local rx,ry=getElementRotation(vehicle)
    if (rx>90 and rx<270) or (ry>90 and ry<270) then
        return true
    end
    return false
end








