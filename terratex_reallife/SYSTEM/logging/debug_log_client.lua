addEventHandler ("onClientDebugMessage",getRootElement(),
function(message,level,file,line)
    triggerLatentServerEvent ( "store_client_debug", 5000, true, getLocalPlayer(), getRealTime(), message, level, file, line, debug.traceback())
end)

---logMessageWithStackTrace
---@param level number - can be:
--- 0: "Custom" message.
--- 1: Error message.
--- 2: Warning message.
--- 3: Information message.
---
---@param message string - message
---@param additionalData table - table with additionalData
function logMessageWithStackTrace(level, message, additionalData)
    local callInfo = debug.getinfo(2);

    triggerLatentServerEvent ( "store_client_debug", 5000, true, getLocalPlayer(), getRealTime(), message, level, callInfo.source, callInfo.linedefined, debug.traceback())
end

LOG_LEVEL = {
    CUSTOM_MSG = 0,
    ERROR = 1,
    WARNING = 2,
    INFO = 3
}
