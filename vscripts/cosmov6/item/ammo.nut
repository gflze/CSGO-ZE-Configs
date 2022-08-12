PLAYERS <- [];
class player
{
    handle = null;
    noammo = null;
    takeammo = null;
    constructor(_handle)
    {
        this.handle = _handle
        this.noammo = true;
        this.takeammo = false;
    }
}
ticking <- false;

dist <- 0;

function Tick()
{
    if(!ticking)
    {
        PLAYERS.clear();
        return;
    }
    if(PLAYERS.len() > 0)
    {
        local ammo = null;
        while(null != (ammo = Entities.FindByClassnameWithin(ammo,"weapon_*",self.GetOrigin(),768)))
        {
            local owner = ammo.GetOwner()
            if(owner != null)
            {
                local pl = GetClassByHandle(owner);
                if(pl != null)
                {
                    if(pl.noammo)
                    {
                        local spos = self.GetOrigin();
                        local apos = owner.GetOrigin();

                        if(GetDistance2D(spos,apos) <= dist)
                        {
                            if(ammo.GetClassname() != "weapon_axe" &&
                            ammo.GetClassname() != "weapon_knife" &&
                            ammo.GetClassname() != "weapon_breachcharge" &&
                            ammo.GetClassname() != "weapon_c4" &&
                            ammo.GetClassname() != "weapon_decoy" &&
                            ammo.GetClassname() != "weapon_diversion" &&
                            ammo.GetClassname() != "weapon_flashbang" &&
                            ammo.GetClassname() != "weapon_healthshot" &&
                            ammo.GetClassname() != "weapon_hegrenade" &&
                            ammo.GetClassname() != "weapon_incgrenade" &&
                            ammo.GetClassname() != "weapon_hammer" &&
                            ammo.GetClassname() != "weapon_knifegg" &&
                            ammo.GetClassname() != "weapon_molotov" &&
                            ammo.GetClassname() != "weapon_smokegrenade" &&
                            ammo.GetClassname() != "weapon_snowball" &&
                            ammo.GetClassname() != "weapon_spanner" &&
                            ammo.GetClassname() != "weapon_tagrenade" &&
                            ammo.GetClassname() != "weapon_taser" &&
                            ammo.GetClassname() != "weapon_bumpmine")
                            {
                                pl.takeammo = true;
                                EntFireByHandle(ammo,"SetAmmoAmount","250",0.00,null,null);
                            }
                        }
                    }
                }
            }
        }
        foreach(p in PLAYERS)
        {
            if(p.takeammo)
            {
                p.noammo = false;
            }
        }
    }
    EntFireByHandle(self, "RunScriptCode", "Tick(); ", 0.05, null, null);
}

function Touch()
{
    PLAYERS.push(player(activator));
}

function PrintArray()
{
    if(PLAYERS.len() > 0)
    {
        for (local i = 0; i < PLAYERS.len(); i++)
        {
           printl(PLAYERS[i]);
        }
    }
    else
    {
        printl("CLEAR");
    }
}

function GetClassByHandle(handle)
{
	foreach(p in PLAYERS)
	{
		if(p.handle == handle)
		{
            return p
		}
	}
	return null;
}

function Enable()
{
    ticking = true;
    Tick();
    self.ConnectOutput("OnStartTouch", "Touch");
    EntFireByHandle(self, "Enable", "", 0.01, null, null);
}

function Disable()
{
    ticking = false;
    self.DisconnectOutput("OnStartTouch", "Touch")
    EntFireByHandle(self, "Disable", "", 0.01, null, null);
}


function GetDistance2D(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y));

function DrawAxis(pos,s = 16,nocull = true,time = 4)
{
	DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 0, 255, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y,pos.z-s), Vector(pos.x,pos.y,pos.z+s), 0, 0, 255, nocull, time);
}
