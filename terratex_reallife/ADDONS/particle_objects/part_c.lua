function resourceLoading()
			local part_dff = engineLoadDFF("ADDONS/particle_objects/particles/petrolcan.dff",2052)
			engineReplaceModel(part_dff,2052)
			local part_dff = engineLoadDFF("ADDONS/particle_objects/particles/puke.dff",2053)
			engineReplaceModel(part_dff,2053)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),resourceLoading)