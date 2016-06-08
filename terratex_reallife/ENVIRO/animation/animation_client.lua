
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
local animBonePosition={
    ["smoke"]=36,["smokem"]=36,["smokef"]=26
}
local playerZigarren={}
addEvent("addZigarre",true)
function addZigarre_func(anim)
    local x,y,z=getPedBonePosition(source,animBonePosition[anim])
    local rx,ry,rz=getElementRotation(source, "ZXY")
    local int=getElementInterior(source)
    local dim=getElementDimension(source)



   -- local obj=createObject(3044,x,y,z,rx,ry,rz-180)


   -- setElementInterior(obj,int)
   -- setElementDimension(obj,dim)
   -- playerZigarren[source]={obj,anim}

end
addEventHandler("addZigarre",getRootElement(),addZigarre_func)


addEvent("deleteZigarre",true)
function deleteZigarre_func()
    --destroyElement(playerZigarren[source][1])
end
addEventHandler("deleteZigarre",getRootElement(),deleteZigarre_func)


function renderZigarren()
    for theKey, theZigarre in pairs(playerZigarren)do
        if(isElement(theZigarre[1]))then
            local x,y,z=getPedBonePosition(theKey,animBonePosition[theZigarre[2]])
            local rx,ry,rz=getElementRotation(theKey, "ZXY")

            --@FIXME: Rotationen müssen sich Elyptisch ändern.
            --@FIXME: Löschen der Zigarette wenn nicht mehr in animation oder neuer animation

            local dify=math.sin(rz)*0.13
            local difx=math.cos(rz)*-0.07


            setElementPosition(theZigarre[1],x-difx,y-dify,z)
        end
    end
end
addEventHandler("onClientRender",getRootElement(),renderZigarren)










