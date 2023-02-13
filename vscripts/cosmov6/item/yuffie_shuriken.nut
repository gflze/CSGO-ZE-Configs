const TICKRATE = 0.01;

const SPEED = 8;
const TRACE_DISTANCE = 12;
// const ROTATE_SPEED = 50;
const DAMAGE = 200;
const INIT_RADIUS = 150;
const BOUNCE = 12;
const MOVE_RADIUS = 500;
const MOVE_MIN_DISTANCE = 40;
const RANDOM_ANG_MAX = 20;
const RANDOM_ANG_MIN = 5;

g_hOwner <- null;
g_hTarget <- null;
g_hHitbox <- null;

g_hAlreadyTarget <- [];
g_hTarget_Last <- null;
g_vecGravity <- Vector();

g_vecStartDir <- Vector();
g_iMateriaStatus <- -1;
g_iBounce <- BOUNCE;

enum Enum_Status
{
	Init,
	MoveToTarget,
	Back,
}

g_iStatus <- Enum_Status.Init
g_bTicking <- false;

function Init(hOwner, hHitBox, vecDir = Vector(0, -1, 0), iMateriaStatus = -1)
{
	g_iStatus = Enum_Status.Init
	g_hOwner = hOwner;
	g_vecStartDir = vecDir;
	g_iMateriaStatus = iMateriaStatus
	g_hHitbox = hHitBox;

	GetRandomAngele();

	g_bTicking = true;
	Tick();
}

function Tick()
{
	if (!g_bTicking)
	{
		self.Destroy();
		return;
	}
	// TickRotate();
	TickStatus();

	EntFireByHandle(self, "RunScriptCode", "Tick();", TICKRATE, null, null);
}

// function TickRotate()
// {
// 	local x = self.GetAngles().x;
// 	local y = (self.GetAngles().y + ROTATE_SPEED).tointeger();
// 	local z = self.GetAngles().z;
// 	if (y > 360)
// 	{
// 		y = 0;
// 	}
// 	self.SetAngles(x, y, z);
// }

function TickStatus()
{
	switch (g_iStatus)
	{
		case Enum_Status.Init:
			TickStatus_Init();
			break;
		case Enum_Status.MoveToTarget:
			TickStatus_MoveToTarget();
			break;
		case Enum_Status.Back:
			TickStatus_Back();
			break;
	}
}

function TickStatus_Init()
{
	local vecSelf = self.GetOrigin();
	if (!InSight(vecSelf, vecSelf + g_vecStartDir * TRACE_DISTANCE, g_hHitbox))
	{
		GetRandomAngele();
		g_iStatus = Enum_Status.Back;
		TickStatus_Back();
		return;
	}

	vecSelf = vecSelf + g_vecStartDir * SPEED;
	self.SetOrigin(vecSelf);

	local h;
	local distance = MOVE_RADIUS;
	local near = null;

	local temp = 0;
	while ((h = Entities.FindByClassnameWithin(h, "player", vecSelf, INIT_RADIUS)) != null)
	{
		if (h.IsValid() &&
		h.GetTeam() == 2 &&
		h.GetHealth() > 0 &&
		InSight(h.GetCenter(), vecSelf, g_hHitbox) &&
		(temp = GetDistance3D(h.GetCenter(), vecSelf)) < distance)
		{
			distance = temp;
			near = h;
		}
	}

	if (near != null)
	{
		if (g_iMateriaStatus == 0)
		{
			temp = 0;
			while ((h = Entities.FindByClassnameWithin(h, "player", vecSelf, 1024)) != null)
			{
				if (h.IsValid() &&
				h.GetTeam() == 2 &&
				h.GetHealth() > 0)
				{
					g_vecGravity += h.GetOrigin();
					temp++
				}
			}
			g_vecGravity = Vector(g_vecGravity.x / temp, g_vecGravity.y / temp, g_vecGravity.z / temp);
		}

		g_iStatus = Enum_Status.MoveToTarget;
		g_hTarget = near;

		TickStatus_MoveToTarget();
	}
}

function TickStatus_MoveToTarget()
{
	if (g_hTarget == null ||
	!g_hTarget.IsValid() ||
	g_hTarget.GetHealth() < 1 ||
	g_hTarget.GetTeam() != 2)
	{
		if (BounceCheck())
		{
			if (!SearchTarget())
			{
				g_iStatus = Enum_Status.Back;
				TickStatus_Back();
				return;
			}
		}
		else
		{
			g_iStatus = Enum_Status.Back;
			TickStatus_Back();
			return;
		}
	}

	local vecTarget = g_hTarget.GetCenter();
	local vecSelf = self.GetOrigin();

	local dir = vecTarget - vecSelf;
	dir.Norm();
	vecSelf = vecSelf + dir * SPEED;
	self.SetOrigin(vecSelf);

	if (GetDistance3D(vecSelf, vecTarget) < MOVE_MIN_DISTANCE)
	{
		Touch(g_hTarget);
		g_hAlreadyTarget.push(g_hTarget);
		g_hTarget_Last = g_hTarget;
		g_hTarget = null;
	}
}

function SearchTarget()
{
	local vecSelf = self.GetOrigin();

	local h;
	local distance = 9999;
	local near = null;

	local temp = 0;
	local array = [];
	while ((h = Entities.FindByClassnameWithin(h, "player", vecSelf, MOVE_RADIUS)) != null)
	{
		if (h.IsValid() &&
		h != g_hTarget_Last &&
		h.GetTeam() == 2 &&
		h.GetHealth() > 0 &&
		InSight(h.GetCenter(), vecSelf, g_hHitbox))
		{
			if (InArray(h))
			{
				array.push([h, temp]);
				continue;
			}

			if ((temp = GetDistance3D(h.GetCenter(), vecSelf)) < distance)
			{
				distance = temp;
				near = h;
			}
		}

	}

	if (near != null)
	{
		g_hTarget = near;
		return true;
	}
	if (array.len() > 0)
	{
		if (array.len() == 1)
		{
			g_hTarget = array[0][0];
			return true;
		}
		else
		{
			array.sort(array_SortFunction);
			g_hTarget = array[array.len()-1][0];
			g_hAlreadyTarget.clear();
			return true;
		}
	}

	return false;
}

function array_SortFunction(first, second)
{
    if(first[1] > second[1]){return 1;}
    if(first[1] < second[1]){return -1;}
    return 0;
}

function InArray(handle)
{
	foreach (value in g_hAlreadyTarget)
	{
		if (value == handle)
		{
			return true;
		}
	}

	return false;
}

function BounceCheck()
{
	GetRandomAngele();
	return !(--g_iBounce < 0);
}
function GetRandomAngele()
{
	if (RandomInt(0, 1))
	{
		self.SetAngles(RandomInt(-RANDOM_ANG_MIN, -RANDOM_ANG_MAX), 0, 0);
	}
	else
	{
		self.SetAngles(RandomInt(RANDOM_ANG_MIN, RANDOM_ANG_MAX), 0, 0);
	}
}

function TickStatus_Back()
{
	if (g_hOwner == null ||
	!g_hOwner.IsValid() ||
	g_hOwner.GetHealth() < 1 ||
	g_hOwner.GetTeam() != 3)
	{
		g_bTicking = false;
		return;
	}

	local vecOwner = g_hOwner.GetCenter();
	local vecSelf = self.GetOrigin();

	if (GetDistance3D(vecSelf, vecOwner) < 35)
	{
		g_bTicking = false;
		return;
	}

	local dir = vecOwner - vecSelf;
	dir.Norm();
	self.SetOrigin(vecSelf + dir * SPEED);
}

function Touch(activator)
{
	local hp = activator.GetHealth() - DAMAGE;
	if (hp < 1)
	{
		EntFireByHandle(activator, "SetHealth", "0", 0, null, null);
	}
	else
	{
		if (g_iMateriaStatus > -1)
		{
			SetShuriken_Effect({
					activator = activator,
					materia = g_iMateriaStatus,
					owner = g_hOwner,
					shuriken = self,
					gravity = g_vecGravity,
				}
			);
		}
		activator.SetHealth(hp);
	}
}

// Init(null);


function InSight(start,target,handle){if(TraceLine(start,target,handle)<1.00)return false;return true;}
::GetDistance3D <- function(v1, v2){return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));}