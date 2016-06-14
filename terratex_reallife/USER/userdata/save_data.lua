function save_data()

    local nickname = getPlayerName(source)
    if (nickname) then
        if (isPlayerLoggedIn(source)) then

            outputDebugString("Start Saveing User Data [" .. nickname .. "]")

            local setTable = {}

            --rechte
            setTable["faction_userrights"] = {}
            setTable["faction_userrights"]["AllLeader"] = vioGetElementData(source, "rechte_AllLeader")

            --Userdata
            setTable["user_data"] = {}
            setTable["user_data"]["Spawn"] = vioGetElementData(source, "spawnplace")
            setTable["user_data"]["PremiumSpawn"] = vioGetElementData(source, "PremiumSpawn")
            if (vioGetElementData(source, "skinid") ~= '') then
                setTable["user_data"]["Skin"] = vioGetElementData(source, "skinid")
            end
            setTable["user_data"]["Fraktion"] = vioGetElementData(source, "fraktion")
            setTable["user_data"]["Fraktionsrang"] = vioGetElementData(source, "fraktionsrang")
            setTable["user_data"]["Tode"] = vioGetElementData(source, "tode")
            setTable["user_data"]["TodZeit"] = vioGetElementData(source, "todezeit")
            setTable["user_data"]["TodeLast"] = vioGetElementData(source, "todelast")
            setTable["user_data"]["PlayTime"] = vioGetElementData(source, "playtime")
            setTable["user_data"]["Bank"] = getPlayerBank(source)
            setTable["user_data"]["Geld"] = getPlayerMoney(source)
            setTable["user_data"]["paydaygehalt"] = vioGetElementData(source, "addPayDayGehalt")
            setTable["user_data"]["tbans"] = vioGetElementData(source, "tbans")
            setTable["user_data"]["stvoFreePayDays"] = vioGetElementData(source, "stvoFreePayDays")
            if (vioGetElementData(source, "FrakSkin") ~= '') then
                setTable["user_data"]["FrakSkin"] = vioGetElementData(source, "FrakSkin")
            end
            setTable["user_data"]["verheiratet"] = vioGetElementData(source, "verheiratet")
            setTable["user_data"]["schutzgeld"] = vioGetElementData(source, "schutzgeld")
            setTable["user_data"]["Hufeisen"] = vioGetElementData(source, "Hufeisen")
            setTable["user_data"]["ueberweisungssumme"] = vioGetElementData(source, "ueberweisungssumme")
            setTable["user_data"]["versicherung"] = vioGetElementData(source, "versicherung")
            setTable["user_data"]["lebensversicherung"] = vioGetElementData(source, "lebensversicherung")
            setTable["user_data"]["speedtank"] = vioGetElementData(source, "speedtank")
            setTable["user_data"]["Job"] = vioGetElementData(source, "job")
            setTable["user_data"]["Telefonnummer"] = vioGetElementData(source, "telefon")
            setTable["user_data"]["Wanteds"] = vioGetElementData(source, "wanteds")
            -- setTable["user_data"]["Warn"]=vioGetElementData(source,"warn")
            setTable["user_data"]["Stvo"] = vioGetElementData(source, "stvo")
            setTable["user_data"]["Knastzeit"] = vioGetElementData(source, "knastzeit")
            setTable["user_data"]["lastKnastzeit"] = vioGetElementData(source, "lastknastzeit")
            setTable["user_data"]["Kaution"] = vioGetElementData(source, "kaution")
            setTable["user_data"]["VehSlots"] = vioGetElementData(source, "maxslots")
            setTable["user_data"]["tutorial_gui"] = vioGetElementData(source, "tut")
            setTable["user_data"]["fisheslasthour"] = vioGetElementData(source, "fisheslasthour")
            setTable["user_data"]["newhkey"] = vioGetElementData(source, "hkey")
            setTable["user_data"]["prestigeKey"] = vioGetElementData(source, "prestigeKey")
            setTable["user_data"]["kopfgeld"] = vioGetElementData(source, "kopfgeld")
            setTable["user_data"]["bizKey"] = vioGetElementData(source, "bizKey")
            setTable["user_data"]["ingamespenden"] = vioGetElementData(source, "ingamespenden")
            setTable["user_data"]["alkaknast"] = vioGetElementData(source, "alkaknast")
            setTable["user_data"]["mussAlka"] = vioGetElementData(source, "mussAlka")

            --lizensen

            setTable["user_licenses"] = {}

            setTable["user_licenses"]["autoLic"] = vioGetElementData(source, "autoLic")
            setTable["user_licenses"]["truckLic"] = vioGetElementData(source, "truckLic")
            setTable["user_licenses"]["planeLic"] = vioGetElementData(source, "planeLic")
            setTable["user_licenses"]["bikeLic"] = vioGetElementData(source, "bikeLic")
            setTable["user_licenses"]["heliLic"] = vioGetElementData(source, "heliLic")
            setTable["user_licenses"]["boatLic"] = vioGetElementData(source, "boatLic")
            setTable["user_licenses"]["lastautoLic"] = vioGetElementData(source, "lastautoLic")
            setTable["user_licenses"]["lasttruckLic"] = vioGetElementData(source, "lasttruckLic")
            setTable["user_licenses"]["lastplaneLic"] = vioGetElementData(source, "lastplaneLic")
            setTable["user_licenses"]["lastbikeLic"] = vioGetElementData(source, "lastbikeLic")
            setTable["user_licenses"]["lastheliLic"] = vioGetElementData(source, "lastheliLic")
            setTable["user_licenses"]["quadLic"] = vioGetElementData(source, "quadLic")
            setTable["user_licenses"]["sonstigeLic"] = vioGetElementData(source, "sonstigeLic")
            setTable["user_licenses"]["waffenLic"] = vioGetElementData(source, "waffenLic")
            setTable["user_licenses"]["reiseLic"] = vioGetElementData(source, "reiseLic")
            setTable["user_licenses"]["angelLic"] = vioGetElementData(source, "angelLic")
            setTable["user_licenses"]["persoLic"] = vioGetElementData(source, "persoLic")

            --inventar

            setTable["user_inventory"] = {}

            setTable["user_inventory"]["Benzinkanister"] = vioGetElementData(source, "kanister")
            setTable["user_inventory"]["Lotto"] = vioGetElementData(source, "lotto")
            setTable["user_inventory"]["Lottoschein"] = vioGetElementData(source, "lottoschein")
            setTable["user_inventory"]["Rubbellos"] = vioGetElementData(source, "rubbellos")
            setTable["user_inventory"]["Drogen"] = vioGetElementData(source, "drogen")
            setTable["user_inventory"]["Snack"] = vioGetElementData(source, "snack")
            setTable["user_inventory"]["Hamburger"] = vioGetElementData(source, "hamburger")
            setTable["user_inventory"]["Fertigessen"] = vioGetElementData(source, "fertigessen")
            setTable["user_inventory"]["Schnellhilfe"] = vioGetElementData(source, "schnellhilfe")
            setTable["user_inventory"]["CarFinder"] = vioGetElementData(source, "carfinder")
            setTable["user_inventory"]["Materials"] = vioGetElementData(source, "mats")
            setTable["user_inventory"]["UseCarFinder"] = vioGetElementData(source, "usecarfinder")
            setTable["user_inventory"]["Hufeisenhelfer"] = vioGetElementData(source, "Hufeisenhelfer")
            setTable["user_inventory"]["geschenk"] = vioGetElementData(source, "geschenk")
            setTable["user_inventory"]["terralapptapp"] = vioGetElementData(source, "terralapptapp")
            setTable["user_inventory"]["tachodig_addon"] = vioGetElementData(source, "tachodig_addon")
            setTable["user_inventory"]["Kondome"] = vioGetElementData(source, "Kondome")
            setTable["user_inventory"]["adgutscheine"] = vioGetElementData(source, "adgutscheine")
            setTable["user_inventory"]["adaktiv"] = vioGetElementData(source, "adaktiv")
            setTable["user_inventory"]["dice"] = vioGetElementData(source, "dice")
            setTable["user_inventory"]["blutmesser"] = vioGetElementData(source, "blutmesser")


            --jobskills

            setTable["user_jobskills"] = {}

            setTable["user_jobskills"]["fischSkill"] = vioGetElementData(source, "fischSkill")
            setTable["user_jobskills"]["fischSkillPoints"] = vioGetElementData(source, "fischSkillPoints")
            setTable["user_jobskills"]["busSkill"] = vioGetElementData(source, "busSkill")
            setTable["user_jobskills"]["busSkillPoints"] = vioGetElementData(source, "busSkillPoints")
            setTable["user_jobskills"]["muellSkill"] = vioGetElementData(source, "muellSkill")
            setTable["user_jobskills"]["muellSkillPoints"] = vioGetElementData(source, "muellSkillPoints")
            setTable["user_jobskills"]["pizzaSkill"] = vioGetElementData(source, "pizzaSkill")
            setTable["user_jobskills"]["pizzaSkillPoints"] = vioGetElementData(source, "pizzaSkillPoints")
            setTable["user_jobskills"]["truckSkill"] = vioGetElementData(source, "truckSkill")
            setTable["user_jobskills"]["truckSkillPoints"] = vioGetElementData(source, "truckSkillPoints")
            setTable["user_jobskills"]["farmerSkill"] = vioGetElementData(source, "farmerSkill")
            setTable["user_jobskills"]["farmerSkillPoints"] = vioGetElementData(source, "farmerSkillPoints")
            setTable["user_jobskills"]["flyersSkill"] = vioGetElementData(source, "flyersSkill")
            setTable["user_jobskills"]["flyersSkillPoints"] = vioGetElementData(source, "flyersSkillPoints")
            setTable["user_jobskills"]["sweeperSkill"] = vioGetElementData(source, "sweeperSkill")
            setTable["user_jobskills"]["sweeperSkillPoints"] = vioGetElementData(source, "sweeperSkillPoints")
            setTable["user_jobskills"]["bergWerksSkill"] = vioGetElementData(source, "bergWerkSkill")
            setTable["user_jobskills"]["bergWerkSkillPoints"] = vioGetElementData(source, "bergWerkSkillPoints")
            setTable["user_jobskills"]["meeresSkill"] = vioGetElementData(source, "meeresSkill")
            setTable["user_jobskills"]["meeresSkillPoints"] = vioGetElementData(source, "meeresSkillPoints")


            --- archivments


            setTable["user_achievements"] = {}

            setTable["user_achievements"]["Erfolg_Fischermeister"] = vioGetElementData(source, "Erfolg_Fischermeister")
            setTable["user_achievements"]["Punkte_Fischermeister"] = vioGetElementData(source, "Punkte_Fischermeister")
            setTable["user_achievements"]["Punkte_Busmeister"] = vioGetElementData(source, "Punkte_Busmeister")
            setTable["user_achievements"]["Erfolg_MrLicenses"] = vioGetElementData(source, "Erfolg_MrLicenses")
            setTable["user_achievements"]["Erfolg_First_50"] = vioGetElementData(source, "Erfolg_First_50")
            setTable["user_achievements"]["Erfolg_First_100"] = vioGetElementData(source, "Erfolg_First_100")
            setTable["user_achievements"]["Erfolg_First_1000"] = vioGetElementData(source, "Erfolg_First_1000")
            setTable["user_achievements"]["Erfolg_10erFahrzeugrausch"] = vioGetElementData(source, "Erfolg_10erFahrzeugrausch")
            setTable["user_achievements"]["Erfolg_20erFahrzeugrausch"] = vioGetElementData(source, "Erfolg_20erFahrzeugrausch")
            setTable["user_achievements"]["Erfolg_50erFahrzeugrausch"] = vioGetElementData(source, "Erfolg_50erFahrzeugrausch")
            setTable["user_achievements"]["Erfolg_Busmeister"] = vioGetElementData(source, "Erfolg_Busmeister")
            setTable["user_achievements"]["Punkte_Busmeister"] = vioGetElementData(source, "Punkte_Busmeister")
            setTable["user_achievements"]["Erfolg_Lotto1"] = vioGetElementData(source, "Erfolg_Lotto1")
            setTable["user_achievements"]["Erfolg_Lotto2"] = vioGetElementData(source, "Erfolg_Lotto2")
            setTable["user_achievements"]["Erfolg_Lotto3"] = vioGetElementData(source, "Erfolg_Lotto3")
            setTable["user_achievements"]["Erfolg_Rubbellosgluck"] = vioGetElementData(source, "Erfolg_Rubbellosgluck")
            setTable["user_achievements"]["Erfolg_10erLos"] = vioGetElementData(source, "Erfolg_10erLos")
            setTable["user_achievements"]["Erfolg_Benzin_leer"] = vioGetElementData(source, "Erfolg_Benzin_leer")
            setTable["user_achievements"]["Erfolg_Mein_erstes_Geld"] = vioGetElementData(source, "Erfolg_Mein_erstes_Geld")
            setTable["user_achievements"]["Erfolg_MyOwnHome"] = vioGetElementData(source, "Erfolg_MyOwnHome")
            setTable["user_achievements"]["Erfolg_MyOwnBiz"] = vioGetElementData(source, "Erfolg_MyOwnBiz")
            setTable["user_achievements"]["Erfolg_Autoeinsteiger"] = vioGetElementData(source, "Erfolg_Autoeinsteiger")
            setTable["user_achievements"]["Erfolg_Mein_erstes_Brot"] = vioGetElementData(source, "Erfolg_Mein_erstes_Brot")
            setTable["user_achievements"]["Erfolg_Ersatztanke"] = vioGetElementData(source, "Erfolg_Ersatztanke")
            setTable["user_achievements"]["Erfolg_Fraktionseinsteiger"] = vioGetElementData(source, "Erfolg_Fraktionseinsteiger")
            setTable["user_achievements"]["Erfolg_10Hufeisen"] = vioGetElementData(source, "Erfolg_10Hufeisen")
            setTable["user_achievements"]["Erfolg_100Hufeisen"] = vioGetElementData(source, "Erfolg_100Hufeisen")
            setTable["user_achievements"]["Erfolg_1000Hufeisen"] = vioGetElementData(source, "Erfolg_1000Hufeisen")
            setTable["user_achievements"]["Erfolg_Meisterpilot"] = vioGetElementData(source, "Erfolg_Meisterpilot")
            setTable["user_achievements"]["Punkte_Meisterpilot"] = vioGetElementData(source, "Punkte_Meisterpilot")
            setTable["user_achievements"]["Punkte_Meistertrucker"] = vioGetElementData(source, "Punkte_Meistertrucker")
            setTable["user_achievements"]["Erfolg_Meistertrucker"] = vioGetElementData(source, "Erfolg_Meistertrucker")
            setTable["user_achievements"]["Erfolg_KMPokal"] = vioGetElementData(source, "Erfolg_KMPokal")
            setTable["user_achievements"]["Erfolg_TerraFriend"] = vioGetElementData(source, "Erfolg_TerraFriend")
            setTable["user_achievements"]["Erfolg_Millionaer"] = vioGetElementData(source, "Erfolg_Millionaer")
            setTable["user_achievements"]["Erfolg_Strassenreiniger"] = vioGetElementData(source, "Erfolg_Strassenreiniger")
            setTable["user_achievements"]["Punkte_Strassenreiniger"] = vioGetElementData(source, "Punkte_Strassenreiniger")
            setTable["user_achievements"]["Erfolg_Meeresreiniger"] = vioGetElementData(source, "Erfolg_Meeresreiniger")
            setTable["user_achievements"]["Punkte_Meeresreiniger"] = vioGetElementData(source, "Punkte_Meeresreiniger")
            setTable["user_achievements"]["Erfolg_Muellsammler"] = vioGetElementData(source, "Erfolg_Muellsammler")
            setTable["user_achievements"]["Punkte_Muellsammler"] = vioGetElementData(source, "Punkte_Muellsammler")
            setTable["user_achievements"]["Erfolg_Pizzaraser"] = vioGetElementData(source, "Erfolg_Pizzaraser")
            setTable["user_achievements"]["Punkte_Pizzaraser"] = vioGetElementData(source, "Punkte_Pizzaraser")
            setTable["user_achievements"]["Erfolg_Farmerjunge"] = vioGetElementData(source, "Erfolg_Farmerjunge")
            setTable["user_achievements"]["Punkte_Farmerjunge"] = vioGetElementData(source, "Punkte_Farmerjunge")
            setTable["user_achievements"]["Erfolg_Steinraeumer"] = vioGetElementData(source, "Erfolg_Steinraeumer")
            setTable["user_achievements"]["Punkte_Steinraeumer"] = vioGetElementData(source, "Punkte_Steinraeumer")
            setTable["user_achievements"]["Erfolg_Langlaeufer"] = vioGetElementData(source, "Erfolg_Langlaeufer")
            setTable["user_achievements"]["Punkte_Langlaeufer"] = vioGetElementData(source, "Punkte_Langlaeufer")
            setTable["user_achievements"]["Erfolg_Rekordschwimmer"] = vioGetElementData(source, "Erfolg_Rekordschwimmer")
            setTable["user_achievements"]["Punkte_Rekordschwimmer"] = vioGetElementData(source, "Punkte_Rekordschwimmer")


            -- NAME
            setTable["user_grades"] = {}

            setTable["user_grades"]["NAME_orientierung"] = vioGetElementData(source, "NAME_orientierung")
            setTable["user_grades"]["NAME_theorie_Beamte"] = vioGetElementData(source, "NAME_theorie_Beamte")
            setTable["user_grades"]["NAME_Gelaendefahr"] = vioGetElementData(source, "NAME_Gelaendefahr")
            setTable["user_grades"]["NAME_sozial"] = vioGetElementData(source, "NAME_sozial")
            setTable["user_grades"]["NAME_Waffenumgang"] = vioGetElementData(source, "NAME_Waffenumgang")
            setTable["user_grades"]["NAME_spezFahrtest"] = vioGetElementData(source, "NAME_spezFahrtest")
            setTable["user_grades"]["NAME_Strategisch"] = vioGetElementData(source, "NAME_Strategisch")
            setTable["user_grades"]["NAME_praktisch_Beamte"] = vioGetElementData(source, "NAME_praktisch_Beamte")
            setTable["user_grades"]["refresh"] = vioGetElementData(source, "NAME_refresh")

            -- OnlineSchutz
            setTable["user_tapps"] = {}
            setTable["user_tapps"]["OnlineSchutzUntil"] = vioGetElementData(source, "onlineschutzuntil")


            -- debug.print(setTable)

            for tablename, tableset in pairs(setTable) do
                MySql.helper.update(tablename, tableset, { Nickname = getPlayerName(source) });
            end

            outputDebugString("User Data [" .. nickname .. "] saved")
        end
    end
end
addEvent("SaveMyData", true)
addEventHandler("SaveMyData", getRootElement(), save_data)

