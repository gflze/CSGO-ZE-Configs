RotateDown <- null;
origin <- Vector(4468,-3462,9937); //1000
ticking <- false;
break_ticrate <- 5;

rot_ticrate <- 1;
Speed <- 20;
MaxSpeed <- 200;

PlatformArr <- [
	"MGr_break1a*",
	"MGr_break2*",
	"MGr_break3*",
	"MGr_break4*",
	"MGr_break5*",
	"MGr_break6*",
	"MGr_break7*",
	"MGr_break8*",
	"MGr_break9*",
	"MGr_break10*",
	"MGr_break11*",
	"MGr_break12*",
	"MGr_break13*",
	"MGr_break14*",
	"MGr_break15*",
	"MGr_break16*"
];

function startgame2()
{
	//kill items
	EntFire("Item_Human_Water_B*", "kill");
	EntFire("Item_Human_Fire_B*", "kill");
	EntFire("Item_Human_Heal_B*", "kill");
	EntFire("Item_Human_Wind_B*", "kill");
	//EntFire("Item_UFO_Button*", "kill");
	EntFire("motosierra_push*", "kill");
	EntFire("motosierra_hurt*", "kill");
	// EntFire("motosierra_2*", "kill");
	// EntFire("motosierra_timer*", "kill");

	ticking = true;
	EntFire("MGr_rod_top*", "Start","", 5);
	EntFireByHandle(self, "RunScriptCode", "SetSpeed();", 5, null, null);
	EntFireByHandle(self, "RunScriptCode", "Break();", 10, null, null);
	EntFire("Music", "RunScriptCode","SetMusic(mg2);",0);
	Tick();
}

function SetSpeed()
{
	if(Speed >= MaxSpeed)
		return;

	EntFire("MGr_rod_down*", "Stop","",0);
	EntFire("MGr_rod_down*", "addoutput","maxspeed "+Speed,0);
	EntFire("MGr_rod_down*", "Start","",0.01);
	if(Speed >=100)
	{
		Speed *= 1.05;
	}
	else
		Speed *= 1.02;
	
	//printl("Speed Rot = "+Speed);
	EntFireByHandle(self, "RunScriptCode", "SetSpeed();", rot_ticrate, null, null);
}


function Break()
{
    if(!ticking)
        return;
    if(PlatformArr.len() < 3)
        return;

    local rand = RandomInt(0,PlatformArr.len()-1);
    PlatformBreak(PlatformArr[rand]);
    PlatformArr.remove(rand);
	//printl("message" +rand)

    EntFireByHandle(self, "RunScriptCode", "Break();", break_ticrate, null, null)
}

function PlatformBreak(target)
{
	EntFire(target, "Color", "255 128 64", 0);
	EntFire(target, "Color", "255 0 0", 1.5);
	EntFire(target, "Break", "", 3);
}

function Tick()
{
	if(!ticking)
		return;

	hurt();
	EntFireByHandle(self, "RunScriptCode", "Tick();", 1, null, null);
}

function hurt()
{
	local text;
	if(!ticking)
        return;

	local countT = 0;
	local countCT = 0;
	local handle = null;
	while (null != (handle = Entities.FindInSphere(handle , origin, 1000)))
	{
		if(handle == null)
            continue;
        if(!handle.IsValid())
            continue;
		if(handle.GetHealth() < 1)
            continue;
		if(handle.GetTeam() == 2)
			countT++;
		if(handle.GetTeam() == 3)
			countCT++;
	}

	if (countT < 1)
	{
		if(countCT > 0)
		{
			//printl("CT WIN")
			text = "CT WIN"
    		ServerChat(Chat_pref + text);
			ticking = false;
			Win();
			local handle = null;
			while((handle = Entities.FindByClassname(handle, "player")) != null)
			{
				if(handle == null)
					continue;
				if(!handle.IsValid())
					continue;
				if(handle.GetHealth() < 1)
					continue;
				if(handle.GetTeam() == 3)
				{
					handle.SetHealth(9999999);
				}
			}
		}
	}

	if (countCT < 1)
	{
		//printl("T WIN")
		text = "T WIN"
    	ServerChat(Chat_pref + text);
		ticking = false;
		EntFire("Map_Fade", "FireUser1","",4);
		local handle = null;
		while((handle = Entities.FindByClassname(handle, "player")) != null)
		{
			if(handle == null)
				continue;
			if(!handle.IsValid())
				continue;
			if(handle.GetHealth() < 1)
				continue;
			if(handle.GetTeam() == 2)
			{
				handle.SetHealth(9999999);
			}
		}
	}
}

function Win()
{
	EntFire("Fade_White", "Fade","",4);
	EntFireByHandle(self, "RunScriptCode", "SlayT();", 5, null, null);
}

function SlayT() {
    local handle = null;
    while((handle = Entities.FindByClassname(handle, "player")) != null)
    {
        if(handle == null)
            continue;
        if(!handle.IsValid())
            continue;
        if(handle.GetHealth() < 1)
            continue;
        if(handle.GetTeam() == 2)
        {
            EntFireByHandle(handle, "SetHealth", "-1", 0.00, null, null);
        }
    }
    EntFireByHandle(self, "RunScriptCode", "SlayT();", 1, null, null);
}

Chat_Buffer <- [];

Chat_pref <- " \x07[\x04MAP\x07]\x09 ";

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