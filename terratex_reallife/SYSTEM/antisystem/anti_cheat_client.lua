function loadAntiCheat_pre()
	setWorldSpecialPropertyEnabled ( "hovercars",false)
	setWorldSpecialPropertyEnabled ( "aircars",false)
	setWorldSpecialPropertyEnabled ( "extrabunny",false)
	setWorldSpecialPropertyEnabled ( "extrajump",false)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),loadAntiCheat_pre)








