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

function acceptedKauf()
	triggerServerEvent("acceptedBuyTomboTicket",getLocalPlayer())
end
