local ArmyTestText = {"Orientierung","Beamtentheorie","Geländefahrtraining","soziale Kompetenz","Waffenumgang","spezial Fahrtest","Strategisches Training","praktisches Beamtenwissen","Datum der letzten Erneuerung"}

function zeugnis_geben(thePlayer,cmd,toPlayerName,ids,notes,note2,note3,note4,note5,note6,note7,note8)
	if(vioGetElementData(thePlayer,"fraktion")==7 and vioGetElementData(thePlayer,"fraktionsrang")>4) or(isBeamter(thePlayer) and vioGetElementData(thePlayer,"fraktionsrang")>4)then
		local id=tonumber(ids)
		local note=tonumber(notes)
		local toPlayer=getPlayerFromIncompleteName(toPlayerName)
		if(id and note and toPlayer)then
			if(id==1)then
				vioSetElementData(toPlayer,"NAME_orientierung",note)
				outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[id], note),thePlayer)
				outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[id], note),toPlayer)
			elseif(id==2)then
				vioSetElementData(toPlayer,"NAME_theorie_Beamte",note)
				outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[id], note),thePlayer)
				outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[id], note),toPlayer)
			elseif(id==3)then
				vioSetElementData(toPlayer,"NAME_Gelaendefahr",note)
				outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[id], note),thePlayer)
				outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[id], note),toPlayer)
			elseif(id==4)then
				vioSetElementData(toPlayer,"NAME_sozial",note)
				outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[id], note),thePlayer)
				outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[id], note),toPlayer)
			elseif(id==5)then
				vioSetElementData(toPlayer,"NAME_Waffenumgang",note)
				outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[id], note),thePlayer)
				outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[id], note),toPlayer)
			elseif(id==6)then
				vioSetElementData(toPlayer,"NAME_spezFahrtest",note)
				outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[id], note),thePlayer)
				outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[id], note),toPlayer)
			elseif(id==7)then
				vioSetElementData(toPlayer,"NAME_Strategisch",note)
				outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[id], note),thePlayer)
				outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[id], note),toPlayer)
			elseif(id==8)then
				vioSetElementData(toPlayer,"NAME_praktisch_Beamte",note)
				outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[id], note),thePlayer)
				outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[id], note),toPlayer)
			elseif(id==9)then
				vioSetElementData(toPlayer,"waffenLic",1)
				outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[id], note),thePlayer)
				outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[id], note),toPlayer)
			elseif(id==10)then
                if(note and note2 and note3 and note4 and note5 and note6 and note7 and note8)then
                    note2=tonumber(note2)
                    note3=tonumber(note3)
                    note4=tonumber(note4)
                    note5=tonumber(note5)
                    note6=tonumber(note6)
                    note7=tonumber(note7)
                    note8=tonumber(note8)
                    if(note and note2 and note3 and note4 and note5 and note6 and note7 and note8)then
                        vioSetElementData(toPlayer,"NAME_orientierung",note)
                        outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[1], note),thePlayer)
                        outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[1], note),toPlayer)
                        vioSetElementData(toPlayer,"NAME_theorie_Beamte",note2)
                        outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[2], note2),thePlayer)
                        outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[2], note2),toPlayer)
                        vioSetElementData(toPlayer,"NAME_Gelaendefahr",note3)
                        outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[3], note3),thePlayer)
                        outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[3], note3),toPlayer)
                        vioSetElementData(toPlayer,"NAME_sozial",note4)
                        outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[4], note4),thePlayer)
                        outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[4], note4),toPlayer)
                        vioSetElementData(toPlayer,"NAME_Waffenumgang",note5)
                        outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[5], note5),thePlayer)
                        outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[5], note5),toPlayer)
                        vioSetElementData(toPlayer,"NAME_spezFahrtest",note6)
                        outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[6], note6),thePlayer)
                        outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[6], note6),toPlayer)
                        vioSetElementData(toPlayer,"NAME_Strategisch",note7)
                        outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[7], note7),thePlayer)
                        outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[7], note7),toPlayer)
                        vioSetElementData(toPlayer,"NAME_praktisch_Beamte",note8)
                        outputChatBox(string.format("Du hast dem Spieler %s für %s die Note %s gegeben!", getPlayerName(toPlayer), ArmyTestText[8], note8),thePlayer)
                        outputChatBox(string.format("Du hast von dem Spieler %s für %s die Note %s bekomm!", getPlayerName(thePlayer), ArmyTestText[8], note8),toPlayer)
                    else
                        showError(thePlayer,"Bitte Geben Sie Alle Noten In der richtigen Reihenfolge an.")
                    end

                else
                    showError(thePlayer,"Bitte Geben Sie Alle Noten In der richtigen Reihenfolge an.")
                end
            else
				outputChatBox("IDs: 1:Orientierung 2:Beamtentheorie 3:Geländefahrtraining 4:Soziale Kompetenz",thePlayer)
				outputChatBox("5:Waffenumgang 6:spezieller Fahrtest 7:Strategisches Training 8:praktisches Beamtenwissen 9:Waffenschein 10:alle Noten Hintereinander setzen",thePlayer)
			end	
		else
				outputChatBox("IDs: 1:Orientierung 2:Beamtentheorie 3:Geländefahrtraining 4:Soziale Kompetenz",thePlayer)
				outputChatBox("5:Waffenumgang 6:spezieller Fahrtest 7:Strategisches Training 8:praktisches Beamtenwissen 9:Waffenschein 10:alle Noten Hintereinander setzen",thePlayer)
			end	
	end
end
addCommandHandler("givenote",zeugnis_geben,false,false)

function refresh_zeugnis(thePlayer,cmd,toPlayerName)
	if(vioGetElementData(thePlayer,"fraktion")==7 and vioGetElementData(thePlayer,"fraktionsrang")>4) or (isBeamter(thePlayer) and vioGetElementData(thePlayer,"fraktionsrang")>4)then
		toPlayer=getPlayerFromIncompleteName(toPlayerName)
		if(toPlayer)then
			local timer=getRealTime()
			local timestamp=timer.timestamp
			vioSetElementData(toPlayer,"NAME_refresh",timestamp)
			outputChatBox(string.format("%s hat dein Zeugnis auf das heutige Datum gesetzt!", getPlayerName(thePlayer)),toPlayer,0,255,0)
			outputChatBox(string.format("%ss Zeugnis wurde auf das heutige Datum gesetzt!", getPlayerName(toPlayer)),thePlayer,0,255,0)
		else
			showError(thePlayer,"Dieser Spieler existiert nicht!")
		end
	end
end
addCommandHandler("renote",refresh_zeugnis,false,false)

function reset_zeugnis(thePlayer,cmd,toPlayerName)
	if(vioGetElementData(thePlayer,"fraktion")==7 and vioGetElementData(thePlayer,"fraktionsrang")>4)  or (isBeamter(thePlayer) and vioGetElementData(thePlayer,"fraktionsrang")>4) then
		toPlayer=getPlayerFromIncompleteName(toPlayerName)
		if(toPlayer)then
			vioSetElementData(toPlayer,"NAME_orientierung",0)
			vioSetElementData(toPlayer,"NAME_theorie_Beamte",0)
			vioSetElementData(toPlayer,"NAME_Gelaendefahr",0)
			vioSetElementData(toPlayer,"NAME_sozial",0)
			vioSetElementData(toPlayer,"NAME_Waffenumgang",0)
			vioSetElementData(toPlayer,"NAME_spezFahrtest",0)
			vioSetElementData(toPlayer,"NAME_Strategisch",0)
			vioSetElementData(toPlayer,"NAME_praktisch_Beamte",0)
			outputChatBox(string.format("%s hat dein Zeugnis zurückgesetzt!", getPlayerName(thePlayer)),toPlayer,0,255,0)
			outputChatBox(string.format("%ss Zeugnis wurde zurückgesetzt!", getPlayerName(toPlayer)),thePlayer,0,255,0)
		end
	end	
end
addCommandHandler("resetnote",reset_zeugnis,false,false)

function zeugnis_zeigen(thePlayer,cmd,toPlayerName)
	local toPlayer=getPlayerFromIncompleteName(toPlayerName)
	if not(toPlayer)then
		toPlayer=thePlayer
	end
	outputChatBox("Zeugnis von "..getPlayerName(thePlayer),toPlayer)
	outputChatBox(ArmyTestText[1]..": "..vioGetElementData(thePlayer,"NAME_orientierung")	,toPlayer)
	outputChatBox(ArmyTestText[2]..": "..vioGetElementData(thePlayer,"NAME_theorie_Beamte")	,toPlayer)
	outputChatBox(ArmyTestText[3]..": "..vioGetElementData(thePlayer,"NAME_Gelaendefahr"),toPlayer)
	outputChatBox(ArmyTestText[4]..": "..vioGetElementData(thePlayer,"NAME_sozial"),toPlayer)
	outputChatBox(ArmyTestText[5]..": "..vioGetElementData(thePlayer,"NAME_Waffenumgang"),toPlayer)
	outputChatBox(ArmyTestText[6]..": "..vioGetElementData(thePlayer,"NAME_spezFahrtest"),toPlayer)
	outputChatBox(ArmyTestText[7]..": "..vioGetElementData(thePlayer,"NAME_Strategisch"),toPlayer)
	outputChatBox(ArmyTestText[8]..": "..vioGetElementData(thePlayer,"NAME_praktisch_Beamte"),toPlayer)
	local dates=getRealTime(vioGetElementData(thePlayer,"NAME_refresh"))	
	outputChatBox(ArmyTestText[9]..": "..dates["monthday"].."."..(dates["month"]+1).."."..(dates["year"]+1900),toPlayer)
	outputChatBox(string.format("Du hast dein Zeugnis erfolgreich %s gezeigt!", getPlayerName(toPlayer)),thePlayer,0,255,0)
end
addCommandHandler("zeugnis",zeugnis_zeigen,false,false)

local testcars={false,false,false,false,false}
function cTest_Army(thePlayer)
	if(vioGetElementData(thePlayer,"fraktion")==7)then
		testcars[1]= createVehicle(470,131.4482421875,1999.3701171875,19.232238769531,359.64294433594,357.64343261719,271.27990722656)   
		testcars[2]= createVehicle(433,137.7060546875,1995.08984375,19.746398925781,0.6591796875,0.72509765625,147.216796875)   
		testcars[3]= createVehicle(470,140.34375,1988.9267578125,19.386919021606,359.57702636719,0.0054931640625,3.4771728515625)   
		testcars[4]= createVehicle(470,132.962890625,1983.953125,19.395071029663,359.59350585938,359.99450683594,0.6866455078125)   
		testcars[5]= createVehicle(433,133.279296875,1979.236328125,19.811075210571,0.032958984375,359.86267089844,264.52880859375)    
	end
end
addCommandHandler("ctest",cTest_Army,false,false)

function dTest_Army(thePlayer)
	if(vioGetElementData(thePlayer,"fraktion")==7)  or (isBeamter(thePlayer) and vioGetElementData(thePlayer,"fraktionsrang")>4)then
		if(testcars[1])then
			if(isElement(testcars[1])and isElement(testcars[2])and isElement(testcars[3])and isElement(testcars[4])and isElement(testcars[5]))then
				destroyElement(testcars[1])
				destroyElement(testcars[2])
				destroyElement(testcars[3])
				destroyElement(testcars[4])
				destroyElement(testcars[5])
				testcars={false,false,false,false,false}
			end
		end
	end
end
addCommandHandler("dtest",dTest_Army,false,false)

--[[
 vehicle: createVehicle(470,-2437.35546875,-1914.439453125,304.85797119141,3.1805419921875,1.0272216796875,270.6591796875)    --  carspawner coord 
 ped= -2437.572265625 -1911.4130859375 304.90051269531,323.736328125 -- i carspawner
]]

function mount_spawner(thePlayer)
	if(vioGetElementData(thePlayer,"fraktion")==7 and vioGetElementData(thePlayer,"fraktionsrang")>2)  or (isBeamter(thePlayer) and vioGetElementData(thePlayer,"fraktionsrang")>4)then
		local hasPortedCar=false
		for key, theVehicle in pairs(frakselfcars[7]) do
			if not(isAnyOneInVehicle(theVehicle)) and not(hasPortedCar) and getElementModel(theVehicle)==470 then
					hasPortedCar=true
					setVehicleOverrideLights (theVehicle,1)
					setVehicleEngineState (theVehicle,false)				
					respawnVehicle (theVehicle)
					setElementPosition(theVehicle,-2437.35546875,-1914.439453125,304.85797119141)
					setElementRotation(theVehicle,3.1805419921875,1.0272216796875,270.6591796875)
				if(vioGetElementData(theVehicle,"frakid")~=0)then
					if(frakkasse[vioGetElementData(theVehicle,"frakid")]>=(100-vioGetElementData(theVehicle,"tank"))*6)then
						frakkasse[vioGetElementData(theVehicle,"frakid")]=frakkasse[vioGetElementData(theVehicle,"frakid")]-(100-vioGetElementData(theVehicle,"tank"))*6
	                    changeBizKasse(7, (100-vioGetElementData(theVehicle,"tank"))*6, "Bezinkauf")
						vioSetElementData(theVehicle,"tank",100)
					end
				else				
					vioSetElementData(theVehicle,"tank",100)
				end
			end					
		end	
	end
end
addCommandHandler("gnv",mount_spawner,false,false)

createPickup(179.89999389648,2002.599975585,-23.700000762939,3,1239,5000)
createPickup(192.39999389648,1931.5,17.5,3,1239,5000)

local isRunningAnTest=false
local testIsRunIn=10
local isTestingGuy=false
local isTesterGuy=false
local killerBots={}
local killpoints=0

function startNewWTest(thePlayer,cmd,toPlayerPart)
	if(isRunningAnTest)then
		outputChatBox("Es läuft bereits ein Test!",thePlayer,255,0,0)
	else
		if(vioGetElementData(thePlayer,"fraktion")==7 and vioGetElementData(thePlayer,"fraktionsrang")>1) or(isBeamter(thePlayer) and vioGetElementData(thePlayer,"fraktionsrang")>4)then
			local x,y,z=getElementPosition(thePlayer)
			if(getDistanceBetweenPoints3D(x,y,z,179.89999389648,2002.599975585,-23.700000762939)<200)then		
				if(toPlayerPart)then
					local toPlayer=getPlayerFromIncompleteName(toPlayerPart)
					if(toPlayer)then
						x,y,z=getElementPosition(toPlayer)
						if(getDistanceBetweenPoints3D(x,y,z,179.89999389648,2002.599975585,-23.700000762939)<200)then	
							setElementPosition(toPlayer,179.89999389648,2002.599975585,-23.700000762939)
							testIsRunIn=10
							isTestingGuy=toPlayer
							isTesterGuy=thePlayer
							isRunningAnTest=true
							outputChatBox("Der Test wurde gestartet!",thePlayer,255,0,0)
							outputChatBox("Dein Waffentest beginnt in 10 Sekunden!",toPlayer,255,0,0)
							outputChatBox("Töte nur böse Bots - Grüne Kleidung und tragen Waffen!",toPlayer,255,0,0)
							outputChatBox("und lasse gute Bots leben! -Zivile Kleidung!",toPlayer,255,0,0)
							setElementFrozen(toPlayer,true)
							killpoints=0
							setTimer(startTestInSeconds,1000,1,testIsRunIn)
						else
							outputChatBox("Der Rekrut ist nicht in der Nähe des Waffentests",thePlayer,255,0,0)		
						end							
					else
						outputChatBox("Der Spieler existiert nicht!",thePlayer,255,0,0)
					end		
				else
					outputChatBox("Der Spieler existiert nicht!",thePlayer,255,0,0)
				end
			else
				outputChatBox("Du bist nicht in der nähe des Waffentests",thePlayer,255,0,0)		
			end
		end
	end
end
addCommandHandler("startnwt",startNewWTest,false,false)

local badSkins={105,106,107,269,270}
local friendlySkins={7,12,26,57,59}
local botWeapons={24,30,31,22,29}
local timerData={}
function givemeWeapon(bot,id)
	if(isElement(bot))then
		giveWeapon ( bot,id , 30000, true )
		setWeaponAmmo (  bot, id, 9999,9999)
	else
		if(isTimer(timerData[bot]))then
			killTimer(timerData[bot])
		end
	end
end

function startTestInSeconds(timer)
	timer=timer-1
	if(timer>0)then
		outputChatBox(string.format("Dein Waffentest beginnt in %s Sekunden!", timer),isTestingGuy,255,0,0)		
		setTimer(startTestInSeconds,1000,1,timer)
	else
		timerData={}
		outputChatBox("Dein Waffentest beginnt jetzt! Du hast xx Sekunden Zeit!",isTestingGuy,255,0,0)
		setElementFrozen(isTestingGuy,false)
		local ped= createPed(badSkins[math.random(1,5)],193.18672180176,2013.9154052734,-23.10000038147,167.42596435547) -- böser bob 
		table.insert(killerBots,ped)
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		vioSetElementData(ped,"weaponTestPed",true)
		setElementHealth(ped,100)
		vioSetElementData(ped,"botType","bad")
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )
		ped= createPed(friendlySkins[math.random(1,5)],197.90058898926,2011.8704833984,-23.092918395996,141.10778808594) -- lieber bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		setElementHealth(ped,100)
		vioSetElementData(ped,"botType","friendly")
		ped= createPed(friendlySkins[math.random(1,5)],179.91561889648,2007.1099853516,-22.923961639404,357.90982055664) -- lieber bob
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		vioSetElementData(ped,"botType","friendly")		
		setElementHealth(ped,100)
		ped= createPed(badSkins[math.random(1,5)],178.57832336426,2015.0482177734,-23.10000038147,232.2847442627) -- böser bob
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		vioSetElementData(ped,"botType","bad")
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )		
		ped= createPed(badSkins[math.random(1,5)],185.46992492676,2014.1966552734,-23.10000038147,191.86541748047) -- böser bob
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		vioSetElementData(ped,"botType","bad")
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true ) 
		ped= createPed(badSkins[math.random(1,5)],182.18008422852,2026.181640625,-23.1484375,176.17669677734) -- böser bob
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		vioSetElementData(ped,"botType","bad")
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )		
		ped= createPed(friendlySkins[math.random(1,5)],186.60879516602,2035.2978515625,-23,118.20645141602) -- lieber bob
		table.insert(killerBots,ped)		
		vioSetElementData(ped,"weaponTestPed",true)
		vioSetElementData(ped,"botType","friendly")
		setElementHealth(ped,100)
		ped= createPed(badSkins[math.random(1,5)],181.99356079102,2036.8095703125,-23,131.05514526367) -- böser bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		setElementHealth(ped,100)
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		vioSetElementData(ped,"botType","bad")
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )
		ped= createPed(badSkins[math.random(1,5)],176.28652954102,2036.953125,-23,223.80316162109) -- böser bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		vioSetElementData(ped,"botType","bad")
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )
		ped= createPed(badSkins[math.random(1,5)],173.87344360352,2033.4853515625,-23,251.06614685059) -- böser bob
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		vioSetElementData(ped,"botType","bad")
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )		
		ped= createPed(badSkins[math.random(1,5)],179.62832641602,2028.2177734375,-23,92.849609375) -- böser bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		vioSetElementData(ped,"botType","bad")
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )
		ped= createPed(friendlySkins[math.random(1,5)],179.17227172852,2019.9541015625,-23,17.652557373047) -- lieber bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		vioSetElementData(ped,"botType","friendly")
		setElementHealth(ped,100)
		ped= createPed(badSkins[math.random(1,5)],169.54824829102,2020.1875,-23,307.39392089844) -- böser bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		vioSetElementData(ped,"botType","bad")
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )
		ped= createPed(badSkins[math.random(1,5)],170.55410766602,2028.0380859375,-23,274.87936401367) -- böser bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		vioSetElementData(ped,"botType","bad")
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )
		ped= createPed(badSkins[math.random(1,5)],164.17910766602,2025.2111816406,-23,212.83863830566) -- böser bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		vioSetElementData(ped,"botType","bad")
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )
		ped= createPed(friendlySkins[math.random(1,5)],156.98086547852,2025.3479003906,-23,189.96475219727) -- lieber bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		vioSetElementData(ped,"botType","friendly")
		setElementHealth(ped,100)
		ped= createPed(badSkins[math.random(1,5)],163.96719360352,2012.4025878906,-23,29.556427001953) -- böser bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		vioSetElementData(ped,"botType","bad")
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )
		ped= createPed(badSkins[math.random(1,5)],151.04922485352,2014.0900878906,-23,309.3440246582) -- böser bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		vioSetElementData(ped,"botType","bad")
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )
		ped= createPed(friendlySkins[math.random(1,5)],147.70156860352,2009.7805175781,-23,350.99380493164) -- lieber bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		vioSetElementData(ped,"botType","friendly")
		setElementHealth(ped,100)
		ped= createPed(badSkins[math.random(1,5)],153.32852172852,2026.2863769531,-23.1484375,176.15472412109) -- böser bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		vioSetElementData(ped,"botType","bad")
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )
		ped= createPed(badSkins[math.random(1,5)],145.92910766602,2038.9339599609,-23.776567459106,226.26412963867) -- böser bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		vioSetElementData(ped,"botType","bad")
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )
		ped= createPed(friendlySkins[math.random(1,5)],147.38906860352,2044.9447021484,-24.084615707397,201.82466125488) -- lieber bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		vioSetElementData(ped,"botType","friendly")
		setElementHealth(ped,100)
		ped= createPed(badSkins[math.random(1,5)],153.60781860352,2048.2641601563,-24.09218788147,171.43054199219) -- böser bob
		table.insert(killerBots,ped)	
		vioSetElementData(ped,"weaponTestPed",true)
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		vioSetElementData(ped,"botType","bad")
		setElementHealth(ped,100)
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )	
		ped= createPed(friendlySkins[math.random(1,5)],159.84707641602,2043.0706787109,-23.96478843689,141.03637695313) -- lieber bob 
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		vioSetElementData(ped,"botType","friendly")
		setElementHealth(ped,100)
		ped= createPed(badSkins[math.random(1,5)],158.30703735352,2035.5950927734,-23.174161911011,108.45043945313) -- böser bob	
		table.insert(killerBots,ped)
		vioSetElementData(ped,"weaponTestPed",true)
		local timer=setTimer(givemeWeapon,150,0,ped,botWeapons[math.random(1,5)])
		timerData[ped]=timer
		vioSetElementData(ped,"botType","bad")
		giveWeapon ( ped,botWeapons[math.random(1,5)] , 30000, true )
		setElementHealth(ped,100)
		
		for theKey,thePed in ipairs(killerBots)do
			vioSetElementData(thePed,"HP",100)
			vioSetElementData(thePed,"getPoints",0)
			if(vioGetElementData(thePed,"botType")=="bad")then
				triggerClientEvent(getRootElement(),"setPedShootingAt",isTestingGuy,thePed)
			end			
		end
		
		
		--setTimer(stopWTest,45000,1)
		setTimer(showRestTime,15000,1,60)
	end
end

--isTesterGuy

function showRestTime(lastTime)	
	if(lastTime>1)then
		if(lastTime<11)then
			lastTime=lastTime-1
			outputChatBox(string.format("Du hast noch %s Sekunden Zeit!", lastTime),isTestingGuy)
			setTimer(showRestTime,1000,1,lastTime)
		else
			lastTime=lastTime-5
			outputChatBox(string.format("Du hast noch %s Sekunden Zeit!", lastTime),isTestingGuy)
			setTimer(showRestTime,5000,1,lastTime)
		end
	else
		stopWTest()
	end
end

function stopWTest()
	for theKey,theBot in ipairs(killerBots)do
		if(isElement(theBot))then
			destroyElement(theBot)
		end
	end
	setElementPosition(isTestingGuy,192.39999389648,1931.5,16.5)
	local percent=0
	if(math.round(killpoints/2400*100,1)<0)then
		percent=0
	elseif(math.round(killpoints/2400*100,1)>100)then
		percent=100
	else
		percent=math.round(killpoints/2300*100)
	end
	
	outputChatBox(string.format("Erreichte Punktzahl: %s / 2400 in Prozent: %s", math.round(killpoints,1), percent,isTestingGuy))
	outputChatBox(string.format("%ss Erreichte Punktzahl: %s / 2400 in Prozent: %s", getPlayerName(isTestingGuy), killpoints, percent),isTesterGuy)
	isRunningAnTest=false
	testIsRunIn=10
	isTestingGuy=false
	isTesterGuy=false
	killerBots={}
	killpoints=0	
	
end

function stopTestingByQuit()
	if(source==isTestingGuy)then
		outputChatBox("Der Prüfling ist disconnected",isTesterGuy,255,0,0)
		for theKey,theBot in ipairs(killerBots)do
			if(isElement(theBot))then
				destroyElement(theBot)
			end
		end
		isRunningAnTest=false
		testIsRunIn=10
		isTestingGuy=false
		isTesterGuy=false
		killerBots={}
		killpoints=0	
	
	end
end
addEventHandler("onPlayerQuit",getRootElement(),stopTestingByQuit)

addEvent("onPedDamageCustom",true)
function onPedDamageCustom_func(attacker,  weapon,  bodypart ,  loss)
	local koerperschaden={1,1,2.5,2.5,0.5,0.5,0.5,0.5,4}
	if(vioGetElementData(source,"weaponTestPed"))then
		if(attacker==isTestingGuy)then
			if(not(vioGetElementData(source,"isKilled")))then
				local hp=vioGetElementData(source,"HP")
				loss=loss*koerperschaden[bodypart]
				vioSetElementData(source,"HP",hp-loss)	
				if(hp-loss<0)then				
					vioSetElementData(source,"HP",0)
				end
				
				
				if(hp>100)then
					setElementHealth(source,100)
					hp=100
				end
				local killed=false
				local changedHp=0
				if(hp-loss<0)then
					setElementHealth(source,0)
					vioSetElementData(source,"HP",0)
					killed=true
					changedHp=hp
					vioSetElementData(source,"getPoints",vioGetElementData(source,"getPoints")+changedHp)
					--[[if(bodypart==9)then
						setPedHeadless  ( source, true)
					end]]
				else
					setElementHealth(source,hp-loss)
					vioSetElementData(source,"HP",hp-loss)					
					changedHp=loss	
					vioSetElementData(source,"getPoints",vioGetElementData(source,"getPoints")+changedHp)					
				end
				if(vioGetElementData(source,"getPoints")>100)then
					changedHP=changedHP-(vioGetElementData(source,"getPoints")-100)
				end
				if(vioGetElementData(source,"botType")=="bad")then
					
					if(killed)then
						vioSetElementData(source,"isKilled",true)
						killpoints=killpoints+30
						if(bodypart==9)then
							killpoints=killpoints+20
							--outputChatBox("lalabu")
						end
						killPed (source)
					end
					killpoints=killpoints+changedHp
				else
					if(killed)then
						killpoints=killpoints-100
					end
					killpoints=killpoints-changedHp
				end
			--	outputChatBox("Punkte: "..killpoints.." / 2300 in Prozent: "..math.round(killpoints/2300*100,1))
			end
		end
	end
end
addEventHandler("onPedDamageCustom",getRootElement(),onPedDamageCustom_func)


function goInTestRegion(player)
	local x,y,z=getElementPosition(player)
	if(getDistanceBetweenPoints3D(x,y,z,192.39999389648,1931.5,16.5)<5)then
		setElementPosition(player,179.89999389648,2002.599975585,-24.700000762939)
	end
end
addCommandHandler("nIn",goInTestRegion,false,false)

function goInTestRegion(player)
	local x,y,z=getElementPosition(player)
	if(getDistanceBetweenPoints3D(x,y,z,179.89999389648,2002.599975585,-24.700000762939)<5)then
		setElementPosition(player,192.39999389648,1931.5,16.5)
	end
end
addCommandHandler("nOut",goInTestRegion,false,false)








