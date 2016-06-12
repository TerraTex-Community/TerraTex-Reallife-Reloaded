local saveTagesGewinnePerSpieler = {} --index = spieler , tabelle: {["pferde"]=gewinnpferde,["bj"]=gewinn}

addEvent("reduceBlackJackHandMoney", true)
function reduceBlackJackHandMoney_func(money, typ)
    changePlayerMoney(source, -money, "sonstiges", "Casino", "Wetteinsatz")
    changeBizKasse(13, money, "Casino Wetteinsatz")
    outputChatBox(string.format("Dein Einsatz wurde um %s erhöht!", toprice(money)), source, 0, 255, 0)
    --outputChatBox("Aufgrund von Bugusing wurde der Einsatz nur virtuell erhöht ohne vom Handgeld abgezogen zu werden!",source,255,0,0)
    if not saveTagesGewinnePerSpieler[getPlayerName(source)] then saveTagesGewinnePerSpieler[getPlayerName(source)] = {} end
    if not saveTagesGewinnePerSpieler[getPlayerName(source)][typ] then saveTagesGewinnePerSpieler[getPlayerName(source)][typ] = 0 end
    saveTagesGewinnePerSpieler[getPlayerName(source)][typ] = saveTagesGewinnePerSpieler[getPlayerName(source)][typ] - money

    MySql.helper.insert("log_casino", {
        Nickname = getPlayerName(source),
        Spiel = typ,
        Betrag = -money,
        tagesgewinn = saveTagesGewinnePerSpieler[getPlayerName(source)][typ]
    });
end

addEventHandler("reduceBlackJackHandMoney", getRootElement(), reduceBlackJackHandMoney_func)


addEvent("payOut_Bj", true)
function payOut_Bj_func(money, typ)
    changePlayerMoney(source, money, "sonstiges", "Casino", "Auszahlung")
    changeBizKasse(13, money, "Casino Auszahlung")
    outputChatBox(string.format("Dein Gewinn %s wurde ausgezahlt!", toprice(money)), source, 0, 255, 0)
    --outputChatBox("Aufgrund von Bugusing wurde der Gewinn nur virtuell ausgezahlt ohne auf das Handgeld ausgezahlt zu werden!",source,255,0,0)
    if not saveTagesGewinnePerSpieler[getPlayerName(source)] then saveTagesGewinnePerSpieler[getPlayerName(source)] = {} end
    if not saveTagesGewinnePerSpieler[getPlayerName(source)][typ] then saveTagesGewinnePerSpieler[getPlayerName(source)][typ] = 0 end
    saveTagesGewinnePerSpieler[getPlayerName(source)][typ] = saveTagesGewinnePerSpieler[getPlayerName(source)][typ] + money

    MySql.helper.insert("log_casino", {
        Nickname = getPlayerName(source),
        Spiel = typ,
        Betrag = money,
        tagesgewinn = saveTagesGewinnePerSpieler[getPlayerName(source)][typ]
    });
end

addEventHandler("payOut_Bj", getRootElement(), payOut_Bj_func)








