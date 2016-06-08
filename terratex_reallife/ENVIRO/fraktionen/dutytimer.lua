dutytimer_table={}
local duty_datum=""
local dailytimestamp=0

function dutytimer_init()
	setTimer(dutytimer_saveToDB,7200000,0)
	setTimer(dutytimer_calculate,300000,0)
	local time=getRealTime()
	dailytimestamp=time.timestamp
	duty_datum=(time.year+1900).."-"..(time.month+1).."-"..time.monthday
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),dutytimer_init)

function dutytimer_saveToDB()
	outputDebugString("Started Duty Saving")
		local values="";
		local data=0
		for thePlayerName,thePlayerTable in pairs(dutytimer_table) do		
			values=values..",('"..duty_datum.."','"..thePlayerName.."',"..dailytimestamp..","..thePlayerTable["playtime"]..","..thePlayerTable["dutycops"]..","..thePlayerTable["idcops"]..","..thePlayerTable["dutymedic"]..","..thePlayerTable["dutytaxi"]..","..thePlayerTable["idname"]..")"
			data=data+1
		end
		if(data>0)then
			values=string.sub(values,2)
			local query="INSERT INTO dutycounter (datum,Nickname,timestamp,online,dutycops,idcops,dutymedic,dutytaxi,idname) VALUES "..values.." ON DUPLICATE KEY UPDATE online=online+VALUES(online),dutycops=dutycops+VALUES(dutycops),idcops=idcops+VALUES(idcops),dutymedic=dutymedic+VALUES(dutymedic),dutytaxi=dutytaxi+VALUES(dutytaxi),idname=idname+VALUES(idname);"
			mysql_query(handler,query)
		end
		
	outputDebugString("Dutys were saved!")
end
addEventHandler("onResourceStop",getResourceRootElement(getThisResource()),dutytimer_saveToDB)

function dutytimer_calculate()
	if(table.getn(getElementsByType("player"))>25)then
		for theKey, thePlayer in ipairs(getElementsByType("player"))do
			if(vioGetElementData(thePlayer,"afk_status"))then	
				if(vioGetElementData(thePlayer,"afk_status")==0)then		
					local nickname=getPlayerName(thePlayer)
					if(vioGetElementData(thePlayer,"fraktion"))then
						if(vioGetElementData(thePlayer,"fraktion")==1)then -- cops
							if(not(dutytimer_table[nickname]))then
								dutytimer_table[nickname]={
									["playtime"]=0,
									["idcops"]=0,
									["dutycops"]=0,
									["dutymedic"]=0,
									["dutytaxi"]=0,
									["idname"]=0
								}
							end
							dutytimer_table[nickname]["playtime"]=dutytimer_table[nickname]["playtime"]+5
							if(vioGetElementData(thePlayer,"Innendienst"))then
								dutytimer_table[nickname]["idcops"]=dutytimer_table[nickname]["idcops"]+5					
							end
							if(vioGetElementData(thePlayer,"isCopDuty"))then
								dutytimer_table[nickname]["dutycops"]=dutytimer_table[nickname]["dutycops"]+5					
							end	
						elseif(vioGetElementData(thePlayer,"fraktion")==5)then -- SEK
							if(not(dutytimer_table[nickname]))then
								dutytimer_table[nickname]={
									["playtime"]=0,
									["idcops"]=0,
									["dutycops"]=0,
									["dutymedic"]=0,
									["dutytaxi"]=0,
									["idname"]=0
								}
							end
							dutytimer_table[nickname]["playtime"]=dutytimer_table[nickname]["playtime"]+5
							if(vioGetElementData(thePlayer,"Innendienst"))then
								dutytimer_table[nickname]["idcops"]=dutytimer_table[nickname]["idcops"]+5					
							end
							if(vioGetElementData(thePlayer,"isCopDuty"))then
								dutytimer_table[nickname]["dutycops"]=dutytimer_table[nickname]["dutycops"]+5					
							end			
						elseif(vioGetElementData(thePlayer,"fraktion")==7)then -- cops
							if(not(dutytimer_table[nickname]))then
								dutytimer_table[nickname]={
									["playtime"]=0,
									["idcops"]=0,
									["dutycops"]=0,
									["dutymedic"]=0,
									["dutytaxi"]=0,
									["idname"]=0
								}
							end
							dutytimer_table[nickname]["playtime"]=dutytimer_table[nickname]["playtime"]+5
							if(vioGetElementData(thePlayer,"Innendienst"))then
								dutytimer_table[nickname]["idname"]=dutytimer_table[nickname]["idname"]+5					
							end			
						elseif(vioGetElementData(thePlayer,"fraktion")==10)then --Medics
							if(not(dutytimer_table[nickname]))then
								dutytimer_table[nickname]={
									["playtime"]=0,
									["idcops"]=0,
									["dutycops"]=0,
									["dutymedic"]=0,
									["dutytaxi"]=0,
									["idname"]=0
								}
							end
							dutytimer_table[nickname]["playtime"]=dutytimer_table[nickname]["playtime"]+5
							if(vioGetElementData(thePlayer,"isMedicDuty"))then
								dutytimer_table[nickname]["dutymedic"]=dutytimer_table[nickname]["dutymedic"]+5					
							end	
						elseif(vioGetElementData(thePlayer,"fraktion")==4)then --taxi
							if(not(dutytimer_table[nickname]))then
								dutytimer_table[nickname]={
									["playtime"]=0,
									["idcops"]=0,
									["dutycops"]=0,
									["dutymedic"]=0,
									["dutytaxi"]=0,
									["idname"]=0
								}
							end
							dutytimer_table[nickname]["playtime"]=dutytimer_table[nickname]["playtime"]+5
							if(vioGetElementData(thePlayer,"taxi_duty"))then
								dutytimer_table[nickname]["dutytaxi"]=dutytimer_table[nickname]["dutytaxi"]+5					
							end	
						end	
					end
				end
			end
		end
	end
	--debug.print(dutytimer_table)
end








