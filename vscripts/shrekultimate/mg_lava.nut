rot1 <- null;
rot2 <- null;
rot3 <- null;
rot4 <- null;

ticking <- false;
ticrate <- 0.1;
MaxTime <- 7;
MinTime <- 4;
iTime <- 8;

origin <- Vector(4480,0,9792);
//Rot1 0 90 0
//Rot2 0 0 0
//Rot3 0 270 0
//Rot4 0 180 0

PlatformArr <- [
	"MGw_plat1*",
	"MGw_plat2*",
	"MGw_plat3*",
	"MGw_plat4*",
	"MGw_plat5*",
	"MGw_plat6*",
	"MGw_plat7*",
	"MGw_plat8*",
	"MGw_plat9*"
];

OriginArr <- [
	Vector(3648, -832, 9645),
	Vector(3648, 832, 9645),
	Vector(5312, -832, 9645),
	Vector(5312, 832, 9645),
];


function startgame3()
{
	ticking = true;
	EntFireByHandle(self, "RunScriptCode", "TeleportTeam(3);",0, null, null);
	EntFireByHandle(self, "RunScriptCode", "Tick();",16, null, null);
	EntFire("MGw_move*", "Open", "", 5);	
	EntFireByHandle(self, "RunScriptCode", "TeleportTeam(2);",15, null, null);
	EntFireByHandle(self, "RunScriptCode", "RandomWind();",70, null, null);
	EntFireByHandle(self, "RunScriptCode", "MoveDown();",100, null, null);
	EntFire("Music", "RunScriptCode","SetMusic(mg3);",0);
}

function MoveDown()
{
    if(PlatformArr.len() < 2)
        return;

	local rand = RandomInt(0, PlatformArr.len()-1)
	EntFire(PlatformArr[rand], "Open");
    PlatformArr.remove(rand);

    EntFireByHandle(self, "RunScriptCode", "MoveDown();", 10, null, null)
}

function RandomWind()
{
	if(!ticking)
		return;

	local Interval = RandomInt(MinTime, MaxTime);
	local rand = RandomInt(1, 4);
	//EntFire("Rot"+rand, "Start");
	SetSpeed(rand,Interval);
	EntFire("MGw_push", "FireUser"+rand,"",0);
	EntFire("MGw_push", "Enable","",2);
	EntFire("MGw_push", "Disable","",Interval);
	//EntFire("Rot"+rand, "Stop","",Interval);

	EntFireByHandle(self, "RunScriptCode", "RandomWind();",Interval + iTime, null, null);
	iTime *= 0.91;
	// printl("Time = "+iTime);
}

function SetSpeed(number,time)
{
	//max 360
	//min 20
	EntFire("Rot"+number+"*", "addoutput","maxspeed "+20 ,0);
	EntFire("Rot"+number+"*", "Start","", 0.01);


	EntFire("Rot"+number+"*", "Stop","",0.2);
	EntFire("Rot"+number+"*", "addoutput","maxspeed "+50 ,0.2);
	EntFire("Rot"+number+"*", "Start","",0.21);

	EntFire("Rot"+number+"*", "Stop","",0.4);
	EntFire("Rot"+number+"*", "addoutput","maxspeed "+100 ,0.4);
	EntFire("Rot"+number+"*", "Start","",0.41);

	EntFire("Rot"+number+"*", "Stop","",0.7);
	EntFire("Rot"+number+"*", "addoutput","maxspeed "+160 ,0.7);
	EntFire("Rot"+number+"*", "Start","",0.71);

	EntFire("Rot"+number+"*", "Stop","",1.0);
	EntFire("Rot"+number+"*", "addoutput","maxspeed "+240 ,1.0);
	EntFire("Rot"+number+"*", "Start","",1.01);

	EntFire("Rot"+number+"*", "Stop","",1.3);
	EntFire("Rot"+number+"*", "addoutput","maxspeed "+360 ,1.3);
	EntFire("Rot"+number+"*", "Start","",1.31);

	EntFire("Rot"+number+"*", "Stop","",1.8);
	EntFire("Rot"+number+"*", "addoutput","maxspeed "+520 ,1.8);
	EntFire("Rot"+number+"*", "Start","",1.81);

	EntFire("Rot"+number+"*", "Stop","",time - 0.5);
	EntFire("Rot"+number+"*", "addoutput","maxspeed "+240 ,time - 0.5);
	EntFire("Rot"+number+"*", "Start","",time - 0.49);

	EntFire("Rot"+number+"*", "Stop","",time - 0.1);
	EntFire("Rot"+number+"*", "addoutput","maxspeed "+100 ,time - 0.1);
	EntFire("Rot"+number+"*", "Start","",time - 0.09);

	EntFire("Rot"+number+"*", "Stop","",time + 0.3);
	EntFire("Rot"+number+"*", "addoutput","maxspeed "+40 ,time + 0.3);
	EntFire("Rot"+number+"*", "Start","",time + 0.31);

	EntFire("Rot"+number+"*", "Stop","",time + 0.6);
}

function TeleportTeam(TEAM)
{
	local handle = null;
	while((handle = Entities.FindByClassname(handle, "player")) != null)
	{
		if(!handle.IsValid())
			continue;
		if(handle.GetHealth() < 1)
			continue;
		if(handle.GetTeam() == TEAM)
		{
			handle.SetOrigin(OriginArr[RandomInt(0, OriginArr.len() - 1)]);
			handle.SetHealth(1000);
		}
		handle.__KeyValueFromFloat("gravity", 1);
	}
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
	while (null != (handle = Entities.FindInSphere(handle , origin, 1300)))
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