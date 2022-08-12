map_brush <- Entities.FindByName(null, "map_brush");

PLAYERS <- [];
class player
{
    handle = null;
    nottake = null;
    constructor(_handle)
    {
        this.handle = _handle
        this.nottake = true;
    }
}
ticking <- false;

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
            if(!p.nottake)
                continue;
            if(!p.handle.IsValid())
                continue;
            if(p.handle.GetHealth() <= 0)
                continue;

            p.nottake = false;
            EntFireByHandle(map_brush, "RunScriptCode", "PoisonPlayer(10,30,1)", 0, p.handle, p.handle);
        }
    }
    EntFireByHandle(self, "RunScriptCode", "Tick(); ", 0.05, null, null);
}


function Touch()
{
    PLAYERS.push(player(activator));
}

function EndTouch()
{
    if(PLAYERS.len() > 0)
    {
        for (local i = 0; i < PLAYERS.len(); i++)
        {
            if(PLAYERS[i].handle == activator)PLAYERS.remove(i);
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

function OnPostSpawn()
{
    Enable();
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