--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 03.05.14
-- Time: 12:12
-- To change this template use File | Settings | File Templates.
--
getPlayerHudMoney = getPlayerMoney
function getPlayerMoney(thePlayer)
    assert(isElement(thePlayer), "Expected Player as Argument [1] got" .. type(thePlayer) .. ", Stack: " .. debug.traceback());
    local money = tonumber(getElementData(thePlayer, "money"))
    return money
end

function getPlayerBank(thePlayer)
    assert(isElement(thePlayer), "Expected Player as Argument [1] got" .. type(thePlayer) .. ", Stack: " .. debug.traceback());
    local money = tonumber(getElementData(thePlayer, "bank"))
    return money
end

function getPlayerSpenden(thePlayer)
    assert(isElement(thePlayer), "Expected Player as Argument [1] got" .. type(thePlayer) .. ", Stack: " .. debug.traceback());
	local money = tonumber(getElementData(thePlayer, "ingamespenden"))
	return money
end








