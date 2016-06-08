function save_data()
	
		local nickname=getPlayerName(source)
		if(nickname)then
		if(isPlayerLoggedIn(source))then
		
	outputDebugString("Start Saveing User Data ["..nickname.."]")
		
		local setTable={}
		
		--rechte
		setTable["rechte"]={}
		setTable["rechte"]["AllLeader"]=vioGetElementData(source,"rechte_AllLeader")
		
		--Userdata
		setTable["userdata"]={}
		setTable["userdata"]["Spawn"]=vioGetElementData(source,"spawnplace")
		setTable["userdata"]["PremiumSpawn"]=vioGetElementData(source,"PremiumSpawn") 
		if(vioGetElementData(source,"skinid")~='')then		
			setTable["userdata"]["Skin"]=vioGetElementData(source,"skinid")
		end
		setTable["userdata"]["Fraktion"]=vioGetElementData(source,"fraktion")
		setTable["userdata"]["Fraktionsrang"]=vioGetElementData(source,"fraktionsrang")
		setTable["userdata"]["Tode"]=vioGetElementData(source,"tode")
		setTable["userdata"]["TodZeit"]=vioGetElementData(source,"todezeit")
		setTable["userdata"]["TodeLast"]=vioGetElementData(source,"todelast")
		setTable["userdata"]["PlayTime"]=vioGetElementData(source,"playtime")
		setTable["userdata"]["Bank"]=getPlayerBank(source)
		setTable["userdata"]["Geld"]=getPlayerMoney(source)
		setTable["userdata"]["paydaygehalt"]=vioGetElementData(source,"addPayDayGehalt")
		setTable["userdata"]["tbans"]=vioGetElementData(source,"tbans")
		setTable["userdata"]["stvoFreePayDays"]=vioGetElementData(source,"stvoFreePayDays")
		if(vioGetElementData(source,"FrakSkin")~='')then
			setTable["userdata"]["FrakSkin"]=vioGetElementData(source,"FrakSkin")
		end
		setTable["userdata"]["verheiratet"]=vioGetElementData(source,"verheiratet")
		setTable["userdata"]["schutzgeld"]=vioGetElementData(source,"schutzgeld")
		setTable["userdata"]["Hufeisen"]=vioGetElementData(source,"Hufeisen")
		setTable["userdata"]["ueberweisungssumme"]=vioGetElementData(source,"ueberweisungssumme")		
		setTable["userdata"]["versicherung"]=vioGetElementData(source,"versicherung")
		setTable["userdata"]["lebensversicherung"]=vioGetElementData(source,"lebensversicherung")
		setTable["userdata"]["speedtank"]=vioGetElementData(source,"speedtank")
		setTable["userdata"]["Job"]=vioGetElementData(source,"job")
		setTable["userdata"]["Telefonnummer"]=vioGetElementData(source,"telefon")		
		setTable["userdata"]["Wanteds"]=vioGetElementData(source,"wanteds")
		-- setTable["userdata"]["Warn"]=vioGetElementData(source,"warn")
		setTable["userdata"]["Stvo"]=vioGetElementData(source,"stvo")
		setTable["userdata"]["Knastzeit"]=vioGetElementData(source,"knastzeit")
		setTable["userdata"]["lastKnastzeit"]=vioGetElementData(source,"lastknastzeit")
		setTable["userdata"]["Kaution"]=vioGetElementData(source,"kaution")		
		setTable["userdata"]["VehSlots"]=vioGetElementData(source,"maxslots")
		setTable["userdata"]["tutorial_gui"]=vioGetElementData(source,"tut")
		setTable["userdata"]["fisheslasthour"]=vioGetElementData(source,"fisheslasthour")
		setTable["userdata"]["newhkey"]=vioGetElementData(source,"hkey")
		setTable["userdata"]["prestigeKey"]=vioGetElementData(source,"prestigeKey")
		setTable["userdata"]["kopfgeld"]=vioGetElementData(source,"kopfgeld")
		setTable["userdata"]["bizKey"]=vioGetElementData(source,"bizKey")
		setTable["userdata"]["ingamespenden"]=vioGetElementData(source,"ingamespenden")
		setTable["userdata"]["alkaknast"]=vioGetElementData(source,"alkaknast")
		setTable["userdata"]["mussAlka"]=vioGetElementData(source,"mussAlka")
		
		--lizensen
		
		setTable["lizensen"]={}
		
		setTable["lizensen"]["autoLic"]=vioGetElementData(source,"autoLic")		
		setTable["lizensen"]["truckLic"]=vioGetElementData(source,"truckLic")		
		setTable["lizensen"]["planeLic"]=vioGetElementData(source,"planeLic")		
		setTable["lizensen"]["bikeLic"]=vioGetElementData(source,"bikeLic")		
		setTable["lizensen"]["heliLic"]=vioGetElementData(source,"heliLic")		
		setTable["lizensen"]["boatLic"]=vioGetElementData(source,"boatLic")
		setTable["lizensen"]["lastautoLic"]=vioGetElementData(source,"lastautoLic")
		setTable["lizensen"]["lasttruckLic"]=vioGetElementData(source,"lasttruckLic")
		setTable["lizensen"]["lastplaneLic"]=vioGetElementData(source,"lastplaneLic")
		setTable["lizensen"]["lastbikeLic"]=vioGetElementData(source,"lastbikeLic")
		setTable["lizensen"]["lastheliLic"]=vioGetElementData(source,"lastheliLic")
		setTable["lizensen"]["quadLic"]=vioGetElementData(source,"quadLic")
		setTable["lizensen"]["sonstigeLic"]=vioGetElementData(source,"sonstigeLic")
		setTable["lizensen"]["waffenLic"]=vioGetElementData(source,"waffenLic")
		setTable["lizensen"]["reiseLic"]=vioGetElementData(source,"reiseLic")
		setTable["lizensen"]["angelLic"]=vioGetElementData(source,"angelLic")
		setTable["lizensen"]["persoLic"]=vioGetElementData(source,"persoLic")
			
		--inventar
		
		setTable["inventar"]={}
		
		setTable["inventar"]["Benzinkanister"]=vioGetElementData(source,"kanister")
		setTable["inventar"]["Lotto"]=vioGetElementData(source,"lotto")
		setTable["inventar"]["Lottoschein"]=vioGetElementData(source,"lottoschein")
		setTable["inventar"]["Rubbellos"]=vioGetElementData(source,"rubbellos")
		setTable["inventar"]["Drogen"]=vioGetElementData(source,"drogen")
		setTable["inventar"]["Snack"]=vioGetElementData(source,"snack")
		setTable["inventar"]["Hamburger"]=vioGetElementData(source,"hamburger")
		setTable["inventar"]["Fertigessen"]=vioGetElementData(source,"fertigessen")
		setTable["inventar"]["Schnellhilfe"]=vioGetElementData(source,"schnellhilfe")
		setTable["inventar"]["CarFinder"]=vioGetElementData(source,"carfinder")
		setTable["inventar"]["Materials"]=vioGetElementData(source,"mats")		
		setTable["inventar"]["UseCarFinder"]=vioGetElementData(source,"usecarfinder")
		setTable["inventar"]["Hufeisenhelfer"]=vioGetElementData(source,"Hufeisenhelfer")
		setTable["inventar"]["geschenk"]=vioGetElementData(source,"geschenk")
		setTable["inventar"]["terralapptapp"]=vioGetElementData(source,"terralapptapp")
		setTable["inventar"]["tachodig_addon"]=vioGetElementData(source,"tachodig_addon")
		setTable["inventar"]["Kondome"]=vioGetElementData(source,"Kondome")
		setTable["inventar"]["adgutscheine"]=vioGetElementData(source,"adgutscheine")
		setTable["inventar"]["adaktiv"]=vioGetElementData(source,"adaktiv")
		setTable["inventar"]["dice"]=vioGetElementData(source,"dice")
		setTable["inventar"]["blutmesser"]=vioGetElementData(source,"blutmesser")


		--jobskills
		
		setTable["jobskills"]={}
		
		setTable["jobskills"]["fischSkill"]=vioGetElementData(source,"fischSkill")
		setTable["jobskills"]["fischSkillPoints"]=vioGetElementData(source,"fischSkillPoints")
		setTable["jobskills"]["busSkill"]=vioGetElementData(source,"busSkill")
		setTable["jobskills"]["busSkillPoints"]=vioGetElementData(source,"busSkillPoints")
		setTable["jobskills"]["muellSkill"]=vioGetElementData(source,"muellSkill")
		setTable["jobskills"]["muellSkillPoints"]=vioGetElementData(source,"muellSkillPoints")
		setTable["jobskills"]["pizzaSkill"]=vioGetElementData(source,"pizzaSkill")
		setTable["jobskills"]["pizzaSkillPoints"]=vioGetElementData(source,"pizzaSkillPoints")
		setTable["jobskills"]["truckSkill"]=vioGetElementData(source,"truckSkill")
		setTable["jobskills"]["truckSkillPoints"]=vioGetElementData(source,"truckSkillPoints")
		setTable["jobskills"]["farmerSkill"]=vioGetElementData(source,"farmerSkill")
		setTable["jobskills"]["farmerSkillPoints"]=vioGetElementData(source,"farmerSkillPoints")
		setTable["jobskills"]["flyersSkill"]=vioGetElementData(source,"flyersSkill")
		setTable["jobskills"]["flyersSkillPoints"]=vioGetElementData(source,"flyersSkillPoints")
		setTable["jobskills"]["sweeperSkill"]=vioGetElementData(source,"sweeperSkill")
		setTable["jobskills"]["sweeperSkillPoints"]=vioGetElementData(source,"sweeperSkillPoints")
		setTable["jobskills"]["bergWerksSkill"]=vioGetElementData(source,"bergWerkSkill")
		setTable["jobskills"]["bergWerkSkillPoints"]=vioGetElementData(source,"bergWerkSkillPoints")
		setTable["jobskills"]["meeresSkill"]=vioGetElementData(source,"meeresSkill")
		setTable["jobskills"]["meeresSkillPoints"]=vioGetElementData(source,"meeresSkillPoints")		
		
		
		---archivments
		
		
		setTable["archievments"]={}
		
		setTable["archievments"]["Erfolg_Fischermeister"]=vioGetElementData(source,"Erfolg_Fischermeister")	
		setTable["archievments"]["Punkte_Fischermeister"]=vioGetElementData(source,"Punkte_Fischermeister")
    setTable["archievments"]["Punkte_Busmeister"]=vioGetElementData(source,"Punkte_Busmeister")
		setTable["archievments"]["Erfolg_MrLicenses"]=vioGetElementData(source,"Erfolg_MrLicenses")	
		setTable["archievments"]["Erfolg_First_50"]=vioGetElementData(source,"Erfolg_First_50")	
		setTable["archievments"]["Erfolg_First_100"]=vioGetElementData(source,"Erfolg_First_100")	
		setTable["archievments"]["Erfolg_First_1000"]=vioGetElementData(source,"Erfolg_First_1000")	
		setTable["archievments"]["Erfolg_10erFahrzeugrausch"]=vioGetElementData(source,"Erfolg_10erFahrzeugrausch")
		setTable["archievments"]["Erfolg_20erFahrzeugrausch"]=vioGetElementData(source,"Erfolg_20erFahrzeugrausch")
		setTable["archievments"]["Erfolg_50erFahrzeugrausch"]=vioGetElementData(source,"Erfolg_50erFahrzeugrausch")
		setTable["archievments"]["Erfolg_Busmeister"]=vioGetElementData(source,"Erfolg_Busmeister")
		setTable["archievments"]["Punkte_Busmeister"]=vioGetElementData(source,"Punkte_Busmeister")
		setTable["archievments"]["Erfolg_Lotto1"]=vioGetElementData(source,"Erfolg_Lotto1")
		setTable["archievments"]["Erfolg_Lotto2"]=vioGetElementData(source,"Erfolg_Lotto2")
		setTable["archievments"]["Erfolg_Lotto3"]=vioGetElementData(source,"Erfolg_Lotto3")
		setTable["archievments"]["Erfolg_Rubbellosgluck"]=vioGetElementData(source,"Erfolg_Rubbellosgluck")
		setTable["archievments"]["Erfolg_10erLos"]=vioGetElementData(source,"Erfolg_10erLos")
		setTable["archievments"]["Erfolg_Benzin_leer"]=vioGetElementData(source,"Erfolg_Benzin_leer")
		setTable["archievments"]["Erfolg_Mein_erstes_Geld"]=vioGetElementData(source,"Erfolg_Mein_erstes_Geld")
		setTable["archievments"]["Erfolg_MyOwnHome"]=vioGetElementData(source,"Erfolg_MyOwnHome")
		setTable["archievments"]["Erfolg_MyOwnBiz"]=vioGetElementData(source,"Erfolg_MyOwnBiz")
		setTable["archievments"]["Erfolg_Autoeinsteiger"]=vioGetElementData(source,"Erfolg_Autoeinsteiger")
		setTable["archievments"]["Erfolg_Mein_erstes_Brot"]=vioGetElementData(source,"Erfolg_Mein_erstes_Brot")
		setTable["archievments"]["Erfolg_Ersatztanke"]=vioGetElementData(source,"Erfolg_Ersatztanke")
		setTable["archievments"]["Erfolg_Fraktionseinsteiger"]=vioGetElementData(source,"Erfolg_Fraktionseinsteiger")
		setTable["archievments"]["Erfolg_10Hufeisen"]=vioGetElementData(source,"Erfolg_10Hufeisen")
		setTable["archievments"]["Erfolg_100Hufeisen"]=vioGetElementData(source,"Erfolg_100Hufeisen")
		setTable["archievments"]["Erfolg_1000Hufeisen"]=vioGetElementData(source,"Erfolg_1000Hufeisen")
		setTable["archievments"]["Erfolg_Meisterpilot"]=vioGetElementData(source,"Erfolg_Meisterpilot")
		setTable["archievments"]["Punkte_Meisterpilot"]=vioGetElementData(source,"Punkte_Meisterpilot")
		setTable["archievments"]["Punkte_Meistertrucker"]=vioGetElementData(source,"Punkte_Meistertrucker")
		setTable["archievments"]["Erfolg_Meistertrucker"]=vioGetElementData(source,"Erfolg_Meistertrucker")
		setTable["archievments"]["Erfolg_KMPokal"]=vioGetElementData(source,"Erfolg_KMPokal")
		setTable["archievments"]["Erfolg_TerraFriend"]=vioGetElementData(source,"Erfolg_TerraFriend")
		setTable["archievments"]["Erfolg_Millionaer"]=vioGetElementData(source,"Erfolg_Millionaer")
        setTable["archievments"]["Erfolg_Strassenreiniger"]=vioGetElementData(source,"Erfolg_Strassenreiniger")
        setTable["archievments"]["Punkte_Strassenreiniger"]=vioGetElementData(source,"Punkte_Strassenreiniger")
        setTable["archievments"]["Erfolg_Meeresreiniger"]=vioGetElementData(source,"Erfolg_Meeresreiniger")
        setTable["archievments"]["Punkte_Meeresreiniger"]=vioGetElementData(source,"Punkte_Meeresreiniger")
        setTable["archievments"]["Erfolg_Muellsammler"]=vioGetElementData(source,"Erfolg_Muellsammler")
        setTable["archievments"]["Punkte_Muellsammler"]=vioGetElementData(source,"Punkte_Muellsammler")
        setTable["archievments"]["Erfolg_Pizzaraser"]=vioGetElementData(source,"Erfolg_Pizzaraser")
        setTable["archievments"]["Punkte_Pizzaraser"]=vioGetElementData(source,"Punkte_Pizzaraser")
        setTable["archievments"]["Erfolg_Farmerjunge"]=vioGetElementData(source,"Erfolg_Farmerjunge")
        setTable["archievments"]["Punkte_Farmerjunge"]=vioGetElementData(source,"Punkte_Farmerjunge")
        setTable["archievments"]["Erfolg_Steinraeumer"]=vioGetElementData(source,"Erfolg_Steinraeumer")
        setTable["archievments"]["Punkte_Steinraeumer"]=vioGetElementData(source,"Punkte_Steinraeumer")
        setTable["archievments"]["Erfolg_Langlaeufer"]=vioGetElementData(source,"Erfolg_Langlaeufer")
        setTable["archievments"]["Punkte_Langlaeufer"]=vioGetElementData(source,"Punkte_Langlaeufer")
        setTable["archievments"]["Erfolg_Rekordschwimmer"]=vioGetElementData(source,"Erfolg_Rekordschwimmer")
        setTable["archievments"]["Punkte_Rekordschwimmer"]=vioGetElementData(source,"Punkte_Rekordschwimmer")


		-- NAME 
		setTable["zeugnis"]={}
		
		setTable["zeugnis"]["NAME_orientierung"]=vioGetElementData(source,"NAME_orientierung")
		setTable["zeugnis"]["NAME_theorie_Beamte"]=vioGetElementData(source,"NAME_theorie_Beamte")
		setTable["zeugnis"]["NAME_Gelaendefahr"]=vioGetElementData(source,"NAME_Gelaendefahr")
		setTable["zeugnis"]["NAME_sozial"]=vioGetElementData(source,"NAME_sozial")
		setTable["zeugnis"]["NAME_Waffenumgang"]=vioGetElementData(source,"NAME_Waffenumgang")
		setTable["zeugnis"]["NAME_spezFahrtest"]=vioGetElementData(source,"NAME_spezFahrtest")
		setTable["zeugnis"]["NAME_Strategisch"]=vioGetElementData(source,"NAME_Strategisch")
		setTable["zeugnis"]["NAME_praktisch_Beamte"]=vioGetElementData(source,"NAME_praktisch_Beamte")
		setTable["zeugnis"]["refresh"]=vioGetElementData(source,"NAME_refresh")
					
		-- OnlineSchutz
		setTable["terratapps"] = {}
		setTable["terratapps"]["OnlineSchutzUntil"] = vioGetElementData(source, "onlineschutzuntil")
		
		
	 	-- debug.print(setTable)
	 		
		for tablename, tableset in pairs(setTable)do
			local setString=""
			for theKey,theValue in pairs(tableset)do
				if(theValue)then
					setString=setString..", "..theKey.." ='"..theValue.."'"		
				end
			end	
			setString=string.sub(setString,3)
			local query="UPDATE "..tablename.." SET "..setString.." WHERE Nickname='"..getPlayerName(source).."'"
			mysql_query(handler,query)
		end
	 	

		    --outputServerLog(nickname.."'s Daten wurden gespeichert")
		
	        outputDebugString("User Data ["..nickname.."] saved")
		end
    end



end

addEvent("SaveMyData",true)
addEventHandler("SaveMyData",getRootElement(), save_data)










