--serversettings["Max_User"]

function top_on_player_join()
	local maxUsers=getPlayerCount()
	
	local timer=getRealTime()
	
	
	if(not MySQL_DatasetExist("top_user_daily", "date=CURDATE()"))then
		local query="INSERT INTO top_user_daily (date,user) VALUES (CURDATE(),'"..maxUsers.."')"
		mysql_query(handler,query)			
	end
	
	local query="UPDATE top_user_daily SET user='"..maxUsers.."' WHERE user<"..maxUsers.." and date=CURDATE()"
	mysql_query(handler,query)
	
	local value=MySQL_GetVar("serversettings", "Wert", "Name='Max_Users'")
		
	if(value<maxUsers)then
		MySQL_SetVar("serversettings", "Wert", maxUsers, "Name='Max_Users'")
	end
	--Max_Users

end
addEventHandler("onPlayerJoin",getRootElement(),top_on_player_join)








