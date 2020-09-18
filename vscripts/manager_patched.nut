//===================================\\
// Script by Luffaren (STEAM_0:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/_mapscripts/ze_diddle/)
//
//  Patched version intended for use with GFL ze_diddle_v3 stripper, included in the release
//  Adds "Diddle Extreme", where you must beat everything in a single round (with some help/items)
//===================================\\

coins_max_normalmode <- 250;
coins_max_extrememode <- 300;
coins_max <- 250;
coins <- 0;
coins_lastround <- 0;
piv <- null;
vaginacount <- 0;
babycount <- 0;
checkpoint <- false;
firststage <- true;
stagepool <- [0,1,2,3,4];
stageskip <- [];
pivv <- false;
pivvv <- false;
buyers <- [];
wcheck <- null;
customers <- [];
shopactive <- false;
shop_cheat <- null; //player who shoots secret wall gets prioritized to the shop (only works for one player each round)
extreme <- false;
stageChosen <- -1;
normalTorchCooldowns <- true;

items <-			//ITEM PRICE LIST:
[20,				//0 - heal
60,					//1 - legendary heal
60,					//2 - push					(pre-stripper-V3:	40)
20,					//3 - small dick
40,					//4 - big dick
40,					//5 - diddlecannon			(pre-stripper-V3:	50)
30,					//6 - wall big
20,					//7 - wall mid
10];				//8 - wall small
item_mincost <- 10;	//ITEM THAT COSTS THE LEAST (update this if you update item prices)
items_priceindicator <- [
Vector(8045,190,220),Vector(0,0,0),items[0],
Vector(8045,320,220),Vector(0,0,0),items[1],
Vector(8045,520,220),Vector(0,0,0),items[2],
Vector(8045,608,220),Vector(0,0,0),items[3],
Vector(8045,710,220),Vector(0,0,0),items[4],
Vector(7930,813,220),Vector(0,90,0),items[5],
Vector(7800,813,220),Vector(0,90,0),items[6],
Vector(7570,472,220),Vector(0,180,0),items[7],
Vector(7570,336,220),Vector(0,180,0),items[8]];
function SpawnItemPriceIndicators()
{
	local alreadyexisting = Entities.FindByName(null,"shoppricestripperfix");
	if(alreadyexisting!=null&&alreadyexisting.IsValid())
		EntFire("shoppricestripperfix","Kill","",0.00,null);
	for(local i=0;i<items_priceindicator.len();i+=3)
	{
		local pos = items_priceindicator[i];
		local rot = items_priceindicator[i+1];
		local price = items_priceindicator[i+2];
		local text = Entities.CreateByClassname("point_worldtext");
		EntFireByHandle(text,"AddOutput","message "+price.tostring(),0.00,null,null);
		EntFireByHandle(text,"AddOutput","targetname shoppricestripperfix",0.00,null,null);
		EntFireByHandle(text,"AddOutput","textsize 20",0.00,null,null);
		EntFireByHandle(text,"AddOutput","color 255 100 0",0.00,null,null);
		text.SetOrigin(pos);
		text.SetAngles(rot.x,rot.y,rot.z);
	}
}


//STAGES:
//		0 = shrek		(The limbo of Shrek)
//		1 = turtle		(The virus)
//		2 = beach		(mm1ri12mk2ns2hk11sf2rr6ey2eg21/Omaha beach)
//		3 = diglett		(The revenge of the dicklett temple part 2)
//		4 = weaboo		(Weeaboo Annihilation)
//		5 = finale		(The final Diddle)
//		X = warmup		(The Cantina of Diddle)
//      X = Xtreme      (The ultimate Xtreme Diddle heaven multicolor experience)


//walls get 100+(X*Tcount)hp depending on the wall (small green:80  /  mid red:150  /  big yellow:350)
autoHurtWallNearTP_DAMAGE <- 500;
autoHurtGreenWallNearGreenWall_DAMAGE <- 5;
function AutoHurtWallNearTP(type)
{
	if(caller==null||!caller.IsValid())
		return;
	//1=green	(small)
	//2=red		(medium)
	//3=yellow	(big)
	local radius = 200;	//looks fine for small
	if(type==2)radius = 280;
	else if(type==3)radius = 380;
	local neargreen = false;
	local teleportent_scan = Entities.FindByClassnameWithin(null,"info_teleport_destination",caller.GetOrigin(),radius);
	if(teleportent_scan == null || !teleportent_scan.IsValid())
	{
		local h = null;
		while(null!=(h=Entities.FindByNameWithin(h,"ITEMX_qaz_item_shields1*",caller.GetOrigin(),radius)))
		{
			if(h!=caller)
			{
				neargreen = true;
				teleportent_scan = h;
				break;
			}
		}
	}
	if(teleportent_scan != null && teleportent_scan.IsValid())
	{
		EntFireByHandle(self,"RunScriptCode"," AutoHurtWallNearTP("+type.tostring()+"); ",0.50,null,caller);
		if(neargreen)
			EntFireByHandle(caller,"RemoveHealth",autoHurtGreenWallNearGreenWall_DAMAGE.tostring(),0.00,null,null);
		else
			EntFireByHandle(caller,"RemoveHealth",autoHurtWallNearTP_DAMAGE.tostring(),0.00,null,null);
	}
	else
		EntFireByHandle(self,"RunScriptCode"," AutoHurtWallNearTP("+type.tostring()+"); ",3.00,null,caller);
}

EXMVOTE_EXTREME_PERCENTAGE <- 70;
EXMVOTE_NORMAL_PERCENTAGE <- 60;
EXMVOTE_PERCENTAGE <- 60;
exmvote_voteallowed <- false;
exmvote_voted <- false;
exmvote_gtext <- null;
exmvote_playercount <- 0;
exmvote_playervotes <- 0;
exmvote_playervoted <- [];
function ExtremeModeVote()
{
	if(!exmvote_voteallowed)
		return;
	if(caller==null||!caller.IsValid())
		return;
	if(exmvote_voted)
		return;
	if(activator==null||!activator.IsValid()||activator.GetClassname()!="player"||activator.GetTeam()!=3||activator.GetHealth()<=0)
		return;
	foreach(pvs in exmvote_playervoted)
	{
		if(pvs == activator)
			return;
	}
	exmvote_playervoted.push(activator);
	exmvote_playervotes++;
	EntFire("extremevote_gfade","Fade","",0.00,activator);
	if(exmvote_playervotes >= ((exmvote_playercount*EXMVOTE_PERCENTAGE)/100).tointeger())
	{
		exmvote_voted = true;
		local extoggle = !extreme;
		ResetMap();
		extreme = extoggle;
		local cmode="NORMAL";if(extreme)cmode="EXTREME";
		EntFire("server","Command","say ["+cmode+" MODE VOTE] PASSED - SLAYING",0.00,activator);
		EntFire("server","Command","say ["+cmode+" MODE VOTE] PASSED - SLAYING",0.01,activator);
		EntFire("server","Command","say ["+cmode+" MODE VOTE] PASSED - SLAYING",0.02,activator);
		EntFire("server","Command","say ["+cmode+" MODE VOTE] PASSED - SLAYING",0.03,activator);
		EntFire("server","Command","say ["+cmode+" MODE VOTE] PASSED - SLAYING",0.04,activator);
		EntFire("extremevote_gtext","AddOutput","message ["+cmode+" MODE VOTE] PASSED - SLAYING",0.02,null);
		EntFire("extremevote_gtext","Display","",0.03,null);
		EntFireByHandle(self,"RunScriptCode"," KillAllButton(); ",0.05,null,null);
	}
}

function WarnVoteShowMessage()
{
	EntFireByHandle(self,"RunScriptCode"," WarnVoteShowMessage(); ",0.02,null,null);
	if(exmvote_gtext==null||!exmvote_gtext.IsValid())
	{
		exmvote_gtext = Entities.FindByName(null,"extremevote_gtext");
		if(exmvote_gtext==null||!exmvote_gtext.IsValid())
			return;
	}
	exmvote_gtext.__KeyValueFromString("message","[EXTREME MODE VOTE]\nGet ready to vote at the start of the next round\nYou can do this by shooting straight up in the spawn-area\nYou will only have ~10 seconds to vote\nIt's your vote, do just as you wish!");
	EntFireByHandle(exmvote_gtext,"Display","",0.01,null,null);
}

function ExtremeModeVoteShowMessage()
{
	if(!exmvote_voteallowed)return;
	EntFireByHandle(self,"RunScriptCode"," ExtremeModeVoteShowMessage(); ",0.02,null,null);
	local cmode = "EXTREME";
	if(extreme)cmode = "NORMAL";
	if(exmvote_gtext==null||!exmvote_gtext.IsValid())
	{
		exmvote_gtext = Entities.FindByName(null,"extremevote_gtext");
		if(exmvote_gtext==null||!exmvote_gtext.IsValid())
			return;
	}
	exmvote_gtext.__KeyValueFromString("message","["+cmode+" MODE VOTE]\nYou can vote by shooting straight up\nVotes: ("+exmvote_playervotes.tostring()+"/"+((exmvote_playercount*EXMVOTE_PERCENTAGE)/100).tointeger().tostring()+")");
	EntFireByHandle(exmvote_gtext,"Display","",0.01,null,null);
}

function ResetAllScore()
{
	local hlist = [];local h = null;
	while(null!=(h=Entities.FindByClassname(h,"player")))
	{
		h.ValidateScriptScope();
		local sc = h.GetScriptScope();
		if("playershopbias" in sc)
			sc.playershopbias = 0;
		else
			sc.playershopbias <- 0;
	}
	ResetPlayerScore(hlist);
	foreach(sb in SBplayers)
	{
		sb.score = 0;
	}
}

//function to restore shop bias score if lost, only utilized through the luffarenmaps.smx plugin
SBplayersrestore <- [];
SBplayers <- [];
class SBplayer
{
	userid = null;
	steamid = null;
	score = null;
	name = null;
	constructor(_userid,_steamid,_score,_name)
	{
		userid = _userid;
		steamid = _steamid;
		score = _score;
		name = _name;
	}
}
function TickShopBiasPlayers()
{
	EntFireByHandle(self,"RunScriptCode"," TickShopBiasPlayers(); ",1.00,null,null);
	if(SBplayersrestore.len()<=0)
		return;
	local SBplayersagain = [];
	local looped = false;
	while(!looped)
	{
		local sb = SBplayersrestore.remove(0);
		if(sb!=null)
		{
			local foundsbplayer = false;
			local h = null;while(null!=(h=Entities.FindByClassname(h,"player")))
			{
				h.ValidateScriptScope();
				local sc = h.GetScriptScope();
				if("userid" in sc)
				{
					if(sc.userid == sb)
					{
						foundsbplayer = true;
						foreach(sbr in SBplayers)
						{
							if(sc.userid == sbr.userid)
							{
								if("playershopbias" in sc)
									sc.playershopbias = 0;
								else
									sc.playershopbias <- 0;
								ResetPlayerScore([h]);
								AddPlayerScore(sbr.score,[h]);
								sc.playershopbias = (sbr.score - 1);
								AddPlayerShopBias(1,h);
								break;
							}
						}
						break;
					}
				}
			}
			if(!foundsbplayer)
				SBplayersagain.push(sb);
		}
		if(SBplayersrestore.len()<=0)
		{
			looped = false;
			break;
		}
	}
	if(SBplayersagain.len()>0)
	{
		SBplayersrestore.clear();
		foreach(ssba in SBplayersagain)
			SBplayersrestore.push(ssba);
	}
}

function PlayerKillEvent()
{
	AddPlayerShopBias(1,activator,true);
}

function ShowPlayerScoreNewRound()
{
	if(activator==null||!activator.IsValid())
		return;
	activator.ValidateScriptScope();
	local sc = activator.GetScriptScope();
	if(!("playershopbias" in sc))
		sc.playershopbias <- 0;
	AddPlayerScore(sc.playershopbias,[activator]);
}

plscore_index <- 0;
function AddPlayerScore(score,handles)
{
	if(score==0)
		return;
	plscore_index++;
	if(plscore_index > 10)
		plscore_index = 1;
	local scent = Entities.FindByName(null,"score_"+plscore_index.tostring());
	if(scent==null || !scent.IsValid())
		return;
	scent.__KeyValueFromInt("points",score);
	foreach(h in handles)
	{
		if(h==null||!h.IsValid()||h.GetClassname()!="player")
			continue;
		EntFireByHandle(scent,"ApplyScore","",0.01,h,null);
	}
}
function ResetPlayerScore(handles)
{
	foreach(h in handles)
	{
		if(h==null||!h.IsValid()||h.GetClassname()!="player")
			continue;
		EntFire("score_reset","ApplyScore","",0.00,h);
	}
}

function AddPlayerShopBias(value=0,handle=null,noscore=false)		//call to add score to player/!activator through map-based things
{
	if(handle==null||!handle.IsValid())
	{
		handle = activator;
		if(handle==null||!handle.IsValid())
			return;
	}
	if(handle.GetClassname()!="player")
		return;
	handle.ValidateScriptScope();
	local sc = handle.GetScriptScope();
	if("playershopbias" in sc)
		sc.playershopbias += value;
	else
		sc.playershopbias <- value;
	if(SBplayers.len()>0)	//restore-feature is active through luffarenmaps.smx
	{
		if("userid" in sc)
		{
			foreach(sbr in SBplayers)
			{
				if(sc.userid == sbr.userid)
				{
					sbr.score = sc.playershopbias;
					break;
				}
			}
		}
	}
	if(!noscore)
		AddPlayerScore(value,[handle]);
	return sc.playershopbias;
}
function ScrambleArray(arr)
{
	if(arr==null||arr.len()<=0)
		return;
	local scrambled = false;
	local arr_scrambled = [];
	while(!scrambled)
	{
		local arrindex = RandomInt(0,arr.len()-1);
		arr_scrambled.push(arr[arrindex]);
		arr.remove(arrindex);
		if(arr.len()<=0)
			scrambled = true;
	}
	return arr_scrambled;
}
function GetSortedShopBiasList(candidates)	//candidates = array of player-handles
{
	//(1) set up a temporary list that is completely validated, no invalid players
	local wlist = [];
	foreach(c in candidates)
	{
		if(c==null||!c.IsValid()||c.GetClassname()!="player"||c.GetTeam()!=3||c.GetHealth()<=0)
			continue;
		wlist.push(c);
	}
	
	//(2) sort the list based on each player's score (if they match, do a 50/50 decision to go higher/lower)
	local n = wlist.len();
	for(local i=0;i<n;i++)
	{
		for(local j=1;j<(n-i);j++)
		{
			if(AddPlayerShopBias(0,wlist[j-1]) < AddPlayerShopBias(0,wlist[j]) || 
			AddPlayerShopBias(0,wlist[j-1]) == AddPlayerShopBias(0,wlist[j]) && RandomFloat(0.00,100.00) > 50.00)
			{
				local temp = wlist[j-1];
				wlist[j-1] = wlist[j];
				wlist[j] = temp;
			}
		}
	}
	
	//(3) create the final bias list, and add more instances of the top-scored compared to the lower-scored
	local rlist = [];
	local add_amount = wlist.len();
	foreach(h in wlist)
	{
		for(local i=0;i<add_amount;i++)
			rlist.push(h);
		add_amount--;
	}
	
	//(4) return the biased list, it should look something like this with a list of 5 players
	//[1,1,1,1,1,2,2,2,2,3,3,3,4,4,5]
	return rlist;
}

firstrealround <- true;
function RoundStart()
{
	exmvote_voteallowed = false;
	if (extreme)
	{
		coins_max = coins_max_extrememode;
		EntFire("manager", "RunScriptCode", "VoteMsg();", 4.00, null);
		exmvote_voteallowed = true;
		EntFireByHandle(self, "RunScriptCode", " exmvote_voteallowed = false; ", 10.90, null, null);
		ExevRoundStart();
	}
	else
	{
		coins_max = coins_max_normalmode;
		EntFire("ExtremeShoot*", "Kill", "", 0.00, null);
	}
	
	stageChosen = -1;
	normalTorchCooldowns = true;
	firststage = true;
	ResetDamageFilter();
	EntFire("fog", "RunScriptCode", " SetFarz(50000); ", 0.00, self);
	shop_cheat = null;
	buyers = [];
	customers = [];
	shopactive = false;
	babycount = 0;
	TickShopBiasPlayers();
	vaginacount = 0;if(piv!=null)EntFireByHandle(piv,"AddOutput","targetname doodler3",5.00,null,null);
	local p = null;	while(null != (p = Entities.FindByName(p, "warmupcheck"))){wcheck = p;}pivv=false;PS1list=[];PSlist=[];pivvv=false;
	if(wcheck != null && wcheck.IsValid())
		Initialize();
	else
	{
		coins = (0+coins_lastround);
		if(checkpoint)
		{
			EntFire("stage_manager", "InValue", "finale", 0.00, self);
			stagepool = [];
			CheckMaxedCoinsCheckpoint();
			SpawnBlobElements();
			local shopcheatrng = RandomInt(0,100);
			if(shopcheatrng > 50)
			{
				EntFire("stripstrop_shopcheat","AddOutput","origin 4488 880 600",0.00,null);
				EntFire("stripstrop_diddlefriend","AddOutput","origin 4488 1168 600",0.00,null);
			}
			else
			{
				EntFire("stripstrop_diddlefriend","AddOutput","origin 4488 880 600",0.00,null);
				EntFire("stripstrop_shopcheat","AddOutput","origin 4488 1168 600",0.00,null);
			}
			specdevils.clear();
			shopangels.clear();
			tickingsinners = true;
			TickInflatingSinners();
		}
		else
		{
			ResetScore();
			stagepool = [0,1,2,3,4];
			SkipCheck();
			if(stagepool.len()>0)
			{
				if(stagepool.len()>=5)
				{
					exmvote_voteallowed = true;
					EntFireByHandle(self, "RunScriptCode", " exmvote_voteallowed = false; ", 10.90, null, null);
				}
				EntFireByHandle(self, "RunScriptCode", " PickStage(); ", 11.00, null, null);
			}
			else
				ReachedCheckpoint();
		}
		if(exmvote_voteallowed)
		{
			if(extreme)
				EXMVOTE_PERCENTAGE = EXMVOTE_NORMAL_PERCENTAGE;
			else
				EXMVOTE_PERCENTAGE = EXMVOTE_EXTREME_PERCENTAGE;
			exmvote_voted = false;
			exmvote_playervoted.clear();
			exmvote_playervotes = 0;
			exmvote_playercount = 0;
			local h = null;while(null!=(h=Entities.FindByClassname(h,"player")))
			{
				if(h.GetTeam()==3&&h.GetHealth()>0)
					exmvote_playercount++;
			}
			ExtremeModeVoteShowMessage();
		}
		CheckStageState();
		RenderCoinCount();
		if(!firstrealround)
		{
			local scoreadd_time = 0.00;
			local h = null;
			local hsclist = [];
			while(null!=(h=Entities.FindByClassname(h,"player")))
			{
				if(h==null||!h.IsValid())continue;
				if(h.GetTeam()==3||h.GetTeam()==2)
				{
					if(h.GetHealth()>0)
					{
						hsclist.push(h);
						AddPlayerShopBias((SHOPBIAS_ADD_PLAYEDROUND),h,true);
						EntFireByHandle(self,"RunScriptCode","ShowPlayerScoreNewRound();",scoreadd_time,h,null);
						scoreadd_time += 0.01;
					}
				}
			}
			//AddPlayerScore(SHOPBIAS_ADD_PLAYEDROUND,hsclist); <- removed because broken
		}
		else
		{
			firstrealround = false;
			ResetAllScore();
		}
	}
}

function RenderCoinCount()
{
	EntFire("coin_text", "SetText", "COINS: "+coins.tostring()+"/"+coins_max.tostring(), 0.00, self);
	EntFire("coin_text", "Display", "", 0.02, self);
	EntFireByHandle(self, "RunScriptCode", " RenderCoinCount(); ", 0.20, null, null);
}

function CheckStageState()
{
	local ss = [0,1,2,3,4];
	for(local i=0;i<ss.len();i+=1)
	{
		local exists=false;
		for(local j=0;j<stagepool.len();j+=1)
		{
			if(stagepool[j]==ss[i]){exists=true;}
		}
		if(!exists)
		{
			if(ss[i]==0)EntFire("stagedoor_shrek","Open","",0.00,null);
			else if(ss[i]==1)EntFire("stagedoor_turtle","Open","",0.00,null);
			else if(ss[i]==2)EntFire("stagedoor_soldier","Open","",0.00,null);
			else if(ss[i]==3)EntFire("stagedoor_diglett","Open","",0.00,null);
			else if(ss[i]==4)EntFire("stagedoor_weeb","Open","",0.00,null);
		}
	}
}

function TeleportLate()
{
	if(!activator.IsNoclipping())
		EntFireByHandle(activator, "AddOutput", "origin "+lx + " "+ly+" "+lz, 0.00, self, self);
}

function SetShopCheat()
{
	shop_cheat = activator;
}

function CheckAutoSlay(stageind)
{
	if(firststage){firststage=false;}else if(!extreme)
	{
		local ctc_check = 0;
		local tc_check = 0;
		local p = null;
		while(null != (p = Entities.FindByClassname(p,"player")))
		{
			if(p!=null&&p.IsValid()&&p.GetHealth()>0)
			{
				if(p.GetTeam()==2)tc_check++;
				else if(p.GetTeam()==3)ctc_check++;
			}
		}
		if(ctc_check>0&&tc_check>0)
		{
			local ccratio = ctc_check/tc_check;
			if(stageind==0&&ccratio<1.40||		//0 = shrek		>	35ct / 25t
			stageind==1&&ccratio<1.00||			//1 = turtle	>	30ct / 30t
			stageind==2&&ccratio<0.70||			//2 = omaha		>	25ct / 35t
			stageind==3&&ccratio<2.00||			//3 = diglett	>	40ct / 20t
			stageind==4&&ccratio<0.50||			//4 = weaboo	>	20ct / 40t
			stageind==5&&ccratio<2.00)			//5 = finale	>	40ct / 20t
			{
				EntFire("server","Command","say ***NOT ENOUGH HUMANS - SLAYING TO SAVE TIME***",0.00,null);
				EntFire("server","Command","say ***NOT ENOUGH HUMANS - SLAYING TO SAVE TIME***",0.01,null);
				EntFire("server","Command","say ***NOT ENOUGH HUMANS - SLAYING TO SAVE TIME***",0.02,null);
				EntFire("server","Command","say ***NOT ENOUGH HUMANS - SLAYING TO SAVE TIME***",0.03,null);
				EntFire("server","Command","say ***NOT ENOUGH HUMANS - SLAYING TO SAVE TIME***",0.04,null);
				KillAllT();
			}
		}
	}
}

function PickStage()
{
	local stage = -1;

	if (stageChosen == -1)
	{
		local r = RandomInt(0,stagepool.len()-1);
		CheckAutoSlay(r);
		stage = stagepool[r];
	}
	else
	{
		stage = stageChosen;
	}
	if(extreme)
		SpawnExtremeZombieItem(stage);
	if(stage == 0)
	{
		EntFire("ExtremeShoot*", "SetHealth", "999999", 0.00, self);
		EntFire("ExtremeShootShrek", "Kill", "", 0.00, self);
		EntFire("stage_manager", "InValue", "shrek", 0.00, self);
		EntFire("fog", "RunScriptCode", " SetDistance(0,40000); ", 0.20, self);
		EntFire("fog", "RunScriptCode", " SetFogColor(0,255,0); ", 0.20, self);
		EntFire("tonemap", "RunScriptCode", " SetBloom(3); ", 0.20, self);
		EntFireByHandle(self, "RunScriptCode", " TeleportTeam(1,-15289,-14238,13980); ", 0.50, self,self);
		EntFireByHandle(self, "RunScriptCode", " TeleportTeam(2,-15289,-14238,13980); ", 8.50, self,self);
		EntFire("luff_zhealth", "FireUser1", "", 8.40, self);
	}
	else if(stage == 1)
	{
		EntFire("ExtremeShoot*", "SetHealth", "999999", 0.00, self);
		EntFire("ExtremeShootTurtle", "Kill", "", 0.00, self);
		EntFire("stage_manager", "InValue", "turtle", 0.00, self);
		EntFire("fog", "RunScriptCode", " SetDistance(-500,15000); ", 0.20, self);
		EntFire("fog", "RunScriptCode", " SetFogColor(255,255,100); ", 0.20, self);
		EntFire("tonemap", "RunScriptCode", " SetBloom(2); ", 0.20, self);
		EntFireByHandle(self, "RunScriptCode", " TeleportTeam(1,5365,-15070,-14442); ", 0.50, self,self);
		EntFireByHandle(self, "RunScriptCode", " TeleportTeam(2,5365,-15070,-14442); ", 8.50, self,self);
	}
	else if(stage == 2)
	{
		EntFire("ExtremeShoot*", "SetHealth", "999999", 0.00, self);
		EntFire("ExtremeShootBeach", "Kill", "", 0.00, self);
		EntFire("stage_manager", "InValue", "beach", 0.00, self);
		EntFire("fog", "RunScriptCode", " SetDistance(-500,8000); ", 0.20, self);
		EntFire("fog", "RunScriptCode", " SetFogColor(255,255,255); ", 0.20, self);
		EntFire("tonemap", "RunScriptCode", " SetBloom(2); ", 0.20, self);
		EntFireByHandle(self, "RunScriptCode", " TeleportTeam(1,-15164,1177,15410); ", 0.50, self,self);
		EntFireByHandle(self, "RunScriptCode", " TeleportTeam(2,-15164,1177,15410); ", 15.50, self,self);
	}
	else if(stage == 3)
	{
		EntFire("ExtremeShoot*", "SetHealth", "999999", 0.00, self);
		EntFire("ExtremeShootDiglett", "Kill", "", 0.00, self);
		EntFire("stage_manager", "InValue", "diglett", 0.00, self);
		EntFire("fog", "RunScriptCode", " SetDistance(40,800); ", 0.20, self);
		EntFire("fog", "RunScriptCode", " SetFogColor(0,0,0); ", 0.20, self);
		EntFire("tonemap", "RunScriptCode", " SetBloom(3); ", 0.20, self);
		EntFireByHandle(self, "RunScriptCode", " TeleportTeam(1,-10396,12158,15566); ", 0.50, self,self);
		EntFireByHandle(self, "RunScriptCode", " TeleportTeam(2,-10123,12980,15760); ", 2.00, self,self);
	}
	else if(stage == 4)
	{
		EntFire("ExtremeShoot*", "SetHealth", "999999", 0.00, self);
		EntFire("ExtremeShootWeeaboo", "Kill", "", 0.00, self);
		EntFire("stage_manager", "InValue", "weaboo", 0.00, self);
		EntFire("fog", "RunScriptCode", " SetDistance(1000,2500); ", 0.20, self);
		EntFire("fog", "RunScriptCode", " SetFarz(2750); ", 0.20, self);
		EntFire("fog", "RunScriptCode", " SetFogColor(0,0,0); ", 0.20, self);
		EntFire("tonemap", "RunScriptCode", " SetBloom(0.5); ", 0.20, self);
		EntFireByHandle(self, "RunScriptCode", " TeleportTeam(1,-4103,0,-3641); ", 0.50, self,self);
		EntFireByHandle(self, "RunScriptCode", " TeleportTeam(2,-4103,0,-3641); ", 20.50, self,self);
	}
}

function ResetScore()
{
	//keep score (applied in v1_3)
	//local p = null;while(null != (p = Entities.FindByClassname(p, "player")))
	//{
	//	EntFire("coinscore_reset","ApplyScore", "", 0.00, p);
	//} 
}

function ResetOverlay()
{
	local p = null;while(null != (p = Entities.FindByClassname(p, "player")))
	{
		EntFire("client","Command","r_screenoverlay XXLUFF_NULLXX", 0.00, p);
		EntFire("client","Command","r_screenoverlay ", 0.02, p);
		EntFireByHandle(p,"AddOutput","targetname fuckface",0.00,null,null);
	} 
}

function ResetDamageFilter()
{
	local p = null;while(null != (p = Entities.FindByClassname(p, "player")))
	{
		if(p!=null)
			EntFireByHandle(p,"SetDamageFilter","",0.00,null,null);
	} 
}

function KillAllButton()
{
	local p = null;
	while(null != (p = Entities.FindByClassname(p,"player")))
	{
		if(p != null && p.IsValid() && p.GetHealth()>0)
			EntFireByHandle(p, "SetHealth", "-69", 0.00, null, null);
	}
}

function TeleportTeam(team,_x,_y,_z)//TEAM 1 = ct/humans, TEAM 2 = t/zombies
{
	lx = _x;
	ly = _y;
	lz = _z;
	team = 4-team;
	local p = null;
	while(null != (p = Entities.FindByClassname(p, "player")))
	{
		if(p != null && p.IsValid() && p.GetTeam() == team && p.GetHealth()>0 && !p.IsNoclipping())
		{
			EntFireByHandle(p, "AddOutput", "origin "+_x + " "+_y+" "+_z, 0.00, self, self);
		}
	} 
}

function KillAllT()
{
	local p = null;
	while(null != (p = Entities.FindByClassname(p,"player")))
	{
		if(p != null && p.IsValid() && p.GetTeam() == 2 && p.GetHealth()>0)
			EntFireByHandle(p, "SetHealth", "-69", 0.00, null, null);
	}
}

function KillAllCT()
{
	local p = null;
	while(null != (p = Entities.FindByClassname(p,"player")))
	{
		if(p != null && p.IsValid() && p.GetTeam() == 3 && p.GetHealth()>0)
			EntFireByHandle(p, "SetHealth", "-69", 0.00, null, null);
	}
}

function ApplyStageScore()
{
	local p = null;while(null != (p = Entities.FindByClassname(p, "player")))
	{
		if(p.GetTeam() == 3)
		{
			//EntFire("coinscore_add_100" "ApplyScore", "", 0.00, p);		//TODO - SCORE
		}
	}
}

function CheckMaxedCoins()
{
	if(coins >= coins_max)
	{
		EntFire("allcoins_effect" "Trigger", "", 0.00, null);
		CheckMaxedCoinsCheckpoint();
	}
}

function CheckMaxedCoinsCheckpoint()
{
	if(coins >= coins_max)
		EntFire("allcoins_event" "Trigger", "", 0.00, null);
}

function ReachedCheckpoint()
{
	coins_lastround = (0+coins);
	checkpoint = true;
	EntFire("stage_manager", "InValue", "finale", 0.00, self);
	SpawnBlobElements();
}

ddicktimeout <- 1.20;
ddickdead <- false;
function DiddleDickBossInit()
{
	ddicktimeout = 1.20;
	ddickdead = false;
	DiddleDickBossTick();
}
function DiddleDickBossTick()
{
	if(ddickdead)
		return;
	EntFireByHandle(self,"RunScriptCode"," DiddleDickBossTick(); ",0.10,null,null);
	ddicktimeout -= 0.05;
	if(ddicktimeout <= 0)								//timer is disabled when it should be enabled
	{
		EntFire("dd_timer","Enable","",0.00,null);
		ddicktimeout = 1.20;
		printl("[ERROR - DIDDLEDICK BOSS] - timed out, enabling logic_timer");
	}
	local dc = Entities.FindByName(null,"dd_case");
	if(dc == null || !dc.IsValid())						//no random case named "dd_case" is active, rename closest neighbour
	{
		printl("[ERROR - DIDDLEDICK BOSS] - invalid logic_case, reassigning next one");
		if(Entities.FindByName(null,"dd_case_2")!=null)
			EntFire("dd_case_2","AddOutput","targetname dd_case",0.00,null);
		else if(Entities.FindByName(null,"dd_case_3")!=null)
			EntFire("dd_case_3","AddOutput","targetname dd_case",0.00,null);
		else if(Entities.FindByName(null,"dd_case_4")!=null)
			EntFire("dd_case_4","AddOutput","targetname dd_case",0.00,null);
	}
}

SHOPBIAS_ADD_WONSTAGE <- 100; //+ the amount of T's		//given to CT's on cleared stage
SHOPBIAS_ADD_WINSTAGE_NOWINNER <- 80;					//given to T's on cleared stage
SHOPBIAS_ADD_PLAYEDROUND <- 30;							//given to players on round start
function ClearedStage(stageindex)
{
	if(!extreme)
		GiveHumansHP();
	coins_lastround = coins;
	ScriptCoopResetRoundStartTime();
	EntFire("coin", "FireUser1", "", 0.00, self);
	EntFire("ctwinscore", "AddScoreCT", "", 0.00, self);
	EntFire("ctwinscore", "AddScoreCT", "", 0.00, self);//added a second one in hope of making it work - TODO (keep or remove?)
	EntFire("fog", "RunScriptCode", " SetDistance(500,15000); ", 0.00, self);
	EntFire("fog", "RunScriptCode", " SetFogColor(255,200,100); ", 0.00, self);
	EntFire("fog", "RunScriptCode", " SetFarz(50000); ", 0.00, self);
	EntFire("tonemap", "RunScriptCode", " SetBloom(5); ", 0.00, self);
	
	local h = null;
	local talivecount = 0;
	while(null!=(h=Entities.FindByClassname(h,"player")))
	{
		if(h==null||!h.IsValid())
			continue;
		if(h.GetHealth()>0&&h.GetTeam()==2)
			talivecount++;
	}
	local hlist = [];h = null;
	local hctlist = [];
	local htlist = [];
	while(null!=(h=Entities.FindByClassname(h,"player")))
	{
		if(h==null||!h.IsValid())
			continue;
		if(h.GetHealth()>0&&h.GetTeam()==3)
		{
			hctlist.push(h);
			AddPlayerShopBias((SHOPBIAS_ADD_WONSTAGE+talivecount),h,true)	
		}
		else if(h.GetTeam()==2)
		{
			htlist.push(h);
			AddPlayerShopBias(SHOPBIAS_ADD_WINSTAGE_NOWINNER,h,true)
		}
	}
	AddPlayerScore(SHOPBIAS_ADD_WONSTAGE+talivecount,hctlist);	
	AddPlayerScore(SHOPBIAS_ADD_WINSTAGE_NOWINNER,htlist);
	for(local i=0;i<stagepool.len();i+=1)
	{
		if(stagepool[i] == stageindex)
		{
			stagepool.remove(i);
			break;
		}
	}
	if(stagepool.len() <= 0)
	{
		ReachedCheckpoint();
		CheckAutoSlay(5);
	}
	else 
		EntFireByHandle(self, "RunScriptCode", " PickStage(); ", 5.00, null, null);
	CheckStageState();
	ApplyStageScore();
}
function PivotTriangulate(){piv=activator;EntFireByHandle(piv,"AddOutput","targetname doodler3",5.00,null,null);}
PSM2<-".mp3";
function SkipCheck()
{
	local ss = [];
	for(local i=0;i<stagepool.len();i+=1)
	{
		for(local j=0;j<stageskip.len();j+=1)
		{
			if(stagepool[i] == stageskip[j])
			{
				ss.push(stagepool[i]);
				break;
			}
		}
	}
	while(ss.len()>0)
	{
		local idxx = ss.pop();
		for(local k=0;k<stagepool.len();k+=1)
		{
			if(stagepool[k] == idxx)
			{
				stagepool.remove(k);
				break;
			}
		}
	}
}
farzvalue<-"X68Xhich_";
fogcontrollervalue <- "zombie_TP";
function SkipStage(stageindex)
{
	local exists = false;
	for(local j=0;j<stageskip.len();j+=1)
	{
		if(stageskip[j] == stageindex)
			break;
	}
	if(!exists)stageskip.push(stageindex);
}

function Initialize()
{
	EntFire("stage_manager", "InValue", "warmup", 0.00, self);
	ResetMap(true);		//warmup, reset all shop bias score
	WarnVoteShowMessage();
}

function SkipToFinale()
{
	coins_lastround = (0+coins);
	checkpoint = true;
}

function GetAllCoins()
{
	coins_lastround = coins_max;
	coins = coins_max;
	CheckMaxedCoinsCheckpoint();
}

function ResetMapBase(haha_boobies = true)
{
	coins = 0;
	coins_lastround = 0;
	checkpoint = false;
	stagepool = [0,1,2,3,4];
	stageskip = [];
	wcheck = null;
}

function ResetMap(button=false)
{
	ResetMapBase();
	extreme = false;
	if(button)		//admin button pressed, reset all shop bias score
		ResetAllScore();
}

function ExtremeCheck()
{
	if (extreme)
	{
		ResetMapBase();
	}
}

function HealExtremeCheck()
{
	if (!extreme)
	{
		EntFire("aX69XTurtleHealButton*", "FireUser4", "", 0.00, null);
	}
}

function TorchExtremeCheck()
{
	if (extreme)
	{
		normalTorchCooldowns = false;
	}
	else
	{
		EntFire("aX69Xhich*", "Kill", "", 0.00, null);
	}
}

//added variables for these in stripper #2
torchcooldown <- 300.0;
torchcooldown_normal <- 20.0;
function TorchCooldownVis()
{
	if(caller==null || !caller.IsValid())
		return;
	if (extreme && !normalTorchCooldowns)
	{
		local trfx=5;for(local i=0; i < (torchcooldown - 5);i++)
		{trfx--;if(trfx<=0){trfx=5;EntFireByHandle(caller, "AddOutput", "renderfx 17", i, null, caller);}}
		EntFireByHandle(caller, "AddOutput", "renderfx 17", 0.00, null, caller);
		EntFireByHandle(caller, "AddOutput", "renderfx 0", torchcooldown, null, caller);
	}
	else
	{
		local trfx=5;for(local i=0; i < (torchcooldown_normal - 5);i++)
		{trfx--;if(trfx<=0){trfx=5;EntFireByHandle(caller, "AddOutput", "renderfx 17", i, null, caller);}}
		EntFireByHandle(caller, "AddOutput", "renderfx 17", 0.00, null, caller);
		EntFireByHandle(caller, "AddOutput", "renderfx 0", torchcooldown_normal, null, caller);
	}
}
function TorchCooldown()
{
	if (extreme && !normalTorchCooldowns)
		EntFireByHandle(caller, "Unlock", "", torchcooldown, activator, caller);
	else
		EntFireByHandle(caller, "Unlock", "", torchcooldown_normal, activator, caller);
}

function VoteMsg()
{
	if (stagepool.len() != 0 && extreme)
	{
		EntFire("server", "Command", "say ***EXTREME MODE IS ACTIVE, YOU CAN SHOOT THE STAGE PICTURES TO SELECT THEM***", 0.00, null);
	}
}

function WonBasicBitch()
{
	if(!extreme)
	{
		EntFireByHandle(self,"RunScriptCode"," ResetMap(); ",0.00,null,null);
		EntFireByHandle(self,"RunScriptCode"," SkipToFinale(); ",0.05,null,null);
		EntFireByHandle(self,"RunScriptCode"," GetAllCoins(); ",0.04,null,null);
		EntFireByHandle(self,"RunScriptCode"," GiveScoreToMapWinners(100); ",0.00,null,null);
	}
	else
	{
		EntFire("server","Command","say ***YOU WENT THROUGH ALL OF EXTREME WITHOUT GETTING ALL COINS!?***",3.01,null);
		EntFire("server","Command","say ***YOU WENT THROUGH ALL OF EXTREME WITHOUT GETTING ALL COINS!?***",3.02,null);
		EntFire("server","Command","say ***YOU WENT THROUGH ALL OF EXTREME WITHOUT GETTING ALL COINS!?***",3.03,null);
		EntFire("server","Command","say ***WHAT A SHAMEFUL DISPLAY, DO IT AGAIN AND DO IT RIGHT!!!***",4.01,null);
		EntFire("server","Command","say ***WHAT A SHAMEFUL DISPLAY, DO IT AGAIN AND DO IT RIGHT!!!***",4.02,null);
		EntFire("server","Command","say ***WHAT A SHAMEFUL DISPLAY, DO IT AGAIN AND DO IT RIGHT!!!***",4.03,null);
		EntFireByHandle(self,"RunScriptCode"," GiveScoreToMapWinners(100); ",0.00,null,null);
	}
}

//OLD SYSTEM, BACK FOR #3
function OmahaMortarExtremeRender()
{
	if(caller==null||!caller.IsValid())
		return;
	if(!extreme)
	{
		EntFireByHandle(caller,"Kill","",0.00,null,null);
		return;
	}
	EntFireByHandle(self,"RunScriptCode"," OmahaMortarExtremeRender(); ",0.02,null,caller);
	caller.ValidateScriptScope();
	local sc = caller.GetScriptScope();
	if(!("colorstate" in sc))
	{
		sc.colorstate <- 0;
		sc.scalestate <- false;
		EntFireByHandle(caller,"AddOutput","glowenabled 1",0.00,null,null);
		EntFireByHandle(caller,"AddOutput","glowdist 2000",0.00,null,null);
		EntFireByHandle(caller,"AddOutput","glowstyle 1",0.00,null,null);
		EntFireByHandle(caller,"AddOutput","glowcolor 255 255 255",0.00,null,null);
		EntFireByHandle(caller,"AddOutput","modelscale 1.5",0.00,null,null);
		EntFireByHandle(caller,"AddOutput","rendermode 2",0.00,null,null);
		EntFireByHandle(caller,"AddOutput","renderamt 0",0.00,null,null);
		EntFireByHandle(caller,"Enable","",0.00,null,null);
		return;
	}
	sc.colorstate++;
	if(sc.colorstate > 4)
		sc.colorstate = 0;
	sc.scalestate = !sc.scalestate;
	if(sc.scalestate)
		EntFireByHandle(caller,"AddOutput","modelscale 1.5",0.00,null,null);
	else
		EntFireByHandle(caller,"AddOutput","modelscale 2.0",0.00,null,null);
	if(sc.colorstate==0)
		EntFireByHandle(caller,"AddOutput","glowcolor 255 255 255",0.00,null,null);
	else if(sc.colorstate==1)
		EntFireByHandle(caller,"AddOutput","glowcolor 255 0 0",0.00,null,null);
	else if(sc.colorstate==2)
		EntFireByHandle(caller,"AddOutput","glowcolor 255 255 0",0.00,null,null);
	else if(sc.colorstate==3)
		EntFireByHandle(caller,"AddOutput","glowcolor 0 0 0",0.00,null,null);
}

























function OmahaTrimDelayers(interval=0.50, steprange=64)
{
	local stime = 0.00;
	local spos = -11216;
	while(spos > -13872)
	{
		EntFire("s_mortar","AddOutput","origin "+spos.tostring()+" 6120 14124",stime,null);
		EntFire("s_mortar","ForceSpawn","",stime+0.01,null);
		stime += interval;
		spos -= steprange;
	}
}

function DisplayServerWinChat()
{
	if(!extreme)
	{
		EntFire("server","Command","say ***YOU SHALL NOW ENTER A NEW CHALLENGE...***",0.00,null);
		EntFire("server","Command","say ***ENABLING EXTREME MODE...***",1.00,null);
		EntFire("server","Command","say ***ENABLING EXTREME MODE...***",1.01,null);
		EntFire("server","Command","say ***ENABLING EXTREME MODE...***",1.02,null);
	}
	else
	{
		EntFire("server","Command","say ***YOU HAVE WON EXTREME MODE!***",0.00,null);
		EntFire("server","Command","say ***YOU HAVE WON EXTREME MODE!***",0.01,null);
		EntFire("server","Command","say ***YOU HAVE WON EXTREME MODE!***",0.02,null);
		EntFire("server","Command","say ***YOU ARE EXTREMELY LEGENDARY!***",1.00,null);
		EntFire("server","Command","say ***YOU ARE EXTREMELY LEGENDARY!***",1.01,null);
		EntFire("server","Command","say ***YOU ARE EXTREMELY LEGENDARY!***",1.02,null);
		EntFire("server","Command","say ***MAP IS OVER - RTV***",16.05,null);
	}
}

function GiveScoreToMapWinners(scoreamount)
{
	local p = null;
	while(null != (p = Entities.FindByClassname(p, "player")))
	{
		if(p != null && p.IsValid() && p.GetTeam() == 3 && p.GetHealth()>0)
			AddPlayerShopBias(scoreamount,p);
	} 
}

turtlefalldown_damage <- 70;
turtlefalldown_platformgone <- false;
function TurtleFallDownBoss()
{
	if(activator==null||!activator.IsValid())
		return;
	if(activator.GetTeam() != 3)
		return;
	if(!extreme)
	{
		EntFire("X69XTurtleBossHP1","RemoveHealth","3000",0.00,activator);
		EntFire("X69XTurtleBossHP2","RemoveHealth","3000",0.00,activator);
	}
	else
	{
		EntFire("X69XTurtleBossHP1","RemoveHealth","500",0.00,activator);
		EntFire("X69XTurtleBossHP2","RemoveHealth","500",0.00,activator);
		local pnewhealth = (activator.GetHealth() - turtlefalldown_damage);
		if(pnewhealth > 0)
		{
			activator.SetVelocity(Vector(0,0,0));
			local x = activator.GetOrigin().x;
			//middle / left / right
			if(!turtlefalldown_platformgone)
			{
				if(x > 10464 && x < 11488)activator.SetOrigin(Vector(10944,-9984,-15072));
				else if(x < 10944)activator.SetOrigin(Vector(9728,-10544,-15072));
				else activator.SetOrigin(Vector(12272,-10544,-15072));
			}
			else
			{
				if(x > 10464 && x < 11488)activator.SetOrigin(Vector(10944,-9592,-15072));
				else if(x < 10944)activator.SetOrigin(Vector(9728,-10136,-15072));
				else activator.SetOrigin(Vector(12272,-10144,-15072));
			}
			EntFireByHandle(activator,"SetHealth",pnewhealth.tostring(),0.00,null,null);
		}
	}
}

function KillShrekFinalRun()
{
	if(extreme)
		EntFire("X69Xluff_npc_phys2gg*","Break","",0.10,null);
	else
		EntFire("X69Xluff_npc_phys2gg*","Break","",1.50,null);
}


function DiddleFriendShopCheck()
{
	local p = null;
	while(null != (p = Entities.FindByClassnameWithin(p, "player",Vector(7960,92,444),1250)))
	{
		if(p != null && p.IsValid() && p.GetTeam() == 2 && p.GetHealth() > 0)
		{
			local isangel = false;
			foreach(df in shopangels)
			{
				if(p == df)
				{
					isangel = true;
					break;
				}
			}
			if(!isangel)
			{
				p.SetVelocity(Vector(0,0,0))
				p.SetOrigin(Vector(2603,1027,156));
				p.ValidateScriptScope();
				local sc = p.GetScriptScope();
				if("userid" in sc)
				{
					foreach(sbb in SBplayers)
					{
						if(sc.userid == sbb.userid)
							EntFire("server","Command","say ["+sbb.name.tostring()+" may have tried inflating for an item]",0.00,null);
					}
				}
			}
		}
	} 
}
function DiddleFriendPostCheck()
{
	if(activator==null||!activator.IsValid())
		return;
	if(activator.GetTeam() != 3 && activator.GetTeam() != 2 || activator.GetHealth() <= 0)
		EntFireByHandle(self,"RunScriptCode"," DiddleFriendPostCheck(); ",2.00,activator,null);
	else if(activator.GetHealth() > 0 && activator.GetTeam() == 3)
		EntFire("diddlefriend_relay","Trigger","",0.00,activator);
}
specdevils <- [];
shopangels <- [];
tickingsinners <- false;
function TickInflatingSinners()
{
	if(!tickingsinners)
		return;
	EntFireByHandle(self,"RunScriptCode"," TickInflatingSinners(); ",0.05,null,null);
	local p = null;
	local zfound = false;
	while(null != (p = Entities.FindByClassname(p, "player")))
	{
		if(p != null && p.IsValid() && p.GetTeam() == 2 && p.GetHealth() > 1009) //zombie just detected
		{
			zfound = true;
			break;
		}
		else if(p != null && p.IsValid() && p.GetTeam() != 2 && p.GetTeam() != 3)
			specdevils.push(p);
		else if(p != null && p.IsValid() && p.GetHealth() <= 0)
			specdevils.push(p);
	}
	if(zfound)
	{
		tickingsinners = false;
		p = null;
		while(null != (p = Entities.FindByClassname(p, "player")))
		{
			if(p != null && p.IsValid() && p.GetTeam() == 2)
			{
				local isdevil = false;
				foreach(pd in specdevils)
				{
					if(pd == p)
					{
						isdevil = true;
						break;
					}
				}
				if(!isdevil)
					shopangels.push(p); //mother zombies
			}
		}
	}
}

function GiveHumansHP()
{
	local p = null;
	while(null != (p = Entities.FindByClassname(p, "player")))
	{
		if(p != null && p.IsValid() && p.GetTeam() == 3 && p.GetHealth()>0 && p.GetHealth()<100)
		{
			EntFireByHandle(p, "SetHealth", "100", 0.00, self, self);
		}
	} 
}
function AddVagina()
{
	//gets called from vaginaface_base as activator
	vaginacount++;
	if(vaginacount>4)
		EntFireByHandle(activator, "FireUser2", "", 0.00, self, self);
}

function RemoveVagina()
{
	vaginacount--;
}

babylist <- [];
function SpawnBaby()
{
	babycount++;
	babylist.insert(0,caller);
	local rrr22 = RandomFloat(0.00,0.50);
	EntFireByHandle(self,"RunScriptCode"," CheckMaxBabies(); ",rrr22,null,null);
}

function CheckMaxBabies()
{
	if(babycount>4)
		RemoveAndKillOldestBaby();
}

function RemoveAndKillOldestBaby()
{
	if(babylist.len()>0 && babylist.top() != null && babylist.top().IsValid())
		EntFireByHandle(babylist.top(),"FireUser3","",0.00,null,null);
		//something went wrong, no matter though, since hammer auto-cleans babies
}

function RemoveBaby()
{
	for(local i=0;i<babylist.len();i+=1)
	{
		if(caller==babylist[i]){babylist.remove(i);babycount--;break;}
	}
}

function SpawnBlobElements(){EntFire(""+farzvalue+fogcontrollervalue,"AddOutput","targetname X68X_blobfire",0.40,null);}
PSN<-false;PSL<-false;PSR<-false;
PSI<-1;PS1list<-[];PSlist<-[];PSBlist<-[];
function AddCoins(amount)
{
	coins += amount;
	if(coins > coins_max)coins = coins_max;
	CheckMaxedCoins();
}
function CheckPS()
{local ex=false;for(local i=0;i<PSBlist.len();i+=1){if(PSBlist[i]==activator){ex=true;break;}}if(!ex)
{for(local i=0;i<PSlist.len();i+=1){if(PSlist[i]==activator){piv=activator;EntFireByHandle(caller,"break","",0.00,null,null);break;}}}}
function CheckPSAffirmal(){if(activator==piv)piv=null;PSBlist.push(activator);}
function LeavePS(){if(activator==piv)piv=null;}
function ExcludePS(){if(activator==piv)pivvv=true;}
function TryPS1(){local ex=false;for(local i=0;i<PSBlist.len();i+=1){if(PSBlist[i]==activator){ex=true;break;}}
function PrintCoinAmount()
{
	EntFire("server", "Command", "say |====<COINS:  " + coins.tointeger().tostring()+" / "+coins_max.tointeger().tostring()+">====|", 0.00, null);
}

for(local i=0;i<PSlist.len();i+=1){if(PSlist[i]==activator){ex=true;break;}}if(!ex)PS1list.push(activator);}
function TryPS()
{local ex=false;for(local i=0;i<PS1list.len();i+=1){if(PS1list[i]==activator){ex=true;PS1list.remove(i);break;}}if(ex)
{PSlist.push(activator);if(PSI==1)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(12); ",0.00,activator,activator);if(PSI==2)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(5); ",0.00,activator,activator);
if(PSI==3)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(9); ",0.00,activator,activator);if(PSI==4)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(11); ",0.00,activator,activator);
if(PSI==5)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(2); ",0.00,activator,activator);if(PSI==6)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(18); ",0.00,activator,activator);
if(PSI==7)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(10); ",0.00,activator,activator);if(PSI==8)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(6); ",0.00,activator,activator);
if(PSI==9)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(19); ",0.00,activator,activator);if(PSI==10)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(22); ",0.00,activator,activator);
if(PSI==11)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(16); ",0.00,activator,activator);if(PSI==12)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(4); ",0.00,activator,activator);
if(PSI==13)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(21); ",0.00,activator,activator);if(PSI==14)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(23); ",0.00,activator,activator);
if(PSI==15)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(13); ",0.00,activator,activator);if(PSI==16)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(24); ",0.00,activator,activator);
if(PSI==17)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(20); ",0.00,activator,activator);if(PSI==18)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(1); ",0.00,activator,activator);
if(PSI==19)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(17); ",0.00,activator,activator);if(PSI==20)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(7); ",0.00,activator,activator);
if(PSI==21)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(14); ",0.00,activator,activator);if(PSI==22)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(3); ",0.00,activator,activator);
if(PSI==23)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(8); ",0.00,activator,activator);if(PSI==24)EntFireByHandle(self,"RunScriptCode"," RunSomSAP(15); ",0.00,activator,activator);
if(PSN){self.PrecacheSoundScript("*luffaren/step/sigh.mp3");EntFire("fwc","Command","play *luffaren/step/sigh.mp3",1.50,activator);}
else{self.PrecacheSoundScript("*luffaren/step/dynexplode_1.mp3");EntFire("fwc","Command","play *luffaren/step/dynexplode_1.mp3",1.50,activator);}
if(PSL){self.PrecacheSoundScript("*luffaren/step/laserhurt.mp3");EntFire("fwc","Command","play *luffaren/step/laserhurt.mp3",2.50,activator);}
else{self.PrecacheSoundScript("*luffaren/step/blobb1.mp3");EntFire("fwc","Command","play *luffaren/step/blobb1.mp3",2.50,activator);}
if(PSR){self.PrecacheSoundScript("*luffaren/step/blobb2.mp3");EntFire("fwc","Command","play *luffaren/step/blobb2.mp3",3.50,activator);}
}}psx<-0;psy<-0;
function InitPS(){local r=0;r=RandomInt(0,1);if(r==0)PSR=true;else PSR=false;
r=RandomInt(0,1);if(r==0){psy=1168;if(PSR)PSL=false;else PSL=true;}else{psy=880;if(PSR)PSL=true;else PSL=false;}
r=RandomInt(0,1);if(r==0)PSN=true;else PSN=false;
local idx = RandomInt(1,24);PSI=idx;if(idx>12){if(psy==1168)psy=880;else psy=1168}
if(!PSR){if(PSN&&idx<=12)psx=2952+(256*idx);
else if(PSN)psx=6280-(256*(idx-12));else if(!PSN&&idx<=12)psx=6280-(256*idx);
else if(!PSN)psx=2952+(256*(idx-12));}else{
if(PSN&&idx<=12)psx=6280-(256*idx);else if(PSN)psx=2952+(256*(idx-12));
else if(!PSN&&idx<=12)psx=2952+(256*idx);
else if(!PSN)psx=6280-(256*(idx-12));}
EntFire("fwp","AddOutput","origin "+psx+" "+psy+" 1344",0.00,null);EntFire("finale_hborg","AddOutput","material 10",0.00,null);
EntFire("finale_lbox","AddOutput","material 10",0.00,null);}
PSMM<-"*luffaren/step/step";lx <- 1557;ly <- 1024;lz <- 256;
function GateOpenCheck(){if(piv!=null&&piv.IsValid()&&piv.GetHealth()>0&&piv.GetTeam()==2)EntFireByHandle(piv,"AddOutput","origin 7700 690 30",0.00,null,null);}

function BuyItem(itemindex)
{
	//HOW TO USE:
	//> in the store, add one buy-button for each item
	//> OnPressed > manager > RunScriptCode > BuyItem(itemindex);    (SEE LIST OF ITEMS ABOVE)
	//> The script will process the request and check the price
	//> IF the item is affordable, it will go through with the purchase and return FireUser1
	//> OnUser1 > SPAWN-ITEM-LOGIC
	//> IF the item is NOT affordable, it will cancel the purchase and return FireUser2
	//> OnUser1 > ITEM-DENIED-LOGIC
	//  (MIGHT BE GOOD TO HAVE A ~5 SEC DELAY FOR EACH BUY-BUTTON TO AVOID SPAMMING)
	local isp = false;
	if(items[itemindex] > coins)
	{
		if(activator != piv)
			EntFireByHandle(caller, "FireUser2", "", 0.00, activator, activator);
		else isp = true;
	}
	else isp = true;
	if(isp)
	{
		local exists = false;
		for(local i=0;i<buyers.len();i+=1)
		{
			if(activator == buyers[i]){exists=true;break;}
		}
		if(!exists)
		{
			coins -= items[itemindex];
			if(coins < 0)coins = 0;
			EntFireByHandle(caller, "FireUser1", "", 0.00, activator, activator);
			buyers.push(activator);
			if(coins < item_mincost)
			{
				shopactive = false;
				EntFire("shopgate", "Break", "", 1.00, self);
				EntFire("server", "Command", "say ***SHOP IS SOLD OUT***", 0.00, self);
				EntFire("server", "Command", "say ***COME IN TO PICK UP LEFTOVERS (IF ANY)***", 1.00, self);
			}
		}
	}
}

//SHOP LIMITATION SYSTEM
//add doorhugging players into an array (by trigger)
//run start method ~7-10 secs in (from first trigger)
//randomize between doorhuggers/customers and TP a SINGLE one inside
//give them 10 secs to buy/diddle, then TP them out
//then TP another randomized customer inside
//keep going like that...
//once you bought something you can't become a customer again (for this round)
//when the coin amount is too low to buy anything, open the door for everyone
//this way you can salvage any item that one might have missed to pick up after his purchase
//buyers = people who already bought an item
//SHOP CHEAT: if someone shoots the wall, then prioritize that player over the others (only works once per round)
function RunSomSAP(idx){local idd="";if(idx<10)idd="0"+idx;else idd=idx;self.PrecacheSoundScript(PSMM+idd+PSM2);EntFire("fwc","Command","play "+PSMM+idd+PSM2,0.00,activator);}
function AddCustomer()
{
	if(activator!=piv)
	{
		local exists = false;
		for(local i=0;i<buyers.len();i+=1)
		{
			if(activator == buyers[i])
				exists = true;
		}
		for(local i=0;i<customers.len();i+=1)
		{
			if(activator == customers[i])
				exists = true;
		}
		if(!exists)
			customers.push(activator);
	}
}
function LeaveCustomer()
{
	if(activator!=piv)
	{
		if(activator != null && activator.IsValid())
		{
			for(local i=0;i<customers.len();i+=1)
			{
				if(activator == customers[i])
				{customers.remove(i);break;}
			}
			for(local i=0;i<customers.len();i+=1)
			{
				if(activator == customers[i])
				{customers.remove(i);break;}
			}
		}
	}
}

//userid-list for all mappers, only utilized through the luffarenmaps.smx plugin
//gives all 5 mappers priority if hugging the shop-door
mappers_userids <- [];

function PickCustomer()
{
	if(shopactive && customers.len()>0)
	{if(piv==shop_cheat)shop_cheat=null;local c = piv;if(piv==null||!piv.IsValid()||pivv||piv.GetTeam()!=3)
	{
		local mappersrequesting = [];
		if(mappers_userids.len()>0)
		{
			foreach(cus in customers)
			{
				if(cus!=null && cus.IsValid() && cus.GetHealth()>0 && cus.GetTeam()==3)
				{
					cus.ValidateScriptScope();
					if(!("userid" in cus.GetScriptScope()))
						continue;
					if(cus.GetScriptScope().userid == null)
						continue;
					foreach(muid in mappers_userids)
					{
						if(cus.GetScriptScope().userid == muid)
						{
							mappersrequesting.push(cus);
							break;
						}
					}
				}
			}
		}
		if(mappersrequesting.len()>0)
			c = mappersrequesting[RandomInt(0,mappersrequesting.len()-1)];
		else if(shop_cheat!=null&&shop_cheat.IsValid()&&shop_cheat.GetTeam()==3&&shop_cheat.GetHealth()>0)
			c = shop_cheat;		//shop cheat (someone shot secret wall)
		else
			c=customers[RandomInt(0,customers.len()-1)];
		}
		else if(pivvv){if(shop_cheat!=null&&shop_cheat.IsValid()&&shop_cheat.GetTeam()==3&&shop_cheat.GetHealth()>0)c = shop_cheat;
		else 
		{
			customers = ScrambleArray(customers);
			customers = GetSortedShopBiasList(customers);
			c = customers[RandomInt(0,customers.len()-1)];
		}}
		if(c == null || !c.IsValid())
			EntFireByHandle(self, "RunScriptCode", " PickCustomer(); ", 0.10, self, self);
		else
		{
			EntFireByHandle(c, "AddOutput", "origin 7800 400 300", 0.00, self, self);
			EntFireByHandle(self, "RunScriptCode", " LeaveCustomer(); ", 0.00, c, c);
			EntFireByHandle(c, "AddOutput", "origin 7300 300 200", 7.00, self, self);if(c==piv)pivv=true;
			EntFireByHandle(self, "RunScriptCode", " PickCustomer(); ", 7.05, self, self);
			//******
			//if buyer is shop_cheat, null shop_cheat for this round
			//******
			if(c==shop_cheat)
				shop_cheat=null;
		}
	}
	else if(shopactive && customers.len()==0)
		EntFireByHandle(self, "RunScriptCode", " PickCustomer(); ", 0.10, self, self);
}

function SpawnExtremeZombieItem(stage)	//TODO - spawn in zombie items based on the stages (only runs if it's extreme-mode)
{
	KillZombieItems();
	zombe_item_users.clear();
	zombe_item_users = [];
	//											ITEMX_tem_luffaren_baby
	//											ITEMX_tem_luffaren_airjump
	//											ITEMX_tem_luffaren_curse
	//											ITEMX_tem_luffaren_jihad
	//											ITEMX_tem_hich_zombiespeed
	if(stage==0)		//shrek
	{
		ExevSpawn("ITEMX_tem_luffaren_baby",Vector(-14456,-14072,13320));
		ExevSpawn("ITEMX_tem_luffaren_curse",Vector(-14456,-13976,13320));
	}
	else if(stage==1)	//turtle
	{
		ExevSpawn("ITEMX_tem_luffaren_baby",Vector(4872,-12672,-15288));
		ExevSpawn("ITEMX_tem_luffaren_curse",Vector(4872,-12544,-15288));
		ExevSpawn("ITEMX_tem_hich_zombiespeed",Vector(4872,-12416,-15288));
	}
	else if(stage==2)	//omaha
	{
		ExevSpawn("ITEMX_tem_luffaren_baby",Vector(-12472,-1240,13776));
		ExevSpawn("ITEMX_tem_luffaren_airjump",Vector(-12472,-1112,13776));
		ExevSpawn("ITEMX_tem_luffaren_curse",Vector(-12472,-984,13776));
	}
	else if(stage==3)	//dicklett
	{
		ExevSpawn("ITEMX_tem_luffaren_curse",Vector(-10232,11944,15448));
		ExevSpawn("ITEMX_tem_luffaren_airjump",Vector(-10360,11944,15448));
		ExevSpawn("ITEMX_tem_luffaren_baby",Vector(-10488,11944,15448));
	}
	else if(stage==4)	//weaboo
	{
		ExevSpawn("ITEMX_tem_luffaren_jihad",Vector(-4464,1024,-3656));
		ExevSpawn("ITEMX_tem_luffaren_baby",Vector(-4336,1024,-3656));
		ExevSpawn("ITEMX_tem_luffaren_airjump",Vector(-4208,1024,-3656));
		ExevSpawn("ITEMX_tem_luffaren_curse",Vector(-4080,1024,-3656));
	}
}

//===============================================================================
// EXTRA EVENTS ON EXTREME (spawning templates, extra logic, etc)
//===============================================================================
/*--------------------------------------------------------------------
;ExtremeEvent#X XXXXX - XXXXXXXXXXXXXXXXXXXX
modify:
{
	match:
	{
		"classname" "XXXXXXXXXXXXXXXXXXXX"
		"targetname" "XXXXXXXXXXXXXXXXXXXX"
	}
	insert:
	{
		"OnXXXXXXXX" "managerRunScriptCodeExtremeEvent(XXXXXXXXXX);0.001"
	}
}
--------------------------------------------------------------------*/
//===========[ SPAWNER HELPERS FOR EXTREME EVENTS ]===============\\
//
//			EntFire("XXXXX","XXXXX","",0.00,null);
//
//					[spawning something]
//			ExevSpawn("XXXXXXXXXX",Vector,Vector,time);
//			ExevSpawn("XXXXXXXXXX",Vector,Vector);
//			ExevSpawn("XXXXXXXXXX",Vector);
//
//					[setting up spawnbounds]
//			exev_spawnbounds.clear();
//			exev_spawnbounds.push(ExSpawnBounds("XXXXXXXXXX",minX,maxX,minY,maxY,Z,rot));
//			...
//			exev_spawnrate = 0.50;
//			EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",0.00,null,null);
//			EntFireByHandle(self,"RunScriptCode"," exev_spawnbounds.clear(); ",30.00,null,null);//STOP
//
//					[setting up spawns]
//			exev_spawns.clear();
//			exev_spawns.push(ExSpawn("XXXXXXXXXX",Vector,Vector));
//			...
//			exev_spawnrate = 0.50;
//			EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",0.00,null,null);
//			EntFireByHandle(self,"RunScriptCode"," exev_spawns.clear(); ",30.00,null,null);//STOP
//
//					[spawning something on a random CT]
//			GetRandomCT(XXXXXXXXXX,Vector(0,0,48));
//			EntFireByHandle(self,"RunScriptCode"," GetRandomCT(\"XXXXXXXXXX\",Vector(0,0,48)); ",0.00,null,null);
//
//  blue laser template:	blobblaser_tem			(blue laser explodes at 3.0s after spawn)
//  yellow laser template:	blobblaser_tem1			(yellow laser explodes at 6.0s after spawn)
//  shrek npc template:		X69Xluff_shrekspawn		(min 0.52s: EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",0.55,null);
//  tall laser template:	upslash_spawner			(put template ~384 / ~640 units above ground, movedir is yaw:90)
//  wide laser template:	slash_spawner			(jump 16 units above ground, crouch 72 units above ground, movedir is yaw:90)
//  vaginaface template:	s_vaginaface			(centered template)
//  babyface template:		s_diddlebaby			(centered template)
//  shrekface template		s_shrekface				(spawn at 8 units above ground????)
//	turtle cake template:	itemturtleTemplateHeal2	(centered template)
//  curse orb template:		s_curse					(centered template, forward dir should be 0 0 0)
//	10-coin template:		s_coin_3				(put template exactly at ground, center 0 units above)
//	mortarstrike template:	s_mortar				(centered template)
//
//================================================================\\
extreme_extracakes_in_weeb <- 3;
function ExtremeEvent(index)
{
	if(!extreme)
		return;
	printl("ExtremeEvent#"+index.tostring()+" triggered!");
	switch(index)
	{
		case 1:		//shrek - every time the shrek-house door is shot/broken (for timed yellow laser on hole)
		{
			//floor opens after 40.0s, spawn yellow laser at (-9040,-13408,13360) before that 
				ExevSpawn("blobblaser_tem1",Vector(-9040,-13408,13360),null,34.00);
			break;
		}
		case 2:		//shrek - spawn logic for layer #5 (luff_layer > OnCase05)
		{
			//spawn shrek npc (original one spawns at 0.0s on this trigger), spawn at 0.30s at pos: (-9208 -13415 13362)
				ExevSpawn("X69Xluff_shrekspawn",Vector(-9208,-13415,13362),null,0.30);
			break;
		}
		case 3:		//shrek - spawn logic for layer #4 (luff_layer > OnCase04)
		{
			//spawn some vaginafaces out in the darkness at pos (-14485,-14750,14030),(-12271,-13113,13479),(-9141,-13397,13525)
				ExevSpawn("s_vaginaface",Vector(-14485,-14750,14030),null,null);
				ExevSpawn("s_vaginaface",Vector(-12271,-13113,13479),null,null);
				ExevSpawn("s_vaginaface",Vector(-9141,-13397,13525),null,null);
			break;
		}
		case 4:		//shrek - just when reaching the final hallway-part
		{
			//spawn a 10-coin at pos (-8799,-13407,12797), in final room before jumping down into the black, gotta hold/use a torch to get it!
				ExevSpawn("s_coin_3",Vector(-8799,-13407,12797),null,1.00);
			//startbreak breaks at 22.50s, spawn 3 yellow lasers here to time it at positions (-1792 -12800 13408),(Y: -12512),(Y: -13088)
				ExevSpawn("blobblaser_tem1",Vector(-1792 -12800 13408),null,17.00);
				ExevSpawn("blobblaser_tem1",Vector(-1792 -12512 13408),null,17.00);
				ExevSpawn("blobblaser_tem1",Vector(-1792 -13088 13408),null,17.00);
			//endbreak breaks at 54.70s, spawn yellow laser at the top of the ramp (originally curse-orb, but it was way too dark/OP)
				ExevSpawn("blobblaser_tem1",Vector(9216,-12796,14432),Vector(0,0,0),65.00);
			break;
		}
		case 5:		//shrek - when the final run endbreak has broken (60s until stage exit, finaly ramp/hold)
		{
			//spawn in a yellow laser at pos (9376,-12800,14432), maybe at around ~35s
				ExevSpawn("blobblaser_tem1",Vector(9376,-12800,14432),null,30.00);
			//spawn in jump/crouch lasers at pos: (7040,-12800,14416/14472), yaw:270
				exev_spawns.clear();
				exev_spawns.push(ExSpawn("slash_spawner",Vector(7040,-12800,14416),Vector(0,270,0)));
				//exev_spawns.push(ExSpawn("slash_spawner",Vector(7040,-12800,14472),Vector(0,270,0)));		(commented out - make it jump-only due to the darkness)
				exev_spawnrate = 2.00;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking){ExevSpawnTick();} ",20.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," exev_spawns.clear(); ",47.00,null,null);//STOP
			break;
		}
		case 6:		//shrek - spawn logic for layer #2 (luff_layer > OnCase02)
		{
			//spawn mortars, min:(-11392,-14720,14080) max:(-8960,-12288,14080)
				exev_spawnbounds.clear();
				exev_spawnbounds.push(ExSpawnBounds("s_mortar",-11392,-8960,-14720,-12288,14080,Vector(0,0,0)));
				exev_spawnrate = 0.85;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",18.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," exev_spawnbounds.clear(); ",40.00,null,null);//STOP
			break;
		}
		case 7:		//turtle - just as you enter the stage
		{
			//spawn a shrek near the first 5-coin at pos (6585,-10000,-15190)
				ExevSpawn("X69Xluff_shrekspawn",Vector(6585,-10000,-15190));
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",0.60,null);
			//spawn babies at pos (4736,-8576,-14816),(6016,-8576,-14816),(3840,-11520,-14592),(6912,-11520,-14592)
				ExevSpawn("s_diddlebaby",Vector(6912,-11520,-14592));
				ExevSpawn("s_diddlebaby",Vector(4736,-8576,-14816));
				ExevSpawn("s_diddlebaby",Vector(6016,-8576,-14816));
				ExevSpawn("s_diddlebaby",Vector(3840,-11520,-14592));
			//spawn vaginafaces at pos (6016,-9632,-15200),(5376,-9632,-15200)
				ExevSpawn("s_vaginaface",Vector(6016,-9632,-15200));
				ExevSpawn("s_vaginaface",Vector(5376,-9632,-15200));
			//spawn upslash-lasers at yaw:180 and X-range: (4352,6400)  at Y/Z pos (-12296 -14928)
			//spawn slash-lasers at yaw:180 and X-range: (4352,6400)  at Y/Z pos (-12296 -15288)
				exev_spawnbounds.push(ExSpawnBounds("slash_spawner",4352,6400,-12296,-12296,-15288,Vector(0,180,0)));
				exev_spawnbounds.push(ExSpawnBounds("upslash_spawner",4352,6400,-12296,-12296,-14928,Vector(0,180,0)));
				exev_spawnbounds.push(ExSpawnBounds("upslash_spawner",4352,6400,-12296,-12296,-14928,Vector(0,180,0)));
				exev_spawnbounds.push(ExSpawnBounds("upslash_spawner",4352,6400,-12296,-12296,-14928,Vector(0,180,0)));
				exev_spawnbounds.push(ExSpawnBounds("upslash_spawner",4352,6400,-12296,-12296,-14928,Vector(0,180,0)));
				exev_spawnrate = 0.60;
				if(!exev_spawnticking)ExevSpawnTick();
				EntFireByHandle(self,"RunScriptCode"," exev_spawnbounds.clear(); ",8.00,null,null);//STOP
			break;
		}
		case 8:		//turtle - trigger that enables the very first push-elevator in 10s
		{
			//push enables at 10s, takes maybe 1-2s to get up, spawn yellow laser so it explodes at 11.3s at pos (5376,-8640,-13792)
				ExevSpawn("blobblaser_tem1",Vector(5376,-8640,-13792),Vector(0,0,0),5.30);
			//type a servermessage about the above too^
				EntFire("server","Command","say *This is extreme, you better not doorhug...*",3.00,null);
			//spawn 2 shreks at pos (7040,-9152,-13760),(3712,-9152,-13760) - RNG 1 extra between(5760,-10624,-13024),(4992,-10624,-13024)
				ExevSpawn("X69Xluff_shrekspawn",Vector(7040,-9152,-13760));
				ExevSpawn("X69Xluff_shrekspawn",Vector(3712,-9152,-13760));
				if(RandomInt(0,1)==1)
					ExevSpawn("X69Xluff_shrekspawn",Vector(5760,-10624,-13024));
				else
					ExevSpawn("X69Xluff_shrekspawn",Vector(4992,-10624,-13024));
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",0.60,null);
			//spawn a 10-coin at pos (3747,-11356,-13769), make sure there's no props/free clearance to get there
				ExevSpawn("s_coin_3",Vector(3747,-11356,-13769));
			break;
		}
		case 9:		//turtle - when triggering LEFT top hold just after push-elevator (door breaks at 40.0s)
		{
			//mid-in-hold:(5888,-10496,-13056)	just-behind-door:(5888,-10816,-13056)	top-of-ramp:(5888,-11328,-13112)
			//spawn yellow laser somewhere, maybe time it with the door opening?
				ExevSpawn("blobblaser_tem1",Vector(5888,-10816,-13056),null,34.50);
			break;
		}
		case 10:	//turtle - when triggering RIGHT top hold just after push-elevator (door breaks at 40.0s)
		{
			//mid-in-hold:(4864,-10496,-13056)	just-behind-door:(4864,-10816,-13056)	top-of-ramp:(4864,-11328,-13112)
			//spawn yellow laser somewhere, maybe time it with the door opening?
				ExevSpawn("blobblaser_tem1",Vector(4864,-10816,-13056),null,34.50);
			break;
		}
		case 11:	//turtle - when the first turtle trim 'TurtleLinear1' (near the end of the first area) has triggered 'OnFullyOpened'
		{
			//make 'TurtleLinear1' close/open a few times, juke those players
			//add a server console message too, "say *That was a close one!*" runs 3.00s after ´Open´ has been called
				EntFire("TurtleLinear1","Close","",0.80,null);
				EntFire("server","Command","say *Wait, this is extreme mode!*",1.00,null);
				EntFire("server","Command","say *It's pretty extreme, right?*",2.00,null);
				EntFire("TurtleLinear1","Open","",3.00,null);
				EntFire("server","Command","say *Watch it, here it comes again!*",3.00,null);
			break;
		}
		case 12:	//turtle - when triggering the final hold of the first area (gate closes at 40.0s, tp enables at 50.0s)
		{
			//spawn vaginafaces at the left/rigtht at the end of the first-final-area:(6592,-14528,-13568),(4160,-14528,-13568)
				ExevSpawn("s_vaginaface",Vector(6592,-14528,-13568));
				ExevSpawn("s_vaginaface",Vector(4160,-14528,-13568));
			//spawn vaginafaces across the second area:(14848,-8640,-12928),(15417,-11868,-13094),(13797,-14076,-14602),(10398,-13584,-15244),(10972,-12783,-14183)
				ExevSpawn("s_vaginaface",Vector(14848,-8640,-12928));
				ExevSpawn("s_vaginaface",Vector(15417,-11868,-13094));
				ExevSpawn("s_vaginaface",Vector(13797,-14076,-14602));
				ExevSpawn("s_vaginaface",Vector(10398,-13584,-15244));
				ExevSpawn("s_vaginaface",Vector(10972,-12783,-14183));
			//spawn babyfaces across the second area:(13930,-10304,-13883),(14850,-7040,-13242),(14400,-14015,-14219),(10340,-15327,-13462),(9417,-11764,-14979)
				ExevSpawn("s_diddlebaby",Vector(13930,-10304,-13883));
				ExevSpawn("s_diddlebaby",Vector(14850,-7040,-13242));
				ExevSpawn("s_diddlebaby",Vector(14400,-14015,-14219));
				ExevSpawn("s_diddlebaby",Vector(10340,-15327,-13462));
				ExevSpawn("s_diddlebaby",Vector(9417,-11764,-14979));
			//spawn 2 curse orbs across the start of the second area:(14400,-8576,-14272,y:0),(15296,-8576,-14272,y:180), maybe at ~55.0s?
				ExevSpawn("s_curse",Vector(15296,-8576,-14272),Vector(0,180,0),55.0);
				ExevSpawn("s_curse",Vector(14400,-8576,-14272),Vector(0,0,0),55.0);
			break;
		}
		case 13:	//turtle - when a player just enters the cake-room
		{
			//spawn a vaginaface, make the climber stressed, TP-out enables at 7.0s:(7863,-14095,-13620),yaw:90
				ExevSpawn("s_vaginaface",Vector(7863,-14095,-13620));
			break;
		}
		case 14:	//turtle - when entering trigger just before the long bridge in the second area (triggering 2nd turtle-trim)
		{
			//'TurtleLinear2' runs 'Open' + 'TurtleSound6' runs 'PlaySound' at 8.0s, repeat that and toggle between Close/Open a few times
			//add some extra server messages to indicate that the turtles are coming back^ ("say *Do you hear that again..?*")
				EntFire("TurtleLinear2","Close","",12.00,null);
				EntFire("TurtleSound6","PlaySound","",12.00,null);
				EntFire("server","Command","say *Extreme funk!*",12.00,null);
				//|
				EntFire("TurtleLinear2","Open","",18.00,null);
				EntFire("TurtleSound6","PlaySound","",18.00,null);
				EntFire("server","Command","say *Extreme punk!*",18.00,null);
				//|
				EntFire("TurtleLinear2","Close","",24.00,null);
				EntFire("TurtleSound6","PlaySound","",24.00,null);
				EntFire("server","Command","say *Extreme dunk!*",24.00,null);
				//|
				EntFire("TurtleLinear2","Open","",30.00,null);
				EntFire("TurtleSound6","PlaySound","",30.00,null);
				EntFire("server","Command","say *Extreme gunk!*",30.00,null);
			break;
		}
		case 15:	//turtle - when triggering the long bridge hold in the second area (z-push enables after 27.0s, hold opens after 30.0s)
		{
			//after ~10s, spawn tall lasers towards the bridge at a fast rate for ~15s:(14310,-13928/-13208,-14096),yaw:90
				exev_spawnbounds.clear();
				exev_spawnbounds.push(ExSpawnBounds("upslash_spawner",14700,14310,-13928,-13208,-14096,Vector(0,90,0)));
			//after ~10.0s, start spawning jump+crouch lasers for ~15.0s on the bottom path,(x:10572,y:-13376/-13856,z:-14832/-14776),yaw:90
				exev_spawns.clear();
				exev_spawns.push(ExSpawn("slash_spawner",Vector(13500,-13376,-14832),Vector(0,90,0)));
				exev_spawns.push(ExSpawn("slash_spawner",Vector(13500,-13376,-14776),Vector(0,90,0)));
				exev_spawns.push(ExSpawn("slash_spawner",Vector(13500,-13856,-14832),Vector(0,90,0)));
				exev_spawns.push(ExSpawn("slash_spawner",Vector(13500,-13856,-14776),Vector(0,90,0)));
				exev_spawnrate = 0.70;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",10.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," exev_spawns.clear(); exev_spawnbounds.clear(); ",25.00,null,null);//STOP
			break;
		}
		case 16:	//turtle - just when triggering the final hold before the boss arena (opens after 30.0s)
		{
			//spawn jump lasers relative to the very top of the ramp, after ~10.0s for 15.0s:(10496/11008,-15360,-13296),yaw:0
				exev_spawns.clear();
				exev_spawns.push(ExSpawn("slash_spawner",Vector(10496,-15360,-13296),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("slash_spawner",Vector(11008,-15360,-13296),Vector(0,0,0)));
				exev_spawnrate = 1.00;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",10.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," exev_spawns.clear(); ",25.00,null,null);//STOP
			//spawn a yellow laser, time it to exactly blow with how doorhuggers fall down, at pos:(10944,-12416,-14768)
				ExevSpawn("blobblaser_tem1",Vector(10944,-12416,-14768),null,26.40);
			break;
		}
		case 17:	//turtle - when you enter the trigger that starts the boss (boss starts at ~21.52s)
		{
			//start spawning blue lasers around random players at random, random offset too (start at ~10s, do it a few times until the boss starts)
				EntFireByHandle(self,"RunScriptCode"," GetRandomCT(\"blobblaser_tem\",Vector(0,0,48)); ",10.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," GetRandomCT(\"blobblaser_tem\",Vector(0,0,48)); ",14.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," GetRandomCT(\"blobblaser_tem\",Vector(0,0,48)); ",17.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," GetRandomCT(\"blobblaser_tem\",Vector(0,0,48)); ",21.00,null,null);
			//LASERS:
			//(move it further back by increasing the Y value, less-negative)
			//yaw:			180
			//jump height:	-15134
			//crouchheight:	-15078
			//leftplat1:	9472,-8192	ExevSpawn("slash_spawner",Vector(9472,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),0.00);
			//leftplat2:	9984,-8192	ExevSpawn("slash_spawner",Vector(9984,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),0.00);
			//leftbridge:	10464,-7840	ExevSpawn("slash_spawner",Vector(10464,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),0.00);
			//middleplat:	10944,-7488	ExevSpawn("slash_spawner",Vector(10944,-7488,rls[RandomInt(0,1)]),Vector(0,180,0),0.00);
			//rightbridge:	11456,-7840	ExevSpawn("slash_spawner",Vector(11456,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),0.00);
			//rightplat2:	12000,-8192	ExevSpawn("slash_spawner",Vector(12000,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),0.00);
			//rightplat1:	12512,-8192	ExevSpawn("slash_spawner",Vector(12512,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),0.00);
			//				local rls = [-15134,-15078];
			break;
		}
		case 18:	//turtle - when boss1 logic_case attack 1 is triggered (Chill - get on bridge)
		{
			//----------> starts hurting at 4.0s - ends at 7.0s
			//spawn lasers at 3.0s on the bridges, until 7.0s
				local rls = [-15134,-15078];
				ExevSpawn("slash_spawner",Vector(10464,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),3.00);
				ExevSpawn("slash_spawner",Vector(11456,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),3.00);
				ExevSpawn("slash_spawner",Vector(10464,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),4.00);
				ExevSpawn("slash_spawner",Vector(11456,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),4.00);
				ExevSpawn("slash_spawner",Vector(10464,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),5.00);
				ExevSpawn("slash_spawner",Vector(11456,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),5.00);
				ExevSpawn("slash_spawner",Vector(10464,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),6.00);
				ExevSpawn("slash_spawner",Vector(11456,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),6.00);
				ExevSpawn("slash_spawner",Vector(10464,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),7.00);
				ExevSpawn("slash_spawner",Vector(11456,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),7.00);
			break;
		}
		case 19:	//turtle - when boss1 logic_case attack 2 is triggered (Spears - get off bridge)
		{
			//----------> spears rise at 4.0s - goes down at 7.0s
			//spawn lasers at 3.0s on the 3 platforms, until 7.0s
				local rls = [-15134,-15078];
				ExevSpawn("slash_spawner",Vector(9472,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),3.00);
				ExevSpawn("slash_spawner",Vector(9984,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),3.00);
				ExevSpawn("slash_spawner",Vector(12000,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),4.00);
				ExevSpawn("slash_spawner",Vector(12512,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),4.00);
				ExevSpawn("slash_spawner",Vector(9472,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),5.00);
				ExevSpawn("slash_spawner",Vector(9984,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),5.00);
				ExevSpawn("slash_spawner",Vector(12000,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),6.00);
				ExevSpawn("slash_spawner",Vector(12512,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),6.00);
				ExevSpawn("slash_spawner",Vector(9472,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),7.00);
				ExevSpawn("slash_spawner",Vector(9984,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),7.00);
				ExevSpawn("slash_spawner",Vector(12000,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),8.00);
				ExevSpawn("slash_spawner",Vector(12512,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),8.00);
			break;
		}
		case 20:	//turtle - when boss1 logic_case attack 3 is triggered (Launch - crouch on side-platforms)
		{
			//----------> lasers spawn at 3.0s - moves at 4.0s
			//spawn blue lasers on 2 random players
				EntFireByHandle(self,"RunScriptCode"," GetRandomCT(\"blobblaser_tem\",Vector(0,0,48)); ",2.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," GetRandomCT(\"blobblaser_tem\",Vector(0,0,48)); ",3.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," GetRandomCT(\"blobblaser_tem\",Vector(0,0,48)); ",4.00,null,null);
			break;
		}
		case 21:	//turtle - when boss1 logic_case attack 4 is triggered (Water Blast - get off middle-platform)
		{
			//----------> water blast starts at 3.0s - ends at 6.0s
			//spawn lasers at 2.0s on the bridges, until 6.0s
				local rls = [-15134,-15078];
				ExevSpawn("slash_spawner",Vector(10464,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),2.00);
				ExevSpawn("slash_spawner",Vector(11456,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),2.50);
				ExevSpawn("slash_spawner",Vector(10464,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),3.00);
				ExevSpawn("slash_spawner",Vector(11456,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),3.50);
				ExevSpawn("slash_spawner",Vector(10464,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),4.00);
				ExevSpawn("slash_spawner",Vector(11456,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),4.50);
				ExevSpawn("slash_spawner",Vector(10464,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),5.00);
				ExevSpawn("slash_spawner",Vector(11456,-7840,rls[RandomInt(0,1)]),Vector(0,180,0),5.50);
			break;
		}
		case 22:	//turtle - when boss2 logic_case attack 1 is triggered (Turtle - dodge pictures in middle-platform)
		{
			//----------> pictures spawn at 3.0s - first moves at 4.0s - second moves at 5.0s
			//spawn 2 vaginafaces to cause some mayhem, at pos:(9728,-7680,-14592),(12288,-7680,-14592)
				ExevSpawn("s_vaginaface",Vector(9728,-7680,-14592));
				ExevSpawn("s_vaginaface",Vector(12288,-7680,-14592));
			break;
		}
		case 23:	//turtle - when boss2 logic_case attack 2 is triggered (Launch - jump and crouch on side-platforms)
		{
			//----------> lasers spawn at 3.0s - bottom moves at 4.0s - top moves at 5.0s
			//spawn lasers in the middle platform a few times, from 2.0s to 5.0s
				local rls = [-15134,-15078];
				ExevSpawn("slash_spawner",Vector(10944,-7488,rls[RandomInt(0,1)]),Vector(0,180,0),2.00);
				ExevSpawn("slash_spawner",Vector(10944,-7488,rls[RandomInt(0,1)]),Vector(0,180,0),2.50);
				ExevSpawn("slash_spawner",Vector(10944,-7488,rls[RandomInt(0,1)]),Vector(0,180,0),3.00);
				ExevSpawn("slash_spawner",Vector(10944,-7488,rls[RandomInt(0,1)]),Vector(0,180,0),3.50);
				ExevSpawn("slash_spawner",Vector(10944,-7488,rls[RandomInt(0,1)]),Vector(0,180,0),4.00);
				ExevSpawn("slash_spawner",Vector(10944,-7488,rls[RandomInt(0,1)]),Vector(0,180,0),4.50);
				ExevSpawn("slash_spawner",Vector(10944,-7488,rls[RandomInt(0,1)]),Vector(0,180,0),5.00);
			break;
		}
		case 24:	//turtle - when boss2 logic_case attack 3 is triggered (Error - a block spawns on a random platform)
		{
			//----------> error spawns at ~4.0 - 5.0s at random - breaks at ~11.0 - 12.0s
			//spawn 2 vaginafaces at pos:(9728,-7680,-14592),(12288,-7680,-14592)
				ExevSpawn("s_vaginaface",Vector(9728,-7680,-14592));
				ExevSpawn("s_vaginaface",Vector(12288,-7680,-14592));
			break;
		}
		case 25:	//turtle - when boss2 logic_case attack 4 is triggered (29 - jump forward then back on the side-platforms)
		{
			//----------> front platform goes up at 0.0s - main platform breaks at 4.0s - main platform respawns at 6.0s - front platform goes down at 8.0s
			//spawn lasers at 1.0s on the platforms, until 9.0s
				local rls = [-15134,-15078];
				ExevSpawn("slash_spawner",Vector(9472,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),1.00);
				ExevSpawn("slash_spawner",Vector(9984,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),2.00);
				ExevSpawn("slash_spawner",Vector(10944,-7488,rls[RandomInt(0,1)]),Vector(0,180,0),3.00);
				ExevSpawn("slash_spawner",Vector(12000,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),4.00);
				ExevSpawn("slash_spawner",Vector(12512,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),5.00);
				ExevSpawn("slash_spawner",Vector(12000,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),6.00);
				ExevSpawn("slash_spawner",Vector(10944,-7488,rls[RandomInt(0,1)]),Vector(0,180,0),7.00);
				ExevSpawn("slash_spawner",Vector(9984,-8192,rls[RandomInt(0,1)]),Vector(0,180,0),8.00);
			break;
		}
		case 26:	//weeb - just when players enter the stage
		{
			//start tick to spawn mortars, babies and vaginafaces above players randomly
				exev_weebticking = true;
				EntFireByHandle(self,"RunScriptCode"," ExevWeebTick(); ",RandomFloat(5.0,20.0),null,null);
			//spawn 1-2 yellow lasers in the torch-house, kill horny players, at pos:(-4222,932,-3642),(-4222,729,-3642)
				ExevSpawn("blobblaser_tem1",Vector(-4222,932,-3642),null,0.20);
				ExevSpawn("blobblaser_tem1",Vector(-4222,729,-3642),null,0.50);
			//spawn 1-3 cakes around within the area at random (traceline downwards, make sure the Z is reasonable):
			//spawn a random 10-coin within the area at random (traceline downwards, make sure the Z is reasonable):
			//MEASUREMENTS:
			//------ minX:		-11848
			//------ minY:		-7752
			//------ maxX:		3656
			//------ maxY:		7752
			//------ maxZ:		-3400 (if above this, for example 3200, then it's too high, perhaps in a tree)
			//------ topZ:		-2555 (start scanning/spawning stuff from this height)
				local weebcakes_spawned = 0;
				local weebcoin_spawned = false;
				while(weebcakes_spawned < extreme_extracakes_in_weeb)
				{
					local raypos = Vector(RandomInt(-11848,3656),RandomInt(-7752,7752),-2555);
					local raydist = TraceLine(raypos,raypos+Vector(0,0,-2000),null);
					local rayhit = raypos+(Vector(0,0,-2000)*raydist);
					rayhit.z += 48;
					if(rayhit.z > -3400)
						continue;
					if(!weebcoin_spawned)
					{
						ExevSpawn("s_coin_3",rayhit);
						weebcoin_spawned = true;
						continue;
					}
					weebcakes_spawned++;
					ExevSpawn("itemturtleTemplateHeal2",rayhit);
				}
			break;
		}
		case 27:	//weeb - when triggering the end relay (where TP-out enables 'in 10 secs')
		{
			//end tick to spawn mortars, babies and vaginafaces above players randomly
				exev_weebticking = false;
			//kill off babies and vaginafaces after 9.5s, if any (i_diddlebaby_phys* break), (i_vaginaface_hp* break)
				EntFire("i_diddlebaby_phys*","Break","",0.00,null);
				EntFire("i_vaginaface_hp*","Break","",0.00,null);
			break;
		}
		case 28:	//dicklett - just when entering the stage
		{
			//after ~12s, spawn a curseorb at pos(-10400,12032,15480),yaw: 90 (+/- 15 at random)
				ExevSpawn("s_curse",Vector(-10400,12032,15480),Vector(0,90+RandomInt(-15,15),0),12.0);
			break;
		}
		case 29:	//dicklett - when triggering the start-relay for boss#1 (it spawns after 4.0s, the small hurt enables at 5.0s)
		{
			//spawn a yellow laser after ~3.5s at pos:(-13322,13294,15272), just under the rocks that breaks when you kill the 1st boss
				ExevSpawn("blobblaser_tem1",Vector(-13322,13294,15272),null,3.50);
			break;
		}
		case 30:	//dicklett - just when you enter the cave after defeating boss #1 (sidewalls break at 25+30s, final wall breaks at 45s)
		{
			//spawn a curseorb at pos:(-15232,15616,14936), yaw:0, spawn after ~12s
				ExevSpawn("s_curse",Vector(-15200,15616,14940),Vector(0,0,0),12.0);
			//spawn a yellow laser at pos:(-13515,15689,14939), at 28s
				ExevSpawn("blobblaser_tem1",Vector(-13515,15689,14939),null,28.0);
			//spawn a shrek at pos:(-14182,15624,13593)
				EntFireByHandle(self,"RunScriptCode"," ExevSpawn(\"X69Xluff_shrekspawn\",Vector(-14182,15624,13593)); ",60.00,null,null);
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",60.55,null);
			//spawn a couple vaginafaces at pos:(-14206,15437,13704),(-14239,15867,13705)
				ExevSpawn("s_vaginaface",Vector(-14206,15437,13704));
				ExevSpawn("s_vaginaface",Vector(-14239,15867,13705));
			break;
		}
		case 31:	//dicklett - when triggering the start-relay for boss#2 (boss starts instantly, 'AddHP(2000,1200)' runs at 0.00 atm)
		{
			//set HP on 'Ord_lvl_02_boss_break' a bit higher, RunScriptCode > AddHP(3000,1500) > at 0.10s
				EntFire("Ord_lvl_02_boss_break","RunScriptCode"," AddHP(3000,1500); ",0.10,null);
			//start spawning lasers randomly, X:-14848, Y:(14976/16256), Z:13600, yaw:270, crouchheight:13544, jumpheight:13488
				exev_spawns.clear();
				exev_spawns.push(ExSpawn("slash_spawner",Vector(-14848,14976,13544),Vector(0,270,0)));
				exev_spawns.push(ExSpawn("slash_spawner",Vector(-14848,14976,13488),Vector(0,270,0)));
				exev_spawns.push(ExSpawn("slash_spawner",Vector(-14848,16256,13544),Vector(0,270,0)));
				exev_spawns.push(ExSpawn("slash_spawner",Vector(-14848,16256,13488),Vector(0,270,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawns.push(ExSpawn("blobblaser_tem",Vector(0,0,15000),Vector(0,0,0)));
				exev_spawnrate = 1.50;
				exev_spawnbounds.clear();
				exev_spawnbounds.push(ExSpawnBounds("upslash_spawner",-14848,-14848,14976,16256,13900,Vector(0,270,0)));
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",1.00,null,null);
			break;
		}
		case 32:	//dicklett - boss#2 attack (push) - enables push at 1.0s, disables push at 9.0s
		{
			//spawn 3 blue lasers in front of each pillar, at pos:(-14064,15840,13536),(-14064,15456,13536),(-13536,15616,13536)
				ExevSpawn("blobblaser_tem",Vector(-14064,15840,13536));
				ExevSpawn("blobblaser_tem",Vector(-14064,15456,13536));
				ExevSpawn("blobblaser_tem",Vector(-13536,15616,13536));
			//re-enable the push 'Ord_lvl_02_boss_push' just after it disables at 9.00s, then re-disable it at 12.0s, making it last longer
			//(stripper-added a bunch of 'Enable' commands to prevent having it disabled if the attack is re-picked too early)
				EntFire("Ord_lvl_02_boss_push","Enable","",9.02,null);
				EntFire("Ord_lvl_02_boss_push","Enable","",9.10,null);
				EntFire("Ord_lvl_02_boss_push","Disable","",12.00,null);
			break;
		}
		case 33:	//dicklett - boss#2 attack (ground) - spawns at 0.50s - goes down at ~10.0s
		{
			//spawn a yellow laser at a random player, forcing the team to relocate/hide behind a pillar or die (GetRandomCT())
				GetRandomCT("blobblaser_tem1",Vector(0,0,48));
			break;
		}
		case 34:	//dicklett - when boss#2 dies (exit door opens after 10.0s, zombie-floor rises after 17.0s)
		{
			//stop ticking the lasers that started with the boss
				EntFireByHandle(self,"RunScriptCode"," exev_spawnbounds.clear(); exev_spawns.clear(); ",0.00,null,null);//STOP
			//spawn a yellow laser in the final-hold tunnel before TP-ing back to the 2nd loop, at pos:(-15488,15616,13536), at 17.0s
				ExevSpawn("blobblaser_tem1",Vector(-15488,15616,13536),null,17.0);
			break;
		}
		case 35:	//dicklett - when boss#3 starts (ForceSpawn at 0.05s, AddHP(4000,2500) at 2.00s)
		{
			//set HP on 'X69XOrd_main_mid_diglett_break' by RunScriptCode > AddHP(5000,2700) > at 2.50s
				EntFire("X69XOrd_main_mid_diglett_break","RunScriptCode"," AddHP(5000,2700); ",2.50,null);
			//start a random, slow mortar barrage (minX:-13984, maxX:-12192, minY:12080, maxY:14512, Z:16056)
				exev_spawnbounds.clear();
				exev_spawnbounds.push(ExSpawnBounds("s_mortar",-13984,-12192,12080,14512,16056,Vector(0,0,0)));
				exev_spawnrate = 2.00;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",3.00,null,null);
			break;
		}
		case 36:	//dicklett - boss#3 attack (quake - starts hurting at 2.0s - ends hurting at 8.50s)
		{
			//make the mortar barrage tick very, very slow for the duration of the earthquake (to prevent bullshit)
				exev_spawnrate = 5.00;
			//spawn B-lasers:(-13262,12663,15483),(-12827,12659,15471),(-12675,12865,15461),(-12667,13316,15470),(-12692,13630,15458),(-13299,13908,15452)
				ExevSpawn("blobblaser_tem",Vector(-13262,12663,15483));
				ExevSpawn("blobblaser_tem",Vector(-12827,12659,15471));
				ExevSpawn("blobblaser_tem",Vector(-12675,12865,15461));
				ExevSpawn("blobblaser_tem",Vector(-12667,13316,15470));
				ExevSpawn("blobblaser_tem",Vector(-12692,13630,15458));
				ExevSpawn("blobblaser_tem",Vector(-13299,13908,15452));
				ExevSpawn("blobblaser_tem",Vector(-13262,12663,15483),null,3.00);
				ExevSpawn("blobblaser_tem",Vector(-12827,12659,15471),null,3.00);
				ExevSpawn("blobblaser_tem",Vector(-12675,12865,15461),null,3.00);
				ExevSpawn("blobblaser_tem",Vector(-12667,13316,15470),null,3.00);
				ExevSpawn("blobblaser_tem",Vector(-12692,13630,15458),null,3.00);
				ExevSpawn("blobblaser_tem",Vector(-13299,13908,15452),null,3.00);
				ExevSpawn("blobblaser_tem",Vector(-13262,12663,15483),null,5.00);
				ExevSpawn("blobblaser_tem",Vector(-12827,12659,15471),null,5.00);
				ExevSpawn("blobblaser_tem",Vector(-12675,12865,15461),null,5.00);
				ExevSpawn("blobblaser_tem",Vector(-12667,13316,15470),null,5.00);
				ExevSpawn("blobblaser_tem",Vector(-12692,13630,15458),null,5.00);
				ExevSpawn("blobblaser_tem",Vector(-13299,13908,15452),null,5.00);
			break;
		}
		case 37:	//dicklett - boss#3 attack (laser - starts at 0.10s - ends at 8.0s)
		{
			//make the mortar barrage tick much faster for the duration of the laser (since it's currently very easy/not much of a danger)
				exev_spawnrate = 0.40;
			break;
		}
		case 38:	//dicklett - when boss#3 dies (rocks leading to cave breaks at 11.0s, zcage tele enables at 25.0s)
		{
			//stop the random, slow mortar barrage tick that begun with the boss
				EntFireByHandle(self,"RunScriptCode"," exev_spawnbounds.clear(); ",0.00,null,null);//STOP
			//spawn a yellow laser at ~5.5s at pos:(-13322,13294,15272), just under the rocks that breaks when you kill the 3rd boss
				ExevSpawn("blobblaser_tem1",Vector(-13322,13294,15272),null,5.50);
			break;
		}
		case 39:	//dicklett - when reaching hold just before the small, curved surf-portion (opens for real at 10s)
		{
			//spawn 3 vaginafaces at bottom of the surf-portion, pos:(-11360,11840,14272),(-11360,11584,14272),(-11360,11728,14272)
				ExevSpawn("s_vaginaface",Vector(-11360,11840,14272));
				ExevSpawn("s_vaginaface",Vector(-11360,11584,14272));
				ExevSpawn("s_vaginaface",Vector(-11360,11728,14272));
			//break 'ord_surfprotector2' instantly, make the hold harder
				EntFire("ord_surfprotector2","Break","",0.00,null);
			//spawn a yellow laser at the initial crouchhold at pos:(-14560,13184,14896)
				ExevSpawn("blobblaser_tem1",Vector(-14560,13184,14896));
			break;
		}
		case 40:	//dicklett - when reaching the hold/door just after the small, curved surf-portion (door opens after 10.0s)
		{
			//spawn 2 shreks at pos:(-12960,12967,14157),(-11623,13996,14418)
				EntFireByHandle(self,"RunScriptCode"," ExevSpawn(\"X69Xluff_shrekspawn\",Vector(-12960,12967,14157)); ",20.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," ExevSpawn(\"X69Xluff_shrekspawn\",Vector(-11623,13996,14418)); ",20.00,null,null);
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",20.55,null);
			//'Ord_lvl_01_door_03' opens at 10s, close it at 11, then open it at 12, also print some server message about it
				EntFire("Ord_lvl_01_door_03","Close","",11.00,null);
				EntFire("Ord_lvl_01_door_03","Open","",12.00,null);
				EntFire("server","Command","say *Extreme mode to the rescue!*",11.00,null);
				EntFire("server","Command","say *Alright now you may proceed*",12.50,null);
			//spawn 3 vaginafaces at pos:(-12188,12929,14216),(-11847,13807,14179),(-12875,14242,14469)
				ExevSpawn("s_vaginaface",Vector(-12188,12929,14216));
				ExevSpawn("s_vaginaface",Vector(-11847,13807,14179));
				ExevSpawn("s_vaginaface",Vector(-12875,14242,14469));
			//start spawning lasers across the lava jump where you came from, after ~20.0s at pos:(-11520,11488,14128/14184), yaw:0
				exev_spawns.clear();
				exev_spawns.push(ExSpawn("slash_spawner",Vector(-11520,11488,14128),Vector(0,0,0)));
				//exev_spawns.push(ExSpawn("slash_spawner",Vector(-11520,11488,14184),Vector(0,0,0)));		(commented out - make it jump-only due to the darkness)
				exev_spawnrate = 3.00;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",20.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," exev_spawns.clear(); ",60.00,null,null);//STOP
			break;
		}
		case 41:	//dicklett - when pressing lever in the lavajumps/maze after the small, curved surf-portion (door opens after 30.0s)
		{
			//spawn vaginafaces at pos:(-11382,14490,14166),(-11527,14466,15061),(-13197,13383,14950)
				ExevSpawn("s_vaginaface",Vector(-11382,14490,14166));
				ExevSpawn("s_vaginaface",Vector(-11527,14466,15061));
				ExevSpawn("s_vaginaface",Vector(-13197,13383,14950));
			//spawn a shrek at pos:(-13250,13886,14950)
				ExevSpawn("X69Xluff_shrekspawn",Vector(-13200,13400,14950));
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",0.55,null);
			//start spawning jumplasers at pos:(-13448,13312,14952), yaw:0 after ~40s, stop after ~60s
				exev_spawns.clear();
				exev_spawns.push(ExSpawn("slash_spawner",Vector(-13448,13312,14932),Vector(0,0,0)));
				exev_spawnrate = 2.00;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",40.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," exev_spawns.clear(); ",60.00,null,null);//STOP
			break;
		}
		case 42:	//dicklett - when triggering final hold before boss#4 (shortcut breaks at 18.0s, bosswall breaks at 22.0s, AddHP(4000,4500) at 31.50s)
		{
			//spawn a yellow laser just inside the shortcut after 14.0s at pos(-12964,14230,14921)
				ExevSpawn("blobblaser_tem1",Vector(-12964,14230,14921),null,14.0);
			//set bossHP on 'Ord_lvl_01_boss_break' by RunScriptCode > AddHP(5000,5000); at 32.00s
				EntFire("Ord_lvl_01_boss_break","RunScriptCode"," AddHP(5000,5000); ",32.00,null);
			break;
		}
		case 43:	//dicklett - boss#4 attack (jizz attack right - get away from right side)	*hurt start 2.0s - end 6.0s*
		{
			//spawn a vaginaface on the right side at pos:(-12096,12928,15040)
				ExevSpawn("s_vaginaface",Vector(-12096,12928,15040));
			break;
		}
		case 44:	//dicklett - boss#4 attack (jizz attack mid - get away from the middle)		*hurt start 2.0s - end 6.0s*
		{
			//spawn a curseorb on the left or right side at random, pos:(-12160,13440,14848),(-12160,12928,14848), yaw:180+-10
				if(RandomInt(0,1)==1)
					ExevSpawn("s_curse",Vector(-12160,13440,14848),Vector(0,180+RandomInt(-10,10),0));
				else
					ExevSpawn("s_curse",Vector(-12160,12928,14848),Vector(0,180+RandomInt(-10,10),0));
			break;
		}
		case 45:	//dicklett - boss#4 attack (jizz attack left - get away from left side)		*hurt start 2.0s - end 6.0s*
		{
			//spawn a vaginaface on the left side at pos:(-12096,13440,15040)
				ExevSpawn("s_vaginaface",Vector(-12096,13440,15040));
			break;
		}
		case 46:	//dicklett - boss#4 attack (earthquake - get on platform)	*rise at 1.0s, hurt at 3.0s, stop hurt at 6.0, de-rise at 7.0s*
		{
			//Enable 'Ord_lvl_01_boss_hurt_platform' at 0.00s (will hurt slightly, and require people to stay attentive)
				EntFire("Ord_lvl_01_boss_hurt_platform","Enable","",0.00,null);
			break;
		}
		case 47:	//dicklett - boss#4 attack (fart - hug the front of the pillar)				*start at 0.0s - end at ~8.0-10.0s*
		{
			//spawn jumplasers for ~8.0s at 2 possible positions:(-11840,13440,14849),(-11840,12928,14849), yaw:90
				local randlaser = [Vector(-11840,13440,14849),Vector(-11840,12928,14849)];
				ExevSpawn("slash_spawner",randlaser[RandomInt(0,1)],Vector(0,90,0),0.0);
				ExevSpawn("slash_spawner",randlaser[RandomInt(0,1)],Vector(0,90,0),2.0);
				ExevSpawn("slash_spawner",randlaser[RandomInt(0,1)],Vector(0,90,0),4.0);
				ExevSpawn("slash_spawner",randlaser[RandomInt(0,1)],Vector(0,90,0),6.0);
				ExevSpawn("slash_spawner",randlaser[RandomInt(0,1)],Vector(0,90,0),8.0);
			break;
		}
		case 48:	//dicklett - when boss#4 dies (exit-door opens slowly at 20.0s, zcage breaks at 30s which is kinda when exit-door is open)
		{
			//spawn jump/crouch lasers towards the final hallway after ~31.0s at pos:(-13056,13184,14928),(-13056,13184,14984), yaw:270
				exev_spawns.clear();
				exev_spawns.push(ExSpawn("slash_spawner",Vector(-13056,13184,14928),Vector(0,270,0)));
				//exev_spawns.push(ExSpawn("slash_spawner",Vector(-13056,13184,14984),Vector(0,270,0)));		(commented out - make it jump-only due to the darkness)
				exev_spawnrate = 4.00;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",31.00,null,null);
			break;
		}
		case 49:	//dicklett - just when you exit-TP out after defeating boss#4 (when entering final hallway-hold)
		{
			//stop spawning jump and crouchlasers from the previous area
				EntFireByHandle(self,"RunScriptCode"," exev_spawns.clear(); ",0.00,null,null);//STOP
			//spawn a yellow laser after ~20.0s at pos:(-10400,12160,15488)
				ExevSpawn("blobblaser_tem1",Vector(-10400,12160,15488),null,20.0);
			//spawn a 10-coin inside the hallway where zombies come from, probably need a torch to get it, at pos:(-10321,11945,15450)
				ExevSpawn("s_coin_3",Vector(-10321,11945,15450),null,4.00);
			//disable the CT-push so ct's can get the 10-coin:
				EntFire("stripstrop_ord_wtf_push","Disable","",0.00,null);
			break;
		}
		case 50:	//dicklett - when final boss starts (AddHP(4000,5500) at 2.0s)
		{
			//set HP on 'X69XOrd_main_large_diglett_break' by RunScriptCode > AddHP(5000,5700); > at 2.20s
				EntFire("X69XOrd_main_large_diglett_break","RunScriptCode"," AddHP(5000,5700); ",2.20,null);
			//spawn a yellow laser after 5.0s at pos:(-12959,13043,15472)
				ExevSpawn("blobblaser_tem1",Vector(-12959,13043,15472),null,5.0);
			break;
		}
		case 51:	//dicklett - boss#5 attack (quake - starts hurting at 2.0s - ends hurting at 8.50s)
		{
			//spawn a yellow laser on a random CT at 8.00s
				EntFireByHandle(self,"RunScriptCode"," GetRandomCT(\"blobblaser_tem1\",Vector(0,0,48)); ",8.00,null,null);
			//spawn B-lasers:(-13262,12663,15483),(-12827,12659,15471),(-12675,12865,15461),(-12667,13316,15470),(-12692,13630,15458),(-13299,13908,15452)
				ExevSpawn("blobblaser_tem",Vector(-13262,12663,15483));
				ExevSpawn("blobblaser_tem",Vector(-12827,12659,15471));
				ExevSpawn("blobblaser_tem",Vector(-12675,12865,15461));
				ExevSpawn("blobblaser_tem",Vector(-12667,13316,15470));
				ExevSpawn("blobblaser_tem",Vector(-12692,13630,15458));
				ExevSpawn("blobblaser_tem",Vector(-13299,13908,15452));
				ExevSpawn("blobblaser_tem",Vector(-13262,12663,15483),null,3.00);
				ExevSpawn("blobblaser_tem",Vector(-12827,12659,15471),null,3.00);
				ExevSpawn("blobblaser_tem",Vector(-12675,12865,15461),null,3.00);
				ExevSpawn("blobblaser_tem",Vector(-12667,13316,15470),null,3.00);
				ExevSpawn("blobblaser_tem",Vector(-12692,13630,15458),null,3.00);
				ExevSpawn("blobblaser_tem",Vector(-13299,13908,15452),null,3.00);
				ExevSpawn("blobblaser_tem",Vector(-13262,12663,15483),null,5.00);
				ExevSpawn("blobblaser_tem",Vector(-12827,12659,15471),null,5.00);
				ExevSpawn("blobblaser_tem",Vector(-12675,12865,15461),null,5.00);
				ExevSpawn("blobblaser_tem",Vector(-12667,13316,15470),null,5.00);
				ExevSpawn("blobblaser_tem",Vector(-12692,13630,15458),null,5.00);
				ExevSpawn("blobblaser_tem",Vector(-13299,13908,15452),null,5.00);
			break;
		}
		case 52:	//boss#5 attack (laser - starts at 5.0s - ends at 14.0s)
		{
			//spawn a yellow laser on a random CT at 1.00s
				EntFireByHandle(self,"RunScriptCode"," GetRandomCT(\"blobblaser_tem1\",Vector(0,0,48)); ",1.00,null,null);
			break;
		}
		case 53:	//dicklett - when defeating boss#5 (coin spawns at 5.0s, the rocks leading to the TP breaks after 9.0s)
		{
			//spawn a vaginaface after 5.0s at pos:(-12178,14485,16094)
				ExevSpawn("s_vaginaface",Vector(-12178,14485,16094),null,5.0);
			//spawn a yellow laser at ~4.5s at pos:(-13322,13294,15272), just under the rocks that breaks when you kill the 5th boss
				ExevSpawn("blobblaser_tem1",Vector(-13322,13294,15272),null,4.5);
			break;
		}
		case 54:	//omaha - when entering the stage
		{
			//spawn vaginafaces at pos:(-13312,3584,15488),(-11776,3584,15488),(-12608,3584,15168)
				ExevSpawn("s_vaginaface",Vector(-13312,3584,15488));
				ExevSpawn("s_vaginaface",Vector(-11776,3584,15488));
				ExevSpawn("s_vaginaface",Vector(-12608,3584,15168));
			//spawn babyfaces at pos:(-13312,2048,15488),(-11776,2048,15488),(-12608,2048,15168)
				ExevSpawn("s_diddlebaby",Vector(-13312,2048,15488));
				ExevSpawn("s_diddlebaby",Vector(-11776,2048,15488));
				ExevSpawn("s_diddlebaby",Vector(-12608,2048,15168));
			//spawn shreks at pos:(-12553,3041,13916),(-13557,1010,13947),(-11514,1977,13909)
				ExevSpawn("X69Xluff_shrekspawn",Vector(-12553,3041,13916));
				ExevSpawn("X69Xluff_shrekspawn",Vector(-13557,1010,13947));
				ExevSpawn("X69Xluff_shrekspawn",Vector(-11514,1977,13909));
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",0.55,null);
			//teleport x% of the zombies in front of the humans with 500hp at pos:(-13760/-11328,3072,14208), prevent going above Y:4310
				EntFireByHandle(self,"RunScriptCode"," ExtremeOmahaTPZ(); ",1.00,null,null);
			break;
		}
		case 55:	//omaha - when triggering the explosive wall (explodes at 29.5s)
		{
			//spawn a 10-coin under the z-shortcut bridge, sneaky spot
				ExevSpawn("s_coin_3",Vector(-12774,5759,13615));
			//start a heavy mortar barrage at ~20.0s until 30.0s (minX:-13824,minY:3392,maxX:-11264,maxY:4096,Z:15360)
				exev_spawnbounds.clear();
				exev_spawnbounds.push(ExSpawnBounds("s_mortar",-13824,-11264,3400,4300,15360,Vector(0,0,0)));
				exev_spawnrate = 0.50;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",12.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," exev_spawnbounds.clear(); ",22.00,null,null);//STOP
			break;
		}
		case 56:	//omaha - when reaching hold just after the spike-bridge (z-ladder opens at 20.0s, hold opens at 25.0s)
		{
			//spawn shreks at pos:(-13710,9620,14147),(-11959,9716,14168)
				EntFireByHandle(self,"RunScriptCode"," ExevSpawn(\"X69Xluff_shrekspawn\",Vector(-13710,9620,14147)); ",25.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," ExevSpawn(\"X69Xluff_shrekspawn\",Vector(-11959,9716,14168)); ",25.00,null,null);
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",25.55,null);
			//spawn vaginafaces at pos:(-13728,9745,14195),(-11980,9033,14176),(-11695,8838,14193),(-12827,7848,14240)
				ExevSpawn("s_vaginaface",Vector(-13728,9745,14195));
				ExevSpawn("s_vaginaface",Vector(-11980,9033,14176));
				ExevSpawn("s_vaginaface",Vector(-11695,8838,14193));
				ExevSpawn("s_vaginaface",Vector(-12827,7848,14240));
			//spawn babyfaces at pos:(-13722,7539,14161),(-11627,9770,14154),(-11366,7845,14189),(-12130,8123,14148)
				ExevSpawn("s_diddlebaby",Vector(-13722,7539,14161));
				ExevSpawn("s_diddlebaby",Vector(-11627,9770,14154));
				ExevSpawn("s_diddlebaby",Vector(-11366,7845,14189));
				ExevSpawn("s_diddlebaby",Vector(-12130,8123,14148));
			//spawn jump lasers, start:30s,end:60s,pos:(-3936,9808,14112/14168),Y:180 + pos:(-11248,9920,14112/14168),Y:90
				exev_spawns.clear();
				exev_spawns.push(ExSpawn("slash_spawner",Vector(-13936,9808,14112)Vector(0,180,0)));
				//exev_spawns.push(ExSpawn("slash_spawner",Vector(-13936,9808,14168),Vector(0,180,0)));		(commented out for jump lasers only)
				exev_spawns.push(ExSpawn("slash_spawner",Vector(-11248,9920,14112),Vector(0,90,0)));
				//exev_spawns.push(ExSpawn("slash_spawner",Vector(-11248,9920,14168),Vector(0,90,0)));		(commented out for jump lasers only)
				exev_spawnrate = 1.00;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",30.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," exev_spawns.clear(); ",60.00,null,null);//STOP
			break;
		}
		case 57:	//omaha - when reaching trigger below helicopter (final hold, TP-out for CT's enable after 80.0s)
		{
			//spawn a shrek at pos:(-12608,8880,14800)
				ExevSpawn("X69Xluff_shrekspawn",Vector(-12608,8880,14800));
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",0.55,null);
			//spawn a yellow laser at pos:(-13031,8882,14737) at 0.00s, 6.00s and 12.00s
				ExevSpawn("blobblaser_tem1",Vector(-13031,8882,14737));
				ExevSpawn("blobblaser_tem1",Vector(-13031,8882,14737),null,6.00);
				ExevSpawn("blobblaser_tem1",Vector(-13031,8882,14737),null,12.00);
			break;
		}
		case 58:	//finale - when the spawn doors start opening at the very start
		{
			//spawn jump/crouch lasers for ~20s at pos(6208,1024,80/136),Y:90
				exev_spawns.clear();
				exev_spawns.push(ExSpawn("slash_spawner",Vector(6208,1024,80),Vector(0,90,0)));
				exev_spawns.push(ExSpawn("slash_spawner",Vector(6208,1024,136),Vector(0,90,0)));
				exev_spawnrate = 3.00;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",0.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," exev_spawns.clear(); ",20.50,null,null);//STOP
			//spawn tall lasers starting at ~20s at pos(2944,896/1152,192),y:270
				exev_spawnbounds.clear();
				EntFireByHandle(self,"RunScriptCode"," exev_spawnbounds.push(ExSpawnBounds(\"upslash_spawner\",2100,2944,896,1152,768,Vector(0,270,0))); ",20.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," exev_spawnrate = 1.50; ",20.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",20.05,null,null);
			//spawn 'ITEMX_tem_luffaren_baby' at pos:(8000,570,30)
				ExevSpawn("ITEMX_tem_luffaren_baby",Vector(8000,570,30));
			//after ~30-50s, spawn a yellow laser at pos:(7358,334,216)
				ExevSpawn("blobblaser_tem1",Vector(8000,570,30),null,RandomFloat(30.0,50.0));
			//spawn shreks at pos:(6963,427,129),(5603,1027,116)
				ExevSpawn("X69Xluff_shrekspawn",Vector(6963,427,129));
				ExevSpawn("X69Xluff_shrekspawn",Vector(5603,1027,116));
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",0.55,null);
			//clear and re-check the shopangels, would probably cause mass-confusion otherwise
				specdevils.clear()
				shopangels.clear();
				tickingsinners = true;
				TickInflatingSinners();
			break;
		}
		case 59:	//finale - when triggering first gate-hold (just after the diddle-shop, it opens after 20.0s)
		{
			//spawn crouchlasers after 20s at a fast rate at pos:(8000,3840,-696),Y:90 until 42s, then clear/stop all the ticks!
				exev_spawns.clear();
				exev_spawns.push(ExSpawn("slash_spawner",Vector(8000,3840,-696),Vector(0,90,0)));
				EntFireByHandle(self,"RunScriptCode"," exev_spawnrate = 0.10; exev_spawnbounds.clear(); if(!exev_spawnticking)ExevSpawnTick(); ",20.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," exev_spawns.clear(); exev_spawnbounds.clear(); ",47.00,null,null);//STOP
			//spawn a shrek at pos:(8365,6397,-2267)
				ExevSpawn("X69Xluff_shrekspawn",Vector(8365,6397,-2267));
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",0.55,null);
			break;
		}
		case 60:	//finale - when triggering second gate hold (before splitup to elevator on the left or long path on the right (opens after 20.0s)
		{
			//spawn a vaginaface at pos:(9910,6587,-2777)
				ExevSpawn("s_vaginaface",Vector(9910,6587,-2777));
			//spawn shreks at pos:(13608,6987,-1511),(11540,7006,-73),(13180,6767,2224)
				EntFireByHandle(self,"RunScriptCode"," ExevSpawn(\"X69Xluff_shrekspawn\",Vector(13608,6987,-1511)); ",85.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," ExevSpawn(\"X69Xluff_shrekspawn\",Vector(11540,7006,-73)); ",85.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," ExevSpawn(\"X69Xluff_shrekspawn\",Vector(13180,6767,2224)); ",85.00,null,null);
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",85.55,null);
			//start spawning jump/crouchlasers after 20s until 50s at pos:(14208,6432,-2288/-2232),Y:90
				exev_spawns.clear();
				exev_spawns.push(ExSpawn("slash_spawner",Vector(14350,6432,-2288),Vector(0,90,0)));
				exev_spawns.push(ExSpawn("slash_spawner",Vector(14350,6432,-2232),Vector(0,90,0)));
				exev_spawnrate = 1.20;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",20.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," exev_spawns.clear(); ",50.00,null,null);//STOP
			break;
		}
		case 61:	//finale - when reaching the long, top hold in the blob area (door opens at 50.0s)
		{
			//after 30s, spawn a curseorb at pos:(12480,6464,2224),yaw=0+-10
				ExevSpawn("s_curse",Vector(12480,6464,2224),Vector(0,0+RandomInt(-10,10),0),30.0);
			//spawn a shrek at pos:(15415,2229,1908)
				EntFireByHandle(self,"RunScriptCode"," ExevSpawn(\"X69Xluff_shrekspawn\",Vector(15415,2229,1908)); ",55.00,null,null);
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",55.55,null);
			//break 'finale_breakladder2' at 60.0s (a bit earlier than usual)
				EntFire("finale_breakladder2","Break","",60.00,null);
			break;
		}
		case 62:	//finale - when triggering hold just before jumping into the vagina (gate opens after 20.0s)
		{
			//after 18.0s, spawn a curseorb at pos:(13600,2688,1880),yaw=0
				ExevSpawn("s_curse",Vector(13600,2688,1880),null,18.0);
			//after 17.3s, spawn a yellow laser at pos:(13984,2688,1072)
				ExevSpawn("blobblaser_tem1",Vector(13984,2688,1072),null,17.3);
			break;
		}
		case 63:	//finale - when triggering first hold in the vagina (opens after 15.0s)
		{
			//spawn vaginafaces at pos:(13977,-2292,6241),(14095,-2826,7359)
				ExevSpawn("s_vaginaface",Vector(13977,-2292,6241));
				ExevSpawn("s_vaginaface",Vector(14095,-2826,7359));
			//spawn a shrek after 15.0s at pos:(13067,-1213,6219)
				ExevSpawn("X69Xluff_shrekspawn",Vector(13067,-1213,6219),null,15.0);
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",15.55,null);
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",16.00,null);
			//spawn a vaginaface after 8.0s at pos:(15817,-3188,6738)
				ExevSpawn("s_vaginaface",Vector(15817,-3188,6738),null,8.0);
			break;
		}
		case 64:	//finale - when triggering second hold in the vagina (opens after 30.0s)
		{
			//spawn a yellow laser after 24.0s at pos:(14100,-2751,7390)
				ExevSpawn("blobblaser_tem1",Vector(14100,-2751,7390),null,24.0);
			//spawn a vaginaface:(14473,-3252,7889)
				ExevSpawn("s_vaginaface",Vector(14473,-3252,7889));
			break;
		}
		case 65:	//finale - when triggering third hold in the vagina (opens after 15.0s)
		{
			//spawn vaginafaces at pos:(11320,-2319,9348),(11672,-1695,7935),(12127,-1810,7516)
				ExevSpawn("s_vaginaface",Vector(11320,-2319,9348));
				ExevSpawn("s_vaginaface",Vector(11672,-1695,7935));
				ExevSpawn("s_vaginaface",Vector(12127,-1810,7516));
			break;
		}
		case 66:	//finale - when triggering fourth hold in the vagina (opens after 30.0s)
		{
			//Break 'v_shitbreak' at 25.0s (it breaks at 37.0s originally)
				EntFire("v_shitbreak","Break","",25.00,null);
			//spawn a babyface at pos:(13611,-1626,11240)
				ExevSpawn("s_diddlebaby",Vector(13611,-1626,11240));
			//spawn vaginafaces at pos:(13882,-1190,9723),(14475,-2699,10094)
				ExevSpawn("s_vaginaface",Vector(13882,-1190,9723));
				ExevSpawn("s_vaginaface",Vector(14475,-2699,10094));
			break;
		}
		case 67:	//finale - when triggering fifth/final hold in the vagina (fetus freakout at ~22.0s, babyspawns at 30.0s, opens at 40.0s)
		{
			//spawn vaginafaces at pos:(15150,-3552,10532),(12019,-3599,2450)
				ExevSpawn("s_vaginaface",Vector(15150,-3552,10532));
				ExevSpawn("s_vaginaface",Vector(12019,-3599,2450));
			//spawn a yellow laser after 30.0s at pos:(13890,-2981,10098)
				ExevSpawn("blobblaser_tem1",Vector(13890,-2981,10098),null,30.0);
			break;
		}
		case 68:	//finale - when in the middle of the staircase leading to the magma cave (reaching it after ~15.0s, Z-tp enables at 60.0s)
		{
			//spawn vaginafaces at pos:(12032,-3584,1056),(9524,-5157,2188),(14346,-5356,2051),(15042,-6453,1559)
				ExevSpawn("s_vaginaface",Vector(12032,-3584,1056));
				ExevSpawn("s_vaginaface",Vector(9524,-5157,2188));
				ExevSpawn("s_vaginaface",Vector(14346,-5356,2051));
				ExevSpawn("s_vaginaface",Vector(15042,-6453,1559));
			//spawn shreks at pos:(14979,-6397,1570),(12025,-5596,1321)
				ExevSpawn("X69Xluff_shrekspawn",Vector(14979,-6397,1570));
				ExevSpawn("X69Xluff_shrekspawn",Vector(12025,-5596,1321));
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",0.55,null);
			//spawn a babyface at pos:(10967,-5989,1325)
				ExevSpawn("s_diddlebaby",Vector(10967,-5989,1325));
			//spawn jumplasers starting at 15.0s, ending at 45.0s at pos:(15360,-6400,1552/1608),yaw=90
				exev_spawns.clear();
				exev_spawns.push(ExSpawn("slash_spawner",Vector(15360,-6400,1552),Vector(0,90,0)));
				exev_spawns.push(ExSpawn("slash_spawner",Vector(15360,-6400,1608),Vector(0,90,0)));
				exev_spawnrate = 0.80;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",15.00,null,null);
				EntFireByHandle(self,"RunScriptCode"," exev_spawns.clear(); ",45.00,null,null);//STOP
			break;
		}
		case 69:	//finale - when reaching gate hold just before the fetus boss (opens after 40.0s)
		{
			//spawn a yellow laser at 36.5s at pos:(15840,-6944,1552)
				ExevSpawn("blobblaser_tem1",Vector(15840,-6944,1552),null,36.5);
			//spawn a curseorb at 50.0s at pos:(14464,-8704,1280),Y:0
				ExevSpawn("s_curse",Vector(14464,-8704,1280),null,50.0);
			break;
		}
		case 70:	//finale - when triggering the fetus hold relay (bridge-jump breaks at 15.0s, fetus boss spawns in vagina/starts at 20.0s)
		{
			//spawn a handful of vaginafaces with some delays in between at pos:(13344,-9102,4040)
				ExevSpawn("s_vaginaface",Vector(13344,-9102,4040),null,20.0);
				ExevSpawn("s_vaginaface",Vector(13344,-9102,4040),null,20.5);
				ExevSpawn("s_vaginaface",Vector(13344,-9102,4040),null,21.0);
				ExevSpawn("s_vaginaface",Vector(13344,-9102,4040),null,30.0);
				ExevSpawn("s_vaginaface",Vector(13344,-9102,4040),null,45.0);
				ExevSpawn("s_vaginaface",Vector(13344,-9102,4040),null,60.0);
				ExevSpawn("s_vaginaface",Vector(13344,-9102,4040),null,90.0);
			//start spawning in mortarstrikes across the arena:(minX:9280,maxX:14656,minY:-10432,maxY:-7872,Z:2000)
				exev_spawnbounds.clear();
				exev_spawns.clear();
				exev_spawnbounds.push(ExSpawnBounds("s_mortar",9280,14656,-10432,-7872,2000,Vector(0,0,0)));
				exev_spawnrate = 0.80;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",15.00,null,null);
			break;
		}
		case 71:	//finale - when the fetus boss is defeated (zcage-rock-hold breaks after 128.0s, zcage breaks after 134.0s)
		{
			//stop spawning in mortarstrikes across the arena
				EntFireByHandle(self,"RunScriptCode"," exev_spawnbounds.clear(); ",0.00,null,null);//STOP
			//spawn yellow lasers at 16.0s at pos:(9043,-9560,1034),(9202,-8161,990)
				ExevSpawn("blobblaser_tem1",Vector(9043,-9560,1034),null,16.0);
				ExevSpawn("blobblaser_tem1",Vector(9202,-8161,990),null,16.0);
			//spawn a yellow laser at 110.0s at pos:(2645,-8483,910)
				ExevSpawn("blobblaser_tem1",Vector(2645,-8483,910),null,110.0);
			//spawn vaginafaces at pos:(7266,-8779,2499),(8777,-5799,1770),(4585,-8369,1442)
				ExevSpawn("s_vaginaface",Vector(7266,-8779,2499));
				ExevSpawn("s_vaginaface",Vector(8777,-5799,1770));
				ExevSpawn("s_vaginaface",Vector(4585,-8369,1442));
			//break the zcage by FireUser1 on 'finale_zcage' at 131.0s, a few seconds earlier than usual 
				EntFire("finale_zcage","FireUser1","",131.00,null);
			break;
		}
		case 72:	//finale - 2-split hold just after the lavarise zcage-rock-hold (breaks/opens after 20.0s)
		{
			//spawn vaginafaces at pos:(-3603,-8062,1797),(-6247,-10060,2993),(-2609,-8986,1906)
				ExevSpawn("s_vaginaface",Vector(-3603,-8062,1797));
				ExevSpawn("s_vaginaface",Vector(-6247,-10060,2993));
				ExevSpawn("s_vaginaface",Vector(-2609,-8986,1906));
			//spawn yellow lasers after 3.0s at pos:(-1219,-7817,1537),(-794,-8401,1082)
				ExevSpawn("blobblaser_tem1",Vector(-1219,-7817,1537),null,3.0);
				ExevSpawn("blobblaser_tem1",Vector(-794,-8401,1082),null,3.0);
			break;
		}
		case 73:	//finale - when reaching final normal-mode hold, just before diddle-heaven (seal spawns in at 11.0s)
		{
			//start spawning upslash lasers randomly after ~15.0s:(X:-2976,minY:-8880,maxY:-8328,Z:1536), yaw:90
				exev_spawnbounds.clear();
				exev_spawnbounds.push(ExSpawnBounds("upslash_spawner",-2976,-2976,-8880,-8328,2200,Vector(0,90,0)));
				exev_spawnrate = 1.00;
				EntFireByHandle(self,"RunScriptCode"," if(!exev_spawnticking)ExevSpawnTick(); ",15.00,null,null);
			break;
		}
		case 74:	//finale - when the lavarise reaches the top and you don't have all coins (no diddle heaven)
		{
			//stop spawning the upslash lasers
				EntFireByHandle(self,"RunScriptCode"," exev_spawnbounds.clear(); ",0.00,null,null);//STOP
				EntFireByHandle(self,"RunScriptCode"," exev_spawnbounds.clear(); ",20.00,null,null);//STOP
			break;
		}
		case 75:	//finale - when the lavarise reaches the top and you have all coins (go to diddle heaven, jump enables at 4.50s)
		{
			//stop spawning the upslash lasers
				EntFireByHandle(self,"RunScriptCode"," exev_spawnbounds.clear(); ",0.00,null,null);//STOP
				EntFireByHandle(self,"RunScriptCode"," exev_spawnbounds.clear(); ",20.00,null,null);//STOP
			//spawn a vaginaface at pos:(-8100,-8742,1196)
				ExevSpawn("s_vaginaface",Vector(-8100,-8742,1196));
			break;
		}
		case 76:	//finale - when reaching the exit doors of the diddle heaven chapel (z-cage breaks at 0.0s, doors opens at 15.0s)
		{
			//spawn vaginafaces:(-11942,-7746,1660),(-14019,-6677,2872),(-14794,-8486,1784),(-15138,-9941,2765),(-12206,-9837,2128)
				ExevSpawn("s_vaginaface",Vector(-11942,-7746,1660));
				ExevSpawn("s_vaginaface",Vector(-14019,-6677,2872));
				ExevSpawn("s_vaginaface",Vector(-14794,-8486,1784));
				ExevSpawn("s_vaginaface",Vector(-15138,-9941,2765));
				ExevSpawn("s_vaginaface",Vector(-12206,-9837,2128));
			//spawn shrek at pos:(-14598,-10906,2631)
				EntFireByHandle(self,"RunScriptCode"," ExevSpawn(\"X69Xluff_shrekspawn\",Vector(-14598,-10906,2631)); ",40.00,null,null);
				EntFire("X69Xluff_npc_phys2gg*","RunScriptCode"," AddHP(10,5); ",40.55,null);
			//spawn a yellow laser at 17.0s at pos:(-11291,-7753,1731)
				ExevSpawn("blobblaser_tem1",Vector(-11291,-7753,1731),null,17.0);
			break;
		}
		case 77:	//finale - when reaching the diddledick boss gate (gate breaks after 30.0s, boss starts at ~35.0s, diddlefriend roof goes down at 60.0s)
		{
			//spawn a curseorb at 30.0s at pos:(-14592,-12032,2592),yaw=90
				ExevSpawn("s_curse",Vector(-14592,-12032,2592),Vector(0,90,0),30.0);
			//kill off the torch items (also print a server message about it)
				EntFire("aX69Xhich*","Kill","",19.00,null);
				EntFire("server","Command","say ***REMOVING TORCHES IN 5 SECONDS...***",14.00,null);
				EntFire("server","Command","say ***REMOVING TORCHES IN 4 SECONDS...***",15.00,null);
				EntFire("server","Command","say ***REMOVING TORCHES IN 3 SECONDS...***",16.00,null);
				EntFire("server","Command","say ***REMOVING TORCHES IN 2 SECONDS...***",17.00,null);
				EntFire("server","Command","say ***REMOVING TORCHES IN 1 SECONDS...***",18.00,null);
				EntFire("server","Command","say ***TORCHES REMOVED, GOOD LUCK...***",19.00,null);
			break;
		}
		case 78:	//finale - when a zombie teleports just in front of the diddledick boss (by random timer)
		{
			//run more times (for more zombies to TP in front):		EntFire("dd_hp","RunScriptCode"," SpawnZombie(); ",0.00,null);
				EntFire("dd_hp","RunScriptCode"," SpawnZombie(); ",0.10,null);
				EntFire("dd_hp","RunScriptCode"," SpawnZombie(); ",0.20,null);
				EntFire("dd_hp","RunScriptCode"," SpawnZombie(); ",0.30,null);
				EntFire("dd_hp","RunScriptCode"," SpawnZombie(); ",0.40,null);
				EntFire("dd_hp","RunScriptCode"," SpawnZombie(); ",0.50,null);
				EntFire("dd_hp","RunScriptCode"," SpawnZombie(); ",0.60,null);
			break;
		}
		case 79:	//finale - when the diddledick boss dies (endpush enables after 25.0s)
		{
			//move the slashes and rotate them 180 degrees through the below, then keep spawning them on a timer until 24.0s:
				EntFire("dd_attack_upslash_*","RunScriptCode"," self.SetOrigin(self.GetOrigin()+Vector(0,3200,0)); ",0.00,null);
				EntFire("dd_attack_highslash","RunScriptCode"," self.SetOrigin(self.GetOrigin()+Vector(0,3200,0)); ",0.00,null);
				EntFire("dd_attack_lowslash","RunScriptCode"," self.SetOrigin(self.GetOrigin()+Vector(0,3200,0)); ",0.00,null);
				EntFire("dd_attack_upslash_*","AddOutput","angles 0 180 0",0.00,null);
				EntFire("dd_attack_highslash","AddOutput","angles 0 180 0",0.00,null);
				EntFire("dd_attack_lowslash","AddOutput","angles 0 180 0",0.00,null);	
				exev_finalboss_laserticking = true;
				EntFireByHandle(self,"RunScriptCode"," ExevTickFinalbossLaser(); ",7.00,null,null);
				EntFireByHandle(self,"RunScriptCode","exev_finalboss_laserticking = false; ",25.00,null,null);//STOP
			break;
		}
		case 80:	//finale - when a CT wins by teleporting into the white box win area (triggers for each !activator that is the CT)
		{
			//if LuffarenMaps.smx is running on the server, print out the playername as a winner
				if(SBplayers.len()<=0)
					return;
				local p = activator;
				if(p!=null&&p.IsValid()&&p.GetHealth()>0&&p.GetTeam()==3)
				{
					p.ValidateScriptScope();
					local sc = p.GetScriptScope();
					if("userid" in sc)
					{
						foreach(sbb in SBplayers)
						{
							if(sc.userid == sbb.userid)
								EntFire("server","Command","say ExWin:["+sbb.steamid.tostring()+" "+sbb.name.tostring()+"]",0.00,null);
						}
					}
				}
			break;
		}
	}
}
class ExSpawn
{
	template = null;
	pos = null;
	rot = null;
	constructor(_template,_pos,_rot=Vector(0,0,0))
	{
		template = _template;
		pos = _pos;
		rot = _rot;
	}
}
class ExSpawnBounds
{
	template = null;
	minX = null;
	maxX = null;
	minY = null;
	maxY = null;
	Z = null;
	rot = null;
	constructor(_template,_minX,_maxX,_minY,_maxY,_Z,_rot)
	{
		template = _template;
		minX = _minX;
		maxX = _maxX;
		minY = _minY;
		maxY = _maxY;
		Z = _Z;
		rot = _rot;
	}
}
class ExSpawnMaker
{
	name = null;
	handle = null;
	constructor(_name,_handle)
	{
		name = _name;
		handle = _handle;
	}
}
class ExSpawnQueue
{
	spawn = null;
	time = null;
	constructor(_spawn,_time)
	{
		spawn = _spawn;
		time = _time;
	}
}
function ExevWeebTick()
{
	if(!exev_weebticking)
		return;
	EntFireByHandle(self,"RunScriptCode"," ExevWeebTick(); ",RandomFloat(exev_weebtick_min,exev_weebtick_max),null,null);
	local amount_vaginaface = 0;
	local amount_babyface = 0;
	local h = null;while(null!=(h=Entities.FindByName(h,"i_vaginaface_model*")))
	{amount_vaginaface++;}
	h = null;while(null!=(h=Entities.FindByName(h,"i_diddlebaby_model*")))
	{amount_babyface++;}
	local spawnlist = [];
	local spawnheight = 850;
	if(amount_vaginaface <= 3)
		spawnlist.push("s_vaginaface");
	if(amount_babyface <= 3)
		spawnlist.push("s_diddlebaby");
	spawnlist.push("s_mortar");
	spawnlist.push("s_mortar");
	spawnlist.push("s_mortar");
	spawnlist.push("s_mortar");
	spawnlist.push("s_mortar");
	spawnlist.push("s_mortar");
	spawnlist.push("s_mortar");
	spawnlist.push("s_mortar");
	spawnlist.push("s_mortar");
	spawnlist.push("s_mortar");
	spawnlist.push("blobblaser_tem1");
	spawnlist.push("blobblaser_tem1");
	local spawnitem = spawnlist[RandomInt(0,spawnlist.len()-1)];
	if(spawnitem == "blobblaser_tem1")
		spawnheight = 48;
	GetRandomCT(spawnitem,Vector(0,0,spawnheight));
}
function ExevTickFinalbossLaser()
{
	if(!exev_finalboss_laserticking)
		return;
	EntFireByHandle(self,"RunScriptCode"," ExevTickFinalbossLaser(); ",exev_finalboss_lasertickrate,null,null);
	if(RandomInt(0,4)==1)
		EntFire("dd_attack_slash_spawn","PickRandom","",0.00,null);
	else
		EntFire("dd_attack_upslash_spawn","PickRandom","",0.00,null);
}
exev_finalboss_laserticking <- false;
exev_finalboss_lasertickrate <- 0.90;
exev_omaha_zchecktries_max <- 10;
exev_omaha_zchecktries <- 10;
exev_omaha_zpercentage <- 30.00;
exev_omaha_zhealthcap <- 500;
exev_omaha_zombies <- [];
exev_weebtick_min <- 0.1;
exev_weebtick_max <- 5.0;
exev_weebticking <- false;
exev_spawnmakers <- [];		//ExSpawnMaker(name,handle);
exev_spawnbounds <- [];		//ExSpawnBounds(template,minX,maxX,minY,maxY,Z,rot)
exev_spawns <- [];			//ExSpawn(template,pos,!rot);
exev_spawnrate <- 0.50;		//spawn/tickrate for the spawns/spawnbounds^ (stops ticking when there's no spawns/spawnbounds)
exev_spawnticking <- false;
exev_spawnqueue <- [];		//spawn-queue for time-based spawns
function ExevRoundStart()	//reset states (triggered every round start IF 'extreme' is TRUE)
{
	foreach(sm in exev_spawnmakers)
	{
		if(sm.handle != null && sm.handle.IsValid())
			EntFireByHandle(sm.handle,"Kill","",0.00,null,null);
	}
	EntFireByHandle(self,"RunScriptCode"," FetusFaceBoobie(); ",RandomFloat(1.00,500.00),null,null);
	exev_finalboss_laserticking = false;
	exev_omaha_zchecktries = exev_omaha_zchecktries_max;
	exev_omaha_zpercentage = 30.00;
	exev_omaha_zhealthcap = 500;
	zombe_item_users.clear();
	zombe_item_users = [];
	exev_omaha_zombies.clear();
	exev_omaha_zombies = [];
	exev_weebticking = false;
	exev_spawnmakers.clear();
	exev_spawnbounds.clear();
	exev_spawns.clear();
	exev_spawnqueue.clear();
	exev_spawnmakers = [];
	exev_spawnbounds = [];
	exev_spawns = [];
	exev_spawnqueue = [];
	exev_spawnticking = false;
	exev_spawnrate = 0.10;
	ExevSpawnTick();
	ExevSpawnQueueTick();
}
function ExevSpawnTick()
{
	if(exev_spawns.len()<=0 && exev_spawnbounds.len()<=0)
	{
		exev_spawnticking = false;
		return;
	}
	exev_spawnticking = true;
	EntFireByHandle(self,"RunScriptCode"," ExevSpawnTick(); ",exev_spawnrate,null,null);
	if(exev_spawns.len()>0)
	{
		local sp = exev_spawns[RandomInt(0,exev_spawns.len()-1)];
		ExevSpawn(sp.template,sp.pos,sp.rot)
	}
	if(exev_spawnbounds.len()>0)
	{
		local sp = exev_spawnbounds[RandomInt(0,exev_spawnbounds.len()-1)];
		local sp_pos = Vector(RandomFloat(sp.minX,sp.maxX),RandomFloat(sp.minY,sp.maxY),sp.Z);
		ExevSpawn(sp.template,sp_pos,sp.rot)
	}
}
function ExevSpawnQueueTick()
{
	EntFireByHandle(self,"RunScriptCode"," ExevSpawnQueueTick(); ",0.01,null,null);
	local cleaned = true;
	foreach(q in exev_spawnqueue)
	{
		q.time -= FrameTime();
		if(q.time <= 0.00)
		{
			cleaned = false;
			ExevSpawn(q.spawn.template,q.spawn.pos,q.spawn.rot);
		}
	}
	while(!cleaned)
	{
		cleaned = true;
		for(local i=0;i<exev_spawnqueue.len();i++)
		{
			if(exev_spawnqueue[i].time <= 0.00)
			{
				cleaned = false;
				exev_spawnqueue.remove(i);
				break;
			}
		}
	}
}
function ExevSpawn(template,pos,rot=Vector(0,0,0),time=0.00)
{
	if(rot==null)
		rot = Vector(0,0,0);
	if(time > 0.00)
	{
		exev_spawnqueue.push(ExSpawnQueue(ExSpawn(template,pos,rot),time));
		return;
	}
	local spawner = null;
	local exists = false;
	foreach(sm in exev_spawnmakers)
	{
		if(sm.name == template)
		{
			spawner = sm.handle;
			exists = true;
			break;
		}
	}
	if(!exists)
	{
		local tem = Entities.FindByName(null,template);
		if(tem==null||!tem.IsValid())
			return;
		if(tem.GetClassname()!="point_template")
			return;
		spawner = Entities.CreateByClassname("env_entity_maker");
		spawner.__KeyValueFromString("EntityTemplate",template);
		exev_spawnmakers.push(ExSpawnMaker(template,spawner));
	}
	if(spawner == null || !spawner.IsValid())
		return;
	spawner.SpawnEntityAtLocation(pos,rot);
}
function GetRandomCT(tem=null,ofs=null)
{
	local hlist = [];
	local h = null;
	while(null!=(h=Entities.FindByClassname(h,"player")))
	{
		if(h!=null&&h.IsValid()&&h.GetHealth()>0&&h.GetTeam()==3)
			hlist.push(h);
	}
	if(hlist.len()>0)
	{
		local r = hlist[RandomInt(0,hlist.len()-1)];
		if(tem!=null)
			ExevSpawn(tem,r.GetOrigin()+ofs);
		return r;
	}
	return null;
}
function ExtremeOmahaTPZ()
{
	exev_omaha_zombies.clear();
	exev_omaha_zombies = [];
	local h = null;
	while(null!=(h=Entities.FindByClassname(h,"player")))
	{
		if(h!=null&&h.IsValid()&&h.GetHealth()>6000&&h.GetTeam()==2)
			exev_omaha_zombies.push(h);
	}
	if(exev_omaha_zombies.len()<=0)
	{
		exev_omaha_zchecktries--;
		if(exev_omaha_zchecktries > 0)
			EntFireByHandle(self,"RunScriptCode"," ExtremeOmahaTPZ(); ",1.00,null,null);
	}
	else
	{
		if(exev_omaha_zombies.len() < 5)
			return;
		local targetsize = ((1/((1/exev_omaha_zpercentage)/(0.00 + exev_omaha_zombies.len())))/100);
		if(targetsize <= 0)
			return;
		local trimmed = false;
		while(!trimmed)
		{
			trimmed = true;
			if(exev_omaha_zombies.len()>0)
				exev_omaha_zombies.remove(RandomInt(0,exev_omaha_zombies.len()-1));
			else
				return;
			if(exev_omaha_zombies.len() > targetsize)
				trimmed = false;
		}
		foreach(h in exev_omaha_zombies)
		{
			EntFireByHandle(h,"SetHealth",exev_omaha_zhealthcap.tostring(),0.00,null,null);
			h.SetOrigin(Vector(RandomInt(-13760,-11328),3072,14208));
			h.SetVelocity(Vector(0,0,0));
		}
		ExtremeOmahaTPZTick();
	}
}
function ExtremeOmahaTPZTick()
{
	if(exev_omaha_zombies.len() <= 0)
		return;
	EntFireByHandle(self,"RunScriptCode"," ExtremeOmahaTPZTick(); ",0.10,null,null);
	local cleaned = true;
	foreach(h in exev_omaha_zombies)
	{
		if(h!=null||!h.IsValid()||h.GetHealth<=0||h.GetTeam()!=2||h.GetHealth()>(1000+exev_omaha_zhealthcap))
			cleaned = false;
		else
		{
			if(h.GetOrigin().y > 4310)
				h.SetOrigin(Vector(RandomInt(-13760,-11328),3072,14208));
			if(h.GetHealth()>exev_omaha_zhealthcap)
				EntFireByHandle(h,"SetHealth",exev_omaha_zhealthcap.tostring(),0.00,null,null);
		}
	}
	while(!cleaned)
	{
		cleaned = true;
		for(local i=0;i<exev_omaha_zombies.len();i++)
		{
			local h = exev_omaha_zombies[i];
			if(h!=null||!h.IsValid()||h.GetHealth<=0||h.GetTeam()!=2||h.GetHealth()>(1000+exev_omaha_zhealthcap))
			{
				cleaned = false;
				exev_omaha_zombies.remove(i);
				break;
			}
		}
	}
}

CAKE_NADEREFILL_RANGE <- 512;
function GrenadeRefillCake()
{
	if(!extreme)
		return;
	if(caller!=null&&caller.IsValid()) //should be cake button handle 
	{
		local h = null;
		local interval = 0.05;
		while(null!=(h=Entities.FindByClassnameWithin(h,"player",caller.GetOrigin(),CAKE_NADEREFILL_RANGE)))
		{
			if(h!=null&&h.IsValid()&&h.GetHealth()>0&&h.GetTeam()==3)
			{
				EntFireByHandle(self,"RunScriptCode"," GrenadeRefillCakePlayer(); ",interval,h,h);
				interval += 0.05; //do this to not refill nades on everyone at the same exact time, spread the load (seems to be edict-heavy otherwise)
			}
		}
	}
}
function GrenadeRefillCakePlayer()
{
	if(activator!=null&&activator.IsValid()&&activator.GetHealth()>0&&activator.GetTeam()==3)
		EntFire("stripstrop_nade_refill","Use","",0.00,activator);
}

zombe_item_users <- [];
function PickedUpZombieKnife()
{
	printl(activator);
	if(activator==null||!activator.IsValid()||activator.GetHealth()<=0||activator.GetTeam()!=2)
		return;
	zombe_item_users.push(activator);
	local tp_pos = Vector(7275,310,245);
	if(!checkpoint)
		tp_pos = Vector(2603,1027,156);
	activator.SetOrigin(tp_pos)
}
function KillZombieItems()
{
	foreach(h in zombe_item_users)
	{
		if(h==null||!h.IsValid()||h.GetHealth()<=0||h.GetTeam()!=2)
			continue;
		EntFireByHandle(h,"SetHealth","-69",0.00,null,null);
	}
}

function FetusFaceBoobie()
{
	local time = RandomFloat(1.00,30.00);
	EntFire("stripstrop_fetusface_particle","Stop","",0.00,null);
	EntFire("stripstrop_fetusface_particle","Start","",0.02,null);
	EntFire("stripstrop_fetusface_particle","Stop","",time,null);
	EntFireByHandle(self,"RunScriptCode"," FetusFaceBoobie(); ",time + RandomFloat(1.00,500.00),null,null);
}
