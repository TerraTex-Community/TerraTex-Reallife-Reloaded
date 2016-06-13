--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 09.06.2016
-- Time: 14:57
-- To change this template use File | Settings | File Templates.
--

MySql = {}
MySql._connection = false;

--- Starts Connection to Database for later mysql handling
MySql.init = function()
    local gMysqlHost = config["mysqlhost"];
    local gMysqlUser = config["mysqluser"];
    local gMysqlPass = config["mysqlpassword"];
    local gMysqlDatabase = config["mysqldb"];
    local gMysqlConnectString = "host=" .. gMysqlHost .. ";charset=utf8;dbname=" .. gMysqlDatabase;

    MySql._connection = dbConnect("mysql", gMysqlConnectString, gMysqlUser, gMysqlPass);
    -- @TODO: Is "SET NAMES 'utf8';" needed?

    if (not MySql._connection) then
        outputDebugString("MySQL-Error: Not possible to connect to database!", 1, 255, 0, 0);
        outputDebugString("Please edit config.lua and set a correct database configuration.", 1, 255, 0, 0);
        stopResource(getThisResource());
    end
end

MySql.helper = {};

local function prepareConditions(conditions, operation)
    local query = "";
    local params = {};

    if (conditions) then
        assert(type(conditions) == "table", "datatype table expected got " .. type(conditions));
        query = query .. " WHERE ";

        if (not operation) then operation = "AND" end
        local firstCondition = true;
        local compare, value, field;

        for theField, theValue in pairs(conditions) do
            if not firstCondition then
                query = query .. " " .. operation .. " ";
            else
                firstCondition = false;
            end
            compare = "=";
            value = theValue;
            field = theField;
            if (type(theValue) == "table") then
                if (table.getSize(theValue) == 2) then
                    compare = theValue[1];
                    value = theValue[2];
                else
                    compare = theValue[2];
                    value = theValue[3];
                    field = theValue[1];
                end
            end

            query = query .. "`??` " .. compare .. " ?";
            table.insert(params, field);
            table.insert(params, value);
        end
    end

    return query, params
end

--- Request Data from Database
-- @param tableName Name of the Table
-- @param fieldList "*" or table with colnames or {colname = alias, colname}
-- @param conditions Optional: Table with conditions (optional) Form: { "fieldName" = "value" } or { "fieldName" = { "copmarer", "value"}
-- @param operation Optional: How should the fields from the condition table concatinated (Default: AND)
MySql.helper.getSync = function(tableName, fieldList, conditions, operation)
    local query = "SELECT";
    local params = {};
    if (type(fieldList) == "table") then
        local firstSelect = true;
        for theKey, theValue in pairs(fieldList) do
            if (not firstSelect) then
                query = query .. ","
            else
                firstSelect = false;
            end
            if (not isNumeric(theKey)) then
                query = query .. " ?? AS ??";
                table.insert(params, theKey);
                table.insert(params, theValue);
            else
                query = query .. " ??";
                table.insert(params, theValue);
            end
        end
    else
        query = query .. " *";
    end

    query = query .. " FROM ?? ";
    table.insert(params, tableName);

    local conditionQuery, conditionParams = prepareConditions(conditions, operation);

    query = query .. conditionQuery;
    params = table.merge(params, conditionParams);

    local handler = dbQuery(MySql._connection, query, unpack(params));
    local result = dbPoll(handler, -1);

    return result;
end

--- Checks if there are datasets that pass the conditions
-- @param tableName Name of the Table
-- @param conditions Optional: Table with conditions (optional) Form: { "fieldName" = "value" } or { "fieldName" = { "copmarer", "value"}
-- @param operation Optional: How should the fields from the condition table concatinated (Default: AND)
MySql.helper.existSync = function(tableName, conditions, operation)
    local result = MySql.helper.getCountSync(tableName, conditions, operation);
    return (result and result > 0);
end

--- Returns how many lines will pass the conditions
-- @param tableName Name of the Table
-- @param conditions Optional: Table with conditions (optional) Form: { "fieldName" = "value" } or { "fieldName" = { "copmarer", "value"}
-- @param operation Optional: How should the fields from the condition table concatinated (Default: AND)
MySql.helper.getCountSync = function(tableName, conditions, operation)
    local query = "SELECT count(*) AS counted FROM `??`";
    local params = {};
    table.insert(params, tableName);

    local conditionQuery, conditionParams = prepareConditions(conditions, operation);

    query = query .. conditionQuery;
    params = table.merge(params, conditionParams);

    local handler = dbQuery(MySql._connection, query, unpack(params));
    local result, errorCode, errorString = dbPoll(handler, -1);
    if not result then
        outputDebugString("ERROR IN MySql.helper.getCountSync: " .. errorCode);
        outputDebugString(errorString);
        outputDebugString("in Query: " .. query .." Params: " .. table.concat(params, ", "));
        outputDebugString("Stacktrace: ");
        outputDebugString(debug.traceback());
    end
    return tonumber(result[1]["counted"]);
end


local function generateInsertQuery(tableName, insertValue)
    local query = "INSERT INTO `??` (";
    local params = {};
    local values = {};
    local valueQuery = "";
    table.insert(params, tableName);

    local firstInsert = true;
    for theKey, theValue in pairs(insertValue) do
        if (firstInsert) then
            firstInsert = false;
        else
            query = query ..",";
            valueQuery = valueQuery .. ",";
        end
        query = query .. "`??`";
        valueQuery = valueQuery .. "?";
        table.insert(params, theKey);
        table.insert(values, theValue);
    end

    query = query .. ") VALUES (" .. valueQuery .. ")";
    params = table.merge(params, values);

    return query, params
end

MySql.helper.insert = function(tableName, insertValues, callback, callbackParams)
    local query, params = generateInsertQuery(tableName, insertValues);

    if (callback) then
        if (callbackParams) then
            dbQuery(callback, callbackParams, MySql._connection, query, unpack(params));
        else
            dbQuery(callback, MySql._connection, query, unpack(params));
        end
    else
        dbExec(MySql._connection, query, unpack(params));
    end
end

MySql.helper.insertSync = function(tableName, insertValues)
    local query, params = generateInsertQuery(tableName, insertValues);

    local handler = dbQuery(MySql._connection, query, unpack(params));
    local result, rows, lastInsertId = dbPoll(handler, -1);

    if result then
        return lastInsertId;
    else
        outputDebugString("ERROR IN MySql.helper.insertSync: " .. errorCode);
        outputDebugString(errorString);
        outputDebugString("in Query: " .. query .." Params: " .. table.concat(params, ", "));
        outputDebugString("Stacktrace: ");
        outputDebugString(debug.traceback());
        return false;
    end
end

--- Deletes Content from database
-- @param tableName Name of the Table
-- @param conditions Optional: Table with conditions (optional) Form: { "fieldName" = "value" } or { "fieldName" = { "copmarer", "value"}
-- @param operation Optional: How should the fields from the condition table concatinated (Default: AND)
MySql.helper.delete = function(tableName, conditions, operation)
    local query = "DELETE FROM `??`";
    local params = {};
    table.insert(params, tableName);

    local conditionQuery, conditionParams = prepareConditions(conditions, operation);

    query = query .. conditionQuery;
    params = table.merge(params, conditionParams);

    return dbExec(MySql._connection, query, unpack(params));
end

--- Set a spezifc values to database
-- @param tableName Name of the Table
-- @param updateValues Table with the values that has to be updated Form: {"fieldName = "value"}
-- @param conditions Optional: Table with conditions (optional) Form: { "fieldName" = "value" } or { "fieldName" = { "copmarer", "value"}
-- @param operation Optional: How should the fields from the condition table concatinated (Default: AND)
MySql.helper.update = function(tableName, updateValues, conditions, operation)
    local query = "UPDATE `??` SET ";

    local params = {};
    table.insert(params, tableName);

    local isFirstUpdateValue = true;
    for column, value in pairs(updateValues) do
        if (not isFirstUpdateValue) then
            query = query .. ", ";
        else
            isFirstUpdateValue = false;
        end

        query = query .. "`??` = ?";
        table.insert(params, column);
        table.insert(params, value);
    end

    local conditionQuery, conditionParams = prepareConditions(conditions, operation);

    query = query .. conditionQuery;
    params = table.merge(params, conditionParams);

    return dbExec(MySql._connection, query, unpack(params));
end

--- Get a spezifc value from database
-- @param tableName Name of the Table
-- @param fieldName Name of Field where to find the value
-- @param conditions Optional: Table with conditions (optional) Form:{ "fieldName" = "value" } or { "fieldName" = { "copmarer", "value"}
-- @param operation Optional: How should the fields from the condition table concatinated (Default: AND)
-- @return theValue if success false otherwise or false if there are more then one row as result
MySql.helper.getValueSync = function(tableName, fieldName, conditions, operation)
    local query = "SELECT `??` FROM `??`";
    local params = {};
    table.insert(params, fieldName);
    table.insert(params, tableName);

    local conditionQuery, conditionParams = prepareConditions(conditions, operation);

    query = query .. conditionQuery;
    params = table.merge(params, conditionParams);

    local handler = dbQuery(MySql._connection, query, unpack(params));
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


-- init mysql
MySql.init();
