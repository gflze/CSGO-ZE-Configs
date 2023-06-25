/*  script for ze_aaa_ohio, made by lameskydiver/chinny
 *  fixes various issues that is present in the _final_Final_FINAL version
 *  first version of this fix created on 26th May 2023
 *
 *  If you spot errors / have questions contact me via:
 *  discord:    lameskydiver/chinny#5724
 *  steam:      https://steamcommunity.com/id/lameskydiver
 */

// -------------------------- //
// +   chinny_general.nut   + //
// -------------------------- //

//add message about stripper fix
g_start_chat <- [   " \x02 ur playing ze_aaa_ohio_final_FINAL_FiNaL made by me (lameskydiver/chinny)",
                    " \x02 also hired a stripper to do some fixing",
                    " \x02 thanks to luff and soft serve for feeding my mapping autism",    ];

//modify the introChat function to accommodate extra msg about stripper fix
introChat <- function(it)
{
    ScriptPrintMessageChatAll(g_start_chat[it]);
    if(!it)
        EntFireByHandle(self, "RunScriptCode", "introChat("+(it+1)+")", 2, null, null);
    if(it==1)
        EntFireByHandle(self, "RunScriptCode", "introChat("+(it+1)+")", 2, null, null);
}

// ----------------------------- //
// +   chinny_cincinnati.nut   + //
// ----------------------------- //

//added visual cues to CT to stay away from the dragon
touchedBoss <- function()
{
    if(!activator || !(activator.IsValid()))
        return;
    if(activator.GetTeam()==2)
    {
        local vel = activator.GetVelocity();
        vel.x = -vel.x * 2;
        if(abs(vel.x)<250)
            vel.x = 500;
        if(abs(vel.x)>1000)
            vel.x = 1000;
        activator.SetVelocity(vel);
    }
    else if(activator.GetTeam()==3)
    {
        EntFire("chinny_cn_fade","FadeReverse","",0,activator);
        EntFireByHandle(activator, "SetDamageFilter", "mortal", 0, null, null);
        EntFireByHandle(activator, "SetDamageFilter", "immortal", 0.98, null, null);
        changeHealth(-20,3);
        EntFireByHandle(activator, "ignitelifetime", "1", 0.02, null, null);
    }
}

// -------------------------- //
// +   chinny_toldedo.nut   + //
// -------------------------- //

//fix the stage borke msg
g_toledo_extreme_chat <- [  " \x0e i am sad you are wanting to leave, but i understand!! ",//[0]
                            " \x0e let's walk you back across the\x10 perfectly normal bridge!!",
                            " \x0e don't worry about\x06 that thing\x0e in front of you!!",
                            " \x0e surely it won't start moving like in ze_collective!!",
                            " \x10 oh shit oh fuck",
                            " \x0e haha maybe it is just showing off its moves",//[5]
                            " \x0e surely it will not begin attacking or anything haha!!",
                            " \x10 oh shit oh fuck run, across the bridge!!!!",
                            "",
                            " \x06 THE COLLECTIVE\x0e is preparing for its\x10 ultimate-final-dooming attack!!",
                            " \x0e quick!! get in this\x10 totally inconspicuous trap-free van!!",//[10]
                            " \x10 and stay away from that glitching wall!!\x0e just do!!",
                            " \x02 T H E R E  I S  N O  E S C A P I N G",
                            " \x02 T H E R E  I S  N O  E S C A P I N G",
                            " \x02 T H E R E  I S  N O  E S C A P I N G",
                            " \x0e oops!! it was a trap after all!!",//[15]
                            " \x0e surely nobody fell for it though!!",
                            " \x0e anyways let's cross the\x10 perfectly normal bridge\x0e back!!",
                            " \x0e looks like\x06 THE COLLECTIVE\x0e is still angry though!!",
                            " \x0e oh no!!\x06 THE COLLECTIVE\x0e went absolutely fuming and it\x10 phased into the depths below!!",
                            " \x0e i think you owe it an apology after this!!",//[20]
                            " \x0e but for now let's get\x10 back into the tunnel!!",
                            "",
                            "",
                            " \x10 afk tp has been activated!!",
                            " \x0e oh no!! the stage went borked and the map is now broken!!",//[25]
                            " \x0e wait no, then how is this chat working",
                            " \x0e whatever it is, just stay alive for 30 secs!! then maybe something will happen!!",
                            " \x10 hmm... something is fishy or something?"  ];

g_eye_ignore_rot_checks <- false;//finalx3 s: check for invalid player handles

//new in stripper: check if the eye targetted player handle is still valid and recalculate if not
function isTargettedPlayerStillValid()
{
    if(!g_eye_focus_ply || !(g_eye_focus_ply.IsValid()) || g_eye_focus_ply.GetTeam()!=3 || g_eye_focus_ply.GetHealth()<1 || !checkIfPlayerInStage(g_eye_focus_ply))
    {
        EntFire("debug", "Command", "echo ----------(DEBUG WARNING)----------", 0.0, null);
        EntFire("debug", "Command", "echo The eye is targetting a non-valid player for rotation!", 0.0, null);
        EntFire("debug", "Command", "echo ("+g_eye_focus_ply+", "+g_eye_focus_ply.IsValid()+", "+g_eye_focus_ply.GetTeam()+", "+g_eye_focus_ply.GetHealth()+", "+checkIfPlayerInStage(g_eye_focus_ply)+")", 0.0, null);
        EntFire("debug", "Command", "echo ----------", 0.0, null);
        g_eye_focus_ply = chooseBeamTarget();
        EntFire("debug", "Command", "echo Attempting to choose a new target...", 0.0, null);
        //printl(g_eye_focus_ply);
        if(!g_eye_focus_ply)
        {
            if(g_eye_focus_prev_ply && g_eye_focus_prev_ply.IsValid() && g_eye_focus_prev_ply.GetTeam()==3 && g_eye_focus_prev_ply.GetHealth()>0 && checkIfPlayerInStage(g_eye_focus_prev_ply))
            {
                EntFire("debug", "Command", "echo The previous targetted player has been chosen", 0.0, null);
                g_eye_focus_ply = g_eye_focus_prev_ply;
            }
            else
            {
                EntFire("debug", "Command", "echo No valid targets was found, executing stage end early.", 0.0, null);
                EntFire("debug", "Command", "echo -----------------------------------", 0.0, null);
                EntFire("chinny_tl_eye*", "Kill", "", 0, null);
                g_eye_kill = true;
                return false;
            }
        }
        EntFire("debug", "Command", "echo -----------------------------------", 0.0, null);
    }
    return true;
}

//add more constraints for player targetting
chooseBeamTarget <- function()
{
    local coords = [];
    local ply = null;
    //finalx3 s: add condition to check their health and their position
    while((ply=Entities.FindByClassname(ply, "player"))!=null)  if(ply && ply.IsValid() && ply.GetTeam()==3 && ply.GetHealth()>0 && checkIfPlayerInStage(ply))
        coords.append(ply);
    if(coords.len()==0)
        return null;
    return coords[RandomInt(0,coords.len()-1)];
}

//check if the eye targetted player handle is still valid and recalculate if not
___tickMove <- function()
{
    local eye = Entities.FindByName(null, "chinny_tl_eye");
    if(!eye)
        return;
    local next_fvec = null;
    local eye_org = eye.GetOrigin();
    g_sin -= 0.05;
    if(g_eye_dying)
    {
        if(g_eye_deadvel.z > -50)
            g_eye_deadvel.z -= 1.5;
		eye.SetOrigin(eye_org+g_eye_deadvel);
        if(eye_org.z<(g_toledo_origin.z-2500))
        {
            EntFire("chinny_tl_eye*", "Kill", "",0,null);
            g_eye_kill = true;
            return;
        }
		local ang = eye.GetAngles();
		ang += g_eye_deadrot;
		eye.SetAngles(ang.x,ang.y,ang.z);
    }
    else
    {
        //work on movement part
        if(g_can_eye_roam)
        {
            if(eye_org.x>(g_toledo_origin.x+5632) && g_eye_reverse)
            {
                EntFireByHandle(eye,"SetAnimation","idle_open_frenzy",0.04,null,null);
                EntFireByHandle(eye,"SetDefaultAnimation","idle_open_frenzy",0.05,null,null);
                soundPlay(eye_org,100000,"luffaren/eye_terror.mp3",10,RandomInt(220,255),10,0);
                soundPlay(eye_org,100000,"luffaren/eye_terror.mp3",10,RandomInt(130,150),10,0);
                EntFire("chinny_tl_eye_slow", "Kill", "", 0, null);
                g_chat_delays = [3,3];
                printTLChat(19,3,0);
                EntFire("chinny_tl_end_east*", "Close", "", 20, null);
                EntFire("music_looper"+::g_music_on, "FadeOut", "5", 23, null);
                EntFireByHandle(self, "RunScriptCode", "toledoEnd()", 28, null, null);
                EntFire("chinny_tl_extreme_afk_particle","StopPlayEndCap","",28,null);
                g_eye_dying = true;
            }
            local next_pos = Vector();
            if(g_eye_start)
                next_pos = Vector(eye_org.x,eye_org.y,g_eye_height);
            else
            {
                if(!g_eye_movept)
                {
                    g_eye_movept = Vector();
                    g_eye_movept.y = g_eye_axis+RandomInt(-g_eye_axis_var,g_eye_axis_var);
                    g_eye_movept.z = g_eye_height+RandomInt(-g_eye_height_var,g_eye_height_var);
                    local target = chooseMoveTarget();
                    if(target)
                    {
                        if(!g_eye_reverse)
                            g_eye_movept.x = target.x-g_eye_keep_dist;
                        else
                            g_eye_movept.x = target.x+g_eye_keep_dist;
                    }
                    else
                    {
                        if(g_eye_prev_movept)
                        {
                            if(!g_eye_reverse)
                                g_eye_movept.x = g_eye_prev_movept.x-g_eye_keep_dist;
                            else
                                g_eye_movept.x = g_eye_prev_movept.x+g_eye_keep_dist;
                        }
                        else
                        {
                            EntFire("chinny_tl_eye*", "Kill", "",0,null);
                            g_eye_kill = true;
                            return;
                        }
                    }
                    if(g_eye_afk_changed)
                        g_eye_afk_changed = !g_eye_afk_changed;
                }
                if(g_eye_movept.x<(g_toledo_origin.x-5568) && !g_eye_reverse)
                {
                    g_eye_movept = Vector(g_toledo_origin.x-4268,g_toledo_origin.y,g_eye_height+256);
                    //finalx3 s: stop eye rotation target validation checks
                    g_eye_ignore_rot_checks = true;
                    g_eye_focus_ply = Entities.FindByName(null, "chinny_tl_eye_laser_target");
                    g_eye_focus_ply.SetOrigin(Vector(g_toledo_origin.x-5568,g_toledo_origin.y,g_toledo_origin.z));
                    g_eye_trap_attack = true;
                    g_eyelid_forced = true;
                    if(!g_is_eye_open)
                        EntFire("chinny_tl_eye","SetAnimation","open",0,null);
                    EntFire("chinny_tl_eye","SetDefaultAnimation","idle_open",0.01,null);
                    EntFire("chinny_tl_eye_slow", "Disable", "", 0, null);
                    EntFire("chinny_tl_extreme_afk","Enable","",0,null);
                    local wall = Entities.FindByName(null, "chinny_tl_extreme_afk_wall");
                    wall.SetOrigin(Vector(g_toledo_origin.x-4576,wall.GetOrigin().y,wall.GetOrigin().z));
                    g_eye_afk_active = false;
                }
                next_pos = g_eye_movept;
            }
            local dir = next_pos-eye_org;
            local dist = dir.Length();
            dir.Norm();
            if(dist>g_eye_allowed_dist_var)
            {
                eye.SetOrigin(eye_org+(dir * (dist/g_eye_movespeed)));
                local slow = Entities.FindByName(null, "chinny_tl_eye_slow");
                slow.SetOrigin(Vector(eye_org.x,slow.GetOrigin().y,slow.GetOrigin().z));
            }
            else
            {
                g_eye_prev_movept = g_eye_movept;
                g_eye_movept = null;
                if(g_eye_start)
                {
                    g_eye_start = false;
                    g_can_eye_roam = false;
                    EntFireByHandle(self, "RunScriptCode", "collectPieces()", 2, null, null);
                }
                else if(g_eye_trap_attack)
                {
                    g_can_eye_roam = false;
                    local laser = Entities.FindByName(null, "chinny_tl_eye_laser");
                    laser.SetOrigin(eye_org);
                    local target = Entities.FindByName(null, "chinny_tl_eye_laser_target");
                    local dir = g_eye_focus_ply.GetOrigin()-eye_org;
                    dir.Norm();
                    target.SetOrigin(g_eye_focus_ply.GetOrigin());
                    laser.__KeyValueFromFloat("width", 20.0);
                    laser.__KeyValueFromString("LaserTarget", target.GetName());
                    laser.__KeyValueFromString("rendercolor", "255 "+g_attack_laser_gb_i[0]+" "+g_attack_laser_gb_i[1]);
                    laser.__KeyValueFromInt("TextureScroll",0);
                    EntFire("chinny_tl_eye_laser", "TurnOn", "", 0, null);
                    foreach(i in g_attack_laser_gb_f)
                        g_attack_laser_gb_f[i] = g_attack_laser_gb_it[i];
                    EntFireByHandle(self, "RunScriptCode", "eyeFakeAttack()", 5, null, null);
                    g_chat_delays = [3,3];
                    EntFireByHandle(self, "RunScriptCode", "printTLChat(9,3,0)", 1, null, null);
                }
                else
                {
                    if(g_eye_warmup_counter>=9)
                    {
                        if(!g_attack_notified)
                        {
                            EntFireByHandle(self, "RunScriptCode", "printTLChat(7,1,0)", 0.5, null, null);
                            g_attack_notified = true;
                        }
                        if(RandomInt(1,100)>5)
                        {
                            g_can_eye_roam = false;
                            g_eye_allow_attack = true;
                        }
                        if(!g_eye_afk_changed)
                        {
                            if(!g_eye_reverse)
                            {
                                g_eye_afk_tp.x = eye_org.x+(g_eye_keep_dist*3)+512;
                                if(g_eye_afk_tp.x<(g_toledo_origin.x+6144) && !g_eye_afk_active)
                                {
                                    EntFireByHandle(self, "RunScriptCode", "printTLChat(24,1,0)", 0, null, null);
                                    g_eye_afk_active = true;
                                }
                            }
                            else if(g_eye_reverse)
                            {
                                g_eye_afk_tp.x = eye_org.x-(g_eye_keep_dist*3)-512;
                                if(g_eye_afk_tp.x>(g_toledo_origin.x-6144) && !g_eye_afk_active)
                                {
                                    local tp = Entities.FindByName(null,"chinny_tl_extreme_afk");
                                    local wall = Entities.FindByName(null, "chinny_tl_extreme_afk_wall");
                                    tp.SetAngles(0,180,0);
                                    wall.SetAngles(0,180,0);
                                    EntFireByHandle(self, "RunScriptCode", "printTLChat(24,1,0)", 0, null, null);
                                    g_eye_afk_active = true;
                                }
                            }
                            if(g_eye_afk_active)
                            {
                                local tp = Entities.FindByName(null,"chinny_tl_extreme_afk");
                                local wall = Entities.FindByName(null, "chinny_tl_extreme_afk_wall");
                                local particle = Entities.FindByName(null, "chinny_tl_extreme_afk_particle");
                                local coords = tp.GetOrigin();
                                if(!g_eye_reverse)
                                {
                                    tp.SetOrigin(Vector(g_eye_afk_tp.x+128,coords.y,coords.z));
                                    particle.SetOrigin(Vector(g_eye_afk_tp.x+128,coords.y,coords.z));
                                    coords = wall.GetOrigin();
                                    wall.SetOrigin(Vector(g_eye_afk_tp.x+128,coords.y,coords.z));
                                }
                                else
                                {
                                    tp.SetOrigin(Vector(g_eye_afk_tp.x-128,coords.y,coords.z));
                                    particle.SetOrigin(Vector(g_eye_afk_tp.x-128,coords.y,coords.z));
                                    coords = wall.GetOrigin();
                                    wall.SetOrigin(Vector(g_eye_afk_tp.x-128,coords.y,coords.z));
                                }
                                EntFireByHandle(tp,"Enable","",0,null,null);
                                EntFireByHandle(particle,"StopPlayEndCap","",0,null,null);
                                EntFireByHandle(particle,"Start","",1,null,null);
                                g_eye_afk_changed = true;
                            }
                        }
                    }
                    else
                        g_eye_warmup_counter++;
                }
            }
            //random chance of boss noise
            if(RandomInt(0,1000)<5 && !g_eye_start) foreach(i in array(2))
                soundPlay(eye_org,100000,"luffaren/eye_terror3.mp3",10,RandomInt(55,85),4,0);
        }
        //work on rotation part
        if(!g_eye_start && !g_eye_laser_attacking)
        {
            if(g_eye_find_new_target && !g_eye_trap_attack)
            {
                g_eye_focus_prev_ply = g_eye_focus_ply;
                g_eye_focus_ply = chooseBeamTarget();
                if(g_eye_focus_ply)
                {
                    g_eye_find_new_target = false;
                    EntFireByHandle(self, "RunScriptCode", "g_eye_find_new_target <- true", g_eye_time_per_target, null, null);
                }
                else
                {
                    if(g_eye_focus_prev_ply)
                    {
                        g_eye_focus_ply = g_eye_focus_prev_ply;
                        g_eye_find_new_target = false;
                        EntFireByHandle(self, "RunScriptCode", "g_eye_find_new_target <- true", g_eye_time_per_target, null, null);
                    }
                    else
                    {
                        EntFire("chinny_tl_eye*", "Kill", "", 0, null);
                        g_eye_kill = true;
                        return;
                    }
                }
            }
            local current_fvec = eye.GetForwardVector();
            //finalx3 s: check if the eye targetted player handle is still valid and recalculate if not
            if(!g_eye_ignore_rot_checks)    if(!isTargettedPlayerStillValid())
                return;
            next_fvec = (g_eye_focus_ply.GetOrigin()-eye_org);
            next_fvec.Norm();
            eye.SetForwardVector(current_fvec+(next_fvec*g_eye_rotspeed));
        }
        else if(g_eye_trap_attack)
            next_fvec = (Vector(g_toledo_origin.x-5568,0,0)-eye_org);
        //start attack sequence
        if(g_eye_allow_attack && !g_eye_attacking)
            eyeAttack(eye);
    }
    //do platform movements
    if(g_eye_platforms.len()>0)
    {
        foreach(i, platform in g_eye_platforms)
        {
            if(!i)
            {
                if(!g_eye_dying)
                {
                    if(g_eye_platforms.len()>=g_eye_max_platforms && !g_eye_attacking)
                    {
                        platform.SetOrigin(eye_org-(next_fvec*g_eye_first_platform_dist));
                        platform.SetForwardVector(next_fvec);
                    }
                    else
                    {
                        local dir = (eye_org-platform.GetOrigin());
                        local dist = dir.Length();
                        dir.Norm();
                        if(dist*2 > g_eye_first_platform_dist)
                            platform.SetOrigin(platform.GetOrigin() + (dir * (dist*5/g_eye_platform_dist)));
                        else
                            platform.SetOrigin(eye_org-(dir*25));
                    }
                }
                else
                {
                    platform.SetOrigin(eye_org);
                    platform.SetForwardVector(eye.GetForwardVector());
                }
                continue;
            }
            local next_pos = platform.GetOrigin();
            next_pos.z += (sin(g_sin+(i.tofloat()/2))*4);
            next_pos -= (eye.GetForwardVector()*8);
            next_pos -= eye.GetUpVector();
            platform.SetOrigin(next_pos);
            local dir = (platform.GetOrigin()-g_eye_platforms[i-1].GetOrigin());
            local dist = dir.Length();
            dir.Norm();
            if(g_eye_platforms.len()>=g_eye_max_platforms)
            {
                if(dist > g_eye_platform_dist)
                    platform.SetOrigin(g_eye_platforms[i-1].GetOrigin() + (dir * g_eye_platform_dist));
            }
            else
            {
                if(dist > g_eye_platform_dist*1.2)
                    platform.SetOrigin(platform.GetOrigin() - (dir * (dist*20/g_eye_platform_dist)));
                else
                    platform.SetOrigin(g_eye_platforms[i-1].GetOrigin() + (dir * g_eye_platform_dist));
            }
            platform.SetForwardVector(dir);
        }
    }
    EntFireByHandle(self, "RunScriptCode", "tickMove()", g_tickrate, null, null);
}

//check if the eye targetted player handle is still valid and recalculate if not
eyeAttack <- function(handle)
{
    //finalx3 s: end the function early if the eye is already dead
    if(g_eye_kill)
        return;
    g_eye_attacking = true;
    g_eyelid_forced = true;
    if(!g_is_eye_open)
        EntFire("chinny_tl_eye","SetAnimation","open",0,null);
    EntFire("chinny_tl_eye","SetDefaultAnimation","idle_open",0.01,null);
    if(RandomInt(0,1))
    {//laser attack
        g_eye_laser_attacking = true;
        local laser = Entities.FindByName(null, "chinny_tl_eye_laser");
        laser.SetOrigin(handle.GetOrigin());
        local target = Entities.FindByName(null, "chinny_tl_eye_laser_target");
        //finalx3 s: check if the eye targetted player handle is still valid and recalculate if not
        if(!g_eye_ignore_rot_checks) if(!isTargettedPlayerStillValid())
            return;
        local dir = g_eye_focus_ply.GetOrigin()-handle.GetOrigin();
        dir.Norm();
        local coords = g_eye_focus_ply.GetOrigin();
        coords.z += 32;
        coords += (dir*200);
        target.SetOrigin(coords);
        laser.__KeyValueFromFloat("width", 20.0);
        laser.__KeyValueFromString("LaserTarget", target.GetName());
        laser.__KeyValueFromString("rendercolor", "255 "+g_attack_laser_gb_i[0]+" "+g_attack_laser_gb_i[1]);
        laser.__KeyValueFromInt("TextureScroll",0);
        EntFire("chinny_tl_eye_laser", "TurnOn", "", 0, null);
        foreach(i in g_attack_laser_gb_f)
            g_attack_laser_gb_f[i] = g_attack_laser_gb_it[i];
        laserCharge();
        foreach(i in array(2))
            soundPlay(handle.GetOrigin(),100000,"sfx/chinny/laser_charge.mp3",10,100,3,0);
        particleSpawn(handle.GetOrigin(),handle.GetAngles(),"custom_particle_001",3,"");
    }
    else
    {//ball attack
        ballAttack();
    }
}

//add previous position after an attack
laserAttack <- function()
{
    //finalx3 s: end the function early if the eye is already dead
    if(g_eye_kill)
        return;
    local laser = Entities.FindByName(null, "chinny_tl_eye_laser");
    laserHurt(caller);
    EntFireByHandle(activator, "TurnOff", "", 0.05, null, null);
    caller.__KeyValueFromInt("skin",0);
    EntFire("chinny_tl_eye","SetAnimation","idle_open",0,null);
    laser.__KeyValueFromString("rendercolor", "255 0 0");
    foreach(i in array(2))
            soundPlay(caller.GetOrigin(),100000,"sfx/chinny/laser_fire.mp3",10,100,2,0);
    particleSpawn(caller.GetOrigin(),Entities.FindByName(null, "chinny_tl_eye").GetAngles(),"custom_particle_002",2,"");
    EntFire("chinny_tl_laser_hurt","Kill","",0.05,null);
    g_attack_laser_it = 0;
    g_attack_laser_gb_f = [0,0];
    g_eye_attacking = false;
    g_eye_find_new_target = true;
    g_eye_laser_attacking = false;
    g_eye_allow_attack = false;
    g_eyelid_forced = false;
    //finalx3 s: designate the eye's previous position for future calculation
    g_eye_prev_movept = Entities.FindByName(null, "chinny_tl_eye").GetOrigin();
    EntFireByHandle(self, "RunScriptCode", "g_can_eye_roam <- true", 1, null, null);
}

//add previous position after an attack
ballAttack <- function()
{
    //finalx3 s: end the function early if the eye is already dead
    if(g_eye_kill)
        return;
    g_eye_focus_ply = chooseBeamTarget();
    local eye = Entities.FindByName(null, "chinny_tl_eye");
    local eye_org = eye.GetOrigin();
    moveSpawn(eye_org,eye.GetAngles(),6000,750,0,0,"","",8,0.5);
    if(::g_lin_idx==0)
    {
        ballHurt(eye, "chinny_move"+g_lin_idx_max);
        particleSpawn(eye_org,eye.GetAngles(),"custom_particle_004",10,"chinny_move"+g_lin_idx_max);
    }
    else
    {
        ballHurt(eye, "chinny_move"+(::g_lin_idx-1));
        particleSpawn(eye_org,eye.GetAngles(),"custom_particle_004",10,"chinny_move"+(::g_lin_idx-1));
    }
    if(!g_attack_ball_it)
    {
        EntFire("chinny_tl_eye","SetAnimation","idle_open_frenzy",0,null);
        EntFire("chinny_tl_eye","SetPlaybackRate","5",0,null);
    }
    soundPlay(eye_org,100000,"sfx/chinny/ball_charge.mp3",10,100,2,0);
    soundPlay(eye_org,100000,"sfx/chinny/ball_fire.mp3",10,100,2,0.5);
    g_attack_ball_it++;
    if(g_attack_ball_it<g_attack_ball_max)
        EntFireByHandle(self, "RunScriptCode", "ballAttack()", g_attack_rest_time, null, null);
    else
    {
        g_attack_ball_it = 0;
        g_eye_attacking = false;
        g_eye_allow_attack = false;
        g_eyelid_forced = false;
        EntFireByHandle(self, "RunScriptCode", "g_can_eye_roam <- true", 1.5, null, null);
        EntFire("chinny_tl_eye","SetAnimation","idle_open",1,null);
        //finalx3 s: designate the eye's previous position for future calculation
        g_eye_prev_movept = eye.GetOrigin();
    }
}

//add previous position after an attack
eyeFakeAttack <- function()
{
    //finalx3 s: end the function early if the eye is already dead
    if(g_eye_kill)
        return;
    local laser = Entities.FindByName(null, "chinny_tl_eye_laser");
    local eye = Entities.FindByName(null, "chinny_tl_eye");
    if(g_attack_laser_it<(floor(g_attack_laser_max_it*0.9)))
        soundPlay(eye.GetOrigin(),100000,"sfx/chinny/laser_charge.mp3",10,30+(g_attack_laser_it*2)+RandomInt(-15,15),0.75,0);
    if(g_attack_laser_it==g_attack_laser_max_it)
    {
        eye.__KeyValueFromInt("skin",0);
        EntFireByHandle(laser, "TurnOff", "", 0, null, null);
        EntFire("chinny_tl_eye","SetAnimation","idle_open",0,null);
        EntFire("chinny_tl_eye_slow", "Enable", "", 0, null);
        EntFire("chinny_tl_eye_slow", "SetPushDirection", "0 180 0", 0, null);
        EntFire("chinny_tl_trap", "Open", "", 0, null);
        soundPlay(Vector(g_toledo_origin.x-5852,g_toledo_origin.y,g_toledo_origin.z+96),50000,"sfx/chinny/metal_pipe_sfx.mp3",10,100,2,0);
        g_chat_delays = [0.1,0.1,4,4,4,4];
        printTLChat(12,7,0);
        EntFire("chinny_tl_extreme_afk_particle","StopPlayEndCap","",0,null);
        EntFire("spawn_tp_ct", "AddOutput", "target chiny_dest_west_t", 0, null);
        EntFire("spawn_tp_t", "AddOutput", "target chiny_dest_west_t", 0, null);
        local tp = Entities.FindByName(null,"chinny_tl_extreme_afk");
        tp.SetOrigin(Vector(g_toledo_origin.x-4576,tp.GetOrigin().y,tp.GetOrigin().z));
        EntFireByHandle(tp, "Enable", "", 0, null, null);
        EntFireByHandle(tp, "Disable", "", 0.5, null, null);
        local wall = Entities.FindByName(null, "chinny_tl_extreme_afk_wall");
        wall.SetOrigin(Vector(g_toledo_origin.x-7000,wall.GetOrigin().y,wall.GetOrigin().z));
        g_attack_laser_it = 0;
        g_attack_laser_gb_f = [0,0];
        g_eye_trap_attack = false;
        g_eye_find_new_target = true;
        g_eyelid_forced = false;
        g_eye_reverse = true;
        g_eye_movept = null;
        //finalx3 s: designate the eye's previous position for future calculation
        g_eye_prev_movept = eye.GetOrigin();
        //finalx3 s: resume eye rotation target validation checks
        g_eye_ignore_rot_checks = false;
        EntFireByHandle(self, "RunScriptCode", "g_can_eye_roam <- true", 2, null, null);
        EntFire("chinny_tl_end_west", "Open", "", 10, null);
        return;
    }
    //originally iterated through (floor((1*g_attack_laser_max_it/7))-1), but hardcoding it in hopes to reduce stress
    //the texturescroll was also calculated by floor(1*100/7) and etc.; 7 is the number of skins present on collective eye model
    if(g_attack_laser_it==1)
    {
        eye.__KeyValueFromInt("skin",1);
        laser.__KeyValueFromInt("TextureScroll",14);
    }
    if(g_attack_laser_it==4)
    {
        eye.__KeyValueFromInt("skin",2);
        laser.__KeyValueFromInt("TextureScroll",28);
    }
    if(g_attack_laser_it==7)
    {
        eye.__KeyValueFromInt("skin",3);
        laser.__KeyValueFromInt("TextureScroll",42);
    }
    if(g_attack_laser_it==10)
    {
        eye.__KeyValueFromInt("skin",4);
        laser.__KeyValueFromInt("TextureScroll",57);
    }
    if(g_attack_laser_it==13)
    {
        eye.__KeyValueFromInt("skin",5);
        laser.__KeyValueFromInt("TextureScroll",71);
    }
    if(g_attack_laser_it==16)
    {
        eye.__KeyValueFromInt("skin",6);
        laser.__KeyValueFromInt("TextureScroll",86);
    }
    if(g_attack_laser_it==9)
    {
        EntFire("chinny_tl_eye","SetAnimation","idle_open_frenzy",0,null);
        EntFire("chinny_tl_eye","SetPlaybackRate","5",0,null);
    }
    laser.__KeyValueFromString("rendercolor", "255 "+g_attack_laser_gb_f[0]+" "+g_attack_laser_gb_f[1]);
    foreach(i, dummy in g_attack_laser_gb_f)
        g_attack_laser_gb_f[i] += g_attack_laser_gb_it[i];
    g_attack_laser_it++;
    EntFireByHandle(self, "RunScriptCode", "eyeFakeAttack()", 0.75, null, null);
}

//new in stripper: checks if the targetted player is within the stage
function checkIfPlayerInStage(ply)
{
    local coords = ply.GetOrigin();
    if(abs(coords.x-g_toledo_origin.x)>6656 || abs(coords.y-g_toledo_origin.y)>768)
        return false;
    return true;
}

//add more constraints when targetting eye move positions
chooseMoveTarget <- function()
{
    local coords = Vector();
    //local cum_x = 0;
    //local tot = 0;
    local ply = null;
    if(!g_eye_reverse)
    {
        coords = Vector(99999,99999,99999);
        while(null!=(ply=Entities.FindByClassname(ply, "player")))  if(ply && ply.IsValid() && ply.GetTeam()==3 && ply.GetHealth()>0)
        {//finalx3 s: check that the player is alive 
            local ply_coord = ply.GetOrigin();
            //cum_x += ply_coord.x;
            //tot += 1;
            //finalx3 s: make sure the player is within the bridge stage
            if(checkIfPlayerInStage(ply) && ply_coord.x<coords.x)
                coords = ply_coord;
        }
        if(coords==Vector(99999,99999,99999))
        {
            printl("test");
            return null;
        }
        //finalx3: prevent eye from wandering off too far from the average CT location
        //finalx3 s: use the existing variable instead of doing new calculations
        if(g_eye_prev_movept)
        {
            local safe_x_coord = g_eye_prev_movept.x - g_eye_keep_dist;
            if(g_eye_prev_movept && coords.x < safe_x_coord)
            {
                printTLChat(28,1,0);
                EntFire("debug", "Command", "echo ----------(DEBUG WARNING)----------", 0.0, null);
                EntFire("debug", "Command", "echo The eye has targetted someone/something far from its previous position! Failsafe mechanism has been enabled!", 0.0, null);
                EntFire("debug", "Command", "echo ----------", 0.0, null);
                EntFire("debug", "Command", "echo Targeted entity coordinate: "+coords.x, 0.0, null);
                EntFire("debug", "Command", "echo Min allowed x coordinate based on previous pos: "+safe_x_coord, 0.0, null);
                EntFire("debug", "Command", "echo -----------------------------------", 0.0, null);
                coords.x = safe_x_coord;
            }
        }
    }
    else
    {
        coords = Vector(-99999,-99999,-99999);
        while(null!=(ply=Entities.FindByClassname(ply, "player")))  if(ply && ply.IsValid() && ply.GetTeam()==3 && ply.GetHealth()>0)
        {//finalx3 s: check that the player is alive 
            local ply_coord = ply.GetOrigin();
            //cum_x += ply_coord.x;
            //tot += 1;
            //finalx3 s: make sure the player is within the bridge stage
            if(checkIfPlayerInStage(ply) && ply_coord.x>coords.x)
                coords = ply_coord;
        }
        if(coords==Vector(-99999,-99999,-99999))
            return null;
        //finalx3: prevent eye from wandering off too far from the average CT location
        //finalx3 s: use the existing variable instead of doing new calculations
        //local avg_x_coord = (cum_x/tot) + (g_eye_keep_dist*3);
        local safe_x_coord = g_eye_prev_movept.x + g_eye_keep_dist;
        if(g_eye_prev_movept)
        {    
            if(g_eye_prev_movept && coords.x > safe_x_coord)
            {
                printTLChat(28,1,0);
                EntFire("debug", "Command", "echo ----------(DEBUG WARNING)----------", 0.0, null);
                EntFire("debug", "Command", "echo The eye has targetted someone/something far from its previous position! Failsafe mechanism has been enabled!", 0.0, null);
                EntFire("debug", "Command", "echo ----------", 0.0, null);
                EntFire("debug", "Command", "echo Targeted entity coordinate: "+coords.x, 0.0, null);
                EntFire("debug", "Command", "echo Max allowed x coordinate based on previous pos: "+safe_x_coord, 0.0, null);
                EntFire("debug", "Command", "echo -----------------------------------", 0.0, null);
                coords.x = safe_x_coord;
            }
        }
    }
    return coords;
}

//add stage early ending if the eye is already dead
checkEyeBork <- function()
{
    //ScriptPrintMessageCenterAll("test!");
    if(!g_eye_kill)
    {
        local pos = Entities.FindByName(null, "chinny_tl_eye").GetOrigin();
        if(!((pos-g_eye_crash_pos).LengthSqr()))
            toledoEndEarly();
        else
        {
            g_eye_crash_pos = pos;
            if(g_eye_start || g_eye_trap_attack)
                EntFireByHandle(self, "RunScriptCode", "checkEyeBork()", 30, null, null);
            else
                EntFireByHandle(self, "RunScriptCode", "checkEyeBork()", 15, null, null);
        }
    }
    else if(!g_eye_dying)
        toledoEndEarly();
}