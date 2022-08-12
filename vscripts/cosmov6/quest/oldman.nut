tickrate <- 0.2;
ticking <- false;
Owner <- null;

Move <- self;
Path <- null;
Button <- null;
Model <- null;

function SetHandle()
{
    local ClassName = caller.GetClassname();

    if(ClassName == "func_button")
    {
        Button = caller;
    }
    else if(ClassName == "path_track")
    {
        Path = caller;
    }
    else if(ClassName == "func_tracktrain")
    {
        Move = caller;
    }
    else if(ClassName == "prop_dynamic_glow")
    {
        Model = caller;
    }
}

function SetOwner()
{
    Owner = activator;

    EntFireByHandle(Button, "Lock", "", 0, null, null);
    Button.SetOrigin(Vector(0,0,0));

    ticking = true;
    Tick();
}

function ClearOwner()
{
    Owner = null;
    ticking = false;

    EntFireByHandle(Button, "UnLock", "", 0, null, null);
    Button.SetOrigin(Model.GetOrigin());
}

function Tick()
{
    if(!ticking)
        return;

    if(Owner == null)
        return ClearOwner();

    if(!Owner.IsValid())
        return ClearOwner();

    if(Owner.GetHealth() <= 0)
        return ClearOwner();

    EntFireByHandle(self, "RunScriptCode", "Tick();", tickrate, null, null);

    Path.SetOrigin(Owner.GetOrigin());
    if(GetDistance(Owner.GetOrigin(), self.GetOrigin()) >= 100)
        EntFireByHandle(Move, "StartForward", "", 0.00, null, null);
    else
        EntFireByHandle(Move, "Stop", "", 0.00, null, null);
}

anim_Dead <- "avoid";

anim_Chil <- "chair";
anim_Chilidle <- "chair_idle";

anim_Idle <- "idle";

anim_Walk <- "walk";
anim_Walkrandom <- "walk01";

function SetDefAnimation(animationName)
{
    EntFireByHandle(Model,"SetDefaultAnimation",animationName.tostring(),0.01,null,null);
}
function SetAnimation(animationName)
{
    EntFireByHandle(Model,"SetAnimation",animationName.tostring(),0.00,null,null);
}

function GetDistance(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));