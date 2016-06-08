
addEvent("openDialogForMaxTickets",true)
function openDialogForMaxTickets_func(price)
	askCreate("Tombupot-Ticket-Kauf", "Ja!", "Nein!", string.format("Willst du ein Tombupotticket für %s$ kaufen?", price), acceptedKauf, nil)

end
addEventHandler("openDialogForMaxTickets",getRootElement(),openDialogForMaxTickets_func)

function acceptedKauf()
	triggerServerEvent("acceptedBuyTomboTicket",getLocalPlayer())
end








