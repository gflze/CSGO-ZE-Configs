//#####################################################################
//Patched version intended for use with GFL ze_sisyphus_v1 stripper
//Implements mapper script fixes
//Install as csgo/scripts/vscripts/gfl/sisyphus_magic_v1.nut
//#####################################################################

// *********** include vs_library stuff
IncludeScript("vs_lib/vs_library");
IncludeScript("vs_lib/vs_math");
IncludeScript("vs_lib/vs_events");
IncludeScript("longus/music");
IncludeScript("longus/sfx");

lose_z<--14500.0;
function fall(){  
    if(!activator || activator==null || !activator.IsValid())return;
    if(activator.GetClassname()=="player")EntFireByHandle(activator, "SetHealth", 0, 0.00, null, null);
}

function fail(){
    if(boulder_helper.GetOrigin().z<lose_z){
        EntFireByHandle(boulder_helper, "ClearParent", "", 0, "", "");
        EntFire("boulder","Break","",0.02,"");
        EntFireByHandle(boulder_helper, "FadeAndKill", "", 0.04, "", "");
        VS.EventQueue.CancelEventsByInput(map_tick);
        for (local player = null; player = Entities.FindByClassname(player, "player");){
            if(player!=null && player.IsValid() && player.GetTeam()==3){
                EntFireByHandle(player, "SetHealth", 0, 0.00, null, null);
            }
            else if(player!=null && player.IsValid() && player.GetTeam()==2 && player.GetHealth()<101){
                EntFireByHandle(player, "SetHealth", 0, 0.00, null, null);
            }
        }
    }  
}

neco_arc<-"models/player/custom_player/longus/neco-arc/neco-arc.mdl";
boulder_time<-0.00;
boulder_force<-500.00; //initial scale for thruster based on one human
boulder_thruster<-Entities.FindByName(null,"boulder_thruster");6
boulder_helper<-Entities.FindByName(null,"boulder_helper");

shot_count<-0.00;
shot_inverse<-0.00;
angle_buffer<-Vector(0.00,0.00,0.00);
vector_buffer<-Vector(0.00,0.00,0.00);
time_buffer<-0.1;
shot_buff<-1.50;

// function boulder(){
//     if(!activator || activator==null || !activator.IsValid())return;
//     shot_count = shot_count + 1.00;
//     vector_buffer += activator.GetOrigin();
//     if(boulder_time==0||boulder_time<Time()){ 
//         boulder_time=Time()+time_buffer;
//         shot_inverse = 1.00/shot_count;
//         VS.VectorScale(vector_buffer,shot_inverse,vector_buffer);
//         angle_buffer = VS.GetAngle(vector_buffer, boulder_helper.GetOrigin());
//         boulder_thruster.SetAngles(angle_buffer.x,angle_buffer.y,angle_buffer.z);
//         //boulder_thruster.__KeyValueFromString("force",(boulder_force+0.00/3.00).tostring());
//         boulder_thruster.__KeyValueFromString("force",((boulder_force*shot_count*shot_buff/ct_count)).tostring());      
//         EntFireByHandle(boulder_thruster, "Activate", "", 0, "", "");
//         shot_count=0;
//         angle_buffer=Vector(0.00,0.00,0.00);
//     }
// }

// from luffaren, try this out
function boulder(){
    if(!activator || activator==null || !activator.IsValid())return;
    shot_count = shot_count + 1.00;
        //BORK:angle_buffer += VS.GetAngle(activator.GetOrigin(), boulder_helper.GetOrigin());
        local ang_buf = (boulder_helper.GetOrigin() - activator.GetOrigin());
        ang_buf.Norm();
        angle_buffer += ang_buf;
    if(boulder_time==0||boulder_time<Time()){ 
        boulder_time=Time()+time_buffer;
        shot_inverse = 1/shot_count;
        //BORK:VS.VectorScale(angle_buffer,shot_inverse,angle_buffer);
        //BORK:boulder_thruster.SetAngles(angle_buffer.x,angle_buffer.y,angle_buffer.z);
        boulder_thruster.SetForwardVector(angle_buffer);  
        boulder_thruster.__KeyValueFromString("force",((boulder_force*shot_count/ct_count)).tostring());
        EntFireByHandle(boulder_thruster, "Activate", "", 0, "", "");
        shot_count=0;
        angle_buffer=Vector(0,0,0);
    }
}

// *********** player_spawn event handler
ct_skin<-0;
zm_skin<-1;
ct_name<-"neco_";
zm_name<-"chaos_";
::VS.ListenToGameEvent("player_spawn",function(event){
    local player = VS.GetPlayerByUserid(event.userid);
    if (!player || !player.IsValid()){
        if (!player){
            printl( "ERROR: Player from userid %d was not found\n" + event.userid);
        }
        else if (!player.IsValid()){
            printl( "ERROR: Player from userid %d was found invalid\n" + event.userid);
        }
        foreach (pl in VS.GetAllPlayers()){
            local scope = pl.GetScriptScope();
            if (!scope){
                printl("  Player[%d] has no script scope\n" + pl.entindex());
            }
            else if (!("userid" in scope)){
                printl( "  Player[%d] has no userid\n" + pl.entindex());
            }
            else if (scope.userid == event.userid){
                printl( "  Player[%d] has userid [%d] but was not found\n" + pl.entindex() + ":" + scope.userid);
            }
        }
        shit_fixer(player);
    }
    if(player.GetTeam()==3 || player.GetHealth()<101){
        player.PrecacheModel(neco_arc);
        player.SetModel(neco_arc);
        EntFireByHandle(player,"Skin",ct_skin,0,"","");
        VS.SetName(player,ct_name + event.userid)
    }
    else if(player.GetTeam()==2 || player.GetHealth()>101){
        player.PrecacheModel(neco_arc);
        player.SetModel(neco_arc);
        EntFireByHandle(player,"Skin",zm_skin,0,"","");
        VS.SetName(player,zm_name + event.userid)
    }    
    bot_test();
}.bindenv(this), "player_spawn_async", 0);

function bot_test(){
    for (local player = null; player = Entities.FindByClassname(player, "cs_bot");){
        if(player.GetTeam()==2){
            player.PrecacheModel(neco_arc);
            player.SetModel(neco_arc);
            EntFireByHandle(player,"Skin",zm_skin,0,"","");
        }
    }
}

::event_proxy<-null;
function shit_fixer(player){
    if(event_proxy==null){
        ::event_proxy <- Entities.CreateByClassname("info_game_event_proxy");
        ::event_proxy.__KeyValueFromString("event_name", "player_connect");
    }
    EntFireByHandle(event_proxy, "GenerateGameEvent", "", 0, player, null);
}

ct_count<-0.00;
ct_count_tick<-0.00;
function map_tick(){
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player.GetTeam()==3){
            ct_count_tick=ct_count_tick+1.00;
            if(player.GetModelName()!=neco_arc)player.SetModel(neco_arc);
            EntFireByHandle(player,"Skin",ct_skin,0,"","");
        }
        if(player.GetTeam()==2&&player.GetHealth()>101){
            if(player.GetModelName()!=neco_arc)player.SetModel(neco_arc);
            EntFireByHandle(player,"Skin",zm_skin,0,"","");
        }    
    }
    // for (local player = null; player = Entities.FindByClassname(player, "cs_bot");){
    //     if(player.GetTeam()==3){
    //         ct_count_tick=ct_count_tick+1.00;
    //     }
    // }    
    fail();
    if(ct_count!=ct_count_tick)ct_count=ct_count_tick+0.00;
    ct_count_tick=0.00;
    VS.EventQueue.AddEvent(map_tick,1,this);
}

rain<-0;
rain_max<-500;
function rain_tick(){
    if(rain_max<rain)return;
    rain++;
    EntFire("rain","AddOutput","renderamt " + rain.tostring(),0,"");
    VS.EventQueue.AddEvent(rain_tick,2,this);
}

/*
TextColor
{
	Normal = 1,   // white
	Red,          // red
	Purple,       // purple
	Location,     // lime green
	Achievement,  // light green
	Award,        // green
	Penalty,      // light red
	Silver,       // grey
	Gold,         // yellow
	Common,       // grey blue
	Uncommon,     // light blue
	Rare,         // dark blue
	Mythical,     // dark grey
	Legendary,    // pink
	Ancient,      // orange red
	Immortal      // orange
}*/

sisyphus_tune_names<-{
    [0] = "American Football - Never Meant",
    [1] = "Beck - Loser",
    [2] = "Billy Idol - Rebel Yell",
    [3] = "Boa - Duvet", 
    [4] = "Cortex - Devil's Dance",
    [5] = "Hideki Taniuchi - Death Note",
    [6] = "Melty Blood OST - Neco Arc",
    [7] = "Eiffel 65 - Blue",
    [8] = "Duster - Me And The Birds",
    [9] = "Radiohead - Knives Out",
    [10] = "Outkast - Hey Ya!",
    [11] = "Eyeliner - Payphone",
    [12] = "Gorillaz - Melancholy Hill",
    [13] = "Loverboy - Workin' For The Weekend",
    [14] = "Penpals - Tell Me Why",
    [15] = "Nujabes - Shiki no Uta",
    [16] = "Silver Fins - Waiting So Long",
    [17] = "Susumu Hirasawa - Gats",
    [18] = "Modest Mouse - Sunspots In The House Of The Late Scapegoat",   
    [19] = "The Drums - Money",    
    [20] = "Tears for Fears - Everybody Wants To Rule The World",    
    [21] = "Iron Maiden - The Trooper",                                   
    [22] = "Men at Work - Down Under",    
    [23] = "The Pixies - Where Is My Mind?", 
    [24] = "a-ha - Take on Me"      
}

sisyphus_tunes<-{
    [0] = "music/american_football-never_meant.mp3",
    [1] = "music/beck-loser.mp3",
    [2] = "music/billy_idol-rebel_yell.mp3",
    [3] = "music/boa-duvet.mp3", 
    [4] = "music/cortex-devils_dance.mp3",
    [5] = "music/death_note.mp3",
    [6] = "music/melty_blood-neco_arc.mp3",
    [7] = "music/eiffel_65-blue.mp3",
    [8] = "music/duster-me_and_the_birds.mp3",
    [9] = "music/radiohead-knives_out.mp3",
    [10] = "music/outkast-hey_ya.mp3",
    [11] = "music/eyeliner-payphone.mp3",
    [12] = "music/gorillaz-on_melancholy_hill.mp3",
    [13] = "music/loverboy-workin_for_the_weekend.mp3",
    [14] = "music/penpals-tell_me_why.mp3",
    [15] = "music/shiki_no_uta.mp3",
    [16] = "music/silver_fins-waiting_so_long.mp3",
    [17] = "music/susumu_hirasawa-gats.mp3",
    [18] = "music/modest_mouse-sunspots_in_the_house_of_the_late_scapegoat.mp3",   
    [19] = "music/the_drums-money.mp3",    
    [20] = "music/tears_for_fears-everybody_wants_to_rule_the_world.mp3",    
    [21] = "music/iron_maiden-the_trooper.mp3",                                   
    [22] = "music/men_at_work-down_under.mp3",    
    [23] = "music/pixies-where_is_my_mind.mp3", 
    [24] = "music/a-ha-take_on_me.mp3"      
};

sisyphus_times<-{
    [0] = 257,
    [1] = 235,
    [2] = 288,
    [3] = 203,
    [4] = 148,
    [5] = 190,
    [6] = 137,
    [7] = 282,
    [8] = 95,
    [9] = 254,
    [10] = 221,
    [11] = 321,
    [12] = 226,
    [13] = 218,
    [14] = 72,
    [15] = 300,
    [16] = 79,
    [17] = 214,
    [18] = 156,    
    [19] = 233,    
    [20] = 250,    
    [21] = 250,                                   
    [22] = 209,    
    [23] = 233, 
    [24] = 225      
};

sisyphus_alpha<-{
    [0] = "a",
    [1] = "b",
    [2] = "c",
    [3] = "d",
    [4] = "e",
    [5] = "f",
    [6] = "g",
    [7] = "h",
    [8] = "i",
    [9] = "j",
    [10] = "k",
    [11] = "l",
    [12] = "m",
    [13] = "n",
    [14] = "o",
    [15] = "p",
    [16] = "q",
    [17] = "r",         
    [18] = "s",    
    [19] = "t",    
    [20] = "u",    
    [21] = "v",                                   
    [22] = "w",    
    [23] = "x", 
    [24] = "y"  
}

ringers<-{
    [0] = "music/ringer_1.mp3",
    [1] = "music/ringer_2.mp3",
    [2] = "music/ringer_3.mp3",
    [3] = "music/ringer_4.mp3",
    [4] = "music/ringer_5.mp3"                
}

ringers_time<-{
    [0] = 50,
    [1] = 38,
    [2] = 32,
    [3] = 26,
    [4] = 67             
}

ringers_alpha<-{
    [0] = "a",
    [1] = "b",
    [2] = "c",
    [3] = "d",
    [4] = "e",
}

ringer_spacing<-5;
function sisyphus_playlist(){
    local music_maker = Entities.FindByName(null,"music_maker");
    local has_played = Entities.FindByName(null,"z_*");
    local random_song = 0;
    local first_checked = 0;
    local time = Time();
    local songlist = sisyphus_tunes.len()-1;
    random_song=RandomInt(0, songlist);
    first_checked = random_song;
    local new_song = false;
    for (local e = null; e = Entities.FindByClassname(e, "ambient_generic");){
        if(e.GetName()=="music"){
            EntFireByHandle(e, "Kill", "", 0.01, null, null);
        }
    }
    while(new_song==false){
        if (has_played.GetName().find(sisyphus_alpha[random_song].tostring())){
            random_song++;
            if (random_song>songlist){
                random_song=0;             
            }
            if(random_song == first_checked){
                new_song=true;  
                has_played.__KeyValueFromString("targetname","z_");
                has_played.__KeyValueFromString("targetname",has_played.GetName()+sisyphus_alpha[random_song].tostring());
            }
        }
        else{
            new_song=true;
            has_played.__KeyValueFromString("targetname",has_played.GetName()+sisyphus_alpha[random_song].tostring()); 
        }
    }
    local new_ringer=false;
    local ringer_played = Entities.FindByName(null,"y_*");
    local ringer_list = ringers.len()-1;
    local random_ringer = RandomInt(0, ringer_list);    
    local first_ringer_checked = random_ringer;
    if((has_played.GetName().len()-2)%ringer_spacing==0){
        while(new_ringer==false){
            if (ringer_played.GetName().find(ringers_alpha[random_ringer].tostring())){
                random_ringer++;
                if (random_ringer>ringer_list){
                    random_ringer=0;             
                }
                if(random_ringer == first_ringer_checked){
                    new_song=true;  
                    ringer_played.__KeyValueFromString("targetname","y_");
                    ringer_played.__KeyValueFromString("targetname",ringer_played.GetName()+ringers_alpha[random_ringer].tostring());
                }
            }
            else{
                new_ringer=true;
                ringer_played.__KeyValueFromString("targetname",ringer_played.GetName()+ringers_alpha[random_ringer].tostring()); 
            }
        }
        Chat(TextColor.Red + ">>> " + TextColor.Rare + "YOU ARE LISTENING TO " + TextColor.Mythical + "|| GFL 66.6 FM ||" + TextColor.Legendary + " BROUGHT TO YOUR BY GHOSTFAP.COM" + TextColor.Red + " <<<");
        music_play("music",music_maker.GetOrigin(), ringers[random_ringer].tostring(), 9999, 0, 10, "", 49); 
        VS.EventQueue.AddEvent(music_play,ringers_time[random_ringer],[this,"music",music_maker.GetOrigin(), sisyphus_tunes[random_song].tostring(), 9999, 0, 10, "", 49]);
        VS.EventQueue.AddEvent(sisyphus_playlist,sisyphus_times[random_song]+ringers_time[random_ringer],this);        
        return;
    }
    Chat(TextColor.Red + ">>> " + TextColor.Rare + "NOW PLAYING: " + TextColor.Mythical + sisyphus_tune_names[random_song] + TextColor.Red + " <<<");
    music_play("music",music_maker.GetOrigin(), sisyphus_tunes[random_song].tostring(), 9999, 0, 10, "", 49); 
    VS.EventQueue.AddEvent(sisyphus_playlist,sisyphus_times[random_song],this);
}

::bounds<-16;
::zm_dest<-null;
::spawn_x<-13184;
function zm_tp(){
    if(!activator || activator==null || !activator.IsValid())return;
    zm_dest=null;
    for (local player = null; player = Entities.FindByClassname(player,"player");){
        if(player.GetTeam()==2&&player.GetHealth()>100){
            if(player.GetOrigin().x<spawn_x){
                if(TraceLinePlayersIncluded(player.GetOrigin(),player.GetOrigin()+Vector(0,0,-32),null)==0)continue;
                if(zm_dest==null)zm_dest=player.GetOrigin();
                if(zm_dest.x<spawn_x && player.GetOrigin().x<zm_dest.x&&player.GetOrigin().z>zm_dest.z){
                    zm_dest=player.GetOrigin();
                }
            }

        }
    }
    // for (local player = null; player = Entities.FindByClassname(player,"cs_bot");){
    //     if(player.GetTeam()==2&&player.GetHealth()>100){
    //         if(zm_dest==null)zm_dest=player.GetOrigin();
    //         if(player.GetOrigin().x<zm_dest.x&&player.GetOrigin().z>zm_dest.z)zm_dest=player.GetOrigin();
    //     }
    // }    
    if(zm_dest==null)return;
    activator.SetOrigin(Vector(zm_dest.x,zm_dest.y,zm_dest.z+64));
}

::sfx_neco<-"sfx/neco-arc/neco-arc_";
::sfx_neco_count<-95;
::sfx_chaos<-"sfx/chaos/chaos_";
::sfx_chaos_count<-94;
::neco_words<-["!neco","nyaa","doridoridori","burenyuu"];
function neco_spam_start(){
    ::VS.ListenToGameEvent( "inspect_weapon", function(event){
        local player = VS.GetPlayerByUserid(event.userid);
        if (player==null || !player.IsValid())return;
        if(player.GetTeam()==3 || player.GetTeam()==2&&player.GetHealth()<101)sfx_play("sfx",player.GetOrigin(),sfx_neco+RandomInt(0,sfx_neco_count).tostring()+".wav", 5000, 0, 10, player.GetName(), 48);
        if(player.GetTeam()==2&&player.GetHealth()>101)sfx_play("sfx",player.GetOrigin(),sfx_chaos+RandomInt(0,sfx_chaos_count).tostring()+".wav", 5000, 0, 10, player.GetName(), 48);
    }.bindenv(this),"inspect_weapon_async",0);
    ::VS.ListenToGameEvent( "weapon_reload", function(event){
        local player = VS.GetPlayerByUserid(event.userid);
        if (player==null || !player.IsValid())return;
        if(player.GetTeam()==3 || player.GetTeam()==2&&player.GetHealth()<101)sfx_play("sfx",player.GetOrigin(),sfx_neco+RandomInt(0,sfx_neco_count).tostring()+".wav", 5000, 0, 10, player.GetName(), 48);
    }.bindenv(this),"weapon_reload_async",0);    
    ::VS.ListenToGameEvent( "player_death", function(event){
        local player = VS.GetPlayerByUserid(event.userid);
        if (player==null || !player.IsValid())return;
        if(player.GetTeam()==3)sfx_play("sfx",player.GetOrigin(),sfx_neco+RandomInt(0,sfx_neco_count).tostring()+".wav", 5000, 0, 10, player.GetName(), 48);
        if(player.GetTeam()==2&&player.GetHealth()>101)sfx_play("sfx",player.GetOrigin(),sfx_chaos+RandomInt(0,sfx_chaos_count).tostring()+".wav", 5000, 0, 10, player.GetName(), 48);
    }.bindenv(this),"player_death_async",0);
    ::VS.ListenToGameEvent( "weapon_zoom", function(event){
        local player = VS.GetPlayerByUserid(event.userid);
        if (player==null || !player.IsValid())return;
        if(player.GetTeam()==3)sfx_play("sfx",player.GetOrigin(),sfx_neco+RandomInt(0,sfx_neco_count).tostring()+".wav", 5000, 0, 10, player.GetName(), 48);
        if(player.GetTeam()==2&&player.GetHealth()>101)sfx_play("sfx",player.GetOrigin(),sfx_chaos+RandomInt(0,sfx_chaos_count).tostring()+".wav", 5000, 0, 10, player.GetName(), 48);
    }.bindenv(this),"weapon_zoom_async",0);
    ::VS.ListenToGameEvent( "silencer_detach", function(event){
        local player = VS.GetPlayerByUserid(event.userid);
        if (player==null || !player.IsValid())return;
        if(player.GetTeam()==3)sfx_play("sfx",player.GetOrigin(),sfx_neco+RandomInt(0,sfx_neco_count).tostring()+".wav", 5000, 0, 10, player.GetName(), 48);
        if(player.GetTeam()==2&&player.GetHealth()>101)sfx_play("sfx",player.GetOrigin(),sfx_chaos+RandomInt(0,sfx_chaos_count).tostring()+".wav", 5000, 0, 10, player.GetName(), 48);
    }.bindenv(this),"silencer_detach_async",0);
    ::VS.ListenToGameEvent( "player_say", function(event){
        local player = VS.GetPlayerByUserid(event.userid);
        if (player==null || !player.IsValid())return;
        local txt = event.text.tolower();
        foreach(word in neco_words){
            if(txt!=word)continue;
            if(player.GetTeam()==3)sfx_play("sfx",player.GetOrigin(),sfx_neco+RandomInt(0,sfx_neco_count).tostring()+".wav", 5000, 0, 10, player.GetName(), 48);
            if(player.GetTeam()==2&&player.GetHealth()>101)sfx_play("sfx",player.GetOrigin(),sfx_chaos+RandomInt(0,sfx_chaos_count).tostring()+".wav", 5000, 0, 10, player.GetName(), 48);
        }
    }.bindenv(this),"player_say_async",0);    
};


::VS.ListenToGameEvent( "round_end", function( event ){
    ::VS.StopListeningToAllGameEvents("inspect_weapon_async");
    ::VS.StopListeningToAllGameEvents("weapon_reload_async");
    ::VS.StopListeningToAllGameEvents("player_spawn_async");
    ::VS.StopListeningToAllGameEvents("player_death_async");     
    ::VS.StopListeningToAllGameEvents("weapon_zoom_async");           
    ::VS.StopListeningToAllGameEvents("silencer_detach_async");   
}.bindenv(this), "round_end_async", 0 );

function red_mist_squid(){
    local squid = Entities.FindByName(null,"red_mist_squid_move");
    ::Sound("sfx/heat_death.mp3",Vector(0,0,-15000),squid,10000,999,50,10,null);
    VS.EventQueue.AddEvent(::Sound,5,[this,"sfx/heat_death.mp3",Vector(-1000,0,-14000),squid,10000,999,40,8,null]);
    VS.EventQueue.AddEvent(::Sound,10,[this,"sfx/heat_death.mp3",Vector(-1000,0,-13000),squid,10000,999,30,7,null]);
    VS.EventQueue.AddEvent(::Sound,10,[this,"sfx/heat_death.mp3",Vector(-1000,0,-12000),squid,10000,999,20,6,null]);
    VS.EventQueue.AddEvent(::Sound,15,[this,"sfx/heat_death.mp3",Vector(-1000,0,-11000),squid,10000,999,40,8,null]);
    VS.EventQueue.AddEvent(::Sound,20,[this,"sfx/heat_death.mp3",Vector(-1000,0,-10000),squid,10000,999,30,7,null]);
    VS.EventQueue.AddEvent(::Sound,25,[this,"sfx/heat_death.mp3",Vector(-1000,0,-9000),squid,10000,999,20,6,null]);    
    EntFireByHandle(squid,"Open","",0,"","");
    EntFireByHandle(squid,"SetSpeed",249,0.1,"","");
}

function red_mist_kill(){
    if(!activator || activator==null || !activator.IsValid())return;
    ::Sound("sfx/pizza_aggressive.mp3",activator.GetOrigin()+Vector(0,0,15),null,10000,60,RandomInt(70,130),10,null);
    ::Particle("sisyphus_particle_003",activator.GetOrigin()+Vector(0,0,35),Vector(90+RandomInt(-15,15),RandomInt(0,360),RandomInt(-15,15)),null,0.05);
    EntFireByHandle(activator, "SetHealth", 0, 0, "", "");
}

red_mist_chance<-31;
function red_mist_squid_rng(){
    if(RandomInt(0,red_mist_chance)==red_mist_chance)EntFire("temp_red_mist_squid", "ForceSpawn", "", 30, "");
    else{
        printl("lucky you! you shall not die today, however odds are currently: " + red_mist_chance.tostring());
    }
}

// borrowed from luffaren - dynamic sound function
::manager <- self;
::sound_nameidx <- 0;
::sound_clientcmd <- null;
::sfx_max<-95;
::sfx_count<-0;
::Sound<-function(sound,pos=Vector(),_parent=null,radius=10000,lifetime=0.05,pitch=100,volume=10,logic=null){
    //printl(sound);
    if(logic==null && sfx_count>=sfx_max)return;    
    sfx_count++;
	if(radius<0)
	{
		if(_parent==null||!_parent.IsValid()||_parent.GetClassname()!="player")return;
		if(::sound_clientcmd==null)::sound_clientcmd = Entities.CreateByClassname("point_clientcommand");
		EntFireByHandle(::sound_clientcmd,"Command","play "+sound,0.00,_parent,null);
		return null;
	}
	::sound_nameidx++;
	if(::sound_nameidx>1000)::sound_nameidx=1;
	local mname = "soundmaster_"+::sound_nameidx.tostring();
	local globalsound = false;
	if(radius==0)globalsound = true;
	::manager.PrecacheModel("models/weapons/w_eq_bumpmine.mdl");
	::Ent(pos,Vector(),"prop_dynamic",{
			model = "models/weapons/w_eq_bumpmine.mdl",
			StartDisabled = 0,
			rendermode = 1,
			renderamt = 0,
			solid = 0,
		},{
		pos=pos,
		_parent=_parent,
		radius=radius,
		lifetime=lifetime,
		pitch=pitch,
		volume=volume,
		sound=sound,
		mname=mname,
		globalsound = globalsound,
		killnow=false,
		soundhandle=null,
		logic=logic,
		function Tick(){
			if(killnow)
			{
                sfx_count--;
				EntFireByHandle(self,"Kill","",0.00,null,null);
				if(soundhandle==null||!soundhandle.IsValid()){}else EntFireByHandle(soundhandle,"Kill","",0.00,null,null);
				return;
			}
			EntFireByHandle(self,"RunScriptCode"," Tick(); ",0.05,null,null);
			if(soundhandle==null||!soundhandle.IsValid()){killnow=true;return;}
			if(_parent==null||!_parent.IsValid()){}else self.SetOrigin(_parent.GetOrigin()+
			(_parent.GetForwardVector()*pos.x)+
			(_parent.GetLeftVector()*pos.y)+
			(_parent.GetUpVector()*pos.z));
		},function Run(){
			self.__KeyValueFromString("targetname",mname);
			if(lifetime==null||lifetime<=0.00){}else EntFireByHandle(self,"RunScriptCode"," killnow=true; ",lifetime,null,null);
			self.PrecacheScriptSound(sound);
			local flags = 48;
			if(radius == 0)flags++;
			local kvs = {
				spawnflags = flags,
				volume = volume,
				pitch = pitch,
				radius = radius,
				message = sound,
			};
			if(!globalsound)kvs.SourceEntityName <- ""+mname;	//NEW IN V1_9 - this prevents borked stuff with music plugins (thanks to Tilgep for finding the root cause)
			if(logic==null)logic={};
			logic.parenthandle <- self;
			logic.lifetime <- lifetime;
			logic.pitch <- pitch;
			logic.volume <- volume;
			logic.globalsound <- globalsound;
			::Ent(Vector(),Vector(),"ambient_generic",kvs,{
				sparent=self,
				lifetime=lifetime,
				pitch=pitch,
				volume=volume,
				logic=logic,
				function Run(){
					EntFireByHandle(self,"PlaySound","",0.00,null,null);
					EntFireByHandle(self,"Volume",volume.tostring(),0.00,null,null);
					EntFireByHandle(self,"Pitch",pitch.tostring(),0.01,null,null);
					if(lifetime==null||lifetime<=0.00){}else EntFireByHandle(self,"Kill","",lifetime,null,null);
					sparent.ValidateScriptScope();
					sparent.GetScriptScope().soundhandle = self;
					EntFireByHandle(sparent,"RunScriptCode"," Tick(); ",0.00,null,null);
					if(logic!=null)
					{
						logic.soundhandle <- self;
						if("Run" in logic)logic.Run();
					}
				}});
		}});
	return mname;
}

//borrowed from luffaren - dynamic particle function
::Particle<-function(particle,pos,rot=Vector(),_parent=null,lifetime=0.10)
{
	::Ent(pos,rot,"info_particle_system",{
			effect_name = particle,
			start_active = 0,
			targetname = "particle",
		},{
		_parent=_parent,
		lifetime=lifetime,
		function Run(){
			if(_parent==null||!_parent.IsValid()){}else EntFireByHandle(self,"SetParent","!activator",0.00,_parent,null);
			EntFireByHandle(self,"Start","",0.00,null,null);
			EntFireByHandle(self,"Kill","",lifetime,null,null);
		}});
}

