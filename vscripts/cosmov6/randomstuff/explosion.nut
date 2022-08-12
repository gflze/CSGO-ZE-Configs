map_brush <- Entities.FindByName(null, "map_brush");

dist <- 0;
power <- 0;
ignore <- false;

function OnPostSpawn()
{
    self.ConnectOutput("OnStartTouch", "Touch");
    EntFireByHandle(self, "Enable", "", 0.01, null, null);
    EntFireByHandle(self, "Kill", "", 0.05, null, null);
}

function Touch()
{
    if(!self.IsValid())
        return;
    local spos = self.GetOrigin();
    local apos = activator.GetOrigin();
    local distance = GetDistance3D(spos,apos);
    if(distance <= dist)
    {
        if(ignore || InSight(spos,apos + Vector(0,0,45)))
        {
            local p_damage = distance / dist;
            if(p_damage <= 0.35)p_damage = 0;
            //printl(distance+" / "+dist+" = "+p_damage);
            local damage = power - power * p_damage;
            EntFireByHandle(map_brush, "RunScriptCode", "DamagePlayer("+damage+",::lvl1)", 0, activator, activator);
        }
    }
}

function InSight(start,target)
{
    if(TraceLine(start,target,null)<1.00)
    {
        //DebugDrawLine(start, target, 255,0,0, true, 5)
        return false;
    }
    //DebugDrawLine(start, target, 0,0,255, true, 5)
    return true;
}
function GetDistance3D(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));