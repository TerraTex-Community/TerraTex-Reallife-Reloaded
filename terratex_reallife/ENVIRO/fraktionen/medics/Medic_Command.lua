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









