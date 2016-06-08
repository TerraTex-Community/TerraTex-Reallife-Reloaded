addEvent("onIntDimChange",true)
_setElementInterior=setElementInterior
function setElementInterior(Element,Interior)
	if(isElement(Element)) and Interior then
		triggerEvent("onIntDimChange",Element,Interior,-1)
		_setElementInterior(Element,Interior)
	end

end

_setElementDimension=setElementDimension
function setElementDimension(Element,dim)
	if(isElement(Element))and (dim) then
		triggerEvent("onIntDimChange",Element,-1,dim)
		_setElementDimension(Element,dim)
	end
end



addEvent("clientSetElementDimension",true)
addEvent("clientSetElementInterior",true)

function clientSetElementDimension_func(thePlayer,dim)
    setElementDimension(thePlayer,dim)
end

function clientSetElementInterior_func(thePlayer,int,x,y,z)
    setElementInterior(thePlayer,int,x,y,z)
end

addEventHandler("clientSetElementDimension",getRootElement(),clientSetElementDimension_func)
addEventHandler("clientSetElementInterior",getRootElement(),clientSetElementInterior_func)








