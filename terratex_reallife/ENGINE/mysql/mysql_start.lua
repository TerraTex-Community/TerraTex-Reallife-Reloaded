if not mysql_query then
    outputServerLog("Das MySQL Module wurde nicht installiert. Die Resource wird gestoppt..")
    stopResource(getThisResource())
end

function MySQL_Startup()
    if (handler) then
        if (pcall(MySQL_END)) then end
    end

    --Read Login Data From Config
    gMysqlHost = config["mysqlhost"]
    gMysqlUser = config["mysqluser"]
    gMysqlPass = config["mysqlpassword"]
    gMysqlDatabase = config["mysqldb"]

    handler = mysql_connect(gMysqlHost, gMysqlUser, gMysqlPass, gMysqlDatabase)
    logs_handler = handler

    if (not handler) then
        outputDebugString("Couldn't run query: Unable to connect to the MySQL server!")
        outputDebugString("Please shutdown the server and start the MySQL server!")
    else
        mysql_query(handler, "SET NAMES 'utf8'; ");
    end
end

function MySQL_End()
    mysql_close(handler)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), MySQL_Startup)

function Mysql_CheckConnection()
    if (handler) then
        if (not mysql_ping(handler)) then
            MySQL_Startup()
        end
    end
end

_mysql_query = mysql_query
function mysql_query(handler, query)
    Mysql_CheckConnection(handler)
    local times = getRealTime()
    outputDebugString("Execute Old Query: " .. query)
    local result = _mysql_query(handler, query)
    if (not result) then
        outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
        save_log("mysql_error", "Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler) .. "\nQuery: " .. query)
        return false
    else
        return result
    end
end

