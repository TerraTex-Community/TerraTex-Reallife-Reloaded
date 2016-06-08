        GUIjobMarkler_Window = {}
        GUIjobMarkler_Button = {}
        GUIjobMarkler_Grid = {}
-- Created: 06/05/2012 18:15
addEventHandler("onClientResourceStart",resourceRoot,
    function()
		local dx,dy=guiGetScreenSize()
		dx=479/1600*dx
		dy=296/900*dy
        GUIjobMarkler_Window[1] = guiCreateWindow(dx,dy,380,379,"Jobbörse",false)
		table.insert(allGuis,GUIjobMarkler_Window[1])
        GUIjobMarkler_Button[1] = guiCreateButton(16,331,176,31,"ShowJob",false,GUIjobMarkler_Window[1])
        GUIjobMarkler_Button[2] = guiCreateButton(204,332,166,31,"Beenden",false,GUIjobMarkler_Window[1])
        GUIjobMarkler_Grid[1] = guiCreateGridList(21,38,342,269,false,GUIjobMarkler_Window[1])
        guiGridListSetSelectionMode(GUIjobMarkler_Grid[1],2)
        guiGridListAddColumn(GUIjobMarkler_Grid[1],"JobID",0.15)
        guiGridListAddColumn(GUIjobMarkler_Grid[1],"JobName",0.5)
        guiGridListAddColumn(GUIjobMarkler_Grid[1],"Spielerabhängig",0.25)
        for i = 1, 17 do
            guiGridListAddRow(GUIjobMarkler_Grid[1])
		end
        guiGridListSetItemText(GUIjobMarkler_Grid[1],0,1,"1",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],1,1,"2",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],2,1,"3",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],3,1,"4",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],4,1,"5",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],5,1,"6",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],6,1,"8",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],7,1,"9",false,false)		
        guiGridListSetItemText(GUIjobMarkler_Grid[1],8,1,"10",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],9,1,"11",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],10,1,"12",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],11,1,"13",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],12,1,"14",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],13,1,"15",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],14,1,"16",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],15,1,"17",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],16,1,"18",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],0,2,"Fischerjob",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],1,2,"Drogendealer",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],2,2,"Müllmannjob",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],3,2,"Busfahrer",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],4,2,"Mechaniker",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],5,2,"Detektiv",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],6,2,"Pizzalieferantenjob",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],7,2,"Anwalt",false,false)		
        guiGridListSetItemText(GUIjobMarkler_Grid[1],8,2,"Waffendealer",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],9,2,"Trucker",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],10,2,"Pilot",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],11,2,"Straßenputzer/Sweeper",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],12,2,"Farmer",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],13,2,"Bergwerksarbeiter",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],14,2,"Nutte",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],15,2,"Meeresreiniger",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],16,2,"Hotdogverkäufer",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],0,3,"Nein",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],1,3,"Ja",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],2,3,"Nein",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],3,3,"Nein und Ja",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],4,3,"Ja",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],5,3,"Ja",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],6,3,"Nein",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],7,3,"Ja",false,false)	
        guiGridListSetItemText(GUIjobMarkler_Grid[1],8,3,"Ja",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],9,3,"Nein",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],10,3,"Nein",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],11,3,"Nein",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],12,3,"Nein",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],13,3,"Nein",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],14,3,"Ja",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],15,3,"Nein",false,false)
        guiGridListSetItemText(GUIjobMarkler_Grid[1],16,3,"Ja",false,false)
		guiSetVisible(GUIjobMarkler_Window[1],false)
		addEventHandler("onClientGUIClick",GUIjobMarkler_Button[1],showJobMarklerMarker,false)
		addEventHandler("onClientGUIClick",GUIjobMarkler_Button[2],canceljobMarkler,false)
		local marker=createMarker(359.2421875,182.490234375,1007.3828125,"cylinder",2.0)
		setElementInterior(marker,3)
		addEventHandler("onClientMarkerHit",marker,showJobMarklerGui)
    end
)
local beforeJobMarklerBlip=false

function showJobMarklerMarker()
	local row,colu=guiGridListGetSelectedItem ( GUIjobMarkler_Grid[1] )
	if(row==-1)then
	else
		local jobNummer=tonumber(guiGridListGetItemText(GUIjobMarkler_Grid[1],row,1))
		triggerServerEvent("showJobMarklerBlip",getLocalPlayer(),jobNummer)
		outputChatBox("Die entsprechende Jobmarkierung wurde Rot Hinterlegt auf deiner Karte!")	
	end
end

function canceljobMarkler()
	showCursor(false)
	guiSetVisible(GUIjobMarkler_Window[1],false)
end

function showJobMarklerGui(thePlayer)
	if(thePlayer==getLocalPlayer())and(getElementInterior(thePlayer)==3)then
		showCursor(true)
		guiSetVisible(GUIjobMarkler_Window[1],true)
	end
end









