//#####################################################################
//Intended for use with GFL ze_aaa_grand_line_x stripper
//Fixes script errors
//Install as csgo/scripts/vscripts/gfl/aaa_magic_fix.nut
//#####################################################################

// *********** include vs_library stuff
IncludeScript("vs_lib/vs_library");
IncludeScript("vs_lib/vs_math");
IncludeScript("vs_lib/vs_events");
IncludeScript("luffaren/collective");

function sfx_mist_lever(x){
    local location = Entities.FindByName(null,"mist_trigger_"+x.tostring()).GetOrigin();
    ::Sound("buttons/lever8.wav",location,null,9999,0.05,100,10,null);  
}

function random_p2_funny(){
    if (!activator) return false;
    if(activator.GetTeam()==3){
        EntFireByHandle(activator, "SetHealth", 0, 0, "", "");
    }
    else if(activator.GetTeam()==2){
        activator.SetOrigin(Entities.FindByName(null,"random_p2_zm_tp").GetOrigin());
    }      
}

function cyberia_bomb_spawn_1(){
    local button = Entities.FindByName(null,"wxc_but");
    EntFireByHandle(button, "AddOutput", "Onpressed meat_slide_door:Break::15:1", 0, "", "");
    EntFireByHandle(button, "AddOutput", "Onpressed aaa_magic:RunScriptCode:lore(2,13):3:1", 0, "", "");    
    EntFireByHandle(button, "AddOutput", "Onpressed aaa_magic:RunScriptCode:cyberia_bomb_1():0:1", 1, "", "");
}

function cyberia_bomb_spawn_2(){
    local button = Entities.FindByName(null,"wxc_but");
    EntFireByHandle(button, "AddOutput", "Onpressed cyberia_door_1:Break::15:1", 0, "", "");
    EntFireByHandle(button, "AddOutput", "Onpressed aaa_magic:RunScriptCode:cyberia_bomb_2():0:1", 1, "", "");
}

function cyberia_bomb_1(){
    local bomb = Entities.FindByName(null,"maker_cyberia_bomb");
    local location = Vector(6609,9159,1554)
    bomb.SpawnEntityAtLocation(location, Vector(0,270,0));
    VS.EventQueue.AddEvent(sfx_get_out,12.3,[this,location]);    
}

function cyberia_bomb_2(){
    local bomb = Entities.FindByName(null,"maker_cyberia_bomb");
    local location = Vector(5748,7028,1508);
    bomb.SpawnEntityAtLocation(location, Vector(0,0,0));    
    VS.EventQueue.AddEvent(sfx_get_out,12.3,[this,location]);    
}

function namviet_bomb_spawn_1(){
    local button = Entities.FindByName(null,"wxc_but");
    EntFireByHandle(button, "AddOutput", "Onpressed namviet_predator_statue:Break::15:1", 0, "", "");
    EntFireByHandle(button, "AddOutput", "Onpressed aaa_magic:RunScriptCode:namviet_bomb_1():0:1", 1, "", "");
}

function namviet_bomb_1(){ 
    local bomb = Entities.FindByName(null,"maker_cyberia_bomb");
    local location = Vector(11622,14490,-11568);
    bomb.SpawnEntityAtLocation(location, Vector(0,75,0));
    VS.EventQueue.AddEvent(sfx_get_out,12.3,[this,location]);
}

function namviet_bomb_spawn_0(){
    local button = Entities.FindByName(null,"wxc_but");
    EntFireByHandle(button, "AddOutput", "Onpressed namviet_path_1_door:Break::15:1", 0, "", "");
    EntFireByHandle(button, "AddOutput", "Onpressed aaa_magic:RunScriptCode:namviet_bomb_0():0:1", 1, "", "");
}

function namviet_bomb_0(){
    local bomb = Entities.FindByName(null,"maker_cyberia_bomb");
    local location = Vector(8857,15216,-11639);
    bomb.SpawnEntityAtLocation(location, Vector(0,90,0));
    VS.EventQueue.AddEvent(sfx_get_out,12.3,[this,location]);
}

function sfx_get_out(location){
    ::Sound("sfx/mslug3_get_out.mp3",location,null,10000,0.05,100,10,null);
}

function namviet_train_sfx(){
    local location = Entities.FindByName(null,"namviet_train_explosion").GetOrigin();
    ::Sound("sfx/mslug3_get_out.mp3",location,null,10000,0.05,100,10,null);
}

function mako_grant_access(){
    local door = Entities.FindByName(null,"mako_access_denied");
    sfx_chime();
    EntFireByHandle(door, "Break", "", 1, "", "");
    if(mako_troll_train_timer!=null)mako_troll_train_timer.Destroy();
}

function kill_all_zm(){
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player==null)return;
        if(player.GetTeam()==2){
            EntFireByHandle(player, "SetHealth", 0, 0, "", "");
        }    
    }
}

clueless_rng<-99;
function escape_button(){
    local hmm_today_i_will_not_open = RandomInt(0,clueless_rng);
    if(hmm_today_i_will_not_open==0){
        sfx_chime();
        local clueless_button = Entities.FindByName(null, "clueless_button_1");
        EntFireByHandle(clueless_button, "Kill", "", 0, "", "");
        clueless_button = Entities.FindByName(null, "clueless_button_2");
        EntFireByHandle(clueless_button, "Kill", "", 0, "", "");     
        local clueless_door = Entities.FindByName(null,"clueless_door"); 
        EntFireByHandle(clueless_door, "Open", "", 0, "", "");  
        lore(2,19);
    }
    else{
        clueless_rng--;
    }
}

function serptenis_c4_1(){
    local c4 = Entities.FindByName(null,"maker_serpentis_c4");
    local location = Vector(-11414,-1586,3746);
    local orientation = Vector(270,270,0);
    c4.SpawnEntityAtLocation(location, orientation);   
    ::Sound("radio/bombpl.wav",location,null,10000,0.05,100,10,null);    
    local timer = Entities.FindByName(null,"C4_Timer");
    EntFireByHandle(timer, "FireUser2", "", 0, "", "");
}

function serptenis_c4_2(){
    local c4 = Entities.FindByName(null,"maker_serpentis_c4");
    local location = Vector(-10608,-7128,3776);
    local orientation = Vector(270,270,0);
    c4.SpawnEntityAtLocation(location, orientation);   
    ::Sound("radio/bombpl.wav",location,null,10000,0.05,100,10,null);    
    local timer = Entities.FindByName(null,"C4_Timer");
    EntFireByHandle(timer, "FireUser2", "", 0, "", ""); 
}

function namviet_serpentis_c4(){
    local c4 = Entities.FindByName(null,"maker_serpentis_c4");
    local location = Vector(10017,5190,-11452);
    local orientation = Vector(-90,180,0);
    c4.SpawnEntityAtLocation(location, orientation);   
    ::Sound("radio/bombpl.wav",location,null,10000,0.05,100,10,null);    
    local timer = Entities.FindByName(null,"C4_Timer");
    EntFireByHandle(timer, "FireUser2", "", 0, "", ""); 
}

function namviet_train_serpentis_c4(){
    local c4 = Entities.FindByName(null,"maker_serpentis_c4");
    local location = Vector(8842,8827,-11362);
    local orientation = Vector(-90,0,0);
    c4.SpawnEntityAtLocation(location, orientation);   
    ::Sound("radio/bombpl.wav",location,null,10000,0.05,100,10,null);    
    local timer = Entities.FindByName(null,"C4_Timer");
    EntFireByHandle(timer, "FireUser2", "", 0, "", ""); 
}

function sfx_c4(){
    local location = Entities.FindByName(null,"C4_Timer");
    ::Sound("weapons/c4/c4_beep1.wav",location.GetOrigin(),null,10000,0.05,100,10,null);
}

function sfx_c4_explosion(){
    local location = Entities.FindByName(null,"C4_Particle");
    ::Sound("weapons/c4/c4_explode1.wav",location.GetOrigin(),null,10000,0.05,100,10,null);
}

metal_break<-["physics/metal/metal_box_break1.wav","physics/metal/metal_box_break2.wav"];
function ds_break_grate(entity){
    local cool_entity = Entities.FindByName(null,"ds_grate_"+entity.tostring());
    if(cool_entity==null)return;
    ::Sound(metal_break[RandomInt(0,metal_break.len()-1)],cool_entity.GetOrigin(),null,999,0.05,100,10,null);
    EntFireByHandle(cool_entity, "Break", "", 0, "", "");
}

screamsplosion<-"sfx/screamsplosion.mp3"
frampt_dialogue<-"sfx/ds_frampt.mp3"
function frampt(){
    local door = Entities.FindByName(null,"frampt_door");
    EntFireByHandle(door, "Open", "", 0, "", "");
    local frampt = Entities.FindByName(null,"frampt");
    local location = frampt.GetOrigin();
    frampt_sfx();
    EntFireByHandle(frampt, "SetAnimation", "idle2", 0, "", "");
    EntFire("dark_souls_grate_relay","Trigger","",20,""); 
    local playback = 0.2;
    for(local i=0; i<50;){
        playback = playback + 0.2;
        EntFireByHandle(frampt, "SetPlaybackRate", playback, i, "", "");
        i++;
    }

}

::frampt_sfx_timer<-null;
::frampt_counter<-0;
::frampt_max<-30;
function frampt_sfx(){
    frampt_sfx_timer<-VS.Timer(false,5,function(){
        local location_ent = Entities.FindByName(null,"frampt");
        if(location_ent==null){
            frampt_sfx_timer.Destroy();
            return;
        }
        local location = location_ent.GetOrigin();
        ::Sound("sfx/cruelty_squad-snirby_ambient_" + snirby_sfx_num.tostring() + ".mp3",location,null,9999,0.05,100,10,null);
        snirby_sfx_num++;
        if(snirby_sfx_num>snirby_sfx_max){
            snirby_sfx_num = 1;
        }
        frampt_counter++;
        if(frampt_counter>frampt_max){
            if(frampt_sfx_timer!=null)frampt_sfx_timer.Destroy();
        }
    });
}

function sfx_screamsplosion(){
    ::Sound(screamsplosion,Vector(0,0,0),null,0,1,100,10,null);
}

function minas_funny(){
    if (!activator) return false;
    local cool_tp = Entities.FindByName(null,"minas_tp").GetOrigin();
    activator.SetOrigin(cool_tp);
    activator.SetAngles(0.0,270.0,0.0);
}

function serpentis_leave(){
    //sfx(screamsplosion,Vector(0,0,0),null,0,1,100,10);
    local door = Entities.FindByName(null,"serpentis_leave");
    if(door==null)return;
    EntFireByHandle(door, "Open", "", 0, "", "");
}

function minas_fall(){
    if (!activator) return false;
    if(activator.GetTeam()==3){
        EntFireByHandle(activator, "SetHealth", 0, 0, "", "");
    }
    else if(activator.GetTeam()==2){
        activator.SetOrigin(Entities.FindByName(null,"m1_zm_tp_1_dest").GetOrigin());
    }   
}

function serpentis_funny_lava(){
    if (!activator) return false;
    if(activator.GetTeam()==3){
        EntFireByHandle(activator, "SetHealth", 0, 0, "", "");
    }
    else if(activator.GetTeam()==2){
        activator.SetOrigin(Entities.FindByName(null,"m1_zm_tp_2_dest").GetOrigin());
    }    
}

function rootmars_phase_2_tp(){ 
    if (!activator) return false;
    //EntFire("rootmars_final_fade", "Fade", "", 0, activator)
    if(activator.GetTeam()==3){
        activator.SetOrigin(Entities.FindByName(null,"rootmars_phase_2_ct_tp").GetOrigin());
    }    
    else if(activator.GetTeam()==2){
        activator.SetOrigin(Entities.FindByName(null,"rootmars_phase_2_zm_tp_"+RandomInt(1,2).tostring()).GetOrigin());
    }
}


function rootmars_laugh_2(){
    ::Sound("sfx/mslug3_rootmars_laugh_2.mp3",Vector(0,0,0),null,0,1,100,10,null);
}

function rootmars_phase_2_kill(){
    if(rmp2_balls_timer!=null)rmp2_balls_timer.Destroy();
    if(rmp2_laser_timer!=null)rmp2_laser_timer.Destroy();
    ::Sound("sfx/mslug3_rootmars_death_2.mp3",Vector(0,0,0),null,0,1,100,10,null);
    ::Sound("sfx/mslug3_rootmars_death.mp3",Vector(0,0,0),null,0,1,100,10,null);
    materia_listen_rmp2=false;
}

function rootmars_phase_2_fall(){
    if (!activator) return false;
    if(activator.GetTeam()==3){
        EntFireByHandle(activator, "SetHealth", 0, 0, "", "");
    }    
    else if(activator.GetTeam()==2){
        activator.SetOrigin(Entities.FindByName(null,"rootmars_phase_2_zm_tp_"+RandomInt(1,2).tostring()).GetOrigin());
    }
}

function escape_sfx_stop(){
    if(escape_alarm_timer!=null)escape_alarm_timer.Destroy();
    stop_music();
    VS.EventQueue.AddEvent(stop_music,0.1,[this]);
    VS.EventQueue.AddEvent(stop_music,1,[this]);
    VS.EventQueue.AddEvent(stop_music,2,[this]);
}

function stop_music(){
    if(now_playing==music_prefix+"7" && mission==2){
        local bio = Entities.FindByName(null,"bioinformatics");
        EntFireByHandle(bio, "Volume", 0, 0, "", "");
        EntFireByHandle(bio, "Kill", "", 0.02, "", "");
        now_playing = null;
        loop = 0;        
    }    
    for (local music = null; music = Entities.FindByName(music, music_prefix + "*");){
        VS.EventQueue.CancelEventsByInput(music_queue);
        EntFireByHandle(music,"Volume", 0, 0,"", "");
        EntFireByHandle(music,"Kill","",1,"","");
        now_playing = null;
        loop = 0;
        //return;
    }
}   

function fade_music(fade_time){
    for (local music = null; music = Entities.FindByName(music, music_prefix + "*");){
        VS.EventQueue.CancelEventsByInput(music_queue);
        EntFireByHandle(music,"FadeOut", fade_time, 0,"", "");
        EntFireByHandle(music,"Volume",0,fade_time + 1,"","");
        EntFireByHandle(music,"Kill","",fade_time + 1,"","");
        now_playing = null;
        loop = 0;
        //return;
    }
}    

::mission<-0;
::round_prep<-20;
function mission_one(){ 
    mission=1;
    music_queue(mission,0);
    local mission_one_icon = Entities.FindByName(null,"mission_1_icon");
    EntFireByHandle(mission_one_icon, "Toggle", "", 0, "", "");    
    local sky_swapper = Entities.FindByName(null, "sky_swapper");
    sky_swap_set(sky_swapper,"deadcore_sky_3");
    EntFireByHandle(sky_swapper,"Trigger","",0,"","");
    VS.EventQueue.AddEvent(sky_swap_set,5,[this,sky_swapper,"deadcore_sky_6"]);
    pow_spawns("pow_m1");
    local mission_break = Entities.FindByName(null,"mission_break");
    EntFireByHandle(mission_break, "Break", "", round_prep, "", "");
    EntFire("potc_particles","Start","",19,"");
    EntFire("potc_particles","Stop","",180,"");
    EntFire("sfx_waves","PlaySound","",0,"");
    EntFire("sfx_seagull","PlaySound","",0,"");
    EntFire("sfx_waves","StopSound","",180,"");
    EntFire("sfx_seagull","StopSound","",180,"");
    VS.EventQueue.AddEvent(music_queue,round_prep+1,[this,mission,1]);
    local laser_base = Entities.FindByName(null,"deadcore_laser_base");
    EntFireByHandle(laser_base, "Skin", 3, 0, "", "");
    laser_base.SetOrigin(Vector(laser_base.GetOrigin().x,laser_base.GetOrigin().y,-12753));
    EntFire("kill_mission_two_shit","Trigger","",0,"");
    EntFire("kill_mission_three_shit","Trigger","",0,"");
	//EntFire("manager","RunScriptCode"," ::ITEMS.flight.SetupEventListener(); ",4.00,null);    
    VS.EventQueue.AddEvent(lore,round_prep+1,[this,1,0]);
    VS.EventQueue.AddEvent(lore,round_prep+6,[this,1,1]); 
    EntFire("tonemap_m1","Trigger","",round_prep,"");     
}

function deadcore_laser_base(){
    local laser_base = Entities.FindByName(null,"deadcore_laser_base");
    laser_base.SetOrigin(Vector(laser_base.GetOrigin().x,laser_base.GetOrigin().y,-12976));
}

::round_prep_m2<-20;
function mission_two(){
    mission=2;
    music_queue(mission,0);
    local mission_two_icon = Entities.FindByName(null,"mission_2_icon");
    EntFireByHandle(mission_two_icon, "Toggle", "", 0, "", "");
    local sky_swapper = Entities.FindByName(null, "sky_swapper");
    sky_swap_set(sky_swapper,"deadcore_sky_6");
    EntFireByHandle(sky_swapper,"Trigger","",0,"","");
    VS.EventQueue.AddEvent(sky_swap_set,5,[this,sky_swapper,"deadcore_sky_7"]);
    pow_spawns("pow_m2");
    local mission_break = Entities.FindByName(null,"mission_break");
    EntFireByHandle(mission_break, "Break", "", round_prep_m2, "", "");    
    local laser_base = Entities.FindByName(null,"deadcore_laser_base");
    //printl(laser_base.GetOrigin());
    laser_base.SetOrigin(Vector(-12949,-13120,-13108));
    EntFire("bk_skybox_rocket","Toggle","",0,"");
    VS.EventQueue.AddEvent(random_p2,round_prep_m2+2,[this]);
    VS.EventQueue.AddEvent(music_queue,round_prep_m2+1,[this,mission,1]);   
    EntFire("random_p2_particle","Start","",19,"");
    EntFire("random_p2_particle","Stop","",180,"");   
    EntFire("kill_mission_one_shit","Trigger","",0,"");
    EntFire("kill_mission_three_shit","Trigger","",0,"");      
    EntFire("point_spotlight","Kill","",0,"");
    EntFire("spotlight_end","Kill","",0,"");
    EntFire("mako_skybox_reactor","TurnOn","",0,"");
    EntFire("mako_skybox_walls","Toggle","",0,"");
    VS.EventQueue.AddEvent(lore,round_prep_m2+1,[this,2,0]);
    VS.EventQueue.AddEvent(lore,round_prep_m2+6,[this,2,1]);
    VS.EventQueue.AddEvent(lore,round_prep_m2+11,[this,2,2]);
    VS.EventQueue.AddEvent(lore,round_prep_m2+16,[this,2,3]);  
    //VS.EventQueue.AddEvent(lore,41,[this,2,4]);   
    EntFire("tonemap_m2","Trigger","",round_prep_m2,"");
    VS.EventQueue.AddEvent(validate_targetnames,30,this);
}

::just_in_case<-10000;
function validate_targetnames(){
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player.GetName().find(targetname_prefix)==null){
            VS.SetName(player,targetname_prefix+just_in_case.tostring());
            just_in_case++;
        }
    }
}

//credits
function mission_three(){
    mission=3;
    local mission_break = Entities.FindByName(null,"mission_break");
    EntFireByHandle(mission_break, "Break", "", 0, "", ""); 
    VS.EventQueue.AddEvent(ct_to_seats,1,[this]);
    VS.EventQueue.AddEvent(credits_sprites,5,[this]);
    VS.EventQueue.AddEvent(music_queue,4.9,[this,3,1]);
    EntFire("zm_tp_credits","Enable","",15.25,"");
    EntFire("kill_mission_one_shit","Trigger","",0,"");
    EntFire("kill_mission_two_shit","Trigger","",0,"");  
    VS.EventQueue.AddEvent(lore,21,[this,3,0]);
    VS.EventQueue.AddEvent(lore,26,[this,3,1]);
    VS.EventQueue.AddEvent(lore,31,[this,3,2]);
    VS.EventQueue.AddEvent(lore,36,[this,3,3]);            
    VS.EventQueue.AddEvent(lore,41,[this,3,4]);      
    VS.EventQueue.AddEvent(lore,46,[this,3,5]);   
    EntFire("tonemap_m3","Trigger","",1,"");
}

function movement_enable(){
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        EntFireByHandle(player, "Addoutput", "MoveType 2", 0, "", "");    
    }
}

function random_p2(){
    local zombie_car = Entities.FindByName(null,"ZomCar");
    local zombie_car_door = Entities.FindByName(null,"ZomCarB");
    EntFireByHandle(zombie_car, "SetSpeedReal", 100, 15, "", "");
    EntFireByHandle(zombie_car_door, "Break", "", 15, "", "");
    sfx_train_start();
    EntFire("sfx_random_p2_wheels","PlaySound","",0,"");
}

function random_p2_exit(){
    if(!activator)return;
    local random_p2_exit_tp = Entities.FindByName(null,"m2_zm_tp_1_dest").GetOrigin();
    activator.SetOrigin(random_p2_exit_tp);
}

::sfx_train_timer<-null;
function sfx_train_start(){
    EntFireByHandle(Entities.FindByName(null,"sfx_random_p2_train"), "PlaySound", "", 0, "","");
    sfx_train_timer<-VS.Timer(false,20,function(){
        local sfx_train = Entities.FindByName(null,"sfx_random_p2_train");
        EntFireByHandle(sfx_train, "PlaySound", "", RandomInt(0,10), "","");
    })
}

function sfx_train_stop(){
    if(sfx_train_timer!=null)sfx_train_timer.Destroy();
}

::mako_troll_train_timer<-null;
function mako_troll_train_start(){
    mako_troll_train_timer<-VS.Timer(false,15,function(){
        local mako_train = Entities.FindByName(null,"Bridge_Train_Template");
        EntFireByHandle(mako_train, "ForceSpawn", "", 0, "","");
    })
}


zm_split<-1;
ct_split<-1;
function mako_to_namviet(){
    local ct_tp=null;
    local zm_tp=null;
    if (!activator) return false;
    if(activator.GetTeam()==3){
        ct_tp = Entities.FindByName(null,"namviet_tp_"+ct_split.tostring()).GetOrigin();
        activator.SetOrigin(ct_tp);
        if(ct_split==1){
            ct_split=2;
        }
        else if(ct_split==2){
            ct_split=1;
        }
    }
    else if(activator.GetTeam()==2){
        zm_tp = Entities.FindByName(null,"namviet_tp_"+zm_split.tostring()).GetOrigin();
        activator.SetOrigin(zm_tp);
        if(zm_split==1){
            zm_split=2;
        }
        else if(zm_split==2){
            zm_split=1;
        }        
    }    
}

function namviet_back_to_mako(){
    if (!activator) return false;
    if(activator.GetTeam()==3){
        activator.SetOrigin(Entities.FindByName(null,"namviet_ct_exit_tp").GetOrigin());
    }
    else if(activator.GetTeam()==2){
        activator.SetOrigin(Entities.FindByName(null,"namviet_ct_exit_tp").GetOrigin());
    }   
}

mission_1_ct_tp<-"mission_1_ct_tp";
mission_1_zm_tp<-"mission_1_zm_tp";
mission_2_ct_tp<-"mission_2_ct_tp";
mission_2_zm_tp<-"zm_train";
mission_3_tp<-"credits_tp_dest";
//
admin_nuke_ct_tp<-Entities.FindByName(null,"admin_nuke_ct_dest").GetOrigin();
admin_nuke_zm_tp<-Entities.FindByName(null,"admin_nuke_zm_dest").GetOrigin();
::admin_nuke_bool<-false;
//
function admin_nuke(){
    admin_nuke=true;
    Chat(lore_prefix + TextColor.Legendary + "i'm going to kill all of you lol");
    //nuke_bot_test();
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player==null || !player.IsValid())return;
        if(player.GetTeam()==3){
            if(admin_nuke_ct_tp==null){
                admin_nuke_ct_tp = Entities.FindByName(null,"admin_nuke_ct_dest").GetOrigin();
            }
            player.SetOrigin(admin_nuke_ct_tp);
        }
        else if(player.GetTeam()==2){
            if(admin_nuke_zm_tp==null){
                admin_nuke_zm_tp = Entities.FindByName(null,"admin_nuke_zm_dest").GetOrigin();
            }
            player.SetOrigin(admin_nuke_zm_tp);
        }    
    }
    local admin_nuke_crusher = Entities.FindByName(null,"admin_nuke_crusher");
    EntFireByHandle(admin_nuke_crusher, "Open", "", 5, "", "");
    VS.EventQueue.AddEvent(russian_head,12.5,[this]);
}

function nuke_bot_test(){
    for (local player = null; player = Entities.FindByClassname(player, "cs_bot");){
        if(player==null || !player.IsValid())return;
        if(player.GetTeam()==3){
            if(admin_nuke_ct_tp==null){
                admin_nuke_ct_tp = Entities.FindByName(null,"admin_nuke_ct_dest").GetOrigin();
            }
            player.SetOrigin(admin_nuke_ct_tp);
        }
        else if(player.GetTeam()==2){
            if(admin_nuke_zm_tp==null){
                admin_nuke_zm_tp = Entities.FindByName(null,"admin_nuke_zm_dest").GetOrigin();
            }
            player.SetOrigin(admin_nuke_zm_tp);
        }    
    }    
}

function russian_head(){
    ::Sound("sfx/russian_head.mp3",Vector(0,0,0),null,0,1,100,10,null);
}

credits_zm_cage<-null;
function mission_start(){
    local ct_tp=null;
    local zm_tp=null;
    if(admin_nuke_bool==true){
        if (!activator) return false;
        if(activator.GetTeam()==3){
            if(admin_nuke_ct_tp==null){
                admin_nuke_ct_tp = Entities.FindByName(null,"admin_nuke_ct_dest").GetOrigin();
            }
            activator.SetOrigin(admin_nuke_ct_tp);
        }
        else if(activator.GetTeam()==2){
            if(admin_nuke_zm_tp==null){
                admin_nuke_zm_tp = Entities.FindByName(null,"admin_nuke_zm_dest").GetOrigin();
            }
            activator.SetOrigin(admin_nuke_zm_tp);
        }    
    }
    if(mission==1){
        if (!activator) return false;
        if(activator.GetTeam()==3){
            ct_tp = Entities.FindByName(null,mission_1_ct_tp+"_1_"+RandomInt(1,3).tostring()).GetOrigin();
            activator.SetOrigin(ct_tp);
        }
        else if(activator.GetTeam()==2){
            zm_tp = Entities.FindByName(null,mission_1_zm_tp+"_1_"+RandomInt(1,3).tostring()).GetOrigin();
            activator.SetOrigin(zm_tp);
        }    
    }
    else if(mission==2){
        if (!activator) return false;
        if(activator.GetTeam()==3){
            ct_tp = Entities.FindByName(null,mission_2_ct_tp).GetOrigin();
            activator.SetOrigin(ct_tp);
        }
        else if(activator.GetTeam()==2){
            zm_tp = Entities.FindByName(null,mission_2_zm_tp).GetOrigin() + Vector(0,0,-32);
            activator.SetOrigin(zm_tp);
        }    
    }  
    else if(mission==3){
        if (!activator) return false;
        if(activator.GetTeam()==2 && activator.GetHealth()>1000){
            credits_zm_cage = Entities.FindByName(null,"credits_zm_tp_1_dest").GetOrigin();
            activator.SetOrigin(credits_zm_cage);
        }
        ct_tp = Entities.FindByName(null,mission_3_tp).GetOrigin();
        activator.SetOrigin(ct_tp);
    }
}

function zm_credits_tp(){
    if (!activator) return false;
    if(activator.GetTeam()==2 && activator.GetHealth()>1000){
        credits_zm_cage = Entities.FindByName(null,"credits_zm_tp_1_dest").GetOrigin();
        activator.SetOrigin(credits_zm_cage);
        EntFireByHandle(activator, "AddOutput", "MoveType 2", 0, "", "");
    }    
}

function zm_tp(mission,tp_number){
    local prefix = null;
    local destination = null;
    local tp = Entities.FindByName(null,"zm_tp");
    local tp_zone = null;
    if(mission==1){
        prefix = "m1_zm_tp_";
        destination = Entities.FindByName(null,prefix + tp_number + "_dest").GetOrigin();
        tp_zone = Entities.FindByName(null,prefix + tp_number);
    }
    else if(mission==2){
        prefix = "m2_zm_tp_";
        destination = Entities.FindByName(null,prefix + tp_number + "_dest").GetOrigin();
        tp_zone = Entities.FindByName(null,prefix + tp_number);
    }
    tp.SetOrigin(destination);
    EntFireByHandle(tp_zone, "Enable", "", 0.05, "", ""); 
}

function mako_bk_to_moon_base(){
    if (!activator) return false;
    if(activator.GetTeam()==3){
        local ct_tp = null;
        ct_tp = Entities.FindByName(null,"bk_rocket_ct_dest").GetOrigin();
        activator.SetOrigin(ct_tp);
    }
    else if(activator.GetTeam()==2){
        local zm_tp = null;
        zm_tp = Entities.FindByName(null,"m2_zm_tp_4_dest").GetOrigin();
        activator.SetOrigin(zm_tp);
    }        
}

::mako_zm_tp<-1;
function mako_fall(){
    if (!activator) return false;
    if(activator.GetTeam()==3){
        EntFireByHandle(activator, "SetHealth", 0, 0, "", "");
    }
    else if(activator.GetTeam()==2){
        EntFireByHandle(activator, "SetHealth", 0, 0, "", "");
    }    
}

function random_p2_funny(){
    if (!activator) return false;
    if(activator.GetTeam()==3){
        EntFireByHandle(activator, "SetHealth", 0, 0, "", "");
    }
    else if(activator.GetTeam()==2){
        activator.SetOrigin(Entities.FindByName(null,"zm_train").GetOrigin()+Vector(0,0,-32));
    }    
}

function sound_on(){
    local clientcommand = Entities.FindByName(null,"clientcommand_all");
    EntFireByHandle(clientcommand, "Command", "soundfade 100 0 0 0", 0, "", "");
    EntFireByHandle(clientcommand, "Command", "soundfade 100 0 0 0", 5, "", "");
    EntFireByHandle(clientcommand, "Command", "soundfade 100 0 0 0", 10, "", "");
}

function church_hatch_tp(){
    if (!activator) return false;
    if(activator.GetTeam()==2 || activator==null || !activator.IsValid())return;
    for (local cage = null; cage = Entities.FindByName(cage, "pow_m1_3");){
        if(cage){
            activator.SetOrigin(cage.GetOrigin()+Vector(0,0,64));
        }
    }
}

zm_deadcore_tp<-Entities.FindByName(null,"zm_deadcore_dest").GetOrigin();
function deadcore_fall(){
    if (!activator) return false;
    if(activator.GetTeam()==3){
        EntFireByHandle(activator, "SetHealth", 0, 0, "", "");
    }
    else if(activator.GetTeam()==2){
        if(deadcore_flight_tp==false){
            activator.SetOrigin(zm_deadcore_tp);
            activator.SetAngles(0.0,0.0,0.0);
        }
        else{
            activator.SetOrigin(Entities.FindByName(null,"zm_flight_platform").GetOrigin()+Vector(0,0,160));
        }
    }
}

function deadcore_new_tp(){
    zm_deadcore_tp = Entities.FindByName(null,"zm_flight_platform").GetOrigin();
    local m1_zm_tp_5 = Entities.FindByName(null,"deadcore_tp");
    local tp = Entities.FindByName(null,"zm_tp");
    local platform = Entities.FindByName(null,"zm_flight_platform");
    local cool_vector = platform.GetOrigin() + Vector(0,0,32);
    tp.SetOrigin(cool_vector);
    EntFireByHandle(tp,"SetParent","zm_flight_platform",0,"","");
    EntFireByHandle(m1_zm_tp_5, "Enable", "", 0, "", "");
}

// function zm_flight_spawn(){
//     local cool_vector = Entities.FindByName(null,"zm_flight_platform").GetOrigin()+Vector(0,0,64);
//     ::ITEMS.flight.Spawn(cool_vector);
//     ::VS.ListenToGameEvent( "item_pickup", function( event ){
//         if(event.item=="knife"){
//             local cool_vector = Entities.FindByName(null,"zm_flight_platform").GetOrigin()+Vector(0,0,32);
//             ::ITEMS.flight.Spawn(cool_vector);
//         }
//     }.bindenv(this), "zm_flight_spawner", 1 );
// }

function zm_flight_spawn(){
    zm_flight_player_death();
    local m1_zm_tp_5 = Entities.FindByName(null,"deadcore_tp");
    EntFireByHandle(m1_zm_tp_5, "Disable", "", 0, "", "");
    local cool_vector = Entities.FindByName(null,"zm_flight_platform").GetOrigin()+Vector(0,0,64);
    ::ITEMS.flight.Spawn(cool_vector);
}

function zm_flight_respawn(){
    local cool_vector = Entities.FindByName(null,"zm_flight_platform").GetOrigin()+Vector(0,0,64);
    ::ITEMS.flight.Spawn(cool_vector);
}

::fetus_hurt<-10;
function diddlecore_fetus(){
	if(activator.GetClassname()=="player"){
		EntFireByHandle(activator, "SetHealth", activator.GetHealth()-fetus_hurt, 0.00, null, null);    
    }
}

::admin_override_bool<-false;
function admin_level_override(x){
    admin_override_bool=true;
    ::VS.StopListeningToAllGameEvents("round_end_async");
	Chat(lore_prefix + TextColor.Legendary + "mission " + x.tostring() + " selected");
    local level = Entities.FindByName(null, "level_counter");
    EntFireByHandle(level, "SetValueNoFire", x, 0, "", "")    
}

::VS.ListenToGameEvent( "round_end", function( event ){
    if(admin_override_bool==true)return;
    if(event.winner==3 && mission==1){
        local level = Entities.FindByName(null, "level_counter");
        EntFireByHandle(level, "SetValueNoFire", 2, 0, "", "");
    }
    if(event.winner==3 && mission==2){
        local level = Entities.FindByName(null, "level_counter");
        EntFireByHandle(level, "SetValueNoFire", 3, 0, "", "");        
    }
    if(mission==3){
        local level = Entities.FindByName(null, "level_counter");
        EntFireByHandle(level, "SetValueNoFire", 1, 0, "", "");  
        ::Sound("sfx/dandy_boobies_gone.mp3",Vector(0,0,0),null,0,1,100,10,null);  
        return;
    }    
    if(event.winner==3){
        ::Sound("sfx/mslug3_mission_complete.mp3",Vector(0,0,0),null,0,1,100,10,null);
        if(mission==2){
            ::Sound("sfx/mslug3_rebel_cheer.mp3",Vector(0,0,0),null,0,1,100,10,null);
        }
    }
    else{
        stop_music();
        ::Sound("music/gravestone-mslug3.mp3",Vector(0,0,0),null,0,1,100,10,null);
    }
    if(rmp2_laser_timer!=null)rmp2_laser_timer.Destroy();
    if(rmp2_balls_timer!=null)rmp2_balls_timer.Destroy();
    //::VS.StopListeningToAllGameEvents("zm_flight_spawner");
    ::VS.StopListeningToAllGameEvents("player_say_one_piece");
    ::VS.StopListeningToAllGameEvents("player_death_flight");
    //::VS.Events.DumpListeners();
}.bindenv(this), "round_end_async", 0 );

::VS.ListenToGameEvent( "round_start", function( event ){
    ::VS.StopListeningToAllGameEvents("player_say_one_piece");
    ::VS.StopListeningToAllGameEvents("player_say_snirby_quest");
    //::VS.StopListeningToAllGameEvents("zm_flight_spawner");
    //::VS.Events.DumpListeners();
}.bindenv(this), "round_start_async", 0 );

deadcore_flight_tp<-false;
function deadcore_fall_flight(){
    deadcore_flight_tp=true;
}

function sky_swap_set(sky_swapper, skybox){
    sky_swapper.__KeyValueFromString("SkyboxName",skybox.tostring());
}

::deadcore_platforms<-0;
function deadcore_escape_randomize(x){
    deadcore_platforms++;
    local escape_platform_maker = Entities.FindByName(null, "escape_platform_maker" + deadcore_platforms.tostring());
    escape_platform_maker.__KeyValueFromString("EntityTemplate", "escape_platform_temp" + x.tostring());
    escape_platform_maker.SpawnEntity();
}

::deadcore_max_z<-8000;
::deadcore_max_x<-600;
::deadcore_max_y<-600;
::deadcore_max_fetus<-64;
::deadcore_max_ex<-2;
::fetus_anims<-["freak","hiss","hurt","idle","idlesmile"];
::fetus_model<-"models/luffaren/diddlefetusface.mdl";
function deadcore_press_randomize(){
    local fetus_maker = null;
    fetus_maker = Entities.FindByName(fetus_maker,"maker_diddlecore_fetus");
    local cool_origin = fetus_maker.GetOrigin();
    local cool_offset = null;
    local z_buffer = deadcore_max_z/deadcore_max_fetus;
    for(local i=0; i<deadcore_max_fetus;){
        for(local j=0; j<deadcore_max_ex;){
            cool_offset = Vector(RandomInt(-deadcore_max_x,deadcore_max_x),RandomInt(-deadcore_max_y,deadcore_max_y),-z_buffer*i);
            fetus_maker.SpawnEntityAtLocation(cool_origin + cool_offset, Vector(0,RandomFloat(0,360),0));
            j++;
        }
        i++;
    }
    for (local fetus = null; fetus = Entities.FindByModel(fetus, fetus_model.tostring());){
        EntFireByHandle(fetus,"SetAnimation",fetus_anims[RandomInt(0,fetus_anims.len()-1)].tostring(),0,"","");
    }
}

::reindeer_timer<-null;
::reindeer_interval<-0.325;
function deadcore_reindeer(){
    //EntFire("escape_beam_part*","Start","",0,"");
    //EntFire("escape_beam_part*","Stop","",58,"");
    reindeer_timer<-VS.Timer(false,reindeer_interval,function(){
        local reindeer_maker = Entities.FindByName(null,"reindeer_maker");
        local reindeer_origin = reindeer_maker.GetOrigin();
        local randomize_reindeer = Vector(0,0,0);
        local lower_bound = -640;
        local upper_bound = 640;
        randomize_reindeer = Vector(RandomInt(lower_bound,upper_bound),0,0) + reindeer_origin;
        reindeer_maker.SpawnEntityAtLocation(randomize_reindeer,Vector(0,0,0));
    })
}

::reindeer_hurt<-5;
::bender_hurt<-20;
::energy_ball_small_hurt<-5;
::energy_ball_medium_hurt<-10;
::energy_ball_huge_hurt<-15;
::rm_laser_hurt<-20;
function reindeer_hit(){
    if(!activator || activator==null || !activator.IsValid())return;
    EntFire("methamphetamine","ModifySpeed",0.25,0,activator);
    EntFire("methamphetamine","ModifySpeed",1,2,activator);
    EntFireByHandle(activator, "SetHealth", activator.GetHealth()-reindeer_hurt, 0.00, null, null);
}

function bender_hit(){
    if(!activator || activator==null || !activator.IsValid())return;
    EntFireByHandle(activator, "SetHealth", activator.GetHealth()-bender_hurt, 0.00, null, null);
}

function energy_ball_huge_hit(){
    if(!activator || activator==null || !activator.IsValid())return;
    EntFireByHandle(activator, "SetHealth", activator.GetHealth()-energy_ball_huge_hurt, 0.00, null, null);
}

function energy_ball_medium_hit(){
    if(!activator || activator==null || !activator.IsValid())return;
    EntFireByHandle(activator, "SetHealth", activator.GetHealth()-energy_ball_medium_hurt, 0.00, null, null);
}

function energy_ball_small_hit(){
    if(!activator || activator==null || !activator.IsValid())return;
    EntFireByHandle(activator, "SetHealth", activator.GetHealth()-energy_ball_small_hurt, 0.00, null, null);
}

function rm_laser_hit(){
    if(!activator || activator==null || !activator.IsValid())return;
    EntFireByHandle(activator, "SetHealth", activator.GetHealth()-rm_laser_hurt, 0.00, null, null);
}

function deadcore_reindeer_kill(){
    if(reindeer_timer!=null)reindeer_timer.Destroy();
}

::bender_timer<-null;
::prev_bender<-0;
::bender_firerate<-7;
function deadcore_benders(){
    bender_timer<-VS.Timer(false,bender_firerate,function(){
        local deadcore_bender = RandomInt(1,4);
        if(deadcore_bender==prev_bender){
            while(deadcore_bender==prev_bender){
                deadcore_bender = RandomInt(1,4);
            }
        }
        prev_bender = deadcore_bender;
        local deadcore_particle = Entities.FindByName(null, "escape_beam_part_" + deadcore_bender.tostring());
        EntFireByHandle(deadcore_particle, "Start", "", 0, "", "");
        EntFireByHandle(deadcore_particle, "Stop", "", bender_firerate, "", "");
        VS.EventQueue.AddEvent(bender_delay,bender_firerate,[this,deadcore_bender]);
    })
}

function bender_delay(deadcore_bender){
    local bender_maker = Entities.FindByName(null, "bender_maker");
    local offset = Vector(0,0,-80);
    local bender_spawn = Entities.FindByName(null, "escape_beam_spawn_" + deadcore_bender.tostring()).GetOrigin() + offset;
    bender_maker.SpawnEntityAtLocation(bender_spawn,Vector(0,0,0));
    for (local bender_phys = null; bender_phys = Entities.FindByName(bender_phys, "npc_phys2g3*");){
        bender_phys.__KeyValueFromInt("notsolid", 1);
    }
    for (local bender_phys = null; bender_phys = Entities.FindByName(bender_phys, "npc_phys2gg3*");){
        bender_phys.__KeyValueFromInt("notsolid", 1);
    }
}

::foreskins<-11; //number of texturegroup skins, subtract one because starts at 0
::deadcore_scuffer<-null;
function deadcore_color_scuffer(){
    for (local deadcore_platform = null; deadcore_platform = Entities.FindByClassname(deadcore_platform, "prop_dynamic*");){
        if(deadcore_platform.GetModelName().find("deadcore_")){
            EntFireByHandle(deadcore_platform, "Skin", RandomInt(0,foreskins-1), 0, "", "");
        }
    }    
    deadcore_scuffer<-VS.Timer(false,5,function(){
        for (local deadcore_platform = null; deadcore_platform = Entities.FindByClassname(deadcore_platform, "prop_dynamic*");){
            if(deadcore_platform.GetModelName().find("deadcore_")){
                EntFireByHandle(deadcore_platform, "Skin", RandomInt(0,foreskins-1), 0, "", "");
            }
        }
    });
}

function deadcore_red(){
    if(deadcore_scuffer!=null)deadcore_scuffer.Destroy();
    for (local deadcore_platform = null; deadcore_platform = Entities.FindByClassname(deadcore_platform, "prop_dynamic*");){
        if(deadcore_platform.GetModelName().find("deadcore_")){
            EntFireByHandle(deadcore_platform, "Skin", 5, 0, "", "");
        }
    }    
}

mission_1_music<-{
    [0] = "music/barracks-mslug3.mp3",
    [1] = "music/rubber_bazooka_pt1-one_piece.mp3",
    [2] = "music/rubber_bazooka_pt2-one_piece.mp3",
    [3] = "music/rubber_bazooka_pt3-one_piece.mp3",
    [4] = "music/he_who_can_not_forgive_fight_pt2-one_piece.mp3",
    [5] = "music/karakuri_castle_transform-one_piece.mp3",
    [6] = "music/eustass_kid_theme-one_piece.mp3",
    [7] = "music/hito_no_dokuro_ni_tee_dasuna-one_piece.mp3"
}
mission_1_tracktime<-{
    [0] = 40,
    [1] = 59,
    [2] = 62,
    [3] = 118,
    [4] = 91,
    [5] = 122,
    [6] = 119,
    [7] = 60       
}

mission_2_music<-{
    [0] = "music/barracks-mslug3.mp3",
    [1] = "music/into_the_sky_intro-mslug3.mp3",
    [2] = "music/assault_theme_intro-mslug3.mp3",
    [3] = "music/the_kidnapping-mslug3.mp3",
    [4] = "music/the_unknown_world_intro-mslug3.mp3",
    [5] = "music/first_contact_intro-mslug3.mp3",
    [6] = "music/steel_beast_6beats_intro-mslug3.mp3",
    [7] = "music/bioinformatics_intro-mslug3.mp3",
    [8] = "music/escape_intro-mslug3.mp3",   
    [9] = "music/final_attack_intro-mslug3.mp3"    
}

mission_2_tracktime<-{
    [0] = 40,
    [1] = 64.287,
    [2] = 10,
    [3] = 33,
    [4] = 5.068,
    [5] = 15.308,
    [6] = 16.797,
    [7] = 35.971,
    [8] = 37.721,
    [9] = 5.277
}

mission_2_music_loop<-{
    [0] = "",
    [1] = "music/into_the_sky_loop-mslug3.mp3",
    [2] = "music/assault_theme_loop-mslug3.mp3",
    [3] = "",
    [4] = "music/the_unknown_world_loop-mslug3.mp3",
    [5] = "music/first_contact_loop-mslug3.mp3",
    [6] = "music/steel_beast_6beats_loop-mslug3.mp3",
    [7] = "music/bioinformatics_loop-mslug3.mp3",
    [8] = "music/escape_loop-mslug3.mp3",   
    [9] = "music/final_attack_loop-mslug3.mp3"  
}

mission_2_loop_tracktime<-{
    [0] = 0,
    [1] = 50.913,
    [2] = 121,
    [3] = 0,
    [4] = 113.502,
    [5] = 71.837,
    [6] = 51.592,
    [7] = 93.597,
    [8] = 107.833,
    [9] = 87.850
}

credits_song<-"music/hold_you_still-mslug.mp3";
boobies_music<-["music/mountain_mocha_kilimanjaro_intro-word_pack.mp3","music/mountain_mocha_kilimanjaro_loop_1-word_pack.mp3","music/mountain_mocha_kilimanjaro_loop_2-word_pack.mp3"];
boobies_handles<-["boobies_1","boobies_2","boobies_3"];
boobies_tracktime<-[8.069,31.242,50.782];


::now_playing<-null;
::music_prefix<-"soundtrack_";
::loop<-0;
::queue_buffer<-0.1;
function music_queue(mission,track){
    //Chat(now_playing);
    if(track==0){
        now_playing = music_prefix + track.tostring();
        if(mission==1){
            ::Sound(mission_1_music[track],Vector(0,0,0),null,0,999,100,10,{function Run()
            {soundhandle.__KeyValueFromString("targetname",now_playing.tostring())}});   
        }
        else if(mission==2){
            ::Sound(mission_2_music[track],Vector(0,0,0),null,0,999,100,10,{function Run()
            {soundhandle.__KeyValueFromString("targetname",now_playing.tostring())}});   
        }
        return;
    }
    else if(mission==1){
        if(now_playing!=(music_prefix+track.tostring()) && now_playing!=null){
            for (local music = null; music = Entities.FindByName(music, now_playing.tostring());){
                //VS.EventQueue.Dump(music_queue);
                if(now_playing=="soundtrack_0"){
                    EntFireByHandle(music,"Volume", 0, 0,"", "");
                    EntFireByHandle(music,"Kill","",0.02,"","");                    
                }
                else{
                    EntFireByHandle(music,"Volume", 0, 0,"", "");
                    EntFireByHandle(music,"Kill","",0.02,"","");     
                    VS.EventQueue.CancelEventsByInput(music_queue);
                    VS.EventQueue.CancelEventsByInput(music_queue);
                    VS.EventQueue.CancelEventsByInput(music_queue);
                    VS.EventQueue.CancelEventsByInput(music_queue);
                    //VS.EventQueue.Dump(music_queue);                                       
                }
            }
        }
        //VS.EventQueue.Dump(music_queue);
        VS.EventQueue.AddEvent(music_queue,mission_1_tracktime[track],[this,mission,track]);  
        now_playing = music_prefix + track.tostring();
        ::Sound(mission_1_music[track],Vector(0,0,0),null,0,999,100,10,{function Run()
        {soundhandle.__KeyValueFromString("targetname",now_playing.tostring())}});
    }
    else if(mission==2){
        //Chat(now_playing);
        if(now_playing!=null && now_playing!=(music_prefix+track.tostring())){
            for (local music = null; music = Entities.FindByName(music, now_playing.tostring());){
                //VS.EventQueue.Dump(music_queue);
                if(now_playing=="soundtrack_0"){
                    EntFireByHandle(music,"Volume", 0, 0,"", "");
                    EntFireByHandle(music,"Kill","",0.02,"","");     
                    loop=0;              
                }
                else{
                    EntFireByHandle(music,"Volume", 0, 0,"", "");
                    EntFireByHandle(music,"Kill","",0.02,"","");     
                    VS.EventQueue.CancelEventsByInput(music_queue);
                    VS.EventQueue.CancelEventsByInput(music_queue);
                    VS.EventQueue.CancelEventsByInput(music_queue);
                    VS.EventQueue.CancelEventsByInput(music_queue);                    
                    //VS.EventQueue.Dump(music_queue);    
                    loop=0;                                   
                }
            }
        } 
        if(track==3){
            now_playing = music_prefix + track.tostring();
            ::Sound(mission_2_music[track],Vector(0,0,0),null,0,999,100,10,{function Run()
            {soundhandle.__KeyValueFromString("targetname",now_playing.tostring())}});
            return;
        }
        else{
            if(loop==0){
                if(track==7){
                    local bio = Entities.FindByName(null,"bioinformatics");
                    now_playing = music_prefix + track.tostring();
                    ::Sound(mission_2_music[track],Vector(0,0,0),null,0,mission_2_tracktime[track],100,10,{function Run()
                    {soundhandle.__KeyValueFromString("targetname",now_playing.tostring())}});                    
                    for(local mother_fucker = 0; mother_fucker<20;){
                        EntFireByHandle(bio, "PlaySound", "", mission_2_loop_tracktime[track]*mother_fucker+mission_2_tracktime[track], "", "");
                        mother_fucker++;
                    }
                    loop = 1;
                    now_playing = music_prefix + track.tostring();
                    return;
                }
                VS.EventQueue.AddEvent(music_queue,mission_2_tracktime[track],[this,mission,track]);
                loop = 1;
                now_playing = music_prefix + track.tostring();
                ::Sound(mission_2_music[track],Vector(0,0,0),null,0,mission_2_tracktime[track],100,10,{function Run()
                {soundhandle.__KeyValueFromString("targetname",now_playing.tostring())}});
            }
            else{
                if(track==7)return;
                VS.EventQueue.AddEvent(music_queue,mission_2_loop_tracktime[track],[this,mission,track]);
                for (local music = null; music = Entities.FindByName(music, now_playing.tostring());){
                    EntFireByHandle(music, "PlaySound", "", 0, "", "");      
                    //if(track>=7)EntFireByHandle(music, "PlaySound", "", mission_2_loop_tracktime[track], "", "");    
                    return;
                }
                now_playing = music_prefix + track.tostring();
                ::Sound(mission_2_music_loop[track],Vector(0,0,0),null,0,3600,100,10,{function Run()
                {soundhandle.__KeyValueFromString("targetname",now_playing.tostring())}});                
            }
        }
    }
    else if(mission==3){
        now_playing = "credits";
        ::Sound(credits_song,Vector(0,0,0),null,0,999,100,10,{function Run()
        {soundhandle.__KeyValueFromString("targetname",now_playing.tostring())}});        
        return;
    }
}

function boobies_music_queue(x){
    if(x==0){
        for (local music = null; music = Entities.FindByName(music, now_playing.tostring());){
            EntFireByHandle(music,"Volume", 0, 0,"", "");
            EntFireByHandle(music,"Kill","",0.02,"","");     
            VS.EventQueue.CancelEventsByInput(music_queue);
        }        
        now_playing = boobies_handles[x];
        VS.EventQueue.AddEvent(boobies_music_queue,boobies_tracktime[0],[this,1]);
        ::Sound(boobies_music[x],Vector(0,0,0),null,0,999,100,10,{function Run()
        {soundhandle.__KeyValueFromString("targetname",now_playing.tostring())}});        
        return;
    }
    else if(x==1){
        now_playing = boobies_handles[x];
        VS.EventQueue.AddEvent(boobies_music_queue,boobies_tracktime[1],[this,2]);
        ::Sound(boobies_music[x],Vector(0,0,0),null,0,999,100,10,{function Run()
        {soundhandle.__KeyValueFromString("targetname",now_playing.tostring())}});        
        return;
    }
    else if(x==2){
        now_playing = boobies_handles[x];
        VS.EventQueue.AddEvent(boobies_music_queue,boobies_tracktime[2],[this,1]);
        ::Sound(boobies_music[x],Vector(0,0,0),null,0,999,100,10,{function Run()
        {soundhandle.__KeyValueFromString("targetname",now_playing.tostring())}});        
        return;
    }    
}


function deadcore_benders_kill(){
    if(bender_timer!=null)bender_timer.Destroy();
    for (local bender_phys = null; bender_phys = Entities.FindByName(bender_phys, "npc_phys2g3*");){
        EntFireByHandle(bender_phys, "Break", "", 0, "", "");
    }
}

function bender_bounce(){
    if (!activator) return false;
    for (local bender_phys = null; bender_phys = Entities.FindByName(bender_phys, "npc_phys2g3*");){
        if (bender_phys == activator){
            local thruster_name = "bender_thruster_up&" + bender_phys.GetName().slice(12).tostring();
            //Chat(thruster_name.tostring());
            EntFire(thruster_name, "Activate", "", 0.01, "");
        }
    }
}

::dd_hitbox_cool<-null;
function dd_hitbox_spawn(){
    dd_hitbox_cool = Entities.FindByName(null,"dd_hp").GetOrigin();
}


function dd_upslash(){
    local upslasher = Entities.FindByName(null, "dd_attack_upslash");
    local cool_vector = dd_hitbox_cool;    
    local target = null;
    local plist = [];
    local offset = Vector(0,-24,488);
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player!=null && player.IsValid() && player.GetTeam()==3 && player.GetHealth()>0){
            plist.push(player);
        }
    }
    if(plist.len() > 0)
    {
        if(plist.len() == 1)target = plist[0];
        else target = plist[RandomInt(0,plist.len()-1)];
        if(target != null && target.IsValid() && target.GetHealth()>0)
        {
            cool_vector = Vector(target.GetOrigin().x,dd_hitbox_cool.y,dd_hitbox_cool.z) + offset;
        }
    }
    upslasher.SpawnEntityAtLocation(cool_vector, Vector(0,0,0));
}

function dd_sideslash(){
    local sideslasher = Entities.FindByName(null, "dd_attack_sideslash");
    local height = 64;
    local cool_vector = dd_hitbox_cool + Vector(0,-24 ,RandomInt(0,height)-160);
    sideslasher.SpawnEntityAtLocation(cool_vector, Vector(0,0,0));
}

function dd_baby(){
    local baby = Entities.FindByName(null, "dd_attack_baby");
    local deadcore_platform = 1200;
    local cool_vector = dd_hitbox_cool + Vector(RandomInt(-deadcore_platform/2,deadcore_platform/2),0,488);
    baby.SpawnEntityAtLocation(cool_vector, Vector(0,0,0));
}

function dd_vagina(){
    local vagina = Entities.FindByName(null, "dd_attack_vagina");
    local deadcore_platform = 1200;
    local cool_vector = dd_hitbox_cool + Vector(RandomInt(-deadcore_platform/2,deadcore_platform/2),0,488);
    vagina.SpawnEntityAtLocation(cool_vector, Vector(0,0,0));
    dd_baby();
}

vaginacount <- 0;
function AddVagina(){
	//gets called from vaginaface_base as activator
	vaginacount++;
	if(vaginacount>4)EntFireByHandle(activator, "FireUser2", "", 0.00, self, self);
}

function RemoveVagina(){
	vaginacount--;
}

babylist <- [];
babycount<-0;
function SpawnBaby()
{
	babycount++;
	babylist.insert(0,caller);
	local rrr22 = RandomFloat(0.00,0.50);
	EntFireByHandle(self,"RunScriptCode"," CheckMaxBabies(); ",rrr22,null,null);
}

function CheckMaxBabies()
{
	if(babycount>4)
		RemoveAndKillOldestBaby();
}

function RemoveAndKillOldestBaby() 
{
	if(babylist.len()>0 && babylist.top() != null && babylist.top().IsValid())
		EntFireByHandle(babylist.top(),"FireUser3","",0.00,null,null);
		//something went wrong, no matter though, since hammer auto-cleans babies
}

function RemoveBaby()
{
	for(local i=0;i<babylist.len();i+=1)
	{
		if(caller==babylist[i]){babylist.remove(i);babycount--;break;}
	}
}

pow_trig_offset<-Vector(0,0,-48);
function pow_spawns(mission){
    for(local pow_relay=null;pow_relay=Entities.FindByClassname(pow_relay,"logic_relay");){
        if(pow_relay.GetName().find(mission)>=0){
            local pows = pow_relay.GetName().slice(7).tointeger();
            local cool_vector=Entities.FindByName(null,pow_relay.GetName()).GetOrigin();
            local pow_spawn = null;
            local pow_trigger = null;
            local pow_sprite = null;
            pow_spawn = Entities.FindByName(null,"pow_spawn");
            pow_spawn.SpawnEntityAtLocation(cool_vector,Vector(0,RandomInt(0,360),0));
            pow_trigger = Entities.FindByName(null,"pow_trigger");
            pow_trigger.__KeyValueFromString("targetname","pow_trigger_" + pows.tostring());    
            pow_sprite = Entities.FindByName(null,"pow_tied_sprite");
            pow_sprite.__KeyValueFromString("targetname","pow_tied_sprite_" + pows.tostring());                
            EntFireByHandle(pow_trigger,"AddOutput","OnStartTouch aaa_magic:RunScriptCode:pow_saved("+pows.tostring()+");:0:1",0.00,null,null);
            if(pow_relay.GetName().find("pow_m1_3")>=0){
                EntFireByHandle(pow_trigger,"AddOutput","OnStartTouch church_pow_cage:Break::3:1",0.00,null,null);
            }
        }
    }
}

function pow_run_spawn(location){
    local pow_run = Entities.FindByName(null,"pow_run_maker");
    pow_run.SpawnEntityAtLocation(location,Vector(0,RandomInt(0,360),0));
}

::pow_save_time<-3.4;
::pow_ty_time<-1.5;
::pow_salute_time<-2.8;

// 0:heal, 1:diddlecannon, 2:random, 3:materia
::m1_items<-[2,2,2,1,2,2,2];
::m1_rng_items<-[0,0,0,1,1,1];
/////////////0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9
//13 is a double heal
::m2_items<-[3,3,3,3,3,3,3,3,3,0,3,3,1,0,3,0,0,1,1,0];
::m2_rng_items<-[0,0,1,1];
::m2_materia<-["barrier","bio","earth","electro","fire","gravity","heal","ice","mimic","water","wind","ultima"];

function rng_item(){
    local index = null;
    local item = null;
    if(mission==1){
        index = RandomInt(0,m1_rng_items.len()-1);
        local item = m1_rng_items[index];
        m1_rng_items.remove(index);
        return item;
    }
    if(mission==2){
        index = RandomInt(0,m2_rng_items.len()-1);
        local item = m2_rng_items[index];
        m2_rng_items.remove(index);
        return item;
    }    
}

function random_materia(){
    local index = null;
    local item = null;
    index = RandomInt(0,m2_materia.len()-1);
    local item = m2_materia[index];
    m2_materia.remove(index);
    return item;
}

function pow_saved(pow){
    if (activator==null || !activator.IsValid() || !activator || activator.GetTeam()==2)return;
    else{
        local tied_up_sprite = Entities.FindByName(null,"pow_tied_sprite_"+pow.tostring());  
        EntFireByHandle(tied_up_sprite, "Kill", "", 0, "", "");
        local location_trigger = Entities.FindByName(null,"pow_trigger_"+pow.tostring());    
        local location = location_trigger.GetOrigin();   
        local location_offset = location + pow_trig_offset;    
        local pow_saved = Entities.FindByName(null,"pow_saved_maker");
        pow_saved.SpawnEntityAtLocation(location_offset,Vector(0,0,0));
        local saved_sprite = Entities.FindByNameNearest("pow_saved_sprite*", location, 256);
        VS.EventQueue.AddEvent(pow_run_spawn,pow_save_time,[this,location_offset]);
        EntFireByHandle(saved_sprite, "Kill", "", pow_save_time, "", "");
        VS.EventQueue.AddEvent(Sound,pow_ty_time,[this,"sfx/mslug3_thank_you.mp3",location,null,0,70.00,100,10,null]);
        VS.EventQueue.AddEvent(Sound,pow_salute_time,[this,"sfx/mslug3_salute.mp3",location,null,0,70.00,100,10,null]);
        local item_maker = Entities.FindByName(null,"item_diddle_cannon");
        local lol = null;
        if(mission==1){
            lol = m1_items[pow];
            if(lol==2)lol=rng_item();
            if(lol==0)VS.EventQueue.AddEvent(spawn_heal,pow_ty_time,[this,location]);
            if(lol==1)VS.EventQueue.AddEvent(spawn_item,pow_ty_time,[this,item_maker,location]);
        }
        if(mission==2){
            lol = m2_items[pow];
            if(lol==2)lol=rng_item();                
            if(lol==0)VS.EventQueue.AddEvent(spawn_heal,pow_ty_time,[this,location]);
            if(lol==1)VS.EventQueue.AddEvent(spawn_item,pow_ty_time,[this,item_maker,location]);
            if(lol==3){
                local materia_name = random_materia();
                VS.EventQueue.AddEvent(spawn_materia,pow_ty_time,[this,materia_name,location]);
            }
            if(pow==13)VS.EventQueue.AddEvent(spawn_heal,pow_ty_time,[this,location+Vector(RandomInt(0,0),RandomInt(-128,-64),0)]);
        } 
        if(location_trigger!=null)EntFireByHandle(location_trigger,"Kill","",5,"","");           
    }
}

function spawn_heal(location){
    ::ITEMS.heal_orb.Spawn(location);
}

function spawn_materia(materia_name,location){
    local materia_maker = Entities.FindByName(null,"spawn_item_"+materia_name);
    materia_maker.SpawnEntityAtLocation(location,Vector(0,0,0));
}

function sfx(sound,pos=Vector(),_parent=null,radius=10000,lifetime=0.05,pitch=100,volume=10,logic=null){
    return ::Sound(sound,pos,_parent,radius,lifetime,pitch,volume,logic);
}

function spawn_item(item,location){
    item.SpawnEntityAtLocation(location,Vector(0,0,0));
}

function sfx_electricity(){
    ::Sound("sfx/mslug3_electricity.mp3",Vector(15230,6308,12822),null,9999,1,100,10,null);
}

function sfx_rocket(){
    local sky_swapper = Entities.FindByName(null,"sky_swapper");
    ::Sound("ambient/machines/hydraulic_1.wav",Vector(0,0,0),null,0,1,100,10);
    VS.EventQueue.AddEvent(Sound,5,[this,"animation/jets/jet_flyby_01.wav",Vector(0,0,0),null,0,1,100,10]);
    VS.EventQueue.AddEvent(Sound,6,[this,"animation/jets/jet_flyby_02.wav",Vector(0,0,0),null,0,1,100,10]);
    VS.EventQueue.AddEvent(Sound,7,[this,"animation/jets/jet_flyby_03.wav",Vector(0,0,0),null,0,1,100,10]);
    VS.EventQueue.AddEvent(Sound,8,[this,"animation/jets/jet_flyby_04.wav",Vector(0,0,0),null,0,1,100,10]);
    VS.EventQueue.AddEvent(Sound,9,[this,"animation/jets/jet_flyby_05.wav",Vector(0,0,0),null,0,1,100,10]);
    VS.EventQueue.AddEvent(Sound,10,[this,"animation/jets/jet_flyby_06.wav",Vector(0,0,0),null,0,1,100,10]);
    EntFireByHandle(sky_swapper,"Trigger","",0,"","");
    EntFire("bk_skybox_rocket","Toggle","",10,"");
}

function sfx_okay(){
    if (!activator || activator==null || !activator.IsValid())return false;
    //::Sound("sfx/mslug3_okay.mp3",Vector(0,0,15),activator,9999,2.0,100,10);
    ::Sound("sfx/mslug3_okay.mp3",activator.GetOrigin()+Vector(0,0,15),null,9999,2.0,100,10);
}

::sfx_power_up<-function(){
    if (!activator || activator==null || !activator.IsValid())return false;
    //::Sound("sfx/mslug3_power_up.mp3",Vector(0,0,15),activator,9999,2.0,100,10);
    ::Sound("sfx/mslug3_power_up.mp3",activator.GetOrigin()+Vector(0,0,15),null,9999,2.0,100,10);
}

function sfx_stone(){
    if (!activator || activator==null || !activator.IsValid())return false;
    //::Sound("sfx/mslug3_stone.mp3",Vector(0,0,15),activator,9999,2.0,100,10);
    ::Sound("sfx/mslug3_stone.mp3",activator.GetOrigin()+Vector(0,0,15),null,9999,2.0,100,10);
    zm_mako_infused();
}

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

function captain_dickbeard_scale(){
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player.GetTeam()==3){
            captain_dickbeard_hp += captain_dickbeard_hp_per_ct;
        }
    }
    local dickbeard_hitbox = Entities.FindByName(null,"dd_hp");
    EntFireByHandle(dickbeard_hitbox, "SetHealth", captain_dickbeard_hp, 0, "", "");
}

function rootmars_phase_1(){
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player.GetTeam()==3){
            rootmars_phase_1_hp += rootmars_phase_1_hp_per_ct;
        }
    }
    local rootmars_hibox = Entities.FindByName(null,"rootmars_phase_1_hitbox");
    EntFireByHandle(rootmars_hibox, "SetHealth", rootmars_phase_1_hp, 0, "", "");
    Sound("sfx/mslug3_ball_charge.mp3",ball_start.GetOrigin(),null,0,0.05,100,10,null);
    rmp1_small_start();
    EntFire("rootmars_phase_1_model","Skin",1,0,"");
    materia_listen_rmp1=true;
}

small_ball<-Entities.FindByName(null,"maker_energy_ball_small");
huge_ball<-Entities.FindByName(null,"maker_energy_ball_huge");
ball_start<-Entities.FindByName(null,"rootmars_phase_1_attack");
::rmp1_small_timer<-null;
::rmp1_small_ball_count<-3;
function rmp1_small_start(){
    rmp1_small_timer<-VS.Timer(false,0.75,function(){
        Sound("sfx/mslug3_ball_charge_small.mp3",ball_start.GetOrigin(),null,0,0.05,100,10,null);  
        local target = null;
        local plist = [];
        for (local player = null; player = Entities.FindByClassname(player, "player");){
            if(player!=null && player.IsValid() && player.GetTeam()==3 && player.GetHealth()>0){
                plist.push(player);
            }
        }
        if(plist.len() > 0){
            for(local i=0; i<rmp1_small_ball_count;){
                if(plist.len() == 1){
                    i=rmp1_small_ball_count;
                    target = plist[0];
                }
                else target = plist[RandomInt(0,plist.len()-1)];
                if(target != null && target.IsValid() && target.GetHealth()>0)
                {
                    local vector_to = target.GetOrigin();
                    local vector_from = ball_start.GetOrigin();
                    local ball_angles = VS.GetAngle(vector_from, vector_to);
                    small_ball.SpawnEntityAtLocation(vector_from, ball_angles);
                }
                i++;
            }
        }
    })
}


::rmp1_huge_timer<-null;
::rmp1_huge_skip<-4;
function rmp1_huge_start(){
    rmp1_huge_timer<-VS.Timer(false,2.325,function(){
        rmp1_huge_skip--;
        if(rmp1_huge_skip==0){
            rmp1_huge_skip=4;
            return;
        }
        Sound("sfx/mslug3_ball_charge_huge.mp3",ball_start.GetOrigin(),null,0,0.05,100,10,null);  
        local target = null;
        local plist = [];
        for (local player = null; player = Entities.FindByClassname(player, "player");){
            if(player!=null && player.IsValid() && player.GetTeam()==3 && player.GetHealth()>0){
                plist.push(player);
            }
        }
        if(plist.len() > 0)
        {
            if(plist.len() == 1)target = plist[0];
            else target = plist[RandomInt(0,plist.len()-1)];
            if(target != null && target.IsValid() && target.GetHealth()>0)
            {
                local vector_to = target.GetOrigin();
                local vector_from = ball_start.GetOrigin();
                local ball_angles = VS.GetAngle(vector_from, vector_to);
                huge_ball.SpawnEntityAtLocation(vector_from, ball_angles);
            }
        }
    })
}

::rmp1_hp_timer<-null;
function rmp1_hp_monitor(){
    rmp1_hp_timer<-VS.Timer(false,1,function(){
        local hitbox = null;
        if(hitbox = Entities.FindByName(null,"rootmars_phase_1_hitbox")){
            //Chat(hitbox.GetHealth() + " : " + rootmars_phase_1_hp);
            if(hitbox.GetHealth()<(rootmars_phase_1_hp/1.5)){
                rmp1_huge_start();
                if(rmp1_small_timer!=null)rmp1_small_timer.Destroy();
                rmp1_small_timer=null;
                if(rmp1_hp_timer!=null)rmp1_hp_timer.Destroy();
            }
        }
    })
}

function rootmars_phase_1_kill(){
    if(rmp1_small_timer!=null)rmp1_small_timer.Destroy();
    if(rmp1_huge_timer!=null)rmp1_huge_timer.Destroy();
    Sound("sfx/mslug3_rootmars_pain.mp3",ball_start.GetOrigin(),null,0,0.05,100,10,null);  
    Sound("sfx/mslug3_rootmars_pain_alt.mp3",ball_start.GetOrigin(),null,0,0.05,100,10,null);  
    Sound("sfx/mslug3_rootmars_shake.mp3",ball_start.GetOrigin(),null,0,0.05,100,10,null);  
    stop_music();
    materia_listen_rmp1=false;
}

function sfx_monster_slam(){
    Sound("sfx/mslug3_monster_slam.mp3",ball_start.GetOrigin(),null,0,0.05,100,10,null);  
}

::escape_alarm_timer<-null;
function escape_alarm(){
    escape_alarm_timer<-VS.Timer(false,2,function(){
        Sound("sfx/mslug3_alarm.mp3",Vector(0,0,0),null,0,1,100,10,null);
    })
}

function xanax(){
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player.GetTeam()==3){
            xanax_hp += xanax_hp_per_ct;
        }
    }
    local xanax_hitbox = Entities.FindByName(null,"xanax_pill");
    //Chat(xanax_hp.tostring());
    EntFireByHandle(xanax_hitbox, "SetHealth", xanax_hp, 0, "", "");
    thighspider_start();
    rugname_chamber_door();
    local j=0.0;
    Sound("ambient/ambience/rainscapes/thunder_close01.wav",Vector(0,0,0),null,0,10,RandomInt(90,110),10,null);
    VS.EventQueue.AddEvent(Sound,2.5,[this,"ambient/ambience/rainscapes/thunder_close02.wav",Vector(0,0,0),null,0,10,RandomInt(90,110),10,null]);
    VS.EventQueue.AddEvent(Sound,7.5,[this,"ambient/ambience/rainscapes/thunder_close03.wav",Vector(0,0,0),null,0,10,RandomInt(90,110),10,null]);
    VS.EventQueue.AddEvent(Sound,10,[this,"ambient/ambience/rainscapes/thunder_close04.wav",Vector(0,0,0),null,0,10,RandomInt(90,110),10,null]);
    EntFire("xanax_particle","Start","",0,"");
    EntFire("xanax_particle","Stop","",10,"");   
    EntFire("dd_fade","Fade","",4.95,"");
    EntFire("xanax_pill","Enable","",5,"");
    EntFire("xanax_rotate","Start","",5,"");
    materia_listen_xanax=true;
}

::rugname_chamber_door_timer<-null;
function rugname_chamber_door(){
    Chat(lore_prefix + TextColor.Legendary + "shit, these doors are busted! we're going to have to hold them off at the same time!");
    rugname_chamber_door_timer<-VS.Timer(false,20,function(){
        VS.EventQueue.AddEvent(Chat,10,[this,lore_prefix + TextColor.Legendary + "doors in 5, get ready to defend!"]);
        EntFire("rugname_cloning_chamber_doors_1", "Close", "", 0, "");
        EntFire("rugname_cloning_chamber_doors_2", "Close", "", 0, "");
        EntFire("rugname_cloning_chamber_doors_1", "Open", "", 15, "");
        EntFire("rugname_cloning_chamber_doors_2", "Open", "", 15, "");
    });
}

function lore_buttons(){
    Chat(lore_prefix + TextColor.Legendary + "wait!!! we have to press these at the same time, coordinate guys!");
}

::thighspider_count<-0;
::thighspider_max<-32;
//thighspider_count is in collective nut
::thighspider_timer<-null;
::rugname_chambers<-{
    [0] = Vector(10048,2464,11520),
    [1] = Vector(10048,1632,11520),
    [2] = Vector(10048,800,11520),
    [3] = Vector(9280,800,11520),
    [4] = Vector(9280,1632,11520),
    [5] = Vector(9280,2464,11520)
};

function zm_clone_randomize(){
    if(!activator || activator==null || !activator.IsValid())return;
    activator.SetOrigin(rugname_chambers[RandomInt(0,rugname_chambers.len()-1)]);
}

function mako_infusion_spawn(){
    local cool_vector = Entities.FindByName(null,"mako_infusion").GetOrigin()+Vector(0,0,48);
    ::ITEMS.stone.Spawn(cool_vector);
}

function mako_infusion_respawn(){
    local cool_vector = Entities.FindByName(null,"mako_infusion").GetOrigin()+Vector(0,0,48);
    ::ITEMS.stone.Spawn(cool_vector);
}

function thighspider_start(){
    thighspider_timer<-VS.Timer(false,0.75,function(){
        if(thighspider_max>thighspider_count){
            local location = rugname_chambers[RandomInt(0,rugname_chambers.len()-1)];
            ::TRAPS.thigh_spider.Spawn(location);
            Sound("sfx/mslug3_richochet.mp3",location,null,10000,0.05,100,10,null);
            thighspider_count++;
        }
        else{
            // thighspider_count=0;
            // for (local spiders = null; spiders = Entities.FindByClassname(spiders, "prop_dynamic*");){
            //     if(spiders.GetModelName().find("thigh_spider")){
            //         thighspider_count++;
            //     }
            // }
        }
    })
}

function xanax_kill(){
    if(thighspider_timer!=null)thighspider_timer.Destroy();
    if(rugname_chamber_door_timer!=null)rugname_chamber_door_timer.Destroy();
    EntFire("rugname_cloning_chamber_doors*","Open","",0,"");
    stop_music();
    ::Sound(predator_sfx[1],Vector(0,0,0),null,0,0.05,100,10,null);  
    ::Sound("sfx/mslug3_rocket_explode.mp3",Vector(0,0,0),null,0,0.05,100,10,null); 
    VS.EventQueue.AddEvent(Sound,2,[this,"sfx/mslug3_ship_explosion.mp3",Vector(0,0,0),null,0,0.05,100,10,null]);
    VS.EventQueue.AddEvent(Sound,3,[this,"sfx/mslug3_ship_explosion_2.mp3",Vector(0,0,0),null,0,0.05,100,10,null]);
    xanax_is_kill=true;   
    // for (local spiders = null; spiders = Entities.FindByClassname(spiders, "prop_dynamic*");){
    //     if(spiders.GetModelName().find("thigh_spider")){
    //         EntFireByHandle(spiders,"RunScriptCode","Die();",0,"");
    //     }
    // }    
    materia_listen_xanax=false;
}

//rootmars phase 2
rm_laser<-Entities.FindByName(null,"maker_rootmars_laser");
::rmp2_balls_timer<-null;
::rmp2_laser_timer<-null;

::laser_cc <- Entities.FindByName(null,"cc_rootmars_laser");
::laser_fire_cc <- Entities.FindByName(null,"cc_rootmars_laser_fire");

function rmp2_laser_start(){
    rmp2_laser_timer<-VS.Timer(false,12,function(){
        local rmp2_model = Entities.FindByName(null,"rootmars_phase_2_model");
        EntFireByHandle(rmp2_model, "SetBodyGroup", 2, 0.01, "", "");           
        EntFireByHandle(rmp2_model, "SetBodyGroup", 0, 2.41, "", "");       
        EntFireByHandle(laser_cc, "Enable", "", 0, "", "");
        EntFireByHandle(laser_cc, "Disable", "", 2.3, "", "");
        EntFireByHandle(laser_fire_cc, "Enable", "", 2.25, "", "");
        EntFireByHandle(laser_fire_cc, "Disable", "", 2.5, "", "");
        ::Sound("sfx/mslug3_charge_up.mp3",rmp2_model.GetOrigin(),null,0,0.05,100,10,null);
        EntFire("rootmars_refract*","Start","",0,"");
        EntFire("rootmars_refract*","Stop","",2.3,"");          
        VS.EventQueue.AddEvent(laser_delay,2.3,[this,rmp2_model]);
    })
}

::laser_offset<-Vector(0,0,54);
function laser_delay(rmp2_model){
    ::Sound("sfx/mslug3_rootmars_laser.mp3",rmp2_model.GetOrigin(),null,0,0.05,100,10,null);  
    local hmm = RandomInt(0,999);
    local laser_location = Vector(rmp2_model.GetOrigin().x,rmp2_model.GetOrigin().y,rm_laser.GetOrigin().z);
    if(hmm>500){
        rm_laser.SpawnEntityAtLocation(laser_location, Vector(0,0,0));
    }
    else{
        rm_laser.SpawnEntityAtLocation(laser_location+laser_offset, Vector(0,0,0));
    } 
}

function ct_outside_zone(){
    if(activator!=null && activator.IsValid() && activator.GetTeam()==3 && activator.GetHealth()>0){
        local vector_to = activator.GetOrigin();
        local vector_from = rmp2_balls.GetOrigin();
        local ball_angles = VS.GetAngle(vector_from, vector_to);
        rmp2_balls.SpawnEntityAtLocation(vector_from,ball_angles);
    }
}

function rmp2_balls_start(){
    rmp2_balls_timer<-VS.Timer(false,12,function(){
        local rmp2_model = Entities.FindByName(null,"rootmars_phase_2_model");  
        EntFireByHandle(rmp2_model, "SetBodyGroup", 1, 0.01, "", "");          
        EntFireByHandle(rmp2_model, "SetBodyGroup", 0, 1.10, "", "");
        ::Sound("sfx/mslug3_rootmars_balls.mp3",rmp2_model.GetOrigin(),null,0,0.05,100,10,null);  
        EntFire("ct_boss_zone","CountPlayersInZone","",0,"");
        crazy_balls();
    })
}

::crazy_balls_count<-32;
::crazy_balls_x<-1408/2;
::crazy_balls_y<-1792/2;
::crazy_balls_z<-1408/2;
::crazy_balls_dest<-Entities.FindByName(null,"crazy_balls");
::rmp2_balls<-Entities.FindByName(null,"maker_rootmars_balls");
::rmp2_balls_offset<-Vector(0,-1024,0);
function crazy_balls(){
    local vector_to = crazy_balls_dest.GetOrigin();
    local vector_from = rmp2_balls.GetOrigin()+rmp2_balls_offset;
    local ball_angles = VS.GetAngle(vector_from, vector_to);
    local crazy_vector = null;
    for (local i = 0; i<crazy_balls_count;){
        crazy_vector = vector_from + Vector(0,RandomInt(-crazy_balls_y,crazy_balls_y),RandomInt(-crazy_balls_z,crazy_balls_z));
        VS.EventQueue.AddEvent(balls_delay,i/10,[this,crazy_vector,ball_angles]);
        i++;
    }
}

function balls_delay(vector_from,ball_angles){
    rmp2_balls.SpawnEntityAtLocation(vector_from,ball_angles);
}

function rootmars_phase_2(){
    local laser_base = Entities.FindByName(null,"deadcore_laser_base");
    laser_base.SetOrigin(Vector(-12949,-13120,-13025));
    //local clouds = Entities.FindByName(null,"finale_skybox");
    EntFire("finale_skybox*", "Toggle", "", 0, "");
    //local particles = Entities.FindByName(null,"rootmars_phase_2_skybox_particles*");
    //EntFireByHandle(clouds, "Start", "", 0.1, "");
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player.GetTeam()==3){
            rootmars_phase_2_hp += rootmars_phase_2_hp_per_ct;
        }
    }
    local rootmars_phase_2_hitbox = Entities.FindByName(null,"rootmars_phase_2_hitbox");
    EntFireByHandle(rootmars_phase_2_hitbox, "SetHealth", rootmars_phase_2_hp, 0, "", ""); 
    ::Sound("sfx/mslug3_rootmars_laugh.mp3",Vector(0,0,0),null,0,1,100,10,null);
    VS.EventQueue.AddEvent(rootmars_laugh_2,7,[this]);
    VS.EventQueue.AddEvent(music_queue,8,[this,2,9]);
    EntFire("rootmars_zm_platform_1","Start","",8.1,"");
    EntFire("rootmars_zm_platform_2","Start","",8.2,"");
    //VS.EventQueue.AddEvent(zm_tp,11,[this,2,8]);
    ball_start=Entities.FindByName(null,"rootmars_phase_2_attack");
    VS.EventQueue.AddEvent(rmp2_laser_start,9,[this]);   
    VS.EventQueue.AddEvent(rmp2_balls_start,5.5,[this]);  
    EntFire("finale_skybox_particle","Start","",0,"");
    materia_listen_rmp2=true;
}

::exhaust_count<-6;
function rmp2_stuff(){
    local temp_rmp2 = Entities.FindByName(null,"temp_rmp2");
    EntFireByHandle(temp_rmp2, "ForceSpawn", "", 0, "", "");
    local blood_p = null;
    local refract_p = null;
    for(local i=1;i<=exhaust_count;){
        blood_p = Entities.FindByName(null,"rootmars_blood_" + i.tostring());
        refract_p = Entities.FindByName(null,"rootmars_refract_" + i.tostring());
        EntFireByHandle(blood_p,"SetParent", "rootmars_phase_2_model", 0, "", "");
        EntFireByHandle(blood_p,"SetParentAttachment","exhaust_"+i.tostring(),0.02,"","");
        EntFireByHandle(refract_p,"SetParent", "rootmars_phase_2_model", 0, "", "");
        EntFireByHandle(refract_p,"SetParentAttachment","exhaust_"+i.tostring(),0.02,"","");
        i++;
    }
    rmp2_balls=Entities.FindByName(null,"maker_rootmars_balls");
    EntFireByHandle(rmp2_balls,"SetParent", "rootmars_phase_2_model", 0, "", "");
    EntFireByHandle(rmp2_balls,"SetParentAttachment","mouth",0.02,"","");
    VS.EventQueue.AddEvent(rmp2_hitbox,2,[this]);
}

function rmp2_hitbox(){
    local hb = Entities.FindByName(null,"rootmars_phase_2_hitbox");
    EntFireByHandle(hb, "SetParent", "rootmars_phase_2_model", 0, "", "");
    EntFireByHandle(hb, "SetParentAttachment", "brain", 0.02, "", "");
}

paper_airplane_timer<-null;
direction<--1;
function credits_sprites(){
    local credits_temp = Entities.FindByName(null,"credits_template");
    EntFireByHandle(credits_temp, "ForceSpawn", "", 0, "", "");
    local soldier_angles = Vector(0,0,0);
    local solder_helper = Entities.FindByName(null,"solider_helper");
    EntFire("credits_move","Open","",0,"");
    local soldier_throw = Entities.FindByName(null,"maker_soldier_throw");
    EntFireByHandle(soldier_throw, "ForceSpawnAtEntityOrigin", "soldier_helper", 0, "", "");
    EntFire("soldier_throw","Kill","",3.1,"");
    local soldier_idle = Entities.FindByName(null,"maker_soldier_idle");
    EntFireByHandle(soldier_idle, "ForceSpawnAtEntityOrigin", "soldier_helper", 3.1, "", "");
    EntFire("soldier_idle","Kill","",10,"");
    local paper_airplane = Entities.FindByName(null, "maker_paper_airplane");
    EntFireByHandle(paper_airplane, "ForceSpawnAtEntityOrigin", "soldier_helper", 2.5, "", "");
    EntFire("paper_airplane","ClearParent","",2.6,"");
    EntFire("paper_airplane","SetParent","credits_move",145,"");
    VS.EventQueue.AddEvent(paper_airplane_stop,146,[this]);
    VS.EventQueue.AddEvent(paper_airplane_timer_start,3,[this]);
}

function paper_airplane_timer_start(){
    paper_airplane_woah();
    paper_airplane_timer<-VS.Timer(false,12,function(){
        paper_airplane_woah();
    })    
}

function paper_airplane_stop(){
    if(paper_airplane_timer!=null)paper_airplane_timer.Destroy();
}

function credits_cleanup(){
    lore(3,6);
    EntFire("zm_tp_credits","Disable","",0,"");
    EntFire("zm_tp_credits","Kill","",1,"");
    EntFire("zm_credits_cage","Break","",20,"");
    EntFire("theater_doors","Unlock","",5,"");
    EntFire("theater_doors","Open","",10,"");
    VS.EventQueue.AddEvent(boobies_music_queue,10,[this,0]);
    one_piece_start();
    movement_enable();
    VS.EventQueue.AddEvent(booba_doors_start,15,[this]);
    VS.EventQueue.AddEvent(lore,10,[this,3,7]);      
}

::theater_rows<-[Vector(-42,93,-15848),Vector(-137,93,-15864),Vector(-233,93,-15880),Vector(-329,93,-15896),Vector(-425,93,-15912),Vector(-521,93,-15928)];
::theater_row_z<-Vector(0,0,-20);
::theater_spacing<-Vector(0,64,0);
::theater_cols<-13;
function ct_to_seats(){
    local row = 0;
    local col = 0;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(col==2 || col==11)col++;
        if(col>theater_cols){
            col=0;
            row++;
        }
        player.SetOrigin(theater_rows[row]+theater_spacing*col+theater_row_z);
        player.SetAngles(0.0,180.0,0.0);
        col++;
        EntFireByHandle(player, "Addoutput", "MoveType 0", 0, "", "");
    }
    //bot_test_to_seats(row,col);
}

function bot_test_to_seats(row,col){
    for (local player = null; player = Entities.FindByClassname(player, "cs_bot");){
        if(col==2 || col==11)col++;
        if(col>theater_cols){
            col=0;
            row++;
        }
        player.SetOrigin(theater_rows[row]+theater_spacing*col+theater_row_z);
        player.SetAngles(0.0,180.0,0.0);
        col++;
        EntFireByHandle(player, "Addoutput", "MoveType 0", 0, "", "");
    }
}

function paper_airplane_woah(){
    local pa = null;
    local scale = 1.00;
    local interval = 0.25;
    local time = 3.00;
    local time2 = 6.00;
    local i = null;
    local k = null;
    pa = Entities.FindByName(null,"paper_airplane");
    if(pa==null)return;
    for(i=interval;i<time;){
        VS.EventQueue.AddEvent(model_scale,i,[this,pa,scale]);
        i = i + interval;
        scale = scale + 0.1;
        //printl(i);
    }
    time = time*3;
    for(k=time2;k<time;){
        ///printl(k);
        VS.EventQueue.AddEvent(model_scale,k,[this,pa,scale]);
        k = k + interval;
        scale = scale - 0.1;
    }    
}

function model_scale(e,x){
    e.__KeyValueFromFloat("modelscale",x);
}

::predator_sfx<-["sfx/mslug3_ship_explosion.mp3",
    "sfx/mslug3_ship_explosion_2.mp3",
    "sfx/mslug3_ship_explosion_3.mp3",
    "sfx/mslug3_ship_explosion_4.mp3",
    "sfx/mslug3_ship_explosion_5.mp3"];

predator_ship_sfx_timer<-null;
function predator_ship_sfx(){
    ::Sound(predator_sfx[RandomInt(0,predator_sfx.len()-1)],Vector(0,0,0),null,0,0.05,100,10,null);  
}

function woah_buddy_slow_down(){
    if(!activator)return;
    local slow = Vector(activator.GetVelocity().x/6,activator.GetVelocity().y/6,activator.GetVelocity().z/6);
    activator.SetVelocity(slow);
}

::rebel_death_sfx<-["sfx/mslug3_rebel_death_1.mp3",
    "sfx/mslug3_rebel_death_2.mp3",
    "sfx/mslug3_rebel_death_3.mp3",
    "sfx/mslug3_rebel_death_4.mp3",
    "sfx/mslug3_rebel_death_5.mp3",
    "sfx/mslug3_rebel_death_6.mp3",
    "sfx/mslug3_rebel_death_7.mp3"];

// *********** player_death event handler
::VS.ListenToGameEvent("player_death",function(event){
    local player = VS.GetPlayerByUserid(event.userid);
    if (player!=null && player.IsValid()){
        if(player.GetTeam()==3){
            //::Sound(rebel_death_sfx[RandomInt(0,rebel_death_sfx.len()-1)],Vector(0,0,15),player,10000,0.05,100,10,null);   
            ::Sound(rebel_death_sfx[RandomInt(0,rebel_death_sfx.len()-1)],player.GetOrigin()+Vector(0,0,15),null,10000,0.05,100,10,null); 
        }
    }
}.bindenv(this), "player_death_async", 0);

function zm_flight_player_death(){
    EntFire("manager","RunScriptCode","::ITEMS.flight.TickFlightItemHpCap();",0.10,null);
    ::VS.ListenToGameEvent("player_death",function(event){
        local cool_vector = Entities.FindByName(null,"zm_flight_platform").GetOrigin()+Vector(0,0,32);
        local player = VS.GetPlayerByUserid(event.userid);
        if (player!=null && player.IsValid()){
            player.SetOrigin(cool_vector);
        }
    }.bindenv(this), "player_death_flight", 0);
}

function namviet_sfx(){
    VS.EventQueue.AddEvent(Sound,2,[this,"ambient/playonce/weather/thunder_distant_06.wav",Vector(0,0,0),null,0,1,100,10,null]);
    VS.EventQueue.AddEvent(Sound,2,[this,"weapons/c4/c4_explode1.wav",Vector(0,0,0),null,0,1,100,10,null]);
    ::Sound("sfx/yippee_ki_yay_motherfucker.mp3",Vector(0,0,0),null,0,1,100,10,null);
}

::namviet_count<-0;
function namviet_heli_lost(x){
    local explosion_x = Entities.FindByName(null,"maker_explosion_x");
    local heli = Entities.FindByName(null,"namviet_heli_"+x.tostring());
    explosion_x.SpawnEntityAtLocation(heli.GetOrigin(),Vector(0,0,0));
    explosion_x.SpawnEntityAtLocation(heli.GetOrigin()+Vector(0,256,0), Vector(0,0,0));
    explosion_x.SpawnEntityAtLocation(heli.GetOrigin()+Vector(0,-256,0), Vector(0,0,0));
    EntFireByHandle(heli,"Kill","",0,"","");
    namviet_count++;
    if(namviet_count==1)Chat(lore_prefix + TextColor.Legendary + "shit!!!! we lost half the fucking team!!");
    if(namviet_count==2)Chat(lore_prefix + TextColor.Legendary + "oh my god - we are so fucked!!");
}

function check_if_humans_suck(){
    local trigger = Entities.FindByName(null,"random_p2_trigger_1");
    if(trigger!=null){
        for (local player = null; player = Entities.FindByClassname(player, "player");){
            if(player.GetTeam()==3){
                EntFireByHandle(player, "SetHealth",0, 0, "", "");
            }
        }
    }
}

//Lore

//ScriptPrintMessageChatAll("Test");
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
}
*/

// *********** lore messages
::queue<-0;
::lore_prefix<-TextColor.Location + "captain: ";
::snirby_prefix<-TextColor.Immortal + "snirby: ";
::m1_lore<-{
	[0] = TextColor.Red + "mission one: " + TextColor.Legendary + "diddlecore island",
    [1] = TextColor.Legendary + "head up the beach and defend for the crewmates hunting for treasure in the cave",
    [2] = TextColor.Legendary + "there must be a way to open the portal here",
    [3] = TextColor.Legendary + "that's it! sync the log pose to get this open, everyone else hold the line",
    [4] = TextColor.Legendary + "we better not doorhug here, let's get back to the tree and wait for the portal to open",
    [5] = TextColor.Legendary + "go go go! into the portal",
    [6] = TextColor.Legendary + "the explosives expert planted c4, stay away from the rock!",
    [7] = TextColor.Legendary + "huh, this looks just like serpenis island!",
    [8] = TextColor.Legendary + "i know what i said... it WAS serpenis island. either way, look for a way to open the door",
    [9] = TextColor.Legendary + "alright, more c4 - classic! stay the fuck back!",
    [10] = TextColor.Legendary + "i remember these souls from gorbino's quest, carefully use the low grav to go free it",
    [11] = TextColor.Legendary + "*sniff sniff* there is another restless soul around here",
    [12] = TextColor.Legendary + "omg hey frampt from dark souls! ... oh he is sleeping, let's not bother him",
    [13] = TextColor.Legendary + "there has to be a way to open the diddlecore church, look for a lever",
    [14] = TextColor.Legendary + "keep holding so our crewmates can open the gate from within the church of diddlecore",
    [15] = TextColor.Legendary + "up there! the hot air balloons will surely lead the way. look for something to lower them",
    [16] = TextColor.Legendary + "here they come! look for something aboard them that might continue our voyage",
    [17] = TextColor.Legendary + "oh shit! that's one big ass crow, i think he'll finish the bridge. we must hold until then!",
    [18] = TextColor.Legendary + "so this is the legendary diddlecore experience! we must prevail! cover your crewmates!",
    [19] = TextColor.Legendary + "watch out - don't get eaten!",
    [20] = TextColor.Legendary + "what's next? who is the captain of this nefarious crew?",
    [21] = TextColor.Legendary + "it's dickbeard!!! we are totally fucked! but we must believe to achieve, some of you, cover the flight-flight fruit users!",
    [22] = TextColor.Legendary + "we've defeated dickbeard and now his " + TextColor.Red + "12 DEVIL FRUITS" + TextColor.Legendary + " belong to us!"
}

::m2_lore<-{
    [0] = TextColor.Red + "mission two: " + TextColor.Legendary + "grand line x",
    [1] = TextColor.Legendary + "think of it like the autistic brother of the real grand line",
    [2] = TextColor.Legendary + "let's go crew, traverse the trains, don't fall off!",
    [3] = TextColor.Legendary + "if we free the resting souls here, they might open the doors for us",
    [4] = TextColor.Legendary + "the soul of the conductor is stuck in the sisyphus loop - time the jump and free him, everyone else cover your crew!",
    [5] = TextColor.Legendary + "move out! the mako energy here is unstable, we might get split up, whatever you do, just stick close!",
    [6] = TextColor.Legendary + "trigger both helis, we'll regroup then!",
    [7] = TextColor.Legendary + "into the portal - go go go!",
    [8] = TextColor.Legendary + "alright guys, take a breather - we'll have to rush to the rocket!",
    [9] = TextColor.Legendary + "you won't be able to hear when the door open, rush to the base!",
    [10] = TextColor.Legendary + "we need to head down below, go through the vent",
    [11] = TextColor.Legendary + "mako generator power failure - reboot required",
    [12] = TextColor.Legendary + "mako generator reset successful - power online",
    [13] = TextColor.Legendary + "alright, we'll blow through the door, stand back!",
    [14] = TextColor.Legendary + "find a bomb - we'll need to blow this next door down",
    [15] = TextColor.Legendary + "find the button to open these blast doors, the alien leader roomtars should be close",
    [16] = TextColor.Legendary + "shoot the door to open it! it'll keep trying to close, we have to outdamage it",
    [17] = TextColor.Legendary + "it's rootmars! kill him! you have to shoot the brain!!",
    [18] = TextColor.Legendary + "we need to get out of here quick, find the trigger for the next doors, we need to get to the upper level of the ship",
    [19] = TextColor.Legendary + "take the booster up! try and hold the exit if you can while we check the area",
    [20] = TextColor.Legendary + "i don't have a good feeling about this...",
    [21] = TextColor.Legendary + "destroy the xanax, it's powering the femboy spiders!",
    [22] = TextColor.Legendary + "move it! we gotta get out of here!",
    [23] = TextColor.Legendary + "fuck me, more of this? shoot these doors down, the more the merrier, we've got to hold for our crew opening the doors!",
    [24] = TextColor.Legendary + "shit! we'll need to split here, keep moving forwards, we need to open the doors to the predator reactor",
    [25] = TextColor.Legendary + "this is it!!! we have to hold here while someone goes up and activates the bomb",
    [26] = TextColor.Legendary + "the ship is going to fall apart, keep holding!!!!",
    [27] = TextColor.Legendary + "rootmars won't let us go alive, we've go to kill him!!!! for our grandline journey, we must prevail!"
}

::m3_lore<-{
	[0] = TextColor.Immortal + "longus dongus: " + TextColor.Legendary + "thanks for playing our map!",
    [1] = TextColor.Immortal + "neox35725: " + TextColor.Legendary + "no mames, si que trabajamos duro en esto!",
    [2] = TextColor.Immortal + "longus dongus: " + TextColor.Legendary + "we'll see you all on source2, for now, this is our last map",
    [3] = TextColor.Immortal + "neox35725: " + TextColor.Legendary + "muchas gracias a todos los mappers que nos permitieron usar las cosas de sus mapas",
    [4] = TextColor.Immortal + "longus dongus: " + TextColor.Legendary + "let's continue to make fond memories on csgo and in the years ahead on cs2!",  
    [5] = TextColor.Immortal + "neox35725: " + TextColor.Legendary + "muchas pendejos, vote westersand bunch of laserfaggers server",
    [6] = TextColor.Immortal + "longus dongus: " + TextColor.Legendary + "this raftel may be fake, but that thing you've been looking for must be here somewhere...",
    [7] = TextColor.Immortal + "longus dongus: " + TextColor.Legendary + "welcome to boobies!!! WE HAVE TO FUCKING HOLD, THIS IS OUR ONE SHOT TO ENJOY THE BOOBIES!"    
}

::snirby<-{
    [0] = TextColor.Legendary + "sup dude. you should go talk to my bro downstairs. if you're thirsty i'm sure you'll find what you're looking for.",
    [1] = TextColor.Legendary + "anyways, i assume my bro upstairs sent you. Well, what do you want? do you know the password?",
    [2] = TextColor.Legendary + "haha, nice. i see you're a man of culture. here, check this out - welcome to my memecave! this should distract the zombies for a bit",
    [3] = TextColor.Legendary + "nice try bozo, but that's not the password. you'll never make it here in the grandline!",
    [4] = TextColor.Legendary + "well dudes, too bad, i got to go. good luck on the journey.",
    [5] = TextColor.Legendary + "sup dude. i see you made it this far. it'll be tough... here, take these, i don't need 'em anymore",
    [6] = TextColor.Legendary + "good luck goonbros...",
    [7] = TextColor.Legendary + "sup dude. my vending machines are a little bit autistic, be careful with them..."
}

::passwords<-["shellbert thighs",
    "vauff feet",
    "luffaren toes",
    "russian head",
    "hardye eyes",
    "m4dara eyebrows",
    "soft serve mouth",
    "hichatu nose",
    "heat death of the universe"];

::quest_done<-false;
function snirby_quest_start(){
    ::VS.ListenToGameEvent( "player_say", function(event){
        local player = VS.GetPlayerByUserid( event.userid );
        if (!player.IsValid() || player==null){
            return;
        }
        local txt = event.text.tolower();
        foreach(password in passwords){
            if(txt==password){
                snirby_lore(2);
                snirby_quest();
                quest_done<-true;
                return;
            }
        }
        snirby_lore(3);
    }.bindenv(this),"player_say_snirby_quest",0);
}

function snirby_quest_stop(){
    if(quest_done==true)return;
    else{
        snirby_lore(4);
        EntFire("snirby_2","FadeAndKill","",5,"");
        ::VS.StopListeningToAllGameEvents("player_say_snirby_quest");
        snirby_sfx_stop();
    }
}

vending_machine_model<-"models/longus_aaa/vending_machine_longus.mdl";
vm_foreskins<-6;
vm_foreskins_coomer<-12;
function snirby_quest(){
    local location = Entities.FindByName(null,"snirby_2").GetOrigin();
    ::Sound("sfx/heat_death.mp3",location,null,0,0.05,100,10,null);
    local i=RandomInt(1,vm_foreskins);
    for (local vending_machine = null; vending_machine = Entities.FindByModel(vending_machine, vending_machine_model.tostring());){
        if(vending_machine.GetName().find("mars_vending_machines")!=null){
            EntFireByHandle(vending_machine, "Skin", i, 0, "", "");
            i++;
            if(i>vm_foreskins)i=1;
        }
    }    
    ::VS.StopListeningToAllGameEvents("player_say_snirby_quest");
}

function lore(mission,index){
    if(mission==1){
        Chat(lore_prefix + m1_lore[index]);
    }
    else if(mission==2){
        Chat(lore_prefix + m2_lore[index]);
    }
    else if(mission==3){
        Chat(m3_lore[index]);
    }
}

function snirby_lore(index){
    Chat(snirby_prefix + snirby[index]);
}

::one_piece<-"the one piece is real";
::dandy<-"boobies";
::sfx_one_piece<-"sfx/whitebeard-one_piece_is_real.mp3";
::sfx_demon_inside_me<-"sfx/touch_the_demon_inside_me.mp3";
::sfx_mistral<-"sfx/and_it_will_come.mp3";
::sfx_firekeeper<-["sfx/firekeeper_1.mp3","sfx/firekeeper_2.mp3"];
::sfx_meat<-["sfx/luffy_meat_1.mp3","sfx/luffy_meat_2.mp3"];
::sfx_nami<-"sfx/one_piece_namiswan.mp3";
::sfx_surprised<-"sfx/one_piece_surprised.mp3";
::sfx_tifa<-"sfx/seph_onlythechosen.mp3";
::sfx_elden_ring<-"sfx/uoh_elden_ring.mp3";
::sfx_faye<-"sfx/cowboy_bebop_tank.mp3";
::sfx_opm<-"sfx/opm_the_hero.mp3";
::sfx_lilith<-"sfx/borderlands_lilith.mp3";
::sfx_sailors<-"sfx/sailor_moon.mp3";
::sfx_samus<-"sfx/phendrana_drifts.mp3";
::sfx_motoko<-"sfx/from_the_rooftop.mp3";
::sfx_shego<-"sfx/shego_theme.mp3";
::sfx_dandy<-["sfx/dandy_boobies_1.mp3",
    "sfx/dandy_boobies_2.mp3",
    "sfx/dandy_boobies_3.mp3",
    "sfx/dandy_boobies_4.mp3",
    "sfx/dandy_boobies_4.mp3",
    "sfx/dandy_boobies_5.mp3",
    "sfx/dandy_boobies_6.mp3",
    "sfx/dandy_boobies_7.mp3",
    "sfx/dandy_boobies_8.mp3",
    "sfx/dandy_boobies_10.mp3",    
    "sfx/dandy_boobies_11.mp3",    
    "sfx/dandy_boobies_12.mp3"];
::booba_doors<-["theater_door_nami_1",
    "theater_door_nami_2",
    "theater_door_faye",
    "theater_door_lilith",
    "theater_door_ranni",
    "theater_door_melina",
    "theater_door_firekeeper",
    "theater_door_maiden",
    "theater_door_yamato",
    "theater_door_boa_1",
    "theater_door_boa_2",
    "theater_door_nico",
    "theater_door_tifa",
    "theater_door_mistral",    
    "theater_door_opm",
    "theater_door_motoko",
    "theater_door_shego",
    "theater_door_sailors",        
    "theater_door_samus"];
::booba_doors_timer<-null;


function booba_doors_start(){
    booba_doors_timer<-VS.Timer(false,5,function(){
        if(booba_doors.len()==0){
            booba_doors_timer.Destroy();
            return;
        }
        local index = RandomInt(0,booba_doors.len()-1);
        local door = booba_doors[index];
        booba_doors.remove(index);
        local door_ent = Entities.FindByName(null,door);
        if(door_ent==null)return;
        if(door.find("maiden")>0){
            ::Sound(sfx_demon_inside_me,door_ent.GetOrigin(),null,9999,0.05,100,10,null); 
            EntFireByHandle(door_ent, "Open", "", 0, "", "");
        }        
        if (door.find("mistral")>0){
            ::Sound(sfx_mistral,door_ent.GetOrigin(),null,9999,0.05,100,10,null); 
            EntFireByHandle(door_ent, "Open", "", 0, "", "");
        }      
        if (door.find("firekeeper")>0){
            ::Sound(sfx_firekeeper[0],door_ent.GetOrigin(),null,9999,0.05,100,10,null);
            VS.EventQueue.AddEvent(Sound,2.5,[this,sfx_firekeeper[1],door_ent.GetOrigin(),null,9999,0.05,100,10,null]);
            EntFireByHandle(door_ent, "Open", "", 0, "", "");
        }     
        if (door.find("boa")>0 || door.find("yamato")>0 || door.find("nico")>0){
            ::Sound(sfx_meat[RandomInt(0,sfx_meat.len()-1)],door_ent.GetOrigin(),null,9999,0.05,100,10,null);
            EntFireByHandle(door_ent, "Open", "", 0, "", "");
        }   
        if (door.find("nami")>0){
            //sfx(sfx_meat[RandomInt(0,sfx_meat.len()-1)],door_ent.GetOrigin(),null,0,0.05,100,10);
            ::Sound(sfx_nami,door_ent.GetOrigin(),null,9999,0.05,100,10,null);
            EntFireByHandle(door_ent, "Open", "", 0, "", "");
        }   
        if (door.find("tifa")>0){
            ::Sound(sfx_tifa,door_ent.GetOrigin(),null,9999,0.05,100,10,null);
            EntFireByHandle(door_ent, "Open", "", 0, "", "");             
        }
        if (door.find("ranni")>0 || door.find("melina")>0){
            ::Sound(sfx_elden_ring,door_ent.GetOrigin(),null,9999,0.05,100,10,null);
            EntFireByHandle(door_ent, "Open", "", 0, "", "");  
        }
        if (door.find("faye")>0){
            ::Sound(sfx_faye,door_ent.GetOrigin(),null,9999,0.05,100,10,null);
            EntFireByHandle(door_ent, "Open", "", 0, "", "");               
        }
        if(door.find("opm")>0){
            ::Sound(sfx_opm,door_ent.GetOrigin(),null,9999,0.05,100,10,null);
            EntFireByHandle(door_ent, "Open", "", 0, "", "");     
        }
        if(door.find("lilith")>0){
            ::Sound(sfx_lilith,door_ent.GetOrigin(),null,9999,0.05,100,10,null);
            EntFireByHandle(door_ent, "Open", "", 0, "", "");     
        }
        if(door.find("sailors")>0){
            ::Sound(sfx_sailors,door_ent.GetOrigin(),null,9999,0.05,100,10,null);
            EntFireByHandle(door_ent, "Open", "", 0, "", "");     
        }  
        if(door.find("samus")>0){
            ::Sound(sfx_samus,door_ent.GetOrigin(),null,9999,0.05,100,10,null);
            EntFireByHandle(door_ent, "Open", "", 0, "", "");     
        }  
        if(door.find("motoko")>0){
            ::Sound(sfx_motoko,door_ent.GetOrigin(),null,9999,0.05,100,10,null);
            EntFireByHandle(door_ent, "Open", "", 0, "", "");     
        }   
        if(door.find("shego")>0){
            ::Sound(sfx_shego,door_ent.GetOrigin(),null,9999,0.05,100,10,null);
            EntFireByHandle(door_ent, "Open", "", 0, "", "");     
        }                                          
        else{
            EntFireByHandle(door_ent, "Open", "", 0, "", ""); 
        }
    });
}

::op_girls<-false;
function one_piece_start(){
    ::VS.ListenToGameEvent( "player_say", function(event){
        local player = VS.GetPlayerByUserid( event.userid );
        if (!player.IsValid() || player==null){
            return;
        }
        local txt = event.text.tolower();
        if (txt == one_piece){
            //::Sound(sfx_one_piece,Vector(0,0,15),player,10000,0.05,100,10,null); 
            ::Sound(sfx_one_piece,player.GetOrigin()+Vector(0,0,15),null,10000,0.05,100,10,null); 
            if(op_girls==false){
                EntFire("the_one_piece","Toggle","",0,"");
                EntFire("game_over","Break","",0,"");
                op_girls=true;
            }
            return;
        }
        if (txt==dandy){
            //::Sound(sfx_dandy[RandomInt(0,sfx_dandy.len()-1)],Vector(0,0,15),player,10000,0.05,100,10,null);
            ::Sound(sfx_dandy[RandomInt(0,sfx_dandy.len()-1)],player.GetOrigin()+Vector(0,0,15),null,10000,0.05,100,10,null);
        }
    }.bindenv(this),"player_say_one_piece",0);
}

function sfx_op_surprised(){
    if(!activator)return;
    //::Sound(sfx_surprised,Vector(0,0,15),activator,10000,0.05,100,10,null);
    ::Sound(sfx_surprised,activator.GetOrigin()+Vector(0,0,15),null,10000,0.05,100,10,null);
}

::implant_sfx<-"sfx/cruelty_squad_implant.mp3";
function snirby_3_quest(){
    local item_maker = Entities.FindByName(null,"item_diddle_cannon");
    local location = Entities.FindByName(null,"snirby_3").GetOrigin() + Vector(0,0,32);
    local offset = Vector(0,128,0);
    VS.EventQueue.AddEvent(spawn_heal,2,[this,location+offset]);
    VS.EventQueue.AddEvent(spawn_item,2,[this,item_maker,location-offset]);
    VS.EventQueue.AddEvent(Sound,2,[this,implant_sfx,location,null,9999,0.05,100,10,null]); 
}

::snirby_sfx_timer<-null;
::snirby_number<-0;
::snirby_sfx_num<-1;
::snirby_sfx_max<-5;
function snirby_sfx(x){
    snirby_number=x;
    snirby_sfx_num = 1;
    local location = Entities.FindByName(null,"snirby_" + snirby_number.tostring()).GetOrigin();
    ::Sound("sfx/cruelty_squad-snirby_ambient_" + snirby_sfx_num.tostring() + ".mp3",location,null,9999,0.05,100,10,null);
    snirby_sfx_num++;  
    snirby_sfx_timer<-VS.Timer(false,4,function(){
        local location = Entities.FindByName(null,"snirby_" + snirby_number.tostring()).GetOrigin();
        ::Sound("sfx/cruelty_squad-snirby_ambient_" + snirby_sfx_num.tostring() + ".mp3",location,null,9999,0.05,100,10,null);  
        snirby_sfx_num++;
        if(snirby_sfx_num>snirby_sfx_max){
            snirby_sfx_num = 1;
        }
    })
}

function snirby_sfx_stop(){
    if (snirby_sfx_timer!=null)snirby_sfx_timer.Destroy();
    snirby_sfx_timer = null;
}

::aaa_magic<-self;
::player_models<-["models/player/custom_player/longus/mai_shiranui/mai_shiranui.mdl","models/player/custom_player/longus/cruelty_squad/crusguy.mdl"];
::player_models_sfx<-["sfx/mslug3_oh_big.mp3","sfx/cruelty_squad_implant.mp3"];
::player_models_skins<-[3,1];
::player_models_vectors<-[Vector(-4232,8960,-2164),Vector(-4472,8960,-2164)];
::funny_velocity<-Vector(0,700,300);
::mai_count<-0;
::mai_max<-4;
function soldier_select(x){
    if(!activator || activator==null || !activator.IsValid() || activator.GetHealth()>999)return;
    if(x==0 && mai_count>=mai_max){
        activator.SetOrigin(player_models_vectors[x]);
        activator.SetVelocity(funny_velocity);
        //::Sound(sfx_surprised,Vector(0,0,15),activator,9999,0.05,100,10,null); 
        ::Sound(sfx_surprised,activator.GetOrigin()+Vector(0,0,15),null,9999,0.05,100,10,null); 
        return;
    }
    if(x==0)mai_count++;
    ::aaa_magic.PrecacheModel(player_models[x]);
    activator.SetModel(player_models[x]);
    //::Sound(player_models_sfx[x],Vector(0,0,15),activator,9999,0.05,100,10,null);  
    ::Sound(player_models_sfx[x],activator.GetOrigin()+Vector(0,0,15),null,9999,0.05,100,10,null); 
    if(x==0){
        EntFireByHandle(activator, "Skin", mai_count-1, 0, activator, activator);
    }
    else{
        EntFireByHandle(activator, "Skin", RandomInt(0,player_models_skins[x]), 0, activator, activator);
    }
    activator.SetOrigin(player_models_vectors[x]);
    activator.SetVelocity(funny_velocity);
}

::predator_x<-0;
::teleport_sfx<-"sfx/mslug3_teleport.mp3";
::predator_dest<-[Vector(7798,-4412,11250),Vector(7480,-3916,11244)];
function predator_split(){
    if(!activator || activator==null || !activator.IsValid())return;
    //::Sound(teleport_sfx,Vector(0,0,15),activator,9999,0.05,100,10,null); 
    ::Sound(teleport_sfx,activator.GetOrigin()+Vector(0,0,15),null,9999,0.05,100,10,null); 
    activator.SetOrigin(predator_dest[predator_x]);
    if(predator_x==0){
        activator.SetAngles(0.0,-90.0,0.0);
        predator_x=1;
    }
    else if(predator_x==1)predator_x=0;
}

function predator_teleport(){
    if(!activator || activator==null || !activator.IsValid())return;
    activator.SetOrigin(Vector(7894,-3905,11425));
}

function vm_booba(){
    if(caller==null)return;
    EntFireByHandle(caller,"Skin",RandomInt(7,vm_foreskins_coomer),0,"",caller);
}

function sfx_chime(){
    ::Sound("sfx/mslug3_chime.mp3",Vector(0,0,0),null,0,0.05,100,10,null);
}

function rootmars_door_tp(){
    if(!activator || activator==null || !activator.IsValid())return;
    activator.SetOrigin(Entities.FindByName(null,"m2_zm_tp_7_dest").GetOrigin());
}

::mars_stuck<-Vector(15118,6010,12720);
function vm_stuck(){
    if(!activator || activator==null || !activator.IsValid())return;
    if(activator.GetTeam()==3)activator.SetOrigin(mars_stuck);
}

function vm_stuck_sfx(){
    if(!activator || activator==null || !activator.IsValid())return;
    //::Sound(sfx_surprised,Vector(0,0,15),activator,10000,0.05,100,10,null);
    ::Sound(sfx_surprised,activator.GetOrigin()+Vector(0,0,15),null,10000,0.05,100,10,null);
}

::rootmars_door_ct_count<-0;
function rootmars_door_scale(){
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player.GetTeam()==3){
            rootmars_door_ct_count++;
        }
    } 
    rootmars_door_buff /= rootmars_door_ct_count;
}

::predator_ship_door_ct_count<-0;
function predator_ship_door_scale(){
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player.GetTeam()==3){
            predator_ship_door_ct_count++;
        }
    }
    predator_ship_door_buff /= predator_ship_door_ct_count;
    //Chat(predator_ship_door_buff);
}

::rootmars_door_default_origin<-Entities.FindByName(null,"rootmars_door").GetOrigin();
::rootmars_door_buff<-40.0;
function rootmars_door(){
    local rootmars_door = Entities.FindByName(null,"rootmars_door");
    rootmars_door.SetOrigin(rootmars_door.GetOrigin()+Vector(0,0,-rootmars_door_buff));
    if(rootmars_door.GetOrigin().z<rootmars_door_default_origin.z){
        EntFireByHandle(rootmars_door, "Close", "", 0, "", "");
    }
    if(RandomInt(0,100)>95)::Sound("sfx/mslug3_richochet.mp3",rootmars_door.GetOrigin(),null,6666,0.1,RandomInt(90,110),10,null);
}

::predator_ship_door_z<-400.0;
::predator_ship_door_start<-null;
::predator_ship_door_buff<-10.0;
function predator_ship_door(x){
    local predator_ship_door = Entities.FindByName(null,"predator_ship_shoot_me_"+x.tostring());
    if(predator_ship_door_start==null){
        predator_ship_door_start=predator_ship_door.GetOrigin().z;
    }
    predator_ship_door.SetOrigin(predator_ship_door.GetOrigin()+Vector(0,0,-predator_ship_door_buff));
    if(predator_ship_door.GetOrigin().z<predator_ship_door_start-predator_ship_door_z){
        EntFireByHandle(predator_ship_door, "Break", "", 0, "", "");
    }
    if(RandomInt(0,100)>95)::Sound("sfx/mslug3_richochet.mp3",predator_ship_door.GetOrigin(),null,6666,0.1,RandomInt(90,110),10,null);
}

function heli_leave(){
    Chat(lore_prefix + TextColor.Legendary + "GET TO THE CHOPPA!!!!!!!!!");
    ::Sound("sfx/gettothechopper.mp3",Vector(0,0,0),null,0,1,100,10,null);
}

// *********** player_spawn event handler
::targetname_prefix<-"crewmate_";
::VS.ListenToGameEvent("player_spawn",function(event){
    local player = VS.GetPlayerByUserid(event.userid);
    if (player==null || !player.IsValid())return;
    if (!player.GetName().find(targetname_prefix)){
        VS.SetName(player,targetname_prefix+event.userid.tostring());
    }   
}.bindenv(this), "player_spawn_async", 0);

function cstat_funny(){
    if(!activator || activator==null || !activator.IsValid())return;
    local location = Entities.FindByName(null,"minas_zm_yeet").GetOrigin();
    activator.SetOrigin(location);
}

function kill_vm(){
    if(!activator || activator==null || !activator.IsValid())return;
    if(activator.GetModelName()==vending_machine_model)EntFireByHandle(activator, "Kill", "", 0, "", "");
}

::zm_mako_prefix<-"zm_mako_infused_";
::mako_infused_count<-0;
function zm_mako_infused(){
    if(activator!=null && activator.IsValid()){
        VS.SetName(activator,zm_mako_prefix+mako_infused_count.tostring());
        mako_infused_count++;
    }
}

function zm_unslow(){
    if(!activator || activator==null || !activator.IsValid())return;
    if(activator.GetName().find(zm_mako_prefix)){
        EntFire("methamphetamine","ModifySpeed",mako_zm_speed,0,activator);
    }
    else{
        EntFire("methamphetamine","ModifySpeed",1,0,activator);
    }
}

function namviet_safespot(){
    local safespot = Entities.FindByName(null,"repeat_killer_safespot").GetOrigin();
    activator.SetOrigin(safespot);
}

function use_ultima(){
    local h = null;
    local weapon = Entities.FindByName(null,"item_ultima_cross");
    boss_ultima();
	while(null != (h = Entities.FindInSphere(h,weapon.GetOrigin(),1000))){
		if(h.GetTeam() == 2 && h.GetHealth() > 0 && h.IsValid()){
            local safespot = Entities.FindByName(null,"repeat_killer_safespot").GetOrigin();
            h.SetOrigin(safespot);
			ultima_kill();
			return;
		}
	}
    
}

function spider_materia(){
    ultima_is_kill=true;
    VS.EventQueue.AddEvent(spider_materia_listen_stop,1,this);
}

function spider_materia_listen_stop(){
    ultima_is_kill=false;
}

//--------------------------------------------------------------------------------------------------------------------\\
//--------------------------------------------------------------------------------------------------------------------\\
//--------------------------------------------------------------------------------------------------------------------\\
//--------------------------------------------------------------------------------------------------------------------\\
//----------------SCALING SCALING CTRL F SCALING SCALE FUCK FUCK FUCK CUNNY HAHAHAHHA---------------------------------\\
//--------------------------------------------------------------------------------------------------------------------\\
//--------------------------------------------------------------------------------------------------------------------\\
//--------------------------------------------------------------------------------------------------------------------\\
//--------------------------------------------------------------------------------------------------------------------\\
//DICKBEARD HP
captain_dickbeard_hp<-10000;
captain_dickbeard_hp_per_ct<-2000;
//ROOTMARS HP
rootmars_phase_1_hp<-10000;
rootmars_phase_1_hp_per_ct<-1000;
//XANAX HP
xanax_hp<-50000;
xanax_hp_per_ct<-2000;
//ROOTMARS HP
rootmars_phase_2_hp<-20000;
rootmars_phase_2_hp_per_ct<-1000;
//--------------------------------------------------------------------------------------------------------------------\\
//--------------------------------------------------------------------------------------------------------------------\\
//--------------------------------------------------------------------------------------------------------------------\\

//materia damage values for bosses
//fake rootmars, xanax, rootmars
//rootmars_phase_1_hp, xanax_hp, rootmars_phase_2_hp
::boss_dmg_ultima<-[rootmars_phase_1_hp*1.5,xanax_hp*1.5,rootmars_phase_2_hp*1.5];
::boss_dmg_gravity<-[rootmars_phase_1_hp/4,xanax_hp/4,rootmars_phase_2_hp/4];
::boss_dmg_bio<-[rootmars_phase_1_hp/4,xanax_hp/4,rootmars_phase_2_hp/4];
::boss_dmg_fire<-[rootmars_phase_1_hp/4,xanax_hp/4,rootmars_phase_2_hp/4];
::boss_dmg_electro<-[rootmars_phase_1_hp/4,xanax_hp/4,rootmars_phase_2_hp/4];
::boss_dmg_water<-[rootmars_phase_1_hp/4,xanax_hp/4,rootmars_phase_2_hp/4];
::boss_dmg_ice<-[rootmars_phase_1_hp/4,xanax_hp/4,rootmars_phase_2_hp/4];
//--------------------------------------------------------------------------------------------------------------------\\
//--------------------------------------------------------------------------------------------------------------------\\
//--------------------------------------------------------------------------------------------------------------------\\

::materia_listen_rmp1<-false;
::materia_listen_xanax<-false;
::materia_listen_rmp2<-false;

function boss_ultima(){
    local hitbox = null;
    if(materia_listen_rmp1==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_1_hitbox");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_ultima[0],0,"","");
    }
    if(materia_listen_xanax==true){
        hitbox = Entities.FindByName(null,"xanax_pill");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_ultima[1],0,"","");
        spider_materia();
    }
    if(materia_listen_rmp2==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_2_hitbox");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_ultima[2],0,"","");
    }
}

function boss_ice(){
    local hitbox = null;
    if(materia_listen_rmp1==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_1_hitbox");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_ice[0],0,"","");
    }
    if(materia_listen_xanax==true){
        hitbox = Entities.FindByName(null,"xanax_pill");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_ice[1],0,"","");
        spider_materia();
    }
    if(materia_listen_rmp2==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_2_hitbox");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_ice[2],0,"","");
    }
}

function boss_electro(){
    local hitbox = null;
    if(materia_listen_rmp1==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_1_hitbox");
        EntFire("extra_electro_fx_2*","Start","",0,"");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_electro[0],0,"","");
    }
    if(materia_listen_xanax==true){
        hitbox = Entities.FindByName(null,"xanax_pill");
        EntFire("extra_electro_fx_2*","Start","",0,"");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_electro[1],0,"","");
        spider_materia();
    }
    if(materia_listen_rmp2==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_2_hitbox");
        EntFire("extra_electro_fx_2*","Start","",0,"");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_electro[2],0,"","");
    }
}

function boss_gravity(){
    local hitbox = null;
    if(materia_listen_rmp1==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_1_hitbox");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_gravity[0],0,"","");
    }
    if(materia_listen_xanax==true){
        hitbox = Entities.FindByName(null,"xanax_pill");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_gravity[1],0,"","");
        spider_materia();
    }
    if(materia_listen_rmp2==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_2_hitbox");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_gravity[2],0,"","");
    }
}

function boss_water(){
    local hitbox = null;
    if(materia_listen_rmp1==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_1_hitbox");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_water[0],0,"","");
    }
    if(materia_listen_xanax==true){
        hitbox = Entities.FindByName(null,"xanax_pill");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_water[1],0,"","");
        spider_materia();
    }
    if(materia_listen_rmp2==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_2_hitbox");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_water[2],0,"","");
    }
}

function boss_bio(){
    local hitbox = null;
    if(materia_listen_rmp1==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_1_hitbox");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_bio[0],0,"","");
    }
    if(materia_listen_xanax==true){
        hitbox = Entities.FindByName(null,"xanax_pill");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_bio[1],0,"","");
        spider_materia();
    }
    if(materia_listen_rmp2==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_2_hitbox");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_bio[2],0,"","");
    }
}

function boss_fire(){
    local hitbox = null;
    if(materia_listen_rmp1==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_1_hitbox");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_fire[0],0,"","");
    }
    if(materia_listen_xanax==true){
        hitbox = Entities.FindByName(null,"xanax_pill");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_fire[1],0,"","");
        spider_materia();
    }
    if(materia_listen_rmp2==true){
        hitbox = Entities.FindByName(null,"rootmars_phase_2_hitbox");
        EntFireByHandle(hitbox,"RemoveHealth",boss_dmg_fire[2],0,"","");
    }
}

function ultima_kill(){
    local zm = null;
    local weapon = Entities.FindByName(null,"item_ultima_cross");    
	while(null != (zm = Entities.FindInSphere(zm,weapon.GetOrigin(),1000))){
		if(zm.GetTeam() == 2 && zm.GetHealth() > 0 && zm.IsValid()){
            EntFireByHandle(zm,"SetHealth","-1",0.00,null,null);
		}
	}
}

function pickup_ultima(){
    if(ultima_used==true)return;
    if(activator==null || !activator || !activator.IsValid())return;
    local filter = Entities.FindByName(null,"filter_ultima");
    filter.__KeyValueFromString("filtername",activator.GetName());   
    handler_popup_nosound("ultima materia: has 1 use",activator);
    sfx_okay();
}

function pickup_earth(){
    if(max_earth==0)return;
    if(activator==null || !activator || !activator.IsValid())return;
    local filter = Entities.FindByName(null,"filter_earth");
    filter.__KeyValueFromString("filtername",activator.GetName());  
    handler_popup_nosound("earth materia: has "+max_earth.tostring()+" uses left",activator);
    sfx_okay();
}

function pickup_ice(){
    if(max_ice==0)return;
    if(activator==null || !activator || !activator.IsValid())return;
    local filter = Entities.FindByName(null,"filter_ice");
    filter.__KeyValueFromString("filtername",activator.GetName());    
    handler_popup_nosound("ice materia: has "+max_ice.tostring()+" uses left",activator);
    sfx_okay();
}

function pickup_electro(){
    if(max_electro==0)return;
    if(activator==null || !activator || !activator.IsValid())return;
    local filter = Entities.FindByName(null,"filter_electro");
    filter.__KeyValueFromString("filtername",activator.GetName());  
    handler_popup_nosound("electro materia: has "+max_electro.tostring()+" uses left",activator);  
    sfx_okay();
}

function pickup_wind(){
    if(max_fire==0)return;
    if(activator==null || !activator || !activator.IsValid())return;
    local filter = Entities.FindByName(null,"filter_wind");
    filter.__KeyValueFromString("filtername",activator.GetName());   
    handler_popup_nosound("wind materia: has "+max_wind.tostring()+" uses left",activator);  
    sfx_okay();
}

function pickup_fire(){
    if(max_fire==0)return;
    if(activator==null || !activator || !activator.IsValid())return;
    local filter = Entities.FindByName(null,"filter_fire");
    filter.__KeyValueFromString("filtername",activator.GetName());    
    handler_popup_nosound("fire materia: has "+max_fire.tostring()+" uses left",activator); 
    sfx_okay();
}

function pickup_gravity(){
    if(max_gravity==0)return;
    if(activator==null || !activator || !activator.IsValid())return;
    local filter = Entities.FindByName(null,"filter_gravity");
    filter.__KeyValueFromString("filtername",activator.GetName());  
    handler_popup_nosound("gravity materia: has "+max_gravity.tostring()+" uses left",activator);   
    sfx_okay();
}

function pickup_bio(){
    if(max_bio==0)return;
    if(activator==null || !activator || !activator.IsValid())return;
    local filter = Entities.FindByName(null,"filter_bio");
    filter.__KeyValueFromString("filtername",activator.GetName());    
    handler_popup_nosound("bio materia: has "+max_bio.tostring()+" uses left",activator); 
    sfx_okay();
}

function pickup_water(){
    if(max_water==0)return;
    if(activator==null || !activator || !activator.IsValid())return;
    local filter = Entities.FindByName(null,"filter_water");
    filter.__KeyValueFromString("filtername",activator.GetName());    
    handler_popup_nosound("water materia: has "+max_water.tostring()+" uses left",activator); 
    sfx_okay();
}

function pickup_mimic(){
    if(ultima_mimic==true)return;
    if(activator==null || !activator || !activator.IsValid())return;
    local filter = Entities.FindByName(null,"filter_mimic");
    filter.__KeyValueFromString("filtername",activator.GetName()); 
    handler_popup_nosound("mimic materia: infinite usage of previous materia or sacrifice for ultima",activator);    
    sfx_okay();
}

function pickup_barrier(){
    if(max_barrier==0)return;
    if(activator==null || !activator || !activator.IsValid())return;
    local filter = Entities.FindByName(null,"filter_barrier");
    filter.__KeyValueFromString("filtername",activator.GetName());  
    handler_popup_nosound("barrier materia: has "+max_barrier.tostring()+" uses left",activator);   
    sfx_okay();
}

function pickup_heal(){
    if(activator==null || !activator || !activator.IsValid())return;
    local filter = Entities.FindByName(null,"filter_heal");
    filter.__KeyValueFromString("filtername",activator.GetName());    
    handler_popup_nosound("heal materia: has infinite uses",activator); 
    sfx_okay();
}

::ice_start_time<-0;
::ice_end_time<-0;
::ice_time<-7;
::max_ice<-3;
function use_ice(is_mimic){
    sfx_ice(is_mimic);
    ice_start_time=Time();
    ice_end_time=ice_start_time+ice_time;
    boss_ice();
    //EntFire("extra_ice_trigger_3a*","Enable","",0,"");
    if(is_mimic==0){
        max_ice--;
        if(max_ice==2)EntFire("item_ice_cross","Skin",3,0,"");
        if(max_ice==1)EntFire("item_ice_cross","Skin",2,0,"");
        if(max_ice==0){
            EntFire("item_ice_cross","Disable","",0,"");
            EntFire("filter_ice","Kill","",1,"");
            EntFire("item_ice_cross","Kill","",1,"");
            EntFire("item_ice_btn","Kill","",1,"");
            EntFire("item_ice_fx","Kill","",1,"");
            EntFire("item_ice_maker","Kill","",0,"");
        }
    }       
}

::gravity_start_time<-0;
::gravity_end_time<-0;
::gravity_time<-7;
::max_gravity<-3;
function use_gravity(is_mimic){
    sfx_gravity(is_mimic);
    gravity_start_time=Time();
    gravity_end_time=gravity_start_time+gravity_time;
    boss_gravity();
    //EntFire("extra_gravity_trigger_3A*","Enable","",0,"");
    if(is_mimic==0){
        max_gravity--;
        if(max_gravity==2)EntFire("item_gravity_cross","Skin",3,0,"");
        if(max_gravity==1)EntFire("item_gravity_cross","Skin",2,0,"");
        if(max_gravity==0){
            EntFire("item_gravity_cross","Disable","",0,"");
            EntFire("filter_gravity","Kill","",1,"");
            EntFire("item_gravity_cross","Kill","",1,"");
            EntFire("item_gravity_btn","Kill","",1,"");
            EntFire("item_gravity_fx","Kill","",1,"");
            EntFire("item_gravity_maker","Kill","",1,"");
        }
    }
}

::bio_start_time<-0;
::bio_end_time<-0;
::bio_time<-12;
::max_bio<-3;
function use_bio(is_mimic){
    sfx_bio(is_mimic);
    bio_start_time=Time();
    bio_end_time=bio_start_time+bio_time;
    boss_bio();
    //EntFire("extra_bio_trigger_3*","Enable","",0,"");
    if(is_mimic==0){
        max_bio--;
        if(max_bio==2)EntFire("item_bio_cross","Skin",3,0,"");
        if(max_bio==1)EntFire("item_bio_cross","Skin",2,0,"");
        if(max_bio==0){
            EntFire("item_bio_cross","Disable","",0,"");
            EntFire("filter_bio","Kill","",1,"");
            EntFire("item_bio_cross","Kill","",1,"");
            EntFire("item_bio_btn","Kill","",1,"");
            EntFire("item_bio_fx","Kill","",1,"");
            EntFire("item_bio_maker","Kill","",0,"");
        }
    }
}

::max_electro<-9;
function use_electro(is_mimic){
    sfx_electro(is_mimic);
    boss_electro();
    if(is_mimic==0){
        max_electro--;
        if(max_electro==6)EntFire("item_electro_cross","Skin",3,0,"");
        if(max_electro==3)EntFire("item_electro_cross","Skin",2,0,"");
        if(max_bio==0){
            EntFire("item_electro_cross","Disable","",0,"");
            EntFire("filter_electro","Kill","",1,"");
            EntFire("item_electro_cross","Kill","",1,"");
            EntFire("item_electro_btn","Kill","",1,"");
            EntFire("item_electro_fx","Kill","",1,"");
            EntFire("item_electro_maker","Kill","",0,"");
            EntFire("item_electro_counter","Kill","",0,"");
        }
    }
}

::max_earth<-3;
function use_earth(is_mimic){
    sfx_earth(is_mimic);
    if(is_mimic==0){
        max_earth--;
        if(max_earth==2)EntFire("item_earth_cross","Skin",3,0,"");
        if(max_earth==1)EntFire("item_earth_cross","Skin",2,0,"");
        if(max_earth==0){
            EntFire("item_earth_cross","Disable","",0,"");
            EntFire("filter_earth","Kill","",1,"");
            EntFire("item_earth_cross","Kill","",1,"");
            EntFire("item_earth_btn","Kill","",1,"");
            EntFire("item_earth_fx","Kill","",1,"");
            EntFire("item_earth_maker","Kill","",0,"");
        }
    }
}

::max_barrier<-3;
function use_barrier(is_mimic){
    sfx_barrier(is_mimic);
    local maker_barrier = Entities.FindByName(null,"item_barrier_maker");
    if(is_mimic==1){
       maker_barrier = Entities.FindByName(null,"item_mimic_maker_barrier");
    }
    local cool_angles = Vector(0,maker_barrier.GetAngles().y,0);
    local y_opp = maker_barrier.GetAngles().y+180;
    maker_barrier.SpawnEntityAtLocation(maker_barrier.GetOrigin(), cool_angles);
    EntFire("extra_barrier_trigger_3b*","SetPushDirection","0 "+maker_barrier.GetAngles().y+" 0",0,"");
    EntFire("extra_barrier_trigger_3a*","SetPushDirection","0 "+y_opp+" 0",0,"");
    if(is_mimic==0){
        max_barrier--;
        if(max_barrier==2)EntFire("item_barrier_cross","Skin",3,0,"");
        if(max_barrier==1)EntFire("item_barrier_cross","Skin",2,0,"");
        if(max_barrier==0){
            EntFire("item_barrier_cross","Disable","",0,"");
            EntFire("filter_barrier","Kill","",1,"");
            EntFire("item_barrier_cross","Kill","",1,"");
            EntFire("item_barrier_btn","Kill","",1,"");
            EntFire("item_barrier_fx","Kill","",1,"");
            EntFire("item_barrier_maker","Kill","",0,"");
        }
    }
}

::max_fire<-3;
function use_fire(is_mimic){
    sfx_fire(is_mimic);
    boss_fire();
    if(is_mimic==0){
        max_fire--;
        if(max_fire==2)EntFire("item_fire_cross","Skin",3,0,"");
        if(max_fire==1)EntFire("item_fire_cross","Skin",2,0,"");
        if(max_fire==0){
            EntFire("item_fire_cross","Disable","",0,"");
            EntFire("filter_fire","Kill","",1,"");
            EntFire("item_fire_cross","Kill","",1,"");
            EntFire("item_fire_btn","Kill","",1,"");
            EntFire("item_fire_fx","Kill","",1,"");
            EntFire("item_fire_maker","Kill","",0,"");
        }
    }    
}

::max_water<-3;
function use_water(is_mimic){
    sfx_water(is_mimic);
    boss_water();
    if(is_mimic==0){
        max_water--;
        if(max_water==2)EntFire("item_water_cross","Skin",3,0,"");
        if(max_water==1)EntFire("item_water_cross","Skin",2,0,"");
        if(max_water==0){
            EntFire("item_water_cross","Disable","",0,"");
            EntFire("filter_water","Kill","",1,"");
            EntFire("item_water_cross","Kill","",1,"");
            EntFire("item_water_btn","Kill","",1,"");
            EntFire("item_water_fx","Kill","",1,"");
            EntFire("item_water_maker","Kill","",0,"");
        }
    }       
}

::max_wind<-3;
function use_wind(is_mimic){
    sfx_wind(is_mimic);
    if(is_mimic==0){
        max_wind--;
        if(max_wind==2)EntFire("item_wind_cross","Skin",3,0,"");
        if(max_wind==1)EntFire("item_wind_cross","Skin",2,0,"");
        if(max_wind==0){
            EntFire("item_wind_cross","Disable","",0,"");
            EntFire("filter_wind","Kill","",1,"");
            EntFire("item_wind_cross","Kill","",1,"");
            EntFire("item_wind_btn","Kill","",1,"");
            EntFire("item_wind_fx","Kill","",1,"");
            EntFire("item_wind_maker","Kill","",0,"");
        }
    }   
}

::max_heal<-99;
function use_heal(is_mimic){
    sfx_heal(is_mimic);
    if(is_mimic==0){
        max_heal--;
        if(max_heal==2)EntFire("item_heal_cross","Skin",3,0,"");
        if(max_heal==1)EntFire("item_heal_cross","Skin",2,0,"");
        if(max_heal==0){
            EntFire("item_heal_cross","Disable","",0,"");
            EntFire("filter_heal","Kill","",1,"");
            EntFire("item_heal_cross","Kill","",1,"");
            EntFire("item_heal_btn","Kill","",1,"");
            EntFire("item_heal_fx","Kill","",1,"");
            EntFire("item_heal_maker","Kill","",0,"");
        }
    }   
}

function ice(){
    if(activator==null || !activator || !activator.IsValid())return;
    if(activator.GetName().find(zm_mako_prefix)){
        EntFire("methamphetamine","ModifySpeed",mako_zm_speed,ice_end_time-Time(),activator);
    }
    else{
        EntFire("methamphetamine","ModifySpeed",1.00,ice_end_time-Time(),activator);
    }        
}

function gravity(){
    if(activator==null || !activator || !activator.IsValid())return;
    if(activator.GetName().find(zm_mako_prefix)){
        EntFire("methamphetamine","ModifySpeed",mako_zm_speed,gravity_end_time-Time(),activator);
    }
    else{
        EntFire("methamphetamine","ModifySpeed",1,gravity_end_time-Time(),activator);
    }    
}

function bio(){
    if(activator==null || !activator || !activator.IsValid())return;
    if(activator.GetName().find(zm_mako_prefix)){
        EntFire("methamphetamine","ModifySpeed",mako_zm_speed,bio_end_time-Time(),activator);
    }
    else{
        EntFire("methamphetamine","ModifySpeed",1,bio_end_time-Time(),activator);
    }    
}

//materia sfx - pass 0 for non-mimic, pass 1 for mimic
::ultima_used<-false;
::ultima_mimic<-false;
::snd_ultima<-["sfx/portal_open1_adpcm.mp3","kondik/mako/portal_beam_shoot4.mp3","kondik/mako/portal_beam_shoot6.mp3","kondik/mako/citadel_end_explosion2.mp3","luffaren/dd_s2.mp3","luffaren/dd_slam.mp3"];
function sfx_ultima(is_mimic){
    local weapon = "item_ultima_cross";
    ultima_used=true;
    if(is_mimic==1){
        weapon="item_mimic_cross";
        ultima_mimic=true;
    }
    local weapon_ent = Entities.FindByName(null,weapon);
    local weapon_origin = Vector(0,0,15);
    ::Sound(snd_ultima[0],weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);
    VS.EventQueue.AddEvent(Sound,5,[this,snd_ultima[1],weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null]);
    VS.EventQueue.AddEvent(Sound,7,[this,snd_ultima[0],weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null]);
    VS.EventQueue.AddEvent(Sound,10,[this,snd_ultima[2],weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null]);
    VS.EventQueue.AddEvent(Sound,13,[this,snd_ultima[1],weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null]);
    VS.EventQueue.AddEvent(Sound,13,[this,snd_ultima[2],weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null]);
    VS.EventQueue.AddEvent(Sound,16,[this,snd_ultima[0],weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null]);
    VS.EventQueue.AddEvent(Sound,18,[this,snd_ultima[4],weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null]);
    VS.EventQueue.AddEvent(Sound,19.9,[this,snd_ultima[5],weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null]);
    VS.EventQueue.AddEvent(Sound,20,[this,snd_ultima[3],weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null]);
}

function sfx_earth(is_mimic){
    local weapon = "item_earth_cross";
    if(is_mimic==1)weapon="item_mimic_cross";
    local weapon_ent = Entities.FindByName(null,weapon);
    local weapon_origin = Vector(0,0,15);
    ::Sound("luffaren/dd_slam.mp3",weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);
}

function sfx_gravity(is_mimic){
    local weapon = "item_gravity_cross";
    if(is_mimic==1)weapon="item_mimic_cross";
    local weapon_ent = Entities.FindByName(null,weapon);
    local weapon_origin = Vector(0,0,15);
    ::Sound("kondik/mako/portal_beam_shoot6.mp3",weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);   
    ::Sound("luffaren/dd_slam.mp3",weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);  
}

function sfx_ice(is_mimic){
    local weapon = "item_ice_cross";
    if(is_mimic==1)weapon="item_mimic_cross";
    local weapon_ent = Entities.FindByName(null,weapon);
    local weapon_origin = Vector(0,0,15);
    ::Sound("luffaren/dd_slam.mp3",weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);      
}

function sfx_barrier(is_mimic){
    local weapon = "item_barrier_cross";
    if(is_mimic==1)weapon="item_mimic_cross";
    local weapon_ent = Entities.FindByName(null,weapon);
    local weapon_origin = Vector(0,0,15);
    ::Sound("luffaren/dd_s4.mp3",weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);  
}

function sfx_fire(is_mimic){
    local weapon = "item_fire_cross";
    if(is_mimic==1)weapon="item_mimic_cross";
    local weapon_ent = Entities.FindByName(null,weapon);
    local weapon_origin = Vector(0,0,15);
    ::Sound("ambient/atmosphere/firewerks_burst_02.wav",weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null); 
    ::Sound("luffaren/dd_slam.mp3",weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);       
}

function sfx_water(is_mimic){
    local weapon = "item_water_cross";
    if(is_mimic==1)weapon="item_mimic_cross";
    local weapon_ent = Entities.FindByName(null,weapon);
    local weapon_origin = Vector(0,0,15);
    ::Sound("ambient/water/wave1.wav",weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);   
    ::Sound("luffaren/dd_slam.mp3",weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);        
}

function sfx_bio(is_mimic){
    local weapon = "item_bio_cross";
    if(is_mimic==1)weapon="item_mimic_cross";
    local weapon_ent = Entities.FindByName(null,weapon);
    local weapon_origin = Vector(0,0,15);
    ::Sound("kondik/mako/toxic_slime_gurgle7.mp3",weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);    
    ::Sound("luffaren/dd_slam.mp3",weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);       
}

function sfx_wind(is_mimic){
    local weapon = "item_wind_cross";
    if(is_mimic==1)weapon="item_mimic_cross";
    local weapon_ent = Entities.FindByName(null,weapon);
    local weapon_origin = Vector(0,0,15);
    ::Sound("ambient/wind/windgust.wav",weapon_origin,weapon_ent,6666,20,RandomInt(70,80),10,null);     
    ::Sound("luffaren/dd_slam.mp3",weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);     
}

function sfx_heal(is_mimic){
    local weapon = "item_heal_cross";
    if(is_mimic==1)weapon="item_mimic_cross";
    local weapon_ent = Entities.FindByName(null,weapon);
    local weapon_origin = Vector(0,0,15);
    ::Sound("luffaren/dd_s2.mp3",weapon_origin,weapon_ent,6666,20,RandomInt(70,80),10,null);       
}

function sfx_electro(is_mimic){
    local weapon = "item_heal_cross";
    if(is_mimic==1)weapon="item_mimic_cross";
    local weapon_ent = Entities.FindByName(null,weapon);
    local weapon_origin = Vector(0,0,15);
    ::Sound("ambient/energy/spark6.wav",weapon_origin,weapon_ent,6666,20,RandomInt(70,80),10,null);     
    ::Sound("luffaren/dd_s2.mp3",weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);   
}

function sfx_mimic(){
    local weapon = "item_mimic_cross";
    local weapon_ent = Entities.FindByName(null,weapon);
    local weapon_origin = Vector(0,0,15);
    ::Sound("luffaren/dd_s3.mp3"weapon_origin,weapon_ent,6666,20,RandomInt(90,110),10,null);
}

// *********** handler images
::handler_imgs<-{
	[0] = "<img src=\"https://raw.githubusercontent.com/TheBigBadMemeMan/ghostfap/main/image/handler_1.png\"/>",
	[1] = "<img src=\"https://raw.githubusercontent.com/TheBigBadMemeMan/ghostfap/main/image/handler_2.png\"/>",
	[2] = "<img src=\"https://raw.githubusercontent.com/TheBigBadMemeMan/ghostfap/main/image/handler_3.png\"/>",
	[3] = "<img src=\"https://raw.githubusercontent.com/TheBigBadMemeMan/ghostfap/main/image/handler_4.png\"/>"
}

function set_message(message){
	env_message.__KeyValueFromString("message",message);
}

function show_message(player){
	EntFireByHandle(env_message, "ShowMessage", "", 0, player, player);	
}

function handler_popup_nosound(message,player){
	local handler_img = handler_imgs[RandomInt(0,handler_imgs.len()-1)];
	set_message(handler_img);
	show_message(player);
	VS.EventQueue.AddEvent(set_message,0.05,[this,"<font color='#40EB34'>handler: \n</font><font color='#EB34AB'>" + message + "</font>\n" + handler_img.tostring()]);	
	VS.EventQueue.AddEvent(show_message,0.4,[this,player]);
}

::env_message<-Entities.FindByName(null, "handler_env_message");
