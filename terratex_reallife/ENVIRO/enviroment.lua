-- @todo: aufspliten und aufräumen

function self_func(thePlayer)

    triggerClientEvent(thePlayer, "openInterGui", thePlayer, "left", "down", 0, 0, 0, 0, 0, thePlayer)
end

addCommandHandler("self", self_func, false, false)


function ejectPed(thePlayer)
    if (isPedInVehicle(thePlayer)) then
        triggerClientEvent(thePlayer, "ejectFromVehicle", thePlayer)
        setTimer(reControllEject_func, 5000, 1, thePlayer)
    end
end

function reControllEject_func(thePlayer)
    if (isPedInVehicle(thePlayer)) then
        if (not vioGetElementData(thePlayer, "hasClickedMeeresBoot")) then
            removePedFromVehicle(thePlayer)
        end
    end
end



function timestamp_func(thePlayer)
    local time = getRealTime()
    outputChatBox(string.format("Es ist jetzt %s:%s Uhr und %s Sekunden", time.hour, time.minute, time.second), thePlayer, 0, 255, 0)
    outputChatBox(string.format("Heute ist der %s.%s.%s", time.monthday, (time.month + 1), (1900 + time.year)), thePlayer, 0, 255, 0)
    outputChatBox(string.format("Es sind somit schon %s Sekunden seit 1970 vergangen!", time.timestamp), thePlayer, 0, 255, 0)
end

addCommandHandler("zeit", timestamp_func, false, false)
addCommandHandler("time", timestamp_func, false, false)




function stop_private_message()
    cancelEvent()
    outputChatBox("Das MSG-System ist auf diesem Server deaktiviert! Rufe die Person mit /call an!", source, 255, 0, 0)
    outputChatBox("Wenn du die Telefonnummer nicht kennst, rufe die Auskunft mit /call 11880 an!", source, 255, 0, 0)
end

addEventHandler("onPlayerPrivateMessage", getRootElement(), stop_private_message)

function getMessageADComponents(theString)
    if (theString) then
        local stringtab = {}
        local counter = 0
        local countera = 0
        local countlast
        local zahler = 1
        while countera == 0 do

            countlast = counter
            counter = string.find(theString, "|||", countlast)
            if (counter) then
                stringtab[zahler] = string.sub(theString, countlast, counter - 1)
                counter = counter + 3
            else
                stringtab[zahler] = string.sub(theString, countlast)
                countera = 22
            end
            zahler = zahler + 1
        end
        return stringtab
    else
        outputDebugString("ERROR IN GETSTRINGCOMPONENTS: No STRING")
        return false
    end
end

local adSended = false

function ad_func(thePlayer, Command, word, ...)
    if (vioGetElementData(thePlayer, "playtime")) then
        if (vioGetElementData(thePlayer, "playtime") > 1499) then
            if (not (adSended)) then
                if (word) then
                    local time = getRealTime()
                    local adAktivTime = vioGetElementData(thePlayer, "adaktiv") - time.timestamp
                    local message = word .. " " .. table.concat({ ... }, " ")
                    local oldMessage = message
                    local lengh = string.len(message)
                    local price = lengh * 5.67
                    chat_log(thePlayer, "(ad) " .. message)
                    if (getPlayerMoney(thePlayer) >= price or adAktivTime > 0) then
                        local test = string.find(message, "|||")
                        if not (test) then
                            test = 0
                        end
                        if (lengh < 80) and (test == 0) then
                            if (adAktivTime > 0) then
                                outputChatBox("Die Werbung hat dich nichts gekostet, da ein Gutschein noch", thePlayer, 255, 0, 0)
                                local days = math.round(adAktivTime / 60 / 60 / 24, 0, "floor")
                                adAktivTime = adAktivTime - days * 24 * 60 * 60
                                local hours = math.round(adAktivTime / 60 / 60, 0, "floor")
                                adAktivTime = adAktivTime - hours * 60 * 60
                                local minutes = math.round(adAktivTime / 60, 0, "floor")
                                adAktivTime = adAktivTime - minutes * 60
                                outputChatBox(string.format("%s Tage %s Stunden %s Minuten %s Sekunden aktiv ist!", days, hours, minutes, adAktivTime), thePlayer, 255, 0, 0)
                            else
                                changePlayerMoney(thePlayer, -price, "sonstiges", "Werbung mit /AD")
                                frakkasse[3] = frakkasse[3] + math.round((price / 3))
                                frakdepot_log(3, 1, math.round((price / 3)), "AD")
                                outputChatBox(string.format("Die Werbung hat dich %s$ gekostet", price), thePlayer, 255, 0, 0)
                            end
                            outputChatBox(string.format("Werbung von %s (%s): %s", getPlayerName(thePlayer), vioGetElementData(thePlayer, "telefon"), message), getRootElement(), 16, 188, 0, true)
                            adSended = true
                            save_ad_log(getPlayerName(thePlayer), oldMessage)
                            setTimer(resetADTIMER, 30000, 1)
                        else
                            local messages = getMessageADComponents(message)
                            price = price + 225.00 * table.getSize(messages)
                            if (getPlayerMoney(thePlayer) >= price or adAktivTime > 0) then
                                if (adAktivTime > 0) then
                                    outputChatBox("Die Werbung hat dich nichts gekostet, da ein Gutschein noch", thePlayer, 255, 0, 0)
                                    local days = math.round(adAktivTime / 60 / 60 / 24, 0, "floor")
                                    adAktivTime = adAktivTime - days * 24 * 60 * 60
                                    local hours = math.round(adAktivTime / 60 / 60, 0, "floor")
                                    adAktivTime = adAktivTime - hours * 60 * 60
                                    local minutes = math.round(adAktivTime / 60, 0, "floor")
                                    adAktivTime = adAktivTime - minutes * 60
                                    outputChatBox(string.format("%s Tage %s Stunden %s Minuten %s Sekunden aktiv ist!", days, hours, minutes, adAktivTime), thePlayer, 255, 0, 0)
                                else
                                    changePlayerMoney(thePlayer, -price, "sonstiges", "Werbung mit /AD")
                                    frakkasse[3] = frakkasse[3] + math.round((price / 3))
                                    frakdepot_log(3, 1, math.round((price / 3)), "AD")
                                    outputChatBox(string.format("Die Werbung hat dich %s$ gekostet", price), thePlayer, 255, 0, 0)
                                end
                                outputChatBox(string.format("Werbung von %s (%s)", getPlayerName(thePlayer), vioGetElementData(thePlayer, "telefon")), getRootElement(), 16, 188, 0)
                                for theKey, messagepart in ipairs(messages) do
                                     outputChatBox(messagepart, getRootElement(), 16, 188, 0, true)
                                end
                                outputChatBox("Werbeende von " .. getPlayerName(thePlayer) .. " (" .. vioGetElementData(thePlayer, "telefon") .. ")", getRootElement(), 16, 188, 0)
                                adSended = true
                                save_ad_log(getPlayerName(thePlayer), oldMessage)
                                setTimer(resetADTIMER, 30000, 1)
                            else
                                showError(thePlayer, "Du hast nicht genuegend Geld! (ACHTUNG Die Werbung ist auf Grund der Länge oder Sonderfunktionen teurer als normal)")
                            end
                        end
                    else
                        showError(thePlayer, "Du hast nicht genuegend Geld!")
                    end
                else
                    showError(thePlayer, "Nutzung: /ad [Text]")
                end
            else
                showError(thePlayer, "Es sind noch keine 30 Sekunden seit der letzten Werbung vergangen!")
            end
        else
            showError(thePlayer, "Du musst über 25 Spielstunden haben, um eine AD zu senden!")
        end
    end
end
addCommandHandler("ad", ad_func, false, false)

function resetADTIMER()
    adSended = false
end








