::cp02_quest_01 <- self.GetScriptScope();

const TICKRATE = 1.00;

LIFT_STATUS <- Enum_LIFT.Up;
CT <- [];

CT_LIMIT <- 5;

CT_INSIDE <- CT_LIMIT;

T_INSIDE <- 0;
T_PORTAL <- 0;

g_bPress <- false;
g_bTicking <- false;
g_bInit <- true;

function Init()
{
	g_bTicking = true;

	foreach (portal in PORTALS_CH02_QUEST01)
	{
		portal.SetScript(cp02_quest_01);
		portal.SetLimit(5, 99999);
	}

	Tick();
}

function UnLimit()
{
	g_bTicking = false;
	foreach (portal in PORTALS_CH02_QUEST01)
	{
		portal.SetAllowVulture(true);
		portal.SetScript(null);
		portal.SetLimit(5, 15);
	}
}

function Tick()
{
	if (!g_bTicking)
	{
		return;
	}

	local iCount = 0;
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

		if (!IsVectorInBoundingBox(player.GetOrigin(), Vector(1408, -1883, -722), Vector(2592, 1926, 356)))
		{
			continue;
		}
		iCount++;
	}

	T_INSIDE = iCount;
	foreach (portal in PORTALS_CH02_QUEST01)
	{
		portal.SetLimit(CT_INSIDE - (T_INSIDE + T_PORTAL), 99999);
	}

	CallFunction("Tick()", TICKRATE);
}

function UseTeleport()
{
	T_PORTAL--;
	T_INSIDE++;
	foreach (portal in PORTALS_CH02_QUEST01)
	{
		portal.SetLimit(CT_INSIDE - (T_INSIDE + T_PORTAL), 99999);
	}
}

function UseTeleport_Pre()
{
	T_PORTAL++;
	foreach (portal in PORTALS_CH02_QUEST01)
	{
		portal.SetLimit(CT_INSIDE - (T_INSIDE + T_PORTAL), 99999);
	}
}

function Out()
{
	local index = InArrayCT(activator);
	if (index == -1)
	{
		return;
	}
	CT.remove(index);
}

function In()
{
	if (InArrayCT(activator) != -1)
	{
		return;
	}
	CT.push(activator);
}

function InArrayCT(_activator)
{
	foreach (index, activator in CT)
	{
		if (_activator == activator)
		{
			return index;
		}
	}
	return -1;
}

function Enable_Lift()
{
	EF("loc01_quest02_door00*", "Open", "", 1);
	EF("cp02_logic_lift_door02*", "Open", "", 1.5);
	EF("cp02_logic_lift_button00*", "UnLock", "", 5.5);
	EF("cp02_logic_lift_trigger*", "Enable");
}

function Lift_Button()
{
	if (CT.len() > CT_LIMIT)
	{
		if (!g_bPress)
		{
			g_bPress = true;
			PrintChatMessageAll(Enum_TextColor.Red + Translate["elevatorlimit"]);
			return;
		}

		local index;
		for (local i = CT.len() - CT_LIMIT; 0 < i; i--)
		{
			index = RandomInt(0, CT.len() - 1);
			CT[index].SetOrigin(Vector(4783, -2295, -736));
			CT.remove(index);
		}
	}

	if (LIFT_STATUS == Enum_LIFT.Down)
	{
		EF("loc01_quest02_door01*", "Close");
		EF("cp02_logic_lift_door03*", "Close", "", 3);

		LIFT_STATUS = Enum_LIFT.Move_Up;
	}
	else if (LIFT_STATUS == Enum_LIFT.Up)
	{
		EF("loc01_quest02_door00*", "Close");
		EF("cp02_logic_lift_door03*", "Open", "", 3);
		LIFT_STATUS = Enum_LIFT.Move_Down;
	}
	else
	{
		return;
	}

	if (!g_bInit)
	{
		CT_INSIDE += CT.len();
	}

	CT.clear();
	g_bPress = false;

	EF("cp02_logic_lift_trigger*", "Disable");
	EF("cp02_logic_lift_door02*", "Close", "", 0.5);
	EF("cp02_logic_lift_button00*", "Lock");
}

function Lift_End_Move()
{
	if (LIFT_STATUS == Enum_LIFT.Move_Down)
	{
		EF("loc01_quest02_door01*", "Open");
		CallFunction("Lift_Button()", 35.0);

		if (g_bInit)
		{
			g_bInit = false;
			Main_Script.Trigger_Chapter2_03b();
		}

		LIFT_STATUS = Enum_LIFT.Down;
	}
	else if (LIFT_STATUS == Enum_LIFT.Move_Up)
	{
		EF("cp02_logic_lift_trigger*", "Enable");
		EF("loc01_quest02_door00*", "Open");
		EF("cp02_logic_lift_button00*", "UnLock", "", 5.0);

		LIFT_STATUS = Enum_LIFT.Up;
	}
	else
	{
		return;
	}
	EF("cp02_logic_lift_door02*", "Open", "", 0.5);
}
