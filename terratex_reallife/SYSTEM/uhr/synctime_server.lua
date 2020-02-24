function syncYourTimeDeliver()
    setTimer(syncYourTimeDeliver,600000,1)
    local time = getRealTime()
    triggerClientEvent(getRootElement(),"syncYourTime",getRootElement(),time.hour,time.minute)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),syncYourTimeDeliver)
