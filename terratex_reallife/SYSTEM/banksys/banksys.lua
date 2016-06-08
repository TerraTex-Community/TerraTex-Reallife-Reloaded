-- banksys.lua

bankautomaten={}
function spawnAutomat()
	local automat = createObject(2942, 1497.3177, -1750,15.0344, 0, 0, 180.25)
	table.insert(bankautomaten, automat)  -- Automat Eingang Stadthalle LS
	automat = createObject(2942, 1204.126953125, -919.2734375, 42.582004547119, 0, 0, 2.98832702637)
	table.insert(bankautomaten, automat)  -- Automat Eingang BurgerShot Nord LS
	automat = createObject(2942, 2133.9462890625, -1123.447265625, 24.916599273682, 0, 0, 178.34927368164)
	table.insert(bankautomaten, automat)  -- Automat Eingang Billigautohändler LS
	automat = createObject(2942, 2312.30004883, 2461.10009766, 10.39999962, 0, 0, 0)
	table.insert(bankautomaten, automat)  -- Automat bei LVPD
	automat = createObject(2942, 2194.89990234, 1985.59997559, 11.80000019, 0, 0, 273.25000000)
	table.insert(bankautomaten, automat)  -- Automat bei 24/7 gegenüber CF Base in LV
	automat = createObject(2942, 1715.80004883, 1288.80004883, 10.39999962, 0, 0, 273.24645996)
	table.insert(bankautomaten, automat)  -- Automat Eingang Luxus Autohändler LV
	automat = createObject(2942, 2828.10009766, -1565.69995117, 10.69999981, 0, 0, 0.24649048)
	table.insert(bankautomaten, automat)  -- Automat Eingang Premium Autohändler LS
	automat = createObject(2942, -181, 1038.59997559, 19.29999924, 0, 0, 272.24169922)
	table.insert(bankautomaten, automat)  -- Automat Eingang 24/7 Name Stadt LV
	automat = createObject(2942,1075.69995117, 2383.10009766, 10.39999962, 0, 0, 182.75003052)
	table.insert(bankautomaten, automat)  -- Automat Eingang Sport Autohändler LV
	automat = createObject(2942, 1026.5, 1026.5, 10.60000038147, 0, 0, 121.9951171875)
	table.insert(bankautomaten, automat)  -- Automat für NewsBase. Standort lt. Doody
	automat = createObject(2942, 1366.9111328125, -1283.9345703125, 13.046875, 0, 0, 270.03759765625)
	table.insert(bankautomaten, automat)  -- Automat Eingang Großer Ammo LS
	automat = createObject(2942, 420.9697265625, -1365.4931640625, 14.34, 0, 0, 213.90173339844)
	table.insert(bankautomaten, automat)  -- Automat Eingang Motorrad Autohaus LS
	automat = createObject(2942, 209.3486328125, -1433.748046875, 12.7097, 0, 0, 23.069000244141)
	table.insert(bankautomaten, automat)  -- Automat Parkplatz Südlich von Motorrad Autohaus LS
	automat = createObject(2942, 1537.7216796875, 1669.6123046875, 8373.6259765625, 0, 0, 90)
	setElementInterior(automat, 1)
	table.insert(bankautomaten, automat)  -- Automat in Interior
	automat = createObject(2942, 1537.7216796875, 1671.3857421875, 8373.6259765625, 0, 0, 90)
	setElementInterior(automat, 1)
	table.insert(bankautomaten, automat)  -- Automat in Interior
	automat = createObject(2942, 1537.7216796875, 1673.111328125, 8373.6259765625, 0, 0, 90)
	setElementInterior(automat, 1)
	table.insert(bankautomaten, automat)  -- Automat in Interior
	automat = createObject(2942, 1537.7216796875, 1683.5126953125, 8373.6259765625, 0, 0, 90)
	setElementInterior(automat, 1)
	table.insert(bankautomaten, automat)  -- Automat in Interior
	automat = createObject(2942, 1537.7216796875, 1685.2861328125, 8373.6259765625, 0, 0, 90)
	setElementInterior(automat, 1)
	table.insert(bankautomaten, automat)  -- Automat in Interior
	automat = createObject(2942, 1537.7216796875, 1687.0107421875, 8373.6259765625, 0, 0, 90)
	setElementInterior(automat, 1)
	table.insert(bankautomaten, automat)  -- Automat in Interior
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),spawnAutomat)

 

 addEvent("getCarVersicherung",true)
 addEvent("getLebensVersicherung",true)
  function getLebensVersicherung_func(thePlayer)
	-- local thePlayer=source
	local x,y,z=getElementPosition(thePlayer)
	if(getDistanceBetweenPoints3D(x,y,z,1551.724609375,1671.9560546875,8373.9833984375)<20)then
		if(vioGetElementData(thePlayer,"lebensversicherung")==0)then
			if(getPlayerMoney(thePlayer)>49999.99)then
                changePlayerMoney(thePlayer,-50000,"sonstiges","Abschluss einer Lebensversicherung")
				vioSetElementData(thePlayer,"lebensversicherung",1)
				outputChatBox("Du hast erfolgreich die Versicherung abgeschlossen!",thePlayer,0,255,0)				
			else
				outputChatBox("Du benötigst 50k $ auf deiner Hand um die Lebensversicherung abzuschliesen!",thePlayer,255,0,0)
			end		
		else
				vioSetElementData(thePlayer,"lebensversicherung",0)
				outputChatBox("Du hast die Lebensversicherung erfolgreich gekündigt!",thePlayer,0,255,0)
		end 
	else
		outputChatBox("Du bist nicht am Bankschalter für Versicherung!",thePlayer,255,0,0)
	end
 end
 addEventHandler("getLebensVersicherung",getRootElement(),getLebensVersicherung_func)
 
 function getCarVersicherung_func(thePlayer) 
	-- local thePlayer=source
	local x,y,z=getElementPosition(thePlayer)
	if(getDistanceBetweenPoints3D(x,y,z,1551.724609375,1671.9560546875,8373.9833984375)<20)then
		if(vioGetElementData(thePlayer,"versicherung")==0)then
			if(getPlayerMoney(thePlayer)>149999.99)then
                changePlayerMoney(thePlayer,-150000,"sonstiges","Abschluss einer Fahrzeugversicherung")
				vioSetElementData(thePlayer,"versicherung",1)
				outputChatBox("Du hast erfolgreich die Versicherung abgeschlossen!",thePlayer,0,255,0)				
			else
				outputChatBox("Du benötigst 150k $ auf deiner Hand um die Versicherung abzuschliesen!",thePlayer,255,0,0)
			end		
		else
				vioSetElementData(thePlayer,"versicherung",0)
				outputChatBox("Du hast die Versicherung erfolgreich gekündigt!",thePlayer,0,255,0)
		end 
	else
		outputChatBox("Du bist nicht am Bankschalter für Versicherung!",thePlayer,255,0,0)
	end
 end
 addEventHandler("getCarVersicherung",getRootElement(),getCarVersicherung_func)
 
 
 
 
 function showBankGui(mouseButton, buttonState, playerWhoClicked)
		local noautomat=0
		local x,y,z=getElementPosition(playerWhoClicked)
	 	for key, theAutomat in pairs(bankautomaten) do
			if(theAutomat==source)then
				local ax,ay,az=getElementPosition(theAutomat)
				local dis=getDistanceBetweenPoints3D(ax,ay,az,x,y,z)
				if(dis<5)then
					noautomat=1
				end
			end
		
		end
	if (noautomat==1) then
		triggerClientEvent(playerWhoClicked,"showBankAutomat",playerWhoClicked)
	
	end
 
 
 
 end
 addEventHandler("onElementClicked",getRootElement(),showBankGui)
 
 
 
 function pay_func(source,command,empf,betrags)
	if(empf and betrags)then
		if(isPlayerLoggedIn(source))then
			local betrag=tonumber(betrags)
			if not(betrag) then betrag=0 end
			if(betrag<0)then betrag=-betrag end
			betrag=math.round(betrag,2)
			if(getPlayerFromIncompleteName (empf))then
				if(getPlayerMoney(source)<betrag)then
					showError(source,"Du hast nicht soviel Geld auf deiner Hand!")
				
				elseif((betrag>500)and (vioGetElementData(source,"playtime")<600))then
					showError(source,"Du darfst nur 500$ weitergeben!")
						
				else
					local empfele=getPlayerFromIncompleteName (empf)
					local ex,ey,ez=getElementPosition(empfele)
					local sx,sy,sz=getElementPosition(source)
					local dis=getDistanceBetweenPoints3D(ex,ey,ez,sx,sy,sz)
					if(dis<10)then
                        changePlayerMoney(source,-betrag,"spieler","Geldzahlung an "..getPlayerName(empfele))
                        changePlayerMoney(empfele,betrag,"spieler","Geldzahlung von "..getPlayerName(source))
                        showError(source,string.format("Sie haben erfolgreich %s $ an %s uebergeben!", betrag, empf))
                        local pname=getPlayerName(source)
                        showError(empfele,string.format("%s hat ihnen %s $ uebergeben!", pname, betrag))
                        vioSetElementData(source,"ueberweisungssumme",vioGetElementData(source,"ueberweisungssumme")+betrag)
					else
						showError(source, "Der Spieler ist zuweit entfernt!")		
					end
				end
			else
				showError(source,"Ungueltiger Betrag!")
			end
		end
	end
 end
 addCommandHandler("pay",pay_func,false,false)
 
 
 function betteln_func(thePlayer,Command,empf,betrag)
		if(empf) and (betrag) then
			local pp=getPlayerFromIncompleteName(empf)
			if(pp)then
				outputChatBox(string.format("%s bettelt dich an, ihm %s $ zu geben.", getPlayerName(thePlayer), betrag),pp,255,255,0)			
				outputChatBox("Du hast erfolgreich gebettelt!",thePlayer,255,255,0)			
			
			end
		end
 end 
 addCommandHandler("betteln",betteln_func,false,false)
 
 function ueberweisungServer_func(betrag,empf)
	if source ~= client then return end
   if(betrag<0)then betrag=-betrag end
   betrag=math.round(betrag,2)
		if(betrag>getPlayerBank(source))then
		
			showError(source,string.format("Sie haben keine %s$ auf dem Konto!", betrag))
		else
			if(getPlayerFromIncompleteName (empf))then
				if(vioGetElementData(source,"playtime")<600)then
					showError(source,"Du hast nicht genügend Spielzeit dafür!")
                else

					local empfele=getPlayerFromIncompleteName (empf)
					if(empfele)then
                        changePlayerBank(source,-betrag,"sonstiges","Überweisung an "..getPlayerName(empfele))
                        changePlayerBank(empfele,betrag,"sonstiges","Überweisung von "..getPlayerName(source))
						showError(source,string.format("Sie haben erfolgreich %s $ an %s ueberwiesen!", betrag, empf))
						vioSetElementData(source,"ueberweisungssumme",vioGetElementData(source,"ueberweisungssumme")+betrag)					
						local pname=getPlayerName(source)
                        showError(empfele,string.format("%s hat ihnen %s $ ueberwiesen!", pname, betrag))
					else
						outputChatBox("Der Spieler existiert nicht, oder ist Offline (Zur Offlineüberweisung nutze /transfer [Name] [Betrag])",source,255,0,0)
					end
				end
			else
				outputChatBox("Der Spieler existiert nicht, oder ist Offline (Zur Offlineüberweisung nutze /transfer [Name] [Betrag])",source,255,0,0)
			end
		end
 end
 addEvent("ueberweisungServer",true)
 addEventHandler("ueberweisungServer",getRootElement(),ueberweisungServer_func)
 
 
 
 
 
 
 
 
  function spendenServer_func(betrag)
  if source ~= client then return end
    if(betrag<0)then betrag=-betrag end
    changePlayerMoney(source,-betrag,"sonstiges","Spendenzahlung")
    vioSetElementData(source,"ingamespenden",vioGetElementData(source,"ingamespenden")+betrag)
    showError(source,string.format("Sie haben erfolgreich %s $ an die Vereinigten Hilfswerke fuer Eventveranstalltung \195\188berwiesen!", betrag))
    frakkasse[3]=frakkasse[3]+betrag
    for theKey,thePlayer in ipairs(getPlayersInTeam(team[3]))do
        outputChatBox(string.format("%s hat %s gespendet!", getPlayerName(source), toprice(betrag)),thePlayer,0,255,0)
    end
 end
 addEvent("spendenServer",true)
 addEventHandler("spendenServer",getRootElement(),spendenServer_func)
 
 
 
 
 function einzahlenServer_func(betrag)
 if source ~= client then return end
    if(betrag<0)then betrag=-betrag end
	if(betrag>getPlayerMoney(source))then
        showError(source,string.format("Sie haben keine %s$ auf der Hand!", betrag))
    else
        changePlayerMoney(source,-betrag,"sonstiges","Bankeinzahlung")
        changePlayerBank(source,betrag,"sonstiges","Bankeinzahlung")
        showError(source,string.format("Sie haben erfolgreich %s $ eingezahlt!", betrag))
    end
 end
 addEvent("einzahlenServer",true)
 addEventHandler("einzahlenServer",getRootElement(),einzahlenServer_func)
 
  function auszahlenServer_func(betrag)
  if source ~= client then return end
     if(betrag<0)then betrag=-betrag end
		if(betrag>getPlayerBank(source))then
		
			showError(source,string.format("Sie haben keine %s$ auf dem Konto!", betrag))
        else
            changePlayerMoney(source,betrag,"sonstiges","Bankauszahlung")
            changePlayerBank(source,-betrag,"sonstiges","Bankauszahlung")
            showError(source,string.format("Sie haben erfolgreich %s $ ausgezahlt!", betrag))
		end
 end
 addEvent("auszahlenServer",true)
 addEventHandler("auszahlenServer",getRootElement(),auszahlenServer_func)








