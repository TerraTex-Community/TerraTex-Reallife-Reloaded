
addEvent("stunt_dontknocking",true)
addEvent("stunt_nowknocking",true)
function dontknockingoff()
	setPedCanBeKnockedOffBike ( getLocalPlayer(),false )
end
addEventHandler("stunt_dontknocking",getRootElement(),dontknockingoff)
function nowknockingoff()
	setPedCanBeKnockedOffBike ( getLocalPlayer(),true )
end
addEventHandler("stunt_nowknocking",getRootElement(),nowknockingoff)








