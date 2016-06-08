
function ostern_init()
    local timer=getRealTime()
    --vom 18.04.2014 - 21.04.2014
    if((timer.monthday>=5 and timer.monthday<=7) and (timer.month+1)==4 and (timer.year+1900)==2015)then
		
	
		local txd_floors = engineLoadTXD ( "FILES/MODS/icons8.txd" )
		engineImportTXD ( txd_floors, 1241 )
		local dff_floors = engineLoadDFF ( "FILES/MODS/adrenaline.dff", 0 )
		engineReplaceModel ( dff_floors, 1241 )
	
	
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),ostern_init)








