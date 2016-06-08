--
-- Created by IntelliJ IDEA.
-- User: Geramy
-- Date: 31.07.2014
-- Time: 20:15
-- To change this template use File | Settings | File Templates.
--

function checkAdditionalPunishment(thePlayer)

    checkAdditionalPunishment_offline(getPlayerName(thePlayer))
end

function checkAdditionalPunishment_offline(playerName)

    local query="SELECT * FROM bewaehrungsstrafen WHERE Nickname='"..playerName.."'"
    local result=mysql_query(handler,query)
    local tryKickPlayer=false

    local zahler=0
    if(mysql_num_rows(result)>0)then
        while (mysql_num_rows(result)>zahler) do
            local dasatz = mysql_fetch_assoc(result)
            local time=getTimestamp()
            if(time<tonumber(dasatz["until"]))then
                if(tonumber(dasatz["warn"])>0)then
                    for i=0,tonumber(dasatz["warn"]),1 do
                        local qquery="INSERT INTO warns (Admin,Grund,Nickname) VALUES ('"..dasatz["Adminname"].."','"..dasatz["Grund"].."','"..dasatz["Nickname"].."')"
                        mysql_query(handler,qquery)

                    end
                    save_offline_message(dasatz["Nickname"],"Bewährungssystem","Durch dein Fehlverhalten wurde deine Bewährungsstrafe nun durchgeführt und du hast "..dasatz["warn"].." Warns erhalten")

                    if(MySQL_GetResultsCount("warns","Nickname='"..dasatz["Nickname"].."'")>2)then
                        local serial=MySQL_GetString("players","Serial","Nickname='"..dasatz["Nickname"].."'")
                        local qquery="INSERT INTO ban (Nickname,Serial,IP,Grund,Admin) VALUES ('"..dasatz["Nickname"].."','"..serial.."','0','3 Warns','Warnsystem')"
                        mysql_query(handler,qquery)
                        tryKickPlayer=true
                    end
                end
                if(tonumber(dasatz["tban"])>0)then
                    local qquery="INSERT INTO timeban (Nickname,Grund,Admin,Minuten) VALUES ('"..dasatz["Nickname"].."','Bewährungsstrafe: "..dasatz["Grund"].."','"..dasatz["Adminname"].."','"..dasatz["tban"].."')"
                    mysql_query(handler,qquery)
                    save_offline_message(dasatz["Nickname"],"Bewährungssystem","Durch dein Fehlverhalten wurde deine Bewährungsstrafe nun durchgeführt und du hast einen Timeban erhalten")
                    tryKickPlayer=true
                end
                if(tonumber(dasatz["perma"])>0)then
                    local serial=MySQL_GetString("players","Serial","Nickname='"..dasatz["Nickname"].."'")
                    local qquery="INSERT INTO ban (Nickname,Serial,IP,Grund,Admin) VALUES ('"..dasatz["Nickname"].."','"..serial.."','0','Bewährungsstrafe: "..dasatz["Grund"].."','"..dasatz["Adminname"].."')"
                    mysql_query(handler,qquery)
                    tryKickPlayer=true
                end
            end




            mysql_query(handler,"DELETE FROM bewaehrungsstrafen WHERE ID='"..dasatz["ID"].."'")

            if(tryKickPlayer)then
               if(getPlayerFromName(playerName))then
                   setTimer(kickMeIfYouCan,10000,1,getPlayerFromName(playerName))
               end
            end
            zahler=zahler+1
        end
    end
end

function kickMeIfYouCan(thePlayer)
    kickPlayer(thePlayer,"Deine Bewährungsstrafe wurde durch dein Fehlverhalten fällig")
end








