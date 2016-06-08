farmerJobExplodeDeleteTable={}

addEvent("DeleteMissionFarmerStop",true)
function DeleteMissionFarmerStop_func()
	for theKey,theElement in ipairs(farmerJobExplodeDeleteTable)do
		if(isElement(theElement))then
			destroyElement(theElement)
		end
	end
end
addEventHandler("DeleteMissionFarmerStop",getRootElement(),DeleteMissionFarmerStop_func)








