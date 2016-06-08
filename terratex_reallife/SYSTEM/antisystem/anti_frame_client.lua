--Defs
local minFrameRate=10
local crashesToKick=10
local showWarning=true


--Vars
local lastFramesPerSecond=0
local actualFramesPerSecond=0
local showFrames=false
local frameCrashLastPerMinute=0





function onFrameRecordStart()
	setTimer(recordNewFrameRate,1000,0)
	setTimer(recordFrameCrashes,60000,0)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),onFrameRecordStart)

function recordNewFrameRate()
	lastFramesPerSecond=actualFramesPerSecond
	if(actualFramesPerSecond<minFrameRate)then
		frameCrashLastPerMinute=frameCrashLastPerMinute+1
		
	end
	actualFramesPerSecond=0
end

function recordFrameCrashes()
	if(crashesToKick<frameCrashLastPerMinute and actualFramesPerSecond<minFrameRate)then
		triggerServerEvent("onKickUserFrameRate",getLocalPlayer())
	end
	frameCrashLastPerMinute=0
end

function onFrameRateCount()
	local screenW, screenH = guiGetScreenSize()  


	actualFramesPerSecond=actualFramesPerSecond+1
	
	if((crashesToKick/3)<frameCrashLastPerMinute and actualFramesPerSecond<minFrameRate)then
		dxDrawText("ACHTUNG! IHRE FRAMERATE IST ZU NIEDRIG!\n(Frameraten können mit /frames gesehen werden)", (screenW - 815) / 2, (screenH - 65) / 2, ((screenW - 815) / 2) + 815, ( (screenH - 65) / 2) + 65, tocolor(255, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
	end
	
	if(showFrames)then
		
		--local text="Frames Per Second: "..lastFramesPerSecond.."\nFrames This Second: "..actualFramesPerSecond.."\nFramecrashs last Minute: "..frameCrashLastPerMinute
		local text=""
		if(lastFramesPerSecond<minFrameRate)then
			text=string.format("%s#FF0000Frames pro Sekunde: %s", text, lastFramesPerSecond)
		else
			text=string.format("%sFrames pro Sekunde: %s", text, lastFramesPerSecond)
		end
		text=string.format("%s\n#FFFFFFFrames diese Sekunde: %s", text, actualFramesPerSecond)
		
		if(frameCrashLastPerMinute>(crashesToKick/3))then
			text=string.format("%s\n#FF0000Framecrashs in der letzten Minute: %s", text, frameCrashLastPerMinute)
		else
			text=string.format("%s\nFramecrashs in der letzten Minute: %s", text, frameCrashLastPerMinute)
		end
		dxDrawText(text , (screenW - 345) / 2, 0, ((screenW - 345) / 2) + 345, ( 0) + 64, tocolor(255, 255, 255, 255), 1.20, "default", "left", "top", false, false, true, true, false)		
	end
end	
addEventHandler("onClientRender",getRootElement(),onFrameRateCount)

function showFrames_switch()
	if(showFrames)then
		showFrames=false
	else
		showFrames=true
	end
end
addCommandHandler("frames",showFrames_switch,false,false)










