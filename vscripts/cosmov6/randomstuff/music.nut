//Main
{
    class class_music
    {
        path = "";
        duration = 0;
        repit = false;
        display = ""

        constructor(_path, _duration, _repit, _display = "")
        {
            this.path = _path;
            this.duration = _duration;
            this.repit = _repit;
            this.display = _display;
        }
    }

    //чтобы запустить трек пиши это ent_fire music runscriptcode "SetMusic(M_Argent)"

    //Пример путь к файлу, реальная длительность трека
    self.PrecacheScriptSound( g_Array_Sounds[0] );
    self.PrecacheScriptSound( g_Array_Sounds[1] );

    ::Sound_Win <- class_music("cosmov6/music/ffvii_victory_sound.mp3", 0, false); self.PrecacheScriptSound( Sound_Win.path );

    ::Music_Normal_1 <- class_music("cosmov6/music/Normal_1.mp3", 48, true, "Cosmo Canyon - Remake"); self.PrecacheScriptSound( Music_Normal_1.path );
    ::Music_Normal_2 <- class_music("cosmov6/music/Normal_2.mp3", 73, true, "Yoshinori Nakamura - Noises in the Night"); self.PrecacheScriptSound( Music_Normal_2.path );
    ::Music_Normal_3 <- class_music("cosmov6/music/Normal_3.mp3", 157, false, "Yoshitaka Suzuki - Crab Warden"); self.PrecacheScriptSound( Music_Normal_3.path );
    ::Music_Normal_31 <- class_music("cosmov6/music/Normal_3_1.mp3", 158, false, ""); self.PrecacheScriptSound( Music_Normal_31.path );
    ::Music_Normal_4 <- class_music("cosmov6/music/Normal_4.mp3", 73.04, true, "Yoshinori Nakamura - Hurry"); self.PrecacheScriptSound( Music_Normal_4.path );

    ::Music_Hard_1 <- class_music("cosmov6/music/Hard_1.mp3", 168, true, "Shotaro Shima - A New Operation"); self.PrecacheScriptSound( Music_Hard_1.path );
    ::Music_Hard_2 <- class_music("cosmov6/music/Hard_2.mp3", 87, true, "Shotaro Shima - Undercity Suns"); self.PrecacheScriptSound( Music_Hard_2.path );
    ::Music_Hard_31 <- class_music("cosmov6/music/Hard_3_1.mp3", 158, false, ""); self.PrecacheScriptSound( Music_Hard_31.path );
    ::Music_Hard_4 <- class_music("cosmov6/music/Hard_4.mp3", 160, true, ""); self.PrecacheScriptSound( Music_Hard_4.path );

    ::Music_ZM_1 <- class_music("cosmov6/music/ZM_1.mp3", 158, false, "Shotaro Shima - On Our Way"); self.PrecacheScriptSound( Music_ZM_1.path );
    ::Music_ZM_2 <- class_music("cosmov6/music/ZM_2.mp3", 90, false, "Naoyuki Honzawa - Ignition Flame"); self.PrecacheScriptSound( Music_ZM_2.path );

    ::Music_Extreme_1 <- class_music("cosmov6/music/Extream_1.mp3", 191, true, "Granite - Pendulum"); self.PrecacheScriptSound( Music_Extreme_1.path );
    ::Music_Extreme_2 <- class_music("cosmov6/music/Extream_2.mp3", 208, true, "Pendulum - Witchcraft"); self.PrecacheScriptSound( Music_Extreme_2.path );
    ::Music_Extreme_3 <- class_music("cosmov6/music/Extream_3.mp3", 165, false, ""); self.PrecacheScriptSound( Music_Extreme_3.path );
    ::Music_Extreme_31 <- class_music("cosmov6/music/Extream_3_1.mp3", 148, false, "Shotaro Shima - Let the Battles Begin! - Break Through"); self.PrecacheScriptSound( Music_Extreme_31.path );
    ::Music_Extreme_4 <- class_music("cosmov6/music/Extream_4.mp3", 178, true, "Master Of Puppets - Pendulum"); self.PrecacheScriptSound( Music_Extreme_4.path );

    ::Music_Inferno_1 <- class_music("cosmov6/music/Inferno_0.mp3", 184, true, "Muzz - Spectrum"); self.PrecacheScriptSound( Music_Inferno_1.path );
    ::Music_Inferno_2 <- class_music("cosmov6/music/Inferno_2.mp3", 228, true, "Pendulum - Come Alive"); self.PrecacheScriptSound( Music_Inferno_2.path );
    ::Music_Inferno_3 <- class_music("cosmov6/music/Inferno_3.mp3", 208, false, "Tadayoshi Makino - The Airbuster"); self.PrecacheScriptSound( Music_Inferno_3.path );
    ::Music_Inferno_4 <- class_music("cosmov6/music/Inferno_4.mp3", 242, true, "Pendulum - Propane (2007 October Version)"); self.PrecacheScriptSound( Music_Inferno_4.path );
    ::Music_Inferno_5 <- class_music("cosmov6/music/Inferno_5.mp3", 44, true, "Pendulum - Propane (2007 October Version)"); self.PrecacheScriptSound( Music_Inferno_5.path );

    map_brush <- Entities.FindByName(null, "map_brush");
    Current_Sound <- null;

    function OnPostSpawn()
    {
        Start();
    }

    function Start()
    {
        Stage = map_brush.GetScriptScope().Stage;
        GetMusicStart();
    }

    Stage <- 0;
    tick <- 0;
    RepitSound <- false;

    function TickMusic()
    {
        tick--;
        //ScriptPrintMessageChatAll("Tick : " + tick);
        if(tick > 0)
            EntFireByHandle(self,"RunScriptCode", "TickMusic()", 1.0, null, null);
        else if(Current_Sound.repit && RepitSound)
        {
            tick = Current_Sound.duration;
            EntFireByHandle(self, "PlaySound", "", 0.00, null, null);
            EntFireByHandle(self, "RunScriptCode", "TickMusic()", 1.0, null, null);
        }

    }

    function SetMusic(Name)
    {
        RepitSound = false;
        Current_Sound = Name;

        if(Name.display != "")
        {
            ScriptPrintMessageChatAll(Music_pref + Name.display);
        }

        if(Name.repit)
            EntFireByHandle(self, "RunScriptCode", "RepitSound = true", 8.00, null, null);
        if(tick > 2)
        {
            local time = 0;

            for(local i = 1; i <= 10; i++)
            {
                EntFireByHandle(self,"Volume", "" + (10 - i),time,null,null);
                time += 0.1;
            }

            EntFireByHandle(self,"StopSound", "",2,null,null);
            EntFireByHandle(self,"AddOutPut", "message "+Name.path, 2.02,null,null);

            local handle = null;
            while(null != (handle = Entities.FindByClassname(handle, "player")))
            {
                if(handle == null)
                    continue;
                if(!handle.IsValid())
                    continue;
                EntFire("point_clientcommand", "Command", "play " + Name.path.slice(0, Name.path.len() -4) + "_fix.mp3", 0, handle);
            }

            EntFireByHandle(self,"PlaySound", "", 2.05,null,null);

            if(Name.duration > 4)
            {
                time = 0;
                for(local i = 1; i <= 10; i++)
                {
                    EntFireByHandle(self,"Volume","" + i, 2.02 + time,null,null);
                    time += 0.2;
                }
            }
            //EntFireByHandle(Music,"Volume", "10",2.02,null,null);

            EntFireByHandle(self,"RunScriptCode", "tick = " + (Name.duration + 2), 0, null, null);
        }
        else
        {
            if(Name.duration > 4)
            {
                local time = 0;
                for(local i = 1; i <= 10; i++)
                {
                    EntFireByHandle(self,"Volume",(i).tostring(), time,null,null);
                    time += 0.2;
                }
            }

            EntFireByHandle(self,"RunScriptCode", "TickMusic()", 1.0, null, null);
            EntFireByHandle(self,"StopSound", "",0,null,null);
            EntFireByHandle(self,"AddOutPut", "message " + Name.path, 0.02,null,null);

            EntFireByHandle(self,"PlaySound", "", 0.05,null,null);

            EntFireByHandle(self,"RunScriptCode", "tick = " + Name.duration, 0, null, null);
        }
    }
}

//MusicCase
{
    function GetMusicStart()
    {
        if(Stage == 1)
        {
            SetMusic(Music_Normal_1);
        }
        else if(Stage == 2)
        {
            SetMusic(Music_Hard_1);
        }
        else if(Stage == 3)
        {
            SetMusic(Music_ZM_1);
        }
        else if(Stage == 4)
        {
            SetMusic(Music_Extreme_1);
        }
        else if(Stage == 5)
        {
            SetMusic(Music_Inferno_1);
        }
    }

    function GetMusicCave()
    {
        if(Stage == 1)
        {
            SetMusic(Music_Normal_2);
        }
        else if(Stage == 2)
        {
            SetMusic(Music_Hard_2);
        }
    }

    function GetMusicExplosion()
    {
        if(Stage == 4)
        {
            SetMusic(Music_Extreme_2);
        }
        else if(Stage == 5)
        {
            SetMusic(Music_Inferno_2);
        }
    }

    function GetMusicBossFight()
    {
        if(Stage == 1)
        {
            if(RandomInt(0,1))
                SetMusic(Music_Normal_3);
            else
                SetMusic(Music_Normal_31);
        }
        else if(Stage == 2)
        {
                SetMusic(Music_Hard_31);
        }
        else if(Stage == 4)
        {
                SetMusic(Music_Extreme_3);
        }
        else if(Stage == 5)
        {
            EntFireByHandle(self,"RunScriptCode","SetMusic(Music_Inferno_3);",10,null,null);
        }
    }

    function GetMusicAfterBoss()
    {
        if(Stage == 1)
        {
            SetMusic(Music_Normal_4);
        }
        else if(Stage == 2)
        {
            SetMusic(Music_Hard_4);
        }
        else if(Stage == 4)
        {
            SetMusic(Music_Extreme_4);
        }
        else if(Stage == 5)
        {
            SetMusic(Music_Inferno_4);
        }
    }
}