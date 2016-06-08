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

function MySQL_GetVar(tablename, feldname, bedingung)

    local result = mysql_query(handler, "SELECT " .. feldname .. " from " .. tablename .. "  WHERE " .. bedingung)
    local sendetquery = "SELECT " .. feldname .. " from " .. tablename .. "  WHERE " .. bedingung
    if (not result) then
        outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
        outputDebugString("ErrorQuery: " .. sendetquery)
    else
        if (mysql_num_rows(result) > 0) then
            local dsatz = mysql_fetch_assoc(result)
            local savename = feldname
            mysql_free_result(result)
            return tonumber(dsatz[feldname])
        else
            mysql_free_result(result)
            return false
        end
    end
end

function MySQL_GetString(tablename, feldname, bedingung)

    local result = mysql_query(handler, "SELECT " .. feldname .. " from " .. tablename .. "  WHERE " .. bedingung)
    local sendetquery = "SELECT " .. feldname .. " from " .. tablename .. "  WHERE " .. bedingung
    if (not result) then
        outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
        outputDebugString("ErrorQuery: " .. sendetquery)
    else
        if (mysql_num_rows(result) > 0) then
            local dsatz = mysql_fetch_assoc(result)
            local savename = feldname
            mysql_free_result(result)
            return dsatz[feldname]
        else
            mysql_free_result(result)
            return false
        end
    end
end

function MySQL_SetVar(tablename, feldname, var, bedingung)

    if (type(var) == "table") then
        outputDebugString("ErrorHelp MySQL_SetVar: " .. debug.traceback())
    else
        if var then
            local result = mysql_query(handler, "UPDATE " .. tablename .. " SET " .. feldname .. " = '" .. var .. "' WHERE " .. bedingung .. ";")
            local sendetquery = "UPDATE " .. tablename .. " SET " .. feldname .. " = '" .. var .. "' WHERE " .. bedingung .. ";"
            if (not result) then
                outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
                outputDebugString("Errorquery: " .. sendetquery)
            else
                mysql_free_result(result)
                return false
            end
        end
    end
end

function MySQL_DelRow(tablename, bedingung)

    local result = mysql_query(handler, "DELETE FROM " .. tablename .. " WHERE " .. bedingung)
    if (not result) then
        outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
    else
        mysql_free_result(result)
        return false
    end
end

function MySQL_SetString(tablename, feldname, var, bedingung)

    if var then
        local result = mysql_query(handler, "UPDATE " .. tablename .. " SET " .. feldname .. " = '" .. var .. "' WHERE " .. bedingung .. ";")
        local sendetquery = "UPDATE " .. tablename .. " SET " .. feldname .. " = '" .. var .. "' WHERE " .. bedingung .. ";"
        if (not result) then
            outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
            outputDebugString("Errorquery: " .. sendetquery)
        else
            mysql_free_result(result)
            return false
        end
    end
end

function MySQL_DatasetExist(tablename, bedingung)

    local result = mysql_query(handler, "SELECT * from " .. tablename .. " WHERE " .. bedingung)
    if (not result) then
        outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
    else
        if (mysql_num_rows(result) > 0) then
            mysql_free_result(result)
            return true
        else
            mysql_free_result(result)
            return false
        end
    end
end

function MySQL_GetResultsCount(tablename, bedingung)

    local result = mysql_query(handler, "SELECT count(*) as Anzahl from " .. tablename .. "  WHERE " .. bedingung)
    if (not result) then
        outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
    else
        if (mysql_num_rows(result) > 0) then
            local dsatz = mysql_fetch_assoc(result)
            mysql_free_result(result)
            return tonumber(dsatz["Anzahl"])
        else
            mysql_free_result(result)
            return 0
        end
    end
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
    local result = _mysql_query(handler, query)
    if (not result) then
        outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
        save_log("mysql_error", "Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler) .. "\nQuery: " .. query)
        return false
    else
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
