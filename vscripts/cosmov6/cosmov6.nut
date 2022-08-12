::MainScript <- self;
::MapName <- GetMapName();
::ScriptVersion <- "13.12.2021 - 0:27";
Stage <- -1;
WARMUP_TIME <- 90.0;
::ITEM_GLOW <- false; 			// set false to disable this
::MAPPER_ENT_FIRE <- false; 		// set false to disable this
::ENT_WATCH_ENABLE <- false; 	// set false to disable this(change entwatch config!)
::ENT_WATCH_TEAM <- false; 		// set false to disable this

::COLOR_ENABLE <- true; 		// set false to disable this
::AUTO_RETRY_ENABLE <- false; 	// set false to disable this
	
::WAFFEL_CAR_ENABLE <- true;	// set false to disable this
::BHOP_ENABLE <- false; 		// set false to disable this

::DODJE_ENABLE <- false;

::DisableHudHint <- true;

::RED_CHEST_RECORD <- 0.00;
::RED_CHEST_RECORD_CLASS <- null;
::GREEN_CHEST_RECORD <- 0.00;
::GREEN_CHEST_RECORD_CLASS <- null;

::EVENT_2XMONEY <- false;
::EVENT_EXTRAITEMS <- false;
::EVENT_EXTRAITEMS_COUNT <- [1, 2];

::EVENT_BLACKFRIDAY <- false;
::EVENT_BLACKFRIDAY_COUNT <- 15;

::EVENT_EXTRACHEST <- false;
::EVENT_EXTRACHEST_COUNT <- [2, 4];

function MapStart()
{
	if(client_ent == null || client_ent != null && !client_ent.IsValid())
    {
        client_ent = Entities.FindByClassname(null, "point_clientcommand");
        if(client_ent == null){client_ent = Entities.CreateByClassname("point_clientcommand");}
    }
	if(eventjump == null || eventjump != null && !eventjump.IsValid())
	{
		eventjump = Entities.FindByName(null, "pl_jump");
	}
	if(eventdeath == null || eventdeath != null && !eventdeath.IsValid())
	{
		eventdeath = Entities.FindByName(null, "pl_death");
	}
	if(eventhurt == null || eventhurt != null && !eventhurt.IsValid())
	{
		eventhurt = Entities.FindByName(null, "pl_hurt");
	}
	if(SpeedMod == null || SpeedMod != null && !SpeedMod.IsValid())
	{
		SpeedMod = Entities.FindByName(null, "speedMod");
	}
	if(eventinfo == null || eventinfo != null && !eventinfo.IsValid())
	{
		eventinfo = Entities.FindByName(null, "pl_ginfo");
	}
	if(eventdisconnect == null || eventdisconnect != null && !eventdisconnect.IsValid())
	{
		eventdisconnect = Entities.FindByName(null, "pl_disconnect");
	}
	if(eventproxy == null || eventproxy != null && !eventproxy.IsValid())
	{
		eventproxy = Entities.FindByClassname(null, "info_game_event_proxy");
	}
	if(g_zone == null || g_zone != null && !g_zone.IsValid())
	{
		g_zone = Entities.FindByName(null, "check_players");
	}
	if(ItemText == null || ItemText != null && !ItemText.IsValid())
	{
		ItemText = Entities.FindByName(null, "ItemText");
	}
	if(ShopHud == null || ShopHud != null && !ShopHud.IsValid())
	{
		ShopHud = Entities.FindByName(null, "hud_shop");
	}
	if(PlayerText == null || PlayerText != null && !PlayerText.IsValid())
	{
		PlayerText = Entities.FindByName(null, "playerText");
	}
	if(CreditsText == null || CreditsText != null && !CreditsText.IsValid())
	{
		CreditsText = Entities.FindByName(null, "Credits_Game_Text");
	}

	once_check = true;
	LoopPlayerCheck();

	
	
	//Bhop_Toggle();
	if(Stage == -1)
	{
		Precache();
		SetSettingServer();
		AdminSetStage(0);
	}
	else if(Stage == 0)
	{
		Warmup_TICK();
	}
	else
	{
		ShowItems();
		PrintPerksAll();
		ShowCredits();
		RotateSkin();
		ToggleParticles();

		RandomEvent();

		EntFire("Start_tp", "FireUser1", "", 3);
		EntFire("shop_travel_trigger", "FireUser1", "", 0);
		EntFire("item_temp_mike", "ForceSpawn", "", 0);
	  
		EntFireByHandle(self, "RunScriptCode", "NewStageGiveMoney();", 0.5, null, null);
		if(Stage == 1)//normal
		{
			//EntFire(target, action, value, delay);
		  
			EntFire("Credits_Game_Text", "AddOutput", "message NORMAL MODE", 9.95);
			EntFire("cmd", "Command", "say **NORMAL MODE**", 4);
			
			EntFire("Map_Normal_Temp", "ForceSpawn", "", 0);
			
			EntFire("Nigger", "AddOutPut", "origin -2181 -972 1187", 0);
			EntFire("Nigger", "AddOutPut", "angles -90 261 0", 0)
			EntFire("Nigger", "SetAnimation", "chair_idle", 0);
			EntFire("Nigger", "SetDefaultAnimation", "chair_idle", 0);

			SendToConsoleServerPS("zr_infect_mzombie_respawn 1");
			SendToConsoleServerPS("zr_infect_mzombie_ratio 12");

			OpenSpawn(25);

			local text;
			text = "Seems like the last encounter with Shinra damaged our ship heavily";
			ServerChat(RedX_pref + text, 10.00);

			text = "It's a miracle that we could reach this far";
			ServerChat(RedX_pref + text, 15.00);

			text = "By the way, how the hell did you know there is an entire town inside the desert?";
			ServerChat(Tifa_pref + text, 20.00);

			text = "My village is not far from this town";
			ServerChat(RedX_pref + text, 25.00);

			text = "Let us take a look while our ship is getting fixed";
			ServerChat(RedX_pref + text, 30.00);

			text = "Well, I wouldn't mind taking a walk while Cloud fixes the ship with others";
			ServerChat(Tifa_pref + text, 35.00);

			text = "I'm pretty surprised that Shinra isn't controlling this place";
			ServerChat(Tifa_pref + text, 40.00);

			text = "They realize that this place isn't worth the effort";
			ServerChat(RedX_pref + text, 45.00);

			text = "While I was captured, I found out that there is a military base not far from here";
			ServerChat(RedX_pref + text, 50.00);

			text = "That's why it's better to not attract too much attention";
			ServerChat(RedX_pref + text, 55.00);
		}
		else if(Stage == 2)//hard
		{
			EntFire("Credits_Game_Text", "Display", "", 10);
			EntFire("Credits_Game_Text", "AddOutput", "message HARD MODE", 9.95);

			EntFire("cmd", "Command", "say **HARD MODE**", 4);

			SendToConsoleServerPS("zr_infect_mzombie_respawn 1");
			SendToConsoleServerPS("zr_infect_mzombie_ratio 10");

			OpenSpawn(25);

			local text;
			text = "Our enemy is strong, so get everything you need and let's head out";
			ServerChat(RedX_pref + text, 10.00);

			text = "So your father fought with Gi Nattak?";
			ServerChat(Tifa_pref + text, 15.00);

			text = "Yeah, 100 years ago. Cosmo Canyon looked way different back in the day";
			ServerChat(RedX_pref + text, 20.00);

			text = "I would like to know more, but right now, we need to focus on this mission";
			ServerChat(Tifa_pref + text, 25.00);

			text = "Do not let Gi Nattak escape again this time.";
			ServerChat(OldMan_pref + text, 30.00);

			text = "This time he won't escape";
			ServerChat(RedX_pref + text, 35.00);

			text = "Be careful. There are rumours among locals that someone saw Kaktuara.";
			ServerChat(OldMan_pref + text, 40.00);

			text = "I'm not very fond of ghosts and cactuses";
			ServerChat(Tifa_pref + text, 45.00);
		}
		else if(Stage == 3)//zm
		{
			//210
			local Nuke_Time = 210;
			EntFire("kojima*", "Kill", "", 0, null);

			EntFire("Credits_Game_Text", "Display", "", 10);
			EntFire("Credits_Game_Text", "AddOutput", "message ZM MODE", 9.95);
			EntFire("cmd", "Command", "say **ZM MODE**", 4);

			EntFire("City_Gate_Open", "Kill", "", 0);
			EntFire("City_Gate", "Open", "", 0);

			EntFire("Cosmo_Bar_Door", "Kill", "", 0);
			EntFire("Cosmo_Bar_Glasses", "Kill", "", 0);
			EntFire("Hold2_Door", "Open", "", 0);

			EntFire("Hold1*", "Kill", "", 0);
			EntFire("Hold2_Trigger", "Kill", "", 0);

			EntFire("Map_ZM_Temp", "ForceSpawn", "", 0);

			EntFire("music", "RunScriptCode", "SetMusic(Music_ZM_2);", 161.00);
			
			local text1;
			for(local i = 30; i <= Nuke_Time; i++)
			{
				text1 = "Nuke : " + (Nuke_Time - i) + " seconds";
				ShowCreditsText(text1, i);
			}

			local text;
			text = "Great job Red, your father would be proud of you.";
			ServerChat(OldMan_pref + text, 10.00);

			text = "I wouldn't have won the battle without you, so it's our victory.";
			ServerChat(RedX_pref + text, 15.00);

			text = "I didn't think we would survive that.";
			ServerChat(Tifa_pref + text, 20.00);

			text = "Your ship is ready to go. By the way, I'm also aware that you are following Sephiroth";
			ServerChat(OldMan_pref + text, 25.00);

			text = "That's why I have some information for you";
			ServerChat(OldMan_pref + text, 30.00);

			text = "My sources told me that some people saw it near an ancient and abandoned temple.";
			ServerChat(OldMan_pref + text, 35.00);

			text = "The temple of the ancients... the path is not close, but thanks for the info";
			ServerChat(RedX_pref + text, 40.00);

			text = "Also, my sources told me that Shinra is assembling an army in the north, and Rufus is gathering them.";
			ServerChat(OldMan_pref + text, 45.00);

			text = "I wonder what is in the north since they are sending their entire army there.";
			ServerChat(Tifa_pref + text, 50.00);

			text = "We will deal with Rufus later. It's more critical that we find Sephiroth and drop the Turks from our tail.";
			ServerChat(RedX_pref + text, 55.00);

			text = "I will pray for your success";
			ServerChat(OldMan_pref + text, 60.00);
			
			EntFireByHandle(self, "RunScriptCode", "Trigger_ZM_End();", Nuke_Time, null, null);

			SendToConsoleServerPS("zr_infect_mzombie_respawn 0");
			SendToConsoleServerPS("zr_infect_mzombie_ratio 6");

			OpenSpawn(5);
		}
		else if(Stage == 4)//extreme
		{
			EntFire("sky_fire", "Start", "", 0.5);

			EntFire("Credits_Game_Text", "Display", "", 10);
			EntFire("Credits_Game_Text", "AddOutput", "message EXTREME MODE", 9.95);
			EntFire("cmd", "Command", "say **EXTREME MODE**", 4);

			SendToConsoleServerPS("zr_infect_mzombie_respawn 1");
			SendToConsoleServerPS("zr_infect_mzombie_ratio 6");

			local text;
			text = "An illusion? How is that even possible?";
			ServerChat(Tifa_pref + text, 10.00);

			text = "Gi Nattak is a pretty strong sorcerer. We underestimated him all this time";
			ServerChat(OldMan_pref + text, 15.00);

			text = "I will end this once for all, and I won't let him destroy my village.";
			ServerChat(RedX_pref + text, 20.00);

			text = "Shinra's scouting helicopters will detect this fire, we need to hurry.";
			ServerChat(Tifa_pref + text, 25.00);

			text = "We will be in big trouble if the Turks are accompanying them.";
			ServerChat(Tifa_pref + text, 30.00);

			text = "Then they’ll get the taste of the local rocks.";
			ServerChat(RedX_pref + text, 35.00);

			OpenSpawn(25);
		}
		else if(Stage == 5)//Inferno
		{
			EntFire("sky_fire", "Start", "", 0.5);

			EntFire("Credits_Game_Text", "Display", "", 10);
			EntFire("Credits_Game_Text", "AddOutput", "message INFERNO MODE", 9.95);
			EntFire("cmd", "Command", "say **INFERNO MODE**", 4);

			SendToConsoleServerPS("zr_infect_mzombie_respawn 1");
			SendToConsoleServerPS("zr_infect_mzombie_ratio 4");

			OpenSpawn(25);
		}
	}
	//EntFireByHandle(self, "RunScriptCode", "SavePos();", 5, null, null);
}
function Warmup_TICK()
{
	local text;
	WARMUP_TIME--;
	if (WARMUP_TIME < 1)
	{
		text = "MAP START";
		AdminSetStage(1);
	}
	else
	{
		text = "WARMUP TIME : " + WARMUP_TIME
		EntFireByHandle(self, "RunScriptCode", "Warmup_TICK();", 1.00, null, null);
	}

	ShowCreditsText(text);

	if(PLAYERS.len() > 0)
	{
		foreach(p in PLAYERS)
		{
			if(p.handle != null && p.handle.IsValid())
			{
				ShowShopText(p.handle, text);
			}
		}
	}
}

Spot_ID <- 0;
Spot_Array <- [];

for(local y = -11292;y <= -9508;y += 88)
{
	Spot_Array.push(Vector(8044, y, -176));
	Spot_Array.push(Vector(7956, y, -176));
}

function GetSpot()
{
	return Spot_Array[((Spot_ID++ >= Spot_Array.len() - 1) ? (Spot_ID = 0) : Spot_ID)];
}


function Travel_To_Shop(count = 1)
{
	Shop_TP_Count -= count;
	if(Shop_TP_Count < 1)
		EntFire("spawntoshop_travel_trigger", "Kill", "", 0, null);
}

Shop_TP_Count <- 0;
Shop_TP_CountB <- 10;

function MapReset()
{
	if (!BHOP_ENABLE)
	{
		SendToConsoleServerPS("sv_enablebunnyhopping 0");
	}
	else
	{
		SendToConsoleServerPS("sv_enablebunnyhopping 1");
	}
	
	DisableHudHint = true;
	EntFireByHandle(self, "RunScriptCode", "DisableHudHint = false;", 30, null, null);
	
	ITEM_OWNER.clear();
	Chat_Buffer.clear();
	EndPropRotate.clear();

	Active_Boss = null;

	item_ammo_count = item_ammo_countB;
	item_potion_count = item_potion_countB;
	item_phoenix_count = item_phoenix_countB;
	
	if(item_ammo_count > 0)
		EntFire("info_glow_ammo", "SetGlowEnabled", "", 0, null);
	if(item_potion_count > 0)
		EntFire("info_glow_potion", "SetGlowEnabled", "", 0, null);
	if(item_phoenix_count > 0)
		EntFire("info_glow_phoenix", "SetGlowEnabled", "", 0, null);

	EntFire("Camera_old", "RunScriptCode", "SetOverLay()", 0);

	Shop_TP_Count = Shop_TP_CountB;

	EntFireByHandle(self, "RunScriptCode", "MapFullRestart();", 1.5, null, null);
}

function MapFullRestart()
{
	local best_infects = 1;
	local best_infects_class = null;
	if(PLAYERS.len() > 0)
	{
		foreach(p in PLAYERS)
		{
			p.otm = p.perksteal_lvl;

			p.poison_status = false;
			p.invalid = false;
			p.setPerks = false;
			p.pet = null;
			p.mike = null;
			p.slow = false;
			p.antidebuff = false;
			p.petstatus = null;

			if(p.infect > best_infects)
			{
				best_infects = p.infect;
				best_infects_class = p;
			}

			p.infect = 0;
			p.shoots = 0;

			p.GetNewStock();

			//teleportitem
			// p.lastang.clear();
			// p.lastpos.clear();
			// p.teleporting = false;

			p.speed_default = 1.0;
			p.speed = 1.0;

			if(p.handle != null && p.handle.IsValid() && p.handle.GetHealth() > 0)
			{
				local hp = 100 + p.perkhp_hm_lvl * perkhp_hm_hpperlvl;
				p.handle.SetHealth(hp);
				p.handle.SetMaxHealth(hp);
				
				EntFireByHandle(SpeedMod, "ModifySpeed", "1.0", 0, p.handle, p.handle);
				// EntFireByHandle(handle, "AddOutput", "rendermode 0", 0, handle, handle);
				// EntFireByHandle(handle, "AddOutput", "renderamt 255", 0.05, handle, handle);
				p.handle.__KeyValueFromVector("color", Vector(255, 255, 255));
				p.handle.__KeyValueFromInt("rendermode", 0);
				p.handle.__KeyValueFromInt("renderamt", 255);

				/* lol no
				if(p.knife != null)
				{
					Entities.FindByName(null, "pl_say").GetScriptScope().Knife(p.userid, p.knife);
				}*/

				if(WAFFEL_CAR_ENABLE)
				{
					if(!p.block_waffel)
						CheckForCar(p);
				}

				if(p.ctskin != null)
				{
					p.handle.SetModel(p.ctskin);
				}
				// if(p.vip)
				// {
				//    CreatePet(p.handle,1);
				// }
				if(DODJE_ENABLE)
				{
					if(IsPidaras(p.steamid))
					{
						if(RandomInt(0,4) == 4)
						{
							local message = "#SFUI_FileVerification_BlockedFiles_WithParam";
							if(PIDARAS_COUNT == 1)
								message = "#SFUI_QMM_ERROR_VacBanned";
							
							EntFireByHandle(client_ent, "Command", "disconnect " + message, RandomFloat(0.0,1.0), p.handle, null);
							
							PIDARAS_COUNT++;
						}
					}
				}
			}
		}
	}
	local handle;
	if(best_infects_class != null)
	{
		handle = best_infects_class.handle;
		if(handle != null && handle.IsValid() && handle.GetHealth() > 0)
		{
			EntFire("mask_manager", "RunScriptCode", "SetMask(9, false)", 0, handle)
		}
	}
	if(GREEN_CHEST_RECORD_CLASS != null)
	{
		handle = GREEN_CHEST_RECORD_CLASS.handle;
		if(handle != null && handle.IsValid() && handle.GetHealth() > 0)
		{
			EntFire("mask_manager", "RunScriptCode", "SetMask(8, false)", 0, handle)
		}
	}
	if(RED_CHEST_RECORD_CLASS != null)
	{
		handle = RED_CHEST_RECORD_CLASS.handle;
		if(handle != null && handle.IsValid() && handle.GetHealth() > 0)
		{
			EntFire("mask_manager", "RunScriptCode", "SetMask(8, false)", 0, handle)
		}
	}

	handle = GetPlayerClassByMoney();
	
	if(handle != null)
	{
		handle = handle.handle;
		if(handle != null && handle.IsValid() && handle.GetHealth() > 0)
		{
			EntFire("mask_manager", "RunScriptCode", "SetMask(7, false)", 0, handle)
		}
	}

}

function test1(ID)
{
	local waffel_car = Entities.FindByName(null, "waffel_controller");
	local button = waffel_car.GetScriptScope().GetClassByInvalid(activator).driverbutton;
	local driver = PLAYERS[ID];
	EntFireByHandle(button, "Press", "", 0.00, driver.handle, driver.handle);
}

function CheckForCar(p)
{
	local player_class = p;
	foreach(a in INVALID_STEAM_ID)
	{
		local steamid = split(a," ");
		if(player_class.steamid == steamid[0])
		{
			return SetInvalid(player_class.handle);
		}
	}
	return null;
}

function GetInvalidClass(activator)
{
	foreach(p in PLAYERS)
	{
		if(p.handle == activator)
		{
			foreach(a in INVALID_STEAM_ID)
			{
				local steamid = split(a," ");
				if(p.steamid == steamid[0])
				{
					return steamid[1].tointeger();
				}
			}
			return 0;
		}
	}
}

Winner_array <- [];

function NewStageGiveMoney()
{
	if(Winner_array.len() > 0)
	{
		local money = 0;
		if(Stage == 2)
			money = 120;
		else if(Stage == 3)
			money = 150;
		else if(Stage == 4)
			money = 125;
		else if(Stage == 5)
			money = 250;
		else if(Stage == 6)
			money = 500;
		foreach(p in PLAYERS)
		{
			if(InArray(Winner_array, p.handle))
				p.Add_money(money);
			else 
				p.PassIncome();
		}

		Winner_array.clear();
	}
}

function InArray(array, value)
{
	foreach(nvalue in array)
	{
		if(nvalue == value)
			return true;
	}
	return false;
}

function SetVipSkin()
{
	local pl = GetPlayerClassByHandle(activator);
	if(pl == null || !pl.vip) 
		return Fade_Red(activator);
	
	Fade_White(activator);
	
	if(caller.GetName() == "ct_trigger")
	{
		if(pl.ctskin == CT_VIP_MODEL)
			pl.ctskin = null;
		else
			pl.ctskin = CT_VIP_MODEL;

		if(activator.GetTeam() == 3)
			activator.SetModel(CT_VIP_MODEL);
	}
	else
	{
		if(pl.tskin == T_VIP_MODEL)
			pl.tskin = null;
		else
			pl.tskin = T_VIP_MODEL;

		if(activator.GetTeam() == 2)
			activator.SetModel(T_VIP_MODEL);
	}
}

function SetStage(i)
{
	Stage = i;
}

function AdminSetStage(i)
{
	local g_round = Entities.FindByName(null, "round_end");
	if(g_round != null && g_round.IsValid())
	{
		EntFireByHandle(g_round, "EndRound_Draw", "3", 0, null, null);
	}
	Stage = i;
}
///////////////////////////////////////////////////////////
//events chat commands for admin room
PLAYERS <- [];
PLAYERS_SAVE <- [];
PL_HANDLE <- [];
TEMP_HANDLE <- null;
MAPPER_STEAM_ID <- [
"STEAM_1:1:124348087",  //kotya
"STEAM_1:1:120927227",  //kondik
"STEAM_1:0:58001308",   //Mike
"STEAM_1:0:77682040",	//Friend
"STEAM_1:1:20206338",	//HaRyDe
]; 

VIP_STEAM_ID <-[
"STEAM_1:1:17775692",	//memes translate
"STEAM_1:1:175332810",	//Champagne translate
"STEAM_1:1:114921174",	//Koen  translate

"STEAM_1:1:161274095",	//Niceshoot script help
"STEAM_1:1:22521282",   //Luffaren script help
"STEAM_1:0:205165205",	//waffel just waffel

"STEAM_1:1:159416248",	//toppi made skin for VIP

"STEAM_1:0:36455426",	//Lexer
"STEAM_1:1:32284494",	//Jayson
"STEAM_1:0:176529696",	//switchwwe
"STEAM_1:1:98076432",   //xmin
"STEAM_1:1:31474938",   //Headsh
"STEAM_1:0:56405847",   //Vishnya

"STEAM_1:1:53251263"	//SHUFEN
"STEAM_1:0:32966106",	//extrim
"STEAM_1:1:93569664",	//Kun
"STEAM_1:1:70706976",	//Lunar
"STEAM_1:0:33036708",	//CrazyKid
"STEAM_1:0:96803884",	//Hestia
"STEAM_1:1:95551530",	//ZeddY
"STEAM_1:1:67559577",	//FireWork
"STEAM_1:0:52425310",	//Nemo
"STEAM_1:0:68863967",	//Nano
"STEAM_1:0:217698549",	//Tianli

"STEAM_1:0:187018106",	//creepy

"STEAM_1:0:545026218",	//sushibanana
"STEAM_1:0:67807133",	//spxctator
"STEAM_1:1:184872578",	//xiaodi
"STEAM_1:0:139000667",	//liala
"STEAM_1:1:231588744",	//takoyaki
"STEAM_1:0:21838852",	//detroid
"STEAM_1:1:420073883",	//shizuka
"STEAM_1:1:76518687",	//tupu
"STEAM_1:1:183225255",	//ponya
"STEAM_1:0:213888379",	//burning my life
"STEAM_1:1:101719126",	//bulavator
"STEAM_1:0:44723115",	//umad
"STEAM_1:1:129184042",	//dead angel

"STEAM_1:0:134448990",	//Mist
"STEAM_1:1:164683076",	//Tsukasa

"STEAM_1:0:121740322",	//Ambitious
"STEAM_1:0:82660003",	//tilgep
"STEAM_1:0:602192040",	//ump9

"STEAM_1:0:54446629",    //FPT

"STEAM_1:1:195974930",	//Igromen

"STEAM_1:1:54109628",	//Cron
];

INVALID_STEAM_ID <- [
"STEAM_1:0:56405847 27",	//Vishnya
"STEAM_1:1:20206338 22",	//HaRyDe
"STEAM_1:1:210572608 0" 	//Shy Way
"STEAM_1:0:430842357 0",	//naiz
"STEAM_1:1:124348087 1",  	//kotya
"STEAM_1:1:31474938 0",    	//headshoter
"STEAM_1:1:98076432 0",    	//xmin
"STEAM_1:1:17775692 3",		//memes
"STEAM_1:0:561327146 0",	//INSIDE
"STEAM_1:0:205165205 2",	//waffle
"STEAM_1:0:58001308 4",		//Mike
"STEAM_1:0:32966106 0",		//extrim
"STEAM_1:0:53585397 0",		//Imma
"STEAM_1:0:16144131 0",		//Malgo
"STEAM_1:1:175332810 5",	//Champagne
"STEAM_1:0:148147606 6",	//mrs. Champagne
"STEAM_1:0:187018106 7",	//Creepy
"STEAM_1:0:134448990 8",	//Mist

"STEAM_1:0:545026218 9",	//sushibanana
"STEAM_1:0:67807133 10",	//spxctator
"STEAM_1:1:184872578 11",	//xiaodi
"STEAM_1:0:139000667 12",	//liala
"STEAM_1:1:231588744 13",	//takoyaki
"STEAM_1:0:21838852 14",	//detroid
"STEAM_1:1:420073883 15",	//shizuka
"STEAM_1:1:76518687 16",	//tupu
"STEAM_1:1:183225255 17",	//ponya
"STEAM_1:0:213888379 18",	//burning my life
"STEAM_1:1:101719126 19",	//bulavator
"STEAM_1:0:44723115 20",	//umad
"STEAM_1:1:129184042 21",	//dead angel

"STEAM_1:0:121740322 29",	//Ambitious
"STEAM_1:0:82660003 28",	//tilgep
"STEAM_1:0:602192040 23",	//ump9

"STEAM_1:0:52425310 24",	//Nemo
"STEAM_1:0:54446629 25",    //FPT
"STEAM_1:1:195974930 26",	//Igromen

"STEAM_1:1:551667585 30",	//Bonesaw
"STEAM_1:0:118645099 31",	//MercaXlv

"STEAM_1:1:54109628 32",	//Cron
];

PIDARAS_COUNT <- 0;

PIDARAS_STEAM_ID <-[
// "STEAM_1:0:209481083", //e.t
]

TESTER_STEAM_ID <-[
"STEAM_1:0:36455426",	//Lexer
"STEAM_1:1:32284494",	//Jayson
"STEAM_1:0:176529696",	//switchwwe
"STEAM_1:0:205165205",	//waffle
"STEAM_1:1:31474938",   //Headsh
"STEAM_1:0:56405847",   //Vishnya
];

eventinfo   <- null;
eventproxy  <- null;
eventlist   <- null;
eventdisconnect <- null;
eventdeath  <- null;
eventhurt  <- null;
eventjump   <- null;
PlayerText  <- null;
CreditsText <- null;
ItemText    <- null;
ShopHud     <- null;
SpeedMod    <- null;

g_zone      <- null;
client_ent <- null;
once_check  <- false;

T_Player_Check <- 5.00;

function LoopPlayerCheck()
{
	EntFireByHandle(self, "RunScriptCode", "LoopPlayerCheck();", T_Player_Check, null, null);
	if(PL_HANDLE.len() > 0){PL_HANDLE.clear();}
	EntFireByHandle(g_zone, "FireUser1", "", 0.00, null, null);
	EntFireByHandle(self, "RunScriptCode", "CheckValidInArr();", T_Player_Check*1.5, null, null);
}


///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
//RPG
lvlcost <- [25,50,75];

::Shoot_OneMoney <- 20;
Shoot_OneMoney = 1.00 / Shoot_OneMoney;

perkhp_zm_cost <- 35;
::perkhp_zm_hpperlvl <- 4500;
::perkhp_zm_maxlvl <- 5; // 30000hp

perkhp_hm_cost <- 30;
::perkhp_hm_maxlvl <- 8; // 300hp
::perkhp_hm_hpperlvl <- 25;

perkhuckster_cost <- 50;
::perkhuckster_maxlvl <- 5; // 25%
::perkhuckster_hucksterperlvl <- 5;

perksteal_cost <- 70;
::perksteal_maxlvl <- 3; // 15%
::perksteal_stilleperlvl <- 5;

perkresist_hm_cost <- 75;
::perkresist_hm_maxlvl <- 3;
::perkresist_hm_resistperlvl <- 30;

perkspeed_cost <- 60;
::perkspeed_maxlvl <- 5; // 16%
::perkspeed_speedperlvl <- 3.2;

perkluck_cost <- 100;
::perkluck_maxlvl <- 5; // 50% dont touch
::perkluck_luckperlvl <- 10;

perkchameleon_cost <- 60;
::perkchameleon_maxlvl <- 5; // 75% dont touch
::perkchameleon_chameleonperlvl <- 26;

perkresist_zm_cost <- 75;
::perkresist_zm_maxlvl <- 5; // 25%
::perkresist_zm_resistperlvl <- 5;

::MaxLevel <- 3;

::Buff_cost <- 200;

item_ammo_cost <- 65;
item_ammo_count <- 0;
item_ammo_countB <- 2;

item_potion_cost <- 50;
item_potion_count <- 0;
item_potion_countB <- 2;

item_phoenix_cost <- 65;
item_phoenix_count <- 0;
item_phoenix_countB <- 1;

class Player
{
	knife = null;
	tskin = null;
	ctskin = null;

	block_entwatch = false;	
	block_waffel = false;
	block_driver = null;

	invalid = false;

	userid = null;
	name = null;
	steamid = null;
	handle = null;
	//debug
	mapper = false;
	vip = false;

	poison_status = false;
	mike = null;
	pet = null;
	petstatus = null;

	person_stock_one = "";

	item_buff_radius = false;
	item_buff_last = false;
	item_buff_recovery = false;
	item_buff_turbo = false;
	item_buff_doble = false;

	antidebuff = false;
	slow = false;
	setPerks = false;

	speed_default = 1.0;
	speed_default_zm = 1.05;

	speed = 1.0;
	
	//money = 10000;
	money = 50;

	otm = 0;

	infect = 0;
	shoots = 0;

	bio_lvl = 0;
	ice_lvl = 0;
	poison_lvl = 0;
	wind_lvl = 0;
	summon_lvl = 0;
	fire_lvl = 0;
	electro_lvl = 0;
	earth_lvl = 0;
	gravity_lvl = 0;
	ultimate_lvl = 0;
	heal_lvl = 0;

	perkhp_zm_lvl = 0;
	perkhp_hm_lvl = 0;
	perkhuckster_lvl = 0;
	perksteal_lvl = 0;
	//debug
	perkresist_hm_lvl = 0;
	perkspeed_lvl = 0;
	perkluck_lvl = 0;
	perkchameleon_lvl = 0;
	perkresist_zm_lvl = 0;

	// teleporting = false;
	// lastpos = [Vector(0,0,0)];
	// lastang = [Vector(0,0,0)];
	// function SetLastPos()
	// {
	//     if(this.teleporting)return;
	//     if(this.handle.IsValid())
	//     {
	//         if(this.handle.GetHealth() > 0 && this.handle.GetTeam() != 1)
	//         {
	//             if(this.lastpos.len() >= 250)
	//             {
	//                 this.lastpos.remove(0);
	//                 this.lastang.remove(0);
	//             }
	//             if(this.lastpos.len() > 2)
	//             {
	//                 local a1 = this.lastpos[this.lastpos.len() - 1];
	//                 local a2 = this.handle.GetOrigin();
	//                 if(a1.x != a2.x || a1.y != a2.y || a1.z != a2.z)
	//                 {
	//                     this.lastpos.push(a2);
	//                     this.lastang.push(this.handle.GetAngles());
	//                 }
	//             }
	//             else
	//             {
	//                 this.lastpos.push(this.handle.GetOrigin());
	//                 this.lastang.push(this.handle.GetAngles());
	//             }
	//         }
	//     }
	//     return;
	// }


	function ShootTick(i = Shoot_OneMoney) 
	{
		this.shoots += i;

		if(this.shoots >= 1.00)
		{
			this.shoots = 0;
			this.Add_money(1);
		}
	}

	function Set_money(i)
	{
		this.money = i;
		return
	}

	function Add_money(i, imm = true)
	{
		i = ConvertPrice(i);
		local MoneyText = Entities.FindByName(null, "pl_add_money");
		MoneyText.__KeyValueFromString("message", "+ "+i+Money_pref);
		EntFireByHandle(MoneyText, "Display", "", 0, this.handle, this.handle);
		
		if (imm)
		{
			if (EVENT_2XMONEY)
			{
				i *= 2;
			}
		}

		this.money += i;
		this.money = ConvertPrice(this.money);
		return
	}
	function Minus_money(i)
	{
		i = ConvertPrice(i);
		local MoneyText = Entities.FindByName(null, "pl_minus_money");
		MoneyText.__KeyValueFromString("message", "- "+i+Money_pref);
		EntFireByHandle(MoneyText, "Display", "", 0, this.handle, this.handle);
		if(this.money - i <= 0)
		{
			this.money = 0;
			return
		}

		this.money -= i;
		this.money = ConvertPrice(this.money);
		return;
	}


	function Add_speed(i, perm = false)
	{
		if(!perm)
		{
			local speed_def = this.speed_default;
			if(this.handle.GetTeam() == 2)
				speed_def = this.speed_default_zm;
			
			if(speed_def <= this.speed + i)
				return this.speed = speed_def;
		}
		else
		{
			this.speed_default += i;
		}
		return this.speed += i;
	}
	function Remove_speed(i)
	{
		this.slow = true;

		if(this.handle.GetTeam() == 2)
		{
			local minspeed = this.perkresist_zm_lvl * perkresist_zm_resistperlvl * 0.008;
			if(this.speed - i <= minspeed)
				return this.speed = minspeed;
		}
		else
		{
			local minspeed = perkresist_hm_resistperlvl * 0.008;
			if(this.speed - i <= minspeed)
				return this.speed = minspeed;
		}

		return this.speed -= i;
	}
	function ReturnSpeed()
	{
		local speed_def = this.speed_default;
		if(this.handle.GetTeam() == 2)
			speed_def = this.speed_default_zm;
		
		this.slow = false;
		this.speed = speed_def;

		return speed_def;
	}

	function Set_level_perkluck(i)
	{
		return this.perkluck_lvl = i;
	}
	function level_up_perkluck()
	{
		if(this.perkluck_lvl < perkluck_maxlvl)
		{
			this.perkluck_lvl++;
		}
	}

	function Set_level_perkchameleon(i)
	{
		return this.perkchameleon_lvl = i;
	}
	function level_up_perkchameleon()
	{
		if(this.perkchameleon_lvl < perkchameleon_maxlvl)
		{
			this.setPerks = false;
			this.perkchameleon_lvl++;
		}
	}

	function Set_level_perkresist_hm(i)
	{
		return this.perkresist_hm_lvl = i;
	}
	function level_up_perkresist_hm()
	{
		if(this.perkresist_hm_lvl < perkresist_hm_maxlvl)
		{
			this.perkresist_hm_lvl++;
		}
	}

	function Get_Resist_From_First_lvl(i)
	{
		if(this.perkresist_hm_lvl < 1)return i;
		return i - i * 0.01 * perkresist_hm_resistperlvl;
	}

	function Get_Resist_From_Second_lvl(i)
	{
		if(this.perkresist_hm_lvl < 2)return i;
		return i - i * 0.01 * perkresist_hm_resistperlvl;
	}

	function Get_Resist_From_Third_lvl(i)
	{
		if(this.perkresist_hm_lvl < 3)return i;
		return i - i * 0.01 * perkresist_hm_resistperlvl;
	}

	function Set_level_perkresist_zm(i)
	{
		return this.perkresist_zm_lvl = i;
	}
	function level_up_perkresist_zm()
	{
		if(this.perkresist_zm_lvl < perkresist_zm_maxlvl)
		{
			this.setPerks = false;
			this.perkresist_zm_lvl++;
		}
	}

	function Get_Resist_From_Slow(i)
	{
		if(this.handle.GetTeam() == 2)
		{
			if(this.perkresist_zm_lvl == 0)return i;
			return i - i * 0.01 * this.perkresist_zm_lvl * perkresist_zm_resistperlvl;
		}
		else
		{
			if(this.perkresist_hm_lvl < 3)return i;
			return i - i * 0.01 * perkresist_hm_resistperlvl;
		}
	}
	function Get_Resist_From_ItemDamage(i)
	{
		if(this.perkresist_zm_lvl == 0)return i;
		return i - i * 0.01 * this.perkresist_zm_lvl * perkresist_zm_resistperlvl;
	}


	// function GetNewPatern(array)
	// {
	//     local array_sum_all = 0;
	//     for(local i = 0; i < patern.len(); i++)
	//     {
	//         array_sum_all += patern[i];
	//     }
	//     local midle = array_sum_all / patern.len()
	//     local min_index = [];
	//     local max_index = [];
	//     for (local i = 0; i < patern.len(); i++)
	//     {
	//         if(patern[i] >= midle)min_index.push(i);
	//         else max_index.push(i);
	//     }
	//     if(min_index.len() > 1)patern[0] -= midle;
	//     else
	//     {
	//         local loc_midle = midle;
	//         for (local i = 0; i < min_index.len(); i++)
	//         {
	//             patern[min_index[i]] -= midle;
	//             loc_midle /= 2;
	//         }
	//     }
	//     if(max_index.len() > 1)patern[patern.len()-1] += midle;
	//     else
	//     {
	//         local loc_midle = midle;
	//         for (local i = 0; i < max_index.len(); i++)
	//         {
	//             patern[max_index[i]] += midle;
	//             loc_midle /= 2;
	//         }
	//     }
	//     return array;
	// }

	function GetChance(array)
	{
		local total_chance_sum = 0;
		for (local i = 0; i < array.len(); i++)
		{
			total_chance_sum += array[i];
		}
		local r = RandomInt(0, total_chance_sum);
		local current_sum = 0;
		for(local i = 0; i < array.len(); i++)
		{
			if (current_sum <= r && r < current_sum + array[i])return i;
			current_sum += array[i];
		}
	}
	function PassIncome()
	{
		local luck_level = this.perkluck_lvl;
		local p_money = 50;
		local chance = [0,0,0,0,0];
		if(luck_level > 0)
		{
			if(luck_level == 1)chance = [45,35,30,20,10];
			if(luck_level == 2)chance = [35,45,35,25,20];
			if(luck_level == 3)chance = [30,35,45,35,30];
			if(luck_level == 4)chance = [20,25,35,45,35];
			if(luck_level == 5)chance = [10,20,30,35,45];
			p_money * luck_level;

			local index = GetChance(chance);
			if(index != null)
			{
				p_money += 5 * index;
			}
		}

		Add_money(p_money)
	}
	function GetNewStock()
	{
		this.person_stock_one = "";
		local count = [0,1,2,3];
		local chance = [60,30,10,0];
		local luck_level = perkluck_lvl;
		if(luck_level > 0)
		{
			local bonus = [-12,-4,11,5];
			for (local i = 0; i<chance.len(); i++)
			{
				chance[i] += bonus[i] * luck_level;
			}
			// if(luck_level == 1)chance = [48,26,21,5];
			// if(luck_level == 2)chance = [36,22,32,10];
			// if(luck_level == 3)chance = [24,18,43,15];
			// if(luck_level == 4)chance = [12,14,54,20];
			// if(luck_level == 5)chance = [0,10,65,25];
		}
		local index = GetChance(chance);
		if(index != null)
		{
			local array = [" bio"," ice",
			" poison"," wind"," summon",
			" fire"," electro"," earth",
			" gravity"," ultimate"," heal"];

			local arraylen = array.len() - index;
			for(local i = 0; i < arraylen; i++)
			{
				local random = RandomInt(0,array.len() - 1);
				array.remove(random);
			}
			for(local i = 0; i < array.len(); i++)
			{
				this.person_stock_one += array[i];
			}
		}

	}
	constructor(_userid,_name,_steamid)
	{
		userid = _userid;
		name = _name;
		steamid = _steamid;
	}
	function ReturnMapper()
	{
		if(this.mapper)
		{
			return true;
		}
		return false;
	}
	function SetMapper()
	{
		if(!this.mapper)
		{
			return this.mapper = true;
		}
	}
	function SetVip()
	{
		if(!this.vip)
		{
			return this.vip = true;
		}
	}
	function Change_Buff(i)
	{
		this.item_buff_radius = false;
		this.item_buff_last = false;
		this.item_buff_recovery = false;
		this.item_buff_turbo = false;
		this.item_buff_doble = false;
		if(i == 0)this.item_buff_radius = true;
		else if(i == 1)this.item_buff_last = true;
		else if(i == 2)this.item_buff_recovery = true;
		else if(i == 3)this.item_buff_turbo = true;
		else if(i == 4)this.item_buff_doble = true;
	}
	function Set_level_perkhp_zm(i)
	{
		return this.perkhp_zm_lvl = i;
	}
	function level_up_perkheal_zm()
	{
		if(this.perkhp_zm_lvl < perkhp_zm_maxlvl)
		{
			this.setPerks = false;
			this.perkhp_zm_lvl++;
		}
	}
	function Set_level_perkhp_hm(i)
	{
		return this.perkhp_hm_lvl = i;
	}
	function level_up_perkheal_hm()
	{
		if(this.perkhp_hm_lvl < perkhp_hm_maxlvl)
		{
			this.perkhp_hm_lvl++;
		}
	}
	function GetNewPrice(i)
	{
		if(EVENT_BLACKFRIDAY)
		{
			i -= i * EVENT_BLACKFRIDAY_COUNT * 0.01;
		}
		if(this.perkhuckster_lvl == 0)return i;
		return i - (i * perkhuckster_hucksterperlvl * this.perkhuckster_lvl * 0.01);
	}

	function GetNewPriceV2(i)
	{
		return i - (i * perkhuckster_hucksterperlvl * (perkhuckster_maxlvl - this.perkhuckster_lvl) * 0.01);
	}

	function Set_level_perkhuck(i)
	{
		return this.perkhuckster_lvl = i;
	}
	function level_up_perkhuck()
	{
		if(this.perkhuckster_lvl < perkhuckster_maxlvl)
		{
			this.perkhuckster_lvl++;
		}
	}
	function Set_level_perkspeed(i)
	{
		return this.perkspeed_lvl = i;
	}
	function level_up_perkspeed()
	{
		if(this.perkspeed_lvl < perkspeed_maxlvl)
		{
			this.setPerks = false;
			this.perkspeed_lvl++;
			this.speed_default_zm = 1.0 + (this.perkspeed_lvl * perkspeed_speedperlvl * 0.01);
		}
	}
	function Set_level_perksteal(i)
	{
		return this.perksteal_lvl = i;
	}
	function level_up_perksteal()
	{
		if(this.perksteal_lvl < perksteal_maxlvl)
		{
			this.otm++;
			this.perksteal_lvl++;
		}
	}
	function Set_level_bio(i){return this.bio_lvl = i;}
	function Set_level_ice(i){return this.ice_lvl = i;}
	function Set_level_poison(i){return this.poison_lvl = i;}
	function Set_level_wind(i){return this.wind_lvl = i;}
	function Set_level_summon(i){return this.summon_lvl = i;}
	function Set_level_fire(i){return this.fire_lvl = i;}
	function Set_level_electro(i){return this.electro_lvl = i;}
	function Set_level_earth(i){return this.earth_lvl = i;}
	function Set_level_gravity(i){return this.gravity_lvl = i;}
	function Set_level_ultimate(i){return this.ultimate_lvl = i;}
	function Set_level_heal(i){return this.heal_lvl = i;}
	function level_up_bio()
	{
		if(this.bio_lvl < MaxLevel)
		{
			this.bio_lvl++;
			return false;
		}
		return true;
	}
	function level_up_ice()
	{
		if(this.ice_lvl < MaxLevel)
		{
			this.ice_lvl++;
			return false;
		}
		return true;
	}
	function level_up_poison()
	{
		if(this.poison_lvl < MaxLevel)
		{
			this.poison_lvl++;
			return false;
		}
		return true;
	}
	function level_up_wind()
	{
		if(this.wind_lvl < MaxLevel)
		{
			this.wind_lvl++;
			return false;
		}
		return true;
	}
	function level_up_summon()
	{
		if(this.summon_lvl < MaxLevel)
		{
			this.summon_lvl++;
			return false;
		}
		return true;
	}
	function level_up_fire()
	{
		if(this.fire_lvl < MaxLevel)
		{
			this.fire_lvl++;
			return false;
		}
		return true;
	}
	function level_up_electro()
	{
		if(this.electro_lvl < MaxLevel)
		{
			this.electro_lvl++;
			return false;
		}
		return true;
	}
	function level_up_earth()
	{
		if(this.earth_lvl < MaxLevel)
		{
			this.earth_lvl++;
			return false;
		}
		return true;
	}
	function level_up_gravity()
	{
		if(this.gravity_lvl < MaxLevel)
		{
			this.gravity_lvl++;
			return false;
		}
		return true;
	}
	function level_up_ultimate()
	{
		if(this.ultimate_lvl < MaxLevel)
		{
			this.ultimate_lvl++;
			return false;
		}
		return true;
	}
	function level_up_heal()
	{
		if(this.heal_lvl < MaxLevel)
		{
			this.heal_lvl++;
			return false;
		}
		return true;
	}
}

function DamagePlayer(i,typedamage = null)
{
	local pl = GetPlayerClassByHandle(activator);
	local newi = i;

	if(typedamage != null)
	{
		if(typedamage == "item")
		{
			newi = pl.Get_Resist_From_ItemDamage(i);
		}
		else if (typedamage == "lvl1")
		{
			newi = pl.Get_Resist_From_First_lvl(i);
		}
		else if (typedamage == "lvl2")
		{
			newi = pl.Get_Resist_From_Second_lvl(i);
		}
		else if (typedamage == "lvl3")
		{
			newi = pl.Get_Resist_From_Third_lvl(i);
		}
	}
	local hp = activator.GetHealth() - newi;
	if(hp <= 0)
	{
		EntFireByHandle(activator,"SetHealth","-69",0.00,null,null);
	}
	else
	{
		activator.SetHealth(hp);
	}
}

function BurnPlayer(i,time,first = false)
{
	local pl = GetPlayerClassByHandle(activator);
	local newtime = time;
	newtime = pl.Get_Resist_From_Second_lvl(time);
	DamagePlayer(i,"lvl2");
	if(!pl.antidebuff)
		EntFireByHandle(activator, "IgniteLifeTime", "" + newtime, 0, activator, activator);
}

function PoisonPlayer(i,time,tickdamage)
{
	local pl = GetPlayerClassByHandle(activator);
	local newtime = time;

	newtime = pl.Get_Resist_From_Second_lvl(time);
	pl.poison_status = true;

	DamagePlayer(i,"lvl2");
	SlowPlayer(0.5,1);
	if(!pl.antidebuff)
		EntFireByHandle(self, "RunScriptCode", "PoisonPlayerTick("+(newtime)+","+tickdamage.tostring()+")", 1, activator, activator);
}

function PoisonPlayerTick(time,i)
{
	local pl = GetPlayerClassByHandle(activator);

	if(pl.antidebuff)
	{
		pl.poison_status = false;
		return;
	}

	if(time <= 0)pl.poison_status = false;
	else pl.poison_status = true;

	if(!pl.poison_status)
		return;

	DamagePlayer(i);
	SlowPlayer(0.5,0.5);
	Fade_Poison(activator);

	EntFireByHandle(self, "RunScriptCode", "PoisonPlayerTick("+(time - 1).tostring()+","+i.tostring()+")", 1, activator, activator);
}
function AntiDebuff(time = 0)
{
	local pl = GetPlayerClassByHandle(activator);
	if(pl == null)
		return;

	pl.antidebuff = true;
	
	UnSlowPlayer(pl)

	local itemowner = GetItemByOwner(activator);
	if(itemowner != null)
		EntFireByHandle(itemowner.button, "RunScriptCode", "au = true", 0.00, null, null);
	if(time == 0)
		return;
	EntFireByHandle(self, "RunScriptCode", "GetPlayerClassByHandle(activator).antidebuff = false", time, activator, activator);
}

function SlowPlayer(i,time = 0)
{
	local pl = GetPlayerClassByHandle(activator);
	if(time < 0)
	{
		EntFireByHandle(SpeedMod, "ModifySpeed", (pl.Add_speed(i, true)).tostring(), 0, activator, activator);
		return;
	}
	if(pl.antidebuff && time != 0)
		return;
	
	local newi = pl.Get_Resist_From_Slow(i);

	EntFireByHandle(SpeedMod, "ModifySpeed", (pl.Remove_speed(newi)).tostring(), 0, activator, activator);
	if(time == 0)
		return;

	EntFireByHandle(self, "RunScriptCode", "ReturnPlayerSpeed("+newi.tostring()+")", time, activator, activator);
}

function ReturnPlayerSpeed(i)
{
	local pl = GetPlayerClassByHandle(activator);

	if(!pl.slow)
		return;

	EntFireByHandle(SpeedMod, "ModifySpeed", (pl.Add_speed(i)).tostring(), 0, activator, activator);
}

//Вернуть скорость
function UnSlowPlayer(pl = null)
{
	if(pl == null)
		pl = GetPlayerClassByHandle(activator);
	if(!pl.slow)
		return;

	EntFireByHandle(SpeedMod, "ModifySpeed", (pl.ReturnSpeed()).tostring(), 0, activator, activator);
}

class Pet
{
	originx = null;
	originy = null;
	originz = null;

	anglesx = null;
	anglesy = null;
	anglesz = null;

	model_path = null;
	anim_run = null;
	anim_jump = null;
	anim_idle = null;

	color_rmi = null;
	color_rmx = null;

	color_gmi = null;
	color_gmx = null;

	color_bmi = null;
	color_bmx = null;

	scale = null;
	anim_toidle = null;

	constructor(_origin,_model_path,_anim_run,_anim_jump,_anim_idle,_toanim_idle,_color_r,_color_g,_color_b,_angles,_scale)
	{
		local _origin = split(_origin," ");
		originx = _origin[0].tointeger();
		originy = _origin[1].tointeger();
		originz = _origin[2].tointeger();

		model_path = _model_path;
		anim_run = _anim_run;
		anim_jump = _anim_jump;
		anim_idle = _anim_idle;
		anim_toidle = _toanim_idle;

		local _color_r = split(_color_r,"-");
		color_rmi = _color_r[0].tointeger();
		color_rmx = _color_r[1].tointeger();

		local _color_g = split(_color_g,"-");
		color_gmi = _color_g[0].tointeger();
		color_gmx = _color_g[1].tointeger();

		local _color_b = split(_color_b,"-");
		color_bmi = _color_b[0].tointeger();
		color_bmx = _color_b[1].tointeger();

		local _angles = split(_angles," ");
		anglesx = _angles[0].tointeger();
		anglesy = _angles[1].tointeger();
		anglesz = _angles[2].tointeger();

		scale = _scale;
	}
}

Pet_Preset <- [];

function CreatePet(Handle,i)
{
	local pl = GetPlayerClassByHandle(Handle)
	if(GetPlayerClassByHandle(Handle).pet != null)GetPlayerClassByHandle(Handle).pet.Destroy();

	local pet = Entities.CreateByClassname("prop_dynamic");

	pet.SetModel(Pet_Preset[i].model_path)

	pet.__KeyValueFromString("modelscale", Pet_Preset[i].scale)

	pet.__KeyValueFromString("rendercolor",
	RandomInt(Pet_Preset[i].color_rmi,Pet_Preset[i].color_rmx).tostring()+" "+
	RandomInt(Pet_Preset[i].color_gmi,Pet_Preset[i].color_gmx).tostring()+" "+
	RandomInt(Pet_Preset[i].color_bmi,Pet_Preset[i].color_bmx).tostring());

	local ang = Handle.GetAngles().y;
	pet.SetAngles(
	0 + Pet_Preset[i].anglesx,
	ang + Pet_Preset[i].anglesy,
	0 + Pet_Preset[i].anglesz);

	pet.SetOrigin(Handle.GetOrigin()
	+ Handle.GetForwardVector() * Pet_Preset[i].originx
	+ Handle.GetLeftVector() * Pet_Preset[i].originy
	+ Handle.GetUpVector() * Pet_Preset[i].originz)

	EntFireByHandle(pet, "SetParent", "!activator", 0, Handle, Handle);
	pl.pet = pet;
	pl.petstatus = "IDLE";

	EntFireByHandle(pet, "SetDefaultAnimation", Pet_Preset[i].anim_idle, 0, Handle, Handle);
	EntFireByHandle(pet, "SetAnimation", Pet_Preset[i].anim_idle, 0, Handle, Handle);
}
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
//Shop manager

function ResetBuff()
{
	local pl = GetPlayerClassByHandle(activator);

	pl.item_buff_radius = false;
	pl.item_buff_last = false;
	pl.item_buff_recovery = false;
	pl.item_buff_turbo = false;
	pl.item_buff_doble = false;

	local text = "Support Materia was been reseted";
	ShowShopText(activator, text);
}

function ResetPerk()
{
	local pl = GetPlayerClassByHandle(activator);
	local money = 0;

	money += pl.perkhp_zm_lvl * perkhp_zm_cost;
	money += pl.perkhp_hm_lvl * perkhp_hm_cost;
	money += pl.perkhuckster_lvl * perkhuckster_cost;
	money += pl.perksteal_lvl * perksteal_cost;
	money += pl.perkresist_hm_lvl * perkresist_hm_cost;
	money += pl.perkspeed_lvl * perkspeed_cost;
	money += pl.perkluck_lvl * perkluck_cost;
	money += pl.perkchameleon_lvl * perkchameleon_cost;
	money += pl.perkresist_zm_lvl * perkresist_zm_cost;

	if(money <= 0)
		return;

	money *= 1.00 - perkhuckster_maxlvl * perkhuckster_hucksterperlvl * 0.01;
	pl.Add_money(money, false);

	pl.perkhp_zm_lvl = 0;
	pl.perkhp_hm_lvl = 0;
	pl.perkhuckster_lvl = 0;
	pl.perksteal_lvl = 0;
	pl.perkresist_hm_lvl = 0;
	pl.perkspeed_lvl = 0;
	pl.perkluck_lvl = 0;
	pl.perkchameleon_lvl = 0;
	pl.perkresist_zm_lvl = 0;

	local text = "All perks was been reseted";
	ShowShopText(activator, text);
}

function BuyReRollStock()
{
	local pl = GetPlayerClassByHandle(activator);
	local needmoney = null;

	local money = 10;

	if(pl.money >= pl.GetNewPrice(money))
	{
		pl.Minus_money(pl.GetNewPrice(money));
		pl.GetNewStock();
		local itemtext = "";
		local stock = split(pl.person_stock_one," ");
		if(stock.len() > 0)
		{
			for (local i = 0; i < stock.len(); i++)
			{
				if(stock[i] == "bio")itemtext += "|bio|";
				else if(stock[i] == "ice")itemtext += "|ice|";
				else if(stock[i] == "poison")itemtext += "|poison|";
				else if(stock[i] == "wind")itemtext += "|wind|";
				else if(stock[i] == "summon")itemtext += "|summon|";
				else if(stock[i] == "electro")itemtext += "|electro|";
				else if(stock[i] == "earth")itemtext += "|earth|";
				else if(stock[i] == "gravity")itemtext += "|gravity|";
				else if(stock[i] == "ultimate")itemtext += "|ultima|";
				else if(stock[i] == "heal")itemtext += "|heal|";
			}
		}
		else itemtext = "You lost and didn't get anything"
		local text = "You won a discount ticket!\n"+itemtext+"\n\nYour balance: "+pl.money+Money_pref;
		Fade_White(activator);
		ShowShopText(activator, text);
		return;
	}
	needmoney = pl.GetNewPrice(money);
	local text = "You don't have enough money!\nYou need "+needmoney+Money_pref+" more\n\nYour balance: "+pl.money+Money_pref;
	Fade_Red(activator);
	ShowShopText(activator, text);
}

function BuyStock()
{
	local pl = GetPlayerClassByHandle(activator);
	local item_array = split(pl.person_stock_one," ");
	local stocklen = item_array.len();
	if(stocklen == 0)
	{
		Fade_Red(activator);	
		BuyStockNo(activator);
		return;
	}
	
	local needmoney = 0;

	local lvlprice = 0;
	for (local i = 0; i < lvlcost.len(); i++)lvlprice += lvlcost[i];

	local money = stocklen * (lvlprice - lvlprice * 0.2);

	if(pl.money >= pl.GetNewPrice(money))
	{
		pl.Minus_money(pl.GetNewPrice(money));
		local itemtext = "";

		for (local i = 0; i < stocklen; i++)
		{
			if(item_array[i] == "bio")
			{
				pl.Set_level_bio(3);
				itemtext += "|bio|";
			}
			else if(item_array[i] == "ice")
			{
				pl.Set_level_ice(3);
				itemtext += "|ice|";
			}
			else if(item_array[i] == "poison")
			{
				pl.Set_level_poison(3);
				itemtext += "|poison|";
			}
			else if(item_array[i] == "wind")
			{
				pl.Set_level_wind(3);
				itemtext += "|wind|";
			}
			else if(item_array[i] == "summon")
			{
				pl.Set_level_summon(3);
				itemtext += "|summon|";
			}
			else if(item_array[i] == "electro")
			{
				pl.Set_level_electro(3);
				itemtext += "|electro|";
			}
			else if(item_array[i] == "earth")
			{
				pl.Set_level_earth(3);
				itemtext += "|earth|";
			}
			else if(item_array[i] == "gravity")
			{
				pl.Set_level_gravity(3);
				itemtext += "|gravity|";
			}
			else if(item_array[i] == "ultimate")
			{
				pl.Set_level_ultimate(3);
				itemtext += "|ultima|";
			}
			else if(item_array[i] == "heal")
			{
				pl.Set_level_heal(3);
				itemtext += "|heal|";
			}
		}
		if(itemtext == "")itemtext = "You lost and didn't get anything";
		local text = "You won a discount ticket!\n"+itemtext+"\n\nYour balance: "+pl.money+Money_pref;
		Fade_White(activator);
		ShowShopText(activator, text);
		return;
	}
	needmoney = pl.GetNewPrice(money);

	local text = "You don't have enough money!\nYou need "+needmoney+Money_pref+" more\n\nYour balance: "+pl.money+Money_pref;
	Fade_Red(activator);
	ShowShopText(activator, text);
}

function BuyItemNomore(handle)
{
	local text = "This item is out of stock!";
	ShowShopText(handle, text);
}

function BuyItem()
{
	if(activator.GetTeam() != 3 || GetItemByOwner(activator) != null)
		return Fade_Red(activator);

	local name = caller.GetName();
	local pl = GetPlayerClassByHandle(activator);
	local needmoney = null;
	if(name.find("ammo") != null)
	{
		if(item_ammo_count > 0)
		{
			needmoney = pl.GetNewPrice(item_ammo_cost);
			if(pl.money >= needmoney)
			{
				item_ammo_count--;
				pl.Minus_money(needmoney);
				GetItem(TEMP_AMMO,activator);
				local text = "You bought an Ammo Materia\n\nYour balance "+pl.money+Money_pref;
				Fade_White(activator);
				ShowShopText(activator, text);

				if(item_ammo_count == 0)
					EntFire("info_glow_ammo", "SetGlowDisabled", "", 0, null);
				return;
			}
		}
		else 
		{
			BuyItemNomore(activator);
			return Fade_Red(activator);
		}
		
	}
	else if(name.find("potion") != null)
	{
		if(item_potion_count > 0)
		{
			needmoney = pl.GetNewPrice(item_potion_cost);
			if(pl.money >= needmoney)
			{
				item_potion_count--;
				pl.Minus_money(needmoney);
				GetItem(TEMP_POTION,activator);
				local text = "You bought the Potion Materia\n\nYour balance "+pl.money+Money_pref;
				Fade_White(activator);
				ShowShopText(activator, text);

				if(item_potion_count == 0)
					EntFire("info_glow_potion", "SetGlowDisabled", "", 0, null);
				return;
			}

		}
		else 
		{
			BuyItemNomore(activator);
			return Fade_Red(activator);
		}
	}
	else if(name.find("phoenix") != null)
	{
		if(item_phoenix_count > 0)
		{
			needmoney = pl.GetNewPrice(item_phoenix_cost);
			if(pl.money >= needmoney)
			{
				item_phoenix_count--;
				pl.Minus_money(needmoney);
				GetItem(TEMP_PHOENIX,activator);
				local text = "You have bought a Phoenix Materia\n\nYour balance "+pl.money+Money_pref;
				Fade_White(activator);
				ShowShopText(activator, text);

				if(item_phoenix_count == 0)
					EntFire("info_glow_phoenix", "SetGlowDisabled", "", 0, null);
				return;
			}

		}
		else 
		{
			BuyItemNomore(activator);
			return Fade_Red(activator);
		}
	}
	local text = "You don't have enough money!\nYou need "+needmoney+Money_pref+" more\n\nYour balance: "+pl.money+Money_pref;
	Fade_Red(activator);
	ShowShopText(activator, text);
}

function GetItem(item_temp, handle)
{
	local item_maker = Entities.FindByName(null, item_temp);
	if(item_maker == null)
		return;

	local Pistol = null;
	while((Pistol = Entities.FindByClassname(Pistol,"weapon_*")) != null)
	{
		if(Pistol.GetOwner() == handle)
		{
			if(Pistol.GetClassname() == "weapon_cz75a" ||
			Pistol.GetClassname() == "weapon_deagle" ||
			Pistol.GetClassname() == "weapon_elite" ||
			Pistol.GetClassname() == "weapon_fiveseven" ||
			Pistol.GetClassname() == "weapon_glock" ||
			Pistol.GetClassname() == "weapon_hkp2000" ||
			Pistol.GetClassname() == "weapon_p250" ||
			Pistol.GetClassname() == "weapon_revolver" ||
			Pistol.GetClassname() == "weapon_usp_silencer")
			{
				Pistol.Destroy();
				break;
			}
		}
	}

	local handlepos = handle.GetOrigin();
	
	local makerpos = GetSpot();
	item_maker.SetOrigin(makerpos);
	EntFireByHandle(item_maker, "ForceSpawn", "", 0, null, null);
	EntFireByHandle(self, "RunScriptCode", "activator.SetOrigin(Vector(" + (makerpos.x) + "," + (makerpos.y) + "," + (makerpos.z - 5) + "));", 0, handle, handle);
	EntFireByHandle(self, "RunScriptCode", "activator.SetOrigin(Vector(" + (handlepos.x) + "," + (handlepos.y) + "," + (handlepos.z) + "));", 0.2, handle, handle);
}

function BuyPerk()
{
	local name = caller.GetName();
	local pl = GetPlayerClassByHandle(activator);
	local needmoney = null;

	if(name.find("hp_hm") != null)
	{
		local lvl = pl.perkhp_hm_lvl;
		if(lvl == perkhp_hm_maxlvl)
		{
			Fade_Red(activator);
			BuyPerkMax(activator)
			return;
		}
		needmoney = pl.GetNewPrice(perkhp_hm_cost);
		if(pl.money >= needmoney)
		{
			pl.level_up_perkheal_hm();
			pl.Minus_money(needmoney);

			if(activator.GetTeam() == 3)
			{
				activator.SetHealth(activator.GetHealth() + perkhp_hm_hpperlvl);
				activator.SetMaxHealth(100 + pl.perkhp_hm_lvl * perkhp_hm_hpperlvl);
			}

			local text = "You upgraded Human HP perk to level "+pl.perkhp_hm_lvl+"\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
	}
	else if(name.find("hp_zm") != null)
	{
		local lvl = pl.perkhp_zm_lvl;
		if(lvl == perkhp_zm_maxlvl)
		{
			Fade_Red(activator);
			BuyPerkMax(activator)
			return;
		}
		needmoney = pl.GetNewPrice(perkhp_zm_cost);
		if(pl.money >= needmoney)
		{
			pl.level_up_perkheal_zm();
			pl.Minus_money(needmoney);

			if(activator.GetTeam() == 2 && activator.GetHealth() >= 600)
			{
				activator.SetHealth(activator.GetHealth() + perkhp_zm_hpperlvl);
				activator.SetMaxHealth(7500 + pl.perkhp_zm_lvl * perkhp_zm_hpperlvl);
			}

			local text = "You upgraded Zombie HP perk to level "+pl.perkhp_zm_lvl+"\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}

	}
	else if(name.find("huckster") != null)
	{
		local lvl = pl.perkhuckster_lvl;
		if(lvl == perkhuckster_maxlvl)
		{
			Fade_Red(activator);
			BuyPerkMax(activator)
			return;
		}
		needmoney = perkhuckster_cost;
		if(pl.money >= needmoney)
		{
			pl.level_up_perkhuck();
			pl.Minus_money(needmoney);

			local text = "You upgraded Huckster perk to level "+pl.perkhuckster_lvl+"\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}

	}
	else if(name.find("speed") != null)
	{
		local lvl = pl.perkspeed_lvl;
		if(lvl == perkspeed_maxlvl)
		{
			Fade_Red(activator);
			BuyPerkMax(activator)
			return;
		}
		needmoney = pl.GetNewPrice(perkspeed_cost);
		if(pl.money >= needmoney)
		{
			pl.level_up_perkspeed();
			pl.Minus_money(needmoney);

			local text = "You upgraded Zombie Speed perk to level "+pl.perkspeed_lvl+"\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}

	}
	else if(name.find("steal") != null)
	{
		local lvl = pl.perksteal_lvl;
		if(lvl == perksteal_maxlvl)
		{
			Fade_Red(activator);
			BuyPerkMax(activator)
			return;
		}
		needmoney = pl.GetNewPrice(perksteal_cost);
		if(pl.money >= needmoney)
		{
			pl.level_up_perksteal();
			pl.Minus_money(needmoney);

			local text = "You upgraded Thief perk to level "+pl.perksteal_lvl+"\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}

	}
	else if(name.find("chameleon") != null)
	{
		local lvl = pl.perkchameleon_lvl;
		if(lvl == perkchameleon_maxlvl)
		{
			Fade_Red(activator);
			BuyPerkMax(activator)
			return;
		}
		needmoney = pl.GetNewPrice(perkchameleon_cost);
		if(pl.money >= needmoney)
		{
			pl.level_up_perkchameleon();
			pl.Minus_money(needmoney);

			local text = "You upgraded Zombie Chameleon perk to level "+pl.perkchameleon_lvl+"\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}

	}
	else if(name.find("resist_zm") != null)
	{
		local lvl = pl.perkresist_zm_lvl;
		if(lvl == perkresist_zm_maxlvl)
		{
			Fade_Red(activator);
			BuyPerkMax(activator)
			return;
		}
		needmoney = pl.GetNewPrice(perkresist_zm_cost);
		if(pl.money >= needmoney)
		{
			pl.level_up_perkresist_zm();
			pl.Minus_money(needmoney);

			local text = "You upgraded Human Materia Resist perk to level "+pl.perkresist_zm_lvl+"\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
	}
	if(name.find("resist_hm") != null)
	{
		local lvl = pl.perkresist_hm_lvl;
		if(lvl == perkresist_hm_maxlvl)
		{
			Fade_Red(activator);
			BuyPerkMax(activator)
			return;
		}
		needmoney = pl.GetNewPrice(perkresist_hm_cost);
		if(pl.money >= needmoney)
		{
			pl.level_up_perkresist_hm();
			pl.Minus_money(needmoney);

			local text = "You upgraded Attack Resist perk to level "+pl.perkresist_hm_lvl+"\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
	}
	else if(name.find("luck") != null)
	{
		local lvl = pl.perkluck_lvl;
		if(lvl == perkluck_maxlvl)
		{
			Fade_Red(activator);
			BuyPerkMax(activator)
			return;
		}
		needmoney = pl.GetNewPrice(perkluck_cost);
		if(pl.money >= needmoney)
		{
			pl.level_up_perkluck();
			pl.Minus_money(needmoney);

			local text = "You upgraded Lucky Warrior perk to level "+pl.perkluck_lvl+"\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}

	}
	local text = "You don't have enough money!\nYou need "+needmoney+Money_pref+" more\n\nYour balance: "+pl.money+Money_pref;
	Fade_Red(activator);
	ShowShopText(activator, text);
}

function BuyLevelMax(handle)
{
	local text = "You have already maxed out the level of this Materia";
	ShowShopText(handle, text);
}
function BuyBuff()
{
	local name = caller.GetName();
	local pl = GetPlayerClassByHandle(activator);
	local needmoney = pl.GetNewPrice(Buff_cost);
	if(name.find("double") != null)
	{
		if(pl.money >= needmoney)
		{
			pl.Change_Buff(4);
			pl.Minus_money(needmoney);
			local text = "You bought the 'W-magic' Support Materia\n[+]Gives 1 or 2 more uses to materias\n[-]Reduces Materia level and increases cooldown\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
	}
	else if(name.find("turbo") != null)
	{
		if(pl.money >= needmoney)
		{
			pl.Change_Buff(3);
			pl.Minus_money(needmoney);
			local text = "You bought the 'MP turbo' Support Materia\n[+]Increases Materia duration\n[-]Increases Materia cooldown\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
	}
	else if(name.find("recovery") != null)
	{
		if(pl.money >= needmoney)
		{
			pl.Change_Buff(2);
			pl.Minus_money(needmoney);
			local text = "You bought the 'Recovery' Support Materia\n[+]Reduces Materia cooldown\n[-]Reduces Materia duration\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
	}
	else if(name.find("last") != null)
	{
		if(pl.money >= needmoney)
		{
			pl.Change_Buff(1);
			pl.Minus_money(needmoney);
			local text = "You bought the 'Final Attack' Support Materia\n[+]Regenerates HP while holding the materia\n[-]Materia is used upon death\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
	}
	else if(name.find("radius") != null)
	{
		if(pl.money >= needmoney)
		{
			pl.Change_Buff(0);
			pl.Minus_money(needmoney);
			local text = "You bought the 'All' Materia\n[+]Increases the radius of Materia\n[-]Reduces the power of Materia\n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
	}

	local text = "You don't have enough money!\nYou need "+needmoney+Money_pref+" more\n\nYour balance: "+pl.money+Money_pref;
	Fade_Red(activator);
	ShowShopText(activator, text);
}

function BuyLevelUpItem()
{
	local name = caller.GetName();
	local pl = GetPlayerClassByHandle(activator);
	local needmoney = null;

	if(name.find("bio") != null)
	{
		local lvl = pl.bio_lvl;
		if(lvl == 3)
		{
			Fade_Red(activator);
		 	BuyLevelMax(activator)
			return
		}
		if(pl.money >= pl.GetNewPrice(lvlcost[lvl]))
		{
			pl.level_up_bio();
			pl.Minus_money(pl.GetNewPrice(lvlcost[lvl]));
			local text = "You upgraded Bio Materia to level "+pl.bio_lvl+" \n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
		needmoney = pl.GetNewPrice(lvlcost[lvl]);
	}
	else if(name.find("ice") != null)
	{
		local lvl = pl.ice_lvl;
		if(lvl == 3)
		{
			Fade_Red(activator);
		 	BuyLevelMax(activator)
			return
		}
		if(pl.money >= pl.GetNewPrice(lvlcost[lvl]))
		{
			pl.level_up_ice();
			pl.Minus_money(pl.GetNewPrice(lvlcost[lvl]));
			local text = "You upgraded Ice Materia to level "+pl.ice_lvl+" \n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
		needmoney = pl.GetNewPrice(lvlcost[lvl]);
	}
	else if(name.find("poison") != null)
	{
		local lvl = pl.poison_lvl;
		if(lvl == 3)
		{
			Fade_Red(activator);
		 	BuyLevelMax(activator)
			return
		}
		if(pl.money >= pl.GetNewPrice(lvlcost[lvl]))
		{
			pl.level_up_poison();
			pl.Minus_money(pl.GetNewPrice(lvlcost[lvl]));
			local text = "You upgraded Poison Materia to level "+pl.poison_lvl+" \n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
		needmoney = pl.GetNewPrice(lvlcost[lvl]);
	}
	else if(name.find("wind") != null)
	{
		local lvl = pl.wind_lvl;
		if(lvl == 3)
		{
			Fade_Red(activator);
		 	BuyLevelMax(activator)
			return
		}
		if(pl.money >= pl.GetNewPrice(lvlcost[lvl]))
		{
			pl.level_up_wind();
			pl.Minus_money(pl.GetNewPrice(lvlcost[lvl]));
			local text = "You upgraded Wind Materia to level "+pl.wind_lvl+" \n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
		needmoney = pl.GetNewPrice(lvlcost[lvl]);
	}
	else if(name.find("summon") != null)
	{
		local lvl = pl.summon_lvl;
		if(lvl == 3)
		{
			Fade_Red(activator);
		 	BuyLevelMax(activator)
			return
		}
		if(pl.money >= pl.GetNewPrice(lvlcost[lvl]))
		{
			pl.level_up_summon();
			pl.Minus_money(pl.GetNewPrice(lvlcost[lvl]));
			local text = "You upgraded Summon Materia to level "+pl.summon_lvl+" \n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
		needmoney = pl.GetNewPrice(lvlcost[lvl]);
	}
	else if(name.find("fire") != null)
	{
		local lvl = pl.fire_lvl;
		if(lvl == 3)
		{
			Fade_Red(activator);
		 	BuyLevelMax(activator)
			return
		}
		if(pl.money >= pl.GetNewPrice(lvlcost[lvl]))
		{
			pl.level_up_fire();
			pl.Minus_money(pl.GetNewPrice(lvlcost[lvl]));
			local text = "You upgraded Fire Materia to level "+pl.fire_lvl+" \n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
		needmoney = pl.GetNewPrice(lvlcost[lvl]);
	}
	else if(name.find("electro") != null)
	{
		local lvl = pl.electro_lvl;
		if(lvl == 3)
		{
			Fade_Red(activator);
		 	BuyLevelMax(activator)
			return
		}
		if(pl.money >= pl.GetNewPrice(lvlcost[lvl]))
		{
			pl.level_up_electro();
			pl.Minus_money(pl.GetNewPrice(lvlcost[lvl]));
			local text = "You upgraded Electro Materia to level "+pl.electro_lvl+" \n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
		needmoney = pl.GetNewPrice(lvlcost[lvl]);
	}
	else if(name.find("earth") != null)
	{
		local lvl = pl.earth_lvl;
		if(lvl == 3)
		{
			Fade_Red(activator);
		 	BuyLevelMax(activator)
			return
		}
		if(pl.money >= pl.GetNewPrice(lvlcost[lvl]))
		{
			pl.level_up_earth();
			pl.Minus_money(pl.GetNewPrice(lvlcost[lvl]));
			local text = "You upgraded Earth Materia to level "+pl.earth_lvl+" \n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
		needmoney = pl.GetNewPrice(lvlcost[lvl]);
	}
	else if(name.find("gravity") != null)
	{
		local lvl = pl.gravity_lvl;
		if(lvl == 3)
		{
			Fade_Red(activator);
		 	BuyLevelMax(activator)
			return
		}
		if(pl.money >= pl.GetNewPrice(lvlcost[lvl]))
		{
			pl.level_up_gravity();
			pl.Minus_money(pl.GetNewPrice(lvlcost[lvl]));
			local text = "You upgraded Gravity Materia to level "+pl.gravity_lvl+" \n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
		needmoney = pl.GetNewPrice(lvlcost[lvl]);
	}
	else if(name.find("ultimate") != null)
	{
		local lvl = pl.ultimate_lvl;
		if(lvl == 3)
		{
			Fade_Red(activator);
		 	BuyLevelMax(activator)
			return
		}
		if(pl.money >= pl.GetNewPrice(lvlcost[lvl]))
		{
			pl.level_up_ultimate();
			pl.Minus_money(pl.GetNewPrice(lvlcost[lvl]));
			local text = "You upgraded Ultima Materia to level "+pl.ultimate_lvl+" \n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
		needmoney = pl.GetNewPrice(lvlcost[lvl]);
	}
	else if(name.find("heal") != null)
	{
		local lvl = pl.heal_lvl;
		if(lvl == 3)
		{
			Fade_Red(activator);
		 	BuyLevelMax(activator)
			return
		}
		if(pl.money >= pl.GetNewPrice(lvlcost[lvl]))
		{
			pl.level_up_heal();
			pl.Minus_money(pl.GetNewPrice(lvlcost[lvl]));
			local text = "You upgraded Heal Materia to level "+pl.heal_lvl+" \n\nYour balance "+pl.money+Money_pref;
			Fade_White(activator);
			ShowShopText(activator, text);
			return;
		}
		needmoney = pl.GetNewPrice(lvlcost[lvl]);
	}
	local text = "You don't have enough money!\nYou need "+needmoney+Money_pref+" more\n\nYour balance: "+pl.money+Money_pref;
	ShowShopText(activator, text);
	Fade_Red(activator);
}

function AddCash(i,a = 0)
{
	local pl = GetPlayerClassByHandle(activator);
	local money = 0;
	if(a == 0)money = i;
	else
	{
		local lvl_luck = pl.perkluck_lvl
		if(lvl_luck > 0)money = RandomInt(i+  a * lvl_luck * perkluck_luckperlvl * 0.01,a + a * lvl_luck * perkluck_luckperlvl * 0.002);
		else money = RandomInt(i,a);
	}
	pl.Add_money(money);
}

function AddCashAll(i, TEAM = -1)
{
	local alive = true;
	if(TEAM != -1 && TEAM < 0)
	{
		alive = false;
		TEAM * -1;
	}

	foreach(pl in PLAYERS)
	{
		if(TEAM == -1)
		{
			pl.Add_money(i);
		}	

		else if(pl.handle != null && pl.handle.IsValid() && pl.handle.GetTeam() == TEAM)
		{
			if(alive)
			{
				if(pl.handle.GetHealth() <= 0)
					continue;
			}
			
			pl.Add_money(i);
		}
	}
}	

function RemoveCash(i)
{
	local pl = GetPlayerClassByHandle(activator);
	pl.Minus_money(i);
}

function BuyPerkMax(handle)
{
	local text = "You have already maxed out the level of this Perk";
	ShowShopText(handle, text);
}

function BuyStockNo(handle)
{
	local text = "Empty Kit";
	ShowShopText(handle, text);
}

function Fade_Poison(handle)
{
	EntFire("Poison_fade", "Fade", "", 0, handle);
}

function Fade_Red(handle)
{
	EntFire("fade_red", "Fade", "", 0, handle);
}

function Fade_White(handle)
{
	EntFire("fade_white", "Fade", "", 0, handle);
}

function InfoPerk()
{
	local name = caller.GetName();
	local pl = GetPlayerClassByHandle(activator);
	local perktext = "";
	local lvl = 0;
	local lvlMax = 0;
	local price = 0;
	if(name.find("hp_hm") != null){lvl = pl.perkhp_hm_lvl;lvlMax = perkhp_hm_maxlvl;price = pl.GetNewPrice(perkhp_hm_cost);perktext += "Human HP";}
	else if(name.find("hp_zm") != null){lvl = pl.perkhp_zm_lvl;lvlMax = perkhp_zm_maxlvl;price = pl.GetNewPrice(perkhp_zm_cost);perktext += "Zombie HP";}
	else if(name.find("huckster") != null){lvl = pl.perkhuckster_lvl;lvlMax = perkhuckster_maxlvl;price = perkhuckster_cost;perktext += "Huckster";}
	else if(name.find("speed") != null){lvl = pl.perkspeed_lvl;lvlMax = perkspeed_maxlvl;price = pl.GetNewPrice(perkspeed_cost);perktext += "Zombie Speed";}
	else if(name.find("steal") != null){lvl = pl.perksteal_lvl;lvlMax = perksteal_maxlvl;price = pl.GetNewPrice(perksteal_cost);perktext += "Thief";}
	else if(name.find("chameleon") != null){lvl = pl.perkchameleon_lvl;lvlMax = perkchameleon_maxlvl;price = pl.GetNewPrice(perkchameleon_cost);perktext += "Zombie Chameleon";}
	else if(name.find("resist_zm") != null){lvl = pl.perkresist_zm_lvl;lvlMax = perkresist_zm_maxlvl;price = pl.GetNewPrice(perkresist_zm_cost);perktext += "Attack Resist";}
	else if(name.find("resist_hm") != null){lvl = pl.perkresist_hm_lvl;lvlMax = perkresist_hm_maxlvl;price = pl.GetNewPrice(perkresist_hm_cost);perktext += "Human Materia Resist";}
	else if(name.find("luck") != null){lvl = pl.perkluck_lvl;lvlMax = perkluck_maxlvl;price = pl.GetNewPrice(perkluck_cost);perktext += "Lucky Warrior";}
	perktext += " ["+lvl+"/"+lvlMax+"]\n";
	if(lvl == lvlMax)perktext += "You can't upgrade anymore";
	else perktext += "Upgrade will cost "+ConvertPrice(price)+Money_pref;
	local text = "Your level of "+perktext+"\n\nYour balance "+pl.money+Money_pref;
	ShowShopText(activator, text);

}

::ConvertPrice <- function(money)
{	
	if (typeof money == "float")
	{
		money = format("%.2f", money).tofloat();
	}
	return money;
}

function InfoBuffReset()
{
	local pl = GetPlayerClassByHandle(activator);
	local text = "Reset Support Materia\n\nYour balance "+pl.money+Money_pref;
	ShowShopText(activator, text);
}

function InfoBuff()
{
	local name = caller.GetName();
	local pl = GetPlayerClassByHandle(activator);
	local bufftext = "";
	local infotext = "";
	if(pl.item_buff_radius)
		bufftext += "r Support Materia is 'All'\nReplace for ";
	else if(pl.item_buff_last)
		bufftext += "r Support Materia is 'Final Attack'\nReplace for ";
	else if(pl.item_buff_recovery)
		bufftext += "r Support Materia is 'Recovery'\nReplace for ";
	else if(pl.item_buff_turbo)
		bufftext += "r Support Materia is 'MP turbo'\nReplace for ";
	else if(pl.item_buff_doble)
		bufftext += "r Support Materia is 'W-magic'\nReplace for ";
	else 
		bufftext += " don't have a Support Materia\nBuying ";

	if(name.find("double") != null)
	{
		bufftext += "'W-magic'";
		infotext += "[+]Gives 1 or 2 more uses\n[-]Reduces Materia level and increases cooldown";
	}
	else if(name.find("turbo") != null)
	{
		bufftext += "'MP turbo'";
		infotext += "[+]Increases Materia duration\n[-]Increases Materia cooldown";
	}
	else if(name.find("recovery") != null)
	{
		bufftext += "'Recovery'";
		infotext += "[+]Reduces Materia cooldown\n[-]Reduces Materia duration";
	}
	else if(name.find("last") != null)
	{
		bufftext += "'Final Attack'";
		infotext += "[+]Regenerates HP while holding materia\n[-]Materia is used upon death";
	}
	else if(name.find("radius") != null)
	{
		bufftext += "'All'";
		infotext += "[+]Increases the radius of Materia\n[-]Reduces the power of Materia";
	}
	local text = "You"+bufftext+" will cost "+pl.GetNewPrice(Buff_cost)+Money_pref+"\n"+infotext+"\n\nYour balance "+pl.money+Money_pref;
	ShowShopText(activator, text);
}

function InfoBuffItem()
{
	local name = caller.GetName();
	local pl = GetPlayerClassByHandle(activator);
	local itemtext = "";
	local canbuy;
	local cost;
	local limit;
	local count;
	if(name.find("ammo") != null){itemtext += "Ammo";cost = pl.GetNewPrice(item_ammo_cost);count = item_ammo_count;limit = item_ammo_countB;}
	else if(name.find("potion") != null){itemtext += "Potion";cost = pl.GetNewPrice(item_potion_cost);count = item_potion_count;limit = item_potion_countB;}
	else if(name.find("phoenix") != null){itemtext += "Phoenix";cost = pl.GetNewPrice(item_phoenix_cost);count = item_phoenix_count;limit = item_phoenix_countB;}
	if(count <= 0)canbuy = "You can't buy more on this round";
	else canbuy = "Buying "+itemtext+" will cost "+ConvertPrice(cost)+Money_pref
	local text = "Item "+itemtext+" - "+count+" left\n"+canbuy+"\n\nYour balance "+pl.money+Money_pref;
	ShowShopText(activator, text);
}

function InfoItem()
{
	local name = caller.GetName();
	local pl = GetPlayerClassByHandle(activator);
	local itemtext = "";
	local lvl = "";
	if(name.find("bio") != null){lvl = pl.bio_lvl;itemtext += "Bio";}
	else if(name.find("ice") != null){lvl = pl.ice_lvl;itemtext += "Ice";}
	else if(name.find("poison") != null){lvl = pl.poison_lvl;itemtext += "Poison";}
	else if(name.find("wind") != null){lvl = pl.wind_lvl;itemtext += "Wind";}
	else if(name.find("summon") != null){lvl = pl.summon_lvl;itemtext += "Summon";}
	else if(name.find("fire") != null){lvl = pl.fire_lvl;itemtext += "Fire";}
	else if(name.find("electro") != null){lvl = pl.electro_lvl;itemtext += "Electro";}
	else if(name.find("earth") != null){lvl = pl.earth_lvl;itemtext += "Earth";}
	else if(name.find("gravity") != null){lvl = pl.gravity_lvl;itemtext += "Gravity";}
	else if(name.find("ultimate") != null){lvl = pl.ultimate_lvl;itemtext += "Ultima";}
	else if(name.find("heal") != null){lvl = pl.heal_lvl;itemtext += "Heal";}
	itemtext += " Materia ["+lvl+"/"+MaxLevel+"]\n";
	if(lvl == MaxLevel)itemtext += "You can't upgrade anymore";
	else itemtext += "Upgrade will cost "+ConvertPrice(pl.GetNewPrice(lvlcost[lvl]))+Money_pref;
	local text = "Your level of "+itemtext+"\n\nYour balance "+pl.money+Money_pref;
	ShowShopText(activator, text);
}

function InfoStock()
{
	//local name = caller.GetName();
	local pl = GetPlayerClassByHandle(activator);
	local stock = split(pl.person_stock_one," ");
	if(stock.len() == 0)return BuyStockNo(activator);
	local itemtext = "";

	local lvlprice = 0;
	for (local i = 0; i < lvlcost.len(); i++)lvlprice += lvlcost[i];
	local money = stock.len() * (lvlprice - lvlprice * 0.2);

	for (local i = 0; i < stock.len(); i++)
	{
		if(stock[i] == "bio")itemtext += "|bio|";
		else if(stock[i] == "ice")itemtext += "|ice|";
		else if(stock[i] == "poison")itemtext += "|poison|";
		else if(stock[i] == "wind")itemtext += "|wind|";
		else if(stock[i] == "summon")itemtext += "|summon|";
		else if(stock[i] == "electro")itemtext += "|electro|";
		else if(stock[i] == "earth")itemtext += "|earth|";
		else if(stock[i] == "gravity")itemtext += "|gravity|";
		else if(stock[i] == "ultimate")itemtext += "|ultima|";
		else if(stock[i] == "heal")itemtext += "|heal|";
	}
	local text = "Your personal new discount Kit costs "+ConvertPrice(pl.GetNewPrice(money))+Money_pref+"\n"+itemtext+"\n\nYour balance "+pl.money+Money_pref;
	ShowShopText(activator, text);
}

///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
//Item manager
function LevelUpItem()
{
	local name = caller.GetName();
	local pl = GetPlayerClassByHandle(activator);

	if(name.find("bio") != null)
	{
		if(pl.level_up_bio())
			EntFireByHandle(caller, "AddOutPut", "OnUser1 map_brush:RunScriptCode:LevelUpItem():0:1", 0.05, null, null);
	}
	else if(name.find("ice") != null)
	{
		if(pl.level_up_ice())
			EntFireByHandle(caller, "AddOutPut", "OnUser1 map_brush:RunScriptCode:LevelUpItem():0:1", 0.05, null, null);
	}
	else if(name.find("poison") != null)
	{
		if(pl.level_up_poison())
			EntFireByHandle(caller, "AddOutPut", "OnUser1 map_brush:RunScriptCode:LevelUpItem():0:1", 0.05, null, null);
	}
	else if(name.find("wind") != null)
	{
		if(pl.level_up_wind())
			EntFireByHandle(caller, "AddOutPut", "OnUser1 map_brush:RunScriptCode:LevelUpItem():0:1", 0.05, null, null);
	}
	else if(name.find("summon") != null)
	{
		if(pl.level_up_summon())
			EntFireByHandle(caller, "AddOutPut", "OnUser1 map_brush:RunScriptCode:LevelUpItem():0:1", 0.05, null, null);
	}
	else if(name.find("fire") != null)
	{
		if(pl.level_up_fire())
			EntFireByHandle(caller, "AddOutPut", "OnUser1 map_brush:RunScriptCode:LevelUpItem():0:1", 0.05, null, null);
	}
	else if(name.find("electro") != null)
	{
		if(pl.level_up_electro())
			EntFireByHandle(caller, "AddOutPut", "OnUser1 map_brush:RunScriptCode:LevelUpItem():0:1", 0.05, null, null);
	}
	else if(name.find("earth") != null)
	{
		if(pl.level_up_earth())
			EntFireByHandle(caller, "AddOutPut", "OnUser1 map_brush:RunScriptCode:LevelUpItem():0:1", 0.05, null, null);
	}
	else if(name.find("gravity") != null)
	{
		if(pl.level_up_gravity())
			EntFireByHandle(caller, "AddOutPut", "OnUser1 map_brush:RunScriptCode:LevelUpItem():0:1", 0.05, null, null);
	}
	else if(name.find("ultimate") != null)
	{
		if(pl.level_up_ultimate())
			EntFireByHandle(caller, "AddOutPut", "OnUser1 map_brush:RunScriptCode:LevelUpItem():0:1", 0.05, null, null);
	}
	else if(name.find("heal") != null)
	{
		if(pl.level_up_heal())
			EntFireByHandle(caller, "AddOutPut", "OnUser1 map_brush:RunScriptCode:LevelUpItem():0:1", 0.05, null, null);
	}
}

function PickUpItem()
{
	local name = caller.GetName();
	local pl = GetPlayerClassByHandle(activator);
	local lvl = 1;
	local color = ::GREEN;
	local item_name = "";
	local text = "Item: ";
	local havesupport = true;

	local postfix = GetItemByName(caller.GetName().slice(caller.GetPreTemplateName().len(),caller.GetName().len()))
	postfix.NewOwner(pl);
	
	if(name.find("bio") != null)
	{
		lvl = pl.bio_lvl;
		local item = GetItemPresetByName("bio");

		if(lvl == 0)lvl++;

		if (lvl == 1)
			SendToConsoleServerPS("sm_setcooldown 12558461 80");
		else if (lvl == 2)
			SendToConsoleServerPS("sm_setcooldown 12558461 75");
		else if (lvl == 3)
			SendToConsoleServerPS("sm_setcooldown 12558461 70");

		for(local i = 1; i <= lvl;i++)
		{
			EntFire("item_star"+i+"_bio"+postfix.name, "Enable", "", 0, null);
		}

		text += "Bio";
		text += "\nLevel: "+lvl.tostring();
		text += "\nEffect: "+item.effect;
		text += "\nRadius: "+item.GetRadius(lvl);
		if(pl.item_buff_radius)
		{
			text += " + "+ (item.GetRadius(lvl) * 1.3).tostring();
		}

		text += "\nDuration: "+item.GetDuration(lvl);
		if(pl.item_buff_turbo)
		{
			text += " + 1";
		}
		text += " seconds";
		text += "\nCD: "+item.GetCD(lvl);
		if(pl.item_buff_recovery)
		{
			text += " - 10";
		}

		text += " seconds";
		text += "\nDamage: "+item.GetDamage(lvl);

		item_name = "\x0A Bio\x01 ";

	}
	else if(name.find("ice") != null)
	{
		lvl = pl.ice_lvl;
		local item = GetItemPresetByName("ice");

		if(lvl == 0)lvl++;

		if (lvl == 1)
			SendToConsoleServerPS("sm_setcooldown 12559808 80");
		else if (lvl == 2)
			SendToConsoleServerPS("sm_setcooldown 12559808 75");
		else if (lvl == 3)
			SendToConsoleServerPS("sm_setcooldown 12559808 70");

		for(local i = 1; i <= lvl;i++)
		{
			EntFire("item_star"+i+"_ice"+postfix.name, "Enable", "", 0, null);
		}

		text += "Ice";
		text += "\nLevel: "+lvl.tostring();
		text += "\nEffect: "+item.effect;
		text += "\nRadius: "+item.GetRadius(lvl);

		if(pl.item_buff_radius)
		{
			text += " + "+ (item.GetRadius(lvl) * 1.3).tostring();
		}

		text += "\nDuration: "+item.GetDuration(lvl);
		if(pl.item_buff_turbo)
		{
			text += " + 1";
		}
		text += " seconds";
		text += "\nCD: "+item.GetCD(lvl);
		if(pl.item_buff_recovery)
		{
			text += " - 10";
		}
		text += " seconds";

		item_name = "\x0B Ice\x01 ";
	}
	else if(name.find("poison") != null)
	{
		lvl = pl.poison_lvl;
		local item = GetItemPresetByName("poison");

		if(lvl == 0)lvl++;

		for(local i = 1; i <= lvl;i++)
		{
			EntFire("item_star"+i+"_poison"+postfix.name, "Enable", "", 0, null);
		}


		text += "Poison";
		text += "\nLevel: "+lvl.tostring();
		text += "\nEffect: "+item.effect;
		text += "\nRadius: "+item.GetRadius(lvl);
		if(pl.item_buff_radius)
		{
			text += " + "+ (item.GetRadius(lvl) * 1.3).tostring();
		}
		text += "\nDuration: "+item.GetDuration(lvl);
		if(pl.item_buff_turbo)
		{
			text += " + 1";
		}
		text += " seconds";
		text += "\nCD: "+item.GetCD(lvl);
		if(pl.item_buff_recovery)
		{
			text += " - 10";
		}

		text += " seconds";
		text += "\nDamage: "+item.GetDamage(lvl);

		item_name = "\x06 Poison\x01 ";
	}
	else if(name.find("wind") != null)
	{
		lvl = pl.wind_lvl;
		local item = GetItemPresetByName("wind");

		if(lvl == 0)lvl++;

		if (lvl == 1)
			SendToConsoleServerPS("sm_setcooldown 12559138 80");
		else if (lvl == 2)
			SendToConsoleServerPS("sm_setcooldown 12559138 75");
		else if (lvl == 3)
			SendToConsoleServerPS("sm_setcooldown 12559138 70");

		for(local i = 1; i <= lvl;i++)
		{
			EntFire("item_star"+i+"_wind"+postfix.name, "Enable", "", 0, null);
		}

		text += "Wind";
		text += "\nLevel: "+lvl.tostring();
		text += "\nEffect: "+item.effect;
		text += "\nRadius: "+item.GetRadius(lvl);
		if(pl.item_buff_radius)
		{
			text += " + "+ (item.GetRadius(lvl) * 1.3).tostring();
		}
		text += "\nDuration: "+item.GetDuration(lvl);
		if(pl.item_buff_turbo)
		{
			text += " + 1";
		}
		text += " seconds";
		text += "\nCD: "+item.GetCD(lvl);
		if(pl.item_buff_recovery)
		{
			text += " - 10";
		}

		text += " seconds";

		item_name = "\x05 Wind\x01 ";
	}
	else if(name.find("summon") != null)
	{
		lvl = pl.summon_lvl;
		local item = GetItemPresetByName("summon");

		if(lvl == 0)lvl++;

		if (lvl == 1)
			SendToConsoleServerPS("sm_setcooldown 12559583 80");
		else if (lvl == 2)
			SendToConsoleServerPS("sm_setcooldown 12559583 75");
		else if (lvl == 3)
			SendToConsoleServerPS("sm_setcooldown 12559583 70");

		for(local i = 1; i <= lvl;i++)
		{
			EntFire("item_star"+i+"_summon"+postfix.name, "Enable", "", 0, null);
		}
		text += "Summon";
		text += "\nLevel: "+lvl.tostring();
		text += "\nEffect: "+item.effect;
		text += "\nRadius: "+item.GetRadius(lvl);
		if(pl.item_buff_radius)
		{
			text += " + "+ (item.GetRadius(lvl) * 1.3).tostring();
		}
		text += "\nDuration: "+item.GetDuration(lvl);
		if(pl.item_buff_turbo)
		{
			text += " + 1";
		}
		text += " seconds";
		text += "\nCD: "+item.GetCD(lvl);
		if(pl.item_buff_recovery)
		{
			text += " - 10";
		}

		text += " seconds";

		item_name = "\x09 Summon\x01 ";
	}
	else if(name.find("fire") != null)
	{
		lvl = pl.fire_lvl;
		local item = GetItemPresetByName("fire");

		if(lvl == 0)lvl++;

		if (lvl == 1)
			SendToConsoleServerPS("sm_setcooldown 12559662 75");
		else if (lvl == 2)
			SendToConsoleServerPS("sm_setcooldown 12559662 70");
		else if (lvl == 3)
			SendToConsoleServerPS("sm_setcooldown 12559662 65");

		for(local i = 1; i <= lvl;i++)
		{
			EntFire("item_star"+i+"_fire"+postfix.name, "Enable", "", 0, null);
		}

		text += "Fire";
		text += "\nLevel: "+lvl.tostring();
		text += "\nEffect: "+item.effect;
		text += "\nRadius: "+item.GetRadius(lvl);
		if(pl.item_buff_radius)
		{
			text += " + "+ (item.GetRadius(lvl) * 1.3).tostring();
		}
		text += "\nDuration: "+item.GetDuration(lvl);
		if(pl.item_buff_turbo)
		{
			text += " + 1";
		}
		text += " seconds";
		text += "\nCD: "+item.GetCD(lvl);
		if(pl.item_buff_recovery)
		{
			text += " - 10";
		}

		text += " seconds";
		text += "\nDamage: "+item.GetDamage(lvl);

		item_name = "\x02 Fire\x01 ";
	}
	else if(name.find("electro") != null)
	{
		lvl = pl.electro_lvl;
		local item = GetItemPresetByName("electro");

		if(lvl == 0)lvl++;

		if (lvl == 1)
			SendToConsoleServerPS("sm_setcooldown 12559503 80");
		else if (lvl == 2)
			SendToConsoleServerPS("sm_setcooldown 12559503 75");
		else if (lvl == 3)
			SendToConsoleServerPS("sm_setcooldown 12559503 70");

		for(local i = 1; i <= lvl;i++)
		{
			EntFire("item_star"+i+"_electro"+postfix.name, "Enable", "", 0, null);
		}
		text += "Electro";
		text += "\nLevel: "+lvl.tostring();
		text += "\nEffect: "+item.effect;
		text += "\nRadius: "+item.GetRadius(lvl);
		if(pl.item_buff_radius)
		{
			text += " + "+ (item.GetRadius(lvl) * 1.3).tostring();
		}
		text += "\nDuration: "+item.GetDuration(lvl);
		if(pl.item_buff_turbo)
		{
			text += " + 1";
		}
		text += " seconds";
		text += "\nCD: "+item.GetCD(lvl);
		if(pl.item_buff_recovery)
		{
			text += " - 10";
		}

		text += " seconds";
		text += "\nDamage: "+item.GetDamage(lvl);

		item_name = "\x0C Electro \x01 ";
	}
	else if(name.find("earth") != null)
	{
		lvl = pl.earth_lvl;
		local item = GetItemPresetByName("earth");

		if(lvl == 0)lvl++;

		if (lvl == 1)
			SendToConsoleServerPS("sm_setcooldown 12559894 80");
		else if (lvl == 2)
			SendToConsoleServerPS("sm_setcooldown 12559894 75");
		else if (lvl == 3)
			SendToConsoleServerPS("sm_setcooldown 12559894 70");

		for(local i = 1; i <= lvl;i++)
		{
			EntFire("item_star"+i+"_earth"+postfix.name, "Enable", "", 0, null);
		}

		text += "Earth";
		text += "\nLevel: "+lvl.tostring();
		text += "\nEffect: "+item.effect;
		text += "\nRadius: "+item.GetRadius(lvl);
		if(pl.item_buff_radius)
		{
			text += " + "+ (item.GetRadius(lvl) * 1.3).tostring();
		}
		text += "\nDuration: "+item.GetDuration(lvl);
		if(pl.item_buff_turbo)
		{
			text += " + 1";
		}
		text += " seconds";
		text += "\nCD: "+item.GetCD(lvl);
		if(pl.item_buff_recovery)
		{
			text += " - 10";
		}
		text += " seconds";

		item_name = "\x10 Earth\x01 ";
	}
	else if(name.find("gravity") != null)
	{
		lvl = pl.gravity_lvl;
		local item = GetItemPresetByName("gravity");

		if(lvl == 0)lvl++;

		if (lvl == 1)
			SendToConsoleServerPS("sm_setcooldown 12559425 80");
		else if (lvl == 2)
			SendToConsoleServerPS("sm_setcooldown 12559425 75");
		else if (lvl == 3)
			SendToConsoleServerPS("sm_setcooldown 12559425 70");

		for(local i = 1; i <= lvl;i++)
		{
			EntFire("item_star"+i+"_gravity"+postfix.name, "Enable", "", 0, null);
		}
		text += "Gravity";
		text += "\nLevel: "+lvl.tostring();
		text += "\nEffect: "+item.effect;
		text += "\nRadius: "+item.GetRadius(lvl);
		if(pl.item_buff_radius)
		{
			text += " + "+ (item.GetRadius(lvl) * 1.3).tostring();
		}
		text += "\nDuration: "+item.GetDuration(lvl);
		if(pl.item_buff_turbo)
		{
			text += " + 1";
		}
		text += " seconds";
		text += "\nCD: "+item.GetCD(lvl);
		if(pl.item_buff_recovery)
		{
			text += " - 10";
		}

		text += " seconds";
		text += "\nDamage: "+item.GetDamage(lvl);

		item_name = "\x0E Gravity\x01 ";
	}
	else if(name.find("ultimate") != null)
	{
		lvl = pl.ultimate_lvl;
		local item = GetItemPresetByName("ultimate");

		if(lvl == 0)lvl++;

		if (lvl == 1)
			SendToConsoleServerPS("sm_setcooldown 12558989 80");
		else if (lvl == 2)
			SendToConsoleServerPS("sm_setcooldown 12558989 90");
		else if (lvl == 3)
			SendToConsoleServerPS("sm_setcooldown 12558989 100");

		for(local i = 1; i <= lvl;i++)
		{
			EntFire("item_star"+i+"_ultimate"+postfix.name, "Enable", "", 0, null);
		}
		text += "Ultima";
		text += "\nLevel: "+lvl.tostring();
		text += "\nEffect: "+item.effect;
		text += "\nRadius: "+item.GetRadius(lvl);
		if(pl.item_buff_radius)
		{
			text += " + "+ (item.GetRadius(lvl) * 1.3).tostring();
		}
		text += "\nDuration: "+item.GetDuration(lvl);
		if(pl.item_buff_turbo)
		{
			text += " - 1";
		}

		text += " seconds";
		text += "\nDamage: "+item.GetDamage(lvl)+"% - "+item.GetTime(lvl);
		item_name = "\x04 Ultima\x01 ";
	}
	else if(name.find("heal") != null)
	{
		lvl = pl.heal_lvl;
		local item = GetItemPresetByName("heal");

		if(lvl == 0)lvl++;

		if (lvl == 1)
			SendToConsoleServerPS("sm_setcooldown 12559283 80");
		else if (lvl == 2)
			SendToConsoleServerPS("sm_setcooldown 12559283 75");
		else if (lvl == 3)
			SendToConsoleServerPS("sm_setcooldown 12559283 70");

		for(local i = 1; i <= lvl;i++)
		{
			EntFire("item_star"+i+"_heal"+postfix.name, "Enable", "", 0, null);
		}

		text += "Heal";
		text += "\nLevel: "+lvl.tostring();
		text += "\nEffect: "+item.effect;
		text += "\nRadius: "+item.GetRadius(lvl);
		if(pl.item_buff_radius)
		{
			text += " + "+ (item.GetRadius(lvl) * 1.3).tostring();
		}
		text += "\nDuration: "+item.GetDuration(lvl);
		if(pl.item_buff_turbo)
		{
			text += " + 1";
		}
		text += " seconds";
		text += "\nCD: "+item.GetCD(lvl);
		if(pl.item_buff_recovery)
		{
			text += " - 10";
		}

		text += " seconds";

		item_name = " Heal ";
	}
	else 
	{
		havesupport = false;
		if(name.find("potion") != null)
		{
			lvl = 1;
			local item = GetItemPresetByName("potion");
			if(lvl == 0)lvl++;
			text += "Potion";
			text += "\nEffect: "+item.effect;
			text += "\nRadius: "+item.GetRadius(lvl);
			text += "\nDuration: "+item.GetDuration(lvl);

			text += " seconds";

			item_name = " Potion ";
		}
		else if(name.find("ammo") != null)
		{
			lvl = 1;
			local item = GetItemPresetByName("ammo");
			if(lvl == 0)lvl++;
			text += "Ammo";
			text += "\nEffect: "+item.effect;
			text += "\nRadius: "+item.GetRadius(lvl);
			text += "\nDuration: "+item.GetDuration(lvl);
			text += " seconds";

			item_name = " Ammo ";
		}
		else if(name.find("phoenix") != null)
		{
			lvl = 1;
			local item = GetItemPresetByName("phoenix");
			if(lvl == 0)lvl++;
			text += "Phoenix";
			text += "\nEffect: "+item.effect;

			item_name = " Phoenix down ";
		}
	}

	if (havesupport)
	{
		for(local i = 1; i <= lvl;i++)
		{
			EntFire("item_star"+ i + "_" + postfix.name_right + "" + postfix.name, "Enable", "", 0, null);
			if (pl.vip)
			{
				EntFire("item_star"+ i + "_" + postfix.name_right + "" + postfix.name, "SetGlowEnabled", "", 0, null);
				EntFire("item_star"+ i + "_" + postfix.name_right + "" + postfix.name, "Alpha", "1", 0, null);
			}
		}

		if (pl.vip)
		{
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "Alpha", "1", 0, null);
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "SetGlowEnabled", "", 0, null);
		}

		if (pl.item_buff_radius)
		{
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "SetGlowColor", "0 255 0", 0, null);
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "color", "0 255 0", 0, null);
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "Enable", "", 0, null);
		}
		if (pl.item_buff_turbo)
		{
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "SetGlowColor", "255 255 0", 0, null);
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "color", "255 255 0", 0, null);
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "Enable", "", 0, null);
		}
		if (pl.item_buff_recovery)
		{
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "SetGlowColor", "140 0 255", 0, null);
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "color", "140 0 255", 0, null);
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "Enable", "", 0, null);
		}
		if (pl.item_buff_doble)
		{
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "SetGlowColor", "0 0 255", 0, null);
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "color", "0 0 255", 0, null);
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "Enable", "", 0, null);
		}
		if (pl.item_buff_last)
		{
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "SetGlowColor", "255 0 0", 0, null);
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "color", "255 0 0", 0, null);
			EntFire("item_star0_" + postfix.name_right + "" + postfix.name, "Enable", "", 0, null);
		}
	}
	if (ENT_WATCH_ENABLE)
	{
		if(lvl == 2)color = ::YELLOW;
		else if(lvl == 3)color = ::RED;
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} picked up"+ item_name+""+color+""+lvl+"\x01 level ***")
	}
	

	caller.__KeyValueFromString("message",text);
	EntFireByHandle(caller, "Display", "", 0, activator, activator);
}

function DropItem()
{
	local item_owner = GetItemByButton(caller);
	if(item_owner == null)
		return;

	local lvl = item_owner.lvl;
	if (item_owner.RemoveOwner())
	{
		if(ENT_WATCH_ENABLE)
		{
			local pl = GetPlayerClassByHandle(activator);
			if(pl != null)
			{
				local item_name = "";
				if(item_owner.name_right == "bio")
					item_name = "\x0A Bio\x01 ";
				if(item_owner.name_right == "ice")
					item_name = "\x0B Ice\x01 ";
				if(item_owner.name_right == "poison")
					item_name = "\x06 Poison\x01 ";
				if(item_owner.name_right == "summon")
					item_name = "\x09 Summon\x01 ";
				if(item_owner.name_right == "fire")
					item_name = "\x02 Fire\x01 ";
				if(item_owner.name_right == "wind")
					item_name = "\x05 Wind\x01 ";
				if(item_owner.name_right == "electro")
					item_name = "\x0C Electro \x01 ";
				if(item_owner.name_right == "earth")
					item_name = "\x10 Earth\x01 ";
				if(item_owner.name_right == "gravity")
					item_name = "\x0E Gravity\x01 ";
				if(item_owner.name_right == "ultimate")
					item_name = "\x04 Ultima\x01 ";
				if(item_owner.name_right == "heal")
					item_name = " Heal ";
				if(item_owner.name_right == "potion")
					item_name = " Potion ";
				if(item_owner.name_right == "ammo")
					item_name = " Ammo ";
				if(item_owner.name_right == "phoenix")
					item_name = " Phoenix down ";
				ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} dropped"+item_name+" "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***")
			}
		}
	}
}

//entwatch
function ShowItems()
{
	if (ENT_WATCH_ENABLE)
	{
		local text = "";
		local item_name_array = [];
		local item_data_array = [];
		for (local i = 0; i < ITEM_OWNER.len(); i++)
		{
			if(!ITEM_OWNER[i].button.IsValid())
			{
				ITEM_OWNER.remove(i);
				return ShowItems();
			}

			if(ITEM_OWNER[i].owner != null)
			{
				local item_name = ITEM_OWNER[i].name_right;
				local first = item_name.slice(0,1);
				local second = item_name.slice(1,item_name.len());
				local new_new_item_name = first.toupper() + second;
				item_name_array.push(new_new_item_name);
				item_data_array.push(ITEM_OWNER[i]);
			}
		}

		for (local i = 0; i < item_name_array.len(); i++)
		{
			//fix name
			{
				local id = 1;
				for (local a = 0; a < item_name_array.len(); a++)
				{
					if(item_name_array[i] == item_name_array[a])
					{
						if(item_data_array[i] != item_data_array[a])
						{
							item_name_array[a] += (id++).tostring();
						}
					}
				}
			}

			local pl = GetPlayerClassByHandle(item_data_array[i].owner);
			text += "\n" + item_name_array[i] + ((item_data_array[i].lvl != null) ? "[" + ((pl.item_buff_doble) ? "-" : "") + item_data_array[i].lvl + "]" : "");

			if(pl.item_buff_last)
			{
				local handle = pl.handle;
				local hp = handle.GetHealth()
				local hpmax = handle.GetMaxHealth();
				local sethp = hp + 1;
				if(sethp > hpmax)
					sethp = hpmax;
				handle.SetHealth(sethp);
			}
			
			if(item_data_array[i].canUse)
			{
				if(!item_data_array[i].button.GetScriptScope().GetStatus())
				{
					text += "[L]";
				}
				else
				{
					if(item_data_array[i].type == 1)
					{
						text += "[R]";
					}
					else if(item_data_array[i].type == 2)
					{
						text += "(" + item_data_array[i].count + ")";
					}
					else if(item_data_array[i].type == 3)
					{
						text += "(" + item_data_array[i].count + "/" + item_data_array[i].maxcount + ")";
					}
				}
			}
			else text += "["+item_data_array[i].cd+"]";
			text += pl.name;
		}

		if(text != "")
		{
			ItemText.__KeyValueFromString("message",text);
			foreach(pl in PLAYERS)
			{
				if(pl.block_entwatch)
					continue;

				if(pl.handle != null && pl.handle.IsValid() && pl.handle.GetTeam() != ((ENT_WATCH_TEAM) ? 2 : 0))
					EntFireByHandle(ItemText, "Display", "", 0.01, pl.handle, pl.handle);
			}
		}
	}
	else
	{
		for (local i = 0; i < ITEM_OWNER.len(); i++)
		{
			if(!ITEM_OWNER[i].button.IsValid())
			{
				ITEM_OWNER.remove(i);
				return ShowItems();
			}

			if(ITEM_OWNER[i].owner != null)
			{
				local pl = GetPlayerClassByHandle(ITEM_OWNER[i].owner);
				if(pl.item_buff_last)
				{
					local handle = pl.handle;
					local hp = handle.GetHealth()
					local hpmax = handle.GetMaxHealth();
					local sethp = hp + 1;
					if(sethp > hpmax)
						sethp = hpmax;
					handle.SetHealth(sethp);
				}
			}
		}
	}
	EntFireByHandle(self, "RunScriptCode", "ShowItems();", 0.5, null, null);
}


function UseUltimate()
{
	local pl = GetPlayerClassByHandle(activator);
	local item_owner = GetItemByButton(caller);
	local item_preset = GetItemPresetByName(item_owner.name_right);
	local postfix = item_owner.name;
	local lvl = pl.ultimate_lvl;
	if(pl.item_buff_doble)
		lvl--;
	if(lvl <= 0)
		lvl = 1;
	local worktime = item_preset.GetDuration(lvl);
	local radius = item_preset.GetRadius(lvl);
	local damage = item_preset.GetDamage((!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);
	local timehp = item_preset.GetTime((!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);
	local cd = item_preset.GetCD(lvl);

	if(pl.item_buff_radius)
	{
		radius *= 1.3;
	}
		
	local result = item_owner.Use();

	if(result == -1)
		return;
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used\x04 Ultima\x01 "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}
	if(!item_owner.canUse)
	{
		EntFire("item_effect_"+item_preset.name+""+postfix, "Stop", "", 0, null);
		EntFire("item_button_"+item_preset.name+""+postfix, "Lock", "", 0, null);
	}

	if(pl.item_buff_turbo)
	{	
		worktime -= 1.5;
	}
	if(pl.item_buff_recovery)
	{
		worktime += 1;
	}

	if(result == 1)
	{
		if(!item_owner.canUse)
		{
			if(pl.item_buff_turbo)
			{	
				cd += 15;
			}
			if(pl.item_buff_recovery)
			{
				cd -= 15;
			}
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);

			StartCD(cd);
		}
	}
	else if(result == 2)
	{
		EntFireByHandle(caller, "RunScriptCode", "useloc = false;", 0.00, null, null);
		EntFireByHandle(caller, "RunScriptCode", "useloc = true;", worktime + 6.00, null, null);
		StartCD(worktime + 6.00);
	}
	else if(result == 3)
	{
		local countercd = 100;
		cd = 160;

		if(pl.item_buff_turbo)
		{	
			countercd += 15
			cd += 20;
		}
		if(pl.item_buff_recovery)
		{
			countercd -= 15
			cd -= 20;
		}

		if(!item_owner.canUse)
		{
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);
			StartCD(cd);
		}
		else 
		{
			EntFireByHandle(caller, "RunScriptCode", "useloc = false;", 0.00, null, null);
			EntFireByHandle(caller, "RunScriptCode", "useloc = true;", worktime + 6.00, null, null);
			StartCD(worktime + 6.00);
		}

		StartCounter(countercd);
	}

	EntFire("item_sound_use", "PlaySound", "", 0, null);

	EntFire("item_sound_ultimate"+postfix, "PlaySound", "", 0, null);
	// if(pl.item_buff_doble)
	//     EntFire("item_effect_trigger_ultimate"+lvl+""+postfix, "DestroyImmediately", "", 0, null);
	// else
	EntFire("item_effect_trigger_ultimate"+lvl+""+postfix, "Start", "", 0.1, null);
	EntFire("item_effect_trigger_ultimate"+lvl+""+postfix, "Stop", "", worktime, null);
	EntFire("Ultima_fade" "Fade", "", worktime, null);


	if(Active_Boss != null)
	{
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOn", "", 0.00, null);
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOff", "", 2.00, null);
	}

	EntFireByHandle(self, "RunScriptCode", "UltimateHurt("+damage.tostring()+","+radius.tostring()+","+timehp.tostring()+","+((!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1).tostring()+")", worktime, caller, caller);
}

function UltimateHurt(damage,radius,timehp,lvl)
{
	Boss_Damage_Item("ultimate", lvl);

	local h = null;
	local AllZms = CountAlive(2);
	local UltimaZms = [];

	while(null != (h = Entities.FindByClassnameWithin(h, "player", caller.GetOrigin(), radius)))
	{
		if(h != null && h.IsValid() && h.GetHealth() > 0 && h.GetTeam() == 2)
		{
			UltimaZms.push(h);
		}
	}
	
	local ignore = true;
	for(local i = 0; i < UltimaZms.len(); i++)
	{
		local hhp = UltimaZms[i].GetHealth();
		local ph = hhp * damage * 0.01;
		//local p = GetPlayerClassByHandle(h);
		local hp = hhp - ph - timehp;
		if(hp <= 0)
		{
			if(ignore)
			{
				ignore = false;
				if(UltimaZms.len() == AllZms)
				{
					UltimaZms[i].SetOrigin(Vector(4480, -9984, -400));
					continue;
				}
			}
			EntFireByHandle(UltimaZms[i], "SetHealth", "-1", 0, null, null);
			EntFireByHandle(UltimaZms[i], "SetDamageFilter", "", 0.00, null, null);
		}
		else UltimaZms[i].SetHealth(hp);
	}
}

function CountAlive(TEAM = 3)
{
	local handle = null;
	local counter = 0;
	while(null != (handle = Entities.FindByClassname(handle,"player")))
	{
		if(handle.GetTeam() == TEAM && handle.GetHealth() > 0)
			counter++;
	}
	return counter;
}

function UseWind()
{
	local item_owner = GetItemByButton(caller);
	local postfix = item_owner.name;

	local trigger = Entities.FindByName(null, "item_trigger_wind"+postfix);

	local text;

	if(trigger.GetScriptScope().ticking)
		return;

	local pl = GetPlayerClassByHandle(activator);
	local item_preset = GetItemPresetByName(item_owner.name_right);
	local lvl = pl.wind_lvl;
	if(pl.item_buff_doble)
		lvl--;
	if(lvl <= 0)
		lvl = 1;

	local radius = item_preset.GetRadius(lvl);
	local worktime = item_preset.GetDuration(lvl);
	local cd = item_preset.GetCD(lvl);

	if(pl.item_buff_radius)
	{
		radius *= 1.3;
	}

	local result = item_owner.Use();

	if(result == -1)
		return;
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used\x05 Wind\x01 "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}

	if(!item_owner.canUse)
	{
		EntFire("item_effect_"+item_preset.name+""+postfix, "Stop", "", 0, null);
		EntFire("item_button_"+item_preset.name+""+postfix, "Lock", "", 0, null);
	}

	if(pl.item_buff_turbo)
	{	
		worktime += 1.5;
	}
	if(pl.item_buff_recovery)
	{
		worktime -= 1;
	}

	if(result == 1)
	{
		if(!item_owner.canUse)
		{
			if(pl.item_buff_turbo)
			{	
				cd += 15;
			}
			if(pl.item_buff_recovery)
			{
				cd -= 15;
			}

			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);

			StartCD(cd);
		}
	}
	else if(result == 2)
	{
		EntFireByHandle(caller, "RunScriptCode", "useloc = false;", 0.00, null, null);
		EntFireByHandle(caller, "RunScriptCode", "useloc = true;", worktime + 6.00, null, null);
		StartCD(worktime + 6.00);
	}
	else if(result == 3)
	{
		local countercd = 100;
		cd = 160;

		if(pl.item_buff_turbo)
		{	
			countercd += 15
			cd += 20;
		}
		if(pl.item_buff_recovery)
		{
			countercd -= 15
			cd -= 20;
		}

		if(!item_owner.canUse)
		{
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);
			StartCD(cd);
		}
		else 
		{
			EntFireByHandle(caller, "RunScriptCode", "useloc = false;", 0.00, null, null);
			EntFireByHandle(caller, "RunScriptCode", "useloc = true;", worktime + 6.00, null, null);
			StartCD(worktime + 6.00);
		}

		StartCounter(countercd);
	}

	EntFire("item_sound_use", "PlaySound", "", 0, null);

	trigger.GetScriptScope().dist = radius;
	trigger.GetScriptScope().power = item_preset.GetDamage((!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);

	EntFire("item_sound_wind"+postfix, "PlaySound", "", 0, null);

	EntFire("item_effect_trigger_wind"+lvl+""+postfix, "Start", "", 0, null);
	EntFire("item_trigger_wind"+postfix, "RunScriptCode", "Enable()", 0.01, null);

	EntFire("item_trigger_wind"+postfix, "RunScriptCode", "Disable()", worktime, null);
	// if(pl.item_buff_doble)
	//     EntFire("item_effect_trigger_wind"+lvl+""+postfix, "DestroyImmediately", "", worktime, null);
	// else 
	EntFire("item_effect_trigger_wind"+lvl+""+postfix, "Stop", "", worktime, null);

	if(Active_Boss != null && Active_Boss != "Cactus")
	{
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOn", "", 0.00, null);
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOff", "", 2.00, null);
	}

	Boss_Damage_Item(item_owner.name_right, (!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);
}

function UseIce()
{
	local item_owner = GetItemByButton(caller);
	local postfix = item_owner.name;

	local item_preset = GetItemPresetByName(item_owner.name_right);
	local pl = GetPlayerClassByHandle(activator);

	local lvl = pl.ice_lvl;
	if(pl.item_buff_doble)
	  lvl--;
	if(lvl <= 0)
	  lvl = 1;

	local Worktime = item_preset.GetDuration(lvl);
	local radius = item_preset.GetRadius(lvl);
	local time = item_preset.GetTime((!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);
	local cd = item_preset.GetCD(lvl);

	if(pl.item_buff_radius)
	{
		radius *= 1.3;
	}
	
	local result = item_owner.Use();

	if(result == -1)
		return;
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used\x0B Ice\x01 "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}
	if(!item_owner.canUse)
	{
		EntFire("item_effect_"+item_preset.name+""+postfix, "Stop", "", 0, null);
		EntFire("item_button_"+item_preset.name+""+postfix, "Lock", "", 0, null);
	}

	if(pl.item_buff_turbo)
	{
		Worktime += 2;
		time += 0.25;
	}
	if(pl.item_buff_recovery)
	{
		Worktime -= 2;
		time -= 0.25;
	}	

	if(result == 1)
	{
		if(!item_owner.canUse)
		{
			
			if(pl.item_buff_turbo)
			{	
				cd += 15;
			}
			if(pl.item_buff_recovery)
			{
				cd -= 15;
			}
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);

			StartCD(cd);
		}
	}
	else if(result == 3)
	{
		local countercd = 100;
		cd = 160;

		if(pl.item_buff_turbo)
		{	
			countercd += 15
			cd += 20;
		}
		if(pl.item_buff_recovery)
		{
			countercd -= 15
			cd -= 20;
		}

		if(!item_owner.canUse)
		{
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);
			StartCD(cd);
		}

		StartCounter(countercd);
	}

	EntFire("item_sound_use", "PlaySound", "", 0, null);

	Entities.FindByName(null, "item_spawner_ice"+postfix).SpawnEntity();

	local trigger = Entities.FindByName(null, "item_temp_ice_trigger");

	trigger.GetScriptScope().slow = time;
	trigger.GetScriptScope().dist = radius;
	trigger.GetScriptScope().power = item_preset.GetDamage((!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);

	local name = Time().tointeger()

	for(local i = 1; i <= 3; i++)
	{
		if(lvl != i)
		{
			EntFire("item_temp_ice_effect"+i, "Kill", "", 0.00, null);
			EntFire("item_temp_ice_model"+i, "Kill", "", 0.00, null);
		}
	}

	EntFire("item_temp_ice_effect"+lvl, "Start", "", 0, null);
	EntFire("item_temp_ice_model"+lvl, "RunScriptCode", "Spawn(0.5)", 0, null);

	EntFire("item_temp_ice_trigger", "AddOutPut", "targetname item_temp_ice_trigger"+name, 0, null);
	EntFire("item_temp_ice_effect"+lvl, "AddOutPut", "targetname item_temp_ice_effect"+lvl+""+name, 0, null);
	EntFire("item_temp_ice_model"+lvl, "AddOutPut", "targetname item_temp_ice_model"+lvl+""+name, 0, null);

	EntFire("item_temp_ice_trigger"+name, "Kill", "", Worktime, null);
	EntFire("item_temp_ice_effect"+lvl+""+name, "Kill", "", Worktime, null);
	EntFire("item_temp_ice_model"+lvl+""+name, "RunScriptCode", "Kill(" + (Worktime * 0.9) + ")", Worktime * 0.2, null);

	if(Active_Boss != null)
	{
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOn", "", 0.00, null);
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOff", "", 2.00, null);
	}

	Boss_Damage_Item(item_owner.name_right, (!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);
}

function UseElectro()
{
	local item_owner = GetItemByButton(caller);
	local postfix = item_owner.name;

	local item_preset = GetItemPresetByName(item_owner.name_right);
	local pl = GetPlayerClassByHandle(activator);

	local lvl = pl.electro_lvl;
	if(pl.item_buff_doble)
		lvl--;
	if(lvl <= 0)
		lvl = 1;

	local worktime = item_preset.GetDuration(lvl);
	local radius = item_preset.GetRadius(lvl);
	local cd = item_preset.GetCD(lvl);
	
	if(pl.item_buff_radius)
	{
		radius *= 1.3;
	}
	local result = item_owner.Use();

	if(result == -1)
		return;
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used\x0C Electro\x01 "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}

	if(!item_owner.canUse)
	{
		EntFire("item_effect_"+item_preset.name+""+postfix, "Stop", "", 0, null);
		EntFire("item_button_"+item_preset.name+""+postfix, "Lock", "", 0, null);
	}

	if(pl.item_buff_turbo)
	{	
		worktime += 1.5;
	}
	if(pl.item_buff_recovery)
	{
		worktime -= 1;
	}

	if(result == 1)
	{
		if(!item_owner.canUse)
		{
			if(pl.item_buff_turbo)
			{	
				cd += 5;
			}
			if(pl.item_buff_recovery)
			{
				cd -= 5;
			}
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);

			StartCD(cd);
		}
	}
	else if(result == 3)
	{
		local countercd = 20 * item_owner.maxcount;
		cd = 32 * item_owner.maxcount;

		if(pl.item_buff_turbo)
		{	
			countercd += 5
			cd += 10;
		}
		if(pl.item_buff_recovery)
		{
			countercd -= 5
			cd -= 10;
		}

		if(!item_owner.canUse)
		{
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);
			StartCD(cd);
		}

		StartCounter(countercd);
	}

	EntFire("item_sound_use", "PlaySound", "", 0, null);

	Entities.FindByName(null, "item_spawner_electro"+postfix).SpawnEntity();
	local trigger = Entities.FindByName(null, "item_temp_electro_trigger");

	trigger.GetScriptScope().dist = radius;
	trigger.GetScriptScope().damage = item_preset.GetDamage((!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1) * 0.05;
	trigger.GetScriptScope().slow = item_preset.GetTime((!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);

	local name = Time().tointeger()

	for(local i = 1; i <= 3; i++)
	{
		if(lvl != i)
			EntFire("item_temp_electro_effect"+i, "Kill", "", 0.00, null);
	}

	EntFire("item_temp_electro_effect"+lvl, "Start", "", 0, null);

	EntFire("item_temp_electro_trigger", "AddOutPut", "targetname item_temp_electro_trigger"+name, 0, null);
	EntFire("item_temp_electro_effect"+lvl, "AddOutPut", "targetname item_temp_electro_effect"+lvl+""+name, 0, null);

	EntFire("item_temp_electro_trigger"+name, "Kill", "", worktime, null);
	EntFire("item_temp_electro_effect"+lvl+""+name, "Kill", "", worktime, null);

	if(Active_Boss != null)
	{
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOn", "", 0.00, null);
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOff", "", 2.00, null);
	}

	Boss_Damage_Item(item_owner.name_right, (!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);
}

function UseSummon()
{
	local item_owner = GetItemByButton(caller);
	local postfix = item_owner.name;

	local item_preset = GetItemPresetByName(item_owner.name_right);
	local pl = GetPlayerClassByHandle(activator);

	local lvl = pl.summon_lvl;
	if(pl.item_buff_doble)
		lvl--;
	if(lvl <= 0)
		lvl = 1;

	local Worktime = item_preset.GetDuration(lvl);
	local radius = item_preset.GetRadius(lvl);
	local cd = item_preset.GetCD(lvl);

	if(pl.item_buff_radius)
	{
		radius *= 1.3;
	}

	local result = item_owner.Use();

	if(result == -1)
		return;
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used\x09 Summon\x01 "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}
	if(!item_owner.canUse)
	{
		EntFire("item_effect_"+item_preset.name+""+postfix, "Stop", "", 0, null);
		EntFire("item_button_"+item_preset.name+""+postfix, "Lock", "", 0, null);
	}

	if(pl.item_buff_turbo)
	{	
		Worktime += 1.5;
	}
	if(pl.item_buff_recovery)
	{
		Worktime -= 1;
	}

	if(result == 1)
	{
		if(!item_owner.canUse)
		{
			if(pl.item_buff_turbo)
			{	
				cd += 15;
			}
			if(pl.item_buff_recovery)
			{
				cd -= 15;
			}
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);

			StartCD(cd);
		}
	}
	else if(result == 3)
	{
		local countercd = 100;
		cd = 160;

		if(pl.item_buff_turbo)
		{
			countercd += 15
			cd += 20;
		}
		if(pl.item_buff_recovery)
		{
			countercd -= 15
			cd -= 20;
		}

		if(!item_owner.canUse)
		{
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);
			StartCD(cd);
		}

		StartCounter(countercd);
	}

	EntFire("item_sound_use", "PlaySound", "", 0, null);

	Entities.FindByName(null, "item_spawner_summon"+postfix).SpawnEntity();

	local trigger = Entities.FindByName(null, "item_temp_summon_trigger");

	trigger.GetScriptScope().dist = radius;
	trigger.GetScriptScope().power = item_preset.GetDamage((!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);
	trigger.GetScriptScope().worktime = item_preset.GetTime(lvl);
	trigger.GetScriptScope().Level = lvl;

	local name = Time().tointeger()
	EntFire("item_temp_summon_effect3", "AddOutPut", "targetname item_temp_summon_effect3"+name, 0.01, null);
	EntFire("item_temp_summon_effect2", "AddOutPut", "targetname item_temp_summon_effect2"+name, 0.01, null);
	EntFire("item_temp_summon_effect1", "AddOutPut", "targetname item_temp_summon_effect1"+name, 0.01, null);
	EntFire("item_temp_summon_trigger", "AddOutPut", "targetname item_temp_summon_trigger"+name, 0.01, null);
	EntFire("item_temp_summon_effect", "AddOutPut", "targetname item_temp_summon_effect"+name, 0.01, null);

	EntFire("item_temp_summon_trigger"+name, "RunScriptCode", "SelfDestroy();", Worktime, null);
	Boss_Damage_Item(item_owner.name_right, (!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);
}

function UseBio()
{
	local item_owner = GetItemByButton(caller);
	local postfix = item_owner.name;

	local item_preset = GetItemPresetByName(item_owner.name_right);
	local pl = GetPlayerClassByHandle(activator);

	local lvl = pl.bio_lvl;
	if(pl.item_buff_doble)
		lvl--;
	if(lvl <= 0)
		lvl = 1;

	local worktime = item_preset.GetDuration(lvl);
	local radius = item_preset.GetRadius(lvl);
	local cd = item_preset.GetCD(lvl);

	if(pl.item_buff_radius)
	{
		radius *= 1.3;
	}

	local result = item_owner.Use();

	if(result == -1)
		return;
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used\x0A Bio\x01 "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}
	if(!item_owner.canUse)
	{
		EntFire("item_effect_"+item_preset.name+""+postfix, "Stop", "", 0, null);
		EntFire("item_button_"+item_preset.name+""+postfix, "Lock", "", 0, null);
	}

	if(pl.item_buff_turbo)
	{	
		worktime += 1.5;
	}
	if(pl.item_buff_recovery)
	{
		worktime -= 1;
	}

	if(result == 1)
	{
		if(!item_owner.canUse)
		{
			if(pl.item_buff_turbo)
			{	
				cd += 15;
			}
			if(pl.item_buff_recovery)
			{
				cd -= 15;
			}

			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);

			StartCD(cd);
		}
	}
	else if(result == 3)
	{
		local countercd = 100;
		cd = 160;

		if(pl.item_buff_turbo)
		{	
			countercd += 15
			cd += 20;
		}
		if(pl.item_buff_recovery)
		{
			countercd -= 15
			cd -= 20;
		}
		
		if(!item_owner.canUse)
		{
			
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);
			StartCD(cd);
		}

		StartCounter(countercd);
	}

	EntFire("item_sound_use", "PlaySound", "", 0, null);

	Entities.FindByName(null, "item_spawner_bio"+postfix).SpawnEntity();

	local trigger = Entities.FindByName(null, "item_temp_bio_trigger");

	trigger.GetScriptScope().dist = radius;
	trigger.GetScriptScope().damage = item_preset.GetDamage((!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1) * 0.05;
	trigger.GetScriptScope().slow = item_preset.GetTime(lvl);

	local name = Time().tointeger();

	for(local i = 1; i <= 3; i++)
	{
		if(lvl != i)
			EntFire("item_temp_bio_effect"+i, "Kill", "", 0.00, null);
	}

	EntFire("item_temp_bio_effect"+lvl, "Start", "", 0, null);

	EntFire("item_temp_bio_trigger", "AddOutPut", "targetname item_temp_bio_trigger"+name, 0, null);
	EntFire("item_temp_bio_effect"+lvl, "AddOutPut", "targetname item_temp_bio_effect"+lvl+""+name, 0, null);

	EntFire("item_temp_bio_trigger"+name, "Kill", "", worktime, null);
	EntFire("item_temp_bio_effect"+lvl+""+name, "Kill", "", worktime, null);

	if(Active_Boss != null)
	{
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOn", "", 0.00, null);
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOff", "", 2.00, null);
	}

	Boss_Damage_Item(item_owner.name_right, (!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);
}



function UsePoison()
{
	local item_owner = GetItemByButton(caller);
	local postfix = item_owner.name;

	local item_preset = GetItemPresetByName(item_owner.name_right);
	local pl = GetPlayerClassByHandle(activator);

	local lvl = pl.poison_lvl;
	if(pl.item_buff_doble)
		lvl--;
	if(lvl <= 0)
		lvl = 1;
	
	local Worktime = item_preset.GetDuration(lvl);
	local radius = item_preset.GetRadius(lvl);
	local cd = item_preset.GetCD(lvl);

	if(pl.item_buff_radius)
	{
		radius *= 1.3;
	}

	local result = item_owner.Use();

	if(result == -1)
		return;
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used\x06 Poison\x01 "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}
	if(!item_owner.canUse)
	{
		EntFire("item_effect_"+item_preset.name+""+postfix, "Stop", "", 0, null);
		EntFire("item_button_"+item_preset.name+""+postfix, "Lock", "", 0, null);
	}

	if(pl.item_buff_turbo)
	{	
		Worktime += 1.5;
	}
	if(pl.item_buff_recovery)
	{
		Worktime -= 1;
	}


	if(result == 1)
	{
		if(!item_owner.canUse)
		{
			if(pl.item_buff_turbo)
			{	
				cd += 5;
			}
			if(pl.item_buff_recovery)
			{
				cd -= 5;
			}

			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);

			StartCD(cd);
		}
	}
	else if(result == 3)
	{
		local countercd = 20 * item_owner.maxcount;
		cd = 32 * item_owner.maxcount;

		if(pl.item_buff_turbo)
		{	
			countercd += 5
			cd += 10;
		}
		if(pl.item_buff_recovery)
		{
			countercd -= 5
			cd -= 10;
		}

		if(!item_owner.canUse)
		{
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);
			StartCD(cd);
		}

		StartCounter(countercd);
	}

	EntFire("item_sound_use", "PlaySound", "", 0, null);

	Entities.FindByName(null, "item_spawner_poison"+postfix).SpawnEntity();

	local trigger = Entities.FindByName(null, "item_temp_poison_trigger");

	trigger.GetScriptScope().lvl = lvl;
	trigger.GetScriptScope().dist = radius;
	trigger.GetScriptScope().damage = item_preset.GetDamage((!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1) * 0.05;
	trigger.GetScriptScope().slow = item_preset.GetTime(lvl);
	trigger.GetScriptScope().worktime = Worktime;
	trigger.GetScriptScope().Level = lvl;

	local name = Time().tointeger()

	EntFire("item_temp_poison_effect", "AddOutPut", "targetname item_temp_poison_effect"+name, 0.01, null);
	EntFire("item_temp_poison_effect_explosion1", "AddOutPut", "targetname item_temp_poison_effect_explosion1"+name, 0.01, null);
	EntFire("item_temp_poison_effect_explosion2", "AddOutPut", "targetname item_temp_poison_effect_explosion2"+name, 0.01, null);
	EntFire("item_temp_poison_effect_explosion3", "AddOutPut", "targetname item_temp_poison_effect_explosion3"+name, 0.01, null);
	EntFire("item_temp_poison_touch", "AddOutPut", "targetname item_temp_poison_touch"+name, 0.01, null);
	EntFire("item_temp_poison_trigger", "AddOutPut", "targetname item_temp_poison_trigger"+name, 0.01, null);
	EntFire("item_temp_poison_effect_smoke", "AddOutPut", "targetname item_temp_poison_effect_smoke"+name, 0.01, null);

	EntFire("item_temp_poison_trigger"+name, "RunScriptCode", "SelfDestroy()", 20.0, null);

	if(Active_Boss != null)
	{
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOn", "", 0.00, null);
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOff", "", 2.00, null);
	}

	Boss_Damage_Item(item_owner.name_right, (!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);
}

function UseEarth()
{
	local item_owner = GetItemByButton(caller);
	local postfix = item_owner.name;

	local item_preset = GetItemPresetByName(item_owner.name_right);
	local pl = GetPlayerClassByHandle(activator);

	local lvl = pl.earth_lvl;
	if(pl.item_buff_doble)
		lvl--;
	if(lvl <= 0)
		lvl = 1;
	
	local worktime = item_preset.GetDuration(lvl);
	local hp = item_preset.GetDamage(lvl);
	local cd = item_preset.GetCD(lvl);

	if(pl.item_buff_radius)
	{
		hp *= 1.5;
	}

	local result = item_owner.Use();

	if(result == -1)
		return;
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used\x10 Earth\x01 "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}
	if(!item_owner.canUse)
	{
		EntFire("item_effect_"+item_preset.name+""+postfix, "Stop", "", 0, null);
		EntFire("item_button_"+item_preset.name+""+postfix, "Lock", "", 0, null);
	}

	if(pl.item_buff_turbo)
	{	
		worktime += 1.5;
	}
	if(pl.item_buff_recovery)
	{
		worktime -= 1;
	}

	if(result == 1)
	{
		if(!item_owner.canUse)
		{
			if(pl.item_buff_turbo)
			{	
				cd += 15;
			}
			if(pl.item_buff_recovery)
			{
				cd -= 15;
			}

			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);

			StartCD(cd);
		}
	}
	else if(result == 3)
	{
		local countercd = 100;
		cd = 160;

		if(pl.item_buff_turbo)
		{	
			countercd += 15
			cd += 20;
		}
		if(pl.item_buff_recovery)
		{
			countercd -= 15
			cd -= 20;
		}
		
		if(!item_owner.canUse)
		{
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);
			StartCD(cd);
		}

		StartCounter(countercd);
	}

	EntFire("item_sound_use", "PlaySound", "", 0, null);

	Entities.FindByName(null, "item_spawner_earth"+postfix).SpawnEntity();

	local trigger = Entities.FindByName(null, "item_temp_earth_trigger");

	trigger.SetHealth(hp);

	local name = Time().tointeger()
	EntFire("item_temp_earth_trigger", "AddOutPut", "targetname item_temp_earth_trigger"+name, 0, null);
	EntFire("item_temp_earth_trigger", "AddOutPut", "targetname item_temp_earth_trigger"+name, 0, null);

	EntFire("item_temp_earth_trigger"+name, "Break", "", worktime, null);

	Boss_Damage_Item(item_owner.name_right, lvl);
}

function UseGravity()
{
	local item_owner = GetItemByButton(caller);
	local postfix = item_owner.name;

	local item_preset = GetItemPresetByName(item_owner.name_right);
	local pl = GetPlayerClassByHandle(activator);

	local lvl = pl.gravity_lvl;
	if(pl.item_buff_doble)
		lvl--;
	if(lvl <= 0)
		lvl = 1;

	local worktime = item_preset.GetDuration(lvl);
	local radius = item_preset.GetRadius(lvl);
	local cd = item_preset.GetCD(lvl);

	if(pl.item_buff_turbo)worktime += 2;
	if(pl.item_buff_radius)radius *= 1.3;

	if(pl.item_buff_radius)
	{
		radius *= 1.3;
	}

	local result = item_owner.Use();

	if(result == -1)
		return;
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used\x0E Gravity\x01 "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}
	if(!item_owner.canUse)
	{
		EntFire("item_effect_"+item_preset.name+""+postfix, "Stop", "", 0, null);
		EntFire("item_button_"+item_preset.name+""+postfix, "Lock", "", 0, null);
	}

	if(pl.item_buff_turbo)
	{	
		worktime += 1.5;
	}
	if(pl.item_buff_recovery)
	{
		worktime -= 1;
	}

	if(result == 1)
	{
		if(!item_owner.canUse)
		{
			if(pl.item_buff_turbo)
			{	
				cd += 15;
			}
			if(pl.item_buff_recovery)
			{
				cd -= 15;
			}

			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);

			StartCD(cd);
		}
	}
	else if(result == 3)
	{
		local countercd = 100;
		cd = 160;

		if(pl.item_buff_turbo)
		{
			countercd += 15
			cd += 20;
		}
		if(pl.item_buff_recovery)
		{
			countercd -= 15
			cd -= 20;
		}
		
		if(!item_owner.canUse)
		{
			
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);
			StartCD(cd);
		}

		StartCounter(countercd);
	}

	EntFire("item_sound_use", "PlaySound", "", 0, null);

	Entities.FindByName(null, "item_spawner_gravity"+postfix).SpawnEntity();

	local trigger = Entities.FindByName(null, "item_temp_gravity_trigger");

	trigger.GetScriptScope().dist = radius;
	trigger.GetScriptScope().power = item_preset.GetDamage((!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);

	local name = Time().tointeger()

	for(local i = 1; i <= 3; i++)
	{
		if(lvl != i)
			EntFire("item_temp_gravity_effect"+i, "Kill", "", 0.00, null);
	}

	EntFire("item_temp_gravity_effect"+lvl, "Start", "", 0, null);

	EntFire("item_temp_gravity_trigger", "AddOutPut", "targetname item_temp_gravity_trigger"+name, 0, null);
	EntFire("item_temp_gravity_effect"+lvl, "AddOutPut", "targetname item_temp_gravity_effect"+lvl+""+name, 0, null);
	EntFire("Item_temp_gravity_sound", "AddOutPut", "targetname Item_temp_gravity_sound"+name, 0, null);

	EntFire("item_temp_gravity_trigger"+name, "RunScriptCode", "Disable()", worktime, null);
	EntFire("item_temp_gravity_trigger"+name, "Kill", "", worktime+0.06, null);
	EntFire("item_temp_gravity_effect"+lvl+""+name, "Kill", "", worktime, null);
	EntFire("Item_temp_gravity_sound"+name, "Kill", "", worktime, null);

	if(Active_Boss != null)
	{
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOn", "", 0.00, null);
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOff", "", 2.00, null);
	}

	Boss_Damage_Item(item_owner.name_right, (!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);
}

function UseFire()
{
	local item_owner = GetItemByButton(caller);
	local postfix = item_owner.name;

	local trigger = Entities.FindByName(null, "item_trigger_fire"+postfix);
	if(trigger.GetScriptScope().ticking)
		return;

	local item_preset = GetItemPresetByName(item_owner.name_right);
	local pl = GetPlayerClassByHandle(activator);

	local lvl = pl.fire_lvl;
	if(pl.item_buff_doble)
		lvl--;
	if(lvl <= 0)
		lvl = 1;

	local radius = item_preset.GetRadius(lvl);
	local cd = item_preset.GetCD(lvl);
	local worktime = item_preset.GetDuration(lvl);

	if(pl.item_buff_radius)
	{
		radius *= 1.3;
	}

	local result = item_owner.Use();

	if(result == -1)
		return;
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used\x02 Fire\x01 "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}
	if(!item_owner.canUse)
	{
		EntFire("item_effect_"+item_preset.name+""+postfix, "Stop", "", 0, null);
		EntFire("item_button_"+item_preset.name+""+postfix, "Lock", "", 0, null);
	}

	if(pl.item_buff_turbo)
	{	
		worktime += 1.5;
	}
	if(pl.item_buff_recovery)
	{
		worktime -= 1;
	}
	if(result == 1)
	{
		if(!item_owner.canUse)
		{
			if(pl.item_buff_turbo)
			{	
				cd += 15;
			}
			if(pl.item_buff_recovery)
			{
				cd -= 15;
			}
			
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);

			StartCD(cd);
		}
	}
	else if(result == 2)
	{
		EntFireByHandle(caller, "RunScriptCode", "useloc = false;", 0.00, null, null);
		EntFireByHandle(caller, "RunScriptCode", "useloc = true;", worktime + 6.00, null, null);
		StartCD(worktime + 6.00);
	}
	else if(result == 3)
	{
		local countercd = 100;
		cd = 160;

		if(pl.item_buff_turbo)
		{	
			countercd += 15
			cd += 20;
		}
		if(pl.item_buff_recovery)
		{
			countercd -= 15
			cd -= 20;
		}

		if(!item_owner.canUse)
		{
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);
			StartCD(cd);
		}
		else 
		{
			EntFireByHandle(caller, "RunScriptCode", "useloc = false;", 0.00, null, null);
			EntFireByHandle(caller, "RunScriptCode", "useloc = true;", worktime + 6.00, null, null);
			StartCD(worktime + 6.00);
		}

		StartCounter(countercd);
	}

	EntFire("item_sound_use", "PlaySound", "", 0, null);

	trigger.GetScriptScope().dist = radius;
	trigger.GetScriptScope().damage = item_preset.GetDamage((!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1) * 0.05;
	trigger.GetScriptScope().flametime = item_preset.GetTime(lvl);

	EntFire("item_sound_fire"+postfix, "PlaySound", "", 0, null);

	EntFire("item_effect_trigger_fire"+lvl+""+postfix, "Start", "", 0, null);
	EntFire("item_trigger_fire"+postfix, "RunScriptCode", "Enable()", 0.01, null);

	EntFire("item_trigger_fire"+postfix, "RunScriptCode", "Disable()", worktime, null);

	// if(pl.item_buff_doble)
	//     EntFire("item_effect_trigger_fire"+lvl+""+postfix, "DestroyImmediately", "", worktime, null);
	// else 
	EntFire("item_effect_trigger_fire"+lvl+""+  postfix, "Stop", "", worktime, null);

	if(Active_Boss != null)
	{
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOn", "", 0.00, null);
		EntFire("item_beam_"+item_preset.name+""+postfix, "TurnOff", "", 2.00, null);
	}

	Boss_Damage_Item(item_owner.name_right, (!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);
}

function UseHeal()
{
	local item_owner = GetItemByButton(caller);
	local postfix = item_owner.name;

	local trigger = Entities.FindByName(null, "item_trigger_heal"+postfix);
	if(trigger.GetScriptScope().ticking)
		return;

	local item_preset = GetItemPresetByName(item_owner.name_right);
	local pl = GetPlayerClassByHandle(activator);

	local lvl = pl.heal_lvl;
	if(pl.item_buff_doble)
		lvl--;
	if(lvl <= 0)
		lvl = 1;

	local radius = item_preset.GetRadius(lvl);
	local worktime = item_preset.GetDuration(lvl);
	local cd = item_preset.GetCD(lvl);

	if(pl.item_buff_radius)
	{
		radius *= 1.3;
	}

	local result = item_owner.Use();

	if(result == -1)
		return;
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used Heal "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}
	if(!item_owner.canUse)
	{
		EntFire("item_effect_"+item_preset.name+""+postfix, "Stop", "", 0, null);
		EntFire("item_button_"+item_preset.name+""+postfix, "Lock", "", 0, null);
	}

	if(pl.item_buff_turbo)
	{	
		worktime += 1.5;
	}
	if(pl.item_buff_recovery)
	{
		worktime -= 1;
	}

	if(result == 1)
	{
		if(!item_owner.canUse)
		{
			if(pl.item_buff_turbo)
			{	
				cd += 15;
			}
			if(pl.item_buff_recovery)
			{
				cd -= 15;
			}

			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);

			StartCD(cd);
		}
	}
	else if(result == 2)
	{
		EntFireByHandle(caller, "RunScriptCode", "useloc = false;", 0.00, null, null);
		EntFireByHandle(caller, "RunScriptCode", "useloc = true;", worktime + 6.00, null, null);
		StartCD(worktime + 6.00);
	}
	else if(result == 3)
	{
		local countercd = 100;
		cd = 160;

		if(pl.item_buff_turbo)
		{	
			countercd += 15
			cd += 20;
		}
		if(pl.item_buff_recovery)
		{
			countercd -= 15
			cd -= 20;
		}

		if(!item_owner.canUse)
		{
			EntFire("item_effect_"+item_preset.name+""+postfix, "Start", "", cd, null);
			EntFire("item_button_"+item_preset.name+""+postfix, "UnLock", "", cd, null);
			StartCD(cd);
		}
		else 
		{
			EntFireByHandle(caller, "RunScriptCode", "useloc = false;", 0.00, null, null);
			EntFireByHandle(caller, "RunScriptCode", "useloc = true;", worktime + 6.00, null, null);
			StartCD(worktime + 6.00);
		}

		StartCounter(countercd);
	}

	EntFire("item_sound_use", "PlaySound", "", 0, null);

	trigger.GetScriptScope().dist = radius;
	trigger.GetScriptScope().worktime = worktime;
	trigger.GetScriptScope().lvl = lvl;

	EntFire("item_sound_heal"+postfix, "PlaySound", "", 0, null);

	EntFire("item_effect_trigger_heal"+lvl+""+postfix, "Start", "", 0, null);
	EntFire("item_trigger_heal"+postfix, "RunScriptCode", "Enable()", 0.01, null);

	EntFire("item_trigger_heal"+postfix, "RunScriptCode", "Disable()", worktime, null);

	// if(pl.item_buff_doble)
	//     EntFire("item_effect_trigger_heal"+lvl+""+postfix, "DestroyImmediately", "", worktime, null);
	// else 
	EntFire("item_effect_trigger_heal"+lvl+""+  postfix, "Stop", "", worktime, null);

	Boss_Damage_Item(item_owner.name_right, (!pl.item_buff_radius) ? lvl : (lvl <= 1) ? 1 : lvl - 1);
}

function UsePotion()
{
	local item_owner = GetItemByButton(caller);
	if(!item_owner.canUse)
		return;

	local postfix = item_owner.name;
	local item_preset = GetItemPresetByName(item_owner.name_right);

	local lvl = 1;

	local worktime = item_preset.GetDuration(lvl);
	local radius = item_preset.GetRadius(lvl);

	local pl = GetPlayerClassByHandle(activator);
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used Potion "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}
	EntFire("item_sound_use", "PlaySound", "", 0, null);

	local trigger = Entities.FindByName(null, "item_trigger_potion"+postfix);
	trigger.GetScriptScope().dist = radius;
		item_owner.cd = "E";
	item_owner.canUse = false;

	EntFire("item_effect_"+item_preset.name+""+postfix, "FadeAndKill", "", 0, null);

	EntFire("item_effect_potion"+postfix, "FadeAndKill", "", 0, null);
	EntFire("item_button_potion"+postfix, "Lock", "", 0, null);
	EntFire("item_sound_potion"+postfix, "PlaySound", "", 0, null);

	EntFire("item_effect_trigger_potion"+postfix, "Start", "", 0, null);
	EntFire("item_trigger_potion"+postfix, "RunScriptCode", "Enable()", 0.01, null);

	EntFire("item_trigger_potion"+postfix, "RunScriptCode", "Disable()", worktime, null);
	EntFire("item_effect_trigger_potion"+postfix, "Stop", "", worktime - 0.25, null);
}

function UseAmmo()
{
	local item_owner = GetItemByButton(caller);
	if(!item_owner.canUse)
		return;
	
	local postfix = item_owner.name;
	local item_preset = GetItemPresetByName(item_owner.name_right);

	local lvl = 1;

	local worktime = item_preset.GetDuration(lvl);
	local radius = item_preset.GetRadius(lvl);

	local pl = GetPlayerClassByHandle(activator);
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used Ammo "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}
	EntFire("item_sound_use", "PlaySound", "", 0, null);

	local trigger = Entities.FindByName(null, "item_trigger_"+item_preset.name+""+postfix);
	trigger.GetScriptScope().dist = radius;
	item_owner.cd = "E";
	item_owner.canUse = false;

	EntFire("item_effect_"+item_preset.name+""+postfix, "FadeAndKill", "", 0, null);

	EntFire("item_effect_"+item_preset.name+""+postfix, "Stop", "", 0, null);
	EntFire("item_button_"+item_preset.name+""+postfix, "Lock", "", 0, null);
	EntFire("item_sound_"+item_preset.name+""+postfix, "PlaySound", "", 0, null);

	EntFire("item_effect_trigger_"+item_preset.name+""+postfix, "Start", "", 0, null);
	EntFire("item_trigger_"+item_preset.name+""+postfix, "RunScriptCode", "Enable()", 0.01, null);

	EntFire("item_trigger_"+item_preset.name+""+postfix, "RunScriptCode", "Disable()", worktime, null);
	EntFire("item_effect_trigger_"+item_preset.name+""+postfix, "Stop", "", worktime - 0.25, null);
}

function UsePhoenix()
{
	local item_owner = GetItemByButton(caller);
	if(!item_owner.canUse)
		return;

	local postfix = item_owner.name;
	local item_preset = GetItemPresetByName(item_owner.name_right);

	local lvl = 1;

	local worktime = item_preset.GetDuration(lvl);
	local radius = item_preset.GetRadius(lvl);

	local pl = GetPlayerClassByHandle(activator);
	if (ENT_WATCH_ENABLE)
	{
		ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} used Phoenix down "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***");
	}
	EntFire("item_sound_use", "PlaySound", "", 0, null);

	local trigger = Entities.FindByName(null, "item_trigger_"+item_preset.name+""+postfix);
	trigger.GetScriptScope().dist = radius;
		item_owner.cd = "E";
	item_owner.canUse = false;

	EntFire("item_effect_"+item_preset.name+""+postfix, "FadeAndKill", "", 0, null);

	EntFire("item_effect_"+item_preset.name+""+postfix, "FadeAndKill", "", 0, null);
	EntFire("item_button_"+item_preset.name+""+postfix, "Lock", "", 0, null);
	EntFire("item_sound_"+item_preset.name+""+postfix, "PlaySound", "", 0, null);

	EntFire("item_effect_trigger_"+item_preset.name+""+postfix, "Start", "", 0, null);
	EntFire("item_trigger_"+item_preset.name+""+postfix, "RunScriptCode", "Enable()", 0.01, null);

	EntFire("item_trigger_"+item_preset.name+""+postfix, "RunScriptCode", "Disable()", worktime, null);
	EntFire("item_effect_trigger_"+item_preset.name+""+postfix, "Stop", "", worktime - 0.25, null);
	
	Boss_Damage_Item(item_owner.name_right, 1);
}

function CheckItem(pl)
{
	local item_owner = GetItemByOwner(pl.handle);
	if(item_owner == null)
		return;
	if(pl.item_buff_last && item_owner.allowRegen)
	{
		if(item_owner.count == 0)
			item_owner.count = 1;
	
		EntFireByHandle(item_owner.button, "FireUser4", "", 0, pl.handle, pl.handle);
	}

	local lvl = item_owner.lvl;
	if (item_owner.RemoveOwner())
	{
		if (ENT_WATCH_ENABLE)
		{
			local item_name = "";
			if(item_owner.name_right == "bio")
				item_name = "\x0A Bio\x01 ";
			if(item_owner.name_right == "ice")
				item_name = "\x0B Ice\x01 ";
			if(item_owner.name_right == "poison")
				item_name = "\x06 Poison\x01 ";
			if(item_owner.name_right == "summon")
				item_name = "\x09 Summon\x01 ";
			if(item_owner.name_right == "fire")
				item_name = "\x02 Fire\x01 ";
			if(item_owner.name_right == "wind")
				item_name = "\x05 Wind\x01 ";
			if(item_owner.name_right == "electro")
				item_name = "\x0C Electro \x01 ";
			if(item_owner.name_right == "earth")
				item_name = "\x10 Earth\x01 ";
			if(item_owner.name_right == "gravity")
				item_name = "\x0E Gravity\x01 ";
			if(item_owner.name_right == "ultimate")
				item_name = "\x04 Ultima\x01 ";
			if(item_owner.name_right == "heal")
				item_name = " Heal ";
			if(item_owner.name_right == "potion")
				item_name = " Potion ";
			if(item_owner.name_right == "ammo")
				item_name = " Ammo ";
			if(item_owner.name_right == "phoenix")
				item_name = " Phoenix down ";
			if(item_owner.name_right == "Red XIII")
				item_name = " Red XIII ";
			ScriptPrintMessageChatAll("***\x04 "+pl.name+"\x01 {\x07"+pl.steamid+"\x01} died and dropped"+item_name+" "+((lvl==3) ? RED : (lvl==2) ? YELLOW : GREEN)+""+((lvl != null) ? lvl : 0)+"\x01 level ***")
		}
	}
}

SilenceTime <- 20;
function UseSilence(time = SilenceTime)
{
	for (local i = 0; i < ITEM_OWNER.len(); i++)
	{
		if(!ITEM_OWNER[i].canSilence)
			continue;

		if(ITEM_OWNER[i].button != null)
		{
			local EnableTime = time;
			EntFireByHandle(ITEM_OWNER[i].button, "RunScriptCode", "au = false", 0, null, null);
			if(ITEM_OWNER[i].owner != null)
			{
				local pl = GetPlayerClassByHandle(ITEM_OWNER[i].owner);
				EnableTime = pl.Get_Resist_From_First_lvl(EnableTime);
			}
			EntFireByHandle(ITEM_OWNER[i].button, "RunScriptCode", "au = true", EnableTime, null, null);
		}
	}
}

Active_Boss <- null;
function Boss_Damage_Item(item_name, lvl)
{
	if(Active_Boss != null)
	{
		local damage = null;
		local heal = null;
		local temp = null;
		switch (Active_Boss)
		{
			case "Cactus":
			temp = "Temp_Cactus";

			if(item_name == "fire")
			{
				if(lvl == 1)
					damage = 90;
				else if(lvl == 2)
					damage = 180;
				else if(lvl == 3)
					damage = 270;
			}
			else if(item_name == "electro")
			{
				if(lvl == 1)
					damage = 50;
				else if(lvl == 2)
					damage = 80;
				else if(lvl == 3)
					damage = 120;
			}
			else if(item_name == "gravity")
			{
				if(lvl == 1)
					damage = 100;
				else if(lvl == 2)
					damage = 150;
				else if(lvl == 3)
					damage = 200;
			}
			else if(item_name == "ultimate")
			{
				if(lvl == 1)
					damage = 1000;
				else if(lvl == 2)
					damage = 1500;
				else if(lvl == 3)
					damage = 2000;
			}
			else if(item_name == "bio")
			{
				if(lvl == 1)
					heal = -1;
				else if(lvl == 2)
					heal = -2;
				else if(lvl == 3)
					heal = -3;
			}
			else if(item_name == "ice")
			{
				local time = 0;
				if(lvl == 1)
				{
					time = 3;
					damage = 50;
				}
				else if(lvl == 2)
				{
					time = 4;
					damage = 80;
				}
				else if(lvl == 3)
				{
					time = 5;
					damage = 120;
				}

				EntFire(temp, "RunScriptCode", "ItemEffect_Ice(" + time + ")", 0.00);
			}
			
			break;
			
			case "NattakCave":
			temp = "Temp_Gi_Nattak";

			if(item_name == "electro")
			{
				if(lvl == 1)
					damage = 150;
				else if(lvl == 2)
					damage = 250;
				else if(lvl == 3)
					damage = 350;
			}
			else if(item_name == "wind")
			{
				if(lvl == 1)
					damage = 200;
				else if(lvl == 2)
					damage = 300;
				else if(lvl == 3)
					damage = 400;
			}
			else if(item_name == "gravity")
			{
				if(lvl == 1)
					damage = 300;
				else if(lvl == 2)
					damage = 450;
				else if(lvl == 3)
					damage = 600;
			}
			else if(item_name == "bio")
			{
				if(lvl == 1)
					damage = 600;
				else if(lvl == 2)
					damage = 800;
				else if(lvl == 3)
					damage = 1000;
				EntFire("Minion_Lake_effect*", "Kill", "", 0.00);
			}
			else if(item_name == "ice")
			{
				local time = 0;
				if(lvl == 1)
				{
					time = 3;
					damage = 700;
				}
				else if(lvl == 2)
				{
					time = 4;
					damage = 1000;
				}
				else if(lvl == 3)
				{
					time = 5;
					damage = 1300;
				}

				EntFire("Minion_Lake_effect*", "Kill", "", 0.00);
				EntFire(temp, "RunScriptCode", "ItemEffect_Ice(" + time + ")", 0.00);
			}
			else if(item_name == "ultimate")
			{
				if(lvl == 1)
					damage = -2.5;
				else if(lvl == 2)
					damage = -3.5;
				else if(lvl == 3)
					damage = -4.5;
			}

			else if(item_name == "poison")
			{
				if(lvl == 1)
					heal = 300;
				else if(lvl == 2)
					heal = 500;
				else if(lvl == 3)
					heal = 700;
			}
			else if(item_name == "fire")
			{
				if(lvl == 1)
					heal = 1;
				else if(lvl == 2)
					heal = 2;
				else if(lvl == 3)
					heal = 3;
			}
			else if(item_name == "phoenix")
			{
				damage = -1.5;
			}

			break;
			
			case "NattakLast":
			temp = "Temp_Extreme";

			if(item_name == "electro")
			{
				if(lvl == 1)
					damage = 50;
				else if(lvl == 2)
					damage = 100;
				else if(lvl == 3)
					damage = 150;
			}
			else if(item_name == "wind")
			{
				if(lvl == 1)
					damage = 70;
				else if(lvl == 2)
					damage = 120;
				else if(lvl == 3)
					damage = 170;
			}
			else if(item_name == "gravity")
			{
				if(lvl == 1)
					damage = 100;
				else if(lvl == 2)
					damage = 150;
				else if(lvl == 3)
					damage = 200;
			}
			else if(item_name == "bio")
			{
				if(lvl == 1)
					damage = 100;
				else if(lvl == 2)
					damage = 200;
				else if(lvl == 3)
					damage = 300;
			}
			else if(item_name == "ice")
			{
				local time = 0;
				if(lvl == 1)
				{
					time = 3;
					damage = 150;
				}
				else if(lvl == 2)
				{
					time = 4;
					damage = 250;
				}
				else if(lvl == 3)
				{
					time = 5;
					damage = 350;
				}
				
				EntFire(temp, "RunScriptCode", "ItemEffect_Ice(" + time + ")", 0.00);
			}
			else if(item_name == "ultimate")
			{
				if(lvl == 1)
					damage = -3;
				else if(lvl == 2)
					damage = -4;
				else if(lvl == 3)
					damage = -5;
			}

			else if(item_name == "poison")
			{
				if(lvl == 1)
					heal = 100;
				else if(lvl == 2)
					heal = 150;
				else if(lvl == 3)
					heal = 200;
			}
			else if(item_name == "fire")
			{
				if(lvl == 1)
					heal = 2;
				else if(lvl == 2)
					heal = 3;
				else if(lvl == 3)
					heal = 4;
			}
			else if(item_name == "phoenix")
			{
				damage = -1.5;
			}

			break;

			case "Reno":
			
			break;

			case "AirBuster":
			temp = "Temp_AirBuster";

			if(item_name == "gravity")
			{
				if(lvl == 1)
					damage = -1;
				else if(lvl == 2)
					damage = -2;
				else if(lvl == 3)
					damage = -3;
			}
			else if(item_name == "wind")
			{
				if(lvl == 1)
					damage = 300;
				else if(lvl == 2)
					damage = 500;
				else if(lvl == 3)
					damage = 700;
			}
			else if(item_name == "electro")
			{
				if(lvl == 1)
					damage = 750;
				else if(lvl == 2)
					damage = 1100;
				else if(lvl == 3)
					damage = 1400;
			}
			else if(item_name == "bio")
			{
				if(lvl == 1)
					damage = 400;
				else if(lvl == 2)
					damage = 600;
				else if(lvl == 3)
					damage = 800;
			}
			else if(item_name == "ice")
			{
				if(lvl == 1)
					damage = 300;
				else if(lvl == 2)
					damage = 450;
				else if(lvl == 3)
					damage = 600;
			}
			else if(item_name == "fire")
			{
				if(lvl == 1)
					damage = 400;
				else if(lvl == 2)
					damage = 600;
				else if(lvl == 3)
					damage = 800;
			}
			else if(item_name == "poison")
			{
				if(lvl == 1)
					damage = 300;
				else if(lvl == 2)
					damage = 500;
				else if(lvl == 3)
					damage = 700;
			}
			else if(item_name == "ultimate")
			{
				if(lvl == 1)
					damage = -2;
				else if(lvl == 2)
					damage = -3;
				else if(lvl == 3)
					damage = -4;
			}
			else if(item_name == "earth")
			{
				if(lvl == 1)
					damage = 150;
				else if(lvl == 2)
					damage = 300;
				else if(lvl == 3)
					damage = 450;
			}
			break;
		}

		if(temp != null)
		{
			if(heal != null)
				EntFire(temp, "RunScriptCode", "AddHP(" + heal + ")", 0.00);
			if(damage != null)
				EntFire(temp, "RunScriptCode", "ItemDamage(" + damage + ")", 0.00);
		}
	}
}
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
//Player manager

function ElseCheck()
{
	if(PLAYERS.len() > 0)
	{
		for(local i = 0; i < PLAYERS.len(); i++)
		{
			local pl = PLAYERS[i].handle;
			if(MAPPER_STEAM_ID.len() > 0)
			{
				if(!PLAYERS[i].mapper)
				{
					for(local a = 0; a < MAPPER_STEAM_ID.len(); a++)
					{
						if(PLAYERS[i].steamid == MAPPER_STEAM_ID[a])
						{
							PLAYERS[i].mapper = true;
							PLAYERS[i].vip = true;
							ShowPlayerText(pl,"Thanks for map")
						}
					}
				}
			}
			if(VIP_STEAM_ID.len() > 0)
			{
				if(!PLAYERS[i].vip)
				{
					for(local a = 0; a < VIP_STEAM_ID.len(); a++)
					{
						if(PLAYERS[i].steamid == VIP_STEAM_ID[a])
						{
							PLAYERS[i].vip = true;
							ShowPlayerText(pl,"Thanks for supporting")
						}
					}
				}
			}
			if(pl != null)
			{
				if(pl.IsValid())
				{
					if(pl.GetHealth() >= 600 && pl.GetTeam() == 2)
					{
						if(PLAYERS[i].setPerks == false)
						{
							if(PLAYERS[i].tskin != null)
								pl.SetModel(PLAYERS[i].tskin);

							local alldone = true;

							if(PLAYERS[i].slow == false)
								EntFireByHandle(SpeedMod, "ModifySpeed", (PLAYERS[i].ReturnSpeed()).tostring(), 0.1, pl, pl);
							else 
								alldone = false;

							if(PLAYERS[i].perkchameleon_lvl > 0)
							{
								pl.__KeyValueFromInt("rendermode", 1);
								pl.__KeyValueFromInt("renderamt", (255 - (PLAYERS[i].perkchameleon_lvl * perkchameleon_chameleonperlvl)));
							}
							if(PLAYERS[i].perkhp_zm_lvl > 0)
							{
								local hp = 7500 + PLAYERS[i].perkhp_zm_lvl * perkhp_zm_hpperlvl;
								
								pl.SetHealth(hp);
								pl.SetMaxHealth(hp);
							}
							if(alldone)
							{
								local waffel_car = Entities.FindByName(null, "waffel_controller");
								waffel_car.GetScriptScope().DestroyCar(pl);
								EntFire("kojima_chest_" + PLAYERS[i].userid, "Kill", "", 0, null);
								PLAYERS[i].setPerks = true;
								PLAYERS[i].invalid = false;
							}
						}
					}
				}
			}
		}
	}
}

function CheckValidInArr()
{
	if(PLAYERS.len() > 0 && once_check)
	{
		local Temp_Player_Arr = [];
		for(local i = 0; i < PLAYERS.len(); i++)
		{
			if(PLAYERS[i].handle != null && PLAYERS[i].handle.IsValid())
			{
				Temp_Player_Arr.push(PLAYERS[i])
			}
		}
		PLAYERS.clear();
		for(local a = 0; a < Temp_Player_Arr.len(); a++)
		{
			PLAYERS.push(Temp_Player_Arr[a])
		}
		once_check = false;
	}
	return ElseCheck();
}

function Set_Player()
{
	if(!ValidHandleArr(activator))
	{
		PL_HANDLE.push(activator);
	}
}

function Reg_Player()
{
	if(PL_HANDLE.len() > 0)
	{
		EntFireByHandle(self, "RunScriptCode", "Reg_Player();", 0.10, null, null);
		TEMP_HANDLE = PL_HANDLE[0];
		PL_HANDLE.remove(0);
		if(TEMP_HANDLE.IsValid())
		{
			EntFireByHandle(eventproxy, "GenerateGameEvent", "", 0.00, TEMP_HANDLE, null);
		}
		else
		{
			return;
		}
	}
}

function ValidHandleArr(h)
{
	foreach(p in PLAYERS)
	{
		if(p.handle == h)
		{
			return true;
		}
	}
	return false;
}

function GetPlayerByUserID(userid)
{
	foreach(p in PLAYERS)
	{
		if(p.userid == userid)
		{
			return p.handle;
		}
	}
	return null;
}

function GetPlayerClassByHandle(handle)
{
	foreach(p in PLAYERS)
	{
		if(p.handle == handle)
		{
			return p;
		}
	}
	return null;
}

function GetPlayerClassByUserID(uid)
{
	foreach(p in PLAYERS)
	{
		if(p.userid == uid)
		{
			return p;
		}
	}
	return null;
}

function SetVipByHandle()
{
	foreach(p in PLAYERS)
	{
		if(p.handle == activator)
		{
			return p.SetMapper();
		}
	}
	return null;
}

function GetPlayerClassByMoney()
{
	local player_class = null;
	local money = 0;
	foreach(p in PLAYERS)
	{
		if(p.money > money)
		{
			player_class = p;
			money = p.money;
		}
	}
	return player_class;
}

function GetItemPresetByName(name)
{
	foreach (i in Item_Preset)
	{
		if(name == i.name)
		{
			return i;
		}
	}
	return null;
}

function GetItemPresetByName(name)
{
	foreach (i in Item_Preset)
	{
		if(name == i.name)
		{
			return i;
		}
	}
	return null;
}

///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
//event manager
function PlayerJump()
{
	if(eventjump == null || eventjump != null && !eventjump.IsValid())
	{
		eventjump = Entities.FindByName(null, "pl_jump");
	}

	local userid = eventjump.GetScriptScope().event_data.userid;
	local pl = GetPlayerClassByUserID(userid);
	if(pl != null)
	{
		if(pl.mike != null)
		{
			EntFireByHandle(pl.mike, "FireUser2", "", 0, null, null);
		}
		if(pl.pet != null)
		{
			local pet_index = GetPetIndexByHandle(pl.pet);
			if(pet_index != null)
			{
				pl.petstatus = "JUMP"
				EntFireByHandle(pl.pet, "SetAnimation", Pet_Preset[pet_index].anim_jump, 0, null, null);
				EntFireByHandle(pl.pet, "AddOutPut", "OnAnimationDone map_brush:RunScriptCode:PetStatus("+userid.tostring()+");:0:1", 0, pl.handle, pl.handle);
			}
		}
		if(pl.invalid)
		{
			local handle = pl.handle;
			handle.SetVelocity(Vector(handle.GetVelocity().x,handle.GetVelocity().y,0));
		}
	}
}

function PetStatus(userid)
{
	GetPlayerClassByUserID(userid).petstatus = "";
}

function GetPetIndexByHandle(handle)
{
	local model = handle.GetModelName()
	for(local i = 0;i < Pet_Preset.len() ;i++)
	{
		if(model == Pet_Preset[i].model_path)
		return i;
	}
	return null;
}

//needfix
function PlayerDisconnect()
{
	if(eventdisconnect == null || eventdisconnect != null && !eventdisconnect.IsValid())
	{
		eventdisconnect = Entities.FindByName(null, "pl_disconnect");
	}
	local userid = eventdisconnect.GetScriptScope().event_data.userid;
	local steamid = eventdisconnect.GetScriptScope().event_data.networkid;
	local pl = GetPlayerClassByUserID(userid);
	if(pl != null)
	{
		if(pl.steamid == steamid && pl.steamid != "BOT" && pl.steamid != "none")
		{
			PLAYERS_SAVE.push(pl);
		}
	}
}

function PlayerHurt() 
{
	if(eventhurt == null || eventhurt != null && !eventhurt.IsValid())
	{
		eventhurt = Entities.FindByName(null, "pl_hurt");
	}

	local userid = eventhurt.GetScriptScope().event_data.userid;
	local attacker = eventhurt.GetScriptScope().event_data.attacker;

	if(attacker == 0)
		return;

	local a = GetPlayerClassByUserID(attacker);

	if(a.handle == null || !a.handle.IsValid())
		return;

	//thanks NiceShoot for this code
	if(a.handle.GetTeam() == 3)
	{
		a.ShootTick(Shoot_OneMoney);
	}
}

function PlayerDeath()
{
	if(eventdeath == null || eventdeath != null && !eventdeath.IsValid())
	{
		eventdeath = Entities.FindByName(null, "pl_death");
	}

	local victim_userid = eventdeath.GetScriptScope().event_data.userid;
	local attacker_userid = eventdeath.GetScriptScope().event_data.attacker;

	local victim_player_class = GetPlayerClassByUserID(victim_userid);
	if(victim_player_class == null)
		return;

	CheckItem(victim_player_class);
	
	victim_player_class.setPerks = false;
	victim_player_class.invalid = false;

	{
		EntFire("kojima_chest_" + victim_userid, "Kill", "", 0, null);
	}

	if(victim_player_class.handle != null)
	{
		{
			EntFireByHandle(self, "RunScriptCode", "AntiDebuff(1.0)", 0, victim_player_class.handle, victim_player_class.handle);
		}

		{
			if(victim_player_class.handle.IsValid())
				if(victim_player_class.handle.GetModelName() == T_VIP_MODEL)
					EntFire("sound_sephiroth_death", "PlaySound", "", 0, null);
		}
		{
			local waffel_car = Entities.FindByName(null, "waffel_controller");
			waffel_car.GetScriptScope().DestroyCar(victim_player_class.handle);
		}
	}
	
	{
		if(victim_player_class.pet != null)
			victim_player_class.pet.Destroy();
	}
	
	if(attacker_userid == 0)
		return;

	local attacker_player_class = GetPlayerClassByUserID(attacker_userid);
	if(attacker_player_class == null)
		return;

	if(attacker_player_class.handle == victim_player_class.handle)
		return;

	if(attacker_player_class.handle == null || attacker_player_class.handle.IsValid())
		return;

	if(attacker_player_class.handle.GetTeam() == 3)
		attacker_player_class.infect++;

	if(attacker_player_class.perksteal_lvl < 1)
		return;

	local steal_value = attacker_player_class.perksteal_lvl * perksteal_stilleperlvl;
	local luck_value = victim_player_class.perkluck_lvl * perksteal_stilleperlvl;
	local min_value = steal_value - (luck_value * 0.5)
	local max_value = perksteal_stilleperlvl + steal_value - (luck_value * 0.5)
	local still_money = RandomInt(min_value, max_value);

	if(still_money < 0)
		return;

	local target_money = victim_player_class.money;
	if(target_money <= 10)
		return;
	
	if(attacker_player_class.handle.GetTeam() == 3)
		still_money = still_money * 0.5;

	if(target_money >= still_money)
	{
		victim_player_class.Minus_money(still_money);
		attacker_player_class.Add_money(still_money);
	}
	else
	{
		victim_player_class.Minus_money(target_money);
		attacker_player_class.Add_money(target_money);
	}
}

function PrintPerksAll()
{
	local timer = 0.0;
	local delay = 3.5;
	EntFireByHandle(self, "RunScriptCode", "PrintPerksInfo()", timer, null, null);
	EntFireByHandle(self, "RunScriptCode", "PrintPerksItem()", timer += delay, null, null);
	EntFireByHandle(self, "RunScriptCode", "PrintPerksPerk()", timer += delay, null, null);
	EntFireByHandle(self, "RunScriptCode", "PrintPerksPerk_hm()", timer += delay, null, null);
	EntFireByHandle(self, "RunScriptCode", "PrintPerksPerk_zm()", timer += delay, null, null);
}

function PrintPerksInfo()
{
	local SayScript = Entities.FindByName(null, "pl_say");
	local text = null;
	foreach(pl in PLAYERS)
	{
		if(pl.handle == null || !pl.handle.IsValid())
			continue;

		text = SayScript.GetScriptScope().PrintText_Info(pl);
		ShowPlayerText(pl.handle, text);
	}
}

function PrintPerksItem()
{
	local SayScript = Entities.FindByName(null, "pl_say");
	local text = null;
	foreach(pl in PLAYERS)
	{
		if(pl.handle == null || !pl.handle.IsValid())
			continue;

		text = SayScript.GetScriptScope().PrintText_Item(pl);
		ShowPlayerText(pl.handle, text);
	}
}

function PrintPerksPerk()
{
	local SayScript = Entities.FindByName(null, "pl_say");
	local text = null;
	foreach(pl in PLAYERS)
	{
		if(pl.handle == null || !pl.handle.IsValid())
			continue;

		text = SayScript.GetScriptScope().PrintText_Perk(pl);
		ShowPlayerText(pl.handle, text);
	}
}

function PrintPerksPerk_hm()
{
	local SayScript = Entities.FindByName(null, "pl_say");
	local text = null;
	foreach(pl in PLAYERS)
	{
		if(pl.handle == null || !pl.handle.IsValid())
			continue;

		text = SayScript.GetScriptScope().PrintText_Perk_hm(pl);
		ShowPlayerText(pl.handle, text);
	}
}

function PrintPerksPerk_zm()
{
	local SayScript = Entities.FindByName(null, "pl_say");
	local text = null;
	foreach(pl in PLAYERS)
	{
		if(pl.handle == null || !pl.handle.IsValid())
			continue;

		text = SayScript.GetScriptScope().PrintText_Perk_zm(pl);
		ShowPlayerText(pl.handle, text);
	}
}

EndPropRotate <- [];

class PropRotate
{
	handle = null;
	limitOrigin = null;
	up = false;
	rotateside = null;
	constructor(handle_)
	{
		this.handle = handle_;
		this.limitOrigin = [];
		this.limitOrigin.push(handle_.GetOrigin().z + RandomInt(-40, -25));
		this.limitOrigin.push(handle_.GetOrigin().z + RandomInt(15, 35));
		this.up = RandomInt(0,1);
		this.rotateside = RandomInt(-1,1);
	}

	function Move()
	{
		if(this.up)
		{
			this.handle.SetOrigin(this.handle.GetOrigin() + Vector(0, 0, 1))
			if(this.handle.GetOrigin().z >= this.limitOrigin[1])
				this.up = false;
		}
		else
		{
			this.handle.SetOrigin(this.handle.GetOrigin() - Vector(0, 0, 1))
			if(this.handle.GetOrigin().z <= this.limitOrigin[0])
				this.up = true;
		}

		if(this.rotateside == 1)
		{
			local angels = this.handle.GetAngles();
			this.handle.SetAngles(angels.x + 1, angels.y + 1, angels.z + 1)
		}
		else if(this.rotateside == 0)
		{
			local angels = this.handle.GetAngles();
			this.handle.SetAngles(angels.x - 1, angels.y - 1, angels.z - 1)
		}
	}
}
function StartPropEnd()
{
	local handle = null;
	local randomTimer;
	local randomOrigin;
	while(null != (handle = Entities.FindByName(handle,  "End_prop")))
	{
		randomTimer = RandomFloat(0.0, 5.0);
		EntFireByHandle(self, "RunScriptCode", "EndPropRotate.push(PropRotate(activator))", randomTimer, handle, handle);
	}
	RotateStartPropEnd()
}

function RotateStartPropEnd()
{
	if(EndPropRotate.len() > 0)
	{
		foreach(Prop in EndPropRotate)
		{
			Prop.Move();
		}
	}
	EntFireByHandle(self, "RunScriptCode", "RotateStartPropEnd()", 0.05, null, null);
}

function ShowCredits()
{
	local text;
	text = "" + MapName.toupper();
	ServerChat(Chat_pref + text);

	text = "Version: " + ScriptVersion;
	ServerChat(Chat_pref + text);

	text = "Map by Kondik, Kotya, Friend, Mizz(Haryde) and Microrost"
	ServerChat(Chat_pref + text);

	text = "More info - docs.google.com/spreadsheets/d/1V65cuBFta6nxAQkCVwxGqUJPMTszqJGQEUJFT_uKi9s"
	ServerChat(Chat_pref + text, 6.50);
}

function RandomEvent()
{
	local event = null;
	EVENT_2XMONEY = false;
	EVENT_EXTRAITEMS = false;
	EVENT_EXTRACHEST = false;
	EVENT_BLACKFRIDAY = false;

	if (RandomInt(1, 100) <= 20)
	{
		if ((RandomInt(0, 5) == 0) && !BHOP_ENABLE) 
		{
			SendToConsoleServerPS("sv_enablebunnyhopping 1");
			event = "[Event] Bhop enable";
		}
		else if (RandomInt(0, 4) == 0) 
		{
			EVENT_EXTRACHEST = true;
			event = "[Event] More chests to spawn on a map";
		}
		else if (RandomInt(0, 3) == 0) 
		{
			event = "[Event] Chicken mode";
			EntFire("Start_tp", "AddOutPut", "OnUser3 !activator:RunScriptCode:self.SetModel(CHICKEN_MODEL):0:-1", 3);
		}
		else if (RandomInt(0, 2) == 0) 
		{
			EVENT_EXTRAITEMS = true;
			event = "[Event] More materia to spawn on a map";
		}
		else if (RandomInt(0, 1) == 0) 
		{
			EVENT_2XMONEY = true;
			event = "[Event] x2 GIL for every way of getting it";
		}
		else
		{
			EVENT_BLACKFRIDAY = true;
			event = "[Event] Black friday - " + EVENT_BLACKFRIDAY_COUNT + "% discount";
		}
	}

	if (event != null)
	{
		ServerChat(Chat_pref + event);
		ServerChat(Chat_pref + event, 1.0);
		ServerChat(Chat_pref + event, 2.0);

		event = event.toupper();
		ShowCreditsText(event);
	}
}

Chat_Buffer <- [];

function ServerChat(text, delay = 0.00)
{
	if(delay > 0.00)
	{
		Chat_Buffer.push(text);
		EntFireByHandle(self, "RunScriptCode", "ServerChatText(" + (Chat_Buffer.len() - 1) + ")", delay, null, null);
	}
	else
		ScriptPrintMessageChatAll(text);
}

function ServerChatText(ID)
{
	ScriptPrintMessageChatAll(Chat_Buffer[ID]);   
}

function OpenSpawn(delay)
{
	EntFire("City_Spawn_Door", "Open", "", delay, null);
	EntFire("City_Spawn_Doorv2", "Open", "", delay - 3.5, null);
	EntFire("City_Glass", "Break", "", delay, null);
	EntFire("Shop_Block", "Break", "", delay + 7.00, null);	
	EntFire("spawntoshop_travel_trigger", "Kill", "", delay null);
}

function ToggleParticles()
{
	EntFire("shop_item_particle", "Stop", "", 0.50, null);
	EntFire("perk_particle", "Stop", "", 0.50, null);
	EntFire("kojima_*", "Stop", "", 0.50, null);

	EntFire("shop_item_particle", "Start", "", 1.00, null);
	EntFire("perk_particle", "Start", "", 1.00, null);
	EntFire("kojima_main_particle", "Start", "", 1.00, null);
	EntFire("Canyon_Fire", "StartFire", "", 1.00, null);
}


function Trigger_City_Gate()
{
	local timer = 10.0
	local text;

	text = "City gates open in "+timer+" seconds"
	ServerChat(Chat_pref + text);

	EntFire("City_Gate", "Open", "", timer);
	if(Stage == 4 || Stage == 5)
	{
		EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(2846,-3937,136),350,500)", timer - 0.1);
		EntFire("City_Gate", "Kill", "", timer - 0.05);
		EntFire("Temp_City_Gate", "ForceSpawn", "", timer);
	}
}

function Trigger_Left_Side_Path()
{
	local timer = 12.0
	local text;

	text = "The path open in "+timer+" seconds"
	ServerChat(Chat_pref + text);

	EntFire("Hold1_0_Clip", "Break", "", timer);

	EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(1706,-4718,907),180,99)", timer - 0.1);
}

function Trigger_Right_Side_Path()
{
	local timer = 13.0
	local text;

	text = "The path open in "+timer+" seconds"
	ServerChat(Chat_pref + text);

	EntFire("Hold1_2_Clip", "Break", "", timer);

	EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(1455,-2230,976),180,99)", timer - 0.1);
}

function Trigger_Cave_Bar_Lower_Path()
{
	local timer = 5.0
	local text;

	text = "The path open in "+timer+" seconds"
	ServerChat(Chat_pref + text);

	EntFire("Hold1_1_Clip", "Break", "", timer);

	EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-138,-1130,512),80,99)", timer - 0.1);
}

function Trigger_Cave_Bar_Up_Path()
{
	local timer = 4.0
	local text;

	text = "We are almost at Cosmo Canyon"
	ServerChat(Chat_pref + text);

	EntFire("Hold1_Clip", "Break", "", timer);

	EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-791,-862,1088),84,80)", timer - 0.1);
}

function Trigger_CosmoBar()
{
	if(Stage == 1)
	{
		local text;
		text = "it's been a while since you were kidnapped, Red";
		ServerChat(OldMan_pref + text, 10);

		text = "I am glad to see that you made it in one piece, even if there wasn't much hope";
		ServerChat(OldMan_pref + text, 13);

		text = "It would not have been possible without the help of these guys, and now we travel together";
		ServerChat(RedX_pref + text, 16);

		text = "Is there anything we could do before we leave?";
		ServerChat(RedX_pref + text, 19);

		text = "I'm worried about Gi's cave. Your father sacrificed himself a long time ago to protect the village.";
		ServerChat(OldMan_pref + text, 22);

		text = "It appears like the ancient evil has been awakened";
		ServerChat(OldMan_pref + text, 25);

		text = "Ok, let us scope out the severity of this evil";
		ServerChat(RedX_pref + text, 28);

		text = "I will be waiting for you guys at the observatories, good luck!";
		ServerChat(RedX_pref + text, 31);

		text = "Ghosts don't exist... right?";
		ServerChat(Tifa_pref + text, 35);

		text = "You don't know my village well.";
		ServerChat(RedX_pref + text, 38);

		text = "To be honest, I don't know you either";
		ServerChat(Tifa_pref + text, 41);

		text = "This place used to be my home three years ago before Shinra soldiers took me away";
		ServerChat(RedX_pref + text, 44);

		text = "I have been a lab rat since then";
		ServerChat(RedX_pref + text, 47);

		text = "Sorry, but I can't get used to you talking, not to mention about how I am terrified of ghosts.";
		ServerChat(Tifa_pref + text, 50);

		text = "Don't worry; we have plenty of time to get to know each other";
		ServerChat(RedX_pref + text, 53);

		text = "Agreed";
		ServerChat(Tifa_pref + text, 56);
	}
	if(Stage == 1 || Stage == 2)
	{
		local text;

		text = "The barman will open the door in 10 seconds"
		ServerChat(Chat_pref + text);

		text = "Zombies are coming. Defend Cosmo Bar for 32 seconds before we open the back door"
		ServerChat(Chat_pref + text, 7);

		text = "5 SECONDS LEFT"
		ServerChat(Chat_pref + text, 27);

		text = "FALL BACK"
		ServerChat(Chat_pref + text, 32);
		
		EntFire("Hold2_Door", "Open", "", 10.00);
		EntFire("Cosmo_Bar_Glasses", "Break", "", 12.00);

		EntFire("Hold3_Door", "Open", "", 32.00);
		EntFire("UpVillage_Border", "Kill", "", 35.00);
		EntFire("UpVillage_Border_fence", "Kill", "", 42.00);
	}
	else if(Stage == 4 || Stage == 5)
	{
		local text;

		text = "The barman will open the door in 5 esconds"
		ServerChat(Chat_pref + text);

		text = "Zombies are coming. Defend Cosmo Bar for 42 seconds before we open the back door";
		ServerChat(Chat_pref + text, 7);

		text = "5 SECONDS LEFT"
		ServerChat(Chat_pref + text, 37);

		text = "FALL BACK"
		ServerChat(Chat_pref + text, 42);

		EntFire("Hold2_Door", "Open", "", 4.50);
		EntFire("Hold2_Door", "Kill", "", 5.00);
		EntFire("Cosmo_Bar_Glasses", "Break", "", 5.00);

		EntFire("lvl3_Break", "Break", "", 5.00);
		
		
		EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-1549,-1103,1193),228,100,true)", 5.00);
		EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-1550,-1295,1193),228,100,true)", 5.01);
		if(Stage == 5)
			EntFire("lvl4_Break", "Break", "", 5.00);
		
		EntFire("Cosmo_Bar_Door", "Kill", "", 5.00);
		EntFire("Hold3_Door", "Open", "", 42.00);
		EntFire("UpVillage_Border", "Kill", "", 45.00);
		EntFire("UpVillage_Border_fence", "Kill", "", 51.00);
	}

	EntFire("Map_TP_1", "Enable", "", 40.00);

	{
		EntFire("info_perk_hp_hm", "Kill", "", 40.00);
		EntFire("shop_perk_hp_hm", "Kill", "", 40.00);

		EntFire("info_perk_resist_hm", "Kill", "", 40.00);
		EntFire("shop_perk_resist_hm", "Kill", "", 40.00);

		EntFire("info_perk_luck", "Kill", "", 40.00);
		EntFire("shop_perk_luck", "Kill", "", 40.00);

		EntFire("info_perk_huckster", "Kill", "", 40.00);
		EntFire("shop_perk_huckster", "Kill", "", 40.00);

		EntFire("info_perk_steal", "Kill", "", 40.00);
		EntFire("shop_perk_steal", "Kill", "", 40.00);

		EntFire("info_perk_hp_zm", "Kill", "", 40.00);
		EntFire("shop_perk_hp_zm", "Kill", "", 40.00);

		EntFire("info_perk_speed", "Kill", "", 40.00);
		EntFire("shop_perk_speed", "Kill", "", 40.00);

		EntFire("info_perk_chameleon", "Kill", "", 40.00);
		EntFire("shop_perk_chameleon", "Kill", "", 40.00);

		EntFire("info_perk_resist_zm", "Kill", "", 40.00);
		EntFire("shop_perk_resist_zm", "Kill", "", 40.00);

		EntFire("perk_reset", "Kill", "", 40.00);

		EntFire("info_item_buff_radius", "Kill", "", 40.00);
		EntFire("shop_item_buff_radius", "Kill", "", 40.00);

		EntFire("info_item_buff_last", "Kill", "", 40.00);
		EntFire("shop_item_buff_last", "Kill", "", 40.00);

		EntFire("info_item_buff_double", "Kill", "", 40.00);
		EntFire("shop_item_buff_double", "Kill", "", 40.00);

		EntFire("info_item_buff_turbo", "Kill", "", 40.00);
		EntFire("shop_item_buff_turbo", "Kill", "", 40.00);

		EntFire("info_item_buff_reset", "Kill", "", 40.00);
		EntFire("shop_item_buff_reset", "Kill", "", 40.00);

		EntFire("info_item_buff_recovery", "Kill", "", 40.00);
		EntFire("shop_item_buff_recovery", "Kill", "", 40.00);


		EntFire("info_item_gravity", "Kill", "", 40.00);
		EntFire("shop_item_gravity", "Kill", "", 40.00);

		EntFire("info_item_summon", "Kill", "", 40.00);
		EntFire("shop_item_summon", "Kill", "", 40.00);

		EntFire("info_item_earth", "Kill", "", 40.00);
		EntFire("shop_item_earth", "Kill", "", 40.00);

		EntFire("info_item_wind", "Kill", "", 40.00);
		EntFire("shop_item_wind", "Kill", "", 40.00);

		EntFire("info_item_heal", "Kill", "", 40.00);
		EntFire("shop_item_heal", "Kill", "", 40.00);

		EntFire("info_item_ultimate", "Kill", "", 40.00);
		EntFire("shop_item_ultimate", "Kill", "", 40.00);

		EntFire("info_item_poison", "Kill", "", 40.00);
		EntFire("shop_item_poison", "Kill", "", 40.00);

		EntFire("info_item_fire", "Kill", "", 40.00);
		EntFire("shop_item_fire", "Kill", "", 40.00);

		EntFire("info_item_bio", "Kill", "", 40.00);
		EntFire("shop_item_bio", "Kill", "", 40.00);

		EntFire("info_item_ice", "Kill", "", 40.00);
		EntFire("shop_item_ice", "Kill", "", 40.00);

		EntFire("info_item_electro", "Kill", "", 40.00);
		EntFire("shop_item_electro", "Kill", "", 40.00);
	}

	EntFire("shop_travel_trigger", "Kill", "", 40.00);
	EntFire("shop_stock", "Kill", "", 40.00);
	EntFire("shop_reroll", "Kill", "", 40.00);

	EntFire("kojima_main_trigger", "Kill", "", 40.00)

	EntFire("City_Spawn_Doorv2", "Kill", "", 40.00);
	EntFire("City_Spawn_Door", "Kill", "", 40.00);
}

function Trigger_Rock()
{
	local text;

	EntFire("Hold4_Bomb_Sprite", "FireUser1", "", 0);
	if(Stage == 4 || Stage == 5)
		EntFire("lvl3_Wood_Door", "Break", "", 0);

	if(Stage == 1)
		EntFire("Hold5_Rock", "Kill", "", 0);
	
	if(Stage == 2)
	{
		text = "I wonder why locals are so cautious. Kaktuars are a peaceful kind";
		ServerChat(Tifa_pref + text, 30.00);

		text = "it's no ordinary Kaktuar. There are myths that there is a legendary kaktuar that can walk";
		ServerChat(RedX_pref + text, 33.00);

		text = "That legendary kaktuar attacks everyone indiscriminately.";
		ServerChat(RedX_pref + text, 36.00);
	}

	local timer = 0;
	if(Stage == 2)
		timer = 2;
	if(Stage == 4)
		timer = 4;
	if(Stage == 5)
		timer = 6;

	text = "The explosives will blow the rocks up in " + (25 + timer) + " seconds"
	ServerChat(Chat_pref + text);

	text = "5 SECONDS LEFT"
	ServerChat(Chat_pref + text, 20 + timer);

	text = "FALL BACK"
	ServerChat(Chat_pref + text, 25 + timer);

	EntFire("Hold4_Bomb_Sprite", "AddOutput", "OnUser1 Hold4_Bomb_Sprite:ToggleSprite::0.3:-1", 20 + timer);
	EntFire("Hold4_Bomb_Sprite", "AddOutput", "OnUser1 Hold4_Bomb_Sprite:ToggleSprite::0.5:-1", 20 + timer);
	EntFire("Hold4_Bomb_Sprite", "AddOutput", "OnUser1 Hold4_Bomb_Sprite:ToggleSprite::0.6:-1", 25 + timer);
	EntFire("Hold4_Bomb_Sprite", "AddOutput", "OnUser1 Hold4_Bomb_Sprite:ToggleSprite::0.8:-1", 25 + timer);
	EntFire("Hold4_Rock", "Break", "", 25.05 + timer);

	EntFire("Hold4_Clip", "Kill", "", 25.05 + timer);
	EntFire("Hold4_Bomb_Sprite", "Kill", "", 25.05 + timer);
	EntFire("Hold4_Bomb", "Kill", "", 25.05 + timer);

	EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-4698,-3752,1870),256,100)", 25 + timer);
	EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-4620,-4268,1758),228,100)", 25.01 + timer);
	EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-4718,-4333,2159),228,100)", 25.02 + timer);
	
	EntFire("music", "RunScriptCode", "GetMusicExplosion();", 25.05 + timer);
	
	EntFire("City_Gate", "Kill", "", 0.00);
	EntFire("perk_particle", "Kill", "", 0.00);
	EntFire("Text", "Kill", "", 0.00);
	EntFire("Spawn_props", "Kill", "", 0.00);
	EntFire("City_Gate_Open", "Kill", "", 0.00);
	EntFire("Ship_break", "Kill", "", 0.00);
	EntFire("Hold1*", "Kill", "", 0);

	EntFire("Map_TD", "AddOutput", "origin -2680 -1296 1228", 0.00);
	EntFire("Map_TP_2", "Enable", "", 1.00);
}

function Trigger_Cave_First()
{
	local text;

	text = "The gates will open in 25 seconds"
	ServerChat(Chat_pref + text);

	text = "5 SECONDS LEFT"
	ServerChat(Chat_pref + text, 20);

	text = "FALL BACK"
	ServerChat(Chat_pref + text, 25);

	if(Stage == 1)
	{
		text = "It's amazing how much equipment you managed to fit into a single cave"
		ServerChat(Tifa_pref + text, 5);

		text = "Well, we only equipped the upper level. The lower levels are the forbidden territory."
		ServerChat(RedX_pref + text, 10);

		text = "Is there an evil ghost dwelling there?"
		ServerChat(Tifa_pref + text, 15);

		text = "I hope it's just part of the old man's imagination."
		ServerChat(RedX_pref + text, 20);
	}
	else if(Stage == 4)
	{
		text = "We can't beat him in his current form; His real body is located somehwere else."
		ServerChat(RedX_pref + text, 5);

		text = "We need to deal with his illusion before revealing his real body."
		ServerChat(RedX_pref + text, 10);

		text = "Why am I being told this now?"
		ServerChat(Tifa_pref + text, 15);

		text = "The last time we ran out of the cave, I heard him laugh at the Cape of Rebirth."
		ServerChat(RedX_pref + text, 20);

		text = "I thought it was only me that thought of that, but his main body has been there all this time."
		ServerChat(RedX_pref + text, 25);

		text = "What is this Cape of Rebirth that you speak of?"
		ServerChat(Tifa_pref + text, 30);

		text = "You will find out very soon"
		ServerChat(RedX_pref + text, 35);
	}

	EntFire("Map_TD", "AddOutput", "angles 0 180 0", 10);
	EntFire("Map_TD", "AddOutput", "origin -5774 -3668 1889", 10);

	EntFire("Hold5_Door", "Open", "", 25);
}

function Trigger_Cave_Second()
{
	local text;

	text = "The gates of gi cave will open in 15 seconds"
	ServerChat(Chat_pref + text);

	text = "5 SECONDS LEFT"
	ServerChat(Chat_pref + text, 10);

	text = "FALL BACK"
	ServerChat(Chat_pref + text, 15);   

	EntFire("Hold5_Door1", "Open", "", 15);

	EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-5111,-1827,1922),228,100)", 29.99);
	EntFire("cave_skip", "Break", "", 30);
	EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-4450,-1515,566),228,100)", 29.99);
	EntFire("Skip_Wall", "Toggle", "", 30);
	
	EntFire("Map_TD", "AddOutput", "origin -6414 -2240 2036", 0);
	EntFire("Map_TP_3", "Enable", "", 0.5);

	//EntFireByHandle(self, "RunScriptCode", "Bhop_Toggle(true, true);", 17, null, null);
}

function Bhop_Toggle(value = false, show = false) 
{
	if(!BHOP_ENABLE)
		return;

	SendToConsoleServerPS("sv_enablebunnyhopping " + ((value) ? "1" : "0"));
	if(show)
	{
		local text;

		text = "BHOP" + ((value) ? "\x04 Enable" : "\x02 Disable");
		ServerChat(Chat_pref + text);
	}	
}

function Trigger_Cave_Third()
{
	local text;

	text = "Wait until something happens"
	ServerChat(Chat_pref + text);

	EntFire("Hold6_Move", "Open", "", 15);

	if(Stage == 2 || Stage == 4 || Stage == 5)
	{
		EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-3157,753,553),228,100)", 22);
		EntFire("Hold6_Rock", "Disable", "", 22.01);
		EntFire("Hold6_Rock_wall", "Toggle", "", 22.01);
	}
	else
	{
		EntFire("Hold7_Rock", "Kill", "", 0);
	}
	if(Stage == 4)
	{
		EntFire("Temp_Extreme", "ForceSpawn", "", 15);
	}

	if(Stage == 4 || Stage == 5)
	{
		EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-1169,300,373),228,100)", 20);
		EntFire("lvl3_Wall", "Kill", "", 20.01);  
	}

	EntFire("Gi_Cave_TP", "Kill", "", 0);

	EntFire("Map_TD", "AddOutput", "angles 0 90 0", 25);
	EntFire("Map_TD", "AddOutput", "origin -3810 -144 356", 25);
	EntFire("Map_TP_4", "Enable", "", 26);
}

function Trigger_Cave_Last()
{
	local text;

	text = "The gi gate will open in 35 seconds"
	ServerChat(Chat_pref + text);

	text = "5 SECONDS LEFT"
	ServerChat(Chat_pref + text, 30);

	text = "FALL BACK"
	ServerChat(Chat_pref + text, 35);

	EntFire("Boss_Dicks_Move", "Open", "", 0);
	EntFire("Hold7_Break_Anim", "FireUser1", "", 30);
	
	EntFire("Hold5_Door1", "Close", "", 35);
	EntFire("Hold5_Door", "Close", "", 35);

	EntFire("Hold7_Break", "Break", "", 35);

	EntFire("Map_TD", "AddOutput", "angles 5 -84 0", 5);
	EntFire("Map_TD", "AddOutput", "origin -2934 696 575", 5);
}

function Trigger_Cave_Boss_Start()
{
	if(Stage == 1)
	{
		local text;
		text = "Is that a real ghost?"
		ServerChat(Tifa_pref + text, 20);

		text = "Well, we only equipped its top. Below is the forbidden territory."
		ServerChat(RedX_pref + text, 22);

		text = "Then it's time to warm up."
		ServerChat(Tifa_pref + text, 24);
	}
	else if(Stage == 2)
	{
		local text;
		text = "This time, you won't get away."
		ServerChat(RedX_pref + text, 20);
	}
	if(Stage == 1 || Stage == 2 || Stage == 4)
	{
		EntFire("Temp_Gi_Nattak", "ForceSpawn", "", 5);
		EntFire("Temp_Gi_Nattak", "RunScriptCode", "Init();", 5.01);
	}
	if(Stage == 5)
	{

	}
}

function Trigger_Cave_After_Boss()
{
	local text;

	text = "Now you can get out of Cave of Gi"
	ServerChat(Chat_pref + text, 6.5);

	EntFire("Map_Shake", "StartShake", "", 0);
	EntFire("Map_Shake_7_Sec", "StartShake", "", 12);

	EntFire("Boss_Cage", "Kill", "", 6.5);
	EntFire("Boss_ZM_Dicks_Move", "Open", "", 5);

	EntFire("Skip_Wall", "Toggle", "", 5);

	if(Stage == 2 || Stage == 4 || Stage == 5)
	{
		EntFire("Hold_End_Button", "UnLock", "", 0);//?

		EntFire("Hold6_Rock", "Enable", "", 0);
		EntFire("Hold6_Rock_wall", "Toggle", "", 0);

		EntFire("Hold_End_Ladder_Model", "Enable", "", 0);
		EntFire("Hold_End_Ladder_Wall", "Toggle", "", 0);
	}

	if(Stage == 1)
	{
		text = "We won. Right?"
		ServerChat(Tifa_pref + text, 5);

		text = "I think he vanished. But I'm not sure about how I feel about this."
		ServerChat(RedX_pref + text, 8);

		text = "Then let's hurry to the observatory"
		ServerChat(Tifa_pref + text, 11);

		EntFire("Normal_Crates_End", "Enable", "", 25);
		EntFire("Normal_End_Wall", "Toggle", "", 25);
		EntFire("s1_Ladder_Model", "Kill", "", 25);
		EntFire("s1_Ladder", "Kill", "", 25);

		EntFire("Nigger", "AddOutPut", "origin -4634 -2544 1970", 0);
		EntFire("Nigger", "AddOutPut", "angles -90 346 0", 0)
		EntFire("Nigger", "SetAnimation", "idle", 0);
		EntFire("Nigger", "SetDefaultAnimation", "idle", 0);
	}
	else if(Stage == 2)
	{
		text = "Damn, that wasn't an easy one"
		ServerChat(Tifa_pref + text, 5);

		text = "I am concerned with the fact that he looked different."
		ServerChat(RedX_pref + text, 8);

		text = "What do you mean?"
		ServerChat(Tifa_pref + text, 11);

		text = "Just some random thoughts. Excellent job fellas, how about a quick trip to the bar?"
		ServerChat(RedX_pref + text, 14);

		text = "I will pass on that offer."
		ServerChat(Tifa_pref + text, 17);
	}
	else if(Stage == 4)
	{
		text = "Great, now we need to get out of the cave and reach his main body."
		ServerChat(RedX_pref + text, 5);

		text = "What do you think about the final battle? You think we can manage it?"
		ServerChat(Tifa_pref + text, 8);

		text = "I doubt it. He is using all his power to create an illusion. I think we will need to beat him fast"
		ServerChat(RedX_pref + text, 11);
	}

	EntFire("Trigger_Kill_Boss_Huynya", "Enable", "", 0);
	EntFire("Trigger_Kill_ZM_Cage", "Enable", "", 0);
	EntFire("Normal_End_Trigger", "Enable", "", 0);
	
	EntFire("Hold6_Move", "Close", "", 0);
	
	EntFire("Boss_Dicks_Move", "Open", "", 0);
	
	EntFire("Map_TP_5", "Disable", "", 0);
	EntFire("Map_TP_4", "Disable", "", 0);

	EntFire("music", "RunScriptCode", "GetMusicAfterBoss();", 0.00);
}
function Trigger_After_Boss_Skip_First() 
{
	local time;
	switch (Stage)
	{
		case 1:
		time = 10;
		break;
		case 2:
		time = 7;
		break;
		case 4:
		time = 5;
		break;
		case 5:
		time = 2;
		break;
	}
	EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(643,5346,637),228,100)", time);
	EntFire("cage_skip", "Break", "", time + 0.01);
}

function Trigger_After_Boss_Skip_Second() 
{
	local time;
	local time1;
	switch (Stage)
	{
		case 1:
		time = 7;
		time1 = 0;
		break;
		case 2:
		time = 5;
		time1 = 4;
		break;
		case 4:
		time = 3;
		time1 = 8;
		break;
		case 5:
		time = 0;
		time1 = 12;
		break;
	}

	EntFire("Map_TD", "AddOutput", "angles 7 -145 0", 15);
	EntFire("Map_TD", "AddOutput", "origin -950 3297 469", 15);

	EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-3456,3737,453),228,100)", time);
	EntFire("Boss_Side_Model", "Kill", "", time + 0.01);
	EntFire("Boss_Side_Wall", "Kill", "", time + 0.01);


	if(Stage == 1)
	{
		EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-4450,-1515,566),228,100)", (30 - 0.01) + time1);
		EntFire("Skip_Wall", "Kill", "", 30 + time1);
	}
		

	EntFire("Hold6_Move", "Open", "", 25 + time1);

	EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-3120,958,525),228,100)", 35.5 + time1);
	EntFire("Hold6_Rock", "Disable", "", 35.51 + time1);
	EntFire("Hold6_Rock_wall", "Toggle", "", 35.51 + time1);
}



//Normal
{
	function Trigger_Normal_End_Pre()
	{
		local text;

		text = "The gates of observatory will open in 20 seconds"
		ServerChat(Chat_pref + text);

		text = "5 SECONDS LEFT"
		ServerChat(Chat_pref + text, 15);

		text = "FALL BACK"
		ServerChat(Chat_pref + text, 20);

		EntFire("Lab_Wall_door", "Open", "", 20);
		EntFire("Normal_end_door", "Open", "", 30);

		EntFire("Map_TD", "AddOutput", "angles 0 180 0", 0);
		EntFire("Map_TD", "AddOutput", "origin -3200 256 340", 0);
		EntFire("Map_TP_6", "Enable", "", 1);

		EntFire("Normal_End", "Enable", "", 0);
	}

	function Trigger_Normal_End()
	{
		local text;
		text = "This is your last hold point"
		ServerChat(Chat_pref + text);

		text = "Congrats! You made it.. But seems like Gi Nattak ran away somehow.. We will defeat him next time..."
		ServerChat(Chat_pref + text, 4);

		text = "It seems he appeared again... I thought your father took care of him before!"
		ServerChat(OldMan_pref + text, 7);

		text = "We were all wrong!"
		ServerChat(OldMan_pref + text, 10);

		text = "This time I will finish the job once and for all"
		ServerChat(RedX_pref + text, 13);

		EntFire("Normal_end_door", "Close", "", 15);
		EntFire("Normal_End", "RunScriptCode", "Start(21,7);", 0.01);
	}
	function Trigger_Normal_Win()
	{
		local text;

		text = "NORMAL mode was beaten. Unlocking HARD mode"
		ServerChat(Chat_pref + text);

		Winner_array = caller.GetScriptScope().GetWinner();
		SetStage(2);
	}

	function Trigger_Normal_Lose()
	{
		local text;

		text = "Nice try cringe"
		ServerChat(Chat_pref + text);
	}
}

function Show_Credits_Passed()
{
	local text;
	text = "mission passed"
	text = text.toupper();
	ShowCreditsText(text);
}

function Show_Credits_Failed()
{
	local text;
	text = "mission failed"
	text = text.toupper();
	ShowCreditsText(text);
}

function Trigger_Hold_End()
{
	local text;

	text = "Door opens in 10 seconds"
	ServerChat(Chat_pref + text);

	EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-4450,-1515,566),228,100)", 10 - 0.01);
	EntFire("Skip_Wall", "Kill", "", 10);

	EntFire("Final_Rope_Temp", "ForceSpawn", "", 10);

	EntFire("Hold5_Door1", "Open", "", 10);
	
	if(Stage == 2)
	{
		text = "The final door opens in 20 seconds"
		ServerChat(Chat_pref + text, 10);

		EntFire("Hard_End_Wall", "Toggle", "", 10);
		EntFire("Map_TP_3", "Disable", "", 10);

		EntFire("Hold5_Door", "Open", "", 30);
		EntFire("Hard_End", "Enable", "", 0);
		
		EntFire("Map_Shake_7_Sec", "StartShake", "", 0);
		EntFire("Map_Shake_7_Sec", "StartShake", "", 8);
		EntFire("Map_Shake_7_Sec", "StartShake", "", 15);
	}
	if(Stage == 4)
	{
		text = "The final door opens in 35 seconds"
		ServerChat(Chat_pref + text, 10);

		EntFire("Hold5_Door", "Open", "", 45);

		EntFire("New_ending_wall", "Kill", "", 47);
		EntFire("explosion", "RunScriptCode", "CreateExplosion(Vector(-521,-957,2053),228,100)", 46.99);

		EntFire("Temp_End", "ForceSpawn", "", 5);
		EntFire("End_Fire", "Start", "", 10);

		EntFire("Extreme_Reno_Model", "Enable", "", 45);
		EntFire("Extreme_Reno_Model", "FireUser2", "", 46);
		EntFire("Extreme_Reno_Model", "RunScriptCode", "PlaySound(Sound_First);", 49);

		EntFire("Map_Shake_7_Sec", "StartShake", "", 0);
		EntFire("Map_Shake_7_Sec", "StartShake", "", 16);
		EntFire("Map_Shake_7_Sec", "StartShake", "", 33);

		text = "Damn, that's ain't easy one."
		ServerChat(Tifa_pref + text, 45);

		text = "I am concerned with the fact that he looked different."
		ServerChat(RedX_pref + text, 47);
	}
	if(Stage == 5)
	{
		text = "The final door opens in 35 seconds"
		ServerChat(Chat_pref + text, 10);

		EntFire("Temp_End", "ForceSpawn", "", 5);
		EntFire("End_Fire", "Start", "", 10);

		EntFire("Hold5_Door", "Open", "", 45);
		EntFire("Map_Shake_7_Sec", "StartShake", "", 0);
		EntFire("Map_Shake_7_Sec", "StartShake", "", 20.5);
		EntFire("Map_Shake_7_Sec", "StartShake", "", 38);
	}

	EntFire("Hold6_Move", "Close", "", 10);
	
	EntFire("Map_TP_6", "Enable", "", 10);
	EntFire("Map_TD", "AddOutput", "origin -3200 256 340", 5);
	EntFire("Map_TD", "AddOutput", "angles 0 180 0", 5);
} 
//Hard
{
	function Trigger_Hard_End()
	{
		local text;

		text = "This is your last hold point"
		ServerChat(Chat_pref + text);

		EntFire("Hard_End", "RunScriptCode", "Start(40,7);", 0.01);

		EntFire("Map_TP_7", "Enable", "", 20);
		EntFire("Map_TD", "AddOutput", "origin -7045 -1011 1933", 19);
		EntFire("Map_TD", "AddOutput", "angles -5 -100 0", 19);

		text = "We are lucky ones."
		ServerChat(Tifa_pref + text, 24.5);

		text = "Quick, kill him before he gets to us"
		ServerChat(RedX_pref + text, 26);

		EntFire("temp_cactus", "forcespawn", "", 24);
		EntFire("temp_cactus", "runscriptcode", "Init()", 25);
	}
	function Trigger_Hard_Win()
	{
		local text;

		text = "HARD mode was beaten. Unlocking ZM mode"
		ServerChat(Chat_pref + text);

		Winner_array = caller.GetScriptScope().GetWinner();

		SetStage(3);
	}

	function Trigger_Hard_Lose()
	{
		local text;

		text = "Nice try cringe"
		ServerChat(Chat_pref + text);
	}
}
//ZM
{
	function Trigger_ZM_End()
	{
		local handle = null;
		local alive = false;
		while((handle = Entities.FindByClassname(handle, "player")) != null)
		{
			if(handle == null)
				continue;
			if(!handle.IsValid())
				continue;
			if(handle.GetHealth() <= 0)
				continue;
			if(handle.GetTeam() != 3)
			{
				handle.SetOrigin(Vector(-1827,-332,1106));
				continue;
			}
				
			alive = true;
			handle.SetOrigin(Vector(4680,-3563,899));
			handle.SetVelocity(Vector(0,0,0));
		}
		local text;
		if(!alive)
		{
			text = "Nice try cringe"
			ServerChat(Chat_pref + text);
			return;
		}
		EntFire("zm_camera_nattack", "fireuser1", "", 0.01);

		local text;
		text = "this can't be happening...";
		ServerChat(RedX_pref + text, 12.00);

		text = "i thought we had destroyed him";
		ServerChat(Tifa_pref + text, 15.00);

		text = "My instincts were right. All this time, we were fighting an illusion";
		ServerChat(RedX_pref + text, 17.00);

		text = "We need to report this to the headquarters that we found the target";
		ServerChat(ShinraSoldier_pref + text, 24.00);

		text = "They can't get away this time";
		ServerChat(ShinraSoldier_pref + text, 33.00);
	}

	function Trigger_ZM_End_Win()
	{
		local text;

		text = "ZM mode was beaten. Unlocking Extreme mode"
		ServerChat(Chat_pref + text);

		Winner_array.clear();
		local handle = null;
		while((handle = Entities.FindByClassname(handle, "player")) != null)
		{
			if(handle == null)
				continue;
			if(!handle.IsValid())
				continue;
			if(handle.GetHealth() <= 0)
				continue;
			if(handle.GetTeam() == 3)
				Winner_array.push(handle);
			else if(handle.GetTeam() == 2)
			{
				EntFireByHandle(handle, "SetDamageFilter", "", 0.9, null, null);
            	EntFireByHandle(handle, "SetHealth", "-1", 2.0, null, null);
			}
		}
		local g_round = Entities.FindByName(null, "round_end");
		EntFireByHandle(g_round, "EndRound_CounterTerroristsWin", "6", 1.8, null, null);
		
		Show_Credits_Passed();

		EntFire("music", "RunScriptCode", "SetMusic(Sound_Win);", 0.00);
		EntFire("Nuke_fade", "Fade", "", 0.00);
		EntFire("zamok_ct", "RunScriptCode", "Stop()", 0);

		SetStage(4);
	}
}
//EXTREME
{
	function Trigger_New_End()
	{
		if(Stage == 4)
		{
			EntFire("Map_TD", "AddOutput", "angles 0 180 0", 4);
			EntFire("Map_TD", "AddOutput", "origin -6352 -1104 1876", 4);
			EntFire("Map_TP_7", "Enable", "", 5);

			EntFire("End_Move*", "Open", "", 1.5);

			EntFire("Temp_Extreme", "RunScriptCode", "Init();", 0.01);

			EntFire("Map_Shake", "StartShake", "", 0);
			EntFire("Map_Shake", "StartShake", "", 3);

			EntFire("Map_Shake", "StartShake", "", 40);
			EntFire("End_Platform_Move", "FireUser1", "", 25);
				
			EntFire("End_End", "AddOutPut", "OnUser3 map_brush:RunScriptCode:Trigger_Extreme_Win();:0:1", 0);
			EntFire("End_End", "AddOutPut", "OnUser4 map_brush:RunScriptCode:Trigger_Extreme_Lose();:0:1", 0);
		}
	}

	function Trigger_Extreme_Win()
	{
		local text;

		text = "EXTREME mode was beaten. Thanks for test Cosmov6"
		ServerChat(Chat_pref + text);

		Winner_array = caller.GetScriptScope().GetWinner();

		SetStage(4);
	}

	function Trigger_Extreme_Lose()
	{
		local text;
		
		text = "Nice try cringe"
		ServerChat(Chat_pref + text);
	}
}

function Trigger_New_End_Last()
{
	if(Stage == 4)
	{
		EntFire("music", "RunScriptCode", "SetMusic(Music_Extreme_4);", 6.00);

		for(local i = 9, a = 0; i >= 4; i--, a += 0.2)
		{
			EntFire("music", "Volume", "" + i, 10.0 + a);
		}

		if(ScoreBass > 0 && ScoreBass % 10 == 0)
		{
			EntFire("Extreme_Reno_Model", "RunScriptCode", "self.SetModel(CHICKEN_MODEL);", 8);
			EntFire("Extreme_Reno_Model", "Skin", "4", 8.01);
			EntFire("Extreme_Reno_Model", "SetAnimation", "Run01", 8.01);
			EntFire("Extreme_Reno_Model", "AddOutPut", "ModelScale 3.5", 8);
			EntFire("Extreme_Reno_Model", "AddOutPut", "angles 0 180 0", 8.05 );

			EntFire("Extreme_Reno_Model", "SetAnimation", "Bunnyhop", 3.15 + 8);
			EntFire("Extreme_Reno_Model", "SetAnimation", "Flap_falling", 3.3 + 8);
			EntFire("Extreme_Reno_Model", "SetAnimation", "bounce", 5.9 + 8);
			EntFire("Extreme_Reno_Model", "SetAnimation", "Walk01", 7.4 + 8);
		}
		
		EntFire("Camera_old", "RunScriptCode", "SetOverLay(Overlay)", 8);
		EntFire("Camera_old", "RunScriptCode", "SpawnCameras(Vector(-8225,-982,1878),Vector(0,45,0),0,Vector(-8695,-982,1878),Vector(0,45,0),1,2.4)", 8);
		EntFire("Camera_old", "RunScriptCode", "SpawnCameras(Vector(-10413,-928,1833),Vector(0,0,0),3,Vector(-10413,-928,1897),Vector(0,0,0),0,1)", 3.4 + 8);
		EntFire("Camera_old", "RunScriptCode", "SpawnCameras(Vector(-10413,-928,1897),Vector(0,0,0),0,Vector(-10839,-928,1897),Vector(0,0,0),1,2.7)", 7.4 + 8);
		EntFire("Camera_old", "RunScriptCode", "SetOverLay()", 11.1 + 8);

		EntFire("End_Platform_Move", "FireUser1", "", 3);
		EntFire("Extreme_Reno_Model", "FireUser3", "", 8);

		EntFire("Map_TP_8", "Enable", "", 8);
	}
}

function Trigger_Add_HP_New_End()
{
	if(Stage == 4)
	{
		EntFire("Temp_Extreme", "RunScriptCode", "AddHPInit(55)", 0);
	}
}

function Trigger_After_Last_Nattak()
{
	if(Stage == 4)
	{
		local text;

		text = "Congrats! You made it... You kill Him..."
		ServerChat(Chat_pref + text);

		text = "Get on the rocks and hold";
		ServerChat(Chat_pref + text, 2);

		text = "This is your last hold point";
		ServerChat(Chat_pref + text, 4);

		EntFire("End_Clip", "Kill", "", 0);

		EntFire("Map_TD", "AddOutput", "angles 0 180 0", 4);
		EntFire("Map_TD", "AddOutput", "origin -8816 -928 2324", 4);
		EntFire("Map_TP_4", "Enable", "", 5);
	}
}

function ShowCreditsText(text, delay = 0.00)
{
	if(CreditsText == null || CreditsText != null && !CreditsText.IsValid())
	{
		CreditsText = Entities.FindByName(null, "Credits_Game_Text");
	}

	if(CreditsText == null || CreditsText != null && !CreditsText.IsValid())
		return;

	EntFireByHandle(CreditsText, "SetText", text, delay, null, null);
	EntFireByHandle(CreditsText, "Display", "", delay + 0.01, null, null);
}

function RotateSkin()
{
	local skin;
	local ang;
	skin = Entities.FindByName(null, "ct_skin");
	if(skin != null)
	{
		ang = skin.GetAngles();
		skin.SetAngles(ang.x, ang.y + 0.5, ang.z);
	}
	skin = Entities.FindByName(null, "t_skin");
	if(skin != null)
	{
		ang = skin.GetAngles();
		skin.SetAngles(ang.x, ang.y + 0.5, ang.z);
	}
	EntFireByHandle(self, "RunScriptCode", "RotateSkin()", 0.05, null, null);
}

function PlayerConnect()
{
	if(eventlist == null || eventlist != null && !eventlist.IsValid())
	{
		SendToConsoleServerPS("sv_disable_immunity_alpha 1");
		eventlist = Entities.FindByName(null, "event_player_connect");
	}
	local userid = eventlist.GetScriptScope().event_data.userid;
	local name = eventlist.GetScriptScope().event_data.name;
	local steamid = eventlist.GetScriptScope().event_data.networkid;
	local p_save = LoadSave(steamid);
	local p_new = Player(userid,name,steamid);

	if(DODJE_ENABLE)
	{
		if(PIDARAS_COUNT > 1 && PIDARAS_COUNT < 5)
		{
			if(IsPidaras(steamid))
			{
				EntFireByHandle(client_ent, "Command", "disconnect #SFUI_MainMenu_GameBan_Info", RandomFloat(0.0,1.0), p_new.handle, null);
			}
		}
	}
	
	if(p_save != null)
	{
		p_new.money = p_save.money;

		p_new.knife = p_save.knife;
		p_new.tskin = p_save.tskin;
		p_new.ctskin = p_save.ctskin;

		p_new.item_buff_radius = p_save.item_buff_radius;
		p_new.item_buff_last = p_save.item_buff_last;
		p_new.item_buff_recovery = p_save.item_buff_recovery;
		p_new.item_buff_turbo = p_save.item_buff_turbo;
		p_new.item_buff_doble = p_save.item_buff_doble;

		p_new.bio_lvl = p_save. bio_lvl;
		p_new.ice_lvl = p_save.ice_lvl;
		p_new.poison_lvl = p_save.poison_lvl;
		p_new.wind_lvl = p_save.wind_lvl;
		p_new.summon_lvl = p_save.summon_lvl;
		p_new.fire_lvl = p_save.fire_lvl;
		p_new.electro_lvl = p_save.electro_lvl;
		p_new.earth_lvl = p_save.earth_lvl;
		p_new.gravity_lvl = p_save.gravity_lvl;
		p_new.ultimate_lvl = p_save.ultimate_lvl;
		p_new.heal_lvl = p_save.heal_lvl;

		p_new.perkhp_zm_lvl = p_save.perkhp_zm_lvl;
		p_new.perkhp_hm_lvl = p_save.perkhp_hm_lvl;
		p_new.perkhuckster_lvl = p_save.perkhuckster_lvl;
		p_new.perksteal_lvl = p_save.perksteal_lvl;

		p_new.perkresist_hm_lvl = p_save.perkresist_hm_lvl;
		p_new.perkspeed_lvl = p_save.perkspeed_lvl;
		p_new.perkluck_lvl = p_save.perkluck_lvl;
		p_new.perkchameleon_lvl = p_save.perkchameleon_lvl;
		p_new.perkresist_zm_lvl = p_save.perkresist_zm_lvl;
	}

	PLAYERS.push(p_new);
}

function EventInfo()
{
	local userid = eventinfo.GetScriptScope().event_data.userid;
	if(PLAYERS.len() > 0)
	{
		for(local i=0; i < PLAYERS.len(); i++)
		{
			if(PLAYERS[i].userid == userid)
			{
				PLAYERS[i].handle = TEMP_HANDLE;
				return;
			}
		}
	}

	//test option
	//EntFire("client", "command", "Retry", RandomFloat(0.00, 5.00), TEMP_HANDLE)
	local p = Player(userid,"none","none");
	p.handle = TEMP_HANDLE;
	if(AUTO_RETRY_ENABLE && client_ent != null && client_ent.IsValid()){EntFireByHandle(client_ent, "Command", "retry", 0.00, TEMP_HANDLE, null);}
	PLAYERS.push(p);
}
//need fix
function LoadSave(steamid)
{
	for(local i = 0; i < PLAYERS_SAVE.len(); i++)
	{
		if(PLAYERS_SAVE[i].steamid == steamid)
		{
			local data = PLAYERS_SAVE[i];
			PLAYERS_SAVE.remove(i);
			return data;
		}
	}
	return null;
}

function IsPidaras(steamid) 
{
	/* lol no
	for(local a = 0; a < PIDARAS_STEAM_ID.len(); a++)
	{
		if(steamid == PIDARAS_STEAM_ID[a])
		{
			return true;
		}
	}*/
	return false;
}

function ShowPlayerText(handle, text)
{
	if(PlayerText == null || PlayerText != null && !PlayerText.IsValid())
	{
		PlayerText = Entities.FindByName(null, "playerText");
	}

	if(PlayerText == null || PlayerText != null && !PlayerText.IsValid())
		return;

	EntFireByHandle(PlayerText, "SetText", text, 0, handle, handle);
	EntFireByHandle(PlayerText, "Display", "", 0, handle, handle);
}

function ShowShopText(handle, text)
{
	if(DisableHudHint)
		return ShowPlayerText(handle, text);

	if(ShopHud == null || ShopHud != null && !ShopHud.IsValid())
	{
		ShopHud = Entities.FindByName(null, "hud_shop");
	}

	if(ShopHud == null || ShopHud != null && !ShopHud.IsValid())
		return;

	ShopHud.__KeyValueFromString("message",text);
	EntFireByHandle(ShopHud, "ShowHudHint", "", 0, handle, handle);
}

function Trigger_Invalid()
{
	local waffel_car = Entities.FindByName(null, "waffel_controller");
    local car_class = waffel_car.GetScriptScope().GetClassByInvalid(activator);
    if(car_class == null)
    {
		if(WAFFEL_CAR_ENABLE && Allow_Waffel)
		{
			if(CheckForCar(GetPlayerClassByHandle(activator)) != null)
				Fade_White(activator);
			else 
				Fade_Red(activator);
		}
		else Fade_Red(activator); 
    }
    else
    {
        waffel_car.GetScriptScope().DestroyCar(activator);
		Fade_Red(activator);
    }
}

function SetInvalid(handle)
{
	local invalid_maker = Entities.FindByName(null, ::TEMP_WAFFEL);
	if(invalid_maker == null)
		return;
	local handlepos = handle.GetOrigin();
	local makerpos = GetSpot();

	invalid_maker.SpawnEntityAtLocation(makerpos, Vector(0,0,0));

	handle.SetOrigin(makerpos + Vector(0, 0, -30))
	EntFireByHandle(self, "RunScriptCode", "activator.SetOrigin(Vector(" + (handlepos.x) + "," + (handlepos.y) + "," + (handlepos.z) + "));", 0.15, handle, handle);
}

///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

::item <- "item";
::lvl1 <- "lvl1";
::lvl2 <- "lvl2";
::lvl3 <- "lvl3";

::Mes_Warmup <- " \x02 *** \x10 Warmup \x02 ***";
::RED <- "\x02"
::GREEN <- "\x04"
::YELLOW <- "\x09"
::IDLE <- "IDLE";

::TEMP_BIO <- "item_temp_bio";
::TEMP_EARTH <- "item_temp_earth";
::TEMP_ICE <- "item_temp_ice";
::TEMP_FIRE <- "item_temp_fire";
::TEMP_SUMMON <- "item_temp_summon";
::TEMP_ELECTRO <- "item_temp_electro";
::TEMP_GRAVITY <- "item_temp_gravity";
::TEMP_HEAL <- "item_temp_heal";
::TEMP_WIND <- "item_temp_wind";
::TEMP_ULTIMATE <- "item_temp_ultimate";
::TEMP_POISON <- "item_temp_poison";
::TEMP_POTION <- "item_temp_potion";
::TEMP_AMMO <- "item_temp_ammo";
::TEMP_PHOENIX <- "item_temp_phoenix";
::TEMP_WAFFEL <- "waffel_controller_spawner";


ServerSettings <-[
"ammo_50AE_max 6000",
"ammo_762mm_max 6000",
"ammo_556mm_box_max 6000",
"ammo_556mm_max 6000",
"ammo_338mag_max 6000",
"ammo_9mm_max 6000",
"ammo_buckshot_max 6000",
"ammo_45acp_max 6000",
"ammo_357sig_max 6000",
"ammo_57mm_max 6000",

"mp_startmoney 16000",
"mp_roundtime 18",

"mp_freezetime 1",

//"sv_disable_radar 1",

"sv_gravity 800",

//"sv_enablebunnyhopping 1",
"sv_airaccelerate 18",

"zr_class_modify zombies health_infect_gain 500",
"zr_class_modify zombies health 7500",
"zr_class_modify zombies health_regen_interval 0.5",
"zr_class_modify zombies health_regen_amount 10",

"zr_infect_mzombie_respawn 1",

"zr_infect_spawntime_min 40",
"zr_infect_spawntime_max 40",
"ze_infect_time 40",

"zr_ztele_zombie 1",
"zr_ztele_max_zombie 5",
"zr_ztele_max_human 1",

"sm_rst_m249 0",
"sm_rst_negev 0",

"zr_zspawn 1",
"zr_zspawn_team_zombie 1",
"zr_zspawn_block_rejoin 0",
"zr_zspawn_timelimit 0",

"zr_respawn 1",
"zr_respawn_team_zombie 1",
"zr_respawn_team_zombie_world 1",
"zr_respawn_delay 2"];

function SetSettingServer()
{
	for (local i=0; i<ServerSettings.len()-1; i++)
	{
		SendToConsoleServerPS(ServerSettings[i]);
	}
}

function SendToConsoleServerPS(sCommand)
{
	EntFire("cmd", "Command", sCommand, 0);
    //EntFire("cmd", "Command", "sm_cvar " + sCommand, 0);
}

//teleportitem
// function SavePos()
// {
// 	if(PLAYERS.len() > 0)
// 	{
// 		foreach(p in PLAYERS)
// 		{
// 			if(p.handle != null)
// 			{
// 				if(p.handle.IsValid() && p.handle.GetHealth() > 0)
// 				{
// 					if(p.pet != null)
// 					{
// 						local pet_index = GetPetIndexByHandle(p.pet);
// 						local velocity = p.handle.GetVelocity();
// 						if(velocity.x == 0 && velocity.y == 0 && velocity.z == 0)
// 						{
// 							if(p.petstatus != "IDLE" && p.petstatus != "JUMP")
// 							{
// 								p.petstatus = "IDLE";
// 								EntFireByHandle(p.pet, "SetDefaultAnimation", Pet_Preset[pet_index].anim_idle, 0, null, null);
// 								EntFireByHandle(p.pet, "SetAnimation", Pet_Preset[pet_index].anim_toidle, 0, null, null);
// 							}
// 						}
// 						else
// 						{
// 							if(p.petstatus != "RUN" && p.petstatus != "JUMP")
// 							{
// 								p.petstatus = "RUN";
// 								EntFireByHandle(p.pet, "SetDefaultAnimation", Pet_Preset[pet_index].anim_run, 0, null, null);
// 								EntFireByHandle(p.pet, "SetAnimation", Pet_Preset[pet_index].anim_run, 0, null, null);
// 							}
// 						}
// 					}
// 				}
// 			}
// 		}
// 	}
// 	EntFireByHandle(self, "RunScriptCode", "SavePos();", 0.1, null, null);
// }
// function Teleport()
// {
//     local pl = GetPlayerClassByHandle(activator);
//     if(pl == null)return;
//     if(pl.teleporting)return;

//     // local model_name = activator.GetModelName();
//     // local model = Entities.CreateByClassname("prop_dynamic_glow");
//     // model.SetModel(model_name);
//     // model.SetOrigin(activator.GetOrigin());
//     // model.SetAngles(activator.GetAngles().x,activator.GetAngles().y,activator.GetAngles().z);
//     // model.__KeyValueFromString("glowenabled","1");
//     // model.__KeyValueFromString("glowstyle","1");
//     // model.__KeyValueFromString("glowdist","1024");
//     // model.__KeyValueFromString("glowcolor","244 0 0");

//     pl.teleporting = true;
//     local array = pl.lastpos.slice(0,pl.lastpos.len());
//     local array1 = pl.lastang.slice(0,pl.lastang.len());
//     pl.lastpos.clear();
//     pl.lastang.clear();
//     Revers(array);
//     Revers(array1);
//     local i = 0;
//     local iter = 0.02;

//     for (i; i < array.len() - 1; i++)
//     {
//         local time = i * iter;
//         EntFireByHandle(self, "RunScriptCode", "test1();", time + 0.1, activator, activator);
//         EntFireByHandle(activator, "RunScriptCode", "self.SetOrigin(Vector("+array[i].x+","+array[i].y+","+array[i].z+"));", time, null, null);
//         EntFireByHandle(activator, "RunScriptCode", "self.SetAngles("+array1[i].x+","+array1[i].y+","+array1[i].z+");", time, null, null);
//     }
//     i++;
//     EntFireByHandle(self, "RunScriptCode", "GetPlayerClassByHandle(activator).teleporting = false;", i * iter, activator, activator);
// }
// function Revers(array)
// {
//     local start = 0;
//     local end = array.len() -1;
//     while (start < end)
//     {
//         local temp = array[start];
//         array[start] = array[end];
//         array[end] = temp;
//         start++;
//         end--;
//     }
//     return array;
// }
// function test1()
// {
//     local model_name = activator.GetModelName();
//     local model = Entities.CreateByClassname("prop_dynamic_glow");
//     model.SetModel(model_name);
//     model.SetOrigin(activator.GetOrigin());
//     model.SetAngles(activator.GetAngles().x,activator.GetAngles().y,activator.GetAngles().z);
//     model.__KeyValueFromString("glowenabled","1");
//     model.__KeyValueFromString("glowstyle","1");
//     model.__KeyValueFromString("rendermode","2");
//     model.__KeyValueFromString("renderamt","225");
//     EntFireByHandle(model, "Alpha", "120", 0, null, null);
//     // model.__KeyValueFromString("renderamt","150");
//     model.__KeyValueFromString("glowdist","1024");
//     model.__KeyValueFromString("glowcolor","255 0 0");

//     EntFireByHandle(model, "RunScriptCode", "self.Destroy();", 0.1, null, null);
// }

// function SpawnExplosion(origin,radius,damage,team = -1)
// {
//     local sound = Entities.CreateByClassname("ambient_generic");
//     sound.__KeyValueFromInt("radius",radius * 1.5);
//     sound.__KeyValueFromString("message","weapons/flashbang/flashbang_explode1.wav");
//     sound.SetOrigin(origin);

//     local shake = Entities.CreateByClassname("env_shake");
//     shake.__KeyValueFromInt("radius",radius);
//     shake.__KeyValueFromString("duration","2");
//     shake.__KeyValueFromString("frequency","0.25");
//     shake.__KeyValueFromString("spawnflags","28");
//     shake.__KeyValueFromString("amplitude","25");
//     shake.SetOrigin(origin);

//     local sprite = Entities.CreateByClassname("env_sprite");
//     sprite.__KeyValueFromString("rendermode","5");
//     sprite.__KeyValueFromString("sprites/zerogxplode.vmt","5");
//     sprite.SetOrigin(origin);

//     EntFireByHandle(shake, "StartShake", "", 0, null, null);
//     EntFireByHandle(sound, "PlaySound", "", 0, null, null);
//     EntFireByHandle(sprite, "ShowSprite", "", 0, null, null);
//     local h = null;
//     while(null != (h = Entities.FindByClassnameWithin(h, "player", origin, radius)))
//     {
//         if(h != null && h.IsValid() && h.GetHealth() > 0)
//         {
//             local hp = h.GetHealth();
//             hp = hp - damage;
//             if(hp <= 0)
//             {
//                 EntFireByHandle(h, "SetHealth");, 0, null, null);
//             }
//             else h.SetHealth(hp);
//         }
//     }
	//EntFireByHandle(shake, "Kill", "", 1, null, null);
	//EntFireByHandle(sound, "Kill", "", 1, null, null);
	//EntFireByHandle(sprite, "Kill", "", 1, null, null);
// }

// function test(i)
// {
//     local pet = CreateProp("prop_dynamic", activator.GetOrigin()"models/microrost/cosmov6/ff7r/chokobo.mdl", i);
// }

// function SetInvalid()
// {
//     local pl = GetPlayerClassByHandle(activator);
//     if(pl != null)
//     {
//         pl.invalid = true;
//     }
// }
ITEM_OWNER <- [];

class ItemOwner
{
	owner = null;
	name_right = null;
	name = null;
	button = null;
	weapon = null;
	glow_weapon = null;

	canUse = true;
	canSilence = true;
	allowRegen = true;

	type = 2;
	
	count = 1;
	maxcount = 1;

	//1 нажал кд
	//2 пару юзов
	//3 несколько юзов кд
	
	cd = 0;

	lvl = 0;

	constructor(_name)
	{
		this.button = _name;
		this.name = _name.GetName().slice(_name.GetPreTemplateName().len(),_name.GetName().len());
		local item_name = this.button.GetName()

		local item_name_array = split(item_name,"_");
		local n_item_name = item_name_array[item_name_array.len() - 1];
		local new_item_name = split(n_item_name,"&");
		this.name_right = new_item_name[0];
		this.weapon = Entities.FindByName(null, "item_gun_" + this.name_right + "" + this.name);
		//EntFireByHandle(this.weapon, "ToggleCanBePickedUp", "", 0.01, null, null);
		EntFire("item_effect_" + this.name_right + "" + this.name, "Start", "", 0.01, null);

		if(this.name_right == "phoenix" || 
		this.name_right == "ammo" ||
		this.name_right == "potion")
		{
			this.allowRegen = false;
			this.canSilence = false;
		}
		else if(ITEM_GLOW)
		{
			this.glow_weapon = Entities.CreateByClassname("prop_dynamic_glow");
			this.glow_weapon.__KeyValueFromInt("solid", 0);
			this.glow_weapon.__KeyValueFromInt("glowenabled", 1);
			this.glow_weapon.__KeyValueFromInt("glowdist", 1024);
			this.glow_weapon.__KeyValueFromInt("glowstyle", 0);
        	this.glow_weapon.__KeyValueFromInt("rendermode", 6);

			this.glow_weapon.SetModel(this.weapon.GetModelName());
			this.glow_weapon.SetOrigin(this.weapon.GetOrigin());
			this.glow_weapon.SetAngles(this.weapon.GetAngles().x, this.weapon.GetAngles().y, this.weapon.GetAngles().z);
		}

		if(this.name_right == "mike")
		{
			this.name_right = "Red XIII";
			this.allowRegen = false;
			this.type = 1;
		}
	}

	function NewOwner(_owner)
	{
		this.owner = _owner.handle;
		local item_name = this.button.GetName()
		
		if(this.glow_weapon != null)
		{
			this.glow_weapon.Destroy();
			this.glow_weapon = null;
		}
			
		if(this.name_right == "bio")
		{
			this.type = (_owner.item_buff_doble) ? 3 : 1;
			this.count = (_owner.item_buff_doble) ? 2 : 1;
			this.maxcount = this.count;
			this.lvl = _owner.bio_lvl;
		}
		else if(this.name_right == "ice")
		{
			this.type = (_owner.item_buff_doble) ? 3 : 1;
			this.count = (_owner.item_buff_doble) ? 2 : 1;
			this.maxcount = this.count;
			this.lvl = _owner.ice_lvl;
		}
		else if(this.name_right == "poison")
		{
			this.type = 3;
			this.lvl = _owner.poison_lvl;
			if(this.lvl == 0)
			{
				this.lvl++;
			}
			this.count = this.lvl + ((_owner.item_buff_doble) ? 2 : 0);
			this.maxcount = this.count;
		}
		else if(this.name_right == "wind")
		{
			this.type = (_owner.item_buff_doble) ? 3 : 1;
			this.count = (_owner.item_buff_doble) ? 2 : 1;
			this.maxcount = this.count;
			this.lvl = _owner.wind_lvl;
		}
		else if(this.name_right == "summon")
		{
			this.type = (_owner.item_buff_doble) ? 3 : 1;
			this.count = (_owner.item_buff_doble) ? 2 : 1;
			this.maxcount = this.count;
			this.lvl = _owner.summon_lvl;
		}
		else if(this.name_right == "fire")
		{
			this.type = (_owner.item_buff_doble) ? 3 : 1;
			this.count = (_owner.item_buff_doble) ? 2 : 1;
			this.maxcount = this.count;
			this.lvl = _owner.fire_lvl;
		}
		else if(this.name_right == "electro")
		{
			this.type = 3;
			this.lvl = _owner.electro_lvl;
			if(this.lvl == 0)
			{
				this.lvl++;
			}
			this.count = this.lvl + ((_owner.item_buff_doble) ? 2 : 0);
			this.maxcount = this.count;
		}
		else if(this.name_right == "earth")
		{
			this.type = (_owner.item_buff_doble) ? 3 : 1;
			this.count = (_owner.item_buff_doble) ? 2 : 1;
			this.maxcount = this.count;
			this.lvl = _owner.earth_lvl;
		}
		else if(this.name_right == "gravity")
		{
			this.type = (_owner.item_buff_doble) ? 3 : 1;
			this.count = (_owner.item_buff_doble) ? 2 : 1;
			this.maxcount = this.count;
			this.lvl = _owner.gravity_lvl;
		}
		else if(this.name_right == "ultimate")
		{
			this.type = 2;
			this.count = (_owner.item_buff_doble) ? 2 : 1;
			this.maxcount = this.count;
			this.lvl = _owner.ultimate_lvl;
		}
		else if(this.name_right == "heal")
		{
			this.type = (_owner.item_buff_doble) ? 3 : 1;
			this.count = (_owner.item_buff_doble) ? 2 : 1;
			this.maxcount = this.count;
			this.lvl = _owner.heal_lvl;
		}
		
		if(this.lvl == 0)
		{
			this.lvl++;
		}
	}

	function Use()
	{
		if(this.type == 1)
		{
			if(this.count > 0)
			{
				this.canUse = false;
				this.count--;
				return 1;
			}
			return -1;
		}
		else if(this.type == 2)
		{
			if(this.count > 0)
			{
				this.count--;
				if(this.count <= 0)
				{
					this.count = 0;
					this.canUse = false;
				}
				return 2;
			}
			return -1;
		}
		else if(this.type == 3)
		{
			if(this.count > 0)
			{
				this.count--;
				if(this.count <= 0)
				{
					this.count = 0;
					this.canUse = false;
				}
				return 3;
			}
			return -1;
		}
	}

	function RemoveOwner()
	{
		if(this.owner != null)
		{
			for(local i = 0; i <= 3; i++)
			{
				EntFire("item_star"+ i + "_" + this.name_right + "" + this.name, "Alpha", "255", 0, null);
				EntFire("item_star"+ i + "_" + this.name_right + "" + this.name, "SetGlowDisabled", "", 0, null);
				EntFire("item_star"+ i + "_" + this.name_right + "" + this.name, "Disable", "", 0, null);
			}

			if(this.maxcount != 1)
			{
				if(this.count < this.maxcount)
				{
					EntFireByHandle(this.button, "RunScriptCode", "loc = false;", 0, null, null);
					EntFireByHandle(this.button, "RunScriptCode", "loc = true;", 80, null, null);
				}
			}

			EntFireByHandle(this.weapon, "ToggleCanBePickedUp", "", 0, null, null);
			EntFireByHandle(this.weapon, "ToggleCanBePickedUp", "", 0.5, null, null);

			this.owner = null;
			if(this.lvl != null)
				this.lvl = 0;
			return true;
		}
		return false;
	}
}

function StartCD(cooldown = 0)
{
	local item = GetItemByButton(caller);
	if(item == null)
		return;

	if(item.type == 2) 
	{
	  if(item.count == 0)
	  {
		item.cd = "E";
		item.canUse = false;
		return;
	  }
	}
	if(cooldown != 0)
	{
		item.cd = cooldown;
		item.canUse = false;
	}
	else
	{
		item.cd -= 1;
	}
	if(item.cd > 0)
	{
		EntFireByHandle(self, "RunScriptCode", "StartCD();", 1, caller, caller);
	}
	else
	{
	  if(item.type == 1)
		 item.count++;
		item.canUse = true;
	}
}

function StartCounter(counter)
{
	local item = GetItemByButton(caller);
	if(activator != item.owner)
		return;
	if(item.type != 3) 
		return;
	if(counter > 0)
	{
		EntFireByHandle(self, "RunScriptCode", "StartCounter(" + --counter + ");", 1, activator, caller);
	}
	else
	{
		if(item.type == 3)
			item.count++;
	}
}

function GetItemByOwner(activator)
{
	foreach(p in ITEM_OWNER)
	{
		if(p.owner == activator)
		{
			return p;
		}
	}
	return null;
}

function GetItemByButton(activator)
{
	foreach(p in ITEM_OWNER)
	{
		if(p.button == activator)
		{
			return p;
		}
	}
	return null;
}

function GetItemByName(name)
{
	foreach(p in ITEM_OWNER)
	{
		if(p.name == name)
		{
			return p;
		}
	}
	return null;
}

class Item
{
	name = "";
	effect = "";

	radius1 = 0;
	radius2 = 0;
	radius3 = 0;

	duration1 = 0;
	duration2 = 0;
	duration3 = 0;

	cd1 = 0;
	cd2 = 0;
	cd3 = 0;

	damage1 = 0;
	damage2 = 0;
	damage3 = 0;

	time1 = 0;
	time2 = 0;
	time3 = 0;
	constructor(_name,_effect,_radius,_duration,_cd,_damage,_time)
	{
		name = _name;

		effect = _effect;

		local array = split(_radius," ");
		if(array.len() > 0)
		radius1 = array[0].tofloat();
		if(array.len() > 1)
		radius2 = array[1].tofloat();
		if(array.len() > 2)
		radius3 = array[2].tofloat();

		array = split(_duration," ");
		if(array.len() > 0)
		duration1 = array[0].tofloat();
		if(array.len() > 1)
		duration2 = array[1].tofloat();
		if(array.len() > 2)
		duration3 = array[2].tofloat();

		array = split(_cd," ");
		if(array.len() > 0)
		cd1 = array[0].tofloat();
		if(array.len() > 1)
		cd2 = array[1].tofloat();
		if(array.len() > 2)
		cd3 = array[2].tofloat();

		array = split(_damage," ");
		if(array.len() > 0)
		damage1 = array[0].tofloat();
		if(array.len() > 1)
		damage2 = array[1].tofloat();
		if(array.len() > 2)
		damage3 = array[2].tofloat();

		array = split(_time," ");
		if(array.len() > 0)
		time1 = array[0].tofloat();
		if(array.len() > 1)
		time2 = array[1].tofloat();
		if(array.len() > 2)
		time3 = array[2].tofloat();
	}
	function GetRadius(i)
	{
		if(i <= 1)return this.radius1;
		if(i == 2)return this.radius2;
		if(i >= 3)return this.radius3;
	}
	function GetDuration(i)
	{
		if(i <= 1)return this.duration1;
		if(i == 2)return this.duration2;
		if(i >= 3)return this.duration3;
	}
	function GetCD(i)
	{
		if(i <= 1)return this.cd1;
		if(i == 2)return this.cd2;
		if(i >= 3)return this.cd3;
	}
	function GetDamage(i)
	{
		if(i <= 1)return this.damage1;
		if(i == 2)return this.damage2;
		if(i >= 3)return this.damage3;
	}
	function GetTime(i)
	{
		if(i <= 1)return this.time1;
		if(i == 2)return this.time2;
		if(i >= 3)return this.time3;
	}
}

Item_Preset <- [];
obj <- null;
//           name  effect           radius        duration       cd                 damage              time
obj = Item("bio", "Slows down and boosts ZMs up", "196 320 440", "5 6 7", "80 75 70", "100 200 300", "0.3 0.35 0.4");
Item_Preset.push(obj) //bio
obj = Item("ice", "Freezes ZMs", "360 512 600", "5 6 7", "80 75 70","0.85 1.0 1.15","0.5 1 1.5");
Item_Preset.push(obj) //Ice
obj = Item("poison","Creates an energy that bounces from the walls\nExplodes and creates a smoke when hits ZMs","360 430 512","5 6 7","0 0 0" ,"500 750 1000","0.5 0.5 0.5");
Item_Preset.push(obj) //poison
obj = Item("wind","Creates tornado that pushes ZMs","360 512 600","5 6 7","80 75 70","512 768 1024" ,"0.5 0.5 0.5");
Item_Preset.push(obj) //wind
obj = Item("summon","Spawns a chocobo guardian","360 430 512","20 25 30" ,"80 75 70","512 768 1024" ,"4 5 6");
Item_Preset.push(obj) //summon
obj = Item("fire","Creates a fire zone that burns ZMs","360 512 600","7 8 9","75 70 65","500 600 700","0.15 0.2 0.25");
Item_Preset.push(obj) //fire
obj = Item("electro","Creates an electric zone that slows down and damages ZMs" ,"360 430 512","5 6 7","80 75 70","300 400 500","0.15 0.2 0.25");
Item_Preset.push(obj) //electro
obj = Item("earth","Creates a breakable rock wall" ,"360 512 600","6 7 8","80 75 70","500 1000 2000","0.5 0.5 0.5");
Item_Preset.push(obj) //earth
obj = Item("gravity","Creates a dark materia that pulls ZMs inside","360 430 512","5 6 7","80 75 70","512 768 1024" ,"0.5 0.5 0.5");
Item_Preset.push(obj) //gravity
obj = Item("ultimate","Gains an energy which explodes and deals a lot of damage to ZMs",	"740 920 1024","15 15 15","80 90 100" ,"80 85 95","500 1000 1500");
Item_Preset.push(obj) //ultimate
obj = Item("heal","Restores the current HP to the max and gives some buffs","360 512 600","5 6 7","80 75 70" ,"1 2 3","0.5 0.5 0.5");
Item_Preset.push(obj) //heal
obj = Item("potion","Heals wounds at half of max HP","360 512 600","5 6 7","80 75 70" ,"1 2 3","0.5 0.5 0.5");
Item_Preset.push(obj) //potion
obj = Item("ammo","Gives some amount of ammo","360 512 600","6 7 8","80 75 70" ,"1 2 3","0.5 0.5 0.5");
Item_Preset.push(obj) //ammo
obj = Item("phoenix","Gives all types of Resist to debuffs","360 512 600","6 7 8","80 75 70" ,"1 2 3","0.5 0.5 0.5");
Item_Preset.push(obj) //phoenix

///////////////
//STATS BLOCK//
///////////////
::RoundPlayed <- 0;
::Stats <- [];

::ScoreBass <- 0;

///////////////
//////Skin/////
///////////////
::CT_MODEL <- "models/player/custom_player/legacy/ctm_sas_variantf.mdl";
::CT_VIP_MODEL <- "models/player/custom_player/legacy/gxp/ffvii_remake/tifa/tifa_v1.mdl";
::T_VIP_MODEL <- "models/player/custom_player/microrost/sephiroth/sephiroth.mdl";
::CHICKEN_MODEL <- "models/chicken/chicken.mdl";

self.PrecacheModel(CHICKEN_MODEL);
self.PrecacheModel(CT_MODEL);
self.PrecacheModel(CT_VIP_MODEL);
self.PrecacheModel(T_VIP_MODEL);

function Precache()
{
	PreCacheModels();
}

function PreCacheModels()
{
	local structure = null;
	structure = Pet("0 50 0","models/kmodels/petux1.mdl","","","","","100-255","100-255","100-255","0 0 0","0.6");
	Pet_Preset.push(structure);
	structure = Pet("0 -50 0","models/microrost/cosmov6/ff7r/chokobo.mdl","run","idle2","idle","stoprun","0-150","0-150","0-150","-90 270 0","0.5");
	Pet_Preset.push(structure);

	if(Pet_Preset.len() > 0)
	{
		for (local i=0; i<Pet_Preset.len(); i++)
		{
			self.PrecacheModel(Pet_Preset[i].model_path);
		}
	}
}