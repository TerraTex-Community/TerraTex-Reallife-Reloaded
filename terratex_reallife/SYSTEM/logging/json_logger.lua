local levelOptions = {
    [0] = "CUSTOM",
    [1] = "ERROR",
    [2] = "WARNING",
    [3] = "INFO",
}

local currentBulkTable = {}
local lastBulkTable = {}


---storeLogEntriesAsjson
---@param message string - message
---@param level number - can be:
--- 0: "Custom" message.
--- 1: Error message.
--- 2: Warning message.
--- 3: Information message.
---@param file string filename
---@param line number linenumber
---@param time table getRealTime()
---@param stacktrace string stacktrace
---@param user userdata|nil User or not if it is serversided
function storeLogEntriesAsjson(message, level, file, line, time, stacktrace, user)
    local logType = "client"
    if (not user) then
        user = "server"
        logType = "server"
    end

    local json = toJSON({
        message = message,
        level = levelOptions[level],
        file = file,
        line = line,
        time = time.timestamp * 1000,
        stacktrace = stacktrace,
        user = user,
        logType = logType
    }) .. "\n";

    table.insert(currentBulkTable, json);
end

function storeDebugLogEntriesInFile()
    lastBulkTable = currentBulkTable;
    currentBulkTable = {};

    for theKey, entry in pairs(lastBulkTable) do
        save_log("debug_json.log", entry, true)
    end
end


function onDebugStoreRunner()
    setTimer(storeDebugLogEntries, 600000, 0)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onDebugStoreRunner)
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), storeDebugLogEntries)
