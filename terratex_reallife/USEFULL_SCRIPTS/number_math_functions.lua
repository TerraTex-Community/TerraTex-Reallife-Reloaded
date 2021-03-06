function isNumeric(a)
    return type(tonumber(a)) == "number"
end

function math.round(number, decimals, method)
    if not number then
        if getLocalPlayer then
            triggerServerEvent("debugClientError", getLocalPlayer(), "[Math.round] Number expected got nil", debug.traceback());
        end
        assert(false, "[Math.round] Number expected got nil");
    end

    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then
        return math[method](number * factor) / factor
    else
        return tonumber(("%." .. decimals .. "f"):format(number))
    end
end

function toprice(number)
    local var = math.round(number, 2)
    local stringsbevor = math.Tausend(var)
    return "$ " .. stringsbevor
end

function math.Tausend(v)
    local isnegetive = false
    if (v < 0) then
        isnegetive = true
        v = -v
    end
    local s = string.format("%d", math.floor(v))
    local pos = string.len(s) % 3
    if pos == 0 then
        pos = 3
    end
    if (not (isnegetive)) then
        return string.sub(s, 1, pos)
                .. string.gsub(string.sub(s, pos + 1), "(...)", ",%1")
                .. string.sub(string.format("%.2f", v - math.floor(v)), 2)
    else
        return "-" .. string.sub(s, 1, pos)
                .. string.gsub(string.sub(s, pos + 1), "(...)", ",%1")
                .. string.sub(string.format("%.2f", v - math.floor(v)), 2)
    end

end

math.__random = math.random
function math.random(value, maxvalue)
    if (value and type(value) ~= "number") then
        logMessageWithStackTrace(LOG_LEVEL.ERROR, "Expected Number at Argument #1 ");
        return;
    else
        if (maxvalue and type(maxvalue) ~= "number") then
            logMessageWithStackTrace(LOG_LEVEL.ERROR, "Expected Number at Argument #2 ");
            return;
        end
    end

    if (not value) then
        return math.__random()
    end

    if (not maxvalue) then
        return math.__random(value)
    end

    if (value == maxvalue) then
        return value
    else
        return math.__random(value, maxvalue)
    end
end

function initMathRandom()
    math.randomseed(os.time())
end
addEventHandler("onResourceStart", getRootElement(), initMathRandom)






