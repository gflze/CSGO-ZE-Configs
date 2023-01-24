Forward <- false;
Back    <- false;
Right   <- false;
Left    <- false;
Attack1 <- false;
Attack2 <- false;

//TICKRATE    <- 0.05
Owner <- null;

Effect <- null;
Rock <- null;
Rock_CD <- 30.0;
Rock_CAN <- true;
au <- true;

function PickUp()
{
    if(activator.GetTeam() == 2 ||
    MainScript.GetScriptScope().GetItemByOwner(activator) != null)
        return;
    Owner = activator;
    Owner.SetHealth(300);
    Owner.SetMaxHealth(300);
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

        if(!Spawning)
        {
            if(!Jumping)
            {
                // if(TraceLine(Owner.GetOrigin(),GVO(Owner.GetOrigin(),0,0,-48),Hbox)!=1.00)
                //     SetJumpEnd()
                // else
                //     SetFalling()

                //if(!FlyIng && FlyEnd)
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
                if(Attack1 || Attack2)EntFireByHandle(self, "RunScriptCode", "Attack();", 0.05, null, null);
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
    for (local i = 0; i < Model.len(); i++)
    {
        if(Model[i].IsValid())
            Model[i].Destroy();
    }
    Hbox.Destroy();
}

function Attack()
{
    if(!au)return;
    if(Casting)return;
    if(Attack2 && Rock_CAN)
    {
        Idling = false;
        Running = false;
        Rock_CAN = false

        Freeze();

        SetPlayBack(1.5);
        SetAnimation(anim_Ultimate);
        Spawning = true;


        EntFireByHandle(Effect,"Start","",0,null,null);
        EntFireByHandle(Rock,"Forcespawn","",2,null,null);
        EntFireByHandle(Effect,"Stop","",3,null,null);
        EntFireByHandle(self, "RunScriptCode", "Rock_CAN = true;", Rock_CD, null, null);

        EntFireByHandle(MainScript, "RunScriptCode", "StartCD(" + Rock_CD + ");", 0.00, Owner, self);
        return;
    }
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
anim_Run_Start      <- "run";
anim_Run_Idle       <- "run01";

anim_Jump_Start     <- "jump";
anim_Jump_Idle      <- "falling";
anim_Jump_End       <- "fall_up";

anim_Ultimate       <- "voi";
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
    if(Casting)
    {
        Casting = false;
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
        //SetDefAnimation(anim_Jump_Idle);
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

function SetSkinParametr()
{
    Owner.__KeyValueFromInt("rendermode" 10);

    for (local i = 0; i < Model.len(); i++)
    {
        EntFireByHandle(Model[i], "SetGlowDisabled", "", 0, null, null);
    }
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
Model <- [];
Hbox <- null;
Knife <- null;

function SetHandle()
{
    local name = caller.GetName();
    local clas = caller.GetClassname();
    if(clas == "prop_dynamic_glow")
    {
        Model.push(caller);
    }
    else if(clas == "func_physbox_multiplayer")
    {
        Hbox = caller;
    }
    else if(clas == "weapon_knife")
    {
        Knife = caller;
    }
}
function SetDefAnimation(animationName)
{
    for (local i = 0; i < Model.len(); i++)
    {
        EntFireByHandle(Model[i],"SetDefaultAnimation",animationName.tostring(),0.01,null,null);
    }
}
function SetPlayBack(rate)
{
    for (local i = 0; i < Model.len(); i++)
    {
        EntFireByHandle(Model[i],"setplaybackrate",rate.tostring(),0.00,null,null);
    }
}

function SetAnimation(animationName)
{
    for (local i = 0; i < Model.len(); i++)
    {
        EntFireByHandle(Model[i],"SetAnimation",animationName.tostring(),0.00,null,null);
    }
}


function InSight(start,target){if(TraceLine(start,target,self)<1.00)return false;return true;}
function GVO(vec,_x,_y,_z){return Vector(vec.x+_x,vec.y+_y,vec.z+_z);}

function OnPostSpawn()
{
    EntFireByHandle(MainScript, "RunScriptCode", "ITEM_OWNER.push(ItemOwner(caller))", 0.05, self, self);
}