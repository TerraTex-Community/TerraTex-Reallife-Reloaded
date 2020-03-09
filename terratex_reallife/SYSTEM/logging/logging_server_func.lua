---logMessageWithStackTrace
---@param level number - can be:
--- 0: "Custom" message.
--- 1: Error message.
--- 2: Warning message.
--- 3: Information message.
---
---@param message string - message
function logMessageWithStackTrace(level, message)
    local callInfo = debug.getinfo(2);
    storeLogEntriesAsjson(message, level, callInfo.source, callInfo.linedefined, getRealTime(), debug.traceback())
end

addEventHandler("onDebugMessage", getRootElement(),
        function(message, level, file, line)
            storeLogEntriesAsjson(message, level, file, line, getRealTime(), debug.traceback())
        end)

LOG_LEVEL = {
    CUSTOM_MSG = 0,
    ERROR = 1,
    WARNING = 2,
    INFO = 3
}
