function store_client_debug_func(time, message, level, file, line, stacktrace, data)
    addLogEntryToBulkFileWriter(getPlayerName(client), time, message, level, file, line)
    storeLogEntriesAsjson(message, level, file, line, time, stacktrace, getPlayerName(client), data)
end
addEvent("store_client_debug", true)
addEventHandler ( "store_client_debug", getRootElement(), store_client_debug_func, true, "low" )

local levelOptions = {
    [0] = "CUSTOM",
    [1] = "ERROR",
    [2] = "WARNING",
    [3] = "INFO",
}

local currentBulkTable = {}
local lastBulkTable = {}
function addLogEntryToBulkFileWriter(username, time, message, level, file, line)
    -- add timestramp to log
    local entry = "[" .. time.monthday .. "." .. (time.month + 1) .. "." .. (time.year + 1900) .. " - " .. time.hour .. ":" .. time.minute .. ":" .. time.second .. "] ";
    -- add level
    entry = entry .. "[".. levelOptions[level].. "] ";

    -- add file path if extist
    if (file) then
        entry = entry .. file .. ":"
    end

    -- add line if extist
    if (line) then
        entry = entry .. tostring(line) .. ": "
    end

    -- add message
    entry = entry .. message

    table.insert(currentBulkTable, {
        ["username"] = username,
        ["entry"] = entry
    });
end

function storeDebugLogEntriesInFile()
    lastBulkTable = currentBulkTable;
    currentBulkTable = {};

    local logsPerPlayer = {}

    for theKey, def in ipairs(lastBulkTable) do
        if (logsPerPlayer[def.username] == nil) then
            logsPerPlayer[def.username] = ""
        end
        logsPerPlayer[def.username] = logsPerPlayer[def.username] .. def.entry .. "\n"
    end

    for username, entry in pairs(logsPerPlayer) do
        save_log("user_client_logs/" .. username, entry, true)
    end
end


function onDebugStoreRunner()
    setTimer(storeDebugLogEntriesInFile, 120000, 0)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onDebugStoreRunner)
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), storeDebugLogEntriesInFile)
