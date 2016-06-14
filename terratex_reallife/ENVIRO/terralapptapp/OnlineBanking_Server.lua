local osHackChance = 10
local osSchwundProzent = 25

function OnlineBanking_Offline(sender, empfaenger, grund, betrag)
    if (sender and empfaenger and grund and betrag) then
        if ((((vioGetElementData(source, "premium") / 60) / 60) / 24) > 0) then
            if (getPlayerBank(sender) >= betrag) then
                betrag = math.round(betrag, 2)
                if (betrag > 0) then
                    local empf
                    if (MySql.helper.getCountSync("user", { Nickname = empfaenger }) == 1) then
                        empf = MySql.helper.getValueSync("user", "Nickname", { Nickname = empfaenger });
                    elseif (MySql.helper.getCountSync("user", { Nickname = config["clantag"] .. empfaenger }) == 1) then
                        empf = MySql.helper.getValueSync("user", "Nickname", { Nickname = (config["clantag"] .. empfaenger) });
                    end
                    if (empf) then
                        if (MySql.helper.existSync("user_data", { Nickname = empf })) then

                            local ueberweiser = betrag
                            if ((((vioGetElementData(sender, "onlineschutzuntil") / 60) / 60) / 24) <= 0) then
                                local gestohlen = math.random(1, 100)
                                if (gestohlen <= osHackChance) then
                                    local gestohlenProzent = math.random(1, osSchwundProzent) / 100
                                    local gestohleneSumme = betrag * gestohlenProzent
                                    betrag = betrag - gestohleneSumme
                                    outputChatBox(string.format("Leider wurde Ihre Überweisung gehackt und es sind %s verschwunden.", toprice(gestohleneSumme)), empf, 0, 255, 0)
                                end
                            end
                            changePlayerBank(sender, -ueberweiser, "spieler", string.format("Überweisung an %s Grund: %s", empf, grund))
                            local query = "UPDATE user_data SET Bank = Bank + ? WHERE Nickname = ?"
                            dbExec(MySql._connection, query, betrag, empf);

                            saveMoneyLog_withNickname(empf, "Bank", "spieler", betrag, string.format("Überweisung von %s Grund: %s", getPlayerName(sender), grund))
                            save_offline_message(empf, "SA Bank Systems", string.format("Überweisung von %s Grund: %s", getPlayerName(sender), grund))
                            triggerClientEvent(sender, "obUeberweisungClient", sender, false)
                        else
                            outputChatBox("Empfänger kann nicht gefunden werden.", sender, 0, 255, 0)
                        end
                    else
                        outputChatBox("Empfänger kann nicht gefunden werden.", sender, 0, 255, 0)
                    end
                else
                    outputChatBox("Betrag muss größer 0 sein.", sender, 0, 255, 0)
                end
            else
                outputChatBox("Du hast nicht genügend Geld. Wende dich an DarkCitizen", sender, 0, 255, 0)
            end
        else
            outputChatBox("Empfänger ist Offline. Du hast leider auch kein Premium.", sender, 0, 255, 0)
            outputChatBox("Kauf Dir mit /premium Premium um an Offline Spieler zu überweisen.", sender, 0, 255, 0)
        end
    else
        -- Wir haben keinen Empfänger, Grund oder Betrag
        showError(source, "Du hast nicht genug Geld auf Deinem Konto.") -- Empfänger nicht gefunden.
    end
end

function OnlineBanking_UeberweisenServer(empfaenger, grund, betrag)
    --	if source ~= client then return end
    if (betrag <= 0) then return end
    if (empfaenger == "Doodys vereinigten Kinderhilfswerke") then
        if (betrag <= getPlayerBank(source)) then
            changePlayerBank(source, -betrag, "sonstiges", "Spendenzahlung")
            changePlayerSpenden(source, betrag)
            frakkasse[3] = frakkasse[3] + betrag
            for theKey, thePlayer in ipairs(getPlayersInTeam(team[3])) do
                outputChatBox(string.format("%s hat %s gespendet!", getPlayerName(source), toprice(betrag)), thePlayer, 0, 255, 0)
            end
            triggerClientEvent(source, "obUeberweisungClient", source, false)
        else
            showError(sender, "Du hast nicht genug Geld auf Deinem Konto.")
        end
    else
        betrag = math.round(betrag, 2)
        if (betrag <= getPlayerBank(source)) then
            if (getPlayerFromIncompleteName(empfaenger)) then
                local empfaengerVoll = getPlayerFromIncompleteName(empfaenger)
                if (empfaengerVoll) then
                    local ueberweiser = betrag
                    if ((((vioGetElementData(source, "onlineschutzuntil") / 60) / 60) / 24) <= 0) then
                        local gestohlen = math.random(1, 100)
                        if (gestohlen <= osHackChance) then
                            local gestohlenProzent = math.random(1, osSchwundProzent) / 100
                            local gestohleneSumme = betrag * gestohlenProzent
                            betrag = betrag - gestohleneSumme
                            outputChatBox(string.format("Leider wurde Ihre Überweisung gehackt und es sind %s verschwunden.", toprice(gestohleneSumme)), source, 0, 255, 0)
                        end
                    end
                    changePlayerBank(source, -ueberweiser, "spieler", string.format("Überweisung an %s Grund: %s", getPlayerName(empfaengerVoll), grund))
                    changePlayerBank(empfaengerVoll, betrag, "spieler", string.format("Überweisung von %s Grund: %s", getPlayerName(source), grund))
                    outputChatBox(string.format("%s hat Dir $%s überwiesen. Grund: %s", getPlayerName(source), betrag, grund), empfaengerVoll)
                    triggerClientEvent(source, "obUeberweisungClient", source, false)
                else
                    OnlineBanking_Offline(source, empfaenger, grund, betrag)
                end
            else
                OnlineBanking_Offline(source, empfaenger, grund, betrag)
            end
        else
            showError(source, "Du hast nicht genug Geld auf Deinem Konto.")
        end
    end
end

addEvent("obUberweisenServer", true)
addEventHandler("obUberweisenServer", getRootElement(), OnlineBanking_UeberweisenServer)

local tanPreis = 5 -- Der Preis für das abrufen eines Tan Codes
function OnlineBanking_GetTanCodeServer(spende)
    local canTrigger = false
    if (spende) then
        canTrigger = true
    else
        if (getPlayerBank(source) >= tanPreis) then
            changePlayerBank(source, -tanPreis, "sonstiges", string.format("TAN für %s gekauft.", -tanPreis))
            canTrigger = true
        else
            showError(source, "Nicht genug Geld für einen TAN Code kaufen auf dem Konto")
        end
    end
    if (canTrigger) then
        triggerClientEvent(source, "obGetTANCodesClient", source, true)
    end
end

addEvent("obGetTanCodeServer", true)
addEventHandler("obGetTanCodeServer", getRootElement(), OnlineBanking_GetTanCodeServer)








