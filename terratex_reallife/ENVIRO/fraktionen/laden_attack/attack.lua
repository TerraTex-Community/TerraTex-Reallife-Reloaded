local attackIcons={}
local frakCanAttack={[0]=false,false,true,false,false,false,true,false,false,false,false,true,true,true}
attackerLadenInfos={{6,0,1,"Hauptammunation Los Santos"},{6,0,1,"Ammunation Grove Street"},{2,0,2,"Crackbude"},{2,0,2,"Drogenversteck am Glenpark"},{2,0,1,"Ammunation am Come-A-Lot"},{2,0,1,"Hauptammunation Las Venturas"},{2,0,2,"Drogenladen Süd Las Venturas"},{2,0,2,"Drogenladen Nord Las Vanturas"}}
--{Fraktion,LastAttackHours,Typ(1- Materials 2-Drogen, name}
function createAttackPickups()
	attackIcons[1]=createPickup(1366.197265625,-1287.2333984375,13.546875,3,1313)
		vioSetElementData(attackIcons[1],"typ",1)
		vioSetElementData(attackIcons[1],"id",1)
		addEventHandler("onPickupHit",attackIcons[1],showAttackPickupInfo)
	attackIcons[2]=createPickup(2398.9541015625,-1980.9375,13.546875,3,1313)
		vioSetElementData(attackIcons[2],"typ",1)
		vioSetElementData(attackIcons[2],"id",2)
		addEventHandler("onPickupHit",attackIcons[2],showAttackPickupInfo)
	attackIcons[3]=createPickup(2179.7978515625,-1661.5029296875,14.894522666931,3,1313)
		vioSetElementData(attackIcons[3],"typ",2)
		vioSetElementData(attackIcons[3],"id",3)
		addEventHandler("onPickupHit",attackIcons[3],showAttackPickupInfo)
	attackIcons[4]=createPickup(1808.9853515625,-1168.7900390625,23.828125,3,1313)
		vioSetElementData(attackIcons[4],"typ",2)
		vioSetElementData(attackIcons[4],"id",4)
		addEventHandler("onPickupHit",attackIcons[4],showAttackPickupInfo)
		
	attackIcons[5]=createPickup(2158.50390625,943.37890625,10.8203125,3,1313)
		vioSetElementData(attackIcons[5],"typ",1)
		vioSetElementData(attackIcons[5],"id",5)
		addEventHandler("onPickupHit",attackIcons[5],showAttackPickupInfo)
		
	attackIcons[6]=createPickup(2538.3857421875,2082.6337890625,10.8203125,3,1313)
		vioSetElementData(attackIcons[6],"typ",1)
		vioSetElementData(attackIcons[6],"id",6)
		addEventHandler("onPickupHit",attackIcons[6],showAttackPickupInfo)
		
	attackIcons[7]=createPickup(2442.3583984375,1954.255859375,10.786661148071,3,1313)
		vioSetElementData(attackIcons[7],"typ",2)
		vioSetElementData(attackIcons[7],"id",7)
		addEventHandler("onPickupHit",attackIcons[7],showAttackPickupInfo)

	attackIcons[8]=createPickup(2571.396484375,803.216796875,10.954463005066,3,1313)
		vioSetElementData(attackIcons[8],"typ",2)
		vioSetElementData(attackIcons[8],"id",8)
		addEventHandler("onPickupHit",attackIcons[8],showAttackPickupInfo)

	attackerLadenInfos[1][1] = MySql.helper.getValueSync("faction_shops", "toFraktion", {ID = 1});
	attackerLadenInfos[2][1] = MySql.helper.getValueSync("faction_shops", "toFraktion", {ID = 2});
	attackerLadenInfos[3][1] = MySql.helper.getValueSync("faction_shops", "toFraktion", {ID = 3});
	attackerLadenInfos[4][1] = MySql.helper.getValueSync("faction_shops", "toFraktion", {ID = 4});
	attackerLadenInfos[5][1] = MySql.helper.getValueSync("faction_shops", "toFraktion", {ID = 5});
	attackerLadenInfos[6][1] = MySql.helper.getValueSync("faction_shops", "toFraktion", {ID = 6});
	attackerLadenInfos[7][1] = MySql.helper.getValueSync("faction_shops", "toFraktion", {ID = 7});
	attackerLadenInfos[8][1] = MySql.helper.getValueSync("faction_shops", "toFraktion", {ID = 8});

	setTimer(giveLadenResources,3600000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createAttackPickups)

local isLadenAttack=false
local ladenUnterAttackID=0
local mainAttackerFraktion=0
local ladenDefenderFraktion=0
local ladenAttackTimer=0

function showAttackPickupInfo(thePlayer)
	if(frakCanAttack[vioGetElementData(thePlayer,"fraktion")])then
		local esbringt=""
		if(vioGetElementData(source,"typ")==1)then
			esbringt="Materialen && Money"
		else
			esbringt="Drogen && Money"
		end
		
		outputChatBox(string.format("Dieser Laden gehört der %s Er bringt: %s!", fraktionbezeichner[attackerLadenInfos[vioGetElementData(source,"id")][1]], esbringt),thePlayer,255,0,0)
		if not(vioGetElementData(source,"id")==ladenUnterAttackID) then
			outputChatBox(string.format("Er kann in %s Stunden angegriffen werden! Angriff mit /attack starten!", attackerLadenInfos[vioGetElementData(source,"id")][2]),thePlayer,255,0,0)	
		else
			outputChatBox("Dieser Laden wird gerade angegriffen!",thePlayer,255,0,0)	
		end
	end
end

function giveLadenResources()
	for theKey=1,8,1 do
		MySql.helper.update("faction_shops", { toFraktion = attackerLadenInfos[theKey][1] }, { ID = theKey });
		if(attackerLadenInfos[theKey][2]>0)then
			attackerLadenInfos[theKey][2]=attackerLadenInfos[theKey][2]-1
		end
		if(attackerLadenInfos[theKey][3]==1)then
			frakmun[attackerLadenInfos[theKey][1]]=frakmun[attackerLadenInfos[theKey][1]]+100
			frakdepot_log(attackerLadenInfos[theKey][1],3,100,"Waffenladen")
			frakkasse[attackerLadenInfos[theKey][1]]=frakkasse[attackerLadenInfos[theKey][1]]+100
			frakdepot_log(attackerLadenInfos[theKey][1],1,100,"Waffenladen")	
		else
			frakdrogen[attackerLadenInfos[theKey][1]]=frakdrogen[attackerLadenInfos[theKey][1]]+10
			frakdepot_log(attackerLadenInfos[theKey][1],2,10,"Drogenladen")
			frakkasse[attackerLadenInfos[theKey][1]]=frakkasse[attackerLadenInfos[theKey][1]]+100	
			frakdepot_log(attackerLadenInfos[theKey][1],1,100,"Drogenladen")			
		end			
		--outputDebugString(tostring(theKey))
	end
	setTimer(giveLadenResources,3600000,1)
end

function attack_func(thePlayer)
	if(isLadenAttack==false)then
		
			local ladenID=0
			for theKey=1,8,1 do
				local pix,piy,piz=getElementPosition(attackIcons[theKey])
				local plx,ply,plz=getElementPosition(thePlayer)
				if(getDistanceBetweenPoints3D(pix,piy,piz,plx,ply,plz)<15)then
					ladenID=theKey			
				end
			end
			if(ladenID~=0)then
				if(frakCanAttack[vioGetElementData(thePlayer,"fraktion")])then
					if not(attackerLadenInfos[ladenID][1]==vioGetElementData(thePlayer,"fraktion")) then
						local playerOnlineOfDefender=0
						for theKey,thePlayer in ipairs(getPlayersInTeam(team[attackerLadenInfos[ladenID][1]]))do
							playerOnlineOfDefender=playerOnlineOfDefender+1
						end
						if(playerOnlineOfDefender>1)then
							if(attackerLadenInfos[ladenID][2]==0)then
								ladenDefenderFraktion=attackerLadenInfos[ladenID][1]
								mainAttackerFraktion=vioGetElementData(thePlayer,"fraktion")
								isLadenAttack=true
								ladenUnterAttackID=ladenID
								ladenAttackTimer=setTimer(checkWinningLaden,900000,1)
								for theKey,thePersons in ipairs(getPlayersInTeam(team[ladenDefenderFraktion]))do
									outputChatBox("Einer ihrer Läden wird angegriffen!",thePersons,255,0,0)
								end
								for theKey,thePersons in ipairs(getPlayersInTeam(team[mainAttackerFraktion]))do
									outputChatBox("Der Angriff auf den Laden wurde erfolgreich gestartet!",thePersons,255,0,0)
								end
							
							else
								outputChatBox("Dieser Laden wurde bereits in den letzten 5 Stunden angegriffen!",thePlayer,255,0,0)						
							end				
						else
							outputChatBox("Es sind nicht genug Spieler von der Verteidigerfraktion online!",thePlayer,255,0,0)					
						end		
					else
						showError(thePlayer,"Du kannst nicht euren eigenen Laden angreifen!")
					end
				else
					outputChatBox("Du bist in keiner Fraktion, die angreifen kann!",thePlayer,255,0,0)						
				end		
			else
				outputChatBox("Du bist nicht in der Nähe eines Ladens!",thePlayer,255,0,0)		
			end
	else
		outputChatBox("Es können nicht mehrere Läden gleichzeitig angegriffen werden!",thePlayer,255,0,0)
	end
end
addCommandHandler("attack",attack_func,false,false)

function checkWinningLaden()
	local lax,lay,laz=getElementPosition(attackIcons[ladenUnterAttackID])
	local col=createColCircle ( lax,lay, 50.0 )
	local players=getElementsWithinColShape ( col, "player" )
	local frakplayer={}
	for theKey,thePersons in ipairs(players)do
		if(frakCanAttack[vioGetElementData(thePersons,"fraktion")])and not(isPedDead ( thePersons )) then
			if not(frakplayer[vioGetElementData(thePersons,"fraktion")])then
				frakplayer[vioGetElementData(thePersons,"fraktion")]=0
			end
			frakplayer[vioGetElementData(thePersons,"fraktion")]=frakplayer[vioGetElementData(thePersons,"fraktion")]+1
		end
	end
	if not(frakplayer[mainAttackerFraktion])then
		frakplayer[mainAttackerFraktion]=0
	end
	if not(frakplayer[ladenDefenderFraktion])then
		frakplayer[ladenDefenderFraktion]=0
	end
	if(frakplayer[mainAttackerFraktion]>frakplayer[ladenDefenderFraktion])then
		attackerLadenInfos[ladenUnterAttackID][1]=mainAttackerFraktion	
		attackerLadenInfos[ladenUnterAttackID][2]=5
		for theKey,thePersons in ipairs(getPlayersInTeam(team[mainAttackerFraktion]))do
			outputChatBox("Ihr habt den Laden erfolgreich übernommen!",thePersons,255,0,0)
		end
		for theKey,thePersons in ipairs(getPlayersInTeam(team[ladenDefenderFraktion]))do
			outputChatBox("Ihr konntet den Laden leider nicht halten!",thePersons,255,0,0)
		end
	else
		attackerLadenInfos[ladenUnterAttackID][2]=5
		for theKey,thePersons in ipairs(getPlayersInTeam(team[mainAttackerFraktion]))do
			outputChatBox("Ihr konntet den Laden nicht übernommen!",thePersons,255,0,0)
		end
		for theKey,thePersons in ipairs(getPlayersInTeam(team[ladenDefenderFraktion]))do
			outputChatBox("Ihr konntet den Laden erfolgreich halten!",thePersons,255,0,0)
		end	
	end
	isLadenAttack=false
	ladenUnterAttackID=0
	mainAttackerFraktion=0
	ladenDefenderFraktion=0
	ladenAttackTimer=0
end


function myladen(thePlayer)
	local fraktion=vioGetElementData(thePlayer,"fraktion")
	outputChatBox("Folgende Läden gehören deiner Fraktion: ",thePlayer,150,0,150)
	for theKey, theTable in ipairs(attackerLadenInfos)do
		if(theTable[1]==fraktion)then
			outputChatBox("- "..theTable[4],thePlayer,150,0,150)
		end
	end
end
addCommandHandler("sladen",myladen,false,false)












