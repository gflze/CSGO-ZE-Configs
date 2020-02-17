//#####################################################################
//Patched version intended for use with GFL ze_dark_souls_ptd_v0_4_csgo7 stripper
//Removes HTML formatting broken after Shattered Web Update.
//Install as csgo/scripts/vscripts/dark/boss_c_patched.nut
//#####################################################################

TARGET_DISTANCE <- 0;
BOSS <- 1;
Ticking <- true;
Gwyndolin <- false;
Ornstein <- false;

function Start()
{
	if(BOSS <= 3)
	{
		BossInfo();
	}
	if(BOSS == 5)
	{
		BossInfo();
	}
	SetRadius();
	EntFireByHandle(self, "RunScriptCode", " CrLoop(); ", 0.10, null, null);  
}

function CrLoop()
{
	if(Ticking)
	{
		StartDetectItem();
		EntFireByHandle(self, "RunScriptCode", " CrLoop(); ", 0.10, null, null);  
	}
}

function SetRadius()
{
    if(BOSS == 1)
	{
		TARGET_DISTANCE = 500;
	}
	else if(BOSS == 2)
	{
		TARGET_DISTANCE = 50;
	}
	else if(BOSS == 3)
	{
		TARGET_DISTANCE = 150;
	}
	else if(BOSS == 4)
	{
		TARGET_DISTANCE = 120;
	}
	else if(BOSS == 5)
	{
		TARGET_DISTANCE = 100;
	}
}

function StartDetectItem()
{
	if(BOSS == 1)
	{
		local fent = null;
	    while(null != (fent = Entities.FindInSphere(fent,self.GetOrigin(),TARGET_DISTANCE)))
	    {
		    if(fent.GetClassname() == "trigger_hurt" && fent.GetName() == "LS_Hurt")
		    {
			    EntFire("Asylum_Demon_Hitbox","RemoveHealth","1500",0.00,null);
				fent.Destroy();
				return;
		    }
	    }
	}
	else if(BOSS == 2)
	{
		local tent = null;
	    while(null != (tent = Entities.FindInSphere(tent,self.GetOrigin(),TARGET_DISTANCE)))
	    {
		    if(tent.GetClassname() == "trigger_hurt" && tent.GetName() == "GHSA_Hurt")
		    {
			    EntFire("Broadhead_Body","RemoveHealth","1100",0.00,null);
				tent.Destroy();
				return;
		    }
			if(tent.GetClassname() == "trigger_hurt" && tent.GetName() == "LS_Hurt")
		    {
			    EntFire("Broadhead_Body","RemoveHealth","900",0.00,null);
				tent.Destroy();
				return;
		    }
			if(tent.GetClassname() == "trigger_hurt" && tent.GetName() == "WDB_Hurt")
		    {
			    EntFire("Broadhead_Attack_Timer","ResetTimer","",0.00,null);
				EntFire("Broadhead_Spikes","Enable","",0.00,null);
				EntFire("Broadhead_Phys","RunScriptCode","StopMove(4);",0.00,null);
				EntFire("Broadhead_Spikes","Disable","",4.00,null);
			    EntFire("Broadhead_Body","RemoveHealth","1300",4.00,null);
				tent.Destroy();
				return;
		    }
	    }
	}
	else if(BOSS == 3)
	{
		local thent = null;
	    while(null != (thent = Entities.FindInSphere(thent,self.GetOrigin(),TARGET_DISTANCE)))
	    {
		    if(thent.GetClassname() == "trigger_hurt" && thent.GetName() == "ChSt_Hurt")
		    {
			    EntFire("Golem_Phys_Body","RemoveHealth","2000",0.00,null);
				thent.Destroy();
				return;
		    }
			if(thent.GetClassname() == "trigger_hurt" && thent.GetName() == "GHSA_Hurt")
		    {
			    EntFire("Golem_Phys_Body","RemoveHealth","1250",0.00,null);
				thent.Destroy();
				return;
		    }
			if(thent.GetClassname() == "trigger_hurt" && thent.GetName() == "DO_Hurt")
		    {
			    EntFire("Golem_Phys_Body","RemoveHealth","3000",0.00,null);
				thent.Destroy();
				return;
		    }
			if(thent.GetClassname() == "trigger_hurt" && thent.GetName() == "WDB_Hurt")
		    {
			    EntFire("Golem_Attack_Timer","ResetTimer","",0.00,null);
				EntFire("Golem_WDB_Spikes","Enable","",0.00,null);
				EntFire("Golem_Phys","RunScriptCode","StopMove(4);",0.00,null);
				EntFire("Golem_Model","SetAnimation","almostdied",0.00,null);
				EntFire("Golem_Model","SetDefaultAnimation","almostdied",0.00,null);
				EntFire("Golem_Model","SetAnimation","walk1",4.00,null);
				EntFire("Golem_Model","SetDefaultAnimation","walk1",4.00,null);
				EntFire("Golem_WDB_Spikes","Disable","",4.00,null);
			    EntFire("Golem_Phys_Body","RemoveHealth","1800",4.00,null);
				thent.Destroy();
				return;
		    }
	    }
	}
	else if(BOSS == 4)
	{
		if(Gwyndolin)
		{
			local fhent = null;
	        while(null != (fhent = Entities.FindInSphere(fhent,self.GetOrigin(),TARGET_DISTANCE)))
	        {
		        if(fhent.GetClassname() == "trigger_hurt" && fhent.GetName() == "ChSt_Hurt")
		        {
			        EntFire("Gwyndolin_Phys_Body","RemoveHealth","2200",0.00,null);
				    fhent.Destroy();
				    return;
		        }
			    if(fhent.GetClassname() == "trigger_hurt" && fhent.GetName() == "LS_Hurt")
		        {
			        EntFire("Gwyndolin_Phys_Body","RemoveHealth","1200",0.00,null);
				    fhent.Destroy();
				    return;
		        }
			    if(fhent.GetClassname() == "trigger_hurt" && fhent.GetName() == "DO_Hurt")
		        {
			        EntFire("Gwyndolin_Phys_Body","RemoveHealth","3500",0.00,null);
				    fhent.Destroy();
				    return;
		        }
	        }
		}
		if(Ornstein)
		{
			local ohent = null;
	        while(null != (ohent = Entities.FindInSphere(ohent,self.GetOrigin(),TARGET_DISTANCE)))
	        {
			    if(ohent.GetClassname() == "trigger_hurt" && ohent.GetName() == "GHSA_Hurt")
		        {
			        EntFire("Ornstein_Phys_Body","RemoveHealth","1200",0.00,null);
				    ohent.Destroy();
				    return;
		        }
			    if(ohent.GetClassname() == "trigger_hurt" && ohent.GetName() == "DO_Hurt")
		        {
			        EntFire("Ornstein_Phys_Body","RemoveHealth","3000",0.00,null);
				    ohent.Destroy();
				    return;
		        }
	        }
		}
	}
	else if(BOSS == 5)
	{
		local Gwynent = null;
	    while(null != (Gwynent = Entities.FindInSphere(Gwynent,self.GetOrigin(),TARGET_DISTANCE)))
	    {
			if(Gwynent.GetClassname() == "trigger_hurt" && Gwynent.GetName() == "DO_Hurt")
		    {
			    EntFire("Gwyn_Phys_Body","RemoveHealth","3250",0.00,null);
				Gwynent.Destroy();
				return;
		    }
	    }
	}
}

function Stop()
{
	Ticking = false;
}

function BossInfo()
{
	EntFireByHandle(self, "RunScriptCode", " PrintMBinfo(); ", 0.00, null, null);
	EntFireByHandle(self, "RunScriptCode", " PrintMBinfo(); ", 4.00, null, null); 
}

function PrintMBinfo()
{
	if(BOSS == 1)
	{
		ScriptPrintMessageCenterAll("BOSS: Asylum Demon\n" + "Items work on boss:\n" + "Lightning Spear: -1500 Health");
	}
	else if(BOSS == 2)
	{
		ScriptPrintMessageCenterAll("BOSS: Broadhead\n" + "Items work on boss:\n" + "Lightning Spear: -900 Health\n" + "GHSA: -1100 Health");
		EntFireByHandle(self, "RunScriptCode", " InfTwP(); ", 8.00, null, null);
	}
	else if(BOSS == 3)
	{
		ScriptPrintMessageCenterAll("BOSS: Golem\n" + "Items work on boss:\n" + "GHSA: -1250 Health\n" + "Fire: -2000 Health\n");
		EntFireByHandle(self, "RunScriptCode", " InfTwP(); ", 8.00, null, null);
	}
	else if(BOSS == 4)
	{
		ScriptPrintMessageCenterAll("BOSS: Gwyndolin\n" + "Items work on boss:\n" + "Lightning Spear: -1200 Health\n" + "Fire: -2200 Health");
		EntFireByHandle(self, "RunScriptCode", " InfTwP(); ", 8.00, null, null);
	}
	else if(BOSS == 5)
	{
		ScriptPrintMessageCenterAll("BOSS: Lord of Cinder\n" + "Items work on boss:\n" + "Dark Orb: -3250 Health");
	}
}

function InfTwP()
{
	if(BOSS == 2)
	{
		ScriptPrintMessageCenterAll("BOSS: Broadhead\n" + "Items work on boss:\n" + "White Dragon Breath: -1300 Health and stops moving 4 sec");
	}
	else if(BOSS == 3)
	{
		ScriptPrintMessageCenterAll("BOSS: Golem\n" + "Items work on boss:\n" + "Dark Orb: -3000 Health\n" + "White Dragon Breath: -1800 Health and stops moving 4 sec");
	}
	else if(BOSS == 4)
	{
		ScriptPrintMessageCenterAll("BOSS: Gwyndolin\n" + "Items work on boss:\n" + "Dark Orb: -3500 Health\n" + "HE GRENADE: -500 Health");
		EntFireByHandle(self, "RunScriptCode", " InfTwP2(); ", 4.00, null, null);
	}
}

function InfTwP2()
{
	ScriptPrintMessageCenterAll("BOSS: Ornstein\n" + "Items work on boss:\n" + "GHSA: -1200 Health\n" + "Dark Orb: -3000 Health");
}