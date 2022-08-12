map_brush <- Entities.FindByName(null, "map_brush");

PLAYERS <- [];
ticking <- false;

dist <- 0;
power <- 0;

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
            if(p.IsValid() && p.GetTeam() == 2 && p.GetHealth() > 0)
            {
                local spos = self.GetOrigin();
                local apos = p.GetOrigin();
                if(GetDistance2D(spos,apos) <= dist)
                {
                    DrawAxis(apos);
                    local vec = (spos - apos) * -1;
                    local av = p.GetVelocity();
                    //local ang = p.GetAngles();
                    vec.Norm();
                    //p.SetAngles(ang.x,ang.y + 1,ang.z);
                    p.SetVelocity(Vector(vec.x * power, vec.y * power, vec.z * power));
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
function DrawAxis(pos,s = 16,nocull = true,time = 1)
{
	DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 0, 255, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y,pos.z-s), Vector(pos.x,pos.y,pos.z+s), 0, 0, 255, nocull, time);
}
