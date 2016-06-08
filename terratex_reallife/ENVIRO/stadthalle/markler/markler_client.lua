
        marklerGUI_Window = {}
        marklerGUI_TabPanel = {}
        marklerGUI_Tab = {}
        marklerGUI_Button = {}
        marklerGUI_Label = {}
        marklerGUI_Grid = {}
		marklerGUI_Column={}

addEventHandler("onClientResourceStart",resourceRoot,
    function()

        marklerGUI_Window[1] = guiCreateWindow(0.3744,0.2889,0.2919,0.5233,"Haus- und Buisnessmakler",true)
        marklerGUI_Label[1] = guiCreateLabel(0.0364,0.0786,0.9229,0.0955,"Klicke auf die ID des Hauses oder des Buisness und klicke auf finden!\nDie Nutzung des Maklers kostet 5000$",true,marklerGUI_Window[1])
        marklerGUI_Button[1] = guiCreateButton(0.6381,0.1274,0.3383,0.0594,"Beenden!",true,marklerGUI_Window[1])
        marklerGUI_TabPanel[1] = guiCreateTabPanel(0.0278,0.2059,0.9465,0.7643,true,marklerGUI_Window[1])
        marklerGUI_Tab[1] = guiCreateTab("Haus",marklerGUI_TabPanel[1])
        marklerGUI_Button[2] = guiCreateButton(0.7172,0.0268,0.2579,0.0863,"Haus finden!",true,marklerGUI_Tab[1])
        marklerGUI_Grid[1] = guiCreateGridList(0.0339,0.1399,0.9321,0.8095,true,marklerGUI_Tab[1])
        guiGridListSetSelectionMode(marklerGUI_Grid[1],0)

        marklerGUI_Column[1]=guiGridListAddColumn(marklerGUI_Grid[1],"ID",0.2)

        marklerGUI_Column[2]=guiGridListAddColumn(marklerGUI_Grid[1],"Ort",0.3)

        marklerGUI_Column[3]=guiGridListAddColumn(marklerGUI_Grid[1],"Beschreibung",0.4)

        guiGridListAddColumn(marklerGUI_Grid[1],"Preis",0.2)
        marklerGUI_Tab[2] = guiCreateTab("Buissness",marklerGUI_TabPanel[1])
        marklerGUI_Button[3] = guiCreateButton(0.6674,0.0357,0.2964,0.1042,"Buisness finden!",true,marklerGUI_Tab[2])
        marklerGUI_Grid[2] = guiCreateGridList(0.043,0.1726,0.9253,0.7857,true,marklerGUI_Tab[2])
        guiGridListSetSelectionMode(marklerGUI_Grid[2],0)

        marklerGUI_Column[4]=guiGridListAddColumn(marklerGUI_Grid[2],"ID",0.2)

        marklerGUI_Column[5]=guiGridListAddColumn(marklerGUI_Grid[2],"Name",0.3)

        marklerGUI_Column[6]=guiGridListAddColumn(marklerGUI_Grid[2],"Preis",0.3)
		
		guiSetVisible(marklerGUI_Window[1],false)
		
		addEventHandler ( "onClientGUIClick", marklerGUI_Button[1], close_MarklerGui, false )
		addEventHandler ( "onClientGUIClick", marklerGUI_Button[2], press_find_house_button, false )
		addEventHandler ( "onClientGUIClick", marklerGUI_Button[3], press_find_biz_button, false )
    end
)

function press_find_house_button()

	local row,colum=guiGridListGetSelectedItem ( marklerGUI_Grid[1])
	if(row ~= -1)then
		local id=tonumber(guiGridListGetItemText ( marklerGUI_Grid[1], row, marklerGUI_Column[1]))
		triggerServerEvent("findHouseMarkler",getLocalPlayer(),id)
		guiSetVisible(marklerGUI_Window[1],false)
		showCursor(false)
		toggleAllControls(true)
	else
		showError(getLocalPlayer(),"Du hast kein Haus ausgewaehlt!")
	end




end


function press_find_biz_button()
	local row,colum=guiGridListGetSelectedItem ( marklerGUI_Grid[2])
	if(row ~= -1)then
		local id=tonumber(guiGridListGetItemText ( marklerGUI_Grid[2], row, marklerGUI_Column[4]))
		triggerServerEvent("findBizMarkler",getLocalPlayer(),id)
		guiSetVisible(marklerGUI_Window[1],false)
		showCursor(false)
		toggleAllControls(true)
		
	else
		showError(getLocalPlayer(),"Du hast kein Buissness ausgewaehlt!")
	end





end










addEvent("openMarklerGui",true)
function openMarklerGui_function(houseTable,bizTable,bizZoneTable)
	guiSetVisible(marklerGUI_Window[1],true)
	showCursor(true)
	toggleAllControls(false)
	guiGridListClear(marklerGUI_Grid[1])
	guiGridListClear(marklerGUI_Grid[2])
	for theKey,theHouse in pairs(houseTable) do
		if not(theHouse["besitzer"])then
            local tausstatt="heruntergekommenden"
            if( theHouse["wert"] == 1)then
                tausstatt="mittelständig"
            elseif(theHouse["wert"] == 2)then
                tausstatt="luxuriös"
            end

            rows=guiGridListAddRow(marklerGUI_Grid[1])
			guiGridListSetItemText ( marklerGUI_Grid[1], rows, 1, tostring(theHouse["ID"]), false,false )
			guiGridListSetItemText ( marklerGUI_Grid[1], rows, 2, getZoneName(theHouse["coords"][1],theHouse["coords"][2],theHouse["coords"][3]), false,true )
			guiGridListSetItemText ( marklerGUI_Grid[1], rows, 3, theHouse["qm"].." qm -"..tausstatt, false,true )
			guiGridListSetItemText ( marklerGUI_Grid[1], rows, 4, toprice(theHouse["preis"]), false,true )

			
			
		
		end	
	end
	
	for theKey,theBiz in ipairs(bizTable) do
		if not(theBiz["Besitzer"])then
			
			rows=guiGridListAddRow(marklerGUI_Grid[2])
			guiGridListSetItemText ( marklerGUI_Grid[2], rows, 1, tostring(theKey), false,false )
			guiGridListSetItemText ( marklerGUI_Grid[2], rows, 2, theBiz["Name"], false,true )
			guiGridListSetItemText ( marklerGUI_Grid[2], rows, 3, tostring(theBiz["Preis"]), false,true )		
			
		
		end	
	end
	

end
addEventHandler("openMarklerGui",getRootElement(),openMarklerGui_function)





function close_MarklerGui()

	guiSetVisible(marklerGUI_Window[1],false)
	showCursor(false)
	toggleAllControls(true)

end












