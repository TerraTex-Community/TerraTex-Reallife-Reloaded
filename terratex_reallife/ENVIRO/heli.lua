function onEnterHeli(thePlayer)

	if (getVehicleType ( source )=="Helicopter") or (getVehicleType ( source )=="Plane") then
		giveWeapon(thePlayer,46,1,true)
	end

end
addEventHandler("onVehicleEnter",getRootElement(),onEnterHeli)


function onPlayerJoin_forHeli()
	bindKey(source,"lshift","down",setPlayerHeliDriveBy)

end
addEventHandler("onPlayerJoin",getRootElement(),onPlayerJoin_forHeli)


function setPlayerHeliDriveBy(player)

	---LATER

end










