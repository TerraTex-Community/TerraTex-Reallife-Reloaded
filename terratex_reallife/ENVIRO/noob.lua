 noobCars={}
 
 function spawnNoobCars()
 local vehicle= createVehicle(462,1734.1669921875,-1865.0029296875,13.171788215637,359.54406738281,359.99450683594,0.3955078125,"ROOKIE")    --  noobfagio 
 table.insert(noobCars,vehicle) 
 vehicle= createVehicle(462,1733.216796875,-1864.978515625,13.171591758728,359.54406738281,0,0.0054931640625,"!ROOKIE!")    --  nboob 
 table.insert(noobCars,vehicle) 
 vehicle= createVehicle(462,1732.3525390625,-1864.99609375,13.173258781433,359.55505371094,0,356.13830566406,"!ROOKIE!")    --  noob 
 table.insert(noobCars,vehicle) 
 vehicle= createVehicle(462,1731.4873046875,-1864.9189453125,13.171149253845,359.53857421875,0.0054931640625,355.0341796875,"!ROOKIE!")    --  noob 
 table.insert(noobCars,vehicle) 
 vehicle= createVehicle(462,1730.5380859375,-1864.8720703125,13.173582077026,359.55505371094,359.99450683594,0.5438232421875,"!ROOKIE!")    --  noob 
 table.insert(noobCars,vehicle) 
 vehicle= createVehicle(462,1729.4853515625,-1864.8798828125,13.173665046692,359.55505371094,359.99450683594,0.3680419921875,"!ROOKIE!")    --  noob 
 table.insert(noobCars,vehicle) 
 vehicle= createVehicle(462,1728.732421875,-1870.5322265625,13.163111686707,359.47265625,0.010986328125,2.2467041015625,"!ROOKIE!")    --  noob 
 table.insert(noobCars,vehicle) 
 vehicle= createVehicle(462,1728.658203125,-1867.4765625,13.168503761292,359.54406738281,0,358.04992675781,"!ROOKIE!")    --  noob
 table.insert(noobCars,vehicle) 
 vehicle=  createVehicle(462,1311.234375,-875.052734375,39.177917480469,359.47265625,359.99450683594,358.77502441406,"!ROOKIE!")     
 table.insert(noobCars,vehicle) 
 vehicle=  createVehicle(462,1312.5615234375,-875.259765625,39.151863098145,359.27490234375,359.99450683594,349.27185058594,"!ROOKIE!")     
 table.insert(noobCars,vehicle) 
 vehicle=  createVehicle(462,1313.787109375,-875.1826171875,39.176692962646,359.46716308594,0,356.44592285156,"!ROOKIE!")     
 table.insert(noobCars,vehicle) 
 vehicle=  createVehicle(462,1315.0283203125,-875.08984375,39.175445556641,359.45617675781,359.99450683594,359.02770996094,"!ROOKIE!")    
 table.insert(noobCars,vehicle) 
 vehicle=  createVehicle(462,1316.6123046875,-875.0146484375,39.164054870605,359.36828613281,359.99450683594,0.9613037109375,"!ROOKIE!")     
 table.insert(noobCars,vehicle) 
 vehicle=  createVehicle(462,1318.3017578125,-874.80859375,39.154560089111,359.296875,0,13.287963867188,"!ROOKIE!")     
 table.insert(noobCars,vehicle) 
 vehicle=  createVehicle(462,1319.876953125,-874.8935546875,39.170848846436,359.42321777344,359.99450683594,358.51684570312,"!ROOKIE!")     
 table.insert(noobCars,vehicle) 
 vehicle=  createVehicle(462,1321.42578125,-874.8583984375,39.174819946289,359.45068359375,0,358.4619140625,"!ROOKIE!")     
 table.insert(noobCars,vehicle) 
 vehicle=  createVehicle(462,1322.86328125,-874.6806640625,39.162082672119,359.35729980469,0,1.7303466796875,"!ROOKIE!")     
 table.insert(noobCars,vehicle) 
 vehicle=  createVehicle(462,1324.0859375,-874.68359375,39.175636291504,359.45617675781,359.99450683594,356.90734863281,"!ROOKIE!")   
 table.insert(noobCars,vehicle) 
 
 
 
 
 
 
 		for key, theVehicle in pairs(noobCars) do
			prepare(theVehicle,0)
			addEventHandler("onVehicleEnter",theVehicle,infomessage_noobfaggios)
		end
 	setTimer(respawnNoobCarsLOL,300000,1)	
 
 end
 addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),spawnNoobCars)
 
 function respawnNoobCarsLOL()

	for key, theVehicle in pairs(noobCars) do
		if not(isAnyOneInVehicle(theVehicle))then
			setVehicleOverrideLights (theVehicle,1)
			setVehicleEngineState (theVehicle,false)				
			respawnVehicle (theVehicle)
		end
				
	end
	setTimer(respawnNoobCarsLOL,300000,1)		
end
 
 
 
function infomessage_noobfaggios(thePlayer)
	showError(thePlayer,"Anfaengerhilfe:\n Taste X zum Motorstarten \n Taste L um Licht an und auszumachen!\n Diese Fahrzeuge sind nur für Noobs gedacht und können daher nur bis 25 Spielstunden genutzt werden.")
	if(vioGetElementData(thePlayer,"playtime")>1500)then
		removePedFromVehicle(thePlayer)
	end
	
	
end








