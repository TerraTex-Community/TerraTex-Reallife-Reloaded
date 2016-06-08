	ArenaGUI_Window = {}
    ArenaGUI_Button = {}
    ArenaGUI_Label = {}
    ArenaGUI_Grid = {}
	ArenaGUI_Colum={}
addEventHandler("onClientResourceStart",resourceRoot,
    function()
        
		local sx,sy=guiGetScreenSize ()
		sx=(459/1600)*sx
		sy=(287/800)*sy
        ArenaGUI_Window[1] = guiCreateWindow(sx,sy,658,498,"Arenen",false)
		table.insert(allGuis,ArenaGUI_Window[1])
        ArenaGUI_Button[1] = guiCreateButton(0.6945,0.0643,0.2568,0.0683,"Beenden",true,ArenaGUI_Window[1])
        ArenaGUI_Button[2] = guiCreateButton(0.69,0.1446,0.2629,0.0743,"Betretten",true,ArenaGUI_Window[1])
        ArenaGUI_Label[1] = guiCreateLabel(0.0289,0.0542,0.6155,0.1647,"Willkommen bei den LS-Arenen!\nDer Eintritt für jede Arena kostet 50$!",true,ArenaGUI_Window[1])
        ArenaGUI_Grid[1] = guiCreateGridList(0.0274,0.245,0.9438,0.7269,true,ArenaGUI_Window[1])
        guiGridListSetSelectionMode(ArenaGUI_Grid[1],0)
		guiGridListSetSortingEnabled ( ArenaGUI_Grid[1], false )
		
        ArenaGUI_Colum[1]=guiGridListAddColumn(ArenaGUI_Grid[1],"ID",0.1)
        ArenaGUI_Colum[2]=guiGridListAddColumn(ArenaGUI_Grid[1],"Arena",0.2)
        ArenaGUI_Colum[3]=guiGridListAddColumn(ArenaGUI_Grid[1],"MaxPlayers",0.2)
        ArenaGUI_Colum[4]=guiGridListAddColumn(ArenaGUI_Grid[1],"Player",0.2)
        ArenaGUI_Colum[5]=guiGridListAddColumn(ArenaGUI_Grid[1],"PlayTime",0.2)
		
		addEventHandler ( "onClientGUIClick", ArenaGUI_Button[1], closeArenaGui, false )
		addEventHandler ( "onClientGUIClick", ArenaGUI_Button[2], goArenaGui, false )
		
		guiSetVisible(ArenaGUI_Window[1],false)
    end
)

function goArenaGui()
	local row,colu=guiGridListGetSelectedItem ( ArenaGUI_Grid[1] )
	if(row==-1)then
	else
		triggerServerEvent("goArena_Event",getLocalPlayer(),(row+1))
		closeArenaGui()
	end
end

addEvent("showArenenGui",true)
function showArenenGui_func(gungamePlayer,gungamerestzeit,stuntplayers,activeDurbyPlayers,getDurbyRestTime,getRestTimeType)
	showCursor(true)
	guiSetVisible(ArenaGUI_Window[1],true)
	guiGridListClear (ArenaGUI_Grid[1])
	row=guiGridListAddRow(ArenaGUI_Grid[1])--gungame
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[1], "1", false, true )
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[2], "GunGame", false, true )
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[3], "16", false, true )
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[4], tostring(gungamePlayer), false, true )
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[5], tostring(gungamerestzeit), false, true )	
	row=guiGridListAddRow(ArenaGUI_Grid[1])--stunt
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[1], "2", false, true )
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[2],  "kleine Stunt", false, true )
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[3], "-", false, true )
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[4], tostring(stuntplayers), false, true )
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[5], "-", false, true )			
	row=guiGridListAddRow(ArenaGUI_Grid[1])--durby
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[1], "3", false, true )
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[2],  "Durby/Crashcar", false, true )
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[3], "12", false, true )
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[4], tostring(activeDurbyPlayers), false, true )
			
		local timestring="-"
		if(getRestTimeType)then
			if tonumber(getRestTimeType)then
				timestring=tostring(getDurbyRestTime)
			else
				timestring=tostring(-tonumber(getDurbyRestTime))
			end
		end	
		guiGridListSetItemText ( ArenaGUI_Grid[1], row, ArenaGUI_Colum[5], timestring, false, true )	
		


end
addEventHandler("showArenenGui",getRootElement(),showArenenGui_func)



function closeArenaGui()
	showCursor(false)
	guiSetVisible(ArenaGUI_Window[1],false)
end









