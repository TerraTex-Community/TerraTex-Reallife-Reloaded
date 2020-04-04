function buyNewGold_func(amount)
    if (amount * config["gold.price"] <= getPlayerMoney(source)) then
        if (amount > 0) then
            changePlayerMoney(source, -amount * config["gold.price"], "sonstiges", "Goldkauf");
            changePlayerGold(source, amount, "Goldkauf");
            showError(source, "Du hast erfolgreich " .. amount .. " Gold gekauft!");

            triggerClientEvent(source, "actualizeGoldAmount", source)
        end
    else
        showError(source, "Du hast nicht genug Geld um so viel Gold zu kaufen!");
    end
end
addEvent("buyNewGold", true)
addEventHandler("buyNewGold", getRootElement(), buyNewGold_func)

local itemPrices = {
    FoodBooster = 10,
    FuelBooster = 10,
    HufeisenBooster = 5,
    SkillBooster = 20,
    ["Corona.SkillBooster"] = -1,
    ["Corona.MoneyBooster"] = -1
};

function buyGoldItem_func(itemId)
    local timedItems = getTimedGoldBooster();

    if (table.hasValue(timedItems, itemId)) then
        local timestampOld = vioGetElementData(source, "Gold." .. itemId);
        local time = getRealTime();
        local timestamp = time.timestamp;

        local result = timestampOld - timestamp;

        if (result > 86400) then
            showError(source, "Der Booster ist bereits aktiv und kann zur Zeit nicht verlängert werden.");
        else
            if (result < 0) then
                result = 0
            end
            result = result + timestamp + (31 * 24 * 60 * 60);

            local price = itemPrices[itemId];
            if (vioGetElementData(source, "Gold") < price) then
                showError(source, "Du hast nicht genug Gold um dieses Item zu kaufen!");
            else
                changePlayerGold(source, -price, "Item kauf: " .. itemId);
                vioSetElementData(source, "Gold." .. itemId, result);

                showError(source, "Du hast den Booster erfolgreich gekauft!");

                triggerClientEvent(source, "actualizeGoldAmount", source)
            end
        end
    else
        outputChatBox("not in table for some reason")
    end
end
addEvent("buyGoldItem", true)
addEventHandler("buyGoldItem", getRootElement(), buyGoldItem_func)

function extendGoldItem(player, itemId, days)
    local timestampOld = vioGetElementData(player, "Gold." .. itemId);
    local time = getRealTime();
    local timestamp = time.timestamp;
    local result = timestampOld - timestamp;
    if (result < 0) then
        result = 0
    end
    result = result + timestamp + (days * 24 * 60 * 60);
    vioSetElementData(player, "Gold." .. itemId, result);
end
