addEventHandler("onClientResourceStart",resourceRoot,
    function()
        BlitzerTapp_Window = {}
        BlitzerTapp_Button = {}
        BlitzerTapp_Checkbox = {}
        BlitzerTapp_Label = {}
		local dx,dy=guiGetScreenSize()
		dx=610/1600*dx
		dy=389/900*dy
        BlitzerTapp_Window[1] = guiCreateWindow(dx,dy,371,161,"Blitzermelder",false)
		guiWindowSetSizable(BlitzerTapp_Window[1],false)		
        BlitzerTapp_Button[1] = guiCreateButton(13,129,173,23,"Einstellungen Aktivieren!",false,BlitzerTapp_Window[1])
        BlitzerTapp_Button[2] = guiCreateButton(190,129,169,22,"Beenden!",false,BlitzerTapp_Window[1])
        BlitzerTapp_Checkbox[1] = guiCreateCheckBox(13,27,348,21,"Audio Meldung An/Aus",false,false,BlitzerTapp_Window[1])
        BlitzerTapp_Checkbox[2] = guiCreateCheckBox(13,54,348,21,"Anzeige auf der Minimap An/Aus",false,false,BlitzerTapp_Window[1])
        BlitzerTapp_Label[1] = guiCreateLabel(11,79,336,38,"Es können nur Blitzer gewarnt werden, die von den NEWS gemeldet wurden. (Aktualisierung 1/min)",false,BlitzerTapp_Window[1])
        guiLabelSetHorizontalAlign(BlitzerTapp_Label[1],"left",true)
		guiSetVisible(BlitzerTapp_Window[1],false)		
		
		addEventHandler ( "onClientGUIClick", BlitzerTapp_Button[1], saveBlitzerSettings,false)
		addEventHandler ( "onClientGUIClick", BlitzerTapp_Button[2], closeBlitzerTapp,false)

    end
)

local blitzer_audio_enabled=false
local blitzer_show_enabled=false
local blipblitzer=false
local gemeldeteBlitzer={}
local lastblitzerid=-1
local soundpfad="FILES/SOUNDS/80_mobil02_mo.wav"
local lastplayed=false
function onClientRenderBlitzerCheck()
	setTimer(onClientRenderBlitzerCheck,1000,1)
	if(blitzer_audio_enabled or blitzer_show_enabled)and isPedInVehicle(getLocalPlayer()) then
		local time=getRealTime()
		if isElement(blipblitzer) then
			destroyElement(blipblitzer)
        end
        local wasNearABlitzer=false
		local x,y,z=getElementPosition(getLocalPlayer())
		for theKey,theBlitzer in ipairs(gemeldeteBlitzer)do
	--		if(theBlitzer[4]>time.timestamp)then
				if(getDistanceBetweenPoints3D(x,y,z,theBlitzer[1],theBlitzer[2],theBlitzer[3])<150)then
                    wasNearABlitzer=true
                    if not(lastblitzerid==theKey) then
                        lastblitzerid=theKey
						if(blitzer_audio_enabled)and not(lastplayed)then
							playSound(soundpfad)
							lastplayed=true
							setTimer(reset_lastplayed,5000,1)
						end
					end
					if(blitzer_show_enabled)then
						if isElement(blipblitzer) then
							destroyElement(blipblitzer)
						end
						blipblitzer=createBlip(theBlitzer[1],theBlitzer[2],theBlitzer[3],3,255, 0, 0, 255,0, 50)
					end
				end
	--		end
        end
        if not wasNearABlitzer then
            lastblitzerid=-1
        end
	end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),onClientRenderBlitzerCheck)

function reset_lastplayed()
	lastplayed=false
end

function closeBlitzerTapp()
	guiSetVisible(BlitzerTapp_Window[1],false)
end
function showBlitzerTapp()
	guiSetVisible(BlitzerTapp_Window[1],true)
	guiCheckBoxSetSelected(BlitzerTapp_Checkbox[1],blitzer_audio_enabled)
	guiCheckBoxSetSelected(BlitzerTapp_Checkbox[2],blitzer_show_enabled)
end


function saveBlitzerSettings()
	blitzer_audio_enabled=guiCheckBoxGetSelected(BlitzerTapp_Checkbox[1])
	blitzer_show_enabled=guiCheckBoxGetSelected(BlitzerTapp_Checkbox[2])
end


addEvent("AktualziaBlitzerMeldedTable_Event",true)
function AktualziaBlitzerMeldedTable_func(tables)
	gemeldeteBlitzer=tables
end
addEventHandler("AktualziaBlitzerMeldedTable_Event",getRootElement(),AktualziaBlitzerMeldedTable_func)









