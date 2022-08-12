//Main
{
    class FullPos
    {
        constructor(_origin, _angles)
        {
            this.angles = _angles;
            this.origin = _origin;
        }
        angles = Vector(0, 0, 0);
        origin = Vector(0, 0, 0);
    }
    //last
    FirstPoint <- [
        FullPos(Vector(-6844,-1988,1834),Vector(0,180,-180)),
        FullPos(Vector(-8193,-2057,1786),Vector(0,225,-180)),
        FullPos(Vector(-6469,-2318,1970),Vector(0,150,-180)),
    ];

    LastPoint <- [
        FullPos(Vector(-7738,-2956,1722),Vector(0,240,-180)),
        FullPos(Vector(-6836,-2820,1826),Vector(0,180,-180)),
    ];

    Stage <- 1;


    ticking <- false;
    tickrate <- 0.1;

    tickrate_use <- 0;

    cd_use_CAN <- true;
    cd_use <- 5.0;
    cd_use_d <- cd_use / 17;

    function SetCDUse(i)
    {
        cd_use = 0.00 + i;
        cd_use_d = i / 17;
    }

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
    /*
    fire 180/250/350
    electro 50/80/120
    grav 100/150/200
    ultima 1000/1500/2000
    bio heal на 1/2/3 ячейки
    */
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

    Shoot_OneMoney <- 5;
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

    function SubtractHP(i)
    {
        HP -= i;
    }

    function ItemEffect_Ice(time)
    {
        if(time <= 0)
            return;
        cd_use_CAN = false;

        local ice_temp = Entities.FindByName(null, "map_ice_temp_02"); 
        ice_temp.SetOrigin(Model.GetOrigin()
        )
        EntFireByHandle(ice_temp, "ForceSpawn", "", 0.00, null, null);
        EntFireByHandle(Model, "SetPlayBackRate", "0", 0.00, null, null);
        local name = Time().tointeger();

        EntFire("map_ice_model_02", "SetParent", "!activator", 0, Model);

        EntFire("map_ice_model_02", "RunScriptCode", "Spawn(0.5)", 0, null);

	    EntFire("map_ice_model_02", "AddOutPut", "targetname map_ice_model_02"+name, 0, null);
        EntFire("map_ice_model_02"+name, "RunScriptCode", "Kill(" + (time * 0.9) + ")", time * 0.2, null);

        EntFireByHandle(Model, "SetPlayBackRate", "1", time, null, null);

        EntFireByHandle(Model, "Color", "0 255 0", 0.00, null, null);

        EntFireByHandle(Model, "Color", "255 128 64", time, null, null);
        EntFireByHandle(self, "RunScriptCode", "cd_use_CAN = true;", time, null, null);
    }

    // function SetFadeFromColor(Vector, time)
    // {

    // }

    function BossDead()
    {
        EntFire("Cactus_Timer_Bar", "Kill", "", 0);
        EntFire("Cactus_HP_Bar", "Kill", "", 0);
        EntFire("Cactus_Hbox", "Kill", "", 0);

        EntFire("map_sound_boss_dead", "PlaySound", "", 0);


        EntFireByHandle(Model, "SetAnimation", "gojump", 0.00, null, null);
        EntFireByHandle(Model, "FadeAndKill", "", 3.7, null, null);
        EntFireByHandle(Model, "Color", "255 0 0", 0.00, null, null);
        EntFireByHandle(Model, "Color", "255 0 0", 0.50, null, null);
        EntFireByHandle(Model, "Color", "255 0 0", 1.00, null, null);
        EntFireByHandle(Model, "Color", "255 0 0", 1.50, null, null);
        EntFireByHandle(Model, "Color", "255 0 0", 2.00, null, null);
        EntFireByHandle(Model, "Color", "255 0 0", 2.50, null, null);
        EntFireByHandle(Model, "Color", "255 0 0", 3.00, null, null);
        EntFireByHandle(Model, "Color", "255 0 0", 3.50, null, null);

        local item_target = Entities.FindByName(null, "map_item_beam_target");
        EntFireByHandle(item_target, "ClearParent", "", 0, null, null);
    }
    
    Model <- null;

    function Init()
    {
        EntFire("timer_texture", "AddOutPut", "target Cactus_Timer_Bar", 0);
        EntFire("Special_HealthTexture", "AddOutPut", "target Cactus_HP_Bar", 0);
        Model = Entities.FindByName(null, "Cactus_Model");

        Start();
    }

    function Start()
    {
        ticking = true;

        SetHP(65);
        //SetHP(950);
        EntFire("Cactus_Timer_Bar", "ShowSprite", "", 0.2);
        EntFire("Cactus_HP_Bar", "ShowSprite", "", 0.2);
        EntFire("Cactus_Hbox", "SetDamageFilter", "filter_humans", 0.2);

        local random = RandomInt(0,FirstPoint.len() - 1);
        Model.SetOrigin(FirstPoint[random].origin)
        Model.SetAngles(FirstPoint[random].angles.x ,FirstPoint[random].angles.y, FirstPoint[random].angles.z)

        local item_target = Entities.FindByName(null, "map_item_beam_target");
        item_target.SetOrigin(Model.GetOrigin());
        EntFireByHandle(item_target, "SetParent", "!activator", 0, Model, Model);

        MainScript.GetScriptScope().Active_Boss = "Cactus";

        EntFireByHandle(self, "RunScriptCode", "Tick()", tickrate, null, null);
    }

    function Tick()
    {
        if(!ticking)
            return;
        
        TickUse();

        UpDateCasttime();
        UpDateHP();

        ShowBossStatus();

        EntFireByHandle(self, "RunScriptCode", "Tick()", tickrate, null, null);
    }

    function TickUse()
    {
        if(!cd_use_CAN)
            return;
            
        if(tickrate_use + tickrate >= cd_use)
        {
            tickrate_use = 0;
            if(Stage == 1)
            {
                local random = RandomInt(0,LastPoint.len() - 1);
                Model.SetOrigin(LastPoint[random].origin)
                Model.SetAngles(LastPoint[random].angles.x ,LastPoint[random].angles.y, LastPoint[random].angles.z)
            }
            else 
            {
                local handle = null;
                while((handle = Entities.FindByClassname(handle, "player")) != null)
                {
                    if(handle == null)
                        continue;
                    if(!handle.IsValid())
                        continue;
                    if(handle.GetTeam() != 3)
                        continue;
                    if(handle.GetHealth() <= 0)
                        continue;

                    Model.SetOrigin(handle.GetOrigin());
                    EntFireByHandle(Model, "FireUser1", "", 0.5, null, null);
                    return;
                }
            }
            Stage++;
        }
        else tickrate_use += tickrate;
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
        }
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

        message = "[Cactus] : Status : Angry\n";
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
        ScriptPrintMessageCenterAll(message);
    }

    function ShowBossDeadStatus()
    {
        local message;
        message = "[Cactus] : Status : Dead\n";

        for(local i = HP_BARS; i < 16; i++)
        {
            message += "◇";
        }

        ScriptPrintMessageCenterAll(message);
    }

}





