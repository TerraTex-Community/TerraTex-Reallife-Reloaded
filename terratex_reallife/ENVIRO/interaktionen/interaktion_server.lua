function useCommandFromClient_func(command,arguments)
	if source ~= client then return end
	executeCommandHandler(command, source, tostring(arguments))
end
addEvent("executeServerCommandHandler",true)
addEventHandler("executeServerCommandHandler",getRootElement(),useCommandFromClient_func)

function getZoneForClientGui_func(slotid,row)
	local vehele=vioGetElementData(source,"slot"..slotid)
	local zonename="unbekannt"
	if(isElement(vehele))then
		zonename=getElementZoneName(vehele)
	end
	triggerClientEvent(source,"setZoneNameForGui",source,row,zonename)
end
addEvent("getZoneForClientGui",true)
addEventHandler("getZoneForClientGui",getRootElement(),getZoneForClientGui_func)

function give_func(thePlayer,Command,toPlayerName,wasstring,menge)
	if(toPlayerName)then
		local toPlayer=getPlayerFromIncompleteName(toPlayerName)
		if(toPlayer)then
			local x,y,z=getElementPosition(toPlayer)
			local xx,yy,zz=getElementPosition(thePlayer)
			local dis=getDistanceBetweenPoints3D(x,y,z,xx,yy,zz)
			if(dis<10)then
			if(menge)and tonumber(menge)then
				if(tonumber(menge)<0)then
					outputChatBox(string.format("BUGUSER!: %s", getPlayerName(thePlayer)))
					 save_log( "buguser", "givebug by "..getPlayerName(thePlayer))
					
					
					kickPlayer(thePlayer,"BUGUSER!")					
					return 0
				end
				if(wasstring)then
					if(wasstring=="Drogen")then	
						local mengen=tonumber(menge)	
						local besdro=vioGetElementData(thePlayer,"drogen")
						if(besdro<mengen)then
							showError(thePlayer,"Du hast nicht soviel Drogen!")
						else
							if (vioGetElementData(toPlayer,"drogen")+mengen)>500 then
								mengen= 500-vioGetElementData(toPlayer,"drogen")
							end
							vioSetElementData(thePlayer,"drogen",besdro-mengen)
							vioSetElementData(toPlayer,"drogen",vioGetElementData(toPlayer,"drogen")+mengen)
							showError(thePlayer,string.format("Du hast %s %s Gramm Drogen gegeben!", getPlayerName(toPlayer), mengen))
							showError(toPlayer,string.format("Du hast von %s %s Gramm bekommen!", getPlayerName(thePlayer), mengen))
							local posX, posY, posZ = getElementPosition( thePlayer )
							local chatSphere = createColSphere( posX, posY, posZ, 10 )
							local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
							destroyElement( chatSphere )
							local pname=getPlayerName(thePlayer)
							for index, nearbyPlayer in ipairs( nearbyPlayers ) do
								outputChatBox(string.format("%s hat eine Tüte mit weißen Pulver in %ss Tasche gesteckt!", pname, getPlayerName(toPlayer)), nearbyPlayer,255,255,200 )
							end
						end
					elseif(wasstring=="Materials")then
						local mengen=tonumber(menge)	
						local besdro=vioGetElementData(thePlayer,"mats")
						if(besdro<mengen)then
							showError(thePlayer,"Du hast nicht soviel Materials!")
						else
							vioSetElementData(thePlayer,"mats",besdro-mengen)
							vioSetElementData(toPlayer,"mats",vioGetElementData(toPlayer,"mats")+mengen)
							showError(thePlayer,string.format("Du hast %s %s Materials gegeben!", getPlayerName(toPlayer), mengen))
							showError(toPlayer,string.format("Du hast von %s %s Materials!", getPlayerName(thePlayer), mengen))
							local posX, posY, posZ = getElementPosition( thePlayer )
							local chatSphere = createColSphere( posX, posY, posZ, 10 )
							local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
							destroyElement( chatSphere )
							local pname=getPlayerName(thePlayer)
							for index, nearbyPlayer in ipairs( nearbyPlayers ) do
								outputChatBox( string.format("%s hat einen schwarzen klirrenden Beutel in %ss Tasche gesteckt!", pname, getPlayerName(toPlayer)), nearbyPlayer,255,255,200 )
							end
						end
					elseif(wasstring=="Snack")then
						local mengen=tonumber(menge)	
						local besdro=vioGetElementData(thePlayer,"snack")
						if(besdro<mengen)then
							showError(thePlayer,"Du hast nicht soviel Snacks!")
						else
							vioSetElementData(thePlayer,"snack",besdro-mengen)
							vioSetElementData(toPlayer,"snack",vioGetElementData(toPlayer,"snack")+mengen)
							showError(thePlayer,string.format("Du hast %s %s Snacks gegeben!", getPlayerName(toPlayer), mengen))
							showError(toPlayer,string.format("Du hast von %s %s Snacks!", getPlayerName(thePlayer), mengen))
						end					
					elseif(wasstring=="Hamburger")then
						local mengen=tonumber(menge)	
						local besdro=vioGetElementData(thePlayer,"hamburger")
						if(besdro<mengen)then
							showError(thePlayer,"Du hast nicht soviel Hamburger!")
						else
							vioSetElementData(thePlayer,"hamburger",besdro-mengen)
							vioSetElementData(toPlayer,"hamburger",vioGetElementData(toPlayer,"hamburger")+mengen)
							showError(thePlayer,string.format("Du hast %s %s Hamburger gegeben!", getPlayerName(toPlayer), mengen))
							showError(toPlayer,string.format("Du hast von %s %s Hamburger!", getPlayerName(thePlayer), mengen))
						end
					elseif(wasstring=="Fertigessen")then
						local mengen=tonumber(menge)	
						local besdro=vioGetElementData(thePlayer,"fertigessen")
						if(besdro<mengen)then
							showError(thePlayer,"Du hast nicht soviel Fertigessen!")
						else
							vioSetElementData(thePlayer,"fertigessen",besdro-mengen)
							vioSetElementData(toPlayer,"fertigessen",vioGetElementData(toPlayer,"fertigessen")+mengen)
							showError(thePlayer,string.format("Du hast %s %s Fertigessen gegeben!", getPlayerName(toPlayer), mengen))
							showError(toPlayer,string.format("Du hast von %s %s Fertigessen!", getPlayerName(thePlayer), mengen))
						end
					elseif(wasstring=="Schnellhilfe")then
						local mengen=tonumber(menge)	
						local besdro=vioGetElementData(thePlayer,"schnellhilfe")
						if(besdro<mengen)then
							showError(thePlayer,"Du hast nicht soviel Schnellhilfe!")
						else
							vioSetElementData(thePlayer,"schnellhilfe",besdro-mengen)
							vioSetElementData(toPlayer,"schnellhilfe",vioGetElementData(toPlayer,"schnellhilfe")+mengen)
							showError(thePlayer,string.format("Du hast %s %s Schnellhilfe gegeben!", getPlayerName(toPlayer), mengen))
							showError(toPlayer,string.format("Du hast von %s %s Schnellhilfe!", getPlayerName(thePlayer), mengen))
						end
					elseif(wasstring=="Benzinkanister")then
						local mengen=tonumber(menge)	
						local besdro=vioGetElementData(thePlayer,"kanister")
						if(besdro<mengen)then
							showError(thePlayer,"Du hast nicht soviel Benzinkanister!")
						else
							vioSetElementData(thePlayer,"kanister",besdro-mengen)
							vioSetElementData(toPlayer,"kanister",vioGetElementData(toPlayer,"kanister")+mengen)
							showError(thePlayer,string.format("Du hast %s %s Benzinkanister gegeben!", getPlayerName(toPlayer), mengen))
							showError(toPlayer,string.format("Du hast von %s %s Benzinkanister!", getPlayerName(thePlayer), mengen))
						end
					elseif(wasstring=="Carfinder")then
						showError(thePlayer,"Benutze den CarFinder mit dem befehl /carfind [SlotID]!")
					
					else
						showError(thePlayer,"Ungueltige Auswahl/ Ungueltige Eingabe darueber was gegeben werden soll!")
					end
				else
					showError(thePlayer,"Ungueltige Auswahl/ Ungueltige Eingabe darueber was gegeben werden soll!")
				end
			else
				showError(thePlayer,"Ungueltige Mengenangabe")
			end
			end
		end
	end
end
addCommandHandler("give",give_func,false,false)








