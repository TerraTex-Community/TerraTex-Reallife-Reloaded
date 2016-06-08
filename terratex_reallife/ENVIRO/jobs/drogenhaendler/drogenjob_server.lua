drogenJobHausElement=false
drogenPed=false

function createDrogenJobElements()

   drogenJobHausElement=createObject(1342,331.09436035156,1127.0301513672,1083.9165039063,0,0,269.99996948242)
	setElementInterior(drogenJobHausElement,5)
	drogenPed=createPed (128,330.8388671875,1128.3251953125,1083.8828125,-10.0)
	setElementInterior(drogenPed,5)	
	--addEventHandler("onPlayerClick",drogenJobHausElement,cklickOnDrogenHouse)
	--addEventHandler("onPlayerClick",drogenPed,cklickOnDrogenHouse)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),	createDrogenJobElements)

function cklickOnDrogenHouse(mouseButton,buttonState,clickedElement)
	if(vioGetElementData(source,"job")==2)then
		if(clickedElement==drogenJobHausElement) or (clickedElement==drogenPed)then
			triggerClientEvent(source,"openDrogenJobGui",source,math.round(serversettings["drogenpreis"],0))	
		end
	end
end
addEventHandler("onPlayerClick",getRootElement(),cklickOnDrogenHouse)

function wantBuyDrogenDealer_drogen_func(menge)
	local price=menge*serversettings["drogenpreis"]
	if(getPlayerMoney(source)<price)then
		showError(source,"Du hast nicht genügend Geld dabei!")
	else
		vioSetElementData(source,"drogen",vioGetElementData(source,"drogen")+menge)
        changePlayerMoney(source,-price,"job","Drogendealer","Drogenkauf")
		frakkasse[2]=frakkasse[2]+price/2
		frakkasse[12]=frakkasse[12]+price/2
		for theKey,thePlayer in ipairs(getPlayersInTeam(team[2])) do
			outputChatBox("Hauptdrogenkurier: Jemand hat Drogen gekauft!",thePlayer,255,0,0)
		end
		serversettings["drogenpreis"]=serversettings["drogenpreis"]+(0.002*menge)		
		showError(source,"Du hast erfolgreich die Drogen gekauft!")
	end


end
addEvent("wantBuyDrogenDealer_drogen",true)
addEventHandler("wantBuyDrogenDealer_drogen",getRootElement(),wantBuyDrogenDealer_drogen_func)

function reduceDrogenPreis(timeshift)
		if(serversettings["drogenpreis"]>1)then
			serversettings["drogenpreis"]=serversettings["drogenpreis"]-0.02
		end
	setTimer(reduceDrogenPreis,1800000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),reduceDrogenPreis)

function selldrugs_func(thePlayer,command,toPlayerName,menge,preis)
	if(vioGetElementData(thePlayer,"job")==2)then
	if(toPlayerName)and tonumber(menge)and tonumber(preis)then
		if(tonumber(menge)<0)then menge=menge*-1 end
		if(tonumber(preis)<0)then preis=preis*-1 end
		local toPlayer=getPlayerFromIncompleteName(toPlayerName)
		if(toPlayer)then
			if (vioGetElementData(toPlayer,"drogen")+menge)>500 then
				showError(thePlayer,"Der Spieler kann nicht so viele Drogen annehmen!")
			else
				if(vioGetElementData(thePlayer,"drogen")<tonumber(menge))then
					showError(thePlayer,"Du hast nicht soviele Drogen zum verkaufen!")
				else
					vioSetElementData(toPlayer,"DrugTradeFrom",thePlayer)
					vioSetElementData(toPlayer,"DrugTradePrice",tonumber(preis))
					vioSetElementData(toPlayer,"DrugTradeMenge",tonumber(menge))
					outputChatBox(string.format("%s hat dir %s Gramm Drogen fuer %s angeboten! annehmen mit /accept drogen", getPlayerName(thePlayer), menge, toprice(preis)),toPlayer,0,250,150)
					outputChatBox(string.format("Du hast %s Drogen angeboten!", getPlayerName(toPlayer)),thePlayer,0,250,150)
				end
			end
		end
	else
		showError(thePlayer,"Nutzung: /selldrugs [Spieler] [Menge] [Preis]")
	end
	end
end
addCommandHandler("selldrugs",selldrugs_func,false,false)








