local showElementTextTable={}
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

function onShowTextServerSync()
	setTimer(onShowTextServerSync,1000,1)
	--outputDebugString("test2")
	triggerClientEvent(getRootElement(),"onShowTextServerSync_func",getRootElement(),showElementTextTable)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onShowTextServerSync)











