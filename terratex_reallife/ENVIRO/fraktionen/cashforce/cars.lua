frakselfcars[11]={}
local enteredCashForceMarker=false
function createcashforcecars()

 local vehicle= createVehicle(409,2051.876953125,1910.9375,11.983260154724,0.0274658203125,359.81323242188,180.09887695313)
 table.insert(frakselfcars[11],vehicle)
 vehicle= createVehicle(409,2052.357421875,1929.3046875,11.928283691406,0.8843994140625,359.65393066406,174.65515136719)  
 table.insert(frakselfcars[11],vehicle)
 vehicle= createVehicle(579,1911.087890625,1933.8740234375,7.4294748306274,359.98901367188,0.0054931640625,359.6484375) 
 table.insert(frakselfcars[11],vehicle)
 vehicle= createVehicle(579,1904.818359375,1933.51953125,7.4328308105469,359.98901367188,359.99450683594,3.197021484375)  
 table.insert(frakselfcars[11],vehicle)
 vehicle= createVehicle(516,1898.73046875,1933.5576171875,7.4317927360535,359.98901367188,359.98352050781,0.94482421875) 
 table.insert(frakselfcars[11],vehicle)
 vehicle= createVehicle(516,1892.404296875,1933.4765625,7.4337949752808,359.98901367188,0,0.3131103515625) 
 table.insert(frakselfcars[11],vehicle)
 vehicle= createVehicle(579,1886.1708984375,1934.0361328125,7.2074241638184,0.274658203125,0.0164794921875,0.1153564453125)  
 table.insert(frakselfcars[11],vehicle)
 vehicle= createVehicle(579,1880.08984375,1934.2060546875,7.2036962509155,0.2801513671875,0.0274658203125,0.15380859375)  
 table.insert(frakselfcars[11],vehicle)
 vehicle= createVehicle(559,1873.8662109375,1933.591796875,7.2516131401062,359.98901367188,359.98901367188,359.08813476563)  
 table.insert(frakselfcars[11],vehicle)
 vehicle= createVehicle(559,1867.8759765625,1934.009765625,7.2522711753845,359.98901367188,0,359.62646484375)    
 table.insert(frakselfcars[11],vehicle)
 vehicle=createVehicle(487,1965.9150390625,1914.892578125,131.11430358887,0.263671875,359.70886230469,359.43420410156) 
  table.insert(frakselfcars[11],vehicle)
 
 for theKey,theVehicle in ipairs(frakselfcars[11]) do
		setVehicleColor ( theVehicle, 1,1,1,1 )
		prepare(theVehicle,11)
		addEventHandler("onVehicleStartEnter",theVehicle,donotentercashforce)
		vioSetElementData(theVehicle,"tank",100)
			table.insert(frakcars,theVehicle)
	end
	
	local marker=createMarker(1962.8000488281,1922.8000488281,130.39999389648,"cylinder",1.0)
	addEventHandler("onMarkerHit",marker,setDown_cf)
	marker=createMarker(2017.5999755859,1931.1999511719,11.800000190735,"cylinder",1.0)
	addEventHandler("onMarkerHit",marker,setUp_cf)
	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createcashforcecars)
 
function donotentercashforce(player,seat)
	if(vioGetElementData(player,"fraktion")~=11)and(seat==0)then
		cancelEvent()
	end
end
 
function resetCFTimerMarker()
	enteredCashForceMarker=false
end

function setDown_cf(player)
	if not(enteredCashForceMarker) then

        if(not(isPedInVehicle(player)))then
            enteredCashForceMarker=true
            setElementPosition(player,2017.5999755859,1931.1999511719,12.300000190735)
            setTimer(resetCFTimerMarker,1500,1)
        end


	end
end  

function setUp_cf(player)
	if not(enteredCashForceMarker) then
        if(getElementType(player)=="player")then
            if(not(isPedInVehicle(player)))then
                enteredCashForceMarker=true
                setElementPosition(player,1962.8000488281,1922.8000488281,130.89999389648)
                setTimer(resetCFTimerMarker,1500,1)
            end
        end
	end
end  









