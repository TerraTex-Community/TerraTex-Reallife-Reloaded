

addEvent("kickMeBecauseWrongVersion",true)
function kickMeBecauseWrongVersion_func(player)
	if source ~= client then return end
	kickPlayer(player,"You have an older Version, upgrade on www.mtasa.com!")
end
addEventHandler("kickMeBecauseWrongVersion",getRootElement(),kickMeBecauseWrongVersion_func)

local isDevServerV=false
function isDevServer() return isDevServerV end

serversettings={}
Tagesdurchnitte={}


function version_func(thePlayer)
	outputChatBox(string.format("Aktuelle Serverversion: %s", serversettings["Version"]),thePlayer)
end
addCommandHandler("version",version_func,false,false)

function loadSettingsFromDB()
	setAircraftMaxVelocity ( 50)
	--removeWorldModel ( 4026, 1000, 1497.609,-1543.709,17.549 )
	--removeWorldModel ( 4016, 1000, 1497.609,-1543.709,17.549 )
	--removeWorldModel ( 4218, 1000, 1497.609,-1543.709,17.549) 
	setModelHandling (433,"maxVelocity",120)
	setModelHandling (433,"engineAcceleration",25)
	setModelHandling (433,"engineInertia",80)
	setModelHandling (433,"dragCoeff",4)
	setModelHandling (433,"driveType","awd")
	
	local speedUpTable={[490]=15,[596]=15,[597]=15,[598]=15,[470]=30,[599]=30}
	for vehicle,kmh in pairs(speedUpTable)do
		kmh=kmh*2.5
		local originalTABEL=getOriginalHandling ( vehicle )
		local Handler=(originalTABEL["maxVelocity"]+tonumber(kmh))/originalTABEL["maxVelocity"]
		setModelHandling (vehicle,"maxVelocity",originalTABEL["maxVelocity"]*Handler)
		setModelHandling (vehicle,"engineAcceleration",originalTABEL["engineAcceleration"]*Handler)
		setModelHandling (vehicle,"engineInertia",originalTABEL["engineInertia"]*Handler)
	end

	serversettings["drogenpreis"]=tonumber(MySQL_GetVar("serversettings", "Wert","Name='drogenpreis'"))
	serversettings["steuersatz"]=tonumber(MySQL_GetVar("serversettings", "Wert","Name='steuersatz'"))
	serversettings["sozialabgabesatz"]=tonumber(MySQL_GetVar("serversettings", "Wert","Name='sozialabgabesatz'"))
	serversettings["matspreis"]=tonumber(MySQL_GetVar("serversettings", "Wert","Name='matspreis'"))
	serversettings["lottojackpot"]=tonumber(MySQL_GetVar("serversettings", "Wert","Name='Jackpot'"))
	serversettings["Ueberweisungssteuer"]=tonumber(MySQL_GetVar("serversettings", "Wert","Name='Ueberweisungssteuer'"))	
	serversettings["tankpreis"]=tonumber(MySQL_GetVar("serversettings", "Wert","Name='tankpreis'"))
	serversettings["Version"]=MySQL_GetString("serversettings", "Wert","Name='Version'")	
	serversettings["atommuell"]=tonumber(MySQL_GetVar("serversettings", "Wert","Name='atommuell'"))
	serversettings["playerOfMonthPic"]=MySQL_GetString("serversettings", "Wert","Name='spielerDesMonats'")
	--setServerName ("German TerraTex Reallife by www.tt-rl.de Version "..serversettings["Version"])

    setGameType("TerraTex Reallife Script "..serversettings["Version"])
    setRuleValue ("Homepage",config["maindomain"])
    setMapName ("TerraTex")
    resetWaterLevel(0)


	serversettings["Max_User"]=0
	if not(fileExists(":"..getResourceName(getThisResource()).."/devmode.dev")) then
		local lastDailyReset=tonumber(MySQL_GetVar("serversettings", "Wert","Name='DailyReset'"))
		local time= getRealTime()
		local timestamp=time.timestamp	
	
		if(timestamp-(22*60*60) > lastDailyReset)then
			local query="UPDATE serversettings SET Wert='"..timestamp.."' WHERE Name='DailyReset'"			
			mysql_query(handler,query)
			local query="UPDATE vehicles SET fahrzeugalter=fahrzeugalter+1"
			mysql_query(handler,query)
			--local query="DELETE FROM vehicles WHERE SpawnX='0' and SpawnY='0' and SpawnZ='0' and fahrzeugalter>3"
			--mysql_query(handler,query)
			
			local query="UPDATE players SET AktiveDays=AktiveDays+1"
			mysql_query(handler,query)
			local query="UPDATE userdata SET AktiveDays=AktiveDays+1"
			mysql_query(handler,query)
			local changeaccounts=0
            local query="SELECT Nickname FROM players WHERE AktiveDays>30 AND AktiveDays<35"
            local result=mysql_query(handler,query)
            if(result)then
                local zahler=0
                local queryb=""

                while zahler<mysql_num_rows(result) do
                    --queryb="DELETE FROM vehicles WHERE Besitzer='"..mysql_result(result,(zahler+1),1).."'"
                 --   queryb="UPDATE vehicles SET abgeschleppt='1' WHERE Besitzer='"..mysql_result(result,(zahler+1),1).."'"
                 --   save_offline_message(mysql_result(result,(zahler+1),1),"Inaktiv-System","Aufgrund deiner Inaktivität wurden alle Fahrzeuge abgeschleppt.")
                --    mysql_query(handler,queryb)
                    changeaccounts=changeaccounts+1
                    zahler=zahler+1
                end
            end

            local query="SELECT Nickname FROM players WHERE AktiveDays>90 AND AktiveDays<95"
            local result=mysql_query(handler,query)
            if(result)then
                local zahler=0
                local queryb=""

                while zahler<mysql_num_rows(result) do
               --     queryb="DELETE FROM vehicles WHERE Besitzer='"..mysql_result(result,(zahler+1),1).."'"
                    --queryb="UPDATE vehicles SET abgeschleppt='1' Besitzer='"..mysql_result(result,(zahler+1),1).."'"
                --    save_offline_message(mysql_result(result,(zahler+1),1),"Inaktiv-System","Aufgrund deiner Inaktivität wurden alle Fahrzeuge, Haus, Biz und Prestige gelöscht.")
                --    mysql_query(handler,queryb)
                    changeaccounts=changeaccounts+1
                    zahler=zahler+1
                end
            end

            local query="SELECT Nickname FROM players WHERE AktiveDays>90 AND AktiveDays<95"
            local result=mysql_query(handler,query)
            local zahler=0
            if(result)then
                local queryb=""
                while zahler<mysql_num_rows(result) do
                 --   queryb="UPDATE userdata SET hkey='0',bizKey='0',prestigeKey='0' WHERE Nickname='"..mysql_result(result,(zahler+1),1).."'"
                --    mysql_query(handler,queryb)
                 --   changeaccounts=changeaccounts+1
                    zahler=zahler+1
                end
            end
            local query="SELECT userdata.* FROM userdata LEFT JOIN players ON players.Nickname=userdata.Nickname WHERE userdata.PlayTime<=600 and players.AktiveDays>=30"
            local result=mysql_query(handler,query)
            local zahler=0
            if(result)then
                local queryb=""
                while zahler<mysql_num_rows(result) do
                    local dasatz = mysql_fetch_assoc(result)
                --    queryb="DELETE FROM players WHERE Nickname='"..dasatz["Nickname"].."'"
                --    mysql_query(handler,queryb)

                --    queryb="INSERT INTO CP_deletes (Name) VALUES ('"..dasatz["Nickname"].."');"
                --    mysql_query(handler,queryb)

                 --   save_log( "nickdelete", dasatz["Nickname"])
                    changeaccounts=changeaccounts+1
                    zahler=zahler+1
                end
            end

			local query="SELECT Nickname FROM players WHERE AktiveDays>365"
			local result=mysql_query(handler,query)
			local zahler=0
			local queryb=""
			if(result)then
				while zahler<mysql_num_rows(result) do
					local dasatz = mysql_fetch_assoc(result)								
				--	queryb="DELETE FROM players WHERE Nickname='"..dasatz["Nickname"].."'"					
				--	mysql_query(handler,queryb)	
					
				--	queryb="INSERT INTO CP_deletes (Name) VALUES ('"..dasatz["Nickname"].."');"					
				--	mysql_query(handler,queryb)
					
				--	save_log( "nickdelete", dasatz["Nickname"])
				--	
					changeaccounts=changeaccounts+1
					zahler=zahler+1
					
				end
			end
			outputDebugString(tostring(changeaccounts).." Accounts have been Changed")


		end
	else
        isDevServerV=true
	end
	setTimer(saveSettingsInDB,3600000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),loadSettingsFromDB)

function saveSettingsInDB()
	MySQL_SetVar("serversettings", "Wert" , serversettings["drogenpreis"] , "Name='drogenpreis'")
	MySQL_SetVar("serversettings", "Wert" , serversettings["lottojackpot"] , "Name='Jackpot'")
	MySQL_SetVar("serversettings", "Wert" , serversettings["matspreis"] , "Name='matspreis'")
	MySQL_SetVar("serversettings", "Wert" , serversettings["tankpreis"] , "Name='tankpreis'")
	MySQL_SetVar("serversettings", "Wert" , serversettings["atommuell"] , "Name='atommuell'")
	MySQL_SetVar("serversettings", "Wert" , rainlevel , "Name='regenlevel'")


	--outputDebugString("Serversettings saved!")
	setTimer(saveSettingsInDB,3600000,1)
end
addEventHandler("onResourceStop",getResourceRootElement(getThisResource()),saveSettingsInDB)

function stopResource_func()
	--MySQL_SetVar("serversettings", "Wert" , serversettings["User_Schnitt"], "Name='Last_Daily_User'")
	--MySQL_SetVar("serversettings", "Wert" , serversettings["Max_User"], "Name='Last_Max_Daily_Users'")
	MySQL_SetVar("serversettings", "Wert" , rainlevel , "Name='regenlevel'")
	--MySQL_SetVar("serversettings", "Wert" , serversettings["Max_User"], "Name='Max_Users' AND Wert<"..serversettings["Max_User"])
	MySQL_SetVar("serversettings", "Wert" , serversettings["atommuell"] , "Name='atommuell'")
	--query="INSERT INTO Tagesdurchschnitte (Anzahl) VALUES ('"..serversettings["User_Schnitt"].."')"
	--mysql_query(handler,query)
	
	local time= getRealTime()
	if(fileExists("LOGS/chat.log")) then
		if(fileExists("LOGS/chat/"..time.monthday.."."..(time.month+1).."."..(1900+time.year).."-chat.log")) then
			fileRename ( "LOGS/chat.log", "LOGS/chat/"..time.monthday.."."..(time.month+1).."."..(1900+time.year).."-"..(time.timestamp).."-chat.log"  )
		else
			fileRename ( "LOGS/chat.log", "LOGS/chat/"..time.monthday.."."..(time.month+1).."."..(1900+time.year).."-chat.log"  )
		end
	end
end
addEventHandler("onResourceStop",getResourceRootElement(getThisResource()),stopResource_func)

function reduceSchutzGeld(timestate)
		local query="UPDATE userdata SET schutzgeld=schutzgeld-1 WHERE schutzgeld>0"
		mysql_query(handler,query)
		for theKey,thePlayer in ipairs(getElementsByType("player")) do
			if(vioGetElementData(thePlayer,"schutzgeld"))then
				if(vioGetElementData(thePlayer,"schutzgeld")>0)then
					vioSetElementData(thePlayer,"schutzgeld",vioGetElementData(thePlayer,"schutzgeld"))
				end
			end
		end

	setTimer(reduceSchutzGeld,60000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),reduceSchutzGeld)

function afk_timer()
	for theKey,thePlayer in ipairs(getElementsByType("player"))do
		if(vioGetElementData(thePlayer,"afk_status"))then
			if not(vioGetElementData(thePlayer,"afk_status")==1) then
				vioSetElementData(thePlayer,"afk_timer",vioGetElementData(thePlayer,"afk_timer")+1)
				if(vioGetElementData(thePlayer,"afk_timer")>=15 and not(isAdminLevel(thePlayer,4)))then
					local playerTime=vioGetElementData(thePlayer,"playtime")
					if(math.round(playerTime/60,0,"floor")==math.round((playerTime-20)/60,0,"floor"))then
						vioSetElementData(thePlayer,"playtime",playerTime-20)
					else
						local newPlayerTime=(math.round(playerTime/60,0,"floor")*60)+1
						vioSetElementData(thePlayer,"playtime",newPlayerTime)
					end
					outputChatBox(string.format("Der Spieler %s wurde vom AFK-System nach 15 Minuten gekickt (kein /afk)!", getPlayerName(thePlayer)),getRootElement(),255,0,0)		
					kickPlayer ( thePlayer, "Du warst AFK ohne /afk einzugeben!" )	
				end	
			else
				vioSetElementData(thePlayer,"afk_timer",0)
			end
		end
	end
	setTimer(afk_timer,60000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),afk_timer)

function timebanreduce()
	local query="UPDATE timeban SET Minuten=Minuten-1;"
	local reason=mysql_query(handler,query)
	if not reason then
		outputDebugString("ERROR IN REDUCE TIMEBAN!"..query)
		outputDebugString(mysql_error(handler))
	end
	local query="DELETE FROM timeban WHERE Minuten<='0'"
	local reason=mysql_query(handler,query)
	if not reason then
		outputDebugString("ERROR IN REDUCE TIMEBAN!"..query)		
		outputDebugString(mysql_error(handler))
	end
	setTimer(timebanreduce,60000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),timebanreduce)

function web_GMX_Start(SecureCode,AdminID)
	if(SecureCode==MySQL_GetString("serversettings", "Wert","Name='SecureCode'"))then
		if(2<MySQL_GetVar("userdata", "AdminLVL","ID='"..AdminID.."'"))then
			outputDebugString("Ein Serverneustart wurde initalisiert by Web")
			outputChatBox("In 5 Minuten ist der Server neugestartet. Restart beginnt in 180 Sekunden!",getRootElement(),255,0,0)
			setTimer(gmx_start,180000,1)
		end
	end

end


local startResourceUPGMX=0
function start_GMX()
	
	if(string.upper(config["dailyrestarttype"])~="NONE")then
		local hours=getRealTime()
		setTime(hours.hour,hours.minute)
		--outputDebugString(tostring(hours.hour).." "..tostring(hours.minute))
		if(hours.hour==3)then	
			if(startResourceUPGMX>0)then
				outputDebugString("AUTO GMX Started by Console")
				outputChatBox("Regulärer 3 Uhr Serverneustart in 10 Minuten!",getRootElement(),255,0,0)
				outputChatBox("Regulärer 3 Uhr Serverneustart in 10 Minuten!",getRootElement(),255,0,0)
				outputChatBox("Regulärer 3 Uhr Serverneustart in 10 Minuten!",getRootElement(),255,0,0)
				
				if(string.upper(config["dailyrestarttype"])=="SHUTDOWN")then
					setTimer(startShutDown,(10*60*1000),1)
				else
					setTimer(gmx_start,(10*60*1000),1)
				end
				setTimer(gmxRestTime,60000,1,(10))
			else
				setTimer(start_GMX,3600000,1)
			end
		else
			startResourceUPGMX=startResourceUPGMX+1
			setTimer(start_GMX,3600000,1)
		end
	end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),start_GMX)


function resetLogins()
	for theKey,thePlayer in ipairs(getElementsByType('player'))do
		vioSetElementData(thePlayer,"loggedin",false)
	end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),resetLogins)










