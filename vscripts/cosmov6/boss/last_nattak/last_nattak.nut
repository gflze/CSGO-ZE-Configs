/*
▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
	Gi Nattack script by Kotya[STEAM_1:1:124348087]
	test branch update 09.06.2021 
▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
*/

// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Main settings    
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
	NearBoss_Radius <- 350;
	
	ticking <- false;
	tickrate <- 0.1;

	tickrate_use <- 0;
	cd_use_CAN <- true;

	tickrate_firedick <- 0;

	cd_use <- 5.0;
	cd_use_d <- cd_use / 17;

	function SetCDUse(i)
	{
		cd_use = 0.00 + i;
		cd_use_d = i / 17;
	}
}
// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Status   
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
Status              <- "";
// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      HP settings    
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
	HP <- 0;
	HP_INIT <- 0;
	HP_BARS <- 16;

	function SetHP(i)
	{
		i = (0.00 + i) / HP_BARS;

		local handle = null;
		while(null != (handle = Entities.FindByClassname(handle, "player")))
		{
			if(handle.IsValid())
			{
				if(handle.GetTeam() == 3 && handle.GetHealth() > 0)
				{
					HP += i;
					HP_INIT += i;
				}
			}
		}
	}
	function AddHPInit(i)
	{
		i = (0.00 + i) / HP_BARS;

		HP += i;
		HP_INIT += i;
	}

	function AddHP(i)
	{
		if(i < 0)
		{
			i = -i * HP_INIT;
		}

		while(HP + i >= HP_INIT)
		{
			HP_BARS++;
			i -= HP_INIT;
		}

		if(HP_BARS <= 16)
		{
			local id = 16 - HP_BARS;
			EntFire("Special_HealthTexture", "SetTextureIndex", "" + id, 0.00);
		}
		else EntFire("Special_HealthTexture", "SetTextureIndex", "0", 0.00);

		HP += i;
	}

	Shoot_OneMoney <- 8;
    Shoot_OneMoney = 1.00 / Shoot_OneMoney;
	function ShootDamage()
	{
		SubtractHP(1);
		MainScript.GetScriptScope().GetPlayerClassByHandle(activator).ShootTick(Shoot_OneMoney);
	}

	function ItemDamage(i)
	{
		if(i < 0)
		{
			i = -i * HP_INIT;
		}

		SubtractHP(i);
	}

	function NadeDamage()
	{
		SubtractHP(80);

		if(Stanblock)
			return;

		if(!Stanned)
        {
            NadeCount++
            NadeTickRate += NadeTime;

            if(NadeCount >= NadeNeed)
                SetStanned();
        }
	}


	function SubtractHP(i)
	{
		if(Stanned)i *= StanDamage;
		HP -= i;
	}

	function ItemEffect_Ice(time)
    {
        if(time <= 0)
            return;
        cd_use_CAN = false;

		local ice_temp = Entities.FindByName(null, "map_ice_temp_01"); 
        ice_temp.SetOrigin(Model.GetOrigin() + Vector(0, 0, 150))
        EntFireByHandle(ice_temp, "ForceSpawn", "", 0.00, null, null);
        
        local name = Time().tointeger();

        EntFire("map_ice_model_01", "SetParent", "!activator", 0, Model);

        EntFire("map_ice_model_01", "RunScriptCode", "Spawn(0.5)", 0, null);

	    EntFire("map_ice_model_01", "AddOutPut", "targetname map_ice_model_01"+name, 0, null);
        EntFire("map_ice_model_01"+name, "RunScriptCode", "Kill(" + (time * 0.9) + ")", time * 0.2, null);

        EntFireByHandle(Model, "Color", "0 255 0", 0.00, null, null);

        EntFireByHandle(Model, "Color", "255 255 255", time, null, null);
        EntFireByHandle(self, "RunScriptCode", "cd_use_CAN = true;", time, null, null);
    }


	function BossDead()
	{
		local item_target = Entities.FindByName(null, "map_item_beam_target");
        EntFireByHandle(item_target, "ClearParent", "", 0, null, null);

		EntFire("EndNattak_HP_Bar", "Kill", "", 0);
		EntFire("EndNattak_Name_Bar", "Kill", "", 0);
		EntFire("EndNattak_Timer_Bar", "Kill", "", 0);

		EntFire("EndNattak_Model", "FireUser4", "", 0);
		EntFire("EndNattak_Phys", "Break", "", 0);

		EntFire("EndNattak_Hurt", "Kill", "", 0);
		
		EntFire("EndNattak_Wind*", "Kill", "", 0);

		EntFire("map_sound_boss_dead", "PlaySound", "", 0);

		if(ShieldArray.len() > 0)
        {
            local time = 0;
            local timeadd = (2.0 / ShieldArray.len());

            for(local i = 0; i < ShieldArray.len(); i++)
            {
                EntFireByHandle(ShieldArray[i].hbox, "Break", "", time, null, null);
                EntFireByHandle(ShieldArray[i].model, "RunScriptCode", "Kill(0.5)", time, null, null);
                time += timeadd;
            }

            ShieldArray.clear();
        }
	}
}
// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Stun settings    
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
	Stanblock           <- true;
	Stanned             <- false;
	StanTime            <- 5;
	StanDamage          <- 5;

	NadeCount <- 0;
	NadeNeed <- 10;
	NadeShow <- 20.0;

	NadeShow = NadeNeed * (NadeShow / 100);

	NadeTickRate <- 0;
	NadeTime <- 5;

	function SetStanned()
	{
		NadeTickRate += StanTime;
		NadeCount = 0;
		Stanned = true;
	}

	function SetUnStanned()
	{
		Stanned = false;
	}
}

// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Other settings
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
	Model <- null;

	allow_heal            <- true;
	allow_poison          <- true;
	allow_shield          <- true;

	cancast_heal          <- false;
	cancast_poison        <- false;
	cancast_shield        <- false;

}
// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Attack settings    
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
	//HEAL
	{
		function Cast_Heal()
		{
			cancast_heal = false;

			ScriptPrintMessageChatAll(Scan_pref + "\x07Gi Nattak\x01 is using Heal");

			//ScriptPrintMessageChatAll("UseHeal");
			//EntFire("Gi_Nattak_Heal_Sound", "PlaySound", "", 0);

			EntFire("EndNattak_Heal_Effect", "Start", "", 0);
			EntFire("EndNattak_Heal_Effect", "Stop", "", 3);

			local hp = ((10 * CountAlive()) / 7).tostring();

			EntFireByHandle(self, "RunScriptCode", "AddHP(" + hp + ")", 0.5, null, null);
			EntFireByHandle(self, "RunScriptCode", "AddHP(" + hp + ")", 1, null, null);

			EntFireByHandle(self, "RunScriptCode", "AddHP(" + hp + ")", 1.5, null, null);
			EntFireByHandle(self, "RunScriptCode", "AddHP(" + hp + ")", 2, null, null);

			EntFireByHandle(self, "RunScriptCode", "AddHP(" + hp + ")", 2.5, null, null);
			EntFireByHandle(self, "RunScriptCode", "AddHP(" + hp + ")", 3, null, null);
			//test
			//EntFire("Special_Health", "Add", 600 0);

			//EntFire(cmd Command say **Gi Nattak has healed** 0);
		}
	}
	//POISON
	{
		function Cast_Poison()
		{
			cancast_poison = false;

			ScriptPrintMessageChatAll(Scan_pref + "\x07Gi Nattak\x01 is using\x04 Poison");

			local origin = Model.GetOrigin() + Vector(0, 0, 420) + (Model.GetForwardVector() * 250);
			EntFire("poison_temp", "AddOutPut", "origin "+origin.x+" "+origin.y+" "+origin.z, 0);
			EntFire("poison_temp", "ForceSpawn", "", 0.02);

			//ScriptPrintMessageChatAll("UsePoison");
		}
	}
	//FIREDICK
	{
		FireDickMaker <- null;
		FireDicks_Pos <- [
			Vector(-10200,-928,1876),
			Vector(-10200,-816,1876),
			Vector(-10200,-1040,1876),
			]
		function Cast_FireDick()
		{
			local random = RandomInt(0,FireDicks_Pos.len() - 1);
			FireDickMaker.SpawnEntityAtLocation(FireDicks_Pos[random], Vector(0,0,0))
		}
	}
	//SHIELD
	{
		ShieldArray <- [];
		class shield
		{
			model = null;
			hbox = null;
			health = 0;
			constructor(_model, _hbox, _health)
			{
				this.model = _model;
				this.hbox = _hbox;
				this.health = _health;
			}
		}

		Shield_Random <- 1;
		Shield_FullRotate <- 4.0;
		Shield_Count <- [4, 6, 8, 16];
		//Shield_Count <- [16];
		Shield_Health <- 20.0;

		Shield_Rot  <- null;
		Shield_Maker  <- null;

		function RegShield()
		{
			local model = caller;
			local hbox = Entities.FindByName(null, "EndNattak_Shield_Hbox" + caller.GetName().slice(caller.GetPreTemplateName().len(),caller.GetName().len()));
			local health = (CountAlive() * Shield_Health) / Shield_Count[Shield_Random];
			ShieldArray.push(shield(model, hbox, health));
		}

		function DamageShield(damage = 1)
		{
			local Shield = null;
			local i = 0;
			for(i = 0; i < ShieldArray.len(); i++)
			{
				if(ShieldArray[i].hbox == caller)
				{
					Shield = ShieldArray[i];
					break;
				}
			}

			if(Shield == null)
				return;

			if(Shield.health - damage <= 0)
			{
				EntFireByHandle(Shield.hbox, "Break", "", 0.00, null, null);
				EntFireByHandle(Shield.model, "RunScriptCode", "Kill(1.25)", 0.00, null, null);
				ShieldArray.remove(i);
			}
			else Shield.health--;
		}

		function GetShield(Handle)
		{
			foreach(s in ShieldArray)
			{
				if(s.hbox == Handle)
					return s;
			}
			return null;
		}

		function Cast_Shield()
		{
			cancast_shield = false;

			ScriptPrintMessageChatAll(Scan_pref + "\x07Gi Nattak\x01 is using\x0C Shield");

			//ScriptPrintMessageChatAll("UseShield");

			if(ShieldArray.len() > 0)
			{
				local time = 0;
				local timeadd = (2.0 / ShieldArray.len());

				for(local i = 0; i < ShieldArray.len(); i++)
				{
					EntFireByHandle(ShieldArray[i].hbox, "Break", "", time, null, null);
					EntFireByHandle(ShieldArray[i].model, "RunScriptCode", "Kill(0.5)", time, null, null);
					time += timeadd;
				}

				ShieldArray.clear();
			}
			EntFireByHandle(self, "RunScriptCode", "Cast_Shield_Next();", 1, null, null);
		}

		function Cast_Shield_Next()
		{
			Shield_Random = RandomInt(0, Shield_Count.len() -1);
			local time = 0;
			local speed = 360.0 / Shield_FullRotate;
			local ang = 360.0 / Shield_Count[Shield_Random];
			local timeadd = ang / speed;
			for(local i = Shield_Count[Shield_Random]; 0 < i; i--)
			{
				EntFireByHandle(self, "RunScriptCode", "Spawn_Shield();", time, null, null);
				time += timeadd;
			}
		}

		function Spawn_Shield()
		{
			Shield_Maker.SpawnEntity();
		}
	}
}
// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Main
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
	function Init()
	{
		EntFire("Credits_Game_Text", "Display", "", 2);
		EntFire("Credits_Game_Text", "AddOutput", "message Gi Nattak", 0);

		EntFire("EndNattak_Model_Effect", "FireUser1", "", 0);
		EntFire("EndNattak_Appear", "Start", "", 0);
		EntFire("EndNattak_Appear", "Stop", "", 1.5);
		EntFire("EndNattak_Model", "FireUser3", "", 0);

		EntFire("Name_Texture", "SetTextureIndex", ""+1, 0.2);
		EntFire("Name_Texture", "AddOutPut", "target EndNattak_Name_Bar", 0);
		EntFire("Timer_Texture", "AddOutPut", "target EndNattak_Timer_Bar", 0);
		EntFire("Special_HealthTexture", "AddOutPut", "target EndNattak_HP_Bar", 0);

		FireDickMaker = Entities.FindByName(null,"EndNattak_Firedicks_Maker");
		Model = Entities.FindByName(null,"EndNattak_Model");
		Shield_Maker = Entities.FindByName(null, "EndNattak_Shield_Spawner");
		Shield_Rot = Entities.FindByName(null, "EndNattak_Shield_Rotate");

		EntFireByHandle(Shield_Rot, "AddOutPut", "maxspeed " + (360.0 / Shield_FullRotate), 0.00, null, null);
		EntFireByHandle(Shield_Rot, "Start", "", 0.05, null, null);

		local item_target = Entities.FindByName(null, "map_item_beam_target");
        item_target.SetOrigin(Model.GetOrigin());
        EntFireByHandle(item_target, "SetParent", "!activator", 0, Model, Model);
		
		EntFireByHandle(self, "RunScriptCode", "InitEnd()", 2.00, null, null);
	}

	function InitEnd()
	{
		EntFire("EndNattak_Wind_Effect", "Start", "", 3);
		EntFire("EndNattak_Wind_Push", "Enable", "", 3);

		EntFire("EndNattak_HP_Bar", "ShowSprite", "", 0.01);
		EntFire("EndNattak_Name_Bar", "ShowSprite", "", 0.01);
		EntFire("EndNattak_Timer_Bar", "ShowSprite", "", 0.01);

		EntFire("Gi_Nattak_Smex", "PlaySound", "", 0.5);

		EntFire("Gi_Nattak_Nade", "Enable", "", 0);
		EntFire("EndNattak_Phys", "SetDamageFilter", "filter_humans", 0);

		Start();
	}

	function Start()
	{
		ticking = true;

		SetHP(40);
		MainScript.GetScriptScope().Active_Boss = "NattakLast";

		Tick();
	}

	function Tick()
	{
		if(!ticking)
			return;

		TickUse();
		TickFireDick();

		UpDateCasttime();
		UpDateHP();

		ShowBossStatus();
		
		//DrawTriggers();

		EntFireByHandle(self, "RunScriptCode", "Tick()", tickrate, null, null);
	}

	function TickUse()
	{
		if(!cd_use_CAN)
            return;
		if(tickrate_use + tickrate >= cd_use)
		{
			tickrate_use = 0;
			Use();
			GetRandomAnimation();
		}
		else tickrate_use += tickrate;
	}

	
	use_array <- [];

	function Use()
	{
		if(use_array.len() <= 0)
		{
			if(allow_heal)
				cancast_heal = true;

			if(allow_poison)
				cancast_poison = true;
			
			if(allow_shield)
				cancast_shield = true;
		}

		if(cancast_heal)
			use_array.push("Heal");
		
		if(cancast_poison)
			use_array.push("Poison");

		if(cancast_shield)
			use_array.push("Shield");

		local use_random_index = RandomInt(0, use_array.len() - 1);

		//ScriptPrintMessageChatAll("Use"+use_array[use_random_index]+"();");
		EntFireByHandle(self, "RunScriptCode", "Cast_"+use_array[use_random_index]+"();", 0, null, null);
		use_array.remove(use_random_index);
	}

	function UpDateHP()
	{
		if(HP <= 0)
		{
			HP += HP_INIT;
			HP_BARS--;

			if(HP_BARS <= 16)
			{
				local id = 16 - HP_BARS;
				EntFire("Special_HealthTexture", "SetTextureIndex", "" + id, 0.00);
			}
		}
		if(HP_BARS <= 0)
		{
			ticking = false;
			ShowBossDeadStatus(); 

			BossDead();

			MainScript.GetScriptScope().Active_Boss = null;
			EntFire("map_brush", "RunScriptCode", "Trigger_After_Last_Nattak()", 0);
		}
	}

	function StanTick()
	{
		if(NadeTickRate > 0)
		{
			NadeTickRate -= tickrate;
			if(NadeTickRate <= 0)
			{
				if(Stanned)
				{
					SetUnStanned();
				}
					
				NadeCount = 0;
				NadeTickRate = 0;
			}
		}
	}

	function UpDateStatus()
	{
		if(!Stanned)
		{
			Status = "Casting";
		}
		else Status = "Stanned[dmg x" + StanDamage + "]";
	}

	function UpDateCasttime()
	{
		if(!ticking)
			return;

		local id;
		for(local a = 0; a <= 16; a++)
		{
			id = (a + 1) * cd_use_d;

			if(id >= tickrate_use)
			{
				EntFire("timer_texture", "SetTextureIndex", "" + (a-1), 0.00);
				break;
			}
		}
	}

	function ShowBossStatus()
	{
		if(!ticking)
			return;

		local message;

		message = "[Gi Nattak] : Status : " + Status + "\n";
		for(local i = 1; i <= HP_BARS; i++)
		{
			if(i <= 16)
				message += "◆";
			else
				message += "◈";
		}
		for(local i = HP_BARS; i < 16; i++)
		{
			message += "◇";
		}

		if(!Stanned)
		{
			if(NadeCount >= NadeShow)
			{
				local proccent = 0.0 + NadeCount;
				message += "\nStanStatus : " + ((proccent / NadeNeed) * 100) + "%";
			}
		}
		else
		{
			message += "\nStanTime : " + (NadeTickRate).tointeger()  ; 
		}
		
		ScriptPrintMessageCenterAll(message);
	}

	function ShowBossDeadStatus()
	{
		local message;
		message = "[Gi Nattak] : Status : Dead\n";

		for(local i = HP_BARS; i < 16; i++)
		{
			message += "◇";
		}

		ScriptPrintMessageCenterAll(message);
	}
	FideDicks_use_int <- [1.0, 1.2];
	firedicks_use <- RandomFloat(FideDicks_use_int[0], FideDicks_use_int[1]);
	function TickFireDick()
	{
		if(tickrate_firedick + tickrate >= firedicks_use)
		{
			firedicks_use = RandomFloat(FideDicks_use_int[0], FideDicks_use_int[1]);
			tickrate_firedick = 0;
			Cast_FireDick();
		}
		else tickrate_firedick += tickrate;
	}

}
// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Support Function 
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
	Idle_Anim <- "idle";
	Attack1_Anim <- "attack1";
	Attack2_Anim <- "attack2";
	Attack3_Anim <- "attack3";

	function GetRandomAnimation()
	{
		switch (RandomInt(0,2))
		{
			case 0:
			{
				SetBossAnimation(Attack1_Anim);
				SetBossAnimation(Idle_Anim,3.3);
			}
			break;

			case 1:
			{
				SetBossAnimation(Attack2_Anim);
				SetBossAnimation(Idle_Anim,4.55);
			}
			break;

			case 2:
			{
				SetBossAnimation(Attack3_Anim);
				SetBossAnimation(Idle_Anim,5.25);
			}
			break;
		}
	}

	function SetBossAnimation(animationName,time = 0)EntFireByHandle(Model,"SetAnimation",animationName,time,null,null);

	function CountAlive(TEAM = 3)
	{
		local handle = null;
		local counter = 0;
		while(null != (handle = Entities.FindByClassname(handle,"player")))
		{
			if(handle.GetTeam() == TEAM && handle.GetHealth() > 0)
				counter++;
		}
		return counter;
	}

	function MidleHp(TEAM = 3)
	{
		local handle = null;
		local counter = 0;
		local hp = 0;
		while(null != (handle = Entities.FindByClassname(handle,"player")))
		{
			if(handle.GetTeam() == TEAM && handle.GetHealth() > 0)
			{
				hp += handle.GetHealth();
				counter++;
			}
		}
		return hp / counter;
	}

	function InArena(TEAM = 3)
	{
		local handle = null;
		local counter = 0;
		while (null != (handle = Entities.FindInSphere(handle , CenterArea, InArena_Radius)))
		{
			if(handle.GetTeam() == TEAM && handle.GetHealth() > 0)counter++;
		}
		return counter;
	}

	function OutArena(TEAM = 3)return CountAlive(TEAM) - InArena(TEAM);

	function NearBoss(TEAM = 3)
	{
		local handle = null;
		local counter = 0;
		while (null != (handle = Entities.FindInSphere(handle , Model.GetOrigin(), NearBoss_Radius)))
		{
			if(handle.GetTeam() == TEAM && handle.GetHealth() > 0)counter++;
		}
		return counter;
	}

	function DrawTriggers()
	{
		local ent = null;
		ent = Entities.FindByName(null, "EndNattak_Phys");
		DrawBoundingBox(ent);
		// ent = Entities.FindByName(null, "Gi_Nattak_Nade");
		// DrawBoundingBox(ent);
		// ent = Entities.FindByName(null, "Gi_Nattak_Dark_Push");
		// DrawBoundingBox(ent);
	}

	function DrawBoundingBox(ent)
	{
		local origin = ent.GetOrigin();

		local max = ent.GetBoundingMaxs();
		local min = ent.GetBoundingMins();

		local rV = ent.GetLeftVector();
		local fV = ent.GetForwardVector();
		local uV = ent.GetUpVector();

		local TFR = origin + uV * max.z + rV * max.y + fV * max.x;
		local TFL = origin + uV * max.z + rV * min.y + fV * max.x;

		local TBR = origin + uV * max.z + rV * max.y + fV * min.x;
		local TBL = origin + uV * max.z + rV * min.y + fV * min.x;

		local BFR = origin + uV * min.z + rV * max.y + fV * max.x;
		local BFL = origin + uV * min.z + rV * min.y + fV * max.x;

		local BBR = origin + uV * min.z + rV * max.y + fV * min.x;
		local BBL = origin + uV * min.z + rV * min.y + fV * min.x;


		DebugDrawLine(TFR, TFL, 0, 0, 255, true, tickrate + 0.01);
		DebugDrawLine(TBR, TBL, 0, 0, 255, true, tickrate + 0.01);

		DebugDrawLine(TFR, TBR, 0, 0, 255, true, tickrate + 0.01);
		DebugDrawLine(TFL, TBL, 0, 0, 255, true, tickrate + 0.01);

		DebugDrawLine(TFR, BFR, 0, 0, 255, true, tickrate + 0.01);
		DebugDrawLine(TFL, BFL, 0, 0, 255, true, tickrate + 0.01);

		DebugDrawLine(TBR, BBR, 0, 0, 255, true, tickrate + 0.01);
		DebugDrawLine(TBL, BBL, 0, 0, 255, true, tickrate + 0.01);

		DebugDrawLine(BFR, BBR, 0, 0, 255, true, tickrate + 0.01);
		DebugDrawLine(BFL, BBL, 0, 0, 255, true, tickrate + 0.01);

		DebugDrawLine(BFR, BFL, 0, 0, 255, true, tickrate + 0.01);
		DebugDrawLine(BBR, BBL, 0, 0, 255, true, tickrate + 0.01);
	}
}