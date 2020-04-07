---logMessageWithStackTrace
---@param level number - can be:
--- 0: "Custom" message.
--- 1: Error message.
--- 2: Warning message.
--- 3: Information message.
---
---@param message string - message
---@param additionalData table - table with additional data stuff
function logMessageWithStackTrace(level, message, additionalData)
    local callInfo = debug.getinfo(2);
    local stackTrace = debug.traceback();
    storeLogEntriesAsjson(message, level, callInfo.source, callInfo.linedefined, getRealTime(), stackTrace, additionalData)
end

addEventHandler("onDebugMessage", getRootElement(),
        function(message, level, file, line)
            local stackTrace = debug.traceback();
            storeLogEntriesAsjson(message, level, file, line, getRealTime(), stackTrace, nil, {})
        end)

LOG_LEVEL = {
    CUSTOM_MSG = 0,
    ERROR = 1,
    WARNING = 2,
    INFO = 3
}
