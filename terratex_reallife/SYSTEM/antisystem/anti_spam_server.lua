
antifluttimer=false
anti_flut_Data={}

function antiflutreset()
	
	anti_flut_Data={}
	antifluttimer=setTimer(antiflutreset,5000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),antiflutreset)




function antiflut(command)

	if(not (command=="Next") and not(command=="Previous") and not(command=="Toggle"))then
		if not(tonumber(anti_flut_Data[source]))then
			--vioSetElementData(source,"antiflutreset",0)
			anti_flut_Data[source]=0
		end
		--vioSetElementData(source,"antiflutreset",vioGetElementData(source,"antiflutreset")+1)
		anti_flut_Data[source]=anti_flut_Data[source]+1
		command=mysql_escape_string( logs_handler, command )
		if (isTimer(antifluttimer))then
			if(anti_flut_Data[source]>50)then
				local theReason="ChatBoxSpam"
				local banmeele=source
				local pname=getPlayerName(banmeele)
				local theBeBanned=banmeele
				local IP=getPlayerIP(theBeBanned)
				local Serial=getPlayerSerial(theBeBanned)
				local reasons=mysql_escape_string(handler,theReason)
				local pname=mysql_escape_string(handler,pname)

				local querys="INSERT INTO Ban (Nickname,Serial,IP,Grund,Admin) VALUES ('"..pname.."','".. Serial.."','".. IP .."','"..reasons.."','Anti-Flood-System');"
				mysql_query(handler,querys)	
				outputChatBox(string.format("Der Spieler %s wurde vom Anti-Flood-System gebannt. Grund: %s", pname, reasons),getRootElement(),255,0,0)
				kickPlayer(banmeele,reasons)

			end
		end
		if not(isTimer(antifluttimer))then
			antifluttimer=setTimer(antiflutreset,2000,1)
		end
	end
end

function chatfunc(message, types)
	local cmd="say"
	
	if(types==1)then
		cmd="me"
	end
	
	if(types==2)then
		cmd="teamsay"
	end
	
	triggerEvent("onConsole",source,cmd.." "..message)

end
addEventHandler("onPlayerChat",getRootElement(),chatfunc)
--addEventHandler("onPlayerCommand",getRootElement(),antiflut)

function test_onconsole(command)
	local cmdstring=split ( command," " )
	local cmd=cmdstring[1]
	if(not (cmd=="Next") and not(cmd=="Previous") and not(cmd=="Toggle"))then
		if not(tonumber(anti_flut_Data[source]))then
			--vioSetElementData(source,"antiflutreset",0)
			anti_flut_Data[source]=0
		end
		cmdstring[1]=""
		local rest=table.concat(cmdstring," ")
		anti_flut_Data[source]=anti_flut_Data[source]+1
		cmd=mysql_escape_string( logs_handler, cmd )
		rest=mysql_escape_string( logs_handler, rest )
		
		if (isTimer(antifluttimer))then
			if(anti_flut_Data[source]>150)then
				local theReason="ChatBoxSpam"
				local banmeele=source
				local pname=getPlayerName(banmeele)
				local theBeBanned=banmeele
				local IP=getPlayerIP(theBeBanned)
				local Serial=getPlayerSerial(theBeBanned)
				local reasons=mysql_escape_string(handler,theReason)
				local pname=mysql_escape_string(handler,pname)

				local querys="INSERT INTO Ban (Nickname,Serial,IP,Grund,Admin) VALUES ('"..pname.."','".. Serial.."','".. IP .."','"..reasons.."','Anti-Flood-System');"
				mysql_query(handler,querys)	
				outputChatBox(string.format("Der Spieler %s wurde vom Anti-Flood-System gebannt. Grund: %s", pname, reasons),getRootElement(),255,0,0)
				kickPlayer(banmeele,reasons)

			end
		end
		if not(isTimer(antifluttimer))then
			antifluttimer=setTimer(antiflutreset,2000,1)
		end
	end
end
addEventHandler("onConsole",getRootElement(),test_onconsole)









