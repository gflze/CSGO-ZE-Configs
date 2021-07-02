//#####################################################################
//Patched version intended for use with GFL ze_harry_potter_v2_1_csgo stripper
//Install as csgo/scripts/vscripts/gfl/harry_potter_hp_fix.nut
//#####################################################################

STAGE <- 0;
EXTREME <- false;
ONLYZMMOD <- false;
ZMITEMMAXLVL <- false;
BLOCKZMWANDSHOP <- false;
BLOCKHUWANDSHOP <- false;
BLOCKWANDSHOP <- false;
CLOSEWANDSHOP <- false;
AUTOBHOP <- false;
// SERVERTIME <- Time();

function MapStart()
{
	if(BLOCKWANDSHOP){CLOSEWANDSHOP=true;EntFire("map_wandblock_ZM", "Enable", "", 0.00, null);EntFire("map_wandblock_HM", "Enable", "", 0.00, null);}
	else if(!BLOCKWANDSHOP && CLOSEWANDSHOP){CLOSEWANDSHOP=false;EntFire("map_wandblock_ZM", "Disable", "", 0.00, null);EntFire("map_wandblock_HM", "Disable", "", 0.00, null);}
	EntFire("item_level_0", "SetText", "YOUR ITEM LEVEL: 0", 0.00, null);
	EntFire("item_level_1", "SetText", "YOUR ITEM LEVEL: 1", 0.00, null);
	EntFire("item_level_2", "SetText", "YOUR ITEM LEVEL: 2", 0.00, null);
	EntFire("item_level_3", "SetText", "YOUR ITEM LEVEL: 3", 0.00, null);
	EntFire("item_level_4", "SetText", "YOUR ITEM LEVEL: 4", 0.00, null);
	if(STAGE <= 6)
	{
		EXTREME = false;
		EntFire("lightworld", "TurnOn", "", 0.00, null);
		EntFire("sun", "TurnOn", "", 0.00, null);
        EntFire("tone", "SetAutoExposureMax", "1", 0.00, null);
		EntFire("tone", "SetAutoExposureMin", "1", 0.00, null);
		EntFire("tone", "SetBloomScale", "1.5", 0.00, null);
		EntFire("sky_day", "Trigger", "", 0.00, null);
		EntFire("fog_cont", "SetColor", "253 239 208", 0.00, null);
		EntFire("fog_cont", "SetColorSecondary", "253 239 208", 0.00, null);
	}
	else if(STAGE >= 7)
	{
		EXTREME = true;
		EntFire("lightworld", "TurnOff", "", 0.00, null);
		EntFire("sun", "TurnOff", "", 0.00, null);
		EntFire("tone", "SetAutoExposureMax", ".65", 0.00, null);
		EntFire("tone", "SetAutoExposureMin", ".45", 0.00, null);
		EntFire("tone", "SetBloomScale", "2.75", 0.00, null);
		EntFire("sky_night", "Trigger", "", 0.00, null);
		EntFire("fog_cont", "SetColor", "111 111 111", 0.00, null);
		EntFire("fog_cont", "SetColorSecondary", "111 111 111", 0.00, null);
	}
	EntFire("map_stages_case_*", "InValue", "", 1.00, null);
	EntFire("map_screenoverlay", "SwitchOverlay", "1", 0.85, null);
	EntFire("item_skin_dum_effect_static", "Start", "", 0.70, null);
	EntFire("item_skin_hagrid_effect_static", "Start", "", 0.70, null);
	EntFire("item_skin_dmntr_effect_static", "Start", "", 0.80, null);
	EntFire("item_skin_hp_effect_static", "Start", "", 0.70, null);
	EntFire("spxZM_effect_static_*", "Start", "", 0.75, null);
	EntFire("spx_effect_static_*", "Start", "", 0.75, null);
	EntFire("item_skin_dum_effect_static", "Stop", "", 0.02, null);
	EntFire("item_skin_hagrid_effect_static", "Stop", "", 0.02, null);
	EntFire("item_skin_dmntr_effect_static", "Stop", "", 0.04, null);
	EntFire("item_skin_hp_effect_static", "Stop", "", 0.04, null);
	EntFire("spxZM_effect_wand_*", "Stop", "", 0.06, null);
	EntFire("spxZM_effect_static_*", "Stop", "", 0.06, null);
	EntFire("spx_effect_static_*", "Stop", "", 0.08, null);
	EntFire("spx_effect_wand_*", "Stop", "", 0.08, null);
	EntFire("map_screenoverlay", "SwitchOverlay", "1", 0.00, null);
	EntFire("item_skin_troll_effect_static", "Stop", "", 0.04, null);
	EntFire("item_skin_troll_effect_static", "Start", "", 0.80, null);
	EntFire("map_screenoverlay", "SwitchOverlay", "1", 0.09, null);
	EntFire("item_skin_maxi_effect", "Stop", "", 0.04, null);
	EntFire("item_skin_maxi_effect", "Start", "", 0.80, null);
	EntFire("item_skin_herm_effect_static", "Stop", "", 0.02, null);
	EntFire("item_skin_luna_effect_static", "Stop", "", 0.02, null);
	EntFire("item_skin_luna_effect_static", "Start", "", 0.80, null);
	EntFire("item_skin_herm_effect_static", "Start", "", 0.70, null);
	EntFire("map_wandblock_*", "FireUser1", "", 0.90, null);
	EntFire("item_skin_werewolf_e", "Stop", "", 0.04, null);
	EntFire("item_skin_werewolf_e", "Start", "", 0.70, null);
	EntFire("item_skin_vold_e", "Stop", "", 0.02, null);
	EntFire("item_skin_vold_e", "Start", "", 0.80, null);
	EntFire("map_soundsys_ambient_all", "AddOutput", "targetname map_sound_death", 0.60, null);
	EntFire("map_soundsys_ambient_all", "AddOutput", "message harrypotterze/bosses/deatheater_death.mp3", 0.50, null);
	EntFire("map_soundsys_template", "ForceSpawn", "", 0.40, null);
	EntFire("map_soundsys_ambient_all", "AddOutput", "targetname map_sound_wands", 0.30, null);
	EntFire("map_soundsys_ambient_all", "AddOutput", "message harrypotterze/ambient/xglobalwandsound.mp3", 0.20, null);
	EntFire("map_soundsys_template", "ForceSpawn", "", 0.10, null);
	if(ONLYZMMOD){STAGE = 3;}
	if(!EXTREME)
	{
        EntFire("map_boss_case_hp_xtrm", "Kill", "", 0.2, null);
	    EntFire("map_boss_case_counter_xtrm", "Kill", "", 0.2, null);
	    EntFire("map_fog", "Kill", "", 0, null);
	    EntFire("stage3_wizard_cd_r*", "CancelPending", "", 0.3, null);
	    EntFire("map_skybox_template", "AddOutput", "OnEntitySpawned map_skybox_effect:Kill::0.1:-1", 0.5, null);
	    EntFire("map_hint_case", "AddOutput", "OnCase16 map_hint_msg8B:AddOutput:message Normal mode active:0:1", 0.1, null);
	    EntFire("map_ambient_def1", "AddOutput", "targetname map_sound_switch_nrml1", 0.1, null);
	    EntFire("map_ambient_def2", "AddOutput", "targetname map_sound_switch_nrml2", 0.1, null);
	    EntFire("map_skybox_clouds", "AddOutput", "targetname map_skybox_cspawn", 0.5, null);
	    EntFire("map_fx_perm1", "FireUser3", "", 0.3, null);
	    EntFire("map_fx_perm1", "FireUser4", "", 0.6, null);
	}
	else if(EXTREME)
	{
		EntFire("map_boss_case_hp_nrml", "Kill", "", 0, null);
		EntFire("map_boss_case_counter_nrml", "Kill", "", 0, null);
		EntFire("lightworld", "TurnOff", "", 0.3, null);
		EntFire("map_skybox_clouds", "AddOutput", "targetname map_skybox_cspawn", 0.5, null);
		EntFire("map_skybox_template", "AddOutput", "OnEntitySpawned map_skybox_clouds:Color:255 51 51:0:-1", 0.4, null);
		EntFire("map_skybox_template", "AddOutput", "OnEntitySpawned map_skybox_effect:Stop::0:-1", 0.4, null);
		EntFire("map_skybox_template", "AddOutput", "OnEntitySpawned map_skybox_effect:Start::0.1:-1", 0.4, null);
		EntFire("map_hint_case", "AddOutput", "OnCase16 map_hint_msg8B:AddOutput:message Extreme mode active:0:1", 0.1, null);
		EntFire("map_ambient_def1", "AddOutput", "targetname map_sound_switch_xtrm1", 0.1, null);
		EntFire("map_ambient_def2", "AddOutput", "targetname map_sound_switch_xtrm2", 0.1, null);
		EntFire("map_skybox_clouds", "Color", "255 51 51", 0.3, null);
		EntFire("stage3_wizard_cd_r*", "CancelPending", "", 0.2, null);
		EntFire("map_fx_perm1", "FireUser3", "", 0.2, null);
		EntFire("map_adroom_opt_flycars", "Enable", "", 0.2, null);
		EntFire("map_adroom_comp_flycars", "SetCompareValue", "1", 0.2, null);
		EntFire("map_fx_perm1", "FireUser4", "", 0.6, null);
	}
	if(STAGE >= 10)
	{
		EntFireByHandle(self,"RunScriptCode","SetItemLevel(4);",5.00,null,null);
	}
    if(STAGE == 0 && !ONLYZMMOD)
	{
		TimerMap(117, 3);
		EntFire("player", "SetDamageFilter", "", 116.95, null);
		EntFire("map_nuke_spawn", "Enable", "", 117.00, null);
		EntFireByHandle(self,"RunScriptCode","WonLevel();",115.00,null,null);
		EntFire("map_fixthis", "FireUser1", "", 115.00, null);
	    EntFire("console", "Command", "say >>> STARTING THE MAP - HAVE FUN <<<", 116.00, null);
	    EntFire("map_shake", "StartShake", "", 114.50, null);
	    EntFire("map_zmfix_spawn", "Kill", "", 114.00, null);
	    EntFire("map_zmfix_spawn", "Enable", "", 12.00, null);
	    EntFire("map_shake", "AddOutput", "amplitude 28", 46.00, null);
	    EntFire("map_shake", "AddOutput", "duration 4", 46.00, null);
	    EntFire("map_shake", "AddOutput", "frequency 28", 46.00, null);
	    EntFire("map_zmfix_spawn", "AddOutput", "OnStartTouch !activator:AddOutput:health 5000:0:-1", 9.00, null);
	    EntFire("mode_teleport_*", "Kill", "", 0.90, null);
	    EntFire("map_fade", "Kill", "", 0.30, null);
	    EntFire("map_adroom_opt_fixup", "FireUser1", "", 6.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 5.00, null);
	    EntFire("stage1_*", "Kill", "", 1.00, null);
	    EntFire("stage2_*", "Kill", "", 1.50, null);
	    EntFire("stage3_*", "Kill", "", 2.00, null);
	    EntFire("stage4_*", "Kill", "", 2.50, null);
	    EntFire("stage5_*", "Kill", "", 3.00, null);
	    EntFire("map_sound_switch_nrml1", "PlaySound", "", 4.00, null);
	    EntFire("map_sound_switch_nrml1", "AddOutput", "message #harrypotterze/stages/xxstgwarmupxx.mp3", 1.00, null);
	    EntFire("map_sound_switch_nrml1", "Volume", "10", 4.20, null);
	    EntFire("map_trigger_*", "Kill", "", 0.30, null);
	    EntFire("stageZM_*", "Kill", "", 3.50, null);
	    EntFire("mapx_*", "Kill", "", 3.50, null);
	    EntFire("console", "Command", "say >>> THE MAP IS WARMING UP <<<", 40.00, null);
	    EntFire("map_force_effect_exp", "Start", "", 116.90, null);
	    EntFire("map_sound_explosion", "PlaySound", "", 116.90, null);
	    EntFire("item*", "Kill", "", 0.40, null);
	    EntFire("map_boss*", "Kill", "", 0.20, null);
	    EntFire("map_sound_switch_nrml2", "Kill", "", 0.10, null);
	    EntFire("spx*", "Kill", "", 0.40, null);
	    EntFire("map_texturetoggle", "SetTextureIndex", "0", 0.00, null);
	    EntFire("map_protection_o*", "Kill", "", 114.50, null);
	    EntFire("admin_fixups", "Trigger", "", 9.50, null);
	    EntFire("filter_o*", "Kill", "", 0.80, null);
	    EntFire("filter_prop*", "Kill", "", 0.80, null);
	    EntFire("filter_sn*", "Kill", "", 1.80, null);
	    EntFire("filter_t*", "Kill", "", 0.80, null);
	    EntFire("filter_w*", "Kill", "", 0.80, null);
	    EntFire("filter_b*", "Kill", "", 0.70, null);
	    EntFire("filter_d*", "Kill", "", 0.70, null);
	    EntFire("filter_f*", "Kill", "", 0.70, null);
	    EntFire("filter_h*", "Kill", "", 0.70, null);
	    EntFire("filter_m*", "Kill", "", 0.70, null);
	    EntFire("map_sound_switch_drags", "Kill", "", 29.00, null);
	    EntFire("map_sound_teleport", "Kill", "", 0.10, null);
	    EntFire("map_miniboss*", "Kill", "", 0.20, null);
	    EntFire("map_template_effect1", "AddOutput", "origin 11456 14080 13626", 97.00, null);
	    EntFire("map_template_effect1", "ForceSpawn", "", 97.50, null);
	    EntFire("map_template_effect1", "AddOutput", "origin 11456 9728 13626", 98.00, null);
	    EntFire("map_template_effect1", "ForceSpawn", "", 98.50, null);
	    EntFire("map_template_effect1", "AddOutput", "origin 11388 12316 13480", 99.00, null);
	    EntFire("map_template_effect1", "ForceSpawn", "", 99.50, null);
	    EntFire("masstele_stg*", "Kill", "", 0.90, null);
	    EntFire("filter_class_physics", "Kill", "", 0.90, null);
	    EntFire("map_template_tor*", "Kill", "", 1.20, null);
	    EntFire("map_template_props*", "Kill", "", 1.40, null);
	    EntFire("map_template_miniboss", "Kill", "", 1.30, null);
	    EntFire("map_template_leversys", "Kill", "", 1.40, null);
	    EntFire("map_template_boss*", "Kill", "", 1.30, null);
	    EntFire("map_skybox_template", "Kill", "", 3.60, null);
	    EntFire("map_fly*", "Kill", "", 0.50, null);
	    EntFire("map_template_fix*", "Kill", "", 1.20, null);
	    EntFire("map_trigger_fasttele", "Kill", "", 1.70, null);
	    EntFire("map_healthb_*", "Kill", "", 0.50, null);
	    EntFire("map_barrel*", "Kill", "", 2.30, null);
	    EntFire("buttonsys_*", "Kill", "", 1.60, null);
	    EntFire("map_protection_on", "Enable", "", 4.50, null);
	    EntFire("map_protection_o*", "Disable", "", 113.00, null);
	    EntFire("spx*", "Kill", "", 8.00, null);
	    EntFire("map_hint_msg8B", "Kill", "", 5.90, null);
	    EntFire("map_hint_case", "InValue", "1", 5.50, null);
	    EntFire("map_hint_msg8C", "Kill", "", 5.90, null);
	    EntFire("map_hint_case", "FireUser3", "", 6.50, null);
	    EntFire("map_template_rockattack", "FireUser1", "", 3.70, null);
	    EntFire("respawn_*", "Kill", "", 2.10, null);
	    EntFire("filter_x*", "Kill", "", 0.90, null);
	    EntFire("new_check_*", "Kill", "", 2.30, null);
	    EntFire("new_check_*", "Kill", "", 0.20, null);
	    EntFire("map_sc*", "Kill", "", 4.10, null);
	    EntFire("map_sound_wands", "Kill", "", 0.10, null);
	    EntFire("map_sound_explosion", "Volume", "10", 116.95, null);
	    EntFire("map_sound_explosion", "Volume", "0", 118.00, null);
	    EntFire("map_soundsys_case", "InValue", "4", 115.50, null);
	    EntFire("filter_class_xstg_*", "Kill", "", 0.90, null);
	    EntFire("console", "Command", "mp_restartgame 1", 117.00, null);
		//EntFireByHandle(self,"RunScriptCode","UpDateServerTime();",115.00,null,null);
	    EntFire("filter_stage_winner", "Kill", "", 1.90, null);
	    EntFire("filter_stg*", "Kill", "", 1.80, null);
	    EntFire("filter_sp*", "Kill", "", 1.80, null);
	    EntFire("map_sound_birdies", "Kill", "", 0.10, null);
	    EntFire("x_ad_*", "Kill", "", 0.20, null);
	    EntFire("map_switch_*", "Kill", "", 3.60, null);
	    EntFire("console", "Command", "sv_enablebunnyhopping 1", 0.15, null);
	    EntFire("console", "Command", "zr_class_modify zombies health 5000", 0.13, null);
	    EntFire("console", "Command", "zr_infect_spawntime_max 11.0", 0.05, null);
	    EntFire("console", "Command", "zr_infect_spawntime_min 10.0", 0.06, null);
	    EntFire("map_nadesound", "Kill", "", 29.00, null);
	    EntFire("map_m_v", "Kill", "", 0.30, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 10.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 15.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 20.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 25.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 30.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 35.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 45.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 50.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 55.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 60.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 65.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 70.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 75.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 80.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 85.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 90.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 95.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 100.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 105.00, null);
	    EntFire("filter_stage_blocker", "FireUser3", "", 110.00, null);
	    EntFire("map_hint_msg8A", "Display", "", 116.00, null);
	    EntFire("map_hint_msg8A", "AddOutput", "y 0.05", 9.70, null);
	    EntFire("map_hint_msg8A", "AddOutput", "x -1", 9.70, null);
	    EntFire("map_hint_msg8A", "AddOutput", "holdtime 1", 9.70, null);
	    EntFire("map_hint_msg8A", "AddOutput", "holdtime 2", 115.70, null);
	}
	else if(STAGE == 1 && !ONLYZMMOD)
	{
		EntFire("mode_stage_acces", "Break", "", 35.00, null);
		EntFire("map_zmfix_spawn", "Enable", "", 34.00, null);
		EntFire("mode_teleport_zm", "AddOutput", "OnStartTouch !activator:AddOutput:health 10000:0:-1", 8.50, null);
		EntFire("spxZM_emendo_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:health 10000:0:-1", 8.50, null);
		EntFire("map_zmfix_spawn", "AddOutput", "OnStartTouch !activator:AddOutput:health 10000:0:-1", 8.50, null);
		EntFire("console", "Command", "say >>> STAGE 1/12 - NORMAL MODE <<<", 7.00, null);
		EntFire("map_adroom_opt_fixup", "FireUser1", "", 6.00, null);
		EntFire("console", "Command", "say >>> STAGE 1/12 - NORMAL MODE <<<", 5.00, null);
		EntFire("map_sound_switch_nrml1", "PlaySound", "", 5.00, null);
		EntFire("map_sound_switch_nrml1", "AddOutput", "message #harrypotterze/stages/xxstg1beginningx.mp3", 1.00, null);
		EntFire("map_sound_switch_nrml2", "AddOutput", "message #harrypotterze/stages/xxstg1bossfightvoldemortx.mp3", 1.00, null);
		EntFire("map_sound_switch_nrml1", "Volume", "10", 5.20, null);
		EntFire("map_texturetoggle", "SetTextureIndex", "1", 0.00, null);
		EntFire("filter_targets_block_multi", "FireUser1", "", 30.00, null);
		EntFire("filter_targets_block_multi", "FireUser3", "", 40.00, null);
		EntFire("admin_fixups", "Trigger", "", 11.00, null);
		EntFire("map_trigger_spawntele", "Disable", "", 75.00, null);
		EntFire("mode_teleport_*", "Enable", "", 75.00, null);
		EntFire("map_template_leversys", "ForceSpawn", "", 32.00, null);
		EntFire("map_leversys_brush", "AddOutput", "origin -6410 -422 13187", 33.00, null);
		EntFire("map_leversys_brush", "AddOutput", "angles 0 90 0", 33.00, null);
		EntFire("console", "Command", "say >>> GATE BREAKING IN 6 SECONDS <<<", 29.00, null);
		EntFire("stage1_court_boxxes", "AddOutput", "OnBreak stage1_breakdoor4:FireUser1::0:1", 9.00, null);
		EntFire("stage1_chess_counter", "AddOutput", "OnHitMax stage1_chess_model*:SetHealth:400:1:1", 9.00, null);
		EntFire("stage1_chess_model*", "SetHealth", "200", 68.00, null);
		EntFire("stage1_boss_ending", "AddOutput", "OnStartTouch stage1_rotdoor3:FireUser1::0:1", 9.00, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:LowerRandomBound:2:0.1:-1", 8.00, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:UpperRandomBound:4:0.1:-1", 8.00, null);
		EntFire("stage1_torchsystem", "InValue", "1", 20.00, null);
		EntFire("stage1_torchsystem", "FireUser1", "", 33.00, null);
		EntFire("map_template_torch_noprop2", "AddOutput", "origin -7321 60 12870", 41.00, null);
		EntFire("map_template_torch_noprop2", "ForceSpawn", "", 42.00, null);
		EntFire("map_template_torch_noprop2", "AddOutput", "origin -7321 -902 12870", 43.00, null);
		EntFire("map_template_torch_noprop2", "ForceSpawn", "", 44.00, null);
		EntFire("map_protection_on", "Disable", "", 36.00, null);
		EntFire("map_protection_off", "Enable", "", 37.00, null);
		EntFire("mapx*", "Kill", "", 3.50, null);
		EntFire("stage1_ex_*", "Kill", "", 0.50, null);
		EntFire("stageZM_*", "Kill", "", 3.00, null);
		EntFire("stage5_*", "Kill", "", 2.50, null);
		EntFire("stage4_*", "Kill", "", 2.00, null);
		EntFire("stage3_*", "Kill", "", 1.50, null);
		EntFire("stage2_*", "Kill", "", 1.00, null);
		EntFire("filter_stg*", "Kill", "", 0.20, null);
		EntFire("filter_wiz_*", "Kill", "", 0.40, null);
		EntFire("filter_b*", "Kill", "", 0.20, null);
		EntFire("filter_prop*", "Kill", "", 0.20, null);
		EntFire("map_trigger_itemexitfix", "Enable", "", 72.00, null);
		EntFire("mode_teleport_ct", "Kill", "", 71.00, null);
		EntFire("mode_teleport_zm", "Kill", "", 71.00, null);
		EntFire("mode_start_ct", "Kill", "", 71.00, null);
		EntFire("map_trigger_spawntele", "Enable", "", 70.00, null);
		EntFire("mode_teleport_both", "Enable", "", 70.00, null);
		EntFire("mode_teleport_*", "Disable", "", 69.00, null);
		EntFire("map_template_bossmover", "Kill", "", 0.10, null);
		EntFire("map_bossmover_*", "Kill", "", 0.10, null);
		EntFire("map_bosssys_comp", "SetCompareValue", "1", 10.00, null);
		EntFire("masstele_stg2*", "Kill", "", 4.20, null);
		EntFire("masstele_stg4*", "Kill", "", 4.20, null);
		EntFire("masstele_stg5*", "Kill", "", 4.20, null);
		EntFire("filter_class_physics", "Kill", "", 0.10, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.40, null);
		EntFire("map_trigger_fasttele", "Enable", "", 75.50, null);
		EntFire("map_trigger_itemexitfix", "Disable", "", 74.00, null);
		EntFire("map_trigger_itemexitfix", "Kill", "", 75.40, null);
		EntFire("stage1_buttoncase", "FireUser2", "", 38.00, null);
		EntFire("stage1_buttoncase", "FireUser1", "", 38.50, null);
		EntFire("map_protection_on", "Enable", "", 4.50, null);
		EntFire("map_protection_on", "Kill", "", 37.00, null);
		EntFire("mode_teleport_ct", "AddOutput", "OnStartTouch map_barrels_shaker:FireUser2::0.2:1", 10.00, null);
		EntFire("map_hint_case", "InValue", "16", 5.80, null);
		EntFire("map_hint_case", "InValue", "2", 5.40, null);
		EntFire("map_hint_msg8C", "Kill", "", 5.90, null);
		EntFire("map_hint_case", "FireUser3", "", 6.50, null);
		EntFire("stage1_chess_case", "FireUser1", "", 64.00, null);
		EntFire("map_template_rockattack", "FireUser1", "", 3.20, null);
		EntFire("map_shake", "FireUser3", "", 60.00, null);
		EntFire("new_check_delay_15", "Kill", "", 79.50, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger map_nuke_stg1:Enable::0.60:1", 83.00, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> ACTIVATING NEXT STAGE <<<:0.50:1", 82.00, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger new_check_case_stg:InValue:1:0.30:1", 81.00, null);
		EntFire("new_check_delay_*", "AddOutput", "OnTrigger map_nuke_stg1:Enable::0.30:1", 80.00, null);
		EntFire("spx_owl_nade", "AddOutput", "origin -7091 -942 12850", 7.50, null);
		EntFire("spx_hat_nade", "AddOutput", "origin -7438 100 12850", 7.50, null);
		EntFire("map_skybox_spawn", "Kill", "", 75.50, null);
		EntFire("map_soundsys_case", "InValue", "4", 35.50, null);
		EntFire("map_template_flycartrigs", "Kill", "", 0.60, null);
		EntFire("filter_class_xstg_*", "Kill", "", 0.60, null);
		EntFire("map_switch_*", "Kill", "", 3.60, null);
		EntFire("spx_skin1", "Kill", "", 0.70, null);
		EntFire("item_skin_herm_*", "Kill", "", 0.90, null);
		EntFire("item_skin_luna_*", "Kill", "", 0.90, null);
		EntFire("map_trigger_skins_l", "Kill", "", 0.90, null);
		EntFire("map_trigger_skins_he", "Kill", "", 0.90, null);
		EntFire("map_trigger_skins_v", "Kill", "", 0.90, null);
		EntFire("item_skin_vold_*", "Kill", "", 0.90, null);
		EntFire("mode_stage_acces", "FireUser2", "", 0.80, null);
		EntFire("console", "Command", "zr_class_modify zombies health 10000", 0.06, null);
		EntFire("console", "Command", "sv_enablebunnyhopping 0", 0.04, null);
		EntFire("console", "Command", "zr_infect_mzombie_ratio 8", 0.02, null);
		EntFire("map_template_bosscount", "ForceSpawn", "", 34.00, null);
		EntFire("map_template_bosscount", "Kill", "", 35.00, null);
		EntFire("map_soundsys_case", "FireUser1", "", 70.00, null);
		EntFire("map_adroom_opt_weather", "Trigger", "", 4.40, null);
		EntFire("weathersys_temp_stg6", "Kill", "", 4.30, null);
		EntFire("weathersys_temp_stg5", "Kill", "", 4.30, null);
		EntFire("weathersys_temp_stg4", "Kill", "", 4.30, null);
		EntFire("weathersys_temp_stg2", "Kill", "", 4.30, null);
		EntFire("map_fx_perm1", "FireUser2", "", 4.10, null);
		EntFire("map_adroom_opt_flycars", "Trigger", "", 36.00, null);
		EntFire("new_check_anyone", "AddOutput", "OnTrigger map_nuke_stg1:Enable::2:1", 80.00, null);
	}
	else if(STAGE == 2 && !ONLYZMMOD)
	{
		EntFire("mode_stage_acces", "Break", "", 35.00, null);
		EntFire("map_zmfix_spawn", "Enable", "", 34.00, null);
		EntFire("mode_teleport_zm", "AddOutput", "OnStartTouch !activator:AddOutput:health 15000:0:-1", 8.50, null);
		EntFire("spxZM_emendo_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:health 15000:0:-1", 8.50, null);
		EntFire("map_zmfix_spawn", "AddOutput", "OnStartTouch !activator:AddOutput:health 15000:0:-1", 8.50, null);
		EntFire("mode_start_ct", "AddOutput", "origin 11625 5704 6304", 8.00, null);
		EntFire("mode_start_zm", "AddOutput", "origin 11625 5740 6304", 8.00, null);
		EntFire("mode_start_*", "AddOutput", "angles 0 270 0", 8.00, null);
		EntFire("console", "Command", "say >>> STAGE 2/12 - NORMAL MODE <<<", 7.00, null);
		EntFire("map_adroom_opt_fixup", "FireUser1", "", 6.00, null);
		EntFire("console", "Command", "say >>> STAGE 2/12 - NORMAL MODE <<<", 5.00, null);
		EntFire("map_sound_switch_nrml1", "PlaySound", "", 5.00, null);
		EntFire("map_sound_switch_nrml1", "AddOutput", "message #harrypotterze/stages/xxstg2beginningx.mp3", 1.00, null);
		EntFire("map_sound_switch_nrml2", "AddOutput", "message #harrypotterze/stages/xxstg2bossfightsnakex.mp3", 1.00, null);
		EntFire("map_sound_switch_nrml1", "Volume", "10", 5.20, null);
		EntFire("map_texturetoggle", "SetTextureIndex", "2", 0.00, null);
		EntFire("filter_targets_block_multi", "FireUser1", "", 30.00, null);
		EntFire("filter_targets_block_multi", "FireUser3", "", 40.00, null);
		EntFire("admin_fixups", "Trigger", "", 11.00, null);
		EntFire("map_trigger_spawntele", "Disable", "", 75.00, null);
		EntFire("mode_teleport_*", "Enable", "", 75.00, null);
		EntFire("console", "Command", "say >>> GATE BREAKING IN 6 SECONDS <<<", 29.00, null);
		EntFire("stage2_tunnel_breaks", "AddOutput", "OnBreak stage2_rotdoor7b:FireUser1::0:1", 9.00, null);
		EntFire("stage2_boss_break1", "AddOutput", "OnBreak stage2_updoor2:FireUser1::0:1", 9.00, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:LowerRandomBound:2:0.1:-1", 9.50, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:UpperRandomBound:4:0.1:-1", 10.00, null);
		EntFire("stage2_torchsystem", "InValue", "1", 20.00, null);
		EntFire("stage2_updoor2", "AddOutput", "OnUser2 map_boss_case_debug:InValue:6:0:1", 9.00, null);
		EntFire("stage2_boss_template1", "AddOutput", "OnUser1 console:Command:say >>> FINAL DOORS CLOSING IN 40 SECONDS <<<:0:1", 10.20, null);
		EntFire("stage2_boss_template1", "AddOutput", "OnUser2 console:Command:say >>> FINAL DOORS CLOSING IN 30 SECONDS <<<:0:1", 10.40, null);
		EntFire("stage2_boss_template1", "AddOutput", "OnUser3 console:Command:say >>> FINAL DOORS CLOSING IN 20 SECONDS <<<:0:1", 10.60, null);
		EntFire("stage2_boss_template1", "AddOutput", "OnUser4 console:Command:say >>> FINAL DOORS CLOSING IN 10 SECONDS <<<:0:1", 10.80, null);
		EntFire("stage2_updoor3", "AddOutput", "OnUser1 !self:Close::0:1", 9.00, null);
		EntFire("map_protection_off", "Enable", "", 37.00, null);
		EntFire("map_protection_on", "Disable", "", 36.00, null);
		EntFire("mapx*", "Kill", "", 3.50, null);
		EntFire("stage2_ex_*", "Kill", "", 0.50, null);
		EntFire("stageZM_*", "Kill", "", 3.00, null);
		EntFire("stage5_*", "Kill", "", 2.50, null);
		EntFire("stage4_*", "Kill", "", 2.00, null);
		EntFire("stage3_*", "Kill", "", 1.50, null);
		EntFire("stage1_*", "Kill", "", 1.00, null);
		EntFire("filter_prop*", "Kill", "", 0.20, null);
		EntFire("filter_stg*", "Kill", "", 0.20, null);
		EntFire("filter_wiz_*", "Kill", "", 0.20, null);
		EntFire("filter_b*", "Kill", "", 0.20, null);
		EntFire("filter_m*", "Kill", "", 0.20, null);
		EntFire("map_trigger_itemexitfix", "Enable", "", 72.00, null);
		EntFire("mode_teleport_ct", "Kill", "", 71.00, null);
		EntFire("mode_teleport_zm", "Kill", "", 71.00, null);
		EntFire("mode_start_ct", "Kill", "", 71.00, null);
		EntFire("map_trigger_spawntele", "Enable", "", 70.00, null);
		EntFire("mode_teleport_both", "Enable", "", 70.00, null);
		EntFire("mode_teleport_*", "Disable", "", 69.00, null);
		EntFire("stage2_bathroom_trigger", "AddOutput", "OnStartTouch stage2_miniboss_prop1:FireUser2::1.5:1", 9.50, null);
		EntFire("stage2_bathroom_trigger", "AddOutput", "OnStartTouch stage2_miniboss_prop1:FireUser4::2:1", 10.50, null);
		EntFire("map_template_bossmover", "Kill", "", 0.10, null);
		EntFire("map_bossmover_*", "Kill", "", 0.10, null);
		EntFire("map_bosssys_comp", "SetCompareValue", "1", 10.00, null);
		EntFire("masstele_stg1*", "Kill", "", 4.20, null);
		EntFire("masstele_stg4*", "Kill", "", 4.20, null);
		EntFire("masstele_stg5*", "Kill", "", 4.20, null);
		EntFire("filter_class_physics", "Kill", "", 0.90, null);
		EntFire("map_skybox_template", "AddOutput", "origin 15138 -14102 -13443", 8.00, null);
		EntFire("map_skybox_template", "ForceSpawn", "", 29.30, null);
		EntFire("map_skybox_clouds", "AddOutput", "targetname stage2_skyprops_clouds", 29.60, null);
		EntFire("map_skybox_template", "Kill", "", 73.00, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.40, null);
		EntFire("map_trigger_fasttele", "Enable", "", 75.50, null);
		EntFire("map_trigger_itemexitfix", "Kill", "", 75.40, null);
		EntFire("map_trigger_itemexitfix", "Disable", "", 74.00, null);
		EntFire("stage2_buttoncase", "FireUser1", "", 38.00, null);
		EntFire("map_protection_on", "Enable", "", 4.50, null);
		EntFire("map_protection_on", "Kill", "", 37.00, null);
		EntFire("stage2_rotdoor1_t", "AddOutput", "OnStartTouch stage2_rotdoor1:FireUser1::0:1", 9.20, null);
		EntFire("map_template_props8", "Kill", "", 35.00, null);
		EntFire("map_spwnr_prop8_b*", "Kill", "", 35.00, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 34.60, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin 12045 3093 6109", 34.50, null);
		EntFire("map_template_props8", "ForceSpawn", "", 34.40, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 34.30, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin 12518 3094 6109", 34.20, null);
		EntFire("map_template_props8", "ForceSpawn", "", 34.10, null);
		EntFire("mode_teleport_ct", "AddOutput", "OnStartTouch map_barrels_shaker:FireUser2::0.2:1", 10.00, null);
		EntFire("map_hint_case", "InValue", "16", 5.80, null);
		EntFire("map_hint_case", "InValue", "3", 5.40, null);
		EntFire("map_hint_msg8C", "Kill", "", 5.90, null);
		EntFire("map_hint_case", "FireUser3", "", 6.50, null);
		EntFire("map_template_rockattack", "FireUser1", "", 3.20, null);
		EntFire("map_shake", "FireUser3", "", 60.00, null);
		EntFire("new_check_delay_15", "Kill", "", 79.50, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger map_nuke_stg2:Enable::0.60:1", 83.00, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> ACTIVATING NEXT STAGE <<<:0.50:1", 82.00, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger new_check_case_stg:InValue:2:0.30:1", 81.00, null);
		EntFire("new_check_delay_*", "AddOutput", "OnTrigger map_nuke_stg2:Enable::0.30:1", 80.00, null);
		EntFire("spx_owl_nade", "AddOutput", "origin 12896 2835 6121", 7.50, null);
		EntFire("spx_hat_nade", "AddOutput", "origin 12896 3352 6121", 7.50, null);
		EntFire("map_skybox_spawn", "Kill", "", 75.50, null);
		EntFire("map_soundsys_case", "InValue", "2", 35.50, null);
		EntFire("map_soundsys_case", "InValue", "4", 36.50, null);
		EntFire("map_template_flycartrigs", "Kill", "", 0.60, null);
		EntFire("filter_class_xstg_*", "Kill", "", 0.20, null);
		EntFire("map_switch_*", "Kill", "", 3.60, null);
		EntFire("console", "Command", "zr_class_modify zombies health 15000", 0.06, null);
		EntFire("console", "Command", "sv_enablebunnyhopping 0", 0.04, null);
		EntFire("console", "Command", "zr_infect_mzombie_ratio 7", 0.02, null);
		EntFire("map_template_bosscount", "ForceSpawn", "", 34.00, null);
		EntFire("map_template_bosscount", "Kill", "", 35.00, null);
		EntFire("map_m_v", "Kill", "", 0.40, null);
		EntFire("mode_stage_acces", "FireUser1", "", 0.80, null);
		EntFire("map_soundsys_case", "FireUser1", "", 70.00, null);
		EntFire("map_adroom_opt_weather", "Trigger", "", 4.40, null);
		EntFire("weathersys_temp_stg6", "Kill", "", 4.30, null);
		EntFire("weathersys_temp_stg5", "Kill", "", 4.30, null);
		EntFire("weathersys_temp_stg4", "Kill", "", 4.30, null);
		EntFire("weathersys_temp_stg1", "Kill", "", 4.30, null);
		EntFire("map_fx_perm1", "FireUser2", "", 4.10, null);
		EntFire("map_adroom_opt_flycars", "Trigger", "", 36.00, null);
		EntFire("new_check_anyone", "AddOutput", "OnTrigger map_nuke_stg2:Enable::2:1", 80.00, null);
	}
	else if(STAGE == 3)
	{
		EntFire("mode_stage_acces", "Break", "", 38.00, null);
		EntFire("map_zmfix_spawn", "Enable", "", 33.50, null);
		EntFire("mode_teleport_zm", "AddOutput", "OnStartTouch !activator:AddOutput:health 15000:0:-1", 8.50, null);
		EntFire("spxZM_emendo_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:health 15000:0:-1", 8.50, null);
		EntFire("map_zmfix_spawn", "AddOutput", "OnStartTouch !activator:AddOutput:health 15000:0:-1", 8.50, null);
		EntFire("mode_start_zm", "AddOutput", "origin 12389 -3131 -8172", 8.00, null);
		EntFire("mode_start_ct", "AddOutput", "origin 12389 -3168 -8172", 8.00, null);
		EntFire("mode_start_*", "AddOutput", "angles 0 270 0", 8.00, null);
		EntFire("console", "Command", "say >>> STAGE 3/12 - ZOMBIE MOD - NORMAL MODE <<<", 7.00, null);
		EntFire("map_sound_switch_nrml1", "Volume", "10", 5.20, null);
		EntFire("map_adroom_opt_fixup", "FireUser1", "", 6.00, null);
		EntFire("map_sound_switch_nrml1", "PlaySound", "", 5.00, null);
		EntFire("console", "Command", "say >>> STAGE 3/12 - ZOMBIE MOD - NORMAL MODE <<<", 5.00, null);
		EntFire("console", "Command", "say >>> GO INSIDE THE TELEPORTER WHEN THE GATE BREAKS <<<", 36.00, null);
		EntFire("filter_targets_block_multi", "FireUser2", "", 30.00, null);
		EntFire("console", "Command", "say >>> DO NOT CAMP IN SPAWN <<<", 37.00, null);
		EntFire("console", "Command", "say >>> THE LEVER IS UNLOCKED <<<", 257.00, null);
		EntFire("stageZM_lever_button2", "AddOutput", "origin 12380 -9752 -8240", 258.00, null);
		EntFire("console", "Command", "say >>> THE LEVER WILL UNLOCK IN 5 SECONDS <<<", 253.00, null);
		EntFire("console", "Command", "say >>> THE LEVER WILL UNLOCK IN 10 SECONDS <<<", 248.00, null);
		EntFire("stageZM_doorzm3", "Lock", "", 226.50, null);
		EntFire("console", "Command", "say >>> THE LEVER WILL UNLOCK IN 15 SECONDS <<<", 243.00, null);
		EntFire("map_template_fix1", "FireUser1", "", 240.00, null);
		EntFire("stageZM_trigger_portals", "Kill", "", 239.00, null);
		EntFire("stageZM_portal_exit*", "Kill", "", 239.00, null);
		EntFire("stageZM_trigger_masstele", "Kill", "", 239.00, null);
		EntFire("console", "Command", "say >>> THE LEVER WILL UNLOCK IN 20 SECONDS <<<", 238.00, null);
		EntFire("console", "Command", "say >>> PRESS THE LEVER WHEN UNLOCKED TO BREAK THE DOORS <<<", 236.00, null);
		EntFire("console", "Command", "say >>> KEEP DEFENDING UNTIL THE LEVER UNLOCKS <<<", 235.00, null);
		EntFire("stageZM_effect_end_*", "Stop", "", 234.00, null);
		EntFire("stageZM_trigger_masstele", "Disable", "", 234.00, null);
		EntFire("stageZM_effect_lever", "Start", "", 234.00, null);
		EntFire("stageZM_doorzm1", "Kill", "", 234.00, null);
		EntFire("console", "Command", "say >>> 1 <<<", 233.00, null);
		EntFire("console", "Command", "say >>> 2 <<<", 232.00, null);
		EntFire("console", "Command", "say >>> 3 <<<", 231.00, null);
		EntFire("stageZM_trigger_portals", "Disable", "", 227.00, null);
		EntFire("stageZM_break1", "Break", "", 224.50, null);
		EntFire("console", "Command", "say >>> GET READY FOR A LAST BATTLE <<<", 230.00, null);
		EntFire("stageZM_trigger_masstele", "Enable", "", 225.00, null);
		EntFire("map_trigger_spawntele", "Enable", "", 225.00, null);
		EntFire("stageZM_fakewall", "Close", "", 226.00, null);
		EntFire("stageZM_doorzm*", "Close", "", 226.00, null);
		EntFire("mode_start_zm", "AddOutput", "origin 12366 -6886 -8276", 224.00, null);
		EntFire("mode_start_ct", "AddOutput", "origin 12366 -8304 -8180", 224.00, null);
		EntFire("filter_broomstick_zmblock", "FireUser1", "", 223.00, null);
		EntFire("console", "Command", "say >>> 5 SECONDS LEFT <<<", 220.00, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 10 SECONDS <<<", 215.00, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 20 SECONDS <<<", 205.00, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 30 SECONDS <<<", 195.00, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 1 MINUTE <<<", 165.00, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 2 MINUTES <<<", 105.00, null);
		EntFire("stageZM_doorb2", "Break", "", 44.00, null);
		EntFire("stageZM_fakewall", "Open", "", 43.00, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 3 MINUTES <<<", 45.00, null);
		EntFireByHandle(self,"RunScriptCode","TimerMap(180, 1);",45.00,null,null);
		EntFire("stageZM_doorzm*", "Open", "", 40.00, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 2 MINUTES AND 30 SECONDS <<<", 75.00, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 1 MINUTES AND 30 SECONDS <<<", 135.00, null);
		EntFire("map_screenoverlay", "SwitchOverlay", "1", 224.90, null);
		EntFire("map_screenoverlay", "SwitchOverlay", "1", 226.00, null);
		EntFire("map_template_fix2", "FireUser1", "", 241.00, null);
		EntFire("console", "Command", "say >>> DONT DIE!!! YOU NEED TO ESCAPE AFTER THE TIME RUNS OUT <<<", 46.00, null);
		EntFire("mode_start_ct", "AddOutput", "angles 0 90 0", 224.00, null);
		EntFire("map_trigger_spawntele", "Disable", "", 224.00, null);
		EntFire("stageZM_effect_end_*", "Start", "", 223.00, null);
		EntFire("map_screenoverlay", "SwitchOverlay", "1", 234.50, null);
		EntFire("filter_targets_block_multi", "FireUser4", "", 50.00, null);
		EntFire("console", "Command", "say >>> ALL WANDS DISABLED FOR USE TILL THE END<<<", 35.00, null);
		EntFire("console", "Command", "say >>> ALL WANDS ARE ENABLED FOR USE <<<", 228.00, null);
		EntFire("admin_fixups", "Trigger", "", 15.00, null);
		EntFire("map_shake", "FireUser2", "", 227.70, null);
		EntFire("map_barrels_temp1", "ForceSpawn", "", 38.20, null);
		EntFire("map_barrels_temp1", "ForceSpawn", "", 39.00, null);
		EntFire("map_barrelset1_brush", "AddOutput", "origin 13166 -9764 -8221", 38.40, null);
		EntFire("map_barrelset1_brush", "AddOutput", "angles 0 90 0", 38.40, null);
		EntFire("map_barrelset1_brush", "AddOutput", "origin 11593 -9767 -8221", 39.20, null);
		EntFire("map_barrelset1_brush", "AddOutput", "angles 0 90 0", 39.20, null);
		EntFire("map_barrelset1_brush", "FireUser2", "", 39.40, null);
		EntFire("spx_effect_wand_*", "Stop", "", 37.90, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 37.90, null);
		EntFire("stageZM_towers_model", "Kill", "", 225.20, null);
		EntFire("stageZM_towers_fdoor", "Kill", "", 225.20, null);
		EntFire("stageZM_towers_props", "Break", "", 225.00, null);
		EntFire("console", "Command", "say >>> SPAWNING ALL FUN ITEMS - COMBO NOT POSSIBLE <<<", 10.00, null);
		EntFire("map_template_towers", "FireUser1", "", 10.20, null);
		EntFire("map_template_props4", "AddOutput", "origin 11677 -10350 -8232", 206.00, null);
		EntFire("stageZM_broomstick_spawner", "ForceSpawn", "", 16.00, null);
		EntFire("stageZM_broomstick_spawner", "AddOutput", "origin 12550 -4144 -8210", 7.20, null);
		EntFire("stageZM_broomstick_spawner2", "ForceSpawn", "", 23.00, null);
		EntFire("stageZM_broomstick_spawner2", "AddOutput", "origin 12550 -4288 -8210", 7.20, null);
		EntFire("stageZM_builder_spawner", "AddOutput", "origin 12368 -4560 -8210", 7.20, null);
		EntFire("stageZM_builder_spawner", "ForceSpawn", "", 10.10, null);
		EntFire("stageZM_doorslide1", "FireUser1", "", 170.00, null);
		EntFire("stageZM_towers_exdoors", "Kill", "", 44.00, null);
		EntFire("map_boss_case_hp_*", "FireUser1", "", 5.50, null);
		EntFire("map_barrelset1_*", "ClearParent", "", 38.60, null);
		EntFire("map_barrelset1_brush", "Kill", "", 38.80, null);
		EntFire("stageZM_torchsystem", "InValue", "1", 31.00, null);
		EntFire("stageZM_torchsystem", "InValue", "2", 216.00, null);
		EntFire("map_sound_switch_nrml2", "Volume", "10", 233.20, null);
		EntFire("map_sound_switch_nrml1", "Volume", "0", 233.20, null);
		EntFire("map_sound_switch_nrml2", "PlaySound", "", 233.00, null);
		EntFire("map_sound_switch_nrml1", "Kill", "", 234.50, null);
		EntFire("map_sound_switch_nrml1", "AddOutput", "message #harrypotterze/stages/xxstgzm1beginningxx.mp3", 1.00, null);
		EntFire("map_sound_switch_nrml2", "AddOutput", "message #harrypotterze/stages/xxstgzm1endrunx.mp3", 1.00, null);
		EntFire("map_texturetoggle", "SetTextureIndex", "3", 0.00, null);
		EntFire("map_protection_off", "Enable", "", 37.00, null);
		EntFire("map_protection_on", "Disable", "", 36.00, null);
		EntFire("map_trigger_itemexitfix", "Enable", "", 72.00, null);
		EntFire("mode_teleport_ct", "Kill", "", 71.00, null);
		EntFire("mode_teleport_zm", "Kill", "", 71.00, null);
		EntFire("map_trigger_spawntele", "Enable", "", 70.00, null);
		EntFire("mode_teleport_both", "Enable", "", 70.00, null);
		EntFire("mode_teleport_*", "Disable", "", 69.00, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 344 0", 206.00, null);
		EntFire("map_template_props4", "ForceSpawn", "", 206.10, null);
		EntFire("map_template_props4", "AddOutput", "origin 11620 -10361 -8232", 206.20, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 5 0", 206.20, null);
		EntFire("map_template_props4", "ForceSpawn", "", 206.30, null);
		EntFire("map_template_props4", "AddOutput", "origin 11567 -10363 -8232", 206.40, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 8 0", 206.40, null);
		EntFire("map_template_props4", "ForceSpawn", "", 206.50, null);
		EntFire("map_template_props4", "AddOutput", "origin 13212 -10425 -8232", 206.60, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 349 0", 206.60, null);
		EntFire("map_template_props4", "ForceSpawn", "", 206.70, null);
		EntFire("map_template_props4", "AddOutput", "origin 13158 -10421 -8232", 206.80, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 357 0", 206.80, null);
		EntFire("map_template_props4", "ForceSpawn", "", 206.90, null);
		EntFire("map_template_props4", "AddOutput", "origin 13103 -10414 -8232", 207.00, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 8 0", 207.00, null);
		EntFire("map_template_props4", "ForceSpawn", "", 207.10, null);
		EntFire("map_template_props4", "AddOutput", "origin 13026 -10760 -8232", 207.20, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 1 0", 207.20, null);
		EntFire("map_template_props4", "ForceSpawn", "", 207.30, null);
		EntFire("map_template_props4", "AddOutput", "origin 13025 -10814 -8232", 207.40, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 353 0", 207.40, null);
		EntFire("map_template_props4", "ForceSpawn", "", 207.50, null);
		EntFire("map_template_props4", "AddOutput", "origin 13025 -10869 -8232", 207.60, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 358 0", 207.60, null);
		EntFire("map_template_props4", "ForceSpawn", "", 207.70, null);
		EntFire("map_template_props4", "AddOutput", "origin 11792 -10819 -8232", 207.80, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 352 0", 207.80, null);
		EntFire("map_template_props4", "ForceSpawn", "", 207.90, null);
		EntFire("map_template_props4", "AddOutput", "origin 11792 -10874 -8232", 208.00, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 4 0", 208.00, null);
		EntFire("map_template_props4", "ForceSpawn", "", 208.10, null);
		EntFire("map_template_props4", "AddOutput", "origin 11791 -10927 -8232", 208.20, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 355 0", 208.20, null);
		EntFire("map_template_props4", "ForceSpawn", "", 208.30, null);
		EntFire("map_template_props4", "Kill", "", 209.00, null);
		EntFire("map_template_effect1", "AddOutput", "origin 13514 -5120 -8232", 223.10, null);
		EntFire("map_template_effect1", "ForceSpawn", "", 223.20, null);
		EntFire("map_template_effect1", "AddOutput", "origin 11263 -5120 -8232", 223.30, null);
		EntFire("map_template_effect1", "ForceSpawn", "", 223.40, null);
		EntFire("map_template_effect1", "AddOutput", "origin 11263 -8663 -8232", 223.50, null);
		EntFire("map_template_effect1", "ForceSpawn", "", 223.60, null);
		EntFire("map_template_effect1", "AddOutput", "origin 13514 -8663 -8232", 223.70, null);
		EntFire("map_template_effect1", "ForceSpawn", "", 223.80, null);
		EntFire("map_template_effect1", "Kill", "", 223.90, null);
		EntFire("map_force_effect_exp", "Kill", "", 227.50, null);
		EntFire("map_force_effect_exp", "Stop", "", 227.00, null);
		EntFire("map_force_effect_exp", "Start", "", 225.00, null);
		EntFire("stageZM_camp1_template", "FireUser1", "", 38.50, null);
		EntFire("stageZM_camp1_template", "FireUser3", "", 39.50, null);
		EntFire("stageZM_camp1_model", "Break", "", 225.20, null);
		EntFire("stageZM_camp1_door", "ClearParent", "", 224.70, null);
		EntFire("map_skybox_template", "Kill", "", 73.00, null);
		EntFire("map_skybox_clouds", "AddOutput", "targetname stageZM_skyprops_clouds", 37.60, null);
		EntFire("map_skybox_template", "ForceSpawn", "", 37.30, null);
		EntFire("map_skybox_template", "AddOutput", "origin 15118 -14659 -14236", 8.00, null);
		EntFire("stageZM_camp1_*", "Kill", "", 225.30, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.40, null);
		EntFire("map_template_fix1", "ForceSpawn", "", 6.20, null);
		EntFire("map_template_fix1", "AddOutput", "origin 12430 -3946 -8232", 6.50, null);
		EntFire("map_template_fix2", "AddOutput", "origin 12354 -3946 -8232", 6.50, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.90, null);
		EntFire("map_template_fix1", "ForceSpawn", "", 6.70, null);
		EntFire("mapx*", "Kill", "", 3.50, null);
		EntFire("stage5_*", "Kill", "", 3.00, null);
		EntFire("stage4_*", "Kill", "", 2.50, null);
		EntFire("stage3_*", "Kill", "", 2.00, null);
		EntFire("stage2_*", "Kill", "", 1.50, null);
		EntFire("map_spwnr_prop1*", "Kill", "", 1.10, null);
		EntFire("map_spwnr_prop7*", "Kill", "", 1.10, null);
		EntFire("map_spwnr_prop6*", "Kill", "", 1.10, null);
		EntFire("stage1_*", "Kill", "", 1.00, null);
		EntFire("map_hpbar_*", "Kill", "", 0.90, null);
		EntFire("map_bosssys_*", "Kill", "", 1.30, null);
		EntFire("map_bossmover_*", "Kill", "", 1.30, null);
		EntFire("masstele_stg*", "Kill", "", 0.70, null);
		EntFire("map_template_props1", "Kill", "", 0.60, null);
		EntFire("map_template_props7", "Kill", "", 0.60, null);
		EntFire("map_template_props6", "Kill", "", 0.60, null);
		EntFire("stageZM_ex_*", "Kill", "", 0.50, null);
		EntFire("filter_deat*", "Kill", "", 0.40, null);
		EntFire("filter_h*", "Kill", "", 0.40, null);
		EntFire("filter_snake*", "Kill", "", 0.40, null);
		EntFire("filter_spider_*", "Kill", "", 0.40, null);
		EntFire("filter_spx_spider", "Kill", "", 0.40, null);
		EntFire("filter_class_physics", "Kill", "", 0.20, null);
		EntFire("filter_wiz_*", "Kill", "", 0.20, null);
		EntFire("filter_stg*", "Kill", "", 0.20, null);
		EntFire("filter_m*", "Kill", "", 0.30, null);
		EntFire("map_template_tornado", "Kill", "", 0.10, null);
		EntFire("map_template_boss*", "Kill", "", 0.10, null);
		EntFire("map_template_torch_noprop*", "Kill", "", 0.10, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 48.00, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 58.00, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 68.00, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 78.00, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 88.00, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 98.00, null);
		EntFire("stageZM_counter_logic", "FireUser2", "", 34.00, null);
		EntFire("stageZM_propscade*", "Kill", "", 225.50, null);
		EntFire("stageZM_propstemp*", "Kill", "", 225.10, null);
		EntFire("map_trigger_fasttele", "Enable", "", 75.50, null);
		EntFire("map_trigger_itemexitfix", "Kill", "", 75.40, null);
		EntFire("map_trigger_itemexitfix", "Disable", "", 74.00, null);
		EntFire("stageZM_buttoncase", "FireUser1", "", 245.00, null);
		EntFire("map_protection_on", "Enable", "", 4.50, null);
		EntFire("map_protection_on", "Kill", "", 37.00, null);
		EntFire("stageZM_effect_*", "Stop", "", 9.50, null);
		EntFire("map_hint_case", "InValue", "16", 5.80, null);
		EntFire("map_hint_case", "InValue", "4", 5.70, null);
		EntFire("map_hint_case", "InValue", "14", 5.90, null);
		EntFire("map_hint_case", "FireUser3", "", 6.50, null);
		EntFire("map_template_rockattack", "FireUser1", "", 3.20, null);
		EntFire("stageZM_lever_button2", "AddOutput", "angles 0 0 0", 258.00, null);
		EntFire("map_shake", "FireUser3", "", 60.00, null);
		EntFire("map_hint_zmtemp", "Display", "", 43.00, null);
		EntFire("new_check_delay_15", "Kill", "", 79.50, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger map_nuke_stgZM:Enable::0.60:1", 83.00, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> ACTIVATING NEXT STAGE <<<:0.50:1", 82.00, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger new_check_case_stg:InValue:3:0.30:1", 81.00, null);
		EntFire("new_check_delay_*", "AddOutput", "OnTrigger map_nuke_stgZM:Enable::0.30:1", 80.00, null);
		EntFire("spx_owl_nade", "AddOutput", "origin 11789 -3461 -7304", 7.50, null);
		EntFire("spx_hat_nade", "AddOutput", "origin 12990 -3461 -7304", 7.50, null);
		EntFire("map_skybox_spawn", "Kill", "", 75.50, null);
		EntFire("map_soundsys_case", "InValue", "4", 228.50, null);
		EntFire("map_template_flycartrigs", "Kill", "", 0.60, null);
		EntFire("stageZM_towers_ldoors", "Kill", "", 225.20, null);
		EntFire("filter_class_xstg_*", "Kill", "", 0.20, null);
		EntFire("map_switch_*", "Kill", "", 3.60, null);
		EntFire("item_skin_maxi_*", "Kill", "", 0.30, null);
		EntFire("map_trigger_skins_m", "Kill", "", 0.30, null);
		EntFire("console", "Command", "zr_class_modify zombies health 17500", 0.06, null);
		EntFire("console", "Command", "sv_enablebunnyhopping 0", 0.04, null);
		EntFire("console", "Command", "zr_infect_mzombie_ratio 7", 0.02, null);
		EntFire("map_m_v", "Kill", "", 0.90, null);
		EntFire("mode_stage_acces", "FireUser1", "", 0.80, null);
		EntFire("map_soundsys_case", "FireUser1", "", 70.00, null);
		EntFire("stageZM_lever_prop2", "AddOutput", "angles 0 180 0", 46.50, null);
		EntFire("stageZM_doorslide2", "FireUser1", "", 41.00, null);
		EntFire("stageZM_doorslide2", "FireUser2", "", 44.50, null);
		EntFire("map_hint_zmtemp", "Kill", "", 49.00, null);
		EntFire("new_check_anyone", "AddOutput", "OnTrigger map_nuke_stgZM:Enable::2:1", 80.00, null);
	}
	else if(STAGE == 4 && !ONLYZMMOD)
	{
		EntFire("mode_stage_acces", "Break", "", 35, null);
		EntFire("map_zmfix_spawn", "Enable", "", 34, null);
		EntFire("mode_teleport_zm", "AddOutput", "OnStartTouch !activator:AddOutput:health 20000:0:-1", 8.5, null);
		EntFire("spxZM_emendo_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:health 20000:0:-1", 8.5, null);
		EntFire("map_zmfix_spawn", "AddOutput", "OnStartTouch !activator:AddOutput:health 20000:0:-1", 8.5, null);
		EntFire("mode_start_zm", "AddOutput", "origin -7744 -8001 1812", 8, null);
		EntFire("mode_start_ct", "AddOutput", "origin -7864 -8008 1812", 8, null);
		EntFire("mode_start_ct", "AddOutput", "angles 0 124 0", 8, null);
		EntFire("mode_start_zm", "AddOutput", "angles 0 180 0", 8, null);
		EntFire("console", "Command", "say >>> STAGE 4/12 - WIZARD MODE - NORMAL MODE <<<", 7, null);
		EntFire("map_adroom_opt_fixup", "FireUser1", "", 6, null);
		EntFire("console", "Command", "say >>> STAGE 4/12 - WIZARD MODE - NORMAL MODE <<<", 5, null);
		EntFire("map_sound_switch_nrml1", "PlaySound", "", 5, null);
		EntFire("map_sound_switch_nrml1", "AddOutput", "message #harrypotterze/stages/xxstg4beginningx.mp3", 1.00, null);
		EntFire("map_sound_switch_nrml2", "AddOutput", "message #harrypotterze/stages/xxstg4ministage1x.mp3", 1.00, null);
		EntFire("map_sound_switch_nrml1", "Volume", "10", 5.2, null);
		EntFire("map_texturetoggle", "SetTextureIndex", "4", 0, null);
		EntFire("filter_targets_block_multi", "FireUser1", "", 30, null);
		EntFire("filter_targets_block_multi", "FireUser3", "", 40, null);
		EntFire("admin_fixups", "Trigger", "", 11, null);
		EntFire("map_trigger_spawntele", "Disable", "", 75, null);
		EntFire("mode_teleport_*", "Enable", "", 75, null);
		EntFire("map_template_leversys", "ForceSpawn", "", 32, null);
		EntFire("map_leversys_brush", "AddOutput", "origin -10940 -4150 1786", 33, null);
		EntFire("map_leversys_brush", "AddOutput", "angles 0 90 0", 33, null);
		EntFire("map_wandrespawn", "Enable", "", 65, null);
		EntFire("map_radarfix_toggle", "SetTextureIndex", "5", 0, null);
		EntFire("console", "Command", "say >>> GATE BREAKING IN 6 SECONDS <<<", 29, null);
		EntFire("stage3_buttoncase", "AddOutput", "OnCase02 stage3_wizard_tolate_relay:FireUser1::10:1", 9, null);
		EntFire("map_boss_counter3", "SetHitMax", "4", 51.5, null);
		EntFire("stage3_torchsystem", "FireUser1", "", 25, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:LowerRandomBound:2:0.1:-1", 9.2, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:UpperRandomBound:4:0.1:-1", 10, null);
		EntFire("stage3_torchsystem", "InValue", "1", 20, null);
		EntFire("stage3_torchsystem", "InValue", "2", 38, null);
		EntFire("stage3_wizard_tolate_relay", "AddOutput", "OnTrigger stage3_wizard_template:FireUser1::1.5:1", 9, null);
		EntFire("map_template_props6", "AddOutput", "origin -3023 -14538 -8151", 45, null);
		EntFire("stage3_wizard_zmtriggers_*", "AddOutput", "OnStartTouch !activator:AddOutput:health 20000:0:-1", 8.5, null);
		EntFire("map_protection_off", "Enable", "", 37, null);
		EntFire("map_protection_on", "Disable", "", 36, null);
		EntFire("mapx*", "Kill", "", 3.5, null);
		EntFire("stage3_ex_*", "Kill", "", 0.5, null);
		EntFire("stageZM_*", "Kill", "", 3, null);
		EntFire("stage5_*", "Kill", "", 2.5, null);
		EntFire("stage4_*", "Kill", "", 2, null);
		EntFire("stage2_*", "Kill", "", 1.5, null);
		EntFire("stage1_*", "Kill", "", 1, null);
		EntFire("filter_stg5_end", "Kill", "", 0.3, null);
		EntFire("filter_prop*", "Kill", "", 0.3, null);
		EntFire("filter_m*", "Kill", "", 0.2, null);
		EntFire("filter_b*", "Kill", "", 0.2, null);
		EntFire("map_trigger_itemexitfix", "Enable", "", 72, null);
		EntFire("mode_teleport_ct", "Kill", "", 71, null);
		EntFire("mode_teleport_zm", "Kill", "", 71, null);
		EntFire("map_trigger_spawntele", "Enable", "", 70, null);
		EntFire("mode_teleport_both", "Enable", "", 70, null);
		EntFire("mode_teleport_*", "Disable", "", 69, null);
		EntFire("map_template_bossmover", "Kill", "", 0.1, null);
		EntFire("map_bossmover_*", "Kill", "", 0.1, null);
		EntFire("map_template_bossdropper", "Kill", "", 0.2, null);
		EntFire("map_bosssys_*", "Kill", "", 0.2, null);
		EntFire("filter_stg3_wizard_check3", "AddOutput", "OnPass lightworld:TurnOn::11.95:1", 9.2, null);
		EntFire("map_template_props6", "ForceSpawn", "", 46, null);
		EntFire("map_spwnr_prop6", "AddOutput", "targetname stage3_wizdrag3_hold_break", 49, null);
		EntFire("map_template_props6", "Kill", "", 53, null);
		EntFire("stage3_skyprops_d*", "TurnOff", "", 6.5, null);
		EntFire("masstele_stg*", "Kill", "", 4.2, null);
		EntFire("filter_class_physics", "Kill", "", 0.9, null);
		EntFire("map_skybox_clouds", "AddOutput", "targetname stage3_skyprops_clouds", 29.6, null);
		EntFire("map_skybox_template", "ForceSpawn", "", 29.3, null);
		EntFire("map_skybox_template", "AddOutput", "origin 13713 -14659 -13669", 8, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.4, null);
		EntFire("map_trigger_fasttele", "Enable", "", 75.5, null);
		EntFire("map_trigger_itemexitfix", "Kill", "", 75.4, null);
		EntFire("map_trigger_itemexitfix", "Disable", "", 74, null);
		EntFire("stage3_wizdrag4_template", "AddOutput", "OnUser1 mode_start_zm:AddOutput:origin 5583 -11872 1952:0:1", 9.5, null);
		EntFire("stage3_wizdrag4_template", "AddOutput", "OnUser1 mode_start_ct:AddOutput:origin 9456 -11872 1808:0:1", 9.5, null);
		EntFire("stage3_buttoncase", "FireUser1", "", 37, null);
		EntFire("map_protection_on", "Enable", "", 4.5, null);
		EntFire("map_protection_on", "Kill", "", 37, null);
		EntFire("mode_teleport_ct", "AddOutput", "OnStartTouch map_barrels_shaker:FireUser2::0.2:1", 10, null);
		EntFire("map_hint_case", "InValue", "16", 5.8, null);
		EntFire("map_hint_case", "InValue", "5", 5.7, null);
		EntFire("map_hint_case", "InValue", "15", 5.9, null);
		EntFire("map_hint_case", "FireUser3", "", 6.5, null);
		EntFire("map_template_rockattack", "FireUser1", "", 3.2, null);
		EntFire("map_shake", "FireUser3", "", 60, null);
		EntFire("new_check_delay_15", "Kill", "", 79.5, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger map_nuke_stg3:Enable::0.60:1", 83, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> ACTIVATING NEXT STAGE <<<:0.50:1", 82, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger new_check_case_stg:InValue:4:0.30:1", 81, null);
		EntFire("new_check_delay_*", "AddOutput", "OnTrigger map_nuke_stg3:Enable::0.30:1", 80, null);
		EntFire("spx_owl_nade", "AddOutput", "origin -11885 -5496 1776", 7.5, null);
		EntFire("spx_hat_nade", "AddOutput", "origin -14057 -4556 1776", 7.5, null);
		EntFire("map_skybox_spawn", "Kill", "", 75.5, null);
		EntFire("map_soundsys_case", "InValue", "4", 35.5, null);
		EntFire("map_template_flycartrigs", "Kill", "", 0.6, null);
		EntFire("filter_class_xstg_*", "Kill", "", 0.2, null);
		EntFire("map_spxHM_t", "SetTextureIndex", "1", 1.2, null);
		EntFire("map_spxZM_t", "SetTextureIndex", "0", 1.2, null);
		EntFire("console", "Command", "zr_class_modify zombies health 20000", 0.06, null);
		EntFire("console", "Command", "sv_enablebunnyhopping 0", 0.04, null);
		EntFire("console", "Command", "zr_infect_mzombie_ratio 7", 0.02, null);
		EntFire("map_template_bosscount", "ForceSpawn", "", 51, null);
		EntFire("map_template_bosscount", "Kill", "", 53, null);
		EntFire("map_m_v", "Kill", "", 0.4, null);
		EntFire("mode_stage_acces", "FireUser1", "", 0.8, null);
		EntFire("map_soundsys_case", "FireUser1", "", 70, null);
		EntFire("map_template_props1", "AddOutput", "OnUser1 !self:Kill::0:1", 9.7, null);
		EntFire("stage3_wizard_fog", "Kill", "", 0.9, null);
		EntFire("map_healthb_template", "FireUser2", "", 41, null);
		EntFire("stage3_wizdrag3_hedge1", "AddOutput", "origin -8774 -13821 -8180", 10.8, null);
		EntFire("stage3_wizdrag3_hedge2", "AddOutput", "origin -2765 -13683 -8180", 10.8, null);
		EntFire("stage3_wizdrag3_hedge*", "AddOutput", "angles 0 180 0", 10.6, null);
		EntFire("stage3_wizdrag3_hedge*", "ClearParent", "", 10.4, null);
		EntFire("stage3_wizdrag3_arrows", "Break", "", 10.2, null);
		EntFire("stage3_wizdrag3_arrows", "Kill", "", 10.25, null);
		EntFire("stage3_wizdrag3_afktele2", "Kill", "", 10.2, null);
		EntFire("map_template_props6", "ForceSpawn", "", 48, null);
		EntFire("map_template_props6", "AddOutput", "origin -2919 -12739 -8151", 47, null);
		EntFire("map_template_props6", "AddOutput", "angles 0 90 0", 47, null);
		EntFire("map_adroom_opt_weather", "Trigger", "", 4.4, null);
		EntFire("weathersys_temp_stg6", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg5", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg1", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg2", "Kill", "", 4.3, null);
		EntFire("map_fx_perm1", "FireUser2", "", 4.1, null);
		EntFire("map_adroom_opt_flycars", "Trigger", "", 36, null);
		EntFire("new_check_anyone", "AddOutput", "OnTrigger map_nuke_stg3:Enable::2:1", 80, null);
	}
	else if(STAGE == 5 && !ONLYZMMOD)
	{
		EntFire("mode_stage_acces", "Break", "", 35, null);
		EntFire("map_zmfix_spawn", "Enable", "", 34, null);
		EntFire("mode_teleport_zm", "AddOutput", "OnStartTouch !activator:AddOutput:health 30000:0:-1", 8.5, null);
		EntFire("spxZM_emendo_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:health 30000:0:-1", 8.5, null);
		EntFire("map_zmfix_spawn", "AddOutput", "OnStartTouch !activator:AddOutput:health 30000:0:-1", 8.5, null);
		EntFire("mode_start_zm", "AddOutput", "origin -12640 -314 -9997", 8, null);
		EntFire("mode_start_ct", "AddOutput", "origin -12635 -314 -9997", 8, null);
		EntFire("mode_start_*", "AddOutput", "angles 0 90 0", 8, null);
		EntFire("console", "Command", "say >>> STAGE 5/12 - NORMAL MODE <<<", 7, null);
		EntFire("map_adroom_opt_fixup", "FireUser1", "", 6, null);
		EntFire("console", "Command", "say >>> STAGE 5/12 - NORMAL MODE <<<", 5, null);
		EntFire("sun", "TurnOff", "", 5.00, null);
		EntFire("tone", "SetAutoExposureMax", "1", 5.00, null);
		EntFire("tone", "SetAutoExposureMin", "1", 5.00, null);
		EntFire("tone", "SetBloomScale", "1.75", 5.00, null);
		EntFire("lightworld", "TurnOff", "", 0.00, null);
		EntFire("sky_night", "Trigger", "", 5.00, null);
		EntFire("fog_cont", "SetColor", "111 111 111", 5.00, null);
		EntFire("fog_cont", "SetColorSecondary", "111 111 111", 5.00, null);
		EntFire("map_sound_switch_nrml1", "PlaySound", "", 5, null);
		EntFire("map_sound_switch_nrml1", "AddOutput", "message #harrypotterze/stages/xxstg5beginningx.mp3", 1.00, null);
		EntFire("map_sound_switch_nrml2", "AddOutput", "message #harrypotterze/stages/xxstg5bossfightspiderx.mp3", 1.00, null);
		EntFire("map_sound_switch_nrml1", "Volume", "10", 5.2, null);
		EntFire("map_texturetoggle", "SetTextureIndex", "5", 0, null);
		EntFire("filter_targets_block_multi", "FireUser1", "", 30, null);
		EntFire("stageZM_*", "Kill", "", 3, null);
		EntFire("stage5_*", "Kill", "", 2.5, null);
		EntFire("stage1_*", "Kill", "", 1, null);
		EntFire("stage3_*", "Kill", "", 2, null);
		EntFire("stage2_*", "Kill", "", 1.5, null);
		EntFire("filter_targets_block_multi", "FireUser3", "", 40, null);
		EntFire("mapx*", "Kill", "", 3.5, null);
		EntFire("admin_fixups", "Trigger", "", 11, null);
		EntFire("map_barrels_temp1", "ForceSpawn", "", 41, null);
		EntFire("map_barrelset1_brush", "AddOutput", "origin -15034 1824 -10049", 42, null);
		EntFire("map_barrelset1_brush", "AddOutput", "angles 0 270 0", 42, null);
		EntFire("map_trigger_spawntele", "Disable", "", 75, null);
		EntFire("mode_teleport_*", "Enable", "", 75, null);
		EntFire("map_leversys_brush", "AddOutput", "origin -14932 1784 -10060", 33, null);
		EntFire("map_leversys_brush", "AddOutput", "angles 0 90 0", 33, null);
		EntFire("map_template_leversys", "ForceSpawn", "", 32, null);
		EntFire("map_wandrespawn", "Enable", "", 65, null);
		EntFire("map_radarfix_toggle", "SetTextureIndex", "11", 0, null);
		EntFire("stage4_ex_*", "Kill", "", 0.5, null);
		EntFire("map_wandslevelZM", "Add", "3", 4, null);
		EntFire("map_template_props4", "AddOutput", "origin -11047 4298 -10241", 45, null);
		EntFire("console", "Command", "say >>> GATE BREAKING IN 6 SECONDS <<<", 29, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:LowerRandomBound:2:0.1:-1", 9.5, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:UpperRandomBound:4:0.1:-1", 10.5, null);
		EntFire("stage4_torchsystem", "InValue", "1", 20, null);
		EntFire("stage4_torchsystem", "InValue", "2", 35, null);
		EntFire("map_protection_off", "Enable", "", 37, null);
		EntFire("map_protection_on", "Disable", "", 36, null);
		EntFire("filter_prop_*", "Kill", "", 0.2, null);
		EntFire("filter_stg5_end", "Kill", "", 0.2, null);
		EntFire("filter_wiz_*", "Kill", "", 0.2, null);
		EntFire("filter_b*", "Kill", "", 0.2, null);
		EntFire("map_trigger_itemexitfix", "Enable", "", 72, null);
		EntFire("mode_teleport_ct", "Kill", "", 71, null);
		EntFire("mode_teleport_zm", "Kill", "", 71, null);
		EntFire("mode_start_ct", "Kill", "", 71, null);
		EntFire("map_trigger_spawntele", "Enable", "", 70, null);
		EntFire("mode_teleport_both", "Enable", "", 70, null);
		EntFire("mode_teleport_*", "Disable", "", 69, null);
		EntFire("stage4_forest_fog", "Kill", "", 0.3, null);
		EntFire("stage4_slidedoor2B", "AddOutput", "OnUser1 !self:Close::0:1", 9, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 350 0", 45, null);
		EntFire("map_template_props4", "ForceSpawn", "", 45.1, null);
		EntFire("map_template_props4", "AddOutput", "origin -11051 4239 -10241", 45.2, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 359 0", 45.2, null);
		EntFire("map_template_props4", "ForceSpawn", "", 45.3, null);
		EntFire("map_template_props4", "AddOutput", "origin -11049 4184 -10241", 45.4, null);
		EntFire("map_template_props4", "AddOutput", "angles 0 7 0", 45.4, null);
		EntFire("map_template_props4", "ForceSpawn", "", 45.5, null);
		EntFire("map_bosssys_comp", "SetCompareValue", "1", 10, null);
		EntFire("masstele_stg1*", "Kill", "", 4.2, null);
		EntFire("masstele_stg2*", "Kill", "", 4.2, null);
		EntFire("masstele_stg5*", "Kill", "", 4.2, null);
		EntFire("map_skybox_template", "Kill", "", 73, null);
		EntFire("map_skybox_clouds", "AddOutput", "targetname stage4_skyprops_clouds", 29.8, null);
		EntFire("map_skybox_template", "ForceSpawn", "", 29.2, null);
		EntFire("map_skybox_template", "AddOutput", "origin 14192 -13847 -14628", 7.2, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.4, null);
		EntFire("map_trigger_fasttele", "Enable", "", 75.5, null);
		EntFire("map_trigger_itemexitfix", "Kill", "", 75.4, null);
		EntFire("map_trigger_itemexitfix", "Disable", "", 74, null);
		EntFire("map_skybox_template", "AddOutput", "origin 13483 -14225 -14488", 29.4, null);
		EntFire("map_skybox_template", "ForceSpawn", "", 29.6, null);
		EntFire("stage4_buttoncase", "FireUser1", "", 31, null);
		EntFire("map_protection_on", "Enable", "", 4.5, null);
		EntFire("map_protection_on", "Kill", "", 37, null);
		EntFire("map_spwnr_prop8_s*", "Kill", "", 34.5, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "targetname map_spwnr_prop8_x", 34.2, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "origin -13865 1175 -10075", 34.1, null);
		EntFire("map_template_props8", "ForceSpawn", "", 34, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "targetname map_spwnr_prop8_x", 33.9, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "origin -13357 1175 -10075", 33.8, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33.7, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "targetname map_spwnr_prop8_x", 33.6, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "origin -12341 1175 -10075", 33.5, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33.4, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "targetname map_spwnr_prop8_x", 33.3, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "origin -11833 1175 -10075", 33.2, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33.1, null);
		EntFire("mode_teleport_ct", "AddOutput", "OnStartTouch map_barrels_shaker:FireUser2::0.2:1", 10, null);
		EntFire("map_hint_case", "InValue", "16", 5.8, null);
		EntFire("map_hint_case", "InValue", "6", 5.4, null);
		EntFire("map_hint_msg8C", "Kill", "", 5.9, null);
		EntFire("map_hint_case", "FireUser3", "", 6.5, null);
		EntFire("map_template_rockattack", "FireUser1", "", 3.2, null);
		EntFire("map_shake", "FireUser3", "", 60, null);
		EntFire("new_check_delay_15", "Kill", "", 79.5, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger map_nuke_stg4:Enable::0.60:1", 83, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> ACTIVATING NEXT STAGE <<<:0.50:1", 82, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger new_check_case_stg:InValue:5:0.30:1", 81, null);
		EntFire("new_check_delay_*", "AddOutput", "OnTrigger map_nuke_stg4:Enable::0.30:1", 80, null);
		EntFire("spx_owl_nade", "AddOutput", "origin -13604 1671 -10059", 7.5, null);
		EntFire("spx_hat_nade", "AddOutput", "origin -14920 678 -10059", 7.5, null);
		EntFire("map_skybox_spawn", "Kill", "", 75.5, null);
		EntFire("map_soundsys_case", "InValue", "2", 38, null);
		EntFire("map_soundsys_case", "InValue", "4", 39, null);
		EntFire("map_template_flycartrigs", "Kill", "", 0.6, null);
		EntFire("filter_class_xstg_*", "Kill", "", 0.3, null);
		EntFire("map_switch_*", "Kill", "", 3.6, null);
		EntFire("map_spxHM_t", "SetTextureIndex", "1", 1.2, null);
		EntFire("map_spxZM_t", "SetTextureIndex", "0", 1.2, null);
		EntFire("console", "Command", "zr_class_modify zombies health 30000", 0.06, null);
		EntFire("console", "Command", "sv_enablebunnyhopping 0", 0.04, null);
		EntFire("console", "Command", "zr_infect_mzombie_ratio 6", 0.02, null);
		EntFire("map_template_bosscount", "ForceSpawn", "", 34, null);
		EntFire("map_template_bosscount", "Kill", "", 35, null);
		EntFire("map_m_v", "Kill", "", 0.3, null);
		EntFire("mode_stage_acces", "FireUser1", "", 0.8, null);
		EntFire("map_soundsys_case", "FireUser1", "", 70, null);
		EntFire("map_adroom_opt_weather", "Trigger", "", 4.4, null);
		EntFire("weathersys_temp_stg6", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg1", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg4", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg2", "Kill", "", 4.3, null);
		EntFire("map_fx_perm1", "FireUser2", "", 4.1, null);
		EntFire("map_adroom_opt_flycars", "Trigger", "", 36, null);
		EntFire("new_check_anyone", "AddOutput", "OnTrigger map_nuke_stg4:Enable::2:1", 80, null);
	}
	else if(STAGE == 6 && !ONLYZMMOD)
	{
		EntFire("mode_stage_acces", "Break", "", 35, null);
		EntFire("map_zmfix_spawn", "Enable", "", 34, null);
		EntFire("mode_teleport_zm", "AddOutput", "OnStartTouch !activator:AddOutput:health 50000:0:-1", 8.5, null);
		EntFire("spxZM_emendo_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:health 50000:0:-1", 8.5, null);
		EntFire("map_zmfix_spawn", "AddOutput", "OnStartTouch !activator:AddOutput:health 50000:0:-1", 8.5, null);
		EntFire("mode_start_ct", "AddOutput", "origin -13290 15299 -15259", 8, null);
		EntFire("mode_start_zm", "AddOutput", "origin -13290 15407 -15259", 8, null);
		EntFire("mode_start_*", "AddOutput", "angles 0 270 0", 8, null);
		EntFire("console", "Command", "say >>> STAGE 6/12 - NORMAL MODE <<<", 7, null);
		EntFire("map_adroom_opt_fixup", "FireUser1", "", 6, null);
		EntFire("console", "Command", "say >>> STAGE 6/12 - NORMAL MODE <<<", 5, null);
		EntFire("world", "AddOutput", "OnUser1 map_stages_counter:SetValueNoFire:7:0:1", 4, null);
		EntFire("map_sound_switch_nrml1", "PlaySound", "", 5, null);
		EntFire("map_sound_switch_nrml1", "AddOutput", "message #harrypotterze/stages/xxstg6beginningx.mp3", 1.00, null);
		EntFire("map_sound_switch_nrml2", "AddOutput", "message #harrypotterze/stages/xxstg6bossfightcourtx.mp3", 1.00, null);
		EntFire("map_sound_switch_nrml1", "Volume", "10", 5.2, null);
		EntFire("map_texturetoggle", "SetTextureIndex", "6", 0, null);
		EntFire("filter_targets_block_multi", "FireUser1", "", 30, null);
		EntFire("stageZM_*", "Kill", "", 3, null);
		EntFire("stage1_*", "Kill", "", 1, null);
		EntFire("stage4_*", "Kill", "", 2.5, null);
		EntFire("stage3_*", "Kill", "", 2, null);
		EntFire("stage2_*", "Kill", "", 1.5, null);
		EntFire("filter_targets_block_multi", "FireUser3", "", 40, null);
		EntFire("mapx*", "Kill", "", 3.5, null);
		EntFire("admin_fixups", "Trigger", "", 11, null);
		EntFire("map_barrels_temp1", "ForceSpawn", "", 29, null);
		EntFire("map_barrels_temp1", "ForceSpawn", "", 30.5, null);
		EntFire("map_barrelset1_brush", "AddOutput", "origin -13182 12576 -15312", 29.5, null);
		EntFire("map_barrelset1_brush", "AddOutput", "angles 0 90 0", 29.5, null);
		EntFire("map_barrelset1_brush", "AddOutput", "origin -13409 12576 -15312", 31, null);
		EntFire("map_barrelset1_brush", "AddOutput", "angles 0 90 0", 31, null);
		EntFire("map_trigger_spawntele", "Disable", "", 75, null);
		EntFire("mode_teleport_*", "Enable", "", 75, null);
		EntFire("map_template_leversys", "ForceSpawn", "", 32, null);
		EntFire("map_leversys_brush", "AddOutput", "origin -13298 12592 -15323", 33, null);
		EntFire("map_leversys_brush", "AddOutput", "angles 0 90 0", 33, null);
		EntFire("map_wandrespawn", "Enable", "", 65, null);
		EntFire("map_radarfix_toggle", "SetTextureIndex", "12", 0, null);
		EntFire("stage5_ex_*", "Kill", "", 0.5, null);
		EntFire("map_wandslevelZM", "Add", "4", 4, null);
		EntFire("console", "Command", "say >>> GATE BREAKING IN 6 SECONDS <<<", 29, null);
		EntFire("stage5_case1", "FireUser1", "", 31, null);
		EntFire("stage5_buttoncase", "AddOutput", "OnCase02 stage5_hold_r_breakdoor:FireUser1::5:1", 9, null);
		EntFire("stage5_buttoncase", "AddOutput", "OnCase03 stage5_hold_l_breakdoor:FireUser1::5:1", 9, null);
		EntFire("stage5_case1", "AddOutput", "OnUser3 stage5_compare1:FireUser1::0:1", 9, null);
		EntFire("stage5_miniboss_break1", "AddOutput", "OnBreak stage5_slidedoor1:FireUser1::0:1", 9, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:LowerRandomBound:2:0.1:-1", 9.5, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:UpperRandomBound:4:0.1:-1", 10, null);
		EntFire("map_barrelset1_*", "ClearParent", "", 29.8, null);
		EntFire("map_barrelset1_brush", "Kill", "", 30, null);
		EntFire("stage5_torchsystem", "InValue", "1", 20, null);
		EntFire("map_protection_off", "Enable", "", 37, null);
		EntFire("map_protection_on", "Disable", "", 36, null);
		EntFire("filter_prop*", "Kill", "", 0.4, null);
		EntFire("filter_stg3*", "Kill", "", 0.4, null);
		EntFire("filter_wiz_*", "Kill", "", 0.4, null);
		EntFire("filter_b*", "Kill", "", 0.2, null);
		EntFire("filter_m*", "Kill", "", 0.2, null);
		EntFire("map_trigger_itemexitfix", "Enable", "", 72, null);
		EntFire("mode_teleport_ct", "Kill", "", 71, null);
		EntFire("mode_teleport_zm", "Kill", "", 71, null);
		EntFire("mode_start_ct", "Kill", "", 71, null);
		EntFire("map_trigger_spawntele", "Enable", "", 70, null);
		EntFire("mode_teleport_both", "Enable", "", 70, null);
		EntFire("mode_teleport_*", "Disable", "", 69, null);
		EntFire("stage5_n_death1_spawn", "AddOutput", "OnTrigger stage5_boss_end_break1:FireUser3::7:1", 9.5, null);
		EntFire("masstele_stg1*", "Kill", "", 4.2, null);
		EntFire("masstele_stg2*", "Kill", "", 4.2, null);
		EntFire("masstele_stg4*", "Kill", "", 4.2, null);
		EntFire("map_skybox_template", "Kill", "", 73, null);
		EntFire("map_skybox_clouds", "AddOutput", "targetname stage5_skyprops_clouds", 29.6, null);
		EntFire("stage5_case1", "FireUser2", "", 29.1, null);
		EntFire("map_skybox_template", "AddOutput", "origin 14561 -13442 -14815", 8, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.4, null);
		EntFire("map_trigger_fasttele", "Enable", "", 75.5, null);
		EntFire("stage5_miniboss_break1", "AddOutput", "OnBreak map_sound_switch_drags:AddOutput:message harrypotterze/bosses/xspeech_voldemort_stg6x.mp3:0.20:1", 10, null);
		EntFire("map_sound_switch_drags", "AddOutput", "message harrypotterze/bosses/xscream_fluffy_1x.mp3", 10, null);
		EntFire("map_trigger_itemexitfix", "Kill", "", 75.4, null);
		EntFire("map_trigger_itemexitfix", "Disable", "", 74, null);
		EntFire("stage5_buttoncase", "FireUser1", "", 36, null);
		EntFire("map_protection_on", "Enable", "", 4.5, null);
		EntFire("map_protection_on", "Kill", "", 37, null);
		EntFire("map_spwnr_prop8_b*", "Kill", "", 35, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 34.7, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin -11748 13278 -15334", 34.6, null);
		EntFire("map_template_props8", "ForceSpawn", "", 34.5, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 34.4, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin -14326 13278 -15334", 34.3, null);
		EntFire("map_template_props8", "ForceSpawn", "", 34.2, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 34.1, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin -12255 13278 -15334", 34, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33.9, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 33.8, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin -14833 13278 -15334", 33.7, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33.6, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 33.5, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin -13291 14377 -15334", 33.4, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "angles 0 180 0", 33.4, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33.3, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 33.2, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin -13291 15035 -15334", 33.1, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "angles 0 180 0", 33.1, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33, null);
		EntFire("mode_teleport_ct", "AddOutput", "OnStartTouch map_barrels_shaker:FireUser2::0.2:1", 10, null);
		EntFire("map_hint_case", "InValue", "16", 5.8, null);
		EntFire("map_hint_case", "InValue", "7", 5.4, null);
		EntFire("map_hint_msg8C", "Kill", "", 5.9, null);
		EntFire("map_hint_case", "FireUser3", "", 6.5, null);
		EntFire("map_template_rockattack", "FireUser1", "", 3.2, null);
		EntFire("map_shake", "FireUser3", "", 60, null);
		EntFire("new_check_delay_15", "Kill", "", 79.5, null);
		EntFire("map_hints_text_all", "AddOutput", "targetname map_hint_timeleft", 87.8, null);
		EntFire("map_hints_text_all", "AddOutput", "color 255 255 72", 87.4, null);
		EntFire("map_hints_text_all", "AddOutput", "holdtime 2", 87.4, null);
		EntFire("map_hints_text_all", "AddOutput", "channel 1", 87.4, null);
		EntFire("map_hints_temp_all", "ForceSpawn", "", 87, null);
		EntFire("map_hints_text_all", "AddOutput", "targetname map_hint_end", 86.9, null);
		EntFire("map_hints_text_all", "AddOutput", "message ZE_HARRY_POTTER_V2\nCONGRATULATIONS\nFIRST 6 STAGE COMPLETE\nNORMAL MODE COMPLETE\nACTIVATING EXTREME MODE\nTHANKS FOR PLAYING\nCREATION BY SKULLZ AND DEVIOUS", 86.6, null);
		EntFire("map_hints_text_all", "AddOutput", "color 255 255 72", 86.3, null);
		EntFire("map_hints_text_all", "AddOutput", "holdtime 6", 86.3, null);
		EntFire("map_hints_text_all", "AddOutput", "channel 1", 86.3, null);
		EntFire("map_hints_temp_all", "ForceSpawn", "", 86, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> ACTIVATING EXTREME MODE <<<:0.60:1", 85, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger map_nuke_stg5:Enable::0.60:1", 84, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> NORMAL MODE COMPLETE <<<:0.50:1", 83, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger new_check_case_stg:InValue:6:0.30:1", 82, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger world:FireUser4::0.20:1", 81, null);
		EntFire("new_check_delay_*", "AddOutput", "OnTrigger map_nuke_stg5:Enable::0.30:1", 80, null);
		EntFire("spx_owl_nade", "AddOutput", "origin -11356 13026 -15322", 7.5, null);
		EntFire("spx_hat_nade", "AddOutput", "origin -15227 13529 -15322", 7.5, null);
		EntFire("map_skybox_spawn", "Kill", "", 75.5, null);
		EntFire("map_soundsys_case", "InValue", "2", 35.5, null);
		EntFire("map_soundsys_case", "InValue", "4", 36.5, null);
		EntFire("map_template_flycartrigs", "Kill", "", 0.3, null);
		EntFire("filter_class_xstg_*", "Kill", "", 0.3, null);
		EntFire("map_trigger_skins_h", "Kill", "", 0.6, null);
		EntFire("item_skin_hp_*", "Kill", "", 0.6, null);
		EntFire("map_trigger_skins_v", "Kill", "", 0.6, null);
		EntFire("item_skin_vold_*", "Kill", "", 0.6, null);
		EntFire("map_spxHM_t", "SetTextureIndex", "2", 1.2, null);
		EntFire("map_spxZM_t", "SetTextureIndex", "2", 1.2, null);
		EntFire("console", "Command", "zr_class_modify zombies health 50000", 0.06, null);
		EntFire("console", "Command", "sv_enablebunnyhopping 0", 0.04, null);
		EntFire("console", "Command", "zr_infect_mzombie_ratio 6", 0.02, null);
		EntFire("map_soundsys_case", "InValue", "13", 10.5, null);
		EntFire("map_template_bosscount", "ForceSpawn", "", 34, null);
		EntFire("map_skybox_template", "ForceSpawn", "", 29.4, null);
		EntFire("map_bosssys_comp", "SetCompareValue", "1", 9.5, null);
		EntFire("stage5_n_death2_spawn", "Kill", "", 0.7, null);
		EntFire("stage5_n_death2_life", "Kill", "", 0.7, null);
		EntFire("filter_deatheather_t2", "Kill", "", 0.1, null);
		EntFire("stage5_n_death2_c3", "Kill", "", 0.8, null);
		EntFire("stage5_n_death2_c2", "Kill", "", 0.8, null);
		EntFire("stage5_n_death2_c1", "Kill", "", 0.8, null);
		EntFire("stage5_n_death2_thrust_t_fr", "Kill", "", 0.9, null);
		EntFire("stage5_n_death2_thrust_t_r1", "Kill", "", 0.9, null);
		EntFire("stage5_n_death2_thrust_t_l1", "Kill", "", 0.9, null);
		EntFire("stage5_n_death2_thrust_t_r2", "Kill", "", 0.9, null);
		EntFire("stage5_n_death2_thrust_t_l2", "Kill", "", 0.9, null);
		EntFire("stage5_n_death2_gettarget", "ClearParent", "", 1.1, null);
		EntFire("stage5_n_death2_gettarget", "Kill", "", 1.3, null);
		EntFire("map_soundsys_case", "FireUser1", "", 70, null);
		EntFire("map_adroom_opt_weather", "Trigger", "", 4.4, null);
		EntFire("weathersys_temp_stg1", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg5", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg4", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg2", "Kill", "", 4.3, null);
		EntFire("map_fx_perm1", "FireUser2", "", 4.1, null);
		EntFire("map_adroom_opt_flycars", "Trigger", "", 36, null);
		EntFire("new_check_anyone", "AddOutput", "OnTrigger map_nuke_stg5:Enable::2:1", 80, null);
	}
	else if(STAGE == 7 && !ONLYZMMOD)
	{
		EntFire("map_trigger_spawntele", "Disable", "", 75, null);
		EntFire("mode_teleport_*", "Enable", "", 75, null);
		EntFire("filter_targets_block_multi", "FireUser3", "", 40, null);
		EntFire("mode_stage_acces", "Break", "", 35, null);
		EntFire("map_zmfix_spawn", "Enable", "", 34, null);
		EntFire("map_leversys_brush", "AddOutput", "origin -6410 -422 13187", 33, null);
		EntFire("map_leversys_brush", "AddOutput", "angles 0 90 0", 33, null);
		EntFire("map_template_leversys", "ForceSpawn", "", 32, null);
		EntFire("filter_targets_block_multi", "FireUser1", "", 30, null);
		EntFire("mode_teleport_zm", "AddOutput", "OnStartTouch !activator:AddOutput:health 15000:0:-1", 8.5, null);
		EntFire("spxZM_emendo_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:health 15000:0:-1", 8.5, null);
		EntFire("map_zmfix_spawn", "AddOutput", "OnStartTouch !activator:AddOutput:health 15000:0:-1", 8.5, null);
		EntFire("stageZM_*", "Kill", "", 3, null);
		EntFire("mapx*", "Kill", "", 3.5, null);
		EntFire("stage4_*", "Kill", "", 2, null);
		EntFire("stage5_*", "Kill", "", 2.5, null);
		EntFire("stage2_*", "Kill", "", 1, null);
		EntFire("stage3_*", "Kill", "", 1.5, null);
		EntFire("world", "AddOutput", "OnUser1 map_stages_counter:SetValueNoFire:2:0:1", 4, null);
		EntFire("world", "AddOutput", "OnUser4 map_stages_extreme:FireUser1::0:1", 4, null);
		EntFire("console", "Command", "say >>> STAGE 7/12 - EXTREME MODE <<<", 7, null);
		EntFire("zad_comp_ex", "SetCompareValue", "1", 4, null);
		EntFire("map_sound_switch_xtrm1", "Volume", "10", 5.2, null);
		EntFire("map_adroom_opt_fixup", "FireUser1", "", 6, null);
		EntFire("map_sound_switch_xtrm1", "PlaySound", "", 5, null);
		EntFire("console", "Command", "say >>> STAGE 7/12 - EXTREME MODE <<<", 5, null);
		EntFire("stage1_boss_template1", "AddOutput", "OnEntitySpawned stage1_boss_boxxes:Break::0.2:1", 9, null);
		EntFire("console", "Command", "say >>> GATE BREAKING IN 6 SECONDS <<<", 29, null);
		EntFire("stage1_court_boxxes", "AddOutput", "OnBreak stage1_breakdoor4:FireUser2::0:1", 9, null);
		EntFire("stage1_rotdoor1", "FireUser1", "", 36, null);
		EntFire("map_sound_switch_xtrm2", "AddOutput", "message #harrypotterze/stages/xxstg7bossfightvoldemortx.mp3", 1.00, null);
		EntFire("map_sound_switch_xtrm1", "AddOutput", "message #harrypotterze/stages/xxstg7beginningxx.mp3", 1.00, null);
		EntFire("map_texturetoggle", "SetTextureIndex", "7", 0, null);
		EntFire("stage1_chess_counter", "AddOutput", "OnHitMax stage1_chess_model*:SetHealth:600:1:1", 9, null);
		EntFire("stage1_chess_model*", "SetHealth", "300", 68, null);
		EntFire("stage1_boss_ending", "AddOutput", "OnStartTouch stage1_rotdoor3:FireUser2::0:1", 9, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:LowerRandomBound:2:0.1:-1", 8, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:UpperRandomBound:3:0.1:-1", 8.1, null);
		EntFire("stage1_torchsystem", "InValue", "1", 20, null);
		EntFire("admin_fixups", "Trigger", "", 11, null);
		EntFire("stage1_torchsystem", "FireUser1", "", 33, null);
		EntFire("map_template_torch_noprop2", "ForceSpawn", "", 44, null);
		EntFire("map_template_torch_noprop2", "AddOutput", "origin -7321 -902 12870", 43, null);
		EntFire("map_template_torch_noprop2", "ForceSpawn", "", 42, null);
		EntFire("map_template_torch_noprop2", "AddOutput", "origin -7321 60 12870", 41, null);
		EntFire("map_protection_off", "Enable", "", 37, null);
		EntFire("map_protection_on", "Disable", "", 36, null);
		EntFire("filter_stg*", "Kill", "", 0.4, null);
		EntFire("filter_wiz_*", "Kill", "", 0.4, null);
		EntFire("filter_b*", "Kill", "", 0.2, null);
		EntFire("filter_prop*", "Kill", "", 0.2, null);
		EntFire("map_trigger_itemexitfix", "Enable", "", 72, null);
		EntFire("mode_teleport_ct", "Kill", "", 71, null);
		EntFire("mode_teleport_zm", "Kill", "", 71, null);
		EntFire("mode_start_ct", "Kill", "", 71, null);
		EntFire("map_trigger_spawntele", "Enable", "", 70, null);
		EntFire("mode_teleport_both", "Enable", "", 70, null);
		EntFire("mode_teleport_*", "Disable", "", 69, null);
		EntFire("map_template_bossmover", "Kill", "", 0.1, null);
		EntFire("map_bossmover_*", "Kill", "", 0.1, null);
		EntFire("map_bosssys_comp", "AddOutput", "OnEqualTo map_template_bossdropper:AddOutput:origin -8912 -11007 11016:0:-1", 10, null);
		EntFire("map_bosssys_comp", "AddOutput", "OnEqualTo map_template_bossdropper:ForceSpawn::1:-1", 10.2, null);
		EntFire("masstele_stg2*", "Kill", "", 4.2, null);
		EntFire("masstele_stg4*", "Kill", "", 4.2, null);
		EntFire("masstele_stg5*", "Kill", "", 4.2, null);
		EntFire("filter_class_physics", "Kill", "", 0.6, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.4, null);
		EntFire("map_trigger_fasttele", "Enable", "", 75.5, null);
		EntFire("map_trigger_itemexitfix", "Kill", "", 75.4, null);
		EntFire("map_trigger_itemexitfix", "Disable", "", 74, null);
		EntFire("weathersys_temp_stg2", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg4", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg5", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg6", "Kill", "", 4.3, null);
		EntFire("map_adroom_opt_weather", "Trigger", "", 4.4, null);
		EntFire("stage1_chess_boss", "AddOutput", "OnTrigger stage1_torchsystem:InValue:9:30:1", 8, null);
		EntFire("stage1_buttoncase", "FireUser1", "", 38.5, null);
		EntFire("stage1_buttoncase", "FireUser3", "", 38, null);
		EntFire("map_protection_on", "Enable", "", 4.5, null);
		EntFire("map_protection_on", "Kill", "", 37, null);
		EntFire("map_shake", "StartShake", "", 5.2, null);
		EntFire("mode_teleport_ct", "AddOutput", "OnStartTouch map_barrels_shaker:FireUser2::0.2:1", 10, null);
		EntFire("map_hint_case", "FireUser3", "", 6.5, null);
		EntFire("map_hint_msg8C", "Kill", "", 5.9, null);
		EntFire("map_hint_case", "InValue", "16", 5.8, null);
		EntFire("map_hint_case", "InValue", "8", 5.4, null);
		EntFire("stage1_chess_case", "FireUser1", "", 64, null);
		EntFire("map_shake", "FireUser3", "", 60, null);
		EntFire("new_check_delay_20", "Kill", "", 79.5, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger map_nuke_stg1:Enable::0.60:1", 83, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> ACTIVATING NEXT STAGE <<<:0.50:1", 82, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger new_check_case_stg:InValue:1:0.30:1", 81, null);
		EntFire("new_check_delay_*", "AddOutput", "OnTrigger map_nuke_stg1:Enable::0.30:1", 80, null);
		EntFire("spx_owl_nade", "AddOutput", "origin -7091 -942 12850", 7.5, null);
		EntFire("spx_hat_nade", "AddOutput", "origin -7438 100 12850", 7.5, null);
		EntFire("map_skybox_spawn", "Kill", "", 75.5, null);
		EntFire("map_soundsys_case", "InValue", "2", 35.5, null);
		EntFire("map_soundsys_case", "InValue", "4", 36.5, null);
		EntFire("filter_class_xstg_*", "Kill", "", 0.2, null);
		EntFire("map_switch_*", "Kill", "", 3.6, null);
		EntFire("item_skin_herm_*", "Kill", "", 0.9, null);
		EntFire("item_skin_luna_*", "Kill", "", 0.9, null);
		EntFire("map_trigger_skins_l", "Kill", "", 0.9, null);
		EntFire("map_trigger_skins_he", "Kill", "", 0.9, null);
		EntFire("map_trigger_skins_v", "Kill", "", 0.9, null);
		EntFire("item_skin_vold_*", "Kill", "", 0.9, null);
		EntFire("mode_stage_acces", "FireUser1", "", 0.8, null);
		EntFire("spx_skin1", "Kill", "", 0.7, null);
		EntFire("console", "Command", "zr_class_modify zombies health 20000", 0.06, null);
		EntFire("console", "Command", "sv_enablebunnyhopping 1", 0.04, null);
		EntFire("map_template_bosscount", "ForceSpawn", "", 34, null);
		EntFire("map_template_bosscount", "Kill", "", 35, null);
		EntFire("map_soundsys_case", "FireUser1", "", 70, null);
		EntFire("map_adroom_opt_flycars", "Trigger", "", 36, null);
		EntFire("map_fx_perm1", "FireUser1", "", 3.8, null);
		EntFire("map_fx_perm1", "FireUser2", "", 4.1, null);
		EntFire("new_check_anyone", "AddOutput", "OnTrigger map_nuke_stg1:Enable::2:1", 80, null);
	}
	else if(STAGE == 8 && !ONLYZMMOD)
	{
		EntFire("mode_stage_acces", "Break", "", 35, null);
		EntFire("map_zmfix_spawn", "Enable", "", 34, null);
		EntFire("mode_teleport_zm", "AddOutput", "OnStartTouch !activator:AddOutput:health 20000:0:-1", 8.5, null);
		EntFire("spxZM_emendo_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:health 20000:0:-1", 8.5, null);
		EntFire("map_zmfix_spawn", "AddOutput", "OnStartTouch !activator:AddOutput:health 20000:0:-1", 8.5, null);
		EntFire("mode_start_ct", "AddOutput", "origin 11625 5704 6304", 8, null);
		EntFire("mode_start_zm", "AddOutput", "origin 11625 5740 6304", 8, null);
		EntFire("mode_start_*", "AddOutput", "angles 0 270 0", 8, null);
		EntFire("console", "Command", "say >>> STAGE 8/12 - EXTREME MODE <<<", 7, null);
		EntFire("map_adroom_opt_fixup", "FireUser1", "", 6, null);
		EntFire("console", "Command", "say >>> STAGE 8/12 - EXTREME MODE <<<", 5, null);
		EntFire("map_sound_switch_xtrm1", "PlaySound", "", 5, null);
		EntFire("map_sound_switch_xtrm1", "AddOutput", "message #harrypotterze/stages/xxstg8beginningx.mp3", 1.00, null);
		EntFire("map_sound_switch_xtrm2", "AddOutput", "message #harrypotterze/stages/xxstg8bossfightsnakex.mp3", 1.00, null);
		EntFire("map_sound_switch_xtrm1", "Volume", "10", 5.2, null);
		EntFire("map_texturetoggle", "SetTextureIndex", "8", 0, null);
		EntFire("filter_targets_block_multi", "FireUser1", "", 30, null);
		EntFire("stageZM_*", "Kill", "", 3, null);
		EntFire("stage5_*", "Kill", "", 2.5, null);
		EntFire("stage4_*", "Kill", "", 2, null);
		EntFire("stage3_*", "Kill", "", 1.5, null);
		EntFire("stage1_*", "Kill", "", 1, null);
		EntFire("filter_targets_block_multi", "FireUser3", "", 40, null);
		EntFire("mapx*", "Kill", "", 3.5, null);
		EntFire("admin_fixups", "Trigger", "", 11, null);
		EntFire("map_trigger_spawntele", "Disable", "", 75, null);
		EntFire("mode_teleport_*", "Enable", "", 75, null);
		EntFire("zad_comp_ex", "SetCompareValue", "1", 4, null);
		EntFire("stage2_boxes", "Break", "", 10, null);
		EntFire("console", "Command", "say >>> GATE BREAKING IN 6 SECONDS <<<", 29, null);
		EntFire("stage2_tunnel_breaks", "AddOutput", "OnBreak stage2_rotdoor7b:FireUser2::0:1", 9, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:LowerRandomBound:2:0.1:-1", 10.5, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:UpperRandomBound:3:0.1:-1", 10.6, null);
		EntFire("stage2_torchsystem", "InValue", "1", 20, null);
		EntFire("stage2_miniboss_toilet_temp", "AddOutput", "OnEntitySpawned stage2_miniboss_toilet_exp:AddOutput:iMagnitude 65:0:-1", 9, null);
		EntFire("stage2_updoor2", "AddOutput", "OnUser2 map_boss_case_debug:FireUser2::0:1", 9, null);
		EntFire("stage2_updoor3", "AddOutput", "OnFullyOpen !self:Lock::0:1", 9, null);
		EntFire("stage2_boss_template1", "AddOutput", "OnUser1 console:Command:say >>> DEFEND THE LAST HOLD POINT FOR 40 SECONDS <<<:0:1", 10.1, null);
		EntFire("stage2_boss_template1", "AddOutput", "OnUser2 console:Command:say >>> DEFEND THE LAST HOLD POINT FOR 30 SECONDS <<<:0:1", 10.2, null);
		EntFire("stage2_boss_template1", "AddOutput", "OnUser3 console:Command:say >>> DEFEND THE LAST HOLD POINT FOR 20 SECONDS <<<:0:1", 10.3, null);
		EntFire("stage2_boss_template1", "AddOutput", "OnUser4 console:Command:say >>> DEFEND THE LAST HOLD POINT FOR 10 SECONDS <<<:0:1", 10.4, null);
		EntFire("map_protection_off", "Enable", "", 37, null);
		EntFire("map_protection_on", "Disable", "", 36, null);
		EntFire("filter_prop*", "Kill", "", 0.2, null);
		EntFire("filter_stg*", "Kill", "", 0.2, null);
		EntFire("filter_wiz_*", "Kill", "", 0.2, null);
		EntFire("filter_b*", "Kill", "", 0.3, null);
		EntFire("filter_m*", "Kill", "", 0.3, null);
		EntFire("map_trigger_itemexitfix", "Enable", "", 72, null);
		EntFire("mode_teleport_ct", "Kill", "", 71, null);
		EntFire("mode_teleport_zm", "Kill", "", 71, null);
		EntFire("mode_start_ct", "Kill", "", 71, null);
		EntFire("map_trigger_spawntele", "Enable", "", 70, null);
		EntFire("mode_teleport_both", "Enable", "", 70, null);
		EntFire("mode_teleport_*", "Disable", "", 69, null);
		EntFire("stage2_miniboss_compare", "SetCompareValue", "1", 9.5, null);
		EntFire("stage2_miniboss_compare", "AddOutput", "OnUser1 stage2_miniboss_hp_case:Kill::0:1", 10.5, null);
		EntFire("stage2_miniboss_compare", "AddOutput", "OnUser2 stage2_miniboss_prop1:Break::0:1", 10.8, null);
		EntFire("stage2_bathroom_trigger", "AddOutput", "OnStartTouch stage2_miniboss_prop1:FireUser1::1.5:1", 10.5, null);
		EntFire("stage2_bathroom_trigger", "AddOutput", "OnStartTouch stage2_miniboss_prop1:FireUser3::2:1", 10.9, null);
		EntFire("map_bosssys_comp", "AddOutput", "OnEqualTo map_template_bossdropper:ForceSpawn::1:-1", 10.2, null);
		EntFire("map_bosssys_comp", "AddOutput", "OnEqualTo map_template_bossdropper:AddOutput:origin 6188 -7512 4832:0:-1", 10, null);
		EntFire("masstele_stg1*", "Kill", "", 4.2, null);
		EntFire("masstele_stg4*", "Kill", "", 4.2, null);
		EntFire("masstele_stg5*", "Kill", "", 4.2, null);
		EntFire("filter_class_physics", "Kill", "", 0.9, null);
		EntFire("map_skybox_template", "Kill", "", 73, null);
		EntFire("map_skybox_clouds", "AddOutput", "targetname stage2_skyprops_clouds", 29.6, null);
		EntFire("map_skybox_template", "ForceSpawn", "", 29.3, null);
		EntFire("map_skybox_template", "AddOutput", "origin 15138 -14102 -13443", 8, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.4, null);
		EntFire("map_trigger_fasttele", "Enable", "", 75.5, null);
		EntFire("map_trigger_itemexitfix", "Kill", "", 75.4, null);
		EntFire("map_trigger_itemexitfix", "Disable", "", 74, null);
		EntFire("map_adroom_opt_weather", "Trigger", "", 4.4, null);
		EntFire("weathersys_temp_stg1", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg4", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg5", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg6", "Kill", "", 4.3, null);
		EntFire("stage2_buttoncase", "FireUser1", "", 38, null);
		EntFire("map_protection_on", "Enable", "", 4.5, null);
		EntFire("map_protection_on", "Kill", "", 37, null);
		EntFire("stage2_rotdoor1_t", "AddOutput", "OnStartTouch stage2_rotdoor1:FireUser1::5:1", 9.2, null);
		EntFire("map_template_props8", "Kill", "", 35, null);
		EntFire("map_spwnr_prop8_b*", "Kill", "", 35, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 34.6, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin 12045 3093 6109", 34.5, null);
		EntFire("map_template_props8", "ForceSpawn", "", 34.4, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 34.3, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin 12518 3094 6109", 34.2, null);
		EntFire("map_template_props8", "ForceSpawn", "", 34.1, null);
		EntFire("map_shake", "StartShake", "", 5.2, null);
		EntFire("mode_teleport_ct", "AddOutput", "OnStartTouch map_barrels_shaker:FireUser2::0.2:1", 10, null);
		EntFire("stage2_rotdoor1_t", "AddOutput", "OnStartTouch stage2_rotdoor1:FireUser2::0:1", 8.5, null);
		EntFire("map_hint_case", "FireUser3", "", 6.5, null);
		EntFire("map_hint_msg8C", "Kill", "", 5.9, null);
		EntFire("map_hint_case", "InValue", "16", 5.8, null);
		EntFire("map_hint_case", "InValue", "9", 5.4, null);
		EntFire("map_shake", "FireUser3", "", 60, null);
		EntFire("new_check_delay_20", "Kill", "", 79.5, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger map_nuke_stg2:Enable::0.60:1", 83, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> ACTIVATING NEXT STAGE <<<:0.50:1", 82, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger new_check_case_stg:InValue:2:0.30:1", 81, null);
		EntFire("new_check_delay_*", "AddOutput", "OnTrigger map_nuke_stg2:Enable::0.30:1", 80, null);
		EntFire("spx_owl_nade", "AddOutput", "origin 12896 2835 6121", 7.5, null);
		EntFire("spx_hat_nade", "AddOutput", "origin 12896 3352 6121", 7.5, null);
		EntFire("map_skybox_spawn", "Kill", "", 75.5, null);
		EntFire("map_soundsys_case", "InValue", "2", 35.5, null);
		EntFire("map_soundsys_case", "InValue", "4", 36.5, null);
		EntFire("filter_class_xstg_*", "Kill", "", 0.3, null);
		EntFire("map_switch_*", "Kill", "", 3.6, null);
		EntFire("console", "Command", "zr_class_modify zombies health_infect_gain 175", 0.08, null);
		EntFire("console", "Command", "zr_class_modify zombies health 30000", 0.06, null);
		EntFire("console", "Command", "sv_enablebunnyhopping 1", 0.04, null);
		EntFire("console", "Command", "zr_infect_mzombie_ratio 6", 0.02, null);
		EntFire("map_template_bosscount", "ForceSpawn", "", 34, null);
		EntFire("map_template_bosscount", "Kill", "", 35, null);
		EntFire("map_m_v", "Kill", "", 0.4, null);
		EntFire("mode_stage_acces", "FireUser1", "", 0.8, null);
		EntFire("map_soundsys_case", "FireUser1", "", 70, null);
		EntFire("map_adroom_opt_flycars", "Trigger", "", 36, null);
		EntFire("map_fx_perm1", "FireUser1", "", 3.8, null);
		EntFire("map_fx_perm1", "FireUser2", "", 4.1, null);
		EntFire("new_check_anyone", "AddOutput", "OnTrigger map_nuke_stg2:Enable::2:1", 80, null);
	}
	else if(STAGE == 9 && !ONLYZMMOD)
	{
		EntFire("mode_stage_acces", "Break", "", 38, null);
		EntFire("map_zmfix_spawn", "Enable", "", 33.5, null);
		EntFire("mode_teleport_zm", "AddOutput", "OnStartTouch !activator:AddOutput:health 20000:0:-1", 8.5, null);
		EntFire("spxZM_emendo_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:health 20000:0:-1", 8.5, null);
		EntFire("map_zmfix_spawn", "AddOutput", "OnStartTouch !activator:AddOutput:health 20000:0:-1", 8.5, null);
		EntFire("mode_start_zm", "AddOutput", "origin 12389 -3131 -8172", 8, null);
		EntFire("mode_start_ct", "AddOutput", "origin 12389 -3168 -8172", 8, null);
		EntFire("mode_start_*", "AddOutput", "angles 0 270 0", 8, null);
		EntFire("console", "Command", "say >>> STAGE 9/12 - ZOMBIE MOD - EXTREME MODE <<<", 7, null);
		EntFire("map_sound_switch_xtrm1", "Volume", "10", 5.2, null);
		EntFire("map_adroom_opt_fixup", "FireUser1", "", 6, null);
		EntFire("map_sound_switch_xtrm1", "PlaySound", "", 5, null);
		EntFire("console", "Command", "say >>> STAGE 9/12 - ZOMBIE MOD - EXTREME MODE <<<", 5, null);
		EntFire("console", "Command", "say >>> GO INSIDE THE TELEPORTER WHEN THE GATE BREAKS <<<", 36, null);
		EntFire("filter_targets_block_multi", "FireUser2", "", 30, null);
		EntFire("console", "Command", "say >>> DO NOT CAMP IN SPAWN <<<", 37, null);
		EntFire("console", "Command", "say >>> THE LEVER IS UNLOCKED <<<", 317, null);
		EntFire("stageZM_ex_lever_button2", "AddOutput", "origin 12380 -9752 -8240", 318, null);
		EntFire("console", "Command", "say >>> THE LEVER WILL UNLOCK IN 5 SECONDS <<<", 313, null);
		EntFire("console", "Command", "say >>> THE LEVER WILL UNLOCK IN 10 SECONDS <<<", 308, null);
		EntFire("stageZM_doorzm3", "Lock", "", 286.5, null);
		EntFire("console", "Command", "say >>> THE LEVER WILL UNLOCK IN 15 SECONDS <<<", 303, null);
		EntFire("stageZM_trigger_portals", "Kill", "", 298.5, null);
		EntFire("stageZM_portal_exit*", "Kill", "", 298.5, null);
		EntFire("stageZM_trigger_masstele", "Kill", "", 298.5, null);
		EntFire("console", "Command", "say >>> THE LEVER WILL UNLOCK IN 20 SECONDS <<<", 298, null);
		EntFire("console", "Command", "say >>> PRESS THE LEVER WHEN UNLOCKED TO BREAK THE DOORS <<<", 296, null);
		EntFire("console", "Command", "say >>> KEEP DEFENDING UNTIL THE LEVER UNLOCKS <<<", 295, null);
		EntFire("map_sound_switch_xtrm2", "Volume", "10", 293.2, null);
		EntFire("stageZM_effect_end_*", "Stop", "", 294, null);
		EntFire("stageZM_trigger_masstele", "Disable", "", 294, null);
		EntFire("map_sound_switch_xtrm1", "Volume", "0", 293.2, null);
		EntFire("map_sound_switch_xtrm2", "PlaySound", "", 293, null);
		EntFire("stageZM_effect_lever", "Start", "", 294, null);
		EntFire("stageZM_doorzm1", "Kill", "", 294, null);
		EntFire("console", "Command", "say >>> 1 <<<", 293, null);
		EntFire("console", "Command", "say >>> 2 <<<", 292, null);
		EntFire("console", "Command", "say >>> 3 <<<", 291, null);
		EntFire("stageZM_trigger_portals", "Disable", "", 287, null);
		EntFire("stageZM_break1", "Break", "", 284.5, null);
		EntFire("console", "Command", "say >>> GET READY FOR A LAST BATTLE <<<", 290, null);
		EntFire("stageZM_trigger_masstele", "Enable", "", 285, null);
		EntFire("map_trigger_spawntele", "Enable", "", 285, null);
		EntFire("stageZM_fakewall", "Close", "", 286, null);
		EntFire("stageZM_doorzm*", "Close", "", 286, null);
		EntFire("mode_start_zm", "AddOutput", "origin 12366 -6886 -8276", 284, null);
		EntFire("mode_start_ct", "AddOutput", "origin 12366 -8304 -8180", 284, null);
		EntFire("filter_broomstick_zmblock", "FireUser1", "", 283, null);
		EntFire("console", "Command", "say >>> 5 SECONDS LEFT <<<", 280, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 10 SECONDS <<<", 275, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 20 SECONDS <<<", 265, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 30 SECONDS <<<", 255, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 1 MINUTE <<<", 225, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 2 MINUTES <<<", 165, null);
		EntFire("stageZM_doorb2", "Break", "", 44, null);
		EntFire("stageZM_fakewall", "Open", "", 43, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 4 MINUTES <<<", 45, null);
		EntFireByHandle(self,"RunScriptCode","TimerMap(240, 1);",45.00,null,null);
		EntFire("stageZM_effect_*", "Stop", "", 9.4, null);
		EntFire("stageZM_doorzm*", "Open", "", 40, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 3 MINUTES AND 30 SECONDS <<<", 75, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 1 MINUTES AND 30 SECONDS <<<", 195, null);
		EntFire("map_screenoverlay", "SwitchOverlay", "1", 284.8, null);
		EntFire("map_screenoverlay", "SwitchOverlay", "1", 286, null);
		EntFire("console", "Command", "say >>> DONT DIE!!! YOU NEED TO ESCAPE AFTER THE TIME RUNS OUT <<<", 46, null);
		EntFire("mode_start_ct", "AddOutput", "angles 0 90 0", 284, null);
		EntFire("map_trigger_spawntele", "Disable", "", 284, null);
		EntFire("stageZM_effect_end_*", "Start", "", 283, null);
		EntFire("map_screenoverlay", "SwitchOverlay", "1", 294.5, null);
		EntFire("filter_targets_block_multi", "FireUser4", "", 50, null);
		EntFire("console", "Command", "say >>> ALL WANDS DISABLED FOR USE TILL THE END<<<", 35, null);
		EntFire("console", "Command", "say >>> ALL WANDS ARE ENABLED FOR USE <<<", 288, null);
		EntFire("stageZM_counter_logic", "Trigger", "", 301, null);
		EntFire("admin_fixups", "Trigger", "", 11, null);
		EntFire("map_shake", "FireUser2", "", 287.7, null);
		EntFire("map_barrels_temp1", "ForceSpawn", "", 38.2, null);
		EntFire("map_barrels_temp1", "ForceSpawn", "", 39, null);
		EntFire("map_barrelset1_brush", "AddOutput", "origin 13166 -9764 -8221", 38.4, null);
		EntFire("map_barrelset1_brush", "AddOutput", "angles 0 90 0", 38.4, null);
		EntFire("map_barrelset1_brush", "AddOutput", "origin 11593 -9767 -8221", 39.2, null);
		EntFire("map_barrelset1_brush", "AddOutput", "angles 0 90 0", 39.2, null);
		EntFire("map_barrelset1_brush", "FireUser2", "", 39.4, null);
		EntFire("spx_effect_wand_*", "Stop", "", 38, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 38, null);
		EntFire("stageZM_towers_model", "Kill", "", 285.2, null);
		EntFire("stageZM_towers_fdoor", "Kill", "", 285.2, null);
		EntFire("stageZM_towers_props", "Break", "", 285, null);
		EntFire("console", "Command", "say >>> SPAWNING ALL FUN ITEMS - COMBO NOT POSSIBLE <<<", 10, null);
		EntFire("map_template_towers", "FireUser1", "", 10.2, null);
		EntFire("zad_comp_ex", "SetCompareValue", "1", 4, null);
		EntFire("stageZM_lever_button2", "Kill", "", 2.2, null);
		EntFire("map_wandslevelZM", "FireUser1", "", 9.5, null);
		EntFire("stageZM_broomstick_spawner", "ForceSpawn", "", 16, null);
		EntFire("stageZM_broomstick_spawner2", "ForceSpawn", "", 23, null);
		EntFire("stageZM_broomstick_spawner", "AddOutput", "origin 12550 -4144 -8210", 7.2, null);
		EntFire("stageZM_broomstick_spawner2", "AddOutput", "origin 12550 -4288 -8210", 7.2, null);
		EntFire("stageZM_builder_spawner", "ForceSpawn", "", 10.1, null);
		EntFire("stageZM_builder_spawner", "AddOutput", "origin 12368 -4560 -8210", 7.2, null);
		EntFire("stageZM_doorslide1", "FireUser2", "", 230, null);
		EntFire("map_sound_switch_xtrm2", "AddOutput", "message #harrypotterze/stages/xxstgzm2endrunx.mp3", 1.00, null);
		EntFire("map_sound_switch_xtrm1", "AddOutput", "message #harrypotterze/stages/xxstgzm2beginningxx.mp3", 1.00, null);
		EntFire("map_texturetoggle", "SetTextureIndex", "9", 0, null);
		EntFire("stageZM_towers_exdoors", "Kill", "", 285, null);
		EntFire("spx_builder_counter", "SetHitMax", "4", 9.9, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:LowerRandomBound:2:0.1:1", 9.7, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:UpperRandomBound:3:0.1:1", 9.8, null);
		EntFire("map_barrelset1_*", "ClearParent", "", 38.6, null);
		EntFire("map_barrelset1_brush", "Kill", "", 38.8, null);
		EntFire("stageZM_torchsystem", "InValue", "1", 31, null);
		EntFire("stageZM_torchsystem", "InValue", "2", 276, null);
		EntFire("map_sound_switch_xtrm1", "Kill", "", 294.5, null);
		EntFire("map_protection_off", "Enable", "", 37, null);
		EntFire("map_protection_on", "Disable", "", 36, null);
		EntFire("map_trigger_itemexitfix", "Enable", "", 72, null);
		EntFire("mode_teleport_ct", "Kill", "", 71, null);
		EntFire("mode_teleport_zm", "Kill", "", 71, null);
		EntFire("map_trigger_spawntele", "Enable", "", 70, null);
		EntFire("mode_teleport_both", "Enable", "", 70, null);
		EntFire("mode_teleport_*", "Disable", "", 69, null);
		EntFire("map_template_effect1", "Kill", "", 283.9, null);
		EntFire("map_template_effect1", "ForceSpawn", "", 283.8, null);
		EntFire("map_template_effect1", "AddOutput", "origin 13514 -8663 -8232", 283.7, null);
		EntFire("map_template_effect1", "ForceSpawn", "", 283.6, null);
		EntFire("map_template_effect1", "AddOutput", "origin 11263 -8663 -8232", 283.5, null);
		EntFire("map_template_effect1", "ForceSpawn", "", 283.4, null);
		EntFire("map_template_effect1", "AddOutput", "origin 11263 -5120 -8232", 283.3, null);
		EntFire("map_template_effect1", "ForceSpawn", "", 283.2, null);
		EntFire("map_template_effect1", "AddOutput", "origin 13514 -5120 -8232", 283.1, null);
		EntFire("map_force_effect_exp", "Start", "", 285, null);
		EntFire("map_force_effect_exp", "Stop", "", 287, null);
		EntFire("map_force_effect_exp", "Kill", "", 287.5, null);
		EntFire("stageZM_camp1_template", "FireUser2", "", 39.5, null);
		EntFire("stageZM_camp1_template", "FireUser1", "", 38.5, null);
		EntFire("stageZM_camp1_door", "ClearParent", "", 284.7, null);
		EntFire("stageZM_camp1_model", "Break", "", 285.2, null);
		EntFire("map_skybox_template", "Kill", "", 73, null);
		EntFire("map_skybox_clouds", "AddOutput", "targetname stageZM_skyprops_clouds", 37.6, null);
		EntFire("map_skybox_template", "ForceSpawn", "", 37.3, null);
		EntFire("map_skybox_template", "AddOutput", "origin 15118 -14659 -14236", 8, null);
		EntFire("stageZM_camp1_*", "Kill", "", 285.3, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.4, null);
		EntFire("map_template_fix1", "ForceSpawn", "", 6.2, null);
		EntFire("map_template_fix1", "AddOutput", "origin 12430 -3946 -8232", 6.5, null);
		EntFire("map_template_fix2", "AddOutput", "origin 12354 -3946 -8232", 6.5, null);
		EntFire("map_template_fix1", "ForceSpawn", "", 6.7, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.9, null);
		EntFire("mapx*", "Kill", "", 3.5, null);
		EntFire("stage5_*", "Kill", "", 3, null);
		EntFire("stage4_*", "Kill", "", 2.5, null);
		EntFire("stage3_*", "Kill", "", 2, null);
		EntFire("stage2_*", "Kill", "", 1.5, null);
		EntFire("stage1_*", "Kill", "", 1, null);
		EntFire("map_hpbar_*", "Kill", "", 0.9, null);
		EntFire("map_bosssys_*", "Kill", "", 0.8, null);
		EntFire("map_bossmover_*", "Kill", "", 0.8, null);
		EntFire("masstele_stg*", "Kill", "", 0.7, null);
		EntFire("map_template_props1", "Kill", "", 0.5, null);
		EntFire("map_template_props7", "Kill", "", 0.5, null);
		EntFire("map_template_props6", "Kill", "", 0.5, null);
		EntFire("map_spwnr_prop1*", "Kill", "", 0.6, null);
		EntFire("map_spwnr_prop7*", "Kill", "", 0.6, null);
		EntFire("map_spwnr_prop6*", "Kill", "", 0.6, null);
		EntFire("filter_deat*", "Kill", "", 0.4, null);
		EntFire("filter_h*", "Kill", "", 0.4, null);
		EntFire("filter_snake*", "Kill", "", 0.4, null);
		EntFire("filter_spider_*", "Kill", "", 0.4, null);
		EntFire("filter_spx_spider", "Kill", "", 0.4, null);
		EntFire("filter_class_physics", "Kill", "", 0.2, null);
		EntFire("filter_wiz_*", "Kill", "", 0.2, null);
		EntFire("filter_stg*", "Kill", "", 0.2, null);
		EntFire("filter_m*", "Kill", "", 0.3, null);
		EntFire("map_template_tornado", "Kill", "", 0.1, null);
		EntFire("map_template_bossdropper", "Kill", "", 0.1, null);
		EntFire("map_template_torch_noprop*", "Kill", "", 0.1, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 120, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 100, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 78, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 68, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 58, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 48, null);
		EntFire("stageZM_counter_logic", "FireUser2", "", 34, null);
		EntFire("stageZM_propscade*", "Kill", "", 285.5, null);
		EntFire("stageZM_propstemp*", "Kill", "", 285.1, null);
		EntFire("map_trigger_fasttele", "Enable", "", 75.5, null);
		EntFire("map_trigger_itemexitfix", "Kill", "", 75.4, null);
		EntFire("map_trigger_itemexitfix", "Disable", "", 74, null);
		EntFire("weathersys_*", "Kill", "", 4.2, null);
		EntFire("item_skin_troll_count", "SetValueNoFire", "3", 9.3, null);
		EntFire("stageZM_buttoncase", "FireUser2", "", 305, null);
		EntFire("map_protection_on", "Enable", "", 4.5, null);
		EntFire("map_protection_on", "Kill", "", 37, null);
		EntFire("map_shake", "StartShake", "", 5.2, null);
		EntFire("stageZM_doorzm2", "Kill", "", 301, null);
		EntFire("map_hint_case", "FireUser3", "", 6.5, null);
		EntFire("map_hint_case", "InValue", "14", 5.9, null);
		EntFire("map_hint_case", "InValue", "16", 5.8, null);
		EntFire("map_hint_case", "InValue", "10", 5.7, null);
		EntFire("stageZM_ex_lever_button2", "AddOutput", "angles 0 0 0", 318, null);
		EntFire("map_shake", "FireUser3", "", 60, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 3 MINUTES <<<", 105, null);
		EntFire("console", "Command", "say >>> SURVIVE FOR 2 MINUTES AND 30 SECONDS <<<", 135, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 140, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 160, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 180, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 200, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 235, null);
		EntFire("spxZM_effect_wand_*", "Stop", "", 270, null);
		EntFire("new_check_delay_20", "Kill", "", 79.5, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger map_nuke_stgZM:Enable::0.60:1", 83, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> ACTIVATING NEXT STAGE <<<:0.50:1", 82, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger new_check_case_stg:InValue:3:0.30:1", 81, null);
		EntFire("new_check_delay_*", "AddOutput", "OnTrigger map_nuke_stgZM:Enable::0.30:1", 80, null);
		EntFire("spx_owl_nade", "AddOutput", "origin 11789 -3461 -7304", 7.5, null);
		EntFire("spx_hat_nade", "AddOutput", "origin 12990 -3461 -7304", 7.5, null);
		EntFire("map_skybox_spawn", "Kill", "", 75.5, null);
		EntFire("map_soundsys_case", "InValue", "2", 288.5, null);
		EntFire("map_soundsys_case", "InValue", "4", 290.5, null);
		EntFire("stageZM_towers_ldoors", "Kill", "", 285.2, null);
		EntFire("filter_class_xstg_*", "Kill", "", 0.2, null);
		EntFire("map_switch_*", "Kill", "", 3.6, null);
		EntFire("item_skin_maxi_*", "Kill", "", 0.3, null);
		EntFire("map_trigger_skins_m", "Kill", "", 0.3, null);
		EntFire("console", "Command", "zr_class_modify zombies health_infect_gain 175", 0.08, null);
		EntFire("console", "Command", "zr_class_modify zombies health 35000", 0.06, null);
		EntFire("console", "Command", "sv_enablebunnyhopping 1", 0.04, null);
		EntFire("console", "Command", "zr_infect_mzombie_ratio 6", 0.02, null);
		EntFire("map_template_bossmover", "Kill", "", 0.1, null);
		EntFire("map_template_bosscount", "ForceSpawn", "", 30.5, null);
		EntFire("map_template_bosscount", "Kill", "", 37, null);
		EntFire("map_m_v", "Kill", "", 0.9, null);
		EntFire("mode_stage_acces", "FireUser1", "", 0.8, null);
		EntFire("map_soundsys_case", "FireUser1", "", 70, null);
		EntFire("stageZM_lever_prop2", "AddOutput", "angles 0 180 0", 46.5, null);
		EntFire("map_shake", "FireUser1", "", 38, null);
		EntFire("stageZM_doorslide2", "FireUser3", "", 44.5, null);
		EntFire("stageZM_doorslide2", "FireUser1", "", 41, null);
		EntFire("map_hint_zmtemp", "Display", "", 43, null);
		EntFire("map_hint_zmtemp", "Kill", "", 49, null);
		EntFire("new_check_anyone", "AddOutput", "OnTrigger map_nuke_stgZM:Enable::2:1", 80, null);
	}
	else if(STAGE == 10 && !ONLYZMMOD)
	{
		EntFire("mode_stage_acces", "Break", "", 35, null);
		EntFire("map_zmfix_spawn", "Enable", "", 34, null);
		EntFire("mode_teleport_zm", "AddOutput", "OnStartTouch !activator:AddOutput:health 40000:0:-1", 8.5, null);
		EntFire("spxZM_emendo_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:health 40000:0:-1", 8.5, null);
		EntFire("map_zmfix_spawn", "AddOutput", "OnStartTouch !activator:AddOutput:health 40000:0:-1", 8.5, null);
		EntFire("mode_start_zm", "AddOutput", "origin -7744 -8001 1812", 8, null);
		EntFire("mode_start_ct", "AddOutput", "origin -7864 -8008 1812", 8, null);
		EntFire("mode_start_ct", "AddOutput", "angles 0 124 0", 8, null);
		EntFire("mode_start_zm", "AddOutput", "angles 0 180 0", 8, null);
		EntFire("console", "Command", "say >>> STAGE 10/12 - WIZARD MODE - EXTREME MODE <<<", 7, null);
		EntFire("map_adroom_opt_fixup", "FireUser1", "", 6, null);
		EntFire("console", "Command", "say >>> STAGE 10/12 - WIZARD MODE - EXTREME MODE <<<", 5, null);
		EntFire("map_sound_switch_xtrm1", "PlaySound", "", 5, null);
		EntFire("map_sound_switch_xtrm1", "AddOutput", "message #harrypotterze/stages/xxstg10beginningx.mp3", 1.00, null);
		EntFire("map_sound_switch_xtrm2", "AddOutput", "message #harrypotterze/stages/xxstg10ministage1x.mp3", 1.00, null);
		EntFire("map_sound_switch_xtrm1", "Volume", "10", 5.2, null);
		EntFire("map_texturetoggle", "SetTextureIndex", "10", 0, null);
		EntFire("filter_targets_block_multi", "FireUser1", "", 30, null);
		EntFire("stageZM_*", "Kill", "", 3, null);
		EntFire("stage5_*", "Kill", "", 2.5, null);
		EntFire("stage4_*", "Kill", "", 2, null);
		EntFire("stage1_*", "Kill", "", 1, null);
		EntFire("stage2_*", "Kill", "", 1.5, null);
		EntFire("filter_targets_block_multi", "FireUser3", "", 40, null);
		EntFire("mapx*", "Kill", "", 3.5, null);
		EntFire("admin_fixups", "Trigger", "", 11, null);
		EntFire("map_trigger_spawntele", "Disable", "", 75, null);
		EntFire("mode_teleport_*", "Enable", "", 75, null);
		EntFire("map_template_leversys", "ForceSpawn", "", 32, null);
		EntFire("map_leversys_brush", "AddOutput", "origin -10940 -4150 1786", 33, null);
		EntFire("map_leversys_brush", "AddOutput", "angles 0 90 0", 33, null);
		EntFire("zad_comp_ex", "SetCompareValue", "1", 4, null);
		EntFire("map_template_props6", "AddOutput", "origin -2807 -13695 -8151", 50, null);
		EntFire("stage3_wizstg4_door", "AddOutput", "OnFullyOpen !self:Lock::0:1", 9, null);
		EntFire("console", "Command", "say >>> GATE BREAKING IN 6 SECONDS <<<", 29, null);
		EntFire("filter_stg3_wizard_check1", "AddOutput", "OnPass stage3_wizard_tele_stg1_ZM:Enable::14:1", 45, null);
		EntFire("filter_stg3_wizard_check1", "AddOutput", "OnPass stage3_wizard_zmtriggers_town:Enable::14:1", 45, null);
		EntFire("filter_stg3_wizard_check2", "AddOutput", "OnPass stage3_wizard_tele_stg1_ZM:Enable::14:1", 46, null);
		EntFire("filter_stg3_wizard_check2", "AddOutput", "OnPass stage3_wizard_tele_stg2_ZM:Enable::14:1", 46, null);
		EntFire("filter_stg3_wizard_check2", "AddOutput", "OnPass stage3_wizard_zmtriggers_town:Enable::14:1", 46, null);
		EntFire("filter_stg3_wizard_check3", "AddOutput", "OnPass stage3_wizard_tele_stg1_ZM:Enable::14:1", 47, null);
		EntFire("filter_stg3_wizard_check3", "AddOutput", "OnPass stage3_wizard_tele_stg2_ZM:Enable::14:1", 47, null);
		EntFire("filter_stg3_wizard_check3", "AddOutput", "OnPass stage3_wizard_tele_stg3_ZM:Enable::14:1", 47, null);
		EntFire("filter_stg3_wizard_check3", "AddOutput", "OnPass stage3_wizard_zmtriggers_town:Enable::14:1", 47, null);
		EntFire("stage3_buttoncase", "AddOutput", "OnCase02 stage3_wizard_tolate_relay:FireUser2::10:1", 9, null);
		EntFire("map_boss_counter3", "SetHitMax", "4", 51.5, null);
		EntFire("stage3_torchsystem", "FireUser1", "", 25, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:LowerRandomBound:2:0.1:-1", 10, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:UpperRandomBound:3:0.1:-1", 10.5, null);
		EntFire("stage3_torchsystem", "InValue", "1", 20, null);
		EntFire("stage3_torchsystem", "InValue", "2", 38, null);
		EntFire("stage3_wizard_tolate_relay", "AddOutput", "OnTrigger stage3_wizard_template:FireUser2::1.5:1", 9, null);
		EntFire("filter_stg3_wizard_check3", "AddOutput", "OnPass stage3_wizard_tolate_relay:FireUser3::12:1", 10.5, null);
		EntFire("stage3_wizard_zmtriggers_*", "AddOutput", "OnStartTouch !activator:AddOutput:health 40000:0:-1", 8.5, null);
		EntFire("filter_stg3_wizard_check3", "AddOutput", "OnPass filter_stg3_wizard_multi:FireUser1::9:1", 10, null);
		EntFire("map_protection_off", "Enable", "", 37, null);
		EntFire("map_protection_on", "Disable", "", 36, null);
		EntFire("filter_stg5_end", "Kill", "", 0.3, null);
		EntFire("filter_prop*", "Kill", "", 0.3, null);
		EntFire("filter_m*", "Kill", "", 0.2, null);
		EntFire("filter_b*", "Kill", "", 0.2, null);
		EntFire("stage3_wizard_platform_d", "Kill", "", 5.5, null);
		EntFire("map_trigger_itemexitfix", "Enable", "", 72, null);
		EntFire("mode_teleport_ct", "Kill", "", 71, null);
		EntFire("mode_teleport_zm", "Kill", "", 71, null);
		EntFire("map_trigger_spawntele", "Enable", "", 70, null);
		EntFire("mode_teleport_both", "Enable", "", 70, null);
		EntFire("mode_teleport_*", "Disable", "", 69, null);
		EntFire("map_template_bossmover", "Kill", "", 0.1, null);
		EntFire("map_bossmover_*", "Kill", "", 0.1, null);
		EntFire("map_template_bossdropper", "Kill", "", 0.2, null);
		EntFire("map_bosssys_*", "Kill", "", 0.2, null);
		EntFire("map_template_props6", "Forcespawn", "", 50.5, null);
		EntFire("map_template_props6", "AddOutput", "origin -2919 -12739 -8151", 52, null);
		EntFire("map_template_props6", "AddOutput", "angles 0 90 0", 52, null);
		EntFire("map_template_props6", "ForceSpawn", "", 52.5, null);
		EntFire("map_spwnr_prop6", "AddOutput", "targetname stage3_wizdrag3_hold_break2", 53, null);
		EntFire("map_template_props6", "Kill", "", 54, null);
		EntFire("stage3_skyprops_d*", "TurnOff", "", 6.5, null);
		EntFire("masstele_stg*", "Kill", "", 4.2, null);
		EntFire("filter_class_physics", "Kill", "", 0.9, null);
		EntFire("map_skybox_clouds", "AddOutput", "targetname stage3_skyprops_clouds", 29.6, null);
		EntFire("map_skybox_template", "ForceSpawn", "", 29.3, null);
		EntFire("map_skybox_template", "AddOutput", "origin 13713 -14659 -13669", 8, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.4, null);
		EntFire("map_trigger_fasttele", "Enable", "", 75.5, null);
		EntFire("map_trigger_itemexitfix", "Kill", "", 75.4, null);
		EntFire("map_trigger_itemexitfix", "Disable", "", 74, null);
		EntFire("map_adroom_opt_weather", "Trigger", "", 4.4, null);
		EntFire("weathersys_temp_stg2", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg1", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg5", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg6", "Kill", "", 4.3, null);
		EntFire("stage3_wizdrag4_template", "AddOutput", "OnUser1 mode_start_ct:AddOutput:origin 9456 -11872 -128:0:1", 9.5, null);
		EntFire("stage3_wizdrag4_template", "AddOutput", "OnUser1 mode_start_zm:AddOutput:origin 5826 -11883 -144:0:1", 9.5, null);
		EntFire("stage3_buttoncase", "FireUser1", "", 37, null);
		EntFire("map_protection_on", "Enable", "", 4.5, null);
		EntFire("map_protection_on", "Kill", "", 37, null);
		EntFire("map_shake", "StartShake", "", 5.2, null);
		EntFire("mode_teleport_ct", "AddOutput", "OnStartTouch map_barrels_shaker:FireUser2::0.2:1", 10, null);
		EntFire("map_hint_case", "FireUser3", "", 6.5, null);
		EntFire("map_hint_case", "InValue", "15", 5.9, null);
		EntFire("map_hint_case", "InValue", "16", 5.8, null);
		EntFire("map_hint_case", "InValue", "11", 5.7, null);
		EntFire("map_shake", "FireUser3", "", 60, null);
		EntFire("new_check_delay_20", "Kill", "", 79.5, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger map_nuke_stg3:Enable::0.60:1", 83, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> ACTIVATING NEXT STAGE <<<:0.50:1", 82, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger new_check_case_stg:InValue:4:0.30:1", 81, null);
		EntFire("new_check_delay_*", "AddOutput", "OnTrigger map_nuke_stg3:Enable::0.30:1", 80, null);
		EntFire("spx_owl_nade", "AddOutput", "origin -11885 -5496 1776", 7.5, null);
		EntFire("spx_hat_nade", "AddOutput", "origin -14057 -4556 1776", 7.5, null);
		EntFire("map_skybox_spawn", "Kill", "", 75.5, null);
		EntFire("map_soundsys_case", "InValue", "4", 35.5, null);
		EntFire("filter_class_xstg_*", "Kill", "", 0.2, null);
		EntFire("console", "Command", "zr_class_modify zombies health_infect_gain 200", 0.08, null);
		EntFire("console", "Command", "zr_class_modify zombies health 40000", 0.06, null);
		EntFire("console", "Command", "sv_enablebunnyhopping 1", 0.04, null);
		EntFire("console", "Command", "zr_infect_mzombie_ratio 6", 0.02, null);
		EntFire("map_template_bosscount", "ForceSpawn", "", 51, null);
		EntFire("map_template_bosscount", "Kill", "", 54, null);
		EntFire("map_m_v", "Kill", "", 0.4, null);
		EntFire("mode_stage_acces", "FireUser1", "", 0.8, null);
		EntFire("map_soundsys_case", "FireUser1", "", 70, null);
		EntFire("map_adroom_opt_flycars", "Trigger", "", 36, null);
		EntFire("map_healthb_template", "FireUser2", "", 41, null);
		EntFire("stage3_wizdrag3_d2", "Kill", "", 10.8, null);
		EntFire("stage3_wizdrag3_afktele", "Kill", "", 10.8, null);
		EntFire("map_template_props6", "Forcespawn", "", 49.5, null);
		EntFire("map_template_props6", "AddOutput", "origin -3023 -14538 -8151", 49, null);
		EntFire("map_fx_perm1", "FireUser1", "", 3.8, null);
		EntFire("map_fx_perm1", "FireUser2", "", 4.1, null);
		EntFire("new_check_anyone", "AddOutput", "OnTrigger map_nuke_stg3:Enable::2:1", 80, null);
	}
	else if(STAGE == 11 && !ONLYZMMOD)
	{
		EntFire("mode_stage_acces", "Break", "", 35, null);
		EntFire("map_zmfix_spawn", "Enable", "", 34, null);
		EntFire("mode_teleport_zm", "AddOutput", "OnStartTouch !activator:AddOutput:health 50000:0:-1", 8.5, null);
		EntFire("spxZM_emendo_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:health 50000:0:-1", 8.5, null);
		EntFire("map_zmfix_spawn", "AddOutput", "OnStartTouch !activator:AddOutput:health 50000:0:-1", 8.5, null);
		EntFire("mode_start_zm", "AddOutput", "origin -12640 -314 -9997", 8, null);
		EntFire("mode_start_ct", "AddOutput", "origin -12635 -314 -9997", 8, null);
		EntFire("mode_start_*", "AddOutput", "angles 0 90 0", 8, null);
		EntFire("console", "Command", "say >>> STAGE 11/12 - EXTREME MODE <<<", 7, null);
		EntFire("map_adroom_opt_fixup", "FireUser1", "", 6, null);
		EntFire("console", "Command", "say >>> STAGE 11/12 - EXTREME MODE <<<", 5, null);
		EntFire("map_sound_switch_xtrm1", "PlaySound", "", 5, null);
		EntFire("map_sound_switch_xtrm1", "AddOutput", "message #harrypotterze/stages/xxstg11beginningx.mp3", 1.00, null);
		EntFire("map_sound_switch_xtrm2", "AddOutput", "message #harrypotterze/stages/xxstg11bossfightspiderxx.mp3", 1.00, null);
		EntFire("map_sound_switch_xtrm1", "Volume", "10", 5.2, null);
		EntFire("map_texturetoggle", "SetTextureIndex", "11", 0, null);
		EntFire("filter_targets_block_multi", "FireUser1", "", 30, null);
		EntFire("stageZM_*", "Kill", "", 3, null);
		EntFire("stage5_*", "Kill", "", 2.5, null);
		EntFire("stage1_*", "Kill", "", 1, null);
		EntFire("stage3_*", "Kill", "", 2, null);
		EntFire("stage2_*", "Kill", "", 1.5, null);
		EntFire("filter_targets_block_multi", "FireUser3", "", 40, null);
		EntFire("mapx*", "Kill", "", 3.5, null);
		EntFire("admin_fixups", "Trigger", "", 11, null);
		EntFire("map_barrels_temp1", "ForceSpawn", "", 41, null);
		EntFire("map_barrelset1_brush", "AddOutput", "origin -15034 1824 -10049", 42, null);
		EntFire("map_barrelset1_brush", "AddOutput", "angles 0 270 0", 42, null);
		EntFire("map_trigger_spawntele", "Disable", "", 75, null);
		EntFire("mode_teleport_*", "Enable", "", 75, null);
		EntFire("map_leversys_brush", "AddOutput", "origin -14932 1784 -10060", 33, null);
		EntFire("map_leversys_brush", "AddOutput", "angles 0 90 0", 33, null);
		EntFire("map_template_leversys", "ForceSpawn", "", 32, null);
		EntFire("zad_comp_ex", "SetCompareValue", "1", 4, null);
		EntFire("stage4_boxes", "Break", "", 10.5, null);
		EntFire("console", "Command", "say >>> GATE BREAKING IN 6 SECONDS <<<", 29, null);
		EntFire("stage4_breakdoor1", "FireUser1", "", 36, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:LowerRandomBound:2:0.1:-1", 10, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:UpperRandomBound:3:0.1:-1", 10.4, null);
		EntFire("stage4_torchsystem", "InValue", "1", 20, null);
		EntFire("stage4_torchsystem", "InValue", "2", 35, null);
		EntFire("stage4_miniboss_template", "AddOutput", "OnEntitySpawned stage4_miniboss_model:SetModelScale:1.3:0.2:-1", 9, null);
		EntFire("map_protection_off", "Enable", "", 37, null);
		EntFire("map_protection_on", "Disable", "", 36, null);
		EntFire("filter_prop_*", "Kill", "", 0.2, null);
		EntFire("filter_stg5_end", "Kill", "", 0.2, null);
		EntFire("filter_wiz_*", "Kill", "", 0.2, null);
		EntFire("filter_b*", "Kill", "", 0.2, null);
		EntFire("map_trigger_itemexitfix", "Enable", "", 72, null);
		EntFire("mode_teleport_ct", "Kill", "", 71, null);
		EntFire("mode_teleport_zm", "Kill", "", 71, null);
		EntFire("mode_start_ct", "Kill", "", 71, null);
		EntFire("map_trigger_spawntele", "Enable", "", 70, null);
		EntFire("mode_teleport_both", "Enable", "", 70, null);
		EntFire("mode_teleport_*", "Disable", "", 69, null);
		EntFire("stage4_slidedoor2B", "AddOutput", "OnUser1 !self:Lock::0:1", 9, null);
		EntFire("map_bosssys_comp", "AddOutput", "OnEqualTo map_template_bossdropper:ForceSpawn::1:-1", 10.2, null);
		EntFire("map_bosssys_comp", "AddOutput", "OnEqualTo map_template_bossdropper:AddOutput:origin 6008 9163 -11872:0:-1", 10, null);
		EntFire("masstele_stg1*", "Kill", "", 4.2, null);
		EntFire("masstele_stg2*", "Kill", "", 4.2, null);
		EntFire("masstele_stg5*", "Kill", "", 4.2, null);
		EntFire("map_skybox_template", "Kill", "", 73, null);
		EntFire("map_skybox_clouds", "AddOutput", "targetname stage4_skyprops_clouds", 29.8, null);
		EntFire("map_skybox_template", "ForceSpawn", "", 29.2, null);
		EntFire("map_skybox_template", "AddOutput", "origin 14192 -13847 -14628", 7.2, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.4, null);
		EntFire("map_trigger_fasttele", "Enable", "", 75.5, null);
		EntFire("map_trigger_itemexitfix", "Kill", "", 75.4, null);
		EntFire("map_trigger_itemexitfix", "Disable", "", 74, null);
		EntFire("map_adroom_opt_weather", "Trigger", "", 4.4, null);
		EntFire("weathersys_temp_stg2", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg4", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg1", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg6", "Kill", "", 4.3, null);
		EntFire("map_skybox_template", "ForceSpawn", "", 29.6, null);
		EntFire("map_skybox_template", "AddOutput", "origin 13483 -14225 -14488", 29.4, null);
		EntFire("stage4_boss_template1", "AddOutput", "OnUser1 stage4_miniboss_template:FireUser1::0.2:1", 10, null);
		EntFire("stage4_buttoncase", "FireUser1", "", 31, null);
		EntFire("map_protection_on", "Enable", "", 4.5, null);
		EntFire("map_protection_on", "Kill", "", 37, null);
		EntFire("map_spwnr_prop8_s*", "Kill", "", 34.5, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "targetname map_spwnr_prop8_x", 34.2, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "origin -13865 1175 -10075", 34.1, null);
		EntFire("map_template_props8", "ForceSpawn", "", 34, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "targetname map_spwnr_prop8_x", 33.9, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "origin -13357 1175 -10075", 33.8, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33.7, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "targetname map_spwnr_prop8_x", 33.6, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "origin -12341 1175 -10075", 33.5, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33.4, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "targetname map_spwnr_prop8_x", 33.3, null);
		EntFire("map_spwnr_prop8_big", "AddOutput", "origin -11833 1175 -10075", 33.2, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33.1, null);
		EntFire("map_shake", "StartShake", "", 5.2, null);
		EntFire("mode_teleport_ct", "AddOutput", "OnStartTouch map_barrels_shaker:FireUser2::0.2:1", 10, null);
		EntFire("map_hint_case", "FireUser3", "", 6.5, null);
		EntFire("map_hint_msg8C", "Kill", "", 5.9, null);
		EntFire("map_hint_case", "InValue", "16", 5.8, null);
		EntFire("map_hint_case", "InValue", "12", 5.4, null);
		EntFire("map_shake", "FireUser3", "", 60, null);
		EntFire("new_check_delay_20", "Kill", "", 79.5, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger map_nuke_stg4:Enable::0.60:1", 83, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> ACTIVATING NEXT STAGE <<<:0.50:1", 82, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger new_check_case_stg:InValue:5:0.30:1", 81, null);
		EntFire("new_check_delay_*", "AddOutput", "OnTrigger map_nuke_stg4:Enable::0.30:1", 80, null);
		EntFire("spx_owl_nade", "AddOutput", "origin -13604 1671 -10059", 7.5, null);
		EntFire("spx_hat_nade", "AddOutput", "origin -14920 678 -10059", 7.5, null);
		EntFire("map_skybox_spawn", "Kill", "", 75.5, null);
		EntFire("map_soundsys_case", "InValue", "2", 38, null);
		EntFire("map_soundsys_case", "InValue", "4", 39, null);
		EntFire("filter_class_xstg_*", "Kill", "", 0.2, null);
		EntFire("map_switch_*", "Kill", "", 3.6, null);
		EntFire("console", "Command", "zr_class_modify zombies health 60000", 0.06, null);
		EntFire("console", "Command", "sv_enablebunnyhopping 1", 0.04, null);
		EntFire("console", "Command", "zr_infect_mzombie_ratio 5", 0.02, null);
		EntFire("map_template_bosscount", "ForceSpawn", "", 34, null);
		EntFire("map_template_bosscount", "Kill", "", 35, null);
		EntFire("map_m_v", "Kill", "", 0.3, null);
		EntFire("mode_stage_acces", "FireUser1", "", 0.8, null);
		EntFire("map_soundsys_case", "FireUser1", "", 70, null);
		EntFire("map_adroom_opt_flycars", "Trigger", "", 36, null);
		EntFire("map_fx_perm1", "FireUser1", "", 3.8, null);
		EntFire("map_fx_perm1", "FireUser2", "", 4.1, null);
		EntFire("new_check_anyone", "AddOutput", "OnTrigger map_nuke_stg4:Enable::2:1", 80, null);
	}
	else if(STAGE == 12 && !ONLYZMMOD)
	{
		EntFire("mode_stage_acces", "Break", "", 35, null);
		EntFire("map_zmfix_spawn", "Enable", "", 34, null);
		EntFire("mode_teleport_zm", "AddOutput", "OnStartTouch !activator:AddOutput:health 75000:0:-1", 8.5, null);
		EntFire("spxZM_emendo_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:health 75000:0:-1", 8.5, null);
		EntFire("map_zmfix_spawn", "AddOutput", "OnStartTouch !activator:AddOutput:health 75000:0:-1", 8.5, null);
		EntFire("mode_start_ct", "AddOutput", "origin -13290 15299 -15259", 8, null);
		EntFire("mode_start_zm", "AddOutput", "origin -13290 15407 -15259", 8, null);
		EntFire("mode_start_*", "AddOutput", "angles 0 270 0", 8, null);
		EntFire("console", "Command", "say >>> STAGE 12/12 - FINAL STAGE - EXTREME MODE <<<", 7, null);
		EntFire("map_adroom_opt_fixup", "FireUser1", "", 6, null);
		EntFire("console", "Command", "say >>> STAGE 12/12 - FINAL STAGE - EXTREME MODE <<<", 5, null);
		EntFire("map_sound_switch_xtrm1", "PlaySound", "", 5, null);
		EntFire("map_sound_switch_xtrm1", "AddOutput", "message #harrypotterze/stages/xxstg12beginningx.mp3", 1.00, null);
		EntFire("map_sound_switch_xtrm2", "AddOutput", "message #harrypotterze/stages/xxstg12bossfightfinalx.mp3", 1.00, null);
		EntFire("map_sound_switch_xtrm1", "Volume", "10", 5.2, null);
		EntFire("map_texturetoggle", "SetTextureIndex", "12", 0, null);
		EntFire("filter_targets_block_multi", "FireUser1", "", 30, null);
		EntFire("stageZM_*", "Kill", "", 3, null);
		EntFire("stage1_*", "Kill", "", 1, null);
		EntFire("stage4_*", "Kill", "", 2.5, null);
		EntFire("stage3_*", "Kill", "", 2, null);
		EntFire("stage2_*", "Kill", "", 1.5, null);
		EntFire("filter_targets_block_multi", "FireUser3", "", 40, null);
		EntFire("mapx*", "Kill", "", 3.5, null);
		EntFire("admin_fixups", "Trigger", "", 11, null);
		EntFire("map_barrels_temp1", "ForceSpawn", "", 29, null);
		EntFire("map_barrels_temp1", "ForceSpawn", "", 30.5, null);
		EntFire("map_barrelset1_brush", "AddOutput", "origin -13182 12576 -15312", 29.5, null);
		EntFire("map_barrelset1_brush", "AddOutput", "angles 0 90 0", 29.5, null);
		EntFire("map_barrelset1_brush", "AddOutput", "origin -13409 12576 -15312", 31, null);
		EntFire("map_barrelset1_brush", "AddOutput", "angles 0 90 0", 31, null);
		EntFire("map_trigger_spawntele", "Disable", "", 75, null);
		EntFire("mode_teleport_*", "Enable", "", 75, null);
		EntFire("map_template_leversys", "ForceSpawn", "", 32, null);
		EntFire("map_leversys_brush", "AddOutput", "origin -13298 12592 -15323", 33, null);
		EntFire("map_leversys_brush", "AddOutput", "angles 0 90 0", 33, null);
		EntFire("map_wandrespawn", "Enable", "", 65, null);
		EntFire("console", "Command", "say >>> GATE BREAKING IN 6 SECONDS <<<", 29, null);
		EntFire("stage5_ending_relay", "Kill", "", 0.6, null);
		EntFire("stage5_buttoncase", "AddOutput", "OnCase02 stage5_hold_r_breakdoor:FireUser2::5:1", 9, null);
		EntFire("stage5_buttoncase", "AddOutput", "OnCase03 stage5_hold_l_breakdoor:FireUser2::5:1", 9, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:LowerRandomBound:2:0.1:-1", 10, null);
		EntFire("map_boss_template", "AddOutput", "OnEntitySpawned map_boss_timer_attacks:UpperRandomBound:3:0.1:-1", 10.5, null);
		EntFire("map_barrelset1_*", "ClearParent", "", 29.8, null);
		EntFire("map_barrelset1_brush", "Kill", "", 30, null);
		EntFire("stage5_torchsystem", "InValue", "1", 20, null);
		EntFire("map_protection_off", "Enable", "", 37, null);
		EntFire("map_protection_on", "Disable", "", 36, null);
		EntFire("filter_prop*", "Kill", "", 0.4, null);
		EntFire("filter_stg3*", "Kill", "", 0.2, null);
		EntFire("filter_wiz_*", "Kill", "", 0.4, null);
		EntFire("filter_b*", "Kill", "", 0.2, null);
		EntFire("filter_m*", "Kill", "", 0.2, null);
		EntFire("map_trigger_itemexitfix", "Enable", "", 72, null);
		EntFire("mode_teleport_ct", "Kill", "", 71, null);
		EntFire("mode_teleport_zm", "Kill", "", 71, null);
		EntFire("mode_start_ct", "Kill", "", 71, null);
		EntFire("map_trigger_spx", "Kill", "", 71, null);
		EntFire("map_trigger_spawntele", "Enable", "", 70, null);
		EntFire("mode_teleport_both", "Enable", "", 70, null);
		EntFire("mode_teleport_*", "Disable", "", 69, null);
		EntFire("stage5_slidedoor1", "AddOutput", "OnUser2 stage5_boss_template_rain:FireUser2::0:1", 10.4, null);
		EntFire("map_bosssys_comp", "AddOutput", "OnEqualTo map_template_bossdropper:ForceSpawn::1:-1", 10.2, null);
		EntFire("map_bosssys_comp", "AddOutput", "OnEqualTo map_template_bossdropper:AddOutput:origin 1096 14064 -16288:0:-1", 10, null);
		EntFire("masstele_stg1*", "Kill", "", 4.2, null);
		EntFire("masstele_stg2*", "Kill", "", 4.2, null);
		EntFire("masstele_stg4*", "Kill", "", 4.2, null);
		EntFire("stage5_boss_all_timer_tor", "AddOutput", "OnTimer stage5_boss_all_case_tor:PickRandom::0.6:-1", 10, null);
		EntFire("map_skybox_template", "Kill", "", 73, null);
		EntFire("map_skybox_clouds", "AddOutput", "targetname stage5_skyprops_clouds", 29.6, null);
		EntFire("map_skybox_template", "ForceSpawn", "", 29.4, null);
		EntFire("map_skybox_template", "AddOutput", "origin 14561 -13442 -14815", 8, null);
		EntFire("map_template_fix2", "ForceSpawn", "", 6.4, null);
		EntFire("map_trigger_fasttele", "Enable", "", 75.5, null);
		EntFire("stage5_miniboss_break1", "AddOutput", "OnBreak map_sound_switch_drags:AddOutput:message harrypotterze/bosses/xspeech_voldemort_stg12x.mp3:0.20:1", 10, null);
		EntFire("map_sound_switch_drags", "AddOutput", "message harrypotterze/bosses/xscream_fluffy_1x.mp3", 10.5, null);
		EntFire("map_trigger_itemexitfix", "Kill", "", 75.4, null);
		EntFire("map_trigger_itemexitfix", "Disable", "", 74, null);
		EntFire("map_adroom_opt_weather", "Trigger", "", 4.4, null);
		EntFire("weathersys_temp_stg2", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg4", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg5", "Kill", "", 4.3, null);
		EntFire("weathersys_temp_stg1", "Kill", "", 4.3, null);
		EntFire("stage5_buttoncase", "FireUser1", "", 36, null);
		EntFire("map_protection_on", "Enable", "", 4.5, null);
		EntFire("map_protection_on", "Kill", "", 37, null);
		EntFire("stage5_miniboss_d_case", "Kill", "", 0.6, null);
		EntFire("map_spwnr_prop8_b*", "Kill", "", 35, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 34.7, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin -11748 13278 -15334", 34.6, null);
		EntFire("map_template_props8", "ForceSpawn", "", 34.5, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 34.4, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin -14326 13278 -15334", 34.3, null);
		EntFire("map_template_props8", "ForceSpawn", "", 34.2, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 34.1, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin -12255 13278 -15334", 34, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33.9, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 33.8, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin -14833 13278 -15334", 33.7, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33.6, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 33.5, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin -13291 14377 -15334", 33.4, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "angles 0 180 0", 33.4, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33.3, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "targetname map_spwnr_prop8_x", 33.2, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "origin -13291 15035 -15334", 33.1, null);
		EntFire("map_spwnr_prop8_smll", "AddOutput", "angles 0 180 0", 33.1, null);
		EntFire("map_template_props8", "ForceSpawn", "", 33, null);
		EntFire("map_shake", "StartShake", "", 5.2, null);
		EntFire("mode_teleport_ct", "AddOutput", "OnStartTouch map_barrels_shaker:FireUser2::0.2:1", 10, null);
		EntFire("map_score", "AddOutput", "points 500", 4.1, null);
		EntFire("map_hint_case", "FireUser3", "", 6.5, null);
		EntFire("map_hint_msg8C", "AddOutput", "message This is the final stage", 5.9, null);
		EntFire("map_hint_case", "InValue", "16", 5.8, null);
		EntFire("map_hint_case", "InValue", "13", 5.4, null);
		EntFire("map_shake", "FireUser3", "", 60, null);
		EntFire("new_check_delay_20", "Kill", "", 79.5, null);
		EntFire("map_hints_text_all", "AddOutput", "targetname map_hint_timeleft", 87.8, null);
		EntFire("map_hints_text_all", "AddOutput", "color 255 255 72", 87.4, null);
		EntFire("map_hints_text_all", "AddOutput", "holdtime 2", 87.4, null);
		EntFire("map_hints_text_all", "AddOutput", "channel 1", 87.4, null);
		EntFire("map_hints_temp_all", "ForceSpawn", "", 87, null);
		EntFire("map_hints_text_all", "AddOutput", "targetname map_hint_end", 86.9, null);
		EntFire("map_hints_text_all", "AddOutput", "message ZE_HARRY_POTTER_V2\nCONGRATULATIONS\nYOU BEAT THE MAP\nMAP COMPLETE\nALL MODES COMPLETE\nTHANKS FOR PLAYING\nCREATION BY SKULLZ AND DEVIOUS", 86.6, null);
		EntFire("map_hints_text_all", "AddOutput", "color 255 255 72", 86.3, null);
		EntFire("map_hints_text_all", "AddOutput", "holdtime 6", 86.3, null);
		EntFire("map_hints_text_all", "AddOutput", "channel 1", 86.3, null);
		EntFire("map_hints_temp_all", "ForceSpawn", "", 86, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> THANKS FOR PLAYING THIS MAP <<<:0.60:1", 85, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger map_nuke_stg5:Enable::0.60:1", 84, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger console:Command:say >>> ALL STAGES COMPLETE - RESETTING MAP <<<:0.50:1", 83, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger new_check_case_stg:InValue:7:0.30:1", 82, null);
		EntFire("new_check_relay", "AddOutput", "OnTrigger world:FireUser4::0.20:1", 81, null);
		EntFire("new_check_delay_*", "AddOutput", "OnTrigger map_nuke_stg5:Enable::0.30:1", 80, null);
		EntFire("spx_owl_nade", "AddOutput", "origin -11356 13026 -15322", 7.5, null);
		EntFire("spx_hat_nade", "AddOutput", "origin -15227 13529 -15322", 7.5, null);
		EntFire("map_skybox_spawn", "Kill", "", 75.5, null);
		EntFire("map_soundsys_case", "InValue", "2", 35.5, null);
		EntFire("map_soundsys_case", "InValue", "4", 36.5, null);
		EntFire("filter_class_xstg_*", "Kill", "", 0.4, null);
		EntFire("map_trigger_skins_h", "Kill", "", 0.8, null);
		EntFire("item_skin_hp_*", "Kill", "", 0.8, null);
		EntFire("map_trigger_skins_v", "Kill", "", 0.8, null);
		EntFire("item_skin_vold_*", "Kill", "", 0.8, null);
		EntFire("zad_comp_ex", "SetCompareValue", "1", 4.5, null);
		EntFire("console", "Command", "zr_class_modify zombies health_infect_gain 350", 0.08, null);
		EntFire("console", "Command", "zr_class_modify zombies health 90000", 0.06, null);
		EntFire("console", "Command", "sv_enablebunnyhopping 1", 0.04, null);
		EntFire("console", "Command", "zr_infect_mzombie_ratio 5", 0.02, null);
		EntFire("map_soundsys_case", "InValue", "15", 10.6, null);
		EntFire("map_soundsys_case", "InValue", "12", 66, null);
		EntFire("map_soundsys_case", "InValue", "14", 67, null);
		EntFire("map_template_bosscount", "ForceSpawn", "", 34, null);
		EntFire("stage5_case1", "FireUser2", "", 29.1, null);
		EntFire("stage5_n_death2_spawn", "AddOutput", "OnTrigger stage5_boss_end_break1:FireUser2::5:1", 9, null);
		EntFire("map_soundsys_case", "FireUser1", "", 70, null);
		EntFire("map_adroom_opt_flycars", "Trigger", "", 36, null);
		EntFire("stage5_ending_checkme", "SetCompareValue", "1", 4.5, null);
		EntFire("map_fx_perm1", "FireUser1", "", 3.8, null);
		EntFire("map_fx_perm1", "FireUser2", "", 4.1, null);
		EntFire("new_check_anyone", "AddOutput", "OnTrigger map_nuke_stg5:Enable::2:1", 80, null);
	}
	else if(STAGE == 13 && !ONLYZMMOD)
	{
		EntFire("map_nuke_spawn", "Enable", "", 96, null);
		EntFire("glob_break1", "Kill", "", 20.5, null);
		EntFire("mapx_teleport", "Disable", "", 19, null);
		EntFire("map_trigger_spawntele", "Enable", "", 19, null);
		EntFire("console", "Command", "say >>> TROLOLOLOL SURVIVE OR DIE WHUEHUEHUE <<<", 18, null);
		EntFire("console", "Command", "say >>> OOPS I LIED THERE IS NO SECRET SPECIAL STAGE <<<", 17, null);
		EntFire("map_hint_hidstg", "AddOutput", "message OH SHIT WHAT IS THIS\nOOPS I LIED THERE IS NO SECRET SPECIAL STAGE\nTROLOLOLOL SURVIVE OR DIE WHUEHUEHUE\nTHANKS FOR PLAYING THIS MAP\nIT WAS FUN TO DESIGN", 15.5, null);
		EntFire("mapx_teleport", "Enable", "", 15, null);
		EntFire("mode_start_zm", "AddOutput", "origin -7864 1768 -4296", 8.5, null);
		EntFire("mapx_x_doors", "Lock", "", 97.8, null);
		EntFire("mapx_x_br", "Kill", "", 20.5, null);
		EntFire("console", "Command", "say >>> CONGRATZ WITH THE VICTORY <<<", 13, null);
		EntFire("console", "Command", "say >>> OMG WTF THEY WON ALL STAGES?? <<<", 5, null);
		EntFire("console", "Command", "say >>> SECRET SPECIAL STAGE UNLOCKED <<<", 6, null);
		EntFire("console", "Command", "say >>> THANKS FOR PLAYING THIS MAP <<<", 20, null);
		EntFire("map_sound_switch_xtrm1", "Volume", "10", 5.2, null);
		EntFire("map_sound_switch_xtrm1", "PlaySound", "", 5, null);
		EntFire("map_sound_switch_xtrm1", "AddOutput", "message #harrypotterze/stages/xmapsecretnewx.mp3", 1.00, null);
		EntFire("map_hint_hidstg", "AddOutput", "message 1 MINUTE LEFT", 21.5, null);
		EntFire("console", "Command", "say >>> NO WANDS AVAILABLE FOR THIS STAGE <<<", 7, null);
		EntFire("console", "Command", "say >>> OHWELL GET READY <<<", 14, null);
		EntFire("map_texturetoggle", "SetTextureIndex", "13", 0, null);
		EntFire("admin_fixups", "Trigger", "", 14, null);
		EntFire("map_wandrespawn", "Kill", "", 0.5, null);
		EntFire("map_wandblock_*", "Enable", "", 4, null);
		EntFire("map_fade", "AddOutput", "duration 1", 10, null);
		EntFire("map_fade", "AddOutput", "holdtime 1", 10, null);
		EntFire("map_fade", "AddOutput", "rendercolor 0 0 0", 10, null);
		EntFire("map_fade", "Fade", "", 14, null);
		EntFire("map_shake", "StartShake", "", 81, null);
		EntFire("map_sound_switch_xtrm2", "Kill", "", 0.1, null);
		EntFire("map_sound_switch_drags", "Kill", "", 4.3, null);
		EntFire("map_protection_*", "Kill", "", 0.5, null);
		EntFire("stageZM_*", "Kill", "", 3.5, null);
		EntFire("stage5_*", "Kill", "", 3, null);
		EntFire("stage4_*", "Kill", "", 2.5, null);
		EntFire("stage3_*", "Kill", "", 2, null);
		EntFire("stage2_*", "Kill", "", 1.5, null);
		EntFire("stage1_*", "Kill", "", 1, null);
		EntFire("mode_teleport_*", "Kill", "", 0.9, null);
		EntFire("filter_o*", "Kill", "", 0.8, null);
		EntFire("filter_p*", "Kill", "", 0.8, null);
		EntFire("filter_s*", "Kill", "", 0.8, null);
		EntFire("filter_t*", "Kill", "", 0.8, null);
		EntFire("filter_w*", "Kill", "", 0.8, null);
		EntFire("filter_b*", "Kill", "", 0.7, null);
		EntFire("filter_d*", "Kill", "", 0.7, null);
		EntFire("filter_f*", "Kill", "", 0.7, null);
		EntFire("filter_h*", "Kill", "", 0.7, null);
		EntFire("filter_m*", "Kill", "", 0.7, null);
		EntFire("map_wandslevelZM", "Kill", "", 0.5, null);
		EntFire("map_wandlevels", "Kill", "", 0.5, null);
		EntFire("spx*", "Kill", "", 0.4, null);
		EntFire("item*", "Kill", "", 0.4, null);
		EntFire("map_boss*", "Kill", "", 0.2, null);
		EntFire("map_miniboss*", "Kill", "", 0.2, null);
		EntFire("map_soundsys_*", "Kill", "", 0.25, null);
		EntFire("map_sound_teleport", "Kill", "", 23, null);
		EntFire("map_sound_wands", "Kill", "", 23, null);
		EntFire("map_barrels_*", "Kill", "", 1.1, null);
		EntFire("map_template_boss*", "Kill", "", 1.3, null);
		EntFire("map_wandblock_*", "Disable", "", 95.5, null);
		EntFire("map_force_effect_exp", "Start", "", 97, null);
		EntFire("map_template_effect1", "AddOutput", "origin -8984 1768 -4288", 22.5, null);
		EntFire("console", "Command", "say >>> THANKS FOR PLAYING THIS MAP <<<", 97.5, null);
		EntFire("map_template_effect1", "ForceSpawn", "", 24, null);
		EntFire("map_skybox_*", "Kill", "", 18.5, null);
		EntFire("filter_class_physics", "Kill", "", 0.9, null);
		EntFire("map_tornado_*", "Kill", "", 1.7, null);
		EntFire("map_template_leversys", "Kill", "", 1.4, null);
		EntFire("map_template_miniboss", "Kill", "", 1.3, null);
		EntFire("map_template_props*", "Kill", "", 14.5, null);
		EntFire("map_template_torch*", "Kill", "", 1.2, null);
		EntFire("map_template_tornado", "Kill", "", 1.8, null);
		EntFire("map_skybox_template", "Kill", "", 3.6, null);
		EntFire("mapx_x_fly*", "Kill", "", 79, null);
		EntFire("map_fly*", "Kill", "", 79, null);
		EntFire("console", "Command", "say >>> RESETTING MAP <<<", 99, null);
		EntFire("map_hint_hidstg", "AddOutput", "message 30 SECONDS LEFT", 51.5, null);
		EntFire("console", "Command", "say >>> CREATION BY SKULLZ AND DEVIOUS <<<", 98.4, null);
		EntFire("map_knifefix_*", "Kill", "", 3.2, null);
		EntFire("map_targetfix_*", "Kill", "", 3.2, null);
		EntFire("map_template_fix*", "Kill", "", 1.2, null);
		EntFire("map_healthb_*", "Kill", "", 0.5, null);
		EntFire("weathersys_*", "Kill", "", 4.4, null);
		EntFire("buttonsys_*", "Kill", "", 1.6, null);
		EntFire("map_shake", "StartShake", "", 13.5, null);
		EntFire("spx*", "Kill", "", 9.1, null);
		EntFire("map_hint_msg8C", "Kill", "", 5.9, null);
		EntFire("map_hint_msg8B", "Kill", "", 5.9, null);
		EntFire("map_hint_msg8A", "AddOutput", "message CONGRATULATIONS ON BEATING THE MAP\nSPECIAL STAGE UNLOCKED\nHAVE FUN", 5.8, null);
		EntFire("map_template_rockattack", "FireUser1", "", 3.7, null);
		EntFire("respawn_*", "Kill", "", 2.1, null);
		EntFire("filter_x*", "Kill", "", 0.9, null);
		EntFire("new_check_*", "Kill", "", 1.1, null);
		EntFire("new_check_*", "Kill", "", 0.2, null);
		EntFire("mode_start_ct", "AddOutput", "origin -10101 1768 -4279", 81.5, null);
		EntFire("mode_start_*", "AddOutput", "angles 0 0 0", 81.5, null);
		EntFire("mapx_x_tele*", "Enable", "", 82, null);
		EntFire("map_hint_hidstg", "AddOutput", "message RUN INSIDE AND PRESS THE LEVER", 93.5, null);
		EntFire("map_hint_hidstg", "AddOutput", "message 5 SECONDS LEFT", 87.5, null);
		EntFire("map_hint_hidstg", "AddOutput", "message DOORS OPENING IN 10 SECONDS", 82.5, null);
		EntFire("mapx_x_tele*", "Disable", "", 83, null);
		EntFire("console", "Command", "say >>> OOPS I LIED HUEHUEHUE <<<", 97, null);
		EntFire("mapx_x_devious", "Break", "", 97, null);
		EntFire("mapx_x_gravfix", "Enable", "", 82, null);
		EntFire("mapx_x_doors", "Open", "", 93, null);
		EntFire("mapx_x_trigs", "Kill", "", 80, null);
		EntFire("mapx_x_skins*", "Kill", "", 80, null);
		EntFire("mapx_x_nukeCT", "Enable", "", 99.5, null);
		EntFire("mapx_x_nukeZM", "Enable", "", 98, null);
		EntFire("mapx_x_tele*", "Kill", "", 95.5, null);
		EntFire("map_fade", "Fade", "", 80.5, null);
		EntFire("mapx_x_prop", "Enable", "", 82, null);
		EntFire("map_hint_msg8A", "Display", "", 5.8, null);
		EntFire("map_sc*", "Kill", "", 4.2, null);
		EntFire("stageZM_towers_ldoors", "Kill", "", 14.5, null);
		EntFire("stageZM_towers_*", "Kill", "", 80.5, null);
		EntFire("map_template_props4", "AddOutput", "origin -8588 915 -4311", 9.2, null);
		EntFire("map_template_props4", "AddOutput", "origin -9380 1413 -4311", 9.4, null);
		EntFire("map_template_props4", "AddOutput", "origin -9380 2621 -4311", 9.6, null);
		EntFire("map_template_props4", "AddOutput", "origin -8588 2123 -4311", 9.8, null);
		EntFire("map_template_props4", "ForceSpawn", "", 9.3, null);
		EntFire("map_template_props4", "ForceSpawn", "", 9.5, null);
		EntFire("map_template_props4", "ForceSpawn", "", 9.7, null);
		EntFire("map_template_props4", "ForceSpawn", "", 9.9, null);
		EntFire("map_template_towers", "Kill", "", 14.5, null);
		EntFire("map_template_props5", "ForceSpawn", "", 9.9, null);
		EntFire("map_template_props5", "AddOutput", "origin -9972 3125 -2873", 9.8, null);
		EntFire("map_template_props5", "ForceSpawn", "", 9.7, null);
		EntFire("map_template_props5", "AddOutput", "origin -8087 3029 -2873", 9.6, null);
		EntFire("map_template_props5", "ForceSpawn", "", 9.5, null);
		EntFire("map_template_props5", "AddOutput", "origin -8025 2925 -2873", 9.4, null);
		EntFire("map_template_props5", "ForceSpawn", "", 9.3, null);
		EntFire("map_template_props5", "AddOutput", "origin -8059 2818 -2873", 9.2, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 180 0", 9.8, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 90 0", 9.6, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 15 0", 9.4, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 270 0", 9.2, null);
		EntFire("map_template_props5", "AddOutput", "origin -9973 3016 -2873", 10, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 15 0", 10, null);
		EntFire("map_template_props5", "ForceSpawn", "", 10.1, null);
		EntFire("map_template_props5", "AddOutput", "origin -10116 2817 -2873", 10.2, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 90 0", 10.2, null);
		EntFire("map_template_props5", "ForceSpawn", "", 10.3, null);
		EntFire("map_template_props5", "AddOutput", "origin -10215 2817 -2873", 10.4, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 270 0", 10.4, null);
		EntFire("map_template_props5", "ForceSpawn", "", 10.5, null);
		EntFire("map_template_props5", "AddOutput", "origin -10213 717 -2873", 10.6, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 90 0", 10.6, null);
		EntFire("map_template_props5", "ForceSpawn", "", 10.7, null);
		EntFire("map_template_props5", "AddOutput", "origin -10114 717 -2873", 10.8, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 180 0", 10.8, null);
		EntFire("map_template_props5", "ForceSpawn", "", 10.9, null);
		EntFire("map_template_props5", "AddOutput", "origin -9926 519 -2873", 11, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 15 0", 11, null);
		EntFire("map_template_props5", "ForceSpawn", "", 11.1, null);
		EntFire("map_template_props5", "AddOutput", "origin -9960 412 -2873", 11.2, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 0 0", 11.2, null);
		EntFire("map_template_props5", "ForceSpawn", "", 11.3, null);
		EntFire("map_template_props5", "AddOutput", "origin -7754 718 -2873", 11.4, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 180 0", 11.4, null);
		EntFire("map_template_props5", "ForceSpawn", "", 11.5, null);
		EntFire("map_template_props5", "AddOutput", "origin -8101 621 -2873", 11.6, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 270 0", 11.6, null);
		EntFire("map_template_props5", "ForceSpawn", "", 11.7, null);
		EntFire("map_template_props5", "AddOutput", "origin -8039 517 -2873", 11.8, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 15 0", 11.8, null);
		EntFire("map_template_props5", "ForceSpawn", "", 11.9, null);
		EntFire("map_template_props5", "AddOutput", "origin -8073 410 -2873", 12, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 90 0", 12, null);
		EntFire("map_template_props5", "ForceSpawn", "", 12.1, null);
		EntFire("map_template_props5", "AddOutput", "origin -8983 1318 -2873", 12.2, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 330 0", 12.2, null);
		EntFire("map_template_props5", "ForceSpawn", "", 12.3, null);
		EntFire("map_template_props5", "AddOutput", "origin -8983 2218 -2873", 12.4, null);
		EntFire("map_template_props5", "AddOutput", "angles 0 30 0", 12.4, null);
		EntFire("map_template_props5", "ForceSpawn", "", 12.5, null);
		EntFire("map_template_towers", "ForceSpawn", "", 11.7, null);
		EntFire("map_template_towers", "AddOutput", "origin -8466 1164 -4311", 11.6, null);
		EntFire("map_template_towers", "AddOutput", "angles 0 90 0", 11.6, null);
		EntFire("map_template_towers", "ForceSpawn", "", 11.5, null);
		EntFire("map_template_towers", "AddOutput", "origin -9502 1164 -4311", 11.4, null);
		EntFire("map_template_towers", "AddOutput", "angles 0 270 0", 11.4, null);
		EntFire("map_template_towers", "ForceSpawn", "", 11.3, null);
		EntFire("map_template_towers", "AddOutput", "origin -8466 2372 -4311", 11.2, null);
		EntFire("map_template_towers", "AddOutput", "angles 0 90 0", 11.2, null);
		EntFire("map_template_towers", "ForceSpawn", "", 11.1, null);
		EntFire("map_template_towers", "AddOutput", "origin -9502 2372 -4311", 11, null);
		EntFire("map_template_towers", "AddOutput", "angles 0 270 0", 11, null);
		EntFire("mapx_x_gravfix", "Kill", "", 87, null);
		EntFire("mapx_x_gravity", "Kill", "", 80, null);
		EntFire("map_adroom_opt_fixup", "FireUser1", "", 8, null);
		EntFire("map_sound_birdies", "Kill", "", 23, null);
		EntFire("map_switch_*", "Kill", "", 3.6, null);
		EntFire("map_trigger_sk*", "Kill", "", 0.3, null);
		EntFire("map_trigger_wands", "Kill", "", 0.3, null);
		EntFire("map_triggers_pushZM", "Kill", "", 0.3, null);
		EntFire("map_spxHM_t", "SetTextureIndex", "1", 2.2, null);
		EntFire("map_spxZM_t", "SetTextureIndex", "0", 2.2, null);
		EntFire("zad_comp_ex", "SetCompareValue", "1", 4, null);
		EntFireByHandle(self,"RunScriptCode","WonLevel();",4.00,null,null);
		EntFire("console", "Command", "zr_class_modify zombies health 5000", 0.14, null);
		EntFire("console", "Command", "sv_enablebunnyhopping 1", 0.15, null);
		EntFire("console", "Command", "zr_infect_spawntime_max 12.0", 0.08, null);
		EntFire("console", "Command", "zr_infect_spawntime_min 11.0", 0.09, null);
		EntFire("map_nadesound", "Kill", "", 23, null);
		EntFire("mapx_x_gravity", "Enable", "", 16.5, null);
		EntFire("mapx_x_gravity", "Disable", "", 79.5, null);
		EntFire("map_m_v", "Kill", "", 0.3, null);
		EntFire("console", "Command", "say >>> CREATION BY SKULLZ AND DEVIOUS <<<", 98.5, null);
		EntFire("console", "Command", "say >>> CREATION BY SKULLZ AND DEVIOUS <<<", 98.6, null);
		EntFire("map_hint_hidstg", "AddOutput", "message 20 SECONDS LEFT", 61.5, null);
		EntFire("map_hint_hidstg", "AddOutput", "message 45 SECONDS LEFT", 36.5, null);
		EntFire("map_hint_msg8A", "AddOutput", "targetname map_hint_hidstg", 6.5, null);
		EntFire("map_hint_msg8A", "AddOutput", "color 223 223 0", 5.5, null);
		EntFire("map_hint_msg8A", "AddOutput", "x -1", 5.5, null);
		EntFire("console", "Command", "say >>> OH SHIT WHAT IS THIS <<<", 16, null);
		EntFire("map_hint_hidstg", "Display", "", 16, null);
		EntFire("console", "Command", "say >>> RUN INSIDE AND PRESS THE LEVER <<<", 94, null);
		EntFire("console", "Command", "say >>> 5 SECONDS LEFT <<<", 88, null);
		EntFire("console", "Command", "say >>> DOORS OPENING IN 10 SECONDS <<<", 83, null);
		EntFire("console", "Command", "say >>> 20 SECONDS LEFT <<<", 62, null);
		EntFire("console", "Command", "say >>> 30 SECONDS LEFT <<<", 52, null);
		EntFire("console", "Command", "say >>> 45 SECONDS LEFT <<<", 37, null);
		EntFire("console", "Command", "say >>> 1 MINUTE LEFT <<<", 22, null);
		EntFire("map_hint_hidstg", "Display", "", 94, null);
		EntFire("map_hint_hidstg", "Display", "", 88, null);
		EntFire("map_hint_hidstg", "Display", "", 83, null);
		EntFire("map_hint_hidstg", "Display", "", 62, null);
		EntFire("map_hint_hidstg", "Display", "", 52, null);
		EntFire("map_hint_hidstg", "Display", "", 37, null);
		EntFire("map_hint_hidstg", "Display", "", 22, null);
		EntFire("map_hint_hidstg", "Kill", "", 98.2, null);
		EntFire("map_adroom_opt_flycars", "Trigger", "", 19, null);
		EntFire("map_hint_msg8A", "AddOutput", "y 0.10", 5.5, null);
		EntFire("map_hint_msg8A", "AddOutput", "holdtime 4", 5.5, null);
		EntFire("map_hint_msg8A", "AddOutput", "channel 2", 5.5, null);
		EntFire("mode_start_ct", "AddOutput", "origin -10088 1768 -4296", 8.5, null);
		EntFire("mode_start_zm", "AddOutput", "angles 0 180 0", 9, null);
		EntFire("mode_start_ct", "AddOutput", "angles 0 0 0", 9, null);
	}
	CheckLevel();
    EntFireByHandle(self,"RunScriptCode","SetPlayerScript();",10.01,null,null);
	EntFireByHandle(self,"RunScriptCode","ShowItemTextLevel();",11.51,null,null);
	EntFireByHandle(self,"RunScriptCode","LoopFndPlSt();",60.00,null,null);
}

function CheckLevel()
{
	if(ZMITEMMAXLVL){EntFire("s_item_c", "RunScriptCode", "ZMITEMLVLUP=7;", 0.00, null);}
	if(BLOCKHUWANDSHOP && !CLOSEWANDSHOP){EntFire("map_wandblock_HM", "Enable", "", 0.00, null);}
	else if(!BLOCKHUWANDSHOP && !CLOSEWANDSHOP){EntFire("map_wandblock_HM", "Disable", "", 0.00, null);}
	if(BLOCKZMWANDSHOP && !CLOSEWANDSHOP){EntFire("map_wandblock_ZM", "Enable", "", 0.00, null);}
	else if(!BLOCKZMWANDSHOP && !CLOSEWANDSHOP){EntFire("map_wandblock_ZM", "Disable", "", 0.00, null);}
	if(AUTOBHOP)
	{
        EntFire("console", "Command", "sv_enablebunnyhopping 1", 5.00, null);
		EntFire("console", "Command", "sv_autobunnyhopping 1", 5.00, null);
		EntFire("console", "Command", "sv_staminamax 0", 5.00, null);
		EntFire("console", "Command", "sv_staminajumpcost 0", 5.00, null);
		EntFire("console", "Command", "sv_staminalandcost 0", 5.00, null);
		EntFire("console", "Command", "sv_staminarecoveryrate 0", 5.00, null);
		EntFire("console", "Command", "sv_airaccelerate 120", 5.00, null);
		EntFire("console", "Command", "sv_maxspeed 1000", 5.00, null);
	}
	else if(!AUTOBHOP)
	{
        EntFire("console", "Command", "sv_enablebunnyhopping 0", 0.00, null);
		EntFire("console", "Command", "sv_autobunnyhopping 0", 0.00, null);
		EntFire("console", "Command", "sv_airaccelerate 12", 0.00, null);
		EntFire("console", "Command", "sv_maxspeed 300", 5.00, null);
	}
}

function SetPlayerScript()
{
	local FplHu = null;
	while(null != (FplHu = Entities.FindByClassname(FplHu, "player")))
	{
		if(FplHu.GetTeam() == 3 && FplHu.GetHealth() > 0 && FplHu.GetName() != "player_s" && FplHu.GetName() != "harrypotter")
		{
            EntFire("!activator", "RunScriptFile", "harryk/harry_player.nut", 0.00, FplHu);
            EntFire("!activator", "AddOutput", "targetname player_s", 0.01, FplHu);
		}
	}
	local FplZm = null;
	while(null != (FplZm = Entities.FindByClassname(FplZm, "player")))
	{
		if(FplZm.GetTeam() == 2 && FplZm.GetHealth() > 0 && FplZm.GetName() != "player_s" && FplZm.GetName() != "harrypotter")
		{
            EntFire("!activator", "RunScriptFile", "harryk/harry_player.nut", 0.00, FplZm);
            EntFire("!activator", "AddOutput", "targetname player_s", 0.01, FplZm);
		}
	}
}

function ShowItemTextLevel()
{
	local FndPl = null;
	while(null != (FndPl = Entities.FindByClassname(FndPl, "player")))
	{
		if(FndPl.IsValid() && FndPl.GetHealth() > 0 && FndPl.GetName() == "player_s" || 
		FndPl.IsValid() && FndPl.GetHealth() > 0 && FndPl.GetName() == "harrypotter")
		{
            EntFire("!activator", "RunScriptCode", "CreatHand();", 0.00, FndPl);
		}
	}
}

function WonLevel()
{
	STAGE++;
	if(STAGE <= 6){EXTREME = false;}
	else if(STAGE >= 7){EXTREME = true;}
}

////////////////////////
Monc <- true;
////////////////////////

function MessageText(m)
{
    if(Monc && m == 0)
	{
		Monc = false;
		EntFire("map_hint_msg1", "SetText", "ZE_HARRY_POTTER_V2_1\nCREATION BY SKULLZ AND DEVIOUS\n12 STAGES\n18 WANDS\n15 SKINS\n3 SECRETS\nMANY BOSSFIGHTS\nZOMBIE MOD\nWIZARD MODE\nEXTREME MODE\nADMIN ROOM INCLUDED\nENJOY", 0.00, null);
		EntFire("map_hint_msg1", "Display", "", 0.50, null);
		EntFire("map_hint_msg1", "SetText", "SPECIAL THANKS GOES TO\nKAESAR\nANSEGA\nKAEMON\nZACADE\nJORISCEOEN\nLEV\nANEX\nGEORGE\nMOLTARD\nBLUE DRAGON\nJENZ\nSHADES\nROBIN\nALSO THANKS TO EVERYONE REPORTING ISSUES", 5.00, null);
		EntFire("map_hint_msg1", "Display", "", 5.50, null);
		EntFire("map_hint_msg1", "AddOutput", "y 0.20", 11.00, null);
		EntFire("map_hint_msg1", "AddOutput", "holdtime 6", 11.00, null);
		EntFire("map_hint_msg1", "AddOutput", "channel 2", 11.00, null);
		EntFire("map_hint_msg1", "AddOutput", "color 255 34 255", 11.00, null);
		EntFire("map_hint_msg1", "AddOutput", "targetname admin_hint", 11.50, null);
	}
	else if(!Monc && m == 0)
	{
		EntFire("map_hint_msg1", "SetText", "ZE_HARRY_POTTER_V2_1\nCREATION BY SKULLZ AND DEVIOUS\nENJOY", 0.00, null);
		EntFire("map_hint_msg1", "Display", "", 0.50, null);
		EntFire("map_hint_msg1", "AddOutput", "y 0.20", 6.00, null);
		EntFire("map_hint_msg1", "AddOutput", "holdtime 6", 6.00, null);
		EntFire("map_hint_msg1", "AddOutput", "channel 0", 6.00, null);
		EntFire("map_hint_msg1", "AddOutput", "color 255 34 255", 6.00, null);
		EntFire("map_hint_msg1", "AddOutput", "targetname admin_hint", 6.50, null);
	}
	if(m == 1)
	{
		EntFire("map_hint_msg3", "SetText", "HARRY POTTER WIZARD MODE\n!!! ZOMBIES COLLECTED THE BROOMSTICK !!!\nRESTARTING MODE\nBETTER LUCK NEXT TIME", 0.00, null);
	}
	if(m == 2)
	{
		EntFire("map_hint_msg4", "SetText", "HARRY POTTER WIZARD MODE\nBROOMSTICK DELIVERED SUCCESFULLY\nNEXT MINISTAGE WILL ACTIVATE SOON\nGOOD LUCK", 0.00, null);
	}
	if(m == 3)
	{
		EntFire("map_hint_msg3", "SetText", "HARRY POTTER WIZARD MODE\n!!! ZOMBIES COLLECTED THE EGG !!!\nRESTARTING MODE\nBETTER LUCK NEXT TIME", 0.00, null);
	}
	if(m == 4)
	{
		EntFire("map_hint_msg4", "SetText", "HARRY POTTER WIZARD MODE\nEGG DELIVERED SUCCESFULLY\nNEXT MINISTAGE WILL ACTIVATE SOON\nGOOD LUCK", 0.00, null);
	}
	if(m == 5)
	{
		EntFire("map_hint_msg3", "SetText", "HARRY POTTER WIZARD MODE\n!!! ZOMBIES COLLECTED THE CUP !!!\nRESTARTING MODE\nBETTER LUCK NEXT TIME", 0.00, null);
	}
	if(m == 6)
	{
		EntFire("map_hint_msg4", "SetText", "HARRY POTTER WIZARD MODE\nCUP DELIVERED SUCCESFULLY\nNEXT MINISTAGE WILL ACTIVATE SOON\nGOOD LUCK", 0.00, null);
	}
	if(m == 7)
	{
		EntFire("map_hint_msg4", "SetText", "HARRY POTTER WIZARD MODE\nGOOD JOB EVERYONE\nALL OBJECTS ARE COLLECTED WITHIN TIME ALLOTTED\nFOLLOW THE NEXT INSTRUCTIONS FROM THE CONSOLE", 0.00, null);
	}
	if(m == 8)
	{
		EntFire("map_hint_msg3", "SetText", "HARRY POTTER WIZARD MODE\n!!! THE COLLECTOR DIED !!!\nRESTARTING MODE\nDEFEND THE COLLECTOR BETTER NEXT TIME", 0.00, null);
	}
	if(m == 9)
	{
		EntFire("map_hint_msg3", "SetText", "HARRY POTTER WIZARD MODE\n!!! TIME LIMIT EXPIRED !!!\nRESTARTING MODE\nNOT ALL OBJECTS WERE COLLECTED WITHIN TIME ALLOTED", 0.00, null);
	}
	if(m == 10)
	{
		EntFire("map_hint_mini", "SetText", "THE MINISPIDER IS DEAD\nKILL ARAGOG", 0.00, null);
	}
	if(m == 11)
	{
		EntFire("map_hints_text_all", "SetText", "WATCH OUT FOR MASSIVE FIRE\nRUN INSIDE ONE OF THOOSE FOUR PLATFORMS", 0.00, null);
	}
	if(m == 12)
	{
		EntFire("map_hint_mini", "SetText", "5 OR MORE HUMANS DETECTED\nMINISPIDERS ACTIVATED", 0.00, null);
	}
	if(m == 13)
	{
		EntFire("map_hint_mini", "SetText", "SHOOT AND KILL THE MINISPIDER\nARAGOG CANNOT DIE AS LONG AS THE MINI SPIDER IS ALIVE", 0.00, null);
	}
	if(m == 14)
	{
		EntFire("map_hints_text_single", "SetText", "YOU TOOK HARRY\nAVOID ATTACKS FROM VOLDEMORT IN TIME\nYOU WILL SEE A KEYCODE ON YOUR SCREEN TO AVOID AN ATTACK\nPRESS THE KEYCODE AS FAST AS YOU CAN\nPRESS E ON THE WAND TO ACTIVATE THE BATTLE\nKEEP SPAMMING E ON THE WAND", 0.00, null);
	}
	if(m == 15)
	{
		EntFire("map_hint_deaths", "SetText", "KILL ALL DEATHEATERS\nONLY HARRY CAN STILL HURT VOLDEMORT", 0.00, null);
	}
	if(m == 16)
	{
		EntFire("map_hints_text_all", "SetText", "WELCOME TO THE HARRY POTTER WIZARD MODE\nCOLLECT ALL ITEMS TO COMPLETE THIS MODE\nEVERY ITEM IS PROTECTED BY A DRAGON\nPRESS E ON THE ITEM TO COLLECT IT\nIF THE COLLECTOR DIES THE ENTIRE TEAM DIES\nGOOD LUCK", 0.00, null);
	}
	if(m == 17)
	{
		EntFire("map_hints_text_all", "SetText", "HARRY POTTER WIZARD MODE\n!!! TIME LIMIT EXPIRED !!!\nRESTARTING MODE\nNOT ALL OBJECTS WERE COLLECTED WITHIN TIME ALLOTED", 0.00, null);
	}
	if(m == 18)
	{
		EntFire("map_hint_msg3", "SetText", "HARRY POTTER WIZARD MODE\n!!! TIME LIMIT EXPIRED !!!\nRESTARTING MODE\nNOBODY ACTIVATED THE WIZARD MODE WITHIN TIME ALLOTED", 0.00, null);
	}
	if(m == 19)
	{
		EntFire("map_hints_text_all", "SetText", "ZOMBIE MODE\nHIDE AND SURVIVE\nYOU NEED TO ESCAPE AFTER THE TIME RUNS OUT", 0.00, null);
	}
	if(m == 20)
	{
		EntFire("stage1_boss_hints", "SetText", "SHOOT AND BREAK THE WALL\nNADES HAVE NO EFFECT", 0.00, null);
	}
}

// function UpDateServerTime()
// {
	// SERVERTIME = Time();
// }

function LoopFndPlSt()
{
	EntFireByHandle(self,"RunScriptCode","TeleportStuckPl();",0.00,null,null);
	EntFireByHandle(self,"RunScriptCode","LoopFndPlSt();",5.00,null,null);
}

function TeleportStuckPl()
{
	local FplHu = null;
	local geto = GtoHum();
	while(null != (FplHu = Entities.FindInSphere(FplHu, Vector(13298, -862, 825), 2200)))
	{
		if(FplHu.GetTeam() == 3 && FplHu.GetHealth() > 0 && FplHu.GetName() == "player_s" || 
		FplHu.GetTeam() == 3 && FplHu.GetHealth() > 0 && FplHu.GetName() == "harrypotter")
		{
			EntFireByHandle(FplHu,"AddOutput","origin "+geto.x+" "+geto.y+" "+geto.z,0.10,null,null);
			return;
		}
	}
}

function GtoHum()
{
	local originpl = null;
	local rndp = null;
	local Rn = 0;
	local num = RandomInt(1, ReturnPlayersCt());
	while(null != (rndp = Entities.FindByClassname(rndp, "player")))
	{
		if(rndp.GetTeam() == 3 && rndp.GetHealth() > 0 && rndp.GetClassname() == "player")
		{
			Rn++;
			if(Rn >= num)
			{
                originpl = rndp.GetOrigin();
		        return originpl;
			}
		}
	}
}

function ReturnPlayersCt()
{
    local hupl = null;
	local hulc = 0;
	while(null != (hupl = Entities.FindByClassname(hupl, "player")))
	{
		if(hupl.GetName() == "player_s" && hupl.GetTeam() == 3 && hupl.GetHealth() > 0 && hupl.IsValid())
		{
			hulc++;
		}
	}
	return hulc;
}

function ReturnPlayersT()
{
    local zmpl = null;
	local zmlc = 0;
	while(null != (zmpl = Entities.FindByClassname(zmpl, "player")))
	{
		if(zmpl.GetName() == "player_s" && zmpl.GetTeam() == 2 && zmpl.GetHealth() > 0 && zmpl.IsValid())
		{
			zmlc++;
		}
	}
	return zmlc;
}


function AddItemLevelAllAliveHum()
{
	local apl = null;
	while(null != (apl = Entities.FindByClassname(apl, "player")))
	{
		if(apl.GetTeam() == 3 && apl.GetHealth() > 0 && apl.GetName() == "player_s" || 
		apl.GetTeam() == 3 && apl.GetHealth() > 0 && apl.GetName() == "harrypotter")
		{
            EntFire("!activator", "RunScriptCode", "AddLevel();", 0.00, apl);
		}
	}
}

function AddItemLevelAllAlivePlayer()
{
	local alapl = null;
	while(null != (alapl = Entities.FindByClassname(alapl, "player")))
	{
		if(alapl.GetHealth() > 0 && alapl.GetName() == "player_s" || 
		alapl.GetHealth() > 0 && alapl.GetName() == "harrypotter")
		{
            EntFire("!activator", "RunScriptCode", "AddLevel();", 0.00, alapl);
		}
	}
}

function ResetWandLevel()
{
	local rswl = null;
	while(null != (rswl = Entities.FindByClassname(rswl, "player")))
	{
		if(rswl.GetHealth() > 0 && rswl.GetName() == "player_s" ||
		rswl.GetHealth() > 0 && rswl.GetName() == "harrypotter")
		{
            EntFire("!activator", "RunScriptCode", "ITEMLEVEL=0", 0.00, rswl);
		}
	}
}

function SetItemLevel(ilvl)
{
	local apl = null;
	while(null != (apl = Entities.FindByClassname(apl, "player")))
	{
		if(apl.GetTeam() == 3 && apl.GetHealth() > 0 && apl.GetName() == "player_s" ||
		apl.GetTeam() == 3 && apl.GetHealth() > 0 && apl.GetName() == "harrypotter")
		{
            EntFire("!activator", "RunScriptCode", "AddLevel("+ilvl+");", 0.00, apl);
		}
	}
}

function KillAll()
{
	local p = null;
	while(null != (p = Entities.FindByClassname(p,"player")))
	{
		if(p != null && p.IsValid() && p.GetHealth() > 0)
		{
			EntFireByHandle(p, "SetDamageFilter", "", 0.00, null, null);
			EntFireByHandle(p, "SetHealth", "-1", 0.05, null, null);
		}	
	}
}

function SetZombiePlModel()
{
	if(activator.GetTeam() == 2 && activator.GetHealth() > 500)
	{
        activator.SetModel("models/player/zombie_harry.mdl");
	}
}

Time <- 0.00;
SaveTime <- 0.00;
TimerTick <- true;
TimerText <- "";

function TimerMap(timer, text)
{
   TimerTick = true;
   Time = timer;
   SaveTime = timer;
   AddText(text);
   StartTextHud();
}

function StopTimer(){TimerTick = false;}

function ResetTimer(){Time = SaveTime;}

function AddTime(t){Time += t;}

function AddText(text)
{
	if(text == 1){TimerText = "SURVIVE FOR: ";}
	if(text == 2){TimerText = "TIME REMAINING: ";}
	if(text == 3){TimerText = "WARMUP ROUND: "}
}

function StartTimer(){TimerTick = true;StartTextHud();}

function StartTextHud()
{
    if(TimerTick)
    {
        local min1 = (((Time/60) % 60) % 10);
        local min2 = (((Time/60) % 60) / 10);
        local sec1 = ((Time % 60) % 10);
        local sec2 = ((Time % 60) / 10);
        for(local au = 1; au < 2; au++)
        {
            if(au == 1)
            {
                ScriptPrintMessageCenterAll(""+TimerText+""+min2+""+min1+":"+""+""+sec2+""+sec1+"");
                Time--;
            }
            if(Time == -1)
            {
                Time = SaveTime;
                return;
            }
        }
        EntFireByHandle(self,"RunScriptCode","StartTextHud();",1.00,null,null);
    }
}

//////////////////////////////////////////////////////////////
//////////////////ADMIN ROOM////////////////////
//////////////////////////////////////////////////////////////
                                                //////////////
//////////////////////////////////////////////////////////////
/////////////////////MAIN///////////////////////
//////////////////////////////////////////////////////////////
MAPSTAGE <- false;                              //////////////
ITEMCONTROL <- false;                           //////////////
MAPCONTROL <- false;                            //////////////
                                                //////////////
//////////////////////////////////////////////////////////////
////////////////////CHOOSER/////////////////////
//////////////////////////////////////////////////////////////
PRESSCOUNT <- 0;                                //////////////
                                                //////////////
//////////////////////////////////////////////////////////////
/////////////////////STAGE//////////////////////
//////////////////////////////////////////////////////////////
const EXTREMESTAGE = 6;                         //////////////
DIFSTAGE <- 0;                                  //////////////
SELECTSTAGE <- false;                           //////////////
CHOOSEDIF <- false;                             //////////////
                                                //////////////
//////////////////////////////////////////////////////////////
/////////////////////ITEM///////////////////////
//////////////////////////////////////////////////////////////
CHOOSEITEMCONT <- false;                        //////////////
ITEMMENUSELECT <- 0;                            //////////////
                                                //////////////
//////////////////////////////////////////////////////////////
//////////////////////MAP///////////////////////
//////////////////////////////////////////////////////////////
CHOOSEMAPCONT <- false;                        ///////////////     
CHOOSEMAPBF <- false;                          ///////////////
MAPMENUSELECT <- 0;                            ///////////////
                                               ///////////////
//////////////////////////////////////////////////////////////
///////////////////////////////////////////////
//////////////////////////////////////////////////////////////

function PrintVariable()
{
    EntFire("text", "SetText", "MAPSTAGE: "+MAPSTAGE+
    "\nITEMCONTROL: "+ITEMCONTROL+
    "\nMAPCONTROL: "+MAPCONTROL+
    "\nPRESSCOUNT: "+PRESSCOUNT+
    "\nEXTEMESTAGE: "+EXTREMESTAGE+
    "\nDIFSTAGE: "+DIFSTAGE+
    "\nSELECTSTAGE: "+SELECTSTAGE+
    "\nCHOOSEITEMCONT: "+CHOOSEITEMCONT+
    "\nITEMMENUSELECT: "+ITEMMENUSELECT+
    "\nCHOOSEMAPCONT: "+CHOOSEMAPCONT+
    "\nMAPMENUSELECT: "+MAPMENUSELECT, 0.00, null);
    EntFire("text", "Display", "", 0.05, null);
    EntFireByHandle(self, "RunScriptCode", "PrintVariable();", 0.10, null, null);
}


function FindAct()
{
    if(!MAPSTAGE && !SELECTSTAGE && !CHOOSEITEMCONT && !CHOOSEMAPCONT)
    {
        if(DIFSTAGE == 0)
        {
            ScriptPrintMessageCenterAll("SET MAP STAGE");
            EntFire("CHOOSE_TEXT", "AddOutput", "message SET MAP STAGE", 0.00, null);
            MAPSTAGE = true;
            ITEMCONTROL = true;
            CHOOSEDIF = true;
        }
        else if(DIFSTAGE >= 1)
        {
            DIFSTAGE++;
            if(DIFSTAGE == 2)
            { 
                ScriptPrintMessageCenterAll("SELECT NORMAL MOD");
                EntFire("CHOOSE_TEXT", "AddOutput", "message SELECT NORMAL MOD", 0.00, null);
            }
            else if(DIFSTAGE == 3)
            {
                ScriptPrintMessageCenterAll("SELECT EXTREME MOD");
                EntFire("CHOOSE_TEXT", "AddOutput", "message SELECT EXTREME MOD", 0.00, null);
            }
            else if(DIFSTAGE > 3)
            {
                DIFSTAGE = 2;
                ScriptPrintMessageCenterAll("SELECT NORMAL MOD");
                EntFire("CHOOSE_TEXT", "AddOutput", "message SELECT NORMAL MOD", 0.00, null);
            }
        }
    }
    else if(ITEMCONTROL && DIFSTAGE == 0)
    {
        ScriptPrintMessageCenterAll("ITEM CONTROL");
        EntFire("CHOOSE_TEXT", "AddOutput", "message ITEM CONTROL", 0.00, null);
        ITEMCONTROL = false;
        MAPCONTROL = true;
    }
    else if(!ITEMCONTROL && MAPCONTROL && CHOOSEITEMCONT)
    {
        if(ITEMMENUSELECT == 0)
        {
            ScriptPrintMessageCenterAll("CLOSE/OPEN WANDSHOP"); 
            EntFire("CHOOSE_TEXT", "AddOutput", "message CLOSE/OPEN\nWANDSHOP", 0.00, null);
        }
        else if(ITEMMENUSELECT == 1)
        {
            ScriptPrintMessageCenterAll("PERSONAL UPGRADE LEVEL WAND +1");
            EntFire("CHOOSE_TEXT", "AddOutput", "message PERSONAL UPGRADE\nLEVEL WAND +1", 0.00, null);
        }
        else if(ITEMMENUSELECT == 2)
        {
            ScriptPrintMessageCenterAll("UPGRADE LEVEL WAND +1");
            EntFire("CHOOSE_TEXT", "AddOutput", "message UPGRADE\nLEVEL WAND +1", 0.00, null);
        }
        else if(ITEMMENUSELECT == 3)
        {
            ScriptPrintMessageCenterAll("MAX LEVEL WAND");
            EntFire("CHOOSE_TEXT", "AddOutput", "message MAX LEVEL WAND", 0.00, null);
        }
        else if(ITEMMENUSELECT == 4)
        {
            ScriptPrintMessageCenterAll("ZOMBIES WAND UPGRADE LEVEL");
            EntFire("CHOOSE_TEXT", "AddOutput", "message ZOMBIES WAND\nUPGRADE LEVEL", 0.00, null);
        }
        else if(ITEMMENUSELECT == 5)
        {
            ScriptPrintMessageCenterAll("RESET WAND");
            EntFire("CHOOSE_TEXT", "AddOutput", "message RESET WAND", 0.00, null);
        }
        ITEMMENUSELECT++;
        if(ITEMMENUSELECT == 7)
        {
            ITEMMENUSELECT = 0;
            FindAct();
        }
        if(ITEMMENUSELECT >= 10)
        {
            if(PRESSCOUNT == 0)
            {
                ScriptPrintMessageCenterAll("CLOSE/OPEN ZOMBIES WANDSHOP"); 
                EntFire("CHOOSE_TEXT", "AddOutput", "message CLOSE/OPEN\nZOMBIES WANDSHOP", 0.00, null);
            }
            else if(PRESSCOUNT == 1)
            {
                ScriptPrintMessageCenterAll("CLOSE/OPEN HUMANS WANDSHOP");
                EntFire("CHOOSE_TEXT", "AddOutput", "message CLOSE/OPEN\nHUMANS WANDSHOP", 0.00, null);
            }
            else if(PRESSCOUNT == 2)
            {
                ScriptPrintMessageCenterAll("CLOSE/OPEN WANDSHOP");
                EntFire("CHOOSE_TEXT", "AddOutput", "message CLOSE/OPEN\nWANDSHOP", 0.00, null);
            }
            PRESSCOUNT++;
            if(PRESSCOUNT >= 4)
            {
                PRESSCOUNT = 0;
                FindAct();
            }
        }
    }
    else if(MAPCONTROL && DIFSTAGE == 0 && !CHOOSEITEMCONT)
    {
        ScriptPrintMessageCenterAll("MAP CONTROL");
        EntFire("CHOOSE_TEXT", "AddOutput", "message MAP CONTROL", 0.00, null);
        MAPCONTROL = false;
        MAPSTAGE = false;
        CHOOSEMAPBF = true;
        CHOOSEDIF = false;
    }
    if(SELECTSTAGE && DIFSTAGE == 2)
    {
        PRESSCOUNT++;
        if(PRESSCOUNT >= 7)
        {
            PRESSCOUNT = 1;
        }
        ScriptPrintMessageCenterAll("NEXT STAGE "+PRESSCOUNT);
        EntFire("CHOOSE_TEXT", "AddOutput", "message NEXT STAGE "+PRESSCOUNT, 0.00, null);
    }
    else if(SELECTSTAGE && DIFSTAGE == 3)
    {
        PRESSCOUNT++;
        if((PRESSCOUNT + EXTREMESTAGE) == 14)
        {
            ScriptPrintMessageCenterAll("TOGGLE ONLY ZM STAGE");
            EntFire("CHOOSE_TEXT", "AddOutput", "message TOGGLE\nONLY ZM STAGE", 0.00, null);
        }
        else if((PRESSCOUNT + EXTREMESTAGE) >= 15)
        {
            PRESSCOUNT = 1;
            ScriptPrintMessageCenterAll("NEXT STAGE "+(EXTREMESTAGE+=PRESSCOUNT));
            EntFire("CHOOSE_TEXT", "AddOutput", "message NEXT STAGE "+(EXTREMESTAGE+=PRESSCOUNT), 0.00, null);
        }
        else if((PRESSCOUNT + EXTREMESTAGE) <= 13)
        {
            ScriptPrintMessageCenterAll("NEXT STAGE "+(EXTREMESTAGE+=PRESSCOUNT));
            EntFire("CHOOSE_TEXT", "AddOutput", "message NEXT STAGE "+(EXTREMESTAGE+=PRESSCOUNT), 0.00, null);
        }
    }
    else if(!MAPCONTROL && !MAPSTAGE && CHOOSEMAPCONT)
    {
        if(MAPMENUSELECT == 0)
        {
            ScriptPrintMessageCenterAll("CHOOSE GLOBAL MAP RESET");
            EntFire("CHOOSE_TEXT", "AddOutput", "message CHOOSE\nGLOBAL MAP RESET", 0.00, null);
        }
        else if(MAPMENUSELECT == 1)
        {
            ScriptPrintMessageCenterAll("CHOOSE EXTEND MAP +20min");
            EntFire("CHOOSE_TEXT", "AddOutput", "message CHOOSE\nEXTEND MAP +20min", 0.00, null);
        }
        else if(MAPMENUSELECT == 2)
        {
            ScriptPrintMessageCenterAll("CHOOSE TOGGLE BARREL DAMAGE");
            EntFire("CHOOSE_TEXT", "AddOutput", "message CHOOSE\nTOGGLE BARREL DAMAGE", 0.00, null);
        }
        else if(MAPMENUSELECT == 3)
        {
            ScriptPrintMessageCenterAll("CHOOSE TOGGLE FLYING CARS");
            EntFire("CHOOSE_TEXT", "AddOutput", "message CHOOSE\nTOGGLE FLYING CARS", 0.00, null);
        }
        else if(MAPMENUSELECT == 4)
        {
            ScriptPrintMessageCenterAll("CHOOSE TOGGLE WEATHER");
            EntFire("CHOOSE_TEXT", "AddOutput", "message CHOOSE\nTOGGLE WEATHER", 0.00, null);
        }
        else if(MAPMENUSELECT == 5)
        {
            ScriptPrintMessageCenterAll("CHOOSE LAUNCH NUKE");
            EntFire("CHOOSE_TEXT", "AddOutput", "message CHOOSE\nLAUNCH NUKE", 0.00, null);
        }
		else if(MAPMENUSELECT == 6)
		{
			ScriptPrintMessageCenterAll("CHOOSE TOOGLE AUTO BHOP");
            EntFire("CHOOSE_TEXT", "AddOutput", "message CHOOSE\nTOOGLE AUTO BHOP", 0.00, null);
		}
        MAPMENUSELECT++;
        if(MAPMENUSELECT >= 8)
        {
            MAPMENUSELECT = 0;
            FindAct();
        }
    }
}

function SelectAct()
{
    if(MAPSTAGE && ITEMCONTROL)
    {
        if(DIFSTAGE == 0)
        {
            ScriptPrintMessageCenterAll("CHOOSE DIFFICULTY");
            EntFire("SELECT_TEXT", "AddOutput", "message CHOOSE\nDIFFICULTY", 0.00, null);
            DIFSTAGE = 1;
        }
        MAPSTAGE = false;
    }
    else if(!MAPSTAGE && ITEMCONTROL && !SELECTSTAGE)
    {
        if(DIFSTAGE > 1)
        {
            ScriptPrintMessageCenterAll("CHOOSE STAGE");
            EntFire("SELECT_TEXT", "AddOutput", "message CHOOSE\nSTAGE", 0.00, null);
            SELECTSTAGE = true;
        }
    }
    else if(!MAPSTAGE && SELECTSTAGE && DIFSTAGE == 2)
    {
        ScriptPrintMessageCenterAll("MAP STAGE SET TO "+PRESSCOUNT);
		EntFireByHandle(self,"RunScriptCode","STAGE="+PRESSCOUNT,0.00,null,null);
        EntFire("SELECT_TEXT", "AddOutput", "message MAP STAGE SET TO "+PRESSCOUNT, 0.00, null);
    }
    else if(!MAPSTAGE && SELECTSTAGE && DIFSTAGE == 3)
    {
        if((PRESSCOUNT + EXTREMESTAGE) == 14)
        {
            ScriptPrintMessageCenterAll("NEXT STAGE ZM MOD");
			EntFireByHandle(self,"RunScriptCode","ToggleZmMod();",0.00,null,null);
            EntFire("SELECT_TEXT", "AddOutput", "message NEXT STAGE ZM MOD", 0.00, null);
        }
        else if((PRESSCOUNT + EXTREMESTAGE) <= 13)
        {    
            ScriptPrintMessageCenterAll("MAP STAGE SET TO "+(EXTREMESTAGE+=PRESSCOUNT));
			EntFireByHandle(self,"RunScriptCode","STAGE="+(EXTREMESTAGE+=PRESSCOUNT),0.00,null,null);
            EntFire("SELECT_TEXT", "AddOutput", "message MAP STAGE SET TO "+(EXTREMESTAGE+=PRESSCOUNT), 0.00, null);
        } 
    }
    if(!ITEMCONTROL && MAPCONTROL && !CHOOSEITEMCONT)
    {
        CHOOSEITEMCONT = true;
        ScriptPrintMessageCenterAll("CHOOSE ITEM SETTING");
        EntFire("SELECT_TEXT", "AddOutput", "message CHOOSE\nITEM SETTING", 0.00, null);
    }
    else if(!ITEMCONTROL && MAPCONTROL && CHOOSEITEMCONT)
    {
        if(ITEMMENUSELECT == 1 && ITEMMENUSELECT < 10)
        {
            ScriptPrintMessageCenterAll("CHOOSE CLOSE/OPEN WANDSHOP");
            EntFire("SELECT_TEXT", "AddOutput", "message CHOOSE\nCLOSE/OPEN\nWANDSHOP", 0.00, null);
            ITEMMENUSELECT = 10;
        }
        if(ITEMMENUSELECT >= 10)
        {
            if(PRESSCOUNT == 1)
            {
                ScriptPrintMessageCenterAll("SELECT CLOSE/OPEN ZOMBIES WANDSHOP"); 
				BlockZmShop();
                EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nCLOSE/OPEN\nZOMBIES WANDSHOP", 0.00, null);
            }
            else if(PRESSCOUNT == 2)
            {
                ScriptPrintMessageCenterAll("SELECT CLOSE/OPEN HUMANS WANDSHOP");
				BlockHuShop();
                EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nCLOSE/OPEN\nHUMANS WANDSHOP", 0.00, null);
            }
            else if(PRESSCOUNT == 3)
            {
                ScriptPrintMessageCenterAll("SELECT CLOSE/OPEN WANDSHOP");
				BlockShop();
                EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nCLOSE/OPEN\nWANDSHOP", 0.00, null);
            }
        }
        else if(ITEMMENUSELECT == 2 && ITEMMENUSELECT < 10)
        {
            ScriptPrintMessageCenterAll("SELECT PERSONAL LEVEL ITEM UPGRADE +1");
			EntFireByHandle(activator,"RunScriptCode","AddLevel();",0.00,null,null);
            EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nPERSONAL LEVEL ITEM\nUPGRADE +1", 0.00, null);
        }
        else if(ITEMMENUSELECT == 3 && ITEMMENUSELECT < 10)
        {
            ScriptPrintMessageCenterAll("SELECT PLAYERS LEVEL ITEM UPGRADE +1");
			AddItemLevelAllAlivePlayer();
            EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nPLAYERS LEVEL ITEM\nUPGRADE +1", 0.00, null);
        }
        else if(ITEMMENUSELECT == 4 && ITEMMENUSELECT < 10)
        {
            ScriptPrintMessageCenterAll("SELECT PLAYERS MAX LEVEL WANDS");
			EntFireByHandle(self,"RunScriptCode","AddItemLevelAllAlivePlayer();",0.00,null,null);
			EntFireByHandle(self,"RunScriptCode","AddItemLevelAllAlivePlayer();",0.05,null,null);
			EntFireByHandle(self,"RunScriptCode","AddItemLevelAllAlivePlayer();",0.10,null,null);
			EntFireByHandle(self,"RunScriptCode","AddItemLevelAllAlivePlayer();",0.20,null,null);
            EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nPLAYERS MAX LEVEL\nWANDS", 0.00, null);
        }
        else if(ITEMMENUSELECT == 5 && ITEMMENUSELECT < 10)
        {
            ScriptPrintMessageCenterAll("SELECT ZOMBIES WAND UPGRADE LEVEL");
			ZMITEMMAXLVL = true;
            EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nZOMBIES WAND\nUPGRADE LEVEL", 0.00, null);
        }
        else if(ITEMMENUSELECT == 6 && ITEMMENUSELECT < 10)
        {
            ScriptPrintMessageCenterAll("SELECT RESET WAND");
			ZMITEMMAXLVL = false;
			ResetWandLevel();
            EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nRESET WAND", 0.00, null);
        }
    }
    if(!MAPCONTROL && !MAPSTAGE && !CHOOSEMAPCONT && CHOOSEMAPBF && !CHOOSEDIF)
    {
        CHOOSEMAPCONT = true;
        ScriptPrintMessageCenterAll("CHOOSE MAP SETTING");
        EntFire("SELECT_TEXT", "AddOutput", "message CHOOSE\nMAP SETTING", 0.00, null);
    }
    else if(!MAPCONTROL && !MAPSTAGE && CHOOSEMAPCONT)
    {
        if(MAPMENUSELECT == 1)
        {
            ScriptPrintMessageCenterAll("SELECT GLOBAL MAP RESET");
			ResetWandLevel();
			ZMITEMMAXLVL = false;
			STAGE = 0;
			BLOCKZMWANDSHOP = false;
            BLOCKHUWANDSHOP = false;
            BLOCKWANDSHOP = false;
			EXTREME = false;
            ONLYZMMOD = false;
			AUTOBHOP = false;
            EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nGLOBAL MAP RESET", 0.00, null);
        }
        else if(MAPMENUSELECT == 2)
        {
            ScriptPrintMessageCenterAll("SELECT EXTEND MAP +20min");
			EntFire("map_fixthis", "RunScriptCode", "ExtendMap();", 0.00, null);
			// local UpDateTime = Time();
			// local st = SERVERTIME.tointeger();
            // local temptime = UpDateTime - st;
			// EntFire("console", "Command", "mp_timelimit "+(temptime+20), 0.00, null);
            EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nEXTEND MAP +20min", 0.00, null);
        }
        else if(MAPMENUSELECT == 3)
        {
            ScriptPrintMessageCenterAll("SELECT TOGGLE BARREL DAMAGE");
			EntFire("map_adroom_comp_barreldmg", "Compare", "", 0.00, null);
            EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nTOGGLE\nBARREL DAMAGE", 0.00, null);
        }
        else if(MAPMENUSELECT == 4)
        {
            ScriptPrintMessageCenterAll("SELECT TOGGLE FLYING CARS");
			EntFire("map_adroom_comp_flycars", "Compare", "", 0.00, null);
            EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nTOGGLE\nFLYING CARS", 0.00, null);
        }
        else if(MAPMENUSELECT == 5)
        {
            ScriptPrintMessageCenterAll("SELECT TOGGLE WEATHER");
			EntFire("map_adroom_comp_weather", "Compare", "", 0.00, null);
            EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nTOGGLE\nWEATHER", 0.00, null);
        }
        else if(MAPMENUSELECT == 6)
        {
            ScriptPrintMessageCenterAll("SELECT LAUNCH NUKE");
			KillAll();
            EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nLAUNCH NUKE", 0.00, null);
        }
		else if(MAPMENUSELECT == 7)
        {
            ScriptPrintMessageCenterAll("SELECT TOOGLE AUTO BHOP");
			ToogleAutoBhop();
            EntFire("SELECT_TEXT", "AddOutput", "message SELECT\nTOOGLE AUTO BHOP", 0.00, null);
        }
    }
}

function ResetAct()
{
    MAPSTAGE = false;
    ITEMCONTROL = false;
    MAPCONTROL = false;
    PRESSCOUNT = 0;
    DIFSTAGE = 0;
    SELECTSTAGE = false;
    CHOOSEITEMCONT = false;
    ITEMMENUSELECT = 0;
    CHOOSEMAPCONT = false;                        
    MAPMENUSELECT = 0;
    CHOOSEMAPBF = false;
}

function ToggleZmMod()
{
	if(!ONLYZMMOD){ONLYZMMOD = true;}
	else if(ONLYZMMOD){ONLYZMMOD = false;}
}

function BlockZmShop()
{
	if(!BLOCKZMWANDSHOP){BLOCKZMWANDSHOP = true;}
	else if(BLOCKZMWANDSHOP){BLOCKZMWANDSHOP = false;}
}

function BlockHuShop()
{
	if(!BLOCKHUWANDSHOP){BLOCKHUWANDSHOP = true;}
	else if(BLOCKHUWANDSHOP){BLOCKHUWANDSHOP = false;}
}

function BlockShop()
{
	if(!BLOCKWANDSHOP){BLOCKWANDSHOP = true;}
	else if(BLOCKWANDSHOP){BLOCKWANDSHOP = false;}
}

function ToogleAutoBhop()
{
    if(!AUTOBHOP){AUTOBHOP = true;}
	else if(AUTOBHOP){AUTOBHOP = false;}
}

// function PrintTestTimeOnS()
// {
    // local fsafsafa = Time();
    // local addtime = c+20;
    // SendToConsoleServer("mp_timelimit "+addtime);
    // ScriptPrintMessageCenterAll("SERVER TIME: "+fsafsafa+"\nNEXT TIME: ");
// }

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////