//#####################################################################
//Intended for use with GFL ze_8bit_csgo3 stripper
//Fixes client crash with cannon item
//Install as csgo/scripts/vscripts/gfl/item_cannon_patched.nut
//#####################################################################

Owner <- null;
ticking <- false;
dist <- null;
EntD <- null;
Timer <- 0.00;
KillE <- false;

function PickUp()
{
    if(activator.GetModelName() == "models/player/custom_player/purple_patriot/purple_patriot.mdl")
	{
		Owner = activator;
		if(!ticking)
	    {
			Timer = 0.00;
		    ticking = true;
	 	    Tick();
			//ChangeWeapon();
	    }
	}
	else{if(!KillE){
		EntFireByHandle(activator, "SetHealth", "0", 0.00, null, null);
	EntFire("m_door_1", "ClearParent", "", 0.50, null);}}
} 


function ChangeWeapon()
{
	local k = null;
    if(ticking)
	{
      	while(null != (k = Entities.FindByModel(k, "models/weapons/v_rif_ak47.mdl")))
	    {
			if(Owner == k.GetMoveParent())
		    {
			    k.SetModel("models/weapons/v_cat.mdl")
		    }
		}
		while(null != (k = Entities.FindByModel(k, "models/weapons/w_rif_ak47.mdl")))
	    {
			if(Owner == k.GetMoveParent())
		    {
			    k.SetModel("models/weapons/w_cat.mdl")
		    }
		}
        EntFireByHandle(self,"RunScriptCode"," ChangeWeapon(); ",0.05,null,null);
	}
}

function FindPlayer()
{
	local Fpl = null;
	local geto = null;
	local Rn = 0;
	local num = RandomInt(1, Players());
	while(null != (Fpl = Entities.FindInSphere(Fpl, self.GetOrigin(), 500000)))
	{
		if(Fpl.GetTeam() == 3 && Fpl.GetHealth() > 0 && Fpl.IsValid())
		{
			Rn++;
		    if(Rn >= num)
			{
				geto = Fpl.GetOrigin();
			    EntFire("weapon_strip", "StripWeaponsAndSuit", "", 0.00, Fpl);
			    EntFire("add_weapon", "Use", "", 0.50, Fpl);
			    EntFireByHandle(Fpl,"AddOutput","origin 125 -16132 78",0.00,null,null);
			    EntFireByHandle(Fpl,"AddOutput","origin "+geto.x+" "+geto.y+" "+geto.z,0.10,null,null);
			    Fpl.SetModel("models/player/custom_player/purple_patriot/purple_patriot.mdl");
			    return;
			}
		}
	}
}

function Players()
{
	local fp = null;
	local intp = 0;
	while(null != (fp = Entities.FindInSphere(fp, self.GetOrigin(), 500000)))
	{
		if(fp.GetTeam() == 3 && fp.GetHealth() > 0 && fp.IsValid())
		{
			intp++;
		}
	}
	return intp;
}

function UseCannon() 
{
	if (self.GetMoveParent().GetOwner() == activator)
		EntFireByHandle(self, "FireUser2", "", 0.0, activator, activator)
}

function SetDistcheck()
{
	dist = caller;
}

function SetEnt()
{
	EntD = caller;
}

function Tick()
{
	if(Owner.GetHealth() < 0 || self.GetMoveParent().GetOwner() != Owner
	|| Owner.GetTeam() == 2)
	{
		Drop();
	}
	else
		EntFireByHandle(self, "RunScriptCode", " Tick(); ", 0.05, null, null);
}

function Drop()
{
	ticking = false;
	EntFire("m_door_1", "ClearParent", "", 0.00, null);
	TickDropped();
}

function TickDropped()
{
	if(self.GetMoveParent().GetOwner() != Owner)
	{
		Timer += 0.50;
		if(Timer == 250.00)
	    {
		    KillItem();
	    }
		EntD.SetOrigin(dist.GetOrigin());
		EntD.SetAngles(dist.GetAngles().x,dist.GetAngles().y,dist.GetAngles().z);
		EntFireByHandle(self, "RunScriptCode", " TickDropped(); ", 0.01, null, null);
	}
}

function KillItem()
{
	KillE = true;
	EntFire("m_door_1", "Kill", "", 0.00, null);
	EntFire("distancecheck", "Kill", "", 0.00, null);
	EntFireByHandle(self, "Kill", "", 0.00, null, null);
	EntFire("cannon", "Kill", "", 0.00, null);
}