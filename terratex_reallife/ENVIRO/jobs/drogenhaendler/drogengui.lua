
addEventHandler("onClientResourceStart",resourceRoot,
    function()
        DrogenDealerGUI_Window = {}
        DrogenDealerGUI_Button = {}
        DrogenDealerGUI_Label = {}
        DrogenDealerGUI_Edit = {}

        DrogenDealerGUI_Window[1] = guiCreateWindow(240,199,365,376,"Drogenboss",false)
		table.insert(allGuis,DrogenDealerGUI_Window[1] )
        DrogenDealerGUI_Label[1] = guiCreateLabel(14,27,316,69,"Also... du willst also Drogen haben? Hast du denn Drogenpflanzen oder soll ich dir erst verraten wo welche sind? Nunja kannst ja auch hier Drogen kaufen!",false,DrogenDealerGUI_Window[1])
			guiLabelSetColor(DrogenDealerGUI_Label[1],255,255,255)
			guiLabelSetVerticalAlign(DrogenDealerGUI_Label[1],"top")
			guiLabelSetHorizontalAlign(DrogenDealerGUI_Label[1],"left",true)
        DrogenDealerGUI_Button[1] = guiCreateButton(9,342,345,25,"Beenden",false,DrogenDealerGUI_Window[1])
        DrogenDealerGUI_Label[2] = guiCreateLabel(20,96,141,23,"Aktueller Preis pro g:",false,DrogenDealerGUI_Window[1])
			guiLabelSetColor(DrogenDealerGUI_Label[2],255,255,255)
			guiLabelSetVerticalAlign(DrogenDealerGUI_Label[2],"top")
			guiLabelSetHorizontalAlign(DrogenDealerGUI_Label[2],"left",false)
        DrogenDealerGUI_Label[3] = guiCreateLabel(159,97,73,21,"10",false,DrogenDealerGUI_Window[1])
			guiLabelSetColor(DrogenDealerGUI_Label[3],255,255,255)
			guiLabelSetVerticalAlign(DrogenDealerGUI_Label[3],"top")
			guiLabelSetHorizontalAlign(DrogenDealerGUI_Label[3],"left",false)
        DrogenDealerGUI_Edit[1] = guiCreateEdit(170,129,163,31,"",false,DrogenDealerGUI_Window[1])
        DrogenDealerGUI_Label[4] = guiCreateLabel(53,132,119,29,"Menge an Drogen",false,DrogenDealerGUI_Window[1])
			guiLabelSetColor(DrogenDealerGUI_Label[4],255,255,255)
			guiLabelSetVerticalAlign(DrogenDealerGUI_Label[4],"top")
			guiLabelSetHorizontalAlign(DrogenDealerGUI_Label[4],"left",false)
        DrogenDealerGUI_Button[2] = guiCreateButton(48,162,288,29,"Kaufen!",false,DrogenDealerGUI_Window[1])
        DrogenDealerGUI_Label[5] = guiCreateLabel(11,185,344,28,"_______________________________________________________________________",false,DrogenDealerGUI_Window[1])
			guiLabelSetColor(DrogenDealerGUI_Label[5],255,255,255)
			guiLabelSetVerticalAlign(DrogenDealerGUI_Label[5],"top")
			guiLabelSetHorizontalAlign(DrogenDealerGUI_Label[5],"left",false)
        DrogenDealerGUI_Label[6] = guiCreateLabel(12,318,344,28,"_______________________________________________________________________",false,DrogenDealerGUI_Window[1])
			guiLabelSetColor(DrogenDealerGUI_Label[6],255,255,255)
			guiLabelSetVerticalAlign(DrogenDealerGUI_Label[6],"top")
			guiLabelSetHorizontalAlign(DrogenDealerGUI_Label[6],"left",false)
        DrogenDealerGUI_Label[7] = guiCreateLabel(33,227,297,81,"Drogenpflanzen Finden && Umwandeln erst ab einer spaeteren Version verfuegbar! Informationen unter tt-rl.de! Du kannst dort auch zu diesem Thema Vorschlaege abgeben!",false,DrogenDealerGUI_Window[1])
			guiLabelSetColor(DrogenDealerGUI_Label[7],255,255,255)
			guiLabelSetVerticalAlign(DrogenDealerGUI_Label[7],"top")
			guiLabelSetHorizontalAlign(DrogenDealerGUI_Label[7],"left",true)
			guiSetVisible(DrogenDealerGUI_Window[1] ,false)
			
			
		addEventHandler ( "onClientGUIClick", DrogenDealerGUI_Button[1], closeDrogenDealerGUI, false )
		addEventHandler ( "onClientGUIClick", DrogenDealerGUI_Button[2], buyDrogenDealerGUI, false )
    end
)

function buyDrogenDealerGUI()
	local menge=guiGetText(DrogenDealerGUI_Edit[1])
	if(menge)then
		if(tonumber(menge))then
			if(tonumber(menge)<0)then menge=menge*-1 end
			if(tonumber(menge)+tonumber(getElementData(getLocalPlayer(),"drogen")))>500 then
				showError(getLocalPlayer(),"Du kannst nur maximal 500g Drogen tragen und du hast bereits %s g dabei!", getElementData(getLocalPlayer(),"drogen"))
			else
				triggerServerEvent("wantBuyDrogenDealer_drogen",getLocalPlayer(),tonumber(menge))
			end
		end
	end
end

function closeDrogenDealerGUI()
	guiSetVisible(DrogenDealerGUI_Window[1] ,false)
	showCursor(false)
end

function showDrogenDealerGui(aktualprice)
	guiSetText(DrogenDealerGUI_Label[3],aktualprice)
	guiSetVisible(DrogenDealerGUI_Window[1] ,true)
	showCursor(true)
end
addEvent("openDrogenJobGui",true)
addEventHandler("openDrogenJobGui",getRootElement(),showDrogenDealerGui)











