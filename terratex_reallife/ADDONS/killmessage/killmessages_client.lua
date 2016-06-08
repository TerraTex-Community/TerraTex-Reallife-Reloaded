local killMessage="Off"
function showKillMessages()
	if(isAdminLevel(getLocalPlayer(),1))then
		if(killMessage=="Off")then
			killMessage="On"
			outputChatBox(killMessage)
		else
			killMessage="Off"
			outputChatBox(killMessage)
		end
	end
end
addCommandHandler("skm",showKillMessages,false,false)




addEvent ("onClientPlayerKillMessage",true)
function onClientPlayerKillMessage ( killer,weapon,wr,wg,wb,kr,kg,kb,bodypart,width,resource )
	if wasEventCancelled() then return end
	if(killMessage=="On")then
		outputKillMessage ( source, wr,wg,wb,killer,kr,kg,kb,weapon,bodypart,width,resource )
	end
end
addEventHandler ("onClientPlayerKillMessage",getRootElement(),onClientPlayerKillMessage)

function outputKillMessage ( source, wr,wg,wb,killer,kr,kg,kb,weapon,bodypart,width,resource )
	if not iconWidths[weapon] then 
		if type(weapon) ~= "string" then
			weapon = 999 
		end
	end
	local killerName
	local wastedName
	if not tonumber(wr) then wr = 255 end
	if not tonumber(wg) then wg = 255 end
	if not tonumber(wb) then wb = 255 end
	if not tonumber(kr) then kr = 255 end
	if not tonumber(kg) then kg = 255 end
	if not tonumber(kb) then kb = 255 end
	if ( source ) then
		if isElement ( source ) then
			if getElementType ( source ) == "player" then 
				wastedName = getPlayerName ( source )
			else 
			outputDebugString ( "outputKillMessage - Invalid 'wasted' player specified",0,0,0,100)
			return false end
		elseif type(source) == "string" then
			wastedName = source
		end
	else 
		outputDebugString ( "outputKillMessage - Invalid 'wasted' player specified",0,0,0,100)
	return false end
	if ( killer ) then
		if isElement ( killer ) then
			if getElementType ( killer ) == "player" then
				killerName = getPlayerName ( killer )
			else 
				outputDebugString ( "outputKillMessage - Invalid 'killer' player specified",0,0,0,100)
			return false end
		elseif type(killer) == "string" then
			killerName = killer
		else
			killerName = ""
		end
	else killerName = "" end
	--create the new text
	if not killerName then
		killerName = ""
	end
	if bodypart==9 then
		return outputMessage ( {killerName, {"padding",width=3}, {"icon",id=weapon},{"padding",width=3}, {"icon",id=256},
		{"padding",width=3},{"color",r=wr,g=wg,b=wb}, wastedName},
		kr,kg,kb )
	else
		return outputMessage ( {killerName, {"padding",width=3}, {"icon",id=weapon},
		{"padding",width=3},{"color",r=wr,g=wg,b=wb}, wastedName},
		kr,kg,kb )
	end
	
end
