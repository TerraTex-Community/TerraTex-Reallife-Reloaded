function web_BanNick(nickname, adminname, reason)
	local adminelement=getPlayerFromName(adminname)
	local userelement=getPlayerFromName(nickname)	
	if(adminelement and userelement)then
		if(isPlayerLoggedIn(userelement))then
			ban_func(adminelement,"rban",nickname,reason)
			return 1;
		else
			kickPlayer(userelement,reason)
			outputChatBox(string.format("Der Spieler %s wurde von %s (Offline) gebannt. Grund :%s", nickname, adminname, reason),getRootElement(),255,0,0)		
			return 0;
		end
	else
		if(userelement)then	
			if(isPlayerLoggedIn(userelement))then
				local IP=getPlayerIP(userelement)
				local Serial=getPlayerSerial(userelement)
				local reasons=mysql_escape_string(handler,reason)

				local querys="INSERT INTO Ban (Nickname,Serial,IP,Grund,Admin) VALUES ('"..nickname.."','".. Serial.."','".. IP .."','"..reason.."','"..adminname.."');"
				local result=mysql_query(handler,querys)	
				mysql_free_result (result)
				outputChatBox(string.format("Der Spieler %s wurde von %s (Offline) gebannt. Grund :%s", nickname, adminname, reason),getRootElement(),255,0,0)
				kickPlayer(userelement,reason)
				return 1;
			else
				kickPlayer(userelement,reason)
				outputChatBox(string.format("Der Spieler %s wurde von %s (Offline) gebannt. Grund :%s", nickname, adminname, reason),getRootElement(),255,0,0)		
				return 0;
			end	
		else
			return 0;
		end	
	end
end


function web_TimeBanNick(nickname, adminname,timer,reason)
    checkAdditionalPunishment_offline(nickname)
	local adminelement=getPlayerFromName(adminname)
	local userelement=getPlayerFromName(nickname)	
	if(adminelement and userelement)then		
		if(isPlayerLoggedIn(userelement))then
			tban_func(adminelement,"tban",nickname,timer,reason)
			return 1;
		else
			kickPlayer(userelement,reason)
			outputChatBox(string.format("Der Spieler %s wurde von %s (Offline) time-gebannt. Grund :%s", nickname, adminname, reason),getRootElement(),255,0,0)		
			return 0;
		end
	else
		if(userelement)then			
			if(isPlayerLoggedIn(userelement))then
				local kicktext=""
				local kickreason=""
				local kicktime=0
				
				local timer=tonumber(timer)
				if(timer<0)then
					timer=-timer
					kicktime=timer
					kicktext=string.format("%s wurde von %s (Offline) für %s Minuten gebannt! Grund: %s", nickname, adminname, timer, reason)
					kickreason=string.format("Du wurdest von %s (Offline) für %s Minuten gebannt! Grund: %s", adminname, timer, reason)
				else
					kicktime=timer*60
					kicktext=string.format("%s wurde von %s (Offline) für %s Stunden gebannt! Grund: %s", nickname, adminname, timer, reason)
					kickreason=string.format("Du wurdest von %s (Offline) für %s Stunden gebannt! Grund: %s", adminname, timer, reason)
					if(timer>24)then
						vioSetElementData(userelement,"tbans",vioGetElementData(userelement,"tbans")+1)
						if(vioGetElementData(userelement,"tbans")==1)then
							MySQL_SetVar("userdata", "tban_reason1", reason, "Nickname='"..nickname.."'")
						else						
							local tban_reason=MySQL_GetString("userdata","tban_reason1","Nickname='"..nickname.."'")
							local newreason="2 Timebans: "..tban_reason.." + "..reason
							kicktext=kicktext.." + autowarn für 2 Timebans"
							kickreason=kickreason.." + autowarn für 2 Timebans"
							MySQL_SetVar("userdata", "tban_reason1", "no_reason","Nickname='"..nickname.."'")
							web_WarnNick(nickname, adminname,newreason)
						end						
					end
				end
				outputChatBox(kicktext,getRootElement(),255,0,0)
				-- if(isElement(userlement))then
					local pser=getPlayerSerial(userelement)
					local query="INSERT INTO timeban (Nickname,Serial,Admin,Grund,Minuten) VALUES ('"..nickname.."','"..pser.."','"..adminname.."','"..reason.."','"..kicktime.."')"
					local result=mysql_query(handler,query)
					mysql_free_result (result)
					kickPlayer(userelement,kickreason)
				-- end					
	
				return 1;
			else
				kickPlayer(userelement,reason)
				outputChatBox(string.format("Der Spieler %s wurde von %s (Offline) time-gebannt. Grund :%s", nickname, adminname, reason),getRootElement(),255,0,0)		
				return 0;
			end
		else
			return 0;
		end	
	end	
end

function web_WarnNick(nickname, adminname,reason)
    checkAdditionalPunishment_offline(nickname)
	local adminelement=getPlayerFromName(adminname)
	local userelement=getPlayerFromName(nickname)	
	if(adminelement and userelement)then
		if(isPlayerLoggedIn(userelement))then
			warn_func(adminelement,"warn",nickname,reason)
			return 1;
		else
			kickPlayer(userelement,reason)
			return 0;
		end
	else
		if(userelement)then	

			if(isPlayerLoggedIn(userelement))then
		
				local querys="INSERT INTO warns (Nickname,Admin,Grund) VALUES ('"..nickname.."','"..adminname.."','"..reason.."');"
				local result=mysql_query(handler,querys)	
				mysql_free_result (result)
				outputChatBox(string.format("Der Spieler %s wurde von %s (Offline) verwarnt. Grund :%s", nickname, adminname, reason),getRootElement(),255,0,0)
				vioSetElementData(userelement,"warns",vioGetElementData(userelement,"warns")+1)
				local IP=getPlayerIP(userelement)
				local Serial=getPlayerSerial(userelement)
				if(vioGetElementData(userelement,"warns")>2)then
					reasons=mysql_escape_string(handler,reason)
					pname=mysql_escape_string(handler,nickname)
					local querys="INSERT INTO Ban (Nickname,Serial,IP,Grund,Admin) VALUES ('"..nickname.."','".. Serial.."','".. IP .."','3 Warns','"..adminname.."');"
					local result=mysql_query(handler,querys)	
					mysql_free_result (result)
					outputChatBox(string.format("Der Spieler %s wurde von der Console gebannt. Grund : 3 Warns", nickname),getRootElement(),255,0,0)
					kickPlayer(userelement,reasons)					
				end			
				return 1;				
			else
				kickPlayer(userelement,reason)
				return 0;
			end
		else
			return 0;
		end	
	end	
end








