addEvent("createFahrschulvehicle",true)
function createFahrschulvehicle_func(dim)
	local fahrschulveh=createVehicle(560,1479.8251953125,-1734.61328125,13.221331596375,359.98901367188,0,267.46765136719) 
	addEventHandler("onVehicleStartExit",fahrschulveh,dontexitfahrschulveh)
	setElementDimension(fahrschulveh,dim)
	warpPedIntoVehicle(source,fahrschulveh)
	vioSetElementData(source,"fahrmark",fahrschulveh)
	--ElementDimension(source,dim)
	--outputChatBox(tostring(dim))
	
end
addEventHandler("createFahrschulvehicle",getRootElement(),createFahrschulvehicle_func)

function dontexitfahrschulveh()
	cancelEvent()
end








