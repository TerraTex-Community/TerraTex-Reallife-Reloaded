
        SuperShop_Window = {}
        SuperShop_Button = {}
        SuperShop_Label = {}
        SuperShop_Grid = {}
		SuperShop_Colum={}

addEventHandler("onClientResourceStart",resourceRoot,
    function()

        SuperShop_Window[1] = guiCreateWindow(0.3494,0.25,0.3894,0.4467,"Shop",true)
		table.insert(allGuis,SuperShop_Window[1])
        SuperShop_Button[1] = guiCreateButton(0.0144,0.0721,0.9679,0.092,"Beenden",true,SuperShop_Window[1])
        SuperShop_Button[2] = guiCreateButton(0.0144,0.9129,0.9679,0.0647,"Kaufen",true,SuperShop_Window[1])
        SuperShop_Label[1] = guiCreateLabel(0.6758,0.1891,0.2905,0.6841,"Beschreibung:",true,SuperShop_Window[1])
			guiLabelSetColor(SuperShop_Label[1],255,255,255)
			guiLabelSetVerticalAlign(SuperShop_Label[1],"top")
			guiLabelSetHorizontalAlign(SuperShop_Label[1],"left",true)
        SuperShop_Grid[1] = guiCreateGridList(0.0209,0.1891,0.6388,0.6841,true,SuperShop_Window[1])
			guiGridListSetSelectionMode(SuperShop_Grid[1],0)
			guiGridListSetSortingEnabled ( SuperShop_Grid[1], false )
			SuperShop_Colum[1]=guiGridListAddColumn(SuperShop_Grid[1],"ID",0.2)
			SuperShop_Colum[2]=	guiGridListAddColumn(SuperShop_Grid[1],"Name",0.2)
			SuperShop_Colum[3]=	guiGridListAddColumn(SuperShop_Grid[1],"Preis",0.2)
		guiSetVisible(SuperShop_Window[1],false)
		
		
		local row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "1", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "Blumen", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "2.99", false, false )
		
		row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "2", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "EinwegFotoapperat", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "24.89", false, false )
		
		row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "3", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "Benzinkanister", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "89.75", false, false )
		
		row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "4", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "Lottoschein", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "15", false, false )		

		row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "5", false, false )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "Snack", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "1.95", false, false )
		
		row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "6", false, false )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "Hamburger", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "4.85", false, false )
		
		row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "7", false, false )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "Fertigessen", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "9.99", false, false )
		
		row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "8", false, false )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "Schnellhilfe", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "49.75", false, false )
		
		row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "9", false, false )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "Carfinder", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "53.45", false, false )
		
		row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "10", false, false )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "Hufeisenhelfer", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "485.75", false, false )
		
		row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "11", false, false )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "TerraLappTapp", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "10000", false, false )
		
		row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "12", false, false )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "digitale Tachoerweiterung", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "10000", false, false )
		
		row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "13", false, false )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "Würfel", false, false )		
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "2.50", false, false )

        row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "14", false, false )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "5er Packung Kondome", false, false )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "2.50", false, false )

        row = guiGridListAddRow ( SuperShop_Grid[1] )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1], "15", false, false )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[2], "5 Blutteststreifen", false, false )
        guiGridListSetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[3], "145.29", false, false )
		
		addEventHandler("onClientGUIClick",SuperShop_Button[1],closeSuperShopGUI)
		addEventHandler("onClientGUIClick",SuperShop_Button[2],buy_SuperShop_Gui)
    end
)

function buy_SuperShop_Gui()

	local row,colum=guiGridListGetSelectedItem ( SuperShop_Grid[1])
	if(row ~= -1)then
		local id=guiGridListGetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1])
		triggerServerEvent("buySuperShopGUI_Event",getLocalPlayer(),tonumber(id))
	else
        showError(getLocalPlayer(),"Du hast keine Waren ausgewaehlt!")
	end

end

local oldValues={[5]=1.95,[6]=4.85,[7]=9.99,[8]=49.75}

function closeSuperShopGUI()

	guiSetVisible( SuperShop_Window[1] ,false)
	showCursor(false)
	triggerServerEvent("closeSuperShopGUI_Event",getLocalPlayer())

end
--addEventHandler("closeShopGUIS",getRootElement(),closeSuperShopGUI)

addEvent("showSuperGUI_Event",true)
function showSuperShopGUI()
faktor=1
	if(isWetterEventID==1)then
		faktor=3
	elseif(isWetterEventID==2)then
		faktor=1.5
	elseif(isWetterEventID==3)then
		faktor=3.5
	elseif(isWetterEventID==5)then
		faktor=0.7
	elseif(isWetterEventID==6)then
		faktor=0.9
	end
	
    guiGridListSetItemText ( SuperShop_Grid[1], 5, SuperShop_Colum[3], (oldValues[5]*faktor), false, false )
    guiGridListSetItemText ( SuperShop_Grid[1], 6, SuperShop_Colum[3], (oldValues[6]*faktor), false, false )
    guiGridListSetItemText ( SuperShop_Grid[1], 7, SuperShop_Colum[3], (oldValues[7]*faktor), false, false )
    guiGridListSetItemText ( SuperShop_Grid[1], 8, SuperShop_Colum[3], (oldValues[8]*faktor), false, false )
	guiSetVisible( SuperShop_Window[1] ,true)
	showCursor(true)
end
addEventHandler("showSuperGUI_Event",getRootElement(),showSuperShopGUI)

SuperShop_Discription={"Beschreibung:\nBlumen fuer deine Liebste!","Beschreibung:\n50 Fotos und dann ab in die Tonne damit","Beschreibung:\n25 Prozent Benzin um bis zur naechsten Tankstelle zu kommen!","Beschreibung:\n3 aus 100\nBei 3 Richtigen gibt es den Jackpot! Die Ziehungen werden jeden Tag 19 Uhr durchgeführt! Der Jackpot ist 75% des Preises der gekauften Lottoscheine!\n Nutzung: /lotto [1-100] [1-100] [1-100]! Pro Ziehung ist nur 1 Schein moeglich abzugeben! Mit /jackpot kann der aktuelle Jackpot abgefragt werden!","Beschreibung:\\nBei Rubbellosen rubbelst du 3 Felder mit den Zahlen 1-10 frei! Bei 3 gleichen gleichen wird eine Zahl mit 1000 multipliziert! Bei 3 aufeinander Folgenden Zahlen wird der Preis direkt so abgelesen (Ausnahme: 8-9-10 = 8-9-0)!","kleines Essen","Fuellt den Essensbalken um die Haelfte","Fuellt den Essensbalken komplett","Volles Essen mit Heilung und 20 Minuten kein Essen mehr","Mit diesen Geraet kannst du mit dem Command /carfind [SlotID] dein Auto finden!","Spielt einen kleinen Ton ab wenn man in den 70 Meterradius eines Hufeisens eindringt! ACHTUNG: zu jedem Payday verschwindet ein Hufeisenhelfer","Mobiles Tappgerät - erweitert sich durch Tapps","digitale Tachoerweiterung - erweitert das Tacho um eine digitale Anzeige der Geschwindigkeit","Schützt vor Geschlechtskrankheiten"}

function clickOnSuperShopGui()
	if(guiGetVisible(SuperShop_Window[1]))then
		local row,colum=guiGridListGetSelectedItem ( SuperShop_Grid[1])
		if(row ~= -1)then
			local id=guiGridListGetItemText ( SuperShop_Grid[1], row, SuperShop_Colum[1])
			guiSetText(SuperShop_Label[1],SuperShop_Discription[tonumber(id)])		
		else
			guiSetText(SuperShop_Label[1],"Beschreibung:")
		end
    end
end
addEventHandler("onClientGUIClick",getRootElement(),clickOnSuperShopGui)











