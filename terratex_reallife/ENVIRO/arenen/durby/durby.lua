

durby_spawns={
	{-1423.708984375,931.54296875,1036.1979980469,0.1922607421875,0.1373291015625,359.89562988281},
	{-1443.7568359375,932.9599609375,1036.2889404297,0.2691650390625,0.2801513671875,350.21667480469},
	{-1462.4775390625,937.81640625,1036.3978271484,0.274658203125,0.3790283203125,349.06860351562},
	{-1511.0576171875,968.7001953125,1036.9985351562,0.494384765625,1.175537109375,302.66235351562},
	{-1518.8876953125,1003.798828125,1037.5869140625,359.75830078125,0.955810546875,261.39770507812},
	{-1489.9306640625,1040.44140625,1038.1536865234,359.19250488281,0.5438232421875,218.30932617188},
	{-1444.9208984375,1056.390625,1038.3363037109,359.14855957031,0.230712890625,195.98510742188},
	{-1390.1982421875,1058.6591796875,1038.2839355469,358.9892578125,359.6923828125,169.78820800781},
	{-1332.6279296875,1053.021484375,1038.0919189453,359.24194335938,359.44519042969,149.64477539062},
	{-1290.30859375,1023.56640625,1037.5252685547,359.52209472656,359.11010742188,126.23840332031},
	{-1287.5732421875,974.599609375,1036.7083740234,0.560302734375,359.06616210938,60.853271484375},
	{-1335.8671875,938.123046875,1036.1807861328,0.94482421875,359.59899902344,26.312255859375}
 }
 --504--Interior:15
 isDurbyStarted=false
 durbyTimer=false
 prepareDurbyStartUp=false
 durbycountdown=10
 therewasawinner=false
 
 function test_spawn()
	for theKey,theTable in ipairs(durby_spawns)do
		clearspawn=theKey
		local dbVeh=createVehicle(504,durby_spawns[clearspawn][1],durby_spawns[clearspawn][2],durby_spawns[clearspawn][3],durby_spawns[clearspawn][4],durby_spawns[clearspawn][5],durby_spawns[clearspawn][6],"Kaputt")
		setElementInterior(dbVeh,15)
	end
 end
 addCommandHandler("testspawn",test_spawn)
 
  function onDurbyGameEnd()
	if(getDurbyGamePlayer()>1)then
		local playeranzahl=getAllDurbyPlayers()
		local randompl=math.random(1,table.getn(playeranzahl))
		blowVehicle(getPedOccupiedVehicle(playeranzahl[randompl]),true)		
		local x,y,z=getElementPosition(playeranzahl[randompl])
		killPed(playeranzahl[randompl])
		createExplosion(x,y,z,4)
		setTimer(onDurbyGameEnd,15000,1)
	else
		checkDurbyWinner()
	end 
 end 
  
 function durby_spawn_Player(thePlayer)
	local clearspawn=db_get_clear_random_spawn()
	local dbVeh=createVehicle(504,durby_spawns[clearspawn][1],durby_spawns[clearspawn][2],durby_spawns[clearspawn][3],durby_spawns[clearspawn][4],durby_spawns[clearspawn][5],durby_spawns[clearspawn][6],"Kaputt")
	setElementInterior(dbVeh,15)
	spawnPlayer(thePlayer,durby_spawns[clearspawn][1],durby_spawns[clearspawn][2],(durby_spawns[clearspawn][3]+1),durby_spawns[clearspawn][6],vioGetElementData(thePlayer,"skinid"),15,0,team[vioGetElementData(thePlayer,"fraktion")])
	warpPedIntoVehicle(thePlayer,dbVeh)	
	if(prepareDurbyStartUp)then
		setElementFrozen(dbVeh,true)
	end 
 end
   
 function startDurbyCountDown()
	if(durbycountdown>0)then
		for theKey,thePlayer in ipairs(getAllDurbyPlayers())do
			outputChatBox(string.format("Mach dich bereit! Das Durby beginnt in %s Sekunden!", durbycountdown),thePlayer,0,255,0)
		end
		durbycountdown=durbycountdown-1
		setTimer(startDurbyCountDown,1000,1)
	else
		prepareDurbyStartUp=false
		for theKey,thePlayer in ipairs(getAllDurbyPlayers())do
			outputChatBox("Das Spiel beginnt!",thePlayer,0,255,0)
			local dbveh=getPedOccupiedVehicle(thePlayer)
			setElementFrozen(dbveh,false)
		end
		durbyTimer=setTimer(onDurbyGameEnd,6000000,1)
	end
 end  
  
 function onDurbyStartVehicleExit(thePlayer)
	if(vioGetElementData(thePlayer,"inArena")==3)then
		cancelEvent()
	end
end
addEventHandler("onVehicleStartExit",getRootElement(),onDurbyStartVehicleExit)
  
 function onPlayerDurbyQuit()
	setTimer(checkDurbyWinner,5000,1) 
 end
  
 function onPlayerDurbyWasted() 
	if(vioGetElementData(source,"inArena")==3)then
		if(isDurbyStarted)then
			if(prepareDurbyStartUp)then
				durby_spawn_Player(source)	
			else
				quit_arena(source)
				outputChatBox("Du hast leider verloren!",source,0,255,0)
				spawnPlayer(source,2745.8544921875,-1837.2998046875,10.328806877136,154.12683105469,vioGetElementData(source,"skinid"),0,0,team[vioGetElementData(source,"fraktion")])
				setTimer(checkDurbyWinner,5000,1)
			end
		else
			durby_spawn_Player(source)	
		end
	end
 end  
 addEventHandler("onPlayerWasted",getRootElement(), onPlayerDurbyWasted)
  
 function checkDurbyWinner()
	if(getDurbyGamePlayer()==1)and(therewasawinner==false)then
		local gewinn=150
		therewasawinner=true
		local bestplayers=getAllDurbyPlayers()
		local bestplayer=bestplayers[1]
		outputChatBox(string.format("Du hast %s gewonnen!", toprice(gewinn)),bestplayer,0,255,0)
        changePlayerMoney(bestplayer,gewinn,"sonstiges","Arenagewinn","Durby")
		isDurbyStarted=false
		durbyTimer=false
		prepareDurbyStartUp=false
		durbycountdown=10
		local veh=getPedOccupiedVehicle(bestplayer)
		removePedFromVehicle(bestplayer)
		destroyElement(veh)
		vioSetElementData(bestplayer,"inArena",0)
		killPed(bestplayer)
		spawnPlayer(bestplayer,2745.8544921875,-1837.2998046875,10.328806877136,154.12683105469,vioGetElementData(bestplayer,"skinid"),0,0,team[vioGetElementData(bestplayer,"fraktion")])
		vioSetElementData(bestplayer,"inArena",false)		
	end
	therewasawinner=false
 end
 

  
 function startTheDurbyGame()
	isDurbyStarted=true
	prepareDurbyStartUp=true
	for theKey,thePerson in ipairs(getAllDurbyPlayers())do
		local veh=false
		if(isPedInVehicle(thePerson))then
			veh=getPedOccupiedVehicle(thePerson)
		end
		killPed(thePerson)
		if(veh)then
			destroyElement(veh)
		end
	end
	startDurbyCountDown()
  end 
  
  
 function enter_durby_arena(thePlayer)
	outputChatBox("Du hast die DurbyArena betretten! Du kannst Sie jederzeit mit /arenaquit verlassen!",thePlayer,0,255,0)
	if(durbyTimer)then
		local rest=getDurbyGameRestTime()
		outputChatBox(string.format("Das Spiel wird in %s Minuten starten mache dich bereit!", rest),thePlayer,0,255,0)
	else
		if(getDurbyGamePlayer()>1)then
			for theKey,thePerson in ipairs(getAllDurbyPlayers())do
				outputChatBox("Der Durby Starttimer wurde gestartet! Das Durbyspiel beginnt in 5 Minuten!",thePerson,0,255,0)
			end
			durbyTimer=setTimer(startTheDurbyGame,200000,1)
		else
			outputChatBox("Der Durby Starttimer wird gestartet sobald mehr als 2 Spieler im Spiel sind!",thePlayer,0,255,0)
		end
	end
	killPed(thePlayer)
 end
 
 function getAllDurbyPlayers()
	local durbyPlayer={}
	for theKey,thePlayer in ipairs(getElementsByType("player"))do
		if(vioGetElementData(thePlayer,"inArena")==3)then
			table.insert(durbyPlayer,thePlayer)
		end
	end
	return durbyPlayer
 end	
 
 function db_get_clear_random_spawn()
	local db_hasFindClearSpawn=math.random(1,table.getn(durby_spawns))
	local db_findPlayersBySpawn=1
	local counter=0
	while(db_findPlayersBySpawn>0)do
		db_hasFindClearSpawn=math.random(1,table.getn(durby_spawns))
		local chatSphere = createColSphere( durby_spawns[db_hasFindClearSpawn][1],durby_spawns[db_hasFindClearSpawn][2],durby_spawns[db_hasFindClearSpawn][3],5.0)
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		db_findPlayersBySpawn=0
		for theKey,thePlayer in ipairs(nearbyPlayers)do
			db_findPlayersBySpawn=db_findPlayersBySpawn+1
		end 
		counter=counter+1
		if(counter>20)then
			break
		end
	end 
	return db_hasFindClearSpawn
 end  

 function getDurbyGameRestTime()
	if(isTimer(durbyTimer))then
		local detailA,detailB,detailC=getTimerDetails (durbyTimer)
		detailA=math.round(((detailA/1000)/60))
		return detailA	
	else
		return -1
	end
 end
 
 function getDurbyGamePlayer()
	local activePlayer=0
	for theKey,thePlayer in ipairs(getElementsByType("player"))do
		if(vioGetElementData(thePlayer,"inArena")==3)then
			activePlayer=activePlayer+1
		end	
	end
	return activePlayer 
 end








