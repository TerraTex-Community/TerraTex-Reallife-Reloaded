
function taxiget_func(thePlayer,cmd,toPlayerName)
	if(vioGetElementData(thePlayer,"fraktion")==4)then
		local timer=getRealTime()
		local newtime=(timer.timestamp-(60*3))
		if(toPlayerName)then
			local toPlayer=getPlayerFromIncompleteName(toPlayerName)
			if(toPlayer)then
				if(vioGetElementData(toPlayer,"wantTaxi"))then
					if(vioGetElementData(toPlayer,"wantTaxi")>newtime)and not(vioGetElementData(toPlayer,"hasTaxiDriver"))then
						vioSetElementData(toPlayer,"hasTaxiDriver",thePlayer)
						outputChatBox(string.format("Der Taxifahrer %s hat deinen Taxiruf angenommen und ist nun unterwegs zu dir!", getPlayerName(thePlayer)),toPlayer,0,255,0)
						for theKey,thePerson in ipairs(getPlayersInTeam ( team[4])) do
							outputChatBox(string.format("Der Spieler %s hat den Taxiruf von %s angenommen!", getPlayerName(thePlayer), getPlayerName(toPlayer)),thePerson,0,255,0)
						end	
						local blip=createBlipAttachedTo(toPlayer, 0, 2, 0, 255, 0, 255, 0, 99999.0,thePlayer)
						setTimer(killMechaBlip,240000,1,blip)					
						vioSetElementData(thePlayer, "AcceptedTaxiCustomer", toPlayer)
					else
						outputChatBox("Dieser Spieler benötigt kein Taxi!",thePlayer,255,0,0)			
					end
				else
					outputChatBox("Dieser Spieler benötigt kein Taxi!",thePlayer,255,0,0)			
				end
			else
				outputChatBox("Dieser Spieler existiert nicht!",thePlayer,255,0,0)	
			end		
		else
			outputChatBox("Dieser Spieler existiert nicht!",thePlayer,255,0,0)
		end	
	end
end
addCommandHandler("taxiget",taxiget_func,false,false)
addCommandHandler("tg",taxiget_func,false,false)

function tgnext_cmd(thePlayer)
	if(vioGetElementData(thePlayer,"fraktion")==4)then
		local timer=getRealTime()
		local newtime=(timer.timestamp-(60*3))
			
			local toPlayer=false
			for theKey,thePerson in ipairs(getElementsByType("player"))do
				if(vioGetElementData(thePerson,"wantTaxi"))then
					if(vioGetElementData(thePerson,"wantTaxi")>newtime)and not(vioGetElementData(thePerson,"hasTaxiDriver"))then
						toPlayer=thePerson
						--outputChatBox(getPlayerName(thePerson).." ("..getElementZoneName ( thePerson,true )..")",thePlayer,255,0,0)
					end			
				end
			end	
			if(toPlayer)then
				if(vioGetElementData(toPlayer,"wantTaxi"))then
					if(vioGetElementData(toPlayer,"wantTaxi")>newtime)and not(vioGetElementData(toPlayer,"hasTaxiDriver"))then
						vioSetElementData(toPlayer,"hasTaxiDriver",thePlayer)
						outputChatBox(string.format("Der Taxifahrer %s hat deinen Taxiruf angenommen und ist nun unterwegs zu dir!", getPlayerName(thePlayer)),toPlayer,0,255,0)
						for theKey,thePerson in ipairs(getPlayersInTeam ( team[4])) do
							outputChatBox(string.format("Der Spieler %s hat den Taxiruf von %s angenommen!", getPlayerName(thePlayer), getPlayerName(toPlayer)),thePerson,0,255,0)
						end	
						local blip=createBlipAttachedTo(toPlayer, 0, 2, 0, 255, 0, 255, 0, 99999.0,thePlayer)
						setTimer(killMechaBlip,240000,1,blip)		
						vioSetElementData(thePlayer, "AcceptedTaxiCustomer", toPlayer)
					else
						outputChatBox("Dieser Spieler benötigt kein Taxi!",thePlayer,255,0,0)			
					end
				else
					outputChatBox("Dieser Spieler benötigt kein Taxi!",thePlayer,255,0,0)			
				end
			else
				outputChatBox("Es wurde kein Spieler gefunden!",thePlayer,255,0,0)	
			end		

	end
end
addCommandHandler("tgnext",tgnext_cmd,false,false)

addEvent("showTaxiZiel_Event",true)
function showTaxiZiel_Event_func(x,y,z)
	if(isPedInVehicle(source))then
		local veh=getPedOccupiedVehicle ( source )
		local isTaxi=false
		for theKey,theVehicle in ipairs(frakselfcars[4])do
			if(theVehicle==veh)then
				isTaxi=true
			end
		end
		if(isTaxi)then
			local driver=getVehicleOccupant ( veh, 0)
			if(driver)then
				local blip=createBlip ( x, y, z, 41, 2, 255, 0, 0, 255,0, 99999.0, driver )
				setTimer(destroyElement,180000,1,blip)
				outputChatBox(string.format("Der Fahrgast %s hat dir sein Fahrziel gezeigt!", getPlayerName(source)),driver,0,255,0)
				outputChatBox("Es ist 180 Sekunden durch das Rotekreuz im schwarzen Kreis (Waypointsymbol) gekennzeichnet!",driver,0,255,0)
				outputChatBox("Du hast dem Taxifahrer deinen Zielort gezeigt!",source,0,255,0)			
			else
				outputChatBox("Du musst dazu in einen Taxi mit Fahrer sitzen!",source,255,0,0)			
			end
		else
			outputChatBox("Du musst dazu in einen Taxi mit Fahrer sitzen!",source,255,0,0)		
		end
	else
		outputChatBox("Du musst dazu in einen Taxi mit Fahrer sitzen!",source,255,0,0)
	end
end
addEventHandler("showTaxiZiel_Event",getRootElement(),showTaxiZiel_Event_func)

function listAllTaxiRequests(thePlayer)
	if(vioGetElementData(thePlayer,"fraktion")==4)then
		outputChatBox("Folgende Spieler haben in den letzten 3 Minuten ein Taxi gerufen und noch keine Antwort erhalten:",thePlayer,255,0,0)
		local timer=getRealTime()
		local newtime=(timer.timestamp-(60*3))
			--	vioSetElementData(thePlayer,"wantTaxi",timer.timestamp)
			--	vioSetElementData(thePlayer,"hasTaxiDriver",false)	
		for theKey,thePerson in ipairs(getElementsByType("player"))do
			if(vioGetElementData(thePerson,"wantTaxi"))then
				if(vioGetElementData(thePerson,"wantTaxi")>newtime)and not(vioGetElementData(thePerson,"hasTaxiDriver"))then
					outputChatBox(getPlayerName(thePerson).." ("..getElementZoneName ( thePerson,true )..")",thePlayer,255,0,0)
				end			
			end
		end	
		outputChatBox("Annehmen des Taxirufes mit /taxiget oder /tg [playername]",thePlayer,255,0,0)
	end
end
addCommandHandler("taxilist",listAllTaxiRequests,false,false)


addEvent("saveTaxaMeter",true)
function saveTaxaMeterBetrag(betrag)
	vioSetElementData(source,"saveTaxaMeter",betrag)
end
addEventHandler("saveTaxaMeter",getRootElement(),saveTaxaMeterBetrag)

function quitTaxaMeter_Offline( quitType )
	if(vioGetElementData(source,"taxaUse"))then		
		triggerEvent("stopTaxaMeter",source,"offline",vioGetElementData(source,"saveTaxaMeter"))	
	end
	vioSetElementData(source, "AcceptedTaxiCustomer", false)
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitTaxaMeter_Offline )

addEvent("showTaxaMeterToDriver",true)
function showTaxaMeterToDriver_func(preis)
	outputChatBox(string.format("Das Taxameter für %s zeigt %s$", getPlayerName(source), preis),vioGetElementData(source,"taxaUse"))
	vioSetElementData(source,"saveTaxaMeter",preis)
end
addEventHandler("showTaxaMeterToDriver",getRootElement(),showTaxaMeterToDriver_func)



function taxi_duty(thePlayer)
	if(vioGetElementData(thePlayer,"fraktion")==4)then
		if(vioGetElementData(thePlayer,"taxi_duty"))then
			vioSetElementData(thePlayer,"taxi_duty",false)			
			setElementModel(thePlayer,vioGetElementData(thePlayer,"skinid"))
		--	outputChatBox("Der Taxifahrer "..getPlayerName(thePlayer).." ist nicht mehr im Dienst",getRootElement(),16,188,0)
		--	outputChatBox("Mit /taxi kannst du weitere Taxifahrer, die im Dienst sind, sehen!",getRootElement(),16,188,0)
			outputChatBox("Du bist nun nicht mehr im Dienst",thePlayer,0,255,0)
			for theKey,thePerson in ipairs(getPlayersInTeam(team[4])) do
				outputChatBox(string.format("Der Spieler %s ist nun nicht mehr im Dienst!", getPlayerName(thePlayer)),thePerson,150,120,0)				
			end
		else	
			vioSetElementData(thePlayer,"taxi_duty",true)
			setElementModel(thePlayer,vioGetElementData(thePlayer,"FrakSkin"))
		--	outputChatBox("Der Taxifahrer "..getPlayerName(thePlayer).." ist im Dienst",getRootElement(),16,188,0)
		--	outputChatBox("Mit /taxi kannst du weitere Taxifahrer, die im Dienst sind, sehen!",getRootElement(),16,188,0)
		--	outputChatBox("Für ein Taxi nutze /call 400!",getRootElement(),16,188,0)
		
			for theKey,thePerson in ipairs(getPlayersInTeam(team[4])) do
				outputChatBox(string.format("Der Spieler %s ist im Dienst!", getPlayerName(thePlayer)),thePerson,150,120,0)				
			end
		
		
			outputChatBox("Du bist nun im Dienst",thePlayer,0,255,0)
		end	
	end
end
addCommandHandler("duty",taxi_duty,false,false)

function text_werbung()
	local taxistring=""
	local taxicounter=0
	for theKey,thePlayers in ipairs(getPlayersInTeam ( team[4])) do
		if(vioGetElementData(thePlayers,"taxi_duty"))then
			taxistring=taxistring..", "..getPlayerName(thePlayers)
			taxicounter=taxicounter+1
		end
	end
	if(taxicounter>0)then
		outputChatBox("Es sind Taxifahrer im Dienst! (/taxi)",getRootElement(),16,188,0)
		outputChatBox("Für ein Taxi nutze /call 400!",getRootElement(),16,188,0)
	end
	setTimer(text_werbung,900000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),text_werbung)

function taxi_cmd(thePlayer)
	local taxistring=""
	local taxicounter=0
	for theKey,thePlayers in ipairs(getPlayersInTeam ( team[4])) do
		if(vioGetElementData(thePlayers,"taxi_duty"))then
			taxistring=taxistring..", "..getPlayerName(thePlayers)
			taxicounter=taxicounter+1
		end
	end
	outputChatBox(string.format("Es sind %s Taxifahrer im Dienst", taxicounter),thePlayer,16,188,0)
	if(taxicounter>0)then
		outputChatBox(string.format("Im Dienst sind: %s", taxistring),thePlayer,16,188,0)
		outputChatBox("Für ein Taxi nutze /call 400!",thePlayer,16,188,0)
	end
end
addCommandHandler("taxi",taxi_cmd,false,false)




addEvent("stopTaxaMeter",true)
function stopTaxaMeter_func(reason,price)
	local taxifahrer=vioGetElementData(source,"taxaUse")
	if not(price) then
		price=0
	end
	if(reason=="offline")then
		outputChatBox(string.format("Der Fahrgast %s hat das Taxi verlassen, da er Offline gegangen ist!", getPlayerName(source)),taxifahrer)
        changePlayerMoney(source,-price,"sonstiges","Taxifahrt")
		outputChatBox(string.format("Der Fahrgast zahlt: %s. Die Hälfte wurde an die Fraktionskasse überwiesen!", toprice(price)),taxifahrer)
		local taxiVerdienst=math.round(price/2)
		frakdepot_log(4,1,taxiVerdienst,string.format("Verdienst von %s", getPlayerName(taxifahrer)))
        changePlayerMoney(taxifahrer,taxiVerdienst,"fraktion","Taxifahrt Einkommen")
		frakkasse[4]=frakkasse[4]+taxiVerdienst	
	
	
	elseif(reason=="notmoremoney")then
		outputChatBox("Du wurdest aus dem Taxi geschmissen, da du kein Geld mehr hattest!",source)
		outputChatBox(string.format("Der Fahrgast %s hat das Taxi verlassen, da er kein Geld mehr hatte!", getPlayerName(source)),taxifahrer)
        changePlayerMoney(source,-price,"sonstiges","Taxifahrt")
		outputChatBox(string.format("Du hast %s gezahlt!", toprice(price)),source)
		outputChatBox(string.format("Der Fahrgast zahlt: %s. Die Hälfte wurde an die Fraktionskasse überwiesen!", toprice(price)),taxifahrer)
		local taxiVerdienst=math.round(price/2)
		frakdepot_log(4,1,taxiVerdienst,string.format("Verdienst von %s", getPlayerName(taxifahrer)))
        changePlayerMoney(taxifahrer,taxiVerdienst,"fraktion","Taxifahrt Einkommen")
		frakkasse[4]=frakkasse[4]+taxiVerdienst	
		removePedFromVehicle(source)
	else
		outputChatBox("Du hast das Taxi verlassen!",source)
		outputChatBox(string.format("Der Fahrgast %s hat das Taxi verlassen!", getPlayerName(source)),taxifahrer)
        changePlayerMoney(source,-price,"sonstiges","Taxifahrt")
		outputChatBox(string.format("Du hast %s gezahlt!", toprice(price)),source)
		outputChatBox(string.format("Der Fahrgast zahlt: %s. Die Hälfte wurde an die Fraktionskasse überwiesen!", toprice(price)),taxifahrer)
		local taxiVerdienst=math.round(price/2)
		frakdepot_log(4,1,taxiVerdienst,string.format("Verdienst von %s", getPlayerName(taxifahrer)))
        changePlayerMoney(taxifahrer,taxiVerdienst,"fraktion","Taxifahrt Einkommen")
		frakkasse[4]=frakkasse[4]+taxiVerdienst		
	end
	vioSetElementData(source,"taxaUse",false)
	vioSetElementData(source, "AcceptedTaxiCustomer", false)
end
addEventHandler("stopTaxaMeter",getRootElement(),stopTaxaMeter_func)


function stm_func(thePlayer,Command,toPlayerName)
	if(vioGetElementData(thePlayer,"fraktion")==4)then
		if(isPedInVehicle(thePlayer))then
			local veh=getPedOccupiedVehicle ( thePlayer )
			local isTaxi=false
			for theKey,theVehicle in ipairs(frakselfcars[4])do
				if(theVehicle==veh)then
					isTaxi=true
				end
			end
			if(isTaxi)then
                if(vioGetElementData(thePlayer, "AcceptedTaxiCustomer"))then
                   if(not isElement(vioGetElementData(thePlayer, "AcceptedTaxiCustomer")))then
                       vioSetElementData(thePlayer,"AcceptedTaxiCustomer",false)
                   end
                end
				if(toPlayerName or vioGetElementData(thePlayer, "AcceptedTaxiCustomer"))then
					local toPlayer= ""
					if (toPlayerName) then
						toPlayer = getPlayerFromIncompleteName(toPlayerName)
					else
						toPlayer = vioGetElementData(thePlayer, "AcceptedTaxiCustomer")
					end
					if(toPlayer)then	
						if not(vioGetElementData(toPlayer,"taxaUse"))then
							local tarif=vioGetElementData(thePlayer,"taxatarif")
							local occup=getVehicleOccupants ( veh )
							if(occup[1]==toPlayer or occup[2]==toPlayer or occup[3]==toPlayer)then 
								vioSetElementData(toPlayer,"taxaUse",thePlayer)
								local ttime=getTaxiTimeZone()
								local ttarf=1
								if(vioGetElementData(thePlayer,"taxatarif"))then
									ttarf=vioGetElementData(thePlayer,"taxatarif")
								end
								vioSetElementData(toPlayer,"taxaBetrag",0)
								triggerClientEvent(toPlayer,"startTaxameter",toPlayer,taxiGrundPrice,taxiPrices[ttime][ttarf])
								outputChatBox(string.format("Das Taxameter wurde gestartet mit der Tarifzone: %s", ttarf),toPlayer)
								outputChatBox(string.format("Du hast das Taxameter für %s gestartet mit Tarif %s", getPlayerName(toPlayer), ttarf),thePlayer)					
							
							else
								showError(thePlayer,"Dieser Spieler sitzt nicht in deinem Taxi!")							
							end	
						else
							showError(thePlayer,"Das taxameter für diesen Spieler läuft bereits!")
						end
					else
						showError(thePlayer, "Dieser Spieler existiert nicht!")							
					end
				else
					showError(thePlayer,"Nutzung: /stm [Name]!")						
				end
			else
				showError(thePlayer,"Du bist in keinem Taxi!")			
			end			
		else
			showError(thePlayer,"Du bist in keinem Taxi!")
		end
	end
end
addCommandHandler("stm",stm_func,false,false)

function tarif_func(thePlayer,Command,tarif)
	if(vioGetElementData(thePlayer,"fraktion")==4)then
		if(isPedInVehicle(thePlayer))then
			local veh=getPedOccupiedVehicle ( thePlayer )
			local isTaxi=false
			for theKey,theVehicle in ipairs(frakselfcars[4])do
				if(theVehicle==veh)then
					isTaxi=true
				end
			end
			if(isTaxi)then
				if(tarif)then
					if(tonumber(tarif))then
						local tarifnum=tonumber(tarif)
						vioSetElementData(thePlayer,"taxatarif",tarifnum)
						local occup=getVehicleOccupants ( veh )
						local ttime=getTaxiTimeZone()
						if(occup[1])then
							triggerClientEvent(occup[1],"newTaxaTarif",occup[1],taxiPrices[ttime][tarifnum])
						end
						if(occup[2])then
							triggerClientEvent(occup[2],"newTaxaTarif",occup[2],taxiPrices[ttime][tarifnum])						
						end
						if(occup[3])then
							triggerClientEvent(occup[3],"newTaxaTarif",occup[3],taxiPrices[ttime][tarifnum])						
						end		
						showError(thePlayer,string.format("Du hast den neuen Tarif %s gesetzt!", tarifnum))
					else
						showError(thePlayer,"Nutzung: /tarif [1-3]!")					
					end
				else
					showError(thePlayer,"Nutzung: /tarif [1-3]!")
				end
			else
				showError(thePlayer,"Nutzung: /tarif [1-3]!")			
			end			
		else
			showError(thePlayer,"Nutzung: /tarif [1-3]!")
		end
	end
end
addCommandHandler("tarif",tarif_func,false,false)



function taxilight_func(thePlayer)
      if ( isPedInVehicle ( thePlayer ) ) then --is in vehicle or not?
        local vehicle = getPedOccupiedVehicle ( thePlayer ) --getting player's occupied vehicle
        if ( getVehicleController ( vehicle ) == thePlayer ) then --is driver or not?
          local id = getElementModel ( vehicle ) --getting vehicle's model
          if ( ( id == 420 ) or ( id == 438 ) ) then --is a taxi?
            setVehicleTaxiLightOn ( vehicle, not isVehicleTaxiLightOn ( vehicle ) ) --changing taxi light on/off
          end
        end	
      end
end
addCommandHandler("tlicht",taxilight_func)








