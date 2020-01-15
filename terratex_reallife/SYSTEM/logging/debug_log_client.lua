addEventHandler ("onClientDebugMessage",getRootElement(),
function(message,level,file,line)
    triggerLatentServerEvent ( "store_client_debug", 5000, true, getLocalPlayer(), getRealTime(), message, level, file, line)
end)
