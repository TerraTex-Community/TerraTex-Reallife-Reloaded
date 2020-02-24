function changePlayerGold(thePlayer, Betrag, ...)
    local gold = vioGetElementData(thePlayer, "Gold");
    gold = gold + Betrag;
    vioSetElementData(thePlayer, "Gold", gold);

    MySql.helper.insert("log_gold",{
        Nickname = getPlayerName(thePlayer),
        Betrag = Betrag,
        Grund = table.concat({...}, " ")
    });
end

