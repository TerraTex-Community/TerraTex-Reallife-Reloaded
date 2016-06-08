local lolipop=false
function lollol()
	if(isAdminLevel(getLocalPlayer(),3))then
		if not lolipop then
			setWorldSpecialPropertyEnabled ( "hovercars", true)
			lolipop=true
		else
			setWorldSpecialPropertyEnabled ( "hovercars", false)
			lolipop=false
		
		end
	end
end
addCommandHandler("lollol",lollol)

local lolipop2=false
function lollol2()
	if(isAdminLevel(getLocalPlayer(),3))then
		if not lolipop2 then
			setWorldSpecialPropertyEnabled ( "aircars", true)
			lolipop2=true
		else
			setWorldSpecialPropertyEnabled ( "aircars", false)
			lolipop2=false
		
		end
	end
end
addCommandHandler("lollol2",lollol2)








