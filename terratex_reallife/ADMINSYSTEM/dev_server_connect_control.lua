--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 13.02.14
-- Time: 13:41
-- To change this template use File | Settings | File Templates.
--


--[[  CONFIG BEREICH   ]]
local deleteNullAfterDays=30

--[[ SCRIPT ]]
function onPlayerDevServerConnect(nickname)
    local nicknameSecure=mysql_escape_string( handler, nickname )
    if(fileExists(":"..getResourceName(getThisResource()).."/devmode.dev")) then
        local isDev=MySQL_GetVar("players","isDeveloper","Nickname LIKE '"..nicknameSecure.."'")
        if(isDev)then
            if(isDev==0)then
                local timeQuery="Nickname='"..nicknameSecure.."' and TIMEDIFF(fromTimestamp, NOW())<0 and (TIMEDIFF(toTimestamp, NOW())>0 or toTimestamp IS NULL)"
                if(not MySQL_DatasetExist("dev_beta",timeQuery))then
                    cancelEvent(true,"Der Developmentserver von "..config["communityname"].." ist nur für Entwickler und ausgewähle Betatester gedacht!")
                end
            end
        else
            cancelEvent(true,"Der Developmentserver von "..config["communityname"].." ist nur für Entwickler und ausgewähle Betatester gedacht!")
        end
        --[[QUERY DELETES]]
        local delQuery="TIMEDIFF(fromTimestamp, NOW())<0 AND (TIMEDIFF(toTimestamp, NOW()))<0"
        MySQL_DelRow("dev_beta",delQuery)
        if(deleteNullAfterDays>0)then
            delQuery="DATEDIFF(DATE(fromTimestamp), DATE(NOW()))<-"..deleteNullAfterDays.." and toTimestamp IS NULL"
            MySQL_DelRow("dev_beta",delQuery)
        end
    end
end
addEventHandler("onPlayerConnect",getRootElement(),onPlayerDevServerConnect)









