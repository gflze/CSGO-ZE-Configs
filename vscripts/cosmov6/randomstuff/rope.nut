PLAYERS <- [];

start_pos <- EntityGroup[0].GetOrigin() - Vector(0, 0, 80);
end_pos <- EntityGroup[1].GetOrigin() - Vector(0, 0, 80);

grab_radius <- null;
ungrab_radius <- null;
grab_pos <- null;
ungrab_pos <- null;
speed <- null;

PlayerMax <- null;

movevector <- null;

timer_text <- 0.0;
tickrate_text <- 0.5;
ticking <- false;
tickrate <- 0.05;

function OnPostSpawn()
{
    LoadPreset();
    EntFireByHandle(self, "RunScriptCode", "Start();", tickrate, null, null);
}

function LoadPreset()
{
    EntFireByHandle(self, "FireUser1", "", 0.00, null, null);
    EntFireByHandle(EntityGroup[2], "AddOutPut", "renderfx 17", 0.00, null, null);
}

function Start()
{
    if(grab_pos == null || ungrab_pos == null || movevector == null)
        SetGrabUnGrabPos();
    if(grab_radius == null || ungrab_radius == null)
        SetGrabUnGrabRadius();
    if(speed == null)
        SetSpeed();
    if(PlayerMax == null)
        SetMaxPlayers();

    ticking = true;
    EntFireByHandle(self, "RunScriptCode", "Tick(); ", tickrate, null, null);
}

function SetMaxPlayers(i = 8)
{
    PlayerMax = i;
}

function SetGrabUnGrabPos(new_grab_vector = Vector(0,0,-80), new_ungrab_vector = Vector(0,0,-80))
{
    grab_pos = EntityGroup[0].GetOrigin() + new_grab_vector;
    ungrab_pos = EntityGroup[1].GetOrigin() + new_ungrab_vector;
    EntityGroup[2].SetOrigin(grab_pos);
    CompareDir();
}

function SetGrabUnGrabRadius(new_grab_radius = 60,  new_ungrab_radius = 64)
{
    grab_radius = new_grab_radius;
    ungrab_radius = new_ungrab_radius;
}
function SetSpeed(nspeed = 40)
{
    speed = nspeed;
}
function CompareDir()
{
    movevector = start_pos - end_pos;
    movevector.Norm();
}

function Tick()
{
    if(!ticking)
        return;

    //Debug();

    Search();
    if(CheckPlayers())
    {
        SelfBreak();
        return;
    }
        
    MovePlayers();
    ShowTextPlayers();

    EntFireByHandle(self, "RunScriptCode", "Tick();", tickrate, null, null);
}

function ShowTextPlayers()
{
    timer_text += tickrate;
    if(timer_text >= tickrate_text)
    {
        timer_text = 0;
        foreach(player in PLAYERS)
        {
            EntFire("rope_text", "Display", "", 0, player);
        }
    }
}

function Debug()
{
    //DrawBoundingBox(Trigger);
    DebugDrawCircle(grab_pos, Vector(0,255,0), grab_radius, 16, true, tickrate + 0.01);
    DebugDrawCircle(ungrab_pos, Vector(255,0,0), grab_radius, 16, true, tickrate + 0.01);
}

function SelfBreak()
{
    EntityGroup[2].Destroy();
    self.Destroy();
}

function CheckPlayers()
{
    if(PlayerMax < PLAYERS.len())
    {
        ticking = false;
        foreach(p in PLAYERS)
        {
            UnFreeze(p);
        }
        EntFireByHandle(self, "Kill", "", tickrate, null, null);
        return true;
    }
    return false;
}

function MovePlayers()
{
    for(local i = 0; i < PLAYERS.len(); i++)
    {
        if(!(PLAYERS[i]).IsValid())
        {
            PLAYERS.remove(i);
            continue;
        }

        if((PLAYERS[i]).GetHealth() <= 0)
        {
            PLAYERS.remove(i);
            continue;
        }

        if((PLAYERS[i]).GetBoundingMaxs().z <= 54)
        {
            (PLAYERS[i]).SetVelocity(movevector * speed * -20);
            UnFreeze((PLAYERS[i]));
            PLAYERS.remove(i);
            continue;
        }

        local ppos = (PLAYERS[i]).GetOrigin();

        if(GetDistance(ungrab_pos, ppos) <= ungrab_radius)
        {
            (PLAYERS[i]).SetVelocity(Vector(0,0,0));
            UnFreeze((PLAYERS[i]));
            PLAYERS.remove(i);
            continue;
        }

        PLAYERS[i].SetOrigin((PLAYERS[i]).GetOrigin() - movevector * speed);
    }
}

function RemoveFromRope(handle)
{
    for(local i = 0; i < PLAYERS.len(); i++)
    {
        if(PLAYERS[i] == handle)
        {
            (PLAYERS[i]).SetVelocity(Vector(0,0,0));
            UnFreeze((PLAYERS[i]));
            PLAYERS.remove(i);
            return;
        }
    }
}

function Search()
{
    local p = [];
    local h = null;

    local waffel_car = Entities.FindByName(null, "waffel_controller");
    local waffel_class
    while(null != (h = Entities.FindInSphere(h, grab_pos ,grab_radius)))
    {
        if(h == null)
            continue;
        if(!h.IsValid())
            continue;
        if(h.GetClassname() != "player")
            continue;
        if(h.GetHealth() <= 0)
            continue;
        waffel_class = waffel_car.GetScriptScope().GetClassByInvalid(h)
        if(waffel_class != null)
            if(waffel_class.driver != null)
                continue;
        EntFire("rope_text", "Display", "", 0, h);
        p.push(h);
    }

    if(p.len() < 0)
        return;

    for(local i = 0; i < p.len();i++)
    {
        if(InArray(p[i]))
        {
            p.remove(i);
        }
    }

    if(p.len() <= 0)
        return;

    h = p[RandomInt(0, p.len() - 1)];


    Freeze(h)
    h.SetOrigin(start_pos - movevector * 32);
    PLAYERS.push(h)
}
function InArray(handle)
{
    foreach(p in PLAYERS)
    {
        if(p == handle)
            return true;
    }
    return false;
}
function Freeze(player)
{
   player.__KeyValueFromInt("movetype" 0);
}
function UnFreeze(player)
{
   player.__KeyValueFromInt("movetype" 1);
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
function DebugDrawCircle(Vector_Center, Vector_RGB, radius, parts, zTest, duration) //0 -32 80
{
    local u = 0.0;
    local vec_end = [];
    local parts_l = parts;
    local radius = radius;
    local a = PI / parts * 2;
    while(parts_l > 0)
    {
        local vec = Vector(Vector_Center.x+cos(u)*radius, Vector_Center.y+sin(u)*radius, Vector_Center.z);
        vec_end.push(vec);
        u += a;
        parts_l--;
    }
    for(local i = 0; i < vec_end.len(); i++)
    {
        if(i < vec_end.len()-1){DebugDrawLine(vec_end[i], vec_end[i+1], Vector_RGB.x, Vector_RGB.y, Vector_RGB.z, zTest, duration);}
        else{DebugDrawLine(vec_end[i], vec_end[0], Vector_RGB.x, Vector_RGB.y, Vector_RGB.z, zTest, duration);}
    }
}
function DrawBoundingBox(ent, color = Vector(255, 0, 255))
{
    local origin = ent.GetOrigin();

    local max = ent.GetBoundingMaxs();
    local min = ent.GetBoundingMins();

    local rV = ent.GetLeftVector();
    local fV = ent.GetForwardVector();
    local uV = ent.GetUpVector();

    local TFR = origin + uV * max.z + rV * max.y + fV * max.x;
    local TFL = origin + uV * max.z + rV * min.y + fV * max.x;

    local TBR = origin + uV * max.z + rV * max.y + fV * min.x;
    local TBL = origin + uV * max.z + rV * min.y + fV * min.x;

    local BFR = origin + uV * min.z + rV * max.y + fV * max.x;
    local BFL = origin + uV * min.z + rV * min.y + fV * max.x;

    local BBR = origin + uV * min.z + rV * max.y + fV * min.x;
    local BBL = origin + uV * min.z + rV * min.y + fV * min.x;


    DebugDrawLine(TFR, TFL, color.x, color.y, color.z, true, tickrate + 0.01);
    DebugDrawLine(TBR, TBL, color.x, color.y, color.z, true, tickrate + 0.01);

    DebugDrawLine(TFR, TBR, color.x, color.y, color.z, true, tickrate + 0.01);
    DebugDrawLine(TFL, TBL, color.x, color.y, color.z, true, tickrate + 0.01);

    DebugDrawLine(TFR, BFR, color.x, color.y, color.z, true, tickrate + 0.01);
    DebugDrawLine(TFL, BFL, color.x, color.y, color.z, true, tickrate + 0.01);

    DebugDrawLine(TBR, BBR, color.x, color.y, color.z, true, tickrate + 0.01);
    DebugDrawLine(TBL, BBL, color.x, color.y, color.z, true, tickrate + 0.01);

    DebugDrawLine(BFR, BBR, color.x, color.y, color.z, true, tickrate + 0.01);
    DebugDrawLine(BFL, BBL, color.x, color.y, color.z, true, tickrate + 0.01);

    DebugDrawLine(BFR, BFL, color.x, color.y, color.z, true, tickrate + 0.01);
    DebugDrawLine(BBR, BBL, color.x, color.y, color.z, true, tickrate + 0.01);
}
function GetDistance(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));