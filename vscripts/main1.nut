IncludeScript("kotya/project_ubermensch/vec_lib.nut", this);
IncludeScript("kotya/project_ubermensch/morefunctions_lib.nut", this);
IncludeScript("kotya/project_ubermensch/draw_lib.nut", this);
IncludeScript("kotya/project_ubermensch/translate.nut", this);

::CONST <- getconsttable();

::Main_Script <- self.GetScriptScope();
::Entity_Maker <- null;

MAP_INIT <- true;
::iRestartRounds <- 0;
::bRoundEnd <- false;
::iChapter <- -2;

::iChapter01_Save_Portals <- [];

::Chapter_Init <- false;
::Chapter_Init_Time <- 5.0;

function RoundStart()
{
	if (MAP_INIT)
	{
		MAP_INIT = false;
		Init();
	}
	Chapter_Init = true;
	bFade = false;
	bRoundEnd = false;
	// printl("INIT MAIN")
	iRestartRounds++;

	CHAT_BUFFER.clear();
	PRESELECTS.clear();
	SPORE_INDIVIDUAL_PLAYERS.clear();
	CH03_QUEST2_TICKING = false;

	ResetAllCamers();
	ResetAllCameraSlot();
	ResetAllFreeTargetName();
	ResetGlobalTicks();
	ResetCutScene();
	Spore_Stop();

	Event_Start();
	Settings();

	EF("instanceauto1-skybox_env", "Stop");
	EF("instanceauto1-skybox_env", "Start");

	EF("map_trigger_start", "Enable", "", 1.0);
	EF("map_entity_weapon_restrict", "Enable", "", 1.0);

	EF("map_entity_text_puzzle00", "SetText", Translate["puzzle00"]);
	EF("map_entity_text_puzzle01", "SetText", Translate["puzzle01"]);
	EF("map_entity_text_puzzle02", "SetText", Translate["puzzle02"]);

	if (iChapter == -2)
	{
		local warmup = 5;
		// local warmup = 60;
		for (local i = 0; i < warmup; i++)
		{
			PrintChatMessageAll(Translate["warmup"] + " : " + (warmup - i), i);
		}
		CallFunction("WarmUpEnd()", warmup);
	}
	else
	{
		GlobalTick();
	}

	Entity_Maker = Entities.FindByName(null, "map_entity_maker");

	Portal_Scope.Init();

	CallFunction("Spawn_Chapter()", Chapter_Init_Time);
}

function WarmUpEnd()
{
	iChapter = 2;
	EF("game_round_end", "EndRound_Draw", "1.0");
}

function Settings()
{
	if (iChapter == -2 ||
	iChapter == 0)
	{
		CallFunction("TeleportZombie()", 237.05);
		SetSettings(0);
	}
	else if (iChapter == 1)
	{
		SetSettings(1);
	}
	else if (iChapter == 2)
	{
		SetSettings(3);
	}
	else if (iChapter == 3)
	{
		SetSettings(4);
	}
	else
	{
		LIMIT_CLASS_SCOUT = 999
		LIMIT_CLASS_ENGINEER = 999
		LIMIT_CLASS_VULTURE = 999;
		LIMIT_CLASS_TANK = 999;
	}
}

function TeleportZombie()
{
	local picker_class;
	foreach (player in PLAYERS)
	{
		if (!TargetValid(player))
		{
			continue;
		}
		if (player.GetTeam() != 2 ||
		player.GetHealth() < 1)
		{
			continue;
		}

		picker_class = GetPortalPickerClassByOwner(player);
		if (picker_class != null)
		{
			continue;
		}
		player.SetOrigin(g_vecZTELE);
	}
}

function RoundEnd()
{
	bFade = false;
	bRoundEnd = true;

	if (CUT_SCENE)
	{
		EF(CUT_SCENE_CAM, "Disable");
	}

	OVERLAY_TIME = 0;

	CUT_SCENE_DATA.clear();
	CUT_SCENE_TIME = 0;
	CUT_SCENE = false;
	CUT_SCENE_ID = -1;

	Settings();
}

//TICKS
{
	const TICKRATE = 0.05;
	::g_ahGlobal_Tick <- [];

	::g_fRealTickRate <- TICKRATE;

	::ResetGlobalTicks <- function()
	{
		g_ahGlobal_Tick.clear();
	}

	::GlobalTick <- function()
	{
		// g_fRealTickRate = FrameTime();
		// if (g_fRealTickRate < TICKRATE)
		// {
		// 	g_fRealTickRate = TICKRATE;
		// }
		g_fRealTickRate = TICKRATE;
		CallFunction("GlobalTick()", g_fRealTickRate);

		Tick_OverLay();
		Tick_Global();
		Tick_Class();

		Tick_Color();
		Tick_Spore();
	}

	::Tick_Global <- function()
	{
		foreach (index, ticker in g_ahGlobal_Tick)
		{
			if (!TargetValid(ticker))
			{
				g_ahGlobal_Tick.remove(index);
				continue;
			}
			ticker.GetScriptScope().Tick();
		}
	}

	::Tick_Color <- function()
	{
		if (OVERLAY_TICKING)
		{
			return;
		}

		foreach (player in PLAYERS)
		{
			if (!TargetValid(player))
			{
				continue;
			}

			EntFire("point_clientcommand", "Command", "r_screenoverlay Noise", 0, player);
		}
	}

	function HelicopterRotor()
	{
		if (!TargetValid(caller))
		{
			return;
		}

		local CA = caller.GetAngles();
		CA.x-=RandomInt(0,2);
		CA.y-=4;
		CA.z-=RandomInt(0,2);
		caller.SetAngles(CA.x,CA.y,CA.z);

		EntFireByHandle(self, "Runscriptcode", "HelicopterRotor()", 0.05, caller, caller);
	}
}

//SELECT
{
	enum Enum_PickerType
	{
		ClassPicker,
		PortalPicker,
		PortalPickerClass,
	}

	::Enum_PickerType <- CONST.Enum_PickerType;

	::PRESELECTS <- [];

	::RegSelect <- function()
	{
		local trigger = caller;
		local name = trigger.GetName().slice(trigger.GetPreTemplateName().len(),trigger.GetName().len());
		if (name == "")
		{
			// ScriptPrintMessageChatAll("RegSelect name ERROR");
			return;
		}
		trigger.Destroy();

		local pickerID = GetPreSelectByOwner(activator);
		if (pickerID == -1)
		{
			// ScriptPrintMessageChatAll("RegSelect pickerID ERROR");
			return;
		}

		local PickerType = PRESELECTS[pickerID][1];

		if (PickerType == Enum_PickerType.ClassPicker)
		{
			CLASS_PICKERS.push(class_picker(activator, name));
		}
		else if (PickerType == Enum_PickerType.PortalPicker)
		{
			PORTAL_PICKERS.push(class_portalpicker(activator, name, false, PRESELECTS[pickerID][2]));
		}
		else if (PickerType == Enum_PickerType.PortalPickerClass)
		{
			PORTAL_PICKERS.push(class_portalpicker(activator, name, true));
		}

		PRESELECTS.remove(pickerID);
	}

	::Hook_Select_On <- function()
	{
		local controller_class = GetPickerClassByOwner(activator);
		if (controller_class == null)
		{
			controller_class = GetPortalPickerClassByOwner(activator);
			if (controller_class == null)
			{
				return;
			}
		}
		controller_class.SetControllerStatus(true);
	}

	::Hook_Select_Off <- function()
	{
		local controller_class = GetPickerClassByOwner(activator);
		if (controller_class == null)
		{
			controller_class = GetPortalPickerClassByOwner(activator);
			if (controller_class == null)
			{
				return;
			}
		}
		controller_class.SetControllerStatus(false);
	}

	::Hook_Select_Pressed_A1 <- function()
	{
		local controller_class = GetPickerClassByOwner(activator);
		if (controller_class == null)
		{
			controller_class = GetPortalPickerClassByOwner(activator);
			if (controller_class == null)
			{
				return;
			}
		}
		controller_class.Press_A1();
	}

	::Hook_Select_Pressed_A <- function()
	{
		local controller_class = GetPickerClassByOwner(activator);
		if (controller_class == null)
		{
			controller_class = GetPortalPickerClassByOwner(activator);
			if (controller_class == null)
			{
				return;
			}
		}
		controller_class.Press_A();
	}

	::Hook_Select_Pressed_D <- function()
	{
		local controller_class = GetPickerClassByOwner(activator);
		if (controller_class == null)
		{
			controller_class = GetPortalPickerClassByOwner(activator);
			if (controller_class == null)
			{
				return;
			}
		}
		controller_class.Press_D();
	}

	::CreateSelect <- function(activator)
	{
		local vecOrigin = GetOriginBAZA();
		activator.SetOrigin(vecOrigin);
		AOP(Entity_Maker, "EntityTemplate", "select");
		Entity_Maker.SpawnEntityAtLocation(vecOrigin, Vector());
	}

	::GetPreSelectByOwner <- function(owner)
	{
		foreach (index, value in PRESELECTS)
		{
			if (value[0] == owner)
			{
				return index;
			}
		}
		return -1;
	}
}

function Touch_Start()
{
	if (!TargetValid(activator))
	{
		return;
	}
	PushPlayerArray(activator);

	if (iChapter == -2)
	{
		activator.SetOrigin(GetOriginBAZA());
		return;
	}

	if (GetPickerClassByOwner(activator) != null)
	{
		return;
	}

	if (activator.GetTeam() == 3)
	{
		if (GetHumanOwnerClassByOwner(activator) == null)
		{
			CreateClassPicker(activator);
			return;
		}
		EF(activator, "SetHealth", "0");
	}
	else
	{
		if (GetZombieOwnerClassByOwner(activator) == null)
		{
			CreateClassPicker(activator);
			return;
		}
		EF(activator, "SetHealth", "0");
	}
}

::Touch_Teleport_Human <- function()
{
	local vecAngles = Vector();
	local vecOrigin = Vector(-3281, -2307, -144);

	switch (iChapter)
	{
		case -1:
		{
			vecAngles = Vector(0, -90, 0);
			vecOrigin = Vector(1264, -583, 2268);
			break;
		}

		case 0:
		{
			if (PROLOG_STATUS == 0)
			{
				vecAngles = Vector(10, 15.5, 0);
				vecOrigin = Vector(2106, 3674, -12520);
			}
			else if (PROLOG_STATUS == 1)
			{
				vecAngles = Vector(15, 270, 0);
				vecOrigin = Vector(-8694, 9610, 1170);
			}
			break;
		}
		case 1:
		{
			vecAngles = Vector(-14, 146, 0);
			vecOrigin = Vector(-3353, -2261, -125);
			break;
		}
		case 2:
		{
			vecAngles = Vector(0, -90, 0);
			vecOrigin = Vector(1406, 211, 2192);
			break;
		}
		case 3:
		{
			vecAngles = Vector(0, -90, 0);
			vecOrigin = Vector(6893, 777, -87);
			break;
		}
		default:
		{
			break;
		}
	}

	activator.SetOrigin(vecOrigin);
	activator.SetAngles(vecAngles.x ,vecAngles.y, vecAngles.z);
}

::TeleportToMap <- function(activator)
{
	local vecOrigin;
	local vecAngles;

	local vecStartCTAng = Vector();
	local vecStartTAng = Vector();
	local vecStartCT = Vector(-3281, -2307, -144);
	local vecStartT = Vector(2816, 1154, 100);

	switch (iChapter)
	{
		case 1:
		{
			vecStartCTAng = Vector(0, 150, 0);
			vecStartCT = Vector(-3281, -2307, -144);
			break;
		}
		case 2:
		{
			vecStartCT = Vector(1264, -583, 2268);
			break;
		}
		case 2:
		{
			vecStartCT = Vector(1264, -583, 2268);
			break;
		}
		default:
		{
			break;
		}
	}

	if (GetMapName().find("testroom") != null)
	{
		vecStartCT = Vector(-613, -709, -12);
		vecStartT = Vector(-613, 709, -12);
	}

	if (activator.GetTeam() == 3)
	{
		vecAngles = vecStartCTAng;
		vecOrigin = vecStartCT;
	}
	else
	{
		vecAngles = vecStartTAng;
		vecOrigin = vecStartT;
	}

	activator.SetAngles(vecAngles.x ,vecAngles.y, vecAngles.z);
	activator.SetOrigin(vecOrigin);
}

::DamagePlayer <- function(player, damage, damagetype = null)
{
	local hp = player.GetHealth() - damage.tointeger();

	if (hp < 1)
	{
		EF(player, "SetHealth", "0");
		return;
	}

	player.SetHealth(hp);
}

// TRIGGERS
{
	enum Enum_LIFT
	{
		Down,
		Up,
		Move_Down,
		Move_Up,
	}
	::Enum_LIFT <- CONST.Enum_LIFT;

	::Chapter_End <- function()
	{
		Class_Scope.Human_Reset_Ability();
	}

	function Spawn_Chapter()
	{
		switch (iChapter)
		{
			case -1:
			{
				Spawn_Debug();
				break;
			}
			case 0:
			{
				Spawn_Prolog();
				break;
			}
			case 1:
			{
				Spawn_Chapter01();
				break;
			}
			case 2:
			{
				Spawn_Chapter02();
				break;
			}
			case 3:
			{
				Spawn_Chapter03();
				break;
			}
			default:
			{
				break;
			}
		}
		Chapter_Init = false;
	}
	function Spawn_Debug()
	{
		DISABLE_ABILITY = false;

		Portal_Scope.Portal_Init_CH01();
		EF("map_trigger_start_human", "Enable");
	}

	function Spawn_Prolog()
	{
		EF("cp", "ForceSpawn");
		CallFunction("Trigger_Prologue_00()", 10.0);

		// CallFunction("Trigger_Prologue_02()", 4.0);

		PROLOG_STATUS = 0;
	}

	PROLOG_STATUS <- 0;

	//SUBS
	{
		function Text_Autors()
		{
			EF("map_entity_text", "SetText", "HaRyDe\nKotya\nMicrorost\nFriend");
			EF("map_entity_text", "AddOutPut", "effect 2");
			EF("map_entity_text", "AddOutPut", "fadein 0.45");
			EF("map_entity_text", "AddOutPut", "y 0.55");
			EF("map_entity_text", "AddOutPut", "x -1.00");
			EF("map_entity_text", "AddOutPut", "duration 10");

			foreach (player in PLAYERS)
			{
				if (!TargetValid(player))
				{
					continue;
				}

				EntFire("map_entity_text", "Display", "", 0, player);
			}
		}

		function Text_Autors_A()
		{
			EF("map_entity_text", "SetText", Translate["autors"]);
			EF("map_entity_text", "AddOutPut", "effect 2");
			EF("map_entity_text", "AddOutPut", "fadein 0.1");
			EF("map_entity_text", "AddOutPut", "y 0.52");
			EF("map_entity_text", "AddOutPut", "x -1.00");
			EF("map_entity_text", "AddOutPut", "duration 4");

			foreach (player in PLAYERS)
			{
				if (!TargetValid(player))
				{
					continue;
				}

				EntFire("map_entity_text", "Display", "", 0, player);
			}
		}

		function Text_Nietzsche()
		{
			EF("map_entity_text", "SetText", Translate["nietzsche"]);
			EF("map_entity_text", "AddOutPut", "effect 2");
			EF("map_entity_text", "AddOutPut", "fadein 0.08");
			EF("map_entity_text", "AddOutPut", "y 0.43");
			EF("map_entity_text", "AddOutPut", "x -1.00");
			EF("map_entity_text", "AddOutPut", "duration 10");

			foreach (player in PLAYERS)
			{
				if (!TargetValid(player))
				{
					continue;
				}
				if (player.GetTeam() == 2)
				{
					continue;
				}
				EntFire("map_entity_text", "Display", "", 0, player);
			}
		}

		function Text_Prologue()
		{
			EF("map_entity_text", "SetText", Translate["date_prologue"]);
			EF("map_entity_text", "AddOutPut", "effect 2");
			EF("map_entity_text", "AddOutPut", "fadein 0.05");
			EF("map_entity_text", "AddOutPut", "y 0.50");
			EF("map_entity_text", "AddOutPut", "x 0.00");
			EF("map_entity_text", "AddOutPut", "duration 6");

			foreach (player in PLAYERS)
			{
				if (!TargetValid(player))
				{
					continue;
				}
				if (player.GetTeam() == 2)
				{
					continue;
				}
				EntFire("map_entity_text", "Display", "", 0, player);
			}
		}

		function Text_CP1()
		{
			EF("map_entity_text", "SetText", Translate["date_cp1"]);
			EF("map_entity_text", "AddOutPut", "effect 2");
			EF("map_entity_text", "AddOutPut", "fadein 0.05");
			EF("map_entity_text", "AddOutPut", "y 0.50");
			EF("map_entity_text", "AddOutPut", "x 0.00");
			EF("map_entity_text", "AddOutPut", "duration 6");

			foreach (player in PLAYERS)
			{
				if (!TargetValid(player))
				{
					continue;
				}
				if (player.GetTeam() == 2)
				{
					continue;
				}
				EntFire("map_entity_text", "Display", "", 0, player);
			}
		}

		function Text_CP2()
		{
			EF("map_entity_text", "SetText", Translate["date_cp2"]);
			EF("map_entity_text", "AddOutPut", "effect 2");
			EF("map_entity_text", "AddOutPut", "fadein 0.05");
			EF("map_entity_text", "AddOutPut", "y 0.50");
			EF("map_entity_text", "AddOutPut", "x 0.00");
			EF("map_entity_text", "AddOutPut", "duration 6");

			foreach (player in PLAYERS)
			{
				if (!TargetValid(player))
				{
					continue;
				}
				if (player.GetTeam() == 2)
				{
					continue;
				}
				EntFire("map_entity_text", "Display", "", 0, player);
			}
		}


		function Text_CP3()
		{
			EF("map_entity_text", "SetText", Translate["date_cp3"]);
			EF("map_entity_text", "AddOutPut", "effect 2");
			EF("map_entity_text", "AddOutPut", "fadein 0.05");
			EF("map_entity_text", "AddOutPut", "y 0.50");
			EF("map_entity_text", "AddOutPut", "x 0.00");
			EF("map_entity_text", "AddOutPut", "duration 6");

			foreach (player in PLAYERS)
			{
				if (!TargetValid(player))
				{
					continue;
				}
				if (player.GetTeam() == 2)
				{
					continue;
				}
				EntFire("map_entity_text", "Display", "", 0, player);
			}
		}
	}

	function Trigger_Prologue_00()
	{
		CallFunction("Human_Glow_Disabled()");

		EF("skycamera_main", "ActivateSkyBox");
		EF("cp_logic_music01*", "PlaySound");
		EF("map_entity_fade_end_chapter_out", "Fade");

		CUT_SCENE_DATA = [
			{
				o1 = Vector(7097, -1129, -76),
				a1 = Vector(5, -83, 0),
				time1 = 4.00,
				o2 = Vector(6888, -88, 348),
				a2 = Vector(21, -78, 0),
				time2 = 0.10,
				flytime = 11.50,
			},
			{
				o1 = Vector(6888, -88, 348),
				a1 = Vector(21, -78, 0),
				time1 = 0.00,
				o2 = Vector(8452, -525, 537),
				a2 = Vector(3, 16, 0),
				time2 = 2.00,
				flytime = 10.00,
			},
			{
				o1 = Vector(9947, 7047, -96),
				a1 = Vector(-0, 91, 0),
				time1 = 0.1,
				o2 = Vector(9949, 5978, 393),
				a2 = Vector(24, 90, 0),
				time2 = 0.1,
				flytime = 5.00,
			},
			{
				o1 = Vector(9949, 5978, 393),
				a1 = Vector(24, 90, 0),
				time1 = 0.1,
				o2 = Vector(9949, 5994, 409),
				a2 = Vector(-45, 90, 0),
				time2 = 2.00,
				flytime = 3.90,
			},
			{
				o1 = Vector(2197, 3704, -12472),
				a1 = Vector(0, 18.4, 0),
				time1 = 3.00,
				o2 = Vector(2106, 3674, -12445),
				a2 = Vector(15, 18, 0),
				time2 = 3.00,
				flytime = 5.00,
			},
		];

		EF("cp_logic_tv*", "Skin", "1" , 43.0);
		EF("cp_logic_tv*", "Skin", "5" , 44.0);
		EF("cp_logic_tv*", "Skin", "3" , 48.5);
		EF("cp_logic_tv*", "Skin", "4" , 50.5);
		EF("cp_logic_tv*", "Skin", "0" , 67.0);

		EF("cp01", "ForceSpawn");

		Spawn_Location01();

		CallFunction("StartCutScene()", 2.0);

		EF("map_entity_fade_end_chapter_in", "Fade", "", 37.0);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 39.5);


		EF("map_entity_fade_end_chapter_in", "Fade", "", 47.0);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 50.5);

		CallFunction("Text_Prologue()", 58.0);

		CallFunction("StartOverLay(\"overlay/Prologue\", 8.0);", 50.0);

		EF("map_trigger_start_human", "Enable", "", 50);
		EF("map_trigger_start_human", "Disable", "", 55.0);

		local array = [
			Enum_TextColor.Penalty + Translate["tip0"],
			Enum_TextColor.Penalty + Translate["tip1"],
			Enum_TextColor.Penalty + Translate["tip2"],
			Enum_TextColor.Penalty + Translate["tip3"],
			Enum_TextColor.Penalty + Translate["tip4"],
			Enum_TextColor.Penalty + Translate["tip5"],
			Enum_TextColor.Penalty + Translate["tip6"],
			Enum_TextColor.Penalty + Translate["tip7"],
			Enum_TextColor.Penalty + Translate["tip8"],
			Enum_TextColor.Penalty + Translate["tip9"],
			Enum_TextColor.Penalty + Translate["tip10"],
		];

		local delay = 60.0;
		for (local i = 0; i < 11; i++)
		{
			PrintChatMessageAll(array[i], delay);
			delay += 1.5;
		}

		PrintChatMessageAll(Enum_TextColor.Award + Translate["text00"], 79);

		EF("cp_logic_warning*", "PlaySound", "", 79);
		EF("cp_logic_door00*", "Open", "", 80);

		EF("cp_logic_helicopter00*", "SetAnimation", "2start", 75);
		EF("cp_logic_helicopter00*", "SetDefaultAnimation", "3ready", 75.05);

		EF("cp_logic_helicopter00*", "SetGlowEnabled", "", 81);

		EF("cp_logic_helicopter00*", "SetGlowDisabled", "", 95);
		EF("cp_logic_mover01*", "Open", "", 95);

		EF("cp_logic_warning*", "StopSound", "", 90);
		EF("cp_logic_warning*", "PlaySound", "", 90);

		EF("cp_logic_mover01*", "SetSpeed", "75", 96);
		EF("cp_logic_mover01*", "SetSpeed", "175", 98);


		CallFunction("Text_Autors()", 80.0);
		CallFunction("Text_Autors_A()", 95.0);
		CallFunction("StartOverLay(\"overlay/uber\", 10.0);", 98.0);

		EF("map_entity_fade_end_chapter_in", "Fade", "", 101);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 103.5);

		CallFunction("Trigger_Prologue_01()", 105);
	}

	function Trigger_Prologue_01()
	{
		foreach (player in PLAYERS)
		{
			if (!TargetValid(player))
			{
				continue;
			}
			if (player.GetTeam() != 3 ||
			player.GetHealth() < 1)
			{
				continue;
			}

			player.SetOrigin(g_vecCTRoom);
		}

		CUT_SCENE_DATA = [
			//Полет по больнице
			{
				o1 = Vector(240, 2300, 350),
				a1 = Vector(0, -90, 0),
				time1 = 0.10,
				o2 = Vector(240, -1660, 350),
				a2 = Vector(0, -90, 0),
				time2 = 0.10,
				flytime = 12.00,
			},
			{
				o1 = Vector(870, -480, -80),
				a1 = Vector(0, 90, 0),
				time1 = 0.50,
				o2 = Vector(870, -1071, -66),
				a2 = Vector(0, 90, 0),
				time2 = 0.10,
				flytime = 5.00,
			},
			{
				o1 = Vector(870, -1071, -66),
				a1 = Vector(0, 90, 0),
				time1 = 0.10,
				o2 = Vector(865, -1247, -32),
				a2 = Vector(20, 90, 0),
				time2 = 0.10,
				flytime = 2.50,
			},
			{
				o1 = Vector(865, -1247, -32),
				a1 = Vector(20, 90, 0),
				time1 = 0.10,
				o2 = Vector(865, -1247, -32),
				a2 = Vector(-30, 80, 0),
				time2 = 0.50,
				flytime = 3.00,
			},
			{
				o1 = Vector(6681, -350, 820),
				a1 = Vector(90, 90, 0),
				time1 = 0.10,
				o2 = Vector(9538, -350, 820),
				a2 = Vector(90, 90, 0),
				time2 = 0.10,
				flytime = 9.00,
			},
		];

		EF("skycamera_main", "ActivateSkyBox");

		EF("map_entity_fade_end_chapter_in", "Fade", "", 8.6);
		EF("map_entity_fade_end_chapter_in", "Fade", "", 21);
		StartCutScene();

		EF("map_entity_fade_end_chapter_in", "Fade", "", 28);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 31.5);

		EF("skycamera_prolog01", "ActivateSkyBox", "", 32);
		EF("instanceauto1-cpsky_city_timer", "Enable", "", 25);

		CallFunction("Trigger_Prologue_02()", 33);
	}

	function Trigger_Prologue_02()
	{
		// EF("skycamera_prolog02", "ActivateSkyBox");

		PROLOG_STATUS = 1;
		EF("map_trigger_start_human", "Enable");
		EF("map_trigger_start_human", "Disable", "", 5.0);

		CallFunction("Trigger_Prologue_03()", 9.0);

		// EF("cp_logic_music02*", "PlaySound");
	}

	function Trigger_Prologue_03()
	{
		CUT_SCENE_DATA = [
			{
				o1 = Vector(-8807, 3288, 1948),
				a1 = Vector(30, 82, 0),
				time1 = 0.10,
				o2 = Vector(-8510, 6086, 1100),
				a2 = Vector(0, 97, 0),
				time2 = 0.10,
				flytime = 6.00,
			},
			{
				o1 = Vector(-8510, 6086, 1100),
				a1 = Vector(0, 97, 0),
				time1 = 0.00,
				o2 = Vector(-8680, 6100, 1178),
				a2 = Vector(3, 92, 0),
				time2 = 1.00,
				flytime = 1.50,
			},
		]
		CallFunction("StartCutScene()", 0.0);

		EF("cp_logic_effect02*", "SetParentAttachmentMaintainOffset", "muzzle");
		EF("cp_logic_helicopter02*", "SetAnimation", "spin");
		EF("cp_logic_helicopter02*", "Enable");

		EF("cp_logic_mover02*", "StartForward", "", 0);
		EF("cp_logic_phrase_00*", "PlaySound", "", 0);

		EF("cp_logic_effect02*", "Start", "", 10.0);
		EF("cp_logic_sound_01*", "PlaySound", "", 9.8);

		EF("cp_logic_mover03*", "StartForward", "", 12);
		EF("cp_logic_phrase_01*", "PlaySound", "", 13);

		EF("cp_logic_effect02*", "Stop", "", 13.2);
		EF("cp_logic_sound_01*", "StopSound", "", 13.2);

		EF("cp_logic_mover02*", "StartForward", "", 14);
		EF("cp_logic_phrase_02*", "PlaySound", "", 16);

		EF("cp_logic_sound_01*", "PlaySound", "", 17.8);
		EF("cp_logic_effect02*", "Start", "", 18);
		EF("cp_logic_hurt*", "Enable", "", 18.2);

		EF("cp_logic_effect04_00*", "StartSpark", "", 20.5);
		EF("cp_logic_effect04_01*", "Start", "", 25);
		EF("cp_logic_sound_04*", "PlaySound", "", 25);

		EF("cp_logic_phrase_03*", "PlaySound", "", 25.25);
		EF("cp_logic_phrase_04*", "PlaySound", "", 27);
		EF("cp_logic_phrase_05*", "PlaySound", "", 28);
		EF("cp_logic_sound_01*", "StopSound", "", 33);

		EF("cp_logic_hurt*", "Disable", "", 34);
		CallFunction("bFade = true;", 35.5);

		EF("cp_logic_effect04_01*", "Stop", "", 35.75);
		EF("cp_logic_effect04_01*", "Start", "", 35.8);
		EF("cp_logic_sound_04*", "PlaySound", "", 35.8);

		CallFunction("Trigger_Prologue_04()", 37);

		CallFunction("StartOverLay(\"overlay/cut_scene\", 13.0);", 36);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 36);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 37);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 38);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 39);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 40);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 41);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 42);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 43);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 44);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 45);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 46);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 47);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 48);

		CallFunction("bFade = false;", 49);

		EF("cp_logic_music01*", "Volume", "9", 30);
		EF("cp_logic_music01*", "Volume", "8", 31.5);
		EF("cp_logic_music01*", "Volume", "7", 32);
		EF("cp_logic_music01*", "Volume", "6", 32.5);
		EF("cp_logic_music01*", "Volume", "5", 33);
		EF("cp_logic_music01*", "Volume", "4", 33.5);
		EF("cp_logic_music01*", "Volume", "3", 34);
		EF("cp_logic_music01*", "Volume", "2", 34.5);
		EF("cp_logic_music01*", "Volume", "1", 35);
		EF("cp_logic_music01*", "Volume", "0", 35.5);
	}

	function Trigger_Prologue_04()
	{
		EF("instanceauto1-cpsky_city_timer", "Kill");
		EF("skycamera_main", "ActivateSkyBox");

		foreach (player in PLAYERS)
		{
			if (!TargetValid(player))
			{
				continue;
			}
			if (player.GetTeam() != 3 ||
			player.GetHealth() < 1)
			{
				continue;
			}
			player.SetOrigin(g_vecCTRoom);
		}

		EF("cp_logic_phrase_06*", "PlaySound");
		CallFunction("Trigger_Prologue_05()", 11);
	}

	function Trigger_Prologue_05()
	{
		CUT_SCENE_DATA = [
			{
				o1 = Vector(-3279, -2309, -138),
				a1 = Vector(-89, 147, 0),
				time1 = 2.00,
				o2 = Vector(-3279, -2309, -138),
				a2 = Vector(-34, 150, 0),
				time2 = 0.50,
				flytime = 4.00,
			},
			{
				o1= Vector(-3279, -2309, -138),
				a1 = Vector(-34, 150, 0),
				time1 = 0.10,
				o2 = Vector(-3353, -2261, -125),
				a2 = Vector(-14, 146, 0),
				time2 = 0.10,
				flytime = 4.00,
			},
			{
				o1 = Vector(-3353, -2261, -125),
				a1 = Vector(-14, 146, 0),
				time1 = 2.00,
				o2 = Vector(-3353, -2261, -125),
				a2 = Vector(90, 146, 0),
				time2 = 1.50,
				flytime = 2.00,
			},
			{
				o1 = Vector(-3353, -2261, -125),
				a1 = Vector(90, 146, 0),
				time1 = 5.00,
				o2 = Vector(-3353, -2261, -125),
				a2 = Vector(-14, 146, 0),
				time2 = 1.50,
				flytime = 2.00,
			},
			{
				o1 = Vector(-3353, -2261, -125),
				a1 = Vector(-14, 146, 0),
				time1 = 0.10,
				o2 = Vector(-3353, -2261, -85),
				a2 = Vector(-14, 146, 0),
				time2 = 0.50,
				flytime = 3.00,
			},
		]
		EF("loc01_props_helicopter*", "Disable");
		EF("map_entity_fade_end_chapter_out*", "Fade", "", 0);
		EF("cp_logic_blood_fade*", "Fade", "", 3.5);
		EF("cp_logic_blood_fade*", "Fade", "", 5.0);
		EF("cp_logic_blood_fade*", "Fade", "", 7.0);
		EF("cp_logic_blood_fade*", "Fade", "", 9.0);
		EF("cp_logic_blood_fade*", "Fade", "", 11.0);
		EF("map_entity_fade_end_chapter_in*", "Fade", "", 11.8);

		foreach (player in PLAYERS)
		{
			if (!TargetValid(player))
			{
				continue;
			}

			EntFire("point_clientcommand", "Command", "play player/heartbeat_noloop.wav", 3.5, player);
			EntFire("point_clientcommand", "Command", "play player/heartbeat_noloop.wav", 5.0, player);
			EntFire("point_clientcommand", "Command", "play player/heartbeat_noloop.wav", 7.0, player);
			EntFire("point_clientcommand", "Command", "play player/heartbeat_noloop.wav", 9.0, player);
			EntFire("point_clientcommand", "Command", "play player/heartbeat_noloop.wav", 11.0, player);
		}
		CallFunction("StartCutScene()", 0.0);

		EF("map_entity_fade_end_chapter_out*", "Fade", "", 15);
		EF("map_entity_fade_end_chapter_out*", "Fade", "", 16);
		EF("map_entity_fade_end_chapter_out*", "Fade", "", 17);
		EF("map_entity_fade_end_chapter_out*", "Fade", "", 18);

		EF("cp_logic_phrase_07*", "PlaySound", "", 17.0);
		EF("cp_logic_phrase_08*", "PlaySound", "", 20.0);

		CallFunction("Trigger_Prologue_06()", 24.7);
	}

	function Trigger_Prologue_06()
	{
		iChapter01_Save_Portals.clear();
		Portal_Scope.Portal_Init_CH01();

		EF("cp_*", "Kill", "", 10);
		iChapter = 1;

		CallFunction("Trigger_Chapter1_00()", 2.8);
	}

	function Spawn_Chapter01()
	{
		iChapter01_Save_Portals.clear();
		Portal_Scope.Portal_Init_CH01();

		EF("cp01", "ForceSpawn");

		Spawn_Location01();

		CallFunction("Text_Nietzsche();", 5.5);

		CallFunction("bFade = true;", 16.5);
		EF("map_entity_fade_end_chapter_in", "Fade", "", 16.5);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 20);

		CallFunction("bFade = false;", 25);

		CallFunction("Human_Glow_Disabled()", 15);
		CallFunction("Trigger_Chapter1_00()", 20);

		local array = [
			Enum_TextColor.Penalty + Translate["tip0"],
			Enum_TextColor.Penalty + Translate["tip1"],
			Enum_TextColor.Penalty + Translate["tip2"],
			Enum_TextColor.Penalty + Translate["tip3"],
			Enum_TextColor.Penalty + Translate["tip4"],
			Enum_TextColor.Penalty + Translate["tip5"],
			Enum_TextColor.Penalty + Translate["tip6"],
			Enum_TextColor.Penalty + Translate["tip7"],
			Enum_TextColor.Penalty + Translate["tip8"],
			Enum_TextColor.Penalty + Translate["tip9"],
			Enum_TextColor.Penalty + Translate["tip10"],
		];

		local delay = 0.0;
		for (local i = 0; i < 11; i++)
		{
			PrintChatMessageAll(array[i], delay);
			delay += 1.8;
		}
	}

	function TestCamera()
	{
		CUT_SCENE_DATA = [
			{
				o1 = Vector(7853, 200, 816),
				a1 = Vector(25, -96, 0),
				time1 = 0.0,
				o2 = Vector(8095, -524, 235),
				a2 = Vector(3, -15, 0),
				time2 = 0.5,
				flytime = 3.5,
			},

			{
				o1 = Vector(8939, -4804, 64),
				a1 = Vector(-8, 79, 0),
				time1 = 0.0,
				o2 = Vector(9313, -3063, 540),
				a2 = Vector(38, -67, 0),
				time2 = 0.5,
				flytime = 3.5,
			},
			{
				o1 = Vector(7707, -2809, 134),
				a1 = Vector(7, -177, 0),
				time1 = 0.0,
				o2 = Vector(6666, -3463, 54),
				a2 = Vector(2, 138, 0),
				time2 = 0.5,
				flytime = 3.5,
			},
		];
		CallFunction("StartCutScene()", 0.0);
	}

	function KillHelicopter()
	{
		foreach (player in PLAYERS)
		{
			if (!TargetValid(player))
			{
				continue;
			}
			if (player.GetHealth() < 1)
			{
				continue;
			}

			if (!IsVectorInSphere(Vector(-3487, -2269, -67), 320, player.GetOrigin()))
			{
				continue;
			}

			EF(player, "SetHealth", "0");
		}
	}

	function Spawn_Location01()
	{
		EF("loc01", "ForceSpawn");

		LIFT_STATUS_CP01 = Enum_LIFT.Down;
		Location01_Spawn_MedKits();

		EF("loc01_props_ragdoll*", "DisableMotion", "", 3);

		if (iChapter > 1)
		{
			EF("loc01_wall00*", "Toggle");
			EF("loc01_quest01_trigger*", "Kill");
			EF("loc01_quest00_door*", "Open");

			LIFT_INIT = false;

			EF("loc01_logic_lift_button0*", "UnLock");
			EF("loc01_logic_lift_door03*", "SetSpeed", "200");
			EF("loc01_logic_lift_door00*", "Open");
			EF("loc01_logic_lift_door02*", "Open");

			EF("loc01_quest03_door01*", "Lock");

			EF("loc01_quest03_button*", "Kill");
			EF("loc01_quest03_door00a*", "AddOutPut", "angles 0 145 0");
		}
	}

	function Spawn_Chapter02()
	{
		Portal_Scope.Portal_Init_CH02();
		Portal_Scope.Portal_Init_CH02_Quest01();
		Portal_Scope.Portal_Init_CH01_Save();

		CallFunction("Text_Nietzsche();", 5.5);
		CallFunction("Spore_Start(300);", 20.0);
		CallFunction("Human_Glow_Disabled()", 15);

		CallFunction("bFade = true;", 16.5);
		EF("map_entity_fade_end_chapter_in", "Fade", "", 16.5);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 20.0);
		CallFunction("StartOverLay(\"overlay/c2\", 7.0);", 20.0);
		CallFunction("Text_CP2()", 27);

		EF("cp02_quest00_prop01*", "SetGlowEnabled", "", 27);

		CallFunction("bFade = false;", 25.0);

		EF("map_trigger_start_human", "Enable", "", 20);
		CallFunction("Human_Glow_Enabled()", 27.0);

		CallFunction("PlayMusic(4)", 19.0);

		EF("cp02", "ForceSpawn");
		Spawn_Location01();
		Spawn_Location02();

		EF("loc01_quest03_trigger00z*", "Kill");
		EF("loc01_quest03_door00z*", "Open");

		EF("loc01_quest03_door01*", "UnLock");
		EF("loc01_quest03_door01*", "Open");
		EF("loc01_quest03_door01*", "Lock");

		EF("loc01_quest03_door02*", "Open");

		local array = [
			Enum_TextColor.Penalty + Translate["tip0"],
			Enum_TextColor.Penalty + Translate["tip1"],
			Enum_TextColor.Penalty + Translate["tip2"],
			Enum_TextColor.Penalty + Translate["tip3"],
			Enum_TextColor.Penalty + Translate["tip4"],
			Enum_TextColor.Penalty + Translate["tip5"],
			Enum_TextColor.Penalty + Translate["tip6"],
			Enum_TextColor.Penalty + Translate["tip7"],
			Enum_TextColor.Penalty + Translate["tip8"],
			Enum_TextColor.Penalty + Translate["tip9"],
			Enum_TextColor.Penalty + Translate["tip10"],
		];

		local delay = 0.0;
		for (local i = 0; i < 11; i++)
		{
			PrintChatMessageAll(array[i], delay);
			delay += 1.8;
		}

		PrintChatMessageAll(Enum_TextColor.Award + Translate["text01"], 20);
		PrintChatMessageAll(Enum_TextColor.Award + Translate["text02"], 22.0);
		PrintChatMessageAll(Enum_TextColor.Award + Translate["text03"], 24.0);
		PrintChatMessageAll(Enum_TextColor.Award + Translate["text04"], 26.0);
		PrintChatMessageAll(Enum_TextColor.Award + Translate["text05"], 28.0);
	}

	function Spawn_Location02()
	{
		EF("loc02", "ForceSpawn");

		EF("loc02_props_ragdoll*", "DisableMotion", "", 3);
		Location02_Spawn_MedKits();

		if (iChapter != 2)
		{
			EF("loc02_quest03_trigger*", "Kill");
			return;
		}
	}

	function Spawn_Chapter03()
	{
		Portal_Scope.Portal_Init_CH03();
		EF("cp03", "ForceSpawn");

		CallFunction("Text_Nietzsche();", 5.5);
		CallFunction("Spore_Start(300);", 20.0);
		CallFunction("Human_Glow_Disabled()", 15);

		CallFunction("bFade = true;", 16.5);
		EF("map_entity_fade_end_chapter_in", "Fade", "", 16.5);
		EF("map_entity_fade_end_chapter_out", "Fade", "", 20.0);
		CallFunction("PlayMusic(7)", 19.0);
		CallFunction("StartOverLay(\"overlay/c3\", 7.0);", 20.0);
		CallFunction("Text_CP3()", 27);
		CallFunction("bFade = false;", 25.0);

		EF("map_trigger_start_human", "Enable", "", 20);
		CallFunction("Human_Glow_Enabled()", 27.0);

		Spawn_Location03();
		PrintChatMessageAll(Enum_TextColor.Award + Translate["text06"], 25);
		CallFunction("Trigger_Chapter3_01()", 27);

		local array = [
			Enum_TextColor.Penalty + Translate["tip0"],
			Enum_TextColor.Penalty + Translate["tip1"],
			Enum_TextColor.Penalty + Translate["tip2"],
			Enum_TextColor.Penalty + Translate["tip3"],
			Enum_TextColor.Penalty + Translate["tip4"],
			Enum_TextColor.Penalty + Translate["tip5"],
			Enum_TextColor.Penalty + Translate["tip6"],
			Enum_TextColor.Penalty + Translate["tip7"],
			Enum_TextColor.Penalty + Translate["tip8"],
			Enum_TextColor.Penalty + Translate["tip9"],
			Enum_TextColor.Penalty + Translate["tip10"],
		];

		local delay = 0.0;
		for (local i = 0; i < 11; i++)
		{
			PrintChatMessageAll(array[i], delay);
			delay += 1.8;
		}

	}

	function Spawn_Location03()
	{
		EF("loc03", "ForceSpawn");

		LIFT_STATUS_CP03 = Enum_LIFT.Down;
		LIFT_INIT_CP03 = true;

		EF("loc03_props_ragdoll*", "DisableMotion", "", 3);

		Location03_Spawn_MedKits();
	}

	::Location01_Spawn_MedKits <- function()
	{
		local aVec = [
		class_pos(Vector(1287, 208, 1509), Vector(0, 90, 0)),
		class_pos(Vector(980, -760, -113), Vector(0, 15, 0)),
		class_pos(Vector(1635, 12, -125), Vector(0, 15, 0)),
		class_pos(Vector(1497.76, 144.173, 2167), Vector(0, 345, 0)),
		class_pos(Vector(-1388, -4384.4, -153), Vector(0, 270, 0)),
		class_pos(Vector(-2083, 93, -145), Vector(0, 195, 0)),
		class_pos(Vector(4313, -272, -153), Vector(0, 120, 0)),
		class_pos(Vector(2954, -3348, -146), Vector(0, 270, 0)),
		];

		AOP(Entity_Maker, "EntityTemplate", "item_heal");
		foreach (vec in aVec)
		{
			Entity_Maker.SpawnEntityAtLocation(vec.origin, vec.angles);
		}
	}

	::Trigger_Chapter1_00 <- function()
	{
		SetSettings(1);
		DISABLE_ABILITY = false;

		EF("instanceauto1-skybox_env", "Stop");
		EF("instanceauto1-skybox_env", "Start");

		Spore_Start(360);

		PlayMusic(1);

		PrintChatMessageAll(Enum_TextColor.Award + Translate["text07"]);
		PrintChatMessageAll(Enum_TextColor.Award + Translate["text08"], 5.0);
		PrintChatMessageAll(Enum_TextColor.Award + Translate["text09"], 10.0);

		EF("loc01_props_helicopter*", "Disable");

		EF("loc01_quest00_door*", "SetGlowEnabled", "", 7);

		EF("map_trigger_start_human", "Enable", "", 1.0);
		Portal_Scope.ZombieToTeleportRadius(Vector(-3487, -2269, -67), 1750);

		StartOverLay("overlay/c1", 7.0);
		CallFunction("Text_CP1()", 7);

		CallFunction("Human_SetHalfHP()", 1.0);
		CallFunction("Human_Glow_Enabled()", 7.0);

		EF("cp01_sound02*", "PlaySound", "", 9.75);
		EF("cp01_effect02*", "Start", "", 9.75);

		EF("cp01_sound01*", "PlaySound", "", 10);
		EF("cp01_effect01*", "Start", "", 10);
		EF("loc01_wall00*", "Toggle", "", 10);

		CallFunction("KillHelicopter()", 10);

		EF("cp01_sound00*", "PlaySound", "", 10.25);
		EF("cp01_effect00*", "Start", "", 10.25);

		EF("cp01_fire*", "Kill", "", 10.1);
		EF("cp01_sound0*", "Kill", "", 20);

		EF("cp01_props_helicopter*", "Kill", "", 10.1);
		EF("loc01_props_helicopter*", "Enable", "", 10);
		// EF("loc01_props_helicopter*", "EnableCollision", "", 20);

		EF("cp01_effect0*", "Kill", "", 15);
	}

	::Trigger_Chapter1_01 <- function()
	{
		Portal_Scope.Portal_Maker_CH01a();

		EF("loc01_quest00_door*", "Open");
		EF("loc01_quest00_door*", "Close", "", 25.0);

		EF("loc01_quest00_door*", "Open", "", 45.0);

		CallFunction("Trigger_Chapter1_03()", 27.0);

		PrintChatMessageAll(Enum_TextColor.Award + Translate["text10"]);
		PrintChatMessageAll(Enum_TextColor.Award + Translate["text11"], 2.0);
		PrintChatMessageAll(Enum_TextColor.Award + Translate["text12"], 4.0);
		PrintChatMessageAll(Enum_TextColor.Award + Translate["text13"], 6.0);

		PrintChatMessageAll(Enum_TextColor.Award + Translate["text14"], 25.0);
	}

	::Trigger_Chapter1_03 <- function()
	{
		SPORE_INDIVIDUAL_PLAYERS.clear();
		foreach (player in PLAYERS)
		{
			if (!TargetValid(player))
			{
				continue;
			}
			if (player.GetTeam() != 3 ||
			player.GetHealth() < 1)
			{
				continue;
			}

			if (IsVectorInBoundingBox(player.GetOrigin(), Vector(1224, -124, -84), Vector(447.5, 892, 90.5)))
			{
				continue;
			}
			Individual_Spore(player);
		}

		Portal_Scope.Portal_Init_CH01_Quest01();

		EF("loc01_props_lift*", "SetGlowEnabled");
		EF("cp01_quest02_trigger*", "Enable");

		EF("cp01_quest02_prop*", "Enable");
		EF("cp01_quest02_prop*", "SetGlowEnabled");

		TRIGGER_CHAPTER1_TOOLS = 0;

		PrintChatMessageAll(Enum_TextColor.Award + Translate["text15"]);
	}
	//CP1_QUEST_01
	{
		::Trigger_Quest_01_Start <- function()
		{
			local aVec = [
				Vector(-3410, -259, -183.969),
				Vector(-987, -830, -135.969),
				Vector(-1744, -4823, -191.969),
				Vector(2355, -3402, -183.969),
				Vector(-3486, 1051, -183.969),
				Vector(1338, 2033, -173.969),
				Vector(-750, -3421, -191.969),
				Vector(1221, -3567, -183.969),
				Vector(-1637, -3396, -191.969),
				Vector(4883, -1806, -183.969),
			];

			local iRandomChance = 35;
			local iNearRadiusZombie = 512;
			local iNearRadiusHuman = 4000;

			EF("loc01_quest01_trigger*", "Enable");
			EF("loc01_quest01_prop*", "Enable");
			EF("loc01_quest01_prop*", "SetGlowEnabled");

			local ID = RandomInt(0, aVec.len() - 1);

			if (GetChande(iRandomChance))
			{
				// printl("Random");
				cp01_quest_01.Init(aVec[ID]);
				return;
			}

			local temp;
			local iSaveIndex = ID;
			local fDistance = iNearRadiusHuman;

			if (ZOMBIE_OWNERS.len() > 0)
			{
				local ZombieArray = ZOMBIE_OWNERS.slice();

				foreach (index0, value0 in ZombieArray)
				{
					ZombieArray[index0] = value0.handle.GetOrigin();
					foreach (index1, value1 in aVec)
					{
						temp = GetDistance3D(ZombieArray[index0], value1);
						if (temp < fDistance)
						{
							fDistance = temp;
							iSaveIndex = index1;
						}
					}
				}
				// printl("Near ZM " + fDistance);

				if (fDistance < iNearRadiusZombie)
				{
					// printl("iNearRadiusZombie");
					cp01_quest_01.Init(aVec[iSaveIndex]);
					return;
				}
			}

			local HumanArray = HUMAN_OWNERS.slice();
			iSaveIndex = ID;
			fDistance = iNearRadiusHuman;

			foreach (index0, value0 in HumanArray)
			{
				HumanArray[index0] = value0.handle.GetOrigin();
				foreach (index1, value1 in aVec)
				{
					temp = GetDistance3D(HumanArray[index0], value1);
					if (temp > fDistance)
					{
						fDistance = temp;
						iSaveIndex = index1;
					}
				}
			}
			// printl("Near KT " + fDistance);
			if (fDistance >= iNearRadiusHuman)
			{
				// printl("iNearRadiusHuman");
				cp01_quest_01.Init(aVec[iSaveIndex]);
				return;
			}
			// printl("Random2");
			cp01_quest_01.Init(aVec[ID]);
		}

		::Trigger_Quest_01_PickUp <- function()
		{
			EF("loc01_props_lift*", "SetGlowEnabled");
			EF("cp01_quest02_trigger*", "Enable");
			EF("cp01_quest02_prop*", "Enable");
			EF("cp01_quest02_prop*", "SetGlowEnabled");

			EndAllMiniGameByType("cp01_quest01");

			EF("loc01_quest01_trigger*", "Kill");

			PrintChatMessageAll(Enum_TextColor.Award + Translate["text16"]);
		}

		::Trigger_Quest_01_OpenDoor <- function()
		{
			if (activator.GetTeam() != 3)
			{
				return;
			}

			EF(caller, "Disable");

			local Data = {
				gamename = "puzzle00",
				type = "cp01_quest01",
				owner = activator,
				owner_origin = activator.GetOrigin(),
				button = caller,
				door = caller.GetMoveParent(),

				function Lose()
				{
					EF(button, "Enable", "", 3.0);
				}

				function Win()
				{
					EF(button, "Kill");
					EF(door, "FireUser4");
				}
			};

			Create_MiniGame(Data)
		}
	}

	//CP1_QUEST_02
	{
		::TRIGGER_CHAPTER1_TOOLS <- 0;
		::Trigger_Chapter1_Touch_Quest_02 <- function()
		{
			if (TRIGGER_CHAPTER1_TOOLS == 0)
			{
				EF("cp01_quest02_trigger*", "Disable");
				EF("cp01_quest02_prop*", "Disable");
				EF("cp01_quest02_prop*", "SetGlowDisabled");

				EF("loc01_props_lift*", "SetGlowDisabled");

				Trigger_Quest_01_Start();

				TRIGGER_CHAPTER1_TOOLS = 1;

				PrintChatMessageAll(Enum_TextColor.Uncommon + Translate["text17"]);
				return;
			}

			if (TRIGGER_CHAPTER1_TOOLS == 1)
			{
				if (activator == cp01_quest_01.g_hOwner)
				{
					cp01_quest_01.Complete();

					EF("cp01_quest02_trigger*", "Disable");
					EF("cp01_quest02_prop*", "Disable");
					EF("cp01_quest02_prop*", "SetGlowDisabled");
					EF("loc01_props_lift*", "SetGlowDisabled");

					EF("cp01_quest02_trigger*", "Enable", "", 2.0);
					EF("cp01_quest02_prop*", "Enable", "", 2.0);
					EF("cp01_quest02_prop*", "SetGlowEnabled", "", 2.0);
					EF("loc01_props_lift*", "SetGlowEnabled", "", 2.0);

					TRIGGER_CHAPTER1_TOOLS = 2;
				}
				return;
			}

			if (TRIGGER_CHAPTER1_TOOLS == 2)
			{
				EF("cp01_quest02_trigger*", "Disable");
				EF("cp01_quest02_prop*", "Disable");
				EF("cp01_quest02_prop*", "SetGlowDisabled");

				local Data = {
					gamename = "puzzle01",
					type = "cp01_quest02",
					owner = activator,
					owner_origin = activator.GetOrigin(),

					function Lose()
					{
						EF("cp01_quest02_trigger*", "Enable", "", 3.0);
						EF("cp01_quest02_prop*", "Enable", "", 3.0);
						EF("cp01_quest02_prop*", "SetGlowEnabled", "", 3.0);
						DamagePlayer(owner, 50);
					}

					function Draw()
					{
						EF("cp01_quest02_trigger*", "Enable", "", 3.0);
						EF("cp01_quest02_prop*", "Enable", "", 3.0);
						EF("cp01_quest02_prop*", "SetGlowEnabled", "", 3.0);
					}

					function Win()
					{
						Main_Script.Trigger_Chapter1_Enable_Lift();
					}
				};

				Create_MiniGame(Data);
				return;
			}
		}
	}

	::Trigger_Chapter1_Enable_Lift <- function()
	{
		LIFT_INIT = true;
		SetSettings(2);

		EF("loc01_logic_lift_door00*", "Open", "", 1);
		EF("loc01_logic_lift_door02*", "Open", "", 1.5);
		EF("loc01_logic_lift_button00*", "UnLock", "", 1.5);

		EF("loc01_quest00_door*", "SetGlowDisabled");
		EF("loc01_props_lift*", "SetGlowDisabled");

		EF("cp01_quest02_trigger*", "Kill");
		EF("cp01_quest02_prop*", "Kill");
		EF("loc01_logic_lift_glow00*", "SetGlowEnabled");

		PrintChatMessageAll(Enum_TextColor.Award + Translate["text18"]);
	}

	//CP1_LIFT
	{
		LIFT_INIT <- false;
		LIFT_STATUS_CP01 <- Enum_LIFT.Down;

		::Lift_Call_Down_CP01 <- function()
		{
			if (LIFT_STATUS_CP01 != Enum_LIFT.Up)
			{
				return;
			}
			EF("loc01_logic_lift_button0*", "Lock");

			EF("loc01_logic_lift_door01*", "Close");

			EF("loc01_logic_lift_door02*", "Close", "", 0.5);
			EF("loc01_logic_lift_door03*", "Close", "", 3);

			LIFT_STATUS_CP01 = Enum_LIFT.Move_Down;
		}
		::Lift_Call_Up_CP01 <- function()
		{
			if (LIFT_STATUS_CP01 != Enum_LIFT.Down)
			{
				return;
			}
			EF("loc01_logic_lift_button0*", "Lock");

			EF("loc01_logic_lift_door00*", "Close");

			EF("loc01_logic_lift_door02*", "Close", "", 0.5);
			EF("loc01_logic_lift_door03*", "Open", "", 3);

			LIFT_STATUS_CP01 = Enum_LIFT.Move_Up;
		}
		::Lift_Button_CP01 <- function()
		{
			if (LIFT_INIT)
			{
				CallFunction("PlayMusic(2)", 45.0);

				EF("loc01_logic_lift_button00*", "Lock");

				EF("loc01_quest00_door*", "Close", "", 25.0);
				EF("loc01_quest00_door*", "Open", "", 30.0);

				EF("loc01_logic_lift_door00*", "Close", "", 30);
				EF("loc01_logic_lift_door02*", "Close", "", 30.5);
				EF("loc01_logic_lift_door03*", "Open", "", 33);

				EF("loc01_logic_lift_glow00*", "SetGlowDisabled", "", 25);

				LIFT_STATUS_CP01 = Enum_LIFT.Move_Up;

				Portal_Scope.Portal_Init_CH01_Quest04();

				PrintChatMessageAll(Enum_TextColor.Award + Translate["text19"]);
				return;
			}

			if (LIFT_STATUS_CP01 == Enum_LIFT.Down)
			{
				EF("loc01_logic_lift_door00*", "Close");
				EF("loc01_logic_lift_door03*", "Open", "", 3);
				LIFT_STATUS_CP01 = Enum_LIFT.Move_Up;
			}
			else if (LIFT_STATUS_CP01 == Enum_LIFT.Up)
			{
				EF("loc01_logic_lift_door01*", "Close");
				EF("loc01_logic_lift_door03*", "Close", "", 3);
				LIFT_STATUS_CP01 = Enum_LIFT.Move_Down;
			}
			else
			{
				return;
			}

			EF("loc01_logic_lift_door02*", "Close", "", 0.5);
			EF("loc01_logic_lift_button0*", "Lock");
		}
		::Lift_End_Move_CP01 <- function()
		{
			// printl("Lift_End_Move")
			if (LIFT_STATUS_CP01 == Enum_LIFT.Move_Down)
			{
				EF("loc01_logic_lift_door00*", "Open");
				LIFT_STATUS_CP01 = Enum_LIFT.Down;
			}
			else if (LIFT_STATUS_CP01 == Enum_LIFT.Move_Up)
			{
				EF("loc01_logic_lift_door01*", "Open");
				LIFT_STATUS_CP01 = Enum_LIFT.Up;
			}
			else
			{
				return;
			}

			EF("loc01_logic_lift_door02*", "Open", "", 0.5);

			if (LIFT_INIT)
			{
				Spore_Add(90);
				EF("loc01_logic_lift_button0*", "UnLock", "", 8.0);
				EF("loc01_logic_lift_button01*", "Press", "", 8.1);

				EF("loc01_logic_lift_door03*", "SetSpeed", "250", 4.0);

				Trigger_Chapter1_04_pre()
				LIFT_INIT = false;

				EF("loc01_logic_lift_glow00*", "SetGlowColor", "255 0 0");
				EF("loc01_logic_lift_glow00*", "SetGlowEnabled", "", 5.0);
				return;
			}

			EF("loc01_logic_lift_button0*", "UnLock", "", 5.0);
		}
	}

	//CP1_QUEST_03
	{
		::Trigger_Chapter1_04_pre <- function()
		{
			EF("loc01_quest03_trigger00z*", "Enable");
			EF("loc01_quest03_prop00z*", "Enable");
			EF("loc01_quest03_prop00z*", "SetGlowEnabled");
		}

		::Trigger_Chapter1_04 <- function()
		{
			PlayMusic(3);
			EF("loc01_quest03_door00z*", "Open");

			EF("loc01_quest03_button*", "UnLock");
			EF("loc01_quest03_door00a*", "SetGlowEnabled");
			PrintChatMessageAll(Enum_TextColor.Award + Translate["text20"], 1.0);
		}
		::Trigger_Chapter1_05 <- function()
		{
			EF("loc01_quest03_door01_prop*", "SetGlowEnabled");
			EF("loc01_quest03_door01*", "UnLock");

			EF("loc01_quest03_door00a*", "SetGlowDisabled", "", 5.0);

			EF("cp01_wall01*", "Kill");

			CH01_QUEST4_INIT = true;
			PrintChatMessageAll(Enum_TextColor.Award + Translate["text21"]);
		}

		::Trigger_Chapter1_055 <- function()
		{
			if (iChapter != 1)
			{
				return;
			}

			EF("loc01_props_roof*", "SetGlowEnabled");
			EF("loc01_quest03_door01*", "Lock");
			EF("cp01_quest04_button*", "UnLock");

			PrintChatMessageAll(Enum_TextColor.Award + Translate["text22"] 2.0);
			PrintChatMessageAll(Enum_TextColor.Award + Translate["text23"], 5.0);
			PrintChatMessageAll(Enum_TextColor.Award + Translate["text24"], 8.0);
		}
	}
	//CP1_QUEST_04
	{
		::CH01_QUEST4_INIT <- false;
		::Trigger_Chapter1_06 <- function()
		{
			if (activator.GetTeam() != 3)
			{
				return;
			}

			EF(caller, "Lock");

			if (CH01_QUEST4_INIT)
			{
				Portal_Scope.Portal_Maker_CH01b();

				EF("loc01_quest03_door01_prop*", "SetGlowColor", "255 0 0");
				EF("loc01_quest03_door02_prop*", "SetGlowEnabled");
				EF("loc01_quest03_door02*", "Open");

				CH01_QUEST4_INIT = false;
			}

			local Data = {
				gamename = "puzzle02",
				type = "cp01_quest04",
				owner = activator,
				owner_origin = activator.GetOrigin(),
				button = caller,

				function Lose()
				{
					EF(button, "UnLock", "", 3.0);
				}

				function Draw()
				{
					Main_Script.Trigger_Chapter1_07a();
				}

				function Win()
				{
					Main_Script.Trigger_Chapter1_07b();
				}
			};

			Create_MiniGame(Data);
		}

		::Trigger_Chapter1_07a <- function()
		{
			CallFunction("Trigger_Chapter1_07()", 5.0);
			PrintChatMessageAll(Enum_TextColor.Award + Translate["text25"]);
		}

		::Trigger_Chapter1_07b <- function()
		{
			CallFunction("Trigger_Chapter1_07()", 10.0);
			PrintChatMessageAll(Enum_TextColor.Award + Translate["text25"]);
		}

		END_TRIGGERD <- false;
		END_ZOMBIE_INSIDE <- false;
		::Trigger_Chapter1_07 <- function()
		{
			END_ZOMBIE_INSIDE = false;
			END_TRIGGERD = false;

			EF("cp01_quest04_button*", "Kill");
			EF("loc01_props_roof*", "SetGlowDisabled");

			EF("loc01_quest03_door02_prop*", "SetGlowDisabled", "", 5.0);
			EF("loc01_quest03_door02*", "Close", "", 5.0);

			EF("loc01_quest03_door01*", "UnLock", "", 5.0);
			EF("loc01_quest03_door01_prop*", "SetGlowDisabled", "", 5.0);
			EF("loc01_logic_lift_glow00*", "SetGlowDisabled", "", 5.0);
			EF("loc01_quest03_door01*", "Close", "", 5.0);
			EF("loc01_quest03_door01*", "Lock", "", 5.0);

			EF("cp01_quest04_trigger*", "Enable", "", 5.0);

			CallFunction("Trigger_Chapter1_08()", 5.05);
		}

		Trigger_Chapter1_08_I <- function()
		{
			END_ZOMBIE_INSIDE = true;
		}

		Trigger_Chapter1_08_O <- function()
		{
			EF(caller, "Kill");

			END_ZOMBIE_INSIDE = false;

			Trigger_Chapter1_08();
		}

		::Trigger_Chapter1_08 <- function()
		{
			if (END_ZOMBIE_INSIDE ||
			END_TRIGGERD)
			{
				return;
			}

			SPORE_INDIVIDUAL_PLAYERS.clear();
			local bAlive = false;
			foreach (player in PLAYERS)
			{
				if (!TargetValid(player))
				{
					continue;
				}
				if (player.GetTeam() != 3 ||
				player.GetHealth() < 1)
				{
					continue;
				}

				if (!IsVectorInBoundingBox(player.GetOrigin(), Vector(1920, -131, 1977), Vector(1152, 900, 290)))
				{
					Individual_Spore(player);
					continue;
				}

				bAlive = true;
			}

			if (!bAlive)
			{
				return;
			}

			END_TRIGGERD = true;
			iChapter = 2;
			SetSettings(3);

			EF("cp01_quest04_trigger*", "Kill");

			CallFunction("Human_Glow_Disabled()", 0);
			CallFunction("bFade = true;", 0);
			EF("map_entity_fade_end_chapter_in", "Fade", "", 0.0);
			EF("map_entity_fade_end_chapter_out", "Fade", "", 3.5);
			CallFunction("StartOverLay(\"overlay/c2\", 7.0);", 3.5);
			CallFunction("Text_CP2()", 10.5);

			EF("cp02_quest00_prop01*", "SetGlowEnabled", "", 11);

			CallFunction("bFade = false;", 8.5);
			CallFunction("Human_Glow_Enabled()", 15);

			StopMusic();
			EF("map_music_chapter_complete", "FireUser1", "", 1.0);
			CallFunction("PlayMusic(4)", 2.5);

			CallFunction("Trigger_Chapter1_09()", 5.0);
			PrintChatMessageAll(Enum_TextColor.Gold + Translate["missioncomplete"]);


			PrintChatMessageAll(Enum_TextColor.Award + Translate["text01"], 11);
			PrintChatMessageAll(Enum_TextColor.Award + Translate["text02"], 13.0);
			PrintChatMessageAll(Enum_TextColor.Award + Translate["text03"], 15.0);
			PrintChatMessageAll(Enum_TextColor.Award + Translate["text04"], 17.0);
			PrintChatMessageAll(Enum_TextColor.Award + Translate["text05"], 19.0);

			Chapter_End();
		}

		::Trigger_Chapter1_09 <- function()
		{
			Spore_Start(300);

			EF("loc01_quest03_door01*", "UnLock");
			EF("loc01_quest03_door01*", "Open");
			EF("loc01_quest03_door01*", "Lock");

			EF("loc01_quest03_door02*", "Open");

			EF("cp02", "ForceSpawn");
			Spawn_Location02();

			Portal_Scope.Portal_Init_CH02();
			Portal_Scope.Portal_Init_CH01_CH02();
			Portal_Scope.Portal_Init_CH02_Quest01();
			Portal_Scope.ZombieToTeleport();
		}
	}

	//CP2_QUEST
	{
		::Location02_Spawn_MedKits <- function()
		{
			local aVec = [
				class_pos(Vector(-13, -2611, -641), Vector(0, 105, 0)),
				class_pos(Vector(603, -1585, -862.687), Vector(-90, 270, 0)),
				class_pos(Vector(4705, -2399, -1209), Vector(0, 180, 0)),
			];

			AOP(Entity_Maker, "EntityTemplate", "item_heal");
			foreach (vec in aVec)
			{
				Entity_Maker.SpawnEntityAtLocation(vec.origin, vec.angles);
			}
		}

		::Trigger_Chapter2_01 <- function()
		{
			DISABLE_ABILITY = false;

			EF("instanceauto1-skybox_env", "Stop");
			EF("instanceauto1-skybox_env", "Start");

			EF("cp02_quest00_trigger01", "RunScriptcode", "Destroy()", 40);

			EF("cp02_quest00_prop01*", "Kill", "", 38);
			EF("cp02_quest00_trigger02", "Enable");

			EF("cp02_quest00_prop02*", "Enable");
			EF("cp02_quest00_prop02*", "SetGlowEnabled");

			EF("cp02_quest04_prop*", "Enable");
			EF("cp02_quest04_prop*", "SetGlowEnabled");

			Portal_Scope.Portal_Maker_CH02a();
		}
		::Trigger_Chapter2_02 <- function()
		{
			EF("cp02_quest00_prop02*", "Kill", "", 3);

			EF("cp02_quest01_trigger*", "Enable");

			EF("cp02_quest00_prop03*", "Enable");
			EF("cp02_quest00_prop03*", "SetGlowEnabled");

			Portal_Scope.Portal_Maker_CH02b();
			Portal_Scope.Portal_PostInitCH02();
		}
		::Trigger_Chapter2_03 <- function()
		{
			EF("loc01_props_metro*", "SetGlowEnabled");

			EF("cp02_quest00_prop03*", "Kill", "", 3);

			EF("cp02_quest01_button00*", "UnLock", "", 1.0);

		}

		::Trigger_Chapter2_Press_Quest_01 <- function()
		{
			if (activator.GetTeam() != 3)
			{
				return;
			}

			EF("cp02_quest01_button00*", "Lock");

			local Data = {
				gamename = "puzzle01",
				type = "cp02_quest01",
				owner = activator,
				owner_origin = activator.GetOrigin(),

				function Lose()
				{
					EF("cp02_quest01_button00*", "UnLock", "", 3.0);
					DamagePlayer(owner, 50);
				}

				function Draw()
				{
					EF("cp02_quest01_button00*", "UnLock", "", 3.0);
				}

				function Win()
				{
					// EF("cp02_quest01_button00", "Kill");
					Main_Script.Trigger_Chapter2_03a();
				}
			};

			Create_MiniGame(Data);
		}

		::Trigger_Chapter2_03a <- function()
		{
			EF("cp02_quest01_button00*", "Kill");
			EF("loc01_props_metro*", "SetGlowDisabled");
			cp02_quest_01.Enable_Lift();
		}

		::Trigger_Chapter2_03b <- function()
		{
			EF("cp02_quest02_prop00*", "Enable");
			EF("cp02_quest02_prop00*", "SetGlowEnabled");

			EF("cp02_quest03_trigger*", "Enable");

			EF("loc02_quest02_trigger00*", "Enable");
			EF("loc02_quest02_prop*", "Enable");
			EF("loc02_quest02_prop*", "SetGlowEnabled");

			EF("cp02_quest01_button01*", "UnLock");
			EF("loc02_props_metro1*", "SetGlowEnabled");
		}

		::Trigger_Chapter2_Press_Quest_02 <- function()
		{
			if (activator.GetTeam() != 3)
			{
				return;
			}

			EF("cp02_quest01_button01*", "Lock");

			local Data = {
				gamename = "puzzle01",
				type = "cp02_quest01",
				owner = activator,
				owner_origin = activator.GetOrigin(),

				function Lose()
				{
					EF("cp02_quest01_button01*", "UnLock", "", 3.0);
					DamagePlayer(owner, 50);
				}

				function Draw()
				{
					EF("cp02_quest01_button01*", "UnLock", "", 3.0);
				}

				function Win()
				{
					// EF("cp02_quest01_button00", "Kill");
					Main_Script.Trigger_Chapter2_04();
				}
			};

			Create_MiniGame(Data);
		}

		::Trigger_Chapter2_04 <- function()
		{
			EF("loc01_quest02_door*", "Open");
			EF("cp02_quest01_button01*", "Kill");
			EF("loc02_props_metro1*", "SetGlowDisabled");

			EF("cp02_quest03_trigger01*", "Kill");

			HO_Disable_Stealth_Zone(0);
			cp02_quest_01.UnLimit();
		}

		::Trigger_Chapter2_05 <- function()
		{
			Spore_Add(90);
			EF("cp02_quest02_prop00*", "Kill", "", 3);

			PlayMusic(5);
			PrintChatMessageAll(Enum_TextColor.Uncommon + Translate["text31"]);
			PrintChatMessageAll(Enum_TextColor.Uncommon + Translate["text32"], 2.0);
			Trigger_Quest_01_CP02_Start();
		}

		::Trigger_Quest_01_CP02_Start <- function()
		{
			local aVec = [
				Vector(344, -3367, -867),
				Vector(447, -3355, -591),
				Vector(-131, -3304, -591),
				Vector(-1055, -2615, -591),
				Vector(-336, -1116, -847),
				Vector(380, -1267, -591),
				Vector(-279, -1488, -847),
			];

			local iRandomChance = 20;
			local iNearRadiusZombie = 512;

			EF("loc02_quest03_trigger*", "Enable");
			EF("loc02_quest03_prop*", "Enable");
			EF("loc02_quest03_prop*", "SetGlowEnabled");

			local ID = RandomInt(0, aVec.len() - 1);

			if (GetChande(iRandomChance))
			{
				// printl("Random");
				cp02_quest_03.Init(aVec[ID]);
				return;
			}

			local temp;
			local iSaveIndex = ID;
			local fDistance = 9999;

			if (ZOMBIE_OWNERS.len() > 0)
			{
				local ZombieArray = ZOMBIE_OWNERS.slice();

				foreach (index0, value0 in ZombieArray)
				{
					ZombieArray[index0] = value0.handle.GetOrigin();
					foreach (index1, value1 in aVec)
					{
						temp = GetDistance3D(ZombieArray[index0], value1);
						if (temp < fDistance)
						{
							fDistance = temp;
							iSaveIndex = index1;
						}
					}
				}
				// printl("Near ZM " + fDistance);

				if (fDistance < iNearRadiusZombie)
				{
					// printl("iNearRadiusZombie");
					cp02_quest_03.Init(aVec[iSaveIndex]);
					return;
				}
			}
			// printl("Random2");
			cp02_quest_03.Init(aVec[ID]);
		}

		::Trigger_Quest_01_CP02_PickUp <- function()
		{
			EF("cp02_quest04_trigger*", "Enable");

			EndAllMiniGameByType("cp01_quest01");

			EF("loc02_quest03_trigger*", "Kill");

			EF("cp02_quest03_sound*", "PlaySound");
			EF("cp02_quest03_sound*", "Kill", "", 10);

			PrintChatMessageAll(Enum_TextColor.Award + Translate["text41"]);
			PrintChatMessageAll(Enum_TextColor.Award + Translate["text42"], 15.0);
			CH02_QUEST3_INIT = true;
		}
		::CH02_QUEST3_INIT <- false;

		::Trigger_Chapter2_06_0 <- function()
		{
			if (!Trigger_Chapter2_06(activator))
			{
				return;
			}
			EF("loc00_logic_doors00*", "Open");
		}
		::Trigger_Chapter2_06_1 <- function()
		{
			if (!Trigger_Chapter2_06(activator))
			{
				return;
			}
			EF("loc00_logic_doors01*", "Open");
		}

		::Trigger_Chapter2_06 <- function(activator)
		{
			if (!CH02_QUEST3_INIT)
			{
				return false;
			}
			if (activator != cp02_quest_03.g_hOwner)
			{
				return false;
			}

			PrintChatMessageAll(Enum_TextColor.Award + Translate["text33"], 12.0);

			PlayMusic(6);

			cp02_quest_03.Complete();

			EF("cp02_quest04_prop*", "Kill");
			EF("cp02_quest04_trigger*", "Kill");

			Spawn_Location03();

			EF("cp02_quest05_trigger*", "Enable");
			EF("loc03_quest00_door0*", "Open");
			EF("loc03_quest00_door00_prop*", "SetGlowEnabled");

			CH02_QUEST3_INIT = false;

			return true;
		}
		::Trigger_Chapter2_07 <- function()
		{
			END_TRIGGERD = false;
			END_ZOMBIE_INSIDE = false;

			EF("loc00_logic_doors*", "Close");

			EF("loc03_quest00_door00_prop*", "SetGlowDisabled", "", 15);
			EF("loc03_quest00_door0*", "Close", "", 19);

			EF("cp02_quest05_trigger_zm*", "Enable", "", 20);
			CallFunction("Trigger_Chapter2_08()", 20.05);

			PrintChatMessageAll(Enum_TextColor.Award + Translate["text34"]);
		}

		Trigger_Chapter2_08_I <- function()
		{
			END_ZOMBIE_INSIDE = true;
		}

		Trigger_Chapter2_08_O <- function()
		{
			EF(caller, "Kill");

			END_ZOMBIE_INSIDE = false;

			Trigger_Chapter2_08();
		}

		::Trigger_Chapter2_08 <- function()
		{
			if (END_ZOMBIE_INSIDE ||
			END_TRIGGERD)
			{
				return;
			}

			SPORE_INDIVIDUAL_PLAYERS.clear();
			local bAlive = false;
			foreach (player in PLAYERS)
			{
				if (!TargetValid(player))
				{
					continue;
				}
				if (player.GetTeam() != 3 ||
				player.GetHealth() < 1)
				{
					continue;
				}

				if (!IsVectorInBoundingBox(player.GetOrigin(), Vector(6774, 981, -24), Vector(267.5, 365, 160)))
				{
					Individual_Spore(player);
					continue;
				}

				bAlive = true;
			}

			if (!bAlive)
			{
				return;
			}
			END_TRIGGERD = true;

			iChapter = 3;
			SetSettings(4);

			EF("loc00_logic_doors0*", "SetSpeed", "200");
			EF("loc00_logic_doors0*", "Close");

			CallFunction("Human_Glow_Disabled()", 0);
			CallFunction("bFade = true;", 0);
			EF("map_entity_fade_end_chapter_in", "Fade", "", 0.0);
			EF("map_entity_fade_end_chapter_out", "Fade", "", 3.5);

			StopMusic();
			EF("map_music_chapter_complete", "FireUser1", "", 1.0);
			CallFunction("PlayMusic(7)", 2.5);
			CallFunction("StartOverLay(\"overlay/c3\", 7.0);", 3.5);
			CallFunction("Text_CP3()", 10.5);
			CallFunction("bFade = false;", 8.5);
			CallFunction("Human_Glow_Enabled()", 15.0);

			CallFunction("Trigger_Chapter2_09()", 5.0);

			PrintChatMessageAll(Enum_TextColor.Gold + Translate["missioncomplete"]);
			Chapter_End();
		}
		::Trigger_Chapter2_09 <- function()
		{
			Spore_Start(300);

			EF("cp01_*", "Kill");
			EF("cp02_*", "Kill");

			EF("loc01_*", "Kill");
			EF("loc02_*", "Kill");
			/*
				уничтожение ентитей с прошлых лок
			*/

			Portal_Scope.Portal_Init_CH03();
			Portal_Scope.Portal_InitCH02_CH03();
			Portal_Scope.ZombieToTeleport();

			EF("cp03", "ForceSpawn");

			PrintChatMessageAll(Enum_TextColor.Award + Translate["text06"], 5);
			CallFunction("Trigger_Chapter3_01()", 10);
			RemoveMedKitAtBoundBox(Vector(110, -1184, 922 ), Vector(5552, 3911, 1974));
		}
	}


	//CP3_QUEST
	{
		::Location03_Spawn_MedKits <- function()
		{
			local aVec = [
				class_pos(Vector(8417, -3560, -154), Vector(0, 210, 0)),
				class_pos(Vector(6895, 874, -139), Vector(0, 135, 0)),
			];

			AOP(Entity_Maker, "EntityTemplate", "item_heal");
			foreach (vec in aVec)
			{
				Entity_Maker.SpawnEntityAtLocation(vec.origin, vec.angles);
			}
		}

		LIFT_STATUS_CP03 <- Enum_LIFT.Down;
		LIFT_INIT_CP03 <- true;

		::Lift_Call_Down_CP03 <- function()
		{
			if (LIFT_INIT_CP03)
			{
				if (activator.GetTeam() != 3)
				{
					return;
				}
				LIFT_INIT_CP03 = false;
			}

			if (LIFT_STATUS_CP03 != Enum_LIFT.Up)
			{
				return;
			}
			EF("loc03_logic_lift_button0*", "Lock");

			EF("loc03_logic_lift_door01*", "Close");

			EF("loc03_logic_lift_door02*", "Close", "", 0.5);
			EF("loc03_logic_lift_door03*", "Close", "", 3);

			LIFT_STATUS_CP03 = Enum_LIFT.Move_Down;
		}
		::Lift_Call_Up_CP03 <- function()
		{
			if (LIFT_INIT_CP03)
			{
				if (activator.GetTeam() != 3)
				{
					return;
				}
				LIFT_INIT_CP03 = false;
			}
			if (LIFT_STATUS_CP03 != Enum_LIFT.Down)
			{
				return;
			}
			EF("loc03_logic_lift_button0*", "Lock");

			EF("loc03_logic_lift_door00*", "Close");

			EF("loc03_logic_lift_door02*", "Close", "", 0.5);
			EF("loc03_logic_lift_door03*", "Open", "", 3);

			LIFT_STATUS_CP03 = Enum_LIFT.Move_Up;

		}
		::Lift_Button_CP03 <- function()
		{
			if (LIFT_INIT_CP03)
			{
				if (activator.GetTeam() != 3)
				{
					return;
				}
				LIFT_INIT_CP03 = false;
			}
			if (LIFT_STATUS_CP03 == Enum_LIFT.Down)
			{
				EF("loc03_logic_lift_door00*", "Close");
				EF("loc03_logic_lift_door03*", "Open", "", 3);
				LIFT_STATUS_CP03 = Enum_LIFT.Move_Up;
			}
			else if (LIFT_STATUS_CP03 == Enum_LIFT.Up)
			{
				EF("loc03_logic_lift_door01*", "Close");
				EF("loc03_logic_lift_door03*", "Close", "", 3);
				LIFT_STATUS_CP03 = Enum_LIFT.Move_Down;
			}
			else
			{
				return;
			}

			EF("loc03_logic_lift_door02*", "Close", "", 0.5);
			EF("loc03_logic_lift_button0*", "Lock");
		}
		::Lift_End_Move_CP03 <- function()
		{
			// printl("Lift_End_Move")

			if (LIFT_STATUS_CP03 == Enum_LIFT.Move_Down)
			{
				EF("loc03_logic_lift_door00*", "Open");
				LIFT_STATUS_CP03 = Enum_LIFT.Down;
			}
			else if (LIFT_STATUS_CP03 == Enum_LIFT.Move_Up)
			{
				EF("loc03_logic_lift_door01*", "Open");
				LIFT_STATUS_CP03 = Enum_LIFT.Up;
			}
			else
			{
				return;
			}
			EF("loc03_logic_lift_door02*", "Open", "", 0.5);

			EF("loc03_logic_lift_button0*", "UnLock", "", 5.0);
		}

		::Trigger_Chapter3_01 <- function()
		{
			Portal_Scope.ZombieToTeleportRadius(Vector(7112, 666, -70), 1750);
			DISABLE_ABILITY = false;

			EF("instanceauto1-skybox_env", "Stop");
			EF("instanceauto1-skybox_env", "Start");

			LIMIT_CLASS_TANK = 2;
			EF("loc03_quest00_door0*", "Open");
			Portal_Scope.Portal_Maker_CH03a();

			Trigger_Quest_01_CP03_Start();
			PrintChatMessageAll(Enum_TextColor.Uncommon + Translate["text35"]);
			PrintChatMessageAll(Enum_TextColor.Uncommon + Translate["text36"], 2.5);
		}

		::Trigger_Quest_01_CP03_Start <- function()
		{
			local aVec = [
				Vector(8806, -3769, -191),
				Vector(10944, 713, -192),
				Vector(9920, -365, -183),
				Vector(10481, -3111, -183),
				Vector(9076, -2761, -183),
				Vector(8312, -2374, -183),
				Vector(6153, -4802, -127),
				Vector(6758, -5456, 752),
				Vector(7299, -3004, -191),
				Vector(6131, -1423, -191),
			];

			LIFT_STATUS_CP03 <- Enum_LIFT.Down;

			EF("loc03_logic_lift_door00*", "Open", "", 1);
			EF("loc03_logic_lift_door02*", "Open", "", 1.5);
			EF("loc03_logic_lift_button0*", "UnLock", "", 1.5);

			EF("cp03_quest01_prop*", "Enable");
			EF("cp03_quest01_prop*", "SetGlowEnabled");

			EF("loc03_quest01_prop*", "Enable");
			EF("loc03_quest01_prop*", "SetGlowEnabled");
			EF("loc03_quest01_trigger00*", "Enable");

			EF("cp03_quest01_trigger*", "Enable");

			local aPush = [];
			local ID;

			for (local i = 0; i < 4; i++)
			{
				ID = RandomInt(0, aVec.len() - 1);

				aPush.push(aVec[ID]);
				aVec.remove(ID);
			}
			cp03_quest_01.Init(aPush);
		}

		::Trigger_Chapter3_02 <- function()
		{
			EF("loc03_quest00_door00_prop*", "SetGlowEnabled");
			EF("loc03_quest00_door0*", "Close", "", 29);
			EF("loc03_quest00_door00_prop*", "SetGlowDisabled", "", 25);

			EF("cp03_quest02_effect00*", "Start", "", 26.0);
			EF("cp03_quest02_effect01*", "Start", "", 30.0);
			CallFunction("Trigger_Chapter3_03()", 30);

			CallFunction("StopMusic()", 22);

			EF("cp03_quest02_sound00*", "PlaySound", "", 31);
			EF("cp03_quest02_sound00*", "Kill", "", 60);

			PrintChatMessageAll(Enum_TextColor.Award + Translate["text37"]);
		}

		::Trigger_Chapter3_03 <- function()
		{
			local bAlive = false;
			foreach (player in PLAYERS)
			{
				if (!TargetValid(player))
				{
					continue;
				}
				if (player.GetHealth() < 1)
				{
					continue;
				}

				if (player.GetTeam() != 3)
				{
					if (!IsVectorInBoundingBox(player.GetOrigin(), Vector(6774, 981, -24), Vector(267.5, 365, 160)))
					{
						continue;
					}
					CreatePortalPickerClass(player);
				}
				else
				{
					if (!IsVectorInBoundingBox(player.GetOrigin(), Vector(6774, 981, -24), Vector(267.5, 365, 160)))
					{
						EF(player, "SetHealth", "0");
						continue;
					}
					bAlive = true;
				}
			}

			if (!bAlive)
			{
				return;
			}

			EF("cp03_quest02_hitbox0*", "SetParentAttachment", "SosiskaAttach");
			EF("cp03_quest02_prop0*", "Enable");

			CUT_SCENE_DATA = [
				{
					o1 = Vector(7853, 200, 816),
					a1 = Vector(25, -96, 0),
					time1 = 0.0,
					o2 = Vector(8095, -524, 235),
					a2 = Vector(3, -15, 0),
					time2 = 0.5,
					flytime = 3.5,
				},{
					o1 = Vector(8939, -4804, 64),
					a1 = Vector(-8, 79, 0),
					time1 = 0.0,
					o2 = Vector(9313, -3063, 540),
					a2 = Vector(38, -67, 0),
					time2 = 0.5,
					flytime = 3.5,
				},{
					o1 = Vector(7707, -2809, 134),
					a1 = Vector(7, -177, 0),
					time1 = 0.0,
					o2 = Vector(6666, -3463, 54),
					a2 = Vector(2, 138, 0),
					time2 = 0.5,
					flytime = 3.5,
				}
			];

			EF("cp03_quest02_prop00*", "SetAnimation", "Rise", 1.0);
			EF("cp03_quest02_prop01*", "SetAnimation", "Rise", 5.0);

			EF("cp03_quest02_prop02*", "SetAnimation", "Rise", 9.0);
			EF("cp03_quest02_effect02*", "Start", "", 4.0);

			EF("cp03_quest02_prop0*", "SetDefaultAnimation", "idle");

			CallFunction("StartCutScene()", 1.0);

			CallFunction("Trigger_Chapter3_04()", 14);
		}

		CH03_QUEST2_TICKING <- false;
		CH03_QUEST2_BACK_HP <- 100;
		CH03_QUEST2_HP_MAX <- 0;

		CH03_QUEST2_00_TIME <- 0;
		CH03_QUEST2_01_TIME <- 0;
		CH03_QUEST2_02_TIME <- 0;
		CH03_QUEST2_00_HP <- CH03_QUEST2_BACK_HP;
		CH03_QUEST2_01_HP <- CH03_QUEST2_BACK_HP;
		CH03_QUEST2_02_HP <- CH03_QUEST2_BACK_HP;
		::Trigger_Chapter3_04 <- function()
		{
			CH03_QUEST2_TICKING = true;
			Portal_Scope.ZombieToTeleport();
			Spore_Add(100);

			CH03_QUEST2_HP_MAX = HUMAN_OWNERS.len() * CH03_QUEST2_BACK_HP;
			CH03_QUEST2_00_HP = CH03_QUEST2_HP_MAX;
			CH03_QUEST2_01_HP = CH03_QUEST2_HP_MAX;
			CH03_QUEST2_02_HP = CH03_QUEST2_HP_MAX;

			EF("loc03_quest00_door0*", "Open", "", 2);


			EF("cp03_quest02_sound01*", "PlaySound");
			EF("cp03_quest02_sound01*", "Kill", "", 10);

			CallFunction("PlayMusic(8)", 2.5);
			PrintChatMessageAll(Enum_TextColor.Red + Translate["text38"]);
		}
		::Hook_Damage_Worm_Chapter3 <- function()
		{
			if (!CH03_QUEST2_TICKING)
			{
				return;
			}
			local ID = caller.GetPreTemplateName().slice(caller.GetPreTemplateName().len() - 1).tointeger();
			if (ID == 0)
			{
				CH03_QUEST2_00_HP--;
				if (CH03_QUEST2_00_HP <= 0)
				{
					caller.Destroy();
					EF("cp03_quest02_prop0" + ID + "*", "SetAnimation", "Rise_down", 1.0);
					EF("cp03_quest02_prop0" + ID + "*", "FadeAndKill", "", 5.0);
					EF("cp03_quest02_effect0" + ID + "*", "Stop");
				}
				else if (Time() > CH03_QUEST2_00_TIME)
				{
					CH03_QUEST2_00_TIME = Time() + 0.25;
					EF("cp03_quest02_prop0" + ID + "*", "AddOutPut", "rendercolor 200 150 150");
					EF("cp03_quest02_prop0" + ID + "*", "AddOutPut", "rendercolor 255 255 255", 0.15);
				}
			}
			else if (ID == 1)
			{
				CH03_QUEST2_01_HP--;
				if (CH03_QUEST2_01_HP <= 0)
				{
					caller.Destroy();
					EF("cp03_quest02_prop0" + ID + "*", "SetAnimation", "Rise_down", 1.0);
					EF("cp03_quest02_prop0" + ID + "*", "FadeAndKill", "", 5.0);
					EF("cp03_quest02_effect0" + ID + "*", "Stop");
				}
				else if (Time() > CH03_QUEST2_01_TIME)
				{
					CH03_QUEST2_01_TIME = Time() + 0.25;
					EF("cp03_quest02_prop0" + ID + "*", "AddOutPut", "rendercolor 200 150 150");
					EF("cp03_quest02_prop0" + ID + "*", "AddOutPut", "rendercolor 255 255 255", 0.15);
				}
			}
			else if (ID == 2)
			{
				CH03_QUEST2_02_HP--;
				if (CH03_QUEST2_02_HP <= 0)
				{
					caller.Destroy();
					EF("cp03_quest02_prop0" + ID + "*", "SetAnimation", "Rise_down", 1.0);
					EF("cp03_quest02_prop0" + ID + "*", "FadeAndKill", "", 5.0);
					EF("cp03_quest02_effect0" + ID + "*", "Stop");
				}
				else if (Time() > CH03_QUEST2_02_TIME)
				{
					CH03_QUEST2_02_TIME = Time() + 0.25;
					EF("cp03_quest02_prop0" + ID + "*", "AddOutPut", "rendercolor 200 150 150");
					EF("cp03_quest02_prop0" + ID + "*", "AddOutPut", "rendercolor 255 255 255", 0.15);
				}
			}

			if (CH03_QUEST2_00_HP <= 0 &&
			CH03_QUEST2_01_HP <= 0 &&
			CH03_QUEST2_02_HP <= 0)
			{
				Trigger_Chapter3_05();
			}
		}
		::Trigger_Chapter3_05 <- function()
		{
			CH03_QUEST2_TICKING = false;
			EF("cp03_quest03_trigger*", "Enable", "", 2);
			EF("loc03_quest00_door00_prop*", "SetGlowEnabled");

			PrintChatMessageAll(Enum_TextColor.Award + Translate["text39"]);
			PrintChatMessageAll(Enum_TextColor.Award + Translate["text40"], 2);
		}

		::Trigger_Chapter3_06 <- function()
		{
			Spore_Add(50);
			END_ZOMBIE_INSIDE = false;

			EF("loc03_quest00_door00_prop*", "SetGlowDisabled", "", 15);
			EF("loc03_quest00_door0*", "Close", "", 19);

			EF("cp03_quest04_trigger_zm*", "Enable", "", 20);
			CallFunction("Trigger_Chapter3_07()", 20.05);
			CallFunction("StopMusic()", 12.00);
		}

		::Trigger_Chapter3_07_I <- function()
		{
			END_ZOMBIE_INSIDE = true;
		}

		::Trigger_Chapter3_07_O <- function()
		{
			EF(caller, "Kill");

			END_ZOMBIE_INSIDE = false;

			Trigger_Chapter3_07();
		}

		::Trigger_Chapter3_07 <- function()
		{
			if (END_ZOMBIE_INSIDE)
			{
				return;
			}

			local bAlive = false;
			foreach (player in PLAYERS)
			{
				if (!TargetValid(player))
				{
					continue;
				}
				if (player.GetTeam() != 3 ||
				player.GetHealth() < 1)
				{
					continue;
				}

				if (!IsVectorInBoundingBox(player.GetOrigin(), Vector(6774, 981, -24), Vector(267.5, 365, 160)))
				{
					EF(player, "SetHealth", "0");
					continue;
				}

				bAlive = true;
			}

			if (!bAlive)
			{
				return;
			}
			iChapter = 1;


			CUT_SCENE_DATA = [
				{
					o1 = Vector(7013, 888, -134),
					a1 = Vector(60, 0, 0),
					time1 = 3.10,
					o2 = Vector(6893, 1067, -58),
					a2 = Vector(23, -58, 0),
					time2 = 0.10,
					flytime = 8.00,
				},
			]
			CallFunction("Human_Glow_Disabled()");
			EF("cp03_quest05_effect*",  "ShowSprite");
			EF("cp03_quest05_sound*",  "PlaySound");
			EF("cp03_quest05_sound*",  "StopSound", "", 8.5);

			EF("map_entity_fade_end_chapter_out", "Fade");
			EF("map_entity_fade_end_chapter_in", "Fade", "", 8.0);

			CallFunction("StartCutScene()", 0.1);


			CallFunction("bFade = true;", 0);
			CallFunction("bFade = false;", 12);

			EF("map_music_chapter_complete", "FireUser1", "", 11.5);
			CallFunction("Human_Glow_Enabled()", 12);
			EF("game_round_end", "EndRound_CounterTerroristsWin", "5.0", 12.0);

			PrintChatMessageAll(Enum_TextColor.Gold + Translate["missioncomplete"], 10.0);

			Chapter_End();
		}
	}
}
// Spore
{
	const SPORE_TICKRATE = 1.00;
	::SPORE_TICKRATES <- 0;

	::SPORE_TICKING <- false;
	::SPORE_TIME <- 0.0;
	::SPORE_TIME_MAX <- 0.0;
	::SPORE_END <- false;

	::Spore_Start <- function(_time)
	{
		SPORE_TICKING = true;
		SPORE_END = false;

		SPORE_TIME = _time;
		SPORE_TIME_MAX = _time;
	}

	::Spore_Add <- function(_time)
	{
		if (SPORE_TIME <= 0)
		{
			Spore_Start(_time);
			return;
		}
		SPORE_TIME += _time;

		if (SPORE_TIME_MAX < SPORE_TIME)
		{
			SPORE_TIME_MAX = SPORE_TIME;
		}
	}

	::SPORE_INDIVIDUAL_PLAYERS <- [];
	::Individual_Spore <- function(player)
	{
		SPORE_INDIVIDUAL_PLAYERS.push(player);
		if (SPORE_INDIVIDUAL_PLAYERS.len() == 1)
		{
			Tick_Individual_Spore();
		}
	}

	::Tick_Individual_Spore <- function()
	{
		local bAlive = false;

		foreach (player in SPORE_INDIVIDUAL_PLAYERS)
		{
			if (!TargetValid(player))
			{
				continue;
			}
			if (player.GetTeam() != 3 ||
			player.GetHealth() < 1)
			{
				continue;
			}

			DamagePlayer(player, 20);
			bAlive = true;
		}

		if (bAlive)
		{
			CallFunction("Tick_Individual_Spore()", SPORE_TICKRATE);
		}
	}

	::Tick_Spore <- function()
	{
		if (Time() < SPORE_TICKRATES)
		{
			return;
		}

		SPORE_TICKRATES = Time() + SPORE_TICKRATE;
		if (!SPORE_TICKING ||
		CUT_SCENE)
		{
			return;
		}

		SPORE_TIME--;
		if (SPORE_TIME <= 0)
		{
			Spore_End();
			return;
		}

		local text_spore = Translate["ct_sporetime"] + " : <font color='#" + GetCOLORHEX(SPORE_TIME, SPORE_TIME_MAX) +"'>" + SPORE_TIME.tointeger() +"</font>";
		if (CH03_QUEST2_TICKING)
		{
			text_spore += "\n\n";
			if (CH03_QUEST2_00_HP > 0)
			{
				text_spore += "Ἄργης : <font color='#" + GetCOLORHEX(CH03_QUEST2_00_HP, CH03_QUEST2_HP_MAX) +"'>" + (CH03_QUEST2_00_HP * 1.0 / CH03_QUEST2_HP_MAX * 100).tointeger() + "</font>% HP\n";
			}
			else
			{
				text_spore +="Ἄργης : <font color='#FF0000'>Dead</font>\n";
			}
			if (CH03_QUEST2_01_HP > 0)
			{
				text_spore += "Βρόντης : <font color='#" + GetCOLORHEX(CH03_QUEST2_01_HP, CH03_QUEST2_HP_MAX) +"'>" + (CH03_QUEST2_01_HP * 1.0 / CH03_QUEST2_HP_MAX * 100).tointeger() + "</font>% HP\n";
			}
			else
			{
				text_spore +="Βρόντης : <font color='#FF0000'>Dead</font>\n";
			}
			if (CH03_QUEST2_02_HP > 0)
			{
				text_spore += "Στερόπης : <font color='#" + GetCOLORHEX(CH03_QUEST2_02_HP, CH03_QUEST2_HP_MAX) +"'>" + (CH03_QUEST2_02_HP * 1.0 / CH03_QUEST2_HP_MAX * 100).tointeger() + "</font>% HP\n";
			}
			else
			{
				text_spore += "Στερόπης : <font color='#FF0000'>Dead</font>\n";
			}
		}
		ScriptPrintMessageCenterAll(text_spore);
	}

	::Spore_End <- function()
	{
		SPORE_END = true;
		SPORE_TICKING = false;
		ScriptPrintMessageCenterAll("");
	}

	::Spore_Stop <- function()
	{
		SPORE_END = false;
		SPORE_TICKING = false;
		ScriptPrintMessageCenterAll("");
	}

	::GetCOLORHEX <- function(iValue, iMax)
	{
		local iProccent = (iValue * 1.0 / iMax * 100).tointeger();

		local iRed = (iProccent > 50) ? ((1 - 2 * (iProccent - 50) / 100.0) * 255).tointeger() : (255);
		local iGreen = (iProccent > 50) ? (255) : ((2 * iProccent / 100.0) * 255).tointeger();
		local iBlue = 0;

		return format("%06X", (((iRed & 0xFF) << 16) | ((iGreen & 0xFF) << 8) | ((iBlue & 0xFF) << 0)));
	}
}


// GAMES
{
	::MINIGAMES <- [];
	::TEMP_GAME_CONNECTOR <- null;

	enum Enum_MiniGame_End
	{
		DRAW,
		WIN,
		LOSE,
	}

	::Enum_MiniGame_End <- CONST.Enum_MiniGame_End;

	::class_minigame <- class
	{
		handle = null;

		handle_origin = Vector();
		type = "";
		minigame = null;
		camera = null;
		cameraslot = null;

		data = null;

		destroy = true;

		constructor(_Data = null)
		{
			this.handle = _Data.owner;
			this.handle_origin = _Data.owner_origin;

			this.camera = _Data.camera;
			this.cameraslot = _Data.cameraslot;
			this.type = _Data.type;

			this.data = _Data;
		}

		function SetScript(_minigame)
		{
			this.minigame = _minigame;
			this.minigame.GetScriptScope().SetOwner(this.handle);
			this.minigame.GetScriptScope().g_vecOrigin = this.handle_origin;
		}

		function GetOrigin()
		{
			return this.handle_origin;
		}

		function GetResult(_result)
		{
			switch (_result)
			{
				case Enum_MiniGame_End.WIN:
				{
					this.data.Win();
					break;
				}
				case Enum_MiniGame_End.LOSE:
				{
					this.data.Lose();
					break;
				}
				case Enum_MiniGame_End.DRAW:
				{
					this.data.Draw();
					break;
				}
			}
		}

		function Destroy()
		{
			camera.Disable();
			cameraslot.ClearSlot();
		}

		function DestroyMiniGame()
		{
			this.Destroy();
			this.minigame.GetScriptScope().Destroy();
		}

		function ForceEnd()
		{
			this.minigame.GetScriptScope().End(Enum_MiniGame_End.LOSE);
		}
	}

	::GetMiniGameClassByMiniGame <- function(_minigame)
	{
		foreach (minigame in MINIGAMES)
		{
			if (_minigame == minigame.minigame)
			{
				return minigame;
			}
		}

		return null;
	}

	::GetMiniGameClassByOwner<- function(owner)
	{
		foreach (minigame in MINIGAMES)
		{
			if (owner == minigame.owner)
			{
				return minigame;
			}
		}

		return null;
	}

	::MiniGameIsEnd <- function(_minigame, result)
	{
		foreach (index, minigame in MINIGAMES)
		{
			if (_minigame == minigame.minigame)
			{
				minigame.Destroy();
				minigame.GetResult(result);

				MINIGAMES.remove(index);
				return;
			}
		}
	}

	::EndAllMiniGameByType <- function(type)
	{
		foreach (index, minigame in MINIGAMES)
		{
			if (type == minigame.type)
			{
				minigame.DestroyMiniGame();
				MINIGAMES.remove(index);
			}
		}
	}

	::REG_GAME_POST <- function(minigame)
	{
		TEMP_GAME_CONNECTOR.SetScript(minigame);
	}

	::Create_MiniGame <- function(Data)
	{
		local cameraslot = GetFreeCameraSlot();
		local camera = GetFreeCamera(Data.owner);
		camera.SetCameraPos(class_pos(cameraslot.GetOrigin(), Vector(0, 180, 0)));

		Data["cameraslot"] <- cameraslot;
		Data["camera"] <- camera;

		TEMP_GAME_CONNECTOR = class_minigame(Data);
		MINIGAMES.push(TEMP_GAME_CONNECTOR);

		AOP(Entity_Maker, "EntityTemplate", Data.gamename);
		Entity_Maker.SpawnEntityAtLocation(cameraslot.GetOrigin(), Vector());
	}
}

//ALL PLAYERS
{
	::PLAYERS <- [];

	::GetPlayersArray <- function()
	{
		foreach (index, player in PLAYERS)
		{
			if (!TargetValid(player))
			{
				PLAYERS.remove(index);
				continue;
			}
		}

		return PLAYERS;
	}

	::PushPlayerArray <- function(activator)
	{
		foreach (player in PLAYERS)
		{
			if (player == activator)
			{
				return;
			}
		}

		PLAYERS.push(activator);
	}
}
//OVERLAY
{
	::bFade <- false;
	::OVERLAY_NAME <- "*";
	::OVERLAY_TICKING <- false;
	::OVERLAY_TIME <- 0.0;

	const OVERLAY_TICKRATE = 0.25;
	::OVERLAY_TICKRATES <- 0;

	::StartOverLay <- function(_name, _time)
	{
		OVERLAY_NAME = _name;
		OVERLAY_TICKING = true;
		OVERLAY_TIME = Time() + _time;
		Tick_OverLay();
	}
	::Tick_OverLay <- function()
	{
		if (!OVERLAY_TICKING)
		{
			return;
		}

		if (Time() < OVERLAY_TICKRATES)
		{
			return;
		}

		OVERLAY_TICKRATES = Time() + OVERLAY_TICKRATE;

		if (Time() >= OVERLAY_TIME)
		{
			OVERLAY_NAME = "*";
			OVERLAY_TICKING = false;
		}
		local setoverlay;

		local array = GetPlayersArray();
		foreach (player in array)
		{
			setoverlay = OVERLAY_NAME;
			if (OVERLAY_NAME == "*")
			{
				setoverlay = "Noise";
				EF(player, "SetHUDVisibility", "1");
			}
			else
			{
				EF(player, "SetHUDVisibility", "0");
			}
			EntFire("point_clientcommand", "Command", "r_screenoverlay " + setoverlay, 0, player);
		}
	}
}
//CUT_SCENE
{
	::CUT_SCENE_PLAYERS <- [];
	::CUT_SCENE_TIME <- 0.0;
	::CUT_SCENE <- false;
	::CUT_SCENE_ID <- 0;
	::CUT_SCENE_DATA <- [];

	::CUT_SCENE_CAM <- Entities.FindByName(null, "map_camera");
	::CUT_SCENE_TARGET <-  Entities.FindByName(null, "map_camera_target");

	::StartCutScene <- function()
	{
		CUT_SCENE_OVERLAY <- "overlay/cut_scene";
		CUT_SCENE_ID = -1;
		CUT_SCENE = true;

		local delay = 0.00;

		foreach (camera in PERSONAL_CAMS)
		{
			if (camera.Valid())
			{
				EF(camera.GetCamera(), "Disable");
			}
		}

		for (local i = 0; i < CUT_SCENE_DATA.len(); i++)
		{
			if (i == 0)
			{
				CallFunction("NextCameras()");
			}
			else
			{
				CallFunction("NextCameras()", delay - 0.01);
			}
			// printl("TIME " + delay);
			delay += CUT_SCENE_DATA[i].time1 + CUT_SCENE_DATA[i].time2 + CUT_SCENE_DATA[i].flytime;
		}
		CUT_SCENE_TIME = delay;
		// printl("CUT_SCENE TIME " + CUT_SCENE_TIME);
		StartOverLay(CUT_SCENE_OVERLAY, CUT_SCENE_TIME);
	}

	::NextCameras <- function()
	{
		if (bRoundEnd)
		{
			return;
		}
		local aData = CUT_SCENE_DATA[++CUT_SCENE_ID];
		SpawnCameras(aData.o1, aData.a1, aData.time1, aData.o2, aData.a2, aData.time2, aData.flytime);

		if (CUT_SCENE_ID >= CUT_SCENE_DATA.len() - 1)
		{
			CallFunction("EndCutScene()", aData.time1 + aData.time2 + aData.flytime);
			CUT_SCENE_DATA.clear();
		}
	}

	::EndCutScene <- function()
	{
		CUT_SCENE_TIME = 0;
		CUT_SCENE = false;
		CUT_SCENE_ID = -1;

		foreach (player in CUT_SCENE_PLAYERS)
		{
			if (TargetValid(player) &&
			player.GetHealth() > 0)
			{
				player.SetOrigin(g_vecZTELE);
			}
		}
		CUT_SCENE_PLAYERS.clear();

		foreach (camera in PERSONAL_CAMS)
		{
			if (camera.Valid())
			{
				EntFireByHandle(camera.GetCamera(), "Enable", "", 0, camera.GetHandle(), camera.GetHandle());
			}
		}
	}

	::ResetCutScene <- function()
	{
		StartOverLay("*", 1);

		CUT_SCENE_DATA.clear();
		CUT_SCENE_TIME = 0;
		CUT_SCENE = false;
		CUT_SCENE_ID = -1;
		CUT_SCENE_PLAYERS.clear();
	}

	::SpawnCameras <- function(o1, a1, time1, o2, a2, time2, flytime)
	{
		CUT_SCENE_CAM.SetAngles(a1.x, a1.y, a1.z);
		CUT_SCENE_CAM.SetOrigin(o1);
		CUT_SCENE_TARGET.SetAngles(a2.x, a2.y, a2.z);
		CUT_SCENE_TARGET.SetOrigin(o2);

		CUT_SCENE_CAM.__KeyValueFromFloat("interp_time", flytime);

		EF(CUT_SCENE_CAM, "Enable", "", 0);
		EF(CUT_SCENE_CAM, "StartMovement", "", 0.01 + time1);
		EF(CUT_SCENE_CAM, "Disable", "", time1+time2+flytime - 0.01);
	}
}

//CAMERA SLOT
{
	::CAMERA_SLOT <- [];
	::class_camera_slot <- class
	{
		id = 0;
		free = true;
		origin = Vector();

		constructor(_origin)
		{
			this.origin = _origin;
			this.id = CAMERA_SLOT.len();
		}

		function Valid()
		{
			return !this.free;
		}

		function GetOrigin()
		{
			return this.origin;
		}

		function ClearSlot()
		{
			this.free = true;
		}

		function PickSlot()
		{
			this.free = false;
		}
	}

	::GetFreeCameraSlot <- function()
	{
		foreach (slot in CAMERA_SLOT)
		{
			if (!slot.Valid())
			{
				slot.PickSlot();
				return slot
			}
		}
		return null;
	}

	::ResetAllCameraSlot <- function()
	{
		foreach (slot in CAMERA_SLOT)
		{
			slot.ClearSlot()
		}
	}
}

//FREE CAMERA
{
	::PERSONAL_CAMS <- [];
	::class_presonal_camera <- class
	{
		camera = null;
		owner = null;

		constructor()
		{
			this.camera = Entities.CreateByClassname("point_viewcontrol");
			this.camera.__KeyValueFromInt("spawnflags", 160);
			this.camera.__KeyValueFromInt("fov", 100);
			this.camera.__KeyValueFromInt("fov_rate", 0);
			this.camera.__KeyValueFromInt("wait", 68);
		}

		function SetCameraPos(_pos)
		{
			this.camera.SetOrigin(_pos.origin);
			this.camera.SetAngles(_pos.ax, _pos.ay, _pos.az);
		}

		function GetCamera()
		{
			return this.camera;
		}

		function GetHandle()
		{
			return this.owner;
		}

		function Valid()
		{
			return TargetValid(this.owner) && this.owner.GetHealth() > 0;
		}

		function Disable()
		{
			// if (TargetValid(this.owner))
			// {
			EF(this.camera, "Disable")
			// }

			this.owner = null;
		}

		function SetOwner(owner)
		{
			this.owner = owner;
			EntFireByHandle(this.camera, "Enable", "", 0, this.owner, this.owner);
		}
	}

	::GetFreeCamera <- function(activator)
	{
		foreach (index, camera in PERSONAL_CAMS)
		{
			if (!camera.Valid())
			{
				camera.SetOwner(activator);
				return camera;
			}
		}
		return null;
	}

	::ResetAllCamers <- function()
	{
		foreach (camera in PERSONAL_CAMS)
		{
			camera.owner = null;
		}

		EF("point_viewcontrol", "Disable");
	}

	::RemoveCameraOwner <- function(activator)
	{
		local bFind;
		foreach (camera in PERSONAL_CAMS)
		{
			if (camera.owner == activator)
			{
				camera.Disable();
				return;
			}
		}
	}
}

//FREE TARGETNAME
{
	::FREE_TARGETNAME <- [];
	::class_freetargetname <- class
	{
		name = "";
		owner = null;

		constructor(_name)
		{
			this.name = _name;
		}

		function Valid()
		{
			return TargetValid(this.owner);
		}

		function Reset()
		{
			// EF(this.name, "AddOutPut", "targetname  ");
			if (TargetValid(this.owner))
			{
				AOP(this.owner, "targetname", "");
			}

			this.owner = null;
		}

		function SetOwner(_owner)
		{
			this.owner = _owner;
			AOP(this.owner, "targetname", this.name);
		}
	}

	::GetFreeTargetName <- function(activator)
	{
		foreach (targetname in FREE_TARGETNAME)
		{
			if (!targetname.Valid())
			{
				targetname.SetOwner(activator);
				return;
			}
		}
	}

	::ResetAllFreeTargetName <- function()
	{
		foreach (targetname in FREE_TARGETNAME)
		{
			targetname.Reset();
		}
	}

	::RemoveFreeTargetName <- function(activator)
	{
		local szName = "";
		if (TargetValid(activator))
		{
			szName = activator.GetName();
		}

		local bHaveName = (szName != "");
		local bFind;

		foreach (targetname in FREE_TARGETNAME)
		{
			bFind = false;
			if (bHaveName)
			{
				if (targetname.name == szName)
				{
					bFind = true;
				}
			}
			else
			{
				if (targetname.owner == activator)
				{
					bFind = true;
				}
			}

			if (bFind)
			{
				targetname.Reset();
				return;
			}
		}
	}
}

//TEXTCOLOR
{
	enum Enum_TextColor
	{
		// NORMAL			= 1,
		Normal = " \x1",	// white
		// USEOLDCOLORS	= 2,
		// RED				= 2,
		Red	= " \x2",	// red
		// PLAYERNAME		= 3,
		// PURPLE			= 3,
		Purple = " \x3",	// pur	ple
		// LOCATION		= 4,
		Location = "  \x4",	// dark green
		// ACHIEVEMENT		= 5,
		Achievement = " \x5",	// light green
		// AWARD			= 6,
		Award = " \x6",	// green
		// PENALTY			= 7,
		Penalty = " \x7",	// light red
		// SILVER			= 8,
		Silver = " \x8",	// grey
		// GOLD			= 9,
		Gold = " \x9",	// yellow
		// COMMON			= 10,
		Common = " \xA",	// grey blue
		// UNCOMMON		= 11,
		Uncommon = " \xB",	// light blue
		// RARE			= 12,
		Rare = " \xC",	// dark blue
		// MYTHICAL		= 13,
		Mythical = " \xD",	// dark grey
		// LEGENDARY		= 14,
		Legendary = " \xE",	// pink
		// ANCIENT			= 15,
		Ancient = " \xF",	// orange red
		// IMMORTAL		= 16
		Immortal = " \x10"	// orange
	}

	::Enum_TextColor <- CONST.Enum_TextColor;
}

//CLASS_SETTINGS
{
	::SETTINGS <- [];

	enum Enum_SettingsValue
	{
		NONE,
	}
	::Enum_SettingsValue <- CONST.Enum_SettingsValue;

	::class_settings <- class
	{
		zr_infect_spawntime = Enum_SettingsValue.NONE;
		zr_infect_ration = Enum_SettingsValue.NONE;
		zr_respawn_delay = Enum_SettingsValue.NONE;

		class_limit_scout = Enum_SettingsValue.NONE;
		class_limit_engineer = Enum_SettingsValue.NONE;

		class_limit_tank = Enum_SettingsValue.NONE;
		class_limit_vulture = Enum_SettingsValue.NONE;

		function SetInfectTime(_time)
		{
			this.zr_infect_spawntime = _time;
		}

		function SetInfectRation(_ration)
		{
			this.zr_infect_ration = _ration;
		}

		function SetRespawnDelay(_delay)
		{
			this.zr_respawn_delay = _delay;
		}

		function SetLimitScout(_limit)
		{
			this.class_limit_scout = _limit;
		}

		function SetLimitEnginner(_limit)
		{
			this.class_limit_engineer = _limit;
		}

		function SetLimitVulture(_limit)
		{
			this.class_limit_vulture = _limit;
		}

		function SetLimitTank(_limit)
		{
			this.class_limit_tank = _limit;
		}

		function SetSettings()
		{
			if (this.zr_infect_spawntime !=  Enum_SettingsValue.NONE)
			{
				EF("point_servercommand*", "Command", "zr_infect_spawntime_min " + this.zr_infect_spawntime);
				EF("point_servercommand*", "Command", "zr_infect_spawntime_max " + this.zr_infect_spawntime);
				EF("point_servercommand*", "Command", "sm_cvar zr_infect_spawntime_min " + this.zr_infect_spawntime);
				EF("point_servercommand*", "Command", "sm_cvar zr_infect_spawntime_max " + this.zr_infect_spawntime);
			}

			if (this.zr_infect_ration !=  Enum_SettingsValue.NONE)
			{
				EF("point_servercommand*", "Command", "zr_infect_mzombie_ratio " + this.zr_infect_ration);
				EF("point_servercommand*", "Command", "sm_cvar zr_infect_mzombie_ratio " + this.zr_infect_ration);
			}
			if (this.zr_respawn_delay !=  Enum_SettingsValue.NONE)
			{
				EF("point_servercommand*", "Command", "zr_respawn_delay " + this.zr_respawn_delay);
				EF("point_servercommand*", "Command", "sm_cvar zr_respawn_delay " + this.zr_respawn_delay);
			}
			if (this.class_limit_scout !=  Enum_SettingsValue.NONE)
			{
				LIMIT_CLASS_SCOUT = this.class_limit_scout;
			}
			if (this.class_limit_engineer !=  Enum_SettingsValue.NONE)
			{
				LIMIT_CLASS_ENGINEER = this.class_limit_engineer;
			}
			if (this.class_limit_vulture !=  Enum_SettingsValue.NONE)
			{
				LIMIT_CLASS_VULTURE = this.class_limit_vulture;
			}
			if (this.class_limit_tank !=  Enum_SettingsValue.NONE)
			{
				LIMIT_CLASS_TANK = this.class_limit_tank;
			}
		}
	}

	function Init_Settings()
	{
		local obj;

		//0 prolog
		obj = class_settings();

		obj.SetInfectTime(237);
		obj.SetInfectRation(7);
		obj.SetRespawnDelay(8);

		obj.SetLimitScout(6);
		obj.SetLimitEnginner(4);
		obj.SetLimitVulture(8);
		obj.SetLimitTank(0);
		SETTINGS.push(obj);

		//1 chapter01a
		obj = class_settings();

		obj.SetInfectTime(1);
		obj.SetInfectRation(7);
		obj.SetRespawnDelay(8);

		obj.SetLimitScout(6);
		obj.SetLimitEnginner(4);
		obj.SetLimitVulture(8);
		obj.SetLimitTank(0);
		SETTINGS.push(obj);

		//2 chapter01b
		obj = class_settings();

		obj.SetLimitVulture(10);
		obj.SetLimitTank(1);
		SETTINGS.push(obj);

		//3 chapter02a
		obj = class_settings();

		obj.SetInfectTime(1);
		obj.SetInfectRation(6);
		obj.SetRespawnDelay(8);

		obj.SetLimitScout(6);
		obj.SetLimitEnginner(4);
		obj.SetLimitVulture(6);
		obj.SetLimitTank(1);
		SETTINGS.push(obj);


		//4 chapter03a
		obj = class_settings();

		obj.SetInfectTime(1);
		obj.SetInfectRation(5);
		obj.SetRespawnDelay(8);

		obj.SetLimitScout(6);
		obj.SetLimitEnginner(4);
		obj.SetLimitVulture(8);
		obj.SetLimitTank(2);
		SETTINGS.push(obj);
	}

	::SetSettings <- function(ID)
	{
		SETTINGS[ID].SetSettings();
	}
}

//EVENT HOOKER
{
	::PLAYERSINFO <- [];
	PL_HANDLE <- [];

	TEMP_HANDLE <- null;
	T_Player_Check <- 5.00;

	class class_playerinfo
	{
		userid = null;
		name = null;
		steamid = null;
		handle = null;

		pl_checked_r = 0;

		constructor(_userid, _name, _steamid)
		{
			this.userid = _userid;
			this.name = _name;
			this.steamid = _steamid;
		}

		function ValidThisH()
		{
			if (this.handle == null || !this.handle.IsValid()){return false;}
			else{return true;}
		}

		function ClearClassData()
		{
			this.pl_checked_r++;
			if (this.pl_checked_r > 3){this.pl_checked_r = 3;}
		}

		function GetCheckedCPl(){return this.pl_checked_r;}

		function GetHandle()
		{
			return this.handle;
		}
	}

	EVENT_INFO <- null;
	EVENT_PROXE <- null;
	EVENT_LIST <- null;
	EVENT_FALL <- null;
	EVENT_CHAT <- null;
	GLOBAL_ZONE <- null;

	function Event_Start()
	{
		if (EVENT_LIST == null || EVENT_LIST != null && !EVENT_LIST.IsValid()){EVENT_LIST = Entities.FindByName(null, "map_eventlistener_player_connect");}
		if (GLOBAL_ZONE == null || GLOBAL_ZONE != null && !GLOBAL_ZONE.IsValid()){GLOBAL_ZONE = Entities.FindByName(null, "map_eventlistener_zone");}
		if (EVENT_INFO == null || EVENT_INFO != null && !EVENT_INFO.IsValid()){EVENT_INFO = Entities.FindByName(null, "map_eventlistener_player_info");}
		if (EVENT_FALL == null || EVENT_FALL != null && !EVENT_FALL.IsValid()){EVENT_FALL = Entities.FindByName(null, "map_eventlistener_player_falldamage");}
		if (EVENT_CHAT == null || EVENT_CHAT != null && !EVENT_CHAT.IsValid()){EVENT_CHAT = Entities.FindByName(null, "map_eventlistener_player_chat");}
		if (EVENT_PROXE == null || EVENT_PROXE != null && !EVENT_PROXE.IsValid())
		{
			EVENT_PROXE = Entities.CreateByClassname("info_game_event_proxy");
			EVENT_PROXE.__KeyValueFromString("event_name", "player_info");
			EVENT_PROXE.__KeyValueFromInt("range", 0);
			EVENT_PROXE.__KeyValueFromInt("spawnflags", 1);
			EVENT_PROXE.__KeyValueFromInt("StartDisabled", 0);
		}

		for(local i = 0; i < PLAYERSINFO.len(); i++){PLAYERSINFO[i].ClearClassData();}

		LoopPlayerCheck();
	}

	function LoopPlayerCheck()
	{
		EntFireByHandle(self, "RunScriptCode", "LoopPlayerCheck();", T_Player_Check, null, null);
		if (PL_HANDLE.len() > 0){PL_HANDLE.clear();}
		EntFireByHandle(GLOBAL_ZONE, "FireUser1", "", 0.00, null, null);
		EntFireByHandle(self, "RunScriptCode", "CheckValidInArr();", T_Player_Check*1.5, null, null);
	}

	function CheckValidInArr()
	{
		if (PLAYERSINFO.len() > 0)
		{
			for(local i = 0; i < PLAYERSINFO.len(); i++)
			{
				if (!PLAYERSINFO[i].ValidThisH() && PLAYERSINFO[i].GetCheckedCPl() >= 3){PLAYERSINFO.remove(i);}
			}
		}
	}

	function Set_Player()
	{
		if (!ValidHandleArr(activator))
		{
			PL_HANDLE.push(activator);
		}
	}

	function ValidHandleArr(h)
	{
		foreach(p in PLAYERSINFO)
		{
			if (p.handle == h)
			{
				return true;
			}
		}
		return false;
	}

	function Reg_Player()
	{
		if (PL_HANDLE.len() > 0)
		{
			EntFireByHandle(self, "RunScriptCode", "Reg_Player();", 0.10, null, null);
			TEMP_HANDLE = PL_HANDLE[0];
			PL_HANDLE.remove(0);
			if (TEMP_HANDLE.IsValid())
			{
				if (EVENT_PROXE == null || EVENT_PROXE != null  && !EVENT_PROXE.IsValid())return;
				EntFireByHandle(EVENT_PROXE, "GenerateGameEvent", "", 0.00, TEMP_HANDLE, null);
			}
		}
	}

	function PlayerConnect()
	{
		if (EVENT_LIST == null || EVENT_LIST != null && !EVENT_LIST.IsValid())
		{
			EVENT_LIST = Entities.FindByName(null, "map_eventlistener_player_connect");
			if (EVENT_LIST == null)return;
		}
		local userid = EVENT_LIST.GetScriptScope().event_data.userid;
		local name = EVENT_LIST.GetScriptScope().event_data.name;
		local steamid = EVENT_LIST.GetScriptScope().event_data.networkid;
		local p = class_playerinfo(userid,name,steamid);
		PLAYERSINFO.push(p);
	}

	function PlayerInfo()
	{
		local userid = EVENT_INFO.GetScriptScope().event_data.userid;
		if (PLAYERSINFO.len() > 0)
		{
			for(local i=0; i < PLAYERSINFO.len(); i++)
			{
				if (PLAYERSINFO[i].userid == userid)
				{
					PLAYERSINFO[i].handle = TEMP_HANDLE;
					return;
				}
			}
		}
		local p = class_playerinfo(userid,"NOT GETED","NOT GETED");
		p.handle = TEMP_HANDLE;
		PLAYERSINFO.push(p);
	}

	function PlayerChat()
	{
		local userid = EVENT_CHAT.GetScriptScope().event_data.userid;
		local playerinfo_class = GetPlayerInfoClassByUserID(userid);

		if (playerinfo_class == null)
		{
			return;
		}

		local msg = EVENT_CHAT.GetScriptScope().event_data.text;
		if (msg != "!mc_slay" &&
		msg != "/mc_slay")
		{
			return;
		}

		local handle = playerinfo_class.GetHandle();
		if (handle == null ||
		!handle.IsValid() ||
		handle.GetHealth() < 1 ||
		handle.GetTeam() != 2)
		{
			return;
		}

		if (GetPickerClassByOwner(handle) != null)
		{
			return;
		}

		EF(handle, "SetHealth", "0");
	}

	function PlayerFall()
	{
		local userid = EVENT_FALL.GetScriptScope().event_data.userid;
		local playerinfo_class = GetPlayerInfoClassByUserID(userid);

		if (playerinfo_class == null)
		{
			return;
		}

		local handle = playerinfo_class.GetHandle();
		if (handle == null ||
		!handle.IsValid() ||
		handle.GetHealth() < 1)
		{
			return;
		}

		local damage = EVENT_FALL.GetScriptScope().event_data.damage;
		local hp = handle.GetHealth() - damage.tointeger();

		if (hp < 1 &&
		damage > 50)
		{
			DispatchParticleEffect("blood_impact_headshot", handle.GetOrigin() + Vector(0, 0, 16), Vector());

			DispatchParticleEffect("blood_impact_goop_heavy", handle.GetOrigin() + Vector(0, 0, 16), Vector(RandomFloat(-1.0, 1.0), RandomFloat(-1.0, 1.0), 0));
			DispatchParticleEffect("blood_impact_goop_heavy", handle.GetOrigin() + Vector(0, 0, 16), Vector(RandomFloat(-1.0, 1.0), RandomFloat(-1.0, 1.0), 0));
			DispatchParticleEffect("blood_pool", handle.GetOrigin() + Vector(0, 0, 16), Vector());
		}

		DamagePlayer(handle, damage);
	}

	::GetPlayerInfoClassByHandle <- function(handle)
	{
		foreach(p in PLAYERSINFO)
		{
			if (p.handle == handle)
			{
				return p;
			}
		}
		return null;
	}

	::GetPlayerInfoClassByUserID <- function(uid)
	{
		foreach(p in PLAYERSINFO)
		{
			if (p.userid == uid)
			{
				return p;
			}
		}
		return null;
	}
}
//CHAT
{
	::CHAT_BUFFER <- [];

	::PrintChatMessageAllByArrayID <- function(ID)
	{
		ScriptPrintMessageChatAll(CHAT_BUFFER[ID].toupper());
	}

	::PrintChatMessageAll <- function(message, delay = 0.00)
	{
		if (delay > 0.00)
		{
			CHAT_BUFFER.push(message);
			CallFunction("PrintChatMessageAllByArrayID(" + (CHAT_BUFFER.len() - 1).tostring() + ")", delay);
		}
		else
		{
			ScriptPrintMessageChatAll(message.toupper());
		}
	}
}


::g_vecZTELE <- Vector(-15680, 16064, 15940);
::g_vecVpizde <- Vector(-16000, -16000, -16000);
::g_vecCTRoom <- Vector(-15264, 15512, 14260);
::g_vecBaza <- [];
::g_BazaID <- 0;

function Init()
{
	Init_Settings();
	EF("skycamera_main", "ActivateSkyBox");
	// local vecStart = Vector(-15864, -15864, 15084);
	local vecStart = Vector(-16025, 15832, 15764);
	if (GetMapName().find("testroom") != null)
	{
		vecStart = Vector(-16025, 15832, 15764);
	}

	g_vecBaza.clear();
	local x = 0;
	local y = 0;
	for (x = 0; x < 9; x++)
	{
		for (y = 0; y < 8; y++)
		{
			g_vecBaza.push(Vector(vecStart.x + (64 * x), vecStart.y + (64 * y), vecStart.z));
		}
	}

	CAMERA_SLOT.clear();
	vecStart = Vector(-16212, 13912, 14992);
	local vecOrigin = Vector();
	local z = 0;
	for (y = 0; y < 8; y++)
	{
		for (z = 0; z < 8; z++)
		{
			local vecOrigin = Vector(vecStart.x + (0 * x), vecStart.y + (320 * y), vecStart.z + (176 * z));
			CAMERA_SLOT.push(class_camera_slot(vecOrigin));
		}
	}

	for (local i = 0; i < 256; i++)
	{
		FREE_TARGETNAME.push(class_freetargetname("targetname_" + i));
	}

	for (local i = 0; i < 64; i++)
	{
		PERSONAL_CAMS.push(class_presonal_camera());
	}
}

::GetOriginBAZA <- function()
{
	return g_vecBaza[((++g_BazaID >= g_vecBaza.len()) ? (g_BazaID = 0) : g_BazaID)];
}
// EntFireByHandle(self, "RunScriptCode", "Init()", 0.05, null, null);
// CallFunction("Init()", 0.05);