//=========== (C) Copyright 1999 Valve, L.L.C. All rights reserved. ===========
//
// The copyright to the contents herein is the property of Valve, L.L.C.
// The contents may be used and/or copied only with the written permission of
// Valve, L.L.C., or in accordance with the terms and conditions stipulated in
// the agreement/contract under which the contents have been supplied.
//=============================================================================
EVENT_PLAYER_DEATH<-0;
EVENT_OTHER_DEATH<-1;
EVENT_PLAYER_HURT<-2;
EVENT_ITEM_PURCHASE<-3;
EVENT_BOMB_BEGINPLANT<-4;
EVENT_BOMB_ABORTPLANT<-5;
EVENT_BOMB_PLANTED<-6;
EVENT_BOMB_DEFUSED<-7;
EVENT_BOMB_EXPLODED<-8;
EVENT_BOMB_DROPPED<-9;
EVENT_BOMB_PICKUP<-10;
EVENT_DEFUSER_DROPPED<-11;
EVENT_DEFUSER_PICKUP<-12;
EVENT_ANNOUNCE_PHASE_END<-13;
EVENT_CS_INTERMISSION<-14;
EVENT_BOMB_BEGINDEFUSE<-15;
EVENT_BOMB_ABORTDEFUSE<-16;
EVENT_HOSTAGE_FOLLOWS<-17;
EVENT_HOSTAGE_HURT<-18;
EVENT_HOSTAGE_KILLED<-19;
EVENT_HOSTAGE_RESCUED<-20;
EVENT_HOSTAGE_STOPS_FOLLOWING<-21;
EVENT_HOSTAGE_RESCUED_ALL<-22;
EVENT_HOSTAGE_CALL_FOR_HELP<-23;
EVENT_VIP_ESCAPED<-24;
EVENT_VIP_KILLED<-25;
EVENT_PLAYER_RADIO<-26;
EVENT_BOMB_BEEP<-27;
EVENT_WEAPON_FIRE<-28;
EVENT_WEAPON_FIRE_ON_EMPTY<-29;
EVENT_WEAPON_OUTOFAMMO<-30;
EVENT_WEAPON_RELOAD<-31;
EVENT_WEAPON_ZOOM<-32;
EVENT_SILENCER_DETACH<-33;
EVENT_INSPECT_WEAPON<-34;
EVENT_WEAPON_ZOOM_RIFLE<-35;
EVENT_PLAYER_SPAWNED<-36;
EVENT_ITEM_PICKUP<-37;
EVENT_AMMO_PICKUP<-38;
EVENT_ITEM_EQUIP<-39;
EVENT_ENTER_BUYZONE<-40;
EVENT_EXIT_BUYZONE<-41;
EVENT_BUYTIME_ENDED<-42;
EVENT_ENTER_BOMBZONE<-43;
EVENT_EXIT_BOMBZONE<-44;
EVENT_ENTER_RESCUE_ZONE<-45;
EVENT_EXIT_RESCUE_ZONE<-46;
EVENT_SILENCER_OFF<-47;
EVENT_SILENCER_ON<-48;
EVENT_BUYMENU_OPEN<-49;
EVENT_BUYMENU_CLOSE<-50;
EVENT_ROUND_PRESTART<-51;
EVENT_ROUND_POSTSTART<-52;
EVENT_ROUND_START<-53;
EVENT_ROUND_END<-54;
EVENT_GRENADE_BOUNCE<-55;
EVENT_HEGRENADE_DETONATE<-56;
EVENT_FLASHBANG_DETONATE<-57;
EVENT_SMOKEGRENADE_DETONATE<-58;
EVENT_SMOKEGRENADE_EXPIRED<-59;
EVENT_MOLOTOV_DETONATE<-60;
EVENT_DECOY_DETONATE<-61;
EVENT_DECOY_STARTED<-62;
EVENT_TAGRENADE_DETONATE<-63;
EVENT_INFERNO_STARTBURN<-64;
EVENT_INFERNO_EXPIRE<-65;
EVENT_INFERNO_EXTINGUISH<-66;
EVENT_DECOY_FIRING<-67;
EVENT_BULLET_IMPACT<-68;
EVENT_PLAYER_FOOTSTEP<-69;
EVENT_PLAYER_JUMP<-70;
EVENT_PLAYER_BLIND<-71;
EVENT_PLAYER_FALLDAMAGE<-72;
EVENT_DOOR_MOVING<-73;
EVENT_ROUND_FREEZE_END<-74;
EVENT_MB_INPUT_LOCK_SUCCESS<-75;
EVENT_MB_INPUT_LOCK_CANCEL<-76;
EVENT_NAV_BLOCKED<-77;
EVENT_NAV_GENERATE<-78;
EVENT_PLAYER_STATS_UPDATED<-79;
EVENT_ACHIEVEMENT_INFO_LOADED<-80;
EVENT_SPEC_TARGET_UPDATED<-81;
EVENT_SPEC_MODE_UPDATED<-82;
EVENT_HLTV_CHANGED_MODE<-83;
EVENT_CS_GAME_DISCONNECTED<-84;
EVENT_CS_WIN_PANEL_ROUND<-85;
EVENT_CS_WIN_PANEL_MATCH<-86;
EVENT_CS_MATCH_END_RESTART<-87;
EVENT_CS_PRE_RESTART<-88;
EVENT_SHOW_FREEZEPANEL<-89;
EVENT_HIDE_FREEZEPANEL<-90;
EVENT_FREEZECAM_STARTED<-91;
EVENT_PLAYER_AVENGED_TEAMMATE<-92;
EVENT_ACHIEVEMENT_EARNED<-93;
EVENT_ACHIEVEMENT_EARNED_LOCAL<-94;
EVENT_ITEM_FOUND<-95;
EVENT_ITEMS_GIFTED<-96;
EVENT_REPOST_XBOX_ACHIEVEMENTS<-97;
EVENT_MATCH_END_CONDITIONS<-98;
EVENT_ROUND_MVP<-99;
EVENT_PLAYER_DECAL<-100;
EVENT_TEAMPLAY_ROUND_START<-101;
EVENT_CLIENT_DISCONNECT<-102;
EVENT_GG_PLAYER_LEVELUP<-103;
EVENT_GGTR_PLAYER_LEVELUP<-104;
EVENT_ASSASSINATION_TARGET_KILLED<-105;
EVENT_GGPROGRESSIVE_PLAYER_LEVELUP<-106;
EVENT_GG_KILLED_ENEMY<-107;
EVENT_GG_FINAL_WEAPON_ACHIEVED<-108;
EVENT_GG_BONUS_GRENADE_ACHIEVED<-109;
EVENT_SWITCH_TEAM<-110;
EVENT_GG_LEADER<-111;
EVENT_GG_TEAM_LEADER<-112;
EVENT_GG_PLAYER_IMPENDING_UPGRADE<-113;
EVENT_WRITE_PROFILE_DATA<-114;
EVENT_TRIAL_TIME_EXPIRED<-115;
EVENT_UPDATE_MATCHMAKING_STATS<-116;
EVENT_PLAYER_RESET_VOTE<-117;
EVENT_ENABLE_RESTART_VOTING<-118;
EVENT_SFUIEVENT<-119;
EVENT_START_VOTE<-120;
EVENT_PLAYER_GIVEN_C4<-121;
EVENT_GG_RESET_ROUND_START_SOUNDS<-122;
EVENT_TR_PLAYER_FLASHBANGED<-123;
EVENT_TR_MARK_COMPLETE<-124;
EVENT_TR_MARK_BEST_TIME<-125;
EVENT_TR_EXIT_HINT_TRIGGER<-126;
EVENT_BOT_TAKEOVER<-127;
EVENT_TR_SHOW_FINISH_MSGBOX<-128;
EVENT_TR_SHOW_EXIT_MSGBOX<-129;
EVENT_RESET_PLAYER_CONTROLS<-130;
EVENT_JOINTEAM_FAILED<-131;
EVENT_TEAMCHANGE_PENDING<-132;
EVENT_MATERIAL_DEFAULT_COMPLETE<-133;
EVENT_CS_PREV_NEXT_SPECTATOR<-134;
EVENT_CS_HANDLE_IME_EVENT<-135;
EVENT_NEXTLEVEL_CHANGED<-136;
EVENT_SEASONCOIN_LEVELUP<-137;
EVENT_TOURNAMENT_REWARD<-138;
EVENT_START_HALFTIME<-139;
EVENT_HLTV_STATUS<-140;
EVENT_HLTV_CAMERAMAN<-141;
EVENT_HLTV_RANK_CAMERA<-142;
EVENT_HLTV_RANK_ENTITY<-143;
EVENT_HLTV_FIXED<-144;
EVENT_HLTV_CHASE<-145;
EVENT_HLTV_MESSAGE<-146;
EVENT_HLTV_TITLE<-147;
EVENT_HLTV_CHAT<-148;
EVENT_HLTV_CHANGED_TARGET<-149;
EVENT_TEAM_INFO<-150;
EVENT_TEAM_SCORE<-151;
EVENT_TEAMPLAY_BROADCAST_AUDIO<-152;
EVENT_GAMEUI_HIDDEN<-153;
EVENT_ITEMS_GIFTED<-154;
EVENT_PLAYER_TEAM<-155;
EVENT_PLAYER_CLASS<-156;
EVENT_PLAYER_HURT<-158;
EVENT_PLAYER_CHAT<-159;
EVENT_PLAYER_SCORE<-160;
EVENT_PLAYER_SPAWN<-161;
EVENT_PLAYER_SHOOT<-162;
EVENT_PLAYER_USE<-163;
EVENT_PLAYER_CHANGENAME<-164;
EVENT_PLAYER_HINTMESSAGE<-165;
EVENT_GAME_INIT<-166;
EVENT_GAME_NEWMAP<-167;
EVENT_GAME_START<-168;
EVENT_GAME_END<-169;
EVENT_ROUND_ANNOUNCE_MATCH_POINT<-171;
EVENT_ROUND_ANNOUNCE_FINAL<-172;
EVENT_ROUND_ANNOUNCE_LAST_ROUND_HALF<-173;
EVENT_ROUND_ANNOUNCE_MATCH_START<-174;
EVENT_ROUND_ANNOUNCE_WARMUP<-175;
EVENT_ROUND_END_UPLOAD_STATS<-177;
EVENT_ROUND_OFFICIALLY_ENDED<-178;
EVENT_ROUND_TIME_WARNING<-179;
EVENT_UGC_MAP_INFO_RECEIVED<-180;
EVENT_UGC_MAP_UNSUBSCRIBED<-181;
EVENT_UGC_MAP_DOWNLOAD_ERROR<-182;
EVENT_UGC_FILE_DOWNLOAD_FINISHED<-183;
EVENT_UGC_FILE_DOWNLOAD_START<-184;
EVENT_BEGIN_NEW_MATCH<-185;
EVENT_ROUND_START_PRE_ENTITY<-186;
EVENT_TEAMPLAY_ROUND_START<-187;
EVENT_HOSTNAME_CHANGED<-188;
EVENT_DIFFICULTY_CHANGED<-189;
EVENT_FINALE_START<-190;
EVENT_GAME_MESSAGE<-191;
EVENT_DM_BONUS_WEAPON_START<-192;
EVENT_SURVIVAL_ANNOUNCE_PHASE<-193;
EVENT_BREAK_BREAKABLE<-194;
EVENT_BREAK_PROP<-195;
EVENT_PLAYER_DECAL<-196;
EVENT_ENTITY_KILLED<-197;
EVENT_BONUS_UPDATED<-198;
EVENT_PLAYER_STATS_UPDATED<-199;
EVENT_ACHIEVEMENT_EVENT<-200;
EVENT_ACHIEVEMENT_INCREMENT<-201;
EVENT_ACHIEVEMENT_EARNED<-202;
EVENT_ACHIEVEMENT_WRITE_FAILED<-203;
EVENT_PHYSGUN_PICKUP<-204;
EVENT_FLARE_IGNITE_NPC<-205;
EVENT_HELICOPTER_GRENADE_PUNT_MISS<-206;
EVENT_USER_DATA_DOWNLOADED<-207;
EVENT_RAGDOLL_DISSOLVED<-208;
EVENT_GAMEINSTRUCTOR_DRAW<-209;
EVENT_GAMEINSTRUCTOR_NODRAW<-210;
EVENT_MAP_TRANSITION<-211;
EVENT_ENTITY_VISIBLE<-212;
EVENT_SET_INSTRUCTOR_GROUP_ENABLED<-213;
EVENT_INSTRUCTOR_SERVER_HINT_CREATE<-214;
EVENT_INSTRUCTOR_SERVER_HINT_STOP<-215;
EVENT_READ_GAME_TITLEDATA<-216;
EVENT_WRITE_GAME_TITLEDATA<-217;
EVENT_RESET_GAME_TITLEDATA<-218;
EVENT_WEAPON_RELOAD_DATABASE<-219;
EVENT_VOTE_ENDED<-220;
EVENT_VOTE_STARTED<-221;
EVENT_VOTE_CHANGED<-222;
EVENT_VOTE_PASSED<-223;
EVENT_VOTE_FAILED<-224;
EVENT_VOTE_CAST<-225;
EVENT_VOTE_OPTIONS<-226;
EVENT_ENDMATCH_MAPVOTE_SELECTING_MAP<-227;
EVENT_ENDMATCH_CMM_START_REVEAL_ITEMS<-228;
EVENT_INVENTORY_UPDATED<-229;
EVENT_CART_UPDATED<-230;
EVENT_STORE_PRICESHEET_UPDATED<-231;
EVENT_GC_CONNECTED<-232;
EVENT_ITEM_SCHEMA_INITIALIZED<-233;
EVENT_CLIENT_LOADOUT_CHANGED<-234;
EVENT_ADD_PLAYER_SONAR_ICON<-235;
EVENT_ADD_BULLET_HIT_MARKER<-236;
EVENT_VERIFY_CLIENT_HIT<-237;
EVENT_SERVER_SPAWN<-238;
EVENT_SERVER_PRE_SHUTDOWN<-239;
EVENT_SERVER_SHUTDOWN<-240;
EVENT_SERVER_CVAR<-241;
EVENT_SERVER_MESSAGE<-242;
EVENT_SERVER_ADDBAN<-243;
EVENT_SERVER_REMOVEBAN<-244;
EVENT_PLAYER_CONNECT<-245;
EVENT_PLAYER_INFO<-246;
EVENT_PLAYER_DISCONNECT<-247;
EVENT_PLAYER_ACTIVATE<-248;
EVENT_PLAYER_CONNECT_FULL<-249;
EVENT_PLAYER_SAY<-250;
EVENT_CS_ROUND_START_BEEP<-251;
EVENT_CS_ROUND_FINAL_BEEP<-252;
EVENT_ROUND_TIME_WARNING<-253;
events_ids_translate<-{};
events_ids_translate[EVENT_PLAYER_DEATH]<-["player_death",["userid","attacker","assister","weapon","weapon_itemid","weapon_fauxitemid","weapon_originalowner_xuid","headshot","dominated","revenge","penetrated","noreplay"]];
events_ids_translate[EVENT_OTHER_DEATH]<-["other_death",["otherid","othertype","attacker","weapon","weapon_itemid","weapon_fauxitemid","weapon_originalowner_xuid","headshot","penetrated"]];
events_ids_translate[EVENT_PLAYER_HURT]<-["player_hurt",["userid","attacker","health","armor","weapon","dmg_health","dmg_armor","hitgroup"]];
events_ids_translate[EVENT_ITEM_PURCHASE]<-["item_purchase",["userid","team","weapon"]];
events_ids_translate[EVENT_BOMB_BEGINPLANT]<-["bomb_beginplant",["userid","site"]];
events_ids_translate[EVENT_BOMB_ABORTPLANT]<-["bomb_abortplant",["userid","site"]];
events_ids_translate[EVENT_BOMB_PLANTED]<-["bomb_planted",["userid","site"]];
events_ids_translate[EVENT_BOMB_DEFUSED]<-["bomb_defused",["userid","site"]];
events_ids_translate[EVENT_BOMB_EXPLODED]<-["bomb_exploded",["userid","site"]];
events_ids_translate[EVENT_BOMB_DROPPED]<-["bomb_dropped",["userid","entindex"]];
events_ids_translate[EVENT_BOMB_PICKUP]<-["bomb_pickup",["userid"]];
events_ids_translate[EVENT_DEFUSER_DROPPED]<-["defuser_dropped",["entityid"]];
events_ids_translate[EVENT_DEFUSER_PICKUP]<-["defuser_pickup",["entityid","userid"]];
events_ids_translate[EVENT_ANNOUNCE_PHASE_END]<-["announce_phase_end",[]];
events_ids_translate[EVENT_CS_INTERMISSION]<-["cs_intermission",[]];
events_ids_translate[EVENT_BOMB_BEGINDEFUSE]<-["bomb_begindefuse",["userid","haskit"]];
events_ids_translate[EVENT_BOMB_ABORTDEFUSE]<-["bomb_abortdefuse",["userid"]];
events_ids_translate[EVENT_HOSTAGE_FOLLOWS]<-["hostage_follows",["userid","hostage"]];
events_ids_translate[EVENT_HOSTAGE_HURT]<-["hostage_hurt",["userid","hostage"]];
events_ids_translate[EVENT_HOSTAGE_KILLED]<-["hostage_killed",["userid","hostage"]];
events_ids_translate[EVENT_HOSTAGE_RESCUED]<-["hostage_rescued",["userid","hostage","site"]];
events_ids_translate[EVENT_HOSTAGE_STOPS_FOLLOWING]<-["hostage_stops_following",["userid","hostage"]];
events_ids_translate[EVENT_HOSTAGE_RESCUED_ALL]<-["hostage_rescued_all",[]];
events_ids_translate[EVENT_HOSTAGE_CALL_FOR_HELP]<-["hostage_call_for_help",["hostage"]];
events_ids_translate[EVENT_VIP_ESCAPED]<-["vip_escaped",["userid"]];
events_ids_translate[EVENT_VIP_KILLED]<-["vip_killed",["userid","attacker"]];
events_ids_translate[EVENT_PLAYER_RADIO]<-["player_radio",["userid","slot"]];
events_ids_translate[EVENT_BOMB_BEEP]<-["bomb_beep",["entindex"]];
events_ids_translate[EVENT_WEAPON_FIRE]<-["weapon_fire",["userid","weapon","silenced"]];
events_ids_translate[EVENT_WEAPON_FIRE_ON_EMPTY]<-["weapon_fire_on_empty",["userid","weapon"]];
events_ids_translate[EVENT_WEAPON_OUTOFAMMO]<-["weapon_outofammo",["userid"]];
events_ids_translate[EVENT_WEAPON_RELOAD]<-["weapon_reload",["userid"]];
events_ids_translate[EVENT_WEAPON_ZOOM]<-["weapon_zoom",["userid"]];
events_ids_translate[EVENT_SILENCER_DETACH]<-["silencer_detach",["userid"]];
events_ids_translate[EVENT_INSPECT_WEAPON]<-["inspect_weapon",["userid"]];
events_ids_translate[EVENT_WEAPON_ZOOM_RIFLE]<-["weapon_zoom_rifle",["userid"]];
events_ids_translate[EVENT_PLAYER_SPAWNED]<-["player_spawned",["userid","inrestart"]];
events_ids_translate[EVENT_ITEM_PICKUP]<-["item_pickup",["userid","item","silent"]];
events_ids_translate[EVENT_AMMO_PICKUP]<-["ammo_pickup",["userid","item","index"]];
events_ids_translate[EVENT_ITEM_EQUIP]<-["item_equip",["userid","item","canzoom","hassilencer","issilenced","hastracers","weptype","ispainted"]];
events_ids_translate[EVENT_ENTER_BUYZONE]<-["enter_buyzone",["userid","canbuy"]];
events_ids_translate[EVENT_EXIT_BUYZONE]<-["exit_buyzone",["userid","canbuy"]];
events_ids_translate[EVENT_BUYTIME_ENDED]<-["buytime_ended",[]];
events_ids_translate[EVENT_ENTER_BOMBZONE]<-["enter_bombzone",["userid","hasbomb","isplanted"]];
events_ids_translate[EVENT_EXIT_BOMBZONE]<-["exit_bombzone",["userid","hasbomb","isplanted"]];
events_ids_translate[EVENT_ENTER_RESCUE_ZONE]<-["enter_rescue_zone",["userid"]];
events_ids_translate[EVENT_EXIT_RESCUE_ZONE]<-["exit_rescue_zone",["userid"]];
events_ids_translate[EVENT_SILENCER_OFF]<-["silencer_off",["userid"]];
events_ids_translate[EVENT_SILENCER_ON]<-["silencer_on",["userid"]];
events_ids_translate[EVENT_BUYMENU_OPEN]<-["buymenu_open",["userid"]];
events_ids_translate[EVENT_BUYMENU_CLOSE]<-["buymenu_close",["userid"]];
events_ids_translate[EVENT_ROUND_PRESTART]<-["round_prestart",[]];
events_ids_translate[EVENT_ROUND_POSTSTART]<-["round_poststart",[]];
events_ids_translate[EVENT_ROUND_START]<-["round_start",["timelimit","fraglimit","objective"]];
events_ids_translate[EVENT_ROUND_END]<-["round_end",["winner","reason","message","legacy","player_count"]];
events_ids_translate[EVENT_GRENADE_BOUNCE]<-["grenade_bounce",["userid"]];
events_ids_translate[EVENT_HEGRENADE_DETONATE]<-["hegrenade_detonate",["userid","entityid","vector"]];
events_ids_translate[EVENT_FLASHBANG_DETONATE]<-["flashbang_detonate",["userid","entityid","vector"]];
events_ids_translate[EVENT_SMOKEGRENADE_DETONATE]<-["smokegrenade_detonate",["userid","entityid","vector"]];
events_ids_translate[EVENT_SMOKEGRENADE_EXPIRED]<-["smokegrenade_expired",["userid","entityid","vector"]];
events_ids_translate[EVENT_MOLOTOV_DETONATE]<-["molotov_detonate",["userid","vector"]];
events_ids_translate[EVENT_DECOY_DETONATE]<-["decoy_detonate",["userid","entityid","vector"]];
events_ids_translate[EVENT_DECOY_STARTED]<-["decoy_started",["userid","entityid","vector"]];
events_ids_translate[EVENT_TAGRENADE_DETONATE]<-["tagrenade_detonate",["userid","entityid","vector"]];
events_ids_translate[EVENT_INFERNO_STARTBURN]<-["inferno_startburn",["entityid","vector"]];
events_ids_translate[EVENT_INFERNO_EXPIRE]<-["inferno_expire",["entityid","vector"]];
events_ids_translate[EVENT_INFERNO_EXTINGUISH]<-["inferno_extinguish",["entityid","vector"]];
events_ids_translate[EVENT_DECOY_FIRING]<-["decoy_firing",["userid","entityid","vector"]];
events_ids_translate[EVENT_BULLET_IMPACT]<-["bullet_impact",["userid","vector"]];
events_ids_translate[EVENT_PLAYER_FOOTSTEP]<-["player_footstep",["userid"]];
events_ids_translate[EVENT_PLAYER_JUMP]<-["player_jump",["userid"]];
events_ids_translate[EVENT_PLAYER_BLIND]<-["player_blind",["userid"]];
events_ids_translate[EVENT_PLAYER_FALLDAMAGE]<-["player_falldamage",["userid","damage"]];
events_ids_translate[EVENT_DOOR_MOVING]<-["door_moving",["entindex","userid"]];
events_ids_translate[EVENT_ROUND_FREEZE_END]<-["round_freeze_end",[]];
events_ids_translate[EVENT_MB_INPUT_LOCK_SUCCESS]<-["mb_input_lock_success",[]];
events_ids_translate[EVENT_MB_INPUT_LOCK_CANCEL]<-["mb_input_lock_cancel",[]];
events_ids_translate[EVENT_NAV_BLOCKED]<-["nav_blocked",["area","blocked"]];
events_ids_translate[EVENT_NAV_GENERATE]<-["nav_generate",[]];
events_ids_translate[EVENT_PLAYER_STATS_UPDATED]<-["player_stats_updated",["forceupload"]];
events_ids_translate[EVENT_ACHIEVEMENT_INFO_LOADED]<-["achievement_info_loaded",[]];
events_ids_translate[EVENT_SPEC_TARGET_UPDATED]<-["spec_target_updated",["userid"]];
events_ids_translate[EVENT_SPEC_MODE_UPDATED]<-["spec_mode_updated",["userid"]];
events_ids_translate[EVENT_HLTV_CHANGED_MODE]<-["hltv_changed_mode",["oldmode","newmode","obs_target"]];
events_ids_translate[EVENT_CS_GAME_DISCONNECTED]<-["cs_game_disconnected",[]];
events_ids_translate[EVENT_CS_WIN_PANEL_ROUND]<-["cs_win_panel_round",["show_timer_defend","show_timer_attack","timer_time","final_event","funfact_token","funfact_player","funfact_data1","funfact_data2","funfact_data3"]];
events_ids_translate[EVENT_CS_WIN_PANEL_MATCH]<-["cs_win_panel_match",[]];
events_ids_translate[EVENT_CS_MATCH_END_RESTART]<-["cs_match_end_restart",[]];
events_ids_translate[EVENT_CS_PRE_RESTART]<-["cs_pre_restart",[]];
events_ids_translate[EVENT_SHOW_FREEZEPANEL]<-["show_freezepanel",["victim","killer","hits_taken","damage_taken","hits_given","damage_given"]];
events_ids_translate[EVENT_HIDE_FREEZEPANEL]<-["hide_freezepanel",[]];
events_ids_translate[EVENT_FREEZECAM_STARTED]<-["freezecam_started",[]];
events_ids_translate[EVENT_PLAYER_AVENGED_TEAMMATE]<-["player_avenged_teammate",["avenger_id","avenged_player_id"]];
events_ids_translate[EVENT_ACHIEVEMENT_EARNED]<-["achievement_earned",["player","achievement"]];
events_ids_translate[EVENT_ACHIEVEMENT_EARNED_LOCAL]<-["achievement_earned_local",["achievement","splitscreenplayer"]];
events_ids_translate[EVENT_ITEM_FOUND]<-["item_found",["player","quality","method","itemdef","itemid"]];
events_ids_translate[EVENT_ITEMS_GIFTED]<-["items_gifted",["player","itemdef","numgifts","giftidx","accountid"]];
events_ids_translate[EVENT_REPOST_XBOX_ACHIEVEMENTS]<-["repost_xbox_achievements",["splitscreenplayer"]];
events_ids_translate[EVENT_MATCH_END_CONDITIONS]<-["match_end_conditions",["frags","max_rounds","win_rounds","time"]];
events_ids_translate[EVENT_ROUND_MVP]<-["round_mvp",["userid","reason","musickitmvps"]];
events_ids_translate[EVENT_PLAYER_DECAL]<-["player_decal",["userid"]];
events_ids_translate[EVENT_TEAMPLAY_ROUND_START]<-["teamplay_round_start",["full_reset"]];
events_ids_translate[EVENT_CLIENT_DISCONNECT]<-["client_disconnect",[]];
events_ids_translate[EVENT_GG_PLAYER_LEVELUP]<-["gg_player_levelup",["userid","weaponrank","weaponname"]];
events_ids_translate[EVENT_GGTR_PLAYER_LEVELUP]<-["ggtr_player_levelup",["userid","weaponrank","weaponname"]];
events_ids_translate[EVENT_ASSASSINATION_TARGET_KILLED]<-["assassination_target_killed",["target","killer"]];
events_ids_translate[EVENT_GGPROGRESSIVE_PLAYER_LEVELUP]<-["ggprogressive_player_levelup",["userid","weaponrank","weaponname"]];
events_ids_translate[EVENT_GG_KILLED_ENEMY]<-["gg_killed_enemy",["victimid","attackerid","dominated","revenge","bonus"]];
events_ids_translate[EVENT_GG_FINAL_WEAPON_ACHIEVED]<-["gg_final_weapon_achieved",["playerid"]];
events_ids_translate[EVENT_GG_BONUS_GRENADE_ACHIEVED]<-["gg_bonus_grenade_achieved",["userid"]];
events_ids_translate[EVENT_SWITCH_TEAM]<-["switch_team",["numplayers","numspectators","avg_rank","numtslotsfree","numctslotsfree"]];
events_ids_translate[EVENT_GG_LEADER]<-["gg_leader",["playerid"]];
events_ids_translate[EVENT_GG_TEAM_LEADER]<-["gg_team_leader",["playerid"]];
events_ids_translate[EVENT_GG_PLAYER_IMPENDING_UPGRADE]<-["gg_player_impending_upgrade",["userid"]];
events_ids_translate[EVENT_WRITE_PROFILE_DATA]<-["write_profile_data",[]];
events_ids_translate[EVENT_TRIAL_TIME_EXPIRED]<-["trial_time_expired",["slot"]];
events_ids_translate[EVENT_UPDATE_MATCHMAKING_STATS]<-["update_matchmaking_stats",[]];
events_ids_translate[EVENT_PLAYER_RESET_VOTE]<-["player_reset_vote",["userid","vote"]];
events_ids_translate[EVENT_ENABLE_RESTART_VOTING]<-["enable_restart_voting",["enable"]];
events_ids_translate[EVENT_SFUIEVENT]<-["sfuievent",["action","data","slot"]];
events_ids_translate[EVENT_START_VOTE]<-["start_vote",["userid","type","vote_parameter"]];
events_ids_translate[EVENT_PLAYER_GIVEN_C4]<-["player_given_c4",["userid"]];
events_ids_translate[EVENT_GG_RESET_ROUND_START_SOUNDS]<-["gg_reset_round_start_sounds",["userid"]];
events_ids_translate[EVENT_TR_PLAYER_FLASHBANGED]<-["tr_player_flashbanged",["userid"]];
events_ids_translate[EVENT_TR_MARK_COMPLETE]<-["tr_mark_complete",["complete"]];
events_ids_translate[EVENT_TR_MARK_BEST_TIME]<-["tr_mark_best_time",["time"]];
events_ids_translate[EVENT_TR_EXIT_HINT_TRIGGER]<-["tr_exit_hint_trigger",[]];
events_ids_translate[EVENT_BOT_TAKEOVER]<-["bot_takeover",["userid","botid","index"]];
events_ids_translate[EVENT_TR_SHOW_FINISH_MSGBOX]<-["tr_show_finish_msgbox",["userid"]];
events_ids_translate[EVENT_TR_SHOW_EXIT_MSGBOX]<-["tr_show_exit_msgbox",["userid"]];
events_ids_translate[EVENT_RESET_PLAYER_CONTROLS]<-["reset_player_controls",[]];
events_ids_translate[EVENT_JOINTEAM_FAILED]<-["jointeam_failed",["userid","reason"]];
events_ids_translate[EVENT_TEAMCHANGE_PENDING]<-["teamchange_pending",["userid","toteam"]];
events_ids_translate[EVENT_MATERIAL_DEFAULT_COMPLETE]<-["material_default_complete",[]];
events_ids_translate[EVENT_CS_PREV_NEXT_SPECTATOR]<-["cs_prev_next_spectator",["next"]];
events_ids_translate[EVENT_CS_HANDLE_IME_EVENT]<-["cs_handle_ime_event",["local","eventtype","eventdata"]];
events_ids_translate[EVENT_NEXTLEVEL_CHANGED]<-["nextlevel_changed",["nextlevel"]];
events_ids_translate[EVENT_SEASONCOIN_LEVELUP]<-["seasoncoin_levelup",["player","category","rank"]];
events_ids_translate[EVENT_TOURNAMENT_REWARD]<-["tournament_reward",["defindex","totalrewards","accountid"]];
events_ids_translate[EVENT_START_HALFTIME]<-["start_halftime",[]];
events_ids_translate[EVENT_HLTV_STATUS]<-["hltv_status",["clients","slots","proxies","master","externaltotal","externallinked"]];
events_ids_translate[EVENT_HLTV_CAMERAMAN]<-["hltv_cameraman",["index"]];
events_ids_translate[EVENT_HLTV_RANK_CAMERA]<-["hltv_rank_camera",["index","rank","target"]];
events_ids_translate[EVENT_HLTV_RANK_ENTITY]<-["hltv_rank_entity",["index","rank","target"]];
events_ids_translate[EVENT_HLTV_FIXED]<-["hltv_fixed",["posx","posy","posz","theta","phi","offset","fov","target"]];
events_ids_translate[EVENT_HLTV_CHASE]<-["hltv_chase",["target1","target2","distance","theta","phi","inertia","ineye"]];
events_ids_translate[EVENT_HLTV_MESSAGE]<-["hltv_message",["text"]];
events_ids_translate[EVENT_HLTV_TITLE]<-["hltv_title",["text"]];
events_ids_translate[EVENT_HLTV_CHAT]<-["hltv_chat",["text"]];
events_ids_translate[EVENT_HLTV_CHANGED_TARGET]<-["hltv_changed_target",["mode","old_target","obs_target"]];
events_ids_translate[EVENT_TEAM_INFO]<-["team_info",["teamid","teamname"]];
events_ids_translate[EVENT_TEAM_SCORE]<-["team_score",["teamid","score"]];
events_ids_translate[EVENT_TEAMPLAY_BROADCAST_AUDIO]<-["teamplay_broadcast_audio",["team","sound"]];
events_ids_translate[EVENT_GAMEUI_HIDDEN]<-["gameui_hidden",[]];
events_ids_translate[EVENT_ITEMS_GIFTED]<-["items_gifted",["player","itemdef","numgifts","giftidx","accountid"]];
events_ids_translate[EVENT_PLAYER_TEAM]<-["player_team",["userid","team","oldteam","disconnect","autoteam","silent","isbot"]];
events_ids_translate[EVENT_PLAYER_CLASS]<-["player_class",["userid","class"]];
events_ids_translate[EVENT_PLAYER_CHAT]<-["player_chat",["teamonly","userid","text"]];
events_ids_translate[EVENT_PLAYER_SCORE]<-["player_score",["userid","kills","deaths","score"]];
events_ids_translate[EVENT_PLAYER_SPAWN]<-["player_spawn",["userid","teamnum"]];
events_ids_translate[EVENT_PLAYER_SHOOT]<-["player_shoot",["userid","weapon","mode"]];
events_ids_translate[EVENT_PLAYER_USE]<-["player_use",["userid","entity"]];
events_ids_translate[EVENT_PLAYER_CHANGENAME]<-["player_changename",["userid","oldname","newname"]];
events_ids_translate[EVENT_PLAYER_HINTMESSAGE]<-["player_hintmessage",["hintmessage"]];
events_ids_translate[EVENT_GAME_INIT]<-["game_init",[]];
events_ids_translate[EVENT_GAME_NEWMAP]<-["game_newmap",["mapname"]];
events_ids_translate[EVENT_GAME_START]<-["game_start",["roundslimit","timelimit","fraglimit","objective"]];
events_ids_translate[EVENT_GAME_END]<-["game_end",["winner"]];
events_ids_translate[EVENT_ROUND_ANNOUNCE_MATCH_POINT]<-["round_announce_match_point",[]];
events_ids_translate[EVENT_ROUND_ANNOUNCE_FINAL]<-["round_announce_final",[]];
events_ids_translate[EVENT_ROUND_ANNOUNCE_LAST_ROUND_HALF]<-["round_announce_last_round_half",[]];
events_ids_translate[EVENT_ROUND_ANNOUNCE_MATCH_START]<-["round_announce_match_start",[]];
events_ids_translate[EVENT_ROUND_ANNOUNCE_WARMUP]<-["round_announce_warmup",[]];
events_ids_translate[EVENT_ROUND_END_UPLOAD_STATS]<-["round_end_upload_stats",[]];
events_ids_translate[EVENT_ROUND_OFFICIALLY_ENDED]<-["round_officially_ended",[]];
events_ids_translate[EVENT_ROUND_TIME_WARNING]<-["round_time_warning",[]];
events_ids_translate[EVENT_UGC_MAP_INFO_RECEIVED]<-["ugc_map_info_received",["published_file_id"]];
events_ids_translate[EVENT_UGC_MAP_UNSUBSCRIBED]<-["ugc_map_unsubscribed",["published_file_id"]];
events_ids_translate[EVENT_UGC_MAP_DOWNLOAD_ERROR]<-["ugc_map_download_error",["published_file_id","error_code"]];
events_ids_translate[EVENT_UGC_FILE_DOWNLOAD_FINISHED]<-["ugc_file_download_finished",["hcontent"]];
events_ids_translate[EVENT_UGC_FILE_DOWNLOAD_START]<-["ugc_file_download_start",["hcontent","published_file_id"]];
events_ids_translate[EVENT_BEGIN_NEW_MATCH]<-["begin_new_match",[]];
events_ids_translate[EVENT_ROUND_START_PRE_ENTITY]<-["round_start_pre_entity",[]];
events_ids_translate[EVENT_TEAMPLAY_ROUND_START]<-["teamplay_round_start",["full_reset"]];
events_ids_translate[EVENT_HOSTNAME_CHANGED]<-["hostname_changed",["hostname"]];
events_ids_translate[EVENT_DIFFICULTY_CHANGED]<-["difficulty_changed",["newdifficulty","olddifficulty","strdifficulty"]];
events_ids_translate[EVENT_FINALE_START]<-["finale_start",["rushes"]];
events_ids_translate[EVENT_GAME_MESSAGE]<-["game_message",["target","text"]];
events_ids_translate[EVENT_DM_BONUS_WEAPON_START]<-["dm_bonus_weapon_start",["time","wepid","pos"]];
events_ids_translate[EVENT_SURVIVAL_ANNOUNCE_PHASE]<-["survival_announce_phase",["phase"]];
events_ids_translate[EVENT_BREAK_BREAKABLE]<-["break_breakable",["entindex","userid","material"]];
events_ids_translate[EVENT_BREAK_PROP]<-["break_prop",["entindex","userid"]];
events_ids_translate[EVENT_PLAYER_DECAL]<-["player_decal",["userid"]];
events_ids_translate[EVENT_ENTITY_KILLED]<-["entity_killed",["entindex_killed","entindex_attacker","entindex_inflictor","damagebits"]];
events_ids_translate[EVENT_BONUS_UPDATED]<-["bonus_updated",["numadvanced","numbronze","numsilver","numgold"]];
events_ids_translate[EVENT_PLAYER_STATS_UPDATED]<-["player_stats_updated",["forceupload"]];
events_ids_translate[EVENT_ACHIEVEMENT_EVENT]<-["achievement_event",["achievement_name","cur_val","max_val"]];
events_ids_translate[EVENT_ACHIEVEMENT_INCREMENT]<-["achievement_increment",["achievement_id","cur_val","max_val"]];
events_ids_translate[EVENT_ACHIEVEMENT_EARNED]<-["achievement_earned",["player","achievement"]];
events_ids_translate[EVENT_ACHIEVEMENT_WRITE_FAILED]<-["achievement_write_failed",[]];
events_ids_translate[EVENT_PHYSGUN_PICKUP]<-["physgun_pickup",["entindex"]];
events_ids_translate[EVENT_FLARE_IGNITE_NPC]<-["flare_ignite_npc",["entindex"]];
events_ids_translate[EVENT_HELICOPTER_GRENADE_PUNT_MISS]<-["helicopter_grenade_punt_miss",[]];
events_ids_translate[EVENT_USER_DATA_DOWNLOADED]<-["user_data_downloaded",[]];
events_ids_translate[EVENT_RAGDOLL_DISSOLVED]<-["ragdoll_dissolved",["entindex"]];
events_ids_translate[EVENT_GAMEINSTRUCTOR_DRAW]<-["gameinstructor_draw",[]];
events_ids_translate[EVENT_GAMEINSTRUCTOR_NODRAW]<-["gameinstructor_nodraw",[]];
events_ids_translate[EVENT_MAP_TRANSITION]<-["map_transition",[]];
events_ids_translate[EVENT_ENTITY_VISIBLE]<-["entity_visible",["userid","subject","classname","entityname"]];
events_ids_translate[EVENT_SET_INSTRUCTOR_GROUP_ENABLED]<-["set_instructor_group_enabled",["group","enabled"]];
events_ids_translate[EVENT_INSTRUCTOR_SERVER_HINT_CREATE]<-["instructor_server_hint_create",["hint_name","hint_replace_key","hint_target","hint_activator_userid","hint_timeout","hint_icon_onscreen","hint_icon_offscreen","hint_caption","hint_activator_caption","hint_color","hint_icon_offset","hint_range","hint_flags","hint_binding","hint_gamepad_binding","hint_allow_nodraw_target","hint_nooffscreen","hint_forcecaption","hint_local_player_only"]];
events_ids_translate[EVENT_INSTRUCTOR_SERVER_HINT_STOP]<-["instructor_server_hint_stop",["hint_name"]];
events_ids_translate[EVENT_READ_GAME_TITLEDATA]<-["read_game_titledata",["controllerid"]];
events_ids_translate[EVENT_WRITE_GAME_TITLEDATA]<-["write_game_titledata",["controllerid"]];
events_ids_translate[EVENT_RESET_GAME_TITLEDATA]<-["reset_game_titledata",["controllerid"]];
events_ids_translate[EVENT_WEAPON_RELOAD_DATABASE]<-["weapon_reload_database",[]];
events_ids_translate[EVENT_VOTE_ENDED]<-["vote_ended",[]];
events_ids_translate[EVENT_VOTE_STARTED]<-["vote_started",["issue","param1","team","initiator"]];
events_ids_translate[EVENT_VOTE_CHANGED]<-["vote_changed",["vote_option1","vote_option2","vote_option3","vote_option4","vote_option5","potentialvotes"]];
events_ids_translate[EVENT_VOTE_PASSED]<-["vote_passed",["details","param1","team"]];
events_ids_translate[EVENT_VOTE_FAILED]<-["vote_failed",["team"]];
events_ids_translate[EVENT_VOTE_CAST]<-["vote_cast",["vote_option","team","entityid"]];
events_ids_translate[EVENT_VOTE_OPTIONS]<-["vote_options",["count","option1","option2","option3","option4","option5"]];
events_ids_translate[EVENT_ENDMATCH_MAPVOTE_SELECTING_MAP]<-["endmatch_mapvote_selecting_map",["count","slot1","slot2","slot3","slot4","slot5","slot6","slot7","slot8","slot9","slot10"]];
events_ids_translate[EVENT_ENDMATCH_CMM_START_REVEAL_ITEMS]<-["endmatch_cmm_start_reveal_items",[]];
events_ids_translate[EVENT_INVENTORY_UPDATED]<-["inventory_updated",[]];
events_ids_translate[EVENT_CART_UPDATED]<-["cart_updated",[]];
events_ids_translate[EVENT_STORE_PRICESHEET_UPDATED]<-["store_pricesheet_updated",[]];
events_ids_translate[EVENT_GC_CONNECTED]<-["gc_connected",[]];
events_ids_translate[EVENT_ITEM_SCHEMA_INITIALIZED]<-["item_schema_initialized",[]];
events_ids_translate[EVENT_CLIENT_LOADOUT_CHANGED]<-["client_loadout_changed",[]];
events_ids_translate[EVENT_ADD_PLAYER_SONAR_ICON]<-["add_player_sonar_icon",["userid","vector"]];
events_ids_translate[EVENT_ADD_BULLET_HIT_MARKER]<-["add_bullet_hit_marker",["userid","bone","vector","vector","vector","hit"]];
events_ids_translate[EVENT_VERIFY_CLIENT_HIT]<-["verify_client_hit",["userid","vector","timestamp"]];
events_ids_translate[EVENT_SERVER_SPAWN]<-["server_spawn",["hostname","address","port","game","mapname","maxplayers","os","dedicated","official","password"]];
events_ids_translate[EVENT_SERVER_PRE_SHUTDOWN]<-["server_pre_shutdown",["reason"]];
events_ids_translate[EVENT_SERVER_SHUTDOWN]<-["server_shutdown",["reason"]];
events_ids_translate[EVENT_SERVER_CVAR]<-["server_cvar",["cvarname","cvarvalue"]];
events_ids_translate[EVENT_SERVER_MESSAGE]<-["server_message",["text"]];
events_ids_translate[EVENT_SERVER_ADDBAN]<-["server_addban",["name","userid","networkid","ip","duration","by","kicked"]];
events_ids_translate[EVENT_SERVER_REMOVEBAN]<-["server_removeban",["networkid","ip","by"]];
events_ids_translate[EVENT_PLAYER_CONNECT]<-["player_connect",["name","index","userid","networkid","address"]];
events_ids_translate[EVENT_PLAYER_INFO]<-["player_info",["name","index","userid","networkid","bot"]];
events_ids_translate[EVENT_PLAYER_DISCONNECT]<-["player_disconnect",["userid","reason","name","networkid"]];
events_ids_translate[EVENT_PLAYER_ACTIVATE]<-["player_activate",["userid"]];
events_ids_translate[EVENT_PLAYER_CONNECT_FULL]<-["player_connect_full",["userid","index"]];
events_ids_translate[EVENT_PLAYER_SAY]<-["player_say",["userid","text"]];
events_ids_translate[EVENT_CS_ROUND_START_BEEP]<-["cs_round_start_beep",[]];
events_ids_translate[EVENT_CS_ROUND_FINAL_BEEP]<-["cs_round_final_beep",[]];
events_ids_translate[EVENT_ROUND_TIME_WARNING]<-["round_time_warning",[]];
if (!("gameevents_proxy" in getroottable())||!(::gameevents_proxy.IsValid())){
::gameevents_proxy<-Entities.CreateByClassname("info_game_event_proxy");
::gameevents_proxy.__KeyValueFromString("event_name","player_use");
::gameevents_proxy.__KeyValueFromInt("range",0);
}
::GameEventsCapturedPlayer<-null
Think<-function(){
	player<-null;
	while((player = Entities.FindByClassname(player,"*")) != null){
		if (player.GetClassname()=="player"){
			if (player.ValidateScriptScope()){
				local script_scope=player.GetScriptScope()
				if (!("userid" in script_scope)&&!("attemptogenerateuserid" in script_scope)){
					script_scope.attemptogenerateuserid<-true;
					::GameEventsCapturedPlayer=player;
					EntFireByHandle(::gameevents_proxy,"GenerateGameEvent","",0.0,player,null);
					return
				}
			}
		}
	}
}
::WEAPONTYPE_UNKNOWN<- -1
::WEAPONTYPE_KNIFE<-0
::WEAPONTYPE_PISTOL<-1
::WEAPONTYPE_SUBMACHINEGUN<-2
::WEAPONTYPE_RIFLE<-3
::WEAPONTYPE_SHOTGUN<-4
::WEAPONTYPE_SNIPER_RIFLE<-5
::WEAPONTYPE_MACHINEGUN<-6
::WEAPONTYPE_C4<-7
::WEAPONTYPE_GRENADE<-8
FireEventFormat<-function(id,event_data){
	local name="OnGameEvent_"+events_ids_translate[id][0]
	local args={}
	local vector=Vector(0,0,0);
	local writedx=false
	local writedy=false
	local writedz=false
	local offset=0
	local order=events_ids_translate[id][1]
	foreach (key,arg in event_data){
		local shouldwrite=true
		if (key=="userid"||key=="attacker"||key=="assister"||key=="victimid"||key=="attackerid"||key=="playerid"||key=="botid"){
			arg=GetPlayerForUserID(arg);
		}
		if (key=="entindex"||key=="entindex_killed"||key=="entindex_attacker"||key=="entindex_inflictor"||key=="site"||key=="hostage"||key=="index"||key=="victim"||key=="killer"||key=="player"||key=="entity"){
			arg=GetEntityForIndex(arg);
		}
		if (key=="x"||key=="pos_x"||key=="start_x"||key=="ang_x"){
			vector.x=arg
			writedx=true
			shouldwrite=false
		}
		if (key=="y"||key=="pos_y"||key=="start_y"||key=="ang_y"){
			vector.y=arg
			writedy=true
			shouldwrite=false
		}
		if (key=="z"||key=="pos_z"||key=="start_z"||key=="ang_z"){
			vector.z=arg
			writedz=true
			shouldwrite=false
		}
		if (writedx&&writedy&&writedz){
			foreach (index,k in order){
				if (k=="vector"){
					args[index+1]<-vector;
					writedx=false;
					writedy=false;
					writedz=false;
					break
				}
			}
		}
		if (shouldwrite){
			foreach (index,k in order){
				if (k==key){
					args[index+1]<-arg;
					break;
				}
			}
		}
	}
	switch (args.len()){
		case 0:getroottable()[name]();break;
		case 1:getroottable()[name](args[1]);break;
		case 2:getroottable()[name](args[1],args[2]);break;
		case 3:getroottable()[name](args[1],args[2],args[3]);break;
		case 4:getroottable()[name](args[1],args[2],args[3],args[4]);break;
		case 5:getroottable()[name](args[1],args[2],args[3],args[4],args[5]);break;
		case 6:getroottable()[name](args[1],args[2],args[3],args[4],args[5],args[6]);break;
		case 7:getroottable()[name](args[1],args[2],args[3],args[4],args[5],args[6],args[7]);break;
		case 8:getroottable()[name](args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8]);break;
		case 9:getroottable()[name](args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9]);break;
		case 10:getroottable()[name](args[1],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10]);break;
	}
}
userid_assigner<-function(params){
	if (::GameEventsCapturedPlayer!=null&&(!("entity" in params)||params.entity == 0)){
		local script_scope=::GameEventsCapturedPlayer.GetScriptScope();
		script_scope.userid<-params.userid;
		::GameEventsCapturedPlayer=null;
		return true
	}
}
OnEventFired<-function(EVENT_ID){
	if (EVENT_ID==EVENT_PLAYER_USE){if (userid_assigner(this.event_data)){return}}
	if ("event_data" in this){
		if ("OnGameEvent_"+events_ids_translate[EVENT_ID][0] in getroottable()){
			FireEventFormat(EVENT_ID,this.event_data)
		}
		if ("OnGameEvent_"+events_ids_translate[EVENT_ID][0]+"_raw" in getroottable()){
			getroottable()["OnGameEvent_"+events_ids_translate[EVENT_ID][0]+"_raw"](this.event_data)
		}
	}
}
::GetPlayerForUserID<-function(userid){
	if (userid == 0) return null
	player <- null;
	while((player = Entities.FindByClassname(player,"*")) != null){
		if (player.GetClassname()=="player"){
			if (player.ValidateScriptScope()){
				local script_scope=player.GetScriptScope()
				if ("userid" in script_scope && script_scope.userid==userid){return player}
			}	
		}
	}
	return null
}
::GetEntityForIndex<-function(entindex){
	ent <- null;
	while((ent= Entities.FindByClassname(ent,"*")) != null){
		if (ent.entindex()==entindex){return ent}
	}
	return null
}

//********************************************************\\
//----------------------VIP SCRIPT------------------------\\
//********************************************************\\


MapperModel <- "models/player/custom_player/ia-nananana/lillwasa/dao/templar2.mdl"; // ADD LATER
VIPModel <- "models/player/custom_player/ia-nananana/lillwasa/dao/templar.mdl"; // ADD LATER

::MapperTemplate <- Entities.FindByName(null,"MapperTagTemplateSpawner");

::VipTemplate <- Entities.FindByName(null,"VipTagTemplateSpawner");

::SpellsHandlerEntity <- Entities.FindByName(null, "SpellsHandler");


if (!("mapperArray" in getroottable())){ //Create locals only once
  ::mapperArray<-["STEAM_1:0:230226481"];
}

if (!("mapperuserArray" in getroottable())){ //Create locals only once
  ::mapperuserArray<-[];
}


if (!("vipArray" in getroottable())){ //Create locals only once
  ::vipArray<-[	"STEAM_1:1:511378910","STEAM_1:1:62262896","STEAM_1:0:82660003",
  				"STEAM_1:0:130098902", "STEAM_1:1:84011175", "STEAM_1:1:164683076",
  			    "STEAM_1:0:508127592","STEAM_1:1:69345448","STEAM_1:0:52022033",
  				"STEAM_1:1:28758194","STEAM_1:0:55472634","STEAM_1:0:13024433",
				"STEAM_1:1:17775692","STEAM_1:0:545026218","STEAM_1:1:21421008",
				"STEAM_1:1:109841723","STEAM_1:0:204515005","STEAM_1:1:465751038"];
}

if (!("vipuserArray" in getroottable())){ //Create locals only once
  ::vipuserArray<-[];
}


::OnGameEvent_player_connect_raw<-function(event)
{
	foreach(val in ::mapperArray) { 
		if (val == event.networkid)
		{
			::mapperuserArray.append(event.userid);
			break;
		}
	}
	foreach(val in ::vipArray)
	{
		if(val == event.networkid)
		{
			::vipuserArray.append(event.userid);
		}
	}
}
function PrintMapperArray()
{
	foreach(val in ::mapperArray)
	{
		printl(val);
	}
}
function PrintVipArray()
{
	foreach(val in ::vipArray)
	{
		printl(val);
	}
}

function CheckUsers()
{
	foreach(val in ::mapperuserArray)
	{
		local ply = ::GetPlayerForUserID(val);
		ply.ValidateScriptScope()
		if(ply != null)
		{
			local scope = ply.GetScriptScope();
			EntFireByHandle(ply, "AddOutput", "Health 200", 0, null, null);
			MapperTemplate.SpawnEntityAtEntityOrigin(ply);
			local mapperTrail = Entities.FindByClassnameWithin(null,"env_spritetrail",ply.GetOrigin(),5);
			local mapperSprite = Entities.FindByClassnameWithin(null,"env_sprite",ply.GetOrigin(),5);
			ParentSpawnedEntity(mapperTrail,mapperSprite,ply,0);

			ply.PrecacheModel(MapperModel);
			ply.SetModel(MapperModel);
			
			try{
				if( ::CheckIfHasSpell(scope.spells, "Swords Of Light") == false)
				{
					EntFireByHandle(::SpellsHandlerEntity, "RunScriptCode", "PickupSpell(0)", 0, ply, null);
					EntFireByHandle(::SpellsHandlerEntity, "RunScriptCode", "PickupSpell(1)", 0, ply, null);
				}

				if(scope.level + scope.points == 1)
				{
					scope.points = 5;
				}
			}
			catch(err){
				printl(err)// just to see whats wrong if it happens on a live server
			}
		}
	}
	foreach(val in ::vipuserArray)
	{
		local ply = ::GetPlayerForUserID(val);
		ply.ValidateScriptScope()
		if(ply != null)
		{
			local scope = ply.GetScriptScope();
			EntFireByHandle(ply, "AddOutput", "Health 150", 0, null, null);
			VipTemplate.SpawnEntityAtEntityOrigin(ply);
			local vipTrail = Entities.FindByClassnameWithin(null,"env_spritetrail",ply.GetOrigin(),5);
			local vipSprite = Entities.FindByClassnameWithin(null,"env_sprite",ply.GetOrigin(),5);
			ParentSpawnedEntity(vipTrail,vipSprite,ply,0);

			ply.PrecacheModel(VIPModel);
			ply.SetModel(VIPModel);

			try{
				if( ::CheckIfHasSpell(scope.spells, "Swords Of Light") == false)
					EntFireByHandle(::SpellsHandlerEntity, "RunScriptCode", "PickupSpell(0)", 0, ply, null);

				if(scope.level + scope.points == 1)
				{
					scope.points = 5;
				}
			}
			catch(err){
				printl(err)
			}
		}
	}
}

function AddVipID(seg1,seg2)
{
	local steamid = "STEAM_1:"+seg1+":"+seg2;
	::vipArray.append(steamid);
}

function SetRandomizedSkin(player)
{
	local randomNumber = RandomInt(0,1);
	if(randomNumber == 0)
	{
		player.PrecacheModel(vip_model_1);
		player.SetModel(vip_model_1);
	}
	else if(randomNumber == 1)
	{
		player.PrecacheModel(vip_model_2);
		player.SetModel(vip_model_2);
	}
}

function ParentSpawnedEntity(trail,sprite,player,delay)
{
	if(trail == null||player == null)
		return;
	EntFireByHandle(trail,"SetParent","!activator",delay, player, null);
	EntFireByHandle(sprite,"SetParent","!activator",delay, player, null);

	trail.SetOrigin(Vector(player.GetOrigin().x,player.GetOrigin().y,player.GetOrigin().z +5));

	sprite.SetOrigin(Vector(player.GetOrigin().x,player.GetOrigin().y,player.GetOrigin().z+80));

}