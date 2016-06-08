function build_settingsmenu()
	
	local gui = {}
	gui._placeHolders = {}
	
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 599, 615
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	gui["_root"] = guiCreateWindow(left, top, windowWidth, windowHeight, "Settingsmenü", false)
	guiWindowSetSizable(gui["_root"], false)
	gui["settingsCloseButton"] = guiCreateButton(434, 25, 161, 61, "Save & Close", false, gui["_root"])
	if on_settingsCloseButton_clicked then
		addEventHandler("onClientGUIClick", gui["settingsCloseButton"], on_settingsCloseButton_clicked, false)
	end
	
	gui["label"] = guiCreateLabel(10, 25, 420, 61, "In diesem GUI kannst du verschiedene Einstellungen auf TT vornehmen. \nACHTUNG: Diese werden nur auf diesem PC gespeichert. Ebenfals gibt es pro PC nur einen Settingsspeicher.", false, gui["_root"])
	guiLabelSetHorizontalAlign(gui["label"], "left", true)
	guiLabelSetVerticalAlign(gui["label"], "center")
	
	gui["settingsTabPanel"] = guiCreateTabPanel(4, 94, 591, 521, false, gui["_root"])
	
	gui["tab"] = guiCreateTab("Allgemein", gui["settingsTabPanel"])
	
	gui["scrollArea"] = guiCreateScrollPane(10, 10, 561, 481, false, gui["tab"])
	
	gui["label_3"] = guiCreateLabel(12, 12, 108, 31, "Infoboxsound", false, gui["scrollArea"])
	guiLabelSetHorizontalAlign(gui["label_3"], "left", false)
	guiLabelSetVerticalAlign(gui["label_3"], "center")
	
	gui["infoCheck"] = guiCreateCheckBox(126, 17, 107, 21, "An / Aus", false, false, gui["scrollArea"])
	
	gui["label_4"] = guiCreateLabel(12, 52, 129, 31, "Standartradiosender", false, gui["scrollArea"])
	guiLabelSetHorizontalAlign(gui["label_4"], "left", false)
	guiLabelSetVerticalAlign(gui["label_4"], "center")
	
	gui["radioCheck"] = guiCreateCheckBox(147, 57, 131, 21, "Einstellen An / Aus", false, false, gui["scrollArea"])
	
	gui["radioBox"] = guiCreateComboBox(284, 56, 259, 180,"Radio off", false, gui["scrollArea"])
	
	guiComboBoxAddItem(gui["radioBox"], "Radio off")
	guiComboBoxAddItem(gui["radioBox"], "Playback FM")
	guiComboBoxAddItem(gui["radioBox"], "K-Rose")
	guiComboBoxAddItem(gui["radioBox"], "K-DST")
	guiComboBoxAddItem(gui["radioBox"], "Bounce FM")
	guiComboBoxAddItem(gui["radioBox"], "SF-UR")
	guiComboBoxAddItem(gui["radioBox"], "Radio Los Santos")
	guiComboBoxAddItem(gui["radioBox"], "Radio X")
	guiComboBoxAddItem(gui["radioBox"], "CSR 103.9")
	guiComboBoxAddItem(gui["radioBox"], "K-Jah West")
	guiComboBoxAddItem(gui["radioBox"], "Master Sounds 98.3")
	guiComboBoxAddItem(gui["radioBox"], "WCTR")
	guiComboBoxAddItem(gui["radioBox"], "User Track Player")
	
	gui["label_5"] = guiCreateLabel(12, 92, 229, 31, "Radiostreamer (F2) automatisch starten", false, gui["scrollArea"])
	guiLabelSetHorizontalAlign(gui["label_5"], "left", false)
	guiLabelSetVerticalAlign(gui["label_5"], "center")
	
	gui["streamerCheck"] = guiCreateCheckBox(247, 97, 216, 21, "An / Aus", false, false, gui["scrollArea"])

    gui["label_6"] = guiCreateLabel(12, 132, 209, 31, "Essensbalken im Wasser ausblenden", false, gui["scrollArea"])
    guiLabelSetHorizontalAlign(gui["label_6"], "left", false)
    guiLabelSetVerticalAlign(gui["label_6"], "center")

    gui["essenCheck"] = guiCreateCheckBox(227, 137, 166, 21, "An / Aus", false, false, gui["scrollArea"])

    gui["label_12"] = guiCreateLabel(12, 182, 209, 31, "Infotext in der Fußzeile anzeigen", false, gui["scrollArea"])
    guiLabelSetHorizontalAlign(gui["label_12"], "left", false)
    guiLabelSetVerticalAlign(gui["label_12"], "center")

    gui["infotextCheck"] = guiCreateCheckBox(227, 187, 166, 21, "An / Aus", false, false, gui["scrollArea"])

	
	gui["tab_2"] = guiCreateTab("Grafik", gui["settingsTabPanel"])
	
	gui["scrollArea_2"] = guiCreateScrollPane(10, 10, 561, 471, false, gui["tab_2"])
	
	gui["blurAusCheck"] = guiCreateCheckBox(42, 32, 461, 14, "Aus", false, false, gui["scrollArea_2"])
	
	gui["blurNormalCheck"] = guiCreateCheckBox(42, 52, 461, 13, "Normal", false, false, gui["scrollArea_2"])
	
	gui["blurStarkCheck"] = guiCreateCheckBox(42, 71, 461, 14, "Stark", false, false, gui["scrollArea_2"])
	
	gui["blurGTAIVCheck"] = guiCreateCheckBox(42, 91, 461, 13, "GTA IV Grafik wenig", false, false, gui["scrollArea_2"])
	
	gui["blurGTAIVExtremCheck"] = guiCreateCheckBox(42, 110, 461, 13, "GTA IV Grafik extrem", false, false, gui["scrollArea_2"])
	
	gui["label_7"] = guiCreateLabel(22, 12, 511, 16, "Blureffekt (Bewegungsunschärfe):", false, gui["scrollArea_2"])
	guiLabelSetHorizontalAlign(gui["label_7"], "left", false)
	guiLabelSetVerticalAlign(gui["label_7"], "center")
	
	gui["label_8"] = guiCreateLabel(22, 132, 531, 16, "Wassereffekt:", false, gui["scrollArea_2"])
	guiLabelSetHorizontalAlign(gui["label_8"], "left", false)
	guiLabelSetVerticalAlign(gui["label_8"], "center")
	
	gui["normWaterCheck"] = guiCreateCheckBox(42, 152, 461, 13, "normal", false, false, gui["scrollArea_2"])
	
	gui["realWaterCheck"] = guiCreateCheckBox(42, 171, 461, 12, "reallistisch", false, false, gui["scrollArea_2"])
	
	gui["label_9"] = guiCreateLabel(22, 192, 131, 16, "Bloomeffekt:", false, gui["scrollArea_2"])
	guiLabelSetHorizontalAlign(gui["label_9"], "left", false)
	guiLabelSetVerticalAlign(gui["label_9"], "center")
	
	gui["bloomCheck"] = guiCreateCheckBox(122, 192, 158, 18, "An / Aus", false, false, gui["scrollArea_2"])
	
	gui["label_10"] = guiCreateLabel(22, 212, 141, 16, "Sunshine-Effekt:", false, gui["scrollArea_2"])
	guiLabelSetHorizontalAlign(gui["label_10"], "left", false)
	guiLabelSetVerticalAlign(gui["label_10"], "center")
	
	gui["sunshineCheck"] = guiCreateCheckBox(122, 212, 71, 18, "An / Aus", false, false, gui["scrollArea_2"])

    gui["label_11"] = guiCreateLabel(22, 232, 111, 16, "Neue Details:", false, gui["scrollArea_2"])
    guiLabelSetHorizontalAlign(gui["label_11"], "left", false)
    guiLabelSetVerticalAlign(gui["label_11"], "center")

    gui["detailsCheck"] = guiCreateCheckBox(122, 232, 71, 18, "An / Aus", false, false, gui["scrollArea_2"])




    gui["label_12"] = guiCreateLabel(22, 252, 111, 16, "Lack-Glänzen", false, gui["scrollArea_2"])
    guiLabelSetHorizontalAlign(gui["label_12"], "left", false)
    guiLabelSetVerticalAlign(gui["label_12"], "center")

    gui["lackCheck"] = guiCreateCheckBox(122, 252, 71, 18, "An / Aus", false, false, gui["scrollArea_2"])



	
	gui["Info"] = guiCreateTab("Info", gui["settingsTabPanel"])
	
	gui["label_2"] = guiCreateLabel(70, 90, 411, 181, "\nDieses GUI wird erweitert.", false, gui["Info"])
	guiLabelSetHorizontalAlign(gui["label_2"], "left", false)
	guiLabelSetVerticalAlign(gui["label_2"], "center")
	
	return gui
end

local settingsGUI=false
client_settings={}
function loadStandardSettings()
	client_settings["InfoSounds"]=true --true = an false = aus
	client_settings["Standartradio"]=-1 --false=automatisch  0-12 => systemwahl
	client_settings["RadioStreamer"]=false -- true= autoan false=autoaus
	client_settings["Blur"]=1 -- 0=aus 1=normal 2=stark 3=shadder 4=starkerShadder
	client_settings["EssenAusblender"]=true
	client_settings["WaterShader"]=0 -- 0=normal 1=reallistisch
	client_settings["BloomShader"]=false 
	client_settings["SunshineShadder"]=false
	client_settings["newDetails"]=false
	client_settings["LackShadder"]=false
	client_settings["infotext"]=true

end
function onSettingsGUICreate()
	settingsGUI=build_settingsmenu()
	table.insert(allGuis,settingsGUI["_root"])
	guiSetVisible(settingsGUI["_root"],false)
	bindKey ( "F3", "down", settings_show)
	setTimer(loadConfigFile,5000,1)
	loadStandardSettings()
	
	addEventHandler("onClientGUIClick",settingsGUI["blurAusCheck"] ,setSingleSelectBloom,false)
	addEventHandler("onClientGUIClick",settingsGUI["blurNormalCheck"] ,setSingleSelectBloom,false)
	addEventHandler("onClientGUIClick",settingsGUI["blurStarkCheck"],setSingleSelectBloom,false)
	addEventHandler("onClientGUIClick",settingsGUI["blurGTAIVCheck"] ,setSingleSelectBloom,false)
	addEventHandler("onClientGUIClick",settingsGUI["blurGTAIVExtremCheck"],setSingleSelectBloom,false)
		
	addEventHandler("onClientGUIClick",settingsGUI["normWaterCheck"],setSingleSelectWater,false)
	addEventHandler("onClientGUIClick",settingsGUI["realWaterCheck"],setSingleSelectWater,false)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),onSettingsGUICreate)

function setSingleSelectBloom()
	local setBlur={[0]=settingsGUI["blurAusCheck"],settingsGUI["blurNormalCheck"],settingsGUI["blurStarkCheck"],settingsGUI["blurGTAIVCheck"],settingsGUI["blurGTAIVExtremCheck"]}
	for i=0,4,1 do		
		guiCheckBoxSetSelected(setBlur[i],false)
	end
	guiCheckBoxSetSelected(source,true)	
end

function setSingleSelectWater()
	guiCheckBoxSetSelected ( settingsGUI["normWaterCheck"] ,false)
	guiCheckBoxSetSelected ( settingsGUI["realWaterCheck"] ,false)	
	guiCheckBoxSetSelected ( source ,true)
end

function executeSettingsGUI()
	if(client_settings["Blur"]==0)then	
		setBlurLevel (0 )
		triggerEvent( "switchRadialBlur", getRootElement(), false )
	elseif(client_settings["Blur"]==1)then	
		setBlurLevel ( 36)
		triggerEvent( "switchRadialBlur", getRootElement(), false )		
	elseif(client_settings["Blur"]==2)then	
		setBlurLevel ( 72 )
		triggerEvent( "switchRadialBlur", getRootElement(), false )
	elseif(client_settings["Blur"]==3)then	
		triggerEvent( "switchRadialBlur", getRootElement(), true , false)
	else
		triggerEvent( "switchRadialBlur", getRootElement(), true , true)	
	end
	if(client_settings["WaterShader"]==0)then
		setWaterShader(false)
	else
		setWaterShader(true)
	end
	
	setBloomShader(client_settings["BloomShader"])
	switchRoadshine3( client_settings["SunshineShadder"] )
	handleOnClientSwitchDetail(client_settings["newDetails"])

    triggerEvent( "switchCarPaintReflectLite", getRootElement(), client_settings["LackShadder"]  )
    --@todo: lackglänzeneffekt
	
	if(client_settings["RadioStreamer"])then
		setTimer(startAutoPlayingRadioStreamer,5000,1)
	end
end

function on_settingsCloseButton_clicked(button, state, absoluteX, absoluteY)
	if (button ~= "left") or (state ~= "up") then
		return
	end
	--Daten aus GUI auslesen
	client_settings["InfoSounds"]=guiCheckBoxGetSelected ( settingsGUI["infoCheck"]  )
	client_settings["infotext"]=guiCheckBoxGetSelected ( settingsGUI["infotextCheck"]  )
	client_settings["RadioStreamer"]=guiCheckBoxGetSelected ( settingsGUI["streamerCheck"]  )
	client_settings["BloomShader"]=guiCheckBoxGetSelected ( settingsGUI["bloomCheck"]  )
	client_settings["newDetails"]=guiCheckBoxGetSelected ( settingsGUI["detailsCheck"]  )
	client_settings["SunshineShadder"]=guiCheckBoxGetSelected ( settingsGUI["sunshineCheck"]  )
	client_settings["LackShadder"]=guiCheckBoxGetSelected ( settingsGUI["lackCheck"]  )
	client_settings["EssenAusblender"]=guiCheckBoxGetSelected ( settingsGUI["essenCheck"]  )
	if(guiCheckBoxGetSelected ( settingsGUI["normWaterCheck"]  ))then
		client_settings["WaterShader"]=0
	else
		client_settings["WaterShader"]=1
	end
	if not(guiCheckBoxGetSelected ( settingsGUI["radioCheck"]  ))then
		client_settings["Standartradio"]=-1
	else
		client_settings["Standartradio"]=guiComboBoxGetSelected (settingsGUI["radioBox"])
	end	
	local setBlur={[0]=settingsGUI["blurAusCheck"],settingsGUI["blurNormalCheck"],settingsGUI["blurStarkCheck"],settingsGUI["blurGTAIVCheck"],settingsGUI["blurGTAIVExtremCheck"]}
	for i=0,4,1 do		
		if(guiCheckBoxGetSelected(setBlur[i]))then
			client_settings["Blur"]=i
		end
	end
	
	--Settingsspeichern
	local filename="client_config.xml"
	local node=xmlLoadFile(filename)
	for theName,theValue in pairs(client_settings)do
		--outputDebugString(tostring(theName)..": "..tostring(theValue))
		--local childnode=xmlCreateChild ( node, theName )
		local childnode= xmlFindChild ( node, theName, 0 ) 
		if not childnode then
			childnode=xmlCreateChild ( node, theName )
		end
		xmlNodeSetValue ( childnode, tostring(theValue) )
	end		
	xmlSaveFile ( node )
	xmlUnloadFile(node)
	guiSetVisible(settingsGUI["_root"],false)
	showCursor(false)
	executeSettingsGUI()
end

function loadConfigFile()
	local filename="client_config.xml"
	local filehandler
	if not(fileExists ( filename ))then
		filehandler=fileCreate ( filename)
		fileClose ( filehandler)
		local node=xmlCreateFile ( "client_config.xml", "clientconfig" )
		for theName,theValue in pairs(client_settings)do
		--outputDebugString(tostring(theName)..": "..tostring(theValue))
			local childnode=xmlCreateChild ( node, theName )
			xmlNodeSetValue ( childnode, tostring(theValue) )
		end		
		xmlSaveFile ( node )
		--[[
		client_settings["InfoSounds"]=true --true = an false = aus
		client_settings["Standartradio"]=false --false=automatisch  0-12 => systemwahl
		client_settings["RadioStreamer"]=false -- true= autoan false=autoaus
		client_settings["Blur"]=1 -- 0=aus 1=normal 2=stark 3=shadder]]
		xmlUnloadFile(node)
	else
		local node=xmlLoadFile(filename)
		client_settings["InfoSounds"]=StrToBool(xmlNodeGetValue (xmlFindChild ( node, "InfoSounds", 0 ) ))
        if(xmlFindChild ( node, "infotext", 0 ))then
		    client_settings["infotext"]=StrToBool(xmlNodeGetValue (xmlFindChild ( node, "infotext", 0 ) ))
        end
		client_settings["Standartradio"]=tonumber(xmlNodeGetValue (xmlFindChild ( node, "Standartradio", 0 ) ))
		client_settings["RadioStreamer"]=StrToBool(xmlNodeGetValue (xmlFindChild ( node, "RadioStreamer", 0 ) ))
		client_settings["Blur"]=tonumber(xmlNodeGetValue (xmlFindChild ( node, "Blur", 0 ) ))
		client_settings["WaterShader"]=tonumber(xmlNodeGetValue (xmlFindChild ( node, "WaterShader", 0 ) ))
		client_settings["EssenAusblender"]=StrToBool(xmlNodeGetValue (xmlFindChild ( node, "EssenAusblender", 0 ) ))
		client_settings["BloomShader"]=StrToBool(xmlNodeGetValue (xmlFindChild ( node, "BloomShader", 0 ) ))
		client_settings["SunshineShadder"]=StrToBool(xmlNodeGetValue (xmlFindChild ( node, "SunshineShadder", 0 ) ))
		client_settings["LackShadder"]=StrToBool(xmlNodeGetValue (xmlFindChild ( node, "LackShadder", 0 ) ))
		client_settings["newDetails"]=StrToBool(xmlNodeGetValue (xmlFindChild ( node, "newDetails", 0 ) ))
		
		xmlUnloadFile(node)
		
		
		writeSettingsInSettingsGUI()
	
	
		--HIER NOCH IN DAS SETTINGSGUI ÜBERTRAGEN
		--executeSettings_client()
		--outputChatBox(tostring(client_settings["Blur"]))
	end
end

function writeSettingsInSettingsGUI()
	guiCheckBoxSetSelected ( settingsGUI["infoCheck"] , client_settings["InfoSounds"])
	guiCheckBoxSetSelected ( settingsGUI["infotextCheck"] , client_settings["infotext"])
	guiCheckBoxSetSelected ( settingsGUI["streamerCheck"], client_settings["RadioStreamer"])
	guiCheckBoxSetSelected ( settingsGUI["bloomCheck"],client_settings["BloomShader"])
	guiCheckBoxSetSelected ( settingsGUI["detailsCheck"],client_settings["newDetails"])
	guiCheckBoxSetSelected ( settingsGUI["sunshineCheck"],client_settings["SunshineShadder"])
	guiCheckBoxSetSelected ( settingsGUI["lackCheck"],client_settings["LackShadder"])
	guiCheckBoxSetSelected ( settingsGUI["essenCheck"],client_settings["EssenAusblender"])
	if(client_settings["WaterShader"]==0)then
		guiCheckBoxSetSelected ( settingsGUI["normWaterCheck"] ,true)
		guiCheckBoxSetSelected ( settingsGUI["realWaterCheck"] ,false)
	else
		guiCheckBoxSetSelected ( settingsGUI["normWaterCheck"] ,false)
		guiCheckBoxSetSelected ( settingsGUI["realWaterCheck"] ,true)	
	end
	if(client_settings["Standartradio"]==-1)then
		guiCheckBoxSetSelected(settingsGUI["radioCheck"],false)
		guiComboBoxSetSelected ( settingsGUI["radioBox"], 0)
	else
		guiCheckBoxSetSelected(settingsGUI["radioCheck"],true)
		guiComboBoxSetSelected ( settingsGUI["radioBox"], client_settings["Standartradio"] )		
	end
	local setBlur={[0]=settingsGUI["blurAusCheck"],settingsGUI["blurNormalCheck"],settingsGUI["blurStarkCheck"],settingsGUI["blurGTAIVCheck"],settingsGUI["blurGTAIVExtremCheck"]}
	for i=0,4,1 do		
		guiCheckBoxSetSelected(setBlur[i],false)
	end
	guiCheckBoxSetSelected(setBlur[client_settings["Blur"]],true)	
	
	executeSettingsGUI()
end

function StrToBool(strings)
	if(strings=="true")then
		return true
	else
		return false
	end
end

function settings_show()
	--outputChatBox("enabled")
	guiSetVisible(settingsGUI["_root"],true)
	showCursor(true)
end
addCommandHandler("optionen",settings_show,false,false)
addCommandHandler("settings",settings_show,false,false)


--radiochannel
function setRightChannel(player)
	if(player==getLocalPlayer())then
		if not(client_settings["Standartradio"]==-1)then
			setRadioChannel ( client_settings["Standartradio"] )
		end
	end
end
addEventHandler("onClientVehicleEnter",getRootElement(),setRightChannel)








