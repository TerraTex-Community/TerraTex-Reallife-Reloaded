function deactivateTarn()
	if(source==getLocalPlayer())then
		if(getElementData(getLocalPlayer(),"tarnung"))then
			triggerServerEvent("onDeactivateTarn",source)
		end
	end
end
addEventHandler("onClientPlayerWeaponFire",getRootElement(),deactivateTarn)

addEvent("onShowPlayerTarnung",true)
function onShowPlayerTarnung_func()
	setElementAlpha(source,100)
end
addEventHandler("onShowPlayerTarnung",getRootElement(),onShowPlayerTarnung_func)








