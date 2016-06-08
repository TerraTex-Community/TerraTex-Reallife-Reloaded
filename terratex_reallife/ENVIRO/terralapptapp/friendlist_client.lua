Fiendlist={}
addEventHandler("onClientResourceStart",resourceRoot,
    function()
        TappFriendlist_Window = {}
        TappFriendlist_TabPanel = {}
        TappFriendlist_Tab = {}
        TappFriendlist_Button = {}
        TappFriendlist_Label = {}
        TappFriendlist_Edit = {}
        TappFriendlist_Grid = {}

		local dx,dy=guiGetScreenSize()
		dx=574/1600*dx
		dy=214/900*dy	
		
        TappFriendlist_Window[1] = guiCreateWindow(574,214,482,530,"FriendTapp! List Your Friends!",false)
		table.insert(allGuis,TappFriendlist_Window[1])
        TappFriendlist_Button[1] = guiCreateButton(0.0228,0.0453,0.9419,0.0491,"Beenden!",true,TappFriendlist_Window[1])
        TappFriendlist_TabPanel[1] = guiCreateTabPanel(0.0353,0.1132,0.9357,0.8566,true,TappFriendlist_Window[1])
        TappFriendlist_Tab[1] = guiCreateTab("Freunde",TappFriendlist_TabPanel[1])
        TappFriendlist_Grid[1] = guiCreateGridList(0.031,0.0279,0.4124,0.9279,true,TappFriendlist_Tab[1])
        guiGridListSetSelectionMode(TappFriendlist_Grid[1],2)
        guiGridListAddColumn(TappFriendlist_Grid[1],"Nickname",0.5)
        guiGridListAddColumn(TappFriendlist_Grid[1],"Telenummer",0.3)
        TappFriendlist_Label[1] = guiCreateLabel(0.4878,0.0372,0.5033,0.1093,"!!! Telefonnummer wird nur angezeigt wenn die Person Online ist (grüne Farbgebung)!!!",true,TappFriendlist_Tab[1])
        guiLabelSetHorizontalAlign(TappFriendlist_Label[1],"left",true)
        TappFriendlist_Button[2] = guiCreateButton(0.5432,0.1744,0.4235,0.0674,"Freund löschen!",true,TappFriendlist_Tab[1])
        TappFriendlist_Button[3] = guiCreateButton(0.5432,0.2512,0.4235,0.0674,"Anrufen!",true,TappFriendlist_Tab[1])
        TappFriendlist_Edit[1] = guiCreateEdit(0.592,0.3395,0.3769,0.0581,"smstext",true,TappFriendlist_Tab[1])
        TappFriendlist_Label[2] = guiCreateLabel(0.4812,0.3535,0.0843,0.0326,"Text:",true,TappFriendlist_Tab[1])
        TappFriendlist_Button[4] = guiCreateButton(0.5432,0.4116,0.4235,0.0674,"SMS schreiben!",true,TappFriendlist_Tab[1])
        TappFriendlist_Button[5] = guiCreateButton(0.5432,0.4884,0.4235,0.0674,"Anstupsen!",true,TappFriendlist_Tab[1])
        TappFriendlist_Button[6] = guiCreateButton(0.5432,0.5674,0.4235,0.0674,"Deine Position 20s zeigen!",true,TappFriendlist_Tab[1])
        TappFriendlist_Tab[2] = guiCreateTab("Deine Freundesanfragen",TappFriendlist_TabPanel[1])
        TappFriendlist_Grid[2] = guiCreateGridList(0.0488,0.0372,0.3636,0.8953,true,TappFriendlist_Tab[2])
        guiGridListSetSelectionMode(TappFriendlist_Grid[2],2)
        guiGridListAddColumn(TappFriendlist_Grid[2],"Nickname",0.8)
        TappFriendlist_Button[7] = guiCreateButton(0.5322,0.0488,0.4346,0.0535,"Anfrage zurückziehen!",true,TappFriendlist_Tab[2])
        TappFriendlist_Button[8] = guiCreateButton(0.5322,0.3279,0.4346,0.0535,"Anfrage stellen!",true,TappFriendlist_Tab[2])
        TappFriendlist_Edit[2] = guiCreateEdit(0.6231,0.2605,0.3459,0.0605,"Mein_Freund",true,TappFriendlist_Tab[2])
        TappFriendlist_Label[3] = guiCreateLabel(0.5277,0.2721,0.1175,0.0349,"Name:",true,TappFriendlist_Tab[2])
        TappFriendlist_Tab[3] = guiCreateTab("gestellte Anfragen",TappFriendlist_TabPanel[1])
        TappFriendlist_Grid[3] = guiCreateGridList(0.051,0.0349,0.3703,0.914,true,TappFriendlist_Tab[3])
        guiGridListSetSelectionMode(TappFriendlist_Grid[3],2)
        guiGridListAddColumn(TappFriendlist_Grid[3],"Nickname",0.8)
        TappFriendlist_Button[9] = guiCreateButton(0.4967,0.0465,0.4501,0.0488,"Anfrage ablehnen!",true,TappFriendlist_Tab[3])
        TappFriendlist_Button[10] = guiCreateButton(0.4967,0.1116,0.4501,0.0488,"Anfrage annehmen!",true,TappFriendlist_Tab[3])
		guiSetVisible(TappFriendlist_Window[1],false)
		
		addEventHandler("onClientGUIClick",TappFriendlist_Button[1],cancelFriendlist,false)
		addEventHandler("onClientGUIClick",TappFriendlist_Button[2],deleteFromFriendlist,false)
		addEventHandler("onClientGUIClick",TappFriendlist_Button[3],anrufenFromFriendlist,false)
		addEventHandler("onClientGUIClick",TappFriendlist_Button[4],smsFromFriendlist,false)
		addEventHandler("onClientGUIClick",TappFriendlist_Button[5],anstupsenFromFriendlist,false)
		addEventHandler("onClientGUIClick",TappFriendlist_Button[6],poszeigenFromFriendlist,false)
		addEventHandler("onClientGUIClick",TappFriendlist_Button[7],backanfrageFromFriendlist,false)
		addEventHandler("onClientGUIClick",TappFriendlist_Button[8],sendanfrageFromFriendlist,false)
		addEventHandler("onClientGUIClick",TappFriendlist_Button[9],ablehnenFromFriendlist,false)		
		addEventHandler("onClientGUIClick",TappFriendlist_Button[10],annehmenFromFriendlist,false)
		
		triggerServerEvent("getRequestAndFriendList",getLocalPlayer())
    end
)
function annehmenFromFriendlist()
	local row,colum=guiGridListGetSelectedItem ( TappFriendlist_Grid[3])
	if(row ~= -1)then
		local name=guiGridListGetItemText ( TappFriendlist_Grid[3], row, 1)
		triggerServerEvent("annehmenAnfrageFriendlist",getLocalPlayer(),name)
	else
		showError(getLocalPlayer(),"Du hast niemanden ausgwählt!")
	end
end

function ablehnenFromFriendlist()
	local row,colum=guiGridListGetSelectedItem ( TappFriendlist_Grid[3])
	if(row ~= -1)then
		local name=guiGridListGetItemText ( TappFriendlist_Grid[3], row, 1)
		triggerServerEvent("ablehnenAnfrageFriendlist",getLocalPlayer(),name)
	else
		showError(getLocalPlayer(),"Du hast niemanden ausgwählt!")
	end
end


function sendanfrageFromFriendlist()
	local name=guiGetText(TappFriendlist_Edit[2])
	triggerServerEvent("sendAnfrageFriendlist",getLocalPlayer(),name)
end

function backanfrageFromFriendlist()	
	local row,colum=guiGridListGetSelectedItem ( TappFriendlist_Grid[2])
	if(row ~= -1)then
		local name=guiGridListGetItemText ( TappFriendlist_Grid[2], row, 1)
		triggerServerEvent("getAnfrageBackFriendlist",getLocalPlayer(),name)
	else
		showError(getLocalPlayer(),"Du hast niemanden ausgwählt!")
	end
end

function poszeigenFromFriendlist()
	local row,colum=guiGridListGetSelectedItem ( TappFriendlist_Grid[1])
	if(row ~= -1)then
		local name=guiGridListGetItemText ( TappFriendlist_Grid[1], row, 1)
		if(getPlayerFromName(name))then
			triggerServerEvent("showMyPosFriendlist",getLocalPlayer(),name)	
		else
			showError(getLocalPlayer(),"Dieser Spieler ist nicht Online!")		
		end		
	else
		showError(getLocalPlayer(),"Du hast niemanden ausgwählt!")
	end
end

function anstupsenFromFriendlist()
	local row,colum=guiGridListGetSelectedItem ( TappFriendlist_Grid[1])
	if(row ~= -1)then
		local name=guiGridListGetItemText ( TappFriendlist_Grid[1], row, 1)
		if(getPlayerFromName(name))then
			triggerServerEvent("anstupsenFriendlist",getLocalPlayer(),name)	
		else
			showError(getLocalPlayer(),"Dieser Spieler ist nicht Online!")		
		end		
	else
		showError(getLocalPlayer(),"Du hast niemanden ausgwählt!")
	end
end

function smsFromFriendlist()
	local row,colum=guiGridListGetSelectedItem ( TappFriendlist_Grid[1])
	if(row ~= -1)then
		local name=guiGridListGetItemText ( TappFriendlist_Grid[1], row, 1)
		if(getPlayerFromName(name))then
			local numer=getElementData(getPlayerFromName(name),"telefon")		
			local smstext=guiGetText(TappFriendlist_Edit[1])
			triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"sms",numer.." "..smstext)		
		else
			showError(getLocalPlayer(),"Dieser Spieler ist nicht Online!")		
		end		
	else
		showError(getLocalPlayer(),"Du hast niemanden ausgwählt!")
	end
end

function anrufenFromFriendlist()
	local row,colum=guiGridListGetSelectedItem ( TappFriendlist_Grid[1])
	if(row ~= -1)then
		local name=guiGridListGetItemText ( TappFriendlist_Grid[1], row, 1)
		if(getPlayerFromName(name))then
			local numer=getElementData(getPlayerFromName(name),"telefon")			
			triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"call",numer)		
		else
			showError(getLocalPlayer(),"Dieser Spieler ist nicht Online!")		
		end		
	else
		showError(getLocalPlayer(),"Du hast niemanden ausgwählt!")
	end
end

function deleteFromFriendlist()
	local row,colum=guiGridListGetSelectedItem ( TappFriendlist_Grid[1])
	if(row ~= -1)then
		local name=guiGridListGetItemText ( TappFriendlist_Grid[1], row, 1)
		triggerServerEvent("deleteFromFriendlist_Event",getLocalPlayer(),name)
	else
		showError(getLocalPlayer(),"Du hast niemanden ausgwählt!")
	end
end

function cancelFriendlist()
	guiSetVisible(TappFriendlist_Window[1],false)
end
function showFriendlistGui()
	guiSetVisible(TappFriendlist_Window[1],true)
	triggerServerEvent("getRequestAndFriendList",getLocalPlayer())
	guiGridListClear ( TappFriendlist_Grid[1] )
	guiGridListClear ( TappFriendlist_Grid[2] )
	guiGridListClear ( TappFriendlist_Grid[3] )
end
addEvent("sendrequestInfos",true)
function friendlist_insert_grids(requestTable,sendRequestTable,friendlistTable)
	guiGridListClear ( TappFriendlist_Grid[1] )
	guiGridListClear ( TappFriendlist_Grid[2] )
	guiGridListClear ( TappFriendlist_Grid[3] )
	for theKey,theName in ipairs(requestTable)do
		--TappFriendlist_Grid[3]
		local row = guiGridListAddRow ( TappFriendlist_Grid[3] )
		--outputChatBox(theName)
        guiGridListSetItemText ( TappFriendlist_Grid[3], row, 1, theName, false, false )	
	end
	for theKey,theName in ipairs(sendRequestTable)do
		--TappFriendlist_Grid[3]
		local row = guiGridListAddRow ( TappFriendlist_Grid[2] )
		--outputChatBox(theName)
        guiGridListSetItemText ( TappFriendlist_Grid[2], row, 1, theName, false, false )	
	end
	for theKey,theName in ipairs(friendlistTable)do
		--TappFriendlist_Grid[3]
		local row = guiGridListAddRow ( TappFriendlist_Grid[1] )
		--outputChatBox(theName)
        guiGridListSetItemText ( TappFriendlist_Grid[1], row, 1, theName, false, false )
		if(getPlayerFromName(theName))then
			guiGridListSetItemText ( TappFriendlist_Grid[1], row, 2, tostring(getElementData(getPlayerFromName(theName),"telefon")), false, false )
			guiGridListSetItemColor ( TappFriendlist_Grid[1], row, 1, 0,255,0 )
			guiGridListSetItemColor ( TappFriendlist_Grid[1], row, 2, 0,255,0 )
		end
	end
	Fiendlist=friendlistTable
end
addEventHandler("sendrequestInfos",getRootElement(),friendlist_insert_grids)



















