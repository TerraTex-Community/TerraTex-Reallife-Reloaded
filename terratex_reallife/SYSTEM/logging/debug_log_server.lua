function store_client_debug_func(time, message, level, file, line)
    addLogEntryToBulk(getPlayerName(client), time, message, level, file, line)
end
addEvent("store_client_debug", true)
addEventHandler ( "store_client_debug", getRootElement(), store_client_debug_func, true, "low" )

local levelOptions = {
    [0] = "[CUSTOM]",
    [1] = "[ERROR]",
    [2] = "[WARNING]",
    [3] = "[INFO]",
}

local currentBulkTable = {}
local lastBulkTable = {}
function addLogEntryToBulk(username, time, message, level, file, line)
    -- add timestramp to log
    local entry = "[" .. time.monthday .. "." .. (time.month + 1) .. "." .. (time.year + 1900) .. " - " .. time.hour .. ":" .. time.minute .. ":" .. time.second .. "] ";
    -- add level
    entry = entry .. levelOptions[level].. " ";

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

function storeDebugLogEntries()
    lastBulkTable = currentBulkTable;
    currentBulkTable = {};

    for theKey, def in ipairs(lastBulkTable) do
        save_log("user_client_log/" .. def.username, def.entry)
    end
end

function onDebugStoreRunner()
    setTimer(storeDebugLogEntries, 600000, 0)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onDebugStoreRunner)
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), storeDebugLogEntries)
