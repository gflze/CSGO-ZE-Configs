
camera_model <- "models/editor/camera.mdl"
camera_mover <- null;
camera_camera <- null;
camera_start <- null;
camera_end <- null;
CameraPos <- [];

class camerapos
{
    origin = null;
    angles = null;
    staytime = null;
    flytime = null;
    constructor(origin_, angles_, flytime_, staytime_)
    {
        this.origin = origin_;
        this.angles = angles_;
        this.flytime = flytime_;
        this.staytime = staytime_;
    }
}

EntFireByHandle(self, "RunScriptCode", "Init()", 0.01, null, null);

function Init()
{
    self.PrecacheModel(camera_model);

    EntFire("viewcontrol*", "Disable", "", 0.00, null);
    EntFire("viewcontrol*", "Kill", "", 0.01, null);

    EntFireByHandle(self, "RunScriptCode", "InitEnd()", 0.01, null, null);
}

function InitEnd()
{
    camera_camera = Entities.CreateByClassname("point_viewcontrol_multiplayer");
    camera_mover = EntityGroup[0];
    camera_start = EntityGroup[1];
    camera_end = EntityGroup[2];

    camera_camera.__KeyValueFromString("targetname", "viewcontrol");
    camera_camera.SetOrigin(camera_mover.GetOrigin());

    EntFireByHandle(camera_start, "SetParent", "!activator", 0.00, camera_mover, camera_mover);
    EntFireByHandle(camera_camera, "SetParent", "!activator", 0.00, camera_mover, camera_mover);

    EntFireByHandle(self, "RunScriptCode", "DrawC()", 0.05, camera_mover, camera_mover);
    EntFireByHandle(self, "RunScriptCode", "DrawC()", 0.05, camera_start, camera_start);
    EntFireByHandle(self, "RunScriptCode", "DrawC()", 0.05, camera_end, camera_end);
}

function PushCamera(origin = null, angles = null, flytime = 0.2, staytime = 1)
{
    if(origin == null)
        origin = activator.GetOrigin() + Vector(0, 0, 64);

    if(angles == null)
        angles = activator.GetAngles();

    CreateModel(origin, angles, 5, camera_model);
    CameraPos.push(camerapos(origin, angles, flytime, staytime))
}

function StartCamera()
{
    if(CameraPos.len() < 1)
        return;
    local origin;
    local angles;
    local time;
    local flytime;

    origin = CameraPos[0].origin;
    angles = CameraPos[0].angles;

    camera_end.SetOrigin(origin);
    camera_mover.SetOrigin(origin);
    camera_camera.SetAngles(angles.x, angles.y, angles.z);
    
    time = CameraPos[0].staytime;
    //EntFireByHandle(camera_camera, "Enable", "", 0, null, null);
    
    flytime = CameraPos[0].flytime;
    EntFireByHandle(self, "RunScriptCode", "CameraMoveNextPoint(" + 1 +")", flytime + time, null, null);
}

function CameraMoveNextPoint(index)
{
    local origin;
    local angles;
    local time;
    local flytime;
    local speed;

    origin = CameraPos[index].origin;
    angles = CameraPos[index].angles;

    // speed = GetDistance3D(camera_mover.GetOrigin(), origin);

    // camera_mover.__KeyValueFromInt("speed", speed);
    // camera_mover.__KeyValueFromInt("startspeed", speed);
    camera_start.SetOrigin(origin);

    EntFireByHandle(camera_mover, "startbackward", "", 0.00, null, null);

    time = CameraPos[index].staytime;
    flytime = CameraPos[index].flytime;

    if(CameraPos.len() > ++index)
        EntFireByHandle(self, "RunScriptCode", "CameraMoveNextPoint(" + index + ")", flytime + time, null, null);
    else
        EntFireByHandle(camera_camera, "Disable", "", flytime + time, null, null);
}

// function ChangeAnglesCamera(NeedAngles)
// {
//     local angles;
//     angles = camera_camera.GetAngles;
//     if(NeedAngles.x <= angles.x + 0.01)

//     else

// }


function ClearCamera()
{
    CameraPos.clear();
}

// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Support Function 
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
    function CreateModel(origin, angles, time, model)
    {
        local handle;
        handle = Entities.CreateByClassname("prop_dynamic");

        handle.SetAngles(angles.x ,angles.y ,angles.z);
        handle.SetOrigin(origin);
        handle.SetModel(camera_model);

        EntFireByHandle(handle, "Kill", "", time, null, null);
    }

    function DrawC()
    {
        DrawAxis(activator.GetOrigin(), 16, true, 0.21);
        EntFireByHandle(self, "RunScriptCode", "DrawC()", 0.2, activator, activator);
    }

    function DrawAxis(pos,s = 16,nocull = true,time = 1)
    {
        DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 0, nocull, time);
        DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 0, 255, 0, nocull, time);
        DebugDrawLine(Vector(pos.x,pos.y,pos.z-s), Vector(pos.x,pos.y,pos.z+s), 0, 0, 255, nocull, time);
    }

    function GetDistance3D(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z)); 
}
