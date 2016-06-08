--TableInserts: <1>element, <2>posx, <3>posy, <4>posz, <5>true=pos/false=elementattached, <6>textcolor, <7>text, <8>durchobjecte, <9>disabled ,<10>distance, <11>size, <12>zkorri
local showElementTextTable={}
local showElementTextTable_server={}
local standarddis=25

function showElementTexted()
	local px,py,pz=getElementPosition(getLocalPlayer())
	for theKey,theTable in ipairs(showElementTextTable) do
		if not(theTable[9])then
			
			local posx,posy,posz=theTable[2],theTable[3],theTable[4]
			if not(theTable[5])then
				posx,posy,posz=getElementPosition(theTable[1])
			end
			local dis=standarddis
			if(theTable[10])then
				dis=theTable[10]
			end
			if(theTable[12])then
				posz=posz+theTable[12]
			end
			if(getDistanceBetweenPoints3D(px,py,pz,posx,posy,posz)<dis)then
				if(theTable[8] and isLineOfSightClear ( px,py,pz ,posx,posy,posz, true,false,false,true,false,true))or(not(theTable[8]))then
					local sx,sy,sz=getScreenFromWorldPosition ( posx,posy,posz )
					if(sx)then
						dxDrawText (theTable[7], sx,sy, sx,sy, theTable[6], theTable[11], "default", "left", "top", false ,true,false,false, false)
					end
				end
			end
		end
	end
	for theKey,theTable in ipairs(showElementTextTable_server) do
		if not(theTable[9])then
			if(isElement(theTable[1]))then
				local posx,posy,posz=theTable[2],theTable[3],theTable[4]
				if not(theTable[5])then
					posx,posy,posz=getElementPosition(theTable[1])
				end
				local dis=standarddis
				if(theTable[10])then
					dis=theTable[10]
				end
				if(theTable[12])then
					posz=posz+theTable[12]
				end
				if(getDistanceBetweenPoints3D(px,py,pz,posx,posy,posz)<dis)then
					if(theTable[8] and isLineOfSightClear ( px,py,pz ,posx,posy,posz, true,false,false,true,false,true))or(not(theTable[8]))then
						local sx,sy,sz=getScreenFromWorldPosition ( posx,posy,posz )
						if(sx)then
							dxDrawText (theTable[7], sx,sy, sx,sy, theTable[6], theTable[11], "default", "center", "top", false ,true,false,false, false)
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender",getRootElement(),showElementTexted)

function changePosShowText(id,color,text)
	showElementTextTable[id][6]=color
	showElementTextTable[id][7]=text
end

function changeElementShowText(element,color,text)
	for theKey,theTable in ipairs(showElementTextTable) do
		if(theTable[1]==element)then
			theTable[6]=color
			theTable[7]=text
			hasText=true
		end	
	end
end

function unsetPosShowText(id)
	showElementTextTable[id][9]=true
end

function setPosShowText(posx,posy,posz,color,text,durchobjecte,distance,size)
	table.insert(showElementTextTable,{false,posx,posy,posz,true,color,text,durchobjecte,false,distance,size,false})
	local insertKey=false
	for theKey,theTable in ipairs(showElementTextTable) do
		if(theTable[2]==posx and theTable[3]==posy and theTable[4]==posz)then
			insertKey=theKey
		end
	end
	return insertKey
end

function setElementShowText(element,color,text,durchobjecte,distance,size,zkorri)
	local hasText=false
	for theKey,theTable in ipairs(showElementTextTable) do
		if(theTable[1]==element)then
			theTable[6]=color
			theTable[7]=text
			theTable[8]=durchobjecte
			theTable[10]=distance
			theTable[11]=size
			theTable[12]=zkorri
			hasText=true
		end	
	end
	if(not(hasText))then
		table.insert(showElementTextTable,{element,0,0,0,false,color,text,durchobjecte,false,distance,size,zkorri})
	end
	return true
end

function unsetElementShowText(element)
	for theKey,theTable in ipairs(showElementTextTable) do
		if(theTable[1])then
			theTable[9]=true
		end	
	end
	return true
end

function onShowTextServerSync_func_func(tabler)
	showElementTextTable_server=tabler
	for theKey,theTable in ipairs(showElementTextTable_server)do
		if(type( theTable[6] )=="table")then
			theTable[6]=tocolor(theTable[6][1],theTable[6][2],theTable[6][3],theTable[6][4])
		end
	end
end
addEvent("onShowTextServerSync_func",true)
addEventHandler("onShowTextServerSync_func",getRootElement(),onShowTextServerSync_func_func)








