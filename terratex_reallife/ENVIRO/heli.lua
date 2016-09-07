function onEnterHeli(thePlayer)

	if (getVehicleType ( source )=="Helicopter") or (getVehicleType ( source )=="Plane") then
		giveWeapon(thePlayer,46,1,true)
	end

end
addEventHandler("onVehicleEnter",getRootElement(),onEnterHeli)

