--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 26.04.14
-- Time: 23:52
-- To change this template use File | Settings | File Templates.
--

function syncYourTimeDeliver()
    setTimer(syncYourTimeDeliver,600000,1)
    local time = getRealTime()
    triggerClientEvent(getRootElement(),"syncYourTime",getRootElement(),time.hour,time.minute)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),syncYourTimeDeliver)








