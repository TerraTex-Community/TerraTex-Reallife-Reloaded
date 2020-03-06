addEvent("syncYourTime",true)
function syncMyTime(hour,minute)
    setMinuteDuration ( 60000)
    setTime(hour,minute)
end
addEventHandler("syncYourTime",getRootElement(),syncMyTime)
