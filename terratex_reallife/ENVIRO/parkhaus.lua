fahrstuhlelement=false
fahrstuhlgitterA=false
fahrstuhlgitterB=false
fahrstuhltimer=10000
fahrstuhlhaltetimer=5000
fahrstuhlmovement=true
fahrstuhlstation=0
fahrstuhlhighs={[0]=11.1,17.3,23.7,30.1,36.5,42.9}

function createFahrstuhl_parkhaus()
	fahrstuhlelement=createObject(974,2260.8,1391.4,11.1,90,0,0)
	fahrstuhlgitterA=createObject(970,2258,1391.2,11.6,0,0,90)
	fahrstuhlgitterB=createObject(970,2260.1,1388.8,11.6,0,0,0)
	--attachRotationAdjusted ( attachelemeneter,fahrstuhlelement)
	setTimer(moveFahrStuhl,fahrstuhlhaltetimer,1)

end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createFahrstuhl_parkhaus)

function moveFahrStuhl()
	if(fahrstuhlmovement)then
		fahrstuhlstation=fahrstuhlstation+1
		if(fahrstuhlstation>5)then
			fahrstuhlstation=4
			fahrstuhlmovement=false
		end
	else
		fahrstuhlstation=fahrstuhlstation-1
		if(fahrstuhlstation<0)then
			fahrstuhlstation=1
			fahrstuhlmovement=true
		end
	end
	moveObject(fahrstuhlelement,fahrstuhltimer,2260.8,1391.4,fahrstuhlhighs[fahrstuhlstation])
	moveObject(fahrstuhlgitterA,fahrstuhltimer,2258,1391.2,fahrstuhlhighs[fahrstuhlstation]+0.5)
	moveObject(fahrstuhlgitterB,fahrstuhltimer,2260.1,1388.8,fahrstuhlhighs[fahrstuhlstation]+0.5)	
	setTimer(moveFahrStuhl,fahrstuhlhaltetimer+fahrstuhltimer,1)
end









