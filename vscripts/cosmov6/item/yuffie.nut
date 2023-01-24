Forward <- false;
Back <- false;
Right <- false;
Left <- false;
Attack1 <- false;
Attack2 <- false;
bAttack2 <- false;
//TICKRATE    <- 0.05
Owner <- null;

Effect <- null;
Rock <- null;
// Rock_CD <- 0.1;
Rock_CD <- 12.0;
Rock_CAN <- true;
au <- true;
g_bBlockRope <- false;

g_bTicking <- false;
g_bFlyTime <- 0.0;
g_vecHookOrigin_Start <- Vector();
g_vecHookOrigin_End <- Vector();
g_hArray <- null;

g_fDistance_Grab <- 550.0;
// g_fDistance_Grab <- 2550.0;

g_fSpeed <- 1000.0;
g_fDistance <- 56.0;
g_fTimeMax <- g_fDistance_Grab / g_fSpeed;
g_fDistance_UpBoost <- 300;
g_fUnGrab_Velocity <- 0.75;

function PickUp()
{
    if(activator.GetTeam() == 2 ||
    MainScript.GetScriptScope().GetItemByOwner(activator) != null)
        return;
    Owner = activator;
    Owner.SetHealth(225);
    Owner.SetMaxHealth(225);
    EntFireByHandle(MainScript, "RunScriptCode", "GetItemByButton(caller).NewOwner(GetPlayerClassByHandle(activator));", 0.00, Owner, self);
    caller.Destroy();

    ReplaceKnife();
    SetSkinParametr();

    Freeze();
    SetAnimation(anim_Ultimate);
    Spawning = true;

    Tick();
}

function Tick()
{
    try
    {
        if(Owner == null || !Owner.IsValid() || Owner.GetHealth() <= 0 || Owner.GetTeam() != 3)
            return SetDeath();

        if(!Spawning && !Casting)
        {
            if(!Jumping)
            {
                // if(TraceLine(Owner.GetOrigin(),GVO(Owner.GetOrigin(),0,0,-48),Hbox)!=1.00)
                //     SetJumpEnd()
                // else
                //     SetFalling()

                if(!g_bTicking)
                {
                    if(Forward || Back || Right || Left)
                    {
                        SetRun();
                    }
                    else
                    {
                        SetIdel();
                    }
                }
            }
        }

        if (g_bTicking)
        {
            if (GetDistance3D(g_vecHookOrigin_Start, Owner.GetOrigin()) < g_fDistance)
            {
                Owner.SetVelocity(Vector(0, 0, g_fDistance_UpBoost));
                UnHook();
            }
            else if (g_bFlyTime > g_fTimeMax)
            {
                UnHook();
            }
            else
            {
                local dir = (g_vecHookOrigin_Start - Owner.GetOrigin());
                dir.Norm();
                local vel = (dir * g_fSpeed);
                Owner.SetVelocity(vel);

                g_bFlyTime += 0.05;
            }
        }
        //printDebug();
        EntFireByHandle(self, "RunScriptCode", "Tick();", 0.05, null, null);
    }
    catch(error)
    {
        return SetDeath();
    }
}

function SetDeath()
{
    UnFreeze();
    if(Owner != null && Owner.IsValid() && Owner.GetHealth() > 0)
    {
        EntFireByHandle(self,"Deactivate","",0,null,null);
        EntFireByHandle(Freeze, "ModifySpeed", "1", 0, Owner, Owner);
        EntFireByHandle(Owner, "SetDamageFilter", "", 0.00, null, null);
        EntFireByHandle(Owner, "AddOutput", "rendermode 0", 0.00, null, null);
        EntFireByHandle(Owner, "SetHealth", "-1", 0.02, null, null);
    }
    RemoveHook();
    // for (local i = 0; i < Model.len(); i++)
    // {
    //     if(Model[i].IsValid())
    //         Model[i].Destroy();
    // }
    Hbox.Destroy();
}

ShurikenData <- [];

function ShurikenDataInit()
{
    CreateShuriken(ShurikenData[0][0], ShurikenData[0][1], ShurikenData[0][2], ShurikenData[0][3]);
    ShurikenData.remove(0);
    MainScript.GetScriptScope().Boss_Damage_Item("shuriken");
}

function TryToHook()
{
    if(!Rock_CAN ||
    Spawning ||
    Casting ||
    g_bTicking)
    {
        return;
    }

    if (Back)
    {
        Rock_CAN = false
        local item = GetItemNameIndexByOwner(Owner);
        local delay = 1.4;
        local dir = g_hEye.GetForwardVector();
        for (local i = 0; i < 4; i++)
        {
            ShurikenData.push([Owner, Hbox, dir - Vector(RandomFloat(-0.1, 0.1), RandomFloat(-0.1, 0.1), RandomFloat(-0.1, 0.1)), item]);
            EntFireByHandle(self, "RunScriptCode", "ShurikenDataInit();", 0 + delay, null, null);
            delay += RandomFloat(0.05, 0.1);
        }

        Casting = true;
        EntFireByHandle(Model,"SetAnimation","suricen",0,null,null);
        EntFireByHandle(Model,"SetAnimation","suricen2",0.55,null,null);
        EntFireByHandle(Model,"SetAnimation","suricen3",1.0,null,null);
        EntFireByHandle(Owner, "AddOutPut", "movetype 5", 0, null, null);
        EntFireByHandle(Owner, "AddOutPut", "movetype 1", 2.6, null, null);

        EntFireByHandle(self, "RunScriptCode", "Casting = false;", 3.0, null, null);
        if (item == -1)
        {
            EntFireByHandle(self, "RunScriptCode", "Rock_CAN = true;", 25, null, null);
            EntFireByHandle(MainScript, "RunScriptCode", "StartCD(25);", 0.00, Owner, self);
        }
        else
        {
            EntFireByHandle(self, "RunScriptCode", "Rock_CAN = true;", 45, null, null);
            EntFireByHandle(MainScript, "RunScriptCode", "StartCD(45);", 0.00, Owner, self);
        }
        return;
    }

    if (g_bBlockRope)
    {
        return;
    }

    // Freeze();
    // SetAnimation(anim_Ultimate);
    // Spawning = true;

    // EntFireByHandle(Effect,"Start","",0,null,null);
    // EntFireByHandle(Rock,"Forcespawn","",2,null,null);
    // EntFireByHandle(Effect,"Stop","",3,null,null);

    local vecOrigin = Trace(Owner.EyePosition(), g_hEye.GetForwardVector(), 10000, Hbox);
    if (GetDistance3D(vecOrigin, Owner.EyePosition()) > g_fDistance_Grab)
    {
        return;
    }
    Rock_CAN = false

    Idling = false;
    Running = false;


    SetAnimation("jump1");
    SetDefAnimation("jump1");

    g_vecHookOrigin_Start = vecOrigin;
    g_vecHookOrigin_End = Owner.EyePosition();
    CreateRope(self);

    local vel = Owner.GetVelocity();
    local dir = g_hEye.GetForwardVector();
    dir.Norm();
    if (vel.z < 10)
    {
        Owner.SetVelocity(Vector(dir.x, dir.y, 320));
    }

    g_bTicking = true;
    g_bFlyTime = 0.0;
}

function UnHookPre()
{
    if (Spawning)
    {
        return;
    }

	if (g_bTicking)
	{
		local vel = Owner.GetVelocity();
		vel.x = vel.x * g_fUnGrab_Velocity;
		vel.y = vel.y * g_fUnGrab_Velocity;
		vel.z = vel.z * g_fUnGrab_Velocity;
		Owner.SetVelocity(vel);
        UnHook();
	}

}

function RemoveHook()
{
    foreach (enitity in g_hArray)
    {
        if (enitity != null &&
        enitity.IsValid())
        {
            EntFireByHandle(enitity, "Kill", "", 0, null, null);
        }
    }
}

function UnHook()
{
    RemoveHook();
    EntFireByHandle(self, "RunScriptCode", "Rock_CAN = true;", Rock_CD, null, null);
    EntFireByHandle(MainScript, "RunScriptCode", "StartCD(" + Rock_CD + ");", 0.00, Owner, self);

    if(!Spawning && !Casting)
    {
        SetIdel();
    }

	g_bTicking = false;
}
//////////////////////
//    Anims Block   //
//////////////////////
Casting <- false;
Running  <- false;
Idling  <- false;
Spawning<- false;
FlyIng  <- false;
Jumping <- false;
FlyEnd <- true;

anim_Attack         <- "attack";

anim_Idle           <- "idle";
anim_Run_Start      <- "run1";
anim_Run_Idle       <- "run2";

anim_Jump_Start     <- "jump2";
anim_Jump_Idle      <- "falling";
anim_Jump_End       <- "jump3";

anim_Ultimate       <- "item";
/*
attack - атака

jump
fall_up - призимление
falling - падение зацикленное

idle

run - старт анимки
run01 - бег зацикленное
takedamage
voi - ульта
*/
function AnimComplete()
{
    if(Owner == null)return;
    if(Spawning)
    {
        Spawning = false;
        UnFreeze();
        return;
    }
    if(Jumping)
    {
        Jumping = false;
        return;
    }
    if(FlyEnd && FlyIng)
    {
        Running = false;
        Idling = false;
        FlyIng = false;
        return;
    }
}

function SetRun()
{
    Idling = false;
    if(!Running)
    {
        SetDefAnimation(anim_Run_Idle);
        SetAnimation(anim_Run_Start);
    }
    Running = true;
}

function SetJumpStart()
{
    //FlyIng = true;
    //FlyEnd = false;

    if(!Jumping)
    {
        SetDefAnimation(anim_Jump_Idle);
        SetAnimation(anim_Jump_Start);
    }
    Jumping = true;
}

function SetFalling()
{
    FlyEnd = false;
    if(!FlyIng)
    {
        SetDefAnimation(anim_Jump_Idle);
        SetAnimation(anim_Jump_Idle);
    }
    FlyIng = true;
}

function SetJumpEnd()
{
    if(!FlyEnd && FlyIng)
    {
        SetDefAnimation(anim_Idle);
        SetAnimation(anim_Jump_End);
    }
    FlyEnd = true;
}

function SetIdel()
{
    Running = false;
    if(!Idling)
    {
        SetDefAnimation(anim_Idle);
        SetAnimation(anim_Idle);
    }
    Idling = true;
}

function Freeze()
{
   Owner.__KeyValueFromInt("movetype" 5);
}

function UnFreeze()
{
   Owner.__KeyValueFromInt("movetype" 1);
}

function ReplaceKnife()
{
    local knife = null;
    while((knife = Entities.FindByClassname(knife,"weapon_knife")) != null)
    {
        if(knife.GetOwner() == Owner)
        {
            knife.Destroy();
            break;
        }
    }
    Knife.SetOrigin(Owner.GetOrigin());
}

function GetStatus()
{
    if(!au)
    {
        return false;
    }
    else
    {
        return true;
    }
}

function CreateRopeCallBack(entities)
{
    g_hArray = entities;
    EntFireByHandle(g_hArray[0], "Toggle", "", 0, null, null);
    g_hArray[1].SetOrigin(g_vecHookOrigin_Start);
    EntFireByHandle(g_hArray[2], "SetParent", "!activator", 0.05, Model, Model);
    g_hArray[2].SetOrigin(g_vecHookOrigin_End);
}

function SetSkinParametr()
{
    Owner.__KeyValueFromInt("rendermode" 10);

    // for (local i = 0; i < Model.len(); i++)
    // {
        EntFireByHandle(Model, "SetGlowDisabled", "", 0, null, null);
    // }
    Hbox.SetOwner(Owner);
    EntFireByHandle(Hbox, "SetDamageFilter", "filter_zombies", 0, null, null);
    EntFireByHandle(Owner, "SetDamageFilter", "filter_no_zombie", 0, null, null);
    EntFireByHandle(self, "Activate", "", 0, Owner, Owner);
}

function printDebug()
{
    local message = "Forward ";
    message += (Forward) ? "+" : "-";
    message += "\nBack "
    message += (Back) ? "+" : "-";
    message += "\nRight "
    message += (Right) ? "+" : "-";
    message += "\nLeft "
    message += (Left) ? "+" : "-";
    message += "\nIdling "
    message += (Idling) ? "+" : "-";
    message += "\nRunning "
    message += (Running) ? "+" : "-";
    message += "\nFlyIng "
    message += (FlyIng) ? "+" : "-";
    message += "\nJumping "
    message += (Jumping) ? "+" : "-";
    message += "\nFlyEnd "
    message += (FlyEnd) ? "+" : "-";
    ScriptPrintMessageCenterAll(message);
}

//////////////////////
//   Handle block   //
//////////////////////
Model <- null;
Hbox <- null;
Knife <- null;
g_hEye <- null;

function SetHandle()
{
    local name = caller.GetName();
    local clas = caller.GetClassname();
    if(clas == "prop_dynamic_glow")
    {
        Model = caller;
    }
    else if(clas == "func_physbox_multiplayer")
    {
        Hbox = caller;
    }
    else if(clas == "weapon_knife")
    {
        Knife = caller;
    }
    else if(clas == "func_door")
    {
        g_hEye = caller;
    }
}
function SetDefAnimation(animationName)
{
    // for (local i = 0; i < Model.len(); i++)
    // {
        EntFireByHandle(Model,"SetDefaultAnimation",animationName.tostring(),0.01,null,null);
    // }
}

function SetAnimation(animationName)
{
    // for (local i = 0; i < Model.len(); i++)
    // {
        EntFireByHandle(Model,"SetAnimation",animationName.tostring(),0.00,null,null);
    // }
}


function InSight(start,target){if(TraceLine(start,target,self)<1.00)return false;return true;}
function GVO(vec,_x,_y,_z){return Vector(vec.x+_x,vec.y+_y,vec.z+_z);}
::Trace <- function(origin, dir, distance = 4096, filter = null)
{
	return  origin + (dir * (distance * TraceLine(origin, origin + dir * distance, filter)));
}

::GetDistance3D <- function(v1, v2){return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));}

function OnPostSpawn()
{ 
    EntFireByHandle(MainScript, "RunScriptCode", "ITEM_OWNER.push(ItemOwner(caller))", 0.05, self, self);
}