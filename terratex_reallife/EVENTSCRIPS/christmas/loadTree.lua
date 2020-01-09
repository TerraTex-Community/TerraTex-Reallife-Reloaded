function loadChrismasStuff()
    if (isChristmasTime()) then
        outputDebugString(string.format("Weihnachtsbaum wird geladen!", theBaustellenID))
        local node = xmlLoadFile(":"..getResourceName(getThisResource()).."/EVENTSCRIPT/christmas/Weihnachtsbaum.map")
        local mapRoot = loadMapData(node, root)
        xmlUnloadFile(node)
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadChrismasStuff);
