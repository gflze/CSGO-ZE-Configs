//Main
{
    //Sounds
    {
        Sound_First <- "cosmov6/boss/reno/first/extreme_after_final_gate.mp3"; self.PrecacheScriptSound( Sound_First );
        Sound_Second <- "cosmov6/boss/reno/first/extreme_scene1sound.mp3"; self.PrecacheScriptSound( Sound_Second );
        Sound_Third <- "cosmov6/boss/reno/first/extreme_scene2sound.mp3"; self.PrecacheScriptSound( Sound_Third );
        Sound_Fourth <- "cosmov6/boss/reno/first/extreme_scene3sound.mp3"; self.PrecacheScriptSound( Sound_Fourth );

        Sound_End_Win <- "cosmov6/boss/reno/first/extreme_end_win.mp3"; self.PrecacheScriptSound( Sound_End_Win );
        Sound_End_Lose1 <- "cosmov6/boss/reno/first/extreme_end_all_die_random1.mp3"; self.PrecacheScriptSound( Sound_End_Lose1 );
        Sound_End_Lose2 <- "cosmov6/boss/reno/first/extreme_end_all_die_random2.mp3"; self.PrecacheScriptSound( Sound_End_Lose2 );
    
        Sound_Laser1 <- "cosmov6/boss/reno/laser_random1.mp3"; self.PrecacheScriptSound( Sound_Laser1 );
        Sound_Laser2 <- "cosmov6/boss/reno/laser_random2.mp3"; self.PrecacheScriptSound( Sound_Laser2 );
        Sound_Laser3 <- "cosmov6/boss/reno/laser_random3.mp3"; self.PrecacheScriptSound( Sound_Laser3 );
        Sound_Laser4 <- "cosmov6/boss/reno/laser_random4.mp3"; self.PrecacheScriptSound( Sound_Laser4 );
        Sound_Laser5 <- "cosmov6/boss/reno/laser_random5.mp3"; self.PrecacheScriptSound( Sound_Laser5 );
        Sound_Laser6 <- "cosmov6/boss/reno/laser_random6.mp3"; self.PrecacheScriptSound( Sound_Laser6 );
        Sound_Laser7 <- "cosmov6/boss/reno/laser_random7.mp3"; self.PrecacheScriptSound( Sound_Laser7 );
        Sound_Laser8 <- "cosmov6/boss/reno/laser_random8.mp3"; self.PrecacheScriptSound( Sound_Laser8 );

        Sound <- Entities.FindByName(null, "Extreme_Reno_Sound");
        function PlaySound(Name)
        {
            EntFireByHandle(Sound,"AddOutPut", "message "+Name, 0.00,null,null);
            EntFireByHandle(Sound,"PlaySound", "", 0.05,null,null);
        }
    }
    //Movie
    {
        function Start()
        {
            Laser_Maker = Entities.FindByName(null, "Laser_maker");
            local delay = 0.2
            local laser_delay = 0.8;
            local laser_counter = 0;

            EntFireByHandle(self, "RunScriptCode", "PlaySound(Sound_Second);", delay + 0, null, null);
            EntFireByHandle(self, "RunScriptCode", "PlaySound(Sound_Third);", delay + 0.9, null, null);
            EntFireByHandle(self, "RunScriptCode", "PlaySound(Sound_Fourth);", delay + 5.8, null, null);

            EntFireByHandle(self, "RunScriptCode", "GetRandomSoundForLaser();", delay + 0.5 + 7.5 + (laser_delay * laser_counter), null, null);
            EntFireByHandle(self, "RunScriptCode", "SpawnDelayYLaser();", delay + 0.5 + 7.5 + (laser_delay * laser_counter), null, null);
            EntFireByHandle(self, "RunScriptCode", "LaserAttack();", delay + 7.5 + (laser_delay * laser_counter++), null, null);

            EntFireByHandle(self, "RunScriptCode", "LaserAttack();", delay + 7.5 + (laser_delay * laser_counter++), null, null);
           
            EntFireByHandle(self, "RunScriptCode", "GetRandomSoundForLaser();", delay + 0.5 + 7.5 + (laser_delay * laser_counter), null, null);
            EntFireByHandle(self, "RunScriptCode", "SpawnDelayYLaser();", delay + 0.5 + 7.5 + (laser_delay * laser_counter), null, null);
            EntFireByHandle(self, "RunScriptCode", "LaserAttack();", delay + 7.5 + (laser_delay * laser_counter++), null, null);
            
            EntFireByHandle(self, "RunScriptCode", "LaserAttack();", delay + 7.5 + (laser_delay * laser_counter++), null, null);

            EntFireByHandle(self, "RunScriptCode", "GetRandomSoundForLaser();", delay + 0.5 + 7.5 + (laser_delay * laser_counter), null, null);
            EntFireByHandle(self, "RunScriptCode", "SpawnDelayYLaser();", delay + 0.5 + 7.5 + (laser_delay * laser_counter), null, null);
            EntFireByHandle(self, "RunScriptCode", "LaserAttack();", delay + 7.5 + (laser_delay * laser_counter++), null, null);

            EntFireByHandle(self, "RunScriptCode", "GetEnding();", delay + 7.5 + (laser_delay * ++laser_counter), null, null);
        }

        debuging <- false;
        function Debug()
        {
            debuging = true;
            debug()
        }

        function debug()
        {
            if(!debuging)
                return;
            local laser_delay = 0.8;

            EntFireByHandle(self, "RunScriptCode", "LaserAttack();", 0.00, null, null);
            EntFireByHandle(self, "RunScriptCode", "debug();", laser_delay, null, null);
        }

        function GetEnding()
        {
            local handle = null;
            while((handle = Entities.FindByClassname(handle, "player")) != null)
            {
                if(handle == null)
                    continue;
                if(!handle.IsValid())
                    continue;
                if(handle.GetHealth() <= 0)
                    continue;
                if(handle.GetTeam() == 3)
                    return MovieGood();
            }
            return MovieBad();
        }

        function MovieGood()
        {
            EntFire("Extreme_Reno_Move", "TeleportToPathNode", "Extreme_Reno_Path_8", 0);
            EntFire("Extreme_Reno_Model", "SetDefaultAnimation", "sidit", 0);
            EntFire("Extreme_Reno_Model", "SetAnimation", "sidit", 0);
            EntFire("Extreme_Reno_Model", "AddOutput", "angles -90 135 0", 0);
            EntFire("Extreme_Reno_Model", "AddOutput", "angles -90 135 0", 0.01);
            EntFire("Extreme_Reno_Model", "SetAnimation", "sidit_idle", 3.2);
            EntFire("Extreme_Reno_Model", "SetDefaultAnimation", "sidit_idle", 3.2);
        
            EntFireByHandle(self, "RunScriptCode", "PlaySound(Sound_End_Win);", 2, null, null);

            EntFire("End_End", "RunScriptCode", "Start(4.0,0.0)", 0);
        }

        function MovieBad()
        {
            EntFire("Extreme_Reno_Model", "SetDefaultAnimation", "idle1", 0);
            SetBossAnimation("younoob");

            if(RandomInt(0,1))
                PlaySound(Sound_End_Lose1);
            else
                PlaySound(Sound_End_Lose2);

            EntFire("End_End", "RunScriptCode", "Start(4.0,0.0)", 0);
        }
    }
    //Laser
    {
        //Smart
        {

        }
        Laser_Maker <- null;
        function LaserAttack()
        {
            GetRandomAnimationForLaser();

            GetRandomLaser();
        }

        //Sound
        {
            LaserSound_Array <- [
                Sound_Laser1,
                Sound_Laser2,
                Sound_Laser3,
                Sound_Laser4,
                Sound_Laser5,
                Sound_Laser6,
                Sound_Laser7,
                Sound_Laser8,
            ]

            function GetRandomSoundForLaser()
            {
                PlaySound(LaserSound_Array[GetRandomSoundID()]);
            }

            function GetRandomSoundID(){return RandomInt(0, LaserSound_Array.len() - 1);}

        }
        //Anim
        {
            Anim_Laser1 <- "karateguy";
            Anim_Laser2 <- "attack2";

            function GetRandomAnimationForLaser()
            {
                if(RandomInt(0,1))
                    SetBossAnimation(Anim_Laser1);
                else
                    SetBossAnimation(Anim_Laser2);
            }
        }
        //Laser
        {
            //POS
            {
                class laser_preset
                {
                    origin = Vector(0, 0, 0);
                    angles = Vector(0, 0, 0);
                    constructor(_o, _a)
                    {
                        this.origin = _o;
                        this.angles = _a;
                    }
                }
                Laser_Array <- [
                    
                    laser_preset(Vector(-9982,-935,1860), Vector(180,5,90)),
                    laser_preset(Vector(-9982,-935,1860), Vector(180,0,0)),
                    laser_preset(Vector(-9982,-935,1865), Vector(180,0,0)),
                    laser_preset(Vector(-9982,-935,1870), Vector(180,0,0)),
                    laser_preset(Vector(-9982,-935,1872), Vector(180,0,0)),
                    laser_preset(Vector(-9982,-935,1880), Vector(180,0,0)),
                    laser_preset(Vector(-9982,-935,1885), Vector(180,0,0)),
                    laser_preset(Vector(-9982,-935,1890), Vector(180,0,0)),
                    laser_preset(Vector(-9982,-935,1895), Vector(180,0,0)),

                    laser_preset(Vector(-9982,-935,1860), Vector(180,0,11)),
                    laser_preset(Vector(-9982,-935,1860), Vector(180,0,-11)),
                ]
                Laser_Origin <- [
                    Vector(-9982,-935,1860), //Нижний
                    Vector(-9982,-935,1875), //Нижний
                    Vector(-9982,-935,1880), //Средний
                    Vector(-9982,-935,1885), //Верхний
                ];
                Laser_Ang <- [
                    Vector(180,0,0),    //нижний
                    Vector(180,0,8),    //слева на право
                    Vector(180,0,-8),   //справа на лево
                    Vector(180,0,40),   //Угловой лево
                    Vector(180,0,-40),  //Угловой право
                ];
            }
            function GetRandomLaser()
            {
                SpawnDelayLaser(GetRandomLaserID(), 0.5);
            }
            
            function GetRandomLaserID(){return RandomInt(0, Laser_Array.len() - 1);}

            function SpawnDelayLaser(id, delay = 0.00)
            {
                EntFireByHandle(self, "RunScriptCode", "SpawnLaser(" + id + ");", delay, null, null);
                
            }
            function SpawnDelayYLaser(delay = 0.00)
            {
                EntFireByHandle(self, "RunScriptCode", "SpawnYLaser();", delay + RandomFloat(0.35, 0.55), null, null);
            }

            function SpawnYLaser()
            {
                local array = [];
                local array1 = [];
                local y = -935;

                if(Global_Target != null && Global_Target.IsValid() && Global_Target.GetHealth() > 0 && Global_Target.GetTeam() == 3)
                {
                    array.push(Global_Target);
                }
                else
                {
                    local origin = Entities.FindByName(null, "End_Platform_Move").GetOrigin();
                    local handle = null;
                    while(null != (handle = Entities.FindByClassnameWithin(handle, "player", origin, 300)))
                    {
                        if(!handle.IsValid())
                            continue;
                        if(handle.GetHealth() <= 0)
                            continue;
                        if(handle.GetTeam() != 3)
                            continue;
                        
                        local luck = MainScript.GetScriptScope().GetPlayerClassByHandle(handle)
                        if(luck != null)
                        {
                            luck = luck.perkluck_lvl;
                            if(luck > 0)
                            {
                                if(RandomInt(1, 100) > luck * perkluck_luckperlvl)
                                {
                                    array1.push(handle);
                                    continue;
                                }  
                            }

                        }

                        array.push(handle);
                    }
                }
                
                if(array.len() > 0)
                    y = GetTwoVectYaw(Vector(-9982,-935,1860), array[RandomInt(0, array.len() - 1)].GetOrigin())
                else if(array1.len() > 0)
                {
                    y = GetTwoVectYaw(Vector(-9982,-935,1860), array1[RandomInt(0, array1.len() - 1)].GetOrigin())
                }
                Laser_Maker.SpawnEntityAtLocation(Vector(-9982,-935,1860), Vector(180, y, 90));
            }

            function SpawnLaser(id)
            {
                id = id.tointeger();

                Laser_Maker.SpawnEntityAtLocation(Laser_Array[id].origin, Laser_Array[id].angles);
            }
        }
    }
    //Model
    {
        Model <- self;
        function SetBossAnimation(animationName,time = 0)EntFireByHandle(Model,"SetAnimation",animationName,time,null,null);
    }
    //Support
    {
        function GetTwoVectYaw(start,target)
        {
            local yaw = 0.00;
            local v = Vector(start.x - target.x, start.y - target.y, start.z - target.z);
            local vl = sqrt(v.x * v.x + v.y * v.y);
            yaw = 180 * acos(v.x / vl) / PI;
            if(v.y < 0)
            {
                yaw = -yaw;
            }
            return yaw;
        }
    }
}