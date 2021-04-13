//#####################################################################
//Patched version intended for use with GFL ze_mojos_minigames_v1_4_1 stripper
//Removes HTML formatting broken after Shattered Web Update.
//Install as csgo/scripts/vscripts/gfl/main_patched.nut
//#####################################################################

stage <- 0
//mapnames <- ["BOATLESS ESCAPE", "CURSED RITUAL", "VALLEY", "CRUMBLE RUMBLE", "RAT MAZE", "SLIDE RACE"]
votes <- [0,0,0]


mapindexes <- ["BOATLESS ESCAPE", "CURSED RITUAL", "VALLEY", "DEEP LEARNING"]
mgindexes <- ["CRUMBLE RUMBLE", "RAT MAZE", "SLIDE RACE", "BOUNCEBOX"]

mapnames <- ["BOATLESS ESCAPE", "CURSED RITUAL", "VALLEY", "DEEP LEARNING"]
mgnames <- ["CRUMBLE RUMBLE", "RAT MAZE", "SLIDE RACE", "BOUNCEBOX"]

maps <- array(mapnames.len(),true)
minigames <- array(mgnames.len(),true)


function findInArray(array, val) 
{
	foreach (i, v in array) 
	{
		if(v == val)
		{
			return i
		}
	}
}

function shuffleArray(array)
{
	for(local i = 1; i < array.len(); i++)
	{
		local j = RandomInt(0,i)
		local temp = array[j]
		array[j] = array[i]
		array[i] = temp
	}
}

function enableVotingTriggers()
{
	
	votes <- [0,0,0]
	if(stage % 2 == 0) //minigame
	{
		shuffleArray(mgnames)


		for(local i = 0; i < 3; i++)
		{
			if(i < mgnames.len())
			{
				EntFire("worldtext"+(i+1), "AddOutput", "message "+ mgnames[i], 0.0, self)
			}
			else
			{
				EntFire("worldtext"+(i+1), "AddOutput", "message ", 0.0, self)
			}
		}
		//controlar para cuando hay menos de 3 elementos
//		EntFire("worldtext1", "AddOutput", "message "+ mgnames[0], 0.0, self)
//		EntFire("worldtext2", "AddOutput", "message "+ mgnames[1], 0.0, self)
//		EntFire("worldtext3", "AddOutput", "message "+ mgnames[2], 0.0, self)
		if(stage == 6)
		{
			DoEntFire("end_relay", "Trigger", "", 8.0, self, self)
			DoEntFire("vote_relay", "CancelPending", "", 0.0, self, self)
			EntFire("worldtext*", "AddOutput", "message ", 0.0, self)

			return
		}
		for(local i = 0; i < 3; i++)
		{
			if(i < mgnames.len())
			{
				DoEntFire("main_vote_trigger_"+i, "Enable", "", 0.0, self, self)
			}
			else
			{
				DoEntFire("main_vote_trigger_"+i, "Disable", "", 0.0, self, self)
			}
			
		}
		DoEntFire("console", "Command", "say * * * Choose the "+(stage == 0 ? "first" : "next")+" MINIGAME * * * ", 0.0, self, self)
	}
	else //Map
	{
		shuffleArray(mapnames)

		for(local i = 0; i < 3; i++)
		{
			if(i < mapnames.len())
			{
				EntFire("worldtext"+(i+1), "AddOutput", "message "+ mapnames[i], 0.0, self)
			}
			else
			{
				EntFire("worldtext"+(i+1), "AddOutput", "message ", 0.0, self)
			}
		}
//		EntFire("worldtext1", "AddOutput", "message "+ mapnames[0], 0.0, self)
//		EntFire("worldtext2", "AddOutput", "message "+ mapnames[1], 0.0, self)
//		EntFire("worldtext3", "AddOutput", "message "+ mapnames[2], 0.0, self)
		for(local i = 0; i < 3; i++)
		{
			if(i < mapnames.len())
			{
				DoEntFire("main_vote_trigger_"+i, "Enable", "", 0.0, self, self)
			}
			else
			{
				DoEntFire("main_vote_trigger_"+i, "Disable", "", 0.0, self, self)
			}
			
		}
		DoEntFire("console", "Command", "say * * * Choose the "+(stage == 5 ? "LAST" : "next")+" MAP * * * ", 0.0, self, self)
	}
	DoEntFire("console", "Command", "say * * * STAND in your platform of choice by the time the countdown ENDS * * *", 2.0, self, self)
}

function goto(str)
{
	local p = activator.GetOrigin()
	switch (str) {
		case 'c':
	        activator.SetOrigin(Vector(-6825.455566,-1705.051147,-88.889038))
	        break;
	    case '0':
	        activator.SetOrigin(Vector(-5234.693848,-10741.019531,-2952.157471))
	        break;
	    case 's':
	        activator.SetOrigin(Vector(425.709900,-8248.678711,1126.492188))
	        break;
		case 'r':
	        activator.SetOrigin(Vector(-3824.968018,-2781.480713,578.093811))
	        break;
	    case 'b':
	        activator.SetOrigin(Vector(-11550.430664,2671.911865,-5567.906250))
	        break;
	    case 'm':
	        activator.SetOrigin(Vector(6885.065918,11360.217773,217.150024))
	        break;
	    case 'v':
	        activator.SetOrigin(Vector(621.216919,345.132324,1402.984131))
	        break;
	    case '.':
	        activator.SetOrigin(Vector(621.216919,345.132324,1402.984131))
	        break;
	    default:
	        
	}
	
	EntFireByHandle(activator, "addoutput", "origin " + p.x + " " + p.y + " " + p.z , 2.0, self, self)
}


function updateChart()
{

	local x = [-5568,-5120,-4672]
	local y = -8840
	local zBot = -2560

//	local maxVotes = 0
//	local maxVotesIndex = -1
	local totalVotes = 0
	foreach(i,v in votes)
	{
		totalVotes += v
	}
	foreach(i,v in votes)
	{
		local p = (1.0*v/totalVotes)
		if(totalVotes == 0) 
		{
			p = 0
		}
		local h = zBot+1024*p
		p = (100.0*p).tostring()
		if(p.len() > 2)
		{
			p = p.slice(0,2)
		}
		
		
		if (totalVotes == v)
		{
			p = "100"
		}
		if (v == 0) 
		{
		    p = "0"
		}
		DoEntFire("main_chart_"+i+"_text", "AddOutput", "message " +p+"%", 0.0, self, self)
		DoEntFire("main_chart_"+i, "AddOutput", "origin "+x[i]+" "+y+" "+h, 0.0, self, self)
	}
}

function endVote()
{
	if(stage == 6) return
	DoEntFire("main_vote_trigger_*", "Disable", "", 0.0, self, self)
	local maxVotes = 0
	local maxVotesIndex = -1
	local totalVotes = 0
	foreach(i,v in votes)
	{
		totalVotes += v
	}
	foreach(i,v in votes)
	{
		if(maxVotes == v && v != 0)
		{
			if(RandomFloat(0,1) < 0.5)
			{
				maxVotes = v
				maxVotesIndex = i
			}
		}
		else if(maxVotes < v)
		{
			maxVotes = v
			maxVotesIndex = i
		}
	}
	local random = false
	if(maxVotes == 0)
	{
		random = true
		if(stage % 2 == 0)
		{
			//printl("minigameS:  minigames[0]" + "="+minigames[0] + "\n" + "minigames[1]" + "="+minigames[1]+"\n"+"minigames[2]" + "="+minigames[2]+"\nRAND: "+rand)
			maxVotesIndex = RandomInt(0,mgnames.len()-1)
		}
		else
		{
			//printl("MAPS:  maps[0]" + "="+maps[0] + "\n" + "maps[1]" + "="+maps[1]+"\n"+"maps[2]" + "="+maps[2]+"\nRAND: "+rand)
			maxVotesIndex = RandomInt(0,mapnames.len()-1)
		}
	}

	if(stage % 2 == 0)
	{
		if(random)
		{
			ScriptPrintMessageChatAll(" \x02[\x07MOJOVOTE\x02]\x05 " + mgnames[maxVotesIndex] + " was chosen at random.");
		}
		else
		{
			ScriptPrintMessageChatAll(" \x02[\x07MOJOVOTE\x02]\x05 " + mgnames[maxVotesIndex] + " won with " + votes[maxVotesIndex] + "/" + totalVotes + " votes (" + votes[maxVotesIndex]*100.0/totalVotes + "%).");
		}
		EntFireByHandle(EntityGroup[findInArray(mgindexes,mgnames[maxVotesIndex])], "Trigger", "", 0.0, self, self)

		mgnames.remove(maxVotesIndex)
	}
	else
	{
		if(random)
		{
			ScriptPrintMessageChatAll(" \x02[\x07MOJOVOTE\x02]\x05 " + mapnames[maxVotesIndex] + " was chosen at random.");
		}
		else
		{
			ScriptPrintMessageChatAll(" \x02[\x07MOJOVOTE\x02]\x05 " + mapnames[maxVotesIndex] + " won with " + votes[maxVotesIndex] + "/" + totalVotes + " votes (" + votes[maxVotesIndex]*100.0/totalVotes + "%).");
		}
		EntFireByHandle(EntityGroup[findInArray(mapindexes,mapnames[maxVotesIndex])+10], "Trigger", "", 0.0, self, self)

		mapnames.remove(maxVotesIndex)
	}
}

function voteEndsIn(t){
	if(t < 1) return
	if(stage == 6) {
		//chooseMinigame()
		return
	}
	local text = EntityGroup[9]
	local message = "Vote ends in " + t-- + " seconds!"
	EntFireByHandle(text, "AddOutput", "message " + message, 0.0, self, self)
	EntFireByHandle(text, "ShowMessage", "", 0.01, activator, activator)
	EntFireByHandle(self, "RunScriptCode", "voteEndsIn("+t+")", 1.0, self, self)
}

function backIn(t){
	if(t < 1) return
	local text = EntityGroup[9]
	local message = "Returning to spawn in " + t-- + " s"
	EntFireByHandle(text, "AddOutput", "message " + message, 0.0, self, self)
	EntFireByHandle(text, "ShowMessage", "", 0.01, activator, activator)
	EntFireByHandle(self, "RunScriptCode", "backIn("+t+")", 1.0, self, self)
}

function TimeToWin(t){
	if(t < 1) return
	local text = EntityGroup[9]
	local message = "" + t-- + " seconds to win"
	EntFireByHandle(text, "AddOutput", "message " + message, 0.0, self, self)
	EntFireByHandle(text, "ShowMessage", "", 0.01, activator, activator)
	EntFireByHandle(self, "RunScriptCode", "TimeToWin("+t+")", 1.0, self, self)
}


function fakeregen()
{
	EntFireByHandle(self, "RunScriptCode", "fakeregen()", 5.00, caller, activator)
	activator.SetHealth(activator.GetHealth()+10)
}

function checkHP()
{
	local p = null
	while((p = Entities.FindByClassname(p, "player")) != null)
	{
		if(p != null && p.IsValid() && p.GetTeam() == 3 && p.GetHealth() > 0)
		{
			if(p.ValidateScriptScope())
			{
				local sc = p.GetScriptScope()
				if(!("MAX_HP" in sc))
				{
					sc.MAX_HP <- 140
				}
				else 
				{
					if(sc.MAX_HP < 1)
					{
						sc.MAX_HP = 1
					}
					if(p.GetHealth() > sc.MAX_HP)
					{
						EntFireByHandle(p, "Addoutput", "health "+floor(sc.MAX_HP), 0.00, caller, p)
					}
				}
			}
		}
	}
}

HP_REDUCTION_SCALE <- 0.2

function Punish()
{
	local p = null
	while((p = Entities.FindByClassname(p, "player")) != null)
	{
		if(p.IsValid() && p.GetTeam() == 3)
		{
			if(p.ValidateScriptScope())
			{
				local sc = p.GetScriptScope()
				sc.MAX_HP *= 1-HP_REDUCTION_SCALE
				if(sc.MAX_HP < 1)
				{
					sc.MAX_HP = 1
				}
				if(p.GetHealth() > sc.MAX_HP)
				{
					EntFireByHandle(p, "Addoutput", "health "+floor(sc.MAX_HP), 0.00, caller, p)
				}
			}
		}
	}
}

function PunishActivator()
{
	if(activator == null || !activator.IsValid()) 
	{
		return
	}
	local h = activator.GetHealth()*0.8;
	//printl("h = " + h)
	if(activator.GetTeam() == 3)
	{
		if(activator.ValidateScriptScope())
		{
			local sc = activator.GetScriptScope()
			sc.MAX_HP *= 1-HP_REDUCTION_SCALE
			if(sc.MAX_HP < 1)
			{
				sc.MAX_HP = 1
			}
			if(activator.GetHealth() > sc.MAX_HP)
			{
				EntFireByHandle(activator, "Addoutput", "health "+floor(sc.MAX_HP), 0.00, activator, activator)
			}
		}
	}
}

function HealthTimes(n=1){
	if(activator == null || !activator.IsValid() || activator.GetTeam() != 3 || activator.GetHealth() <= 0)
	{
		return
	}
	if(activator.ValidateScriptScope())
	{
		local sc = activator.GetScriptScope()
		sc.MAX_HP *= n
		if(sc.MAX_HP < 1)
		{
			sc.MAX_HP = 1
		}
		if(activator.GetHealth()*n > sc.MAX_HP)
		{
			EntFireByHandle(activator, "Addoutput", "health "+floor(sc.MAX_HP), 0.00, activator, activator)
		}
		else
		{
			EntFireByHandle(activator, "Addoutput", "health "+activator.GetHealth()*n, 0.00, activator, activator)
		}
	}
	
}

function showHelp(n)
{
	switch (n) {
	    case 0:
	        ScriptPrintMessageChatTeam(2, " \x02[\x07MOJOHINT\x02]\x05 Press E to spawn a BOMB directly below you.")
	        break;
	    case 1:
	        ScriptPrintMessageChatTeam(3, " \x02[\x07MOJOHINT\x02]\x05 FIRE can HEAL you, but your max HP is REDUCED each time you fail to complete a map!.")
	        break;
	    case 2:
	        ScriptPrintMessageChatTeam(3, " \x02[\x07MOJOHINT\x02]\x05 BREAKABLE walls don't make any sound when hit, but they don't take long to break.")
	        break;
	    case 3:
	        ScriptPrintMessageChatTeam(3, " \x02[\x07MOJOHINT\x02]\x05 Keep an eye on the SKY!")
	        break;
	    case 4:
	        ScriptPrintMessageChatTeam(3, " \x02[\x07MOJOHINT\x02]\x05 The spooky SKULL from the ALTAR is REQUIRED to proceed in this level - Be sure to DEFEND EARLY!")
	        break;
	    case 5:
	        ScriptPrintMessageChatTeam(2, " \x02[\x07MOJOHINT\x02]\x05 Press E to spawn a BOMB directly below you - you can also use the SIDE RAMPS to get the humans on the way back!")
	        break;
		case 6:
	        ScriptPrintMessageChatTeam(2, " \x02[\x07MOJOHINT\x02]\x05 Use your KNIFE on the platforms to CRUMBLE them.")
	        break;
	    case 7:
	        ScriptPrintMessageChatTeam(3, " \x02[\x07MOJOHINT\x02]\x05 The TOP path can be HARD to defend, consider admitting defeat and GOING to the LOWER BUNKER as a TEAM.")
	        break;
	    case 8:
	        ScriptPrintMessageChatTeam(3, " \x02[\x07MOJOHINT\x02]\x05 The TRAM only starts MOVING some seconds after someone REACHES the other side")
	        break;
	    case 9:
	        ScriptPrintMessageChatTeam(2, " \x02[\x07MOJOHINT\x02]\x05 Press E to spawn STICKY GOO directly below you.")
	        break;
	    default:
	        
	}
	
}