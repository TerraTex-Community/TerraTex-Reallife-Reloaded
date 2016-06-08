function drop_func(thePlayer,Command,theWas)

	if(theWas)then
		if(theWas=="Drogen")then
			vioSetElementData(thePlayer,"drogen",0)

			local posX, posY, posZ = getElementPosition( thePlayer )
			local chatSphere = createColSphere( posX, posY, posZ, 10 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			local pname=getPlayerName(thePlayer)
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
				outputChatBox( string.format("%s hat eine Tüte mit weißen Pulver weggeworfen!", pname), nearbyPlayer,255,255,200 )
			end
			
			
			
		elseif(theWas=="Materials")then
			vioSetElementData(thePlayer,"mats",0)
			local posX, posY, posZ = getElementPosition( thePlayer )
			local chatSphere = createColSphere( posX, posY, posZ, 10 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			local pname=getPlayerName(thePlayer)
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
				outputChatBox( string.format("%s hat einen schwarzen klirrenden Beutel weggeworfen!", pname), nearbyPlayer,255,255,200 )
			end	
		
		
		
		
		elseif(theWas=="Benzinkanister")then
			vioSetElementData(thePlayer,"kanister",0)
			local posX, posY, posZ = getElementPosition( thePlayer )
			local chatSphere = createColSphere( posX, posY, posZ, 10 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			local pname=getPlayerName(thePlayer)
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
				outputChatBox( string.format("%s hat einen Benzinkanister weggeworfen!", pname), nearbyPlayer,255,255,200 )
			end	
				
		elseif(theWas=="Lottoscheine")then
			vioSetElementData(thePlayer,"lottoschein",0)
			local posX, posY, posZ = getElementPosition( thePlayer )
			local chatSphere = createColSphere( posX, posY, posZ, 10 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			local pname=getPlayerName(thePlayer)
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
				outputChatBox( string.format("%s hat Lottoscheine weggeworfen!", pname), nearbyPlayer,255,255,200 )
			end	
					
		elseif(theWas=="Rubbellose")then
			vioSetElementData(thePlayer,"rubbellos",0)
			local posX, posY, posZ = getElementPosition( thePlayer )
			local chatSphere = createColSphere( posX, posY, posZ, 10 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			local pname=getPlayerName(thePlayer)
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
				outputChatBox( string.format("%s hat Rubbellose weggeworfen!", pname), nearbyPlayer,255,255,200 )
			end	
		elseif (theWas == "Kondome") then
			vioSetElementData(thePlayer, "Kondome", 0)
			local posX, posY, posZ = getElementPosition(thePlayer)
			local chatSphere = createColSphere(posX, posY, posZ, 10)
			local nearbyPlayers = getElementsWithinColShape(chatSphere, "player")
			destroyElement(chatSphere)
			local pname = getPlayerName(thePlayer)
			for index, nearbyPlayer in ipairs(nearbyPlayers) do
				outputChatBox(string.format("%s hat Kondome weggeworfen!", pname), nearbyPlayer, 255, 255, 200)
			end
		else
			showError(thePlayer,"Du kannst nur folgende Dinge wegwerfen: Drogen, Materials, Benzinkanister, Rubbellose, Lottoscheine und Kondome")
		end
	end
end
addCommandHandler("drop",drop_func,false,false)


function use_func(thePlayer,Command,wasString)
	if(wasString=="AD-Gutscheine")then
		if(vioGetElementData(thePlayer,"adgutscheine")>0)then
			local time=getRealTime()
			local timestamp=time.timestamp
			if(vioGetElementData(thePlayer,"adaktiv")>timestamp)then
				outputChatBox("Ein Gutschein ist noch aktiv für ",thePlayer,255,0,0)
				local restTime=vioGetElementData(thePlayer,"adaktiv")-timestamp
				local days=math.round(restTime/60/60/24,0,"floor")
				restTime=restTime-days*24*60*60
				local hours=math.round(restTime/60/60,0,"floor")
				restTime=restTime-hours*60*60
				local minutes=math.round(restTime/60,0,"floor")
				restTime=restTime-minutes*60
				outputChatBox(string.format("%s Tage %s Stunden %s Minuten %s Sekunden", days, hours, minutes, restTime),thePlayer,255,0,0)
				outputChatBox("Solange ein Gutschein aktiv ist, kann kein neuer aktiviert werden.",thePlayer,255,0,0)
			else
				timestamp=timestamp+7*24*60*60
				vioSetElementData(thePlayer,"adgutscheine",vioGetElementData(thePlayer,"adgutscheine")-1)
				vioSetElementData(thePlayer,"adaktiv",timestamp)
				outputChatBox("Du hast den Gutschein aktiviert! Er ist nun 7 Tage aktiv!",thePlayer,255,0,0)	
			end
		else
			showError(thePlayer,"Du besitzt keine AD-Gutscheine!")
		end
	elseif(wasString=="Drogen")then
		if(vioGetElementData(thePlayer,"drogen"))then
			if(vioGetElementData(thePlayer,"drogen")>0)then
				if not (isTimer(vioGetElementData(thePlayer,"hitTimer"))) then
					local hp=getElementHealth(thePlayer)
					if(hp<100)then
						hp=hp+20
						setElementHealth(thePlayer,hp)
						triggerClientEvent(thePlayer,"stopFoodTimerForSeconds_Event",thePlayer,240)
					end
					vioSetElementData(thePlayer,"drogen",vioGetElementData(thePlayer,"drogen")-1)
					triggerClientEvent(thePlayer,"addDrugTime_Event",thePlayer)
				else
					showError(thePlayer,"Du darfst in einen Kampf nichts essen!")
				end			
			else
				showError(thePlayer,"Du kannst das nicht benutzen!")
			end
		end
	
	elseif(wasString=="Benzinkanister")then
		if(vioGetElementData(thePlayer,"kanister")>0)then
			if(isPedInVehicle(thePlayer))then
				if(vioGetElementData(thePlayer,"Erfolg_Ersatztanke")~=1)then
					vioSetElementData(thePlayer,"Erfolg_Ersatztanke",1)
					triggerClientEvent(thePlayer,"onClientCreatePokalGUI",thePlayer,"Ersatztanke","Benutze das erste Mal einen benzinkanister")
				end			
				local veh=getPedOccupiedVehicle(thePlayer)
			
			
				if(vioGetElementData(veh,"tank"))then
					vioSetElementData(thePlayer,"kanister",vioGetElementData(thePlayer,"kanister")-1)
					vioSetElementData(veh,"tank",vioGetElementData(veh,"tank")+25)
					showError(thePlayer,"Du hast den Benzinkanister erfolgreich benutzt!")
                end
			end
		end		
	elseif(wasString=="Snack")then
		if(vioGetElementData(thePlayer,"snack")>0)then
			if not (isTimer(vioGetElementData(thePlayer,"hitTimer"))) then
				vioSetElementData(thePlayer,"snack",vioGetElementData(thePlayer,"snack")-1)
				triggerClientEvent(thePlayer,"addFood",thePlayer,10)
				showError(thePlayer,"Du hast einen Snack gegessen!")	
			else
				showError(thePlayer,"Du darfst in einen Kampf nichts essen!")
			end
		else
			showError(thePlayer,"Du besitzt keine Snacks!")				
		end
	elseif(wasString=="Hamburger")then
		if(vioGetElementData(thePlayer,"hamburger")>0)then
			if not (isTimer(vioGetElementData(thePlayer,"hitTimer"))) then
				vioSetElementData(thePlayer,"hamburger",vioGetElementData(thePlayer,"hamburger")-1)
				triggerClientEvent(thePlayer,"addFood",thePlayer,20)
				showError(thePlayer,"Du hast einen Hamburger gegessen!")				
			else
				showError(thePlayer,"Du darfst in einen Kampf nichts essen!")
			end
		else
			showError(thePlayer,"Du besitzt keine Hamburger!")				
		end
	elseif(wasString=="Fertigessen")then
		if(vioGetElementData(thePlayer,"fertigessen"))then
			if(vioGetElementData(thePlayer,"fertigessen")>0)then
				if not (isTimer(vioGetElementData(thePlayer,"hitTimer"))) then
					vioSetElementData(thePlayer,"fertigessen",vioGetElementData(thePlayer,"fertigessen")-1)
					triggerClientEvent(thePlayer,"addFood",thePlayer,50)
					showError(thePlayer,"Du hast einen Fertigessen gegessen!")				
				else
					showError(thePlayer,"Du darfst in einen Kampf nichts essen!")
				end
			else
				showError(thePlayer,"Du besitzt keine Fertigessen!")				
			end
		end
	elseif(wasString=="Schnellhilfe")then
		if(vioGetElementData(thePlayer,"schnellhilfe")>0)then
			if not (isTimer(vioGetElementData(thePlayer,"hitTimer"))) then
				vioSetElementData(thePlayer,"schnellhilfe",vioGetElementData(thePlayer,"schnellhilfe")-1)
				triggerClientEvent(thePlayer,"addFood",thePlayer,150)
				triggerClientEvent(thePlayer,"stopFoodTimerForSeconds_Event",thePlayer,1200)
				showError(thePlayer,"Du hast eine Schnellhilfe gegessen!")				
			else
				showError(thePlayer,"Du darfst in einen Kampf nichts essen!")
			end
		else
			showError(thePlayer,"Du besitzt keine Schnellhilfen!")				
		end
	
	elseif(wasString=="Lottoscheine")then
		showError(thePlayer,"Nutze /lotto [1-100] [1-100] [1-100]!")
	elseif(wasString=="TerraLappTapp")then
		showterralapptapp_func(thePlayer)
    elseif(wasString=="Würfel")then
        dice_func(thePlayer,"dice",false,false)
    elseif(wasString=="Blutteststreifen")then
        if(vioGetElementData(thePlayer,"blutmesser"))then
            vioSetElementData(thePlayer,"blutmesser",vioGetElementData(thePlayer,"blutmesser")-1)
            triggerClientEvent(thePlayer,"checkalkdrug",thePlayer)
        else
            showError(thePlayer,"Du hast keine Blutteststreifen mehr.")
        end

    else
		showError(thePlayer,"Du kannst nur folgende Dinge mir /use verwenden: Drogen,Rubbellose,Benzinkanister,Snack,Hamburger,Fertigessen,Schnellhilfe,Lottoscheine!")
	end
end
addCommandHandler("use",use_func,false,false)

function sendDiceText(thePlayer,dicetext)
	local posX, posY, posZ = getElementPosition( thePlayer )
	local chatSphere = createColSphere( posX, posY, posZ, 20 )
	local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
	destroyElement( chatSphere )
	for index, nearbyPlayer in ipairs( nearbyPlayers ) do
		outputChatBox( dicetext, nearbyPlayer,173,82,209 )
	end
end

function dice_func(thePlayer,cmd,argA,argB)
if(vioGetElementData(thePlayer,"dice"))then
	if(vioGetElementData(thePlayer,"dice")>0)then
		if not(argA) and not(argB) then
			local rand=math.random(1,6)
			local text=string.format("%s wirft einen Würfel .... und würfelt eine %s", getPlayerName(thePlayer), rand)
			sendDiceText(thePlayer,text)		
		else
			if(argA) and not(argB) then
				local seiten=tonumber(argA)
				if not(seiten)then
					seiten=6
				end
				if(seiten<2)then
					seiten=2
				end
				if(seiten>999)then
					seiten=999
				end
				local rand=math.random(1,seiten)
				local text=string.format("%s wirft einen %s seitigen Würfel .... und würfelt eine %s", getPlayerName(thePlayer), seiten, rand)
				sendDiceText(thePlayer,text)					
			else
				local seiten=tonumber(argA)
				if not(seiten)then
					seiten=6
				end
				if(seiten<2)then
					seiten=2
				end
				if(seiten>999)then
					seiten=999
				end
				local anzahl=tonumber(argB)
				if not(anzahl) then
					anzahl=1
				end
				if anzahl<1 then
					anzahl=1
				end
				if(vioGetElementData(thePlayer,"dice")<anzahl)then
					showError(thePlayer,"Du hast nicht soviele Würfel")
				else
					local zahlen={}
					for i=1,anzahl,1 do
						zahlen[i]=math.random(1,seiten)
					end	
					local zahlensumme=0
					for i=1,anzahl,1 do
						zahlensumme=zahlensumme+zahlen[i]
					end
					local zahlenstring=tostring(zahlen[1])
					if (anzahl>1)then
						for i=2,anzahl,1 do
							zahlenstring=zahlenstring..", "..zahlen[i]
						end
					end
					local text=string.format("%s wirft %s %s seitigen Würfel .... und würfelt die Zahlen: %s", getPlayerName(thePlayer), anzahl, seiten, zahlenstring)
					sendDiceText(thePlayer,text)	
					text=string.format("Die Augensumme beträgt: %s", zahlensumme)
					sendDiceText(thePlayer,text)						
				end			
			end	
		end
	else
		showError(thePlayer,"Du hast keine Würfel")
	end
end
end
addCommandHandler("dice",dice_func,false,false)
addCommandHandler("Würfel",dice_func,false,false)

function lotto_func(thePlayer,Command,numA,numB,numC)
	if(vioGetElementData(thePlayer,"lottoschein")>0)then
	if(vioGetElementData(thePlayer,"lotto")=="0|0|0")then
		if(numA) and (numB) and (numC) then
			local nuA=tonumber(numA)
			local nuB=tonumber(numB)
			local nuC=tonumber(numC)
			if(nuA and nuB and nuC)then	
				if(nuA>0 and nuA<101) and (nuB>0 and nuB<101) and (nuC>0 and nuC<101)then
					if(nuA~=nuB and nuA~=nuC and nuC~=nuB)then
						vioSetElementData(thePlayer,"lottoschein",vioGetElementData(thePlayer,"lottoschein")-1)
						vioSetElementData(thePlayer,"lotto",nuA.."|"..nuB.."|"..nuC)
						showError(thePlayer,"Du hast den Lottoschein erfolgreich abgegeben!")
						
					else
						showError(thePlayer,"Nutzung: /lotto [1-100] [1-100 [1-100]  (3 unterschiedliche)!")				
					end
				else
					showError(thePlayer,"Nutzung: /lotto [1-100] [1-100] [1-100] (Bitte angegebene Werte benutzen!)!")
				end
			else
				showError(thePlayer,"Nutzung: /lotto [1-100] [1-100] [1-100] (Es müssen Zahlen sein!)!")
			end
		else
			showError(thePlayer,"Nutzung: /lotto [1-100] [1-100] [1-100] (Bitte geben sie die 3 Zahlen ein!)!")
		end
	else
		showError(thePlayer,"Du hast bereits einen Lottoschein eingereicht!")
	end
	else
		showError(thePlayer,"Du hast besitzt keine Lottoscheine die du einreichen könntest!")
	
	end
end	
addCommandHandler("lotto",lotto_func,false,false)


function jackpot_func(thePlayer)
	outputChatBox(string.format("Der Lottojackpot liegt bei %s$", serversettings["lottojackpot"]),thePlayer)

end
addCommandHandler("jackpot",jackpot_func)


function pass_cmd(thePlayer,cmd,showplayer)
	local imBesitz={"nicht im Besitz","im Besitz"}
	if(showplayer)then
		local toPlayer=getPlayerFromIncompleteName(showplayer)
		if(toPlayer)then
			local x,y,z=getElementPosition(thePlayer)
			local px,py,pz=getElementPosition(toPlayer)
			local dis=getDistanceBetweenPoints3D(x,y,z,px,py,pz)
			if(dis<10)then
				outputChatBox(string.format("Du hast %s erfolgreich deine Pässe gezeigt!", getPlayerName(toPlayer)),thePlayer,255,0,0)
				outputChatBox(string.format("Pässe von %s: ", getPlayerName(thePlayer)),toPlayer,255,0,0)
				outputChatBox(string.format("Personalausweis: %s", imBesitz[(vioGetElementData(thePlayer,"persoLic")+1)]),toPlayer,255,0,0)
				outputChatBox(string.format("Reisepass: %s", imBesitz[(vioGetElementData(thePlayer,"reiseLic")+1)]),toPlayer,255,0,0)
					
			else
				outputChatBox("Der Spieler ist nicht in deiner Nähe!",thePlayer,255,0,0)
			end	
		else
			outputChatBox("Der Spieler existiert nicht!",thePlayer,255,0,0)
		end	
	else
		outputChatBox("Nutzung: /pass [name]",thePlayer,255,0,0)
	end
end
addCommandHandler("pass",pass_cmd,false,false)








