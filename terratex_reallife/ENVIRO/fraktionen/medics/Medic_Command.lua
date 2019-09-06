local function commandMedicDutyList(thePlayer)
	local myDutyMedics = {}
	for k, v in ipairs(getPlayersInTeam(team[10])) do
		if (vioGetElementData(v, "isMedicDuty")) then
			table.insert(myDutyMedics, getPlayerName(v))
		end
	end
	outputChatBox(string.format("Es sind %s Medics im Dienst", table.getn(myDutyMedics)), thePlayer, 16, 188, 0)
	if (table.getn(myDutyMedics) > 0) then
		outputChatBox(string.format("Im Dienst sind: %s", table.concat(myDutyMedics, ", ")), thePlayer, 16, 188, 0)
	end
end
addCommandHandler("medic", commandMedicDutyList, false, false)



----- Medic-Tore LS -----
--- Hintere Tore ---
-- Hintertor 1
local backdoor1 = createObject( 3037, 1108.099609375, -1309.599609375, 14.857500076294, 0, 0, 270 )
local backdoor1_key1 = createObject( 2886, 1113.400390625, -1310.5, 14.39999961853, 0, 0, 0 )
local backdoor1_key2 = createObject( 2886, 1113.400390625, -1308.9000244141, 14.39999961853, 0, 0, 180 )

function medic_backdoor_func1 ( button, state, player )
	if vioGetElementData( player, "fraktion" ) ~= 10 then return end
	if getElementData( backdoor1, "moving" ) == true then return end
	setElementData( backdoor1, "moving", true )
	setTimer( setElementData, 2600, 1, backdoor1, "moving", false )
	if getElementData( backdoor1, "state" ) == "open" then
		moveObject( backdoor1, 2500, 1108.099609375, -1309.599609375, 14.857500076294 )
		setElementData( backdoor1, "state", "closed" )
	else
		moveObject( backdoor1, 2500, 1102.5999755859, -1309.599609375, 14.857500076294 )
		setElementData( backdoor1, "state", "open" )
	end
end
addEventHandler( "onElementClicked", backdoor1_key1, medic_backdoor_func1 )
addEventHandler( "onElementClicked", backdoor1_key2, medic_backdoor_func1 )

-- Hintertor 2
local backdoor2 = createObject( 3037, 1119.7998046875, -1309.599609375, 14.857500076294, 0, 0, 270 )
local backdoor2_key1 = createObject( 2886, 1125.2001953125, -1310.5, 14.39999961853, 0, 0, 0 )
local backdoor2_key2 = createObject( 2886, 1125.2001953125, -1308.9000244141, 14.39999961853, 0, 0, 180 )

function medic_backdoor_func2 ( button, state, player )
	if vioGetElementData( player, "fraktion" ) ~= 10 then return end
	if getElementData( backdoor2, "moving" ) == true then return end
	setElementData( backdoor2, "moving", true )
	setTimer( setElementData, 2600, 1, backdoor2, "moving", false )
	if getElementData( backdoor2, "state" ) == "open" then
		moveObject( backdoor2, 2500, 1119.7998046875, -1309.599609375, 14.857500076294 )
		setElementData( backdoor2, "state", "closed" )
	else
		moveObject( backdoor2, 2500, 1119.7998046875, -1309.599609375, 10.300000190735 )
		setElementData( backdoor2, "state", "open" )
	end
end
addEventHandler( "onElementClicked", backdoor2_key1, medic_backdoor_func2 )
addEventHandler( "onElementClicked", backdoor2_key2, medic_backdoor_func2 )

-- Hintertor 3
local backdoor3 = createObject( 3037, 1131.599609375, -1309.599609375, 14.857500076294, 0, 0, 270 )
local backdoor3_key1 = createObject( 2886, 1126.2001953125, -1310.5, 14.39999961853, 0, 0, 0 )
local backdoor3_key2 = createObject( 2886, 1126.2001953125, -1308.9000244141, 14.39999961853, 0, 0, 180 )

function medic_backdoor_func3 ( button, state, player )
	if vioGetElementData( player, "fraktion" ) ~= 10 then return end
	if getElementData( backdoor3, "moving" ) == true then return end
	setElementData( backdoor3, "moving", true )
	setTimer( setElementData, 2600, 1, backdoor3, "moving", false )
	if getElementData( backdoor3, "state" ) == "open" then
		moveObject( backdoor3, 2500, 1131.599609375, -1309.599609375, 14.857500076294 )
		setElementData( backdoor3, "state", "closed" )
	else
		moveObject( backdoor3, 2500, 1131.599609375, -1309.599609375, 10.300000190735 )
		setElementData( backdoor3, "state", "open" )
	end
end
addEventHandler( "onElementClicked", backdoor3_key1, medic_backdoor_func3 )
addEventHandler( "onElementClicked", backdoor3_key2, medic_backdoor_func3 )

-- Hintertor 4
local backdoor4 = createObject( 3037, 1143.2998046875, -1309.599609375, 14.857500076294, 0, 0, 270 )
local backdoor4_key1 = createObject( 2886, 1138, -1310.5, 14.39999961853, 0, 0, 0 )
local backdoor4_key2 = createObject( 2886, 1138, -1308.9000244141, 14.39999961853, 0, 0, 180 )

function medic_backdoor_func4 ( button, state, player )
	if vioGetElementData( player, "fraktion" ) ~= 10 then return end
	if getElementData( backdoor4, "moving" ) == true then return end
	setElementData( backdoor4, "moving", true )
	setTimer( setElementData, 2600, 1, backdoor4, "moving", false )
	if getElementData( backdoor4, "state" ) == "open" then
		moveObject( backdoor4, 2500, 1143.2998046875, -1309.599609375, 14.857500076294 )
		setElementData( backdoor4, "state", "closed" )
	else
		moveObject( backdoor4, 2500, 1143.2998046875, -1309.599609375, 10.300000190735 )
		setElementData( backdoor4, "state", "open" )
	end
end
addEventHandler( "onElementClicked", backdoor4_key1, medic_backdoor_func4 )
addEventHandler( "onElementClicked", backdoor4_key2, medic_backdoor_func4 )

--- Vordere Tore ---
-- Vordertor 1
local frontdoor1 = createObject( 3037, 1108.099609375, -1293.2001953125, 14.857500076294, 0, 0, 270 )
local frontdoor1_key1 = createObject( 2886, 1113.400390625, -1293.900390625, 14.39999961853, 0, 0, 0 )
local frontdoor1_key2 = createObject( 2886, 1113.400390625, -1292.2998046875, 14.39999961853, 0, 0, 180 )

function medic_frontdoor_func1 ( button, state, player )
	if vioGetElementData( player, "fraktion" ) ~= 10 then return end
	if getElementData( frontdoor1, "moving" ) == true then return end
	setElementData( frontdoor1, "moving", true )
	setTimer( setElementData, 2600, 1, frontdoor1, "moving", false )
	if getElementData( frontdoor1, "state" ) == "open" then
		moveObject( frontdoor1, 2500, 1108.099609375, -1293.2001953125, 14.857500076294 )
		setElementData( frontdoor1, "state", "closed" )
	else
		moveObject( frontdoor1, 2500, 1102.5999755859, -1293.2001953125, 14.857500076294 )
		setElementData( frontdoor1, "state", "open" )
	end
end
addEventHandler( "onElementClicked", frontdoor1_key1, medic_frontdoor_func1 )
addEventHandler( "onElementClicked", frontdoor1_key2, medic_frontdoor_func1 )

-- Vordertor 2
local frontdoor2 = createObject( 3037, 1119.7998046875, -1293.2001953125, 14.857500076294, 0, 0, 270 )
local frontdoor2_key1 = createObject( 2886, 1125.2001953125, -1293.900390625, 14.39999961853, 0, 0, 0 )
local frontdoor2_key2 = createObject( 2886, 1125.2001953125, -1292.2998046875, 14.39999961853, 0, 0, 180 )

function medic_frontdoor_func2 ( button, state, player )
	if vioGetElementData( player, "fraktion" ) ~= 10 then return end
	if getElementData( frontdoor2, "moving" ) == true then return end
	setElementData( frontdoor2, "moving", true )
	setTimer( setElementData, 2600, 1, frontdoor2, "moving", false )
	if getElementData( frontdoor2, "state" ) == "open" then
		moveObject( frontdoor2, 2500, 1119.7998046875, -1293.2001953125, 14.857500076294 )
		setElementData( frontdoor2, "state", "closed" )
	else
		moveObject( frontdoor2, 2500, 1119.7998046875, -1293.2001953125, 10.300000190735 )
		setElementData( frontdoor2, "state", "open" )
	end
end
addEventHandler( "onElementClicked", frontdoor2_key1, medic_frontdoor_func2 )
addEventHandler( "onElementClicked", frontdoor2_key2, medic_frontdoor_func2 )

-- Vordertor 3
local frontdoor3 = createObject( 3037, 1131.599609375, -1293.2001953125, 14.857500076294, 0, 0, 270 )
local frontdoor3_key1 = createObject( 2886, 1126.2001953125, -1293.900390625, 14.39999961853, 0, 0, 0 )
local frontdoor3_key2 = createObject( 2886, 1126.2001953125, -1292.2998046875, 14.39999961853, 0, 0, 180 )

function medic_frontdoor_func3 ( button, state, player )
	if vioGetElementData( player, "fraktion" ) ~= 10 then return end
	if getElementData( frontdoor3, "moving" ) == true then return end
	setElementData( frontdoor3, "moving", true )
	setTimer( setElementData, 2600, 1, frontdoor3, "moving", false )
	if getElementData( frontdoor3, "state" ) == "open" then
		moveObject( frontdoor3, 2500, 1131.599609375, -1293.2001953125, 14.857500076294 )
		setElementData( frontdoor3, "state", "closed" )
	else
		moveObject( frontdoor3, 2500, 1131.599609375, -1293.2001953125, 10.300000190735 )
		setElementData( frontdoor3, "state", "open" )
	end
end
addEventHandler( "onElementClicked", frontdoor3_key1, medic_frontdoor_func3 )
addEventHandler( "onElementClicked", frontdoor3_key2, medic_frontdoor_func3 )

-- Vordertor 4
local frontdoor4 = createObject( 3037, 1143.2998046875, -1293.2001953125, 14.857500076294, 0, 0, 270 )
local frontdoor4_key1 = createObject( 2886, 1138, -1293.900390625, 14.39999961853, 0, 0, 0 )
local frontdoor4_key2 = createObject( 2886, 1138, -1292.2998046875, 14.39999961853, 0, 0, 180 )

function medic_frontdoor_func4 ( button, state, player )
	if vioGetElementData( player, "fraktion" ) ~= 10 then return end
	if getElementData( frontdoor4, "moving" ) == true then return end
	setElementData( frontdoor4, "moving", true )
	setTimer( setElementData, 2600, 1, frontdoor4, "moving", false )
	if getElementData( frontdoor4, "state" ) == "open" then
		moveObject( frontdoor4, 2500, 1143.2998046875, -1293.2001953125, 14.857500076294 )
		setElementData( frontdoor4, "state", "closed" )
	else
		moveObject( frontdoor4, 2500, 1143.2998046875, -1293.2001953125, 10.300000190735 )
		setElementData( frontdoor4, "state", "open" )
	end
end
addEventHandler( "onElementClicked", frontdoor4_key1, medic_frontdoor_func4 )
addEventHandler( "onElementClicked", frontdoor4_key2, medic_frontdoor_func4 )






