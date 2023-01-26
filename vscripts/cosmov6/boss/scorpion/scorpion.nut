g_hTeleported <- null;
g_oTeleported <- Vector(0, 0, 0);
g_fTimer_TakeTime <- 0.0;
g_fTimer_fTime_Skip <- 0.0;
g_bTake <- false;
g_bEnd <- false;

const TICKRATE = 0.5;

::class_pos <- class
{
    origin = Vector();
    ox = 0;
    oy = 0;
    oz = 0;
    angles = Vector();
    ax = 0;
    ay = 0;
    az = 0;

    constructor(_origin = Vector(), _angles = Vector())
    {
        this.origin = _origin;
        this.ox = _origin.x;
        this.oy = _origin.y;
        this.oz = _origin.z;

        this.angles = _angles;
        this.ax = _angles.x;
        this.ay = _angles.y;
        this.az = _angles.z;
    }
}

g_vPos_Gargantua_PickUp <- class_pos(Vector(-4408, 2442, 1628), Vector(0, 0, 0));
g_fTime_TakeTime <- 5;
g_fTime_Skip <- 31;

ARRAY_BEST_INFECTORS <- [];

EntFireByHandle(self, "RunScriptCode", "Init();", 0.01, null, null);

function Camera()
{
    EntFire("scorpion_knife", "addoutput", "angles 0 180", 1);
    EntFire("Camera_old", "RunScriptCode", "SpawnCameras(Vector(-5764,2150,1900),Vector(10,45,10),0.5,Vector(-4846,2428,1652),Vector(0,0,0),1,4)", 0);
    //o1, a1, time1, o2, a2, time2, flytime
}

function Init()
{
    g_fTime_TakeTime = 0.00 + g_fTime_TakeTime;
    g_fTime_Skip = 0.00 + g_fTime_Skip;

    g_fTimer_TakeTime = g_fTime_TakeTime;
}

function Start()
{
    GenerateBestInfectors();

    g_bTake = false;
    Tick();
}

function PickUp()
{
    g_bTake = true;
    g_bBossFight = true;

    local handle;
    foreach(p in PLAYERS)
    {
        handle = p.handle;

        if(!handle.IsValid() ||
        handle.GetHealth() < 1 ||
        handle.GetTeam() != 3 ||
        p.mike ||
        p.yuffi)
        {
            continue;
        }
        EntFireByHandle(handle, "SetDamageFilter", "filter_no_zombie", 0, null, null);
    }
}

function Tick()
{
    if(g_bTake)
        return;

    g_fTimer_TakeTime += TICKRATE;
    if(g_fTimer_TakeTime >= g_fTime_TakeTime)
    {
        g_fTimer_TakeTime = 0.0;

        if(g_hTeleported != null && g_hTeleported.IsValid())
        {
            g_hTeleported.SetOrigin(g_oTeleported.origin);
            g_hTeleported.SetAngles(g_oTeleported.ax, g_oTeleported.ay, g_oTeleported.az);
        }

        g_hTeleported = GetBestInfector();

        if(g_hTeleported == null)
            return End();

        g_oTeleported = class_pos(g_hTeleported.GetOrigin(), g_hTeleported.GetAngles());

        g_hTeleported.SetOrigin(g_vPos_Gargantua_PickUp.origin);
        g_hTeleported.SetAngles(g_vPos_Gargantua_PickUp.ax, g_vPos_Gargantua_PickUp.ay, g_vPos_Gargantua_PickUp.az);
    }

    g_fTimer_fTime_Skip += TICKRATE;
    if(g_fTimer_fTime_Skip >= g_fTime_Skip)
    {
        if(g_hTeleported != null && g_hTeleported.IsValid())
            g_hTeleported.SetOrigin(g_oTeleported);
        return End();
    }

    EntFireByHandle(self, "RunScriptCode", "Tick();", TICKRATE, null, null);
}
function End()
{
    if(g_bEnd)
        return;
    g_bEnd = true;
    g_bBossFight = false;

    local handle;
    foreach(p in PLAYERS)
    {
        handle = p.handle;

        if(!handle.IsValid() ||
        handle.GetHealth() < 1 ||
        handle.GetTeam() != 3 ||
        p.mike ||
        p.yuffi)
        {
            continue;
        }
        EntFireByHandle(handle, "SetDamageFilter", "", 0, null, null);
    }

	EntFire("Mine_Scorpion_ZM_TP", "Enable", "", 5);
	EntFire("map_brush", "RunScriptCode", "Mine_Door4();", 5);
}


function GenerateBestInfectors()
{
    ARRAY_BEST_INFECTORS.clear();

    foreach(p in PLAYERS)
    {
        local handle = p.handle;
        if(handle == null || !handle.IsValid()  || handle.GetTeam() != 2){continue;}
        ARRAY_BEST_INFECTORS.push(p);
    }

    ARRAY_BEST_INFECTORS.sort(Infector_SortFunction);
}


function Infector_SortFunction(first, second)
{
    if(first.infect > second.infect){return -1;}
    if(first.infect < second.infect){return 1;}
    return 0;
}

function GetBestInfector()
{
    local i = ARRAY_BEST_INFECTORS.len() - 1;
    local infector = null;

    for(; i >= 0; i--)
    {
        local handle = ARRAY_BEST_INFECTORS[i].handle;

        if(handle == null || !handle.IsValid()  || handle.GetTeam() != 2){continue;}

        infector = handle;
        ARRAY_BEST_INFECTORS.remove(i);

        break;
    }

    return infector;
}