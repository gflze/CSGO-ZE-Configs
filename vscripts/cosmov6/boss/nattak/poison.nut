speed <- 12;
check <- false;

function OnPostSpawn()
{
    SearchTarget();
}

function SearchTarget()
{
    if(Global_Target != null && Global_Target.IsValid() && Global_Target.GetHealth() > 0 && Global_Target.GetTeam() == 3)
    {
        local dir = self.GetOrigin()-(Global_Target.GetOrigin()+Vector(0,0,24));
        dir.Norm();
        self.SetForwardVector(dir);

        CreateIgnore();
        EntFireByHandle(self, "RunScriptCode", "check = true", 0.7, Global_Target, Global_Target);
        EntFireByHandle(self, "RunScriptCode", "MoveToTarget()", 0.05, Global_Target, Global_Target);
        return;
    }
    local array = [];
    local h = null;
    while(null != (h = Entities.FindByClassname(h, "player")))
    {
        if(h == null)
            continue;
        if(!h.IsValid())
            continue;
        if(h.GetHealth() <= 0)
            continue;
        if(h.GetTeam() != 3)
            continue;

        local luck = MainScript.GetScriptScope().GetPlayerClassByHandle(h)
        if(luck != null)
        {
            luck = luck.perkluck_lvl;
            if(luck > 0)
            {
                if(RandomInt(1, 100) > luck * perkluck_luckperlvl)
                {
                    array.push(h);
                    continue;
                }  
            }     
        }

        local dir = self.GetOrigin()-(h.GetOrigin()+Vector(0,0,24));
        dir.Norm();
        self.SetForwardVector(dir);

        CreateIgnore();
        EntFireByHandle(self, "RunScriptCode", "check = true", 0.7, h, h);
        EntFireByHandle(self, "RunScriptCode", "MoveToTarget()", 0.05, h, h);
        return;
    }

    if(array.len() > 0)
    {
        h = array[RandomInt(0, array.len() - 1)];
        local dir = self.GetOrigin()-(h.GetOrigin()+Vector(0,0,24));
        dir.Norm();
        self.SetForwardVector(dir);

        CreateIgnore();
        EntFireByHandle(self, "RunScriptCode", "check = true", 0.7, h, h);
        EntFireByHandle(self, "RunScriptCode", "MoveToTarget()", 0.05, h, h);
        return;
    }
    EntFireByHandle(self, "FireUser1", "", 0, null, null);
}

function MoveToTarget()
{
    if(self.IsValid())
    {
        local so = self.GetOrigin();
        if(check)
        {
            if(InSightArray(so, so - (self.GetForwardVector() * speed)))
            {
                EntFireByHandle(self, "FireUser1", "", 0, null, null);
                return;
            }
        }

        self.SetOrigin(so - (self.GetForwardVector() * speed));
        EntFireByHandle(self, "RunScriptCode", "MoveToTarget()", 0.01, null, null);
    }
}

hitbox <- Entities.FindByName(null, "Gi_Nattak_Phys");
IgnoreArray <- [];

function CreateIgnore()
{
    local ent
    ent = Entities.FindByName(null, "Gi_Nattak_Phys");
    IgnoreArray.push(ent);
}

function InSight(start,target,handle){if(TraceLine(start,target,handle)<1.00)return false;return true;}
function InSightArray(start,target)
{
    for (local i = 0; i < IgnoreArray.len() ; i++)
    {
        if(InSight(start, target, IgnoreArray[i]))
        {
            //DrawLine(start,target,true);
            return false;
        }
    }
    //DrawLine(start,target,false);
    return true;
}

function DrawLine(start,end,color)
{
    if(color)
        DebugDrawLine(start, end, 0, 255, 0, true, 0.5);
    else
        DebugDrawLine(start, end, 255, 0, 0, true, 5);
}