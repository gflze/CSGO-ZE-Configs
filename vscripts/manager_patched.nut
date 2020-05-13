//===================================\\
// Script by Luffaren (STEAM_0:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/_mapscripts/ze_diddle/)
//
//  Patched version intended for use with GFL ze_diddle_v3 stripper, included in the release
//  Adds "Diddle Extreme", where you must beat everything in a single round (with some help/items)
//===================================\\

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
80,					//2 - push					(pre-stripper-V3:	40)
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


//walls get 100+(X*Tcount)hp depending on the wall (small green:50  /  mid red:100  /  big yellow:150)
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

EXMVOTE_EXTREME_PERCENTAGE <- 80;
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
	constructor(_userid,_steamid,_score)
	{
		userid = _userid;
		steamid = _steamid;
		score = _score;
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
		EntFire("manager", "RunScriptCode", "VoteMsg();", 4.00, null);
		exmvote_voteallowed = true;
		EntFireByHandle(self, "RunScriptCode", " exmvote_voteallowed = false; ", 10.90, null, null);
	}
	else
	{
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
						AddPlayerShopBias((SHOPBIAS_ADD_PLAYEDROUND),h,true)	
					}
				}
			}
			AddPlayerScore(SHOPBIAS_ADD_PLAYEDROUND,hsclist);
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
	EntFire("coin_text", "SetText", "COINS: "+coins.tostring()+"/250", 0.00, self);
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
	ResetMap();
}

function SkipToFinale()
{
	coins_lastround = (0+coins);
	checkpoint = true;
}

function GetAllCoins()
{
	coins_lastround = 250;
	coins = 250;
	CheckMaxedCoinsCheckpoint();
}

function ResetMapBase()
{
	coins = 0;
	coins_lastround = 0;
	checkpoint = false;
	stagepool = [0,1,2,3,4];
	stageskip = [];
	wcheck = null;
	ResetAllScore();
}

function ResetMap()
{
	ResetMapBase();
	extreme = false;
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

function TorchCooldownVis()
{
	if(caller==null || !caller.IsValid())
		return;
	if (extreme && !normalTorchCooldowns)
	{
		EntFireByHandle(caller, "DisableDraw", "", 0.00, null, caller);
		EntFireByHandle(caller, "EnableDraw", "", 300.00, null, caller);		//300 SECOND COOLDOWN!
	}
}
function TorchCooldown()
{
	if (extreme && !normalTorchCooldowns)
		EntFireByHandle(caller, "Unlock", "", 300.00, activator, caller);		//300 SECOND COOLDOWN!
	else
		EntFireByHandle(caller, "Unlock", "", 20.00, activator, caller);
}

function VoteMsg()
{
	if (stagepool.len() != 0 && extreme)
	{
		EntFire("server", "Command", "say ***EXTREME MODE IS ACTIVE, YOU CAN SHOOT THE STAGE PICTURES TO SELECT THEM***", 0.00, null);
	}
}

function OmahaMortarExtremeRender()
{
	if(!extreme)
		return;
	if(caller==null||!caller.IsValid())
		return;
	EntFireByHandle(self,"RunScriptCode"," OmahaMortarExtremeRender(); ",0.08,null,caller);
	local pos = caller.GetOrigin();
	local tdist = TraceLine(pos,pos+Vector(0,0,-10000),caller);
	pos = (pos+(Vector(0,0,-10000)*tdist));
	DebugDrawBox(pos,Vector(-5,-5,-2),Vector(5,5,2),255,0,0,255,0.15);
	DebugDrawBox(pos,Vector(-10,-10,-4),Vector(10,10,4),255,100,0,100,0.15);
	DebugDrawBox(pos,Vector(-15,-15,-5),Vector(15,15,5),255,255,0,50,0.15);
	DebugDrawBox(pos,Vector(-30,-30,-10),Vector(30,30,10),255,255,255,50,0.15);
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
	if(coins > 250)coins = 250;
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
