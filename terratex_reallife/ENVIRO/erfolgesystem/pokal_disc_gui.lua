
        Pokal_disc_GUI_Window = {}
        Pokal_disc_GUI_Button = {}
        Pokal_disc_GUI_Label = {}
        Pokal_disc_GUI_Grid = {}
		Pokal_disc_GUI_Rows={}
		Pokal_disc_disc={}
addEventHandler("onClientResourceStart",resourceRoot,
    function()


        Pokal_disc_GUI_Window[1] = guiCreateWindow(0.3625,0.2022,0.2663,0.4878,"Pokalliste",true)
        table.insert(allGuis,Pokal_disc_GUI_Window[1])
		Pokal_disc_GUI_Button[1] = guiCreateButton(0.0352,0.9134,0.2207,0.0592,"Beenden",true,Pokal_disc_GUI_Window[1])
        Pokal_disc_GUI_Label[1] = guiCreateLabel(0.0235,0.0592,0.9507,0.1708,"Klicken Sie auf eins der Pokale und hier erscheint die Beschreibung",true,Pokal_disc_GUI_Window[1])
        guiLabelSetHorizontalAlign(Pokal_disc_GUI_Label[1],"left",true)
        Pokal_disc_GUI_Grid[1] = guiCreateGridList(0.0211,0.2597,0.9577,0.631,true,Pokal_disc_GUI_Window[1])
        guiGridListSetSelectionMode(Pokal_disc_GUI_Grid[1],0)
		guiGridListSetSortingEnabled ( Pokal_disc_GUI_Grid[1],false )

        guiGridListAddColumn(Pokal_disc_GUI_Grid[1],"ID",0.2)

        guiGridListAddColumn(Pokal_disc_GUI_Grid[1],"Name",0.3)

        guiGridListAddColumn(Pokal_disc_GUI_Grid[1],"Erhalten?",0.3)
		
		---ADD Rows for Discribtion
		
		Pokal_disc_GUI_Rows[1]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[1], 1, "1", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[1], 2, "Fischermeister", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[1]]="Fischermeister"..":\n".."Fange 1000 Fische"

		Pokal_disc_GUI_Rows[2]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[2], 1, "2", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[2], 2, "Mr.Licenses", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[2]]="Mr.Licenses"..":\n".."Besitze alle Lizensen"

		Pokal_disc_GUI_Rows[3]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[3], 1, "3", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[3], 2, "First 50", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[3]]="First 50"..":\n".."Erreiche 50 Spielstunden"

		Pokal_disc_GUI_Rows[4]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[4], 1, "4", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[4], 2, "First 100", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[4]]="First 100"..":\n".."Erreiche 100 Spielstunden"

		Pokal_disc_GUI_Rows[5]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[5], 1, "5", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[5], 2, "First 1000", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[5]]="First 1000"..":\n".."Erreiche 1000 Spielstunden"
		
		Pokal_disc_GUI_Rows[6]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[6], 1, "6", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[6], 2, "Millionaer", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[6]]="Millionaer"..":\n".."Erreiche 1 Mio. $"
				
		Pokal_disc_GUI_Rows[7]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[7], 1, "7", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[7], 2, "10er Fahrzeugrausch", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[7]]="10er Fahrzeugrausch"..":\n".."Besitze 10 Fahrzeuge"
				
		Pokal_disc_GUI_Rows[8]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[8], 1, "8", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[8], 2, "15er Fahrzeugrausch", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[8]]="15er Fahrzeugrausch"..":\n".."Besitze 15 Fahrzeuge"
				
		Pokal_disc_GUI_Rows[9]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[9], 1, "9", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[9], 2, "20er Fahrzeugrausch", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[9]]="20er Fahrzeugrausch"..":\n".."Besitze 20 Fahrzeuge"
				
		Pokal_disc_GUI_Rows[10]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[10], 1, "10", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[10], 2, "Busmeister", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[10]]="Busmeister"..":\n".."Fahre 100 Haltestellen ab"
			
		Pokal_disc_GUI_Rows[11]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[11], 1, "11", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[11], 2, "1er Lotto", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[11]]="1er Lotto"..":\n".."Gewinne mit einen 1er im Lotto"
			
		Pokal_disc_GUI_Rows[12]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[12], 1, "12", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[12], 2, "2er Lotto", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[12]]="2er Lotto"..":\n".."Gewinne mit einen 2er im Lotto"
			
		Pokal_disc_GUI_Rows[13]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[13], 1, "13", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[13], 2, "3er Lotto", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[13]]="3er Lotto"..":\n".."Gewinne mit einen 3er im Lotto"
		
		Pokal_disc_GUI_Rows[14]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[14], 1, "14", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[14], 2, "Rubbellosglueck", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[14]]="Rubbellosglueck"..":\n".."Gewinne einmal im Rubbellosspiel"
		
		Pokal_disc_GUI_Rows[15]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[15], 1, "15", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[15], 2, "10er Los", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[15]]="10er Los"..":\n".."Gewinne mit drei Zehnen auf dem Rubbellos"
		
		Pokal_disc_GUI_Rows[16]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[16], 1, "16", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[16], 2, "Benzin leer", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[16]]="Benzin leer"..":\n".."Gehe das erste Mal Tanken"
						
		Pokal_disc_GUI_Rows[17]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[17], 1, "17", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[17], 2, "Mein erstes Geld", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[17]]="Mein erstes Geld"..":\n".."Erhalte deinen ersten Payday"
						
		Pokal_disc_GUI_Rows[18]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[18], 1, "18", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[18], 2, "My Own Home", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[18]]="My Own Home"..":\n".."Besitze dein erstes eigenes Haus (Pokal wird zum nächsten PayDay erst vergeben)"
						
		Pokal_disc_GUI_Rows[19]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[19], 1, "19", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[19], 2, "My Own Biz", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[19]]="My Own Biz"..":\n".."Besitze dein erstes eigenes Buisness (Pokal wird zum nächsten PayDay erst vergeben)"
						
		Pokal_disc_GUI_Rows[20]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[20], 1, "20", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[20], 2, "Autoeinsteiger", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[20]]="Autoeinsteiger"..":\n".."Kaufe ein Auto"
						
		Pokal_disc_GUI_Rows[21]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[21], 1, "21", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[21], 2, "Mein erstes Brot", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[21]]="Mein erstes Brot"..":\n".."Iss das erste Mal etwas"
						
		Pokal_disc_GUI_Rows[22]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[22], 1, "22", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[22], 2, "Ersatztanke", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[22]]="Ersatztanke"..":\n".."Benutze einen Benzinkanister"
						
		
		Pokal_disc_GUI_Rows[23]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[23], 1, "23", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[23], 2, "Fraktionseinsteiger", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[23]]="Fraktionseinsteiger"..":\n".."Sei in einer Fraktion"

		Pokal_disc_GUI_Rows[24]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[24], 1, "24", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[24], 2, "Hufeisenprinz", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[24]]="Hufeisenprinz"..":\n".."Finde 10 Hufeisen!"
			
		Pokal_disc_GUI_Rows[25]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[25], 1, "25", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[25], 2, "Hufeisenkönig", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[25]]="Hufeisenkönig"..":\n".."Finde 100 Hufeisen!"
			
		Pokal_disc_GUI_Rows[26]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[26], 1, "26", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[26], 2, "Hufeisenkaiser", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[26]]="Hufeisenkaiser"..":\n".."Finde 1000 Hufeisen!"
			
		Pokal_disc_GUI_Rows[27]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[27], 1, "27", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[27], 2, "Truckermeister", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[27]]="Truckermeister"..":\n".."Schließe 1000 Truckerfahrten ab!"
			
		Pokal_disc_GUI_Rows[28]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[28], 1, "28", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[28], 2, "Meisterpilot", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[28]]="Meisterpilot"..":\n".."Beende 1000 Flüge!"
			
		Pokal_disc_GUI_Rows[29]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[29], 1, "29", false, false )
			guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[29], 2, "Kilometerfresser", false, false )
			Pokal_disc_disc[Pokal_disc_GUI_Rows[29]]="Kilometerfresser"..":\n".."Besitze ein Fahrzeug mit 100,000 km auf dem Tacho!"

        Pokal_disc_GUI_Rows[30]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[30], 1, "30", false, false )
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[30], 2, "TerraFriend", false, false )
        Pokal_disc_disc[Pokal_disc_GUI_Rows[30]]="TerraFriend"..":\n".."Wirb 5 User, die sich 25 Spielstunden erspielen! (Wird zum PayDay vergeben)"

        
        --neu
        Pokal_disc_GUI_Rows[31]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[31], 1, "31", false, false )
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[31], 2, "Straßenreiniger", false, false )
        Pokal_disc_disc[Pokal_disc_GUI_Rows[31]]="Straßenreiniger"..":\n".."Reinige 100km Straße."

        Pokal_disc_GUI_Rows[32]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[32], 1, "32", false, false )
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[32], 2, "Meeresreiniger", false, false )
        Pokal_disc_disc[Pokal_disc_GUI_Rows[32]]="Meeresreiniger"..":\n".."Reinige 100km Meer"

        Pokal_disc_GUI_Rows[33]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[33], 1, "33", false, false )
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[33], 2, "Müllsammler", false, false )
        Pokal_disc_disc[Pokal_disc_GUI_Rows[33]]="Müllsammler"..":\n".."Sammle 1000 Müllsäcke"

        Pokal_disc_GUI_Rows[34]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[34], 1, "34", false, false )
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[34], 2, "Pizzaraser", false, false )
        Pokal_disc_disc[Pokal_disc_GUI_Rows[34]]="Pizzaraser"..":\n".."Liefere 1000 Bestellungen aus"

        Pokal_disc_GUI_Rows[35]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[35], 1, "35", false, false )
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[35], 2, "Farmerjunge", false, false )
        Pokal_disc_disc[Pokal_disc_GUI_Rows[35]]="Farmerjunge"..":\n".."Sei Fleißig und erledige 100 Missionen"

        Pokal_disc_GUI_Rows[36]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[36], 1, "36", false, false )
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[36], 2, "Steinräumer", false, false )
        Pokal_disc_disc[Pokal_disc_GUI_Rows[36]]="Steinräumer"..":\n".."Sammle 1000 Marker ein."

        Pokal_disc_GUI_Rows[37]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[37], 1, "37", false, false )
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[37], 2, "Langläufer", false, false )
        Pokal_disc_disc[Pokal_disc_GUI_Rows[37]]="Langläufer"..":\n".."Laufe 1000km zu Fuß"

        Pokal_disc_GUI_Rows[38]=guiGridListAddRow ( Pokal_disc_GUI_Grid[1])
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[38], 1, "38", false, false )
        guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[38], 2, "Rekordschwimmer", false, false )
        Pokal_disc_disc[Pokal_disc_GUI_Rows[38]]="Rekordschwimmer"..":\n".."Schwimme 10km."




        guiSetVisible(Pokal_disc_GUI_Window[1],false)
		addEventHandler("onClientGUIClick",Pokal_disc_GUI_Button[1],click_Pokal_disc_Close_Button,false)
		addEventHandler("onClientGUIClick",Pokal_disc_GUI_Grid[1],click_Pokal_disc_disc,false)
		
    end
)

function click_Pokal_disc_disc()

	local selected={}
	selected=guiGridListGetSelectedItems ( Pokal_disc_GUI_Grid[1] )
	if(selected)then
		if(selected[1]["row"])then
			if tonumber(selected[1]["row"])>-1 then
				
				guiSetText(Pokal_disc_GUI_Label[1],Pokal_disc_disc[selected[1]["row"]])
			
			end	
		end
	end
end

function click_Pokal_disc_Close_Button()
	guiSetVisible(Pokal_disc_GUI_Window[1],false)
	showCursor(false)
end

function showPokalDiscGui()
	guiSetVisible(Pokal_disc_GUI_Window[1],true)
	showCursor(true)
	guiSetText(Pokal_disc_GUI_Label[1],"Klicken Sie auf eins der Pokale und hier erscheint die Beschreibung")
	--JaNeinSetzen
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[1], 3, get_Ja_Nein_Pokal("Fischermeister"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[2], 3, get_Ja_Nein_Pokal("MrLicenses"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[3], 3, get_Ja_Nein_Pokal("First_50"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[4], 3, get_Ja_Nein_Pokal("First_100"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[5], 3, get_Ja_Nein_Pokal("First_1000"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[6], 3, get_Ja_Nein_Pokal("Millionaer"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[7], 3, get_Ja_Nein_Pokal("10erFahrzeugrausch"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[8], 3, get_Ja_Nein_Pokal("20erFahrzeugrausch"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[9], 3, get_Ja_Nein_Pokal("50erFahrzeugrausch"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[10], 3, get_Ja_Nein_Pokal("Busmeister"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[11], 3, get_Ja_Nein_Pokal("Lotto1"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[12], 3, get_Ja_Nein_Pokal("Lotto2"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[13], 3, get_Ja_Nein_Pokal("Lotto3"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[14], 3, get_Ja_Nein_Pokal("Rubbellosgluck"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[15], 3, get_Ja_Nein_Pokal("10erLos"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[16], 3, get_Ja_Nein_Pokal("Benzin_leer"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[17], 3, get_Ja_Nein_Pokal("Mein_erstes_Geld"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[18], 3, get_Ja_Nein_Pokal("MyOwnHome"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[19], 3, get_Ja_Nein_Pokal("MyOwnBiz"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[20], 3, get_Ja_Nein_Pokal("Autoeinsteiger"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[21], 3, get_Ja_Nein_Pokal("Mein_erstes_Brot"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[22], 3, get_Ja_Nein_Pokal("Ersatztanke"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[23], 3, get_Ja_Nein_Pokal("Fraktionseinsteiger"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[24], 3, get_Ja_Nein_Pokal("10Hufeisen"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[25], 3, get_Ja_Nein_Pokal("100Hufeisen"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[26], 3, get_Ja_Nein_Pokal("1000Hufeisen"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[27], 3, get_Ja_Nein_Pokal("Meistertrucker"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[28], 3, get_Ja_Nein_Pokal("Meisterpilot"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[29], 3, get_Ja_Nein_Pokal("KMPokal"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[30], 3, get_Ja_Nein_Pokal("TerraFriend"), false, false )

	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[31], 3, get_Ja_Nein_Pokal("Strassenreiniger"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[32], 3, get_Ja_Nein_Pokal("Meeresreiniger"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[33], 3, get_Ja_Nein_Pokal("Muellsammler"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[34], 3, get_Ja_Nein_Pokal("Pizzaraser"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[35], 3, get_Ja_Nein_Pokal("Farmerjunge"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[36], 3, get_Ja_Nein_Pokal("Steinraeumer"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[37], 3, get_Ja_Nein_Pokal("Langlaeufer"), false, false )
	guiGridListSetItemText ( Pokal_disc_GUI_Grid[1], Pokal_disc_GUI_Rows[38], 3, get_Ja_Nein_Pokal("Rekordschwimmer"), false, false )
end
addCommandHandler("pokal",showPokalDiscGui,false,false)

function get_Ja_Nein(num)
    if(num==1)then
        return "Ja"
    else
        return "Nein"
    end
end
-- Abfrage über Erfolg_  Punkte_

function get_Ja_Nein_Pokal(pokalname)
    local num=tonumber(getElementData(getLocalPlayer(),"Erfolg_"..pokalname))
    if(num==1)then
        return "Ja"
    else
        if(pokalname=="Meisterpilot")then
            local percent=math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/1000*100)
            return percent.."% ("..getElementData(getLocalPlayer(),"Punkte_"..pokalname).." / 1000 )"

            --1000
        elseif(pokalname=="Meistertrucker")then
            local percent=math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/1000*100)
            return percent.."% ("..getElementData(getLocalPlayer(),"Punkte_"..pokalname).." / 1000 )"
            --1000
        elseif(pokalname=="Fischermeister")then
            local percent=math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/1000*100)
            return percent.."% ("..getElementData(getLocalPlayer(),"Punkte_"..pokalname).." / 1000 )"
            --1000
        elseif(pokalname=="Busmeister")then
            local percent=math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/100*100)
            return percent.."% ("..getElementData(getLocalPlayer(),"Punkte_"..pokalname).." / 100 )"
             --100

         elseif(pokalname=="Strassenreiniger")then
            local percent=math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/100000*100)
            return percent.."% ("..math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/1000,3).." / 100 )"

        elseif(pokalname=="Meeresreiniger")then
            local percent=math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/100000*100)
            return percent.."% ("..math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/1000,3).." / 100 )"
             --100

        elseif(pokalname=="Muellsammler")then
            local percent=math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/1000*100)
            return percent.."% ("..(getElementData(getLocalPlayer(),"Punkte_"..pokalname)).." / 1000 )"
             --100

        elseif(pokalname=="Pizzaraser")then
            local percent=math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/1000*100)
            return percent.."% ("..(getElementData(getLocalPlayer(),"Punkte_"..pokalname)).." / 1000 )"
             --100

        elseif(pokalname=="Farmerjunge")then
            local percent=math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/100*100)
            return percent.."% ("..(getElementData(getLocalPlayer(),"Punkte_"..pokalname)).." / 100 )"
             --100

        elseif(pokalname=="Steinraeumer")then
            local percent=math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/1000*100)
            return percent.."% ("..(getElementData(getLocalPlayer(),"Punkte_"..pokalname)).." / 1000 )"
             --100

        elseif(pokalname=="Langlaeufer")then
            local percent=math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/1000000*100)
            return percent.."% ("..math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/1000,3).." / 1000 )"
             --100

        elseif(pokalname=="Rekordschwimmer")then
            local percent=math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/10000*100)
            return percent.."% ("..math.round(getElementData(getLocalPlayer(),"Punkte_"..pokalname)/1000,3).." / 10 )"
             --100



        else
            return "Nein"
        end
    end



end








