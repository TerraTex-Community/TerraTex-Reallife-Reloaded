
function createABaustelle()
    local baustellentable={}
	for i=1,100,1 do
        if (fileExists(":"..getResourceName(getThisResource()).."/MAPS/baustellen/baustelle_"..i..".map" )) then
            table.insert(baustellentable,i)
        end
	end
--	n=n-1



	local baustelle=math.random(1,table.getSize(baustellentable)+1)
	if(baustelle==table.getSize(baustellentable)+1)then
		loadAllBaustellen()
	else 
		local howMany=math.random(1,3)
        if(howMany==1)then

            outputDebugString(string.format("Baustelle %s von %s wurde geladen!", baustelle, table.getSize(baustellentable)))
            local node = xmlLoadFile(":"..getResourceName(getThisResource()).."/MAPS/baustellen/baustelle_"..baustellentable[baustelle]..".map")
            local mapRoot = loadMapData(node, root)
            xmlUnloadFile(node)

        else
            local which={}
            table.insert(which,baustelle)
            local c=1
            while(c<=howMany)do
                baustelle=math.random(1,table.getSize(baustellentable))
                if(not table.hasValue(which,baustelle))then
                    table.insert(which,baustelle)
                    c=c+1
                end
            end

            for theKey, theBaustellenID in ipairs(which)do
                outputDebugString(string.format("Baustelle %s von %s wurde geladen!", theBaustellenID, table.getSize(baustellentable)))
                local node = xmlLoadFile(":"..getResourceName(getThisResource()).."/MAPS/baustellen/baustelle_"..baustellentable[theBaustellenID]..".map")
                local mapRoot = loadMapData(node, root)
                xmlUnloadFile(node)
            end
        end
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








