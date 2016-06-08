addEvent("SendeMirMeineEmailsZu",true)
function SendeMirMeineEmailsZu_func()
	local query="SELECT * FROM emails WHERE Empfaenger='"..getPlayerName(source).."'"
	local result=mysql_query(handler,query)
	local emailTable={}
	if( not result) then
		 outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
	else			
		local zahler=0
		while (mysql_num_rows(result)>zahler) do
			local dasatz = mysql_fetch_assoc(result)
			--{Empfänger,Sender,Datum,betreff,Inhalt,new=true,dbid}
			local readbool=false
			if(dasatz["neu"]=="1")then
				readbool=true
			end
			table.insert(emailTable,{dasatz["Empfaenger"],dasatz["Sender"],dasatz["Datum"],dasatz["Betreff"],dasatz["Inhalt"],readbool,tonumber(dasatz["ID"])})
			--outputChatox(dasatz["Empfaenger"])
			zahler=zahler+1
		end
	end
	triggerClientEvent(source,"hierdeineemails",source,emailTable)

end
addEventHandler("SendeMirMeineEmailsZu",getRootElement(),SendeMirMeineEmailsZu_func)


addEvent("setEMailReaded",true)
function setEMailReaded_func(id)
	local query="UPDATE emails SET neu='0' WHERE ID='"..id.."'"
	--outputDebugString(query)
	mysql_query(handler,query)
end
addEventHandler("setEMailReaded",getRootElement(),setEMailReaded_func)

addEvent("deleteEMail",true)
function deleteEMail_func(id)
	local query="DELETE FROM emails WHERE ID='"..id.."'"
	mysql_query(handler,query)
end
addEventHandler("deleteEMail",getRootElement(),deleteEMail_func)

addEvent("sendEMail",true)
function sendEMail_func(empfaenger,betreff,inhalt)
	local sender=getPlayerName(source)
	if (MySQL_DatasetExist("players","Nickname='"..empfaenger.."'" ))then
		if not(vioGetElementData(source,"sendEMailLastSec"))then
			inhalt=mysql_escape_string( handler, inhalt )
			betreff=mysql_escape_string( handler, betreff)
			local query="INSERT INTO emails (Empfaenger,Sender,Betreff,Inhalt) VALUES ('"..empfaenger.."','"..sender.."','"..betreff.."','"..inhalt.."');"
			mysql_query(handler,query)
			outputChatBox("EMail wurde versendet!",source,0,255,0)
			vioSetElementData(source,"sendEMailLastSec",true)
			setTimer(vioSetElementData,5000,1,source,"sendEMailLastSec",false)
		else
			outputChatBox("Du kannst nur alle 5 Sekunden eine EMail schreiben!",source,255,0,0)
		end
	else
		outputChatBox("Dieser Empfänger existiert nicht!",source,255,0,0)
	end
end
addEventHandler("sendEMail",getRootElement(),sendEMail_func)








