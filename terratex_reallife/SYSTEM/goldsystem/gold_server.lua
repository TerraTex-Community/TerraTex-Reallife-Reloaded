--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 21.06.2016
-- Time: 21:57
-- To change this template use File | Settings | File Templates.
--

function buyNewGold_func(amount)
    if (amount * config["gold.price"] <= getPlayerMoney(source)) then
        if (amount > 0) then
            changePlayerMoney(source, -amount * config["gold.price"], "sonstiges", "Goldkauf");

            vioSetElementData(source, "Gold", vioGetElementData(source, "Gold") + amount);
            showError(source, "Du hast erfolgreich " .. amount .. " Gold gekauft!");

            triggerClientEvent(source, "actualizeGoldAmount", source)
        end
    else
        showError(source, "Du hast nicht genug Geld um so viel Gold zu kaufen!");
    end
end
addEvent("buyNewGold", true)
addEventHandler("buyNewGold", getRootElement(), buyNewGold_func)