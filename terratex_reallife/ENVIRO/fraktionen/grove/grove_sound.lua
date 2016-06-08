
local eiswagensound=false
local eiswagen=false


function playEiswagenSound_request()

	triggerServerEvent("triggerMeGroveCar",getLocalPlayer())

end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),playEiswagenSound_request)

addEvent("sendGroveEiswagen",true)
function sendGroveEiswagen_func(car)
	--outputChatBox(tostring(car))
	eiswagen=car
	local x,y,z=getElementPosition(eiswagen)
	eiswagensound=playSound3D ( "FILES/SOUNDS/eiswagen.wav", x, y, z, true )
	setSoundVolume (eiswagensound, 0)
	setSoundMaxDistance (eiswagensound, 80 )
	setTimer(checkEnabledEiswagen,500,1)
end
addEventHandler("sendGroveEiswagen",getRootElement(),sendGroveEiswagen_func)

function checkEnabledEiswagen()
	setTimer(checkEnabledEiswagen,500,1)	
	local x,y,z=getElementPosition(eiswagen)
	--outputChatBox(tostring(eiswagensound))
	setElementPosition(eiswagensound,x,y,z)
	if(getVehicleSirensOn ( eiswagen ))then
		setSoundVolume (eiswagensound, 1 )
	else
		setSoundVolume (eiswagensound, 0)
	end
 end
 









