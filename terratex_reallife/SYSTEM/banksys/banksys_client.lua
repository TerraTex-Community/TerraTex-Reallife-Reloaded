
BankGUI_Window = {}
BankGUI_TabPanel = {}
BankGUI_Tab = {}
BankGUI_Button = {}
BankGUI_Label = {}
BankGUI_Image = {}

function createBankGui()



BankGUI_Window[1] = guiCreateWindow(229,288,550,305,"BankAutomat",false)
table.insert(allGuis,BankGUI_Window[1])
bank_label = guiCreateLabel(39,45,338,109,"Willkommen an einen Automaten der San Andreas Liberty Bank. \n Suche dir eine Funktion aus und \195\188berweise Geld, spende geld an Selbsthilfegruppen fuer S\195\188chtige, hebe Geld ab oder zahle es ein. Wir erf\195\188llen jeden Wunsch. \n Ihre Liberty Bank von San Andreas.",false,BankGUI_Window[1])
guiLabelSetColor(bank_label,255,255,255)
guiLabelSetVerticalAlign(bank_label,"top")
guiLabelSetHorizontalAlign(bank_label,"left",true)
BankGUI_Image[1] = guiCreateStaticImage(396,39,121,117,"FILES/IMAGES/bank.jpg",false,BankGUI_Window[1])
BankGUI_TabPanel[1] = guiCreateTabPanel(33,175,499,111,false,BankGUI_Window[1])
BankGUI_Tab[1] = guiCreateTab("Kontoübersicht",BankGUI_TabPanel[1])
BankGUI_Label[1] = guiCreateLabel(38,9,193,25,"Kontobesitzer:",false,BankGUI_Tab[1])
guiLabelSetColor(BankGUI_Label[1],255,255,255)
guiLabelSetVerticalAlign(BankGUI_Label[1],"top")
guiLabelSetHorizontalAlign(BankGUI_Label[1],"left",false)
BankGUI_Label[2] = guiCreateLabel(14,29,103,22,"Bargeld:",false,BankGUI_Tab[1])
guiLabelSetColor(BankGUI_Label[2],255,255,255)
guiLabelSetVerticalAlign(BankGUI_Label[2],"top")
guiLabelSetHorizontalAlign(BankGUI_Label[2],"left",false)
BankGUI_Label[3] = guiCreateLabel(53,50,117,16,"Kontostand:",false,BankGUI_Tab[1])
guiLabelSetColor(BankGUI_Label[3],255,255,255)
guiLabelSetVerticalAlign(BankGUI_Label[3],"top")
guiLabelSetHorizontalAlign(BankGUI_Label[3],"left",false)
BankGUI_Button[1] = guiCreateButton(270,26,207,39,"Automat verlassen !",false,BankGUI_Tab[1])
BankGUI_Label[4] = guiCreateLabel(130,9,113,14,"(kontobesitzer)",false,BankGUI_Tab[1])
guiLabelSetColor(BankGUI_Label[4],255,255,255)
guiLabelSetVerticalAlign(BankGUI_Label[4],"top")
guiLabelSetHorizontalAlign(BankGUI_Label[4],"left",false)
BankGUI_Label[5] = guiCreateLabel(129,29,125,17,"(Handgeld)",false,BankGUI_Tab[1])
guiLabelSetColor(BankGUI_Label[5],255,255,255)
guiLabelSetVerticalAlign(BankGUI_Label[5],"top")
guiLabelSetHorizontalAlign(BankGUI_Label[5],"left",false)
BankGUI_Label[6] = guiCreateLabel(130,49,130,18,"(kontostand)",false,BankGUI_Tab[1])
guiLabelSetColor(BankGUI_Label[6],255,255,255)
guiLabelSetVerticalAlign(BankGUI_Label[6],"top")
guiLabelSetHorizontalAlign(BankGUI_Label[6],"left",false)
BankGUI_Tab[2] = guiCreateTab("Einzahlung",BankGUI_TabPanel[1])
BankGUI_Button[2] = guiCreateButton(269,31,206,34,"Einzahlen",false,BankGUI_Tab[2])
BankGUI_Edit_einzahlen = guiCreateEdit(25,29,228,33,"",false,BankGUI_Tab[2])
BankGUI_Label[7] = guiCreateLabel(33,6,109,17,"Betrag:",false,BankGUI_Tab[2])
guiLabelSetColor(BankGUI_Label[7],255,255,255)
guiLabelSetVerticalAlign(BankGUI_Label[7],"top")
guiLabelSetHorizontalAlign(BankGUI_Label[7],"left",false)
BankGUI_Tab[3] = guiCreateTab("Auszahlen",BankGUI_TabPanel[1])
BankGUI_Button[3] = guiCreateButton(264,27,219,34,"Auszahlen",false,BankGUI_Tab[3])
BankGUI_Edit_auszahlen = guiCreateEdit(19,27,232,36,"",false,BankGUI_Tab[3])
BankGUI_Label[8] = guiCreateLabel(25,4,76,21,"Betrag:",false,BankGUI_Tab[3])
guiLabelSetColor(BankGUI_Label[8],255,255,255)
guiLabelSetVerticalAlign(BankGUI_Label[8],"top")
guiLabelSetHorizontalAlign(BankGUI_Label[8],"left",false)
BankGUI_Tab[4] = guiCreateTab("Überweisung",BankGUI_TabPanel[1])
BankGUI_Edit_empfaenger_ueberweisung = guiCreateEdit(127,7,206,30,"",false,BankGUI_Tab[4])
BankGUI_Edit_Betrag_ueberweisung = guiCreateEdit(129,47,209,32,"",false,BankGUI_Tab[4])
BankGUI_Label[9] = guiCreateLabel(46,11,96,21,"Empfänger:",false,BankGUI_Tab[4])
guiLabelSetColor(BankGUI_Label[9],255,255,255)
guiLabelSetVerticalAlign(BankGUI_Label[9],"top")
guiLabelSetHorizontalAlign(BankGUI_Label[9],"left",false)
BankGUI_Label[10] = guiCreateLabel(77,51,96,22,"Betrag:",false,BankGUI_Tab[4])
guiLabelSetColor(BankGUI_Label[10],255,255,255)
guiLabelSetVerticalAlign(BankGUI_Label[10],"top")
guiLabelSetHorizontalAlign(BankGUI_Label[10],"left",false)
BankGUI_Button[4] = guiCreateButton(367,11,114,60,"Überweisen!",false,BankGUI_Tab[4])
BankGUI_Tab[5] = guiCreateTab("Spenden",BankGUI_TabPanel[1])
BankGUI_Label[11] = guiCreateLabel(18,11,305,33,"Danke das Sie sich dazu entschieden haben, unseren Anstalten f\195\188r die Vereinigten Hilfswerke f\195\188r Events zu Spenden!",false,BankGUI_Tab[5])
guiLabelSetColor(BankGUI_Label[11],255,255,255)
guiLabelSetVerticalAlign(BankGUI_Label[11],"top")
guiLabelSetHorizontalAlign(BankGUI_Label[11],"left",true)
BankGUI_Edit_betrag_spenden = guiCreateEdit(100,46,215,31,"",false,BankGUI_Tab[5])
BankGUI_Label[12] = guiCreateLabel(49,51,73,20,"Betrag:",false,BankGUI_Tab[5])
guiLabelSetColor(BankGUI_Label[12],255,255,255)
guiLabelSetVerticalAlign(BankGUI_Label[12],"top")
guiLabelSetHorizontalAlign(BankGUI_Label[12],"left",false)
BankGUI_Button[5] = guiCreateButton(345,20,136,49,"Spenden",false,BankGUI_Tab[5])


		addEventHandler ( "onClientGUIClick", BankGUI_Button[1], closeBankGui, false )
		addEventHandler ( "onClientGUIClick", BankGUI_Button[2], einzahlen, false )
		addEventHandler ( "onClientGUIClick", BankGUI_Button[3], auszahlen, false )
		addEventHandler ( "onClientGUIClick", BankGUI_Button[4], ueberweisen, false )
		addEventHandler ( "onClientGUIClick", BankGUI_Button[5], spenden, false )
				




guiSetVisible(BankGUI_Window[1],false)

end
addEventHandler("onClientResourceStart", getRootElement( ),createBankGui)


function ueberweisen()
	local betrag=tonumber(guiGetText(BankGUI_Edit_Betrag_ueberweisung))
	if(betrag<1)then
		showError(getLocalPlayer(),"Ung\195\188ltiger Betrag!")
	elseif (betrag>getPlayerBank(getLocalPlayer()))then
		showError(getLocalPlayer(),"So viel Geld hast du nicht auf deinem Konto!")
	else
		local empf=guiGetText(BankGUI_Edit_empfaenger_ueberweisung)
		if(empf=="")then
			showError(getLocalPlayer(),"Du hast keinen Empf\195\164nger angegeben!")
		else
			triggerServerEvent("ueberweisungServer",getLocalPlayer(),betrag,empf)
		end
	end


end





function spenden()
	local betrag=tonumber(guiGetText(BankGUI_Edit_betrag_spenden))
	if(betrag<1)then
		showError(getLocalPlayer(),"Ung\195\188ltiger Betrag!")
	elseif (betrag>getPlayerMoney(getLocalPlayer()))then
		showError(getLocalPlayer(),"So viel Geld hast du nicht auf deiner Hand!")
	else
		triggerServerEvent("spendenServer",getLocalPlayer(),betrag)
	end


end





function auszahlen()
	local betrag=tonumber(guiGetText(BankGUI_Edit_auszahlen))
	if betrag then
		if(betrag<0.01)then
			showError(getLocalPlayer(),"Ung\195\188ltiger Betrag!")
		elseif (betrag>getPlayerBank(getLocalPlayer()))then
			showError(getLocalPlayer(),"So viel Geld hast du nicht auf deinem Konto!")
		else
			triggerServerEvent("auszahlenServer",getLocalPlayer(),betrag)
		end
	else
			showError(getLocalPlayer(),"Ung\195\188ltiger Betrag!")
	
	end


end

function einzahlen()
	local betrag=tonumber(guiGetText(BankGUI_Edit_einzahlen))
	if(betrag<0.01)then
		showError(getLocalPlayer(),"Ung\195\188ltiger Betrag!")
	elseif (betrag>getPlayerMoney(getLocalPlayer()))then
		showError(getLocalPlayer(),"So viel Geld hast du nicht auf deiner Hand!")
	else
		triggerServerEvent("einzahlenServer",getLocalPlayer(),betrag)
	end


end

function aktualiseBankGui(theTab)
	if(guiGetVisible(BankGUI_Window[1])==true)then
        if(BankGUI_Tab[1]==theTab)then
            guiSetText(BankGUI_Label[4],getPlayerName(getLocalPlayer()))
            guiSetText(BankGUI_Label[5],getPlayerMoney(getLocalPlayer()))
            guiSetText(BankGUI_Label[6],getPlayerBank(getLocalPlayer()))
        end
	end

end
addEventHandler("onClientGUITabSwitched",getRootElement(),aktualiseBankGui)

function closeBankGui()
	guiSetVisible(BankGUI_Window[1],false)
	showCursor(false)
	toggleAllControls ( true )
end



function showBankGui_func()
	guiSetText(BankGUI_Label[4],getPlayerName(getLocalPlayer()))
	guiSetText(BankGUI_Label[5],getPlayerMoney(getLocalPlayer()))
	guiSetText(BankGUI_Label[6],getPlayerBank(getLocalPlayer()))
	guiSetVisible(BankGUI_Window[1],true)
	showCursor(true)
	toggleAllControls ( false )

end
addEvent("showBankAutomat",true)
addEventHandler("showBankAutomat",getRootElement(),showBankGui_func)





addEventHandler("onClientResourceStart",resourceRoot,
function()
        VersicherungsGUI_Window = {}
        VersicherungsGUI_Button = {}
        VersicherungsGUI_Label = {}
		
		local dx,dy=guiGetScreenSize()
		dx=579/1600*dx
		dy=391/900*dy	
		
        VersicherungsGUI_Window[1] = guiCreateWindow(dx,dy,434,221,"Versicherung",false)
		table.insert(allGuis,VersicherungsGUI_Window[1])
        VersicherungsGUI_Label[1] = guiCreateLabel(16,38,188,102,"Autoversicherung\nEinmalige Kosten: 150k $\npro PayDay: 15.00$ pro Fahrzeug\nNutzen: bei Fahrzeugverlust bei Nichtpremium 25 Prozent und bei Premium 75 Prozent",false,VersicherungsGUI_Window[1])
        guiLabelSetHorizontalAlign(VersicherungsGUI_Label[1],"left",true)
        VersicherungsGUI_Label[2] = guiCreateLabel(214,38,206,99,"Lebensversicherung\nEinmalige Kosten: 50k $\npro PayDay 10% mehr Sozialabgaben\nNutzen: \195\156bernimmt alle Wiederbelebungskosten",false,VersicherungsGUI_Window[1])
        guiLabelSetHorizontalAlign(VersicherungsGUI_Label[2],"left",true)
        VersicherungsGUI_Button[1] = guiCreateButton(14,141,197,27,"Autoversicherung: abschließen",false,VersicherungsGUI_Window[1])
        VersicherungsGUI_Button[2] = guiCreateButton(218,141,197,27,"Lebensversicher: abschließen",false,VersicherungsGUI_Window[1])
        VersicherungsGUI_Button[3] = guiCreateButton(21,179,393,20,"Beenden",false,VersicherungsGUI_Window[1])
		
		addEventHandler ( "onClientGUIClick", VersicherungsGUI_Button[1], getAutoVersicherung_button, false )
		addEventHandler ( "onClientGUIClick", VersicherungsGUI_Button[2], getLebensVersicherung_button, false )
		
		addEventHandler ( "onClientGUIClick", VersicherungsGUI_Button[3], closeVersicherungsPickup, false )
		
		guiSetVisible(VersicherungsGUI_Window[1],false)
		
		local pickele=createMarker(1551.1533203125,1671.759765625,8373.4833984375,"cylinder",1)
		setElementInterior(pickele,1)
		addEventHandler("onClientMarkerHit",pickele,EnterVersicherungsPickup)
		
	end
)


function getLebensVersicherung_button()
	triggerServerEvent("getLebensVersicherung",getLocalPlayer(),getLocalPlayer())
end

function getAutoVersicherung_button()
	triggerServerEvent("getCarVersicherung",getLocalPlayer(),getLocalPlayer())	
end

function closeVersicherungsPickup()
	showCursor(false)
	guiSetVisible(VersicherungsGUI_Window[1],false)
end

function EnterVersicherungsPickup(thePlayer)
	if(thePlayer==getLocalPlayer() and getElementInterior(getLocalPlayer())==1)then
		showCursor(true)
		guiSetVisible(VersicherungsGUI_Window[1],true)
		if(tonumber(getElementData(getLocalPlayer(),"versicherung"))==1)then
			guiSetText(VersicherungsGUI_Button[1],"Autoversicherung: beenden")
		else
			guiSetText(VersicherungsGUI_Button[1],"Autoversicherung: abschließen")		
		end
		if(tonumber(getElementData(getLocalPlayer(),"lebensversicherung"))==1)then
			guiSetText(VersicherungsGUI_Button[2],"Lebensversicherung: beenden")
		else
			guiSetText(VersicherungsGUI_Button[2],"Lebensversicherung: abschließen")		
		end		
	end
end











