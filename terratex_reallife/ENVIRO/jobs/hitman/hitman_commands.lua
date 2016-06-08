local mindestKopfgeld = 1000

function contract_func(thePlayer,command,toPlayerName,Betrag)
	if((Betrag) and (toPlayerName))then
		if(vioGetElementData(thePlayer,"job")~=7)then
			local toPlayer=getPlayerFromIncompleteName(toPlayerName)
			if(toPlayer)then
				if(vioGetElementData(toPlayer,"job")~=7)then
					local BetragNum=tonumber(Betrag)
					if(BetragNum)then
						if(getPlayerMoney(thePlayer)<BetragNum)then
							showError(thePlayer,"Du hast nicht genügend Geld auf der Hand!")
						elseif(BetragNum<mindestKopfgeld)then
							showError(thePlayer,string.format("Das Kopfgeld muss mindestens %s $ betragen!", mindestKopfgeld))
                        else
                            changePlayerMoney(thePlayer,-BetragNum,"sonstiges","Kopfgeld ausgesetzt")
							vioSetElementData(toPlayer,"kopfgeld",vioGetElementData(toPlayer,"kopfgeld")+BetragNum)
							showError(thePlayer,string.format("Du hast auf %s's Kopf %s $ ausgesetzt!", getPlayerName(toPlayer), BetragNum))						
						end
					else
						showError(thePlayer,"Nutzung: /kopfgeld [Name] [Betrag]")			
					end	
				else
					showError(thePlayer,"Auf diesen Spieler kannst du kein Kopfgeld setzen!")			
				end
			else
				showError(thePlayer,"Dieser Spieler existiert nicht!")
			end
		end
	else
		showError(thePlayer,"Nutzung: /kopfgeld [Name] [Betrag]")
	end
end
addCommandHandler("contract",contract_func,false,false)
addCommandHandler("kopfgeld",contract_func,false,false)

function contracts_func(thePlayer)
	if(vioGetElementData(thePlayer,"job")==7)or(vioGetElementData(thePlayer,"fraktion")==8)then
		outputChatBox("Folgende Kopfgelder sind ausgesetzt:",thePlayer,0,255,0)
		for theKey,toPlayer in ipairs(getElementsByType("player"))do
			if(vioGetElementData(toPlayer,"kopfgeld"))then
				if(vioGetElementData(toPlayer,"kopfgeld")>0)then
					outputChatBox(string.format("%s : %s", getPlayerName(toPlayer), toprice(vioGetElementData(toPlayer,"kopfgeld"))),thePlayer,0,255,0)
				end
			end
		end
	end
end
addCommandHandler("contracts",contracts_func,false,false)








