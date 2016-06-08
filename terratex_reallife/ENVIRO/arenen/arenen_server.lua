function arenen_marker()
	local areneMark=createMarker(2747.9228515625,-1826.47265625,11.347807884216,"cylinder")
	addEventHandler("onMarkerHit",areneMark,onArnenMarkerHit)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),arenen_marker)


function onArnenMarkerHit(thePlayer)
	
	if(getElementType(thePlayer)=="player")then
		--gungame
		local activeGunGamePlayers=getGunGamePlayer()
		local gungametime=getGunGameRestTime()
		if(gungametime==-1)then
			gungametime="-"
		end
		--stunt
		local activeSmallStuntPlayers=getStuntPlayer()		
		--durby
		local activeDurbyPlayers=getDurbyGamePlayer()
		local getDurbyRest=getDurbyGameRestTime()
		local getRestTimeType=isDurbyStarted
		if(getDurbyRest==-1)then
			getDurbyRest=""
		end
			
		triggerClientEvent(thePlayer,"showArenenGui",thePlayer,activeGunGamePlayers,gungametime,activeSmallStuntPlayers,activeDurbyPlayers,getDurbyRest,getRestTimeType)
	end
end


function quit_arena(thePlayer)
	if(vioGetElementData(thePlayer,"inArena")==1)then
		vioSetElementData(thePlayer,"inArena",0)
		killPed(thePlayer)
		spawnPlayer(thePlayer,2745.8544921875,-1837.2998046875,10.328806877136,154.12683105469,vioGetElementData(thePlayer,"skinid"),0,0,team[vioGetElementData(thePlayer,"fraktion")])
	elseif(vioGetElementData(thePlayer,"inArena")==2)then
		local vehicle=vioGetElementData(thePlayer,"stunt_vehicle")
		removePedFromVehicle(thePlayer)
		destroyElement(vehicle)
		setElementInterior(thePlayer,0)
		setElementDimension(thePlayer,0)
		vioSetElementData(thePlayer,"stunt_vehicle",false)
		vioSetElementData(thePlayer,"inArena",false)		
		setElementPosition(thePlayer,2745.8544921875,-1837.2998046875,10.328806877136)
		triggerClientEvent(thePlayer,"stunt_nowknocking",thePlayer)
		if isTimer(vioGetElementData(thePlayer,"stunt_timer"))then
			killTimer(vioGetElementData(thePlayer,"stunt_timer"))
		end
		vioSetElementData(thePlayer,"stunt_timer",false)
	elseif(vioGetElementData(thePlayer,"inArena")==3)then
		if(isPedInVehicle(thePlayer))then
			local veh=getPedOccupiedVehicle(thePlayer)
			removePedFromVehicle(thePlayer)
			destroyElement(veh)
		end
		vioSetElementData(thePlayer,"inArena",0)
		spawnPlayer(thePlayer,2745.8544921875,-1837.2998046875,10.328806877136,154.12683105469,vioGetElementData(thePlayer,"skinid"),0,0,team[vioGetElementData(thePlayer,"fraktion")])
	end
	vioSetElementData(thePlayer,"inArena",false)	
end

function quit_arena_cmd(thePlayer)
	if(vioGetElementData(thePlayer,"inArena"==3))then
		onPlayerDurbyQuit(thePlayer)
	end
	quit_arena(thePlayer)
end
addCommandHandler("arenaquit",quit_arena,false,false)

addEvent("goArena_Event",true)
function goArena_Event_func(arnennr)
	--outputChatBox(tostring(arnennr))
	if(getPlayerMoney(source)>49.99)then
		if(arnennr==1)then
			if(vioGetElementData(source,"waffenLic")==1)then
				if(getGunGamePlayer()<17)then
					changePlayerMoney(source,-50,"sonstiges","Arenaeintritt","GunGame")
                    changeBizKasse(11, 12.5, "Eintritt Arena")
					vioSetElementData(source,"inArena",1)
					enterGunGame(source)
				else
					outputChatBox("Es tut uns Leid, ihnen mitteilen zu müssen, dass die Arena voll ist!",source,255,0,0)							
				end
			else
				outputChatBox("Für die GunGame Arena benötigst du einen Waffenschein!",source,255,0,0)				
			end
		elseif(arnennr==2)then
            changePlayerMoney(source,-50,"sonstiges","Arenaeintritt","Stunt")
            changeBizKasse(11, 12.5, "Eintritt Arena")
			vioSetElementData(source,"inArena",2)
			stunt_join(source)
		elseif(arnennr==3)then
			if(not(isDurbyStarted))then
                changePlayerMoney(source,-50,"sonstiges","Arenaeintritt","Durby")
                changeBizKasse(11, 12.5, "Eintritt Arena")
				vioSetElementData(source,"inArena",3)
				enter_durby_arena(source)
			end
		end
	else
		outputChatBox("Du hast nicht genug Geld! Der Eintritt kostet 50$",source,255,0,0)
	end
end
addEventHandler("goArena_Event",getRootElement(),goArena_Event_func)








