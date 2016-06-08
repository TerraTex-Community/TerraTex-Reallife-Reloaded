function createLVTOR() 
	createObject(2930,2294,2494.600,4.90)
end
addEventHandler("createLVTOR",getRootElement(),createLVTOR)

local lvpdtore={}
lvpdtore[1]=createObject(971,2293.89,2499.3,5.8,0,0,90)
lvpdtore[2]=createObject(971,2334.8,2444,6.199,0,0,59.25)
lvpdtore[3]=createObject(968,2238.199,2450.399,10.6,0,90,90)
local lvpdtorstatus={false,false,false}

lvpdschranketurnable=true




function openLVPDtore(thePlayer)
	if(isBeamter(thePlayer))then
		local x,y,z=getElementPosition(thePlayer)
		local dis=getDistanceBetweenPoints3D(x,y,z,2293.89,2499.3,5.8)
		if(dis<10)then
			if(lvpdtorstatus[1])then
				lvpdtorstatus[1]=false
				moveObject(lvpdtore[1],3000,2293.89,2499.3,5.8)
			else
				lvpdtorstatus[1]=true
				moveObject(lvpdtore[1],3000,2293.89,2508,5.8)
			end
		end
		local dis=getDistanceBetweenPoints3D(x,y,z,2334.8,2444,6.199)
		if(dis<10)then
			if(lvpdtorstatus[2])then
				lvpdtorstatus[2]=false
				moveObject(lvpdtore[2],3000,2334.8,2444,6.199)
			else
				lvpdtorstatus[2]=true
				moveObject(lvpdtore[2],3000,2334.8,2444,-1)
			end
		end		
		
	end
	if(isBeamter(thePlayer))then
		local x,y,z=getElementPosition(thePlayer)
		local dis=getDistanceBetweenPoints3D(x,y,z,2238.199,2450.399,10.6)
		if(dis<10)then
			if(lvpdschranketurnable)then
				if(lvpdtorstatus[3])then
					moveObject(lvpdtore[3],3000,2238.199,2450.399,10.6,0,90,0)
					lvpdtorstatus[3]=false
					lvpdschranketurnable=false
					setTimer(setLVPDSchrankeMoveAble,3500,1)
				else
					moveObject(lvpdtore[3],3000,2238.199,2450.399,10.6,0,-90,0)				
					lvpdtorstatus[3]=true				
					lvpdschranketurnable=false					
					setTimer(setLVPDSchrankeMoveAble,3500,1)
				end	
			end
		end	
	end
end
addCommandHandler("mv",openLVPDtore,false,false)

function setLVPDSchrankeMoveAble()
	lvpdschranketurnable=true
end
    
    








