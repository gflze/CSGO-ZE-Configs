//#####################################################################
// Patched version intended for use with the GFL ze_doom3_v2 stripper
// Adds randomization selection to NPC target searching in the SearchTarget() function (thanks Luff)
// Install as csgo/scripts/vscripts/gfl/boss_move_tar.nut
//#####################################################################

//===============================================================\\
//	MOVING NPC SCRIPT - BY LUFFAREN (STEAM_1:1:22521282)  \\
//===============================================================\\	



TICKRATE 		<- 	0.10;

TARGET_DISTANCE <- 	5000;

RETARGET_TIME 	<- 	5.00;

SPEED_FORWARD 	<- 	1.00;

SPEED_TURNING 	<- 	1.00;

MIN_SPEED		<- 	2;

MAX_STOP_TIME	<- 	2.00;

p <- null;
tf <- null;
ts <- null;
ttime <- 0.00;
ticking <- false;
counter <- 0.00;
lastpos <- self.GetOrigin();

function Start()
{
    if(!ticking)
	{
	    ticking = true;
	    Tick();
	}
}

function Stop()
{
    if(ticking)
    {
        ticking = false;
		EntFire("target","Kill","",0.00,null);
		EntFireByHandle(tf,"Kill","",0.00,null,null);
	    EntFireByHandle(ts,"Kill","",0.00,null,null);
		EntFireByHandle(self,"Kill","",0.01,null,null);
    }
}

function Tick()
{
	if(ticking)
		EntFireByHandle(self,"RunScriptCode","Tick();",TICKRATE,null,null);
	else
	{
		EntFireByHandle(tf,"Deactivate","",0.00,null,null);
		EntFireByHandle(ts,"Deactivate","",0.00,null,null);
		return;
	}
	if(GetDistance(self.GetOrigin(),lastpos) < MIN_SPEED)
		counter += 0.10;
	else counter = 0.00;
	if(counter > MAX_STOP_TIME)
	{
		EntFireByHandle(ts,"Deactivate","",0.00,null,null);
		EntFireByHandle(ts,"AddOutput","force 4000",0.01,null,null);
		EntFireByHandle(ts,"Activate","",0.02,null,null);
	}
	lastpos = self.GetOrigin();
	EntFireByHandle(tf,"Deactivate","",0.00,null,null);
	EntFireByHandle(ts,"Deactivate","",0.00,null,null);	
	if(p == null || p.GetHealth() <= 0.00 || p.GetTeam() != 3 || ttime >= RETARGET_TIME){
	    return SearchTarget();p = null;}
	ttime+=TICKRATE;
	EntFireByHandle(tf,"Activate","",0.02,null,null);
	EntFireByHandle(ts,"Activate","",0.02,null,null);
	local sa = self.GetAngles().y;
	local ta = GetTargetYaw(self.GetOrigin(),p.GetOrigin());
	local ang = abs((sa-ta+360)%360);
	if(ang>=180)EntFireByHandle(ts,"AddOutput","angles 0 270 0",0.00,null,null);
	else EntFireByHandle(ts,"AddOutput","angles 0 90 0",0.00,null,null);
	local angdif = (sa-ta-180);
	while(angdif>360){angdif-=180;}
	while(angdif< -180){angdif+=360;}
	angdif=abs(angdif);
	local tdist = GetDistance(self.GetOrigin(),p.GetOrigin());
	local tdistz = (p.GetOrigin().z-self.GetOrigin().z);
	EntFireByHandle(tf,"AddOutput","force "+(3000*SPEED_FORWARD).tostring(),0.00,null,null);
	EntFireByHandle(ts,"AddOutput","force "+((3*SPEED_TURNING)*angdif).tostring(),0.00,null,null);
}

function SearchTarget()
{
    ttime = 0.00;
    p = null;
    local candidates = [];
    while(null != (p = Entities.FindInSphere(p,self.GetOrigin(),TARGET_DISTANCE)))
    {
        if(p.GetClassname()=="player" && p.GetTeam()==3 && p.GetHealth()>0)
        {
            candidates.push(p)
        }
    }
    if(candidates.len()<=0)
    {
      p = null;
      return;
    }
    p = candidates[RandomInt(0,candidates.len()-1)];
    local geto = p.GetOrigin();
    local origin = "origin "+geto.x+" "+geto.y+" "+(geto.z+96);
    EntFire("target","AddOutput",origin,0.00,null);
    EntFire("target","SetParent","!activator",0.00,p);
}

function GetTargetYaw(start,target)
{
	local yaw = 0.00;
	local v = Vector(start.x-target.x,start.y-target.y,start.z-target.z);
	local vl = sqrt(v.x*v.x+v.y*v.y);
	yaw = 180*acos(v.x/vl)/3.14159;
	if(v.y<0)
		yaw=-yaw;
	return yaw;
}

function SetThruster(ent)
{
    if(ent == 0)
	{
	    tf=caller;
	}
	else if(ent == 1)
	{
        ts=caller;
	}
}

function GetDistance(v1,v2)
{
    return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));
}
