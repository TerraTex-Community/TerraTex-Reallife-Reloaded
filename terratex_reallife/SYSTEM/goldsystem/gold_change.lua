--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 22.06.2016
-- Time: 17:19
-- To change this template use File | Settings | File Templates.
--

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

