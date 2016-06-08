
function halloween_init()
    local timer=getRealTime()
    --vom 18.04.2014 - 21.04.2014
    if((((timer.monthday>=1 and timer.monthday<=3) and (timer.month+1)==11) or ((timer.monthday>=28 and timer.monthday<=32) and (timer.month+1)==10)) and (timer.year+1900)==2014)then
		
	
		txd_floors = engineLoadTXD ( "FILES/MODS/icons8.txd" )
		engineImportTXD ( txd_floors, 1241 )
		dff_floors = engineLoadDFF ( "FILES/MODS/adrenaline.dff", 0 )
		engineReplaceModel ( dff_floors, 1241 )
	
	
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),halloween_init)








