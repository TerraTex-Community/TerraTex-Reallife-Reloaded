local streamElement=false
local streamVolumen=100
local streamtext=""
local filename="files/streamer.xml"
local streamlinks={}

addEventHandler("onClientResourceStart",resourceRoot,
    function()

        radioStreamer_Window = {}
        radioStreamer_Button = {}
        radioStreamer_Checkbox = {}
        radioStreamer_Label = {}
        radioStreamer_Edit = {}
        radioStreamer_Scrollbar = {}
		radioStreamer_Combobox={}

		local dx,dy=guiGetScreenSize()
		dx=549/1600*dx
		dy=295/900*dy	
        radioStreamer_Window[1] = guiCreateWindow(dx,dy,573,188,"Radio Streamer",false)
		table.insert(allGuis,radioStreamer_Window[1])
        radioStreamer_Label[1] = guiCreateLabel(21,32,168,17,"Neuer Streamlink:",false,radioStreamer_Window[1])
        radioStreamer_Edit[1] = guiCreateEdit(133,27,324,28,"",false,radioStreamer_Window[1])
        radioStreamer_Button[1] = guiCreateButton(463,27,101,29,"hinzufügen",false,radioStreamer_Window[1])
        radioStreamer_Label[2] = guiCreateLabel(57,65,123,22,"Streamauswahl:",false,radioStreamer_Window[1])
        radioStreamer_Combobox[1]=guiCreateComboBox ( 172,64,285,160, "Streams", false, radioStreamer_Window[1] )
		radioStreamer_Button[2] = guiCreateButton(465,62,97,25,"entfernen",false,radioStreamer_Window[1])
        radioStreamer_Label[3] = guiCreateLabel(22,103,121,24,"Lautstärke:",false,radioStreamer_Window[1])
        radioStreamer_Scrollbar[1] = guiCreateScrollBar(104,104,446,16,true,false,radioStreamer_Window[1])
        radioStreamer_Button[3] = guiCreateButton(25,146,129,27,"Play",false,radioStreamer_Window[1])
        radioStreamer_Button[4] = guiCreateButton(222,146,129,27,"Stop",false,radioStreamer_Window[1])
        radioStreamer_Button[5] = guiCreateButton(421,146,129,27,"Close",false,radioStreamer_Window[1])

		
		addEventHandler("onClientGUIComboBoxAccepted",radioStreamer_Combobox[1],selectRadioStream,false)
				
		addEventHandler("onClientGUIClick",radioStreamer_Button[1],addStreamFromRadioStreamList,false)
		addEventHandler("onClientGUIClick",radioStreamer_Button[2],removeStreamFromRadioStreamList,false)
		addEventHandler("onClientGUIClick",radioStreamer_Button[3],startPlayingRadioStreamer,false)
		addEventHandler("onClientGUIClick",radioStreamer_Button[4],stopPlayingRadioStreamer,false)		
		addEventHandler ( "onClientGUIClick", radioStreamer_Button[5], closeRadioSreamer, false )
		addEventHandler("onClientGUIScroll", radioStreamer_Scrollbar[1],onScrollRadioStreamer,false)
		guiSetVisible(radioStreamer_Window[1],false)
		bindKey ( "F2", "down", openRadioStreamer)
		
		local filehandler
		if not(fileExists ( filename ))then
			local node=xmlCreateFile ( filename, "streamer" )			
			local childnode=xmlCreateChild ( node, "lastVolume" )
			xmlNodeSetValue ( childnode, tostring(100) )
			childnode=xmlCreateChild ( node, "lastPlayedLink" )
			xmlNodeSetValue ( childnode, tostring(-1) )		
			childnode=xmlCreateChild ( node, "streams" )
			xmlSaveFile ( node )
			xmlUnloadFile(node)
		else
			local node=xmlLoadFile(filename)
			streamVolumen=tonumber(xmlNodeGetValue (xmlFindChild ( node, "lastVolume", 0 ) ))
			streamtext=xmlNodeGetValue (xmlFindChild ( node, "lastPlayedLink", 0 ) )
			local streamnodes=xmlNodeGetChildren (xmlFindChild ( node, "streams", 0 ))
			for theKey,theNode in ipairs(streamnodes)do
				table.insert(streamlinks,xmlNodeGetValue(theNode))
				guiComboBoxAddItem(  radioStreamer_Combobox[1], xmlNodeGetValue(theNode) )
				if(xmlNodeGetValue(theNode)==streamtext)then
					guiComboBoxSetSelected(radioStreamer_Combobox[1],(theKey-1))
				end
			end
			xmlUnloadFile(node)
		end	
		
    end
)

function addStreamFromRadioStreamList()
	local name=guiGetText(radioStreamer_Edit[1])
	local isInTable=false
	for theKey,theName in ipairs(streamlinks)do
		if(theName==name)then
			isInTable=true
		end
	end
	if(isInTable)then
		outputChatBox("Dieser StreamLink existiert bereits in der Auswahl!",255,0,0)
	else
		table.insert(streamlinks,name)
		guiSetText(radioStreamer_Edit[1],"")
		streamtext=name
		local itemid=guiComboBoxAddItem(radioStreamer_Combobox[1], name )
		guiComboBoxSetSelected(radioStreamer_Combobox[1],itemid)
		if(isElement(streamElement))then
			stopSound(streamElement)
			streamElement=playSound(streamtext)
		end
	end
end

function removeStreamFromRadioStreamList()
	if(isElement(streamElement))then
		stopPlayingRadioStreamer()
	end
	local item = guiComboBoxGetSelected(radioStreamer_Combobox[1])
	local text = guiComboBoxGetItemText(radioStreamer_Combobox[1], item)
	removeStreamFromTable(text)
	guiComboBoxRemoveItem(radioStreamer_Combobox[1], item )

end


function selectRadioStream()
	local item = guiComboBoxGetSelected(radioStreamer_Combobox[1])
	--outputChatBox("ID:"..item)
	local text = guiComboBoxGetItemText(radioStreamer_Combobox[1], item)
	streamtext=text
	if(isElement(streamElement))then
		stopSound(streamElement)
		streamElement=playSound(streamtext)
	end
end

function removeStreamFromTable(name)
	for theKey,theName in ipairs(streamlinks)do
		if(theName==name)then
			table.remove(streamlinks,theKey)
		end
	end
end

function saveRadioXML()
	--outputChatBox("saved")
	local node=xmlLoadFile(filename)
	--outputChatBox("saved"..tostring(node))	
	local child=xmlFindChild ( node, "lastVolume",0)
	xmlNodeSetValue (child , tostring(streamVolumen) )	
	child=xmlFindChild ( node, "lastPlayedLink",0)
	xmlNodeSetValue ( child , tostring(streamtext) )	
	child=xmlFindChild ( node, "streams",0)
	xmlDestroyNode ( child )
	childnode=xmlCreateChild ( node, "streams" )
	for theKey,theName in ipairs(streamlinks)do
		local streamnode=xmlCreateChild ( childnode, "stream" )
		xmlNodeSetValue(streamnode,theName)	
	end
	xmlSaveFile(node)
	xmlUnloadFile(node)
end


function onScrollRadioStreamer()	
		streamVolumen=guiScrollBarGetScrollPosition ( radioStreamer_Scrollbar[1])
		if(streamElement)then			
			setSoundVolume ( streamElement, (streamVolumen/100) )
		end
end




function stopPlayingRadioStreamer()
		stopSound(streamElement)
		streamVolumen=guiScrollBarGetScrollPosition ( radioStreamer_Scrollbar[1])
		streamElement=false

end


function startAutoPlayingRadioStreamer()
	stream=streamtext
	--streamVolumen=guiScrollBarGetScrollPosition ( radioStreamer_Scrollbar[1])
	if( not(streamElement))then
		streamElement=playSound(stream)
		setSoundVolume ( streamElement, (streamVolumen/100) )
	end
end



function startPlayingRadioStreamer()
	if(streamElement)then
		stopSound(streamElement)
	end
	streamVolumen=guiScrollBarGetScrollPosition ( radioStreamer_Scrollbar[1])
	streamElement=playSound(streamtext)
	setSoundVolume ( streamElement, streamVolumen/100 )
	--outputChatBox(streamtext)

end

function openRadioStreamer()
	guiSetVisible(radioStreamer_Window[1],true)
	showCursor(true)
	guiScrollBarSetScrollPosition ( radioStreamer_Scrollbar[1], streamVolumen )

	
end

function closeRadioSreamer()

	saveRadioXML()
	guiSetVisible(radioStreamer_Window[1],false)
	showCursor(false)
end








