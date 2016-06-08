  PremiumInfoGUI_Window = {}
        PremiumInfoGUI_Button = {}
        PremiumInfoGUI_Scrollpane = {}
        PremiumInfoGUI_Scrollbar = {}
		PremiumInfoGUI_Label={}
-- Created: 12/11/2011 22:26
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
    function()

        PremiumInfoGUI_Window[1] = guiCreateWindow(125,55,700,300,"Premium Informationen",false)
        PremiumInfoGUI_Button[1] = guiCreateButton(40,20,620,25,"Beenden",false,PremiumInfoGUI_Window[1])
		   PremiumInfoGUI_Scrollpane[1] = guiCreateScrollPane(0.01,0.15,0.99,0.99,true,PremiumInfoGUI_Window[1])
			--x=0.1 normal --x=15 eingerückt --Pro Zeile +20 y
			--PremiumInfoGUI_Label[1]=guiCreateLabel ( 0.1, 1, 670,20, "1. Jeder hat so zu spielen, dass sie derzeitiges Leben als sein letztes Betrachtet wird!",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[1]=guiCreateLabel ( 0.1, 1, 660,20, "Du hast noch 0 Tage Premium!",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[2]=guiCreateLabel ( 0.1, 20, 660,20, "Du hast noch 0 Gutscheine um beim nächsten Kauf 25% mehr Premium zu erhalten!",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[3]=guiCreateLabel ( 0.1, 40, 660,20, "Premium kostet Ingame mit 50k Ingame$$!",false,PremiumInfoGUI_Scrollpane[1])--(5€ Kauf im Forum oder)
			PremiumInfoGUI_Label[3]=guiCreateLabel ( 0.1, 60, 660,20, "Zum Verlängern oder Kaufen von Premium mit Ingame$$ nutze /buypremium!",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[4]=guiCreateLabel ( 0.1, 80, 660,20, "Echt-Geldkauf ist nicht möglich.",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[5]=guiCreateLabel ( 0.1,100, 660,20, "Premium bringt folgende Vorteile:",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[6]=guiCreateLabel ( 15, 120, 660,20, "-> Mehr Geld der Verschrottung von Fahrzeugen: 90 Prozent des Einkaufspreises",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[7]=guiCreateLabel ( 15, 140, 660,20, "-> Bei Verlust eines Fahrzeugs: erhalt von 25 Prozent des Einkaufspreises von einer Versicherung",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[8]=guiCreateLabel ( 15, 160, 660,20, "-> Lichtertuning mit /pcolor (kostenlos)",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[9]=guiCreateLabel ( 15, 180, 660,20, "-> Sofortiger Fahrzeugfarben wechsel mit /pcolor (kostenlos)",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[10]=guiCreateLabel ( 15, 200, 660,20, "-> 25 Prozent mehr Hufeisen auf der Karte",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[11]=guiCreateLabel ( 15, 220, 660,20, "-> /healme in der eigenen Wohnung oder dem eigenen Haus (kostenlos)",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[12]=guiCreateLabel ( 15, 240, 660,20, "-> Essensbalken wird nur halb so schnell runter",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[13]=guiCreateLabel ( 15, 260, 660,20, "-> Premiumautos",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[13]=guiCreateLabel ( 15, 280, 660,20, "-> /speedtank [1/2] - doppelt(1)/vierfach(2) so schnelles Tanken",false,PremiumInfoGUI_Scrollpane[1])
			PremiumInfoGUI_Label[13] = guiCreateLabel ( 15, 300, 660, 20, "-> In Online Banking auch an Offline Spieler überweisen", false, PremiumInfoGUI_Scrollpane[1])

		guiSetVisible(PremiumInfoGUI_Window[1],false)
		addEventHandler("onClientGUIClick", PremiumInfoGUI_Button[1],closePremiumInfoGUI)
 end
)



function closePremiumInfoGUI()
	guiSetVisible(PremiumInfoGUI_Window[1],false)
	showCursor(false)
end

addEvent("showPremiumInfoGUI",true)
function showPremiumInfo_func(premiumOutTime,hasPremGutSchein)
	guiSetVisible(PremiumInfoGUI_Window[1],true)
	showCursor(true)
	if(premiumOutTime>0)then
		guiSetText(PremiumInfoGUI_Label[1],string.format("Du hast noch %s Tage Premium!", math.round(((premiumOutTime/60)/60)/24)))
	else
		guiSetText(PremiumInfoGUI_Label[1],"Du hast kein Premium")
	end
	if(hasPremGutSchein>0)then
		guiSetText(PremiumInfoGUI_Label[2],string.format("Du hast noch %s Gutscheine um beim nächsten Kauf 25% mehr Premium zu erhalten!", hasPremGutSchein))
	else
		guiSetText(PremiumInfoGUI_Label[2],"")
	end
	
end
addEventHandler("showPremiumInfoGUI",getRootElement(),showPremiumInfo_func)

--- --- --- --- ---PremiumInfoGUI_Label[2]=guiCreateLabel ( 1, 20, 600,20, "",false,PremiumInfoGUI_Scrollpane[1])









