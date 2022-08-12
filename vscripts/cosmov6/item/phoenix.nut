PLAYERS <- [];
class player
{
    handle = null;
    notakebuff = null;
    constructor(_handle)
    {
        this.handle = _handle
        this.notakebuff = true;
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
            if(p.notakebuff)
            {
                local handle = p.handle;
                if(handle.IsValid() && handle.GetHealth() > 0)
                {
                    local spos = self.GetOrigin();
                    local apos = handle.GetOrigin();

                    if(GetDistance2D(spos,apos) <= dist)
                    {
                        EntFireByHandle(MainScript, "RunScriptCode", "AntiDebuff(1.5)", 0, p.handle, p.handle);
                        p.notakebuff = false;
                    }
                }
            }
        }
    }
    EntFireByHandle(self, "RunScriptCode", "Tick();", 0.05, null, null);
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