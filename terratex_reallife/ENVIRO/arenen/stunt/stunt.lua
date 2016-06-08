


function stunt_join(thePlayer)
	takeAllWeapons(thePlayer)
	local veh=createVehicle(468,-1430.9599609375,1650.7607421875,1052.2004394531,359.85168457031,359.99450683594,171.44714355469)
	setElementInterior(veh,14,-1430.9599609375,1650.7607421875,1052.2004394531)
	setElementInterior(thePlayer,14)
	warpPedIntoVehicle(thePlayer,veh)
	triggerClientEvent(thePlayer,"stunt_dontknocking",thePlayer)
	--setElementCollisionsEnabled ( veh,false )
	setTimer(stunt_dissablecollision,2000,1,veh)
	vioSetElementData(thePlayer,"stunt_vehicle",veh)
	triggerClientEvent(thePlayer,"addFood",thePlayer,500)
	addEventHandler("onVehicleDamage", veh, repairStuntCar)
	addEventHandler("onVehicleStartExit", veh, stunt_dontexit )
	outputChatBox("Willkommen in der kleinen Stunthalle! Hier kannst du jetzt 20 Minuten Stunten!",thePlayer,0,255,0)
	outputChatBox("Verlassen kannst du die Arena mit /arenaquit",thePlayer,0,255,0)
	local stunt_timer=setTimer(stunt_quitPlayer,1200000,1,thePlayer)
	vioSetElementData(thePlayer,"stunt_timer",stunt_timer)
end
function stunt_dissablecollision(veh)
--setElementCollisionsEnabled ( veh,false )
end
function stunt_quitPlayer(thePlayer)
	if(isElement(thePlayer))then
		if(vioGetElementData(thePlayer,"inArena")==2)then
			local vehicle=vioGetElementData(thePlayer,"stunt_vehicle")
			removePedFromVehicle(thePlayer)
			destroyElement(vehicle)
			setElementInterior(thePlayer,0)
			setElementDimension(thePlayer,0)
			vioSetElementData(thePlayer,"stunt_vehicle",false)
			vioSetElementData(thePlayer,"inArena",false)
			triggerClientEvent(thePlayer,"stunt_nowknocking",thePlayer)
			setElementPosition(thePlayer,2745.8544921875,-1837.2998046875,10.328806877136)
			vioSetElementData(thePlayer,"stunt_timer",false)
		end
	end
end

function stunt_dontexit()
	cancelEvent()
end
function repairStuntCar()
	fixVehicle(source)
end

 function getStuntPlayer()
	local activePlayer=0
	for theKey,thePlayer in ipairs(getElementsByType("player"))do
		if(vioGetElementData(thePlayer,"inArena")==2)then
			activePlayer=activePlayer+1
		end	
	end
	return activePlayer
 
 end
 








