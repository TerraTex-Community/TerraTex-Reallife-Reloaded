function send_anonym_message(thePlayer,cmd,an,text,...)
	if(vioGetElementData(thePlayer,"fraktion")==8 or vioGetElementData(thePlayer,"fraktionsrang")>4)then
		if(an)and(text)then
			if(string.lower(an)=="news")then
				for theKey,theNewsReporter in ipairs(getPlayersInTeam(team[3])) do
					outputChatBox(string.format("NewsService SMS von einer Anonymen Person: %s %s", text, table.concat({...}," ")),theNewsReporter,0,255,0)
				end
				outputChatBox("Deine Anonyme Nachricht wurde gesendet!",thePlayer)
				save_log( "anonym", getPlayerName(thePlayer)..": "..text.." "..table.concat({...}," ").."\n")
			elseif(string.lower(an)=="cops")then
				outputChatBoxForPolice(string.format("Ein Anonymer Tipp: %s %s", text, table.concat({...}," ")))
				save_log( "anonym", getPlayerName(thePlayer)..": "..text.." "..table.concat({...}," ").."\n")
				outputChatBox("Deine Anonyme Nachricht wurde gesendet!",thePlayer)
			else
				outputChatBox("Nutzung: /anonym [NEWS/COPS] [Text]",thePlayer)
			end
		else
			outputChatBox("Nutzung: /anonym [NEWS/COPS] [Text]",thePlayer)
		end	
	end
end
addCommandHandler("anonym",send_anonym_message,false,false)

-- define our chat radius
local chatRadius = 20 --units
 
-- define a handler that will distribute the message to all nearby players
function sendMessageToNearbyPlayers( message, messageType )
	if(vioGetElementData(source,"Auskunft"))then
		local name=message
		local player=getPlayerFromIncompleteName(name)
		if(player)then
			if(vioGetElementData(player,"telefon"))then
				outputChatBox(string.format("Die Telefonnummer des Spielers lautet %s!", vioGetElementData(player,"telefon")),source,255,255,0)
				vioSetElementData(source,"Auskunft",false)
			else
				outputChatBox("Der Spieler ist nicht richtig mit dem Server verbunden, versuche es später erneut!",source,255,255,0)
			end
		else
			outputChatBox("Tut mir leid, diese Person existiert nicht!",source,255,255,0)
			vioSetElementData(source,"Auskunft",false)
		end
	else
		-- we will only send normal chat messages, action and team types will be ignored
		if messageType == 0 then
			if(vioGetElementData(source,"telestatus")==1)then
				local callwithele=vioGetElementData(source,"callwith")
				local name=getPlayerName(source)
				outputChatBox(string.format("Handy %s: %s", name, message),callwithele,255,255,0)
				chat_log(source,"(Handy) "..message)
				
				
				-- get the chatting player's position
				local posX, posY, posZ = getElementPosition( source )
		 
				-- create a sphere of the specified radius in that position
				local chatSphere = createColSphere( posX, posY, posZ, chatRadius )
				-- get a table all player elements inside it
				local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
				-- and destroy the sphere, since we're done with it
				destroyElement( chatSphere )
				local pname=getPlayerName(source)
				-- deliver the message to each player in that table
				for index, nearbyPlayer in ipairs( nearbyPlayers ) do
					outputChatBox( string.format("%s (am Handy): %s", pname, message), nearbyPlayer,255,255,255 )
				end
				if(spactater[source])then
					for theKey,theAdmin in ipairs(spactater[source])do
						if(isElement(theAdmin))then
							outputChatBox(string.format("SPEC(Tele) %s: %s", getPlayerName(source), message),theAdmin,255,255,0)
						end
					end
				end
				if(spactater[callwithele])then
					for theKey,theAdmin in ipairs(spactater[callwithele])do
						if(isElement(theAdmin))then
							outputChatBox(string.format("SPEC(Tele) %s to %s: %s", getPlayerName(source), getPlayerName(callwithele), message),theAdmin,255,255,0)
						end
					end
				end
			
			else
			
				if(vioGetElementData(source,"isInNewsLive"))then
					outputChatBox(string.format("Live Gast %s: %s", getPlayerName(source), message),getRootElement(),255,150,150)		
					chat_log(source,"(live) "..message)
				elseif(source==liveLeader) then
					outputChatBox(string.format("Live Newsreporter %s: %s", getPlayerName(source), message),getRootElement(),255,150,150)	
					chat_log(source,"(live) "..message)
				else
				
					local posX, posY, posZ = getElementPosition( source )
			 
					-- create a sphere of the specified radius in that position
					local chatSphere = createColSphere( posX, posY, posZ, chatRadius )
					-- get a table all player elements inside it
					local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
					-- and destroy the sphere, since we're done with it
					destroyElement( chatSphere )
					local pname=getPlayerName(source)
					chat_log(source,message)
					-- deliver the message to each player in that table
					for index, nearbyPlayer in ipairs( nearbyPlayers ) do
						outputChatBox( pname..": "..message, nearbyPlayer,255,255,255 )
						if(spactater[nearbyPlayer])then
							for theKey,theAdmin in ipairs(spactater[nearbyPlayer])do
								if(isElement(theAdmin))then
									outputChatBox(string.format("SPEC(umgebung von %s) %s: %s", getPlayerName(nearbyPlayer), getPlayerName(source), message),theAdmin,255,255,0)
								end
							end
						end
					end
				end
			end
		end
		
		if messageType == 1 then
			-- get the chatting player's position
			local posX, posY, posZ = getElementPosition( source )
	 
			-- create a sphere of the specified radius in that position
			local chatSphere = createColSphere( posX, posY, posZ, chatRadius )
			-- get a table all player elements inside it
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			-- and destroy the sphere, since we're done with it
			destroyElement( chatSphere )
			local pname=getPlayerName(source)
			chat_log(source,"(me) "..message)
			-- deliver the message to each player in that table
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
				outputChatBox( string.format("     * %s %s", pname, message), nearbyPlayer,173,82,209)
				if(spactater[nearbyPlayer])then
					for theKey,theAdmin in ipairs(spactater[nearbyPlayer])do
						if(isElement(theAdmin))then
							outputChatBox(string.format("SPEC(/me-umgebung von %s) %s: %s", getPlayerName(nearbyPlayer), getPlayerName(source), message),theAdmin,255,255,0)
						end
					end
				end
			end
			
		end
		if messageType == 2 then
			local pname=getPlayerName(source)
			chat_log(source,"(fraktion "..vioGetElementData(source,"fraktion")..") "..message)
			if(vioGetElementData(source,"fraktion")>0)then
				for index, nearbyPlayer in ipairs( getPlayersInTeam(team[vioGetElementData(source,"fraktion")]) ) do

					outputChatBox( string.format("%s %s: %s", fraktionsrange[vioGetElementData(source,"fraktion")][vioGetElementData(source,"fraktionsrang")], pname, message),nearbyPlayer,0,255,255)
					if(spactater[nearbyPlayer])then
						for theKey,theAdmin in ipairs(spactater[nearbyPlayer])do
							if(isElement(theAdmin))then
								outputChatBox(string.format("SPEC(Fraktion von %s) %s: %s", getPlayerName(nearbyPlayer), getPlayerName(source), message),theAdmin,255,255,0)
							end
						end
					end
				end
			end
		end
	end
	
end
-- attach our new chat handler to onPlayerChat
addEventHandler( "onPlayerChat", getRootElement(), sendMessageToNearbyPlayers )


function send_schreien(thePlayer,command,...)
	local message=table.concat({...}," ")
	local posX, posY, posZ = getElementPosition( thePlayer )
			 
	-- create a sphere of the specified radius in that position
	local chatSphere = createColSphere( posX, posY, posZ, chatRadius*2 )
	-- get a table all player elements inside it
	local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
	-- and destroy the sphere, since we're done with it
	destroyElement( chatSphere )
	local pname=getPlayerName(thePlayer)
	chat_log(thePlayer,"(schreien) "..message)
	-- deliver the message to each player in that table
	for index, nearbyPlayer in ipairs( nearbyPlayers ) do
		outputChatBox( pname.." schreit: "..message, nearbyPlayer,255,255,255 )
		if(spactater[nearbyPlayer])then
			for theKey,theAdmin in ipairs(spactater[nearbyPlayer])do
				if(isElement(theAdmin))then
					outputChatBox(string.format("SPEC(/s-umgebung von %s) %s: %s", getPlayerName(nearbyPlayer), getPlayerName(thePlayer), message),theAdmin,255,255,0)
				end
			end
		end
	end
end
addCommandHandler("s",send_schreien,false,false)

function fluestern_schreien(thePlayer,command,...)
	local message=table.concat({...}," ")
	local posX, posY, posZ = getElementPosition( thePlayer )
			 
	-- create a sphere of the specified radius in that position
	local chatSphere = createColSphere( posX, posY, posZ, chatRadius/4 )
	-- get a table all player elements inside it
	local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
	-- and destroy the sphere, since we're done with it
	destroyElement( chatSphere )
	local pname=getPlayerName(thePlayer)
	
	chat_log(thePlayer,"(fluestern) "..message)
	-- deliver the message to each player in that table
	for index, nearbyPlayer in ipairs( nearbyPlayers ) do
		outputChatBox( string.format("%s flüstert: %s", pname, message), nearbyPlayer,255,255,255 )
		if(spactater[nearbyPlayer])then
			for theKey,theAdmin in ipairs(spactater[nearbyPlayer])do
				if(isElement(theAdmin))then
					outputChatBox(string.format("SPEC(/f-umgebung von %s) %s: %s", getPlayerName(nearbyPlayer), getPlayerName(thePlayer), message),theAdmin,255,255,0)
				end
			end
		end
	end
end
addCommandHandler("f",fluestern_schreien,false,false)

function car_chat(thePlayer,command,...)
	local message=table.concat({...}," ")
	local pname=getPlayerName(thePlayer)
	chat_log(thePlayer,"(Carchat) "..message)
	if(isPedInVehicle ( thePlayer))then
		for theKey,thePerson in pairs (getVehicleOccupants ( getPedOccupiedVehicle(thePlayer) )) do
			outputChatBox( string.format("%s (Carchat): %s", pname, message), thePerson,255,255,255 )
			if(spactater[thePerson])then
				for theKey,theAdmin in ipairs(spactater[thePerson])do
					if(isElement(theAdmin))then
						outputChatBox(string.format("SPEC(/s-umgebung von %s) %s: %s", getPlayerName(thePerson), getPlayerName(thePlayer), message),theAdmin,255,255,0)
					end
				end
			end
		end
	end	
end
addCommandHandler("c",car_chat)

-- define another handler function that cancels the event so that the message won't be delivered through the 
function blockChatMessage()
    cancelEvent()
end
-- attach it as a handler to onPlayerChat
addEventHandler( "onPlayerChat", getRootElement(), blockChatMessage )

function t_func(source,command,...)
	if(vioGetElementData(source,"fraktion"))then
		if(vioGetElementData(source,"fraktion")>0)then
			local message=table.concat({...} ," ")
			local pname=getPlayerName(source)

			chat_log(source,"(fraktion "..vioGetElementData(source,"fraktion")..") "..message)
			for index, nearbyPlayer in ipairs( getPlayersInTeam(team[vioGetElementData(source,"fraktion")]) ) do
				if(isElement(theAdmin))then
					outputChatBox( fraktionsrange[vioGetElementData(source,"fraktion")][vioGetElementData(source,"fraktionsrang")].." "..pname..": "..message,nearbyPlayer,0,255,255)
				end
			end

		end
	end
end
addCommandHandler("t",t_func,false,false)

function flug_chat(thePlayer,cmd,text,...)
	if(isPedInVehicle(thePlayer))then
		local veh=getPedOccupiedVehicle(thePlayer)
		if((isPlane(veh) or isHeli(veh)) and (getPedOccupiedVehicleSeat(thePlayer)==0))then
			if(text)then
				text=text.." "..table.concat({...}," ")
				chat_log(thePlayer,"(flugchat) "..text)
				for theKey, thePerson in ipairs(getElementsByType("player")) do
					if(isPedInVehicle(thePerson))then
					local veh=getPedOccupiedVehicle(thePerson)
						if((isPlane(veh) or isHeli(veh)) and (getPedOccupiedVehicleSeat(thePerson)==0))then						
							outputChatBox(string.format("Flugchat (/fc) %s: %s", getPlayerName(thePlayer), text),thePerson,244,0,252)	
						end
					end
				end			
			end
		end	
	end
end	
addCommandHandler("fc",flug_chat,false,false)










