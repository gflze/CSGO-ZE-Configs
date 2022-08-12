map_brush <- Entities.FindByName(null, "map_brush");
item_buff_radius <- false;

PLAYERS <- [];
ticking <- false;

dist <- 0;
power <- 0;
slow <- 0;

function Tick()
{
    if(!ticking)
    {
        foreach(p in PLAYERS)
        {
            foreach(p in PLAYERS)
            {
                if(p.IsValid() && p.GetTeam() == 2 && p.GetHealth() > 0)
                {
                    local spos = self.GetOrigin();
                    local apos = p.GetOrigin();
                    if(GetDistance2D(spos,apos) <= dist)
                    {
                        EntFireByHandle(map_brush, "RunScriptCode", "SlowPlayer("+power+","+slow+")", 0, p, p);
                        //DrawAxis(apos)
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
            if(p.IsValid() && p.GetTeam() == 2 && p.GetHealth() > 0)
            {
                local spos = self.GetOrigin();
                local apos = p.GetOrigin();
                if(GetDistance2D(spos,apos) <= dist)
                {
                    EntFireByHandle(map_brush, "RunScriptCode", "SlowPlayer("+power+",0.05)", 0, p, p);
                    //DrawAxis(apos)
                }
            }
        }
    }
    EntFireByHandle(self, "RunScriptCode", "Tick(); ", 0.05, null, null);
}

function Touch()
{
    PLAYERS.push(activator);
}

function EndTouch()
{
    if(PLAYERS.len() > 0)
    {
        for (local i = 0; i < PLAYERS.len(); i++)
        {
            if(PLAYERS[i] == activator)PLAYERS.remove(i);
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

function GetDistance2D(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y));