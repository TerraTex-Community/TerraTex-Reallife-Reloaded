function debug.print(value)
    if not (type(value) == "table") then
        outputDebugString("Value [" .. type(value) .. "] = " .. tostring(value));
    else
        outputDebugString("Value [table] =")

        debug.table(value, 1)
    end
end

function debug.table(tablevalue, step)
    if not step then step = 1 end

    local prestring = ""
    for i = 0, step, 1 do
        prestring = prestring .. "\t"
    end

    for theKey, theValue in pairs(tablevalue) do
        if not (type(theValue) == "table") then
            outputDebugString(prestring .. tostring(theKey) .. "[" .. type(theValue) .. "] = " .. tostring(theValue));
        else
            outputDebugString(prestring .. tostring(theKey) .. "[table] = ")
            debug.table(theValue, step + 1)
        end
    end
end


---try catch function - errors will be stored on Server directly
---@param func function that should be called
---@param ... any parameters of functions
---@return boolean, any|nil Status, Value
function debug.tryAndCatch(func, ...)
    local status, errorOrValue = pcall(func, ...)
    if (status == false) then
        logMessageWithStackTrace(1, errorOrValue)
        return false, nil
    else
        return true, errorOrValue
    end
end


