--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 01:02
-- To change this template use File | Settings | File Templates.
--


_setPlayerMoney=setPlayerMoney
function setPlayerMoney(thePlayer,betrag)
    triggerClientEvent(thePlayer,"setPlayerNewMoney",thePlayer,betrag)
end










