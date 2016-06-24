--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 00:45
-- To change this template use File | Settings | File Templates.
--

addEvent("setPlayerNewMoney",true)
function setPlayerNewMoney_func(betrag)
    setHudNewMoney(betrag);
end
addEventHandler("setPlayerNewMoney",getRootElement(),setPlayerNewMoney_func)
