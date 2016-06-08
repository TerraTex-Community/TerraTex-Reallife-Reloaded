--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 01:15
-- To change this template use File | Settings | File Templates.
--

function isNumeric(a)
    return type(tonumber(a)) == "number"
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function toprice(number)
    local var = math.round(number, 2)
    local stringsbevor = math.Tausend(var)
    return "$ " .. stringsbevor
end

function math.Tausend(v)
    local isnegetive=false
    if(v<0)then
        isnegetive=true
        v=-v
    end
    local s = string.format("%d", math.floor(v))
    local pos = string.len(s) % 3
    if pos == 0 then pos = 3 end
    if(not(isnegetive))then
        return string.sub(s, 1, pos)
                .. string.gsub(string.sub(s, pos+1), "(...)", ",%1")
                .. string.sub(string.format("%.2f", v - math.floor(v)), 2)
    else
        return "-"..string.sub(s, 1, pos)
                .. string.gsub(string.sub(s, pos+1), "(...)", ",%1")
                .. string.sub(string.format("%.2f", v - math.floor(v)), 2)
    end

end


math._random=math.random
function math.random(value,maxvalue)
    if(not maxvalue)then
        return math._random(value)
    end
    
    
    if(value==maxvalue)then
        return value
    else
        return math._random(value,maxvalue)
    end
end








