
speed <- 10;
radius <- 2048;

target <- null;
target_mark <- self.GetMoveParent();

EntFireByHandle(self, "ClearParent", "", 0, null, null);

Hit_Box_L <- Entities.FindByName(null, "AirBuster_Hbox_H_L");
Hit_Box_H_L <- Entities.FindByName(null, "AirBuster_Hbox_H_L");
Hit_Box_H_R <- Entities.FindByName(null, "AirBuster_Hbox_H_R");
Hit_Box_C <- Entities.FindByName(null, "AirBuster_Hbox_C");
Hit_Box_U <- Entities.FindByName(null, "AirBuster_Hbox_L");

function OnPostSpawn()
{
    self.SetForwardVector(Vector(0,0,-1));
    local h = null;
    local array = [];

    while(null != (h = Entities.FindInSphere(h, self.GetOrigin(), radius)))
    {
        if(h == null)
            continue;

        if(!h.IsValid())
            continue;

        if(h.GetClassname() != "player")
            continue;

        if(h.GetHealth() <= 0)
            continue;

        if(h.GetTeam() == 1)
            continue;

        array.push(h);
    }

    if(array.len() <= 0)
    {
        printl("return")
        EntFireByHandle(self, "FireUser1", "", 0, null, null);
        return;
    }

    target = array[RandomInt(0, array.len() - 1)];
    EntFireByHandle(self, "RunScriptCode", "speed = 13;SetAngle();", 0.5, null, null);
    EntFireByHandle(self, "RunScriptCode", "MoveToTarget()", 0.05, null, null);
    EntFireByHandle(self, "RunScriptCode", "SetTargetMark()", 0.06, null, null);
}

function SetTargetMark()
{
    target_mark.SetOrigin(target.GetOrigin() + (target.GetForwardVector() * 5) + Vector(0, 0, 80));
    EntFireByHandle(target_mark, "ShowSprite", "", 0.02, null, null);
    EntFireByHandle(target_mark, "SetParent", "!activator", 0.02, target, target);
}


function SetAngle()
{
    if(self.IsValid())
    {
        local dir = self.GetOrigin()-(target.GetOrigin()+Vector(0,0,24));
        dir.Norm();
        self.SetForwardVector(dir);

        EntFireByHandle(self, "RunScriptCode", "SetAngle()", 0.2, null, null);
    }
}
function MoveToTarget()
{
    if(self.IsValid())
    {
        if(target == null || !target.IsValid() || target.GetHealth() <= 0.00 || target.GetTeam() == 1)
        {
            EntFireByHandle(self, "FireUser1", "", 0, null, null);
            return;
        }

        local so = self.GetOrigin();
        if(InSightArray(so, so - (self.GetForwardVector() * speed)))
        {
            EntFireByHandle(self, "FireUser1", "", 0, null, null);
            return;
        }

        self.SetOrigin(so - (self.GetForwardVector() * speed));
        EntFireByHandle(self, "RunScriptCode", "MoveToTarget()", 0.01, null, null);
    }
}

function InSight(start,target,handle){if(TraceLine(start,target,handle)<1.00)return false;return true;}
function InSightArray(start,target)
{
    local bool = true;

    if(InSight(start,target,Hit_Box_L))
        bool = false;
    if(InSight(start,target,Hit_Box_H_L))
        bool = false;
    if(InSight(start,target,Hit_Box_H_R))
        bool = false;
    if(InSight(start,target,Hit_Box_C))
        bool = false;
    if(InSight(start,target,Hit_Box_U))
        bool = false;

    if(bool)return true;
    return false;
}