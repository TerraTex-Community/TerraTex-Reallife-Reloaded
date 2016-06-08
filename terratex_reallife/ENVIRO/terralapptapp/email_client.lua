

-- Created: 17/08/2012 12:47
addEventHandler("onClientResourceStart",resourceRoot,
    function()
        emailtapp_Window = {}
        emailtapp_TabPanel = {}
        emailtapp_Tab = {}
        emailtapp_Button = {}
        emailtapp_Memo = {}
        emailtapp_Label = {}
        emailtapp_Edit = {}
        emailtapp_Grid = {}
		emailtapp_Combo={}
		
		local dx,dy=guiGetScreenSize()
		dx=515/1600*dx
		dy=271/900*dy	
        emailtapp_Window[1] = guiCreateWindow(dx,dy,546,516,"EMailTapp",false)
		table.insert(allGuis,emailtapp_Window[1])
        emailtapp_Button[1] = guiCreateButton(352,29,161,30,"Close",false,emailtapp_Window[1])
        emailtapp_Label[1] = guiCreateLabel(20,34,315,19,"Sie haben 0 ungelesen Nachichten!",false,emailtapp_Window[1])
        emailtapp_TabPanel[1] = guiCreateTabPanel(23,83,511,421,false,emailtapp_Window[1])
        emailtapp_Tab[1] = guiCreateTab("Lesen",emailtapp_TabPanel[1])
        emailtapp_Grid[1] = guiCreateGridList(18,27,370,126,false,emailtapp_Tab[1])
        guiGridListSetSelectionMode(emailtapp_Grid[1],0)
		guiGridListAddColumn(emailtapp_Grid[1],"id",0.1)
        guiGridListAddColumn(emailtapp_Grid[1],"Nickname",0.2)
        guiGridListAddColumn(emailtapp_Grid[1],"Betreff",0.5)
        guiGridListAddColumn(emailtapp_Grid[1],"erhalten am",0.2)
        emailtapp_Button[2] = guiCreateButton(394,29,101,27,"Antworten",false,emailtapp_Tab[1])
        emailtapp_Button[4] = guiCreateButton(394,64,101,27,"Löschen",false,emailtapp_Tab[1])
        emailtapp_Memo[1] = guiCreateMemo(28,171,469,213,"Mailinhalt_Keine EMail Ausgewählt",false,emailtapp_Tab[1])
		guiMemoSetReadOnly ( emailtapp_Memo[1], true )
        emailtapp_Tab[2] = guiCreateTab("Schreiben",emailtapp_TabPanel[1])
        emailtapp_Label[2] = guiCreateLabel(19,17,143,21,"Empfänger:",false,emailtapp_Tab[2])
        emailtapp_Edit[1] = guiCreateEdit(113,16,240,22,"",false,emailtapp_Tab[2])
        emailtapp_Label[3] = guiCreateLabel(14,42,217,34,"Empfänger aus Friendlist auswählen (nur wenn Friendtapp):",false,emailtapp_Tab[2])
        guiLabelSetHorizontalAlign(emailtapp_Label[3],"left",true)
        emailtapp_Combo[1]=guiCreateComboBox ( 229,44,232,90, "Friendlist",false, emailtapp_Tab[2])		
		emailtapp_Label[4] = guiCreateLabel(21,100,84,16,"Betreff:",false,emailtapp_Tab[2])
        emailtapp_Edit[2] = guiCreateEdit(98,96,207,27,"",false,emailtapp_Tab[2])
        emailtapp_Label[5] = guiCreateLabel(20,130,99,24,"Inhalt:",false,emailtapp_Tab[2])
        emailtapp_Memo[2] = guiCreateMemo(24,155,471,228,"",false,emailtapp_Tab[2])
        emailtapp_Button[6] = guiCreateButton(349,99,129,32,"Senden",false,emailtapp_Tab[2])
		
		
		addEventHandler ( "onClientGUIClick", emailtapp_Button[1], closeEMailTapp, false )
		addEventHandler ( "onClientGUIClick", emailtapp_Button[2], answerEMailTapp, false )
		addEventHandler ( "onClientGUIClick", emailtapp_Button[4], deleteEMailTapp, false )
		addEventHandler ( "onClientGUIClick", emailtapp_Button[6], sendEMailTapp, false )
		
		
		addEventHandler("onClientGUIDoubleClick", emailtapp_Grid[1],showEMailInBrowser,false)
		addEventHandler("onClientGUIComboBoxAccepted",emailtapp_Combo[1],setFriendInTextBox,false)
		guiSetVisible(emailtapp_Window[1],false)
		
		setTimer(emailaktualieren,15000,0)
    end
)

-- SENDEEVENT: sendEMail(empfaenger,betreff,inhalt)
local eMails={}

function sendEMailTapp()
	local empf=guiGetText(emailtapp_Edit[1])
	local betreff=guiGetText(emailtapp_Edit[2])
	local inhalt=guiGetText(emailtapp_Memo[2])
	triggerServerEvent("sendEMail",getLocalPlayer(),empf,betreff,inhalt)
end

function deleteEMailTapp()
	local clicked=guiGridListGetSelectedItems ( emailtapp_Grid[1] )
	local row=clicked[1]["row"]
	dbid=tonumber(guiGridListGetItemText ( emailtapp_Grid[1], row,1 ))
	triggerServerEvent("deleteEMail",getLocalPlayer(),dbid)
	guiGridListRemoveRow ( emailtapp_Grid[1],  row )
end

function answerEMailTapp()
	local clicked=guiGridListGetSelectedItems ( emailtapp_Grid[1] )
	local row=clicked[1]["row"]
	dbid=tonumber(guiGridListGetItemText ( emailtapp_Grid[1], row,1 ))
	for theKey,theEMailTable in ipairs(eMails)do 
		if(dbid==theEMailTable[7])then
			guiSetText(emailtapp_Edit[2],string.format("RE: %s", theEMailTable[4]))
			guiSetText(emailtapp_Edit[1],theEMailTable[2])
		end	
	end
	guiSetSelectedTab ( emailtapp_TabPanel[1], emailtapp_Tab[2] )
	
end

function showEMailInBrowser()
	local clicked=guiGridListGetSelectedItems ( emailtapp_Grid[1] )
	local row=clicked[1]["row"]
	dbid=tonumber(guiGridListGetItemText ( emailtapp_Grid[1], row,1 ))
	triggerServerEvent("setEMailReaded",getLocalPlayer(),dbid)
	guiGridListSetItemColor ( emailtapp_Grid[1],  row,  1, 255,  255,  255)
	guiGridListSetItemColor ( emailtapp_Grid[1],  row,  2, 255,  255,  255)
	guiGridListSetItemColor ( emailtapp_Grid[1],  row,  3, 255,  255,  255)
	guiGridListSetItemColor ( emailtapp_Grid[1],  row,  4, 255,  255,  255)
	for theKey,theEMailTable in ipairs(eMails)do 
		if(dbid==theEMailTable[7])then
			guiSetText(emailtapp_Memo[1],theEMailTable[5])
		end	
	end

end

--pro Email: {Empfänger,Sender,Datum,betreff,Inhalt,new=true,dbid}
addEvent("hierdeineemails",true)
function hierdeineemails_func(emailtable)
	eMails=emailtable
	guiGridListClear(emailtapp_Grid[1])
	local count=0
	for theKey,theEMailTable in ipairs(emailtable)do
		local row = guiGridListAddRow ( emailtapp_Grid[1] )
        guiGridListSetItemText ( emailtapp_Grid[1], row, 1, tostring(theEMailTable[7]) , false, false )--id
		guiGridListSetItemText ( emailtapp_Grid[1], row, 2, theEMailTable[2], false, false )--von
		guiGridListSetItemText ( emailtapp_Grid[1], row, 3, theEMailTable[4], false, false )--betreff
		guiGridListSetItemText ( emailtapp_Grid[1], row, 4, tostring(theEMailTable[3]), false, false )--am
		if(theEMailTable[6])then
			guiGridListSetItemColor ( emailtapp_Grid[1],  row,  1, 0,  255,  0)
			guiGridListSetItemColor ( emailtapp_Grid[1],  row,  2, 0,  255,  0)
			guiGridListSetItemColor ( emailtapp_Grid[1],  row,  3, 0,  255,  0)
			guiGridListSetItemColor ( emailtapp_Grid[1],  row,  4, 0,  255,  0)
			count=count+1
		end
	end	
	guiSetText(emailtapp_Label[1],string.format("Sie haben %s ungelesene Nachichten!", count))
end
addEventHandler("hierdeineemails",getRootElement(),hierdeineemails_func)

function showEMail()
	triggerServerEvent("getRequestAndFriendList",getLocalPlayer())
	guiComboBoxClear ( emailtapp_Combo[1] )
	for theKey,theName in ipairs(Fiendlist)do
		guiComboBoxAddItem(emailtapp_Combo[1] ,theName)
	end
	guiSetVisible(emailtapp_Window[1],true)
end

function emailaktualieren()
	triggerServerEvent("SendeMirMeineEmailsZu",getLocalPlayer())
end

function setFriendInTextBox()
	local item = guiComboBoxGetSelected(emailtapp_Combo[1])
	if not(item==-1) then
		local text = guiComboBoxGetItemText(emailtapp_Combo[1], item)
		guiSetText(emailtapp_Edit[1],text)
	end
end


function closeEMailTapp()
	guiSetVisible(emailtapp_Window[1],false)	
end



--- --- --- --- ---









