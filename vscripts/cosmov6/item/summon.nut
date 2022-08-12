map_brush <- Entities.FindByName(null, "map_brush");

PLAYERS <- [];
ticking <- false;

dist <- 0;
power <- 0;
worktime <- 0;

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
                    p.SetVelocity(Vector(vec.x * power, vec.y * power, av.z));
                    if(ticking)EntFireByHandle(self, "RunScriptCode", "Disable();", worktime, null, null);
                }
            }
        }
    }
    EntFireByHandle(self, "RunScriptCode", "Tick(); ", 0.05, null, null);
}

function Touch()
{
    PLAYERS.push(activator);
    if(activator.GetTeam() == 2)
    {
        if(!Active)
            Enable();
    }
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
    EnablePre();
}
Active <- false;
Level <- null;
Particle1 <- null;
Particle2 <- null;
Particle3 <- null;
Model <- null;

function EnablePre()
{
    EntFireByHandle(self, "FireUser1", "", 0.00, null, null);
    EntFireByHandle(self, "RunScriptCode", "EnablePost()", 0.05, null, null);
}
function EnablePost()
{
    //EntFireByHandle(Model, "RunScriptCode", "Hide(1.00)", 0.01, null, null);
    EntFireByHandle(self, "RunScriptCode", "EnableLast()", 0.50, null, null);
}

function EnableLast()
{
    self.ConnectOutput("OnStartTouch", "Touch");
    self.ConnectOutput("OnEndTouch", "EndTouch");
    EntFireByHandle(self, "Enable", "", 0.01, null, null);
}

function Enable()
{
    Active = true;

    EntFireByHandle(Model, "SetAnimation", "idle2", 0.21, null, null);
    EntFireByHandle(Model, "SetDefaultAnimation", "idle2", 0.20, null, null);
    EntFireByHandle(Model, "RunScriptCode", "Spawn(0.5)", 0.01, null, null);
    EntFireByHandle(self, "RunScriptCode", "EnableFull()", 0.7, null, null);
}

function EnableFull()
{
    if(Level == 1)
        EntFireByHandle(Particle1, "Start", "", 0.01, null, null);
    else if(Level == 2)
        EntFireByHandle(Particle2, "Start", "", 0.01, null, null);
    else if(Level == 3)
        EntFireByHandle(Particle3, "Start", "", 0.01, null, null);

    ticking = true;
    Tick();    
}

function Disable()
{
    ticking = false;
    if(self.IsValid())    
    {
        self.DisconnectOutput("OnStartTouch", "Touch")
        self.DisconnectOutput("OnEndTouch", "EndTouch");
        EntFireByHandle(self, "Disable", "", 0.01, null, null);
    }
    SelfDestroy();
}

function SelfDestroy()
{
    if(ticking)
        return;
    if(self.IsValid())
        self.Destroy();

    if(Particle1.IsValid())
        Particle1.Destroy();

    if(Particle2.IsValid())
        Particle2.Destroy();

    if(Particle3.IsValid())
        Particle3.Destroy();

    if(Model.IsValid())
        EntFireByHandle(Model, "RunScriptCode", "Kill(3.00)", 0.01, null, null);
}


function GetDistance2D(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y));

function DrawAxis(pos,s = 16,nocull = true,time = 1)
{
	DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 0, 255, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y,pos.z-s), Vector(pos.x,pos.y,pos.z+s), 0, 0, 255, nocull, time);
}
