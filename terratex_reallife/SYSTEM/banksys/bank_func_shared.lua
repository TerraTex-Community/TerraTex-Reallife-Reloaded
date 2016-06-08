--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 03.05.14
-- Time: 12:12
-- To change this template use File | Settings | File Templates.
--
getPlayerHudMoney = getPlayerMoney
function getPlayerMoney(thePlayer)
    local money = tonumber(getElementData(thePlayer, "money"))
    return money
end

function getPlayerBank(thePlayer)
    local money = tonumber(getElementData(thePlayer, "bank"))
    return money
end

function getPlayerSpenden(thePlayer)
	local money = tonumber(getElementData(thePlayer, "ingamespenden"))
	return money
end








