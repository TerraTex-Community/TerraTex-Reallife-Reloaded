addEvent("setPlayerNewMoney",true)
function setPlayerNewMoney_func(betrag)
    setHudNewMoney(betrag);
end
addEventHandler("setPlayerNewMoney",getRootElement(),setPlayerNewMoney_func)
