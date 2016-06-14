--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 13.02.14
-- Time: 13:41
-- To change this template use File | Settings | File Templates.
--


--[[  CONFIG BEREICH   ]]
local deleteNullAfterDays = 30

--[[ SCRIPT ]]
function onPlayerDevServerConnect(nickname)
    if (fileExists(":" .. getResourceName(getThisResource()) .. "/devmode.dev")) then
        local isDev = MySql.helper.getValueSync("user", "isDeveloper", { Nickname = nickname });
        if (isDev) then
            if (isDev == 0) then
                local execQ = dbQuery(MySql._connection, "SELECT count(*) as anzahl FROM admin_dev_access WHERE Nickname = ? AND TIMEDIFF(fromTimestamp, NOW())<0 and (TIMEDIFF(toTimestamp, NOW())>0 or toTimestamp IS NULL)", nickname);
                local result = dbPoll(execQ, -1);
                if (tonumber(result[1]["anzahl"]) > 0) then
                    cancelEvent(true, "Der Developmentserver von " .. config["communityname"] .. " ist nur für Entwickler und ausgewähle Betatester gedacht!")
                end
            end
        else
            cancelEvent(true, "Der Developmentserver von " .. config["communityname"] .. " ist nur für Entwickler und ausgewähle Betatester gedacht!")
        end

        local conditionTable = {};
        conditionTable["TIMEDIFF(fromTimestamp, NOW())"] = { "<", 0 };
        conditionTable["TIMEDIFF(toTimestamp, NOW())"] = { "<", 0 };

        MySql.helper.delete("admin_dev_access", conditionTable)
        if (deleteNullAfterDays > 0) then
            dbExec(MySql._connection, "DELETE FROM admin_dev_access WHERE DATEDIFF(DATE(fromTimestamp), DATE(NOW()))< ? and toTimestamp IS NULL", -deleteNullAfterDays);
        end
    end
end
addEventHandler("onPlayerConnect", getRootElement(), onPlayerDevServerConnect)









