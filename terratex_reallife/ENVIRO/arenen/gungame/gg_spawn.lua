
gungame_spawns={
 {-1132.8037109375,1029.1533203125,1345.7368164062,166.08013916016}, 
 {-1135.0244140625,1022.556640625,1345.7440185547,108.01647949219}, 
 {-1131.443359375,1095.2470703125,1345.7882080078,249.30830383301}, 
 {-1112.8115234375,1087.0732421875,1341.8569335938,102.83636474609}, 
 {-1111.3271484375,1035.0751953125,1342.837890625,208.57586669922}, 
 {-1101.3994140625,1020.4638671875,1342.09375,311.42596435547}, 
 {-1070.33984375,1048.982421875,1344.2177734375,216.28839111328}, 
 {-1056.8095703125,1091.28515625,1342.9836425781,257.21859741211}, 
 {-1039.8486328125,1027.978515625,1343.0041503906,68.82763671875}, 
 {-1019.82421875,1028.6796875,1343.4848632812,252.1318359375}, 
 {-970.779296875,1096.736328125,1344.9967041016,284.7177734375}, 
 {-974.240234375,1089.6123046875,1344.9798583984,256.20233154297}, 
 {-976.3740234375,1023.8818359375,1345.0299072266,205.44471740723}, 
 {-998.654296875,1052.83984375,1342.5946044922,41.883270263672}, 
 {-1009.6474609375,1075.6318359375,1341.2575683594,85.823760986328}, 
 {-1013.400390625,1059.5986328125,1342.9970703125,274.35202026367}, 
 {-1021.9296875,1091.1943359375,1342.8951416016,278.74111938477}
 }
 
 
 gungame_maxplayers=12
 gungame_weapons={22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,38,16,9,8,4} --20 Waffen
 gungame_additional_weapon={4} --knifekill
 gungame_gametimer=false
 gungame_bestactualplayer=false
 gungame_hasstarted=false
 gungame_lastplayers=0
 gungame_startspawnes={false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false}
 
 function gg_get_clear_random_spawn()
	local gg_hasFindClearSpawn=math.random(1,17)
	local gg_findPlayersBySpawn=1
	local counter=0
	while(gg_findPlayersBySpawn>0)do
		gg_hasFindClearSpawn=math.random(1,17)
		local chatSphere = createColSphere( gungame_spawns[gg_hasFindClearSpawn][1],gungame_spawns[gg_hasFindClearSpawn][2],gungame_spawns[gg_hasFindClearSpawn][3],5.0)
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		gg_findPlayersBySpawn=0
		for theKey,thePlayer in ipairs(nearbyPlayers)do
			gg_findPlayersBySpawn=gg_findPlayersBySpawn+1
		end 
		counter=counter+1
		if(counter>20)then
			break
		end
	end 
	return gg_hasFindClearSpawn
 end 
 
 function gg_Spawn_Player(thePlayer)
	if(vioGetElementData(thePlayer,"inArena")==1)then
		if gungame_hasstarted then
			local startspawn=gg_get_clear_random_spawn()
			spawnPlayer(thePlayer,gungame_spawns[startspawn][1],gungame_spawns[startspawn][2],gungame_spawns[startspawn][3],gungame_spawns[startspawn][4],vioGetElementData(thePlayer,"skinid"),10,0,team[vioGetElementData(thePlayer,"fraktion")])
			--setElementFrozen(thePlayer,true)
			giveWeapon ( thePlayer,4)
			giveWeapon ( thePlayer,gungame_weapons[vioGetElementData(thePlayer,"gg_level")],999,true)
			outputChatBox(string.format("Du bist Level %s/20 und hast eine %s", vioGetElementData(thePlayer,"gg_level"), getWeaponNameFromID(gungame_weapons[vioGetElementData(thePlayer,"gg_level")])),thePlayer,0,255,0)
			triggerClientEvent(thePlayer,"addFood",thePlayer,300)
			setTimer(gg_unfreeze_Player,3000,1,thePlayer)
		else
			outputChatBox("Bitte Warten bis mindestens 2 Spieler in der GunGame-Halle sind....",thePlayer,0,255,0)
			local startspawn=1
			for theKey,theSpawn in ipairs(gungame_startspawnes)do
				if(isElement(theSpawn))then
					if not(vioGetElementData(theSpawn,"inArena")==1)then
						startspawn=theKey
						break
					end				
				else
					startspawn=theKey
					break
				end			
			end
			gungame_startspawnes[startspawn]=thePlayer
			spawnPlayer(thePlayer,gungame_spawns[startspawn][1],gungame_spawns[startspawn][2],gungame_spawns[startspawn][3],gungame_spawns[startspawn][4],vioGetElementData(thePlayer,"skinid"),10,0,team[vioGetElementData(thePlayer,"fraktion")])
			setElementFrozen(thePlayer,true)
			triggerClientEvent(thePlayer,"addFood",thePlayer,300)
			
		end
	end
 end
 
 function gg_unfreeze_Player(thePlayer)
	if(thePlayer)then
		setElementFrozen(thePlayer,false)
	end
 end
 
 
 function gg_unfreeze_all_gg_players()
	for theKey,thePlayer in ipairs(getElementsByType("player"))do
		if(vioGetElementData(thePlayer,"inArena")==1)then
			outputChatBox("Die Runde GunGame beginnt!",thePlayer,0,255,0)
			outputChatBox("Möge der beste gewinnen!",thePlayer,0,255,0)
			setElementFrozen(thePlayer,false)
			gungame_hasstarted=true
			giveWeapon ( thePlayer, 4 )
			giveWeapon ( thePlayer, gungame_weapons[vioGetElementData(thePlayer,"gg_level")] , 999, true )
		end
	end
 end
 
 
function gg_onPlayerKilled(totalAmmo, killer, killerWeapon, bodypart , stealth)
	--outputChatBox(tostring(vioGetElementData(source,"inArena")))
	if(vioGetElementData(source,"inArena"))then
		if(vioGetElementData(source,"inArena")==1)then
			if(killer)and (not(killer==source))then
				vioSetElementData(killer,"gg_level",vioGetElementData(killer,"gg_level")+1)
				if(stealth)then
					if(vioGetElementData(source,"gg_level")>1)then
						vioSetElementData(source,"gg_level",vioGetElementData(source,"gg_level")-1)
						outputChatBox(string.format("Dir wurde ein Level von %s geklaut!", getPlayerName(killer)),source,0,255,0)
						outputChatBox(string.format("Du hast jetzt Level %s!", vioGetElementData(source,"gg_level")),source,0,255,0)
						outputChatBox(string.format("Du hast nun eine %s", getWeaponNameFromID(gungame_weapons[vioGetElementData(source,"gg_level")])),source,0,255,0)
					end
				end				
				if(vioGetElementData(killer,"gg_level")>20)then
					gungame_end()
				else
					outputChatBox(string.format("Du hast Level %s erreicht!", vioGetElementData(killer,"gg_level")),killer,0,255,0)
					outputChatBox(string.format("Du hast nun eine %s", getWeaponNameFromID (gungame_weapons[vioGetElementData(killer,"gg_level")])),killer,0,255,0)
					takeAllWeapons(killer)
					giveWeapon ( killer, 4 )
					triggerClientEvent(killer,"addFood",killer,25)
					giveWeapon ( killer, gungame_weapons[vioGetElementData(killer,"gg_level")] , 999, true )
					if(isElement(gungame_bestactualplayer))then
						if(vioGetElementData(killer,"gg_level")>vioGetElementData(gungame_bestactualplayer,"gg_level"))then
							gungame_bestactualplayer=killer
							for theKey,thePlayer in ipairs(getElementsByType("player"))do
								if(vioGetElementData(thePlayer,"inArena")==1)then
									outputChatBox(string.format("%s ist jetzt der Levelbeste mit Level %s", getPlayerName(killer), vioGetElementData(killer,"gg_level")),thePlayer,0,255,0)
								end
							end
						end
					else
						gungame_bestactualplayer=killer
						for theKey,thePlayer in ipairs(getElementsByType("player"))do
							if(vioGetElementData(thePlayer,"inArena")==1)then
								outputChatBox(string.format("%s ist jetzt der Levelbeste mit Level %s", getPlayerName(killer), vioGetElementData(killer,"gg_level")),thePlayer,0,255,0)
							end
						end
					end			
					
				end			
				setTimer(gg_Spawn_Player,5000,1,source)
				
			else
				setTimer(gg_Spawn_Player,5000,1,source)
				if(vioGetElementData(source,"gg_level")>1)then
					vioSetElementData(source,"gg_level",vioGetElementData(source,"gg_level")-1)
					outputChatBox("Du hast ein Level verloren!",source,0,255,0)
					outputChatBox(string.format("Du hast jetzt Level %s!", vioGetElementData(source,"gg_level")),source,0,255,0)
					outputChatBox(string.format("Du hast nun eine %s", getWeaponNameFromID ( gungame_weapons[vioGetElementData(source,"gg_level")] )),source,0,255,0)
				end
			end
		end
	end
end
addEventHandler("onPlayerWasted",getRootElement(),gg_onPlayerKilled)

 
 function enterGunGame(thePlayer)
	vioSetElementData(thePlayer,"gg_level",1)
	vioSetElementData(thePlayer,"inArena",1)
	gungame_lastplayers=gungame_lastplayers+1
	outputChatBox("Du hast die GunGameArena betreten! Du kannst Sie jederzeit mit /arenaquit verlassen!",thePlayer,0,255,0)
	if(getGunGameRestTime()==-1)then
		if(getGunGamePlayer()>1)then
			setTimer(gg_start,30000,1)
		end
	end
	killPed(thePlayer)
 end
 
 function gg_start()
	gg_unfreeze_all_gg_players()
	gungame_gametimer=setTimer(gungame_end,1200000,1)
 end
 
 function gungame_end()
	if(gungame_hasstarted)then
		gungame_hasstarted=false
		if(isTimer(gungame_gametimer))then
			killTimer(gungame_gametimer)
		end
		local gungameplayer={}
		for theKey,thePlayer in ipairs(getElementsByType("player"))do
			if(vioGetElementData(thePlayer,"inArena")==1)then
				table.insert(gungameplayer,thePlayer)
			end
		end
		local bestplayer=false
		for theKey,thePlayer in ipairs(gungameplayer)do
			if(bestplayer)then
				if(vioGetElementData(thePlayer,"gg_level")>vioGetElementData(bestplayer,"gg_level"))then
					bestplayer=thePlayer
				end
			else
				bestplayer=thePlayer
			end		
		end
		if(bestplayer)then
			for theKey,thePlayer in ipairs(gungameplayer)do
				outputChatBox(string.format("Der Gewinner mit 20 Levels ist: %s", getPlayerName(bestplayer)),thePlayer,0,255,0)	
			end
		end
		for theKey,thePlayer in ipairs(gungameplayer)do
			vioSetElementData(thePlayer,"gg_level",0)
			vioSetElementData(thePlayer,"inArena",0)
			killPed(thePlayer)
			vioSetElementData(thePlayer,"inArena",false)
			spawnPlayer(thePlayer,2745.8544921875,-1837.2998046875,10.328806877136,154.12683105469,vioGetElementData(thePlayer,"skinid"),0,0,team[vioGetElementData(thePlayer,"fraktion")])	
		end
		if(gungame_lastplayers>3)then
			local gewinn=25*gungame_lastplayers
			outputChatBox("Du hast "..toprice(gewinn).." verdient!",bestplayer,0,255,0)
            changePlayerMoney(bestplayer,gewinn,"sonstiges","Arenagewinn","GunGame")
		else
			outputChatBox("Da zu wenig Spieler noch im Spiel waren, konnte kein Gewinn ausgezahlt werden.",bestplayer,0,255,0)
		end
	end
	bestplayer=false
	 gungame_gametimer=false
	 gungame_bestactualplayer=false
	 gungame_hasstarted=false
	 gungame_lastplayers=0
	 gungame_startspawnes={false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false}
 end
 
 function getGunGamePlayer()
	local activePlayer=0
	for theKey,thePlayer in ipairs(getElementsByType("player"))do
		if(vioGetElementData(thePlayer,"inArena")==1)then
			activePlayer=activePlayer+1
		end	
	end
	return activePlayer
 
 end
 
 function getGunGameRestTime()
	if(isTimer(gungame_gametimer))then
		local detailA,detailB,detailC=getTimerDetails (gungame_gametimer )
		detailA=math.round(((detailA/1000)/60))
		return detailA	
	else
		return -1
	end
 end








