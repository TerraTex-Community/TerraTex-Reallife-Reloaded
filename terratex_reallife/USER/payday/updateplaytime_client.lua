        GUIPayDay_Window = {}
        GUIPayDay_Button = {}
        GUIPayDay_Grid = {}
		GUIPayDayClomus={}
addEventHandler("onClientResourceStart",resourceRoot,
    function()


        GUIPayDay_Window[1] = guiCreateWindow(0.3225,0.1989,0.3394,0.5878,"PayDay",true)
		table.insert(allGuis,GUIPayDay_Window[1])
        GUIPayDay_Button[1] = guiCreateButton(0.0184,0.9225,0.9595,0.0529,"Beenden!",true,GUIPayDay_Window[1])
        GUIPayDay_Grid[1] = guiCreateGridList(0.0313,0.0681,0.9484,0.8318,true,GUIPayDay_Window[1])
        guiGridListSetSelectionMode(GUIPayDay_Grid[1],2)

        GUIPayDayClomus[1]=guiGridListAddColumn(GUIPayDay_Grid[1],"Name",0.5)

        GUIPayDayClomus[2]=guiGridListAddColumn(GUIPayDay_Grid[1],"Einnahmen",0.2)

        GUIPayDayClomus[3]=guiGridListAddColumn(GUIPayDay_Grid[1],"Ausgaben",0.2)
		
		guiSetVisible(GUIPayDay_Window[1],false)		
		addEventHandler ( "onClientGUIClick", GUIPayDay_Button[1], PayDayBeendenButtonClick, false )
    end
)

function PayDayBeendenButtonClick()
	guiSetVisible(GUIPayDay_Window[1],false)	
	showCursor(false)
end



addEvent("showPayDayGui",true)
function payDayShowFunc(paydaytable)
	guiGridListClear(GUIPayDay_Grid[1])
	for theKey,theEinnahmtable in ipairs(paydaytable)do
		row=guiGridListAddRow(GUIPayDay_Grid[1])
		guiGridListSetItemText ( GUIPayDay_Grid[1], row, GUIPayDayClomus[1], theEinnahmtable[1], false, true )
		if(theEinnahmtable[2]~=0)then
			guiGridListSetItemText ( GUIPayDay_Grid[1], row, GUIPayDayClomus[2], toprice(theEinnahmtable[2]), false, true )
			guiGridListSetItemColor ( GUIPayDay_Grid[1], row, GUIPayDayClomus[1], 0,255,0,255 )
			guiGridListSetItemColor ( GUIPayDay_Grid[1], row, GUIPayDayClomus[2], 0,255,0,255 )
		else
			guiGridListSetItemText ( GUIPayDay_Grid[1], row, GUIPayDayClomus[3], toprice(theEinnahmtable[3]), false, true )
			guiGridListSetItemColor ( GUIPayDay_Grid[1], row, GUIPayDayClomus[1], 255,0,0,255 )
			guiGridListSetItemColor ( GUIPayDay_Grid[1], row, GUIPayDayClomus[3], 255,0,0,255 )
		end		
	end

		guiSetVisible(GUIPayDay_Window[1],true)
		showCursor(true)

end
addEventHandler("showPayDayGui",getRootElement(),payDayShowFunc)








