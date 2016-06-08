local innendienstpickup=false
function createInnenDienstPickup()
	innendienstpickup=createPickup(246.5556640625,125.7724609375,1003.21875,3,1239,5000)
	setElementInterior(innendienstpickup,10)
	local anderes=createPickup(229.6025390625,167.876953125,1003.0234375,3,1239,5000)
	setElementInterior(anderes,3)
	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createInnenDienstPickup)

function sendInnenDienstInfo(thePlayer)
	if(innendienstpickup==source)then
		if(isBeamter(thePlayer))then
			outputChatBox("Innendienst: '/id an' zum anmelden und '/id ab' zum abmelden!",thePlayer,255,0,0)
		end
	end
end
addEventHandler("onPickupHit",getRootElement(),sendInnenDienstInfo)


function checkInnenDienst_func()
	setTimer(checkInnenDienst_func,600000,1)
	local isInInnenDienst=0
	local howManyBeamte=0
	for theKey,thePlayer in ipairs(getElementsByType("player"))do
		if(vioGetElementData(thePlayer,"Innendienst"))then
			isInInnenDienst=isInInnenDienst+1
		end	
		if(vioGetElementData(thePlayer,"fraktion")==1 or vioGetElementData(thePlayer,"fraktion")==9)then
			howManyBeamte=howManyBeamte+1
		end
	end
	local timer=getRealTime()
	local innendienstlogname=string.format("LOGS/screens/policeControl/%s_%s_%s/innendienst.log", timer.monthday, (timer.month+1), (timer.year+1900))
	local filehandler
	if not(fileExists ( innendienstlogname ))then
		filehandler=fileCreate ( innendienstlogname)
		fileClose ( filehandler)	
	end	
	filetext=""	
	if(timer.hour>8 and timer.hour<23)then
		if(howManyBeamte>2)then
			if(isInInnenDienst>0)then
				filetext=string.format("[%s:%s] STATUS OK", timer.hour, timer.minute)
			else
--					local message="!!!INNENDIENST!!!: ES IST NIEMAND IM INNENDIENST, DER POSTEN MUSS BESETZT WERDEN!!!INNENDIENST!!!"
--					for theKey,thePlayers in ipairs(getPlayersInTeam(team[1])) do
--							outputChatBox( message,thePlayers,255,0,0)
--							outputChatBox( message,thePlayers,255,0,0)
--					end
--					for theKey,thePlayers in ipairs(getPlayersInTeam(team[5])) do
--							outputChatBox( message,thePlayers,255,0,0)
--							outputChatBox( message,thePlayers,255,0,0)
--					end
--					for theKey,thePlayers in ipairs(getPlayersInTeam(team[7])) do
--							outputChatBox( message,thePlayers,255,0,0)
--							outputChatBox( message,thePlayers,255,0,0)
--					end
--					for theKey,thePlayers in ipairs(getPlayersInTeam(team[9])) do
--							outputChatBox( message,thePlayers,255,0,0)
--							outputChatBox( message,thePlayers,255,0,0)
--					end
					filetext=string.format("[%s:%s] NO INNENDIENST NOT OK!", timer.hour, timer.minute)
			end		
		else		
			filetext=string.format("[%s:%s] NOT ENOUGH COPS!", timer.hour, timer.minute)
		end
		-- filehandler=fileOpen ( innendienstlogname )
		-- if(filehandler) then	
			-- local fileSize=fileGetSize(filehandler)
			-- fileSetPos ( filehandler, fileSize )
			-- local messages="\n"..filetext
			-- fileWrite(filehandler,messages)
			-- fileClose ( filehandler)	
		-- end
	end
	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),checkInnenDienst_func)

addEventHandler( "onPlayerScreenShot", getRootElement(),
    function ( theResource, status, pixels, timestamp, tag )
		if(status=="ok")then
			local timer=getRealTime()
			local stringParts=getStringComponents(tag)
			if(stringParts[1])then
				if(stringParts[1]=="policeControl")then
					-- local fileHandle = fileCreate("files/screens/policeControl/"..timer.monthday.."_"..(1+timer.month).."_"..(timer.year+1900).."/"..stringParts[2].."/"..(timer.hour).."_"..timer.minute..".jpg")             -- attempt to create a new file
					-- if fileHandle then                                    -- check if the creation succeeded
						-- fileWrite(fileHandle, pixels)     -- write a text line
						-- fileClose(fileHandle)                             -- close the file once you're done with it
					-- end
				end
			end
			
		end	
    end
)

function disconnect_innendienst()
	if(vioGetElementData(source,"Innendienst"))then
		local message=string.format("!!!INNENDIENST!!! %s hat sich im Innendienst abgemeldet (disconnect)!!!INNENDIENST!!!", getPlayerName(source))
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[1])) do
								outputChatBox( message,thePlayers,255,0,0)
						end	
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[5])) do
								outputChatBox( message,thePlayers,255,0,0)
						end	
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[7])) do
								outputChatBox( message,thePlayers,255,0,0)
						end
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[9])) do
								outputChatBox( message,thePlayers,255,0,0)
						end		
						-- filetext="["..timer.hour..":"..timer.minute.."] "..getPlayerName(source).." meldet sich vom Innendienst ab (disconnect)!"
						-- filehandler=fileOpen ( innendienstlogname )
						-- if(filehandler) then	
							-- local fileSize=fileGetSize(filehandler)
							-- fileSetPos ( filehandler, fileSize )
							-- local messages="\n"..filetext
							-- fileWrite(filehandler,messages)
							-- fileClose ( filehandler)	
						-- end
	end
end
addEventHandler("onPlayerQuit",getRootElement(),disconnect_innendienst)

function ScreenMrAndMsInnenDienst()
	setTimer(ScreenMrAndMsInnenDienst,60000,1)
	for theKey,thePlayer in ipairs(getElementsByType("player"))do
		if(vioGetElementData(thePlayer,"Innendienst"))then	
			local x,y,z=getElementPosition(thePlayer)
			local int=getElementInterior(thePlayer)
			if(getDistanceBetweenPoints3D(1568.6015625,-1690.0556640625,6.21875,x,y,z)>200 and int==0)then
				vioSetElementData(thePlayer,"Innendienst",false)
				local message=string.format("!!!INNENDIENST!!! %s hat sich im Innendienst abgemeldet (Entfernung zum LSPD)!!!INNENDIENST!!!", getPlayerName(thePlayer))
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[1])) do
								outputChatBox( message,thePlayers,255,0,0)
						end	
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[5])) do
								outputChatBox( message,thePlayers,255,0,0)
						end	
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[7])) do
								outputChatBox( message,thePlayers,255,0,0)
						end
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[9])) do
								outputChatBox( message,thePlayers,255,0,0)
						end	
						-- timer=getRealTime()
						-- filetext="["..timer.hour..":"..timer.minute.."] "..getPlayerName(thePlayer).." meldet sich vom Innendienst ab (Entfernung zum LSPD)!"
						-- filehandler=fileOpen ( innendienstlogname )
						-- if(filehandler) then	
							-- local fileSize=fileGetSize(filehandler)
							-- fileSetPos ( filehandler, fileSize )
							-- local messages="\n"..filetext
							-- fileWrite(filehandler,messages)
							-- fileClose ( filehandler)	
						-- end
			else
				takePlayerScreenShot( thePlayer, 1024,768, "policeControl|"..getPlayerName(thePlayer) )
			end
		end	
	end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),ScreenMrAndMsInnenDienst)

function innendienst_func(thePlayer,cmd,status)
	local timer=getRealTime()
	local innendienstlogname=string.format("LOGS/screens/policeControl/%s_%s_%s/innendienst.log", timer.monthday, (timer.month+1), (timer.year+1900))
	local filehandler
	if not(fileExists ( innendienstlogname ))then
		filehandler=fileCreate ( innendienstlogname)
		fileClose ( filehandler)	
	end	
	filetext=""	
	if(isBeamter(thePlayer))then
		local x,y,z=getElementPosition(thePlayer)
		if(getDistanceBetweenPoints3D(x,y,z,246.5556640625,125.7724609375,1003.21875)<20)then
			if(status=="an")then
				if(vioGetElementData(thePlayer,"Innendienst"))then
					outputChatBox("Du bist bereits im Innendienst!",thePlayer,255,0,0)
				else
					vioSetElementData(thePlayer,"Innendienst",true)
					local message=string.format("!!!INNENDIENST!!! %s hat sich im Innendienst angemeldet!!!INNENDIENST!!!", getPlayerName(thePlayer))
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[1])) do
								outputChatBox( message,thePlayers,255,0,0)
						end	
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[5])) do
								outputChatBox( message,thePlayers,255,0,0)
						end	
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[7])) do
								outputChatBox( message,thePlayers,255,0,0)
						end
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[9])) do
								outputChatBox( message,thePlayers,255,0,0)
						end	
						-- filetext="["..timer.hour..":"..timer.minute.."] "..getPlayerName(thePlayer).." meldet sich zum Innendienst!"
						-- filehandler=fileOpen ( innendienstlogname )
						-- if(filehandler) then	
							-- local fileSize=fileGetSize(filehandler)
							-- fileSetPos ( filehandler, fileSize )
							-- local messages="\n"..filetext
							-- fileWrite(filehandler,messages)
							-- fileClose ( filehandler)	
						-- end
				end			
			else
				if not(vioGetElementData(thePlayer,"Innendienst"))then
					outputChatBox("Du bist nicht im Innendienst!",thePlayer,255,0,0)
				else
					vioSetElementData(thePlayer,"Innendienst",false)
					local message=string.format("!!!INNENDIENST!!! %s hat sich im Innendienst abgemeldet!!!INNENDIENST!!!", getPlayerName(thePlayer))
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[1])) do
								outputChatBox( message,thePlayers,255,0,0)
						end	
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[5])) do
								outputChatBox( message,thePlayers,255,0,0)
						end	
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[7])) do
								outputChatBox( message,thePlayers,255,0,0)
						end
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[9])) do
								outputChatBox( message,thePlayers,255,0,0)
						end		
						-- filetext="["..timer.hour..":"..timer.minute.."] "..getPlayerName(thePlayer).." meldet sich vom Innendienst ab!"
						-- filehandler=fileOpen ( innendienstlogname )
						-- if(filehandler) then	
							-- local fileSize=fileGetSize(filehandler)
							-- fileSetPos ( filehandler, fileSize )
							-- local messages="\n"..filetext
							-- fileWrite(filehandler,messages)
							-- fileClose ( filehandler)	
						-- end
				end	
			end
		end
	end
end
addCommandHandler("id",innendienst_func,false,false)









