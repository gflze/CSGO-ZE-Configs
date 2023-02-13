/*
▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
    Airbuster script by Kotya[STEAM_1:1:124348087]
    test branch update 07.06.2021
▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
*/

// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Main settings
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞

InArena_Radius <- 600;
NearBoss_Radius <- 450;

ticking <- false;
tickrate <- 0.1;

cd_use_CAN <- true;
tickrate_use <- 0;

cd_use <- 8.5;
cd_use_d <- cd_use / 17;
bCringe <- false;

function SetCDUse(i)
{
    cd_use = 0.00 + i;
    cd_use_d = i / 17;
}

// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Status
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞

Status <- "";

// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      HP settings
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
    HP <- 5;
    HP_INIT <- 5;
    HP_BARS <- 16;

    HP_U <- 10; //ГОЛОВА
    HP_H <- 30; //РУКИ
    HP_C <- 20; //Тело
    HP_L <- 40; //Ноги :D

    HP_U_TOTAL <- 0;
    HP_H_TOTAL <- 0;
    HP_C_TOTAL <- 0;
    HP_L_TOTAL <- 0;

    U_BROKEN <- false;
    H_BROKEN <- false;
    C_BROKEN <- false;
    L_BROKEN <- false;

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

        local M_HP = HP_INIT * HP_BARS;

        HP_H = M_HP * (HP_H / 100.0);
        HP_U = M_HP * (HP_U / 100.0);
        HP_L = M_HP * (HP_L / 100.0);
        HP_C = M_HP * (HP_C / 100.0);

        HP_U_TOTAL = HP_U;
        HP_H_TOTAL = HP_H;
        HP_C_TOTAL = HP_C;
        HP_L_TOTAL = HP_L;
    }

    function AddHP(i)
    {
        if(i < 0)
        {
            i = -i * HP_INIT;
        }

        if (HP_H > 0)
        {
            HP_H += i * 0.3;
        }
        if (HP_U > 0)
        {
            HP_U += i * 0.1;
        }
        if (HP_L > 0)
        {
            HP_L += i * 0.4;
        }
        if (HP_C > 0)
        {
            HP_C += i * 0.2;
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

    function ItemDamage(i)
    {

        if(i == 500)
        {
            if(bCringe)
                return;
            bCringe = true;
            EntFireByHandle(self, "RunScriptCode", "bCringe = false;", 1, null, null);
        }
        if(i < 0)
        {
            i = -i * HP_INIT;
        }

        if (ShieldArray.len() > 0)
        {
            i *= 0.8
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

    Shoot_OneMoney <- 15;
    Shoot_OneMoney = 1.00 / Shoot_OneMoney;
    function ShootDamage(ID)
    {
        MainScript.GetScriptScope().GetPlayerClassByHandle(activator).ShootTick(Shoot_OneMoney);
        switch (ID)
        {
            case 0:
            SubtractHP_Head(1.5);
            break;

            case 1:
            SubtractHP_Chest(1);
            break;

            case 2:
            SubtractHP_Hand(1);
            break;

            case 3:
            SubtractHP_Low(1);
            break;
        }
    }

    function SubtractHP_Head(i)//голова
    {
        if(Stanned)i *= StanDamage;

        if(HP_U > 1)
            HP_U -= i;
        else if (!U_BROKEN)
        {
            U_BROKEN = true;
            allow_rocket =  false;
            allow_heal  =   false;
            local use_index = -1;
            use_index = InArray("Rocket", use_array);
            if(use_index != -1)
            use_array.remove(use_index)
            use_index = InArray("Heal", use_array);
            if(use_index != -1)
            use_array.remove(use_index)
        }
        SubtractHP(i);
    }

    function SubtractHP_Chest(i)//тело
    {
        if(Stanned)i *= StanDamage;

        if(HP_C > 1)
            HP_C -= i;
        else if (!C_BROKEN)
        {
            C_BROKEN = true;
            allow_shield =  false;
            allow_laser  =  false;
            local use_index = -1;
            use_index = InArray("Laser", use_array);
            if(use_index != -1)
            use_array.remove(use_index)
            use_index = InArray("Shield", use_array);
            if(use_index != -1)
            use_array.remove(use_index)
        }
        SubtractHP(i);
    }

    function SubtractHP_Hand(i)//руки
    {
        if(Stanned)i *= StanDamage;

        if(HP_H > 1)
            HP_H -= i;
        else if(!H_BROKEN)
        {
            H_BROKEN = true;
            allow_confuse = false;
            allow_ice = false;
            allow_punch = false;
            allow_wind = false;
            local use_index = -1;
            use_index = InArray("Confuse", use_array);
            if(use_index != -1)
            use_array.remove(use_index)
            use_index = InArray("Ice", use_array);
            if(use_index != -1)
            use_array.remove(use_index)
            use_index = InArray("Punch", use_array);
            if(use_index != -1)
            use_array.remove(use_index)
            use_index = InArray("Wind", use_array);
            if(use_index != -1)
            use_array.remove(use_index)
        }
        SubtractHP(i);
    }

    function SubtractHP_Low(i)//ноги
    {
        if(Stanned)i *= StanDamage;

        if(HP_L > 1)
            HP_L -= i;
        else if(!L_BROKEN)
        {
            L_BROKEN = true;
            allow_flame = false;
            allow_mine = false;
            local use_index = -1;
            use_index = InArray("Flame", use_array);
            if(use_index != -1)
            use_array.remove(use_index)
            use_index = InArray("Mine", use_array);
            if(use_index != -1)
            use_array.remove(use_index)
        }
        SubtractHP(i);
    }

    function SubtractHP(i)
    {
        if(Stanned)i *= StanDamage;
        HP -= i;
    }

    function BossDead()
    {
        local item_target = Entities.FindByName(null, "map_item_beam_target");
        EntFireByHandle(item_target, "ClearParent", "", 0, null, null);

        EntFire("airbuster_move_physbox", "DisableMotion", "", 0);
        SetAnimation(Stanned_Anim);
        EntFire("AirBuster_Model", "FireUser4", "", 1);
        EntFire("explosion", "RunScriptCode", "CreateExplosion(activator.GetOrigin(),256,100)",3,Model);
        EntFire("map_sound_boss_dead", "PlaySound", "", 0);
        EntFire("Airbuster*", "Kill", "", 3.2);

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
    StanDamage          <- 2;

    NadeCount <- 0;
    NadeNeed <- 20;
    NadeShow <- 20.0;

    NadeShow = NadeNeed * (NadeShow / 100);

    NadeTickRate <- 0;
    NadeTime <- 3;

    Stanned_Anim <- "stagger";
    UnStanned_Anim <- "dmgburst";

    function SetStanned()
    {
        EntFire("AirBuster_Stager_Effect","Start","",0);
        EntFire("AirBuster_Move_Physbox","DisableMotion","",0);
        SetPlayBackRate(0,2.5);
        SetAnimation(Stanned_Anim);

        NadeTickRate = StanTime;
        NadeCount = 0;
        Stanned = true;

        cd_use_CAN = false;
        EntFireByHandle(self, "RunScriptCode", "cd_use_CAN = true;", StanTime, null, null);
    }

    function SetUnStanned()
    {
        EntFire("AirBuster_Stager_Effect","Stop","",0);
        EntFire("AirBuster_Move_Physbox","EnableMotion","",1);
        SetPlayBackRate(1);
        SetAnimation(UnStanned_Anim);
        Stanned = false;
    }
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

    EntFireByHandle(self, "RunScriptCode", "SPEED_FORWARD = 0.3;", 0, null, null);
    EntFireByHandle(self, "RunScriptCode", "SPEED_TURNING = 0.3;", 0, null, null);

    EntFireByHandle(Model, "Color", "0 255 0", 0.00, null, null);

    EntFireByHandle(Model, "Color", "255 255 255", time, null, null);
    EntFireByHandle(self, "RunScriptCode", "SPEED_FORWARD = 1.0;", time, null, null);
    EntFireByHandle(self, "RunScriptCode", "SPEED_TURNING = 1.0;", time, null, null);
    EntFireByHandle(self, "RunScriptCode", "cd_use_CAN = true;", time, null, null);
}

function ItemEffect_Electro(time)
{
    if(time <= 0)
        return;
    cd_use_CAN = false;

    EntFire("AirBuster_Stager_Effect","Start","",0);
    EntFire("AirBuster_Move_Physbox","DisableMotion","",0);
    SetPlayBackRate(0,2.5);
    SetAnimation(Stanned_Anim);

    EntFire("AirBuster_Stager_Effect","Stop","",time);
    EntFire("AirBuster_Move_Physbox","EnableMotion","",time+1);
    EntFireByHandle(self, "RunScriptCode", "SetPlayBackRate(1);", time, null, null);
    EntFireByHandle(self, "RunScriptCode", "SetAnimation(UnStanned_Anim);", time, null, null);

    EntFireByHandle(self, "RunScriptCode", "cd_use_CAN = true;", time, null, null);
}
// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Attack settings
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
    //PUNCH
    {
        Punch_Damage <- 1;
        Punch_Radius <- 400;
        Punch_Push <- 1200;

        Punch_Anim <- "attack_hook";

        function Cast_Punch()
        {
            CompareDir();
            SetAnimation(Punch_Anim);
            SetPlayBackRate(2);
            EntFireByHandle(self, "RunScriptCode", "Cast_Punch_Next();", 0.8, null, null);
        }
        function Cast_Punch_Next()
        {
            local handle = null;
            local origin = GetAttOrigin("L_VFXMuzzleW_a") + Vector(0, 0, -50)
            DebugDrawCircle(origin, Vector(255,255,255), Punch_Radius, 12, true, tickrate+0.01);
            while (null != (handle = Entities.FindInSphere(handle, origin, Punch_Radius)))
            {
                if(handle == null)
                    continue;

                if(!handle.IsValid())
                    continue;

                if(handle.GetHealth() <= 0)
                    continue;
                Punch(handle);
            }
        }
        function Punch(Handle)
        {
            local hp = Handle.GetHealth() - Punch_Damage;

            if(hp < 1)
            {
                EntFireByHandle(Handle, "SetHealth", "-1", 0.00, null, null);
                return;
            }
            Handle.SetHealth(hp);

            local spos = Model.GetOrigin();
            local tpos = Handle.GetOrigin();
            local vec = spos - tpos;
            vec.Norm();

            Handle.SetVelocity(Vector((vec.x * -Punch_Push), (vec.y * -Punch_Push), (400)));
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
        //Shield_Count <- [4, 6, 8, 16];
        Shield_Count <- [16];
        Shield_Health <- 60.0;

        Shield_Rot <- Entities.FindByName(null, "AirBuster_Shield_Rotate");
        EntFireByHandle(Shield_Rot, "AddOutPut", "maxspeed " + (360.0 / Shield_FullRotate), 0.00, null, null);

        Shield_Maker  <- Entities.FindByName(null, "AirBuster_Shield_Spawner");
        Shield_Anim <- "attack_hover";

        function RegShield()
        {
            local model = caller;
            local hbox = Entities.FindByName(null, "AirBuster_Shield_Hbox" + caller.GetName().slice(caller.GetPreTemplateName().len(),caller.GetName().len()));
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
            SetAnimation(Shield_Anim);
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
                EntFireByHandle(self, "RunScriptCode", "Cast_Spawn_Shield();", time, null, null);
                time += timeadd;
            }
        }

        function Cast_Spawn_Shield()
        {
            Shield_Maker.SpawnEntity();
        }
    }
    //ROCKET
    {
        Rocket_Maker <- Entities.FindByName(null, "AirBuster_Rocket_Spawner");
        Rocket_Delay <- 0.16;
        Rocket_Anim <- "attack_missle";

        function Cast_Rocket()
        {
            SetAnimation(Rocket_Anim);
            EntFireByHandle(self, "RunScriptCode", "Cast_Rocket_Next();", 1.2, null, null);
        }

        function Cast_Rocket_Next()
        {
            local array;
            array = att_Rocket_R;

            for(local i = 0; i < array.len(); i++)
            {
                local origin = GetAttOrigin(array[i])
                local angles = GetAttAngles(array[i])

                EntFireByHandle(self, "RunScriptCode", "Rocket_Maker.SpawnEntityAtLocation(Vector(" + origin.x + "," + origin.y + "," + origin.z + "), Vector(" + angles.x + "," + angles.y + "," + angles.z + "));", Rocket_Delay * i, null, null);
            }

            array = att_Rocket_L;

            for(local i = 0; i < array.len(); i++)
            {
                local origin = GetAttOrigin(array[i])
                local angles = GetAttAngles(array[i])

                EntFireByHandle(self, "RunScriptCode", "Rocket_Maker.SpawnEntityAtLocation(Vector(" + origin.x + "," + origin.y + "," + origin.z + "), Vector(" + angles.x + "," + angles.y + "," + angles.z + "));", Rocket_Delay * i, null, null);
            }
        }

        function Cast_Rocket_Spam()
        {
            if(!ticking)
                return;

            Cast_Mine_Next();
            EntFireByHandle(self, "RunScriptCode", "Cast_Rocket_Spam()", 5, null, null);
        }
    }
    //LASER
    {
        Laser_L_Anim <- "bomber";

        function Cast_Laser_L()
        {
            SetAnimation(Laser_L_Anim);
            ToggleLower(3.2);

            SetPlayBackRate(0.05, 0.05);
            SetPlayBackRate(1, 3.2);

            ToggleHurtEffect(Laser_L, 0.8, 3.4);
        }

        Laser_C_Anim <- "attackcannon";

        function Cast_Laser_C()
        {
            CompareDir();
            EntFire("AirBuster_Move_Physbox","DisableMotion","",0);
            SetAnimation(Laser_C_Anim);
            EntFireByHandle(self, "RunScriptCode", "Cast_Laser_C_Next();", 1, null, null);
        }
        function Cast_Laser_C_Next()
        {
            ToggleHurtEffect(Laser_C, 0, 3.4);

            if(RandomInt(0, 1))
            {
                EntFire("AirBuster_Model","Setparent","AirBuster_Rotate_R",0);
                EntFire("AirBuster_Rotate_R","Open","",0.);
                EntFire("AirBuster_Move_Physbox","EnableMotion","",3.4);
            }
            else
            {
                EntFire("AirBuster_Model","Setparent","AirBuster_Rotate_L",0);
                EntFire("AirBuster_Rotate_L","Open","",0);
                EntFire("AirBuster_Move_Physbox","EnableMotion","",3.4);
            }
        }
    }
    //WIND
    {
        Wind_Damage <- 40;
        Wind_FullDamage <- 316;
        Wind_Power <- 726;
        Wind_Radius <- 800;
        Wind_Anim_r <- "attackblow_r";
        Wind_Anim_l <- "attackblow_l";

        function Cast_Wind(side = -1)
        {
            local R = false;
            if(side == -1)
            {
                R = true;
                side = RandomInt(0, 1);
            }

            if(side)
            {
                SetAnimation(Wind_Anim_r);
                EntFireByHandle(self, "RunScriptCode", "Cast_Wind_Next(true);", 1.35, null, null);
                if(R)EntFireByHandle(self, "RunScriptCode", "Cast_Wind(0);", 1.8, null, null);
            }
            else
            {
                SetAnimation(Wind_Anim_l);
                EntFireByHandle(self, "RunScriptCode", "Cast_Wind_Next(false);", 1.35, null, null);
                if(R)EntFireByHandle(self, "RunScriptCode", "Cast_Wind(1);", 1.8, null, null);
            }
        }
        function Cast_Wind_Next(left)
        {
            local origin;

            if(left)origin = Model.GetOrigin() + Model.GetUpVector() * 200 + Vector(0, 0, -100);
            else origin = Model.GetOrigin() + Model.GetUpVector() * -200 + Vector(0, 0, -100);

            DebugDrawCircle(origin, Vector(0,0,255), Wind_Radius, 12, true, 5);
            local handle = null;
            while (null != (handle = Entities.FindInSphere(handle, origin, Wind_Radius)))
            {
                if(handle == null)
                    continue;

                if(!handle.IsValid())
                    continue;

                if(handle.GetHealth() <= 0)
                    continue;

                Wind(handle, origin);
            }
        }
        function Wind(Handle, origin)
        {
            local tpos = Handle.GetOrigin();
            local dist = GetDistance2D(origin, tpos);

            local resist = dist / Wind_Radius;
            if(dist <= Wind_FullDamage)
            resist = 0;

            local damage = Wind_Damage - Wind_Damage * resist;
            local hp = Handle.GetHealth() - damage;

            if(hp < 1)
            {
                EntFireByHandle(Handle, "SetHealth", "-1", 0.00, null, null);
                return;
            }
            Handle.SetHealth(hp);


            local vec = origin - tpos;
            vec.Norm();

            local push = Vector((vec.x * -Wind_Power), (vec.y * -Wind_Power), (300));
            if (Handle.GetVelocity().z >50)
            {
                push = Vector(push.x, push.y, 0);
            }
            Handle.SetVelocity(push);

            EntFire("AirBuster_Wind_Effect", "Start", "", 0);
            EntFire("AirBuster_Wind_Effect", "DestroyImmediately", "", 0.9);
        }
    }
    //FLAME
    {
        Flang_Flame_Anim <- "attack_machine";

        function Cast_Flame()
        {
            switch  (RandomInt(0,2))
                {
                    case 0:
                    {
                        EntFireByHandle(self, "RunScriptCode", "Cast_Flang_Flame()", 0, null, null);
                        break;
                    }
                    case 1:
                    {
                        EntFireByHandle(self, "RunScriptCode", "Cast_Flang_Flame()", 0, null, null);
                        break;
                    }
                    case 2:
                    {
                        EntFireByHandle(self, "RunScriptCode", "Cast_Low_Flame()", 0, null, null);
                        break;
                    }

                }
        }
        function Cast_Flang_Flame()
        {
            SetAnimation(Flang_Flame_Anim);
            SetPlayBackRate(0.05, 0.75);
            SetPlayBackRate(1, 2.8);

            ToggleHurtEffect(Flame_R_U, 0.55, 3.35);
            ToggleHurtEffect(Flame_L_U, 0.55, 3.35);

            ToggleHurtEffect(Flame_R_M, 0.55, 3.75);
            ToggleHurtEffect(Flame_L_M, 0.55, 3.75);


            ToggleHurtEffect(Flame_R_L, 0.2, 4)
            ToggleHurtEffect(Flame_L_L, 0.2, 4)
        }

        Flame_Rotate_Anim <- "attack_grenade";

        doorchek <- false;

        function Cast_Rotate_Flame()
        {
            EntFire("AirBuster_Move_Physbox","DisableMotion","",0);
            SetAnimation(Flame_Rotate_Anim);
            SetPlayBackRate(0.3, 1.0);
            SetPlayBackRate(1, 3.0);
            ToggleLower(2);

            EntFire("AirBuster_Model","SetParent","AirBuster_Rotate",0);
            //Rotate(720, 0.5, 4.5);
            if (doorchek)
            {
                EntFire("AirBuster_Rotate","Open","",0);
            }
            else
            {
                EntFire("AirBuster_Rotate","close","",0);
            }
            doorchek = !doorchek
            ToggleHurtEffect(Flame_R_M, 0.3, 3.5)
            ToggleHurtEffect(Flame_L_M, 0.3, 3.5)

            ToggleHurtEffect(Flame_R_U, 0.3, 2.5)
            ToggleHurtEffect(Flame_L_U, 0.3, 2.5)

            ToggleHurtEffect(Flame_R_B_L, 0.3, 4.5)
            ToggleHurtEffect(Flame_L_B_L, 0.3, 4.5)
            EntFire("AirBuster_Move_Physbox","EnableMotion","",4.5);
        }


        Low_Flame_Anim <- "idle";

        function Cast_Low_Flame()
        {
            EntFire("AirBuster_Move_Physbox","DisableMotion","",0);
            SetAnimation(Low_Flame_Anim);
            ToggleLower(5.2);

            ToggleHurtEffect(Flame_R_F_L, 0.5, 5.2);
            ToggleHurtEffect(Flame_L_F_L, 0.5, 5.2);
            ToggleHurtEffect(Flame_L_L, 0.75, 5);
            ToggleHurtEffect(Flame_R_L, 0.75, 5);
            ToggleHurtEffect(Flame_L_B_L, 1, 5.4);
            ToggleHurtEffect(Flame_R_B_L, 1, 5.4);
            EntFire("AirBuster_Move_Physbox","EnableMotion","",5.5);

        }
    }
    //MINE
    {
        Mine_Count <- [1, 3];
        Mine_Radius <- 150;
        Mine_Interval <- [0.5, 3.2];

        Mine_Maker <- null;
        Mine_Anim <- "attack_rocket";

        function Cast_Mine()
        {
            SetAnimation(Mine_Anim);
            EntFireByHandle(self, "RunScriptCode", "Cast_Mine_Next();", 0.8, null, null);
        }
        function Cast_Mine_Next()
        {
            local count = RandomInt(Mine_Count[0], Mine_Count[1]);
            local interval = 0;
            for(local i = 0; i < count; i++)
            {
                if(count > 1)
                    interval = RandomFloat(Mine_Interval[0], Mine_Interval[1])

                    local origin = Model.GetOrigin();
                    origin += Vector(RandomInt(-Mine_Radius, Mine_Radius), RandomInt(-Mine_Radius, Mine_Radius), 0);
                EntFireByHandle(self, "RunScriptCode", "Mine_Maker.SpawnEntityAtLocation(Vector(" + origin.x + "," + origin.y + "," + origin.z + "), Vector(0,0,0));", interval, null, null);
            }
        }
    }
    //HEAL
    {
        Heal_Anim <- "attack_hover";

        function Cast_Heal()
        {
            EntFire("AirBuster_Heal_Effect","Start","",0);
            EntFire("AirBuster_Heal_Effect","Stop","",4);
            SetAnimation(Heal_Anim);
            AddHP(CountAlive()*50);
        }
    }
    //CONFUSE
    {

        Confuse_Maker <- Entities.FindByName(null, "AirBuster_Confuse_Spawner");
        Confuse_Anim <- "attack_beam";

        function Cast_Confuse()
        {
            CompareDir();
            EntFire("AirBuster_Move_Physbox","DisableMotion","",0);
            ToggleHurtEffect(Confuse_R, 2.0, 3.5);
            ToggleHurtEffect(Confuse_L, 2.0, 3.5);
            SetAnimation(Confuse_Anim);
            EntFireByHandle(self, "RunScriptCode", "Cast_Confuse_Next();", 2.0, null, null);
            EntFire("AirBuster_Move_Physbox","EnableMotion","",3.4);
        }

        function Cast_Confuse_Next()
        {
            local origin = GetAttOrigin("C_VFXMuzzleD_a") + Model.GetLeftVector() * -550 + Vector(0, 0, 5);
            Confuse_Maker.SpawnEntityAtLocation(origin, Vector(0,0,0));

            origin = GetAttOrigin("C_VFXMuzzleD_a") + Model.GetLeftVector() * -1200 + Vector(0, 0, 5);
            Confuse_Maker.SpawnEntityAtLocation(origin, Vector(0,0,0));
        }
    }

     //Ice
    {

        Ice_Maker <- Entities.FindByName(null, "AirBuster_Ice_Air_Spawner");
        Ice_Anim <- "attack_beam";

        function Cast_Ice()
        {
            CompareDir();
            EntFire("AirBuster_Move_Physbox","DisableMotion","",0);
            ToggleHurtEffect(Ice_R, 2.05, 3.5);
            ToggleHurtEffect(Ice_L, 2.05, 3.5);
            SetAnimation(Ice_Anim);
            EntFireByHandle(self, "RunScriptCode", "Cast_Ice_Next();", 2.0, null, null);
            EntFire("AirBuster_Move_Physbox","EnableMotion","",3.4);
        }

        function Cast_Ice_Next()
        {
            local origin = GetAttOrigin("C_VFXMuzzleD_a") + Model.GetLeftVector() * -550 + Vector(0, 0, 5);
            Ice_Maker.SpawnEntityAtLocation(origin, Vector(0,0,0));

            origin = GetAttOrigin("C_VFXMuzzleD_a") + Model.GetLeftVector() * -1200 + Vector(0, 0, 5);
            Ice_Maker.SpawnEntityAtLocation(origin, Vector(0,0,0));
        }
    }
}
// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Fake Parent
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
    FakeParentArray <- [];
    class fakeparent
    {
        handle = null
        attachment = null;
        move = null;
        ang = null;

        constructor(_handle, _attachment, _ang = Vector(0, 0, 0), _move = Vector(0, 0, 0))
        {
            this.handle = _handle;
            this.attachment = _attachment;
            this.move = _move;
            this.ang = _ang;
        }
    }
}
// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Hurt And Particle
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
    class hurtandpart
    {
        particle = null
        hurt = null;
        constructor(_particle, _hurt)
        {
            this.particle = _particle;
            this.hurt = _hurt;
        }
    }

    function ToggleHurtEffect(id, on, off)
    {
        EntFireByHandle(id.particle, "Start", "", on, null, null);
        EntFireByHandle(id.particle, "Stop", "", off, null, null);

        EntFireByHandle(id.hurt, "Enable", "", on, null, null);
        EntFireByHandle(id.hurt, "Disable", "", off, null, null);
    }
}
// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Other settings
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
    Model <- self;

    Hit_Box_L <- null;
    Hit_Box_H_L <- null;
    Hit_Box_H_R <- null;
    Hit_Box_C <- null;
    Hit_Box_U <- null;
    Electro_L <- null;
    Flame_R_M <- null;
    Flame_L_M <- null;
    Flame_R_U <- null;
    Flame_L_U <- null;
    Flame_R_L <- null;
    Flame_L_L <- null;
    Flame_R_F_L <- null;
    Flame_L_F_L <- null;
    Flame_R_B_L <- null;
    Flame_L_B_L <- null;
    Laser_C <- null;
    Laser_L <- null;
    Confuse_R <- null;
    Confuse_L <- null;
    Ice_R <- null;
    Ice_L <- null;
}

    allow_punch         <- true;        //стандарт
    allow_shield        <- true;        //тело
    allow_rocket        <- true;        //голова
    allow_laser         <- true;        //тело
    allow_wind          <- true;        //стандарт
    allow_flame         <- true;        //ноги
    allow_mine          <- true;        //ноги
    allow_heal          <- true;        //голова
    allow_confuse       <- true;        //руки
    allow_ice           <- true;

// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      MOVING NPC SCRIPT - BY LUFFAREN (STEAM_1:1:22521282)  \\
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞


//TICKRATE 		<- 	0.10;

TARGET_DISTANCE <- 	5000;

RETARGET_TIME 	<- 	8.00;

SPEED_FORWARD 	<- 	1.00;

SPEED_TURNING 	<- 	1.00;

MIN_SPEED		<- 	2;

MAX_STOP_TIME	<- 	10.00;

p <- null;
tf <- null;
ts <- null;
ttime <- 0.00;
//ticking <- false;
counter1 <- 0.00;
lastpos <- self.GetOrigin();


function Movement()
{
	// if(GetDistance(self.GetOrigin(),lastpos) < MIN_SPEED)
	// 	counter1 += 0.10;
	// else counter1 = 0.00;
	// if(counter1 > MAX_STOP_TIME)
	// {
	// 	EntFireByHandle(ts,"Deactivate","",0.00,null,null);
	// 	EntFireByHandle(ts,"AddOutput","force 4000",0.01,null,null);
	// 	EntFireByHandle(ts,"Activate","",0.02,null,null);
	// }
	lastpos = self.GetOrigin();
	EntFireByHandle(tf,"Deactivate","",0.00,null,null);
	EntFireByHandle(ts,"Deactivate","",0.00,null,null);
	if(p == null ||
    !p.IsValid() ||
    p.GetHealth() < 1 ||
    p.GetTeam() != 3 ||
    ttime >= RETARGET_TIME)
    {
        return SearchTarget();
    }
	ttime += tickrate;
    local tdist = GetDistance2D(self.GetOrigin(),p.GetOrigin());
	local tdistz = (p.GetOrigin().z-self.GetOrigin().z);
    if (tdist > 75)
    {
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
        EntFireByHandle(tf,"AddOutput","force "+(3000*SPEED_FORWARD).tostring(),0.00,null,null);
        EntFireByHandle(ts,"AddOutput","force "+((3*SPEED_TURNING)*angdif).tostring(),0.00,null,null);
    }
    else
    {
        tickrate_use += 0.03;
    }
}

function SearchTarget()
{
    ttime = 0.00;
    if(Global_Target != null && Global_Target.IsValid() && Global_Target.GetHealth() > 0 && Global_Target.GetTeam() == 3)
    {
        p = Global_Target;
        return;
    }

    local array = [];
    local h = null;
    while(null != (h = Entities.FindByClassname(h, "player")))
    {
        if(h != null)
        {
            if(h.IsValid() && h.GetHealth() > 0)
            {
                if(h.GetTeam() == 3)
                {
                    local luck = MainScript.GetScriptScope().GetPlayerClassByHandle(h)
                    if(luck != null)
                    {
                        luck = luck.perkluck_lvl;
                        if(luck > 0)
                        {
                            if(RandomInt(1, 100) < luck * perkluck_luckperlvl)
                            {
                                continue;
                            }
                        }
                    }
                    array.push(h);
                }
            }
        }
    }

    p = null;

    if (array.len() == 0)
    {
        return;
    }
    if (array.len() == 1)
    {
        p = array[0];
        return;
    }

    // if (GetChance(60))
    // {
    //     local items = MainScript.GetScriptScope().ITEM_OWNER.slice();

    //     local removearray = [];

    //     foreach (index, item in items)
    //     {
    //         if (item.owner == null ||
    //         !item.owner.IsValid() ||
    //         item.owner.GetTeam() != 3 ||
    //         item.owner.GetHealth() < 1)
    //         {
    //             removearray.push(index);
    //             continue;
    //         }
    //     }

    //     removearray.reverse();
    //     foreach (item in removearray)
    //     {
    //         items.remove(item);
    //     }
    //     removearray.clear();

    //     foreach (index, item in items)
    //     {
    //         if (item.name_right == "electro")
    //         {
    //             if (GetChance(50))
    //             {
    //                 p = item.owner;
    //                 return;
    //             }
    //             else
    //             {
    //                 removearray.push(index);
    //                 continue;
    //             }
    //         }
    //     }

    //     foreach (index, item in items)
    //     {
    //         if (item.name_right == "heal")
    //         {
    //             if (GetChance(40))
    //             {
    //                 p = item.owner;
    //                 return;
    //             }
    //             else
    //             {
    //                 removearray.push(index);
    //                 continue;
    //             }
    //         }
    //     }

    //     foreach (index, item in items)
    //     {
    //         if (item.name_right == "ultimate")
    //         {
    //             if (GetChance(40))
    //             {
    //                 p = item.owner;
    //                 return;
    //             }
    //             else
    //             {
    //                 removearray.push(index);
    //                 continue;
    //             }
    //         }
    //     }

    //     foreach (index, item in items)
    //     {
    //         if (item.name_right == "gravity")
    //         {
    //             if (GetChance(80))
    //             {
    //                 removearray.push(index);
    //                 continue;
    //             }
    //         }
    //     }
    //     removearray.reverse();
    //     foreach (item in removearray)
    //     {
    //         items.remove(item);
    //     }

    //     if (items.len() > 0)
    //     {
    //         p = items[RandomInt(0, items.len() - 1)].owner;

    //         if (p != null)
    //         {
    //             return;
    //         }
    //     }
    // }
    p = array[RandomInt(0, array.len() - 1)];
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

function SetThrusterTs()
{
    ts=caller;
}

function SetThrusterTf()
{
    tf=caller;
}


function GetDistance(v1,v2)
{
    return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));
}

// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Main
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
function PreStart()
{
    EntFire("AirBuster_Top_Move", "FireUser1", "", 10);
    EntFire("Boss_Dicks_Move", "Close", "", 10);
    EntFire("Boss_Push", "Kill", "", 10);
    EntFire("Credits_Game_Text", "AddOutput", "message AirBuster", 0);
    EntFire("Credits_Game_Text", "Display", "", 10);
    EntFire("Camera_old", "RunScriptCode", "SpawnCameras(Vector(-1250,5152,326),Vector(-60,180,0),6,Vector(-854,5152,486),Vector(15,180,0),3,4)", 11);
    EntFire("Camera_old", "RunScriptCode", "SetOverLay(Overlay)", 11);
    EntFire("Camera_old", "RunScriptCode", "SetOverLay()", 24);
    //o1, a1, time1, o2, a2, time2, flytime
}
Default_Anim <- "walk";
function Start()
{
    EntFire("AirBuster_Nade", "Enable", "", 0);
    EntFireByHandle(self, "RunScriptCode", "Cast_Rocket_Spam()", 150, null, null);
    EntFire("Name_Texture", "AddOutPut", "target AirBuster_Name_Bar", 0);
    EntFire("Timer_Texture", "AddOutPut", "target AirBuster_Timer_Bar", 0);
    EntFire("Special_HealthTexture", "AddOutPut", "target AirBuster_HP_Bar", 0);
    tf = Entities.FindByName(null, "AirBuster_thruster_forward");
    ts = Entities.FindByName(null, "AirBuster_thruster_side");

    Model = Entities.FindByName(null,"AirBuster_Model");

    Init();
    ticking = true;
    MainScript.GetScriptScope().Active_Boss = "AirBuster";

    local item_target = Entities.FindByName(null, "map_item_beam_target");
    item_target.SetOrigin(Model.GetOrigin());

    EntFireByHandle(item_target, "SetParent", "!activator", 0, Model, Model);
    Tick();
    EntFireByHandle(self, "RunScriptCode", "StunUnlock()", RandomInt(30,50), null, null);
    SetDefaultAnimation(Default_Anim);
}

function StunUnlock()
{
    Stanblock = false;
    ScriptPrintMessageChatAll(Chat_pref + "The boss is weak, you can stagger him now!");
}

function Init()
    {
        Model.__KeyValueFromInt("rendermode", 1);
        local ent;

        Mine_Maker = Entities.FindByName(null, "AirBuster_Mine_Spawner");

        ent = Entities.FindByName(null, "AirBuster_Ice_R_Effect");
        FakeParentArray.push(fakeparent(ent, "R_VFXMuzzleW_a", Vector(0, 0, 0), Vector(-80, -6, 0)));
        Ice_R = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Ice_R_Hurt"));

        ent = Entities.FindByName(null, "AirBuster_Ice_L_Effect");
        FakeParentArray.push(fakeparent(ent, "L_VFXMuzzleW_a", Vector(0, 0, 0), Vector(-80, -6, 0)));
        Ice_L = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Ice_L_Hurt"));

        ent = Entities.FindByName(null, "AirBuster_Confuse_R_Effect");
        FakeParentArray.push(fakeparent(ent, "R_VFXMuzzleW_a", Vector(0, 0, 0), Vector(-80, -6, 0)));
        Confuse_R = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Confuse_R_Hurt"));

        ent = Entities.FindByName(null, "AirBuster_Confuse_L_Effect");
        FakeParentArray.push(fakeparent(ent, "L_VFXMuzzleW_a", Vector(0, 0, 0), Vector(-80, -6, 0)));
        Confuse_L = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Confuse_L_Hurt"));

        ent = Entities.FindByName(null, "AirBuster_Attack_Fire_Effect_a");
        FakeParentArray.push(fakeparent(ent, "R_VFXMuzzleQ_a", Vector(0, 0, 0), Vector(-80, -6, 0)));
        Flame_R_M = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Attack_Fire_Hurt_a"));

        ent = Entities.FindByName(null, "AirBuster_Attack_Fire_Effect_b");
        FakeParentArray.push(fakeparent(ent, "L_VFXMuzzleQ_a", Vector(0, 0, 0), Vector(-80, -6, 0)));
        Flame_L_M = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Attack_Fire_Hurt_b"));

        ent = Entities.FindByName(null, "AirBuster_Attack_Fire_Effect_c");
        FakeParentArray.push(fakeparent(ent, "R_VFXMuzzleP_a", Vector(0, 0, 0), Vector(-80, -6, 0)));
        Flame_R_U = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Attack_Fire_Hurt_c"));

        ent = Entities.FindByName(null, "AirBuster_Attack_Fire_Effect_d");
        FakeParentArray.push(fakeparent(ent, "L_VFXMuzzleP_a", Vector(0, 0, 0), Vector(-80, -6, 0)));
        Flame_L_U = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Attack_Fire_Hurt_d"));

        ent = Entities.FindByName(null, "AirBuster_Attack_Fire_Effect_e");
        FakeParentArray.push(fakeparent(ent, "L_VFXMuzzleB_a", Vector(0, 0, 0), Vector(-40, 0, 0)));
        Flame_L_L = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Attack_Fire_Hurt_e"));

        ent = Entities.FindByName(null, "AirBuster_Attack_Fire_Effect_f");
        FakeParentArray.push(fakeparent(ent, "R_VFXMuzzleB_a", Vector(0, 0, 0), Vector(-15, 0, 0)));
        Flame_R_L = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Attack_Fire_Hurt_f"));

        ent = Entities.FindByName(null, "AirBuster_Attack_Fire_Effect_g");
        FakeParentArray.push(fakeparent(ent, "R_VFXMuzzleA_a", Vector(0, 0, 0), Vector(-25, 0, 0)));
        Flame_R_F_L = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Attack_Fire_Hurt_g"));

        ent = Entities.FindByName(null, "AirBuster_Attack_Fire_Effect_h");
        FakeParentArray.push(fakeparent(ent, "L_VFXMuzzleA_a", Vector(0, 0, 0), Vector(-25, 0, 0)));
        Flame_L_F_L = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Attack_Fire_Hurt_h"));

        ent = Entities.FindByName(null, "AirBuster_Attack_Fire_Effect_i");
        FakeParentArray.push(fakeparent(ent, "L_VFXMuzzleC_a", Vector(0, 0, 0), Vector(-25, 0, 0)));
        Flame_L_B_L = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Attack_Fire_Hurt_i"));

        ent = Entities.FindByName(null, "AirBuster_Attack_Fire_Effect_j");
        FakeParentArray.push(fakeparent(ent, "R_VFXMuzzleC_a", Vector(0, 0, 0), Vector(-25, 0, 0)));
        Flame_R_B_L = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Attack_Fire_Hurt_j"));

        ent = Entities.FindByName(null, "AirBuster_Chest_Laser_Effect_a");
        FakeParentArray.push(fakeparent(ent, "C_VFXMuzzleA_a", Vector(90, 0, 0), Vector(-20, -15, 0)));
        Laser_C = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Chest_Laser_Hurt_a"));

        ent = Entities.FindByName(null, "AirBuster_Chest_Laser_Effect_b");
        FakeParentArray.push(fakeparent(ent, "C_VFXMuzzleB_a", Vector(180, 0, 0), Vector(-50, -30, 0)));
        Laser_L = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Chest_Laser_Hurt_b"));

        ent = Entities.FindByName(null, "AirBuster_Attack_Electro_Effect_a");
        FakeParentArray.push(fakeparent(ent, "C_VFXMuzzleD_a", Vector(0, 270, 270), Vector(0, -25, 0)));
        Electro_L = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Attack_Electro_Hurt_a"));

        Hit_Box_H_L = Entities.FindByName(null, "AirBuster_Hbox_H_L");
        FakeParentArray.push(fakeparent(Hit_Box_H_L, "L_HandRoll_a", Vector(0, 0, 0), Vector(60, -20, 0)));

        Hit_Box_H_R = Entities.FindByName(null, "AirBuster_Hbox_H_R");
        FakeParentArray.push(fakeparent(Hit_Box_H_R, "R_HandRoll_a", Vector(0, 0, 0), Vector(60, -20, 0)));

        Hit_Box_L = Entities.FindByName(null, "AirBuster_Hbox_L");
        FakeParentArray.push(fakeparent(Hit_Box_L, "C_VFXMuzzleD_a", Vector(0, 0, 90), Vector(0, 0, 90)));

        Hit_Box_U = Entities.FindByName(null, "AirBuster_Hbox_U");
        FakeParentArray.push(fakeparent(Hit_Box_U, "C_Head_end", Vector(15, 0, 0), Vector(0, 0, 0)));

        Hit_Box_C = Entities.FindByName(null, "AirBuster_Hbox_C");
        FakeParentArray.push(fakeparent(Hit_Box_C, "C_VFXMuzzleA_a", Vector(0, 0, 0), Vector(-60, 30, 0)));

//        ent = Entities.FindByName(null, "AirBuster_Nade");
//        FakeParentArray.push(fakeparent(ent, "C_VFXMuzzleD_a", Vector(0, 0, 0), Vector(0, 200, 0)));

        SetHP(600);

        EntFireByHandle(Hit_Box_L, "FireUser1", "", 0, null, null);
        EntFireByHandle(Hit_Box_H_L, "FireUser1", "", 0, null, null);
        EntFireByHandle(Hit_Box_H_R, "FireUser1", "", 0, null, null);
        EntFireByHandle(Hit_Box_C, "FireUser1", "", 0, null, null);
        EntFireByHandle(Hit_Box_U, "FireUser1", "", 0, null, null);

        EntFireByHandle(Electro_L.particle, "Start", "", 0, null, null);
        EntFireByHandle(Electro_L.hurt, "Enable", "", 0, null, null);
        // ent = Entities.FindByName(null, "AirBuster_Attachment_Attack_Fire_d");
        // SetAttachment(ent);
        EntFire("AirBuster_HP_Bar", "ShowSprite", "", 0.01);
        EntFire("AirBuster_Name_Bar", "ShowSprite", "", 0.01);
        EntFire("AirBuster_Timer_Bar", "ShowSprite", "", 0.01);
        EntFire("AirBuster_Hbox*", "SetDamageFilter", "filter_humans", 0);
    }

    function Tick()
    {
        if(!ticking)
            return;

        //Debug();

        FakeParent();
        UpDateCasttime();
        UpDateHP();
        UpDateStatus();

        TickUse();
        StanTick();

        ShowBossStatus();
        Movement();

        EntFireByHandle(self, "RunScriptCode", "Tick();", tickrate, null, null);
    }

    function Debug()
    {
        local ent;
        //DrawBoundingBox(ent);

        DrawBoundingBox(Hit_Box_L);
        DrawBoundingBox(Hit_Box_H_L);
        DrawBoundingBox(Hit_Box_H_R);
        DrawBoundingBox(Hit_Box_C);
        DrawBoundingBox(Hit_Box_U);

        ent = Entities.FindByName(null, "AirBuster_Nade");
        DrawBoundingBox(ent);

        //DrawBox(GetAttOrigin("C_VFXMuzzleD_a") + Model.GetLeftVector() * -550 + Vector(0, 0, 5));


        // ent = Entities.FindByName(null, "AirBuster_Attachment_Attack_Fire_c");
        // DrawBoundingBox(ent);

        // ent = Entities.FindByName(null, "AirBuster_Attachment_Attack_Fire_d");
        // DrawBoundingBox(ent);
    }

    function FakeParent()
    {
        for(local i = 0; i < FakeParentArray.len(); i++ )
        {
            SetFakeParent(FakeParentArray[i]);
        }
    }

    function SetFakeParent(ID)
    {
        local angles = GetAttAngles(ID.attachment)

        local ang = ID.ang;
        angles.x += ang.x;
        angles.y += ang.y;
        angles.z += ang.z;
        ID.handle.SetAngles(angles.x, angles.y, angles.z);

        local origin = GetAttOrigin(ID.attachment)

        local move = ID.move;
        origin += ID.handle.GetForwardVector() * move.x;
        origin += ID.handle.GetLeftVector() * move.y;
        origin += ID.handle.GetUpVector() * move.z;

        ID.handle.SetOrigin(origin);
    }

    function UpDateHP()
    {
        if(HP < 1)
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
            EntFire("map_brush", "RunScriptCode", "Trigger_Cave_After_Boss()", 0);
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
        if (!Stanned)
        {
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
    }

    function ShowBossStatus()
    {
        if(!ticking)
            return;

        local message;

        message = "[Air Buster] : Status : " + Status + "\n";
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
        message += "\n\nCore A: " + GetProccentHP(HP_U, HP_U_TOTAL) + "%";
        message += "\nCore B: " + GetProccentHP(HP_H, HP_H_TOTAL) + "%";
        message += "\nCore C: " + GetProccentHP(HP_C, HP_C_TOTAL) + "%";
        message += "\nCore D: " + GetProccentHP(HP_L, HP_L_TOTAL) + "%";

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

    function GetProccentHP(iValue, iMax)
    {
        local iProccent = (iValue * 1.0 / iMax * 100).tointeger();
        return iProccent;
    }

    function ShowBossDeadStatus()
    {
        local message;
        message = "[Air Buster] : Status : Dead\n";

        for(local i = HP_BARS; i < 16; i++)
        {
            message += "◇";
        }

        ScriptPrintMessageCenterAll(message);
    }
}
// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Support Function
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
    function TickUse()
    {
        if(!cd_use_CAN)
            return;
        if(tickrate_use + tickrate >= cd_use)
        {
            tickrate_use = 0;
            Use();
        }
        else tickrate_use += tickrate;
    }

    use_array <- [];

    function Use()
    {
        if(use_array.len() <= 0)
        {
            if(allow_punch)
                use_array.push("Punch");

            if(allow_shield)
                use_array.push("Shield");

            if(allow_rocket)
                use_array.push("Rocket");

            if(allow_laser)
                use_array.push("Laser_C");

            if(allow_wind)
                use_array.push("Wind");

            if(allow_flame)
                use_array.push("Flame");

            if(allow_mine)
                use_array.push("Mine");

            if(allow_heal)
                use_array.push("Heal");

            if(allow_confuse)
                use_array.push("Confuse");

            if(allow_ice)
                use_array.push("Ice");
        }
        local use_index = -1;

        // rocket - ауе демедж+

        // laser_c - смертельный демедж+

        // wind - пуш мили+
        // flame - огнемет мили+

        // punch - мили аттака пушем+
        // mine - мина под собой

        // ice - по центру лучше всего юзать для макс импакта

        // shield - сейв+
        // heal - сейв+
        // confuse - сейв+

        if (GetChance(85))
        {
            local iInArena = InArena();
            local iCountAlive = CountAlive();
            local iNearBoss = NearBoss();

            if(HP_BARS <= 5 || NadeCount > NadeShow)
            {
                if(use_index == -1)
                    use_index = InArray("Shield", use_array);
            }

            if(HP_BARS <= 12 || NadeCount > NadeShow)
            {
                if(use_index == -1)
                    use_index = InArray("Heal", use_array);
            }

            if (NadeCount > NadeShow)
            {
                if(use_index == -1)
                    use_index = InArray("Confuse", use_array);
            }

            if(p != null &&
            p.IsValid() &&
            p.GetHealth() > 0 &&
            p.GetTeam() == 3 &&
            RETARGET_TIME > ttime)
            {
                local distance = GetDistance2D(p.GetCenter(), self.GetOrigin());
                if (distance < 250)
                {
                    if(use_index == -1)
                    {
                        use_index = InArray("Punch", use_array);
                        ttime -= 3.0;
                    }
                }
                else if (GetChance(70))
                {
                    if(use_index == -1)
                    {
                        use_index = InArray("Laser_C", use_array);
                        ttime -= 3.0;
                    }
                }
            }

            if (iInArena > (iCountAlive / 4) && GetChance(60))
            {
                if(use_index == -1)
                    use_index = InArray("Rocket", use_array);
            }

            if (iNearBoss > (iCountAlive / 4) && GetChance(70))
            {
                if(use_index == -1)
                    use_index = InArray("Wind", use_array);

                if(use_index == -1)
                    use_index = InArray("Flame", use_array);

                if(use_index == -1)
                    use_index = InArray("Ice", use_array);
            }
        }

        if (use_index == -1)
        {
            use_index = RandomInt(0, use_array.len() - 1);
        }

        EntFireByHandle(self, "RunScriptCode", "Cast_"+use_array[use_index]+"();", 0, null, null);

        use_array.remove(use_index);
    }

    function InArray(value, array)
    {
        for(local i = 0; i < array.len(); i++)
        {
            if(array[i] == value)
                return i;
        }
        return -1;
    }

    function CompareDir()
    {
        if(p != null &&
        p.IsValid() &&
        p.GetHealth() > 0 &&
        p.GetTeam() == 3)
        {
            local vec = p.GetCenter() - self.GetOrigin();
            vec.Norm();
            vec = Vector(vec.x, vec.y, 0);
            self.SetForwardVector(vec);
        }
    }

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

        while (null != (handle = Entities.FindInSphere(handle , Model.GetOrigin(), InArena_Radius)))
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

    function GetChance(value)
    {
        if(RandomInt(0, 100) <= value)
            return true;
        return false;
    }


    function Rotate(radian = 360, timestart = 0, timeend = 1, side = RandomInt(0, 1))
    {
        if(side == 0)
            side = -1;

        local ang = 0.5
        local ticks = radian / ang;
        local time = (timeend - timestart) / ticks;

        for(local i = 0; i < ticks; i++)
        {
            EntFireByHandle(self, "RunScriptCode", "ModelSetRotate(" + (ang * side) + ")", timestart + (i * time), null, null);
        }
    }

    function ToggleLower(off)
    {
//        for(local i = 1; i < 76; i++)
//        {
//            EntFireByHandle(self, "RunScriptCode", "ModelSetZ(" + (-i * 0.02) + ")", (i * 0.01), null, null);
//            EntFireByHandle(self, "RunScriptCode", "ModelSetZ(" + (i * 0.02) + ")", off + (i * 0.05), null, null);
//        }
        EntFire("AirBuster_Move","Open","",0);
        EntFire("AirBuster_Move","Close","",off);
    }

    function ModelSetZ(i)Model.SetOrigin(Model.GetOrigin() + Vector(0, 0, i));
    function ModelSetRotate(i){local angles = Model.GetAngles();Model.SetAngles(angles.x, angles.y, angles.z + i);}

    function SetAnimation(animationName,time = 0)EntFireByHandle(Model, "SetAnimation", animationName, time, null, null);
    function SetPlayBackRate(Speed,time = 0)EntFireByHandle(Model, "SetPlayBackRate", "" + Speed, time, null, null);
    function SetDefaultAnimation(animationName,time = 0)EntFireByHandle(Model, "SetDefaultAnimation", animationName, time, null, null);
    function CountAlive(TEAM = 3)
    {
        local handle = null;
        local counter = 0;
        while(null != (handle = Entities.FindByClassname(handle,"player")))
        {
            if(handle.GetTeam() == TEAM && handle.GetHealth() > 0)counter++;
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
    function GetDistance3D(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));
    function GetDistance2D(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y));

    function GetAttOrigin(AttachmentName)return Model.GetAttachmentOrigin(Model.LookupAttachment(AttachmentName));
    function GetAttAngles(AttachmentName)return Model.GetAttachmentAngles(Model.LookupAttachment(AttachmentName));

    function SetTestAtt(ID)
    {
        local ent = Entities.FindByName(null, "AirBuster_Attachment_tester");
        EntFireByHandle(ent, "SetParentAttachment", AttachmenntArray[ID], 0.00, null, null);
        AttachmenntID = ID;
        PrintAtt();
    }
    function PrintAtt()ScriptPrintMessageChatAll(AttachmenntArray[AttachmenntID]);

    function DrawBox(VectorX)DebugDrawBox(VectorX, Vector(-16, -16, -16), Vector(16, 16, 16), 255, 255, 255, 255, tickrate * 2+0.01)
    function DrawBoundingBox(ent, color = Vector(255, 0, 255))
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


        DebugDrawLine(TFR, TFL, color.x, color.y, color.z, true, tickrate + 0.01);
        DebugDrawLine(TBR, TBL, color.x, color.y, color.z, true, tickrate + 0.01);

        DebugDrawLine(TFR, TBR, color.x, color.y, color.z, true, tickrate + 0.01);
        DebugDrawLine(TFL, TBL, color.x, color.y, color.z, true, tickrate + 0.01);

        DebugDrawLine(TFR, BFR, color.x, color.y, color.z, true, tickrate + 0.01);
        DebugDrawLine(TFL, BFL, color.x, color.y, color.z, true, tickrate + 0.01);

        DebugDrawLine(TBR, BBR, color.x, color.y, color.z, true, tickrate + 0.01);
        DebugDrawLine(TBL, BBL, color.x, color.y, color.z, true, tickrate + 0.01);

        DebugDrawLine(BFR, BBR, color.x, color.y, color.z, true, tickrate + 0.01);
        DebugDrawLine(BFL, BBL, color.x, color.y, color.z, true, tickrate + 0.01);

        DebugDrawLine(BFR, BFL, color.x, color.y, color.z, true, tickrate + 0.01);
        DebugDrawLine(BBR, BBL, color.x, color.y, color.z, true, tickrate + 0.01);
    }

    function DebugDrawCircle(Vector_Center, Vector_RGB, radius, parts, zTest, duration) //0 -32 80
    {
        local u = 0.0;
        local vec_end = [];
        local parts_l = parts;
        local radius = radius;
        local a = PI / parts * 2;
        while(parts_l > 0)
        {
            local vec = Vector(Vector_Center.x+cos(u)*radius, Vector_Center.y+sin(u)*radius, Vector_Center.z);
            vec_end.push(vec);
            u += a;
            parts_l--;
        }
        for(local i = 0; i < vec_end.len(); i++)
        {
            if(i < vec_end.len()-1){DebugDrawLine(vec_end[i], vec_end[i+1], Vector_RGB.x, Vector_RGB.y, Vector_RGB.z, zTest, duration);}
            else{DebugDrawLine(vec_end[i], vec_end[0], Vector_RGB.x, Vector_RGB.y, Vector_RGB.z, zTest, duration);}
        }
    }


    att_Rocket_R <- [
    "R_VFXMuzzleD_a",
    "R_VFXMuzzleE_a",
    "R_VFXMuzzleF_a",
    "R_VFXMuzzleG_a",
    "R_VFXMuzzleH_a",
    "R_VFXMuzzleI_a",
    "R_VFXMuzzleJ_a",
    "R_VFXMuzzleK_a",
    "R_VFXMuzzleL_a",
    "R_VFXMuzzleM_a",
    "R_VFXMuzzleN_a",
    "R_VFXMuzzleO_a"];

    att_Rocket_L <- [
    "L_VFXMuzzleD_a",
    "L_VFXMuzzleE_a",
    "L_VFXMuzzleF_a",
    "L_VFXMuzzleG_a",
    "L_VFXMuzzleH_a",
    "L_VFXMuzzleI_a",
    "L_VFXMuzzleJ_a",
    "L_VFXMuzzleK_a",
    "L_VFXMuzzleL_a",
    "L_VFXMuzzleM_a",
    "L_VFXMuzzleN_a",
    "L_VFXMuzzleO_a"];


    AttachmenntID <- 0;
    AttachmenntArray <- [
    "L_HandRoll_a",
    "R_HandRoll_a",
    "L_CharaB_a",
    "R_CharaB_a",
    "C_Head_end",
    "C_VFXMuzzleC_a",
    "C_VFXMuzzleA_a",
    "L_VFXMuzzleA_a",
    "C_VFXMuzzleB_a",
    "R_VFXMuzzleA_a",
    "R_VFXMuzzleB_a",
    "L_VFXMuzzleB_a",
    "L_VFXMuzzleC_a",
    "R_VFXMuzzleC_a",
    "C_VFXMuzzleE_a",
    "C_VFXMuzzleD_a",
    "R_VFXMuzzleD_a",
    "R_VFXMuzzleE_a",
    "R_VFXMuzzleF_a",
    "R_VFXMuzzleG_a",
    "R_VFXMuzzleH_a",
    "R_VFXMuzzleI_a",
    "R_VFXMuzzleJ_a",
    "R_VFXMuzzleK_a",
    "R_VFXMuzzleL_a",
    "R_VFXMuzzleM_a",
    "R_VFXMuzzleN_a",
    "R_VFXMuzzleO_a",
    "L_VFXMuzzleD_a",
    "L_VFXMuzzleE_a",
    "L_VFXMuzzleF_a",
    "L_VFXMuzzleG_a",
    "L_VFXMuzzleH_a",
    "L_VFXMuzzleI_a",
    "L_VFXMuzzleJ_a",
    "L_VFXMuzzleK_a",
    "L_VFXMuzzleL_a",
    "L_VFXMuzzleM_a",
    "L_VFXMuzzleN_a",
    "L_VFXMuzzleO_a",
    "R_VFXMuzzleU_a",
    "R_VFXMuzzleW_a",
    "R_VFXMuzzleV_a",
    "R_VFXMuzzleX_a",
    "R_VFXMuzzleY_a",
    "L_VFXMuzzleU_a",
    "L_VFXMuzzleW_a",
    "L_VFXMuzzleV_a",
    "L_VFXMuzzleX_a",
    "L_VFXMuzzleY_a",
    "R_VFXMuzzleP_a",
    "L_VFXMuzzleP_a",
    "R_VFXMuzzleQ_a",
    "L_VFXMuzzleQ_a",
    ]
}