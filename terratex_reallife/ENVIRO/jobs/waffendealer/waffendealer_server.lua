local wdealerPed=false
function createWeaponBots_Server()
	wdealerPed=createPed(166,  308.4365234375,-143.0947265625,999.6015625,8.0228881835938 )
	setElementInterior(wdealerPed,7)	
	setElementPosition(wdealerPed,308.4365234375,-143.0947265625,999.6015625)
	setPedRotation(wdealerPed,8.0228881835938 )
	addEventHandler("onPedWasted",wdealerPed,respawnWeaponBot_Server)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createWeaponBots_Server)

function respawnWeaponBot_Server()
	destroyElement(wdealerPed)
	wdealerPed=createPed(166, 308.4365234375,-143.0947265625,999.6015625,8.0228881835938 )	
	setElementInterior(wdealerPed,7)	
	setElementPosition(wdealerPed,308.4365234375,-143.0947265625,999.6015625)
	setPedRotation(wdealerPed,8.0228881835938 )
	addEventHandler("onPedWasted",wdealerPed,respawnWeaponBot_Server)
end

function clickonwdealer(mouseButton, buttonState, clickedElement)
	--outputChatBox("test")
	if(clickedElement==wdealerPed)and(vioGetElementData(source,"job")==10) then
		triggerClientEvent(source,"openWeaponGui",source,math.round(serversettings["matspreis"],2))
	end
end
addEventHandler("onPlayerClick",getRootElement(),clickonwdealer)

function reduceWeaponPreis(timeshift)
		if(serversettings["matspreis"]>1)then
			serversettings["matspreis"]=serversettings["matspreis"]-0.15
		end
		if(serversettings["matspreis"]>5)then
			serversettings["matspreis"]=5
		end
	setTimer(reduceWeaponPreis,1800000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),reduceWeaponPreis)

addEvent("buyWaffenDealer_Event",true)
function buyWaffenDealer_func(anzahl)
	if(anzahl<0)then anzahl=-anzahl end
	local price=anzahl*serversettings["matspreis"]
	if(getPlayerMoney(source)<price)then
		showError(source,"Sie haben nicht genug Geld!")
    else
        changePlayerMoney(source,-price,"job","Waffendealer","Materials gekauft")
		vioSetElementData(source,"mats",vioGetElementData(source,"mats")+anzahl)
		frakkasse[6]=frakkasse[6]+price/2
		frakkasse[11]=frakkasse[11]+price/2
		serversettings["matspreis"]=math.round(serversettings["matspreis"]+anzahl*0.023,2)
		showError(source, string.format("Du hast %s Materialien gekauft! Waffen verkaufen mit /sellweapon Name ID Munianzahl!", anzahl))
		for theKey,thePlayer in ipairs(getPlayersInTeam(team[6])) do
			outputChatBox("Hauptwaffenkurier: Jemand hat Waffenmaterialien gekauft!",thePlayer,255,0,0)
		end
	end
end
addEventHandler("buyWaffenDealer_Event",getRootElement(),buyWaffenDealer_func)

function sellWeapon_func(thePlayer,cmd,toNamePart,weaponID,Munianzahl)
	if(vioGetElementData(thePlayer,"job")==10)then
		if(toNamePart)and(weaponID)and(Munianzahl)then
			local toPlayer=getPlayerFromIncompleteName(toNamePart)
			local id=tonumber(weaponID)
			local mun=tonumber(Munianzahl)
			if(toPlayer) and (id) and (mun) then
				local x,y,z=getElementPosition(thePlayer)
				local x2,y2,z2=getElementPosition(toPlayer)
				if(getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)<20)then
					if(mun<0)then
						outputChatBox(string.format("BUGUSER!: %s", getPlayerName(thePlayer)))
						save_log( "buguser", "weapondealerbug by "..getPlayerName(thePlayer))
						kickPlayer(thePlayer, "BUGUSER!")
					end
					if(id==1)then
						if(vioGetElementData(thePlayer,"mats")<6)then
							outputChatBox("Du hast nicht genügend Materialien!",thePlayer,255,0,0)
						else
							giveWeapon ( toPlayer, 4 , 30, true )
							vioSetElementData(thePlayer,"mats",vioGetElementData(thePlayer,"mats")-6)
							outputChatBox(string.format("Du hast %s ein Messer gegeben!", getPlayerName(toPlayer)),thePlayer,255,0,0)
							outputChatBox(string.format("%s hat dir ein Messer gegeben!", getPlayerName(thePlayer)),toPlayer,255,0,0)
						end
					elseif(id==2)then
						if(vioGetElementData(thePlayer,"mats")<15+3*Munianzahl)then
							outputChatBox("Du hast nicht genügend Materialien!",thePlayer,255,0,0)
						else
							giveWeapon ( toPlayer, 22 , Munianzahl, true )
							vioSetElementData(thePlayer,"mats",vioGetElementData(thePlayer,"mats")-15-3*Munianzahl)
							outputChatBox(string.format("Du hast %s eine 9mm mit %s Schuss gegeben!", getPlayerName(toPlayer), Munianzahl),thePlayer,255,0,0)
							outputChatBox(string.format("%s hat dir eine 9mm mit %s Schuss gegeben!", getPlayerName(thePlayer), Munianzahl),toPlayer,255,0,0)
						end
					elseif(id==3)then
						if(vioGetElementData(thePlayer,"mats")<30+3*Munianzahl)then
							outputChatBox("Du hast nicht genügend Materialien!",thePlayer,255,0,0)
						else
							giveWeapon ( toPlayer, 23 , Munianzahl, true )
							vioSetElementData(thePlayer,"mats",vioGetElementData(thePlayer,"mats")-30-3*Munianzahl)
							outputChatBox(string.format("Du hast %s eine schallgedämpfte 9mm mit %s Schuss gegeben!", getPlayerName(toPlayer), Munianzahl),thePlayer,255,0,0)
							outputChatBox(string.format("%s hat dir eine schallgedämpfte 9mm mit %s Schuss gegeben!", getPlayerName(thePlayer), Munianzahl),toPlayer,255,0,0)
						end
					elseif(id==4)then
						if(vioGetElementData(thePlayer,"mats")<150+3*Munianzahl)then
							outputChatBox("Du hast nicht genügend Materialien!",thePlayer,255,0,0)
						else
							giveWeapon ( toPlayer, 24 , Munianzahl, true )
							vioSetElementData(thePlayer,"mats",vioGetElementData(thePlayer,"mats")-150-3*Munianzahl)
							outputChatBox(string.format("Du hast %s eine Deagle mit %s Schuss gegeben!", getPlayerName(toPlayer), Munianzahl),thePlayer,255,0,0)
							outputChatBox(string.format("%s hat dir eine Deagle mit %s Schuss gegeben!", getPlayerName(thePlayer), Munianzahl),toPlayer,255,0,0)
						end			
					elseif(id==5)then
						if(vioGetElementData(thePlayer,"mats")<60+3*Munianzahl)then
							outputChatBox("Du hast nicht genügend Materialien!",thePlayer,255,0,0)
						else
							giveWeapon ( toPlayer, 25 , Munianzahl, true )
							vioSetElementData(thePlayer,"mats",vioGetElementData(thePlayer,"mats")-60-3*Munianzahl)
							outputChatBox(string.format("Du hast %s eine Shotgun mit %s Schuss gegeben!", getPlayerName(toPlayer), Munianzahl),thePlayer,255,0,0)
							outputChatBox(string.format("%s hat dir eine Shotgun mit %s Schuss gegeben!", getPlayerName(thePlayer), Munianzahl),toPlayer,255,0,0)
						end	
					elseif(id==6)then
						if(vioGetElementData(thePlayer,"mats")<1500+6*Munianzahl)then
							outputChatBox("Du hast nicht genügend Materialien!",thePlayer,255,0,0)
						else
							giveWeapon ( toPlayer, 29 , Munianzahl, true )
							vioSetElementData(thePlayer,"mats",vioGetElementData(thePlayer,"mats")-1500-6*Munianzahl)
							outputChatBox(string.format("Du hast %s eine MP5 mit %s Schuss gegeben!", getPlayerName(toPlayer), Munianzahl),thePlayer,255,0,0)
							outputChatBox(string.format("%s hat dir eine MP5 mit %s Schuss gegeben!", getPlayerName(thePlayer), Munianzahl),toPlayer,255,0,0)
						end	
					elseif(id==7)then
						if(vioGetElementData(thePlayer,"mats")<4000+15*Munianzahl)then
							outputChatBox("Du hast nicht genügend Materialien!",thePlayer,255,0,0)
						else
							giveWeapon ( toPlayer, 30 , Munianzahl, true )
							vioSetElementData(thePlayer,"mats",vioGetElementData(thePlayer,"mats")-4000-15*Munianzahl)
                            outputChatBox(string.format("Du hast %s eine AK47 mit %s Schuss gegeben!", getPlayerName(toPlayer), Munianzahl),thePlayer,255,0,0)
                            outputChatBox(string.format("%s hat dir eine AK47 mit %s Schuss gegeben!", getPlayerName(thePlayer), Munianzahl),toPlayer,255,0,0)
						end	
					elseif(id==8)then
						if(vioGetElementData(thePlayer,"mats")<4500+15*Munianzahl)then
							outputChatBox("Du hast nicht genügend Materialien!",thePlayer,255,0,0)
						else
							giveWeapon ( toPlayer, 31 , Munianzahl, true )
							vioSetElementData(thePlayer,"mats",vioGetElementData(thePlayer,"mats")-4500-15*Munianzahl)
							outputChatBox(string.format("Du hast %s eine M4 mit %s Schuss gegeben!", getPlayerName(toPlayer), Munianzahl),thePlayer,255,0,0)
							outputChatBox(string.format("%s hat dir eine M4 mit %s Schuss gegeben!", getPlayerName(thePlayer), Munianzahl),toPlayer,255,0,0)
						end	
					--[[elseif(id==8)then
						if(vioGetElementData(thePlayer,"mats")<50000+Munianzahl)then
							outputChatBox("Du hast nicht genügend Materialien!",thePlayer,255,0,0)
						else
							giveWeapon ( toPlayer, 38 , Munianzahl, true )
							vioSetElementData(thePlayer,"mats",vioGetElementData(thePlayer,"mats")-50000+50000*Munianzahl)
							outputChatBox("Du hast "..getPlayerName(toPlayer).." eine Minigun mit "..Munianzahl.." Schuss gegeben!",thePlayer,255,0,0)
							outputChatBox(getPlayerName(thePlayer).." hat dir eine Minigun mit "..Munianzahl.." Schuss gegeben!",toPlayer,255,0,0)
						end	]]
					end	
				else
					showError(thePlayer,"Der Spieler ist nicht in deiner Nähe!")
				end
			else
				outputChatBox("Nutzung: /sellweapon toName weaponID Munianzahl",thePlayer,255,0,0)
				outputChatBox("ID:Waffe(Waffenpreis|Munitionspreis) : 1:Messer(6) 2:9mm(15|3) 3:Schallged. 9mm(30|3) 4:Deagle(150|3) 5:Shotgun(60|3) 6:MP5(1500|6) 7:AK47(4000|15) 8:M4(4500|15) ",thePlayer,255,0,0)
			end	
		else
			outputChatBox("Nutzung: /sellweapon toName weaponID Munianzahl",thePlayer,255,0,0)
				outputChatBox("ID:Waffe(Waffenpreis|Munitionspreis) : 1:Messer(6) 2:9mm(15|3) 3:Schallged. 9mm(30|3) 4:Deagle(150|3) 5:Shotgun(60|3) 6:MP5(1500|6) 7:AK47(4000|15) 8:M4(4500|15) ",thePlayer,255,0,0)
		end
	end
end
addCommandHandler("sellweapon",sellWeapon_func,false,false)









