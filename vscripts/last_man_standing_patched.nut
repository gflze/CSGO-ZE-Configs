//#####################################################################
//Patched version intended for use with GFL ze_last_man_standing_h2 stripper
//Prevents mech being picked for stage 5/10 solo when core is destroyed
//Install as csgo/scripts/vscripts/gfl/ze_last_man_standing_patched.nut
//#####################################################################

Survivor <- null;

function KillFag()
{
	local FindPlSurv = [];
	EntFire("Weapon_Inmunizer_Inmunize_Trigger","Kill","",0.00,null);
	EntFire("Human_Item_Mech_Cam","Disable","",0.00,null);
	EntFire("Map_End_Camera","Disable","",0.00,null);
	EntFire("v_cam1","Disable","",0.00,null);
	EntFire("Zombie_Item_Boss_Cam","Disable","",0.00,null);
	local z = null;
	while(null != (z = Entities.FindByClassname(z, "player")))
	{
		if(z != null && z.IsValid() && z.GetTeam() == 3 && z.GetHealth() > 0)
		{
			FindPlSurv.push(z);
		}
	}
	if(FindPlSurv.len() == 0){return;}

	do
	{
		Survivor = FindPlSurv[RandomInt(0,FindPlSurv.len()-1)];
	}
	while (Survivor.GetName() == "human_mech" && FindPlSurv.len() > 1);

	foreach(item in FindPlSurv)
	{
		if(item != Survivor)
		{
			EntFireByHandle(item, "SetDamageFilter", "", 0.00, null, null);
            EntFireByHandle(item, "SetHealth", "-1", 0.02, null, null);
		}
	}
	local rndpos = RandomInt(1,4);
	{
		if(rndpos == 1)
		{
			Survivor.__KeyValueFromString("origin", "9700 -4610 13969");
			Survivor.SetAngles(0, 180, 0);
		}
		else if(rndpos == 2)
		{
			Survivor.__KeyValueFromString("origin", "-446 -4610 13969");
			Survivor.SetAngles(0, 0, 0);
		}
		else if(rndpos == 3)
		{
			Survivor.__KeyValueFromString("origin", "4608 449 13969");
			Survivor.SetAngles(0, 270, 0);
		}
		else if(rndpos == 4)
		{
			Survivor.__KeyValueFromString("origin", "4608 -9665 13969");
			Survivor.SetAngles(0, 90, 0);
		}
		Survivor.SetVelocity(Vector(0,0,0));
	}
}