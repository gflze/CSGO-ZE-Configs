const TICKRATE = 0.15;
const TICKRATE_TEXT = 1.00;

// const CD_ROAR = 15.0;
// const CD_JUMP = 10.0;

const CD_ROAR = 30.0;
const CD_JUMP = 10.0;
const CD_DASH = 5.0;	//strike
const CD_STRIKE = 15.0; //poison

g_szAnimList <- [
	"attack",			// ТЫЧКА
	"attack2",			// РЫВОК
	"attack3",
	"dead",
	"idle",
	"jump",			// ПРЫГНУЛ ЗАДАМАЖИЛ
	"roar",			// ЗАМЕДЛИЛ
	"run",
];

g_iScroll_ID <- 0;
g_aiAttacks <- [
	"Strike",
	"Poison",
	"Jump",
	"Roar",
]

g_fTicking_Text <- 0.0;
enum EnumAnimStatus
{
	idle,
	run,
	casting,
}

g_fCD <- null;

g_iHP <- 5;
g_iHP_Init <- 5;
g_iHP_BARS <- 16;

g_bStaned <- false;

g_iShoots_for_Gil <- 15;
g_iShoots_for_Gil = 1.00 / g_iShoots_for_Gil;

g_hOwner <- null;
g_hKnife <- null;

g_hCamera <- null;
g_hEyeParent <- null;
g_hEyeParentModel <- null;
g_hBox <- null;
g_hModel <- null;
g_hGameUI  <- null;

g_bPress_W <- false;
g_bPress_S <- false;
g_bPress_A <- false;
g_bPress_D <- false;

g_bPickUp <- false;
g_bTicking <- false;

g_hText <- null;

function Init()
{
	g_hBox = Entities.FindByName(null, "scorpion_hbox");
	g_hKnife = Entities.FindByName(null, "scorpion_knife");

	g_fCD = [
	[Time(), CD_DASH, "Cast_Dash"],
	[Time(), CD_STRIKE, "Cast_Strike"],
	[Time(), CD_JUMP, "Cast_Jump"],
	[Time(), CD_ROAR, "Cast_Roar"],];

	CreateModel();
	CreateCamera();
	CreateGameUI();
	CreateText();

	TickPickUp();
}

function PickUp()
{
	SetOwner();
	SetHP(350);

	g_bTicking = true;
	Tick();
	EntFire("Mine_Scorpion_ZM_TP", "Enable", "", 130);
	EntFire("Scorpion_Nade", "Enable", "", 10);
}

function TickPickUp()
{
	if (g_bPickUp)
	{
		return;
	}

	local h;
	local oldKnife
	while (null != (h = Entities.FindInSphere(h, g_hKnife.GetOrigin(), 32)))
	{
		if (h.GetClassname() == "player" &&
		h.IsValid() &&
		h.GetHealth() > 0 &&
		h.GetTeam() == 2)
		{
			while ((oldKnife = Entities.FindByClassname(oldKnife, "weapon_knife*")) != null)
			{
				if (oldKnife.GetOwner() == h)
				{
					oldKnife.Destroy();
					break;
				}
			}
			g_bPickUp = true;
			g_hOwner = h;
			return;
		}
	}

	EF(self, "RunScriptcode", "TickPickUp()", 0.5);
}

function Tick()
{
	if (!g_bTicking ||
	!Tick_Owner() ||
	!Tick_HP())
	{
		return;
	}

	Tick_Anim();
	Tick_BossStatus();
	Tick_Text();

	EF(self, "RunScriptcode", "Tick()", TICKRATE);
}

function Tick_Text()
{
	g_fTicking_Text += TICKRATE;
	if (g_fTicking_Text >= TICKRATE_TEXT)
	{
		g_fTicking_Text = 0.0;
		DisplayText();
	}
}

function DisplayText()
{
	local szMsg = "";
	for (local i = 0; i < g_aiAttacks.len(); i++)
	{
		if (i == g_iScroll_ID)
		{
			szMsg += ">>>" + g_aiAttacks[g_iScroll_ID] + "[" + GetCDstring(GetCD(i)) + "]" + "<<<";
		}
		else
		{
			szMsg += g_aiAttacks[i] + "[" + GetCDstring(GetCD(i)) + "]";
		}
		szMsg += "\n";
	}

	EF(g_hText, "SetText", szMsg);
	EntFireByHandle(g_hText, "Display", "", 0, g_hOwner, g_hOwner);
}

function GetCD(ID)
{
	local fTime = g_fCD[ID][0] - Time().tointeger();
	if (fTime <= 0.1)
	{
		return 0;
	}
	return fTime.tointeger();
}

function GetCDstring(CD)
{
	if (CD == 0)
	{
		return "R";
	}
	return ""+CD;
}

function Tick_Owner()
{
	if (g_hOwner == null ||
	!g_hOwner.IsValid() ||
	g_hOwner.GetTeam() != 2 ||
	g_hOwner.GetHealth() < 1)
	{
		BossDead();
		return false;
	}
	return true;
}

function BossDead()
{
	g_bTicking = false;
	ShowBossDeadStatus();

	if (MainScript != null && MainScript.IsValid())
	{
		MainScript.GetScriptScope().Active_Boss = null;
	}
	EF("Temp_Scorpion", "RunScriptCode", "End()");
	printl("Main_S");

	local item_target = Entities.FindByName(null, "map_item_beam_target");
	EntFireByHandle(item_target, "ClearParent", "", 0, null, null);

	ResetOwner();
	RemoveSkin();
}

function Tick_Anim()
{
	if (g_iAnimStatus == EnumAnimStatus.casting)
	{
		return;
	}

	if (g_bPress_W ||
	g_bPress_S ||
	g_bPress_A ||
	g_bPress_D)
	{
		return SetAnimation_Run();
	}
	SetAnimation_Idle();
}

function Tick_HP()
{
	if (g_iHP <= 0)
	{
		g_iHP += g_iHP_Init;
		g_iHP_BARS--;

		if (g_iHP_BARS <= 16)
		{
			local id = 16 - g_iHP_BARS;
			EF("Special_HealthTexture", "SetTextureIndex", "" + id);
		}
	}

	if (g_iHP_BARS <= 0)
	{
		BossDead();
		return false;
	}
	return true;
}

function Press_AT1()
{
	if (GetCD(g_iScroll_ID) != 0)
	{
		return;
	}
	if (g_iAnimStatus != EnumAnimStatus.idle &&
	g_iAnimStatus != EnumAnimStatus.run)
	{
		return;

	}

	g_iAnimStatus = EnumAnimStatus.casting;
	EF(self, "RunScriptCode",  g_fCD[g_iScroll_ID][2] + "()");
	g_fCD[g_iScroll_ID][0] = Time().tointeger() + g_fCD[g_iScroll_ID][1]

	DisplayText();
}
// function t1()
// {
// 	local sz = "<img src='https://cdn.discordapp.com/attachments/790715666540920922/998091996965126184/unknown.png'>";
// 	ScriptPrintMessageCenterAll(sz);
// }

function Press_AT2()
{
	g_iScroll_ID++;
	if (g_iScroll_ID >= g_aiAttacks.len())
	{
		g_iScroll_ID = 0;
	}
	DisplayText();
}

function Cast_Strike()
{
	printl("Cast_Strike");
	local start = 0.75;
	local end = 1.95;

	EF(g_hModel, "SetAnimation", "attack");

	EF(self, "RunScriptCode", "g_iAnimStatus <- -1;", end);

	EF(g_hOwner, "AddOutPut", "movetype 0", 0);
	EF(g_hOwner, "AddOutPut", "movetype 2", end);

	EF("scorpion_hurt_strike", "Enable", "", start);
	EF("scorpion_hurt_effects", "Start", "", start-0.3);
	EF("scorpion_hurt_strike", "Disable", "", end);
	EF("scorpion_hurt_effects", "Stop", "", end);
}
function Cast_Dash()
{
	printl("Cast_Dash");
	local start = 0.3;
	local end = 0.4;
	EF(g_hModel, "SetAnimation", "attack2");

	EF(self, "RunScriptCode", "g_iAnimStatus <- -1;", end);

	EF("scorpion_hurt_dash", "Enable", "", start);
	EF("scorpion_hurt_dash", "Disable", "", end);

}
function Cast_Jump()
{
	printl("Cast_Jump");
	local start = 1.1;
	local end = 5;

	EF(g_hModel, "SetAnimation", "jump");
	EF(g_hModel, "SetPlayBackRate", "0.3", 0.6);
	EF("scorpion_jump_effects", "Start", "jump", 1.9);
	EF("scorpion_jump_effects", "Stop", "jump", 3);
	// EF(g_hModel, "SetPlayBackRate", "1.0", start);

	EF(g_hOwner, "AddOutPut", "movetype 0", 0);
	EF(g_hOwner, "AddOutPut", "movetype 2", end);

	EF(self, "RunScriptCode", "g_iAnimStatus <- -1;", end);

	//	ПОДОГНАТЬ!
	EF("scorpion_hurt_jump", "Enable", "", start);
	EF("scorpion_hurt_jump", "Disable", "", start + 0.1);
}
function Cast_Roar()
{
	printl("Cast_Roar");
	local start = 0.25;
	local end = 2.5;
	EF(g_hModel, "SetAnimation", "roar");

	EF(self, "RunScriptCode", "Trigger_Roar();", start);

	EF(self, "RunScriptCode", "g_iAnimStatus <- -1;", end);

	EF(g_hOwner, "AddOutPut", "movetype 0", 0);
	EF(g_hOwner, "AddOutPut", "movetype 2", end);

	EF("scorpion_roar_effects", "Start", "", 0.5);
	EF("scorpion_roar_effects", "Stop", "", 5);
}

function Trigger_Roar()
{
	if (MainScript == null ||
	!MainScript.IsValid())
	{
		return;
	}

	AddHP(-1);

	local h;
	while (null != (h = Entities.FindByClassnameWithin(h, "player", g_hKnife.GetOrigin(), 9999)))
	{
		if( h.IsValid() &&
		h.GetHealth() > 0 &&
		h.GetTeam() == 3)
		{
			EntFireByHandle(MainScript, "RunScriptCode", "SlowPlayer(0.9 5.0)", 0, h, h);
		}
	}
	MainScript.GetScriptScope().UseSilence(10);
}


function Tick_BossStatus()
{
	local szMsg;

	szMsg = "[Scorpion] : Status : Angry\n";
	for (local i = 1; i <= g_iHP_BARS; i++)
	{
		if (i <= 16)
		{
			szMsg += "◆";
		}
		else
		{
			szMsg += "◈";
		}
	}
	for (local i = g_iHP_BARS; i < 16; i++)
	{
		szMsg += "◇";
	}

	ScriptPrintMessageCenterAll(szMsg);
}


function ShowBossDeadStatus()
{
	local szMsg;
	szMsg = "[Scorpion] : Status : Dead\n";

	for (local i = g_iHP_BARS; i < 16; i++)
	{
		szMsg += "◇";
	}

	ScriptPrintMessageCenterAll(szMsg);
}

function SetOwner()
{
	AOP(g_hOwner, "targetname", "scorpion_owner" + Time());
	AOP(g_hOwner, "rendermode", 10);
	AOP(g_hOwner, "gravity", 0.7);

	local pl = MainScript.GetScriptScope().GetPlayerClassByHandle(g_hOwner);
	if (pl != null)
	{
		pl.Add_speed(0.3, true);
		EntFireByHandle(SpeedMod, "ModifySpeed", (pl.ReturnSpeed()).tostring(), 0.1, pl.handle, pl.handle);
	}

	g_hOwner.SetHealth(80000);
	EF(g_hOwner, "SetDamageFilter", "filter_zombies");

	EntFireByHandle(g_hGameUI, "Activate", "", 0, g_hOwner, g_hOwner);
	EntFireByHandle(g_hCamera, "Enable", "", 0, g_hOwner, g_hOwner);
}

function ResetOwner()
{
	if (g_hOwner != null && g_hOwner.IsValid())
	{
		AOP(g_hOwner, "targetname", "");
		AOP(g_hOwner, "rendermode", 0);
		AOP(g_hOwner, "gravity", 1.0);
		EF(g_hGameUI, "Deactivate");

		local pl = MainScript.GetScriptScope().GetPlayerClassByHandle(g_hOwner);
		if (pl != null)
		{
			pl.Add_speed(-0.3, true);
			EntFireByHandle(SpeedMod, "ModifySpeed", (pl.ReturnSpeed()).tostring(), 0.1, pl.handle, pl.handle);
		}
	}

	EF(g_hOwner, "SetDamageFilter", "", 0.05);
	EF(g_hOwner, "SetHealth", "-1", 0.05);
	EF(g_hCamera, "Disable");
}

function RemoveSkin()
{
	EF(g_hBox, "Break", "");
	EF(g_hModel, "ClearParent", "");
	EF(g_hModel, "SetAnimation", "dead");
	EF(g_hModel, "FadeAndKill", "", 1.0);

	EF(g_hCamera, "Kill", "", 0.05);
	EF(g_hEyeParent, "Kill", "", 0.05);
	EF(g_hEyeParentModel, "Kill", "", 0.05);
	EF(g_hGameUI, "Kill", "", 0.05);
	EF(g_hText, "Kill", "", 0.05);
}

/*
	HP BLOCK
*/
{
	function SetHP(i)
	{
		g_iHP = 100;
		i = (0.00 + i) / g_iHP_BARS;

		local handle;
		while (null != (handle = Entities.FindByClassname(handle, "player")))
		{
			if (handle.IsValid())
			{
				if (handle.GetTeam() == 3 &&
				handle.GetHealth() > 0)
				{
					g_iHP += i;
					g_iHP_Init += i;
				}
			}
		}
	}

	function AddHP(i)
	{
		if (i < 0)
		{
			i = -i * g_iHP_Init;
		}

		while (g_iHP + i >= g_iHP_Init)
		{
			g_iHP_BARS++;
			i -= g_iHP_Init;
		}

		if (g_iHP_BARS <= 16)
		{
			local id = 16 - g_iHP_BARS;
			EF("Special_HealthTexture", "SetTextureIndex", "" + id);
		}
		else
		{
			EF("Special_HealthTexture", "SetTextureIndex", "0");
		}

		g_iHP += i;
	}

	function ShootDamage()
	{
		SubtractHP(1);
		if (MainScript != null && MainScript.IsValid())
		{
			MainScript.GetScriptScope().GetPlayerClassByHandle(activator).ShootTick(g_iShoots_for_Gil);
		}
	}

	function ItemDamage(i)
	{
		if (i < 0)
		{
			i = -i * g_iHP_Init;
		}

		SubtractHP(i);
	}


	function SubtractHP(i)
	{
		if (g_bStaned)
		{
			i *= StanDamage;
		}

		g_iHP -= i;
	}

	function NadeDamage()
    {
        SubtractHP(80);
	}
}
/*
	ANIM BLOCK
*/
{
	g_iAnimStatus <- -1;

	g_iAnimSelected <- -1;

	function SetAnimation_Idle()
	{
		if (g_iAnimStatus != EnumAnimStatus.idle)
		{
			EF(g_hModel, "SetAnimation", "idle");
			EF(g_hModel, "SetDefaultAnimation", "idle");
		}
		g_iAnimStatus = EnumAnimStatus.idle;
	}

	function SetAnimation_Run()
	{
		if (g_iAnimStatus != EnumAnimStatus.run)
		{
			EF(g_hModel, "SetAnimation", "run");
			EF(g_hModel, "SetDefaultAnimation", "run");
		}
		g_iAnimStatus = EnumAnimStatus.run;
	}

	function CreateModel()
	{
		local modelpath = "models/microrost/cosmov6/ff7r/scorpion.mdl";

		self.PrecacheModel(modelpath);
		g_hModel = Entities.CreateByClassname("prop_dynamic");

		AOP(g_hModel, "solid", 0);
		AOP(g_hModel, "rendermode", 1);

		g_hModel.SetModel(modelpath);

		g_hModel.SetAngles(-90 , 90, 0);
		g_hModel.SetOrigin(g_hKnife.GetOrigin() + g_hKnife.GetForwardVector() * -32 + g_hKnife.GetUpVector() * 5);

		// EntFireByHandle(g_hModel, "AddOutPut", "OnAnimationDone " + self.GetName() + ":RunScriptCode:OnAnimationComplite():0:-1", 0.01, null, null);
		EntFireByHandle(g_hModel, "SetParent", "!activator", 0.01, g_hKnife, g_hKnife);

		SetAnimation_Idle();
	}

	function CreateCamera()
	{
		g_hEyeParentModel = Entities.CreateByClassname("prop_dynamic");
		AOP(g_hEyeParentModel, "targetname", "scorpion_cameraparent" + Time());
		g_hEyeParentModel.SetOrigin(g_hKnife.GetOrigin() + g_hKnife.GetForwardVector() * -100 + g_hKnife.GetUpVector() * 130);
		g_hEyeParentModel.SetAngles(25, 0, 0);
		EntFireByHandle(g_hEyeParentModel, "SetParent", "!activator", 0.01, g_hKnife, g_hKnife);

		g_hEyeParent = Entities.CreateByClassname("logic_measure_movement");

		AOP(AOP, "TargetScale", 0.0);
		AOP(AOP, "MeasureType", 0);

		g_hCamera = Entities.CreateByClassname("point_viewcontrol");

		g_hCamera.SetOrigin(g_hEyeParentModel.GetOrigin());

		AOP(g_hCamera, "fov", 110);
		AOP(g_hCamera, "spawnflags", 128);
		AOP(g_hCamera, "fov_rate", 0.0);
		AOP(g_hCamera, "targetname", "scorpion_camera" + Time());

		EF(g_hEyeParent, "SetTargetReference", g_hEyeParentModel.GetName());
		EF(g_hEyeParent, "SetMeasureReference", g_hEyeParentModel.GetName());
		EF(g_hEyeParent, "SetMeasureTarget", g_hEyeParentModel.GetName());
		EF(g_hEyeParent, "SetTarget", g_hCamera.GetName());
		EF(g_hEyeParent, "Enable", "", 0.05);
	}

	function CreateText()
	{
		g_hText = Entities.CreateByClassname("game_text");
		g_hText.__KeyValueFromInt("spawnflags", 0);
		g_hText.__KeyValueFromInt("channel", 3);
		g_hText.__KeyValueFromInt("effect", 0);
		g_hText.__KeyValueFromVector("color", Vector(255, 0, 0));
		g_hText.__KeyValueFromVector("color2", Vector(193, 87, 0));
		g_hText.__KeyValueFromFloat("y", 0.78);
		g_hText.__KeyValueFromFloat("x", -1.0);
		g_hText.__KeyValueFromFloat("fadein", 0.75);
		g_hText.__KeyValueFromFloat("fadeout", 0.75);
		g_hText.__KeyValueFromFloat("holdtime", 1.0);
	}

	function CreateGameUI()
	{
		g_hGameUI = Entities.CreateByClassname("game_ui");

		g_hGameUI.__KeyValueFromInt("spawnflags", 0);
		g_hGameUI.__KeyValueFromFloat("FieldOfView", -1.0);

		AOP(g_hGameUI, "PressedAttack", self.GetName() + ":RunScriptCode:Press_AT1():0:-1", 0.01);
		AOP(g_hGameUI, "PressedAttack2", self.GetName() + ":RunScriptCode:Press_AT2():0:-1", 0.01);
		AOP(g_hGameUI, "PressedForward", self.GetName() + ":RunScriptCode:g_bPress_W=true:0:-1", 0.01);
		AOP(g_hGameUI, "PressedBack", self.GetName() + ":RunScriptCode:g_bPress_S=true:0:-1", 0.01);
		AOP(g_hGameUI, "PressedMoveLeft", self.GetName() + ":RunScriptCode:g_bPress_A=true:0:-1", 0.01);
		AOP(g_hGameUI, "PressedMoveRight", self.GetName() + ":RunScriptCode:g_bPress_D=true:0:-1", 0.01);

		AOP(g_hGameUI, "UnPressedForward", self.GetName() + ":RunScriptCode:g_bPress_W=false:0:-1", 0.01);
		AOP(g_hGameUI, "UnPressedBack", self.GetName() + ":RunScriptCode:g_bPress_S=false:0:-1", 0.01);
		AOP(g_hGameUI, "UnPressedMoveLeft", self.GetName() + ":RunScriptCode:g_bPress_A=false:0:-1", 0.01);
		AOP(g_hGameUI, "UnPressedMoveRight", self.GetName() + ":RunScriptCode:g_bPress_D=false:0:-1", 0.01);
	}
}

/*
	SOFT BLOCK
*/
{
	::AOP <- function(item, key, value = "", d = 0.00)
	{
		if (typeof item == "string")
		{
			EntFire(item, "AddOutPut", key + " " + value, d);
		}
		else if (typeof item == "instance")
		{
			if (d > 0.00)
			{
				EntFireByHandle(item, "AddOutPut", key + " " + value, d, item, item);
			}
			else
			{
				if (typeof value == "string")
				{
					item.__KeyValueFromString(key, value);
				}
				else if (typeof value == "integer")
				{
					item.__KeyValueFromInt(key, value);
				}
				else if (typeof value == "float")
				{
					item.__KeyValueFromFloat(key, value);
				}
				else if (typeof value == "vector")
				{
					item.__KeyValueFromVector(key, value);
				}
				else
				{
					EntFireByHandle(item, "AddOutPut", key + " " + value, d, item, item);
				}
			}
		}
	}
	::EF <- function(target, action, value = "", delay = 0.00)
	{
		if (typeof target == "string")
		{
			EntFire(target, action, value, delay, null)
		}
		else
		{
			EntFireByHandle(target, action, value, delay, null, null);
		}
	}
	function AnimCheck(ID = -1)
	{
		if (ID == -1)
		{
			g_iAnimSelected++;
			if (g_szAnimList.len() <= g_iAnimSelected)
			{
				g_iAnimSelected = 0;
			}
		}
		else
		{
			g_iAnimSelected = ID;
		}

		printl("SetAnim: " + g_szAnimList[g_iAnimSelected]);
		EF(g_hModel, "SetAnimation", g_szAnimList[g_iAnimSelected]);
	}
}

EF(self, "RunScriptCode", "Init()", 0.05);