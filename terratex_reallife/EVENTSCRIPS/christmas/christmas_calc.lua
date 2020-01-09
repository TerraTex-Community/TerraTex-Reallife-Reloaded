function isAdventDayToday()
    local time = getRealTime();
    if (time.weekday == 0 and (time.month == 10 and time.monthday >= 26 or time.month == 11 and time.monthday < 24)) or
            (time.month == 11 and (time.monthday >= 24 or time.monthday <= 26)) then
        return true;
    end
    return false;
end

function isChristmasTime()
    local time = getRealTime();
    if (time.month == 10 and time.monthday >= 15 or time.month == 11 or time.month == 0 and time.monthday <= 6) then
        return true;
    end
    return false;
end

function isAdventTime()
    local time = getRealTime();
    if (time.month == 11 and time.monthday <= 26) then
        return true;
    end
    return false;
end


