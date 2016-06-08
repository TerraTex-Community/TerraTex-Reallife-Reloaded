addEventHandler("onClientResourceStart",resourceRoot,
    function()
        StoppUhr_Window = {}
        StoppUhr_Button = {}
        StoppUhr_Label = {}
		
		local dx,dy=guiGetScreenSize()
		dx=610/1600*dx
		dy=389/900*dy
		
        StoppUhr_Window[1] = guiCreateWindow(dx,dy,378,142,"Stopuhr 3000",false)
        guiWindowSetSizable(StoppUhr_Window[1],false)
		guiWindowSetSizable(StoppUhr_Window[1],false)
        StoppUhr_Button[1] = guiCreateButton(14,108,113,25,"Start/Pause",false,StoppUhr_Window[1])
        StoppUhr_Button[2] = guiCreateButton(133,108,113,25,"RESET",false,StoppUhr_Window[1])
        StoppUhr_Button[3] = guiCreateButton(251,108,113,25,"Beenden",false,StoppUhr_Window[1])
        StoppUhr_Label[1] = guiCreateLabel(14,26,116,16,"Zeit in Sekunden:",false,StoppUhr_Window[1])
        StoppUhr_Label[2] = guiCreateLabel(131,26,116,16,"0 Sekunden",false,StoppUhr_Window[1])
        StoppUhr_Label[3] = guiCreateLabel(71,52,116,16,"Exakt:",false,StoppUhr_Window[1])
        guiSetFont(StoppUhr_Label[3],"clear-normal")
        StoppUhr_Label[4] = guiCreateLabel(130,53,225,18,"00:00:00,000",false,StoppUhr_Window[1])
		StoppUhr_Label[5] = guiCreateLabel(71,81,341,18,"Schnellbefehl zum Starten/Pause: /stopuhr",false,StoppUhr_Window[1])
        guiSetFont(StoppUhr_Label[4],"clear-normal")
		guiSetVisible(StoppUhr_Window[1],false)		
		addEventHandler ( "onClientGUIClick", StoppUhr_Button[3], stopShowStoppUhr,false)
		addEventHandler ( "onClientGUIClick", StoppUhr_Button[2], ResetCounter,false)
		addEventHandler ( "onClientGUIClick", StoppUhr_Button[1], startPausedTimer,false)
		
		setTimer(countUpStopUhr,235,1)
    end
)

local isStopUhrRunning=false
local stopptimer=false
local stopUhrTime=0

function stopuhr_func()
	if(guiGetVisible(StoppUhr_Window[1]))then
		startPausedTimer()
	end	
end
addCommandHandler("stopuhr",stopuhr_func,false,false)

--%02d
function countUpStopUhr()
	setTimer(countUpStopUhr,341,1)
	if(isStopUhrRunning)then
		stopUhrTime=stopUhrTime+341
		local stopUhrTimeexecute=stopUhrTime
		local seconds=math.round(stopUhrTimeexecute/1000,0,"floor")
		guiSetText(StoppUhr_Label[2], string.format("%s Sekunden", seconds)) -- .seconds
		
		local hour=math.round(stopUhrTimeexecute/1000/60/60,0,"floor")
		stopUhrTimeexecute=stopUhrTimeexecute-hour*60*60*1000
		local minute=math.round(stopUhrTimeexecute/1000/60,0,"floor")
		stopUhrTimeexecute=stopUhrTimeexecute-minute*1000*60
		local seconde=math.round(stopUhrTimeexecute/1000,0,"floor")
		stopUhrTimeexecute=stopUhrTimeexecute-seconde*1000		
		
		guiSetText(StoppUhr_Label[4],string.format("%02d:%02d:%02d,%03d",hour,minute,seconde,stopUhrTimeexecute))
	end
end

function startPausedTimer()
--[[	if(isTimer(stopptimer))then
		killTimer(stopptimer)
	else
		stopptimer=setTimer(countUpStopUhr,123,0)
	end]]
	isStopUhrRunning=not(isStopUhrRunning)
end

function ResetCounter()
	stopUhrTime=0
	guiSetText(StoppUhr_Label[2],"0 Sekunden")
	guiSetText(StoppUhr_Label[4],"00:00:00,000")
end


function showStoppUhrTapp()
	guiSetVisible(StoppUhr_Window[1],true)
end

function stopShowStoppUhr()
	guiSetVisible(StoppUhr_Window[1],false)
end









