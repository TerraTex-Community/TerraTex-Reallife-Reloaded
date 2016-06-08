MarketTapp_Window = {}
MarketTapp_Button = {}
MarketTapp_Label = {}
MarketTapp_Grid = {}
MarketTapp_Image = {}

tapps_discription = {
	["Tapp-Marketplace"] = "Zur Suche und zum Kaufen von Apps!",
	["Friendlist"] = "Freundesliste\nZeigt Freunde, ihren Onlinestatus\nLässt Freundesanfragen stellen und löschen\nKann schneller SMS schreiben und Anrufen!",
	["GPS"] = "Suchen war gestern! Lass dich von der GPS-Tapp führen!\nACHTUNG: Diese Tapp hat ihre Macken, wie ab und an eine fehlerhafte Route\nRouten stimmen aber zu 80 Prozent!",
	["Stopuhr"] = "Stoppuhr! Eine Tapp zum stoppen von Zeit",
	["Blitzermelder"] = "Warnt vor von den NEWS gemeldete Blitzer! Aktualisiert sich einmal pro Minute",
	["Kompass"] = "Zeigt verschiedene Positions und Geschwindigkeitsanzeigen!",
	["EMail"] = "Einfache Tapp zum Mail Senden und Empfangen!",
	["Notizblock"] = "Einfache Tapp zum Speichern von Informationen",
	["Colorpicker"] = "Einfache Tapp zum Finden von Farbcodes",
	["TicTacToe"] = "Ein Spiel Zwischen Freunden: Fordere Spieler zu einer Partie TicTacToe herraus!",
	["MineSweeper"] = "Klassisches Minesweeper Game",
	["OnlineBanking"] = "Mobile Online Banking",
	["OnlineSchutz"] = "Online Schutz für Online Banking",
	}

tapps_price = {
	["Tapp-Marketplace"] = 0,
	["Friendlist"] = 2500,
	["GPS"] = 4000,
	["Stopuhr"] = 1000,
	["Blitzermelder"] = 5000,
	["Kompass"] = 500,
	["EMail"] = 5000,
	["Notizblock"] = 100,
	["Colorpicker"] = 1000,
	["TicTacToe"] = 5000,
	["MineSweeper"] = 5000,
	["OnlineBanking"] = 10000,
	["OnlineSchutz"] = 5000,
	}		
		
addEventHandler("onClientResourceStart", resourceRoot, 
    function()
		local dx, dy = guiGetScreenSize()
		dx = 483 / 1600 * dx
		dy = 259 / 900 * dy	
        MarketTapp_Window[1] = guiCreateWindow(dx, dy, 423, 333, "Marketplace", false)
		table.insert(allGuis, MarketTapp_Window[1])
        MarketTapp_Button[1] = guiCreateButton(0.6123, 0.1231,0.2979, 0.1051, "Beenden", true, MarketTapp_Window[1])
        MarketTapp_Button[2] = guiCreateButton(0.0804, 0.1231,0.2979, 0.1051, "Tapp kaufen!", true, MarketTapp_Window[1])
        MarketTapp_Grid[1] = guiCreateGridList(0.0875, 0.3093, 0.3333,0.6276, true, MarketTapp_Window[1])
        guiGridListSetSelectionMode(MarketTapp_Grid[1], 2)
        local colu = guiGridListAddColumn(MarketTapp_Grid[1], "Tapps", 0.8)
        MarketTapp_Label[1] = guiCreateLabel(0.461, 0.3093, 0.5012,0.6156, "", true, MarketTapp_Window[1])
        guiLabelSetHorizontalAlign(MarketTapp_Label[1], "left", true)
        MarketTapp_Image[1] = guiCreateStaticImage(0.4137, 0.0991, 0.1678,0.1652, "FILES/IMAGES/lapptapp/marketplace.png", true, MarketTapp_Window[1])
		guiSetVisible(MarketTapp_Window[1] , false)
		local row = guiGridListAddRow (MarketTapp_Grid[1])
        guiGridListSetItemText(MarketTapp_Grid[1], row, colu, "Tapp-Marketplace", false, false)	
		row = guiGridListAddRow(MarketTapp_Grid[1])
        guiGridListSetItemText(MarketTapp_Grid[1], row, colu, "Friendlist", false, false)	--TAPPS HIER ADDED
		row = guiGridListAddRow(MarketTapp_Grid[1])
        guiGridListSetItemText(MarketTapp_Grid[1], row, colu, "GPS", false, false)	--TAPPS HIER ADDED
		row = guiGridListAddRow(MarketTapp_Grid[1])
        guiGridListSetItemText(MarketTapp_Grid[1], row, colu, "Stopuhr", false, false)	--TAPPS HIER ADDED
		row = guiGridListAddRow(MarketTapp_Grid[1])
        guiGridListSetItemText(MarketTapp_Grid[1], row, colu, "Blitzermelder", false, false)	--TAPPS HIER ADDED
		row = guiGridListAddRow(MarketTapp_Grid[1])
        guiGridListSetItemText(MarketTapp_Grid[1], row, colu, "Kompass", false, false)	--TAPPS HIER ADDED
		row = guiGridListAddRow(MarketTapp_Grid[1])
        guiGridListSetItemText(MarketTapp_Grid[1], row, colu, "EMail", false, false)	--TAPPS HIER ADDED
		row = guiGridListAddRow(MarketTapp_Grid[1])
        guiGridListSetItemText(MarketTapp_Grid[1], row, colu, "Notizblock", false, false)	--TAPPS HIER ADDED
		row = guiGridListAddRow(MarketTapp_Grid[1])
        guiGridListSetItemText(MarketTapp_Grid[1], row, colu, "Colorpicker", false, false)	--TAPPS HIER ADDED
		row = guiGridListAddRow(MarketTapp_Grid[1])
        guiGridListSetItemText(MarketTapp_Grid[1], row, colu, "TicTacToe", false, false)	--TAPPS HIER ADDED		
		row = guiGridListAddRow(MarketTapp_Grid[1])
        guiGridListSetItemText(MarketTapp_Grid[1], row, colu, "MineSweeper", false, false)	--TAPPS HIER ADDED
		row = guiGridListAddRow(MarketTapp_Grid[1])
        guiGridListSetItemText(MarketTapp_Grid[1], row, colu, "OnlineBanking", false, false)	--TAPPS HIER ADDED
		row = guiGridListAddRow(MarketTapp_Grid[1])
        guiGridListSetItemText(MarketTapp_Grid[1], row, colu, "OnlineSchutz", false, false)	--TAPPS HIER ADDED
		addEventHandler ( "onClientGUIClick", MarketTapp_Grid[1], markettapp_showdiscription, false)	
		addEventHandler ( "onClientGUIClick", MarketTapp_Button[1], markettapp_close, false)	
		addEventHandler ( "onClientGUIClick", MarketTapp_Button[2], markettapp_buy, false)	
    end
)

function markettapp_buy()
	local row, column = guiGridListGetSelectedItem(MarketTapp_Grid[1])
	if (row == -1) then
		outputChatBox("Du hast keine App ausgewählt!", 255, 0, 0)
	else
		triggerServerEvent("BuyTapp", getLocalPlayer(), tapps_price[guiGridListGetItemText(MarketTapp_Grid[1], row, column)], guiGridListGetItemText(MarketTapp_Grid[1], row, column))
	end
end

function markettapp_close()
	guiSetVisible(MarketTapp_Window[1], false)
end

function markettapp_showdiscription()
	local row, column = guiGridListGetSelectedItem(MarketTapp_Grid[1])
	if (row == -1) then
		guiSetText(MarketTapp_Label[1], "Wähle eine Tapp!")
		guiStaticImageLoadImage(MarketTapp_Image[1], "FILES/IMAGES/lapptapp/marketplace.png")
	else
		local tappname = guiGridListGetItemText(MarketTapp_Grid[1], row, column)
		guiSetText(MarketTapp_Label[1], string.format("Name: %s\nPreis: %s\nBeschreibung: %s", tappname, tapps_price[tappname], tapps_discription[tappname]))			
		guiStaticImageLoadImage(MarketTapp_Image[1], tapps[tappname])
	end
end









