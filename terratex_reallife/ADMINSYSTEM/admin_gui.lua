
        AdminGUI_Window = {}
        AdminGUI_TabPanel = {}
        AdminGUI_Tab = {}
        AdminGUI_Button = {}
        AdminGUI_Label = {}
        AdminGUI_Edit = {}
        AdminGUI_Radio = {}
        AdminGUI_Grid = {}
		AdminGUI_Grid_Clo=false
		
addEventHandler("onClientResourceStart",resourceRoot,
    function()


        AdminGUI_Window[1] = guiCreateWindow(0.2719,0.1433,0.4675,0.6978,"Admingui",true)	
			table.insert(allGuis,AdminGUI_Window[1])
        AdminGUI_Button[1] = guiCreateButton(0.7553,0.0525,0.1979,0.0557,"Beenden!",true,AdminGUI_Window[1])
        AdminGUI_Label[1] = guiCreateLabel(0.0214,0.043,0.7126,0.0876,"Dieses Admin Gui verarbeitet die Eingaben zu Commands und sendet diese ab! Bei Fehleingaben oder nicht vorhandenen Rechten kommt es zum Teil nicht zu einer Fehlermeldung!",true,AdminGUI_Window[1])
			guiLabelSetColor(AdminGUI_Label[1],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[1],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[1],"left",true)
			guiSetFont(AdminGUI_Label[1],"clear-normal")
        AdminGUI_Grid[1] = guiCreateGridList(0.0174,0.1369,0.2914,0.836,true,AdminGUI_Window[1])
			guiGridListSetSelectionMode(AdminGUI_Grid[1],2)
			AdminGUI_Grid_Clo=guiGridListAddColumn(AdminGUI_Grid[1],"SpielerName",0.8)
        AdminGUI_TabPanel[1] = guiCreateTabPanel(0.3209,0.1417,0.6471,0.8344,true,AdminGUI_Window[1])
        AdminGUI_Tab[1] = guiCreateTab("Allgemein",AdminGUI_TabPanel[1])
        AdminGUI_Button[2] = guiCreateButton(0.0227,0.036,0.2583,0.068,"Goto!",true,AdminGUI_Tab[1])
        AdminGUI_Button[4] = guiCreateButton(0.3017,0.036,0.2583,0.068,"Get Here!",true,AdminGUI_Tab[1])
        AdminGUI_Button[5] = guiCreateButton(0.0227,0.124,0.2583,0.068,"Spectate!",true,AdminGUI_Tab[1])
        AdminGUI_Button[6] = guiCreateButton(0.0227,0.212,0.2583,0.068,"Slap!",true,AdminGUI_Tab[1])
        AdminGUI_Label[2] = guiCreateLabel(0.0165,0.292,0.9607,0.044,"Respawns:",true,AdminGUI_Tab[1])
			guiLabelSetColor(AdminGUI_Label[2],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[2],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[2],"left",false)
        AdminGUI_Button[7] = guiCreateButton(0.031,0.336,0.2583,0.068,"Bus",true,AdminGUI_Tab[1])
        AdminGUI_Button[8] = guiCreateButton(0.3099,0.336,0.2583,0.068,"Mechaniker",true,AdminGUI_Tab[1])
        AdminGUI_Button[9] = guiCreateButton(0.5888,0.336,0.2583,0.068,"Müll",true,AdminGUI_Tab[1])
        AdminGUI_Button[10] = guiCreateButton(0.031,0.424,0.2583,0.068,"Pizza",true,AdminGUI_Tab[1])
        AdminGUI_Button[11] = guiCreateButton(0.3099,0.424,0.2583,0.068,"Noob",true,AdminGUI_Tab[1])
        AdminGUI_Button[12] = guiCreateButton(0.5888,0.424,0.2583,0.068,"LSPD",true,AdminGUI_Tab[1])
        AdminGUI_Button[13] = guiCreateButton(0.5888,0.512,0.2583,0.068,"SEK",true,AdminGUI_Tab[1])
        AdminGUI_Button[14] = guiCreateButton(0.3099,0.512,0.2583,0.068,"News",true,AdminGUI_Tab[1])
        AdminGUI_Button[15] = guiCreateButton(0.031,0.512,0.2583,0.068,"Mafia",true,AdminGUI_Tab[1])
        AdminGUI_Label[3] = guiCreateLabel(0.0124,0.612,0.2335,0.044,"Textfunktionen",true,AdminGUI_Tab[1])
			guiLabelSetColor(AdminGUI_Label[3],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[3],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[3],"left",false)
        AdminGUI_Button[16] = guiCreateButton(0.031,0.666,0.2583,0.068,"Cleartext",true,AdminGUI_Tab[1])
        AdminGUI_Edit[1] = guiCreateEdit(0.0372,0.756,0.9236,0.058,"",true,AdminGUI_Tab[1])
        AdminGUI_Button[17] = guiCreateButton(0.0372,0.844,0.2583,0.068,"A-Chat",true,AdminGUI_Tab[1])
        AdminGUI_Button[18] = guiCreateButton(0.3161,0.844,0.2583,0.068,"O-Chat",true,AdminGUI_Tab[1])
        AdminGUI_Button[19] = guiCreateButton(0.5888,0.844,0.2583,0.068,"W-Chat",true,AdminGUI_Tab[1])
        AdminGUI_Tab[2] = guiCreateTab("Ban/Kicksys",AdminGUI_TabPanel[1])
        AdminGUI_Label[4] = guiCreateLabel(0.0186,0.02,0.2831,0.04,"Verwarnung:",true,AdminGUI_Tab[2])
			guiLabelSetColor(AdminGUI_Label[4],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[4],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[4],"left",false)
        AdminGUI_Label[5] = guiCreateLabel(0.0702,0.07,0.1921,0.032,"Grund:",true,AdminGUI_Tab[2])
			guiLabelSetColor(AdminGUI_Label[5],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[5],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[5],"left",false)
        AdminGUI_Edit[2] = guiCreateEdit(0.1694,0.06,0.781,0.05,"",true,AdminGUI_Tab[2])
        AdminGUI_Button[20] = guiCreateButton(0.0289,0.118,0.3368,0.064,"Verwarnung Aussprechen!",true,AdminGUI_Tab[2])
        AdminGUI_Label[6] = guiCreateLabel(0.0165,0.208,0.2107,0.036,"Kick:",true,AdminGUI_Tab[2])
			guiLabelSetColor(AdminGUI_Label[6],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[6],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[6],"left",false)
        AdminGUI_Label[7] = guiCreateLabel(0.0702,0.256,0.0806,0.03,"Grund:",true,AdminGUI_Tab[2])
			guiLabelSetColor(AdminGUI_Label[7],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[7],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[7],"left",false)
        AdminGUI_Edit[3] = guiCreateEdit(0.1715,0.244,0.781,0.05,"",true,AdminGUI_Tab[2])
        AdminGUI_Button[21] = guiCreateButton(0.0289,0.314,0.3368,0.064,"Spieler Kicken!",true,AdminGUI_Tab[2])
        AdminGUI_Label[8] = guiCreateLabel(0.0186,0.406,0.1426,0.028,"TimeBan:",true,AdminGUI_Tab[2])
			guiLabelSetColor(AdminGUI_Label[8],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[8],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[8],"left",false)
        AdminGUI_Label[9] = guiCreateLabel(0.062,0.45,0.4298,0.034,"ACHTUNG! Bei Minuten Maximal 60!",true,AdminGUI_Tab[2])
			guiLabelSetColor(AdminGUI_Label[9],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[9],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[9],"left",false)
        AdminGUI_Label[10] = guiCreateLabel(0.2293,0.734,0.0103,0.01,"",true,AdminGUI_Tab[2])
			guiLabelSetColor(AdminGUI_Label[10],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[10],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[10],"left",false)
        AdminGUI_Label[11] = guiCreateLabel(0.0579,0.488,0.4132,0.096,"Zeitangabe in:",true,AdminGUI_Tab[2])
			guiLabelSetColor(AdminGUI_Label[11],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[11],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[11],"left",false)
        AdminGUI_Radio[1] = guiCreateRadioButton(0.0599,0.522,0.3058,0.03,"Minuten",true,AdminGUI_Tab[2])
			guiRadioButtonSetSelected(AdminGUI_Radio[1],true)
        AdminGUI_Radio[2] = guiCreateRadioButton(0.062,0.554,0.3058,0.03,"Stunden",true,AdminGUI_Tab[2])
        AdminGUI_Label[12] = guiCreateLabel(0.0702,0.616,0.0806,0.03,"Grund:",true,AdminGUI_Tab[2])
			guiLabelSetColor(AdminGUI_Label[12],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[12],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[12],"left",false)
        AdminGUI_Edit[4] = guiCreateEdit(0.1715,0.604,0.781,0.05,"",true,AdminGUI_Tab[2])
			AdminGUI_Label[15] = guiCreateLabel(0.3616,0.528,0.2004,0.036,"Zeit:",true,AdminGUI_Tab[2])
			guiLabelSetColor(AdminGUI_Label[15],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[15],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[15],"left",false)
			AdminGUI_Edit[11] = guiCreateEdit(0.4504,0.526,0.3512,0.048,"",true,AdminGUI_Tab[2])
        AdminGUI_Button[23] = guiCreateButton(0.031,0.688,0.3368,0.064,"Spieler Timebannen!",true,AdminGUI_Tab[2])
        AdminGUI_Label[13] = guiCreateLabel(0.0124,0.776,0.1591,0.034,"Ban:",true,AdminGUI_Tab[2])
			guiLabelSetColor(AdminGUI_Label[13],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[13],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[13],"left",false)
        AdminGUI_Label[14] = guiCreateLabel(0.0702,0.85,0.0806,0.03,"Grund:",true,AdminGUI_Tab[2])
			guiLabelSetColor(AdminGUI_Label[14],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[14],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[14],"left",false)
        AdminGUI_Edit[5] = guiCreateEdit(0.1715,0.84,0.781,0.05,"",true,AdminGUI_Tab[2])
        AdminGUI_Button[24] = guiCreateButton(0.031,0.91,0.3368,0.064,"Spieler bannen!",true,AdminGUI_Tab[2])
        AdminGUI_Tab[3] = guiCreateTab("Lvl 2 Admin",AdminGUI_TabPanel[1])
        AdminGUI_Label[15] = guiCreateLabel(0.0207,0.022,0.3657,0.04,"MakeLeader:",true,AdminGUI_Tab[3])
			guiLabelSetColor(AdminGUI_Label[15],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[15],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[15],"left",false)
        AdminGUI_Label[16] = guiCreateLabel(0.3202,0.062,0.3988,0.264,"Fraktionen:\n0 - Zivi\n1 - LSPD\n2 - Grove\n3 - Newsreporter",true,AdminGUI_Tab[3])
			guiLabelSetColor(AdminGUI_Label[16],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[16],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[16],"left",false)
        AdminGUI_Edit[6] = guiCreateEdit(0.1591,0.078,0.1033,0.062,"",true,AdminGUI_Tab[3])
        AdminGUI_Label[17] = guiCreateLabel(0.0413,0.094,0.0971,0.028,"FrakID:",true,AdminGUI_Tab[3])
			guiLabelSetColor(AdminGUI_Label[17],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[17],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[17],"left",false)
        AdminGUI_Button[25] = guiCreateButton(0.0165,0.162,0.2376,0.072,"MAKE LEADER!",true,AdminGUI_Tab[3])
        AdminGUI_Tab[4] = guiCreateTab("Lvl 3 Admin",AdminGUI_TabPanel[1])
        AdminGUI_Button[26] = guiCreateButton(0.031,0.03,0.312,0.07,"GMX Starten!",true,AdminGUI_Tab[4])
        AdminGUI_Label[18] = guiCreateLabel(0.0475,0.13,0.1798,0.05,"InteriorID:",true,AdminGUI_Tab[4])
			guiLabelSetColor(AdminGUI_Label[18],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[18],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[18],"left",false)
        AdminGUI_Edit[7] = guiCreateEdit(0.1756,0.124,0.1343,0.052,"",true,AdminGUI_Tab[4])
        AdminGUI_Button[27] = guiCreateButton(0.3326,0.116,0.2996,0.068,"Hinein Teleportieren!",true,AdminGUI_Tab[4])
        AdminGUI_Label[19] = guiCreateLabel(0.0475,0.218,0.1281,0.044,"VerhicleID:",true,AdminGUI_Tab[4])
			guiLabelSetColor(AdminGUI_Label[19],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[19],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[19],"left",false)
        AdminGUI_Edit[8] = guiCreateEdit(0.1798,0.204,0.1322,0.058,"",true,AdminGUI_Tab[4])
        AdminGUI_Button[28] = guiCreateButton(0.3326,0.204,0.2996,0.068,"Fahrzeug erstellen!",true,AdminGUI_Tab[4])
        AdminGUI_Label[20] = guiCreateLabel(0.0475,0.304,0.1426,0.042,"WaffenID:",true,AdminGUI_Tab[4])
			guiLabelSetColor(AdminGUI_Label[20],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[20],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[20],"left",false)
        AdminGUI_Edit[9] = guiCreateEdit(0.1777,0.288,0.1322,0.058,"",true,AdminGUI_Tab[4])
        AdminGUI_Button[29] = guiCreateButton(0.3326,0.288,0.2996,0.068,"Waffe Geben!",true,AdminGUI_Tab[4])
        AdminGUI_Tab[5] = guiCreateTab("Lvl 4 Admin",AdminGUI_TabPanel[1])
        AdminGUI_Label[21] = guiCreateLabel(0.0269,0.018,0.5041,0.116,"Derzeit gibt es keine LVl 4 Befehle die Hier zuerwaehnen waeren!",true,AdminGUI_Tab[5])
			guiLabelSetColor(AdminGUI_Label[21],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[21],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[21],"left",true)
        AdminGUI_Tab[6] = guiCreateTab("sonstiges",AdminGUI_TabPanel[1])
        AdminGUI_Label[22] = guiCreateLabel(0.0413,0.04,0.1632,0.046,"InteriorID:",true,AdminGUI_Tab[6])
			guiLabelSetColor(AdminGUI_Label[22],255,255,255)
			guiLabelSetVerticalAlign(AdminGUI_Label[22],"top")
			guiLabelSetHorizontalAlign(AdminGUI_Label[22],"left",false)
        AdminGUI_Edit[10] = guiCreateEdit(0.1798,0.038,0.1467,0.05,"",true,AdminGUI_Tab[6])
        AdminGUI_Button[30] = guiCreateButton(0.3595,0.034,0.2211,0.052,"Interior Setzen!",true,AdminGUI_Tab[6])
		
		guiSetVisible(AdminGUI_Window[1],false)
		
		
		addEventHandler("onClientGUIClick",AdminGUI_Button[1],closeAdminGUI,false)		
		addEventHandler("onClientGUIClick",AdminGUI_Button[2],gotoAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[4],gethereAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[5],specAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[6],slapAdminGUI,false)
		
    	addEventHandler("onClientGUIClick",AdminGUI_Button[7] ,busrespawnAdminGUI ,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[8] ,mechanikerrespawnAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[9] ,trashrespawnAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[10],pizzarespawnAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[11],noobrespawnAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[12],lspdrespawnAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[13],sekrespawnAdminGUI,false)		
    	addEventHandler("onClientGUIClick",AdminGUI_Button[14],newsrespawnAdminGUI,false)		
    	addEventHandler("onClientGUIClick",AdminGUI_Button[15],llsrespawnAdminGUI,false)		
		
    	addEventHandler("onClientGUIClick",AdminGUI_Button[16],cleartextAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[17],achatAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[18],ochatAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[19],wchatAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[20],warnAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[21],rkickAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[23],tbanAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[24],rbanAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[25],makeleaderAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[26],gmxAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[27],devinAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[28],vehAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[29],agwAdminGUI,false)
    	addEventHandler("onClientGUIClick",AdminGUI_Button[30],intAdminGUI,false)
    end
)


--"executeServerCommandHandler",getLocalPlayer(),"command","arguments..."
--  AdminGUI_Edit[1] 
function makeleaderAdminGUI()
	local row,colo=guiGridListGetSelectedItem ( AdminGUI_Grid[1]  )
	if(row~=-1)then
		local player=guiGridListGetItemText ( AdminGUI_Grid[1] , row, colo)
		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"setfraktion",player.." "..guiGetText(AdminGUI_Edit[6]).." 5")
	else
		showError(getLocalPlayer(),"Sie haben keinen Spieler gewählt!")
	end	
end


function intAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"int",guiGetText(AdminGUI_Edit[10] ))

end

function agwAdminGUI()
	local row,colo=guiGridListGetSelectedItem ( AdminGUI_Grid[1]  )
	if(row~=-1)then
		local player=guiGridListGetItemText ( AdminGUI_Grid[1] , row, colo)		
		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"agw",player.." "..guiGetText(AdminGUI_Edit[9] ))
	else
		showError(getLocalPlayer(),"Sie haben keinen Spieler gewählt!")
	end	
end


function vehAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"veh",guiGetText(AdminGUI_Edit[8] ))

end


function devinAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"devin",guiGetText(AdminGUI_Edit[7] ))

end

function gmxAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"gmx")

end

function rbanAdminGUI()
	local row,colo=guiGridListGetSelectedItem ( AdminGUI_Grid[1]  )
	if(row~=-1)then
		local player=guiGridListGetItemText ( AdminGUI_Grid[1] , row, colo)		
		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"rban",player.." "..guiGetText(AdminGUI_Edit[5] ))
	else
		showError(getLocalPlayer(),"Sie haben keinen Spieler gewählt!")
	end	
end

function tbanAdminGUI()
	local row,colo=guiGridListGetSelectedItem ( AdminGUI_Grid[1]  )
	if(row~=-1)then
		local player=guiGridListGetItemText ( AdminGUI_Grid[1] , row, colo)	
		if( guiRadioButtonGetSelected( AdminGUI_Radio[1] ))then
			if(guiGetText(AdminGUI_Edit[11])=="")then
				zeit=0
			else
				zeit=-1*tonumber(guiGetText(AdminGUI_Edit[11]))
			end
			
		else
			zeit=guiGetText(AdminGUI_Edit[11])
		end
		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"tban",player.." "..zeit.." "..guiGetText(AdminGUI_Edit[4] ))
	else
		showError(getLocalPlayer(),"Sie haben keinen Spieler gewählt!")
	end	
end

function rkickAdminGUI()
	local row,colo=guiGridListGetSelectedItem ( AdminGUI_Grid[1]  )
	if(row~=-1)then
		local player=guiGridListGetItemText ( AdminGUI_Grid[1] , row, colo)		
		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"rkick",player.." "..guiGetText(AdminGUI_Edit[3] ))
	else
		showError(getLocalPlayer(),"Sie haben keinen Spieler gewählt!")
	end	
end

function warnAdminGUI()
	local row,colo=guiGridListGetSelectedItem ( AdminGUI_Grid[1]  )
	if(row~=-1)then
		local player=guiGridListGetItemText ( AdminGUI_Grid[1] , row, colo)		
		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"warn",player.." "..guiGetText(AdminGUI_Edit[2] ))
	else
		showError(getLocalPlayer(),"Sie haben keinen Spieler gewählt!")
	end	
end


function wchatAdminGUI()
	local row,colo=guiGridListGetSelectedItem ( AdminGUI_Grid[1]  )
	if(row~=-1)then
		local player=guiGridListGetItemText ( AdminGUI_Grid[1] , row, colo)		
		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"w",player.." "..guiGetText(AdminGUI_Edit[1] ))
	else
		showError(getLocalPlayer(),"Sie haben keinen Spieler gewählt!")
	end	
end

function achatAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"a",guiGetText(AdminGUI_Edit[1] ))

end
function ochatAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"o",guiGetText(AdminGUI_Edit[1] ))

end

function cleartextAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"cleartext","")

end



function noobrespawnAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"respawn","noob")

end

function trashrespawnAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"respawn","muell")

end

function mechanikerrespawnAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"respawn","mechaniker")

end

function busrespawnAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"respawn","bus")

end


function newsrespawnAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"respawn","news")

end

function pizzarespawnAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"respawn","pizza")

end

function lspdrespawnAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"respawn","lspd")

end

function sekrespawnAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"respawn","sek")

end

function llsrespawnAdminGUI()

		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"respawn","lls")

end


function slapAdminGUI()
	local row,colo=guiGridListGetSelectedItem ( AdminGUI_Grid[1]  )
	if(row~=-1)then
		local player=guiGridListGetItemText ( AdminGUI_Grid[1] , row, colo)
		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"slap",player)
	else
		showError(getLocalPlayer(),"Sie haben keinen Spieler gewählt!")
	end	
end

function specAdminGUI()
	local row,colo=guiGridListGetSelectedItem ( AdminGUI_Grid[1]  )
	if(row~=-1)then
		local player=guiGridListGetItemText ( AdminGUI_Grid[1] , row, colo)
		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"spec",player)
	else
		showError(getLocalPlayer(),"Sie haben keinen Spieler gewählt!")
	end	
end



function gethereAdminGUI()
	local row,colo=guiGridListGetSelectedItem ( AdminGUI_Grid[1]  )
	if(row~=-1)then
		local player=guiGridListGetItemText ( AdminGUI_Grid[1] , row, colo)
		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"gethere",player)
	else
		showError(getLocalPlayer(),"Sie haben keinen Spieler gewählt!")
	end	
end




function gotoAdminGUI()
	local row,colo=guiGridListGetSelectedItem ( AdminGUI_Grid[1]  )
	if(row~=-1)then
		local player=guiGridListGetItemText ( AdminGUI_Grid[1] , row, colo)
		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"goto",player)
	else
		showError(getLocalPlayer(),"Sie haben keinen Spieler gewählt!")
	end	
end


function closeAdminGUI()
	guiSetVisible(AdminGUI_Window[1],false)
end




addEvent("showAdminGui_Event",true)
function showAdminGui()
	if(isAdminLevel(getLocalPlayer(),0))then
		guiSetVisible(AdminGUI_Window[1],true)
		showCursor(true)
		
		guiGridListClear ( AdminGUI_Grid[1] )
		local players=getElementsByType("player")
		local pname=""
		local row=false
		for theKey,thePlayer in ipairs(players) do
			pname=getPlayerName(thePlayer)
			guiGridListSetItemText ( AdminGUI_Grid[1], guiGridListAddRow ( AdminGUI_Grid[1] ), AdminGUI_Grid_Clo, pname, false, false )
			
		end		
	end
end
addCommandHandler("admincmd",showAdminGui)
addEventHandler("showAdminGui_Event",getRootElement(),showAdminGui)










