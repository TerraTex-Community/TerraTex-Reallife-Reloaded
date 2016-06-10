if not mysql_query then
    outputServerLog("Das MySQL Module wurde nicht installiert. Die Resource wird gestoppt..")
    stopResource(getThisResource())
end

-- _mysql_error = mysql_error

-- function mysql_error(...)
-- 	outputDebugString(debug.traceback())
-- 	return _mysql_error(...)
-- end

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
--        outputDebugString("[" .. times.monthday .. "." .. (times.month + 1) .. "." .. (times.year + 1900) .. " - " .. times.hour .. ":" .. times.minute .. ":" .. times.second .. "] got result")
        return result
    end
end

mysql = {}
mysql.__index = mysql

function mysql.getFirstTableRow(handlers, tablename, bedingung)
    local query = "SELECT * FROM " .. tablename .. " WHERE " .. bedingung
    local result = mysql_query(handlers, query)
    if (not result) then
        outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
    else
        if (mysql_num_rows(result) > 0) then
            local dsatz = mysql_fetch_assoc(result)
            mysql_free_result(result)
            return dsatz
        else
            return false
        end
    end
end
