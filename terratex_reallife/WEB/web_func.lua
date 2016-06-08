
function web_isPlayerOnline(Name)
	if(getPlayerFromName(Name))then
		return 1;
	else
		return 0;
	end
end

function web_getMiete(HausNr)
	if(HausNr)then
		if(houseData[tonumber(HausNr)]["Miete"])then
			return houseData[tonumber(HausNr)]["Miete"]
		else
			return 0
		end
	else
		return 0
	end
end

function web_getKasse(HausNr)
	if(HausNr)then
		if(houseData[tonumber(HausNr)]["Kasse"])then
		
			return houseData[tonumber(HausNr)]["Kasse"]
	else
			return 0
		end
	else
		return 0
	end
end

--function web_setMiete(HausNr,Miete)
--	houseData[tonumber(HausNr)]["Miete"]=tonumber(Miete)
--	local query="SELECT * FROM userdata WHERE hkey='"..(-HausNr).."'"
--	local result=mysql_query(handler,query)
--	while(true)do
--		row = mysql_fetch_assoc(result)
--		if not row then break end
--		local newQuery="INSERT INTO servermessage (VonName,Message,Nickname) VALUES ('Mietsystem','Die Miete deiner Wohnung wurde auf "..Miete.." gesetzt!','"..row["Nickname"].."')"
--		mysql_query(handler,newQuery)
--	end
--	for theKey,thePlayer in ipairs(getElementsByType("player"))do
--		if(vioGetElementData(thePlayer,"hkey"))then
--			if(vioGetElementData(thePlayer,"hkey")==-HausNr)then
--				outputChatBox(string.format("Die Miete deiner Wohnung wurde auf %s gesetzt!", Miete),thePlayer)
--			end
--		end
--	end
--end

--function web_kickBewohner(HausNr,BewohnerName)
--	if(getPlayerFromName(BewohnerName))then
--		if(vioGetElementData(getPlayerFromName(BewohnerName),"hkey")==-tonumber(HausNr))then
--			vioSetElementData(getPlayerFromName(BewohnerName),"hkey",0)
--			outputChatBox("Du wurdest aus deiner Mietwohnung geschmissen!",getPlayerFromName(BewohnerName),255,0,0)
--		end
--	end
--end

function web_changeNick(Name,newnick)
	local player=getPlayerFromName(Name)
	for theKey,theVehicleTable in ipairs(privVeh) do
		if(string.lower(theVehicleTable[1])==string.lower(Name))then
			theVehicleTable[1]=newnick
			if(isElement(theVehicleTable[3]))then
				vioSetElementData(theVehicleTable[3],"besitzer",newnick)
			end
		end	
	end
	for theKey,theBizTable in ipairs(bizData)do
		if(theBizTable["Besitzer"])then
			if(string.lower(theBizTable["Besitzer"])==string.lower(Name))then
			theBizTable["Besitzer"]=newnick
			end
		end
	end
	for theKey,theHaus in ipairs(haeuser)do
		if(theHaus:getBesitzer())then
			if(string.lower(theHaus:getBesitzer())==string.lower(Name))then
                theHaus.besitzer=newnick
			end
		end
	end
	
	for theName,thePlayerTable in ipairs(dutytimer_table)do
		if(string.lower(theName)==string.lower(Name))then
			dutytimer_table[newnick]=thePlayerTable
			table.removeKey(dutytimer_table,theName)
		end
	end
	
	
	
	
	if(player)then
		local console=getElementsByType ( "console")
		tban_func(console[1],"tban",Name,"-5","Dein","Antrag auf Nickwechsel wird gerade durchgeführt!" )
		return 1;
		
	else
		return 0;
	end


end


function web_setNewRank(Name,Rank,Leader)
	local player=getPlayerFromName(Name)
	if(player)then
		if(Rank>0)then
			vioSetElementData(player,"fraktionsrang",Rank)
			outputChatBox(string.format("Der Leader %s hat deinen Rang geändert. Du bist jetzt Rang %s.", Leader, Rank),player,255,0,0)
			takeAllWeapons ( player )	
		else
			vioSetElementData(player,"fraktion",0)
			vioSetElementData(player,"fraktionsrang",0)
			outputChatBox(string.format("Der Leader %s hat dich aus der Fraktion geworfen. Du bist jetzt Zivilist.", Leader),player,255,0,0)
			vioSetElementData(player,"FrakSkin",0)
			vioSetElementData(toPlayer,"rechte_AllLeader",0) 
			setElementModel(player,vioGetElementData(player,"skinid"))
			takeAllWeapons ( player )
			setPlayerTeam (player,nil)
		end
		return 1;
	end
	return 0;
end

--function web_givePremium(Name,AdminID,SecureCode,premtime,gesamtzeit)
--	if(SecureCode==MySQL_GetString("serversettings", "Wert","Name='SecureCode'"))then
--		if(0<MySQL_GetVar("userdata", "AdminLVL","ID='"..AdminID.."'"))then
--			local player=getPlayerFromIncompleteName(Name)
--			if(player)then
--					vioSetElementData(player,"premium",gesamtzeit)
--					outputChatBox(string.format("Dir wurden soeben %s Tage Premium gutgeschrieben!", math.round(((premtime/60)/60)/24)),player,0,255,0)
--				return 1;
--			else
--				return 0;
--			end
--		end
--	end
--end
--









