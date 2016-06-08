--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 26.04.14
-- Time: 23:53
-- To change this template use File | Settings | File Templates.
--
addEvent("syncYourTime",true)
function syncMyTime(hour,minute)
    setMinuteDuration ( 60000)
    setTime(hour,minute)
end
addEventHandler("syncYourTime",getRootElement(),syncMyTime)










