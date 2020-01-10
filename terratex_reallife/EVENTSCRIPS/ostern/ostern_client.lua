
function ostern_init()
    local timer=getRealTime()
    if (isEaster()) then
		local txd_floors = engineLoadTXD ( "FILES/MODS/icons8.txd" )
		engineImportTXD ( txd_floors, 1241 )
		local dff_floors = engineLoadDFF ( "FILES/MODS/adrenaline.dff", 0 )
		engineReplaceModel ( dff_floors, 1241 )
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),ostern_init)








