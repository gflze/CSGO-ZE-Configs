/*
▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
    Airbuster script by Kotya[STEAM_1:1:124348087]
    test branch update 07.06.2021 
▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
*/

// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Main settings    
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞

ticking <- false;
tickrate <- 0.1;

// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Status   
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞

Status <- "";

// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      HP settings    
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
    HP <- 0;
    HP_INIT <- 0;
    HP_BARS <- 16;

    HP_U <- 10;
    HP_H <- 30;
    HP_C <- 20;
    HP_L <- 40;

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

        // if(HP_BARS <= 16)
        // {
        //     local id = 16 - HP_BARS;
        //     EntFire("Special_HealthTexture", "SetTextureIndex", "" + id, 0.00);
        // }
        // else EntFire("Special_HealthTexture", "SetTextureIndex", "0", 0.00);

        HP += i;
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

        NadeCount++
        NadeTickRate += NadeTime;

        if(!Stanned)
        {
            if(NadeCount >= NadeNeed)
                SetStanned();
        }
    }
    function ShootDamage(ID)
    {
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

        SubtractHP(1);
    }

    function SubtractHP_Head(i)
    {
        if(Stanned)i *= StanDamage;

        if(HP_U > 0)
            HP_U -= i;
    }

    function SubtractHP_Chest(i)
    {
        if(Stanned)i *= StanDamage;

        if(HP_C > 0)
            HP_C -= i;
    }

    function SubtractHP_Hand(i)
    {
        if(Stanned)i *= StanDamage;

        if(HP_H > 0)
            HP_H -= i;
    }

    function SubtractHP_Low(i)
    {
        if(Stanned)i *= StanDamage;

        if(HP_L > 0)
            HP_L -= i;
    }

    function SubtractHP(i)
    {
        if(Stanned)i *= StanDamage;
        HP -= i;
    }

    function BossDead()
    {
        
    }
}
// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Stun settings    
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
    Stanned             <- false;
    StanTime            <- 5;
    StanDamage          <- 5;

    NadeCount <- 0;
    NadeNeed <- 10;
    NadeShow <- 20.0;

    NadeShow = NadeNeed * (NadeShow / 100);

    NadeTickRate <- 0;
    NadeTime <- 5;

    Stanned_Anim <- "stagger";
    UnStanned_Anim <- "dmgburst";

    function SetStanned()
    {
        SetPlayBackRate(0,2.5);
        SetAnimation(Stanned_Anim);
        
        NadeTickRate += StanTime;
        NadeCount = 0;
        Stanned = true;
    }

    function SetUnStanned()
    {
        SetPlayBackRate(1);
        SetAnimation(UnStanned_Anim);
        Stanned = false;
    }
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

            if(hp <= 0)
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
        Shield_Health <- 100.0;

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
            SetAnimation(Laser_C_Anim);
            EntFireByHandle(self, "RunScriptCode", "Cast_Laser_C_Next();", 1, null, null);
        }
        function Cast_Laser_C_Next()
        {
            ToggleHurtEffect(Laser_C, 0, 3.4);

            if(RandomInt(0, 1))
            {
                Rotate(45, 0.2, 1.5, 0);
                Rotate(90, 1.7, 3, 1);
                Rotate(45, 3.2, 4, 0);
            }
            else
            {
                Rotate(45, 0.2, 1.5, 1);
                Rotate(90, 1.7, 3, 0);
                Rotate(45, 3.2, 4, 1);
            }
        }
    }
    //WIND
    {
        Wind_Damage <- 20;
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

            if(hp <= 0)
            {
                EntFireByHandle(Handle, "SetHealth", "-1", 0.00, null, null);
                return;
            }
            Handle.SetHealth(hp);


            local vec = origin - tpos;
            vec.Norm();

            local push = Vector((vec.x * -Wind_Power), (vec.y * -Wind_Power), (300));
            Handle.SetVelocity(push);
        }
    }
    //FLAME
    {
        Flang_Flame_Anim <- "attack_machine";

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

        function Cast_Rotate_Flame()
        {
            SetAnimation(Flame_Rotate_Anim);
            SetPlayBackRate(0.3, 1.0);
            SetPlayBackRate(1, 3.0);
            ToggleLower(2);

            Rotate(720, 0.5, 4.5);

            ToggleHurtEffect(Flame_R_M, 0.3, 3.5)
            ToggleHurtEffect(Flame_L_M, 0.3, 3.5)

            ToggleHurtEffect(Flame_R_U, 0.3, 2.5)
            ToggleHurtEffect(Flame_L_U, 0.3, 2.5)

            ToggleHurtEffect(Flame_R_B_L, 0.3, 4.5)
            ToggleHurtEffect(Flame_L_B_L, 0.3, 4.5)
        }

        Low_Flame_Anim <- "idle";

        function Cast_Low_Flame()
        {
            SetAnimation(Low_Flame_Anim);
            ToggleLower(5.2);

            ToggleHurtEffect(Flame_R_F_L, 0.5, 5.2);
            ToggleHurtEffect(Flame_L_F_L, 0.5, 5.2);
            ToggleHurtEffect(Flame_L_L, 0.75, 5);
            ToggleHurtEffect(Flame_R_L, 0.75, 5);
            ToggleHurtEffect(Flame_L_B_L, 1, 5.4);
            ToggleHurtEffect(Flame_R_B_L, 1, 5.4);

        }
    }
    //MINE
    {
        Mine_Count <- [1, 3];
        Mine_Radius <- 150;
        Mine_Interval <- [0.5, 3.2];

        Mine_Maker <- Entities.FindByName(null, "AirBuster_Mine_Spawner");
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

                local origin = GetAttOrigin("C_VFXMuzzleD_a");
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
            SetAnimation(Heal_Anim);
            AddHP(500);
        }
    }
    //CONFUSE
    {
        Confuse_Maker <- Entities.FindByName(null, "AirBuster_Confuse_Spawner");
        Confuse_Anim <- "attack_beam";

        function Cast_Confuse()
        {
            SetAnimation(Confuse_Anim);
            EntFireByHandle(self, "RunScriptCode", "Cast_Confuse_Next();", 2.0, null, null);
        }

        function Cast_Confuse_Next()
        {
            local origin = GetAttOrigin("C_VFXMuzzleD_a") + Model.GetLeftVector() * -550 + Vector(0, 0, 5);
            Confuse_Maker.SpawnEntityAtLocation(origin, Vector(0,0,0));
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
}
// ▞▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▚
//      Main
// ▚▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▞
{
    function OnPostSpawn()
    {
        Start();
    }

    function Start()
    {
        Init();
        SetTestAtt(0);

        ticking = true;
        MainScript.GetScriptScope().Active_Boss = "AirBuster";
        Tick();
    }

    function Init()
    {
        local ent;

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
        Flame_L_F_L = hurtandpart(ent, Entities.FindByName(null, "AirBuster_Attack_Fire_Hurt_h"));;

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

        ent = Entities.FindByName(null, "AirBuster_Nade");
        FakeParentArray.push(fakeparent(ent, "C_VFXMuzzleD_a", Vector(0, 0, 0), Vector(0, 200, 0)));

        SetHP(80);

        EntFireByHandle(Hit_Box_L, "FireUser1", "", 0, null, null);
        EntFireByHandle(Hit_Box_H_L, "FireUser1", "", 0, null, null);
        EntFireByHandle(Hit_Box_H_R, "FireUser1", "", 0, null, null);
        EntFireByHandle(Hit_Box_C, "FireUser1", "", 0, null, null);
        EntFireByHandle(Hit_Box_U, "FireUser1", "", 0, null, null);

        EntFireByHandle(Electro_L.particle, "Start", "", 0, null, null);
        EntFireByHandle(Electro_L.hurt, "Enable", "", 0, null, null);
        // ent = Entities.FindByName(null, "AirBuster_Attachment_Attack_Fire_d");
        // SetAttachment(ent);
    }

    function Tick()
    {
        if(!ticking)
            return;

        Debug();

        FakeParent();

        UpDateHP();

        StanTick();
        
        UpDateStatus();

        ShowBossStatus();

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
        for(local i = 1; i < 76; i++)
        {
            EntFireByHandle(self, "RunScriptCode", "ModelSetZ(" + (-i * 0.02) + ")", (i * 0.01), null, null);
            EntFireByHandle(self, "RunScriptCode", "ModelSetZ(" + (i * 0.02) + ")", off + (i * 0.05), null, null);
        }
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