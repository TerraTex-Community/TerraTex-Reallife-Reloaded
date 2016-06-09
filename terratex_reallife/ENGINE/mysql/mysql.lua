--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 09.06.2016
-- Time: 14:57
-- To change this template use File | Settings | File Templates.
--

MySql = {}
MySql.mainConnection = false;

MySql.init = function()
    local gMysqlHost = config["mysqlhost"];
    local gMysqlUser = config["mysqluser"];
    local gMysqlPass = config["mysqlpassword"];
    local gMysqlDatabase = config["mysqldb"];
    local gMysqlConnectString = "host=" .. gMysqlHost .. ";charset=utf8;dbname=" .. gMysqlDatabase;

    MySql.mainConnection = dbConnect ( "mysql", gMysqlConnectString, gMysqlUser, gMysqlPass);
    -- @TODO: Is "SET NAMES 'utf8';" needed?

    if (not MySql.mainConnection) then
        outputDebugString("MySQL-Error: Not possible to connect to database!", 1, 255, 0, 0);
        outputDebugString("Please edit config.lua and set a correct database configuration.", 1 , 255, 0, 0);
        stopResource(getThisResource());
    end
end

-- Run Init()
MySql.init();