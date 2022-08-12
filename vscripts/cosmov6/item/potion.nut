PLAYERS <- [];
class player
{
    handle = null;
    notheal = null;
    constructor(_handle)
    {
        this.handle = _handle
        this.notheal = true;
    }
}
ticking <- false;

dist <- 0;

function Tick()
{
    if(!ticking)
    {
        PLAYERS.clear();
        return;
    }
    if(PLAYERS.len() > 0)
    {
        foreach(p in PLAYERS)
        {
            if(p.notheal)
            {
                local handle = p.handle;
                if(handle.IsValid() && handle.GetHealth() > 0)
                {
                    local spos = self.GetOrigin();
                    local apos = handle.GetOrigin();

                    if(GetDistance2D(spos,apos) <= dist)
                    {
                        local hp = handle.GetHealth()
                        local hpmax = handle.GetMaxHealth();
                        local sethp = hp + hpmax * 0.5;
                        if(sethp > hpmax)
                            sethp = hpmax;
                        handle.SetHealth(sethp);
                        p.notheal = false;
                    }
                }
            }
        }
    }
    EntFireByHandle(self, "RunScriptCode", "Tick(); ", 0.05, null, null);
}

function Touch()
{
    if(!InArray(activator))
        PLAYERS.push(player(activator));
}

function InArray(handle)
{
    foreach(p in PLAYERS)
    {
        if(p.handle == handle)
            return true;
    }
    return false;
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
    EntFireByHandle(self, "Enable", "", 0.01, null, null);
}

function Disable()
{
    ticking = false;
    self.DisconnectOutput("OnStartTouch", "Touch")
    EntFireByHandle(self, "Disable", "", 0.01, null, null);
}

function GetDistance2D(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y));

function DrawAxis(pos,s = 16,nocull = true,time = 4)
{
	DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 0, 255, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y,pos.z-s), Vector(pos.x,pos.y,pos.z+s), 0, 0, 255, nocull, time);
}
