map_brush <- Entities.FindByName(null, "map_brush");

PLAYERS <- [];
class player
{
    handle = null;
    inradius = false;
    mike = false;
    constructor(_handle, _mike)
    {
        this.handle = _handle;
        this.mike = _mike;
    }
}
ticking <- false;

lvl <- 1;
worktime <- 0;
dist <- 0;

function Tick()
{
    if(!ticking)
    {
        if(lvl > 1)
        {
            foreach(p in PLAYERS)
            {
                local handle = p.handle;
                if(handle.IsValid() && handle.GetHealth() > 0)
                {
                    local spos = self.GetOrigin();
                    local apos = handle.GetOrigin();

                    if(GetDistance2D(spos,apos) <= dist)
                    {
                        if(!g_bBossFight && !p.mike)
                        {
                            if(lvl > 1)
                            {
                                EntFireByHandle(handle, "SetDamageFilter", "", 0, null, null);
                            }
                        }
                        if(lvl > 2)
                        {
                            EntFireByHandle(MainScript, "RunScriptCode", "GetPlayerClassByHandle(activator).antidebuff = false", 0, handle, handle);
                        }
                    }
                }
            }
        }
        PLAYERS.clear();
        return;
    }
    if(PLAYERS.len() > 0)
    {
        foreach(p in PLAYERS)
        {
            local handle = p.handle;
            if(handle.IsValid() && handle.GetHealth() > 0)
            {
                local spos = self.GetOrigin();
                local apos = handle.GetOrigin();

                if(GetDistance2D(spos,apos) <= dist)
                {
                    handle.SetHealth(handle.GetMaxHealth());

                    if(!p.inradius)
                    {
                        p.inradius = true;
                        if(!g_bBossFight && !p.mike)
                        {
                            if(lvl > 1)
                            {
                                EntFireByHandle(handle, "SetDamageFilter", "filter_no_zombie", 0, null, null);
                            }
                        }
                        if(lvl > 2)
                        {
                            EntFireByHandle(MainScript, "RunScriptCode", "AntiDebuff()", 0, handle, handle);
                        }
                    }
                }
                else if(p.inradius)
                {
                    p.inradius = false;
                    if(!g_bBossFight && !p.mike)
                    {
                        if(lvl > 1)
                        {
                            EntFireByHandle(handle, "SetDamageFilter", "", 0, null, null);
                        }
                    }
                    if(lvl > 2)
                    {
                        EntFireByHandle(MainScript, "RunScriptCode", "GetPlayerClassByHandle(activator).antidebuff = false", 0, handle, handle);
                    }
                }
            }
        }
    }
    //Debug();
    EntFireByHandle(self, "RunScriptCode", "Tick(); ", 0.05, null, null);
}

function Debug()
{
    local text = "";
    foreach(p in PLAYERS)
    {
        local handle = p.handle;
        if(handle.IsValid() && handle.GetHealth() > 0)
        {
            text += handle + " " + p.inradius + "\n"
        }
    }
    ScriptPrintMessageCenterAll(text);
}


function Touch()
{
    local player_class = MainScript.GetScriptScope().GetPlayerClassByHandle(activator);
    if(player_class.mike || player_class.yuffi)
        PLAYERS.push(player(activator, true));
    else
        PLAYERS.push(player(activator, false));
}

function EndTouch()
{
    if(PLAYERS.len() > 0)
    {
        for (local i = 0; i < PLAYERS.len(); i++)
        {
            if(PLAYERS[i].handle == activator)
            {
                if(PLAYERS[i].inradius)
                {
                    if(!PLAYERS[i].mike)
                    {
                        if(lvl > 1)
                        {
                            EntFireByHandle(PLAYERS[i].handle, "SetDamageFilter", "", 0, null, null);
                        }
                    }
                    if(lvl > 2)
                    {
                        EntFireByHandle(MainScript, "RunScriptCode", "GetPlayerClassByHandle(activator).antidebuff = false", 0, PLAYERS[i].handle, PLAYERS[i].handle);
                    }
                }

                PLAYERS.remove(i);
            }
        }
    }
}

function PrintArray()
{
    if(PLAYERS.len() > 0)
    {
        for (local i = 0; i < PLAYERS.len(); i++)
        {
           printl(PLAYERS[i]);
        }
    }
    else
    {
        printl("CLEAR");
    }
}

function Enable()
{
    ticking = true;
    Tick();
    self.ConnectOutput("OnStartTouch", "Touch");
    self.ConnectOutput("OnEndTouch", "EndTouch");
    EntFireByHandle(self, "Enable", "", 0.01, null, null);
}

function Disable()
{
    ticking = false;
    self.DisconnectOutput("OnStartTouch", "Touch")
    self.DisconnectOutput("OnEndTouch", "EndTouch");
    EntFireByHandle(self, "Disable", "", 0.01, null, null);
}


function GetDistance2D(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y));

function DrawAxis(pos,s = 16,nocull = true,time = 4)
{
	DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 0, 255, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y,pos.z-s), Vector(pos.x,pos.y,pos.z+s), 0, 0, 255, nocull, time);
}
