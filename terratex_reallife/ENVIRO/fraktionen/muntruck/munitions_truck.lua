muntruckcords={
{1581.8203125,-1624.0283203125,13.3828125},
{2496.6162109375,-1678.333984375,12.339521408081},
{false,false,false},
{false,false,false},
{1581.8203125,-1624.0283203125,13.3828125},
{711.564453125,-1434.3916015625,13.531820297241},
{1581.8203125,-1624.0283203125,13.3828125},
{false,false,false},
{1581.8203125,-1624.0283203125,13.3828125},
{false,false,false},
{2040.1337890625,1916.4404296875,12.167406082153},--cash
{2804.8916015625,2183.91796875,10.8203125},--violettas
{2384.958984375,1019.9931640625,10.8203125} --sharkracer
}
munTruckMassage={true,true,true,false,true,true,true,false,true,false,true,true,true}

muntrucks={
{-1588.5419921875,79.6015625,3.9918963909149},
{-1588.5419921875,79.6015625,3.9918963909149},
{-1588.5419921875,79.6015625,3.9918963909149},
{-1588.5419921875,79.6015625,3.9918963909149},
{-1588.5419921875,79.6015625,3.9918963909149},
{-1588.5419921875,79.6015625,3.9918963909149},
{-1588.5419921875,79.6015625,3.9918963909149}
}

muntruckstarted=false

function onMunTruckMarker_create()
	local MunTruckMarker=createMarker ( -1596.21875,42.517578125,17.328125, "cylinder", 5.0)
	addEventHandler( "onMarkerHit", MunTruckMarker, onMunTruckMarkerHit )

end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onMunTruckMarker_create)

function onMunTruckMarkerHit(hitElement)
	local frak=vioGetElementData(hitElement,"fraktion")
	if(frakmun[frak])then
		if(frakmun[frak]>=1000000)then
			outputChatBox("Euer Munitionsdepot ist bereits voll!",hitElement,255,0,0)
		else
			triggerClientEvent(hitElement,"showMunTruckBestellGUI",hitElement,frakmun[frak])		
		end
	else	
		outputChatBox("Du bist hier unerwünscht!",hitElement,255,0,0,255)
	end
end

addEvent("bestellMuntGui_Event",true)
function bestellMuntGui(howmany)
	local copson=0
	for theKey,thePlayers in ipairs(getPlayersInTeam(team[1]))do
		copson=copson+1
	end	
	for theKey,thePlayers in ipairs(getPlayersInTeam(team[7]))do
		copson=copson+1
	end
	for theKey,thePlayers in ipairs(getPlayersInTeam(team[5]))do
		copson=copson+1
	end
	for theKey,thePlayers in ipairs(getPlayersInTeam(team[9]))do
		copson=copson+1
	end
	if(copson>0)then
		if( not(muntruckstarted))then
	
			local price=howmany*0.1
			if(price>frakkasse[vioGetElementData(source,"fraktion")])then
				outputChatBox("In der Fraktionskasse befindet sich nicht genug Geld!",source,255,0,0)
			else
				frakkasse[vioGetElementData(source,"fraktion")]=frakkasse[vioGetElementData(source,"fraktion")]-price
				local randTruck=math.random(1,6)
				local MunTruck=createVehicle ( 455, muntrucks[randTruck][1], muntrucks[randTruck][2],muntrucks[randTruck][3], 0,0,90, "MUNITION" )
				vioSetElementData(MunTruck,"frakid",5000)
				vioSetElementData(MunTruck,"muntruck",true)
				vioSetElementData(MunTruck,"muntruckbetrag",howmany)
				addEventHandler("onVehicleEnter",MunTruck,enterMunTruck)
				addEventHandler("onVehicleExit",MunTruck,exitMunTruck)
				addEventHandler("onVehicleExplode", MunTruck, munTruckExplode)
				warpPedIntoVehicle(source,MunTruck,0)	
				triggerClientEvent(source,"closeMuntGui_Event",source)
				muntruckstarted=true
				setTimer(resetWTruckTimer,600000,1)
				frakdepot_log(vioGetElementData(source,"fraktion"),1,-price,"WTruck-"..getPlayerName(source))
				for theKey,theValue in ipairs(munTruckMassage)do
					if(theValue)then
						players=getPlayersInTeam(team[theKey])
						for theNewKey,theNewPlayer in ipairs(players)do
							outputChatBox("Geheimdienst: Ein Waffentruck ist unterwegs!",theNewPlayer,255,0,0)
						end
					end		
				end		
			end
		else
			outputChatBox("Es kann nur alle 10 Minuten ein Munitrionstruck gestartet werden!",source,255,0,0)
		end
	else
		outputChatBox("Es müssen mindestens 2 Beamte online sein!",source,255,0,0)
	end
end
addEventHandler("bestellMuntGui_Event",getRootElement(),bestellMuntGui)

function resetWTruckTimer()
	muntruckstarted=false
end

function enterMunTruck(thePlayer,seat)
	if(seat==0)then
		local fraktion=vioGetElementData(thePlayer,"fraktion")
		if(frakmun[fraktion])or(isBeamter(thePlayer))then
			if(isBeamter(thePlayer))then
				outputChatBox("Bringe den Munitionstruck zur Reservatenkammer!",thePlayer,255,0,0)
			else
				outputChatBox("Bringe den Munitionstruck zu euren Munitionsdepot!",thePlayer,255,0,0)
			end
			local marker=createMarker (muntruckcords[fraktion][1],muntruckcords[fraktion][2],muntruckcords[fraktion][3], "cylinder", 10.0, 255, 0, 0, 255, thePlayer )
			local blip=createBlip ( muntruckcords[fraktion][1],muntruckcords[fraktion][2],muntruckcords[fraktion][3], 0, 2, 255, 0, 0, 255, 0 , 99999.0,thePlayer )
			vioSetElementData(thePlayer,"MunMarker",marker)
			vioSetElementData(thePlayer,"MunBlip",blip)
			vioSetElementData(source,"MunDriver",thePlayer)
			addEventHandler( "onMarkerHit", marker, enterMunMarkerAbgabe )
		end		
	end
end

function enterMunMarkerAbgabe(hitElementer)
	if(isElement(hitElementer))then
		if(getElementType(hitElementer)=="vehicle")then
			if(vioGetElementData(hitElementer,"muntruck"))then
				local player=getVehicleOccupant ( hitElementer, 0 )
				local fraktion=vioGetElementData(player,"fraktion")
				local betrag=vioGetElementData(hitElementer,"muntruckbetrag")
				if((frakmun[fraktion]))then
					frakmun[fraktion]=frakmun[fraktion]+betrag
					outputChatBox(string.format("Es wurden %s Patronen in das Munitionsdepot gelagert!", betrag),player,255,0,0)
					frakdepot_log(fraktion,3,betrag,"WTruck-"..getPlayerName(player))
					for theKey,theValue in ipairs(munTruckMassage)do
						if(theValue)then
							players=getPlayersInTeam(team[theKey])
							for theNewKey,theNewPlayer in ipairs(players)do
								outputChatBox("Geheimdienst: Ein Waffentruck hat sein Zielort erreicht!",theNewPlayer,255,0,0)
							end
						end	
					end
				elseif((isBeamter(player)))then
					local cops={}
					local copanzahl=0
					for theKey,thePlayers in ipairs(getElementsByType("player"))do
						if(isBeamter(thePlayers))then
							copanzahl=copanzahl+1
							table.insert(cops,thePlayers)
						end					
					end
					local BetragProCop=(betrag*0.04)/copanzahl
					for theKey,thePlayers in ipairs(cops)do
						outputChatBox(string.format("Für die erfolgreiche Beschlagnahmung eines Waffentrucks wurden jedem Cop %s gutgeschrieben!", toprice(BetragProCop)),thePlayers,255,0,0)
                        changePlayerMoney(thePlayers,BetragProCop,"fraktion","Belohnung fürs Stoppen des WTs")
					end
					for theKey,theValue in ipairs(munTruckMassage)do
						if(theValue)then
							players=getPlayersInTeam(team[theKey])
							for theNewKey,theNewPlayer in ipairs(players)do
								outputChatBox("Geheimdienst: Ein Waffentruck wurde beschlagnahmt!",theNewPlayer,255,0,0)
							end
						end	
					end
				end	
					
				
				destroyElement(hitElementer)
				destroyElement(vioGetElementData(player,"MunMarker"))
				destroyElement(vioGetElementData(player,"MunBlip"))	
				
			end	
		end
	end
end

function exitMunTruck(thePlayer, seat)
	if(seat==0)then
		local marker=vioGetElementData(thePlayer,"MunMarker")
		local blip=vioGetElementData(thePlayer,"MunBlip")
		destroyElement(marker)
		destroyElement(blip)
		
			vioSetElementData(source,"MunDriver",false)
		
	end
end
function munTruckExplode()
	local player=vioGetElementData(source,"MunDriver")
	if(player)then
		local marker=vioGetElementData(player,"MunMarker")
		local blip=vioGetElementData(player,"MunBlip")
		destroyElement(marker)
		destroyElement(blip)
	end
	
end


function onMunTruckHit()
	if(vioGetElementData(source,"muntruck"))then
		if(getElementHealth(source)<=500)then
			fixVehicle(source)
			setElementFrozen(source,true)
			local occupants = getVehicleOccupants(source) 
			local seats = getVehicleMaxPassengers(source) 
			for seat = 0, seats do 
				if(occupants[seat])then
					outputChatBox("Der Waffentruck ist beschädigt! Verteidige ihn bis er wieder funktioniert!",occupants[seat],255,0,0)
					vioGetElementData(source,"MunDriver",false)
					ejectPed(occupants[seat])
					local rx,ry,rz=getElementRotation(source)
					setElementRotation(source,0,0,rz)
				end			
			end
			setTimer(unfreezeMunTruck,60000,1,source)
		end
	end

end
addEventHandler("onVehicleDamage",getRootElement(),onMunTruckHit)

function unfreezeMunTruck(source)
	if(isElement(source))then
		setElementFrozen(source,false)
	end
end













