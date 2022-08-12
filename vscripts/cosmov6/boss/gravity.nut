function Push(power)
{
    local spos = self.GetOrigin();
    local apos = activator.GetOrigin();
    local vec = (spos - apos) * 1;
    local av = activator.GetVelocity();
    vec.Norm();
    if(GetDistance2D(spos,apos) <= 350)
        power *= 2.5;
    if(TraceLine(activator.GetOrigin(),GVO(activator.GetOrigin(),0,0,-32),null)!=1.00)
    {
        activator.SetVelocity(Vector(vec.x * power, vec.y * power, 255));
    }
    else
    {
        activator.SetVelocity(Vector(vec.x * power, vec.y * power, 0));
    }
}

function GetDistance2D(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y));
function GVO(vec,_x,_y,_z){return Vector(vec.x+_x,vec.y+_y,vec.z+_z);}