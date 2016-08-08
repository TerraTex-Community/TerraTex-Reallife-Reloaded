
addEvent("playVomit",true)
function playVomit_func(playerSource)
	local x,y,z=getPedBonePosition(playerSource,8)
	local obj1=createObject(2053,x,y,z-0.3)
	local obj2=createObject(2053,x,y,z-0.3)
	local obj3=createObject(2053,x,y,z-0.3)
	local obj4=createObject(2053,x,y,z-0.3)
	local obj5=createObject(2053,x,y,z-0.3)
	
	local int=getElementInterior(playerSource)
	local dim=getElementDimension(playerSource)
	
	setElementInterior(obj1,int)
	setElementInterior(obj2,int)
	setElementInterior(obj3,int)
	setElementInterior(obj4,int)
	setElementInterior(obj5,int)
	
	setElementDimension(obj1,dim)
	setElementDimension(obj2,dim)
	setElementDimension(obj3,dim)
	setElementDimension(obj4,dim)
	setElementDimension(obj5,dim)
	
	
	
	setTimer(destroyAnimation,5000,1,obj1,obj2,obj3,obj4,obj5)
end
addEventHandler("playVomit",getRootElement(),playVomit_func)

function destroyAnimation(obj1,obj2,obj3,obj4,obj5)

	destroyElement(obj1)
	destroyElement(obj2)
	destroyElement(obj3)
	destroyElement(obj4)
	destroyElement(obj5)
end

