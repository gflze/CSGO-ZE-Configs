floor_temp1 <- null;
floor_temp2 <- null;
floor_temp3 <- null;
GunSpawner <- null;

floor_arr <- [];
floor_arr1 <- [];

ticking <- false;
Floor_TicrateTime <- 1; //time for break one platform

function startgame1()
{
	floor_temp1 = Entities.FindByName(null, "mg_maker_plat_1");
	floor_temp2 = Entities.FindByName(null, "mg_maker_plat_2");
	floor_temp3 = Entities.FindByName(null, "mg_maker_plat_3");
	GunSpawner = Entities.FindByName(null, "MG_gun_maker");
	init();
	Tick();
}

function init()
{
	build(floor_temp1);
	build(floor_temp2);
	build(floor_temp3);
	RegPlatform();

	ticking = true;
	GunSpawner.SpawnEntityAtLocation(Vector(2360,-680,9768), Vector(0,0,0))
	GunSpawner.SpawnEntityAtLocation(Vector(248,-1368,9768), Vector(0,-90,0))
	GunSpawner.SpawnEntityAtLocation(Vector(-376,680,9768), Vector(0,180,0))
	GunSpawner.SpawnEntityAtLocation(Vector(1720,1368,9768), Vector(0,-270,0))
	GunSpawner.SpawnEntityAtLocation(Vector(2360,-680,10344), Vector(0,0,0))
	GunSpawner.SpawnEntityAtLocation(Vector(248,-1368,10344), Vector(0,-90,0))
	GunSpawner.SpawnEntityAtLocation(Vector(-376,680,10344), Vector(0,180,0))
	GunSpawner.SpawnEntityAtLocation(Vector(1720,1368,10344), Vector(0,-270,0))
	EntFire("MGp_platform", "Break", "", 2);
	EntFireByHandle(self, "RunScriptCode", "BreakTimer();", 5, null, null);
	EntFireByHandle(self, "RunScriptCode", "BreakTimer1();", 10, null, null);
	EntFire("Music", "RunScriptCode","SetMusic(mg1);",0);
}

function build(temp)
{
	local SavePos = temp.GetOrigin();
	local i;
	local j;
	local n = 13;
	local center = n / 2;

	for(i = 0; i < n; i++)
	{
		for(j = 0; j < n; j++)
		{
			if(i <= center)
			{
				if(j >= center - i && j <= center + i)	
					temp.SpawnEntityAtLocation(SavePos + Vector(j*128,i*128,0), Vector())
			}
			  else
			{
				if(j >= center + i - n + 1 && j <= center - i + n - 1)
					temp.SpawnEntityAtLocation(SavePos + Vector(j*128,i*128,0), Vector())
			}
		}
	}	
}

function RegPlatform()
{
	local handle = null;
    while((handle = Entities.FindByName(handle, "MGp_tbreak")) != null)
	{
		if(!handle.IsValid())
            continue;
		floor_arr.push(handle);
	}
	while((handle = Entities.FindByName(handle, "MGp_sbreak")) != null)
	{
		if(!handle.IsValid())
            continue;
		floor_arr1.push(handle);
	}
	//printl(""+floor_arr.len());
}

function BreakTimer()
{
	if(!ticking)
		return;
	if(floor_arr.len() < 1)
		return;

	local rand = RandomInt(0,floor_arr.len()-1);
	PlatformBreak(floor_arr[rand]);
	floor_arr.remove(rand);

	EntFireByHandle(self, "RunScriptCode", "BreakTimer();", Floor_TicrateTime, null, null)
}

function BreakTimer1()
{
	if(!ticking)
		return;
	if(floor_arr.len() < 1)
		return;

	local rand = RandomInt(0,floor_arr1.len()-1);
	PlatformBreak(floor_arr1[rand]);
	floor_arr1.remove(rand);

	EntFireByHandle(self, "RunScriptCode", "BreakTimer1();", Floor_TicrateTime * 2, null, null)
}

function PlatformBreak(target)
{
	EntFireByHandle(target, "Color", "255 128 64", 0.30, null, null);
	EntFireByHandle(target, "Color", "255 0 0", 0.60, null, null);
	EntFireByHandle(target, "Break", "", 1.0, null, null);
}

function Tick()
{
	if(!ticking)
		return;

	hurt();
	EntFireByHandle(self, "RunScriptCode", "Tick();", 1, null, null)
}

function hurt()
{
	if ((CountAlive()) == 1)
	{
		ticking = false;
		Win();
		//printl("SOLO WIN")
		local text;
		text = "SOLO WIN"
    	ServerChat(Chat_pref + text);
		
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
		EntFire("Fade_White", "fade","",4);
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

function CountAlive(TEAM = 3)
{
    local handle = null;
    local counter = 0;
    while(null != (handle = Entities.FindByClassname(handle,"player")))
    {
        if(handle.GetTeam() == TEAM && handle.GetHealth() > 0)counter++;
    }
    return counter;
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