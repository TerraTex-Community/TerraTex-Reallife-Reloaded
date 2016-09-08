addEvent("openDialogForBuyTickets",true)
function openDialogForBuyTickets_func(total, price, playerTickets, maxTickets)
	askCreate("Tombupot-Ticket-Kauf", "Ja!", "Nein!", string.format("Aktuelle Gewinnsumme: %s$\n\nWillst du ein Tombupotticket für %s$ kaufen? (%s/%s)", total, price, playerTickets, maxTickets), acceptedKauf, nil)
end
addEventHandler("openDialogForBuyTickets",getRootElement(),openDialogForBuyTickets_func)

addEvent("openDialogForMaxTickets",true)
function openDialogForMaxTickets_func(total, maxTickets)
	createDialog("Tombupot-Tickets", "Ok", string.format("Aktuelle Gewinnsumme: %s$\n\nDu hast bereits die maximale Anzahl an Tickets für die nächste\nLotterieziehung erworben. (%s Tickets)", total, maxTickets), nil, nil)
end
addEventHandler("openDialogForMaxTickets",getRootElement(),openDialogForMaxTickets_func)

local activeBuyRequest = false
addEvent("confirmTombuTicket", true)
function confirmTombuTicket(winTimeHour, winTimeMinute, total)
    activeBuyRequest = false
    local additionalZero = ""
    if (winTimeMinute < 10) then
        additionalZero = 0
    end
    outputChatBox(string.format("Du hast nun ein weiteres Ticket für die Tombupot-Lotterie erworben! Die Ziehung findet %s:%s%s Uhr statt!", winTimeHour, additionalZero, winTimeMinute), 155, 155, 0)
    outputChatBox(string.format("Die Gewinnsumme liegt nun bei %s$!", total), 155, 155, 0)
end
addEventHandler("confirmTombuTicket", getRootElement(), confirmTombuTicket)

function acceptedKauf()
    if (not activeBuyRequest) then
        activeBuyRequest = true
        triggerServerEvent("acceptedBuyTomboTicket", getLocalPlayer())
    end
end

addEvent("needMoreMoneyTombupot", true)
function needMoreMoneyTombupot()
    activeBuyRequest = false
    showError(getLocalPlayer(), "Du hast nicht genug Geld!")
end
addEventHandler("needMoreMoneyTombupot", getRootElement(), needMoreMoneyTombupot)
