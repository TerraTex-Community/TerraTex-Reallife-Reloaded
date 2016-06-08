
RegisterGUI = {
    label = {},
    window = {},
    staticimage = {},
    edit = {}
}

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
    function()
	    local screenW, screenH = guiGetScreenSize()
	    Registergui = guiCreateWindow((screenW - 722) / 2, (screenH - 378) / 2, 722, 378, "Registrieren auf "..config["communityname"], false)
	    RegisterGUI.window[1]=Registergui
	    table.insert(allGuis,Registergui)
	    guiWindowSetSizable(RegisterGUI.window[1], false)

	    RegisterGUI.staticimage[1] = guiCreateStaticImage(10, 23, 700, 345, "FILES/IMAGES/register.png", false, RegisterGUI.window[1])

	    RegisterGUI.staticimage[2] = guiCreateStaticImage(144, 297, 219, 38, "FILES/IMAGES/registerbutton.png", false, RegisterGUI.staticimage[1])
	    Register_Gui_PW = guiCreateEdit(189, 94, 251, 25, "", false, RegisterGUI.staticimage[1])
	    Register_Gui_PW_B = guiCreateEdit(189, 125, 251, 25, "", false, RegisterGUI.staticimage[1])

	    RegisterGUI.label[2] = guiCreateLabel(20, 93, 169, 26, "Passwort", false, RegisterGUI.staticimage[1])
	    local font_0 = guiCreateFont("FILES/FONTS/gothic.ttf",12)
	    local font_1 = guiCreateFont("FILES/FONTS/gothic.ttf",9)
	    guiSetFont(RegisterGUI.label[2], font_0)
	    guiLabelSetVerticalAlign(RegisterGUI.label[2], "center")
	    RegisterGUI.label[3] = guiCreateLabel(20, 124, 169, 26, "Passwort bestätigen", false, RegisterGUI.staticimage[1])
	    guiSetFont(RegisterGUI.label[3], font_0)
	    guiLabelSetVerticalAlign(RegisterGUI.label[3], "center")
	    RegisterGUI.label[4] = guiCreateLabel(20, 156, 169, 26, "E-Mail", false, RegisterGUI.staticimage[1])
	    guiSetFont(RegisterGUI.label[4], font_0)
	    guiLabelSetVerticalAlign(RegisterGUI.label[4], "center")
	    Register_Gui_EMAIL = guiCreateEdit(189, 156, 251, 25, "", false, RegisterGUI.staticimage[1])
	    RegisterGUI.label[5] = guiCreateLabel(20, 181, 420, 50, "* Es wird empfohlen, eine korrekte, funktionierende E-Mail anzugeben, da diese als Adresse für die \"Passwort vergessen\"-Funktion genutzt wird.", false, RegisterGUI.staticimage[1])
	    guiSetFont(RegisterGUI.label[5], font_1)
	    guiLabelSetHorizontalAlign(RegisterGUI.label[5], "left", true)
	    guiLabelSetVerticalAlign(RegisterGUI.label[5], "center")
	    RegisterGUI.label[6] = guiCreateLabel(20, 231, 169, 26, "Geburstag", false, RegisterGUI.staticimage[1])
	    guiSetFont(RegisterGUI.label[6], font_0)
	    guiLabelSetVerticalAlign(RegisterGUI.label[6], "center")
	    RegisterGUI.label[7] = guiCreateLabel(20, 261, 169, 26, "geworben von", false, RegisterGUI.staticimage[1])
	    guiSetFont(RegisterGUI.label[7], font_0)
	    guiLabelSetVerticalAlign(RegisterGUI.label[7], "center")
	    Register_Gui_Geb_T = guiCreateEdit(189, 231, 64, 26, "", false, RegisterGUI.staticimage[1])
	    Register_Gui_Geb_M = guiCreateEdit(263, 231, 64, 26, "", false, RegisterGUI.staticimage[1])
	    Register_Gui_Geb_Y = guiCreateEdit(337, 231, 103, 26, "", false, RegisterGUI.staticimage[1])

	    Register_Gui_Werber = guiCreateEdit(189, 261, 251, 25, "", false, RegisterGUI.staticimage[1])

		guiEditSetMasked(Register_Gui_PW_B,true)
		guiEditSetMasked(Register_Gui_PW,true)
		guiEditSetMaxLength(Register_Gui_Geb_T,2)
		guiEditSetMaxLength(Register_Gui_Geb_M,2)
		guiEditSetMaxLength(Register_Gui_Geb_Y,4)
		guiSetVisible (Registergui , false)

		addEventHandler("onClientGUIClick",RegisterGUI.staticimage[2],startRegister,false)
    end
)

local hasClickedRegisterGui=false
function startRegister(button)
	if(not(hasClickedRegisterGui))then
		if (button=="left") then
			local pw=guiGetText(Register_Gui_PW)
			local pwb=guiGetText(Register_Gui_PW_B)
			local email =guiGetText(Register_Gui_EMAIL )
			local gebt =guiGetText(Register_Gui_Geb_T )
			local gebm =guiGetText(Register_Gui_Geb_M)
			local geby =guiGetText(Register_Gui_Geb_Y )
			local werber =guiGetText( Register_Gui_Werber)
			
			if(not(utf_check(pw)) or not(utf_check(email)) or not(utf_check(werber)))then
				showError(getLocalPlayer(),"Sponderzeichen sind nur begrenzt möglich. Du verwendest Sonderzeichen, die nicht möglich sind!")
			else		
				if (pw=="")then pw="a" end
				if(pw=="")then pwb="z" end

				if(pw==pwb)then
					if not(email=="")then
						if(not(gebt==""))then
							if(not(gebt=="")and(tonumber(gebt)<32)and(tonumber(gebt)>0))then
								if(not(gebm=="")and(tonumber(gebm)<13)and(tonumber(gebm)>0))then
									if(not(geby=="")and(tonumber(geby)<2010)and(tonumber(geby)>1900))then
										if(weber=="")then werber="none" end
										triggerServerEvent("registerPlayer",getLocalPlayer(),getPlayerName(getLocalPlayer()),pw,email,gebt,gebm,geby,werber)
									else
										showError(getLocalPlayer(),"Du hast kein korrektes Geburstdatum eingegeben(3)!")
									end		
								else
									showError(getLocalPlayer(),"Du hast kein korrektes Geburstdatum eingegeben(2)!")
								end	
							else
								showError(getLocalPlayer(),"Du hast kein korrektes Geburstdatum eingegeben (1)!")
							end
						else
							showError(getLocalPlayer(),"Du hast kein korrektes Geburstdatum eingegeben (1)!")
						end
					else
						showError(getLocalPlayer(),"Du hast keine Email angegeben!")
					end
				else
					showError(getLocalPlayer(),"Die Passwoerter stimmen nicht ueberein!")
				end
			end
		end
		hasClickedRegisterGui=true
		setTimer(reloadRegisterGUI,1000,1)
	end

end

function reloadRegisterGUI()
	hasClickedRegisterGui=false
end

function disableRegisterGui()
	guiSetVisible (Registergui , false)
	showCursor ( false)
	toggleAllControls ( true, true, true )
end
addEvent("hideRegisterGui",true)
addEventHandler("hideRegisterGui",getRootElement(),disableRegisterGui)









