Act <- null;
Ticking <- true;
Limit_dist <- 50;

Center_T <- null;
Center_M <- self;
Center_W <- null;

function SetHandle()
{
    if(caller.GetClassname() == "func_movelinear")Center_T = caller;
    if(caller.GetClassname() == "weapon_elite" || caller.GetClassname() == "weapon_knife")Center_W = caller;

}

function Pick(check = true)
{
    Act = activator;
    Ticking = true;
    EntFireByHandle(Center_M, "ClearParent", "", 0, null, null);
    EntFireByHandle(Center_M, "SetParent", "!activator", 0.01, Center_W, Center_W);
    if(check)
        CheckItem();
}

function CheckItem()
{
    if(Ticking)
    {
        if(Act != null && Center_T.IsValid())
        {
            if(DistanceCheck() > Limit_dist || Act.GetHealth() <= 0)
            {
                EntFireByHandle(Center_M, "FireUser4", "", 0.00, null, null);
            }
            else
            {
                EntFireByHandle(Center_M, "RunScriptCode", "CheckItem();", 0.05, null, null);
            }
        }
    }
}

function ClearParent()
{
    Act = null;
    Ticking = false;
    SetPosM();
}

function SetPosM()
{

    if(!Ticking)
    {
        local CurentPos = Center_M.GetOrigin();
        local Tang = Center_T.GetAngles();
        Center_M.SetAngles(Tang.x,Tang.y,Tang.z);
        Center_M.SetOrigin(Center_T.GetOrigin());
        if(CompareCoordinates(CurentPos.x,CurentPos.y,CurentPos.z))
        {
            EntFireByHandle(Center_M, "SetParent", "!activator", 0, Center_W, Center_W);
            return;
        }
        EntFireByHandle(Center_M, "RunScriptCode", "SetPosM();", 0.01, null, null);
    }
}

function CompareCoordinates(x1,y1,z1)
{
    local CurentPos = Center_M.GetOrigin();
	if(x1 == CurentPos.x && y1 == CurentPos.y && z1 == CurentPos.z)
	{
		return true;
	}
    else
    {
        return false;
    }
}

function DistanceCheck()
{
    local opos = Act.GetOrigin();
    local cpos = Center_T.GetOrigin();
    local dist = (opos.x-cpos.x)*(opos.x-cpos.x)
    +(opos.y-cpos.y)*(opos.y-cpos.y)
    +(opos.z-cpos.z)*(opos.z-cpos.z);
    return sqrt(dist);
}


