map_brush <- Entities.FindByName(null, "map_brush");

PLAYERS <- [];
ticking <- false;

dist <- 0;
damage <- 0;
slow <- 0;

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
            if(p.IsValid() && p.GetTeam() == 2 && p.GetHealth() > 0 )
            {
                local spos = self.GetOrigin();
                local apos = p.GetOrigin();
                if(GetDistance2D(spos,apos) <= dist)
                {
                    EntFireByHandle(map_brush, "RunScriptCode", "DamagePlayer("+damage+",::item)", 0, p, p);

                    if(GetDistanceZ(spos,apos) >= self.GetBoundingMaxs().z * 0.025)
                    {
                        p.SetVelocity(Vector(0,0,450));
                    }
                    else EntFireByHandle(map_brush, "RunScriptCode", "SlowPlayer("+slow+",0.12)", 0.2, p, p);
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
function GetDistanceZ(v1,v2)return v1.z - v2.z;

function DrawAxis(pos,s = 16,nocull = true,time = 4)
{
	DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 0, 255, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y,pos.z-s), Vector(pos.x,pos.y,pos.z+s), 0, 0, 255, nocull, time);
}
