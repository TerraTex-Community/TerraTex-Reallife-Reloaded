
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
