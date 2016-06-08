
function createGroveColShape()
	local colshape=createColRectangle(2393.873046875,-1724.5283203125,146,96)
	addEventHandler("onColShapeHit",colshape,enterGroveCol)
	setGarageOpen(9,true)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createGroveColShape)



function enterGroveCol(thePlayer)
	if(vioGetElementData(thePlayer,"fraktion")~=2)then
		outputChatBox("ACHTUNG!!! Sie nähern sich der Grove Street! In diesem Ghetto herrscht Lebensgefahr!",thePlayer,255,0,0)
	end	
end








