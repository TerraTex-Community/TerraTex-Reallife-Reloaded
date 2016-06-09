--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 09.06.2016
-- Time: 14:57
-- To change this template use File | Settings | File Templates.
--

MySql = {}
MySql._mainConnection = false;

--- Starts Connection to Database for later mysql handling
MySql.init = function()
    local gMysqlHost = config["mysqlhost"];
    local gMysqlUser = config["mysqluser"];
    local gMysqlPass = config["mysqlpassword"];
    local gMysqlDatabase = config["mysqldb"];
    local gMysqlConnectString = "host=" .. gMysqlHost .. ";charset=utf8;dbname=" .. gMysqlDatabase;

    MySql._mainConnection = dbConnect("mysql", gMysqlConnectString, gMysqlUser, gMysqlPass);
    -- @TODO: Is "SET NAMES 'utf8';" needed?

    if (not MySql._mainConnection) then
        outputDebugString("MySQL-Error: Not possible to connect to database!", 1, 255, 0, 0);
        outputDebugString("Please edit config.lua and set a correct database configuration.", 1, 255, 0, 0);
        stopResource(getThisResource());
    end
end

-- Functions todo:
-- MySQL_GetVar(tablename, feldname, bedingung)
-- MySQL_GetString(tablename, feldname, bedingung)
-- MySQL_SetVar(tablename, feldname, var, bedingung)
-- MySQL_DelRow(tablename, bedingung)
-- MySQL_SetString(tablename, feldname, var, bedingung)
-- MySQL_DatasetExist(tablename, bedingung)
-- MySQL_GetResultsCount(tablename, bedingung)
-- function mysql_query(handler, query)
--  mysql.getFirstTableRow(handlers, tablename, bedingung)

MySql.helper = {};

local function prepareGetValueFunc(tableName, fieldName, conditions, operation)
    local query = "SELECT `??` FROM `??`";
    local params = {};
    table.insert(params, fieldName);
    table.insert(params, tableName);

    if (conditions) then
        assert(type(conditions) == "table", "datatype table expected got " .. type(conditions));
        query = query .. " WHERE ";

        if (not operation) then operation = "AND" end
        local firstCondition = true;

        for theField, theValue in pairs(conditions) do
            if not firstCondition then
                query = query .. " " .. operation .. " ";
            else
                firstCondition = false;
            end
            query = query .. "`??` = ?";
            table.insert(params, theField);
            table.insert(params, theValue);
        end
    end

    return query, params
end

--- Get a spezifc value from database
-- @param tableName Name of the Table
-- @param fieldName Name of Field where to find the value
-- @param conditions Optional: Table with conditions (optional) Form: { "fieldName": "value" }
-- @param operation Optional: How should the fields from the condition table concatinated (Default: AND)
-- @return theValue if success false otherwise or false if there are more then one row as result
MySql.helper.getFieldValueSync = function(tableName, fieldName, conditions, operation)
    local query, params = prepareGetValueFunc(tableName, fieldName, conditions, operation);

    local handler = dbQuery(MySql._mainConnection, query, unpack(params));
    local result, rows = dbPoll(handler, -1);
    if (rows == 1) then
        if (isNumeric(result[1][fieldName])) then
            return tonumber(result[1][fieldName]);
        else
            return result[1][fieldName];
        end
    else
        return false;
    end
end

--- Get a table with the values of a columns spezified by conditions
-- @param tableName Name of the Table
-- @param fieldName Name of Field where to find the value
-- @param conditions Optional: Table with conditions (optional) Form: { "fieldName": "value" }
-- @param operation Optional: How should the fields from the condition table concatinated (Default: AND)
-- @param callback Callbackfunction
-- @param callbackParams Params of callback
MySql.helper.getColumn = function(tableName, fieldName, conditions, operation, callback, callbackParams)
    if (type(conditions) == "function") then
        if (type(operation) == "table") then
            callbackParams = operation;
        end
        callback = conditions;
        conditions = nil;
        operation = nil;
    end

    if (type(operation) == "function") then
        if (type(callback) == "table") then
            callbackParams = callback;
        end
        callback = operation;
        operation = nil;
    end


    assert(type(callback) == "function", "Function as callback expected got " .. type(callback));

    local query, params = prepareGetVarFunc(tableName, fieldName, conditions, operation);

    if (type(operation) == "callbackParams") then
        dbQuery(callback, callbackParams, MySql._mainConnection, query, unpack(params))
    else
        dbQuery(callback, MySql._mainConnection, query, unpack(params))
    end
end

-- init mysql
MySql.init();
