


function getSozialStatus(thePlayer,show)
	if(not show)then
		show=false
	end
	
	local sozialTable={}
	--GrundStatus
	local sozial=1
	table.insert(sozialTable,{"Grundstatus","+1","green"})
	
	--Fraktion
	if(vioGetElementData(thePlayer,"fraktion")>0)then
		sozial=sozial+1
		table.insert(sozialTable,{"Ist in einer Fraktion","+1","green"})
		sozial=sozial+vioGetElementData(thePlayer,"fraktionsrang")
		if(vioGetElementData(thePlayer,"fraktionsrang")<5)then
			table.insert(sozialTable,{"Fraktionsrang","+"..vioGetElementData(thePlayer,"fraktionsrang"),"gelb"})
		else
			table.insert(sozialTable,{"Fraktionsrang","+"..vioGetElementData(thePlayer,"fraktionsrang"),"green"})
		end
	else
		table.insert(sozialTable,{"Ist in einer Fraktion","+0","red"})	
		table.insert(sozialTable,{"Fraktionsrang","+0","red"})	
	end
	
	--Job
	if(vioGetElementData(thePlayer,"job")>0)then
		sozial=sozial+1
		table.insert(sozialTable,{"Hat einen Job","+1","green"})
		
	else
		table.insert(sozialTable,{"Ist in einer Fraktion","+0","red"})	
	end
	
	local jobskillsum=vioGetElementData(thePlayer,"meeresSkill")
		jobskillsum	=jobskillsum + vioGetElementData(thePlayer,"bergWerkSkill")
		jobskillsum =jobskillsum + vioGetElementData(thePlayer,"farmerSkill")
		jobskillsum =jobskillsum + vioGetElementData(thePlayer,"fischSkill")
		jobskillsum =jobskillsum + vioGetElementData(thePlayer,"busSkill")
		jobskillsum =jobskillsum + vioGetElementData(thePlayer,"muellSkill")
		jobskillsum =jobskillsum + vioGetElementData(thePlayer,"pizzaSkill")
		jobskillsum =jobskillsum + vioGetElementData(thePlayer,"truckSkill")
		jobskillsum =jobskillsum + vioGetElementData(thePlayer,"flyersSkill")
		jobskillsum =jobskillsum + vioGetElementData(thePlayer,"sweeperSkill")
	sozial=sozial+math.round(jobskillsum/10)
	if(jobskillsum>0)then
		if(math.round(jobskillsum/10)<5)then
			table.insert(sozialTable,{"Durchschnittsskilllevel","+"..math.round(jobskillsum/10),"gelb"})
		else
			table.insert(sozialTable,{"Durchschnittsskilllevel","+"..math.round(jobskillsum/10),"green"})
		end
	else
		table.insert(sozialTable,{"Durchschnittsskilllevel","+"..math.round(jobskillsum/10),"red"})
	end
	
	--Haus
	if(vioGetElementData(thePlayer,"hkey")~=0)then
		table.insert(sozialTable,{"Ist nicht obdachlos","+1","green"})
		sozial=sozial+1
	else
		table.insert(sozialTable,{"Ist nicht obdachlos","+0","red"})	
	end
	
	if(vioGetElementData(thePlayer,"hkey")>0)then
		table.insert(sozialTable,{"Besitzt ein Haus","+1","green"})
		sozial=sozial+1
	else
		table.insert(sozialTable,{"Besitzt ein Haus","+0","red"})	
		table.insert(sozialTable,{"Haus hat einen Wert über 10000$","+0","red"})	
		table.insert(sozialTable,{"Haus hat einen Wert über 100000$","+0","red"})	
		table.insert(sozialTable,{"Haus hat einen Wert über 500000$","+0","red"})	
		table.insert(sozialTable,{"Haus hat einen Wert über 1000000$","+0","red"})		
	end
	local hkey=vioGetElementData(thePlayer,"hkey")
	if(hkey>0)then
		local haus=haeuser[hkey]
		if(haus:getPreis()>10000-1)or((haus:getCity())==3)then
			sozial=sozial+1
			table.insert(sozialTable,{"Haus hat einen Wert über 10000$","+1","green"})
		else
			table.insert(sozialTable,{"Haus hat einen Wert über 10000$","+0","red"})		
		end		
		if(haus:getPreis()>100000-1)or((haus:getCity())==3)then
			sozial=sozial+1
			table.insert(sozialTable,{"Haus hat einen Wert über 100000$","+1","green"})
		else
			table.insert(sozialTable,{"Haus hat einen Wert über 100000$","+0","red"})		
		end	
		if(haus:getPreis()>500000-1)or((haus:getCity())==3)then
			sozial=sozial+1
			table.insert(sozialTable,{"Haus hat einen Wert über 500000$","+1","green"})
		else
			table.insert(sozialTable,{"Haus hat einen Wert über 500000$","+0","red"})		
		end	
		if(haus:getPreis()>1000000-1)then
			sozial=sozial+1
			table.insert(sozialTable,{"Haus hat einen Wert über 1000000$","+1","green"})
		else
			table.insert(sozialTable,{"Haus hat einen Wert über 1000000$","+0","red"})		
		end	
	end
	
	--Buissness
	if(vioGetElementData(thePlayer,"bizKey")~=0)then
		sozial=sozial+2
		table.insert(sozialTable,{"Besitzt ein Buissness","+2","green"})
	else
		table.insert(sozialTable,{"Besitzt ein Buissness","+0","red"})		
	end	
	
	--Prestige
	if(vioGetElementData(thePlayer,"prestigeKey")~=0)then
		sozial=sozial+3
		table.insert(sozialTable,{"Besitzt ein Prestigeobjekt","+3","green"})
	else
		table.insert(sozialTable,{"Besitzt ein Prestigeobjekt","+0","red"})		
	end	

	--Premium	
	if(vioGetElementData(thePlayer,"premium")>0)then
		sozial=sozial+1
		table.insert(sozialTable,{"Hat Premium","+1","green"})
	else
		table.insert(sozialTable,{"Hat Premium","+0","red"})		
	end	
	
	
	--Admin	
	if(vioGetElementData(thePlayer,"SupportLVL")>0)then
		sozial=sozial+2
		table.insert(sozialTable,{"Ist Supporter","+2","green"})
	end
	if(isAdminLevel(thePlayer,1))then
		sozial=sozial+2+vioGetElementData(thePlayer,"adminlvl")
		table.insert(sozialTable,{"Ist Moderationsteam","+"..(2+vioGetElementData(thePlayer,"adminlvl")),"green"})
	end
	
	return sozial,sozialTable
	
end



function showSozialStatus(thePlayer)
	local gesamt, statustable= getSozialStatus (thePlayer)
	triggerClientEvent(thePlayer,"showsocial_event",thePlayer,gesamt,statustable)

end
addCommandHandler("sozial",showSozialStatus,false,false)
addCommandHandler("social",showSozialStatus,false,false)








