function createABaustelle()
    local baustellentable={}
	for i=1,100,1 do
        if (fileExists(":"..getResourceName(getThisResource()).."/MAPS/baustellen/baustelle_"..i..".map" )) then
            table.insert(baustellentable,i)
        end
	end


    local x = math.random(0, 3000)/1000
    local howMany = math.ceil((table.getSize(baustellentable)) * math.exp(-x))
    local which = {}
    local c = 0
    while (c < howMany) do
        local baustelle = math.random(1, table.getSize(baustellentable))
        table.insert(which, baustellentable[baustelle])
        table.remove(baustellentable, baustelle)
        c = c+1
    end

    for theKey, theBaustellenID in ipairs(which) do
        table.insert(baustellentable, theBaustellenID)
        outputDebugString(string.format("Baustelle mit ID %s wurde geladen!", theBaustellenID))
        local node = xmlLoadFile(":"..getResourceName(getThisResource()).."/MAPS/baustellen/baustelle_"..theBaustellenID..".map")
        local mapRoot = loadMapData(node, root)
        xmlUnloadFile(node)
    end


    reloadMapExtensions()

end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createABaustelle)


function loadAllBaustellen()
    local baustellentable={}
    for i=1,100,1 do
        if (fileExists(":"..getResourceName(getThisResource()).."/MAPS/baustellen/baustelle_"..i..".map" )) then
            table.insert(baustellentable,i)
        end
    end

    for theKey,theID in ipairs(baustellentable)do
        outputDebugString(string.format("Baustelle %s von %s wurde geladen!", theKey.."("..theID..")", table.getSize(baustellentable)))
        local node = xmlLoadFile(":"..getResourceName(getThisResource()).."/MAPS/baustellen/baustelle_"..theID..".map")
        local mapRoot = loadMapData(node, root)
        xmlUnloadFile(node)

    end


    reloadMapExtensions()
end


function load_All_Baustellen_by_admin(thePlayer)
	if(isAdminLevel(thePlayer,3))then
		loadAllBaustellen()
	end
end
addCommandHandler("loadAllBaustellen",load_All_Baustellen_by_admin,false,false)
