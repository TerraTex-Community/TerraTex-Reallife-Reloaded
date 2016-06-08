
policeSkin={[150]=true,[265]=true,[266]=true,[268]=true,[280]=true,[281]=true,[282]=true,[283]=true,[284]=true,[288]=true,[267]=true}
groveSkin={[105]=true,[106]=true,[107]=true,[269]=true,[270]=true,[271]=true,[311]=true,[301]=true,[300]=true}
newsSkin={[148]=true,[188]=true,[227]=true,[187]=true}
llsSkin={[111]=true,[112]=true,[113]=true,[12]=true,[223]=true,[46]=true,[126]=true,[125]=true,[124]=true,[98]=true}
sekSkin={[141]=true,[163]=true,[164]=true,[165]=true,[166]=true,[286]=true,[285]=true}
armySkin={[287]=true,[73]=true,[191]=true,[312]=true,[179]=true}
taxiSkin={[61]=true,[172]=true,[255]=true,[59]=true,[126]=true,[98]=true,[25]=true}
medicSkin={[274]=true,[275]=true,[276]=true,[70]=true,[71]=true}
cashForceSkin={[117]=true,[118]=true,[120]=true,[171]=true,[172]=true,[186]=true}
violettasSkin={[13]=true,[102]=true,[103]=true,[104]=true }
sharkracerSkin={[41]=true,[114]=true,[115]=true,[116]=true,[173]=true,[174]=true,[175]=true}




        SkinGui_Window = {}
        SkinGui_Button = {}
        SkinGui_Label = {}
        SkinGui_Grid = {}

addEventHandler("onClientResourceStart",resourceRoot,
    function()


        SkinGui_Window[1] = guiCreateWindow(591,122,292,367,"Skin-List",false)
		table.insert(allGuis,SkinGui_Window[1])
        SkinGui_Button[1] = guiCreateButton(145,56,133,33,"GetIt!",false,SkinGui_Window[1])
        SkinGui_Button[2] = guiCreateButton(163,97,98,33,"Beenden",false,SkinGui_Window[1])
        SkinGui_Grid[1] = guiCreateGridList(37,39,96,310,false,SkinGui_Window[1])
		guiGridListSetSelectionMode(SkinGui_Grid[1],2)
		guiGridListAddColumn(SkinGui_Grid[1],"SKinID",0.4)
        SkinGui_Label[1] = guiCreateLabel(146,154,129,91,"Klicke auf eine ID um zusehen welcher Skin sich dahinter verbirkt!",false,SkinGui_Window[1])
		guiLabelSetColor(SkinGui_Label[1],255,255,255)
		guiLabelSetVerticalAlign(SkinGui_Label[1],"top")
		guiLabelSetHorizontalAlign(SkinGui_Label[1],"left",true)
		guiSetVisible(SkinGui_Window[1],false)

		addEventHandler ( "onClientGUIClick", SkinGui_Button[1], buy_skin, false )
		addEventHandler ( "onClientGUIClick", SkinGui_Button[2], break_skin, false )

	
    end
)
function buy_skin()
	local selectrow,selectcolum=guiGridListGetSelectedItem ( SkinGui_Grid[1] )
	local selectedskin=guiGridListGetItemText(SkinGui_Grid[1],guiGridListGetSelectedItem ( SkinGui_Grid[1]),1)
	toggleAllControls(true)
	guiSetVisible(SkinGui_Window[1],false)
	showCursor(false)
	triggerServerEvent("buy_skin",getLocalPlayer(),selectedskin)

end

function break_skin()
	toggleAllControls(true)
	guiSetVisible(SkinGui_Window[1],false)
	showCursor(false)
	triggerServerEvent("break_skin",getLocalPlayer())
end

function showSkinGui_func(duty)
	guiSetVisible(SkinGui_Window[1],true)
	showCursor(true)

	guiGridListClear (SkinGui_Grid[1] )
	local fraktion=tonumber(getElementData(getLocalPlayer(),"fraktion"))
	if(fraktion==0)or(fraktion==8)or(duty)then
		tabler = getValidPedModels()
		for key, index in pairs ( tabler ) do
			if (not(policeSkin[index]) and not(groveSkin[index]) and not(sharkracerSkin[index]) and not(newsSkin[index]) and not(llsSkin[index]) and not(sekSkin[index]) and not (armySkin[index]) and not(medicSkin[index]) and not(violettasSkin[index]) and not(cashForceSkin[index]))then
				local row = guiGridListAddRow ( SkinGui_Grid[1] )
                guiGridListSetItemText ( SkinGui_Grid[1], row, 1, tostring(index), false, false )
			end
        end

	elseif(fraktion==12)then
		tabler = getValidPedModels()
		for key, index in pairs ( tabler ) do
			if ((violettasSkin[index]))then
				local row = guiGridListAddRow ( SkinGui_Grid[1] )
                		guiGridListSetItemText ( SkinGui_Grid[1], row, 1, tostring(index), false, false )
			end
		end
	elseif(fraktion==13)then
		tabler = getValidPedModels()
		for key, index in pairs ( tabler ) do
			if ((sharkracerSkin[index]))then
				local row = guiGridListAddRow ( SkinGui_Grid[1] )
                		guiGridListSetItemText ( SkinGui_Grid[1], row, 1, tostring(index), false, false )
			end
		end
	elseif(fraktion==11)then
		tabler = getValidPedModels()
		for key, index in pairs ( tabler ) do
			if ((cashForceSkin[index]))then
				local row = guiGridListAddRow ( SkinGui_Grid[1] )
                		guiGridListSetItemText ( SkinGui_Grid[1], row, 1, tostring(index), false, false )
			end
		end	
	elseif(fraktion==1)or(fraktion==9)then
		tabler = getValidPedModels()
		for key, index in pairs ( tabler ) do
			if ((policeSkin[index]))then
				local row = guiGridListAddRow ( SkinGui_Grid[1] )
                		guiGridListSetItemText ( SkinGui_Grid[1], row, 1, tostring(index), false, false )
			end
		end	
	elseif(fraktion==2)then
		tabler = getValidPedModels()
		for key, index in pairs ( tabler ) do
			if ((groveSkin[index]))then
				local row = guiGridListAddRow ( SkinGui_Grid[1] )
                		guiGridListSetItemText ( SkinGui_Grid[1], row, 1, tostring(index), false, false )
			end
		end	
	elseif(fraktion==3)then
		tabler = getValidPedModels()
		for key, index in pairs ( tabler ) do
			if ((newsSkin[index]))then
				local row = guiGridListAddRow ( SkinGui_Grid[1] )
                		guiGridListSetItemText ( SkinGui_Grid[1], row, 1, tostring(index), false, false )
			end
		end	
	elseif(fraktion==4)then
		tabler = getValidPedModels()
		for key, index in pairs ( tabler ) do
			if ((taxiSkin[index]))then
				local row = guiGridListAddRow ( SkinGui_Grid[1] )
                guiGridListSetItemText ( SkinGui_Grid[1], row, 1, tostring(index), false, false )
			end
		end	
	
	elseif(fraktion==5)then
		tabler = getValidPedModels()
		for key, index in pairs ( tabler ) do
			if ((sekSkin[index]))then
				local row = guiGridListAddRow ( SkinGui_Grid[1] )
                		guiGridListSetItemText ( SkinGui_Grid[1], row, 1, tostring(index), false, false )
			end
		end	
	elseif(fraktion==6)then
		tabler = getValidPedModels()
		for key, index in pairs ( tabler ) do
			if ((llsSkin[index]))then
				local row = guiGridListAddRow ( SkinGui_Grid[1] )
                		guiGridListSetItemText ( SkinGui_Grid[1], row, 1, tostring(index), false, false )
			end
		end	
	elseif(fraktion==7)then
		tabler = getValidPedModels()
		for key, index in pairs ( tabler ) do
			if ((armySkin[index]))then
				local row = guiGridListAddRow ( SkinGui_Grid[1] )
                		guiGridListSetItemText ( SkinGui_Grid[1], row, 1, tostring(index), false, false )
			end
		end	
	elseif(fraktion==10)then
		tabler = getValidPedModels()
		for key, index in pairs ( tabler ) do
			if ((medicSkin[index]))then
				local row = guiGridListAddRow ( SkinGui_Grid[1] )
                		guiGridListSetItemText ( SkinGui_Grid[1], row, 1, tostring(index), false, false )
			end
		end	
	end
	
	
	
	
end
addEvent("showSkinGui",true)
addEventHandler("showSkinGui",getRootElement(),showSkinGui_func)


function setPlayerClickedSkin(button,state)

	if(guiGetVisible ( SkinGui_Window[1] ))then

		if(button=="left") and (state=="down")then

			if(guiGridListGetSelectedCount ( SkinGui_Grid[1] )>0)then
				local selectrow,selectcolum=guiGridListGetSelectedItem ( SkinGui_Grid[1] )
				local selectedskin=guiGridListGetItemText(SkinGui_Grid[1],guiGridListGetSelectedItem ( SkinGui_Grid[1]),1)
				triggerServerEvent("setMySkin",getLocalPlayer(),tonumber(selectedskin))
			end	
		end	
	end
end
addEventHandler("onClientClick",getRootElement(),setPlayerClickedSkin)











