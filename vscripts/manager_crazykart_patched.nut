//#####################################################################
//Patched version intended for use with GFL ze_crazykart_v4 stripper
//Removes HTML formatting broken after Shattered Web Update.
//Install as csgo/scripts/vscripts/gfl/manager_crazykart_patched.nut
//#####################################################################

//ze_crazykart - by Luffaren

//V4 StringTable convert ---------> DONE

//=================================================================\\
//		say !ef /idme manager runscriptcode MASTERSPRITE = false
//		say !ef /idme manager runscriptcode CAMRECORD = true
//		say !ef /idme manager runscriptcode SetDevCamera(0,5)
//=================================================================\\

MASTERZERO						<-		false;					//F-zero cosmetic
MASTERCOLOR						<-		Vector(250,200,0);		//MASTER color, null=disable
MASTERBATE						<-		false;					//devmode
MASTERTIER						<-		3;						//devmode item tier (null=disable, 1, 2, 3)
MASTERFUCK						<-		false;					//devmode sanic start
MASTERHUNT 						<- 		false;					//override master as starhunter-pick (devmode not needed)
READCONFIG 						<- 		true;					//set to false in order to manually override .nut CFG variables
CAMRECORD						<-		false;					//dev recording	   //SetDevCamera(index,time,ridx=null)  //1-6
//	!ef manager runscriptcode ResetFinale()						//lets you play the finale again

KARTCOLOR_PLACEMENT_REQUIREMENT <- 		5;		//must be at least this placement in order for !kartcolor to work (B4:3, B5:5)
AUTOVOTE_TIME <- 11;			//seconds before the map auto-chooses something randomly (pauses during active player vote)
SCORE_PUNISH 					<- 		-100;
SCORE_FINISH_RACE 				<- 		100;
SCORE_FINISH_LAP 				<- 		30;
SCORE_FINISH_CHECKPOINT 		<- 		1;
SCORE_FINISH_RACE_PLACEBONUS	<-		10;		//15th place gets X, 14th place gets X+X, 13th place gets X+X+X, etc
SCORE_KILL						<-		50;		//if a player kills another player (should work with zombie infections too)
//SCORE_ITEM_HIT				<-		5;		//not used...
SCORE_LAST_ALIVE 				<-		300;
SCORE_KILLED_OMAR				<-		500;	//score for being the first player/driving into omar during the finale
SCORE_FINISHED_MAP				<-		500;	//score for being one of the surviving players as the finale ends
SCORE_BATTLE_PLACEBONUS			<-		300;	// this means:    (X/karts-left), so 300 at 12 karts left is: (300/12)=25
SCORE_HUMAN_SURVIVOR			<-		50;		//score for being a surviving human NOT in a kart when RaceWon(); is called
SCORE_ROUND_ENDED_EARLY			<-		20;		//score for being in a kart if the round ended early (for example if all humans died)
VIMPACT_FIRSTSCORE 				<- 		11;		//B2 = 20
VIMPACT_STARTSCORE 				<- 		6;		//B2 = 10
VIMPACT_DECREASE 				<- 		2;		//B2 = 3
DEBUG 							<- 		false;
INACTIVITY_SLAY_TIME			<-		60.00;	//after a race starts, check for inactivity/camp/trolling and slay at this second-rate
S7_SUDDEN_DEATH_RATE			<-		10.0;	//this value determines the rate which to tick sudden-death spawns (active_karts/S7_SUDDEN_DEATH_RATE=rate)
S7_SUDDEN_DEATH_START			<-		20;		//when it's star royale and it's only this amount of karts left (or under), start spawning bombs
S7_SUDDEN_DEATH_ARTILLERYSTART	<-		10;		//when it's star royale and it's only this amount of karts left (or under), start spawning artillery
RACEPLACEMENT_MAX				<- 		0;		//read-only-value, do not touch (shows the amount of active players in karts)
PLAYERS_FINISHED				<-		0;		//read-only-value, do not touch (used to figure out the amount of players that finished)

//EXTERNAL CONFIG VARIABLES:
KART_SPAWN_AMOUNT <- 64;
KART_HEALTH_RACE <- 200;
KART_HEALTH_BATTLE <- 50;
KART_HEALTH_STARROYALE <- 10;
KART_HEALTH_FZERO <- 100;
KILL_NON_KART_PLAYERS <- false;
SPAWN_THWOMPS <- true;
SPAWN_ITEMBOXES <- true;
SPAWN_RNG <- true;
RETRY_TO_FIX_NAMES	<-	false;
ENABLE_KART_JUMP <-	true;
::PREFER_THIRDPERSON	<-	true;
BOOM_COMMAND_COOLDOWN <- 10.00;
FINALE_ACTIVATION_SCORE	<-	2000;
BOOM_RACE	<-	true;
BOOM_BATTLE	<-	true;
BOOM_STARROYALE	<-	false;
BOOM_FZERO <-	false;
BOOM_FINALE	<-	false;
KART_BHOP_PUNISH_LIMIT <- 3;
KART_BHOP_PUNISH_COOLDOWN <- 5.00;
KART_BHOP_PUNISH_SLOWAMOUNT	<- 0.30;
KART_BHOP_PUNISH_SLOWTIME <- 0.70;
KART_JUMP_COOLDOWN <- 0.50;
KART_GROUNDMELT_TRY_FIX	<- true;
FINALE_SKIP_TO_BOSS	<- false;
KART_FALLDOWN_TP_TO_SPAWN <- true;
PUNISH_INACTIVITY <- true;
GENERAL_EXPLOSION_DAMAGE <-	0;
GENERAL_EXPLOSION_RADIUS <-	200;
FINALE_EXPLOSION_DAMAGE	<- 500;
FINALE_EXPLOSION_RADIUS <- 200;
ALLOW_DAMAGE_IN_KART <-	false;
FZERO_BOOST_HP_DRAIN <-	15;
FZERO_BOOST_COOLDOWN <-	1.50;
KART_FALLDOWN_TP_TO_LASTCP <- true;
KART_ALLOW_LMB_BEEP <- true;
HIDE_HUD_DURING_STAGEINTRO <- true;
KART_SPEED_MODIFIER <- 0.00;
ZOMBIE_ITEM_COOLDOWN <- 10.00;
FINALE_MAX_TRIES_UNTIL_SKIP <- 6;
FINALE_SKIP_IF_REACHED_AND_FAILED_LASERS <- false;
PUNISH_ITEMCAMPING <- true;
PUNISH_ITEMCAMPING_RANGE <- 512;
PUNISH_ITEMCAMPING_COUNT <- 3;
FINALE_SKIP_TO_BOSS_IF_REACHED <- true;
FINALE_MAX_TRIES_UNTIL_SKIP_TO_BOSS <- 3;
FINALE_LASER_TIMER_MIN <- 0.20;
FINALE_LASER_TIMER_MAX <- 2.00;
FINALE_JUMPLASER_TIMER_MIN <- 1.50;
FINALE_JUMPLASER_TIMER_MAX <- 7.00;
ITEM_TIER_FIRST <- 30.00;
ITEM_TIER_LAST <- 70.00;
RACEPLACEMENT_UPDATE_RATE <- 2.00;
ITEMCHANCE_TIER_ENABLE <- true;
STARTBOOST_TIMEWINDOW <- 0.10;
DISABLE_GHOSTMODE <- false;
FINALE_ONLY_ALLOW_CT_WIN <- true;
DISALLOW_PVP_DAMAGE	<- false;
KART_AUTO_CHECKPOINT_ENABLED <- true;
KART_AUTO_CHECKPOINT_RATE <- 2.00;
FZERO_DISABLE_WALL_DAMAGE <- false;
WEAPON_RESTRICT_MODE <- 2;
WEAPON_RESTRICT_MODE_FINALE <- 0;
STARHUNTER_KONI_VOICE <- true;
STARHUNTER_START_WAIT_TIME <- 10.00;
STARHUNTER_SPEED_MODIFIER <- -0.50;
STARHUNTER_VOTES_NEEDED <- 70.00;
STARHUNTER_SCORE_BIAS <- 10;
::FINALE_BOSS_INCLUDE_T_IN_FIGHT <- false;
::FINALE_DISALLOW_ITEMS_AT_LASERS <- false;
::KARTDESTROYED_SMOKE_ENABLED <- true;
::KARTDESTROYED_SMOKE_CHANCE <- 100;
::KARTDESTROYED_SMOKE_CLEANTIME <- 100.00;
::FINALE_BOSS_ARTILLERY_AMOUNT <- 2;

::ITEMCHANCE_TIER_1 <- [//==========> for people up ahead, very low chance for good items
0	,	30	 ,//-----> artillery
2	,	200	 ,//-----> banana_1
3	,	80	 ,//-----> banana_3
4	,	20	 ,//-----> bomb
5	,	30	 ,//-----> feather
6	,	15	 ,//-----> ghost
7	,	10	 ,//-----> mushroom_1
8	,	7	 ,//-----> mushroom_3
9	,	60	 ,//-----> oil
10	,	1	 ,//-----> panic
11	,	50	 ,//-----> shellgreen_1
12	,	30	 ,//-----> shellgreen_3
13	,	25	 ,//-----> shellred_1
14	,	10	 ,//-----> shellred_3
15	,	1	 ,//-----> star
16	,	1	 ,//-----> thunder
21	,	100  ,//-----> fakeitembox
22	,	1   ];//-----> shellblue
::ITEMCHANCE_TIER_2 <- [//==========> for people in the middle, a default/generally mixed item pool
0	,	30	 ,//-----> artillery
2	,	120	 ,//-----> banana_1
3	,	100	 ,//-----> banana_3
4	,	40	 ,//-----> bomb
5	,	60	 ,//-----> feather
6	,	30	 ,//-----> ghost
7	,	120	 ,//-----> mushroom_1
8	,	90	 ,//-----> mushroom_3
9	,	50	 ,//-----> oil
10	,	1	 ,//-----> panic
11	,	100	 ,//-----> shellgreen_1
12	,	90	 ,//-----> shellgreen_3
13	,	80	 ,//-----> shellred_1
14	,	70	 ,//-----> shellred_3
15	,	6	 ,//-----> star
16	,	3	 ,//-----> thunder
21	,	40   ,//-----> fakeitembox
22	,	10  ];//-----> shellblue
::ITEMCHANCE_TIER_3 <- [//==========> for people in the back, very high chance for good items
0	,	10	 ,//-----> artillery
2	,	1	 ,//-----> banana_1
3	,	10	 ,//-----> banana_3
4	,	30	 ,//-----> bomb
5	,	35	 ,//-----> feather
6	,	15	 ,//-----> ghost
7	,	20	 ,//-----> mushroom_1
8	,	100	 ,//-----> mushroom_3
9	,	15	 ,//-----> oil
10	,	2	 ,//-----> panic
11	,	15	 ,//-----> shellgreen_1
12	,	40	 ,//-----> shellgreen_3
13	,	20	 ,//-----> shellred_1
14	,	100	 ,//-----> shellred_3
15	,	60	 ,//-----> star
16	,	4	 ,//-----> thunder
21	,	15   ,//-----> fakeitembox
22	,	20  ];//-----> shellblue
::ITEMCHANCE_TIER_BATTLE <- [//==========> item pool for battle-mode, more aggressive items (no blue shell as it only works for races)
0	,	30	 ,//-----> artillery
2	,	120	 ,//-----> banana_1
3	,	100	 ,//-----> banana_3
4	,	40	 ,//-----> bomb
5	,	60	 ,//-----> feather
6	,	30	 ,//-----> ghost
7	,	120	 ,//-----> mushroom_1
8	,	90	 ,//-----> mushroom_3
9	,	50	 ,//-----> oil
10	,	1	 ,//-----> panic
11	,	100	 ,//-----> shellgreen_1
12	,	90	 ,//-----> shellgreen_3
13	,	80	 ,//-----> shellred_1
14	,	70	 ,//-----> shellred_3
15	,	10	 ,//-----> star
16	,	3	 ,//-----> thunder
21	,	40   ];//----> fakeitembox

scoreboard <- [];
stageteleport <- null;
stp <- Vector(-260,0,12);
stps <- -1;
stpss <- 0;
racewon <- false;
max_laps <- 999999;
finallap <- false;
winplacing <- 1;
songname <- "";
songoffset <- 0.00;
ghostarr <- 	[[],[],[],[],[],[],[],[],[]];
ghostarr_cur <- [];
ghostarr_time<- [999999,999999,999999,999999,999999,999999,999999,999999,999999];
ghostarr_idx <- -1;
ghost_count <- 0;
ghost_time <- 0.00;
ghost_showtime <- 0.00;
ghost_kart <- null;
ghost_active <- false;
votescore <- 	[0,0,0,0,0,0,0,0,0,0,0];
votescoreb <- 	[0,0,0,0,0,0,0,0,0,0,0];
votedone <- false;
avote <- AUTOVOTE_TIME;
avote_active <- true;
voteminspeed <- 100;
racestart <- true;	//false = battle music + no camera + faster start
warmup_done <- false;
iswarmup <- true;
tpkartlist<-[];
inspawnhub<-true;
allowboom<-false;
s7_bomb<-false;
allkartsbroken <- false;
zero <- false;
finalereached <- false;
finalewon <- false;
finaleactive <- false;
bombzstate <- false; //set this to true when zombie bomb items can throw bombs forward
ex_damage <- 0;
ex_radius <- 200;
finale_pickedupzitems <- 0;
finalewinreason <- 0;
finaleroundcount <- 0;
textlapsindex <- 1;
::TPRECOVER <- [];
::TPRECOVER_INDEX <- 0;

function AddTpRecover()
{
	if(caller!=null&&caller.IsValid())
		::TPRECOVER.push(caller);
}

::GetTpRecover <- function()
{
	local tp = ::TPRECOVER[::TPRECOVER_INDEX];
	::TPRECOVER_INDEX++;
	if(::TPRECOVER_INDEX>=::TPRECOVER.len())
		::TPRECOVER_INDEX = 0;
	return tp;
}

function TickPlayerDamageFilter()
{
	EntFireByHandle(self,"RunScriptCode"," TickPlayerDamageFilter(); ",5.00,null,null);
	for(local i=0;i<PLAYERS.len();i++)
	{
		if(PLAYERS[i].handle!=null&&PLAYERS[i].handle.IsValid())
		{
			if(PLAYERS[i].kart != null && PLAYERS[i].kart.IsValid())
				EntFireByHandle(PLAYERS[i].handle,"SetDamageFilter","filter_player_no",0.00,null,null);
		}
	}
}

starhunter_v_ready <- false;
starhunter_v_needed <- 0;
starhunter_v_current <- 0;
starhunter_votedone <- false;
starhunter_countdown <- 10.00;
starhunter_counting <- false;
starhunter_player <- null;
starhunter_playername <- null;
starhunter_kart <- null;
starhunter_baseh <- null;
function StarHunterVote(trig_butt)
{
	if(starhunter_votedone || !starhunter_v_ready)return;
	local c = GetPlayerClassByHandle(activator);
	if(c==null||c.handle==null||!c.handle.IsValid()||c.votedstarhunt)return;
	starhunter_v_current++;
	c.votedstarhunt = true;
	EntFire("fade_repair","Fade","",0.00,activator);
	local votestatusmsg = starhunter_v_current.tostring()+" / "+starhunter_v_needed.tostring()+" votes needed";
	EntFire("starhunter_vote_text","AddOutput","message "+votestatusmsg,0.00,null);
	if(MASTER!=null&&MASTERBATE&&c.userid==MASTER)starhunter_v_current=starhunter_v_needed;
	if(starhunter_v_current >= starhunter_v_needed)
	{
		starhunter_votedone = true;
		EntFire("starhunter_vote_stageindicator","Close","",0.00,null);
		EntFire("s_starhunt","ForceSpawn","",0.00,null);
		EntFire("starhunter_vote_text","AddOutput","message vote successful!",0.00,null);
		EntFire("starhunter_vote_text","AddOutput","message vote successful!",0.02,null);
		EntFire("starhunter_vote_text","AddOutput","message vote successful!",0.05,null);
	}
}
function SetStarHuntBase()
{
	starhunter_baseh = caller;
}
function StarHunterStartCountdown()
{
	starhunter_countdown = STARHUNTER_START_WAIT_TIME;
	starhunter_counting = true;
	starhunter_player = null;
	starhunter_kart = null;
	if(MASTER!=null&&MASTERHUNT)
	{
		starhunter_player = GetPlayerClassByUserID(MASTER);
		if(starhunter_player==null||starhunter_player.handle==null||!starhunter_player.handle.IsValid()||
		starhunter_player.handle.GetHealth()<=0||starhunter_player.kart==null||!starhunter_player.kart.IsValid())
			starhunter_player = null;
		else
			starhunter_kart = starhunter_player.kart;
	}
	if(starhunter_player==null)
	{
		local shuntcandidates = [];
		for(local i=0;i<PLAYERS.len();i++)
		{
			if(PLAYERS[i].handle==null||!PLAYERS[i].handle.IsValid()||PLAYERS[i].handle.GetHealth()<=0)continue;
			if(PLAYERS[i].kart==null||!PLAYERS[i].kart.IsValid())continue;
			if(PLAYERS[i].scoreplacement <= 15 && PLAYERS[i].scoreplacement > 0)
			{
				for(local j=0;j<((16*STARHUNTER_SCORE_BIAS).tointeger() - (PLAYERS[i].scoreplacement*STARHUNTER_SCORE_BIAS).tointeger());j++)
				{
					shuntcandidates.push(PLAYERS[i]);
				}
			}
		}
		if(shuntcandidates.len()<=0)
		{
			for(local i=0;i<PLAYERS.len();i++)
			{
				if(PLAYERS[i].handle==null||!PLAYERS[i].handle.IsValid()||PLAYERS[i].handle.GetHealth()<=0)continue;
				if(PLAYERS[i].kart==null||!PLAYERS[i].kart.IsValid())continue;
				shuntcandidates.push(PLAYERS[i]);
			}
		}
		if(shuntcandidates.len()<=0)
			starhunter_player = null;
		else
		{
			starhunter_player = shuntcandidates[RandomInt(0,shuntcandidates.len()-1)];
			starhunter_kart = starhunter_player.kart;
		}
	}
	if(starhunter_player!=null)
	{
		starhunter_playername = starhunter_player.name;
		if(starhunter_playername==null||starhunter_playername==""||starhunter_playername==" ")
			starhunter_playername="userid-"+c.userid.tostring();
		for(local iii=0;iii<100;iii++)
		{
			local nindex = starhunter_playername.find("<");
			if(nindex==null)nindex = starhunter_playername.find(">");
			if(nindex==null)break;
			else
			{
				local npart1 = starhunter_playername;
				local npart2 = "";
				if(nindex==0)
				{
					npart1 = starhunter_playername.slice(1,starhunter_playername.len());
				}
				else if(nindex==starhunter_playername.len()-1)
					npart1 = starhunter_playername.slice(0,starhunter_playername.len()-1);
				else
				{
					npart1 = starhunter_playername.slice(0,nindex);
					npart2 = starhunter_playername.slice(nindex+1,starhunter_playername.len());
				}
				starhunter_playername = npart1+npart2;
			}
		}
		EntFireByHandle(starhunter_kart,"DisableMotion","",0.00,null,null);
		EntFireByHandle(starhunter_kart,"RunScriptCode"," SetInvincibility(10000); ",0.00,null,null);
		EntFireByHandle(starhunter_kart,"RunScriptCode"," AddSpeed("+STARHUNTER_SPEED_MODIFIER.tostring()+"); ",0.00,null,null);
		StarHunterPrintTick();
	}
}
function StarHunterPrintTick()
{
	if(!starhunter_counting)
	{
		StarHunterStart();
		ScriptPrintMessageCenterAll("  STAR HUNTER     ENABLED"+
		"\n"+starhunter_playername+" has been picked as the Star Hunter!"+
		"\n"+starhunter_playername+" has been released!"+
		"\nGood luck!");
		return;
	}
	EntFireByHandle(self,"RunScriptCode"," StarHunterPrintTick(); ",0.01,null,null);
	starhunter_countdown -= 0.015625;
	if(starhunter_countdown <= 0.00)
	{
		starhunter_countdown = 0.00;
		starhunter_counting = false;
	}
	local timeleft = format("%.2f",starhunter_countdown.tofloat());
	ScriptPrintMessageCenterAll("  STAR HUNTER     ENABLED"+
	"\n"+starhunter_playername+" has been picked as the Star Hunter!"+
	"\n"+starhunter_playername+" will be released in:"+
	"\n"+timeleft.tostring()+" Seconds");
}
function StarHunterStart()
{
	StarHunterTick();
	if(STARHUNTER_KONI_VOICE)
		EntFire("i_starhunt_case","PickRandomShuffle","",0.00,null);
	if(starhunter_kart != null && starhunter_kart.IsValid())
	{
		EntFireByHandle(starhunter_kart,"EnableMotion","",0.00,null,null);
		starhunter_baseh.SetOrigin(starhunter_kart.GetOrigin());
		EntFireByHandle(starhunter_baseh,"SetParent","!activator",0.01,starhunter_kart,starhunter_kart);
		EntFireByHandle(starhunter_baseh,"SetParent","!activator",0.02,starhunter_kart,starhunter_kart);
		EntFireByHandle(starhunter_kart,"RunScriptCode"," SetStarSkin(); ",0.00,null,null);
	}
}
function StarHunterTick()
{
	if(starhunter_kart != null && starhunter_kart.IsValid())
	{
		EntFireByHandle(self,"RunScriptCode"," StarHunterTick(); ",12.00,null,null);
		EntFireByHandle(starhunter_kart,"RunScriptCode"," GetStar(); ",0.00,null,null);
		EntFireByHandle(starhunter_kart,"RunScriptCode"," SetInvincibility(10000); ",0.02,null,null);
	}
}

finalewintriggertouched <- false;
function FinaleRunWinTrigger()
{
	finalewintriggertouched = false;
	if(FINALE_ONLY_ALLOW_CT_WIN)
	{
		EntFire("finale_wintrigger","RunScriptCode"," WinStage(500,true); ",0.02,null);
	}
	else
		EntFire("finale_wintrigger2","Enable","",0.02,null);
	EntFireByHandle(self,"RunScriptCode"," FinaleRunWinTriggerPost(); ",2.00,null,null);
}
function FinaleRunWinTriggerPost()
{
	if(!finalewintriggertouched)
	{
		EntFire("server","Command","say ***NO ONE MADE IT - YOU FAILED***",0.00,null);
		EntFire("server","Command","say ***NO ONE MADE IT - YOU FAILED***",0.05,null);
		EntFire("server","Command","say ***NO ONE MADE IT - YOU FAILED***",0.10,null);
		EntFireByHandle(self,"RunScriptCode"," KillAllPlayers(); ",0.00,null,null);
	}
}

function ResetFinale(skiptoboss=false)
{
	finalewinreason = 0;
	finaleroundcount = 0;
	finalewon = false;
	if(skiptoboss)FINALE_SKIP_TO_BOSS = true;
	else FINALE_SKIP_TO_BOSS = false;
}

function SetConfig()
{
	if(!READCONFIG)return;
	if(caller==null||!caller.IsValid())return;
	caller.ValidateScriptScope();
	local ccc = caller.GetScriptScope();
	if("valid_v4" in ccc)
	{
		KART_SPAWN_AMOUNT = ccc.KART_SPAWN_AMOUNT;if(KART_SPAWN_AMOUNT<1)KART_SPAWN_AMOUNT=1;else if(KART_SPAWN_AMOUNT>64)KART_SPAWN_AMOUNT=64;
		KART_HEALTH_RACE = ccc.KART_HEALTH_RACE;
		KART_HEALTH_BATTLE = ccc.KART_HEALTH_BATTLE;
		KART_HEALTH_STARROYALE = ccc.KART_HEALTH_STARROYALE;
		KART_HEALTH_FZERO = ccc.KART_HEALTH_FZERO;
		KILL_NON_KART_PLAYERS = ccc.KILL_NON_KART_PLAYERS;
		SPAWN_THWOMPS = ccc.SPAWN_THWOMPS;
		SPAWN_ITEMBOXES = ccc.SPAWN_ITEMBOXES;
		SPAWN_RNG = ccc.SPAWN_RNG;
		RETRY_TO_FIX_NAMES = ccc.RETRY_TO_FIX_NAMES;
		::PREFER_THIRDPERSON = ccc.PREFER_THIRDPERSON;
		KART_GROUNDMELT_TRY_FIX = ccc.KART_GROUNDMELT_TRY_FIX;
		FINALE_ACTIVATION_SCORE = ccc.FINALE_ACTIVATION_SCORE;
		FINALE_SKIP_TO_BOSS = ccc.FINALE_SKIP_TO_BOSS;
		BOOM_RACE = ccc.BOOM_RACE;
		BOOM_BATTLE = ccc.BOOM_BATTLE;
		BOOM_STARROYALE = ccc.BOOM_STARROYALE;
		BOOM_FZERO = ccc.BOOM_FZERO;
		BOOM_FINALE = ccc.BOOM_FINALE;
		BOOM_COMMAND_COOLDOWN = ccc.BOOM_COMMAND_COOLDOWN;
		ENABLE_KART_JUMP = ccc.ENABLE_KART_JUMP;
		KART_BHOP_PUNISH_LIMIT = ccc.KART_BHOP_PUNISH_LIMIT;
		KART_BHOP_PUNISH_COOLDOWN = ccc.KART_BHOP_PUNISH_COOLDOWN;
		KART_BHOP_PUNISH_SLOWAMOUNT = ccc.KART_BHOP_PUNISH_SLOWAMOUNT;
		KART_BHOP_PUNISH_SLOWTIME = ccc.KART_BHOP_PUNISH_SLOWTIME;
		KART_JUMP_COOLDOWN = ccc.KART_JUMP_COOLDOWN;
		KART_FALLDOWN_TP_TO_SPAWN = ccc.KART_FALLDOWN_TP_TO_SPAWN;
		PUNISH_INACTIVITY = ccc.PUNISH_INACTIVITY;
		GENERAL_EXPLOSION_DAMAGE = ccc.GENERAL_EXPLOSION_DAMAGE;
		GENERAL_EXPLOSION_RADIUS = ccc.GENERAL_EXPLOSION_RADIUS;
		FINALE_EXPLOSION_DAMAGE	= ccc.FINALE_EXPLOSION_DAMAGE;
		FINALE_EXPLOSION_RADIUS = ccc.FINALE_EXPLOSION_RADIUS;
		ALLOW_DAMAGE_IN_KART = ccc.ALLOW_DAMAGE_IN_KART;
		FZERO_BOOST_HP_DRAIN = ccc.FZERO_BOOST_HP_DRAIN;
		FZERO_BOOST_COOLDOWN = ccc.FZERO_BOOST_COOLDOWN;
		KART_FALLDOWN_TP_TO_LASTCP = ccc.KART_FALLDOWN_TP_TO_LASTCP;
		KART_ALLOW_LMB_BEEP = ccc.KART_ALLOW_LMB_BEEP;
		HIDE_HUD_DURING_STAGEINTRO = ccc.HIDE_HUD_DURING_STAGEINTRO;
		KART_SPEED_MODIFIER = ccc.KART_SPEED_MODIFIER;
		ZOMBIE_ITEM_COOLDOWN = ccc.ZOMBIE_ITEM_COOLDOWN;
		CLEAN_WEAPONS = ccc.CLEAN_DROPPED_WEAPONS;
		FINALE_MAX_TRIES_UNTIL_SKIP = ccc.FINALE_MAX_TRIES_UNTIL_SKIP;
		FINALE_SKIP_IF_REACHED_AND_FAILED_LASERS = ccc.FINALE_SKIP_IF_REACHED_AND_FAILED_LASERS;
		PUNISH_ITEMCAMPING = ccc.PUNISH_ITEMCAMPING;
		PUNISH_ITEMCAMPING_RANGE = ccc.PUNISH_ITEMCAMPING_RANGE;
		PUNISH_ITEMCAMPING_COUNT = ccc.PUNISH_ITEMCAMPING_COUNT;
		SCORE_KILLED_OMAR = ccc.SCORE_KILLED_OMAR;
		SCORE_FINISHED_MAP = ccc.SCORE_FINISHED_MAP;
		FINALE_SKIP_TO_BOSS_IF_REACHED = ccc.FINALE_SKIP_TO_BOSS_IF_REACHED;
		FINALE_MAX_TRIES_UNTIL_SKIP_TO_BOSS = ccc.FINALE_MAX_TRIES_UNTIL_SKIP_TO_BOSS;
		FINALE_LASER_TIMER_MIN = ccc.FINALE_LASER_TIMER_MIN;
		FINALE_LASER_TIMER_MAX = ccc.FINALE_LASER_TIMER_MAX;
		FINALE_JUMPLASER_TIMER_MIN = ccc.FINALE_JUMPLASER_TIMER_MIN;
		FINALE_JUMPLASER_TIMER_MAX = ccc.FINALE_JUMPLASER_TIMER_MAX;
		S7_SUDDEN_DEATH_RATE = ccc.S7_SUDDEN_DEATH_RATE;
		S7_SUDDEN_DEATH_START = ccc.S7_SUDDEN_DEATH_START;
		S7_SUDDEN_DEATH_ARTILLERYSTART = ccc.S7_SUDDEN_DEATH_ARTILLERYSTART;	
		ITEM_TIER_FIRST = ccc.ITEM_TIER_FIRST;
		ITEM_TIER_LAST = ccc.ITEM_TIER_LAST;
		RACEPLACEMENT_UPDATE_RATE = ccc.RACEPLACEMENT_UPDATE_RATE;
		ITEMCHANCE_TIER_ENABLE = ccc.ITEMCHANCE_TIER_ENABLE;
		STARTBOOST_TIMEWINDOW = ccc.STARTBOOST_TIMEWINDOW;
		DISABLE_GHOSTMODE = ccc.DISABLE_GHOSTMODE;
		FINALE_ONLY_ALLOW_CT_WIN = ccc.FINALE_ONLY_ALLOW_CT_WIN;
		DISALLOW_PVP_DAMAGE	= ccc.DISALLOW_PVP_DAMAGE;
		KART_AUTO_CHECKPOINT_ENABLED = ccc.KART_AUTO_CHECKPOINT_ENABLED;
		KART_AUTO_CHECKPOINT_RATE = ccc.KART_AUTO_CHECKPOINT_RATE;
		FZERO_DISABLE_WALL_DAMAGE = ccc.FZERO_DISABLE_WALL_DAMAGE;
		WEAPON_RESTRICT_MODE = ccc.WEAPON_RESTRICT_MODE;
		WEAPON_RESTRICT_MODE_FINALE = ccc.WEAPON_RESTRICT_MODE_FINALE;
		STARHUNTER_KONI_VOICE = ccc.STARHUNTER_KONI_VOICE;
		STARHUNTER_START_WAIT_TIME = ccc.STARHUNTER_START_WAIT_TIME;
		STARHUNTER_SPEED_MODIFIER = ccc.STARHUNTER_SPEED_MODIFIER;
		STARHUNTER_VOTES_NEEDED = ccc.STARHUNTER_VOTES_NEEDED;
		STARHUNTER_SCORE_BIAS = ccc.STARHUNTER_SCORE_BIAS;
		::FINALE_BOSS_INCLUDE_T_IN_FIGHT = ccc.FINALE_BOSS_INCLUDE_T_IN_FIGHT;
		::FINALE_DISALLOW_ITEMS_AT_LASERS = ccc.FINALE_DISALLOW_ITEMS_AT_LASERS;
		::KARTDESTROYED_SMOKE_ENABLED = ccc.KARTDESTROYED_SMOKE_ENABLED;
		::KARTDESTROYED_SMOKE_CHANCE = ccc.KARTDESTROYED_SMOKE_CHANCE;
		::KARTDESTROYED_SMOKE_CLEANTIME = ccc.KARTDESTROYED_SMOKE_CLEANTIME;
		::ITEMCHANCE_TIER_1 = ccc.ITEMCHANCE_TIER_1;
		::ITEMCHANCE_TIER_2 = ccc.ITEMCHANCE_TIER_2;
		::ITEMCHANCE_TIER_3 = ccc.ITEMCHANCE_TIER_3;
		::ITEMCHANCE_TIER_BATTLE = ccc.ITEMCHANCE_TIER_BATTLE;
		::FINALE_BOSS_ARTILLERY_AMOUNT = ccc.FINALE_BOSS_ARTILLERY_AMOUNT;
	}
}

function FinaleEndReachedNow()
{
	if(FINALE_SKIP_IF_REACHED_AND_FAILED_LASERS)
	{
		finalewon = true;
		finalewinreason = 2;
	}
}

function FinaleWon()
{
	finalewon = true;
	finalewinreason = 0;
	EntFireByHandle(self,"RunScriptCode"," KillAllPlayers(); ",10.00,null,null);
	local h=null;while(null!=(h=Entities.FindInSphere(h,Vector(-14592,1344,-9280),1200)))//1024 rad, 1200 to be safe
	{
		if(h.GetClassname()=="player"&&h.GetHealth()>0)
		{
			local c = GetPlayerClassByHandle(h);
			if(c==null)continue;
			c.score += SCORE_FINISHED_MAP;
			if(c.handle!=null&&c.handle.IsValid()&&c.handle.GetHealth()>0)
				EntFire("fade_repair","Fade","",0.00,c.handle);
		}
	}
}
function KilledOmar()
{
	local c = GetPlayerClassByHandle(activator);
	if(c==null)return;
	c.score += SCORE_KILLED_OMAR;
	if(c.handle!=null&&c.handle.IsValid()&&c.handle.GetHealth()>0)
		EntFire("fade_repair","Fade","",0.00,c.handle);
}
judgezitemtime <- 0.00;
function JudgePlayer()
{
	if(activator==null||!activator.IsValid()||activator.GetHealth()<=0)return;
	local c = GetPlayerClassByHandle(activator);
	if(c==null)return;
	if(c.judged)return;
	c.judged = true;
	if(activator.GetTeam()==2)//T
	{
		if(c.scoreplacement>3)
		{
			if(c.score<0){EntFire("speedmodXXX","ModifySpeed","0.80",0.00,activator);}
			activator.SetVelocity(Vector(RandomInt(-200,200),RandomInt(-200,200),0));
			return;
		}
		else if(c.scoreplacement==3)
		{
			EntFire("s_zitem","AddOutput","origin -12288 15424 -10080",judgezitemtime+0.00,null);
			EntFire("s_zitem","ForceSpawn","",judgezitemtime+0.02,null);
			EntFireByHandle(activator,"AddOutput","origin -12288 15424 -10080",0.04,null,null);
			EntFireByHandle(activator,"AddOutput","movetype 0",judgezitemtime+0.00,null,null);
			EntFireByHandle(activator,"AddOutput","movetype 2",judgezitemtime+0.20,null,null);
			judgezitemtime += 0.10;
		}
		else if(c.scoreplacement==2)
		{
			EntFire("s_zitem","AddOutput","origin -12448 15424 -10080",judgezitemtime+0.00,null);
			EntFire("s_zitem","ForceSpawn","",judgezitemtime+0.02,null);
			EntFireByHandle(activator,"AddOutput","origin -12448 15424 -10080",0.04,null,null);
			EntFireByHandle(activator,"AddOutput","movetype 0",judgezitemtime+0.00,null,null);
			EntFireByHandle(activator,"AddOutput","movetype 2",judgezitemtime+0.20,null,null);
			judgezitemtime += 0.10;
		}
		else if(c.scoreplacement==1)
		{
			EntFire("s_zitem","AddOutput","origin -12128 15424 -10080",judgezitemtime+0.00,null);
			EntFire("s_zitem","ForceSpawn","",judgezitemtime+0.02,null);
			EntFireByHandle(activator,"AddOutput","origin -12128 15424 -10080",0.04,null,null);
			EntFireByHandle(activator,"AddOutput","movetype 0",judgezitemtime+0.00,null,null);
			EntFireByHandle(activator,"AddOutput","movetype 2",judgezitemtime+0.20,null,null);
			judgezitemtime += 0.10;
		}
		activator.SetVelocity(Vector(0,0,0));
	}
	if(activator.GetTeam()==3)//CT
	{
		if(c.scoreplacement==1)
		{
			EntFireByHandle(activator,"AddOutput","origin -3520 -9920 -12992",0.00,null,null);
			EntFire("speedmodXXX","ModifySpeed","1.50",0.00,activator);
			EntFireByHandle(activator,"AddOutput","health 300",0.00,null,null);
			EntFireByHandle(self,"RunScriptCode"," SpriteTrail(20,1.0,255,255,0); ",0.02,activator,activator);
			activator.SetVelocity(Vector(0,0,0));
			EntFire("m_vip_model_5","FireUser1","",0.00,activator);//chad thundercock
		}
		else if(c.scoreplacement==2)
		{
			EntFireByHandle(activator,"AddOutput","origin -3520 -10176 -13088",0.00,null,null);
			EntFire("speedmodXXX","ModifySpeed","1.20",0.00,activator);
			EntFireByHandle(activator,"AddOutput","health 200",0.00,null,null);
			EntFireByHandle(self,"RunScriptCode"," SpriteTrail(15,0.5,0,100,200); ",0.02,activator,activator);
			activator.SetVelocity(Vector(0,0,0));
			EntFire("m_vip_model_3","FireUser1","",0.00,activator);//jar jar binks
		}
		else if(c.scoreplacement==3)
		{
			EntFireByHandle(activator,"AddOutput","origin -3520 -10432 -13184",0.00,null,null);
			EntFire("speedmodXXX","ModifySpeed","1.20",0.00,activator);
			EntFireByHandle(activator,"AddOutput","health 150",0.00,null,null);
			EntFireByHandle(self,"RunScriptCode"," SpriteTrail(15,0.5,200,50,50); ",0.02,activator,activator);
			activator.SetVelocity(Vector(0,0,0));
			EntFire("m_vip_model_4","FireUser1","",0.00,activator);//mr muscle
		}
		else if(c.scoreplacement==4||c.scoreplacement==5)
		{
			EntFireByHandle(activator,"AddOutput","origin -3520 -10688 -13280",0.00,null,null);
			EntFire("speedmodXXX","ModifySpeed","1.10",0.00,activator);
			EntFireByHandle(activator,"AddOutput","health 150",0.00,null,null);
			EntFireByHandle(self,"RunScriptCode"," SpriteTrail(10,0.25,100,100,100); ",0.02,activator,activator);
			activator.SetVelocity(Vector(0,RandomInt(-200,200),0));
		}
		else if(c.scoreplacement>5&&c.scoreplacement<11)
		{
			EntFireByHandle(activator,"AddOutput","origin -3520 -11040 -13344",0.00,null,null);
			activator.SetVelocity(Vector(0,RandomInt(-200,200),0));
			EntFireByHandle(activator,"AddOutput","health 150",0.00,null,null);
		}
		else if(c.scoreplacement>10&&c.scoreplacement<16)
		{
			EntFireByHandle(activator,"AddOutput","origin -3520 -11488 -13440",0.00,null,null);
			activator.SetVelocity(Vector(0,RandomInt(-200,200),0));
			EntFireByHandle(activator,"AddOutput","health 130",0.00,null,null);
		}
		else if(c.score>0)
		{
			EntFireByHandle(activator,"AddOutput","origin -3520 -12032 -13536",0.00,null,null);
			activator.SetVelocity(Vector(0,RandomInt(-200,200),0));
		}
		else
		{
			EntFire("speedmodXXX","ModifySpeed","0.80",0.00,activator);
			activator.SetVelocity(Vector(0,RandomInt(-200,200),0));
		}
	}
}
function ExitJudge()
{
	if(finale_pickedupzitems<3)
	{
		EntFire("s_zitem","AddOutput","origin 3120 11712 -15576",0.00,null);
		EntFire("s_zitem","ForceSpawn","",0.05,null);
	}
	if(finale_pickedupzitems<2)
	{
		EntFire("s_zitem","AddOutput","origin 3184 11712 -15576",0.10,null);
		EntFire("s_zitem","ForceSpawn","",0.15,null);
	}
	if(finale_pickedupzitems<1)
	{
		EntFire("s_zitem","AddOutput","origin 3248 11712 -15576",0.20,null);
		EntFire("s_zitem","ForceSpawn","",0.25,null);
	}
	NextFinaleMusicState();
	TickFinaleMusic();
	//EntFire("fmusic_judgement","FadeOut","10",0.00,null); //disabled in V2
}
finalemusicindex <- 1;
finalemusicstate <- false;
finalemusictransfer <- false;
function NextFinaleMusicState(){finalemusictransfer = true;}
function TickFinaleMusic()
{
	if(finalemusicindex==1)
	{
		EntFire("fmusic_loop","AddOutput","message music/luffaren_crazykart/fmusic_1_16-66.mp3",0.00,null);
		if(!finalemusicstate)EntFire("fmusic_1","PlaySound","",0.00,null);else EntFire("fmusic_loop","PlaySound","",0.00,null);finalemusicstate = !finalemusicstate;
		if(!finalemusictransfer)EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",16.66,null,null);
		else{EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",16.66,null,null);finalemusicstate=false;finalemusictransfer=false;finalemusicindex++;}
	}
	else if(finalemusicindex==2)
	{
		EntFire("fmusic_loop","AddOutput","message music/luffaren_crazykart/fmusic_2_5-56_last_5-27.mp3",0.00,null);
		if(!finalemusicstate)EntFire("fmusic_2","PlaySound","",0.00,null);else EntFire("fmusic_loop","PlaySound","",0.00,null);finalemusicstate = !finalemusicstate;
		if(!finalemusictransfer)EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",5.56,null,null);
		else{EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",5.27,null,null);finalemusicstate=false;finalemusictransfer=false;finalemusicindex++;}
	}
	else if(finalemusicindex==3)
	{
		EntFire("fmusic_loop","AddOutput","message music/luffaren_crazykart/fmusic_3_32-10_last_32-63.mp3",0.00,null);
		if(!finalemusicstate)EntFire("fmusic_3","PlaySound","",0.00,null);else EntFire("fmusic_loop","PlaySound","",0.00,null);finalemusicstate = !finalemusicstate;
		if(!finalemusictransfer)EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",32.10,null,null);
		else{EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",32.63,null,null);finalemusicstate=false;finalemusictransfer=false;finalemusicindex++;}
	}
	else if(finalemusicindex==4)
	{
		EntFire("fmusic_loop","AddOutput","message music/luffaren_crazykart/fmusic_4_28-72_last_28-95.mp3",0.00,null);
		if(!finalemusicstate)EntFire("fmusic_4","PlaySound","",0.00,null);else EntFire("fmusic_loop","PlaySound","",0.00,null);finalemusicstate = !finalemusicstate;
		if(!finalemusictransfer)EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",28.72,null,null);
		else{EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",28.95,null,null);finalemusicstate=false;finalemusictransfer=false;finalemusicindex++;}
	}
	else if(finalemusicindex==5)
	{
		NextFinaleMusicState();
		EntFire("fmusic_loop","AddOutput","message music/luffaren_crazykart/fmusic_5_5-57.mp3",0.00,null);
		if(!finalemusicstate)EntFire("fmusic_5","PlaySound","",0.00,null);else EntFire("fmusic_loop","PlaySound","",0.00,null);finalemusicstate = !finalemusicstate;
		if(!finalemusictransfer)EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",5.57,null,null);
		else{EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",5.57,null,null);finalemusicstate=false;finalemusictransfer=false;finalemusicindex++;}
	}
	else if(finalemusicindex==6)
	{
		EntFire("fmusic_loop","AddOutput","message music/luffaren_crazykart/fmusic_6_17-32_last_17-41.mp3",0.00,null);
		if(!finalemusicstate)EntFire("fmusic_6","PlaySound","",0.00,null);else EntFire("fmusic_loop","PlaySound","",0.00,null);finalemusicstate = !finalemusicstate;
		if(!finalemusictransfer)EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",17.32,null,null);
		else{EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",17.41,null,null);finalemusicstate=false;finalemusictransfer=false;finalemusicindex++;}
	}
	else if(finalemusicindex==7)
	{
		NextFinaleMusicState();
		EntFire("fmusic_loop","AddOutput","message music/luffaren_crazykart/fmusic_7_14-61.mp3",0.00,null);
		if(!finalemusicstate)EntFire("fmusic_7","PlaySound","",0.00,null);else EntFire("fmusic_loop","PlaySound","",0.00,null);finalemusicstate = !finalemusicstate;
		if(!finalemusictransfer)EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",14.61,null,null);
		else{EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",14.61,null,null);finalemusicstate=false;finalemusictransfer=false;finalemusicindex++;}
	}
	else if(finalemusicindex==8)
	{
		EntFire("fmusic_loop","AddOutput","message music/luffaren_crazykart/fmusic_8_15-25.mp3",0.00,null);
		if(!finalemusicstate)EntFire("fmusic_8","PlaySound","",0.00,null);else EntFire("fmusic_loop","PlaySound","",0.00,null);finalemusicstate = !finalemusicstate;
		EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",15.25,null,null);
	}
}
bosstarget <- [];
bosstarget_ticktime <- 0.50; //do not go <= 0.05 (-= 0.04 for each destroyed thingie)
bosstarget_active <- true;
function AddBossTarget()
{
	if(activator!=null&&activator.IsValid()&&activator.GetHealth()>0)
	{
		if(::FINALE_BOSS_INCLUDE_T_IN_FIGHT)
			bosstarget.push(activator);
		else if(activator.GetTeam()==3)
			bosstarget.push(activator);
	}
}
function CheckBossTarget()
{
	if(!bosstarget_active || ::FINALE_BOSS_ARTILLERY_AMOUNT<=0)return;
	EntFireByHandle(self,"RunScriptCode"," CheckBossTarget(); ",bosstarget_ticktime,null,null);
	bosstarget.clear();
	EntFire("boss_artilleryspawn_trigger","Enable","",0.00,null);
	EntFire("boss_artilleryspawn_trigger","Disable","",0.03,null);
	EntFireByHandle(self,"RunScriptCode"," CheckBossTargetPost(); ",0.05,null,null);
	if(::FINALE_BOSS_ARTILLERY_AMOUNT>=2)
		EntFireByHandle(self,"RunScriptCode"," CheckBossTargetPost(); ",0.08,null,null);//added one extra explosion for V2
}
artmaker <- null;
function SetArtilleryMaker()
{
	if(caller!=null&&caller.IsValid())
		artmaker = caller;
}
function CheckBossTargetPost()
{
	if(bosstarget.len()==0)return;
	local btt = bosstarget[RandomInt(0,bosstarget.len()-1)];
	if(btt==null||!btt.IsValid()||btt.GetHealth()<=0)return;
	local spos = btt.GetOrigin();spos.x+=(RandomInt(-400,400));spos.y+=(RandomInt(-400,400));
	if(btt.GetMoveParent()==null)spos.z+=8;
	else spos.z+=40;
	artmaker.SpawnEntityAtLocation(spos,Vector(0,0,0));
}
function GetExplosionDamage()
{
	EntFire("i_kartexplosion_explosion*","AddOutput","iMagnitude "+ex_damage.tostring(),0.02,null);
	EntFire("i_kartexplosion_explosion*","AddOutput","iRadiusOverride "+ex_radius.tostring(),0.02,null);
	//caller.__KeyValueFromInt("iMagnitude",ex_damage.tointeger());
	//caller.__KeyValueFromInt("iRadiusOverride",ex_radius.tointeger());
}
function RequestFinaleBoom(){if(BOOM_FINALE)allowboom=true;}
function RequestBombZ(){if(bombzstate)EntFireByHandle(caller,"FireUser1","",0.00,caller,caller);}
function CheckBombZ()
{
	EntFireByHandle(caller,"FireUser4","",ZOMBIE_ITEM_COOLDOWN,caller,caller);
	if(bombzstate)EntFireByHandle(caller,"FireUser2","",0.00,caller,caller);
	else EntFireByHandle(caller,"FireUser3","",0.00,caller,caller);
}

function InitThwompStomp()
{
	if(caller!=null&&caller.IsValid())
		EntFireByHandle(caller,"FireUser1","",RandomFloat(0.00,10.00),null,null);
}

//-------------------------> say !ef /idme manager runscriptcode SetDevCamera(X,5)
function SetDevCamera(index,time,ridx=null)
{
	if(activator==null||!activator.IsValid()||!CAMRECORD)return;
	EntFire("camera","ClearParent","",0.00,activator);
	EntFire("camera","AddPlayer","",0.00,activator);
	EntFireByHandle(activator,"SetHudVisibility","0",0.00,activator,activator);
	EntFireByHandle(self,"RunScriptCode"," SetDevCameraPost(); ",time,activator,activator);
	if(index==0)//parents camera to random kart with random pos/rot
	{
		local hlist = [];local h = null;while(null!=(h=Entities.FindByNameWithin(h,"i_kart_phys*",Vector(0,0,0),100000)))
		{if(h.GetHealth()>70000)hlist.push(h);}
		if(hlist.len()<=0)return;
		h = hlist[RandomInt(0,hlist.len()-1)];
		if(h==null||!h.IsValid())return;
		local spos = h.GetOrigin();
		local sang = h.GetAngles();
		local randidx = RandomInt(0,6);
		if(ridx!=null)randidx=ridx;
		if(randidx==0)
		{
			spos = h.GetOrigin()-(h.GetForwardVector()*20)+(h.GetUpVector()*15)-(h.GetLeftVector()*30);
		}
		else if(randidx==1)
		{
			spos = h.GetOrigin()+(h.GetForwardVector()*50)+(h.GetUpVector()*15)+(h.GetLeftVector()*30);
			sang.x -= 5;
			sang.y += 170;
		}
		else if(randidx==2)
		{
			spos = h.GetOrigin()+(h.GetForwardVector()*50)+(h.GetUpVector()*15)-(h.GetLeftVector()*30);
			sang.x -= 5;
			sang.y += 200;
		}
		else if(randidx==3)
		{
			spos = h.GetOrigin()-(h.GetForwardVector()*70)+(h.GetUpVector()*50);
			sang.x += 10;
		}
		else if(randidx==4)
		{
			spos = h.GetOrigin()-(h.GetForwardVector()*30)+(h.GetUpVector()*400);
			sang.x += 60;
		}
		else if(randidx==5)
		{
			spos = h.GetOrigin()+(h.GetForwardVector()*50)+(h.GetUpVector()*10);
		}
		else if(randidx==6)
		{
			spos = h.GetOrigin()+(h.GetForwardVector()*50)+(h.GetUpVector()*40);
		}
		EntFire("camera","AddOutput","origin "+spos.x+" "+spos.y+" "+spos.z,0.01,h);
		EntFire("camera","AddOutput","angles "+sang.x+" "+sang.y+" "+sang.z,0.01,h);
		EntFire("camera","SetParent","!activator",0.02,h);
	}
	else if(index==1)//stage 1 - first curve (looking towards starting line)
	{
		EntFire("camera","AddOutput","origin -2870 -14815 -14065",0.04,activator);
		EntFire("camera","AddOutput","angles 15 210 5",0.04,activator);
	}
	else if(index==2)//stage 1 - big road before the lava jump
	{
		EntFire("camera","AddOutput","origin -625 -14015 -14290",0.04,activator);
		EntFire("camera","AddOutput","angles 7 120 2",0.04,activator);
	}
	else if(index==3)//stage 1 - just outside the last tunnel
	{
		EntFire("camera","AddOutput","origin -16035 -10480 -13860",0.04,activator);
		EntFire("camera","AddOutput","angles 25 322 -2",0.04,activator);
	}
	else if(index==4)//stage 1 - long road just before finish like (looking backwards)
	{
		EntFire("camera","AddOutput","origin -9730 -15350 -14075",0.04,activator);
		EntFire("camera","AddOutput","angles 0 200 0",0.04,activator);
	}
	else if(index==5)//stage 2 - baby park overview
	{
		EntFire("camera","AddOutput","origin -9980 -13060 -13900",0.04,activator);
		EntFire("camera","AddOutput","angles 27 35 0",0.04,activator);
	}
	else if(index==6)//stage 3 - big snow ravine overview
	{
		EntFire("camera","AddOutput","origin 4440 -10700 -13870",0.04,activator);
		EntFire("camera","AddOutput","angles 20 60 2",0.04,activator);
	}
	else if(index==7)//stage 3 - snow cave (from the exit, looking backwards to the entrance)
	{
		EntFire("camera","AddOutput","origin 1235 -10130 -14150",0.04,activator);
		EntFire("camera","AddOutput","angles 10 65 -1",0.04,activator);
	}
	else if(index==8)//stage 3 - from top-overview of the snow, behind finish line looking towards cave
	{
		EntFire("camera","AddOutput","origin 1030 -15960 -13445",0.04,activator);
		EntFire("camera","AddOutput","angles 35 60 -5",0.04,activator);
	}
	else if(index==9)//stage 4 - overview of the first jump/bump areas
	{
		EntFire("camera","AddOutput","origin 14650 2510 -14685",0.04,activator);
		EntFire("camera","AddOutput","angles 14 126 5",0.04,activator);
	}
	else if(index==10)//stage 4 - mud boosters
	{
		EntFire("camera","AddOutput","origin 11580 4640 -14955",0.04,activator);
		EntFire("camera","AddOutput","angles 15 130 5",0.04,activator);
	}
	else if(index==11)//stage 4 - road, looking at 2nd thwomp from behind
	{
		EntFire("camera","AddOutput","origin 5220 8685 -15225",0.04,activator);
		EntFire("camera","AddOutput","angles 5 290 0",0.04,activator);
	}
	else if(index==12)//stage 4 - overview of the final road turn before long stretch/finish line
	{
		EntFire("camera","AddOutput","origin 1020 2775 -15000",0.04,activator);
		EntFire("camera","AddOutput","angles 3 47 0",0.04,activator);
	}
	else if(index==13)//stage 5 - from side of start bridge, over lava
	{
		EntFire("camera","AddOutput","origin -10880 -1660 -14165",0.04,activator);
		EntFire("camera","AddOutput","angles 5 240 0",0.04,activator);
	}
	else if(index==14)//stage 5 - overview of courtyard
	{
		EntFire("camera","AddOutput","origin -9885 -1045 -12755",0.04,activator);
		EntFire("camera","AddOutput","angles 35 290 0",0.04,activator);
	}
	else if(index==15)//stage 5 - upper inside area with lava and 2 thwomps
	{
		EntFire("camera","AddOutput","origin -5030 -5710 -14185",0.04,activator);
		EntFire("camera","AddOutput","angles 8 130 0",0.04,activator);
	}
	else if(index==16)//stage 5 - lower inside lava area, looking at jump
	{
		EntFire("camera","AddOutput","origin -4755 3730 -15050",0.04,activator);
		EntFire("camera","AddOutput","angles 8 305 0",0.04,activator);
	}
	else if(index==17)//stage 5 - overview of final stretch
	{
		EntFire("camera","AddOutput","origin -15950 -7190 -13810",0.04,activator);
		EntFire("camera","AddOutput","angles 25 35 0",0.04,activator);
	}
	else if(index==18)//stage 6 - just below starting line star road slope
	{
		EntFire("camera","AddOutput","origin -9060 8295 -15400",0.04,activator);
		EntFire("camera","AddOutput","angles 0 220 0",0.04,activator);
	}
	else if(index==19)//stage 6 - birdeye overview from turns just before halfpipe
	{
		EntFire("camera","AddOutput","origin -14975 12330 -14060",0.04,activator);
		EntFire("camera","AddOutput","angles 48 317 0",0.04,activator);
	}
	else if(index==20)//stage 6 - death spinner overview
	{
		EntFire("camera","AddOutput","origin -3110 9120 -15120",0.04,activator);
		EntFire("camera","AddOutput","angles 15 35 -2",0.04,activator);
	}
	else if(index==21)//stage 6 - loop zone
	{
		EntFire("camera","AddOutput","origin -3520 14195 -15030",0.04,activator);
		EntFire("camera","AddOutput","angles -12 230 0",0.04,activator);
	}
	else if(index==22)//stage 6 - final stretch (with 3 boosts)
	{
		EntFire("camera","AddOutput","origin -14260 5200 -14300",0.04,activator);
		EntFire("camera","AddOutput","angles 20 35 0",0.04,activator);
	}
	else if(index==23)//stage 7 - battle arena overview
	{
		EntFire("camera","AddOutput","origin 6815 100 -14750",0.04,activator);
		EntFire("camera","AddOutput","angles 22 220 0",0.04,activator);
	}
	else if(index==24)//stage 8 - star royale arena overview
	{
		EntFire("camera","AddOutput","origin 10470 -3295 -14885",0.04,activator);
		EntFire("camera","AddOutput","angles 25 36 0",0.04,activator);
	}
	else if(index==25)//stage 9 - start stretch of mute city (looking towards starting line)
	{
		EntFire("camera","AddOutput","origin -2540 -6060 65",0.04,activator);
		EntFire("camera","AddOutput","angles 2 155 0",0.04,activator);
	}
	else if(index==26)//stage 9 - first turns before first jump/gap, camera at jump/gap, looking backwards
	{
		EntFire("camera","AddOutput","origin 6380 -9260 400",0.04,activator);
		EntFire("camera","AddOutput","angles 12 145 0",0.04,activator);
	}
	else if(index==27)//stage 9 - best view, 2nd stretch before big climb, first part of big climb
	{
		EntFire("camera","AddOutput","origin 10580 -12395 55",0.04,activator);
		EntFire("camera","AddOutput","angles -12 -156 0",0.04,activator);
	}
	else if(index==28)//stage 9 - second best view, on top of big climb looking down
	{
		EntFire("camera","AddOutput","origin 1057 -13148 4940",0.04,activator);
		EntFire("camera","AddOutput","angles 54 22 0",0.04,activator);
	}
	else if(index==29)//stage 10 - big blue start, overview of the first splitup gap
	{
		EntFire("camera","AddOutput","origin -4332 -2770 740",0.04,activator);
		EntFire("camera","AddOutput","angles 39 46 0",0.04,activator);
	}
	else if(index==30)//stage 10 - yellow tunnel in big blue, just before big jump before big climb
	{
		EntFire("camera","AddOutput","origin 6280 9045 150",0.04,activator);
		EntFire("camera","AddOutput","angles 7 -150 0",0.04,activator);
	}
	else if(index==31)//stage 10 - overview of big jump before big climb + big climb from side
	{
		EntFire("camera","AddOutput","origin 9838 2614 -990",0.04,activator);
		EntFire("camera","AddOutput","angles -26 142 0",0.04,activator);
	}
	else if(index==32)//stage 10 - second split up after big climb (looking towards top of big climb)
	{
		EntFire("camera","AddOutput","origin -2495 3595 2788",0.04,activator);
		EntFire("camera","AddOutput","angles 12 43 0",0.04,activator);
	}
	else if(index==33)//stage 11 - fire field first halfpipe, looking back towards the starting line
	{
		EntFire("camera","AddOutput","origin -3580 11298 54",0.04,activator);
		EntFire("camera","AddOutput","angles -2 150 0",0.04,activator);
	}
	else if(index==34)//stage 11 - fire field first tunnel
	{
		EntFire("camera","AddOutput","origin 9448 11465 -210",0.04,activator);
		EntFire("camera","AddOutput","angles 20 -153 0",0.04,activator);
	}
	else if(index==35)//stage 11 - fire field end of the final long thin stretch, looking backwards
	{
		EntFire("camera","AddOutput","origin -6697 15655 160",0.04,activator);
		EntFire("camera","AddOutput","angles 5 -25 0",0.04,activator);
	}
	else if(index==36)//finale - boss overview from bottom
	{
		EntFire("camera","AddOutput","origin 5160 14112 -14717",0.04,activator);
		EntFire("camera","AddOutput","angles -9 -38 0",0.04,activator);
	}
	else if(index==37)//finale - boss overview from top
	{
		EntFire("camera","AddOutput","origin 13848 10965 -10260",0.04,activator);
		EntFire("camera","AddOutput","angles 40 140 0",0.04,activator);
	}
}
function SetDevCameraPost()
{
	if(activator==null||!activator.IsValid())return;
	EntFire("camera","RemovePlayer","",0.00,activator);
	EntFire("camera","ClearParent","",0.00,activator);
	EntFireByHandle(activator,"SetHudVisibility","1",0.00,activator,activator);
}

function Start()
{
	//EntFire("external_config","Trigger","",0.00,null);	//V1 (V2 calls this BEFORE Start() to run changes right away)
	collectgarbage();//B5
	s7_bomb=false;
	finalerubblespawn = true;
	allkartsbroken = false;
	inspawnhub=true;
	allowboom=false;
	::TPRECOVER.clear();
	::TPRECOVER_INDEX = 0;
	EntFire("tprecover_ent","FireUser1","",0.05,null);
	EntFire("s_item_artillery_maker","FireUser1","",0.05,null);
	EntFire("teleport_kartdestination","FireUser1","",0.05,null);
	EntFire("teleport_kartdestination_fallback","FireUser1","",0.05,null);
	EntFire("ghost_holder","FireUser1","",0.05,null);
	EntFire("s_breakeffect_rock_maker","FireUser1","",0.05,null);
	EntFire("s_itembox_maker","FireUser1","",0.05,null);
	InitSoundCC();
	starhunter_v_needed = 0;
	starhunter_v_current = 0;
	starhunter_v_ready = false;
	starhunter_votedone = false;
	finaleactive=false;
	avote = AUTOVOTE_TIME;
	RACEPLACEMENT_MAX = 0;
	PLAYERS_FINISHED = 0;
	avote_active = true;
	voteminspeed = 100;
	racewon = false;
	judgezitemtime = 0.00;
	textlapsindex = 1;
	zero = false;
	ghostarr_idx = -1;
	bosstarget.clear();
	bosstarget_ticktime = 0.50;
	bosstarget_active = true;
	finallap = false;
	max_laps = 999999;
	finalemusicindex = 1;
	finalemusictransfer = false;
	finalemusicstate = false;
	winplacing = 1;
	songname = "";
	bombzstate = false;
	ex_damage = 0;
	ex_radius = 200;
	songoffset = 0.00;
	DEATHS.clear();
	OnPlayerDeath();
	finale_pickedupzitems = 0;
	for(local i=0;i<votescore.len();i++){votescore[i]=0;}
	for(local i=0;i<votescoreb.len();i++){votescoreb[i]=0;}
	votedone = false;
	dspt = 0.00;
	EntFire("text_fzeroboost","AddOutput","message BOOST READY (left click - drains "+FZERO_BOOST_HP_DRAIN.tostring()+"hp)",0.00,null);	
	if(finaleroundcount>=FINALE_MAX_TRIES_UNTIL_SKIP)
	{
		finalewon = true;
		finalewinreason = 1;
	}
	if(finaleroundcount>=FINALE_MAX_TRIES_UNTIL_SKIP_TO_BOSS)
	{
		FINALE_SKIP_TO_BOSS = true;
	}
	if(!finalewon)EntFire("text_finalescorelimit","AddOutput","message (SCORE NEEDED TO ACTIVATE: "+FINALE_ACTIVATION_SCORE.tostring()+")",0.00,null);
	else
	{
		if(finalewinreason==1)
			EntFire("text_finalescorelimit","AddOutput","message (FAILED - LOST TOO MANY TIMES)",0.00,null);
		else if(finalewinreason==2)
			EntFire("text_finalescorelimit","AddOutput","message (FAILED - LOST AT THE VERY END)",0.00,null);
		else
			EntFire("text_finalescorelimit","AddOutput","message (COMPLETED SUCCESSFULLY)",0.00,null);
	}
	EntFire("finale_omarlaser_jump","AddOutput","angles 0 0 270",5.00,null); 
	EntFire("finale_omarlaser_timer_jump","AddOutput","LowerRandomBound "+FINALE_JUMPLASER_TIMER_MIN.tostring(),5.10,null);
	EntFire("finale_omarlaser_timer_jump","AddOutput","UpperRandomBound "+FINALE_JUMPLASER_TIMER_MAX.tostring(),5.20,null);
	EntFire("finale_omarlaser_timer","AddOutput","LowerRandomBound "+FINALE_LASER_TIMER_MIN.tostring(),5.30,null);
	EntFire("finale_omarlaser_timer","AddOutput","UpperRandomBound "+FINALE_LASER_TIMER_MAX.tostring(),5.40,null);
	EntFire("judge_star","AddOutput","modelscale 10",3.00,null);
	EntFire("server","Command","mp_solid_teammates 0",0.00,null);
	EntFire("text_laps_all","AddOutput","y 0.91",0.00,null);
	EntFire("text_laps_all","AddOutput","x 0.21",0.00,null);
	EntFire("text_startinfo","AddOutput","y 0.91",0.00,null);
	EntFire("text_startinfo","AddOutput","x 0.13",0.00,null);
	EntFire("text_laps","AddOutput","y 0.91",0.00,null);EntFire("text_laps","AddOutput","x 0.21",0.00,null);
	EntFire("text_laps_1","AddOutput","y 0.91",0.00,null);EntFire("text_laps_1","AddOutput","x 0.21",0.00,null);
	EntFire("text_laps_2","AddOutput","y 0.91",0.00,null);EntFire("text_laps_2","AddOutput","x 0.21",0.00,null);
	EntFire("text_laps_3","AddOutput","y 0.91",0.00,null);EntFire("text_laps_3","AddOutput","x 0.21",0.00,null);
	EntFire("text_laps_4","AddOutput","y 0.91",0.00,null);EntFire("text_laps_4","AddOutput","x 0.21",0.00,null);
	EntFire("text_laps_5","AddOutput","y 0.91",0.00,null);EntFire("text_laps_5","AddOutput","x 0.21",0.00,null);
	
	EntFire("text_ghoststatus","AddOutput","y 0.95",0.00,null);
	//EntFire("text_ghoststatus","AddOutput","x 0.175",0.00,null);
	EntFire("text_kartsleft","AddOutput","y 0.91",0.00,null);
	EntFire("text_kartsleft","AddOutput","x 0.01",0.00,null);
	EntFire("text_karthp_all","AddOutput","y 0.91",0.00,null);
	EntFire("text_karthp_all","AddOutput","x 0.13",0.00,null);
	EntFire("text_karthp_1","AddOutput","y 0.91",0.00,null);EntFire("text_karthp_1","AddOutput","x 0.13",0.00,null);
	EntFire("text_karthp_2","AddOutput","y 0.91",0.00,null);EntFire("text_karthp_2","AddOutput","x 0.13",0.00,null);
	EntFire("text_karthp_3","AddOutput","y 0.91",0.00,null);EntFire("text_karthp_3","AddOutput","x 0.13",0.00,null);
	EntFire("text_karthp_4","AddOutput","y 0.91",0.00,null);EntFire("text_karthp_4","AddOutput","x 0.13",0.00,null);
	EntFire("text_karthp_5","AddOutput","y 0.91",0.00,null);EntFire("text_karthp_5","AddOutput","x 0.13",0.00,null);
	EntFire("text_karthp_6","AddOutput","y 0.91",0.00,null);EntFire("text_karthp_6","AddOutput","x 0.13",0.00,null);
	EntFire("text_karthp_7","AddOutput","y 0.91",0.00,null);EntFire("text_karthp_7","AddOutput","x 0.13",0.00,null);
	EntFire("KILLME","Kill","",0.00,null);//why was this commented out in B4?
	EntFire("skybox_clear","Trigger","",0.00,null);
	EntFire("music_menu","PlaySound","",0.10,null);
	EntFire("start_camera","Disable","",0.50,null);
	EntFire("start_camera","AddOutput","origin 0 0 0",0.50,null);
	EntFire("start_camera","AddOutput","angles 0 0 0",0.50,null);
	stageteleport = null;
	stp = Vector(-260,0,12);
	stps = -1;
	stpss = 0;
	tpkartlist.clear();
	local kstime = 0.50;
	active_karts = 64;
	EntFire("server","Command","sv_allow_thirdperson 1",0.00,null);
	EntFire("server","Command","say ***Welcome to Crazy Kart***",0.00,null);
	EntFire("server","Command","say ***Map by Luffaren***",1.00,null);
	EntFire("server","Command","say ***Thanks to Enviolinador for the green shell bounce/vector logic***",2.00,null);
	if(!warmup_done)
	{
		EntFire("spawn_floorbreak_wallblocker","Toggle","",0.00,null);
		EntFire("spawn_kartcage","Break","",0.00,null);
		EntFire("server","Command","say ***WARMUP***",3.00,null);
		EntFire("starhunter_vote*","Kill","",0.00,null);
		local wtime = 40;local wtime2 = 1.00;
		for(local i=wtime;i>0;i--){EntFire("vote_auto","AddOutput","message [WARMUP ENDS IN "+wtime+" SECONDS]",wtime2,null);wtime--;wtime2+=1.00;}
		EntFireByHandle(self,"RunScriptCode"," warmup_done = true; ",20.00,null,null);
		EntFire("spawn_playerfilter_timer","Disable","",39.00,null);
		EntFire("spawn_actualkiller","Enable","",40.00,null);
		EntFireByHandle(self,"RunScriptCode"," KillAllPlayers(); ",39.90,null,null);
		if(RETRY_TO_FIX_NAMES)EntFireByHandle(self,"RunScriptCode"," RetryNameFail(); ",0.00,null,null);
		EntFire("server","Command","say ***WARMUP DONE***",40.00,null);
		EntFire("clientbroadcast","Command","Drop",38.01,null);
		EntFire("clientbroadcast","Command","Drop",38.02,null);
		EntFire("clientbroadcast","Command","Drop",38.03,null);
		return;
	}
	else iswarmup=false;
	EntFire("server","Command","mp_roundtime 60",0.00,null);
	for(local i=0;i<KART_SPAWN_AMOUNT;i++)
	{
		EntFireByHandle(self,"RunScriptCode"," SpawnKartSpawn(); ",kstime+0.05,null,null);
		kstime += 0.40;
	}
	//if(PREFER_THIRDPERSON)EntFire("i_kart_phys*","RunScriptCode"," allowthirdperson = true; ",kstime+0.50,null);//removed in V2
	if(!ENABLE_KART_JUMP)EntFire("i_kart_phys*","RunScriptCode"," allowjumpglobal = false; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," JUMPAMOUNT_LIMIT = "+KART_BHOP_PUNISH_LIMIT.tostring()+"; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," JUMPAMOUNT_COOLDOWN = "+KART_BHOP_PUNISH_COOLDOWN.tostring()+"; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," JUMPAMOUNT_SLOWDOWN = "+KART_BHOP_PUNISH_SLOWAMOUNT.tostring()+"; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," JUMPAMOUNT_SLOWTIME = "+KART_BHOP_PUNISH_SLOWTIME.tostring()+"; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," MANJUMP_COOLDOWN = "+KART_JUMP_COOLDOWN.tostring()+"; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," KART_GROUNDMELT_TRY_FIX = "+KART_GROUNDMELT_TRY_FIX.tostring()+"; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," KART_FALLDOWN_TP_TO_SPAWN = "+KART_FALLDOWN_TP_TO_SPAWN.tostring()+"; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," KART_FALLDOWN_TP_TO_LASTCP = "+KART_FALLDOWN_TP_TO_LASTCP.tostring()+"; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," KART_ALLOW_LMB_BEEP = "+KART_ALLOW_LMB_BEEP.tostring()+"; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," FZERO_BOOST_COOLDOWN = "+FZERO_BOOST_COOLDOWN.tostring()+"; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," FZERO_BOOST_HP_DRAIN = "+FZERO_BOOST_HP_DRAIN.tostring()+"; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," AddSpeed("+KART_SPEED_MODIFIER.tostring()+"); ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," disallowpvp = "+DISALLOW_PVP_DAMAGE+"; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," KART_AUTO_CHECKPOINT_RATE = "+KART_AUTO_CHECKPOINT_RATE+"; ",kstime+0.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," FZERO_DISABLE_WALL_DAMAGE = "+FZERO_DISABLE_WALL_DAMAGE+"; ",kstime+0.50,null);
	EntFireByHandle(self,"RunScriptCode"," AllKartsSpawned(); ",kstime+0.50,null,null);
	scoreboard.clear();
	local statstxt = 0.05;
	if(DISALLOW_PVP_DAMAGE)
	{
		TickPlayerDamageFilter();
		EntFire("finale_enddmg_relay_nokill","Enable","",0.00,null);
		EntFire("finale_enddmg_relay_kill","Disable","",0.00,null);
	}
	if(CAMRECORD)
	{
		EntFire("camera","AddOutput","origin 100 50 -220",0.00,null);
		EntFire("camera","AddOutput","angles 90 0 0",0.00,null);
		EntFire("camera","Enable","",0.00,null);
	}
	for(local i=0;i<PLAYERS.len();i++)
	{
		PLAYERS[i].kart = null;
		PLAYERS[i].checkpoint = 0;
		PLAYERS[i].lap = 0;
		PLAYERS[i].judged = false;
		PLAYERS[i].voteimpact = 1;
		PLAYERS[i].scoreplacement = -1;
		PLAYERS[i].raceplacement = 0;
		PLAYERS[i].raceplacedist = 0;
		PLAYERS[i].ia_C = -1;
		PLAYERS[i].ia_L = -1;	
		PLAYERS[i].itemcampcount = 0;
		PLAYERS[i].itemcamplast = Vector(-99999,-99999,-99999);
		PLAYERS[i].last_checkpoint_pos = null;
		PLAYERS[i].boom = true;
		PLAYERS[i].votedstarhunt = false;
		if(PLAYERS[i].score>=FINALE_ACTIVATION_SCORE)finalereached=true;
		if(PLAYERS[i].name==null||PLAYERS[i].name=="")
			PLAYERS[i].name="<userid-"+PLAYERS[i].userid.tostring()+">";
		scoreboard.push(PLAYERS[i]);
		if(PLAYERS[i].handle!=null&&PLAYERS[i].handle.IsValid())
		{
			if(CAMRECORD)
			{
				EntFire("camera","RemovePlayer","",0.00,PLAYERS[i].handle);
				EntFire("camera","RemovePlayer","",0.02,PLAYERS[i].handle);
			}
			starhunter_v_needed++;
			EntFireByHandle(PLAYERS[i].handle,"AddOutput","rendermode 0",0.00,null,null);
			if(PLAYERS[i].handle.GetHealth()>0)voteminspeed -= 5;
			PLAYERS[i].handle.ValidateScriptScope();
			local sc = PLAYERS[i].handle.GetScriptScope();
			sc.uid <- PLAYERS[i].userid;
			sc.ubc <- null;
			EntFire("client","Command","firstperson",0.00,PLAYERS[i].handle);
			EntFire("client","Command","cam_collision 0",0.00,PLAYERS[i].handle);
			EntFire("client","Command","cam_idealpitch 0",0.00,PLAYERS[i].handle);
			EntFire("client","Command","cam_idealyaw 0",0.00,PLAYERS[i].handle);
			EntFire("client","Command","cam_idealdistright 0",0.00,PLAYERS[i].handle);
			EntFire("client","Command","cam_idealdist 150",0.00,PLAYERS[i].handle);
			EntFire("client","Command","cam_idealdistup 0",0.00,PLAYERS[i].handle);
			if(PLAYERS[i].handle.GetHealth()>0)
			{
				local tttname = "";
				if(PLAYERS[i].name==null||PLAYERS[i].name=="")tttname="userid-"+PLAYERS[i].userid.tostring();
				else tttname = PLAYERS[i].name;
				local statstext = "message ("+PLAYERS[i].score.tostring()+" score) "+tttname;
				EntFire("text_startinfo","AddOutput",statstext,statstxt,PLAYERS[i].handle);
				EntFire("text_startinfo","Display","",statstxt+0.02,PLAYERS[i].handle);
				statstxt += 0.04;
			}
		}
	}
	starhunter_v_needed = (starhunter_v_needed*(STARHUNTER_VOTES_NEEDED/100)).tointeger();
	if(starhunter_v_needed<=1)starhunter_v_needed=1;
	local votestatusmsg = starhunter_v_current.tostring()+" / "+starhunter_v_needed.tostring()+" votes needed";
	EntFire("starhunter_vote_text","AddOutput","message "+votestatusmsg,0.00,null);
	EntFireByHandle(self,"RunScriptCode"," starhunter_v_ready = true; ",1.00,null,null);
	if(voteminspeed<0)voteminspeed=0;
	local n = scoreboard.len();
	for(local i=0;i<n;i++)
	{
		for(local j=1;j<(n-i);j++)
		{
			if(scoreboard[j-1].score < scoreboard[j].score)
			{
				local temp = scoreboard[j-1];
				scoreboard[j-1] = scoreboard[j];
				scoreboard[j] = temp;
			}
		}
	}
	local vimpact = VIMPACT_STARTSCORE;
	n = scoreboard.len()+1;if(n>16)n=16;
	for(local i=1;i<n;i++)
	{
		if(scoreboard[i-1].score>0)
		{
			if(i==1)
			{
				scoreboard[i-1].voteimpact = VIMPACT_FIRSTSCORE;
				if(scoreboard[i-1].handle!=null&&scoreboard[i-1].handle.IsValid()&&scoreboard[i-1].handle.GetHealth()>0)
				{
					if(scoreboard[i-1].userid==MASTER&&scoreboard[i-1].userid!=null)
						EntFireByHandle(self,"RunScriptCode"," SpriteTrail(25,0.5,255,255,0); ",15.00,scoreboard[i-1].handle,scoreboard[i-1].handle);
					else if(scoreboard[i-1].steamid=="STEAM_1:1:161646505")//koala - pink prostitute
						EntFireByHandle(self,"RunScriptCode"," SpriteTrail(25,0.5,255,150,180); ",15.00,scoreboard[i-1].handle,scoreboard[i-1].handle);
					else if(scoreboard[i-1].steamid=="STEAM_1:0:12218767")//sodagod - mountain dew boy
						EntFireByHandle(self,"RunScriptCode"," SpriteTrail(25,0.5,174,198,207); ",15.00,scoreboard[i-1].handle,scoreboard[i-1].handle);
					else
						EntFireByHandle(self,"RunScriptCode"," SpriteTrail(25,0.5,100,200,255); ",15.00,scoreboard[i-1].handle,scoreboard[i-1].handle);
				}
			}
			else 
			{
				scoreboard[i-1].voteimpact = vimpact;
				vimpact -= VIMPACT_DECREASE;
				if(vimpact<1)vimpact=1;
			}
			//scoreboard[i-1].scoreplacement=i;//B5
		}
		scoreboard[i-1].scoreplacement=i;//V1
		local bmsg_pos = "#";if(i<10)bmsg_pos="#0"+i;else bmsg_pos="#"+i;
		local bmsg_lastround = "placed "+scoreboard[i-1].lastround_place;if(bmsg_lastround=="placed 0")bmsg_lastround="DNF";
		local bmsg = "message "+bmsg_pos+" "+scoreboard[i-1].name + " ["+scoreboard[i-1].score.tostring()+" score] ("+bmsg_lastround+")";
		EntFire("scoreboard_place_"+i,"AddOutput",bmsg,0.00,null);
	}
	for(local i=0;i<PLAYERS.len();i++){PLAYERS[i].lastround_place=0;}
	local h=null;while(null!=(h=Entities.FindInSphere(h,self.GetOrigin(),500000)))
	{
		if(h.GetClassname()=="player"&&h.GetHealth()>0)
		{
			EntFire("client","Command","r_screenoverlay XXX_NULL_XXX",0.00,h);
		}
	}
	if(finalereached&&!finalewon)
	{
		finaleactive = true;
		finaleroundcount++;
		if(!FINALE_ONLY_ALLOW_CT_WIN)EntFire("finale_finalarea_zslow","Kill","",1.00,null);
		EntFire("server","Command","mp_items_prohibited -696969",0.00,null);
		EntFire("server","Command","mp_items_prohibited -696969",0.50,null);
		ex_damage = FINALE_EXPLOSION_DAMAGE;
		ex_radius = FINALE_EXPLOSION_RADIUS;
		EntFire("skybox_bigblue","Trigger","",0.00,null);
		EntFire("vote_auto","AddOutput","message [JUDGEMENT DAY IS HERE]",0.00,null);
		EntFire("vote_auto","AddOutput","message [JUDGEMENT DAY IS HERE]",0.20,null);
		EntFire("vote_auto","AddOutput","message [JUDGEMENT DAY IS HERE]",1.00,null);
		EntFire("vote_auto","AddOutput","message [JUDGEMENT DAY IS HERE]",2.00,null);
		if(FINALE_SKIP_TO_BOSS)
		{
			EntFire("spawn_floorbreak_wallblocker","Toggle","",0.00,null);
			EntFire("finale_vent2_toggle","Toggle","",0.00,null);
			EntFire("finale_door_4","Close","",0.00,null);
			if(!::FINALE_BOSS_INCLUDE_T_IN_FIGHT)
			{
				EntFire("spawn_tpush","Enable","",0.00,null);
				EntFire("spawn_tpush_timer","Enable","",0.00,null);
			}
			EntFire("spawn_playerfilter_timer3","Enable","",5.00,null);
			EntFire("spawn_playerfilter_timer","Disable","",5.00,null);
			EntFireByHandle(self,"RunScriptCode"," CheckBossTarget(); ",0.00,null,null);
			EntFire("spawn_playerfilter_timer","Disable","",5.00,null);
			EntFire("music_menu","Volume","0",0.00,null);
			EntFire("music_menu","Volume","0",0.10,null);
			EntFire("music_menu","Volume","0",0.20,null);
			EntFire("music_menu","Volume","0",0.30,null);
			EntFire("music_menu","Volume","0",0.40,null);
			EntFire("music_menu","Volume","0",0.50,null);
			EntFire("music_menu","Volume","0",1.00,null);
			EntFire("music_menu","Volume","0",2.00,null);
			finalemusicindex = 6;
			NextFinaleMusicState();
			TickFinaleRubble();
			EntFireByHandle(self,"RunScriptCode"," TickFinaleMusic(); ",2.50,null,null);
		}
		else
		{
			EntFire("spawn_floorbreak","Break","",5.00,null);
			EntFire("spawn_floorbreak2","Kill","",5.00,null);
			EntFire("fmusic_judgement","PlaySound","",7.00,null);
			EntFire("music_menu","Volume","0",7.00,null);
			EntFire("spawn_playerfilter_timer3","Enable","",15.00,null);
			EntFire("spawn_playerfilter_timer","Disable","",15.00,null);
			EntFire("judge_lava","Open","",13.00,null);
			EntFire("judge_topblock","Open","",12.00,null);
			EntFire("judge_zblocker","Break","",16.00,null);
			EntFire("judge_platdoor_1","Close","",25.00,null);
			EntFire("judge_platdoor_2","Close","",35.00,null);
			EntFire("judge_platdoor_3","Close","",45.00,null);
			EntFire("judge_platdoor_4","Close","",50.00,null);
			EntFire("judge_platdoor_5","Close","",55.00,null);
			EntFire("judge_platdoor_6","Close","",60.00,null);
			EntFire("judge_getout","Trigger","",70.00,null);
			EntFire("server","Command","say ***JUDGEMENT ENDS IN 10 SECONDS***",60.00,null);
			EntFire("server","Command","say ***JUDGEMENT ENDS IN 5 SECONDS***",65.00,null);
			EntFire("server","Command","say ***JUDGEMENT ENDS IN 4 SECONDS***",66.00,null);
			EntFire("server","Command","say ***JUDGEMENT ENDS IN 3 SECONDS***",67.00,null);
			EntFire("server","Command","say ***JUDGEMENT ENDS IN 2 SECONDS***",68.00,null);
			EntFire("server","Command","say ***JUDGEMENT ENDS IN 1 SECONDS***",69.00,null);
			EntFire("server","Command","say ***JUDGEMENT HAS ENDED***",70.00,null);
			EntFire("server","Command","say ***IT IS TIME TO GET WORKING***",71.00,null);
		}
		if(WEAPON_RESTRICT_MODE_FINALE == 1)RestrictWeapons(false,[41,42,59,74,26]);	//restrict all weapons except knife+bizon
		else if(WEAPON_RESTRICT_MODE_FINALE == 2)RestrictWeapons(false,[41,42,59,74,4]);//restrict all weapons except knife+glock
		else if(WEAPON_RESTRICT_MODE_FINALE == 3)RestrictWeapons(true,[41,42,59,74]);	//restrict all weapons except knife
		else SendToConsoleServer("mp_items_prohibited X");								//restrict no weapons at all	
	}
	else
	{
		EntFire("spawn_floorbreak_wallblocker","Toggle","",0.00,null);
		EntFire("vote_auto","AddOutput","message [VOTE STARTS IN 10 SECONDS]",0.00,null);
		EntFire("vote_auto","AddOutput","message [VOTE STARTS IN 9 SECONDS]",1.00,null);
		EntFire("vote_auto","AddOutput","message [VOTE STARTS IN 8 SECONDS]",2.00,null);
		EntFire("vote_auto","AddOutput","message [VOTE STARTS IN 7 SECONDS]",3.00,null);
		EntFire("vote_auto","AddOutput","message [VOTE STARTS IN 6 SECONDS]",4.00,null);
		EntFire("vote_auto","AddOutput","message [VOTE STARTS IN 5 SECONDS]",5.00,null);
		EntFire("vote_auto","AddOutput","message [VOTE STARTS IN 4 SECONDS]",6.00,null);
		EntFire("vote_auto","AddOutput","message [VOTE STARTS IN 3 SECONDS]",7.00,null);
		EntFire("vote_auto","AddOutput","message [VOTE STARTS IN 2 SECONDS]",8.00,null);
		EntFire("vote_auto","AddOutput","message [VOTE STARTS IN 1 SECONDS]",9.00,null);
		EntFire("vote_trigger*","Enable","",10.00,null);
		EntFireByHandle(self,"RunScriptCode"," TickAutoVote(); ",10.02,null,null);
		ex_damage = GENERAL_EXPLOSION_DAMAGE;
		ex_radius = GENERAL_EXPLOSION_RADIUS;
		EntFire("finale*","Kill","",0.00,null);
		if(MASTER!=null&&MASTERBATE)
		{
			local c = GetPlayerClassByUserID(MASTER);
			if(c!=null)c.voteimpact = 100;
		}
		if(WEAPON_RESTRICT_MODE == 1)RestrictWeapons(false,[41,42,59,74,26]);		//restrict all weapons except knife+bizon
		else if(WEAPON_RESTRICT_MODE == 2)RestrictWeapons(false,[41,42,59,74,4]);	//restrict all weapons except knife+glock
		else if(WEAPON_RESTRICT_MODE == 3)RestrictWeapons(true,[41,42,59,74]);		//restrict all weapons except knife
		else SendToConsoleServer("mp_items_prohibited X");							//restrict no weapons at all
	}
}

kartspawnindex <- 0;
kartspawnhandle <- null;
function SetKartSpawnHandle()
{
	kartspawnindex = 0;
	kartspawnhandle = caller;
}
function SpawnKartSpawn()
{
	kartspawnhandle.SpawnEntityAtLocation(kartspawns[kartspawnindex],Vector(0,0,0));
	kartspawnindex++;
}

//====> https://tf2b.com/itemlist.php?gid=730
function RestrictWeapons(drop,exclude)
{
	local prohibit = "";
	local GB = 0;
	for(local i=0;i<99;i++)
	{
		local excludethis = false;
		for(local j=0;j<exclude.len();j++)
		{
			if(exclude[j]==4)GB=1;
			else if(exclude[j]==26)GB=2;
			if(i == exclude[j])
			{
				excludethis = true;
				break;
			}
		}
		if(!excludethis)
		{
			if(i==0)
				prohibit = i.tostring();
			else
				prohibit = prohibit + "," + i.tostring();
		}
	}
	SendToConsoleServer("mp_items_prohibited "+prohibit);
	
	if(drop)
	{
		EntFire("clientbroadcast","Command","Drop",0.01,null);
		EntFire("clientbroadcast","Command","Drop",0.02,null);
		EntFire("clientbroadcast","Command","Drop",0.03,null);
		EntFire("clientbroadcast","Command","Drop",0.04,null);
		EntFire("clientbroadcast","Command","Drop",0.05,null);
		EntFire("clientbroadcast","Command","Drop",1.01,null);
		EntFire("clientbroadcast","Command","Drop",1.02,null);
		EntFire("clientbroadcast","Command","Drop",1.03,null);
		EntFire("clientbroadcast","Command","Drop",1.04,null);
		EntFire("clientbroadcast","Command","Drop",1.05,null);
		EntFire("weapon_bizon","Kill","",0.02,null);
		EntFire("weapon_glock","Kill","",0.02,null);
	}
	else
	{
		if(GB==1)
		{
			//EntFire("clientbroadcast","Command","Drop",0.01,null);
			EntFire("weapon_bizon","Kill","",0.02,null);
		}
		else if(GB==2)
			EntFire("weapon_glock","Kill","",0.02,null);
		EntFire("weapon_deagle","Kill","",0.02,null);
		EntFire("weapon_elite","Kill","",0.02,null);
		EntFire("weapon_fiveseven","Kill","",0.02,null);
		EntFire("weapon_tec9","Kill","",0.02,null);
		EntFire("weapon_taser","Kill","",0.02,null);
		EntFire("weapon_hkp2000","Kill","",0.02,null);
		EntFire("weapon_p250","Kill","",0.02,null);
		EntFire("weapon_usp_silencer","Kill","",0.02,null);
		EntFire("weapon_cz75a","Kill","",0.02,null);
		EntFire("weapon_revolver","Kill","",0.02,null);
	}
	EntFire("weapon_hegrenade","Kill","",0.02,null);
	EntFire("weapon_flashbang","Kill","",0.02,null);
	EntFire("weapon_molotov","Kill","",0.02,null);
	EntFire("weapon_incgrenade","Kill","",0.02,null);
	EntFire("weapon_smokegrenade","Kill","",0.02,null);
	EntFire("weapon_decoy","Kill","",0.02,null);
	EntFire("weapon_tagrenade","Kill","",0.02,null);
}

function RenderLapStatus()
{
	local tickagain = 0.02;
	for(local i=0;i<PLAYERS.len();i++)
	{
		if(PLAYERS[i].handle==null||!PLAYERS[i].handle.IsValid()||PLAYERS[i].handle.GetHealth()<=0)
			continue;
		if(PLAYERS[i].lastround_place!=0)
		{
			EntFire("text_laps_"+textlapsindex,"AddOutput","message FINISHED "+PLAYERS[i].lastround_place.tostring(),tickagain+0.00,null);
			EntFire("text_laps_"+textlapsindex,"Display","",tickagain+0.02,PLAYERS[i].handle);
		}
		else
		{
			if(ITEMCHANCE_TIER_ENABLE&&PLAYERS[i].raceplacement!=0)
			{
				local namnam = "th";
				if(PLAYERS[i].raceplacement==1)namnam = "st";
				else if(PLAYERS[i].raceplacement==2)namnam = "nd";
				else if(PLAYERS[i].raceplacement==3)namnam = "rd";
				EntFire("text_laps_"+textlapsindex,"AddOutput","message LAP "+PLAYERS[i].lap.tostring()+"/"+max_laps.tostring()+"   ("+PLAYERS[i].raceplacement.tostring()+namnam+" place)",tickagain+0.00,null);
			}
			else
				EntFire("text_laps_"+textlapsindex,"AddOutput","message LAP "+PLAYERS[i].lap.tostring()+"/"+max_laps.tostring(),tickagain+0.00,null);
			EntFire("text_laps_"+textlapsindex,"Display","",tickagain+0.02,PLAYERS[i].handle);
		}
		textlapsindex++;
		if(textlapsindex>=6)
		{
			textlapsindex = 1;
			tickagain += 0.04;
		}
	}
	EntFireByHandle(self,"RunScriptCode"," RenderLapStatus(); ",tickagain,null,null);
}

function TickAutoVote()
{
	if(!votedone)
		EntFireByHandle(self,"RunScriptCode"," TickAutoVote(); ",1.00,null,null);
	else return;
	if(avote_active)
	{
		avote--;
		EntFire("vote_auto","AddOutput","message [AUTO VOTE IN "+avote.tostring()+" SECONDS]",0.00,null);
		if(avote<=0)
		{
			EntFire("vote_auto","AddOutput","message [AUTO VOTE COMPLETE]",0.01,null);
			EntFire("vote_auto","AddOutput","color 0 255 0",0.00,null);
			VoteDone(RandomInt(1,votescore.len()));
		}
	}
}

function RetryNameFail()
{
	EntFireByHandle(self,"RunScriptCode"," RetryNameFail(); ",7.00,null,null);
	local retrime = 0.00;
	for(local i=0;i<PLAYERS.len();i++)
	{
		if(PLAYERS[i].retried)continue;
		if(PLAYERS[i].name == null || PLAYERS[i].name == "" || PLAYERS[i].name == " ")
		{
			if(PLAYERS[i].handle!=null&&PLAYERS[i].handle.IsValid())
			{
				PLAYERS[i].retried = true;
				EntFire("client","Command","retry",retrime,PLAYERS[i].handle);
				retrime += 0.10;
			}
		}
	}
}

function AllKartsSpawned()
{
	if(finaleactive)
	{
		EntFire("i_kart_phys*","RunScriptCode"," startwake = false; ",0.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," damageable = true; ",0.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," finaleactive = true; ",0.00,null);
		EntFire("i_kart_phys*","EnableMotion","",0.10,null);
		EntFire("i_kart_button*","Unlock","",20.00,null);
		if(!DISALLOW_PVP_DAMAGE)
		{
			EntFire("server","Command","say ***YOU CAN NOW HURT THE OPPOSITE TEAM IN A KARTS***",0.00,null);
			EntFire("server","Command","say ***YOU CAN NOW HURT THE OPPOSITE TEAM IN A KARTS***",0.05,null);
			EntFire("server","Command","say ***YOU CAN NOW HURT THE OPPOSITE TEAM IN A KARTS***",0.10,null);
		}
		if(FINALE_SKIP_TO_BOSS)
		{
			EntFire("spawn_finaledoor","Open","",0.00,null);
			EntFire("spawn_kartcage","Break","",0.50,null);
			EntFire("spawn_tpush","Disable","",10.10,null);
			EntFire("spawn_tpush","Disable","",12.10,null);
			EntFire("spawn_tpush_timer","Disable","",10.00,null);
		}
	}
}

function VoteField(in_out)
{
	local vs = split(caller.GetName(),"vote_trigger_")[0];
	local va = 1;
	local c = GetPlayerClassByHandle(activator);
	if(c!=null)va=c.voteimpact;
	if(va>1)//bonus people!
	{
		if(in_out)votescoreb[vs.tointeger()-1]+=(va-1);
		else votescoreb[vs.tointeger()-1]-=(va-1);
	}
	if(in_out)
	{
		votescore[vs.tointeger()-1]+=va;
		avote_active=false;
		EntFire("vote_auto","AddOutput","color 255 0 0",0.00,null);
	}
	else
	{
		votescore[vs.tointeger()-1]-=va;
		local vstotal = 0;
		for(local i=0;i<votescore.len();i++){vstotal+=votescore[i];}
		if(vstotal<=0)
		{
			avote_active=true;
			EntFire("vote_auto","AddOutput","color 255 255 255",0.00,null);
		}
	}
	//if(votescore[vs.tointeger()-1]<0)votescore[vs.tointeger()-1]=0;									//COMMENTED OUT FOR B5
	//local vmsg = "message ["+(votescore[vs.tointeger()-1]-votescoreb[vs.tointeger()-1])+" voters]";	//COMMENTED OUT FOR B5
	local vmsg = "message ["+(votescore[vs.tointeger()-1])+" voters]";									//TWEAKED FOR B5 INSTEAD^
	if(votescoreb[vs.tointeger()-1]>0)vmsg=vmsg+" ("+votescoreb[vs.tointeger()-1]+")";
	EntFire("vote_text_"+vs,"AddOutput",vmsg,0.00,null);
	EntFire("vote_mover_"+vs,"Open","",0.00,null);
	if(votescore[vs.tointeger()-1]<=0)
		EntFire("vote_mover_"+vs,"SetSpeed","0",0.00,null);
	else
		EntFire("vote_mover_"+vs,"SetSpeed",(votescore[vs.tointeger()-1]+votescoreb[vs.tointeger()-1]+voteminspeed).tostring(),0.00,null);
}

function VoteDone(deff = -1)
{
	if(!votedone)
	{	
		votedone = true;local vs = 0;
		if(deff == -1)
		{
			vs = split(caller.GetName(),"vote_mover_")[0];//player vote, read stage from "caller"
			EntFire("vote_auto","AddOutput","color 0 255 0",0.00,null);
			EntFire("vote_auto","AddOutput","color 0 255 0",0.01,null);
			EntFire("vote_auto","AddOutput","message [MANUAL VOTE COMPLETE]",0.00,null);
			EntFire("vote_auto","AddOutput","message [MANUAL VOTE COMPLETE]",0.01,null);
		}
		else vs = deff;//auto vote, read stage from "deff"
		vs = vs.tointeger();local stagename = "";local stagetype = "";
		
		if(vs==1)			{stagename="Basic ass raceway";stagetype="RACE";racestart=true;}
		else if(vs==2)		{stagename="Baby park waaah";stagetype="RACE";racestart=true;}
		else if(vs==3)		{stagename="Winter wonderland";stagetype="RACE";racestart=true;}
		else if(vs==4)		{stagename="Evil magma castle";stagetype="RACE";racestart=true;}
		else if(vs==5)		{stagename="Circle of death";stagetype="BATTLE";racestart=false;}
		else if(vs==6)		{stagename="Rodeo of stars";stagetype="STAR ROYALE";racestart=false;}
		else if(vs==7)		{stagename="Funky funway";stagetype="RACE";racestart=true;}
		else if(vs==8)		{stagename="Rad dad rainbow";stagetype="RACE";racestart=true;}
		else if(vs==9)		{stagename="Mute city";stagetype="F-ZERO RACE";racestart=true;}
		else if(vs==10)		{stagename="Big blue";stagetype="F-ZERO RACE";racestart=true;}
		else if(vs==11)		{stagename="Fire field";stagetype="F-ZERO RACE";racestart=true;}
		
		EntFire("vote_text_*","AddOutput","color 255 0 0",0.00,null);
		EntFire("vote_text_*","AddOutput","message [VOTE LOST]",0.00,null);
		EntFire("vote_text_"+vs.tostring(),"AddOutput","color 0 255 0",0.00,null);
		EntFire("vote_text_"+vs.tostring(),"AddOutput","color 0 255 0",0.01,null);
		EntFire("vote_text_"+vs.tostring(),"AddOutput","message [VOTE WINNER]",0.00,null);
		EntFire("vote_text_"+vs.tostring(),"AddOutput","message [VOTE WINNER]",0.01,null);
		EntFire("vote_trigger_*","Kill","",0.00,null);
		EntFire("server","Command","say ***STAGE PICKED - "+stagename+"***",0.00,null);
		EntFire("server","Command","say ***"+stagetype+" STARTS IN 20 SECONDS***",1.00,null);
		EntFire("server","Command","say ***GET IN YOUR KARTS***",2.00,null);
		EntFire("spawn_kartcage","Break","",2.00,null);
		EntFire("server","Command","say ***5***",16.00,null);
		EntFire("server","Command","say ***4***",17.00,null);
		EntFire("server","Command","say ***3***",18.00,null);
		EntFire("server","Command","say ***2***",19.00,null);
		EntFire("server","Command","say ***1***",20.00,null);
		EntFire("server","Command","say ***LET'S A GO***",21.00,null);
		EntFire("stage_"+vs.tostring(),"FireUser1","",21.00,null);
	}
}

function StartTeleport()
{
	//INDEX LIST:
	//0 	= //stage 1 itemboxes
	//1 	= //stage 1 rng
	//2 	= //stage 2 itemboxes
	//3 	= //stage 2 rng
	//4 	= //stage 3 itemboxes
	//5 	= //stage 3 rng
	//6 	= //stage 4 itemboxes
	//7 	= //stage 4 rng
	//8 	= //stage 4 thwomps (+ angles)
	//9 	= //stage 5 itemboxes
	//10 	= //stage 5 rng
	//11 	= //stage 5 thwomps (+ angles)
	//12 	= //stage 6 itemboxes
	//13 	= //stage 6 rng
	//14 	= //stage 8 itemboxes
	//15 	= //stage 8 thwomps (+ angles)
	//16 	= //stage 8 rng
	//SpawnTemplates(index,templatename,justpos);
	//SpawnRandomItem(index,mintime,maxtime,starchance);
	
	local specificstage = split(caller.GetName(),"music_stage_")[0];
	if(specificstage=="1")//==================> STAGE 1 - Basic ass raceway (race)
	{
		if(BOOM_RACE)allowboom=true;
		max_laps = 2;
		songoffset = 7.80;
		ghostarr_idx = 0;
		EntFire("skybox_clear","Trigger","",1.00,null);
		EntFire("sky_normal","Toggle","",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetHealth("+KART_HEALTH_RACE.tostring()+"); ",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," HEALTH="+KART_HEALTH_RACE.tostring()+"; ",1.00,null);
		EntFire("text_karthp_all","AddOutput","message HP "+KART_HEALTH_RACE.tostring()+"",1.00,null);
		if(SPAWN_ITEMBOXES)SpawnTemplates(0,"s_itembox",true);
		if(SPAWN_RNG)SpawnRandomItem(1,5.00,50.00,10.00);
		EntFireByHandle(self,"RunScriptCode"," TimeOutKill(); ",350.00,null,null);
	}
	else if(specificstage=="2")//=============> STAGE 2 - Baby park waaah (race)
	{
		if(BOOM_RACE)allowboom=true;
		max_laps = 10;
		songoffset = 8.00;
		ghostarr_idx = 1;
		EntFire("skybox_clear","Trigger","",1.00,null);
		EntFire("sky_normal","Toggle","",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetHealth("+KART_HEALTH_RACE.tostring()+"); ",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," HEALTH="+KART_HEALTH_RACE.tostring()+"; ",1.00,null);
		EntFire("text_karthp_all","AddOutput","message HP "+KART_HEALTH_RACE.tostring()+"",1.00,null);
		if(SPAWN_ITEMBOXES)SpawnTemplates(2,"s_itembox",true);
		if(SPAWN_RNG)SpawnRandomItem(3,2.00,15.00,2.00);
		EntFireByHandle(self,"RunScriptCode"," TimeOutKill(); ",350.00,null,null);
	}
	else if(specificstage=="3")//=============> STAGE 3 - Winter wonderland (race)
	{
		if(BOOM_RACE)allowboom=true;
		max_laps = 2;
		songoffset = 8.00;
		ghostarr_idx = 2;
		EntFire("skybox_gray","Trigger","",1.00,null);
		EntFire("sky_snow","Toggle","",1.00,null);
		EntFire("tem_fall_snow","ForceSpawn","",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetHealth("+KART_HEALTH_RACE.tostring()+"); ",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," HEALTH="+KART_HEALTH_RACE.tostring()+"; ",1.00,null);
		EntFire("text_karthp_all","AddOutput","message HP "+KART_HEALTH_RACE.tostring()+"",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," AddSpeed(-0.60); ",1.00,null);
		if(SPAWN_ITEMBOXES)SpawnTemplates(4,"s_itembox",true);
		if(SPAWN_RNG)SpawnRandomItem(5,5.00,50.00,10.00);
		EntFireByHandle(self,"RunScriptCode"," TimeOutKill(); ",350.00,null,null);
	}
	else if(specificstage=="7")//=============> STAGE 4 - Funky funway (race)
	{
		if(BOOM_RACE)allowboom=true;
		max_laps = 2;
		songoffset = 8.00;
		ghostarr_idx = 3;
		EntFire("skybox_clear","Trigger","",1.00,null);
		EntFire("sky_normal","Toggle","",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetHealth("+KART_HEALTH_RACE.tostring()+"); ",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," HEALTH="+KART_HEALTH_RACE.tostring()+"; ",1.00,null);
		EntFire("text_karthp_all","AddOutput","message HP "+KART_HEALTH_RACE.tostring()+"",1.00,null);
		if(SPAWN_ITEMBOXES)SpawnTemplates(6,"s_itembox",true);
		if(SPAWN_RNG)SpawnRandomItem(7,5.00,50.00,10.00);
		if(SPAWN_THWOMPS)SpawnTemplates(8,"s_thwomp",false,0.00,10.00);
		EntFireByHandle(self,"RunScriptCode"," TimeOutKill(); ",350.00,null,null);
	}
	else if(specificstage=="4")//=============> STAGE 5 - Evil magma castle (race)
	{
		if(BOOM_RACE)allowboom=true;
		max_laps = 1;
		songoffset = 8.00;
		ghostarr_idx = 4;
		EntFire("skybox_red","Trigger","",1.00,null);
		EntFire("sky_lava","Toggle","",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetHealth("+KART_HEALTH_RACE.tostring()+"); ",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," HEALTH="+KART_HEALTH_RACE.tostring()+"; ",1.00,null);
		EntFire("text_karthp_all","AddOutput","message HP "+KART_HEALTH_RACE.tostring()+"",1.00,null);
		if(SPAWN_ITEMBOXES)SpawnTemplates(9,"s_itembox",true);
		if(SPAWN_RNG)SpawnRandomItem(10,5.00,50.00,10.00);
		if(SPAWN_THWOMPS)SpawnTemplates(11,"s_thwomp",false,0.00,10.00);
		EntFireByHandle(self,"RunScriptCode"," TimeOutKill(); ",350.00,null,null);
	}
	else if(specificstage=="5")//=============> STAGE 6 - Circle of death (battle)
	{
		if(BOOM_BATTLE)allowboom=true;
		max_laps = 3;
		songoffset = 8.00;
		EntFire("skybox_clear","Trigger","",1.00,null);
		EntFire("sky_normal","Toggle","",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetHealth("+KART_HEALTH_BATTLE.tostring()+"); ",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," HEALTH="+KART_HEALTH_BATTLE.tostring()+"; ",1.00,null);
		EntFire("text_karthp_all","AddOutput","message HP "+KART_HEALTH_BATTLE.tostring()+"",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," InitItemChanceBattle(); ",1.20,null);
		EntFire("s6real_explosionspawn","Enable","",15.00,null);
		SpawnTemplates(12,"s_itembox",true);
		if(SPAWN_RNG)SpawnRandomItem(13,3.00,30.00,20.00);
		EntFireByHandle(self,"RunScriptCode"," TimeOutKill(); ",250.00,null,null);
	}
	else if(specificstage=="6")//=============> STAGE 7 - Rodeo of stars (star royale)
	{
		if(BOOM_STARROYALE)allowboom=true;
		max_laps = 3;
		songoffset = 8.00;
		s7_bomb=true;
		EntFire("skybox_clear","Trigger","",1.00,null);
		EntFire("sky_normal","Toggle","",1.00,null);
		EntFire("starbattle_kartdestroyer_timer","Enable","",20.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetHealth("+KART_HEALTH_STARROYALE.tostring()+"); ",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," HEALTH="+KART_HEALTH_STARROYALE.tostring()+"; ",1.00,null);
		EntFire("text_karthp_all","AddOutput","message HP "+KART_HEALTH_STARROYALE.tostring()+"",1.00,null);
		EntFire("s6_starspawn","FireUser1","",15.00,null);
		EntFireByHandle(self,"RunScriptCode"," TimeOutKill(); ",250.00,null,null);
	}
	else if(specificstage=="8")//=============> STAGE 8 - Rad dad rainbow (race)
	{
		if(BOOM_RACE)allowboom=true;
		max_laps = 1;
		songoffset = 8.00;
		ghostarr_idx = 5;
		EntFire("skybox_space","Trigger","",1.00,null);
		EntFire("s_rainbow_stardetails","ForceSpawn","",6.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetHealth("+KART_HEALTH_RACE.tostring()+"); ",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," HEALTH="+KART_HEALTH_RACE.tostring()+"; ",1.00,null);
		EntFire("text_karthp_all","AddOutput","message HP "+KART_HEALTH_RACE.tostring()+"",1.00,null);
		if(SPAWN_ITEMBOXES)SpawnTemplates(14,"s_itembox",true);
		if(SPAWN_THWOMPS)SpawnTemplates(15,"s_thwomp",false,0.00,10.00);
		if(SPAWN_RNG)SpawnRandomItem(16,5.00,50.00,40.00);
		EntFireByHandle(self,"RunScriptCode"," TimeOutKill(); ",350.00,null,null);
	}
	else if(specificstage=="9")//=============> STAGE 9 - Mute city (F-zero race)
	{
		if(BOOM_FZERO)allowboom=true;
		zero = true;
		max_laps = 2;
		ghostarr_idx = 6;
		EntFire("i_kart_phys*","RunScriptCode"," SetHealth("+KART_HEALTH_FZERO.tostring()+"); ",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," HEALTH="+KART_HEALTH_FZERO.tostring()+"; ",1.00,null);
		EntFire("text_karthp_all","AddOutput","message HP "+KART_HEALTH_FZERO.tostring()+"",1.00,null);
		EntFire("skybox_mutecity","Trigger","",1.00,null);
		EntFire("sky_mutecity","Toggle","",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetZero(); ",1.00,null);
		EntFireByHandle(self,"RunScriptCode"," TimeOutKill(); ",350.00,null,null);
	}
	else if(specificstage=="10")//=============> STAGE 10 - Big blue (F-zero race)
	{
		if(BOOM_FZERO)allowboom=true;
		zero = true;
		max_laps = 2;
		ghostarr_idx = 7;
		EntFire("i_kart_phys*","RunScriptCode"," SetHealth("+KART_HEALTH_FZERO.tostring()+"); ",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," HEALTH="+KART_HEALTH_FZERO.tostring()+"; ",1.00,null);
		EntFire("text_karthp_all","AddOutput","message HP "+KART_HEALTH_FZERO.tostring()+"",1.00,null);
		EntFire("skybox_bigblue","Trigger","",1.00,null);
		EntFire("sky_bigblue","Toggle","",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetZero(); ",1.00,null);
		EntFireByHandle(self,"RunScriptCode"," TimeOutKill(); ",350.00,null,null);
	}
	else if(specificstage=="11")//=============> STAGE 11 - Fire field (F-zero race)
	{
		if(BOOM_FZERO)allowboom=true;
		zero = true;
		max_laps = 2;
		ghostarr_idx = 8;
		EntFire("i_kart_phys*","RunScriptCode"," SetHealth("+KART_HEALTH_FZERO.tostring()+"); ",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," HEALTH="+KART_HEALTH_FZERO.tostring()+"; ",1.00,null);
		EntFire("text_karthp_all","AddOutput","message HP "+KART_HEALTH_FZERO.tostring()+"",1.00,null);
		EntFire("skybox_red","Trigger","",1.00,null);
		EntFire("sky_firefield","Toggle","",1.00,null);
		EntFire("tem_fall_rain","ForceSpawn","",1.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetZero(); ",1.00,null);
		EntFireByHandle(self,"RunScriptCode"," TimeOutKill(); ",350.00,null,null);
	}
	if(KILL_NON_KART_PLAYERS)
	{
		EntFire("i_kart_phys*","RunScriptCode"," killnonkart = true; ",1.00,null);
		EntFire("spawn_actualkiller","Enable","",8.00,null);
		EntFire("spawn_playerfilter_timer2","Enable","",8.00,null);
		EntFire("spawn_playerfilter_trigger","Disable","",7.50,null);
		EntFire("spawn_killer","Disable","",7.50,null);
	}
	EntFire("text_laps_all","AddOutput","message LAP 0/"+max_laps.tostring(),0.00,null);
	songname = "music_stage_"+specificstage;
	EntFire("i_kart_startseater*","Disable","",0.00,null);
	EntFire("i_kart_startseater*","FireUser2","",0.50,null);
	stp = caller.GetOrigin();
	StartTeleportGenerate();//B4
	local stpo = "origin "+stp.x+" "+stp.y+" "+stp.z;
	tph_kartdest.SetOrigin(stp);
	tph_kartfall.SetOrigin(stp);
	EntFire("teleport_kartspawn","Enable","",0.00,null);
	EntFire("starhunter_vote*","Kill","",0.00,null);
	EntFire("fade_start_to","Fade","",0.00,null);
	EntFire("score*","Kill","",1.00,null);
	EntFire("vote*","Kill","",1.00,null);
	EntFire("spawn_playerfilter_timer","Kill","",1.00,null);
	EntFire("spawn_playerfilter_trigger","Kill","",1.00,null);
	EntFire("fade_start_from","Fade","",6.50,null);
	EntFire("music_menu","FadeOut","5",0.00,null);
	EntFire("sound_start_letsago","PlaySound","",0.00,null);
	EntFire("teleport_kartspawn_mover","Open","",0.50,null);
	local stp2 = caller.GetOrigin();stp2.x += 178;stp2.z+=252;
	stpo = "origin "+stp2.x+" "+stp2.y+" "+stp2.z;
	EntFire("start_stopsign","AddOutput",stpo,0.00,null);
	if(racestart)
	{
		local stp3 = caller.GetOrigin();stp3.x -= 768;
		stpo = "origin "+stp3.x+" "+stp3.y+" "+stp3.z;
		EntFire("s_start_camera","AddOutput",stpo,0.00,null);
		EntFire("s_start_camera","ForceSpawn",stpo,0.05,null);
		EntFire("start_camera","AddOutput",stpo,0.00,null);
		EntFire("start_camera","ClearParent","",5.00,null);
		EntFire("start_camera","AddOutput",stpo,5.50,null);
		EntFire("start_camera","AddOutput",stpo,5.55,null);
		EntFire("start_camera","SetParent","start_camera_mover",6.00,null);
		EntFire("start_camera","Enable","",6.50,null);
		if(HIDE_HUD_DURING_STAGEINTRO)EntFire("i_kart_phys*","RunScriptCode"," SetHudVisibility(false); ",6.30,null);
		EntFire("start_camera_mover","Open","",6.50,null);
		EntFire("start_camera_mover2","Open","",6.50,null);
		EntFireByHandle(self,"RunScriptCode"," StartRace(); ",6.50,null,null);
	}
	else EntFireByHandle(self,"RunScriptCode"," StartBattle(); ",6.50,null,null);
	if(!KILL_NON_KART_PLAYERS)EntFire("spawn_killer","Enable","",8.00,null);
	EntFireByHandle(self,"RunScriptCode"," inspawnhub = false; ",20.00,null,null);
}

tph_kartdest <- null;
tph_kartfall <- null;
function SetTphKart(idx)
{
	if(idx==1)tph_kartdest=caller;
	else if(idx==2)tph_kartfall=caller;
}

function StartTeleportTick()//this gets called when each kart touches the TP trigger
{
	if(activator.GetHealth()>200000&&MASTERFUCK)
	{EntFireByHandle(activator,"RunScriptCode"," AddSpeed(0.30); ",0.00,null,null);EntFireByHandle(activator,"RunScriptCode"," AddSpeed(-0.30); ",12.00,null,null);}
	if(tpkartlist.len()<=0)return;
	local ssrand = (RandomInt(0,tpkartlist.len()-1)).tointeger();
	local ccc = tpkartlist[ssrand];
	tph_kartdest.SetOrigin(ccc);
	tph_kartfall.SetOrigin(ccc);
	tpkartlist.remove(ssrand);

	/*//////////OLD CODE FROM B3
	stpss++;
	if(stpss<=64)
	{
		if(stps == -1){stp.x-=72;stp.y+=224;stps++;}
		else if(stps>=8){stps=0;stp.x-=72;stp.y+=448;}
		else{stp.y-=56;stps++;}
		tph_kartdest.SetOrigin(stp);
		tph_kartfall.SetOrigin(stp);
	}
	================================*/
}
//NEW FUNCTION IN B4:
function StartTeleportGenerate()//this gets called once after figuring out the caller position (generates/adds kart positioning)
{
	local sss = stp;
	tpkartlist.push(Vector(sss.x,sss.y,sss.z));
	stpss=0;
	for(local i=0;i<65;i++)
	{
		stpss++;
		if(stpss<64)
		{
			if(stps == -1){sss.x-=72;sss.y+=224;stps++;}
			else if(stps>=8){stps=0;sss.x-=72;sss.y+=448;}
			else{sss.y-=56;stps++;}
			tpkartlist.push(Vector(sss.x,sss.y,sss.z));
		}
	}
	local ssrand = (RandomInt(0,tpkartlist.len()-1)).tointeger();
	local ccc = tpkartlist[ssrand];
	tph_kartdest.SetOrigin(ccc);
	tph_kartfall.SetOrigin(ccc);
	tpkartlist.remove(ssrand);
}

function UseItem(index)
{
	if(index<0||index>21)return;
	local c = GetPlayerClassByHandle(activator);
	if(c!=null&&c.kart!=null)EntFireByHandle(c.kart,"RunScriptCode"," UseItem("+index.tostring()+"); ",0.00,null,null);
}

function AddSpeed(amount)
{
	local c = GetPlayerClassByHandle(activator);
	if(c!=null&&c.kart!=null)EntFireByHandle(c.kart,"RunScriptCode"," AddSpeed("+amount.tostring()+"); ",0.00,null,null);
}

function StartRace()
{
	if(zero)
	{
		EntFire("start_camera","ClearParent","",2.55,null);
		EntFire("start_camera","Disable","",2.50,null);
		EntFire("start_camera","Disable","",0.00,null);
		EntFire("start_camera","Enable","",0.05,null);
		EntFire("start_camera","AddOutput","origin 0 0 0",3.00,null);
		EntFire("start_camera","AddOutput","angles 0 0 0",3.00,null);
		if(HIDE_HUD_DURING_STAGEINTRO)
		{
			EntFire("i_kart_phys*","RunScriptCode"," SetHudVisibility(false); ",0.00,null);
			EntFire("i_kart_phys*","RunScriptCode"," SetHudVisibility(true); ",2.50,null);
		}
		EntFire("i_kart_phys*","RunScriptCode"," SetThirdPerson(); ",0.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetPrefPerson(); ",2.50,null);
		EntFire("fade_start_to_fast","Fade","",2.20,null);
		EntFire("fade_start_from_fast","Fade","",2.50,null);
		EntFire("sound_startbeep_1","AddOutput","message *luffaren_crazykart/ckz_321_go.mp3",2.00,null);
		EntFire("sound_startbeep_1","PlaySound","",3.00,null);
		EntFire("start_stopsign_c_r","ShowSprite","",5.00,null);
		EntFire("start_stopsign_c_r","HideSprite","",6.00,null);
		EntFire("start_stopsign_c_y","ShowSprite","",6.00,null);
		EntFire("start_stopsign_c_y","HideSprite","",7.00,null);
		EntFire("start_stopsign_c_g","ShowSprite","",7.00,null);
		EntFire("start_stopsign_c_g","HideSprite","",15.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," startwake = false; ",5.00,null);
		EntFire("i_kart_phys*","EnableMotion","",7.00,null);
		if(STARTBOOST_TIMEWINDOW>0.00)
		{
			EntFire("i_kart_phys*","RunScriptCode"," startboostwindow = true; ",7.00,null);
			EntFire("i_kart_phys*","RunScriptCode"," startboostwindow = false; ",7.00+STARTBOOST_TIMEWINDOW,null);
		}
		if(KART_AUTO_CHECKPOINT_ENABLED)EntFire("i_kart_phys*","RunScriptCode"," TickAutoCheckPoint(); ",7.50,null);
		if(ITEMCHANCE_TIER_ENABLE)EntFireByHandle(self,"RunScriptCode"," UpdateRacePlacement(); ",7.00,null,null);
		if(ghostarr_idx != -1)EntFireByHandle(self,"RunScriptCode"," StartGhost(); ",7.00,null,null);
		EntFire("text_laps_all","Display","",7.00,null);
		EntFireByHandle(self,"RunScriptCode"," RenderLapStatus(); ",7.00,null,null);
		//EntFireByHandle(self,"RunScriptCode"," CheckInactivity(); ",7.00+INACTIVITY_SLAY_TIME,null,null); //disabled in V2
		EntFire("i_kart_button*","FireUser2","",7.00,null);
		EntFire(songname,"PlaySound","",songoffset,null);
		EntFire("i_kart_phys*","RunScriptCode"," TickDriveControl(true); ",7.01,null);
		EntFire("i_kart_phys*","RunScriptCode"," TickDriveControl(false); ",7.02,null);
		max_karts = active_karts;
		EntFire("text_kartsleft","AddOutput","message KARTS "+active_karts+"/"+max_karts,6.95,null);
		EntFire("text_kartsleft","Display","",7.00,null);
		EntFire("text_karthp_all","Display","",7.00,null);
		EntFireByHandle(self,"RunScriptCode"," HideKartHealthForNonKarters(); ",7.00,null,null);
	}
	else
	{
		EntFire("start_camera","ClearParent","",5.55,null);
		EntFire("start_camera","Disable","",5.50,null);
		if(HIDE_HUD_DURING_STAGEINTRO)EntFire("i_kart_phys*","RunScriptCode"," SetHudVisibility(true); ",5.50,null);
		EntFire("start_camera","AddOutput","origin 0 0 0",6.00,null);
		EntFire("start_camera","AddOutput","angles 0 0 0",6.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetFirstPerson(); ",0.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," SetPrefPerson(); ",5.50,null);
		EntFire("fade_start_to_fast","Fade","",5.20,null);
		EntFire("fade_start_from_fast","Fade","",5.50,null);
		EntFire("sound_startmusic","PlaySound","",0.00,null);
		EntFire("sound_startbeep_1","PlaySound","",6.00,null);
		EntFire("start_stopsign_c_r","ShowSprite","",6.00,null);
		EntFire("sound_startbeep_1x","PlaySound","",7.00,null);
		EntFire("start_stopsign_c_r","HideSprite","",7.00,null);
		EntFire("start_stopsign_c_y","ShowSprite","",7.00,null);
		EntFire("sound_startbeep_2","PlaySound","",8.00,null);
		EntFire("start_stopsign_c_y","HideSprite","",8.00,null);
		EntFire("start_stopsign_c_g","ShowSprite","",8.00,null);
		EntFire("start_stopsign_c_g","HideSprite","",15.00,null);
		EntFire("i_kart_phys*","RunScriptCode"," startwake = false; ",6.00,null);
		EntFire("i_kart_phys*","EnableMotion","",8.00,null);
		if(STARTBOOST_TIMEWINDOW>0.00)
		{
			EntFire("i_kart_phys*","RunScriptCode"," startboostwindow = true; ",8.00,null);
			EntFire("i_kart_phys*","RunScriptCode"," startboostwindow = false; ",8.00+STARTBOOST_TIMEWINDOW,null);
		}
		if(KART_AUTO_CHECKPOINT_ENABLED)EntFire("i_kart_phys*","RunScriptCode"," TickAutoCheckPoint(); ",8.50,null);
		if(ITEMCHANCE_TIER_ENABLE)EntFireByHandle(self,"RunScriptCode"," UpdateRacePlacement(); ",8.00,null,null);
		if(ghostarr_idx != -1)EntFireByHandle(self,"RunScriptCode"," StartGhost(); ",8.00,null,null);
		EntFire("text_laps_all","Display","",8.00,null);
		EntFireByHandle(self,"RunScriptCode"," RenderLapStatus(); ",8.00,null,null);
		EntFireByHandle(self,"RunScriptCode"," CheckInactivity(); ",8.00+INACTIVITY_SLAY_TIME,null,null);
		EntFire("i_kart_button*","FireUser2","",8.00,null);
		EntFire(songname,"PlaySound","",songoffset,null);
		EntFire("i_kart_phys*","RunScriptCode"," TickDriveControl(true); ",8.01,null);
		EntFire("i_kart_phys*","RunScriptCode"," TickDriveControl(false); ",8.02,null);
		max_karts = active_karts;
		EntFire("text_kartsleft","AddOutput","message KARTS "+active_karts+"/"+max_karts,7.95,null);
		EntFire("text_kartsleft","Display","",8.00,null);
		EntFire("text_karthp_all","Display","",8.00,null);
		EntFireByHandle(self,"RunScriptCode"," HideKartHealthForNonKarters(); ",8.00,null,null);
		if(starhunter_votedone)
			EntFireByHandle(self,"RunScriptCode"," StarHunterStartCountdown(); ",8.02,null,null);
	}
	if(ALLOW_DAMAGE_IN_KART)
	{
		EntFire("server","Command","say ***YOU CAN NOW DAMAGE/TAKE DAMAGE WHILE IN A KART***",20.00,null);
		EntFire("server","Command","say ***YOU CAN NOW DAMAGE/TAKE DAMAGE WHILE IN A KART***",20.01,null);
		EntFire("server","Command","say ***YOU CAN NOW DAMAGE/TAKE DAMAGE WHILE IN A KART***",20.02,null);
		EntFire("i_kart_phys*","RunScriptCode"," damageable = true; ",20.00,null);
	}
}

function StartBattle()
{
	EntFire("i_kart_phys*","RunScriptCode"," SetPrefPerson(); ",0.00,null);
	EntFire("sound_startmusic_battle","PlaySound","",0.00,null);
	EntFire("sound_startbeep_1","PlaySound","",2.30,null);
	EntFire("start_stopsign_c_r","ShowSprite","",2.30,null);
	EntFire("sound_startbeep_1x","PlaySound","",3.30,null);
	EntFire("start_stopsign_c_r","HideSprite","",3.30,null);
	EntFire("start_stopsign_c_y","ShowSprite","",3.30,null);
	EntFire("sound_startbeep_2","PlaySound","",4.30,null);
	EntFire("start_stopsign_c_y","HideSprite","",4.30,null);
	EntFire("start_stopsign_c_g","ShowSprite","",4.30,null);
	EntFire("start_stopsign_c_g","HideSprite","",10.00,null);
	EntFire("i_kart_phys*","RunScriptCode"," startwake = false; ",2.30,null);
	EntFire("i_kart_phys*","EnableMotion","",4.30,null);
	EntFire("i_kart_button*","FireUser2","",4.30,null);
	if(STARTBOOST_TIMEWINDOW>0.00)
	{
		EntFire("i_kart_phys*","RunScriptCode"," startboostwindow = true; ",4.30,null);
		EntFire("i_kart_phys*","RunScriptCode"," startboostwindow = false; ",4.30+STARTBOOST_TIMEWINDOW,null);
	}
	EntFire(songname,"PlaySound","",songoffset-3.50,null);
	EntFire("i_kart_phys*","RunScriptCode"," TickDriveControl(true); ",4.51,null);
	EntFire("i_kart_phys*","RunScriptCode"," TickDriveControl(false); ",4.52,null);
	EntFireByHandle(self,"RunScriptCode"," SetActiveKartsPlacement(); ",4.00,null,null);
	max_karts = active_karts;
	EntFire("text_kartsleft","AddOutput","message KARTS "+active_karts+"/"+max_karts,4.25,null);
	EntFire("text_kartsleft","Display","",4.30,null);
	EntFire("text_karthp_all","Display","",4.30,null);
	EntFireByHandle(self,"RunScriptCode"," HideKartHealthForNonKarters(); ",4.30,null,null);
	if(ALLOW_DAMAGE_IN_KART)
	{
		EntFire("server","Command","say ***YOU CAN NOW DAMAGE/TAKE DAMAGE WHILE IN A KART***",10.00,null);
		EntFire("server","Command","say ***YOU CAN NOW DAMAGE/TAKE DAMAGE WHILE IN A KART***",10.01,null);
		EntFire("server","Command","say ***YOU CAN NOW DAMAGE/TAKE DAMAGE WHILE IN A KART***",10.02,null);
		EntFire("i_kart_phys*","RunScriptCode"," damageable = true; ",10.00,null);
	}
	EntFire("start_camera","Disable","",0.00,null);
	EntFire("start_camera","ClearParent","",0.10,null);
	EntFire("start_camera","AddOutput","origin 0 0 0",0.20,null);
	EntFire("start_camera","AddOutput","angles 0 0 0",0.20,null);
}

karthpindex <- 1;
function PrintKartHealth(amount,hidetext=false)
{
	//activator = driver
	if(hidetext)EntFire("text_karthp_"+karthpindex,"AddOutput","message ",0.00,null);
	else EntFire("text_karthp_"+karthpindex,"AddOutput","message HP "+amount.tostring(),0.00,null);
	EntFire("text_karthp_"+karthpindex,"Display","",0.02,activator);
	karthpindex++;
	if(karthpindex>=8)karthpindex=1;
}

function HideKartHealthForNonKarters()
{
	for(local i=0;i<PLAYERS.len();i++)
	{
		if(PLAYERS[i].kart==null)
		{
			if(PLAYERS[i].handle!=null&&PLAYERS[i].handle.IsValid()&&PLAYERS[i].handle.GetHealth()>0)
				EntFire("manager","RunScriptCode"," PrintKartHealth(0,true); ",0.00,PLAYERS[i].handle);
		}
	}
}

soundpool_arr <- [];
soundpool <- 0;
function PlaySoundCC(sound,pos=null)
{
	self.PrecacheSoundScript(sound);
	local shandle = soundpool_arr[soundpool];
	soundpool++;
	if(soundpool>=soundpool_arr.len())
		soundpool = 0;
	if(pos==null)pos = activator.GetOrigin();
	shandle.SetOrigin(pos);
	EntFireByHandle(shandle,"AddOutput","message "+sound,0.00,null,null);
	EntFireByHandle(shandle,"Volume","0",0.00,null,null);
	EntFireByHandle(shandle,"StopSound","",0.00,null,null);
	EntFireByHandle(shandle,"Volume","10",0.01,null,null);
	EntFireByHandle(shandle,"PlaySound","",0.01,null,null);
}

function InitSoundCC()
{
	soundpool = 0;
	soundpool_arr.clear();
	EntFire("soundpool_*","FireUser1","",0.05);
}

function AddSoundCC()
{
	if(caller!=null&&caller.IsValid())
		soundpool_arr.push(caller);
}

function ResetCheckpoint()
{
	local c = GetPlayerClassByHandle(activator);
	if(c==null)return;
	c.checkpoint = 0;
	if("ubc" in activator.GetScriptScope())activator.GetScriptScope().ubc <- null;
}

function ResetCheckpointX()
{
	local c = GetPlayerClassByHandle(activator);
	if(c==null)return;
	c.ia_L = -1;
	c.ia_C = -1;
}

function SpawnTemplates(arr,tem,justpos,minrand=0.00,maxrand=0.00)
{
	for(local i=0;i<randomitemspawn[arr].len();i++)
	{
		local sshpos = randomitemspawn[arr][i];
		local sshang = Vector(0,0,0);
		if(!justpos)sshang = Vector(randomitemspawn[arr][i+1].x,randomitemspawn[arr][i+1].y,randomitemspawn[arr][i+1].z);
		local temhand = Entities.FindByName(null,tem+"_maker");
		temhand.SpawnEntityAtLocation(sshpos,sshang)
		if(!justpos)i++;
	}
}
//randomitemspawn <- [];//array containing arrays for each stage, containing Vector() node positions
function SpawnRandomItem(arr,mintime,maxtime,starchance)
{
	EntFireByHandle(self,"RunScriptCode"," SpawnRandomItem("+arr+","+mintime+","+maxtime+","+starchance+"); ",RandomFloat(mintime,maxtime),null,null);
	//arr = index of randomitemspawn
	//starchance = percentage (0-100 chance of a star spawning instead of a mushroom)
	//mushroom = 60% chance
	//repair = 40% chance
	//^unless starchance won
	local rngpos = randomitemspawn[arr][RandomInt(0,randomitemspawn[arr].len()-1)];
	local item="s_item_mushroom";if(RandomFloat(0,100)<40.00)item="s_item_repair";
	if(RandomFloat(0,100)<starchance)item="s_item_star";
	local sshpos = Vector(rngpos.x+RandomInt(-250,250),rngpos.y+RandomInt(-250,250),rngpos.z);
	local sshang = Vector(0,RandomInt(0,359),0);
	local temhand = Entities.FindByName(null,item+"_maker");
	temhand.SpawnEntityAtLocation(sshpos,sshang)
}

function CheckItemBox()
{
	local c = GetPlayerClassByHandle(activator);
	if(c!=null)
	{
		if(c.kart!=null)
		{
			if(racestart&&!finaleactive)//makes it only work during normal races
			{
				local tier = GetItemTier(c)//1=first, 2=mid, 3=last
				if(MASTER!=null&&c.userid==MASTER&&MASTERBATE&&MASTERTIER!=null)
					EntFireByHandle(c.kart,"RunScriptCode"," ConfirmedItemBox("+MASTERTIER.tostring()+"); ",0.00,null,null);
				else
					EntFireByHandle(c.kart,"RunScriptCode"," ConfirmedItemBox("+tier.tostring()+"); ",0.00,null,null);
			}
			else
				EntFireByHandle(c.kart,"RunScriptCode"," ConfirmedItemBox(); ",0.00,null,null);
		}
		if(PUNISH_ITEMCAMPING && racestart && !finaleactive)
		{
			if(GetDistance(activator.GetOrigin(),c.itemcamplast)<=PUNISH_ITEMCAMPING_RANGE)
			{
				c.itemcampcount++;
				if(c.itemcampcount >= PUNISH_ITEMCAMPING_COUNT)
				{
					c.score += SCORE_PUNISH;
					EntFireByHandle(c.handle,"SetDamageFilter","",0.00,null,null);
					EntFireByHandle(c.handle,"SetDamageFilter","",0.01,null,null);
					EntFireByHandle(c.handle,"SetDamageFilter","",0.02,null,null);
					EntFireByHandle(c.handle,"SetHealth","-1",0.00,null,null);
					EntFireByHandle(c.handle,"SetHealth","-1",0.01,null,null);
					EntFireByHandle(c.handle,"SetHealth","-1",0.02,null,null);
					c.itemcampcount = 0;
					c.itemcamplast = Vector(-99999,-99999,-99999);
					local pname = c.name;if(pname==null||pname==""||pname==" ")pname="userid-"+c.userid.tostring();
					EntFire("server","Command","say ["+pname+" DIED DUE TO ITEMBOX CAMPING/TROLLING]",0.00,null);
				}
			}
			else
				c.itemcampcount = 0;
			c.itemcamplast = activator.GetOrigin();
		}
	}
}

function CheckInactivity()
{
	if(!PUNISH_INACTIVITY)return;
	EntFireByHandle(self,"RunScriptCode"," CheckInactivity(); ",INACTIVITY_SLAY_TIME,null,null);
	foreach(c in PLAYERS)
	{
		if(c==null)continue;
		else if(c.handle==null||!c.handle.IsValid()||c.kart==null||!c.kart.IsValid()||c.lastround_place!=0)
		{	
			c.ia_L = -1;
			c.ia_C = -1;
			continue;
		}
		else if(c.lap==c.ia_L&&c.checkpoint==c.ia_C)
		{
			c.score += SCORE_PUNISH;
			EntFireByHandle(c.handle,"SetDamageFilter","",0.00,null,null);
			EntFireByHandle(c.handle,"SetDamageFilter","",0.01,null,null);
			EntFireByHandle(c.handle,"SetDamageFilter","",0.02,null,null);
			EntFireByHandle(c.handle,"SetHealth","-1",0.00,null,null);
			EntFireByHandle(c.handle,"SetHealth","-1",0.01,null,null);
			EntFireByHandle(c.handle,"SetHealth","-1",0.02,null,null);
			local pname = c.name;if(pname==null||pname==""||pname==" ")pname="userid-"+c.userid.tostring();
			EntFire("server","Command","say ["+pname+" DIED DUE TO INACTIVITY/CAMPING]",0.00,null);
		}
		else
		{
			c.ia_L = c.lap;
			c.ia_C = c.checkpoint;
		}
	}
}

function EnterKartStart()
{
	local c = GetPlayerClassByHandle(activator);
	if(c!=null)
	{
		EntFireByHandle(caller,"FireUser4","",0.00,activator,activator);
		if(RandomInt(0,1)==0)EntFireByHandle(caller.GetRootMoveParent(),"RunScriptCode"," SetOtherSound(); ",0.20,null,null);
		if(c==null||c.handle==null||!c.handle.IsValid())return;
		if(c.userid==MASTER&&c.userid!=null)
		{
			EntFireByHandle(caller.GetRootMoveParent(),"SetHealth","300000",0.00,c.handle,c.handle);
			c.kartcolor=MASTERCOLOR;
			if(c.kartcolor!=null)
				EntFireByHandle(caller.GetRootMoveParent(),"RunScriptCode","SetKartColor("+c.kartcolor.x+","+c.kartcolor.y+","+c.kartcolor.z+");",0.00,c.handle,c.handle);
			if(MASTERZERO)
				EntFireByHandle(caller.GetRootMoveParent(),"RunScriptCode"," SetZeroFake(); ",0.20,c.handle,c.handle);
		}
		local peopleofcolor = false;
		if(IsVip(c.handle))peopleofcolor=true;
		else if(c.scoreplacement != -1&&c.scoreplacement<=KARTCOLOR_PLACEMENT_REQUIREMENT)peopleofcolor=true;
		if(peopleofcolor&&c.kartcolor!=null)
			EntFireByHandle(caller.GetRootMoveParent(),"RunScriptCode","SetKartColor("+c.kartcolor.x+","+c.kartcolor.y+","+c.kartcolor.z+");",0.00,c.handle,c.handle);
	}
	else
	{
		EntFire("text_errorplayerkart","Display","",0.00,activator);
		EntFireByHandle(activator,"AddOutput","basevelocity 0 0 400",0.00,activator,activator);
		EntFireByHandle(self,"RunScriptCode"," RetryRegister(false); ",0.00,activator,activator);
	}
}

function RegisterKart(on_off)
{
	local c = GetPlayerClassByHandle(activator);
	if(c==null)
	{
		if(on_off)EntFireByHandle(caller,"RunScriptCode"," RetryRegister(); ",2.00,null,null);
		return;
	}
	else if(on_off)
	{
		c.kart = caller;
		if(MASTER!=null&&c.userid==MASTER&&MASTERBATE)
			EntFireByHandle(caller,"RunScriptCode"," ismm = true; ",0.00,null,null);
		if(finaleactive)
		{
			if(c.scoreplacement==1)
			{
				EntFireByHandle(caller,"RunScriptCode"," finale_addspeed = 0.20; ",0.00,null,null);
				EntFireByHandle(caller,"RunScriptCode"," AddSpeed(0.20); ",0.00,null,null);
				EntFireByHandle(caller,"RunScriptCode"," boostleftmouse = true; ",0.00,null,null);
				EntFireByHandle(caller,"RunScriptCode"," jumpinair_max = 2; ",0.00,null,null);
			}
			else if(c.scoreplacement==2||c.scoreplacement==3)
			{
				EntFireByHandle(caller,"RunScriptCode"," finale_addspeed = 0.10; ",0.00,null,null);
				EntFireByHandle(caller,"RunScriptCode"," AddSpeed(0.10); ",0.00,null,null);
				EntFireByHandle(caller,"RunScriptCode"," jumpinair_max = 1; ",0.00,null,null);
			}
		}
		EntFireByHandle(c.kart,"RunScriptCode"," thirdpersonpref = "+c.thirdpersonpref.tostring()+"; ",0.00,null,null);
		if(!inspawnhub)
			EntFireByHandle(c.kart,"RunScriptCode"," SetPrefPerson(); ",0.02,null,null);
	}
	else c.kart = null;
}

function EnteredCheckpoint()
{
	local index = split(caller.GetName(),"checkpoint_")[0].tointeger();
	local playah = activator;
	if(playah!=null&&playah.IsValid()&&playah.GetClassname()=="player"&&playah.GetHealth()>0)
	{
		local c = GetPlayerClassByHandle(playah);
		if(c==null)
		{
			for(local i=0;i<PLAYERS.len();i++)
			{
				if(PLAYERS[i].handle==playah){c=PLAYERS[i];break;}
			}
			if(c==null)
			{
				playah.ValidateScriptScope();
				if("uid" in playah.GetScriptScope())c=GetPlayerClassByID(playah.GetScriptScope().uid);
				if(c==null)
				{
					if(playah!=null&&playah.IsValid()&&playah.GetHealth()>0)
					{
						EntFireByHandle(self,"RunScriptCode"," RetryRegister(false); ",0.00,playah,playah);
						if(DEBUG)EntFire("server","Command","say ERROR-READING-CHECKPOINT: ("+playah.tostring()+")",0.00,null);
						EntFire("text_errorplayer","Display","",0.00,playah);
						playah.GetScriptScope().ubc <- index;
					}
					return;
				}
			}
		}
		else if(c.handle==null||!c.handle.IsValid()||c.handle!=activator)c.handle=activator;
		c.last_checkpoint_pos = caller.GetOrigin();	
		if(c.checkpoint < index)
		{
			if(index==1+c.checkpoint)			//NEXT CHECKPOINT
			{
				c.checkpoint = index;
				c.score += SCORE_FINISH_CHECKPOINT;
				c.itemcampcount = 0;
				if(c.kart!=null&&c.kart.IsValid())EntFireByHandle(c.kart,"RunScriptCode"," SetCheckPoint(); ",0.00,null,null);
			}
			else if(c.lastround_place==0)		//CHEATER (finished players can do as they please though)
			{
				local cheaty = true;
				playah.ValidateScriptScope();
				if("ubc" in playah.GetScriptScope())
				{
					local save_index = playah.GetScriptScope().ubc;
					if(save_index != null)
					{
						if(index==1+save_index)
							cheaty = false;
					}
				}
				if(cheaty)
				{
					c.score += SCORE_PUNISH;
					EntFireByHandle(c.handle,"SetDamageFilter","",0.00,null,null);
					EntFireByHandle(c.handle,"SetDamageFilter","",0.01,null,null);
					EntFireByHandle(c.handle,"SetDamageFilter","",0.02,null,null);
					EntFireByHandle(c.handle,"SetHealth","-1",0.00,null,null);
					EntFireByHandle(c.handle,"SetHealth","-1",0.01,null,null);
					EntFireByHandle(c.handle,"SetHealth","-1",0.02,null,null);
					local pname = c.name;if(pname==null||pname==""||pname==" ")pname="userid-"+c.userid.tostring();
					EntFire("server","Command","say ["+pname+" CHEATED AND DIED]",0.00,null);
				}
				else
				{
					c.checkpoint = index;
					c.score += SCORE_FINISH_CHECKPOINT;
				}
			}
		}
		else if(c.checkpoint>1&&index==0)		//FINISH LINE
		{
			c.checkpoint = index;
			c.lap++;
			c.itemcampcount = 0;
			if(c.kart!=null&&c.kart.IsValid())EntFireByHandle(c.kart,"RunScriptCode"," SetCheckPoint(); ",0.00,null,null);
			if(c.lap==(1+max_laps))
			{
				c.score += SCORE_FINISH_RACE;
				PLAYERS_FINISHED++;
				if(racewon)
				{
					if(!zero)
						EntFire("client","Command","play *luffaren_crazykart/kart_win.mp3",0.00,playah);
					else
						EntFire("client","Command","play *luffaren_crazykart/ckz_finish.mp3",0.00,playah);
				}
				else
				{
					RaceWon(true);
					if(ghost_active)EndGhost();
					if(zero&&winplacing==1)
						EntFire("client","Command","play *luffaren_crazykart/ckz_alright_first_place.mp3",3.00,playah);
				}
				c.lastround_place = winplacing;
				local pname = c.name;if(pname==null||pname==""||pname==" ")pname="userid-"+c.userid.tostring();
				EntFire("server","Command","say ["+pname+" FINISHED "+winplacing+"]",0.00,null);
				/*
				EntFire("text_laps","AddOutput","message FINISHED "+winplacing.tostring(),0.00,null);
				if(c.handle!=null&&c.handle.IsValid()&&c.handle.GetHealth()>0)
					EntFire("text_laps","Display","",0.01,c.handle);
				*/
				if(c.kart!=null&&c.kart.IsValid())
							EntFireByHandle(c.kart,"RunScriptCode"," zerowon = true; ",0.00,null,null);
				winplacing++;
				for(local i=16;i>c.lastround_place;i--){c.score += SCORE_FINISH_RACE_PLACEBONUS;}
			}
			else
			{
				/*
				if(c.lastround_place==0)
				{
					EntFire("text_laps","AddOutput","message LAP "+c.lap.tostring()+"/"+max_laps.tostring(),0.00,null);
					if(c.handle!=null&&c.handle.IsValid()&&c.handle.GetHealth()>0)
						EntFire("text_laps","Display","",0.01,c.handle);
				}
				*/
				if(c.lap==max_laps && !finallap){FinalLap();c.score += SCORE_FINISH_LAP;}
				else if(c.lap<(1+max_laps))
				{
					c.score += SCORE_FINISH_LAP;
					if(!zero)
						EntFire("client","Command","play *luffaren_crazykart/kart_lap.mp3",0.00,playah);
					else if(!finallap)
					{
						EntFire("client","Command","play *luffaren_crazykart/ckz_you_have_boost_power.mp3",0.00,playah);
						if(!ghost_active)EntFire("text_fzeroboost","Display","",0.00,playah);
						if(c.kart!=null&&c.kart.IsValid())
							EntFireByHandle(c.kart,"RunScriptCode"," boostzready = true; ",0.00,null,null);
					}
				}
			}
		}
		else if(c.checkpoint==index)			//SAME CHECKPOINT
		{
			//nothing?
		}
		else									//WRONG WAY
		{
			c.checkpoint = index;
			if(c.kart!=null&&c.kart.IsValid())EntFireByHandle(c.kart,"RunScriptCode"," SetCheckPoint(); ",0.00,null,null);
			//add warning?
		}
		playah.ValidateScriptScope();
		playah.GetScriptScope().ubc <- null;
	}
}

function GetDistance(v1,v2){return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));}

function BlueShell()
{
	local max_lap = 0;
	local max_checkpoint = 0;
	local karters = [];
	local leaders = [];
	local leader = null;
	foreach(c in PLAYERS)
	{
		if(c.handle==null||!c.handle.IsValid()||c.kart==null||!c.kart.IsValid()||c.last_checkpoint_pos==null||c.lastround_place!=0)continue;
		karters.push(c);
		if(c.lap>max_lap)max_lap=c.lap;
	}
	foreach(c in karters){if(c.lap==max_lap&&c.checkpoint>max_checkpoint)max_checkpoint=c.checkpoint;}
	foreach(c in karters){if(c.lap==max_lap&&c.checkpoint==max_checkpoint)leaders.push(c);}
	if(leaders.len()==1)leader=leaders[0];
	else if(leaders.len()>0)
	{
		local tleader = null;
		local fdistance = 0;
		foreach(c in leaders)
		{
			local cdist = GetDistance(c.last_checkpoint_pos,c.kart.GetOrigin());
			if(cdist>fdistance)
			{
				tleader = c;
				fdistance = cdist;
			}
		}
		leader = tleader;
	}
	if(leader!=null)
	{
		local spos = leader.kart.GetOrigin()+Vector(0,0,16)+(leader.kart.GetForwardVector()*72);
		local temhand = Entities.FindByName(null,"s_blueshell_maker");
		temhand.SpawnEntityAtLocation(spos,Vector(0,0,0));
		EntFireByHandle(self,"RunScriptCode"," BlueShellPost(Vector("+spos.x+","+spos.y+","+spos.z+")); ",0.02,leader.kart,leader.kart);
	}
}

function BlueShellPost(pos)
{
	local e = Entities.FindByNameNearest("i_blueshell_mover*",pos,256);
	if(e==null||!e.IsValid()||activator==null||!activator.IsValid())return;
	EntFireByHandle(e,"SetParent","!activator",0.00,activator,activator);
	EntFireByHandle(e,"FireUser1","",0.00,null,null);
}

function BlueShellPostPost()
{
	local e = Entities.FindByNameNearest("i_bombexplosion_model*",caller.GetOrigin(),128);
	if(e==null||!e.IsValid())return;
	EntFireByHandle(e,"color","0 50 255",0.00,null,null);
	EntFireByHandle(e,"AddOutput","rendercolor 0 50 255",0.00,null,null);
	EntFireByHandle(e,"AddOutput","rendermode 2",0.00,null,null);
	EntFireByHandle(e,"color","0 50 255",0.02,null,null);
	EntFireByHandle(e,"AddOutput","rendercolor 0 50 255",0.02,null,null);
	EntFireByHandle(e,"AddOutput","rendermode 2",0.02,null,null);
}

function RaceWon(rewardsurvivors=false)
{
	if(finaleactive)return;
	racewon = true;
	if(!zero)
	{
		EntFire("music_stage_*","Volume","0",0.00,null);
		EntFire("sound_winrace","PlaySound","",0.00,null);
		EntFire("sound_winrace2","PlaySound","",2.10,null);
		EntFire("music_finished_race","PlaySound","",8.30,null);
	}
	else
	{
		EntFire("music_stage_*","Volume","0",0.00,null);
		EntFire("sound_winrace_ckz","PlaySound","",0.00,null);
		EntFire("sound_winrace_ckz2","PlaySound","",0.20,null);
	}
	if(!allkartsbroken)
	{
		EntFire("server","Command","say ***ROUND ENDS IN 30 SECONDS***",10.00,null);
		EntFire("server","Command","say ***ROUND ENDS IN 20 SECONDS***",20.00,null);
		EntFire("server","Command","say ***ROUND ENDS IN 10 SECONDS***",30.00,null);
		EntFire("server","Command","say ***ROUND ENDS IN 5 SECONDS***",35.00,null);
		EntFire("server","Command","say ***ROUND ENDS IN 4 SECONDS***",36.00,null);
		EntFire("server","Command","say ***ROUND ENDS IN 3 SECONDS***",37.00,null);
		EntFire("server","Command","say ***ROUND ENDS IN 2 SECONDS***",38.00,null);
		EntFire("server","Command","say ***ROUND ENDS IN 1 SECONDS***",39.00,null);
		EntFire("server","Command","say ***ROUND ENDED***",40.00,null);
	}
	EntFireByHandle(self,"RunScriptCode"," KillAllPlayers(); ",40.00,null,null);
	if(rewardsurvivors)
	{
		local h=null;while(null!=(h=Entities.FindInSphere(h,Vector(0,0,0),100000)))
		{
			if(h.GetClassname()=="player"&&h.GetTeam()==3&&h.GetHealth()>0)
			{
				local c = GetPlayerClassByUserID(h);
				if(c!=null&&c.lastround_place==0)c.score += SCORE_HUMAN_SURVIVOR;
			}
		}
	}
}

function FinalLap()
{
	if(racewon)return;
	finallap = true;
	if(!zero)
	{
		EntFire("sound_finallap","PlaySound","",0.00,null);
		songname = songname+"_fast";
		EntFire("music_stage_*","Volume","0",0.00,null);
		EntFire(songname,"PlaySound","",3.20,null);
		EntFire(songname,"PlaySound","",3.24,null);
		EntFire(songname,"Volume","10",3.22,null);
		EntFire(songname,"Volume","10",3.26,null);
	}
	else
	{
		EntFire("sound_finallap","AddOutput","message *luffaren_crazykart/ckz_finallap.mp3",0.00,null);
		EntFire("sound_finallap","PlaySound","",0.05,null);
		songname = songname+"_fast";
		EntFire("music_stage_*","Volume","0",4.00,null);
		EntFire(songname,"PlaySound","",4.02,null);
		EntFire(songname,"PlaySound","",4.06,null);
		EntFire(songname,"Volume","10",4.04,null);
		EntFire(songname,"Volume","10",4.08,null);
	}
}

function StartGhost()
{
	ghost_active = false;
	ghost_kart = null;
	if(active_karts!=1||DISABLE_GHOSTMODE)return;
	for(local i=0;i<PLAYERS.len();i++)
	{
		if(PLAYERS[i].kart!=null&&PLAYERS[i].kart.IsValid())
		{
			if(ghost_kart!=null)
			{
				ghost_kart = null;
				return;
			}
			ghost_kart = PLAYERS[i].kart;
		}
	}
	if(ghostarr_time[ghostarr_idx]!=999999)
	{
		EntFire("text_ghoststatus","AddOutput","message GHOST TIME: "+ghostarr_time[ghostarr_idx].tostring(),0.00,null);
		EntFire("text_ghoststatus","Display","",0.05,null);
	}
	ghost_active = true;
	if(ghostarr_idx==6||ghostarr_idx==7||ghostarr_idx==8)
	{
		local gkm = Entities.FindByNameNearest("ghost",self.GetOrigin(),10000);
		if(gkm!=null&&gkm.IsValid()&&gkm.GetClassname()=="prop_dynamic")
		{
			gkm.SetModel("models/luffaren/luffaren_kartzero.mdl");
			EntFire("ghost","SetAnimation","running_backward",0.04,null);
			EntFire("ghost","SetDefaultAnimation","running_backward",0.06,null);
		}
	}
	else
	{
		EntFire("ghost","SetAnimation","running_forward",0.04,null);
		EntFire("ghost","SetDefaultAnimation","running_forward",0.06,null);
	}
	EntFire("ghost","AddOutput","rendermode 2",0.00,null);
	EntFire("ghost","Alpha","100",0.01,null);
	EntFire("ghost","AddOutput","renderalpha 100",0.01,null);
	EntFire("ghost_trail","SetScale","1.0",0.05,null);
	EntFire("ghost_trail","AddOutput","startwidth 20.00",0.05,null);
	EntFire("ghost_trail","AddOutput","lifetime 0.50",0.05,null);	
	ghostarr_cur.clear();
	ghostarr_cur = [];
	ghost_count = 0;
	ghost_time = 0.00;
	ghost_showtime = 0.00;
	TickGhost();
}

ghostholder <- null;
function SetGhostHolder()
{
	ghostholder = caller;
}
function TickGhost()
{
	if(racewon)return;
	EntFireByHandle(self,"RunScriptCode"," TickGhost(); ",0.01,null,null);
	ghost_time += 0.0165;
	ghost_showtime = format("%.3f",ghost_time.tofloat());
	if(ghostarr[ghostarr_idx].len()>(2+ghost_count))
	{
		local gpos = ghostarr[ghostarr_idx][ghost_count];
		local grot = ghostarr[ghostarr_idx][ghost_count+1];
		ghostholder.SetOrigin(gpos);
		ghostholder.SetAngles(grot.x,grot.y,grot.z);
	}
	ghost_count+=2;
	if(ghost_kart!=null&&ghost_kart.IsValid())
	{
		ghostarr_cur.push(ghost_kart.GetOrigin());
		ghostarr_cur.push(ghost_kart.GetAngles());
		local gtext = "XXXXX";
		if(ghostarr_time[ghostarr_idx]==999999)gtext = "TIME "+ghost_showtime.tostring()+"s";
		else gtext = "TIME "+ghost_showtime.tostring()+"s (GHOST TIME "+ghostarr_time[ghostarr_idx].tostring()+"s)";
		ScriptPrintMessageCenterAll(gtext);
	}
}

function EndGhost()
{
	local gtext = "XXXXX";
	if(ghost_showtime.tofloat()<ghostarr_time[ghostarr_idx])
	{
		if(ghostarr_time[ghostarr_idx]==999999)
			gtext  = "NEW GHOST TIME SET "+ghost_showtime.tostring()+"s";
		else gtext  = "NEW GHOST TIME SET "+ghost_showtime.tostring()+"s (OLD GHOST TIME "+ghostarr_time[ghostarr_idx].tostring()+"s)";
		ghostarr_time[ghostarr_idx] = ghost_showtime.tofloat();
		ghostarr[ghostarr_idx].clear();
		for(local i=0;i<ghostarr_cur.len();i++){ghostarr[ghostarr_idx].push(ghostarr_cur[i]);}
	}
	if(gtext=="XXXXX")gtext = "YOUR TIME "+ghost_showtime.tostring()+"s (GHOST TIME "+ghostarr_time[ghostarr_idx].tostring()+"s)";
	ScriptPrintMessageCenterAll(gtext);
	/*
		EntFire("text_ghoststatus","AddOutput","message "+gtext,0.00,null);
		EntFire("text_ghoststatus","AddOutput","message "+gtext,0.02,null);
		EntFire("text_ghoststatus","AddOutput","channel 4",0.00,null);
		EntFire("text_ghoststatus","AddOutput","channel 4",0.02,null);
		EntFire("text_ghoststatus","Display","",0.05,null);
		EntFire("text_ghoststatus","Display","",0.15,null);
		EntFire("text_ghoststatus","Display","",0.25,null);
		EntFire("text_ghoststatus","Display","",0.35,null);
		EntFire("text_ghoststatus","Display","",0.45,null);
	*/
}

function RoundEnded()
{
	if(!racewon&&!iswarmup)
	{
		RaceWon();
		if(!finaleactive)
		{
			for(local i=0;i<PLAYERS.len();i++)
			{
				if(PLAYERS[i]!=null&&PLAYERS[i].kart!=null&&PLAYERS[i].handle!=null&&PLAYERS[i].handle.IsValid()&&PLAYERS[i].handle.GetHealth()>0)
				{PLAYERS[i].score += SCORE_ROUND_ENDED_EARLY;}
			}
			EntFire("server","Command","say ***ROUND ENDED EARLY - RACE CANCELED***",0.00,null);
			EntFire("server","Command","say ***ALL DRIVERS GOT ("+SCORE_ROUND_ENDED_EARLY+") POINTS***",1.00,null);
		}
	}
	inspawnhub = true;
	allowboom = false;
	ClearCameraParent();
	EntFire("spawn_playerfilter_timer2","Enable","",0.00,null);
	EntFire("start_camera","ClearParent","",0.00,null);
	EntFire("start_camera","Disable","",0.00,null);
	EntFire("camera","ClearParent","",0.02,null);
	EntFire("camera","Disable","",0.02,null);
	EntFire("start_camera","AddOutput","origin 0 0 0",0.20,null);
	EntFire("start_camera","AddOutput","angles 0 0 0",0.20,null);
	EntFire("camera","AddOutput","origin 0 0 0",0.20,null);
	EntFire("camera","AddOutput","angles 0 0 0",0.20,null);
	EntFire("spawn_playerfilter_trigger","Disable","",0.00,null);
	EntFire("spawn_killer","Disable","",0.00,null);
	EntFire("trigger_multiple","Kill","",3.00,null);//B5
	EntFire("spawn_actualkiller","Enable","",0.00,null);
	EntFire("i_kart_phys*","FireUser3","",0.50,null);
	EntFire("i_itembox_trigger*","FireUser1","",0.00,null);
	EntFire("s_itemboxrespawn_maker","Kill","",0.00,null);
	EntFire("s_itembox_maker","Kill","",0.00,null);
	EntFire("text*","Kill","",4.00,null);//added in V2
	EntFire("speedzone*","Kill","",0.00,null);
	EntFire("checkpoint_*","Kill","",0.00,null);
	EntFire("i_item_banana_phys*","FireUser1","",1.00,null);
	EntFire("i_item_star_phys*","FireUser1","",1.00,null);
	EntFire("i_item_fakeitemblock_trigger*","FireUser1","",1.00,null);
	EntFire("i_item_mushroom_phys*","FireUser1","",1.00,null);
	EntFire("i_item_shellred_phys*","FireUser1","",1.00,null);
	EntFire("i_item_shellgreen_phys*","FireUser1","",1.00,null);
	EntFire("i_starpower_steam*","FireUser1","",1.00,null);
	EntFire("i_item_oil_trigger*","FireUser1","",1.00,null);
	EntFire("i_thwomp_mover*","FireUser4","",2.00,null);
}

function ClearCameraParent()
{
	EntFireByHandle(self,"RunScriptCode"," ClearCameraParent(); ",0.05,null,null);
	EntFire("start_camera","ClearParent","",0.00,null);
	EntFire("camera","ClearParent","",0.00,null);
}

function TimeOutKill()
{
	if(racewon)return;
	EntFire("server","Command","say ***OUT OF TIME (SLAYING)***",0.00,null);
	local timtim = 0.20;
	local klist=[];local h = null;while(null!=(h=Entities.FindByNameWithin(h,"i_kart_phys*",Vector(0,0,0),100000)))
	{if(h.GetHealth()>6000)klist.push(h);}
	local n = klist.len();
	for(local i=0;i<n;i++)
	{
		for(local j=1;j<(n-i);j++)
		{
			if(klist[j-1].GetHealth() < klist[j].GetHealth())
			{
				local temp = klist[j-1];
				klist[j-1] = klist[j];
				klist[j] = temp;
			}
		}
	}
	for(local i=(klist.len()-1);i>(-1);i--){EntFireByHandle(klist[i],"RunScriptCode"," DestroySelf(false); ",timtim,null,null);timtim+=0.10;}
}

function KillAllPlayers()
{
	EntFire("spawn_playerfilter_timer2","Enable","",0.00,null);
	EntFire("spawn_playerfilter_trigger","Disable","",0.00,null);
	EntFire("spawn_killer","Disable","",0.00,null);
	EntFire("spawn_actualkiller","Enable","",0.00,null);
	local h = null;while(null!=(h=Entities.FindByClassname(h,"player")))
	{
		if(h.GetHealth()>0)
		{
			EntFireByHandle(h,"SetDamageFilter","",0.00,null,null);
			EntFireByHandle(h,"SetHealth","-1",0.00,null,null);
			EntFireByHandle(h,"SetDamageFilter","",0.01,null,null);
			EntFireByHandle(h,"SetHealth","-1",0.01,null,null);
			EntFireByHandle(h,"SetDamageFilter","",0.02,null,null);
			EntFireByHandle(h,"SetHealth","-1",0.02,null,null);
		}
	}
}

function ScanLastDriver()
{
	if(!racewon)
	{
		allkartsbroken = true;
		RaceWon();
		local solofound = false;
		local lp = null;
		for(local i=0;i<PLAYERS.len();i++)
		{
			if(PLAYERS[i]!=null&&PLAYERS[i].kart!=null&&PLAYERS[i].handle!=null&&PLAYERS[i].handle.IsValid()&&PLAYERS[i].handle.GetHealth()>0)
			{
				PLAYERS[i].score += SCORE_LAST_ALIVE;
				PLAYERS[i].lastround_place = 1;
				lp = PLAYERS[i].name;if(lp==null||lp==""||lp==" ")lp="userid-"+PLAYERS[i].userid.tostring();
				solofound = true;
				EntFire("text_laps","AddOutput","message FINISHED 1 (SOLO)",0.05,null);
				if(PLAYERS[i].handle!=null&&PLAYERS[i].handle.IsValid()&&PLAYERS[i].handle.GetHealth()>0)
					EntFire("text_laps","Display","",0.07,PLAYERS[i].handle);
				break;
			}
		}
		if(solofound)
		{
			EntFire("server","Command","say ["+lp+" - LAST ALIVE]",0.00,null);
			EntFire("server","Command","say ***SOLO WIN***",1.00,null);
		}
		else
		{
			EntFire("server","Command","say ***ALL THE KARTS ARE BROKEN DOWN***",0.00,null);
		}
		EntFire("server","Command","say ***ROUND ENDING IN 5 SECONDS***",5.00,null);
		EntFire("server","Command","say ***ROUND ENDING IN 4 SECONDS***",6.00,null);
		EntFire("server","Command","say ***ROUND ENDING IN 3 SECONDS***",7.00,null);
		EntFire("server","Command","say ***ROUND ENDING IN 2 SECONDS***",8.00,null);
		EntFire("server","Command","say ***ROUND ENDING IN 1 SECONDS***",9.00,null);
		EntFire("server","Command","say ***ROUND ENDED***",10.00,null);
		EntFireByHandle(self,"RunScriptCode"," KillAllPlayers(); ",10.00,null,null);
	}
}

function SetActiveKartsPlacement()
{
	active_karts_placement = active_karts;
	if(active_karts_placement<=0)active_karts_placement=0;
}

max_karts <- 64;
active_karts <- 64;
active_karts_placement <- 64;
function KartExploded()//activator = driver (if any)
{
	active_karts--;
	if(!finaleactive)
	{
		if(active_karts <= 1)//only one kart left, end round
			EntFireByHandle(self,"RunScriptCode"," ScanLastDriver(); ",0.10,null,null);
		else if(!racestart&&!racewon)//if a battle mode is running (!activator is the driver)
		{
			local c = GetPlayerClassByHandle(activator);
			if(c!=null&&c.handle!=null&&c.handle.IsValid())
			{
				c.score += (SCORE_BATTLE_PLACEBONUS/active_karts_placement).tointeger();
				local pname = c.name;if(pname==null||pname==""||pname==" ")pname="userid-"+c.userid.tostring();
				if(c.lastround_place==0)EntFire("server","Command","say ["+pname+" FINISHED "+active_karts_placement+"]",0.00,null);
				else EntFire("server","Command","say ["+pname+" FINISHED "+active_karts_placement+" BY STEALING A KART]",0.00,null);
				DisplayText("text_laps","FINISHED "+active_karts_placement.tostring(),c.handle);
				c.lastround_place = active_karts_placement;
			}
			if(active_karts_placement>1)active_karts_placement--;
			if(s7_bomb&&active_karts<=S7_SUDDEN_DEATH_START)
			{
				s7_bomb = false;
				StageSevenSuddenDeath();
			}
		}
	}
	if(active_karts<0)active_karts=0;
	EntFire("text_kartsleft","AddOutput","message KARTS "+active_karts+"/"+max_karts,0.00,null);
	EntFire("text_kartsleft","Display","",0.01,null);
}

function StageSevenSuddenDeath()
{
	if(racewon)return;
	local timereset = active_karts.tofloat()/S7_SUDDEN_DEATH_RATE; //V1: "/5.0" added
	if(timereset < 0.05)timereset = 0.05;//B5: 1.00, V1: 0.10, V2: 0.05
	EntFireByHandle(self,"RunScriptCode"," StageSevenSuddenDeath(); ",timereset,null,null);
	local bstempp = Entities.FindByName(null,"s6_bombspawn");
	bstempp.SetAngles(RandomInt(0,90),RandomInt(0,359),0);
	EntFire("s6_bombspawn","ForceSpawn","",0.02,null);
	if(active_karts<=S7_SUDDEN_DEATH_ARTILLERYSTART)
	{
		local spos = Vector(12288+RandomInt(-2048,2048),-2048+RandomInt(-2048,2048),-15352);
		artmaker.SpawnEntityAtLocation(spos,Vector(0,0,0));
	}
}

dspt <- 0.00;
function DisplayText(textent,message,handle)
{
	if(handle==null||!handle.IsValid()||handle.GetHealth()<=0)return;
	if(dspt<0.00)dspt=0.00;
	EntFire(textent,"AddOutput","message "+message,dspt,null);
	EntFire(textent,"Display","",dspt+0.01,handle);
	dspt+=0.02;EntFireByHandle(self,"RunScriptCode"," dspt-=0.02; ",0.03,null,null);
}

::DEATHS<-[];
class ::DeathEvent{userid=null;attacker=null;constructor(_userid,_attacker){userid=_userid;attacker=_attacker;::DEATHS.push(this);}}
function OnPlayerDeath()
{
	if(::DEATHS.len()>0)
	{
		EntFireByHandle(self,"RunScriptCode"," OnPlayerDeath(); ",0.01,null,null);
		local dd = ::DEATHS[0];
		if(dd.attacker==0||dd.userid==dd.attacker)return;
		local c = GetPlayerClassByUserID(dd.attacker);
		if(c!=null)c.score += SCORE_KILL;
		::DEATHS.remove(0);	
	}
	else EntFireByHandle(self,"RunScriptCode"," OnPlayerDeath(); ",0.50,null,null);
}
function ResetBoom(userid){local c=GetPlayerClassByUserID(userid);if(c!=null)c.boom=true;}

kartspawns <- [Vector(-14080,14848,-15860),
Vector(-14152,15072,-15860),
Vector(-14152,15016,-15860),
Vector(-14152,14960,-15860),
Vector(-14152,14904,-15860),
Vector(-14152,14848,-15860),
Vector(-14152,14792,-15860),
Vector(-14152,14736,-15860),
Vector(-14152,14680,-15860),
Vector(-14152,14624,-15860),
Vector(-14224,15072,-15860),
Vector(-14224,15016,-15860),
Vector(-14224,14960,-15860),
Vector(-14224,14904,-15860),
Vector(-14224,14848,-15860),
Vector(-14224,14792,-15860),
Vector(-14224,14736,-15860),
Vector(-14224,14680,-15860),
Vector(-14224,14624,-15860),
Vector(-14296,15072,-15860),
Vector(-14296,15016,-15860),
Vector(-14296,14960,-15860),
Vector(-14296,14904,-15860),
Vector(-14296,14848,-15860),
Vector(-14296,14792,-15860),
Vector(-14296,14736,-15860),
Vector(-14296,14680,-15860),
Vector(-14296,14624,-15860),
Vector(-14368,15072,-15860),
Vector(-14368,15016,-15860),
Vector(-14368,14960,-15860),
Vector(-14368,14904,-15860),
Vector(-14368,14848,-15860),
Vector(-14368,14792,-15860),
Vector(-14368,14736,-15860),
Vector(-14368,14680,-15860),
Vector(-14368,14624,-15860),
Vector(-14440,15072,-15860),
Vector(-14440,15016,-15860),
Vector(-14440,14960,-15860),
Vector(-14440,14904,-15860),
Vector(-14440,14848,-15860),
Vector(-14440,14792,-15860),
Vector(-14440,14736,-15860),
Vector(-14440,14680,-15860),
Vector(-14440,14624,-15860),
Vector(-14512,15072,-15860),
Vector(-14512,15016,-15860),
Vector(-14512,14960,-15860),
Vector(-14512,14904,-15860),
Vector(-14512,14848,-15860),
Vector(-14512,14792,-15860),
Vector(-14512,14736,-15860),
Vector(-14512,14680,-15860),
Vector(-14512,14624,-15860),
Vector(-14584,15072,-15860),
Vector(-14584,15016,-15860),
Vector(-14584,14960,-15860),
Vector(-14584,14904,-15860),
Vector(-14584,14848,-15860),
Vector(-14584,14792,-15860),
Vector(-14584,14736,-15860),
Vector(-14584,14680,-15860),
Vector(-14584,14624,-15860)];

randomitemspawn <- [//=========================================
//stage 1 = basic ass raceway
//stage 2 = baby park
//stage 3 = snow
//stage 4 = funky funway
//stage 5 = lava castle
//stage 6 = battle
//stage 7 = star royale

//INDEX LIST:
//0 	= //stage 1 itemboxes
//1 	= //stage 1 rng
//2 	= //stage 2 itemboxes
//3 	= //stage 2 rng
//4 	= //stage 3 itemboxes
//5 	= //stage 3 rng
//6 	= //stage 4 itemboxes
//7 	= //stage 4 rng
//8 	= //stage 4 thwomps (+ angles)
//9 	= //stage 5 itemboxes
//10 	= //stage 5 rng
//11 	= //stage 5 thwomps (+ angles)
//12 	= //stage 6 itemboxes
//13 	= //stage 6 rng
//14 	= //stage 8 itemboxes
//15 	= //stage 8 thwomps (+ angles)
//16 	= //stage 8 rng


//stage 1 itemboxes:
[Vector(-6784,-8021.879883,-14276.799805),
Vector(-6784,-8247.919922,-14276.799805),
Vector(-808,-12224,-14352.599609),
Vector(-1064,-12224,-14352.599609),
Vector(-1320,-12224,-14352.599609),
Vector(-1720,-13520,-14200),
Vector(-5712,-15520,-14240),
Vector(-5712,-15392,-14240),
Vector(-5712,-15648,-14240),
Vector(-15712,-14912,-14123.200195),
Vector(-15584,-14912,-14123.200195),
Vector(-15456,-14912,-14123.200195),
Vector(-15968,-14208,-14120),
Vector(-1075,-9081,-14183),
Vector(-2056,-3984,-14430.400391),
Vector(-2080,-4096,-14430.400391),
Vector(-4039.709961,-6024,-14276.799805),
Vector(-4240.290039,-6024,-14276.799805),
Vector(-10077.099609,-9829.690430,-14276.799805),
Vector(-10141.500000,-9773.419922,-14276.799805),
Vector(-10205.900391,-9717.150391,-14276.799805),
Vector(-10270.299805,-9660.879883,-14276.799805),
Vector(-14886.400391,-11387.500000,-14271.299805)],

//stage 1 rng:
[Vector(-1088,-12672,-14199),
Vector(-1152,-12864,-14288.599609),
Vector(-900.664001,-11515.599609,-14288.599609),
Vector(-1221.119995,-10399.400391,-14288.599609),
Vector(-1310.500000,-6697.819824,-14211.799805),
Vector(-857.963989,-6513.470215,-14211.799805),
Vector(-1109.709961,-4855.200195,-14365.400391),
Vector(-2389.840088,-4156.740234,-14365.400391),
Vector(-3481.080078,-4135.069824,-14211.799805),
Vector(-4084.340088,-4149.290039,-14211.799805),
Vector(-4177.120117,-6601.779785,-14211.799805),
Vector(-4517.899902,-7691.180176,-14211.799805),
Vector(-5661.390137,-8130.680176,-14211.799805),
Vector(-4994.549805,-8062.319824,-14211.799805),
Vector(-4248.140137,-7201.029785,-14211.799805),
Vector(-6280.629883,-8154,-14211.799805),
Vector(-6827.220215,-8154.720215,-14211.799805),
Vector(-7447.250000,-8167.379883,-14211.799805),
Vector(-8091.919922,-8231.429688,-14211.799805),
Vector(-8635.709961,-8447.599609,-14211.799805),
Vector(-9164.780273,-8792.150391,-14211.799805),
Vector(-11255.099609,-10503.700195,-14211.799805),
Vector(-11773.500000,-10501.400391,-14154),
Vector(-12428.099609,-10524.200195,-14041),
Vector(-13056,-10524.200195,-14041),
Vector(-13696,-10524.200195,-14041),
Vector(-14568.200195,-10526.900391,-14211.799805),
Vector(-15146.599609,-10558,-14211.799805),
Vector(-15595.099609,-10618.700195,-14211.799805),
Vector(-15599.400391,-11189.200195,-14211.799805),
Vector(-15541.599609,-11742.200195,-14188.200195),
Vector(-15321.299805,-12308.900391,-14131.799805),
Vector(-15313.200195,-12889,-14078.099609),
Vector(-15516.900391,-13409.799805,-14058.200195),
Vector(-15621.299805,-13987.700195,-14058.200195),
Vector(-14762.900391,-14355.299805,-14058.200195),
Vector(-15359.700195,-14494,-14058.200195),
Vector(-14996.099609,-15009.700195,-14058.200195),
Vector(-15453.299805,-15121.400391,-14058.200195),
Vector(-14935,-15466.900391,-14058.200195),
Vector(-14103.200195,-15504.099609,-14052.299805),
Vector(-13452.900391,-15515.200195,-14045),
Vector(-12537.799805,-15508.400391,-14034.700195),
Vector(-11871.200195,-15511.799805,-14027.200195),
Vector(-11293.299805,-15504.200195,-14020.700195),
Vector(-10685.099609,-15519,-14019.799805),
Vector(-10132.500000,-15514.200195,-14019.799805),
Vector(-8237.940430,-15508.500000,-14019.799805),
Vector(-7701.009766,-15510.200195,-14027.599609),
Vector(-6949.700195,-15525.500000,-14066.299805),
Vector(-6405.009766,-15520.700195,-14109.299805),
Vector(-4945.830078,-15388.099609,-14204.799805),
Vector(-4205.319824,-15297.299805,-14205.799805),
Vector(-3689.350098,-15153.799805,-14205.200195),
Vector(-3110.729980,-14914.299805,-14208.799805),
Vector(-2565.290039,-14672.599609,-14208.900391),
Vector(-1406.910034,-13687.400391,-14288.599609),
Vector(-935.697998,-13480.299805,-14288.599609),
Vector(-1261.890015,-12450.900391,-14288.599609),
Vector(-868.039978,-12408.900391,-14288.599609),
Vector(-1183.040039,-11930.700195,-14288.599609),
Vector(-1202.439941,-11322.700195,-14288.599609),
Vector(-1080.270020,-10900.500000,-14288.599609),
Vector(-1082.180054,-6077.379883,-14211.799805),
Vector(-2944,-4144,-14270.200195),
Vector(-9640.900391,-15516.500000,-14019.799805)],

//stage 2 itemboxes:
[Vector(-5192,-12288,-14296),
Vector(-10168,-12288,-14296),
Vector(-6016,-12288,-14328),
Vector(-5920,-12288,-14328),
Vector(-5824,-12288,-14328),
Vector(-5728,-12288,-14328),
Vector(-5632,-12288,-14328),
Vector(-5536,-12288,-14328),
Vector(-5440,-12288,-14328),
Vector(-5344,-12288,-14328),
Vector(-9312,-12288,-14328),
Vector(-9408,-12288,-14328),
Vector(-9504,-12288,-14328),
Vector(-9600,-12288,-14328),
Vector(-9696,-12288,-14328),
Vector(-9792,-12288,-14328),
Vector(-9888,-12288,-14328),
Vector(-9984,-12288,-14328)],

//stage 2 rng:
[Vector(-6560,-11776,-14087),
Vector(-6208,-11776,-14087),
Vector(-5856,-11904,-14087),
Vector(-5712,-12256,-14087),
Vector(-5808,-12624,-14087),
Vector(-6128,-12768,-14087),
Vector(-6592,-12784,-14087),
Vector(-6784,-11776,-14087),
Vector(-7056,-12800,-14087),
Vector(-7520,-12816,-14087),
Vector(-7968,-12816,-14087),
Vector(-8432,-12816,-14087),
Vector(-8896,-12800,-14087),
Vector(-9344,-12768,-14087),
Vector(-9520,-12592,-14087),
Vector(-9632,-12240,-14087),
Vector(-9504,-11904,-14087),
Vector(-9184,-11776,-14087),
Vector(-8736,-11744,-14087),
Vector(-8272,-11744,-14087),
Vector(-7904,-11744,-14087)],

//stage 3 itemboxes:
[Vector(5216,-14996,-14330),
Vector(5268,-14822,-14330),
Vector(5320,-14644,-14330),
Vector(8776,-15499,-14330),
Vector(8773,-15678,-14330),
Vector(9257,-13805,-14330),
Vector(9298,-13957,-14330),
Vector(9339,-14109,-14330),
Vector(9693,-10980,-14330),
Vector(9895,-11000,-14330),
Vector(11775,-10632,-14330),
Vector(11819,-11196,-14330),
Vector(8834,-8454,-14330),
Vector(8913,-8602,-14330),
Vector(8998,-8761,-14330),
Vector(5697,-8618,-14330),
Vector(4518,-5235,-14330),
Vector(4510,-5404,-14330),
Vector(4393,-11862,-14330),
Vector(4376,-12010,-14330),
Vector(4356,-12174,-14330),
Vector(1516,-8109,-14330),
Vector(1291,-8114,-14330),
Vector(1405,-8111,-14330),
Vector(779,-11769,-14330),
Vector(617,-11772,-14330),
Vector(416,-11777,-14330),
Vector(826,-15524,-14330),
Vector(914,-15326,-14330),
Vector(974,-15154,-14330)],

//stage 3 rng:
[Vector(3906.080078,-14834.700195,-14128),
Vector(4473.299805,-14912.799805,-14128),
Vector(4930.549805,-14776.200195,-14128),
Vector(5389.779785,-14690.099609,-14128),
Vector(5818.959961,-14912.700195,-14128),
Vector(6136.459961,-15264.299805,-14128),
Vector(6241.470215,-14862.299805,-14128),
Vector(6544.500000,-15564,-14128),
Vector(7106.740234,-15714.200195,-14128),
Vector(7706.709961,-15587.500000,-14128),
Vector(8288.740234,-15611.400391,-14128),
Vector(8915.919922,-15712.299805,-14128),
Vector(9506.080078,-15682.700195,-14128),
Vector(9966.570313,-15587.400391,-14128),
Vector(10260.299805,-15093.500000,-14128),
Vector(10195.799805,-14551.200195,-14051.500000),
Vector(10209.900391,-14712.700195,-13859.500000),
Vector(10147.500000,-14327.099609,-13859.500000),
Vector(6719.270020,-14723.299805,-14128),
Vector(7233.029785,-14584.900391,-14128),
Vector(7538.879883,-14281.900391,-14128),
Vector(7941.350098,-13936.299805,-14128),
Vector(8375.230469,-13751.200195,-14128),
Vector(8832.669922,-13631,-14128),
Vector(9278.919922,-13433.700195,-14128),
Vector(9757.299805,-13307,-14128),
Vector(10188.500000,-13189.299805,-14128),
Vector(10520.599609,-13435.799805,-14128),
Vector(10902,-13639.900391,-14128),
Vector(11259.700195,-13814.500000,-14128),
Vector(11706.200195,-13688.400391,-14128),
Vector(11842.799805,-13177.700195,-14128),
Vector(11818.200195,-12692.599609,-14128),
Vector(11618.599609,-12273.500000,-14128),
Vector(11634.200195,-11837.500000,-14128),
Vector(11676.799805,-11312.200195,-14128),
Vector(11402.099609,-10857.200195,-14128),
Vector(11732.099609,-10791,-14128),
Vector(11477,-10368.200195,-14128),
Vector(11675.900391,-9873.320313,-14128),
Vector(11702.500000,-9319.089844,-14128),
Vector(11262.799805,-8878.580078,-14128),
Vector(10768,-8793.839844,-14128),
Vector(10407.799805,-9142.400391,-14128),
Vector(10169.400391,-9626.290039,-14128),
Vector(9881.740234,-10019.400391,-14128),
Vector(9682.620117,-10377.799805,-14128),
Vector(9599.150391,-10869,-14128),
Vector(9503.540039,-11408.200195,-14128),
Vector(9236.429688,-10171.400391,-14118.500000),
Vector(8803.209961,-9873.769531,-14013),
Vector(9226.139648,-9867.580078,-14068.400391),
Vector(10520.700195,-8380.860352,-14128),
Vector(10881.599609,-8407.110352,-14128),
Vector(10082.900391,-8098.370117,-14128),
Vector(9599.750000,-7973.220215,-14128),
Vector(9206.160156,-8194.980469,-14128),
Vector(8776.059570,-8554.690430,-14128),
Vector(8552.440430,-8910.469727,-14128),
Vector(8182.229980,-9269.839844,-14128),
Vector(7862.830078,-9562.730469,-14128),
Vector(7419.899902,-9524.530273,-14128),
Vector(7058.060059,-9604.950195,-14128),
Vector(6558.450195,-9808.790039,-14128),
Vector(6598.399902,-9267.610352,-14128),
Vector(6105.120117,-9815.990234,-14128),
Vector(5730.080078,-10114.700195,-14128),
Vector(5703.779785,-10605.500000,-14128),
Vector(5663.750000,-11109.500000,-14128),
Vector(6467.259766,-8749.650391,-14128),
Vector(6451.609863,-8105.620117,-14128),
Vector(6078.930176,-7726.609863,-14128),
Vector(5714.080078,-6770.660156,-14128),
Vector(4258.080078,-12018.700195,-14128),
Vector(3346.080078,-10434.700195,-14128),
Vector(2793.649902,-7257.410156,-14128),
Vector(2759.070068,-6914.990234,-14128),
Vector(2260.939941,-6948.950195,-14128),
Vector(1736.079956,-6984.390137,-14128),
Vector(1486.469971,-7498.279785,-14128),
Vector(1468.020020,-7918.330078,-14128),
Vector(1496.319946,-8352.459961,-14128),
Vector(1579.319946,-8849.759766,-14128),
Vector(1593.869995,-9345.169922,-14128),
Vector(1474.849976,-9881.599609,-14128),
Vector(1367.750000,-10433.599609,-14128),
Vector(1142.069946,-10951.500000,-14128),
Vector(657.075012,-11417.500000,-14128),
Vector(371.023987,-11865,-14128),
Vector(617.750977,-12346.900391,-14128),
Vector(900.440979,-12781.500000,-14128),
Vector(1314.760010,-13202.599609,-14128),
Vector(1258.489990,-13587,-14128),
Vector(1708.109985,-13885.099609,-14070.099609),
Vector(2072.949951,-14076.799805,-14004),
Vector(1735.709961,-13942.299805,-14059.700195),
Vector(1731.239990,-13987.099609,-14055.599609),
Vector(1273.319946,-14128.799805,-14114.799805),
Vector(954.573975,-14214.700195,-14128),
Vector(832.195984,-14663.400391,-14128),
Vector(847.705994,-15184.400391,-14128),
Vector(1290.250000,-15327.700195,-14128),
Vector(1770.520020,-15282,-14128),
Vector(2227.169922,-14999.200195,-14128),
Vector(2695.600098,-14851.099609,-14128)],

//stage 4 itemboxes:
[Vector(10240,3232,-15351),
Vector(10240,2912,-15351),
Vector(10240,3072,-15351),
Vector(11520,2992,-15351),
Vector(11520,2832,-15351),
Vector(11520,3152,-15351),
Vector(11520,3312,-15351),
Vector(14680.099609,2939.360107,-15160.099609),
Vector(14773.099609,2766.340088,-15165.700195),
Vector(14768.799805,2595.270020,-15170.400391),
Vector(14742.299805,2449.639893,-15164.200195),
Vector(15776,5376,-15352),
Vector(15968,5376,-15352),
Vector(13840,6064,-15352),
Vector(13680,6064,-15352),
Vector(15568,8192,-15352),
Vector(15760,8192,-15352),
Vector(15952,8192,-15352),
Vector(11086.099609,8163.629883,-15290.099609),
Vector(11228.700195,8135.259766,-15250.099609),
Vector(8766.559570,6619.990234,-15351),
Vector(6616.109863,5324.859863,-15351),
Vector(6671.750000,5462.259766,-15351),
Vector(6727.399902,5599.660156,-15351),
Vector(5243.770020,8256.309570,-15351),
Vector(5059.020020,8024.439941,-15351),
Vector(5151.390137,8140.370117,-15351),
Vector(4549.370117,5520.160156,-15352),
Vector(4538.629883,5695.839844,-15352),
Vector(968.263977,7028.919922,-15351),
Vector(1116.130005,7018.459961,-15351),
Vector(1264,7008,-15351),
Vector(1331.670044,3165.219971,-15351),
Vector(1424.040039,3281.159912,-15351),
Vector(1516.420044,3397.100098,-15351),
Vector(5248,2944,-15351)],

//stage 4 rng:
[Vector(8448,3072,-15223),
Vector(9088,3072,-15223),
Vector(9440,3072,-15223),
Vector(9920,3072,-15223),
Vector(10400,3072,-15223),
Vector(10912,3200,-15223),
Vector(10912,2944,-15223),
Vector(11424,2880,-15223),
Vector(11424,3264,-15223),
Vector(11936,3264,-15223),
Vector(11936,2880,-15223),
Vector(12416,3264,-15096),
Vector(12416,2880,-15096),
Vector(14520.900391,2753.330078,-15045),
Vector(13983.799805,2761.360107,-14995.599609),
Vector(15039.299805,3613.229980,-15224),
Vector(15555.900391,3583.479980,-15224),
Vector(15872,3936,-15224),
Vector(15872,4448,-15224),
Vector(15872,4960,-15224),
Vector(15872,5472,-15224),
Vector(15872,5984,-15224),
Vector(15872,6496,-15224),
Vector(15872,7040,-15224),
Vector(15360,7040,-15224),
Vector(14848,7040,-15224),
Vector(14976,6528,-15224),
Vector(14592,6528,-15224),
Vector(14592,6016,-15224),
Vector(14976,6016,-15224),
Vector(14592,5504,-15224),
Vector(14976,5504,-15224),
Vector(14592,4992,-15224),
Vector(14976,4992,-15224),
Vector(14592,4480,-15224),
Vector(14976,4480,-15224),
Vector(13664,4512,-15224),
Vector(13664,5024,-15224),
Vector(13664,5536,-15224),
Vector(13664,6048,-15224),
Vector(13664,6560,-15224),
Vector(13664,7072,-15224),
Vector(13664,7584,-15224),
Vector(13792,7808,-15224),
Vector(14304,7808,-15224),
Vector(14816,7808,-15224),
Vector(15328,7808,-15224),
Vector(15840,7808,-15224),
Vector(15744,8320,-15224),
Vector(15680,8640,-15224),
Vector(15168,8480,-15224),
Vector(15168,8704,-15224),
Vector(14656,8480,-15224),
Vector(14656,8704,-15224),
Vector(14144,8480,-15224),
Vector(14144,8704,-15224),
Vector(11221.599609,8125.430176,-15175.700195),
Vector(11740.299805,8418.799805,-15145.400391),
Vector(11264,8537.190430,-15153.299805),
Vector(11528.099609,7488.180176,-15192),
Vector(11825.799805,6815.140137,-15208),
Vector(11710.799805,7169.399902,-15208),
Vector(11837.799805,6413.279785,-15192),
Vector(11769.299805,5984.740234,-15208),
Vector(11621.099609,5617.129883,-15208),
Vector(11300.299805,5313.180176,-15208),
Vector(10950.599609,5066.109863,-15208),
Vector(10496.700195,4904.729980,-15192),
Vector(10139.200195,4925.500000,-15208),
Vector(9702.639648,4897.770020,-15208),
Vector(9268.219727,5034.040039,-15192),
Vector(8900.500000,5138.259766,-15208),
Vector(8443.950195,5201.439941,-15208),
Vector(7946.899902,5275.479980,-15223),
Vector(8315.120117,5730.379883,-15223),
Vector(8571.410156,6166.040039,-15223),
Vector(8771.530273,6545.859863,-15223),
Vector(8828.669922,6996.879883,-15223),
Vector(8904.719727,7462.939941,-15223),
Vector(9091.030273,7876.950195,-15223),
Vector(9429.059570,8218.629883,-15223),
Vector(7939.299805,5597.129883,-15223),
Vector(7609.890137,5399.509766,-15223),
Vector(7200.330078,5393.479980,-15223),
Vector(6693.899902,5448.830078,-15223),
Vector(6355.919922,5596.029785,-15223),
Vector(6009.790039,5904.839844,-15223),
Vector(5822.850098,6282.100098,-15223),
Vector(5702.970215,6623.009766,-15223),
Vector(5652.370117,6938.080078,-15223),
Vector(5635.609863,7294.500000,-15223),
Vector(5494.899902,7676.830078,-15223),
Vector(5201.930176,7982.350098,-15223),
Vector(4858.750000,8283.780273,-15223),
Vector(4518.370117,8449.730469,-15223),
Vector(4117.490234,8522.049805,-15219),
Vector(3831.899902,8526.129883,-15150.799805),
Vector(7131.529785,5951.509766,-15306.099609),
Vector(6710,5984.939941,-15208),
Vector(6396.580078,6380.169922,-15208),
Vector(6715.330078,6253.589844,-15192.799805),
Vector(6434.660156,6054.100098,-15179.599609),
Vector(6082.810059,6648.839844,-15224),
Vector(2399.909912,8501.209961,-15207.500000),
Vector(2037.510010,8401.740234,-15223),
Vector(1681.420044,8176.049805,-15223),
Vector(1408.839966,7884.740234,-15223),
Vector(1205.380005,7542.549805,-15223),
Vector(1166.359985,7219.500000,-15223),
Vector(1143.189941,6852.379883,-15223),
Vector(1197.280029,6538.569824,-15223),
Vector(1260.920044,6186.529785,-15223),
Vector(1297.329956,5870.180176,-15223),
Vector(1269.150024,5528.040039,-15223),
Vector(1158.479980,5186.649902,-15223),
Vector(1060.270020,4864.189941,-15223),
Vector(1002.520020,4442.410156,-15223),
Vector(1056.329956,3998.600098,-15223),
Vector(1248.050049,3591.550049,-15223),
Vector(1524.150024,3284.760010,-15223),
Vector(1837.189941,3004.060059,-15223),
Vector(2178.010010,2892.840088,-15223),
Vector(2514.060059,2857.020020,-15223),
Vector(2902.590088,2860.469971,-15223),
Vector(3304.429932,2870.040039,-15223),
Vector(3698.209961,2930.310059,-15223),
Vector(4004.620117,3035.449951,-15223),
Vector(4385.819824,3168.729980,-15223),
Vector(4765.020020,3279.879883,-15223),
Vector(5131.250000,3359.520020,-15223),
Vector(5438.220215,3333.560059,-15223),
Vector(5817.580078,3274.570068,-15223),
Vector(6213.870117,3145.750000,-15223),
Vector(6614.439941,3067.610107,-15223),
Vector(7104,3072,-15223),
Vector(7584,3072,-15223),
Vector(7936,3072,-15223),
Vector(5472,5760,-15223),
Vector(4000,5536,-15223),
Vector(3520,5152,-15223),
Vector(3008,4960,-15223),
Vector(2464,4960,-15223),
Vector(1952,4992,-15223),
Vector(1536,4736,-15223),
Vector(1600,5248,-15223),
Vector(8608,3200,-14968)],

//stage 4 thwomps (+ angles):
[Vector(5664,7008,-15352),Vector(0,270,0),
Vector(14112,4416,-15352),Vector(0,0,0),
Vector(9472,2528,-15352),Vector(0,90,0)],

//stage 5 itemboxes:
[Vector(-10240,-2304,-14328),
Vector(-10240,-2432,-14328),
Vector(-10240,-2176,-14328),
Vector(-7776,-5472,-14328),
Vector(-7648,-5344,-14328),
Vector(-7520,-5216,-14328),
Vector(-5536,-3264,-14328),
Vector(-5376,-3264,-14328),
Vector(-5216,-3264,-14328),
Vector(-4731.479980,-78.289101,-14968),
Vector(-5024,1280,-15352),
Vector(-4864,1280,-15352),
Vector(-4704,1280,-15352),
Vector(-1722.599976,-77.281799,-15352),
Vector(-4192,3136,-15352),
Vector(-832,192,-15294.599609),
Vector(-640,192,-15294.599609),
Vector(-1024,192,-15294.599609),
Vector(-832,-2304,-14840),
Vector(-5456,-3072,-13688),
Vector(-5360,-3072,-13688),
Vector(-5264,-3072,-13688),
Vector(-5168,-3072,-13688),
Vector(-9216,-64,-13688),
Vector(-9216,-160,-13688),
Vector(-9008,-4032,-13688),
Vector(-9104,-4032,-13688),
Vector(-7040,-7008,-13304),
Vector(-7168,-7008,-13304),
Vector(-7296,-7008,-13304),
Vector(-11360,-7360,-14488.299805),
Vector(-15360,-5824,-14200),
Vector(-15232,-5824,-14200)],

//stage 5 rng:
[Vector(-11456,-2304,-14263),
Vector(-12448,-2144,-14263),
Vector(-12448,-2464,-14263),
Vector(-11968,-2304,-14263),
Vector(-10944,-2304,-14263),
Vector(-10432,-2304,-14263),
Vector(-9920,-2304,-14263),
Vector(-9408,-2304,-14263),
Vector(-8896,-2304,-14263),
Vector(-8384,-2304,-14263),
Vector(-7968,-2368,-14263),
Vector(-7680,-2752,-14263),
Vector(-7680,-3264,-14263),
Vector(-7680,-3776,-14263),
Vector(-8160,-2816,-14263),
Vector(-8672,-2688,-14263),
Vector(-8128,-3232,-14263),
Vector(-7680,-4288,-14263),
Vector(-7680,-4800,-14263),
Vector(-7584,-5184,-14263),
Vector(-7168,-5376,-14263),
Vector(-6656,-5376,-14263),
Vector(-6144,-5376,-14263),
Vector(-5632,-5376,-14263),
Vector(-5120,-5376,-14263),
Vector(-4832,-4864,-14263),
Vector(-5184,-5024,-14263),
Vector(-4832,-4352,-14263),
Vector(-4832,-3840,-14263),
Vector(-4832,-3328,-14263),
Vector(-4832,-2816,-14263),
Vector(-5376,-2528,-14263),
Vector(-5376,-3040,-14263),
Vector(-5376,-3552,-14263),
Vector(-5376,-4064,-14263),
Vector(-5376,-4576,-14263),
Vector(-7744,-5408,-14263),
Vector(-8000,-4512,-14263),
Vector(-8000,-5024,-14263),
Vector(-5376,-2016,-14263),
Vector(-5376,-1504,-14263),
Vector(-5376,-992,-14263),
Vector(-4864,-256,-14263),
Vector(-4352,-768,-14263),
Vector(-4864,-1280,-14551),
Vector(-5376,-768,-14679),
Vector(-4864,-256,-14775),
Vector(-4352,-768,-14903),
Vector(-4864,-1280,-15063),
Vector(-5376,-768,-15127),
Vector(-4864,512,-15287),
Vector(-4864,1024,-15287),
Vector(-4864,1536,-15287),
Vector(-4864,1856,-15287),
Vector(-5376,1856,-15287),
Vector(-5888,1856,-15287),
Vector(-6464,1856,-15287),
Vector(-6464,2368,-15287),
Vector(-6464,2880,-15287),
Vector(-6464,3136,-15287),
Vector(-5952,3136,-15287),
Vector(-5440,3136,-15287),
Vector(-4928,3136,-15287),
Vector(-4416,3136,-15287),
Vector(-4000,3136,-15191),
Vector(-960,2432,-15287),
Vector(-704,2432,-15287),
Vector(-960,1920,-15223),
Vector(-704,1920,-15223),
Vector(-704,1408,-15223),
Vector(-960,1408,-15223),
Vector(-704,896,-15223),
Vector(-960,896,-15223),
Vector(-704,384,-15223),
Vector(-960,384,-15223),
Vector(-704,-128,-15223),
Vector(-960,-128,-15223),
Vector(-704,-640,-15191),
Vector(-960,-640,-15191),
Vector(-960,-1472,-14775),
Vector(-704,-1472,-14775),
Vector(-1120,-2304,-14775),
Vector(-832,-1984,-14775),
Vector(-1792,-2304,-14455),
Vector(-2304,-2304,-14231),
Vector(-2816,-2304,-14007),
Vector(-3328,-2304,-13815),
Vector(-4672,-2304,-13623),
Vector(-4128,-2304,-13655),
Vector(-3680,-2304,-13815),
Vector(-5312,-2304,-13623),
Vector(-5312,-2816,-13623),
Vector(-5312,-3328,-13623),
Vector(-5312,-3840,-13623),
Vector(-5696,-3840,-13623),
Vector(-6080,-3840,-13623),
Vector(-6080,-3328,-13623),
Vector(-6080,-2816,-13623),
Vector(-6592,-2816,-13623),
Vector(-6976,-2496,-13623),
Vector(-7264,-2080,-13623),
Vector(-7648,-1664,-13623),
Vector(-8096,-1440,-13623),
Vector(-8480,-1280,-13623),
Vector(-8448,-960,-13623),
Vector(-8448,-640,-13623),
Vector(-8832,-256,-13623),
Vector(-9280,-256,-13623),
Vector(-9728,-256,-13623),
Vector(-10112,-640,-13623),
Vector(-10112,-1152,-13623),
Vector(-10048,-1664,-13527),
Vector(-10176,-1664,-13527),
Vector(-10176,-2176,-13527),
Vector(-10048,-2176,-13527),
Vector(-10176,-2688,-13527),
Vector(-10048,-2688,-13527),
Vector(-10144,-3200,-13527),
Vector(-9632,-3200,-13527),
Vector(-9408,-3520,-13527),
Vector(-9056,-3616,-13527),
Vector(-8960,-4128,-13527),
Vector(-8384,-5376,-13207),
Vector(-8352,-4896,-13207),
Vector(-7840,-4768,-13207),
Vector(-7680,-4320,-13207),
Vector(-7360,-4800,-13207),
Vector(-7136,-5312,-13207),
Vector(-7104,-5824,-13207),
Vector(-7168,-6336,-13207),
Vector(-7168,-6848,-13207),
Vector(-7360,-7360,-13207),
Vector(-7872,-7360,-13207),
Vector(-8384,-7360,-13239),
Vector(-8896,-7360,-13335),
Vector(-9408,-7360,-13463),
Vector(-9920,-7360,-13687),
Vector(-10432,-7360,-13879),
Vector(-10944,-7360,-14039),
Vector(-11424,-7360,-14039),
Vector(-11776,-7328,-14519),
Vector(-12288,-7328,-14519),
Vector(-12800,-7328,-14519),
Vector(-12640,-7040,-14519),
Vector(-12960,-6720,-14519),
Vector(-13472,-6720,-14519),
Vector(-13984,-6720,-14519),
Vector(-14496,-6720,-14519),
Vector(-14720,-6720,-14519),
Vector(-13312,-7328,-14423),
Vector(-13824,-7328,-14295),
Vector(-14336,-7328,-14199),
Vector(-14848,-7328,-14135),
Vector(-15296,-7296,-14135),
Vector(-15296,-6784,-14135),
Vector(-15296,-6272,-14135),
Vector(-15296,-5888,-14007),
Vector(-15296,-5440,-14007),
Vector(-15648,-6016,-14007),
Vector(-15648,-6528,-14007),
Vector(-15648,-6816,-14007),
Vector(-15264,-4544,-14263),
Vector(-15488,-4192,-14263),
Vector(-15136,-4096,-14263),
Vector(-15328,-3584,-14263),
Vector(-15328,-3072,-14263),
Vector(-15232,-2656,-14263),
Vector(-14880,-2432,-14263),
Vector(-14816,-2240,-14263),
Vector(-14336,-2144,-14263),
Vector(-14368,-2304,-14263),
Vector(-13856,-2368,-14263),
Vector(-13792,-2112,-14263),
Vector(-13600,-2304,-14263)],

//stage 5 thwomps (+ angles):
[Vector(-7680,-4384,-14328),Vector(0,90,0),
Vector(-6400,-5376,-14328),Vector(0,180,0),
Vector(-5248,-3072,-14328),Vector(0,270,0),
Vector(-5504,-3072,-14328),Vector(0,270,0),
Vector(-5376,-1280,-14328),Vector(0,270,0),
Vector(-5888,1856,-15352),Vector(0,0,0),
Vector(-832,-2304,-14840),Vector(0,90,0),
Vector(-7168,-6272,-13304),Vector(0,90,0),
Vector(-7168,-7232,-13304),Vector(0,90,0),
Vector(-14752,-6720,-14584),Vector(0,0,0)],

//stage 6 itemboxes:
[Vector(3328,-2816,-15352),
Vector(3200,-2944,-15352),
Vector(4032,-2112,-15352),
Vector(2272,-1760,-15160),
Vector(4384,-3872,-15160),
Vector(3136,-3008,-15160),
Vector(7104,-3008,-15160),
Vector(5856,-3872,-15160),
Vector(6912,-2816,-15352),
Vector(7040,-2944,-15352),
Vector(6208,-2112,-15352),
Vector(7968,-1760,-15160),
Vector(7104,960,-15160),
Vector(7968,-288,-15160),
Vector(6912,768,-15352),
Vector(7040,896,-15352),
Vector(6208,64,-15352),
Vector(5856,1824,-15160),
Vector(3136,960,-15160),
Vector(4384,1824,-15160),
Vector(3328,768,-15352),
Vector(3200,896,-15352),
Vector(4032,64,-15352),
Vector(2272,-288,-15160),
Vector(5120,-768,-14976),
Vector(5120,-1280,-14976),
Vector(5376,-1024,-14976),
Vector(4864,-1024,-14976)],

//stage 6 rng:
[Vector(2336,-768,-15287),
Vector(2336,-1248,-15287),
Vector(2848,-768,-15287),
Vector(3360,-768,-15287),
Vector(3680,-768,-15287),
Vector(3680,-1248,-15287),
Vector(3360,-1248,-15287),
Vector(2848,-1248,-15287),
Vector(2784,-1760,-15287),
Vector(3296,-1760,-15287),
Vector(3808,-1760,-15287),
Vector(2944,-2272,-15287),
Vector(3264,-2880,-15287),
Vector(3872,-3200,-15287),
Vector(4320,-2880,-15287),
Vector(4480,-2496,-15287),
Vector(4096,-2048,-15127),
Vector(3424,-2240,-15127),
Vector(3744,-2240,-15127),
Vector(4032,-2496,-15127),
Vector(3808,-2784,-15127),
Vector(3392,-2688,-15127),
Vector(3424,-3200,-15127),
Vector(2944,-2720,-15127),
Vector(2432,-1760,-15127),
Vector(2528,-2144,-15127),
Vector(2656,-2400,-15127),
Vector(2784,-2624,-15127),
Vector(3040,-2976,-15127),
Vector(3232,-3168,-15127),
Vector(3552,-3392,-15127),
Vector(3840,-3552,-15127),
Vector(4352,-3712,-15127),
Vector(4352,-3328,-15127),
Vector(6976,-2880,-15287),
Vector(7808,-1792,-15127),
Vector(7648,-2304,-15127),
Vector(7296,-2272,-15287),
Vector(7424,-1792,-15127),
Vector(6976,-1824,-15287),
Vector(6592,-1664,-15287),
Vector(6592,-2112,-15127),
Vector(6144,-2048,-15127),
Vector(6336,-2400,-15127),
Vector(6880,-2336,-15127),
Vector(6784,-2752,-15127),
Vector(7296,-2720,-15127),
Vector(7488,-2592,-15127),
Vector(6816,-3200,-15127),
Vector(7072,-3104,-15127),
Vector(7264,-2912,-15127),
Vector(6240,-3616,-15127),
Vector(6496,-3488,-15127),
Vector(6720,-3360,-15127),
Vector(5856,-3712,-15127),
Vector(6368,-3200,-15287),
Vector(6336,-2720,-15127),
Vector(5856,-2848,-15287),
Vector(5856,-3360,-15287),
Vector(5344,-3808,-15287),
Vector(4864,-3808,-15287),
Vector(4864,-3296,-15287),
Vector(5344,-3296,-15287),
Vector(5344,-2464,-15287),
Vector(4864,-2784,-15287),
Vector(4864,-2464,-15287),
Vector(5344,-2784,-15287),
Vector(5856,-2336,-15287),
Vector(2336,-1024,-15127),
Vector(5120,-3808,-15127),
Vector(5120,1760,-15127),
Vector(3264,832.000977,-15287),
Vector(2432,-255.998993,-15127),
Vector(2592,256.001007,-15127),
Vector(2944,224.001007,-15287),
Vector(2816,-255.998993,-15127),
Vector(3264,-223.998993,-15287),
Vector(3648,-383.998993,-15287),
Vector(3648,64.000504,-15127),
Vector(4096,0.000488,-15127),
Vector(3904,352.001007,-15127),
Vector(3360,288.001007,-15127),
Vector(3456,704.000977,-15127),
Vector(2944,672.000977,-15127),
Vector(2752,544.000977,-15127),
Vector(3424,1152,-15127),
Vector(3168,1056,-15127),
Vector(2976,864.000977,-15127),
Vector(4000,1568,-15127),
Vector(3744,1440,-15127),
Vector(3520,1312,-15127),
Vector(4384,1664,-15127),
Vector(3872,1152,-15287),
Vector(3904,672.000977,-15127),
Vector(4384,800,-15287),
Vector(4384,1312,-15287),
Vector(4896,1760,-15287),
Vector(5376,1760,-15287),
Vector(5376,1248,-15287),
Vector(4896,1248,-15287),
Vector(4896,416,-15287),
Vector(5376,736,-15287),
Vector(5376,416,-15287),
Vector(4896,736,-15287),
Vector(4384,288,-15287),
Vector(7904,-1024,-15127),
Vector(6976,832,-15287),
Vector(5888,1664,-15127),
Vector(6400,1504,-15127),
Vector(6368,1152,-15287),
Vector(5888,1280,-15127),
Vector(5920,832,-15287),
Vector(5760,448,-15287),
Vector(6208,448,-15127),
Vector(6144,0.000122,-15127),
Vector(6496,192,-15127),
Vector(6432,736,-15127),
Vector(6848,640,-15127),
Vector(6816,1152,-15127),
Vector(6688,1344,-15127),
Vector(7296,672,-15127),
Vector(7200,928,-15127),
Vector(7008,1120,-15127),
Vector(7712,96,-15127),
Vector(7584,352,-15127),
Vector(7456,576,-15127),
Vector(7808,-288,-15127),
Vector(7296,224,-15287),
Vector(6816,192,-15127),
Vector(6944,-288,-15287),
Vector(7456,-288,-15287),
Vector(7904,-800,-15287),
Vector(7904,-1280,-15287),
Vector(7392,-1280,-15287),
Vector(7392,-800,-15287),
Vector(6560,-800,-15287),
Vector(6880,-1280,-15287),
Vector(6560,-1280,-15287),
Vector(6880,-800,-15287),
Vector(6432,-288,-15287)],

//stage 8 itemboxes:
[Vector(-15456,6784,-14328),
Vector(-15648,6784,-14328),
Vector(-15840,6784,-14328),
Vector(-9216,7744,-15480),
Vector(-9216,7936,-15480),
Vector(-9216,8128,-15480),
Vector(-14336,11264,-15480),
Vector(-14336,11456,-15480),
Vector(-14336,11648,-15480),
Vector(-7616,11616,-15608),
Vector(-7808,11616,-15608),
Vector(-8000,11616,-15608),
Vector(-8192,11616,-15608),
Vector(-8384,11616,-15608),
Vector(-1344,12960,-15144),
Vector(-1536,12960,-15144),
Vector(-1728,12960,-15144),
Vector(-4544,7424,-14776),
Vector(-4736,7424,-14776),
Vector(-4928,7424,-14776),
Vector(-3675,14427,-15144),
Vector(-3811,14563,-15144),
Vector(-12464,9912,-15377),
Vector(-10552,9736,-15256),
Vector(-8604,9912,-15128),
Vector(-6516,9736,-14992),
Vector(-800,9088,-15432),
Vector(-928,9216,-15432),
Vector(-1056,9344,-15432),
Vector(-10368,5664,-15096),
Vector(-10368,5280,-15096),
Vector(-11648,5472,-15060),
Vector(-12944,5264,-14818),
Vector(-12944,5648,-14818)],

//stage 8 thwomps:
[Vector(-8192,5904,-15096),Vector(0,0,0),
Vector(-8192,5616,-15096),Vector(0,0,0),
Vector(-8192,5328,-15096),Vector(0,0,0),
Vector(-8192,5040,-15096),Vector(0,0,0)],

//stage 8 rng:
[Vector(-13056,7936,-14304),
Vector(-13568,7936,-14304),
Vector(-14080,7936,-14304),
Vector(-14592,7936,-14304),
Vector(-15104,7872,-14304),
Vector(-15488,7680,-14304),
Vector(-15648,7232,-14304),
Vector(-15648,6720,-14304),
Vector(-15616,6208,-14304),
Vector(-15520,5792,-14304),
Vector(-15232,5568,-14304),
Vector(-14816,5472,-14304),
Vector(-14304,5472,-14304),
Vector(-13792,5472,-14432),
Vector(-13280,5472,-14624),
Vector(-12768,5472,-14784),
Vector(-12256,5472,-14912),
Vector(-11744,5472,-15008),
Vector(-11232,5472,-15072),
Vector(-10720,5472,-15072),
Vector(-10208,5472,-15072),
Vector(-9696,5728,-15072),
Vector(-9696,5216,-15072),
Vector(-9184,5216,-15072),
Vector(-9184,5728,-15072),
Vector(-8672,5216,-15072),
Vector(-8672,5728,-15072),
Vector(-8160,5216,-15072),
Vector(-8160,5728,-15072),
Vector(-7648,5216,-15072),
Vector(-7648,5728,-15072),
Vector(-7136,5216,-15072),
Vector(-7136,5728,-15072),
Vector(-6624,5216,-15072),
Vector(-6624,5728,-15072),
Vector(-12544,7936,-14352),
Vector(-12032,7936,-14512),
Vector(-11520,7936,-14800),
Vector(-11008,7936,-15152),
Vector(-10496,7936,-15376),
Vector(-9984,7936,-15456),
Vector(-9472,7936,-15456),
Vector(-8960,7968,-15456),
Vector(-8448,8064,-15456),
Vector(-8128,8320,-15456),
Vector(-7936,8704,-15456),
Vector(-7872,9216,-15456),
Vector(-7872,9728,-15456),
Vector(-7872,10240,-15456),
Vector(-8128,10752,-15584),
Vector(-7616,10752,-15584),
Vector(-7616,11264,-15584),
Vector(-8128,11264,-15584),
Vector(-7616,11776,-15584),
Vector(-8128,11776,-15584),
Vector(-7616,12288,-15584),
Vector(-8128,12288,-15584),
Vector(-7616,12800,-15584),
Vector(-8128,12800,-15584),
Vector(-7616,13312,-15584),
Vector(-8128,13312,-15584),
Vector(-8544,12864,-15584),
Vector(-8992,13120,-15584),
Vector(-9504,13120,-15584),
Vector(-8544,13120,-15584),
Vector(-9664,13120,-15584),
Vector(-11200,13120,-15456),
Vector(-11712,13120,-15456),
Vector(-12224,13120,-15456),
Vector(-12672,13056,-15456),
Vector(-12960,12800,-15456),
Vector(-13056,12512,-15456),
Vector(-13120,12064,-15456),
Vector(-13248,11712,-15456),
Vector(-13600,11488,-15456),
Vector(-14112,11456,-15456),
Vector(-14624,11456,-15456),
Vector(-15136,11392,-15456),
Vector(-15456,11232,-15456),
Vector(-15584,10944,-15456),
Vector(-15584,10432,-15456),
Vector(-15456,10048,-15456),
Vector(-15104,9888,-15456),
Vector(-14592,9824,-15456),
Vector(-14080,9824,-15456),
Vector(-12384,10016,-15200),
Vector(-11968,9632,-15168),
Vector(-11488,10016,-15136),
Vector(-10912,9664,-15136),
Vector(-10304,10016,-15072),
Vector(-9568,9664,-15040),
Vector(-9024,9760,-15008),
Vector(-8416,10016,-14880),
Vector(-7872,9696,-14944),
Vector(-8384,9664,-14976),
Vector(-7296,9984,-14880),
Vector(-7776,10016,-14880),
Vector(-6784,9728,-14848),
Vector(-6656,9984,-14816),
Vector(-7360,9632,-14880),
Vector(-8768,9600,-14944),
Vector(-9536,10016,-14976),
Vector(-10112,9632,-15040),
Vector(-10528,9664,-15104),
Vector(-9952,10016,-15040),
Vector(-10880,10016,-15104),
Vector(-11424,9632,-15136),
Vector(-11936,10016,-15168),
Vector(-12608,9632,-15200),
Vector(-6112,5472,-15000),
Vector(-5600,5536,-15000),
Vector(-5184,5696,-15000),
Vector(-4928,5984,-15000),
Vector(-4768,6336,-15000),
Vector(-4736,6528,-15000),
Vector(-4736,7456,-14752),
Vector(-4736,7968,-14752),
Vector(-4736,8480,-14752),
Vector(-4736,8992,-14720),
Vector(-4736,9504,-14720),
Vector(-4736,10016,-14720),
Vector(-4736,10528,-14784),
Vector(-4736,11040,-14976),
Vector(-4736,11552,-15072),
Vector(-4736,12064,-15120),
Vector(-4704,12576,-15120),
Vector(-3872,13408,-15120),
Vector(-3840,13920,-15120),
Vector(-3744,14304,-15120),
Vector(-3488,14592,-15120),
Vector(-2976,14656,-15120),
Vector(-2464,14624,-15120),
Vector(-1984,14432,-15120),
Vector(-1696,14112,-15120),
Vector(-1568,13600,-15120),
Vector(-1536,13088,-15120),
Vector(-1536,12576,-15136),
Vector(-1536,12064,-15232),
Vector(-1536,11552,-15392),
Vector(-1536,11040,-15408),
Vector(-1120,10688,-15408),
Vector(-800,10368,-15408),
Vector(-608,9920,-15408),
Vector(-672,9440,-15408),
Vector(-960,9120,-15408),
Vector(-1344,8896,-15408),
Vector(-1856,8928,-15408),
Vector(-2144,9152,-15408),
Vector(-2400,9536,-15408),
Vector(-2432,10048,-15408),
Vector(-2176,10432,-15408),
Vector(-1792,10720,-15408),
Vector(-1536,10304,-15408),
Vector(-1056,10048,-15408),
Vector(-1120,9504,-15408),
Vector(-1632,9376,-15408),
Vector(-2016,9568,-15408),
Vector(-1952,10016,-15408),
Vector(-2784,9728,-15408),
Vector(-2784,9920,-15408),
Vector(-3296,9920,-15408),
Vector(-3296,9728,-15408),
Vector(-5184,10080,-15136),
Vector(-5184,9568,-15136),
Vector(-4672,9824,-15200),
Vector(-4160,9824,-15328),
Vector(-3648,9824,-15360),
Vector(-5696,10080,-14976),
Vector(-5696,9568,-14976)]
];

finalerubblehandle <- null;
function SetFinaleRubble(){finalerubblehandle=caller;}
finaleboxeshandle <- null;
function SetFinaleBoxes(){finaleboxeshandle=caller;}
finalerubblespawn <- true;
function TickFinaleRubble()
{
	if(!finalerubblespawn)return;
	EntFireByHandle(self,"RunScriptCode"," TickFinaleRubble(); ",RandomFloat(0.03,0.20),null,null);
	if(finalerubblehandle!=null&&finalerubblehandle.IsValid())
		finalerubblehandle.SpawnEntityAtLocation(finalespawn_breaks[RandomInt(0,(finalespawn_breaks.len()-1))],Vector(0,RandomInt(0,259),0));
}
function SpawnFinaleBoxes()
{
	for(local i=0;i<finalespawn_itembox.len();i++)
	{
		finaleboxeshandle.SpawnEntityAtLocation(finalespawn_itembox[i],Vector(0,0,0));
	}
}

//ITEMBOXES:
finalespawn_itembox <- [Vector(3296.110107,10562.599609,-14840.000000),
Vector(3107.379883,10454.900391,-14840.000000),
Vector(2880.399902,10321.000000,-14840.000000),
Vector(2651.520020,10180.000000,-14840.000000),
Vector(4416.350098,10021.000000,-14840.000000),
Vector(4420.560059,9746.299805,-14840.000000),
Vector(4420.240234,9450.769531,-14840.000000),
Vector(5308.020020,10043.500000,-14840.000000),
Vector(5365.279785,9817.139648,-14840.000000),
Vector(7205.689941,10939.700195,-14840.000000),
Vector(7180.419922,10697.000000,-14840.000000),
Vector(7158.819824,10451.000000,-14840.000000),
Vector(7131.279785,10216.900391,-14840.000000),
Vector(5460.189941,12461.700195,-14840.000000),
Vector(5792.000000,12480.000000,-14840.000000),
Vector(4848.000000,11952.000000,-14840.000000),
Vector(4789.490234,11534.900391,-14840.000000),
Vector(3770.830078,13381.400391,-14840.000000),
Vector(3356.030029,13510.500000,-14840.000000),
Vector(2976.050049,13380.900391,-14840.000000),
Vector(2753.820068,13128.700195,-14840.000000),
Vector(2811.699951,12762.400391,-14840.000000),
Vector(3073.090088,12460.700195,-14840.000000),
Vector(3498.550049,12416.000000,-14840.000000),
Vector(3890.949951,12591.000000,-14840.000000),
Vector(3936.000000,13025.000000,-14840.000000),
Vector(2811.620117,11669.099609,-14840.000000),
Vector(2579.560059,11734.200195,-14840.000000),
Vector(2361.679932,11794.700195,-14840.000000),
Vector(5862.580078,14054.900391,-14840.000000),
Vector(5981.419922,13840.700195,-14840.000000),
Vector(6144.000000,13568.000000,-14840.000000),
Vector(6277.720215,13318.900391,-14840.000000)];

//ROCK:
finalespawn_breaks <- [Vector(-12852.799805,14979.299805,-15467.599609),
Vector(-12536.599609,14736.500000,-15457.700195),
Vector(-12185.000000,14890.799805,-15432.000000),
Vector(-11639.799805,14704.500000,-15473.700195),
Vector(-11836.799805,15008.900391,-15482.400391),
Vector(-11150.299805,14727.299805,-14344.000000),
Vector(-10830.000000,14989.700195,-14344.000000),
Vector(-10339.500000,14758.599609,-14344.000000),
Vector(-10004.799805,14847.599609,-14344.000000),
Vector(-9248.650391,14958.799805,-14344.000000),
Vector(-9587.750000,14746.099609,-14344.000000),
Vector(-8836.929688,14793.400391,-14344.000000),
Vector(-8609.440430,15043.799805,-14344.000000),
Vector(-8018.790039,15121.799805,-14344.000000),
Vector(-7762.439941,15443.299805,-14344.000000),
Vector(-7419.700195,15651.900391,-14344.000000),
Vector(-7001.720215,15538.799805,-14344.000000),
Vector(-6837.689941,15792.400391,-14344.000000),
Vector(-6429.200195,15565.700195,-14344.000000),
Vector(-6206.470215,15834.900391,-14344.000000),
Vector(-5832.790039,15620.599609,-14344.000000),
Vector(-5208.500000,15826.700195,-14344.000000),
Vector(-4599.350098,15632.799805,-14344.000000),
Vector(-4294.040039,15859.799805,-14344.000000),
Vector(-3899.979980,15649.200195,-14344.000000),
Vector(-3549.060059,15848.700195,-14344.000000),
Vector(-2910.320068,15762.700195,-14344.000000),
Vector(-2213.800049,15606.400391,-14344.000000),
Vector(-1786.229980,15824.799805,-14344.000000),
Vector(-1341.290039,15637.400391,-14344.000000),
Vector(-997.169006,15838.400391,-14344.000000),
Vector(-609.513000,15645.599609,-14344.000000),
Vector(-675.250000,15887.299805,-14344.000000),
Vector(-155.388000,15820.799805,-14344.000000),
Vector(106.567001,15579.200195,-14344.000000),
Vector(459.802002,15687.200195,-14344.000000),
Vector(722.320984,15340.900391,-14344.000000),
Vector(1108.650024,15354.000000,-14344.000000),
Vector(1595.810059,14867.500000,-14344.000000),
Vector(2006.660034,14925.599609,-14344.000000),
Vector(2618.389893,14724.700195,-14375.700195),
Vector(3088.189941,14970.799805,-14375.400391),
Vector(3896.389893,14911.599609,-14345.799805),
Vector(4387.899902,14674.400391,-14400.799805),
Vector(3418.479980,14739.299805,-14368.299805),
Vector(4535.979980,14950.400391,-14365.200195),
Vector(4726.310059,14722.000000,-14377.000000),
Vector(5082.330078,14942.700195,-14361.400391),
Vector(5333.919922,14741.400391,-14367.299805),
Vector(5726.419922,14969.400391,-14374.700195),

//METAL:
Vector(3029.860107,12152.000000,-15162.099609),
Vector(3651.320068,11935.500000,-14984.000000),
Vector(3990.850098,12155.200195,-14984.000000),
Vector(3484.219971,12172.099609,-14984.000000),
Vector(3827.639893,10058.200195,-14984.000000),
Vector(3557.350098,9456.450195,-14984.000000),
Vector(3882.909912,9435.570313,-14984.000000),
Vector(3568.000000,9773.400391,-14984.000000),
Vector(3206.520020,9956.849609,-14984.000000),
Vector(3103.840088,9451.759766,-14984.000000),
Vector(2853.800049,9776.660156,-14984.000000),
Vector(2688.500000,10082.099609,-14984.000000),
Vector(2757.929932,9391.230469,-14984.000000),
Vector(2574.850098,9590.580078,-14984.000000),
Vector(2285.169922,9985.469727,-14984.000000),
Vector(2277.110107,9392.799805,-14984.000000),
Vector(1668.420044,10020.599609,-14152.000000),
Vector(1684.479980,9406.629883,-14152.000000),
Vector(1672.880005,9698.759766,-14152.000000),
Vector(1211.489990,10121.900391,-13448.000000),
Vector(1195.650024,9768.200195,-13448.000000),
Vector(1215.189941,9364.900391,-13448.000000),
Vector(311.083008,10555.500000,-13320.000000),
Vector(550.536987,10580.700195,-13320.000000),
Vector(832.893982,10604.099609,-13320.000000),
Vector(698.081970,10261.700195,-12552.000000),
Vector(437.791992,10326.500000,-12552.000000),
Vector(395.829010,11040.200195,-13832.000000),
Vector(619.440979,11118.299805,-13832.000000),
Vector(899.825989,11058.299805,-13832.000000),
Vector(908.992004,12066.500000,-14472.000000),
Vector(690.052979,12121.500000,-14472.000000),
Vector(373.054993,12099.900391,-14472.000000),
Vector(876.210999,12326.099609,-12808.000000),
Vector(638.388977,12378.200195,-12808.000000),
Vector(351.427002,12341.200195,-12808.000000),
Vector(346.009003,13151.299805,-13320.000000),
Vector(667.955017,13165.099609,-13320.000000),
Vector(848.833008,13088.099609,-13320.000000),
Vector(900.023010,14183.000000,-12808.000000),
Vector(586.986023,14242.200195,-12808.000000),
Vector(315.212006,14198.000000,-12808.000000),
Vector(648.801025,13453.700195,-11272.000000),
Vector(339.194000,13732.900391,-11272.000000),
Vector(739.231018,12500.400391,-11272.000000),
Vector(366.266998,12797.099609,-11272.000000),
Vector(683.492981,11748.599609,-11272.000000),
Vector(365.526001,11584.400391,-11272.000000),
Vector(650.520996,11202.900391,-11272.000000),
Vector(685.650024,10005.099609,-11272.000000),
Vector(5538.850098,15618.400391,-14344.000000),
Vector(5436.100098,15750.299805,-14344.000000),
Vector(5376.189941,15606.400391,-14344.000000),
Vector(5565.049805,15768.700195,-14344.000000),
Vector(5112.270020,15601.099609,-15624.000000),
Vector(4662.040039,15827.900391,-15624.000000),
Vector(4182.680176,15614.099609,-15624.000000),
Vector(3858.580078,15734.900391,-15624.000000),
Vector(3012.780029,15833.900391,-15624.000000),
Vector(2653.699951,15569.500000,-15624.000000),
Vector(2168.439941,15860.299805,-15624.000000),
Vector(1666.739990,15652.200195,-15624.000000),
Vector(4691.080078,15991.400391,-15815.400391),
Vector(4874.140137,15474.900391,-15837.099609),
Vector(4055.070068,15494.900391,-15817.099609),
Vector(3906.479980,16019.900391,-15843.900391),
Vector(3106.239990,16008.400391,-15832.400391),
Vector(3470.889893,15472.400391,-15839.599609),
Vector(2532.729980,15524.099609,-15787.900391),
Vector(2157.560059,16028.700195,-15852.700195),
Vector(1724.729980,15436.000000,-15876.000000),
Vector(1138.489990,15872.500000,-15976.000000),
Vector(423.816010,15670.599609,-15976.000000),
Vector(-339.761993,15926.200195,-15976.000000),
Vector(-1004.429993,15659.900391,-15976.000000),
Vector(-928.174011,15862.500000,-15976.000000),
Vector(-1798.400024,15638.900391,-15976.000000),
Vector(-1827.859985,15842.299805,-15976.000000),
Vector(-2920.719971,15784.599609,-15976.000000),
Vector(-3453.590088,15654.700195,-15976.000000),
Vector(-4324.089844,15932.799805,-15976.000000),
Vector(-4578.720215,15688.500000,-15976.000000),
Vector(-4878.160156,15874.200195,-15976.000000),
Vector(-5706.890137,15660.099609,-15976.000000),
Vector(-6194.339844,15943.200195,-15976.000000),
Vector(-6800.359863,15683.200195,-15976.000000),
Vector(-7480.700195,15887.700195,-15976.000000),
Vector(-8435.379883,15592.200195,-15976.000000),
Vector(-9091.980469,15878.400391,-15976.000000),
Vector(-9801.910156,15689.900391,-15976.000000),
Vector(-10711.500000,15859.299805,-15976.000000),
Vector(-12135.500000,15677.000000,-15976.000000),
Vector(-12621.599609,15896.400391,-15976.000000),
Vector(-13066.299805,15659.000000,-15976.000000),
Vector(-13583.900391,14891.500000,-15944.000000),
Vector(-14342.700195,14687.500000,-15944.000000),
Vector(-14662.500000,15116.400391,-15944.000000),
Vector(-14434.099609,15387.700195,-15944.000000),
Vector(-14427.000000,15876.400391,-15944.000000),
Vector(-14674.000000,15967.200195,-15944.000000),
Vector(-14863.799805,15699.299805,-15944.000000),
Vector(-15084.099609,15957.500000,-15944.000000),
Vector(-15325.700195,15735.400391,-15944.000000),
Vector(-15401.400391,15855.099609,-15944.000000),
Vector(-13705.599609,15496.099609,-15944.000000),
Vector(-13547.000000,15191.299805,-15944.000000)];

function GetItemTier(playerclass)//1=first, 2=mid, 3=last
{
	if(playerclass.raceplacement==0||RACEPLACEMENT_MAX<=1)
		return 2;
	local percentage = ((playerclass.raceplacement) * 100) / (RACEPLACEMENT_MAX);
	if(percentage <= ITEM_TIER_FIRST)
		return 1;
	else if(percentage >= ITEM_TIER_LAST)
		return 3;
	else
		return 2;
}

function UpdateRacePlacement()
{
	EntFireByHandle(self,"RunScriptCode"," UpdateRacePlacement(); ",RACEPLACEMENT_UPDATE_RATE,null,null);
	local placegroup = [];
	for(local i=0;i<PLAYERS.len();i++)
	{
		if(PLAYERS[i].handle==null||!PLAYERS[i].handle.IsValid()||PLAYERS[i].handle.GetHealth()<=0||PLAYERS[i].last_checkpoint_pos==null||PLAYERS[i].kart==null||PLAYERS[i].lastround_place!=0)
		{
			PLAYERS[i].raceplacement = 0;
			continue;
		}
		PLAYERS[i].raceplacedist = ((PLAYERS[i].checkpoint*1000)+(PLAYERS[i].lap*10000)+((GetDistance(PLAYERS[i].last_checkpoint_pos,PLAYERS[i].handle.GetOrigin()))/100));
		local exist = false;
		for(local j=0;j<placegroup.len();j++)
		{
			if(PLAYERS[i].raceplacedist <= placegroup[j].raceplacedist)
			{
				exist = true;
				placegroup.insert(j,PLAYERS[i]);
				break;
			}
		}
		if(!exist)
			placegroup.push(PLAYERS[i]);
	}
	local newplace = PLAYERS_FINISHED;
	//printl("===============[STARTING PLACEMENT CHECK]===============");
	for(local i=(placegroup.len()-1);i>=0;i--)
	{
			newplace++;
			placegroup[i].raceplacement = newplace;
			//printl("GROUP "+i+" ("+placegroup.len()+")  >  "+placegroup[i].name+" | LAP:"+placegroup[i].lap+" | CP:"+placegroup[i].checkpoint+" | dist:"+placegroup[i].raceplacedist+" | placing:"+newplace);
	}
	//printl("===============[ENDING PLACEMENT CHECK]===============");
	RACEPLACEMENT_MAX = newplace;
	placegroup.clear();
	placegroup = null;
}

//====================================================\\
function PlayerChat(userid,text)
{
	if(text.find("!kartcolor")==0)
	{
		local c = GetPlayerClassByUserID(userid);
		if(c==null||c.handle==null||!c.handle.IsValid())return;
		local ptext=split(text," ");if(ptext.len()<4){c.kartcolor=null;return;}
		local kc_r = ptext[1].tointeger();local kc_g = ptext[2].tointeger();local kc_b = ptext[3].tointeger();
		if(kc_r==null||kc_g==null||kc_b==null){c.kartcolor=null;return;}
		c.kartcolor = Vector(kc_r,kc_g,kc_b);
	}
	else if(text.find("!boom")==0)
	{
		if(inspawnhub||!allowboom)return;
		local c = GetPlayerClassByUserID(userid);
		if(c==null||c.handle==null||!c.handle.IsValid()||!c.boom)return;
		if(c.kart==null)
		{
			local porg = c.handle.GetOrigin()+Vector(0,0,16);
			local kexh = Entities.FindByName(null,"s_kartexplosion_maker");
			kexh.SpawnEntityAtLocation(porg,Vector(0,RandomInt(0,359),0));
			if(MASTER!=null&&c.userid==MASTER)return;
			c.boom = false;
			EntFireByHandle(self,"RunScriptCode"," ResetBoom("+userid.tostring()+"); ",BOOM_COMMAND_COOLDOWN,null,null);
		}
	}
	else if(text.find("!kartcam")==0)
	{
		local c = GetPlayerClassByUserID(userid);
		if(c==null)return;
		c.thirdpersonpref = !c.thirdpersonpref;
		if(c.handle!=null&&c.handle.IsValid()&&c.handle.GetHealth()>0)
		{
			if(c.thirdpersonpref)EntFire("text_3rdperson","Display","",0.00,c.handle);
			else EntFire("text_1stperson","Display","",0.00,c.handle);
		}
		if(c.kart!=null&&c.kart.IsValid())
		{
			EntFireByHandle(c.kart,"RunScriptCode"," thirdpersonpref = "+c.thirdpersonpref.tostring()+"; ",0.00,null,null);
			EntFireByHandle(c.kart,"RunScriptCode"," SetPrefPerson(); ",0.02,null,null);
		}
	}
	else if(text=="oh daddy luffaren i beg you to plow my tender loins")
	{
		local c = GetPlayerClassByUserID(userid).handle;
		if(c!=null&&c.IsValid()&&c.GetClassname()=="player"&&c.GetTeam()==3&&c.GetHealth()>0)
			EntFireByHandle(c,"SetHealth",(c.GetHealth()+1).tostring(),0.00,null,null);
	}
}
//==========================================================================\\
//   Manager script by Luffaren (STEAM_1:1:22521282)						\\
//   (PUT THIS IN: csgo/scripts/vscripts/luffaren/)							\\
//--------------------------------------------------------------------------\\
// PLAYERS 			<--- array that contains all Player classes				\\
// VIPS 			<--- array that contains all Vip steamID's				\\
// VIP_SOUNDS 		<--- array that contains all Vip sounds to play			\\
//--------------------------------------------------------------------------\\
//  [FUNCTIONS]
//> GetPlayerClassByUserID(userid)							--	returns playerclass from userid						(int)
//> GetPlayerClassBySteamID(steamid)						--	returns playerclass from steamid					(string)
//> GetPlayerClassByHandle(handle)							--	returns playerclass from handle						(handle)
//> GetPlayerClassByName(name)								--	returns playerclass from name						(string)
//> IsVip(handle=null,fireuser=false)*null=activator* 		--	returns if player is VIP or not						(bool + fireuser1/2 to !caller if true, 1=true/2=false)
//> RetryRegister(all_players)                     			--  mark player(s) for re-registration *bool*			(void)
//> TextSign(text,size,r,g,b)           					-- 	add textsign over !activator head   				(void)
//> SpriteTrail(size,time,r,g,b)        					-- 	add spritetrail at !activator (VIP_TRAIL_Z_OFFSET)  (void)
//> SetFov(fov,returntime,all)								-- 	set activator/all FOV+returntime    				(void)
//> PlaySound(sound,all,pos=null)       					--  play sound from pos/activator or all "*SF/SN.mp3"	(void)
//> PlayClientSound(sound)									--	play sound for client (!activator) only				(void)
//> PlayMusic(sound,looptime=null,fadetime=null)    		--  play music with auto-loop options "*SF/SN.mp3"		(int: index, null if looptime==null)
//> StopMusic(index,fadetime=null)                  		--  stops music+loop, if index==null it clears all      (void)
//> SetFog(r,g,b,start,end,blend)							--	sets fog color/distance (+enable/disable blend)		(void)
//> SetFogTarget(r,g,b,start,end,speed,speedcolor)  		--	sets fog color/distance target + starts ticking 	(void)
//==========================================================================\\
//    GLOBAL SETTINGS     													\\
//--------------------------------------------------------------------------\\
MASTERSPRITE <- true;				//enables/disables master sprite
CLEAN_WEAPONS <- true;				//cleans/removes dropped weapons in the world
NEWROUND_RESET_OVERLAY <- true;		//resets players "r_screenoverlay" on new round (to nothing)
NEWROUND_RESET_FIRE <- false;		//resets players on fire on new round (can sometimes render short fire effect?)
NEWROUND_RESET_TARGETNAME <- true;	//resets players targetname on new round (to "player_normal")
BLOOMSCALE <- 1.0;					//sets the tonemap controller "bloomscale" to this on round start
BLOOMSCALE_ROUNDEND_RESET <- false; //resets the active "bloomscale" to 1.0 on round end
VIP_TRAIL_Z_OFFSET <- 32;			//height of VIP-trail when parented to player (5=feet, 32=pelvis)
SOUNDBUFFER_NORMAL <- 5;			//amount of sounds in the pool (touch this if adding/removing sound ents)
SOUNDBUFFER_ALL <- 8;				//amount of sounds in the pool (touch this if adding/removing sound ents)
SOUNDBUFFER_MUSIC <- 4;				//amount of sounds in the pool (touch this if adding/removing sound ents)
//==========================================================================\\
//    ADMIN MENU (BUTTONPRESSER IS ACTIVATOR)    							\\
//--------------------------------------------------------------------------\\
M_ADMINMENU<-[	"ADMIN_1();"	,"DESCRIPTION_1",
				"ADMIN_2();"	,"DESCRIPTION_2",
				"ADMIN_3();"	,"DESCRIPTION_3",
				"ADMIN_4();"	,"DESCRIPTION_4",
				"ADMIN_5();"	,"DESCRIPTION_5"];
function ADMIN_1(){}
function ADMIN_2(){}
function ADMIN_3(){}
function ADMIN_4(){}
function ADMIN_5(){}
//==========================================================================\\
//    VIP STEAMID LIST     													\\
//--------------------------------------------------------------------------\\
VIPS	<-     ["STEAM_1:1:22521282",		//Luffaren
			   "STEAM_0:1:11715703",		//Enviolinador
			   "STEAM_1:1:11715703",		//Enviolinador
               "STEAM_0:0:45564798",		//Snowy
               "STEAM_1:0:45564798",		//Snowy
               "STEAM_0:1:32440363",		//Syoudous
               "STEAM_1:1:32440363",		//Syoudous
               "STEAM_0:0:5225233",			//Kaemon
               "STEAM_1:0:5225233",			//Kaemon
               "STEAM_0:1:523970",			//Dillinger
               "STEAM_1:1:523970",			//Dillinger
               "STEAM_1:0:51138139",		//Loan
               "STEAM_1:1:51138139",		//Loan
			   "STEAM_1:1:73344846",		//Vauff
			   "STEAM_1:0:73344846",		//Vauff
			   "STEAM_1:1:31574014",		//Mojonero
			   "STEAM_1:0:31574014",		//Mojonero
			   "STEAM_0:1:31574014",		//Mojonero
			   "STEAM_1:0:125601478",
			   "STEAM_1:1:2359822",
			   "STEAM_1:0:172566566",
			   "STEAM_1:1:21998731",
			   "STEAM_1:1:3805781",
			   "STEAM_1:1:186689840",
			   "STEAM_1:0:20719874",
			   "STEAM_1:0:60172513",
			   "STEAM_1:0:69816039",
			   "STEAM_1:1:43037051",
			   "STEAM_1:0:40225637",
			   "STEAM_1:1:161646505",
			   "STEAM_1:0:12218767",
			   "STEAM_1:1:90927558",
			   "STEAM_1:1:36935027",
			   "STEAM_1:1:23249841",
			   "STEAM_1:0:48139771",
			   "STEAM_1:1:153776903",
			   "STEAM_1:1:24484161",
			   "STEAM_1:1:22564477",
			   "STEAM_1:0:36561009",
			   "STEAM_1:0:34155146",
			   "STEAM_1:1:44846771"];
//==========================================================================\\
//    VIP SOUND LIST (FOR !VIPSOUND)    									\\
//--------------------------------------------------------------------------\\
VIP_SOUNDS<-[//"*SOUNDFOLDER/SOUNDNAME.mp3",
"*luffaren_crazykart/schwing.mp3",
"*luffaren_crazykart/omar_laser.mp3",
"*luffaren_crazykart/kart_banana.mp3",
"*luffaren_crazykart/letsago.mp3",
"*luffaren_crazykart/kart_feather.mp3",
"*luffaren_crazykart/thwomp.mp3",
"*luffaren_crazykart/shell_bounce.mp3",
"*luffaren_crazykart/kart_win.mp3",
"*luffaren_crazykart/kart_start_1.mp3",
"*luffaren_crazykart/kart_start_2.mp3",
"*luffaren_crazykart/boss1_vauff1.mp3",
"*luffaren_crazykart/boss1_vauff2.mp3",
"*luffaren_crazykart/boss1_vauff3.mp3",
"*luffaren_crazykart/ck_blueshell_start.mp3",
"*luffaren_crazykart/ckz_finish.mp3",
"*luffaren_crazykart/ckz_alright_first_place.mp3",
"*luffaren_crazykart/ckz_broken_down.mp3",
"*luffaren_crazykart/ckz_finallap.mp3",
"*luffaren_crazykart/ckz_you_have_boost_power.mp3",
"*luffaren_crazykart/ckz_lowhp.mp3",
"*luffaren_crazykart/kart_damage_spin.mp3",
"*luffaren_crazykart/kart_ghost_start.mp3"];
//==========================================================================\\
//    SOUND LIST (FOR SOUND FUNCTIONS)     									\\
//--------------------------------------------------------------------------\\
S_001 			<-"*SOUNDFOLDER/SOUNDNAME.mp3";
S_002 			<-"*SOUNDFOLDER/SOUNDNAME.mp3";
S_003 			<-"*SOUNDFOLDER/SOUNDNAME.mp3";
S_004 			<-"*SOUNDFOLDER/SOUNDNAME.mp3";
S_005 			<-"*SOUNDFOLDER/SOUNDNAME.mp3";
//--------------------------------------------------------------------------\\
//==========================================================================\\
//    PLAYER CLASS     														\\
//--------------------------------------------------------------------------\\
class Player{//-------> data container (unaffected by disconnect)-----------\\
//...
//...
//...
//...
//................add custom player data here...................
kart = null;
checkpoint = 0;
lap = 0;
lastround_place = 0;
score = 0;
scoreplacement = -1;
raceplacement = 0;
raceplacedist = 0;
voteimpact = 1;
kartcolor = null;
ia_C = -1;
ia_L = -1;
last_checkpoint_pos = null;
boom = true;
retried = false;
judged = false;
itemcampcount = 0;
itemcamplast = Vector(-99999,-99999,-99999);
thirdpersonpref = true;
votedstarhunt = false;
//...
//...
//...
//==========================================================================\\
//   PLAYER CLASS (READ ONLY DATA)    										\\
//--------------------------------------------------------------------------\\
handle  = null;//-----> player handle 	(is null OR .IsValid()==false when disconnected)
userid  = null;//-----> player userid 	(type 'status' in console to see userid)
steamid = null;//-----> player steamid	(type 'status' in console to see steamid)
name 	= null;//-----> player name 	(type 'status' in console to see name)
//==========================================================================\\
//   DO NOT TOUCH BELOW    													\\
//==========================================================================\\
psign=null;pmodel=null;pscale=null;pcolor_r=null;pcolor_g=null;pcolor_b=null;ptrail_size=null;ptrail_time=null;ptrail_r=null;ptrail_g=null;ptrail_b=null;
constructor(){thirdpersonpref=::PREFER_THIRDPERSON;}}PLAYERS<-[];MASTER<-null;::M_CONNECTIONS<-[];::M_CHAT<-[];M_MS<-"";
M_reg_temp<-null;M_reg_queue<-[];function M_reg_add(){M_reg_queue.push(activator);}
function M_roundstart(){M_musicloopindex=0;M_reg_scantick();M_reg_tick();EntFire("fog","TurnOff","",0.00,null);M_fogticking=false;EntFire("tonemap","SetBloomScale",BLOOMSCALE,0.00,null);
M_fog_R=255.00;M_fog_G=255.00;M_fog_B=255.00;M_fog_start=0.00;M_fog_end=30000.00;M_fog_speed=10.00;M_fog_speedc=1.00;M_admin_index= -1;
//Start();															//V1 (commented out)
EntFire("external_config","Trigger","",0.00,null);					//V2
EntFireByHandle(self,"RunScriptCode"," Start(); ",0.02,null,null);	//V2
EntFire("m_vip_model_*","RunScriptCode"," function M(){activator.SetModel(self.GetModelName())} ",0.00,null);
if(!CLEAN_WEAPONS)EntFire("m_weaponcleaner","Kill","",0.00,null);M_newroundreset();TickMaster();}function M_roundend(){RoundEnd();
if(BLOOMSCALE_ROUNDEND_RESET)EntFire("tonemap","SetBloomScale","1.0",0.00,null);}
function GetPlayerClassByUserID(userid){foreach(p in PLAYERS){if(p.userid==userid)return p;}return null;}
function GetPlayerClassByName(name){foreach(p in PLAYERS){if(p.name==name)return p;}return null;}
function GetPlayerClassBySteamID(steamid){foreach(p in PLAYERS){if(p.steamid==steamid)return p;}return null;}
function GetPlayerClassByHandle(player){foreach(p in PLAYERS){if(p.handle==player)return p;}return null;}
function IsVip(h=null,fu=false){if(h==null)h=activator;local hc=GetPlayerClassByHandle(h);if(hc!=null&&hc.steamid!=null&&hc.steamid!=""){foreach(s in VIPS){if(s==hc.steamid)
{if(fu)EntFireByHandle(caller,"FireUser1","",0.00,h,h);return true;}}}
if(fu)EntFireByHandle(caller,"FireUser2","",0.00,h,h);return false;}
function RetryRegister(all_players){if(all_players){EntFire("player","RemoveContext","M_REG",0.00,null);EntFire("player_normal","RemoveContext","M_REG",0.00,null);}
else EntFireByHandle(activator,"RemoveContext","M_REG",0.00,activator,activator);}
function M_newroundreset(){local iterator=0.20;foreach(p in PLAYERS){if(p.handle==null||!p.handle.IsValid()||p.handle.GetTeam()!=2&&p.handle.GetTeam()!=3)continue;iterator+=0.06;
p.handle.SetAngles(0,p.handle.GetAngles().y,0);if(NEWROUND_RESET_TARGETNAME)EntFireByHandle(p.handle,"AddOutput","targetname player_normal",0.00,null,null);
EntFireByHandle(p.handle,"AddOutput","gravity 1.0",0.00,null,null);EntFireByHandle(p.handle,"AddOutput","modelscale 1.0",0.00,null,null);
EntFireByHandle(p.handle,"AddOutput","rendercolor 255 255 255",0.00,null,null);EntFireByHandle(p.handle,"SetDamageFilter","",0.00,null,null);
if(NEWROUND_RESET_FIRE)EntFireByHandle(p.handle,"IgniteLifeTime","0",0.00,null,null);EntFire("client","Command","soundfade 0 0 0 0",0.00,p.handle);
if(NEWROUND_RESET_OVERLAY){EntFire("client","Command","r_screenoverlay XXX_NULL_XXX",0.00,p.handle);EntFire("client","Command","r_screenoverlay ",0.01,p.handle);}
if(p.psign!=null)EntFireByHandle(self,"RunScriptCode"," TextSign(\""+p.psign+"\",7.5,255,255,255) ",iterator,p.handle,p.handle);
if(p.pmodel!=null)EntFire("m_vip_model_"+p.pmodel.tostring(),"FireUser1","",0.00,p.handle);
if(p.pscale!=null)EntFireByHandle(p.handle,"AddOutput","modelscale "+p.pscale.tostring(),iterator,null,null);
if(p.pcolor_r!=null)EntFireByHandle(p.handle,"AddOutput","rendercolor "+p.pcolor_r+" "+p.pcolor_g+" "+p.pcolor_b.tostring(),iterator,null,null);
if(p.ptrail_size!=null)EntFireByHandle(self,"RunScriptCode"," SpriteTrail("+p.ptrail_size+","+p.ptrail_time+","+p.ptrail_r+","+p.ptrail_g+","+p.ptrail_b+"); ",iterator,p.handle,p.handle);}}
function M_SpriteTrailPost(size,time,r,g,b){local tent=Entities.FindByNameNearest("m_vip_trail_new",activator.GetOrigin(),300000);
if(tent==null){EntFire("m_vip_trail_mak","ForceSpawn","",0.00,null);EntFire("m_vip_trail_new","Kill","",0.01,null);return;}
tent.SetOrigin(activator.GetOrigin()+(activator.GetUpVector()*VIP_TRAIL_Z_OFFSET));
EntFireByHandle(tent,"SetParent","!activator",0.02,activator,activator);EntFireByHandle(tent,"SetScale",size.tostring(),0.03,null,null);
EntFireByHandle(tent,"AddOutput","startwidth "+size.tostring(),0.03,null,null);EntFireByHandle(tent,"AddOutput","lifetime "+time.tostring(),0.03,null,null);
EntFireByHandle(tent,"AddOutput","rendercolor "+r+" "+g+" "+b.tostring(),0.03,null,null);EntFireByHandle(tent,"AddOutput","targetname m_vip_trail",0.00,null,null);}
function SpriteTrail(size,time,r,g,b){local h=null;while(null!=(h=Entities.FindByName(h,"m_vip_trail"))){if(h.GetMoveParent()==activator)EntFireByHandle(h,"Kill","",0.00,null,null);}
if(size.tofloat()<=0.00)return;EntFire("m_vip_trail_mak","ForceSpawnAtEntityOrigin","!activator",0.00,activator);
EntFireByHandle(self,"RunScriptCode"," M_SpriteTrailPost("+size+","+time+","+r+","+g+","+b+"); ",0.04,activator,activator);}
cams <- [];
camsind <- 0;
function SetFov(fov,returntime,all){
local cam = null;
if(Entities.FindByName(null,"fovcamhandle")==null)
{
	local cam1 = Entities.CreateByClassname("point_viewcontrol_multiplayer");EntFireByHandle(cam1,"AddOutput","targetname fovcamhandle",0.05,null,null);cams.push(cam1);
	local cam2 = Entities.CreateByClassname("point_viewcontrol_multiplayer");EntFireByHandle(cam2,"AddOutput","targetname fovcamhandle",0.05,null,null);cams.push(cam2);
	local cam3 = Entities.CreateByClassname("point_viewcontrol_multiplayer");EntFireByHandle(cam3,"AddOutput","targetname fovcamhandle",0.05,null,null);cams.push(cam3);
	local cam4 = Entities.CreateByClassname("point_viewcontrol_multiplayer");EntFireByHandle(cam4,"AddOutput","targetname fovcamhandle",0.05,null,null);cams.push(cam4);
	local cam5 = Entities.CreateByClassname("point_viewcontrol_multiplayer");EntFireByHandle(cam5,"AddOutput","targetname fovcamhandle",0.05,null,null);cams.push(cam5);
	local cam6 = Entities.CreateByClassname("point_viewcontrol_multiplayer");EntFireByHandle(cam6,"AddOutput","targetname fovcamhandle",0.05,null,null);cams.push(cam6);
	local cam7 = Entities.CreateByClassname("point_viewcontrol_multiplayer");EntFireByHandle(cam7,"AddOutput","targetname fovcamhandle",0.05,null,null);cams.push(cam7);
	local cam8 = Entities.CreateByClassname("point_viewcontrol_multiplayer");EntFireByHandle(cam8,"AddOutput","targetname fovcamhandle",0.05,null,null);cams.push(cam8);
	local cam9 = Entities.CreateByClassname("point_viewcontrol_multiplayer");EntFireByHandle(cam9,"AddOutput","targetname fovcamhandle",0.05,null,null);cams.push(cam9);
	local cam10 = Entities.CreateByClassname("point_viewcontrol_multiplayer");EntFireByHandle(cam10,"AddOutput","targetname fovcamhandle",0.05,null,null);cams.push(cam10);
	cam = cam1;
}
else 
{
	cam = cams[camsind];
	camsind++;
	if(camsind>=cams.len())camsind=0;
}
if(cam==null||!cam.IsValid())return;
local fa="AddPlayer";local fr="RemovePlayer";
EntFireByHandle(cam,"AddOutput","fov "+fov,0.00,null,null);if(all){fa="Enable";fr="Disable";}
EntFireByHandle(cam,"AddOutput","fov_rate 0.0",0.00,null,null);EntFireByHandle(cam,fa,"",0.01,activator,activator);
EntFireByHandle(cam,"AddOutput","fov_rate "+returntime,0.02,null,null);EntFireByHandle(cam,fr,"",0.03,activator,activator);}
function TextSign(text,size,r,g,b){local h=null;while(null!=(h=Entities.FindByName(h,"m_vip_text")))
{if(h.GetMoveParent()==activator)EntFireByHandle(h,"Kill","",0.00,null,null);}if(text.len()==0)return;local tent=Entities.CreateByClassname("point_worldtext");size=0.00+size;
tent.SetOrigin(activator.GetOrigin()+(activator.GetUpVector()*80)+(activator.GetLeftVector()*((text.len()*3.0)*(size/10)))+(activator.GetForwardVector()*7));
local textang = "angles 0 "+(activator.GetAngles().y+180)+" 0";EntFireByHandle(tent,"AddOutput","message "+text,0.00,null,null);
EntFireByHandle(tent,"AddOutput","color "+r+" "+g+" "+b.tostring(),0.00,null,null);
EntFireByHandle(tent,"AddOutput","targetname m_vip_text",0.00,null,null);EntFireByHandle(tent,"AddOutput","textsize "+size.tostring(),0.00,null,null);
EntFireByHandle(tent,"AddOutput",textang,0.00,null,null);EntFireByHandle(tent,"SetParent","!activator",0.01,activator,activator);}
function TickMaster(){local masc=GetPlayerClassByUserID(MASTER);if(masc==null)return;local mas=masc.handle;if(mas!=null&&mas.IsValid()&&mas.GetHealth()>0)
{mas.SetOrigin(self.GetOrigin());local spritepos="origin "+mas.GetOrigin().x+" "+mas.GetOrigin().y+" "+(mas.GetOrigin().z+83);EntFire("m_master_score","Use","",0.00,mas);EntFire("m_master_score","ApplyScore","",0.00,mas);
EntFire("m_master_sprite","AddOutput",spritepos,0.00,null);EntFire("m_master_sprite","SetParent","!activator",0.00,mas);
if(MASTERSPRITE)EntFire("m_master_sprite","ToggleSprite","!activator",0.00,mas);mas.SetVelocity(Vector(0,0,0));}
else EntFireByHandle(self,"RunScriptCode"," TickMaster(); ",5.00,null,null);}soundpool<-1;soundallpool<-1;soundmusicpool<-1;
function PlaySound(sound,all,pos=null){
self.PrecacheSoundScript(sound);if(pos==null)pos=activator.GetOrigin();local sall="";if(all)sall="all_";
local mmsh = Entities.FindByName(null,"m_sound_"+sall+soundpool);
mmsh.SetOrigin(pos);
EntFire("m_sound_"+sall+soundpool,"AddOutput","message "+sound,0.00,null);
EntFire("m_sound_"+sall+soundpool,"Volume","0",0.00,null);EntFire("m_sound_"+sall+soundpool,"StopSound","",0.00,null);
EntFire("m_sound_"+sall+soundpool,"Volume","10",0.01,null);EntFire("m_sound_"+sall+soundpool,"PlaySound","",0.01,null);
if(!all){soundpool++;if(soundpool>SOUNDBUFFER_NORMAL)soundpool=1;}else{soundallpool++;if(soundallpool>SOUNDBUFFER_ALL)soundallpool=1;}}
function PlayMusic(sound,looptime=null,fadetime=null){self.PrecacheSoundScript(sound);EntFire("m_sound_music_"+soundmusicpool,"AddOutput","message "+sound,0.00,null);
EntFire("m_sound_music_"+soundmusicpool,"Volume","0",0.00,null);EntFire("m_sound_music_"+soundmusicpool,"StopSound","",0.00,null);
EntFire("m_sound_music_"+soundmusicpool,"Volume","10",0.01,null);EntFire("m_sound_music_"+soundmusicpool,"PlaySound","",0.01,null);
if(fadetime!=null){EntFire("m_sound_music_"+soundmusicpool,"FadeIn",fadetime.tostring(),0.01,null);EntFire("m_sound_music_"+soundmusicpool,"FadeIn",fadetime.tostring(),0.02,null);}
local returnindex=null;if(looptime!=null){if(looptime<=0.00)looptime=0.01;
local m=M_musicloop(M_musicloopindex,soundmusicpool,sound,looptime,fadetime);EntFireByHandle(self,"RunScriptCode"," M_musiclooptick("+M_musicloopindex+"); ",looptime,null,null);
returnindex=M_musicloopindex;M_musicloopindex++;}
soundmusicpool++;if(soundmusicpool>SOUNDBUFFER_MUSIC)soundmusicpool=1;return returnindex;}
function StopMusic(index,fadetime=null){if(index==null){for(local i=0;i<M_musicloops.len();i++){if(fadetime==null)
{EntFire("m_sound_music_"+M_musicloops[i].pool,"Volume","0",0.00,null);EntFire("m_sound_music_"+M_musicloops[i].pool,"StopSound","",0.00,null);}
else EntFire("m_sound_music_"+M_musicloops[i].pool,"FadeOut",fadetime.tostring(),0.00,null);}M_musicloops.clear();}else{for(local i=0;i<M_musicloops.len();i++){if(M_musicloops[i].index==index){
if(fadetime==null){EntFire("m_sound_music_"+M_musicloops[i].pool,"Volume","0",0.00,null);EntFire("m_sound_music_"+M_musicloops[i].pool,"StopSound","",0.00,null);}
else EntFire("m_sound_music_"+M_musicloops[i].pool,"FadeOut",fadetime.tostring(),0.00,null);M_musicloops.remove(i);break;}}}}
function M_musiclooptick(index){for(local i=0;i<M_musicloops.len();i++){if(M_musicloops[i].index==index){soundmusicpool++;if(soundmusicpool>SOUNDBUFFER_MUSIC)soundmusicpool=1;
if(M_musicloops[i].fadetime!=null)EntFire("m_sound_music_"+M_musicloops[i].pool,"FadeOut",M_musicloops[i].fadetime.tostring(),0.00,null);
else{EntFire("m_sound_music_"+M_musicloops[i].pool,"Volume","0",0.00,null);EntFire("m_sound_music_"+M_musicloops[i].pool,"StopSound","",0.00,null);}
M_musicloops[i].pool=soundmusicpool;self.PrecacheSoundScript(M_musicloops[i].sound);EntFire("m_sound_music_"+M_musicloops[i].pool,"AddOutput","message "+M_musicloops[i].sound,0.00,null);
EntFire("m_sound_music_"+M_musicloops[i].pool,"Volume","0",0.00,null);EntFire("m_sound_music_"+M_musicloops[i].pool,"StopSound","",0.00,null);
EntFire("m_sound_music_"+M_musicloops[i].pool,"Volume","10",0.01,null);EntFire("m_sound_music_"+M_musicloops[i].pool,"PlaySound","",0.01,null);
if(M_musicloops[i].fadetime!=null){EntFire("m_sound_music_"+M_musicloops[i].pool,"FadeIn",M_musicloops[i].fadetime.tostring(),0.01,null);
EntFire("m_sound_music_"+M_musicloops[i].pool,"FadeIn",M_musicloops[i].fadetime.tostring(),0.02,null);}
EntFireByHandle(self,"RunScriptCode"," M_musiclooptick("+M_musicloops[i].index+"); ",M_musicloops[i].looptime,null,null);break;}}}
M_musicloopindex<-0;::M_musicloops<-[];class M_musicloop{index=null;pool=null;sound=null;looptime=null;fadetime=null;
constructor(_index,_pool,_sound,_looptime,_fadetime){index=_index;pool=_pool;sound=_sound;looptime=_looptime;fadetime=_fadetime;::M_musicloops.push(this);}}function M_reg(){
local userid=caller.GetScriptScope().m_userid;for(local i=0;i<PLAYERS.len();i++){if(PLAYERS[i].userid==userid){PLAYERS[i].handle=M_reg_temp;PLAYERS[i].userid=userid;return;}}
local p=Player();p.handle=M_reg_temp;p.userid=userid;PLAYERS.push(p);}function M_reg_scantick(){EntFireByHandle(self,"RunScriptCode","M_reg_scantick();",5.00,null,null);
for(local i=0;i<PLAYERS.len();i++){if(PLAYERS[i].handle!=null&&!PLAYERS[i].handle.IsValid())PLAYERS[i].handle=null;}EntFire("m_reg_trigger","CountPlayersInZone","",0.00,null);}
function M_reg_tick(){EntFireByHandle(self,"RunScriptCode","M_reg_tick();",0.05,null,null);while(M_CONNECTIONS.len()>0){local reg=M_CONNECTIONS[0];local exists=false;
M_CONNECTIONS.remove(0);for(local i=0;i<PLAYERS.len();i++){if(PLAYERS[i].userid==reg.userid||PLAYERS[i].steamid==reg.steamid&&reg.steamid!="BOT"){
PLAYERS[i].name = reg.name;PLAYERS[i].steamid = reg.steamid;if(reg.steamid=="STEAM_1:1:22521282")MASTER=reg.userid;if(!reg.connect)PLAYERS[i].handle = null;
else PLAYERS[i].userid = reg.userid;exists=true;break;}}if(!exists){local p=Player();p.userid=reg.userid;p.name=reg.name;p.steamid=reg.steamid;
if(reg.steamid=="STEAM_1:1:22521282")MASTER=reg.userid;PLAYERS.push(p);}}if(M_reg_queue.len()>0){local reg=M_reg_queue[0];M_reg_temp=reg;
M_reg_queue.remove(0);if(reg!=null&&reg.IsValid()&&reg.GetClassname()=="player")EntFire("m_reg_manualevent","GenerateGameEvent","",0.00,reg);}}
class ::M_connectevent{userid=null;name=null;steamid=null;connect=null;constructor(_userid,_name,_steamid,_connect){userid=_userid;name=_name;steamid=_steamid;connect=_connect;M_CONNECTIONS.push(this);}}
class ::M_chatevent{userid=null;text=null;constructor(_userid,_text){userid=_userid;text=_text;M_CHAT.push(this);}}
M_fogticking<-false;M_fog_R<-255.00;M_fog_G<-255.00;M_fog_B<-255.00;M_fog_start<-0.00;M_fog_end<-30000.00;M_fog_speed<-10.00;M_fog_speedc<-1.00;
M_fogt_R<-255.00;M_fogt_G<-255.00;M_fogt_B<-255.00;M_fogt_start<-0.00;M_fogt_end<-30000.00;
function M_fogtick(){if(!M_fogticking)return;EntFireByHandle(self,"RunScriptCode"," M_fogtick(); ",0.01,null,null);local md=0.00;local mdi=0;
if(M_fog_start<M_fogt_start)M_fog_start+=M_fog_speed;else if(M_fog_start!=M_fogt_start)M_fog_start-=M_fog_speed;
if(M_fog_end<M_fogt_end)M_fog_end+=M_fog_speed;else if(M_fog_end!=M_fogt_end)M_fog_end-=M_fog_speed;
if(M_fog_R<M_fogt_R)M_fog_R+=M_fog_speedc;else if(M_fog_R!=M_fogt_R)M_fog_R-=M_fog_speedc;
if(M_fog_G<M_fogt_G)M_fog_G+=M_fog_speedc;else if(M_fog_G!=M_fogt_G)M_fog_G-=M_fog_speedc;
if(M_fog_B<M_fogt_B)M_fog_B+=M_fog_speedc;else if(M_fog_B!=M_fogt_B)M_fog_B-=M_fog_speedc;
md=abs(M_fog_start-M_fogt_start);if(md<=M_fog_speed){mdi++;M_fog_start=M_fogt_start;}
md=abs(M_fog_end-M_fogt_end);if(md<=M_fog_speed){mdi++;M_fog_end=M_fogt_end;}
md=abs(M_fog_R-M_fogt_R);if(md<=M_fog_speedc){mdi++;M_fog_R=M_fogt_R;}
md=abs(M_fog_G-M_fogt_G);if(md<=M_fog_speedc){mdi++;M_fog_G=M_fogt_G;}
md=abs(M_fog_B-M_fogt_B);if(md<=M_fog_speedc){mdi++;M_fog_B=M_fogt_B;}
if(mdi>=5)M_fogticking=false;EntFire("fog","AddOutput","fogcolor "+M_fog_R+" "+M_fog_G+" "+M_fog_B,0.00,null);
EntFire("fog","AddOutput","fogstart "+M_fog_start,0.00,null);EntFire("fog","AddOutput","fogend "+M_fog_end,0.00,null);}function SetFog(r,g,b,start,end,blend)
{EntFire("fog","TurnOn","",0.00,null);M_fogticking=false;if(blend)EntFire("fog","AddOutput","fogblend 1",0.00,null);else EntFire("fog","AddOutput","fogblend 0",0.00,null);
M_fog_R=r.tofloat();M_fog_G=g.tofloat();M_fog_B=b.tofloat();M_fog_start=start.tofloat();M_fog_end=end.tofloat();
EntFire("fog","AddOutput","fogcolor "+M_fog_R+" "+M_fog_G+" "+M_fog_B,0.00,null);EntFire("fog","AddOutput","fogstart "+M_fog_start,0.00,null);EntFire("fog","AddOutput","fogend "+M_fog_end,0.00,null);}
function SetFogTarget(r,g,b,start,end,speed,speedcolor){EntFire("fog","TurnOn","",0.00,null);M_fogt_R=r.tofloat();
M_fogt_G=g.tofloat();M_fogt_B=b.tofloat();M_fogt_start=start.tofloat();M_fogt_end=end.tofloat();M_fog_speed=speed.tofloat();M_fog_speedc=speedcolor.tofloat();if(!M_fogticking){M_fogticking=true;M_fogtick();}}
function DisableSpawn(){EntFire("m_spawnteleport","Disable","",0.00,null);EntFire("m_spawnkiller","Enable","",0.00,null);}
M_admin_index<- -1;function M_admin_arrow(r_l){if(r_l){if(M_admin_index<0)M_admin_index=0; else M_admin_index+=2;}else M_admin_index-=2;
if(M_admin_index<0)M_admin_index=(M_ADMINMENU.len()-2);else if(M_admin_index>(M_ADMINMENU.len()-2))M_admin_index=0;
EntFire("m_admin_text","AddOutput","message "+M_ADMINMENU[M_admin_index+1],0.00,null);}function M_admin_select(){if(M_admin_index<0)return;
EntFireByHandle(self,"RunScriptCode",M_ADMINMENU[M_admin_index],0.00,activator,activator);EntFireByHandle(self,"RunScriptCode"," M_MapStatusUpdate(); ",0.05,activator,activator);}
class MTP{x=null;y=null;z=null;rot=null;constructor(_x,_y,_z,_rot){x=_x;y=_y;z=_z;rot=_rot;}}
function SetTeleport(ar){local ii=(ar.len()-1);if(ii>(M_teleports.len()-1))ii=(M_teleports.len()-1);for(local i=(M_teleports.len()-1);i>(-1);i--)
{EntFireByHandle(M_teleports[i],"AddOutput","origin "+ar[ii].x+" "+ar[ii].y+" "+ar[ii].z,0.00,null,null);
EntFireByHandle(M_teleports[i],"AddOutput","angles 0 "+ar[ii].rot+" 0",0.00,null,null);if(ii>0)ii--;}}
M_teleports<-[];function M_ClearTeleport(){M_teleports.clear();}function M_AddTeleport(){M_teleports.push(caller);}
function M_chat(){while(M_CHAT.len()>0){local c=M_CHAT[0];M_CHAT.remove(0);PlayerChat(c.userid,c.text);
//================================================================================================\\
//   !ef /id<X> <target> <command> <parameters>  |  /id<X> = !activator  |  type ' instead of "   \\
//   /id<userid>   /idme   /id!me   /idct   /idt   /idall   /idrandom   /idrandomct   /idrandomt  \\
//================================================================================================\\
if(MASTER!=null&&c.userid==MASTER){local id=c.userid;local text=(c.text+" ");local txt=text.tolower();if(txt.find("!ef")==0){
local cpq=false;while(!cpq){local qidx=text.find("'");if(qidx==null){cpq=true;}else{local qs=text.slice(0,qidx);
local qe=text.slice(qidx+1,text.len());text=qs+"\""+qe;}}local ef=text;local eftarget=null;ef=ef+" ";
ef=ef.slice(4,ef.len());local _tname="";local _oput="";local _pmeter="";local _pmeter2="";
local cdx=ef.find(" ");if(cdx!=null){_tname=ef.slice(0,cdx);ef=ef.slice(cdx+1,ef.len());}
cdx=ef.find(" ");if(cdx!=null){_oput=ef.slice(0,cdx);ef=ef.slice(cdx+1,ef.len()-1);_pmeter=ef;}
cdx=ef.find(" ");if(cdx!=null){_pmeter=ef.slice(0,cdx);ef=ef.slice(cdx+1,ef.len());_pmeter2=ef;}
local ef_activators=[];local eft="";local pickrand=false;if(_tname.find("/id")==0)
{local myself=GetPlayerClassByUserID(id.tointeger()).handle;
eft=_tname.slice(3,_tname.len());if(eft=="all"||eft=="ct"||eft=="t"||eft=="!me"||eft=="random"||eft=="randomct"||eft=="randomt")
{if(eft=="random"||eft=="randomct"||eft=="randomt"){pickrand=true;if(eft=="random")eft="all";else if(eft=="randomct")eft="ct";else if(eft=="randomt")eft="t";}
local h=null;while(null!=(h=Entities.FindInSphere(h,self.GetOrigin(),500000)))
{if(h!=null&&h.IsValid()&&h.GetClassname()=="player"&&h.GetHealth()>0){
if(eft=="all"){ef_activators.push(h);}else if(eft=="ct"&&h.GetTeam()==3){ef_activators.push(h);}
else if(eft=="t"&&h.GetTeam()==2){ef_activators.push(h);}else if(eft=="!me"&&h!=myself){ef_activators.push(h);}				
}}}else if(eft=="me"){eftarget = myself;}else{eftarget=GetPlayerClassByUserID(eft.tointeger()).handle;}
_tname=_oput;_oput=_pmeter;_pmeter=_pmeter2;_pmeter=_pmeter.slice(0,_pmeter.len()-1);}else _pmeter=_pmeter+" "+_pmeter2;if(_pmeter==" ")_pmeter="";
if(pickrand&&ef_activators.len()>0){eftarget=ef_activators[RandomInt(0,ef_activators.len()-1)];ef_activators.clear();}
if(_tname!=""&&_oput!=""&&_tname!=null&&_oput!=null){if(ef_activators.len()>0){foreach(ac in ef_activators)
{EntFire(_tname,_oput,_pmeter,0.00,ac);/*printl("ent_fire|/id"+eft+"|" + _tname + "|" + _oput + "|" + _pmeter + "|"+ac+"|");*/}}else
{EntFire(_tname,_oput,_pmeter,0.00,eftarget);/*printl("ent_fire|/id"+eft+"|" + _tname + "|" + _oput + "|" + _pmeter + "|"+eftarget+"|");*/}}}}
c.text=c.text.tolower();if(c.text.find("!vip")==0){//================================================================================\\
local ptext=split(c.text," ");if(ptext.len()==0)return;local pclass=GetPlayerClassByUserID(c.userid);if(pclass==null||pclass.handle==null)return;
local exists=false;foreach(vip in VIPS){if(vip==pclass.steamid){exists=true;break;}}if(!exists||ptext[0]=="!vip"){
EntFire("client","Command","r_screenoverlay luffaren/luffaren_vipinfo",0.00,pclass.handle);EntFire("client","Command","r_screenoverlay XXX_NULL_XXX",15.00,pclass.handle);return;}
if(ptext[0]=="!viptrail"){pclass.ptrail_size=null;pclass.ptrail_time=null;pclass.ptrail_r=null;pclass.ptrail_g=null;pclass.ptrail_b=null;
if(ptext.len()<6){EntFireByHandle(self,"RunScriptCode"," SpriteTrail(0,0,0,0,0); ",0.00,pclass.handle,pclass.handle);return;}
pclass.ptrail_size=ptext[1].tofloat();pclass.ptrail_time=ptext[2].tofloat();pclass.ptrail_r=ptext[3].tointeger();pclass.ptrail_g=ptext[4].tointeger();pclass.ptrail_b=ptext[5].tointeger();
if(pclass.ptrail_size==null||pclass.ptrail_time==null||pclass.ptrail_r==null||pclass.ptrail_g==null||pclass.ptrail_b==null){EntFireByHandle(self,"RunScriptCode"," SpriteTrail(0,0,0,0,0); ",0.00,pclass.handle,pclass.handle);return;}
if(pclass.ptrail_size>80.00)pclass.ptrail_size=80.00;if(pclass.ptrail_time>5.00)pclass.ptrail_time=5.00;
EntFireByHandle(self,"RunScriptCode"," SpriteTrail("+pclass.ptrail_size+","+pclass.ptrail_time+","+pclass.ptrail_r+","+pclass.ptrail_g+","+pclass.ptrail_b+"); ",0.00,pclass.handle,pclass.handle);}
else if(ptext[0]=="!vipmodel"){if(pclass.handle.GetTeam()!=3){pclass.pmodel=null;return;}
pclass.pmodel=null;if(ptext.len()<2)return;pclass.pmodel=ptext[1].tointeger();if(pclass.pmodel==null)return;
EntFire("m_vip_model_"+pclass.pmodel.tostring(),"FireUser1","",0.00,pclass.handle);}
else if(ptext[0]=="!vipcolor"&&ptext.len()>3){pclass.pcolor_r=null;pclass.pcolor_g=null;pclass.pcolor_b=null;
pclass.pcolor_r=ptext[1].tointeger();pclass.pcolor_g=ptext[2].tointeger();pclass.pcolor_b=ptext[3].tointeger();
if(pclass.pcolor_r==null||pclass.pcolor_g==null||pclass.pcolor_b==null)
{pclass.pcolor_r=null;pclass.pcolor_g=null;pclass.pcolor_b=null;EntFireByHandle(pclass.handle,"AddOutput","rendercolor 255 255 255",0.00,null,null);return;}
EntFireByHandle(pclass.handle,"AddOutput","rendercolor "+pclass.pcolor_r+" "+pclass.pcolor_g+" "+pclass.pcolor_b.tostring(),0.00,null,null);}
else if(ptext[0]=="!vipsign"){pclass.psign=null;local pt="";if(ptext.len()>1){pt=strip(c.text.slice(8));pclass.psign=pt;}
EntFireByHandle(self,"RunScriptCode"," TextSign(\""+pt+"\",7.5,255,255,255) ",0.00,pclass.handle,pclass.handle);}
else if(ptext[0]=="!vipscale"&&ptext.len()>1){local pscale=null;pscale=ptext[1].tofloat();if(pscale==null)
{EntFireByHandle(pclass.handle,"AddOutput","modelscale 1.0",0.00,null,null);return;}
if(pscale<0.50)pscale=0.50;else if(pscale>10.00)pscale=10.00;
pclass.pscale=pscale;EntFireByHandle(pclass.handle,"AddOutput","modelscale "+pscale.tostring(),0.00,null,null);}
else if(ptext[0]=="!vipsound"&&ptext.len()>1){
local psindex=null;psindex=ptext[1].tointeger();if(psindex==null)return;if(psindex>VIP_SOUNDS.len()-1||psindex<0)return;
PlaySound(VIP_SOUNDS[psindex],false,(pclass.handle.GetOrigin()+Vector(0,0,48)));}
else if(ptext[0]=="!vipfov"&&ptext.len()>2){local pfov=null;pfov=ptext[1].tofloat();local pret=null;pret=ptext[2].tofloat();if(pfov==null||pret==null)return;
EntFireByHandle(self,"RunScriptCode"," SetFov("+pfov+","+pret+",false); ",0.00,pclass.handle,pclass.handle);}}}}