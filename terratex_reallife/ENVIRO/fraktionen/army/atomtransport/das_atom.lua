-- Atomtransportmeldung Global
local atomPickUp=createPickup ( 2639.5932617188,-2683.5114746094,13.807812690735, 3,1239)
atomkatastrophe=false
local atomtruckSpawn={2635.5654296875,-2688.8818359375,14.091137886047,359.70886230469,0.7635498046875,27.976684570313}
local atombeamtenziel={2523.9482421875,2820.625,11.256578445435}
local atomrest={-1579.1865234375,93.80078125,3.5506792068481}
function startAtomTimer()
	setTimer(controlOnAtom,60000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),startAtomTimer)

function enteratomtransportpickup(thePlayer)
	if(source==atomPickUp)then
		outputChatBox(string.format("Atomlager: %s von 100 Einheiten!", serversettings["atommuell"]),thePlayer,255,0,0)
		if(serversettings["atommuell"]>50)then
			outputChatBox("ACHTUNG!!! DIE MASSE NÄHERT SICH DEM KRITISCHEN PUNKT!",thePlayer,255,0,0)
		end
		outputChatBox("Transport mit /atrans",thePlayer,255,0,0)
	end
end
addEventHandler("onPickupHit",getRootElement(),enteratomtransportpickup)


function atrans_func(thePlayer)
	if(isBeamter(thePlayer))then
		if(serversettings["atommuell"]==0)then
			outputChatBox("Das Lager ist leer, ein Transport ist nicht nötig!",thePlayer,255,0,0)
		else
			local x,y,z=getElementPosition(thePlayer)
			if(getDistanceBetweenPoints3D(x,y,z,atomtruckSpawn[1],atomtruckSpawn[2],atomtruckSpawn[3])<20)then
				local atomveh=createVehicle(433,atomtruckSpawn[1],atomtruckSpawn[2],atomtruckSpawn[3],atomtruckSpawn[4],atomtruckSpawn[5],atomtruckSpawn[6])
				vioSetElementData(atomveh,"frakid",5000)
				vioSetElementData(atomveh,"atomveh",true)
				if(serversettings["atommuell"]<26)then				
					vioSetElementData(atomveh,"atomtransmenge",serversettings["atommuell"])
					serversettings["atommuell"]=0
				else
					serversettings["atommuell"]=serversettings["atommuell"]-25
					vioSetElementData(atomveh,"atomtransmenge",25)
				end
					addEventHandler("onVehicleEnter",atomveh,enterAtomTruck)
					addEventHandler("onVehicleExit",atomveh,exitAtomTruck)
					addEventHandler("onVehicleExplode", atomveh, AtomTruckExplode)
				warpPedIntoVehicle(thePlayer,atomveh,0)				
				outputChatBox("Ein Atomtransport ist auf dem Weg! Bitte räumen Sie den Weg!",getRootElement(),255,0,0)
			end	
		end
	else
		outputChatBox("Wir übergeben unsere atomare Masse nur an zuverlässige Beamte!",thePlayer,255,0,0)
	end
end
addCommandHandler("atrans",atrans_func,false,false)

function enterAtomTruck(thePlayer,seat)
    if(seat==0)then
        if(isBeamter(thePlayer))then
            outputChatBox(string.format("Im Fahrzeug befinden sich %s Einheiten!", vioGetElementData(source,"atomtransmenge")),thePlayer,255,0,0)
            outputChatBox("Bringen sie den Atommüll zur weiteren Verarbeitung zur markierten Fabrik",thePlayer,255,0,0)
            vioSetElementData(source,"atomdriver",thePlayer)
            local marker=createMarker (atombeamtenziel[1],atombeamtenziel[2],atombeamtenziel[3], "cylinder", 10.0, 255, 0, 0, 255, thePlayer )
            local blip=createBlip ( atombeamtenziel[1],atombeamtenziel[2],atombeamtenziel[3], 0, 2, 255, 0, 0, 255, 0 , 99999.0,thePlayer )
            addEventHandler( "onMarkerHit", marker, enterAtomMarkerAbgabe )
            vioSetElementData(thePlayer,"AtomMarker",marker)
            vioSetElementData(thePlayer,"AtomBlip",blip)
        else
            if(frakmun[vioGetElementData(thePlayer,"fraktion")])then
                outputChatBox(string.format("Im Fahrzeug befinden sich %s Einheiten!", vioGetElementData(source,"atomtransmenge")),thePlayer,255,0,0)
                outputChatBox("Bringen sie den Atommüll zur markierten Fabrik um Munition als Belohnung zu erhalten!",thePlayer,255,0,0)
                vioSetElementData(source,"atomdriver",thePlayer)
                local marker=createMarker (atomrest[1],atomrest[2],atomrest[3], "cylinder", 10.0, 255, 0, 0, 255, thePlayer )
                local blip=createBlip ( atomrest[1],atomrest[2],atomrest[3], 0, 2, 255, 0, 0, 255, 0 , 99999.0,thePlayer )
                addEventHandler( "onMarkerHit", marker, enterAtomMarkerAbgabe )
                vioSetElementData(thePlayer,"AtomMarker",marker)
                vioSetElementData(thePlayer,"AtomBlip",blip)
            else
                removePedFromVehicle(thePlayer)
            end
        end
    end
end

function enterAtomMarkerAbgabe(hitElement)
	if(getElementType(hitElement)=="vehicle")then
		if(vioGetElementData(hitElement,"atomveh"))then
			local player=getVehicleOccupant ( hitElement, 0 )
			if(player)then
				if(isBeamter(player))then					
					local marker=vioGetElementData(player,"AtomMarker")
					local blip=vioGetElementData(player,"AtomBlip")
					menge=vioGetElementData(hitElement,"atomtransmenge")*50
					destroyElement(marker)
					destroyElement(hitElement)
					destroyElement(blip)
					outputChatBox("Danke für die Hilfe! Die Belohnung wurde auf die Fraktionskassen der Beamten übertragen.",player,255,0,0)
					frakkasse[1]=frakkasse[1]+menge
					frakkasse[5]=frakkasse[5]+menge
					frakkasse[6]=frakkasse[6]+menge
					frakkasse[7]=frakkasse[7]+menge	
					frakkasse[9]=frakkasse[9]+menge	
					outputChatBox("Entwarnung: Der Atomtransport wurde von der Polizei erfolgreich durchgeführt!",getRootElement(),255,0,0)
				else
					local marker=vioGetElementData(player,"AtomMarker")
					local blip=vioGetElementData(player,"AtomBlip")
					destroyElement(marker)					
					destroyElement(blip)
					outputChatBox("Danke für die Hilfe! Hier habt ihr eurer Geld!",player,255,0,0)
					local menge=vioGetElementData(hitElement,"atomtransmenge")*100
					frakkasse[vioGetElementData(player,"fraktion")]=frakkasse[vioGetElementData(player,"fraktion")]+menge
					outputChatBox(string.format("Ihr habt %s erhalten! Es befindet sich in eurer Frakkasse!", toprice(menge)),player,255,0,0)					
					destroyElement(hitElement)
					outputChatBox("Eilmeldung: Der Atomtransport wurde von einer kriminellen Organisation erfolgreich geklaut!",getRootElement(),255,0,0)
				end		
				
			end		
		end
	end
end

function AtomTruckExplode()
--outputChatBox("lala")
	local player=vioGetElementData(source,"atomdriver")
	if(player)then
		local marker=vioGetElementData(player,"AtomMarker")
		local blip=vioGetElementData(player,"AtomBlip")
		destroyElement(marker)
		destroyElement(blip)
	end

	if not(atomkatastrophe) then
		killTimer(lastWTimer)
		lastWTimer=false
		atomkatastrophe=true
		triggerClientEvent(getRootElement(),"setAtomKatastropheClient",getRootElement(),true)
		setWindVelocity ( 10,10,-(math.random(0,10) ))
		setSunColor ( 255,0,0,255,0,0 )
		if not(isWetterEventID==2) then
			isWetterEventID=1
		else
			isWetterEventID=3
		end
		setSkyGradient (0,255,0,136, 170, 212)
		setWaterColor(tonumber(math.random(0,255)),tonumber(math.random(0,255)),0,255)
		setSunSize(20)
		setRainLevel ( 0 )
		local x,y,z=getElementPosition(source)
		local chatSphere = createColSphere(x,y,z, 1000 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for theKey,thePlayer in ipairs(nearbyPlayers)do
			local health=getElementHealth(thePlayer)
			health=health-50
			if(health<0)then health=0 end
			setElementHealth(thePlayer,health)
		end
		setTimer(endAtomKatastrophe,1800000,1)
	end	
end

function exitAtomTruck(thePlayer, seat)
	if(isElement(source))then
		if(seat==0)then
			local marker=vioGetElementData(thePlayer,"AtomMarker")
			local blip=vioGetElementData(thePlayer,"AtomBlip")
			destroyElement(marker)
			destroyElement(blip)		
			vioSetElementData(source,"atomdriver",false)		
		end
	end
end



function controlOnAtom()
	local time= getRealTime()
	if(time.minute==0)then
		serversettings["atommuell"]=serversettings["atommuell"]+1
		if(serversettings["atommuell"]>50)then
			outputChatBoxForPolice("Das Atomkraftwerk nähert sich der kritischen Masse!")
			if not(FlutInAction) then
				if(serversettings["atommuell"]==100)or(serversettings["atommuell"]>100)then
					atomkatastrophe_func()
				else
					local randomzahl=math.random(serversettings["atommuell"],100)
					local randomzahlB=math.random(serversettings["atommuell"],100)
					if(randomzahl==randomzahlB)then
						atomkatastrophe_func()
					end		
				end
			end
		end
	end
	setTimer(controlOnAtom,60000,1)
end

function atomkatastrophe_func()
	killTimer(lastWTimer)
	lastWTimer=false
	atomkatastrophe=true
	serversettings["atommuell"]=0
	triggerClientEvent(getRootElement(),"setAtomKatastropheClient",getRootElement(),true)
	setWindVelocity ( 10,10,0 )
	setSunColor ( 255,0,0,0,255,0 )
	if not(isWetterEventID==2) then
		isWetterEventID=1
	else
		isWetterEventID=3
	end
	
	setSkyGradient (0,255,0,136, 170, 212)
	setWaterColor(tonumber(math.random(0,255)),tonumber(math.random(0,255)),0,255)
	setSunSize(15)
	setRainLevel ( 0 )
	local chatSphere = createColSphere( atomtruckSpawn[1],atomtruckSpawn[2],atomtruckSpawn[3], 1000 )
	local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
	destroyElement( chatSphere )
	for theKey,thePlayer in ipairs(nearbyPlayers)do
		local health=getElementHealth(thePlayer)
		health=health-50
		if(health<0)then health=0 end
		setElementHealth(thePlayer,health)
	end
	setTimer(endAtomKatastrophe,1800000,1)
end


function endAtomKatastrophe()
	resetRainLevel()
	resetWindVelocity()
	resetSunColor()
	resetSunSize()
	resetWaterColor()
	resetSkyGradient()
	atomkatastrophe=false
	if not(isWetterEventID==3) then
		isWetterEventID=0
	else
		isWetterEventID=2
	end
	triggerClientEvent(getRootElement(),"setAtomKatastropheClient",getRootElement(),false)
	
	lastWTimer=setTimer(changeWeather,10000,1)
end








