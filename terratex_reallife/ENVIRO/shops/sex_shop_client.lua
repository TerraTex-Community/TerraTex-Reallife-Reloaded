
        SexShop_Window = {}
        SexShop_Button = {}
        SexShop_Label = {}
        SexShop_Grid = {}
		SexShop_Colum={}

addEventHandler("onClientResourceStart",resourceRoot,
    function()

        SexShop_Window[1] = guiCreateWindow(0.3494,0.25,0.3894,0.4467,"SexShop",true)
		table.insert(allGuis,SexShop_Window[1])
        SexShop_Button[1] = guiCreateButton(0.0144,0.0721,0.9679,0.092,"Beenden",true,SexShop_Window[1])
        SexShop_Button[2] = guiCreateButton(0.0144,0.9129,0.9679,0.0647,"Kaufen",true,SexShop_Window[1])

        SexShop_Grid[1] = guiCreateGridList(0.0209,0.1891,0.6388,0.6841,true,SexShop_Window[1])
			guiGridListSetSelectionMode(SexShop_Grid[1],0)
			SexShop_Colum[1]=guiGridListAddColumn(SexShop_Grid[1],"ID",0.2)
			SexShop_Colum[2]=	guiGridListAddColumn(SexShop_Grid[1],"Name",0.2)
			SexShop_Colum[3]=	guiGridListAddColumn(SexShop_Grid[1],"Preis",0.2)
		guiSetVisible(SexShop_Window[1],false)
		
		
		local row = guiGridListAddRow ( SexShop_Grid[1] )
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[1], "1", false, false )		
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[2], "keliner weißer Dildo", false, false )		
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[3], "4.99", false, false )
		
		local row = guiGridListAddRow ( SexShop_Grid[1] )
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[1], "2", false, false )		
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[2], "weißer Vibrator", false, false )		
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[3], "9.95", false, false )
		
		local row = guiGridListAddRow ( SexShop_Grid[1] )
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[1], "3", false, false )		
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[2], "Silver Vibrator", false, false )		
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[3], "9.95", false, false )
		
		local row = guiGridListAddRow ( SexShop_Grid[1] )
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[1], "4", false, false )		
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[2], "langer Doppeldildo", false, false )		
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[3], "14.99", false, false )
		
				row = guiGridListAddRow ( SexShop_Grid[1] )
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[1], "5", false, false )		
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[2], "5er Packung Kondome", false, false )		
        guiGridListSetItemText ( SexShop_Grid[1], row, SexShop_Colum[3], "2.50", false, false )
		

		
		addEventHandler("onClientGUIClick",SexShop_Button[1],closeSexShopGUI)
		addEventHandler("onClientGUIClick",SexShop_Button[2],buy_SexShop_Gui)
    end
)

function buy_SexShop_Gui()

	local row,colum=guiGridListGetSelectedItem ( SexShop_Grid[1])
	if(row ~= -1)then
		local id=guiGridListGetItemText ( SexShop_Grid[1], row, SexShop_Colum[1])
		triggerServerEvent("buySexShopGUI_Event",getLocalPlayer(),tonumber(id))
	else
        showError(getLocalPlayer(),"Du hast keine Waren ausgewaehlt!")
	end

end


addEvent("closeShopGUIS",true)
function closeSexShopGUI()

	guiSetVisible( SexShop_Window[1] ,false)
	showCursor(false)
	triggerServerEvent("closeSexShopGUI_Event",getLocalPlayer())

end
function unshowShopGUIS()
	-- SuperShop_Window[1]
	guiSetVisible( SuperShop_Window[1] ,false)
	guiSetVisible( SexShop_Window[1] ,false)
end
addEventHandler("closeShopGUIS",getRootElement(),unshowShopGUIS)



addEvent("showSexGUI_Event",true)
function showSexShopGUI()

	guiSetVisible( SexShop_Window[1] ,true)
	showCursor(true)
end
addEventHandler("showSexGUI_Event",getRootElement(),showSexShopGUI)















