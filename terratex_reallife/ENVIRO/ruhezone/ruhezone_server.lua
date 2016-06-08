ruhezonen={}
--local area=createRadarArea ( posXA,posYA,sizeX,sizeY,0, 200, 0, 150,getRootElement())
--ruhezonen[ID]=area


function createAndLoadRuheZonen()
	local query="SELECT * FROM ruhezonen"
	local result=mysql_query(handler,query)
	local zahler=0
	while (mysql_num_rows(result)>zahler) do
		local dasatz = mysql_fetch_assoc(result)
		local area=createRadarArea ( tonumber(dasatz["leftX"]),tonumber(dasatz["buttonY"]),tonumber(dasatz["sizeX"]),tonumber(dasatz["sizeY"]),0, 200, 0, 150,getRootElement())
		ruhezonen[tonumber(dasatz["ID"])]=area	
		zahler=zahler+1
	end

end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createAndLoadRuheZonen)

function isInRuheZone(thePlayer)
	local x,y,z = getElementPosition(thePlayer)
	for theKey, theArea in pairs (ruhezonen) do
		if(isInsideRadarArea ( theArea, x, y ))then
			return true
		end
	end	
	return false

end









