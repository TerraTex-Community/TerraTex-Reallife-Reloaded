addEvent("getRequestAndFriendList",true)
function sendgetRequestAndFriendList()
	local requestTable={}
	local privquery="SELECT * FROM tlt_friendrequest WHERE Toname='"..getPlayerName(source).."'"
	local result=mysql_query(handler,privquery)
	if( not result) then
		 outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else			
		local zahler=0
		while (mysql_num_rows(result)>zahler) do
			local dasatz = mysql_fetch_assoc(result)	
			table.insert(requestTable,dasatz["Fromname"])
			--outputChatox(dasatz["Fromname"])
			zahler=zahler+1
		end
	end
	
	local sendRequestTable={}
	privquery="SELECT * FROM tlt_friendrequest WHERE Fromname='"..getPlayerName(source).."'"
	result=mysql_query(handler,privquery)
	if( not result) then
		 outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else			
		local zahler=0
		while (mysql_num_rows(result)>zahler) do
			local dasatz = mysql_fetch_assoc(result)	
			table.insert(sendRequestTable,dasatz["Toname"])			
			--outputChatbox(dasatz["Toname"])
			zahler=zahler+1
		end
	end
	local friendlistTable={}
	privquery="SELECT * FROM tlt_friendlist WHERE Nickname='"..getPlayerName(source).."'"
	result=mysql_query(handler,privquery)
	if( not result) then
		 outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else			
		local zahler=0
		while (mysql_num_rows(result)>zahler) do
			local dasatz = mysql_fetch_assoc(result)	
			table.insert(friendlistTable,dasatz["Friendname"])
			zahler=zahler+1
		end
	end
	vioSetElementData(source,"friendlist_table",friendlistTable)
	triggerClientEvent(source,"sendrequestInfos",source,requestTable,sendRequestTable,friendlistTable)

end
addEventHandler("getRequestAndFriendList",getRootElement(),sendgetRequestAndFriendList)

function onPlayerQuitForFriendlist()
	for theKey,thePlayer in ipairs(getElementsByType("player"))do
		local friendtable=vioGetElementData(thePlayer,"friendlist_table")
		if(friendtable)then
			for theNewKey,theNewName in ipairs(friendtable)do
				if(theNewName==getPlayerName(source))then
					outputChatBox(string.format("Dein Freund %s hat den Server verlassen!", getPlayerName(source)),thePlayer,0,255,0)
				end
			end
		end
	end
end
addEventHandler("onPlayerQuit",getRootElement(),onPlayerQuitForFriendlist)

function onPlayerJoinForFriendlist()
	for theKey,thePlayer in ipairs(getElementsByType("player"))do
		local friendtable=vioGetElementData(thePlayer,"friendlist_table")
		if(friendtable)then
			for theNewKey,theNewName in ipairs(friendtable)do
				if(theNewName==getPlayerName(source))then
					outputChatBox(string.format("Dein Freund %s hat den Server betreten!", getPlayerName(source)),thePlayer,0,255,0)
				end
			end	
		end
	end
end
addEventHandler("onPlayerJoin",getRootElement(),onPlayerJoinForFriendlist)





addEvent("ablehnenAnfrageFriendlist",true)
function ablehnenAnfrageFriendlist_func(name)
	if(MySQL_DatasetExist("tlt_friendrequest", "Toname='"..getPlayerName(source).."' and Fromname='"..name.."'"))then	
		local query="DELETE FROM tlt_friendrequest WHERE Toname='"..getPlayerName(source).."' and Fromname='"..name.."'"
		mysql_query(handler,query)		
		showError(source,string.format("Du hast %ss anfrage abgelehnt!", name))
		if(getPlayerFromName(name))then
            showError(getPlayerFromName(name),string.format("%s hat deine Freundschaftsanfrage abgelehnt!", getPlayerName(source)))
			triggerEvent("getRequestAndFriendList",getPlayerFromName(name))
		else
			save_offline_message(name,getPlayerName(source),"Hey, ich will dich nicht als Freund!")
		end	
		triggerEvent("getRequestAndFriendList",source)
	else	
		showError(source,string.format("%s hat dir keine Anfrage gestellt!", name))
	end
end
addEventHandler("ablehnenAnfrageFriendlist",getRootElement(),ablehnenAnfrageFriendlist_func)

addEvent("annehmenAnfrageFriendlist",true)
function annehmenAnfrageFriendlist_func(name)
	if(MySQL_DatasetExist("tlt_friendrequest", "Toname='"..getPlayerName(source).."' and Fromname='"..name.."'"))then	
		local query="INSERT INTO tlt_friendlist (Nickname,Friendname) VALUES ('"..getPlayerName(source).."','"..name.."');"
		mysql_query(handler,query)	
		query="INSERT INTO tlt_friendlist (Friendname,Nickname) VALUES ('"..getPlayerName(source).."','"..name.."');"
		mysql_query(handler,query)
		showError(source,name.." und du seit jetzt Freunde!")
		query="DELETE FROM tlt_friendrequest WHERE Toname='"..getPlayerName(source).."' and Fromname='"..name.."'"
		mysql_query(handler,query)
		if(getPlayerFromName(name))then
            showError(getPlayerFromName(name),string.format("%s und du seit jetzt Freunde!", getPlayerName(source)))
			triggerEvent("getRequestAndFriendList",getPlayerFromName(name))
		else
			save_offline_message(name,getPlayerName(source),"Hey, wir sind jetzt Freunde!")
		end	
		triggerEvent("getRequestAndFriendList",source)
	else	
		showError(source,string.format("%s hat dir keine Anfrage gestellt!", name))
	end
end
addEventHandler("annehmenAnfrageFriendlist",getRootElement(),annehmenAnfrageFriendlist_func)


addEvent("sendAnfrageFriendlist",true)
function sendAnfrageFriendlist_func(name)
	if(name)then
		if(name~="")then
			if(MySQL_DatasetExist("players", "Nickname='"..name.."'"))then		
				if(MySQL_DatasetExist("tlt_friendrequest", "Fromname='"..getPlayerName(source).."' and Toname='"..name.."'"))then
					showError(source,string.format("Du hast %s bereits eine Anfrage gestellt!", name))
				else
					if(MySQL_DatasetExist("tlt_friendrequest", "Toname='"..getPlayerName(source).."' and Fromname='"..name.."'"))then					
						showError(source,string.format("%s hat bereits eine Anfrage gestellt, du kannst sie im Tab 'gestelle Anfragen' annehmen!", name))
					else
												
							if(MySQL_DatasetExist("tlt_friendlist", "Nickname='"..getPlayerName(source).."' and Friendname='"..name.."'"))then	
								showError(source,"Ihr seit doch bereits Freunde!")						
							else
								local query="INSERT INTO tlt_friendrequest (Fromname,Toname) VALUES ('"..getPlayerName(source).."','"..name.."');"
								mysql_query(handler,query)								
								showError(source,string.format("Du hast %s eine Anfrage gestellt!", name))	
								triggerEvent("getRequestAndFriendList",source)
								if(getPlayerFromName(name))then		
									if(vioGetElementData(getPlayerFromName(name),"terralapptapp")==1)then
										outputChatBox("Du hast eine neue Freundschaftsanfrage!",getPlayerFromName(name),255,0,0)
									end
								end
							end
						
					end
				end
			elseif(MySQL_DatasetExist("players", "Nickname='"..config["clantag"]..name.."'"))then		
				name=config["clantag"]..name
				if(MySQL_DatasetExist("tlt_friendrequest", "Fromname='"..getPlayerName(source).."' and Toname='"..name.."'"))then
					showError(source,string.format("Du hast %s bereits eine Anfrage gestellt!", name))
				else
					if(MySQL_DatasetExist("tlt_friendrequest", "Toname='"..getPlayerName(source).."' and Fromname='"..name.."'"))then					
						showError(source,string.format("%s hat bereits eine Anfrage gestellt, du kannst sie im Tab 'gestelle Anfragen' annehmen!", name))
					else
												
							if(MySQL_DatasetExist("tlt_friendlist", "Nickname='"..getPlayerName(source).."' and Friendname='"..name.."'"))then	
								showError(source,"Ihr seit doch bereits Freunde!")						
							else
								local query="INSERT INTO tlt_friendrequest (Fromname,Toname) VALUES ('"..getPlayerName(source).."','"..name.."');"
								mysql_query(handler,query)								
								showError(source,string.format("Du hast %s eine Anfrage gestellt!", name))	
								triggerEvent("getRequestAndFriendList",source)
								if(getPlayerFromName(name))then		
									if(vioGetElementData(getPlayerFromName(name),"terralapptapp")==1)then
										outputChatBox("Du hast eine neue Freundschaftsanfrage!",getPlayerFromName(name),255,0,0)
									end
								end
							end
						
					end
				end
			else
			--	outputChatBox("lala")
				if(MySQL_GetResultsCount("players", "Nickname LIKE '%"..name.."%'")==1)then
					name=MySQL_GetString("players", "Nickname", "Nickname LIKE '%"..name.."%'")
					if(MySQL_DatasetExist("tlt_friendrequest", "Fromname='"..getPlayerName(source).."' and Toname='"..name.."'"))then
						showError(source,string.format("Du hast %s bereits eine Anfrage gestellt!", name))
					else
						if(MySQL_DatasetExist("tlt_friendrequest", "Toname='"..getPlayerName(source).."' and Fromname='"..name.."'"))then					
							showError(source,string.format("%s hat bereits eine Anfrage gestellt, du kannst sie im Tab 'gestelle Anfragen' annehmen!", name))
						else
													
								if(MySQL_DatasetExist("tlt_friendlist", "Nickname='"..getPlayerName(source).."' and Friendname='"..name.."'"))then	
									showError(source,"Ihr seit doch bereits Freunde!")						
								else
									local query="INSERT INTO tlt_friendrequest (Fromname,Toname) VALUES ('"..getPlayerName(source).."','"..name.."');"
									mysql_query(handler,query)								
									showError(source,string.format("Du hast %s eine Anfrage gestellt!", name))	
									triggerEvent("getRequestAndFriendList",source)
									if(getPlayerFromName(name))then		
										if(vioGetElementData(getPlayerFromName(name),"terralapptapp")==1)then
											outputChatBox("Du hast eine neue Freundschaftsanfrage!",getPlayerFromName(name),255,0,0)
										end
									end
								end
							
						end
					end
					
				elseif(MySQL_GetResultsCount("players", "Nickname LIKE '"..config["clantag"].."%"..name.."%'")==1)then
					name=MySQL_GetString("players", "Nickname", "Nickname LIKE '"..config["clantag"].."%"..name.."%'")
					if(MySQL_DatasetExist("tlt_friendrequest", "Fromname='"..getPlayerName(source).."' and Toname='"..name.."'"))then
						showError(source,string.format("Du hast %s bereits eine Anfrage gestellt!", name))
					else
						if(MySQL_DatasetExist("tlt_friendrequest", "Toname='"..getPlayerName(source).."' and Fromname='"..name.."'"))then					
							showError(source,string.format("%s hat bereits eine Anfrage gestellt, du kannst sie im Tab 'gestelle Anfragen' annehmen!", name))
						else
													
								if(MySQL_DatasetExist("tlt_friendlist", "Nickname='"..getPlayerName(source).."' and Friendname='"..name.."'"))then	
									showError(source,"Ihr seit doch bereits Freunde!")						
								else
									local query="INSERT INTO tlt_friendrequest (Fromname,Toname) VALUES ('"..getPlayerName(source).."','"..name.."');"
									mysql_query(handler,query)								
									showError(source,string.format("Du hast %s eine Anfrage gestellt!", name))	
									triggerEvent("getRequestAndFriendList",source)
									if(getPlayerFromName(name))then		
										if(vioGetElementData(getPlayerFromName(name),"terralapptapp")==1)then
											outputChatBox("Du hast eine neue Freundschaftsanfrage!",getPlayerFromName(name),255,0,0)
										end
									end
								end
							
						end
					end
				else
					showError(source,"Dieser Spieler exisitiert nicht! (Du musst den vollständigen und korrekten Namen eingeben!")
				end
			end
		end
	end
end
addEventHandler("sendAnfrageFriendlist",getRootElement(),sendAnfrageFriendlist_func)



addEvent("getAnfrageBackFriendlist",true)
function getAnfrageBackFriendlist_func(name)
	if(MySQL_DatasetExist("tlt_friendrequest", "Fromname='"..getPlayerName(source).."' and Toname='"..name.."'"))then
		local query="DELETE FROM tlt_friendrequest WHERE Fromname='"..getPlayerName(source).."' and Toname='"..name.."'"
		mysql_query(handler,query)
	end	
	triggerEvent("getRequestAndFriendList",source)
	if(getPlayerFromName(name))then		
		triggerEvent("getRequestAndFriendList",getPlayerFromName(name))
	end
end
addEventHandler("getAnfrageBackFriendlist",getRootElement(),getAnfrageBackFriendlist_func)

addEvent("showMyPosFriendlist",true)
function showMyPosFriendlist_func(name)
	if not(vioGetElementData(source,"hasShownPosition")) then
		local red=math.random(0,255)
		local blue=math.random(0,255)
		local green=math.random(0,255)
		local player=getPlayerFromName(name)
		outputChatBox(string.format("Du hast %s deine Position gezeigt!", name),source,red,green,blue)
		outputChatBox(string.format("%s zeigt dir seine Position!", getPlayerName(source)),player,red,green,blue)
		vioSetElementData(source,"hasShownPosition",true)
		local blip=createBlipAttachedTo ( source, 0, 2, red,green,blue,255, 0, 999999.0, player )
		setTimer(deletemyPos,20000,1,blip,source)
	else
		showError(source,"Du kannst nur einer Person gleichzeitig und nur einmal alle 20 Sekunden deine Position zeigen")
	end
end
addEventHandler("showMyPosFriendlist",getRootElement(),showMyPosFriendlist_func)

function deletemyPos(lolo,player)
	destroyElement(lolo)
	vioSetElementData(player,"hasShownPosition",false)
end


addEvent("anstupsenFriendlist",true)
function anstupsenFriendlist_func(name)
	if(getPlayerFromName(name))then
		if not(vioGetElementData(source,"stups")) then
			local player=getPlayerFromName(name)
			outputChatBox(string.format("%s hat dich angestupst!", getPlayerName(source)),player,255,0,0)
			outputChatBox(string.format("Du hast %s angestupst!", name),source,255,0,0)		
			vioSetElementData(source,"stups",true)
			setTimer(deleteanstups,1000,1,source)
		else
			showError(source,"Du kannst jede Sekunde nur einmal jemand anstupsen!")	
		end
	else
		showError(source,"Dieser Spieler ist nicht online!")
	end
end
addEventHandler("anstupsenFriendlist",getRootElement(),anstupsenFriendlist_func)

function deleteanstups(player)
	vioSetElementData(player,"stups",false)
end

function aktualize_friendlist_element_data(thePlayer)
	local friendlistTable={}
	local privquery="SELECT * FROM tlt_friendlist WHERE Nickname='"..getPlayerName(thePlayer).."'"
	result=mysql_query(handler,privquery)
	if( not result) then
		 outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else			
		while (mysql_num_rows(result)>zahler) do
			local dasatz = mysql_fetch_assoc(result)	
			table.insert(friendlistTable,dasatz["Friendname"])
		end
	end
	vioSetElementData(thePlayer,"friendlist_table",friendlistTable)
end

addEvent("deleteFromFriendlist_Event",true)
function deleteFromFriendlist_func(name)
	local query="DELETE FROM tlt_friendlist WHERE Nickname='"..getPlayerName(source).."' and Friendname='"..name.."'"
	mysql_query(handler,query)
	query="DELETE FROM tlt_friendlist WHERE Friendname='"..getPlayerName(source).."' and Nickname='"..name.."'"
	mysql_query(handler,query)
	showError(source,string.format("%s wurde von deiner Freundschaftsliste gelöscht!", name))
	aktualize_friendlist_element_data(source)
	if(getPlayerFromName(name))then
		aktualize_friendlist_element_data(getPlayerFromName(name))
		showError(source,string.format("Du wurdest von %s Freundschaftsliste gelöscht!", getPlayerName(source)))
		triggerEvent("getRequestAndFriendList",getPlayerFromName(name))
	end
	triggerEvent("getRequestAndFriendList",source)
end
addEventHandler("deleteFromFriendlist_Event",getRootElement(),deleteFromFriendlist_func)








