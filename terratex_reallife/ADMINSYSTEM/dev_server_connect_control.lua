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
    if(fileExists(":"..getResourceName(getThisResource()).."/devmode.dev")) then
        local isDev = MySql.helper.getValueSync("players", "isDeveloper", {Nickname = nickname});
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

        local conditionTable = {};
        conditionTable["TIMEDIFF(fromTimestamp, NOW())"] = {"<", 0};
        conditionTable["TIMEDIFF(toTimestamp, NOW())"] = {"<", 0};

        MySql.helper.delete("dev_beta", conditionTable)
        if(deleteNullAfterDays>0)then
            dbExec(MySql._connection, "DELETE FROM dev_beta WHERE DATEDIFF(DATE(fromTimestamp), DATE(NOW()))< ? and toTimestamp IS NULL", -deleteNullAfterDays);
        end
    end
end
addEventHandler("onPlayerConnect",getRootElement(),onPlayerDevServerConnect)









