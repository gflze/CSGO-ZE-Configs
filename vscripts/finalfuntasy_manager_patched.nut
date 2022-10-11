//==================================\\
// By Luffaren (STEAM_1:1:22521282) \\
//==================================\\
//	Final Funtasy
//		There's no ZE-gameplay here, this stage is about taking a break from all that pesky defending
//		The goal is simple, make it to the end and survive
//		You can only walk left/right and jump, enemies/bosses can be damaged by jumping on top of them
//		If you die/are late to the scorpion guard boss/doesn't kill the scorpion guard in time > you won't get a health-buff
//		This health buff is probably very important in order to survive (for longer) at the end, it should be good incentive to do well
//	
//	TP-IN:							stage_lff_tp_in
//	START-RELAY-TRIGGER:			stage_lff_manager
//	Map("Final Funtasy","Luffaren","stage_lff_tp_in","stage_lff_tp_in",0.0,"stage_lff_manager"),
//	Finished in 5 days (started 2021-06-23 - ended 2021-06-27)
//	~9mb in total (.bsp + assets combined)
//=========================================================================================================================================\\
//			[CHANGES IN "finalfuntasy_manager_patched.nut" 2022-08-25]
//			(by luffaren - in an attempt to fix the client-crash issues)
//			CTRL+F to find the general tweaks:		//#####FIX_PATCHED
//	- changed ::luff_ff_tickrate from 0.05 to 0.50
//	- added ::luff_ff_fix_viewmodel_hide and set it to 'false' by default
//	- added ::luff_ff_fix_weapon_kill and set it to 'false' by default
//	- added ::luff_ff_fix_disable_flashlight + ::luff_ff_fix_disable_flashlight_rate + TickFlashlightDisable() to disable flashlights
//	- added ::luff_ff_fix_invisible_models and set it to 'false' by default
//	- added ::luff_ff_fix_late_forgive + LateTpTouched() which is called by late TP, meant to slay CT's who are late (only if '::luff_ff_fix_late_forgive' is false)
//	- added ::luff_ff_fix_start_at_boss which is 'false' by default
//	- added ::luff_ff_fix_bosshug_pos + ::luff_ff_fix_bosshug_tp_range + ::luff_ff_fix_bosshug_tp_dist to deal with players doorhugging the left of the boss
//	- added ::luff_ff_fix_damage_fade which is 'false' by default
//	- added ::luff_ff_fix_damage_sound which is 'false' by default
//	- decreased damage_touch_boss from 29 to 21
//	- increased sephlaser_damage from 23 to 28
//	- increased sephlaser_seph_health from 100 to 120
//---------------------------------------------------\\
//		***EDIT 2022-10-09***
//		^After some testing on GFL (thanks to Vauff) it seems that '::luff_ff_fix_invisible_models' was the cause of the client crashes
//		(namely the playermodel 'models/player/custom_player/luffaren/invisibleplayer.mdl' being borked)
//		As a result - ALL old variables/settings EXCEPT 'sephlaser_damage' + 'damage_touch_boss' are back to how they were now
//		The playermodel has now been replaced with one that works ('models/player/chinny/chinny_invis_model.mdl')
//		
//		***EDIT 2022-10-11***
//		Vauff saw that 'chinny_invis_model.mdl' is running the old skeleton, but also noticed that they were running 'rendermode 10' for that stage
//		As a result, this stage will also run 'rendermode 10' for players (if '::luff_ff_fix_invisible_models' is true)
//	
//-----------------------------------------------------------------------------------------------------------------------------------------\\
::luff_ff_fix_viewmodel_hide <- true;					//set this to true to force-hide the predicted_viewmodel for players
::luff_ff_fix_weapon_kill <- true;						//set this to true to force-kill weapons for players
::luff_ff_fix_disable_flashlight <- true;				//set this to 'true' to run a tick to disable flashlights via EntFire("player","AddOutputs","effects 0",0.00,null);
::luff_ff_fix_disable_flashlight_rate <- 0.01;			//tickrate of above, should probably be good with 0.01s to keep it as fast/clear of flashlights as possible
::luff_ff_fix_invisible_models <- true;					//set to 'true' to force all players to use invisible models during the stage
::luff_ff_fix_late_forgive <- false;					//set to 'true' to forgive humans who are late to boss/etc, else slay them (set to 'false' to prevent them from afking in spawn)
::luff_ff_fix_start_at_boss <- false;					//set to 'true' to start the players directly at the bossfight, could be more fast-paced if people are getting bored
::luff_ff_fix_bosshug_pos <- Vector(14672,-5168,7744);	//the position of the very left-side of the boss arena where doorhuggers usually gather
::luff_ff_fix_bosshug_tp_range <- 400;					//players within this range of '::luff_ff_fix_bosshug_pos' gets TP'd further back (-Y)
::luff_ff_fix_bosshug_tp_dist <- 500;					//how far back to TP players who doorhug (-Y)
::luff_ff_fix_damage_fade <- true;						//set to 'true' to run an env_fade for players who get damaged
::luff_ff_fix_damage_sound <- true;						//set to 'true' to run a clientcommand play sound for players who get damaged

//=========================================================================================================================================\\




::luff_ff_tickrate <- 0.05;						//how fast to tick player-angles + predicted_viewmodel hide + kill weapons
::luff_ff_character_tickrate <- 0.10;			//how fast to tick visual character-animations/states
::luff_ff_health <- 100.00;						//starting health for players
::luff_ff_tpforgive_losing_humans <- false;		//set to 'true' to TP all loser-humans to the vote-room safely (else they get TP:d to zombie-room)
::luff_ff_boss_start_delay <- 17.00;			//how long to wait until starting the boss once a player reaches the core (to let others catch up)
::luff_ff_jump_damage <- 24.00;					//how much damage a player-jump deals to an enemy
::luff_ff_player_gravity <- 0.50;				//the gravity to set for players (1.00 = default)
hiteffect_cd <- 0.05;							//the time-window to disallow enemy jump-hit effects to prevent mass-spawn/edict crash
musdelay <- 25.00;								//delay before playing final song after boss is killed (final door/events are based on this)
late_tp_end_delay <- 47.00;						//after killing boss, enable spawn-tele to 2nd-to-last area at this time (final door closes at ~65.00s)
guardkill_winner_hpadd <- 100.00;				//how much health to += to the players who beat the scorpion guard without dying/being late/TP-ing to the arena
sephlaser_rate <- 1.20;							//how fast to spawn sepiroth's lasers (1.20 is currently matched to .vmt animation speed, kinda)
sephlaser_chances <- [1,1,1,2,2,2,2,2];			//chances between top/bot lasers (1:top, 2:bot)
boss_minionspawnrng <- 6;						//how many minions that are allowed to spawn in durint the scorpion guard bossfight (in total)
boss_auto_defeat_time <- 63.00;					//timeout until the boss (scorpion guard) auto-dies, if this happens 'guardkill_winner_hpadd' won't be ran
missile_speed <- 200.00;						//the default speed for missiles (might/can be overridden by ShootMissile() function)
enemy2_target_rate_min <- 1.00;					//enemy 2 targeting-trigger refire MIN (0.10 min)	test2:0.30
enemy2_target_rate_max <- 5.00;					//enemy 2 targeting-trigger refire MAX				test2:4.00
enemy3_target_rate_min <- 3.00;					//enemy 3 targeting-trigger refire MIN (0.10 min)
enemy3_target_rate_max <- 8.00;					//enemy 3 targeting-trigger refire MAX
grenade_blow_time <- 2.00;						//the time it takes for a grenade to explode once spawned/thrown
damagecd <- 0.80;								//the invincibility-frame-time when taking damage (might/can be ignored by certain things)
//-----------------------[ENEMY DAMAGE]
damage_falldown <- 4;							//damage to deal when falling down a death-pit (you get knockbacked up, allowing you to save yourself)
damage_explosion <- 9;							//damage to deal from touching an explosion
damage_touch_sepiroth <- 39;					//damage to deal from touching sepiroth
sephlaser_damage <- 28;							//damage from sepiroth's laser on-touch
damage_touch_boss <- 21;						//damage to deal from touching boss (scorpion guard)
bosslaser_damage <- 9;							//damage to deal from touching bosslaser (red line)
damage_touch_enemy1 <- 24;						//damage to deal from touching enemy 1 (blue, weird, claw-like soldier that has big knockback on-player-hit)
damage_touch_enemy2 <- 19;						//damage to deal from touching enemy 2 (soldier that throws grenades)
damage_touch_enemy3 <- 7;						//damage to deal from touching enemy 3 (flying little robot that shoots missiles)
//-----------------------[ENEMY HEALTH]
health_enemy1 <- 140.00;						//health for enemy 1	(base health)
health_enemy2 <- 100.00;						//health for enemy 2	(base health)
health_enemy3 <- 40.00;							//health for enemy 3	(base health)
enemy_hpadd_each_player <- 4;					//how much extra HP to add to sepiroth+enemies for each player on the server
enemy_hpadd_each_playerboss <- 40;				//how much extra HP to add to the boss for each player on the server
enemy_hpadd_each_player_cap <- 200;				//the max extra-hp-add^ allowed, if it reaches this point it won't add any more HP
enemy_hpadd_each_player_septhcap <- 150;		//the max extra-hp-add^ allowed for sepiroth specifically, it may need a lower value due to its difficulty
boss_health <- 200.00;							//how much health the boss has (base health) (scorpion guard)
enemy_hpadd_each_player_bosscap <- 2500.00;		//the max extra-hp-add^ allowed for boss specifically, it may need a lower value due to its difficulty
sephlaser_seph_health <- 100.00;				//how much health sepiroth has (base health) (to make it auto-kill by time instead, set below var to a float)
sephlaser_sephkilltime <- null;					//62.00: dies 3 seconds before final door starts closing (good value), 61.00: dies 4 seconds before, etc...
//=========================================================================================================================================\\
introangles <- true;
viewangles <- Vector(-2,0,0);
stageorigin <- Vector();
bossarena_origin <- Vector();
ticking <- true;
enemyhpadd <- 0;
enemyhpaddboss <- 0;
bossreward <- true;
lateplayercheck <- false;
enemy_spawns <- [
					"enemies_spawner_3",		Vector(-432,56,-440),
					"enemies_spawner_2",		Vector(-432,-960,-376),
					"enemies_spawner_2",		Vector(-432,-792,-376),
					"enemies_spawner_3",		Vector(-432,0,176),
					"enemies_spawner_3",		Vector(-432,-552,56),
					"enemies_spawner_1",		Vector(-432,-384,584),
					"enemies_spawner_3",		Vector(-432,96,592),
					"enemies_spawner_3",		Vector(-432,-936,776),
					"enemies_spawner_2",		Vector(-432,-738,-376),
					"enemies_spawner_3",		Vector(-48,384,744),
					"enemies_spawner_3",		Vector(-48,776,16),
					"enemies_spawner_2",		Vector(-48,160,-824),
					"enemies_spawner_2",		Vector(-48,-648,-888),
					"enemies_spawner_2",		Vector(-48,-808,-920),
					"enemies_spawner_3",		Vector(-48,896,-600),
					"enemies_spawner_3",		Vector(-48,-496,752),
					"enemies_spawner_2",		Vector(-48,-712,-200),
					"enemies_spawner_3",		Vector(-48,-304,-472),
					"enemies_spawner_2",		Vector(336,-876,456),
					"enemies_spawner_3",		Vector(336,-216,536),
					"enemies_spawner_3",		Vector(336,896,288),
					"enemies_spawner_1",		Vector(336,468,164),
					"enemies_spawner_2",		Vector(-816,-872,-600),
					"enemies_spawner_1",		Vector(-816,-624,8),
					"enemies_spawner_3",		Vector(-816,-824,192),
					"enemies_spawner_3",		Vector(-816,176,-152),
					"enemies_spawner_2",		Vector(-816,-616,520),
					"enemies_spawner_3",		Vector(-816,608,424),
					"enemies_spawner_2",		Vector(720,312,584),
					"enemies_spawner_3",		Vector(720,-368,584),
]
function RoundStartInitStuff()
{
	stageorigin = Entities.FindByName(null,"s_lff_character").GetOrigin()+Vector(992,0,0);
	bossarena_origin = stageorigin+Vector(336,0,456);
	EntFire("tonemap_softserve","UseDefaultBloomScale","",0.00,null);
	EntFire("tonemap_softserve","UseDefaultAutoExposure","",0.00,null);
}
function Start()
{
	EntFireByHandle(self,"RunScriptCode"," Tick(); ",0.05,null,null);	
	EntFireByHandle(self,"RunScriptCode"," TickFlashlightDisable(); ",::luff_ff_fix_disable_flashlight_rate,null,null);
	EntFireByHandle(self,"RunScriptCode"," TickWeaponKiller(); ",3.00,null,null);
	EntFireByHandle(self,"RunScriptCode"," Start2(); ",0.10,null,null);	
	EntFireByHandle(self,"RunScriptCode"," TickFallDownTrig(); ",0.50,null,null);
	EntFire("tonemap_softserve","SetBloomScale","0",0.00,null);
	EntFire("Console","Command","sv_disable_radar 1",0.00,null);
	EntFire("stage_lff_template","ForceSpawn","",0.00,null);
	EntFireByHandle(self,"RunScriptCode"," TickPickCharacter(); ",0.10,null,null);
	EntFire("lff_moveplat_*","Open","",RandomFloat(2.00,7.00),null);
	EntFire("lff_moveelevator","Open","",RandomFloat(2.00,7.00),null);
	EntFire("lff_music_1","PlaySound","",3.00,null);
	EntFire("lff_music_1","Pitch","100",3.01,null);
	EntFire("lff_music_1","Pitch","100",3.05,null);
	EntFire("lff_music_1","Pitch","100",3.10,null);
	EntFire("lff_music_1","Pitch","100",4.00,null);
	EntFire("lff_introscreen","AddOutput","renderamt 0",0.00,null);
	EntFire("lff_introscreen","AddOutput","renderamt 0",0.02,null);
	EntFire("lff_introscreen","AddOutput","rendercolor 255 255 255",0.00,null);
	EntFire("lff_introscreen","AddOutput","renderamt 50",3.00,null);
	EntFire("lff_introscreen","AddOutput","renderamt 100",3.20,null);
	EntFire("lff_introscreen","AddOutput","renderamt 150",3.40,null);
	EntFire("lff_introscreen","AddOutput","renderamt 200",3.60,null);
	EntFire("lff_introscreen","AddOutput","renderamt 250",3.80,null);
	EntFire("lff_introscreen","AddOutput","renderamt 200",13.00,null);
	EntFire("lff_introscreen","AddOutput","renderamt 150",13.10,null);
	EntFire("lff_introscreen","AddOutput","renderamt 100",13.20,null);
	EntFire("lff_introscreen","AddOutput","renderamt 50",13.30,null);
	EntFire("lff_introscreen","AddOutput","renderamt 0",13.40,null);
	for(local i=0.00;i<13.80;i+=0.05){EntFire("i_lff_character_visual*","Disable","",i,null);}
	EntFire("i_lff_character_visual*","Enable","",13.80,null);
	EntFire("i_lff_character_visual*","Enable","",13.85,null);
	EntFire("i_lff_character_visual*","Enable","",13.90,null);
	EntFire("i_lff_character_visual*","Enable","",13.95,null);
	EntFire("i_lff_character_visual*","Enable","",14.00,null);
	EntFire("i_lff_character_visual*","Enable","",15.00,null);
	if(::luff_ff_fix_start_at_boss)	//#####FIX_PATCHED
	{
		::luff_ff_fix_late_forgive = false;
		EntFire("lff_late_tp","Enable","",14.00,null);
		EntFire("lff_late_tp2","Enable","",14.00,null);
		EntFire("lff_music_1","StopSound","",13.80,null);
		EntFire("lff_music_1","Volume","0",13.80,null);
		EntFire("lff_music_1","Volume","0",14.50,null);
		EntFire("lff_music_2","PlaySound","",13.70,null);
		EntFire("lff_music_2","Volume","10",13.70,null);
		EntFire("lff_music_2","Volume","10",13.90,null);
	}
	EntFire("lff_tp_menu","Enable","",14.00,null);
	EntFireByHandle(self,"RunScriptCode"," lateplayercheck = true; ",17.00,null,null);
	EntFireByHandle(self,"RunScriptCode"," introangles = false; ",13.95,null,null);
	local h=null;while(null!=(h=Entities.FindByClassname(h,"player")))
	{
		enemyhpadd += (0.00+enemy_hpadd_each_player);
		enemyhpaddboss += (0.00+enemy_hpadd_each_playerboss);
		h.__KeyValueFromString("targetname","iii_lff_nocharacter");
		h.SetAngles(0,0,0);
		EntFireByHandle(h,"AddOutput","gravity 1.00",0.00,null,null);
		h.ValidateScriptScope();
		local sc = h.GetScriptScope();
		if(("lff_killsprite" in h.GetScriptScope()))delete h.GetScriptScope().lff_killsprite;
		if(("lff_failedboss" in h.GetScriptScope()))delete h.GetScriptScope().lff_failedboss;
		if(::luff_ff_fix_start_at_boss)EntFire(h,"RunScriptCode","if(\"lff_failedboss\" in this)delete lff_failedboss;",16.00,null,null);	//#####FIX_PATCHED
	}
	if(enemyhpadd > enemy_hpadd_each_player_cap)enemyhpadd = (0.00+enemy_hpadd_each_player_cap);
	if(::luff_ff_fix_weapon_kill)//#####FIX_PATCHED
	{
		local h=null;while(null!=(h=Entities.FindByClassname(h,"weapon_*"))){if(h.FirstMoveChild()==null)EntFireByHandle(h,"Kill","",0.00,null,null);}
	}
}
function Start2()
{
	enemy_maker1 = Entities.FindByName(null,"s_lff_enemy1_maker");
	enemy_maker2 = Entities.FindByName(null,"s_lff_enemy2_maker");
	enemy_maker3 = Entities.FindByName(null,"s_lff_enemy3_maker");
	EntFireByHandle(self,"RunScriptCode"," TickEnemySpawns(); ",0.50,null,null);	
	hiteffect = Entities.FindByName(null,"s_lff_hiteffect_maker");
	if(sephlaser_sephkilltime==null)
	{
		EntFire("lff_sepiroth_touch_trig","Enable","",0.00,null);
		EntFire("lff_sepiroth_touch_trig","FireUser1","",0.00,null);
	}
	EntFire("lff_boss_touch_trig","FireUser1","",0.00,null);
	EntFire("lff_boss_sprite","DisableDraw","",0.00,null);
	EntFire("Console","Command","sv_airaccelerate 12",1.00,null);		//this is needed, else knockback gets fucked
	EntFire("lff_bossexit_platform","Open","",0.00,null);
}
function TickEnemySpawns()
{
	if(enemy_spawns.len()<=0)return;
	EntFireByHandle(self,"RunScriptCode"," TickEnemySpawns(); ",0.10,null,null);	
	local type = enemy_spawns[0];
	enemy_spawns.remove(0);
	local spos = stageorigin+enemy_spawns[0]+Vector(0,0,960);
	enemy_spawns.remove(0);
	if(type=="enemies_spawner_1")enemy_maker1.SpawnEntityAtLocation(spos,Vector());
	else if(type=="enemies_spawner_2")enemy_maker2.SpawnEntityAtLocation(spos,Vector());
	else if(type=="enemies_spawner_3")enemy_maker3.SpawnEntityAtLocation(spos,Vector());
}
function TickFallDownTrig()
{
	if(!ticking)return;
	EntFireByHandle(self,"RunScriptCode"," TickFallDownTrig(); ",0.50,null,null);	
	EntFire("lff_falldowntrigger","Disable","",0.00,null);
	EntFire("lff_falldowntrigger","Enable","",0.02,null);
	EntFire("lff_falldowntrigger","Enable","",0.05,null);
	EntFire("lff_falldowntrigger","Enable","",0.10,null);
}
function End()
{
	ticking = false;
	::luff_ff_fix_disable_flashlight = false;
	EntFire("Console","Command","sv_disable_radar 0",0.00,null);
	EntFire("tonemap_softserve","UseDefaultBloomScale","",0.00,null);
	EntFire("tonemap_softserve","UseDefaultAutoExposure","",0.00,null);
	EntFire("lff*","Kill","",0.00,null);
	EntFire("iiilff_finaldoor*","Kill","",1.00,null);
	EntFire("i_lff*","Kill","",0.00,null);
	EntFire("MuseumPrepareVotingRoom","Trigger","",0.05,null);
	EntFire("stage_lff_tp_out_winner","Enable","",0.50,null);
	if(::luff_ff_tpforgive_losing_humans)EntFire("stage_lff_tp_out_humanall","Enable","",0.60,null);
	EntFire("stage_lff_tp_out","Enable","",0.70,null);
	EntFire("predicted_viewmodel","EnableDraw","",0.00,null);
	EntFire("predicted_viewmodel","EnableDraw","",0.50,null);
	local ii_equip = 0.05;
	local h=null;while(null!=(h=Entities.FindByClassname(h,"player")))
	{
		h.SetAngles(0,0,0);
		h.__KeyValueFromString("targetname","iii_lff_nocharacter");
		EntFireByHandle(h,"AddOutput","gravity 1.00",0.00,null,null);
		if(h.GetTeam()==2)EntFireByHandle(h,"AddOutput","health 5000",0.00,null,null);
		EntFireByHandle(h,"SetDamageFilter","",0.10,null,null);
		EntFireByHandle(h,"SetDamageFilter","",0.15,null,null);
		EntFireByHandle(h,"SetDamageFilter","",0.50,null,null);
		h.ValidateScriptScope();
		local sc = h.GetScriptScope();
		if(::luff_ff_fix_invisible_models)//#####FIX_PATCHED
		{
			if(h.GetModelName()=="models/player/chinny/chinny_invis_model.mdl")
			{
				if(!("lff_pmodel" in sc))EntFireByHandle(h,"SetHealth","-1",0.00,null,null);
				else h.SetModel(sc.lff_pmodel);
			}
		}
		EntFireByHandle(h,"AddOutput","rendermode 0",0.00,null,null);//#####FIX_PATCHED
		EntFireByHandle(h,"AddOutput","rendermode 0",0.10,null,null);//#####FIX_PATCHED
		EntFireByHandle(h,"AddOutput","rendermode 0",1.00,null,null);//#####FIX_PATCHED
		EntFireByHandle(self,"RunScriptCode"," EndWeaponEquip(); ",ii_equip,h,null);
		ii_equip += 0.05;
	}
}
function EndWeaponEquip()
{
	//TODO - some servers uses AmmoFix.smx which seems to fuck up "Use" on game_player_equip, will it happen here? what to do?
	if(activator==null||!activator.IsValid())return;
	if(activator.GetTeam()==3)EntFire("stage_lff_exit_equip_ct","Use","",0.00,activator);
	else if(activator.GetHealth()>0)EntFire("stage_lff_exit_equip_t","Use","",0.00,activator);
}
function TouchedMenuTP()
{
	if(!lateplayercheck)return;
	if(activator==null||!activator.IsValid())return;
	activator.ValidateScriptScope();
	activator.GetScriptScope().lff_failedboss <- true;
}
function ReachedReactor()
{
	local delay = 8.00;
	EntFire("lff_music_1","FadeOut","2",delay,null);
	EntFire("lff_music_2","PlaySound","",delay,null);
	EntFire("lff_music_2","Pitch","100",delay+0.01,null);
	EntFire("lff_music_2","Pitch","100",delay+0.05,null);
	EntFire("lff_music_2","Pitch","100",delay+0.10,null);
	EntFire("lff_music_2","Pitch","100",delay+0.00,null);
	EntFire("lff_music_2","Volume","10",delay+0.01,null);
	EntFire("lff_music_2","Volume","10",delay+0.02,null);
	EntFire("lff_music_2","Volume","10",delay+0.05,null);
}
function ReachedBoss()
{
	EntFireByHandle(self,"RunScriptCode"," StartBoss(); ",::luff_ff_boss_start_delay,null,null);
	EntFire("Console","Command","say ***YOU HAVE REACHED THE REACTOR CORE***",0.00,null);
	EntFire("Console","Command","say ***PLANTING BOMB...***",1.00,null);
}
function StartBoss()
{
	EntFire("lff_boss_sprite","EnableDraw","",4.00,null);
	EntFire("lff_boss_mover_up","Close","",4.00,null);
	EntFire("lff_boss_touch_trig","Enable","",4.00,null);
	//#####FIX_PATCHED - made it so that the late TP kills ct's:
		EntFire("lff_late_tp","AddOutput","OnStartTouch stage_lff_manager:RunScriptCode:LateTpTouched();:0:-1",4.00,null);
		EntFire("lff_late_tp2","AddOutput","OnStartTouch stage_lff_manager:RunScriptCode:LateTpTouched();:0:-1",4.00,null);
	EntFire("lff_late_tp","Enable","",5.00,null);
	EntFire("lff_late_tp2","Enable","",5.00,null);
	EntFire("Console","Command","say ***SOMETHING IS COMING***",0.00,null);
	EntFire("Console","Command","say ***GET READY***",1.00,null);
	EntFire("lff_music_2","FadeOut","5",0.00,null);
	EntFire("lff_music_3","PlaySound","",4.00,null);
	local delay = 4.00;
	EntFire("lff_music_3","Pitch","100",delay+0.01,null);
	EntFire("lff_music_3","Pitch","100",delay+0.05,null);
	EntFire("lff_music_3","Pitch","100",delay+0.10,null);
	EntFire("lff_music_3","Pitch","100",delay+0.00,null);
	EntFire("lff_music_3","Volume","10",delay+0.01,null);
	EntFire("lff_music_3","Volume","10",delay+0.02,null);
	EntFire("lff_music_3","Volume","10",delay+0.05,null);
	EntFireByHandle(self,"RunScriptCode"," idleanim = 2; ",4.20,null,null);
	EntFire("lff_boss_touch_trig","FireUser3","",boss_auto_defeat_time,null);
	EntFireByHandle(self,"RunScriptCode"," bossreward = false; ",boss_auto_defeat_time-0.10,null,null);
	EntFireByHandle(self,"RunScriptCode"," RunBossAttack(); ",RandomFloat(8.00,10.00),null,null);
	EntFireByHandle(self,"RunScriptCode"," BossMove(); ",RandomFloat(8.00,15.00),null,null);
	bosshandle = Entities.FindByName(null,"lff_boss_sprite");
	bosspos = bosshandle.GetOrigin()+Vector(-296,0,0);
	bosslaser_maker = Entities.FindByName(null,"s_lff_bosslaser_maker");
}
boss_attack_attackable <- false;
bossdead <- false;
::lff_bossdead <- false;
bosshandle <- null;
bosspos <- Vector();
bosslaser_maker <- null;
enemy_maker1 <- null;
enemy_maker2 <- null;
enemy_maker3 <- null;
function RunBossAttack()
{
	if(bossdead)return;
	boss_attack_attackable = !boss_attack_attackable;
	if(!boss_attack_attackable)
	{
		EntFire("lff_boss_sprite","Open","",0.00,null);
		EntFireByHandle(self,"RunScriptCode"," RunBossAttack(); ",RandomFloat(4.00,6.00),null,null);
	}
	else
	{
		EntFire("lff_boss_sprite","Close","",0.00,null);
		local minionrand = 1;if(boss_minionspawnrng<=0)minionrand=0;
		local rand = RandomInt(1,5+minionrand);
		if(rand==1)rand = RandomInt(1,5+minionrand);
		if(rand==5)rand = RandomInt(1,5+minionrand);
		if(rand==5)rand = RandomInt(1,5+minionrand);
		if(rand==1)
		{
			EntFireByHandle(self,"RunScriptCode"," RunBossAttack(); ",RandomFloat(7.00,9.00),null,null);
			EntFire("lff_boss_mover_up","Open","",0.00,null);
			EntFire("lff_boss_mover_up","Close","",8.00,null);
			local rev = 32.8;
			local revang = 180;
			local revangpos = 400;
			local ii = -984.00;
			if(RandomInt(0,1)==1){rev = -32.8;ii=984;}
			if(RandomInt(0,1)==1){revang = 0;revangpos= -100}
			for(local i=1.00;i<6.50;i+=0.10)
			{
				ii += rev;
				EntFireByHandle(bosslaser_maker,"RunScriptCode"," if(!::lff_bossdead)self.SpawnEntityAtLocation(Vector("+
				bossarena_origin.x.tointeger().tostring()+","+(bossarena_origin.y+ii).tointeger().tostring()+","+
				(bossarena_origin.z+revangpos).tointeger().tostring()+"),Vector(0,0,"+revang.tointeger().tostring()+")); ",i,null,null);
			}
		}
		else if(rand==2)
		{
			EntFireByHandle(self,"RunScriptCode"," RunBossAttack(); ",RandomFloat(1.80,2.00),null,null);
			for(local i=0.01;i<2.00;i+=0.30)
			{
				EntFireByHandle(self,"RunScriptCode"," FireBossMissile(); ",i,null,null);
			}
		}
		else if(rand==3)
		{
			EntFireByHandle(self,"RunScriptCode"," RunBossAttack(); ",RandomFloat(1.80,2.00),null,null);
			for(local i=0.01;i<2.00;i+=0.30)
			{
				EntFireByHandle(self,"RunScriptCode"," FireBossGrenade(); ",i,null,null);
			}
		}
		else if(rand==4)
		{
			EntFireByHandle(self,"RunScriptCode"," RunBossAttack(); ",RandomFloat(1.80,2.00),null,null);
			for(local i=0.01;i<2.00;i+=0.30)
			{
				EntFireByHandle(self,"RunScriptCode"," FireBossMissile(true); ",i,null,null);
			}
		}
		else if(rand==5)
		{
			EntFireByHandle(self,"RunScriptCode"," RunBossAttack(); ",RandomFloat(2.00,3.00),null,null);
			for(local i=0.01;i<2.00;i+=0.40)
			{
				EntFireByHandle(self,"RunScriptCode",
				" bosslaser_maker.SpawnEntityAtLocation(bossarena_origin+Vector(0,-1024,90),Vector(0,0,-90)); ",i,null,null);
				EntFireByHandle(self,"RunScriptCode",
				" bosslaser_maker.SpawnEntityAtLocation(bossarena_origin+Vector(0,1024,90),Vector(0,0,90)); ",i,null,null);
			}
		}
		else if(rand==6)
		{
			EntFireByHandle(self,"RunScriptCode"," RunBossAttack(); ",RandomFloat(0.50,2.00),null,null);
			boss_minionspawnrng--;
			local spos = bossarena_origin+Vector(0,RandomInt(-950,950),0);
			local type = RandomInt(1,3);
			if(type==1)type = RandomInt(1,3);
			if(type==3)spos.z += 32;
			if(type==1)enemy_maker1.SpawnEntityAtLocation(spos,Vector());
			else if(type==2)enemy_maker2.SpawnEntityAtLocation(spos,Vector());
			else if(type==3)enemy_maker3.SpawnEntityAtLocation(spos,Vector());
		}
	}
	//bosspos				center of boss (can spawn shit relative to this)
	//bossarena_origin		(+- 984 Y   /   + 208 Z for spawning above the entire arena   /   + 400 Z if spawning shit in middle)
}
function BossMove()
{
	if(bossdead)return;
	local rand = RandomInt(1,5);
	if(rand==1)
	{
		EntFire("lff_boss_mover_left","Open","",0.00,null);
		EntFire("lff_boss_mover_left","Close","",4.50,null);
		EntFireByHandle(self,"RunScriptCode"," BossMove(); ",RandomFloat(9.50,15.00),null,null);
	}
	else if(rand==2)
	{
		EntFire("lff_boss_mover_right","Open","",0.00,null);
		EntFire("lff_boss_mover_right","Close","",4.50,null);
		EntFireByHandle(self,"RunScriptCode"," BossMove(); ",RandomFloat(9.50,15.00),null,null);
	}
	else EntFireByHandle(self,"RunScriptCode"," BossMove(); ",RandomFloat(0.50,5.00),null,null);
}
function FireBossMissile(rand=false)
{
	if(!rand)
	{
		bosspos = bosshandle.GetOrigin()+Vector(-296,0,0);
		local targets = [];
		local h=null;while(null!=(h=Entities.FindByClassname(h,"player")))
		{
			if(h==null||!h.IsValid()||h.GetHealth()<=0.00)continue;
			targets.push(h);
		}
		if(targets.len()<=0)return;
		local target = targets[RandomInt(0,targets.len()-1)];
		ShootMissile(bosspos+Vector(0,RandomInt(-96,96),RandomInt(80,140)),target.GetOrigin()+Vector(0,0,48),missile_speed);
		return;
	}
	if(missile_maker==null)missile_maker=Entities.FindByName(null,"s_lff_missile_maker");
	missile_maker.SpawnEntityAtLocation(bossarena_origin+Vector(0,0,400),Vector(0,0,RandomFloat(100,260)));
}
function FireBossGrenade()
{
	bosspos = bosshandle.GetOrigin()+Vector(-296,0,0);
	if(grenade_maker==null)grenade_maker=Entities.FindByName(null,"s_lff_grenade_maker");
	grenade_maker.SpawnEntityAtLocation(bosspos+Vector(0,RandomInt(-96,96),RandomInt(80,140)),Vector(0,0,RandomFloat(-90,90)));
}
function PlayerTouchedBossLaserWaah()
{
	local leftright = 1.00;		//-1.00 = left,	1.00 = right (use as multiplier for knockback side-dir)
	if(activator.GetOrigin().y<caller.GetOrigin().y)leftright = -1.00;
	Damage(activator,bosslaser_damage);
	Knockback(activator,100*leftright,0,false);
	activator.SetOrigin(activator.GetOrigin()+Vector(0,0,2));
}
function KilledBoss()
{
	bossdead = true;
	::lff_bossdead = true;
	EntFire("i_lff_bosslaser*","Kill","",0.00,null);
	EntFire("i_lff_bosslaser*","Kill","",0.50,null);
	EntFire("lff_boss_touch_trig","Disable","",0.00,null);
	EntFire("lff_late_tp2","Disable","",0.00,null);
	EntFire("Console","Command","say ***THE SCORPION GUARD HAS BEEN DEFEATED***",0.00,null);
	EntFire("Console","Command","say ***THIS PLACE IS ABOUT TO BLOW***",1.00,null);
	EntFire("Console","Command","say ***GET OUT OF HERE FAST***",2.00,null);
	if(::luff_ff_fix_start_at_boss)	//#####FIX_PATCHED
	{
		if(bossreward)
			EntFire("Console","Command","say ***(PLAYERS WHO DIDN'T DIE GOT A HEALTH REWARD)***",3.00,null);
		else
			EntFire("Console","Command","say ***(BOSS DIED SINCE YOU TOOK TOO LONG - NO HEALTH REWARD)***",3.00,null);
	}
	else
	{
		if(bossreward)
			EntFire("Console","Command","say ***(PLAYERS WHO DIDN'T DIE/WEREN'T LATE GOT A HEALTH REWARD)***",3.00,null);
		else
			EntFire("Console","Command","say ***(BOSS DIED SINCE YOU TOOK TOO LONG - NO HEALTH REWARD)***",3.00,null);
	}
	//#####FIX_PATCHED - TP doorhuggers who are on the far left
	for(local h;h=Entities.FindByClassnameWithin(h,"player",::luff_ff_fix_bosshug_pos,::luff_ff_fix_bosshug_tp_range);)
	{
		if(h==null||!h.IsValid()||h.GetHealth()<=0)continue;
		h.SetOrigin(::luff_ff_fix_bosshug_pos+Vector(0,-::luff_ff_fix_bosshug_tp_dist,10));
	}
	EntFireByHandle(self,"RunScriptCode"," idleanim = 0; ",2.00,null,null);
	EntFire("lff_bossexit_platform","Close","",0.00,null);
	EntFire("lff_sound_bossdeath","PlaySound","",0.00,null);
	EntFire("lff_bossexit_break","Break","",0.00,null);
	EntFire("lff_music_3","FadeOut","2",musdelay+3.50,null);
	EntFire("lff_music_4","PlaySound","",musdelay+5.00,null);
	EntFire("lff_music_4","Pitch","100",musdelay+5.01,null);
	EntFire("lff_music_4","Pitch","100",musdelay+5.05,null);
	EntFire("lff_music_4","Pitch","100",musdelay+5.10,null);
	EntFire("lff_music_4","Pitch","100",musdelay+5.00,null);
	EntFire("lff_music_4","Volume","10",musdelay+5.01,null);
	EntFire("lff_music_4","Volume","10",musdelay+5.02,null);
	EntFire("lff_music_4","Volume","10",musdelay+5.05,null);
	EntFire("lff_finaldoor","Close","",musdelay+65.00,null);
	EntFire("lff_finaldoor","AddOutput","targetname iiilff_finaldoor",musdelay+65.20,null);
	EntFire("lff_late_tp","Disable","",musdelay+late_tp_end_delay+0.10,null);
	EntFire("lff_late_tp3","Enable","",musdelay+late_tp_end_delay,null);
	if(sephlaser_sephkilltime!=null)EntFire("lff_sepiroth_touch_trig","FireUser3","",musdelay+sephlaser_sephkilltime,null);
	EntFireByHandle(self,"RunScriptCode"," CheckEnd(); ",musdelay+70.20,null,null);	
	EntFireByHandle(self,"RunScriptCode"," FiddleSecretSprite(); ",musdelay+79.90,null,null);
	EntFireByHandle(self,"RunScriptCode"," End(); ",musdelay+80.50,null,null);
	local timer = Entities.FindByName(null,"lff_bombtimer");
	timer.__KeyValueFromFloat("x",-1);
	timer.__KeyValueFromFloat("y",0.10);
	timer.__KeyValueFromFloat("y",0.10);
	local ii = 0.00;
	for(local i=(65+musdelay.tointeger());i>=0;i--)
	{
		local time = (0+i);
		if(time < 10)time = "0"+time.tostring();
		else time = time.tostring();
		EntFireByHandle(timer,"AddOutput","message BOMB "+time,ii,null,null);
		EntFireByHandle(timer,"Display","",i+0.05,null,null);
		ii++;
	}
	TickDebris();
	EntFire("lff_boss_sprite","ClearParent","",0.00,null);
	EntFire("lff_boss_sprite","AddOutput","rendermode 2",0.00,null);
	EntFire("lff_boss_sprite","AddOutput","renderamt 254",0.00,null);
	EntFire("lff_boss_sprite","AddOutput","rendercolor 255 255 255",0.00,null);
	local ii = 0.00;
	for(local i=254;i>0;i--)
	{
		ii += 0.01;
		EntFire("lff_boss_sprite","AddOutput","rendercolor 255 "+i.tostring()+" "+i.tostring(),ii,null);
		local alp = (0+i);
		if(alp<178)alp=178;
		EntFire("lff_boss_sprite","AddOutput","renderamt "+alp.tostring(),ii,null);
	}
	ii+=0.05;EntFire("lff_boss_sprite","Kill","",ii,null);
	if(!bossreward)return;
	local h=null;while(null!=(h=Entities.FindByClassname(h,"player")))
	{
		h.ValidateScriptScope();
		if(("lff_health" in h.GetScriptScope()))
		{
			if(("lff_failedboss" in h.GetScriptScope()))continue;
			h.GetScriptScope().lff_health += (0.00+guardkill_winner_hpadd);
		}
	}
}
debristicking <- true;
debris_maker <- null;
debris_positions <-[Vector(96,-160,1912),
					Vector(96,-320,1912),
					Vector(96,-480,1912),
					Vector(96,-640,1912),
					Vector(96,-800,1912),
					Vector(96,-950,1912),
					Vector(96,-480,1200),
					Vector(96,-640,1200),
					Vector(96,-800,1200),
					Vector(96,-950,1200),
					Vector(480,0,1912),
					Vector(480,160,1912),
					Vector(480,320,1912),
					Vector(480,480,1912),
					Vector(480,640,1912),
					Vector(480,800,1912),
					Vector(480,950,1912),
					Vector(480,-160,1912),
					Vector(480,-320,1912),
					Vector(480,-480,1912),
					Vector(480,-640,1912),
					Vector(480,-800,1912),
					Vector(480,-950,1912),
					Vector(864,640,1912),
					Vector(864,800,1912),
					Vector(864,950,1912)];
function TickDebris()
{
	if(!debristicking)return;
	EntFireByHandle(self,"RunScriptCode"," TickDebris(); ",RandomFloat(0.10,0.80),null,null);
	if(debris_maker==null)debris_maker = Entities.FindByName(null,"s_lff_debris_maker");
	debris_maker.SpawnEntityAtLocation(stageorigin+debris_positions[RandomInt(0,debris_positions.len()-1)],Vector());
	EntFire("i_lff_debris*","Break","",0.00,null);
}
sephlasers <- true;
function KillSepiroth()
{
	sephlasers = false;
	EntFireByHandle(self,"RunScriptCode"," idleanim = 0; ",0.50,null,null);
	EntFire("lff_sepiroth_hurt_trig","Kill","",0.00,null);
	EntFire("lff_sound_bossdeath","PlaySound","",0.00,null);
	EntFire("lff_sepiroth_sprite","Toggle","",0.00,null);
	EntFire("lff_sepiroth_sprite","AddOutput","rendermode 2",0.00,null);
	EntFire("lff_sepiroth_sprite","AddOutput","renderamt 254",0.00,null);
	EntFire("lff_sepiroth_sprite","AddOutput","rendercolor 255 255 255",0.00,null);
	local ii = 0.00;
	for(local i=254;i>0;i--)
	{
		ii += 0.01;
		EntFire("lff_sepiroth_sprite","AddOutput","rendercolor 255 "+i.tostring()+" "+i.tostring(),ii,null);
		local alp = (0+i);
		if(alp<178)alp=178;
		EntFire("lff_sepiroth_sprite","AddOutput","renderamt "+alp.tostring(),ii,null);
	}
	ii+=0.05;EntFire("lff_sepiroth_sprite","Kill","",ii,null);
}
function TickSepirothLaser()
{
	if(!sephlasers)return;
	EntFireByHandle(self,"RunScriptCode"," TickSepirothLaser(); ",sephlaser_rate,null,null);
	EntFire("lff_sepiroth_laser_"+(sephlaser_chances[RandomInt(0,sephlaser_chances.len()-1)]).tostring(),"ForceSpawn","",0.00,null);
}
function SephirothLaserTouched()
{
	Damage(activator,sephlaser_damage);
	Knockback(activator,600,200,true);
	activator.SetOrigin(activator.GetOrigin()+Vector(0,0,2));
}
missile_speedqueue <- [];
function InitMissile()
{
	local speed = (0.00+missile_speed);
	if(missile_speedqueue.len()>0)
	{
		speed = missile_speedqueue[0];
		missile_speedqueue.remove(0);
	}
	EntFireByHandle(caller,"SetSpeed",speed.tointeger().tostring(),0.00,null,null);
	EntFireByHandle(caller,"Open","",0.01,null,null);
	EntFireByHandle(caller,"SetSpeed",speed.tointeger().tostring(),0.02,null,null);
	EntFireByHandle(caller,"SetSpeed",speed.tointeger().tostring(),0.05,null,null);
	EntFireByHandle(self,"RunScriptCode"," TickMissile(); ",0.02,caller,null);
	caller.ValidateScriptScope();
	caller.GetScriptScope().lastpos <- caller.GetOrigin();
	caller.GetScriptScope().hitplayer <- false;
}
function MissileHitPlayer()
{
	if(caller==null||!caller.IsValid())return;
	caller.ValidateScriptScope();
	if(caller.GetScriptScope().hitplayer)return;
	caller.GetScriptScope().hitplayer = true;
	EntFireByHandle(caller,"FireUser4","",0.00,null,null);
	if(explosion_maker==null)explosion_maker=Entities.FindByName(null,"s_lff_explosion_maker");
	explosion_maker.SpawnEntityAtLocation(caller.GetOrigin(),Vector());
}
function TickMissile()
{
	if(activator==null||!activator.IsValid())return;
	EntFireByHandle(self,"RunScriptCode"," TickMissile(); ",0.10,activator,null);
	activator.ValidateScriptScope();
	if(activator.GetScriptScope().hitplayer)return;
	local trace = TraceLine(activator.GetScriptScope().lastpos,activator.GetOrigin()+(activator.GetUpVector()*16),null);
	if(trace < 1.00)
	{
		EntFireByHandle(activator,"FireUser4","",0.00,null,null);
		activator.GetScriptScope().hitplayer = true;
		if(explosion_maker==null)explosion_maker=Entities.FindByName(null,"s_lff_explosion_maker");
		trace-=0.01;if(trace<=0.01)trace=0.01;
		local spos = activator.GetScriptScope().lastpos+(activator.GetUpVector()*
		((GetDistance(activator.GetScriptScope().lastpos,activator.GetOrigin())*trace)));
		spos.x = activator.GetOrigin().x;
		explosion_maker.SpawnEntityAtLocation(spos,Vector());
	}
	else activator.GetScriptScope().lastpos = activator.GetOrigin();
}
function GetDistance(v1,v2){return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));}
missile_maker <- null;
explosion_maker <- null;
function ShootMissile(pos,targetpos,speed=null)
{
	if(missile_maker==null)missile_maker=Entities.FindByName(null,"s_lff_missile_maker");
	if(speed==null)speed = (0.00+missile_speed);
	local targetrot = 0;
	targetpos.x=(0+pos.x);
	local targdir=(targetpos-pos);
	if(targetpos.y>pos.y)targdir=(pos-targetpos);
	targdir.Norm();
	missile_maker.SetForwardVector(targdir);
	targetrot=missile_maker.GetAngles().x;
	if(targetpos.y>pos.y)targetrot-=90;else targetrot-=270;
	missile_speedqueue.push(speed);
	missile_maker.SpawnEntityAtLocation(pos,Vector(0,0,targetrot));
}
function TouchedFallDownTrigger()
{
	Damage(activator,damage_falldown);
	Knockback(activator,null,430,true);
}
hiteffect <- null;
hiteffect_iscd <- false;
function TouchedBadThing()
{
	if(activator==null||!activator.IsValid())return;
	if(caller==null||!caller.IsValid())return;
	local leftright = 1.00;		//-1.00 = left,	1.00 = right (use as multiplier for knockback side-dir)
	if(activator.GetOrigin().y<caller.GetOrigin().y)leftright = -1.00;
	if(caller.GetPreTemplateName()=="i_lff_explosion_touchtrigger")
	{
		Damage(activator,damage_explosion);
		Knockback(activator,300*leftright,251,true);
	}
	else if(caller.GetPreTemplateName()=="i_lff_enemy1_touchtrigger")
	{
		if(caller.GetOrigin().z < activator.GetOrigin().z && activator.GetVelocity().z < -1)
		{
			DamageBadThing(caller);
			Knockback(activator,200*leftright,200,true);
			if(!hiteffect_iscd){hiteffect_iscd=true;EntFireByHandle(self,"RunScriptCode"," hiteffect_iscd=false; ",hiteffect_cd,null,null);
			hiteffect.SpawnEntityAtLocation(activator.GetOrigin()+Vector(0,0,16),Vector(0,0,RandomInt(0,360)));}
		}
		else
		{
			Damage(activator,damage_touch_enemy1);
			Knockback(activator,600*leftright,251,true);
		}
	}
	else if(caller.GetPreTemplateName()=="i_lff_enemy2_touchtrigger")
	{
		if(caller.GetOrigin().z < activator.GetOrigin().z && activator.GetVelocity().z < -1)
		{
			DamageBadThing(caller);
			Knockback(activator,200*leftright,200,true);
			if(!hiteffect_iscd){hiteffect_iscd=true;EntFireByHandle(self,"RunScriptCode"," hiteffect_iscd=false; ",hiteffect_cd,null,null);
			hiteffect.SpawnEntityAtLocation(activator.GetOrigin()+Vector(0,0,16),Vector(0,0,RandomInt(0,360)));}
		}
		else
		{
			Damage(activator,damage_touch_enemy2);
			Knockback(activator,300*leftright,251,true);
		}
	}
	else if(caller.GetPreTemplateName()=="i_lff_enemy3_touchtrigger")
	{
		if(caller.GetOrigin().z < activator.GetOrigin().z && activator.GetVelocity().z < -1)
		{
			DamageBadThing(caller);
			Knockback(activator,null,300,true);
			if(!hiteffect_iscd){hiteffect_iscd=true;EntFireByHandle(self,"RunScriptCode"," hiteffect_iscd=false; ",hiteffect_cd,null,null);
			hiteffect.SpawnEntityAtLocation(activator.GetOrigin()+Vector(0,0,16),Vector(0,0,RandomInt(0,360)));}
		}
		else
		{
			Damage(activator,damage_touch_enemy3);
			Knockback(activator,300*leftright,50,true);
		}
	}
	else if(caller.GetPreTemplateName()=="lff_sepiroth_touch_trig")
	{
		if(caller.GetOrigin().z < activator.GetOrigin().z && activator.GetVelocity().z < -1)
		{
			DamageBadThing(caller);
			Knockback(activator,600,100,true);
			if(!hiteffect_iscd){hiteffect_iscd=true;EntFireByHandle(self,"RunScriptCode"," hiteffect_iscd=false; ",hiteffect_cd,null,null);
			hiteffect.SpawnEntityAtLocation(activator.GetOrigin()+Vector(0,0,16),Vector(0,0,RandomInt(0,360)));}
		}
		else
		{
			Damage(activator,damage_touch_sepiroth);
			Knockback(activator,700*leftright,251,true);
		}
	}
	else if(caller.GetPreTemplateName()=="lff_boss_touch_trig")
	{
		if(caller.GetOrigin().z < activator.GetOrigin().z && activator.GetVelocity().z < -1)
		{
			DamageBadThing(caller);
			Knockback(activator,600*leftright,100,true);
			if(!hiteffect_iscd){hiteffect_iscd=true;EntFireByHandle(self,"RunScriptCode"," hiteffect_iscd=false; ",hiteffect_cd,null,null);
			hiteffect.SpawnEntityAtLocation(activator.GetOrigin()+Vector(0,0,16),Vector(0,0,RandomInt(0,360)));}
		}
		else
		{
			Damage(activator,damage_touch_boss);
			Knockback(activator,700*leftright,251,true);
		}
	}
}
function TouchedBadThingTarget()
{
	if(activator==null||!activator.IsValid())return;
	if(caller==null||!caller.IsValid())return;
	if(caller.GetMoveParent()==null||!caller.GetMoveParent().IsValid())return;
	caller.GetMoveParent().ValidateScriptScope();
	caller.GetMoveParent().GetScriptScope().targetlist.push(activator);
	EntFireByHandle(self,"RunScriptCode"," TickBadThingTarget(); ",RandomFloat(0.10,5.00),null,caller);
}
function GrenadePinPull()
{
	EntFireByHandle(caller,"FireUser1","",grenade_blow_time,null,null);
}
function TickBadThingTarget()
{
	if(caller==null||!caller.IsValid())return;
	if(caller.FirstMoveChild()==null||!caller.FirstMoveChild().IsValid())return;
	if(caller.GetScriptScope().dead)return;
	if(caller.GetPreTemplateName()=="i_lff_enemy2_touchtrigger")
		EntFireByHandle(self,"RunScriptCode"," TickBadThingTarget(); ",RandomFloat(enemy2_target_rate_min,enemy2_target_rate_max),null,caller);
	else
		EntFireByHandle(self,"RunScriptCode"," TickBadThingTarget(); ",RandomFloat(enemy3_target_rate_min,enemy3_target_rate_max),null,caller);
	EntFireByHandle(caller.FirstMoveChild(),"Enable","",0.00,null,null);
	EntFireByHandle(caller.FirstMoveChild(),"Disable","",0.06,null,null);
	EntFireByHandle(self,"RunScriptCode"," CheckBadThingTargetPost(); ",0.08,null,caller);
}
function CheckBadThingTargetPost()
{
	if(caller==null||!caller.IsValid())return;
	caller.ValidateScriptScope();
	local sc = caller.GetScriptScope();
	if(sc.targetlist.len() <= 0)return;
	local candlist = [];
	foreach(h in sc.targetlist){if(TraceLine(caller.GetOrigin(),h.GetOrigin()+Vector(0,0,48),null)==1.00)candlist.push(h);}
	sc.targetlist.clear();
	if(candlist.len() <= 0)return;
	local target = candlist[RandomInt(0,candlist.len()-1)];
	if(grenade_maker==null)grenade_maker=Entities.FindByName(null,"s_lff_grenade_maker");
	if(caller.GetPreTemplateName()=="i_lff_enemy2_touchtrigger")
		grenade_maker.SpawnEntityAtLocation(caller.GetOrigin()+Vector(0,0,32),Vector(0,0,RandomFloat(-90,90)));
	else
		ShootMissile(caller.GetOrigin(),target.GetOrigin()+Vector(0,0,48),missile_speed);
}
grenade_maker <- null;
function InitializeBadThing()
{
	if(caller==null||!caller.IsValid())return;
	caller.ValidateScriptScope();
	caller.GetScriptScope().health <- 100.00;
	caller.GetScriptScope().dead <- false;
	local targeter = false;
	if(caller.GetPreTemplateName()=="lff_sepiroth_touch_trig")
	{
		local shpadd = (0.00+sephlaser_seph_health+enemyhpadd);
		if(shpadd > enemy_hpadd_each_player_septhcap)shpadd=(0.00+enemy_hpadd_each_player_septhcap);
		caller.GetScriptScope().health = (0.00+shpadd);
	}
	if(caller.GetPreTemplateName()=="lff_boss_touch_trig")
	{
		local shpadd = (0.00+boss_health+enemyhpaddboss);
		if(shpadd > enemy_hpadd_each_player_bosscap)shpadd=(0.00+enemy_hpadd_each_player_bosscap);
		caller.GetScriptScope().health = (0.00+shpadd);
	}
	else if(caller.GetPreTemplateName()=="i_lff_enemy1_touchtrigger")caller.GetScriptScope().health = (0.00+health_enemy1+enemyhpadd);
	else if(caller.GetPreTemplateName()=="i_lff_enemy2_touchtrigger"){caller.GetScriptScope().health = (0.00+health_enemy2+enemyhpadd);targeter=true;}
	else if(caller.GetPreTemplateName()=="i_lff_enemy3_touchtrigger"){caller.GetScriptScope().health = (0.00+health_enemy3+enemyhpadd);targeter=true;}
	if(targeter)
	{
		caller.GetScriptScope().targetlist <- [];
		EntFireByHandle(self,"RunScriptCode"," TickBadThingTarget(); ",RandomFloat(0.10,5.00),null,caller);
	}
}
function DamageBadThing(handle)
{
	if(handle==null||!handle.IsValid())return;
	handle.ValidateScriptScope();
	if(handle.GetScriptScope().dead)return;
	handle.GetScriptScope().health -= ::luff_ff_jump_damage;
	if(handle.GetScriptScope().health <= 0.00)
	{
		handle.GetScriptScope().dead = true;
		EntFireByHandle(handle,"Disable","",0.00,null,null);
		EntFireByHandle(handle,"FireUser3","",0.00,null,null);
		if(handle.GetPreTemplateName()=="lff_sepiroth_touch_trig")return;
		local visual = handle.GetMoveParent();
		EntFireByHandle(visual,"AddOutput","rendermode 2",0.00,null,null);
		EntFireByHandle(visual,"AddOutput","renderamt 254",0.00,null,null);
		EntFireByHandle(visual,"AddOutput","rendercolor 255 255 255",0.00,null,null);
		local ii = 0.00;
		for(local i=254;i>0;i-=2)
		{
			ii += 0.01;
			EntFireByHandle(visual,"AddOutput","rendercolor 255 "+i.tostring()+" "+i.tostring(),ii,null,null);
			local alp = (0+i);
			if(alp<178)alp=178;
			EntFireByHandle(visual,"AddOutput","renderamt "+alp.tostring(),ii,null,null);
		}
		ii+=0.05;EntFireByHandle(handle,"FireUser2","",ii,null,null);
	}
}
function ExplodeMeDaddy()
{
	if(caller==null||!caller.IsValid())return;
	EntFireByHandle(caller,"Kill","",0.40,null,null);
	EntFireByHandle(caller,"AddOutput","rendermode 2",0.00,null,null);
	EntFireByHandle(caller,"AddOutput","renderamt 254",0.00,null,null);
	local ii = 255;
	for(local i=0.00;i<0.38;i+=0.02)
	{
		ii -= 5;
		EntFireByHandle(caller,"RunScriptCode"," self.SetAngles(0,0,RandomInt(0,360)); ",i,null,null);
		EntFireByHandle(caller,"AddOutput","rendercolor "+ii.tostring()+" "+ii.tostring()+" "+ii.tostring(),i,null,null);
		local alp=(0+ii);if(alp<178)alp=178;
		EntFireByHandle(caller,"AddOutput","renderamt "+alp.tostring(),i,null,null);
	}
}
secrettrail <- null;
secrettrail_owner <- null;
function SecretTrig()
{
	secrettrail = Entities.FindByName(null,"lff_trailsecret");
	local sprite = Entities.FindByNameNearest("i_lff_character_visual*",secrettrail.GetOrigin(),64);
	if(sprite==null)return;
	secrettrail.SetOrigin(sprite.GetOrigin()+Vector(2,0,2));
	EntFireByHandle(secrettrail,"SetParent","!activator",0.00,sprite,null);
	EntFireByHandle(secrettrail,"SetScale","1.00",0.00,null,null);
	secrettrail_owner = sprite.GetMoveParent();
	secrettrail.__KeyValueFromString("targetname","hahalffsecret");
}
function FiddleSecretSprite()
{
	if(secrettrail==null||!secrettrail.IsValid())return;
	if(secrettrail_owner==null||!secrettrail_owner.IsValid())return;
	EntFireByHandle(secrettrail_owner,"AddOutput","movetype 0",0.00,null,null);
	EntFireByHandle(secrettrail_owner,"AddOutput","movetype 2",0.10,null,null);
	EntFireByHandle(secrettrail,"ClearParent","",0.00,null,null);
	local ppos = "origin "+secrettrail_owner.GetOrigin().x.tostring()+
	" "+secrettrail_owner.GetOrigin().y.tostring()+" "+(secrettrail_owner.GetOrigin().z+2).tostring();
	EntFireByHandle(secrettrail,"AddOutput",ppos,0.04,null,null);
	EntFireByHandle(secrettrail,"SetParent","!activator",0.07,secrettrail_owner,null);
}
function ReachedFinalBridge()
{
	EntFireByHandle(self,"RunScriptCode"," idleanim = 2; ",5.00,null,null);
	EntFire("lff_sepiroth_sprite","Toggle","",6.50,null);
	EntFireByHandle(self,"RunScriptCode"," TickSepirothLaser(); ",6.50,null,null);
	EntFireByHandle(self,"RunScriptCode"," debristicking = false; ",8.00,null,null);
}
function CheckEnd()
{
	local foundwinner = false;
	local h=null;while(null!=(h=Entities.FindByClassnameWithin(h,"player",stageorigin+Vector(720,-928,320),150)))
	{
		if(h==null||!h.IsValid())continue;
		if(h.GetHealth()<=0.00)continue;
		if(h.GetTeam()!=2&&h.GetTeam()!=3)continue;
		if(h.GetOrigin().x < stageorigin.x+688)continue;
		if(h.GetOrigin().y > stageorigin.y-840)continue;
		foundwinner = true;
	}
	EntFire("lff_music_4","Volume","0",0.00,null);
	if(!foundwinner)
	{
		EntFire("lff_music_6","PlaySound","",0.00,null);
		EntFire("lff_music_6","Pitch","100",0.01,null);
		EntFire("lff_music_6","Pitch","100",0.05,null);
		EntFire("lff_music_6","Pitch","100",0.10,null);
		EntFire("lff_music_6","Pitch","100",0.00,null);
		EntFire("lff_music_6","Volume","10",0.01,null);
		EntFire("lff_music_6","Volume","10",0.02,null);
		EntFire("lff_music_6","Volume","10",0.05,null);
		EntFire("Console","Command","say ***YOU LOST - NO ONE GOT POINTS***",0.00,null);
	}
	else
	{
		EntFire("lff_wintext","AddOutput","message you did the laser",0.00,null);
		EntFire("lff_music_5","PlaySound","",0.00,null);
		EntFire("lff_music_5","Pitch","100",0.01,null);
		EntFire("lff_music_5","Pitch","100",0.05,null);
		EntFire("lff_music_5","Pitch","100",0.10,null);
		EntFire("lff_music_5","Pitch","100",0.00,null);
		EntFire("lff_music_5","Volume","10",0.01,null);
		EntFire("lff_music_5","Volume","10",0.02,null);
		EntFire("lff_music_5","Volume","10",0.05,null);
		EntFire("Console","Command","say ***YOU WON - WINNERS GET POINTS***",0.00,null);
	}
	idleanim = 1;
	EntFire("Console","Command","say ***THANK YOU FOR PLAYING***",1.00,null);
}
function TickWeaponKiller()
{
	if(!ticking)return;
	if(!::luff_ff_fix_weapon_kill)return;//#####FIX_PATCHED
	EntFireByHandle(self,"RunScriptCode"," TickWeaponKiller(); ",0.30,null,null);	
	local h=null;while(null!=(h=Entities.FindByClassname(h,"weapon_*"))){if(h.FirstMoveChild()==null)EntFireByHandle(h,"Kill","",0.00,null,null);}
}
function Tick()
{
	if(!ticking)return;
	EntFireByHandle(self,"RunScriptCode"," Tick(); ",::luff_ff_tickrate,null,null);	
	if(::luff_ff_fix_viewmodel_hide)//#####FIX_PATCHED
		EntFire("predicted_viewmodel","DisableDraw","",0.00,null);
	local h=null;while(null!=(h=Entities.FindByClassname(h,"player")))
	{
		try{
		if(h.GetTeam()==2)EntFireByHandle(h,"SetDamageFilter","stage_lff_filter_safeagainst_ct",0.00,null,null);
		else if(h.GetTeam()==3)EntFireByHandle(h,"SetDamageFilter","stage_lff_filter_safeagainst_t",0.00,null,null);
		if(h.GetHealth()>0)
		{
			if(h.GetTeam()==3||h.GetTeam()==2)
			{
				if(!introangles)h.SetAngles(viewangles.x,viewangles.y,viewangles.z);
				else h.SetAngles(-10,0,0);
			}
		}
		EntFireByHandle(h,"AddOutput","gravity "+::luff_ff_player_gravity.tostring(),0.00,null,null);
		h.ValidateScriptScope();
		local sc = h.GetScriptScope();
		if(::luff_ff_fix_invisible_models)//#####FIX_PATCHED
		{
			EntFireByHandle(h,"AddOutput","rendermode 10",0.00,null,null);//#####FIX_PATCHED
			if(h.GetModelName()!="models/player/chinny/chinny_invis_model.mdl")
			{
				sc.lff_pmodel <- h.GetModelName();
				self.PrecacheModel("models/player/chinny/chinny_invis_model.mdl");
				h.SetModel("models/player/chinny/chinny_invis_model.mdl");
			}
		}
		if("lff_health" in sc)
		{
			if(sc.lff_health <= 0.00)
			{
				sc.lff_health <- (0.00+::luff_ff_health);
				sc.lff_damagecd <- 0.00;
				sc.lff_killsprite <- true;
				EntFireByHandle(h,"SetHealth","-1",0.00,null,null);
			}
			else
			{
				if(h.GetHealth() != sc.lff_health && h.GetHealth()>0)
					EntFireByHandle(h,"AddOutput","health "+sc.lff_health.tointeger().tostring(),0.00,null,null);
			}
		}
		}catch(eee){printl("FINALFUNTASY_MANAGER_ERROR: "+eee);}
	}
}
charspawner <- null;
charqueue <- [];
charspawnidx <- 0;
function TickPickCharacter()
{
	EntFireByHandle(self,"RunScriptCode"," TickPickCharacter(); ",0.05,null,null);
	if(charqueue.len()<=0){EntFire("lff_charpicktrigger","Toggle","",0.00,null);return;}
	local p = charqueue[0];
	charqueue.remove(0);
	if(p==null||!p.IsValid())return;
	if(p.GetName()=="iii_lff_character")
	{
		p.SetOrigin(stageorigin+Vector(-815.5,768,113));
		p.ValidateScriptScope();
		p.GetScriptScope().lff_health <- (0.00+::luff_ff_health);
		p.GetScriptScope().lff_damagecd <- 0.00;
		p.SetHealth((0.00+::luff_ff_health).tointeger());
		return;
	}
	charspawnidx += 80;
	if(charspawnidx > 1600)charspawnidx = 0;
	local spos = stageorigin+Vector(-960,960-(charspawnidx),1000);
	p.SetOrigin(spos);
	p.SetVelocity(Vector());
	p.SetAngles(viewangles.x,viewangles.y,viewangles.z);
	//EntFire("lff_weaponstrip","Use","",0.00,p);						//servers using AmmoFix.smx fucks this up, doesn't strip, fucking sucks
	EntFire("weaponstrip","Strip","",0.00,p);							//replacement here (introduced in test4)
	EntFireByHandle(p,"AddOutput","movetype 0",0.00,null,null);
	EntFireByHandle(p,"AddOutput","movetype 2",0.10,null,null);
	EntFireByHandle(p,"AddOutput","movetype 2",0.15,null,null);
	if(charspawner==null)charspawner = Entities.FindByName(null,"s_lff_character_maker");
	charspawner.SpawnEntityAtLocation(spos,Vector());
}
function TriggerPickCharacter()
{
	if(activator==null||!activator.IsValid())return;
	foreach(h in charqueue){if(h==activator)return;}
	charqueue.push(activator);
}
function PickedCharacter()
{
	EntFireByHandle(self,"RunScriptCode"," TickCharacter(); ",0.05,activator,caller.FirstMoveChild());
	EntFireByHandle(caller.FirstMoveChild(),"SetParent","!activator",0.00,activator,null);
	EntFireByHandle(caller.FirstMoveChild(),"AddOutput","rendermode 1",0.00,null,null);
	EntFireByHandle(caller.FirstMoveChild(),"AddOutput","renderamt 254",0.00,null,null);
	EntFireByHandle(caller.FirstMoveChild(),"Enable","",0.04,null,null);
	caller.FirstMoveChild().__KeyValueFromVector("rendercolor",Vector(RandomInt(25,225),RandomInt(25,225),RandomInt(25,225)));
	if(::luff_ff_fix_weapon_kill)//#####FIX_PATCHED
		EntFireByHandle(caller,"Kill","",0.05,null,null);
	activator.ValidateScriptScope();
	local sc = activator.GetScriptScope();
	sc.lff_health <- (0.00+::luff_ff_health);
	sc.lff_damagecd <- 0.00;
	activator.SetHealth((0.00+::luff_ff_health).tointeger());
	activator.__KeyValueFromString("targetname","iii_lff_character");
	activator.SetOrigin(stageorigin+Vector(-815.5,768,113));
}

idleanim <- 0;				//0:normal		1:victory		2:battle
function TickCharacter()
{
	if(caller==null||!caller.IsValid())return;
	local killsprite = false;
	if(activator==null||!activator.IsValid())killsprite = true;
	else
	{
		if(activator.GetHealth()<=0.00)killsprite = true;
		activator.ValidateScriptScope();
		if(("lff_killsprite" in activator.GetScriptScope()))
		{
			killsprite = true;
			delete activator.GetScriptScope().lff_killsprite;
			activator.__KeyValueFromString("targetname","iii_lff_nocharacter");
		}
	}
	if(killsprite)
	{
		EntFireByHandle(caller,"Kill","",0.00,null,null);
		if(activator==null||!activator.IsValid()){}else
		{
			activator.__KeyValueFromString("targetname","iii_lff_nocharacter");
		}
		return;
	}
	EntFireByHandle(self,"RunScriptCode"," TickCharacter(); ",::luff_ff_character_tickrate,activator,caller);
	local sprite = caller;
	local player = activator;
	local vel = player.GetVelocity();
	local grounded=true;if(TraceLine(player.GetOrigin()+Vector(0,0,4),player.GetOrigin()+Vector(0,0,-24),null)==1.00)grounded=false;
	local damaged=false;if(player.GetScriptScope().lff_damagecd > 0.00){damaged=true;player.GetScriptScope().lff_damagecd-=::luff_ff_character_tickrate;}
	
		//sprite direction
	if(vel.y < 0.00){if(damaged)EntFireByHandle(sprite,"AddOutput","body 1",0.00,null,null);
	else EntFireByHandle(sprite,"AddOutput","body 0",0.00,null,null);}
	else if(vel.y > 0.00){if(damaged)EntFireByHandle(sprite,"AddOutput","body 0",0.00,null,null);
	else EntFireByHandle(sprite,"AddOutput","body 1",0.00,null,null);}
	
		//sprite animation
	if(damaged)EntFireByHandle(sprite,"Skin","5",0.00,null,null);							//damage
	else if(!grounded)EntFireByHandle(sprite,"Skin","4",0.00,null,null);					//jump
	else if(vel.y > 30 || vel.y < -30)EntFireByHandle(sprite,"Skin","3",0.00,null,null);	//walk
	else EntFireByHandle(sprite,"Skin",idleanim.tostring(),0.00,null,null);					//idle (can also be victory/battle based on map-event)
}
function Damage(target,damage,ignorecd=false)
{
	if(target==null||!target.IsValid())return;
	target.ValidateScriptScope();
	local sc = target.GetScriptScope();
	if("lff_health" in sc)
	{
		if(sc.lff_damagecd > 0.00 && !ignorecd)return;
		sc.lff_damagecd = (0.00+damagecd);
		sc.lff_health -= damage;
		if(::luff_ff_fix_damage_fade)//#####FIX_PATCHED
			EntFire("lff_damage_fade","Fade","",0.00,target);
		if(::luff_ff_fix_damage_sound)//#####FIX_PATCHED
			EntFire("Client","Command","play *luffaren_finalfuntasy/ouchies.mp3",0.00,target);
	}
}
function Knockback(target,left_right=null,up=null,ignorecd=false)
{
	if(target==null||!target.IsValid())return;
	target.ValidateScriptScope();
	if("lff_damagecd" in target.GetScriptScope()){if(target.GetScriptScope().lff_damagecd > 0.00 && !ignorecd)return;}
	local vel = target.GetVelocity();
	vel.x = 0;
	if(left_right!=null)vel.y=left_right;
	if(up!=null)vel.z=up;
	target.SetVelocity(vel);
}
function TickFlashlightDisable()
{
	if(!::luff_ff_fix_disable_flashlight)return;
	EntFireByHandle(self,"RunScriptCode"," TickFlashlightDisable(); ",::luff_ff_fix_disable_flashlight_rate,null,null);
	EntFire("player","AddOutputs","effects 0",0.00,null);
}
function LateTpTouched()
{
	if(::luff_ff_fix_late_forgive)return;
	if(activator.GetTeam()==3)
		EntFireByHandle(activator,"SetHealth","-1",0.00,null,null);
}

