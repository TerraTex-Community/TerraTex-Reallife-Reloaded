

function Mysql_aktualize_func()
	local antwort=false
	local abfquery="SELECT * FROM `newtables`"
	antwort=mysql_query(handler,abfquery)
	outputDebugString("Copyentries: "..mysql_num_rows(antwort))
	loadInsert=0
	

	while(loadInsert<mysql_num_rows(antwort))do
		dasatz = mysql_fetch_assoc(antwort)
		tablename_akt=dasatz["tablename"]
		newNameSpalte_akt=dasatz["newNameSpalte"]
		outputDebugString("Start Copy TO "..tablename_akt.." named "..newNameSpalte_akt)
		local query="SELECT Nickname FROM players"
		local reha=mysql_query(handler,query)
		local n=0
		while (n<mysql_num_rows(reha)) do
			local dsatz = mysql_fetch_assoc(reha)
			local newquery="INSERT INTO "..tablename_akt.." ("..newNameSpalte_akt..") VALUES ('"..dsatz["Nickname"].."')"
			--outputDebugString(newquery)
			local resultre=mysql_query(handler,newquery)
			mysql_free_result (resultre)
			n=n+1
		end	
		mysql_free_result(reha)
		outputDebugString("COPIED TO "..tablename_akt.." named "..newNameSpalte_akt)
		local delquery="DELETE FROM newtables WHERE ID='"..dasatz["ID"].."'"
		local resultre=mysql_query(handler,delquery)
		mysql_free_result (resultre)
		loadInsert=loadInsert+1
	end
	mysql_free_result(antwort)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),Mysql_aktualize_func)








