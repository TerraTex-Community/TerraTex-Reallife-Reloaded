_setPlayerMoney=setPlayerMoney
function setPlayerMoney(thePlayer,betrag)
    triggerClientEvent(thePlayer,"setPlayerNewMoney",thePlayer,betrag)
end
