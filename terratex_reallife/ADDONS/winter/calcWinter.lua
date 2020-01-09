function isWinter()
    local time = getRealTime();
    if (time.month == 10 and time.monthday >= 15) or time.month == 11
            or time.month == 0 or (time.month == 1 and time.monthday <= 15)then
        return true;
    end
    return false;
end
