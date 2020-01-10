function isEaster()
    local time = getRealTime()
    local year = time.year + 1900

    -- starts "Palmsonntag" until "Eastermonday"
    -- @info: Needs to be changed after 2030
    if (year == 2020) then -- 5.4. - 14.4.
        return (time.month == 3 and time.monthday >=5 and time.monthday <= 13);
    elseif (year == 2021) then -- 28.3. - 5.4.
        return (time.month == 3 and time.monthday >=1 and time.monthday <= 5) or
            (time.month == 2 and time.monthday >=28);
    elseif (year == 2022) then -- 10.4. - 18.4.
        return (time.month == 3 and time.monthday >=10 and time.monthday <= 18);
    elseif (year == 2023) then -- 2.4. - 10.4.
        return (time.month == 3 and time.monthday >=2 and time.monthday <= 10);
    elseif (year == 2024) then -- 24.3. - 1.4.
        return (time.month == 2 and time.monthday >= 24) or
                (time.month == 3 and time.monthday == 1);
    elseif (year == 2025) then --13.4. - 21.4.
        return (time.month == 3 and time.monthday >=13 and time.monthday <= 21);
    elseif (year == 2026) then --29.4. - 6.4.
        return (time.month == 3 and time.monthday >=1 and time.monthday <= 21) or
                (time.month == 2 and time.monthday >= 29);
    elseif (year == 2027) then  --21.3. - 17.3.
        return (time.month == 2 and time.monthday >=21 and time.monthday <= 29);
    elseif (year == 2028) then  --9.4. - 17.4.
        return (time.month == 3 and time.monthday >=9 and time.monthday <= 17);
    elseif (year == 2029) then  --25.3. - 2.4.
        return (time.month == 3 and time.monthday >=1 and time.monthday <= 2) or
                (time.month == 2 and time.monthday >= 25);
    elseif (year == 2030) then -- 14.04. - 22.04.
        return (time.month == 3 and time.monthday >=14 and time.monthday <= 22);
    end
end
