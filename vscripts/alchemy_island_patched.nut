//#####################################################################
//Patched version intended for use with GFL ze_alchemy_b6_2 stripper
//Fix spawn particles being started too early and not displaying on multiplayer
//Install as csgo/scripts/vscripts/king/ze_alchemy_island/alchemy_island_patched.nut
//#####################################################################

// ADMIN ROOM POS -> 9794 -1960 3028
Level_str <- null;
TESTING_MATERIAS <- false; //change to true if you want to test all materias, they spawn in the coordinates 2947 697 -3920

COMMON_MATERIA_SPAWN_CT <- [Vector(2609, -10463, 1184), Vector(2963, -9535, 1152), Vector(3395, -10607, 800), Vector(1322, -11407, 992), Vector(3330, -11391, 1248), Vector(3091, -10207, 1168), Vector(3811, -10655, 1248)]
ORIGINS_CT_MATERIAS <- {
    ["1"] = [
        Vector(2231, 3829, 1268)
    ],
    ["2"] = [
        Vector(-8597, 1425, -1600)
    ],
    ["3"] = [
        Vector(-12413, -7895, 576)
    ],
    ["4"] = [
        Vector(-11685, -3063, 2176)
    ]
}
ORIGINS_T_MATERIAS <- {
    ["1"] = [
        Vector(1941, 2661, 930), Vector(1317, 5249, 1218), Vector(-4027, 5120, 850), Vector(-3323, 3457, 1554), Vector(0, -7968, 666)
    ],
    ["2"] = [
        Vector(-10795, 6592, -2238), Vector(-9067, 2112, -1646), Vector(-9451, 3296, -350), Vector(-12779, 5824, 34), Vector(0, -7968, 666)
    ],
    ["3"] = [
        Vector(-12891, 4135, 34), Vector(-10691, 4128, 1362), Vector(-11595, -4416, 770), Vector(-13824, -9360, 354), Vector(0, -7968, 666)
    ],
    ["4"] = [
        Vector(-11803, -1408, 2194), Vector(7722, -9808, 98), Vector(9381, -7392, 738), Vector(6929, -11216, 738), Vector(0, -7968, 666)
    ]
}

MATERIAS_CT <- {
    ["1"] = ["heal_ct_tpt", "ice_ct_tpt"],
    ["2"] = ["heal_ct_tpt", "ice_ct_tpt", "gravity_ct_tpt"],
    ["3"] = ["heal_ct_tpt", "ice_ct_tpt", "burn_ct_tpt", "gravity_ct_tpt"],
    ["4"] = ["heal_ct_tpt", "ice_ct_tpt", "burn_ct_tpt", "gravity_ct_tpt"]
}
MATERIAS_T <- {
    ["1"] = ["speed_zm_tpt", "lure_zm_tpt"],
    ["2"] = ["speed_zm_tpt", "warp_zm_tpt", "freeze_zm_tpt"],
    ["3"] = ["speed_zm_tpt", "lure_zm_tpt", "warp_zm_tpt"],
    ["4"] = ["speed_zm_tpt", "freeze_zm_tpt"]
}

//entities that are only usable for one level
UNIQUE_ENTITIES <- [
    {level = "1", entityList = 
        ["destino_aventura_lvl1", "caminho_escada_1_lvl1", "tp_zm_2_lvl1_destino", "spawn_plats_hold_2_lvl1", "tp_entrada_torre", "plat_caminho_3", "tp_queda_torre_2",
        "plat_caminho_2", "plat_topo_torre", "destino_queda_cima", "porta_hold_5", "pedra_hold_6", "tp_fim_lvl1", "trigger_fim_lvl1", "temporiza_boss_lvl1",
        "ataques_boss_lvl1", "afk_tele_top", "trigger_porta_final_lvl1"]
    },
    {level = "2", entityList = ["tpt_boss_lvl2", "porta_1_hold_1_lvl2", "destino_tp_zm_andar_baixo_lvl2", "tp_zm_andar_baixo_lvl2", "plat_possivel_materia", "parede_hold_2_lvl2",
        "trigger_parede_inv_hold_3_lvl2", "parede_hold_3_lvl2", "porta_hold_4_lvl2", "push_ct_boss_lvl2", "add_hp_boss_lvl2", "localiza_landslide_bosslvl2", "localiza_death_arrow_bosslvl2",
        "hurt_contato_boss_lvl2", "parede_fim_boss_lvl2", "parede_1_lvl3", "bloqueia_player_especial", "temporiza_boss_lvl2", "ataques_boss_lvl2", "possiveis_lasers_boss", 
        "caminho_1_lvl3", "trigger_final_door_lvl2_normal", "trigger_porta_1_lvl2_ct", "spr_help_1", "escada_level_2", "caminho_lvl2", "trigger_detecta_zm_fim_lvl2"]
    },
    {level = "3", entityList = ["tp_queda_torre_lvl3", "parede_2_lvl3", "afk_tele_tower", "destino_aventura_lvl3", "plats_shortcut_tower", 
        "elevador_teleporte", "push_zms_hold_fonte", "trigger_fonte", "tp_vila_ct", "tp_vila_zm", "trigger_tp_destino_fim_lvl3", "destino_tr_vila", "particula_tp_final", 
        "destino_ct_vila", "tp_destino_fim_lvl3", "trigger_porta_ponte_lvl3", "porta_ponte_lvl3", "trigger_porta_baixo_lvl3", "porta_baixo_lvl3", "parede_fonte", 
        "trigger_porta_caminho_1_lvl3", "porta_caminho_1_lvl3", "porta_caminho_fonte_lvl3", "trigger_caminho_fonte", "first_gate_1", "zombie_outside_tp", 
        "zombie_outside_tp_zms", "first_gate_destino", "push_casinha", "bloqueia_zm_fdp", "destino_zombie_outside_tp", "pedras_hold_underground", "parede_underground",
        "spawn_estatua", "destino_zm_depois_boss", "trigger_main_gate", "main_gate", "trigger_porta_final_lvl3", "push_ct_boss_lvl3", "porta_final_lvl3", "add_hp_boss_lvl3",
        "soul_eater_hurt", "hurt_wall_sorrow", "localiza_frostbite_boss_lvl3", "particula_soul_eater", "cria_wall_sorrow", "tpt_wall_sorrow", "cria_frostbite", "tpt_frostbite",
         "conta_wall_sorrow", "destino_final_lvl3", "temporiza_boss_lvl3", "ataques_boss_lvl3", "trigger_fim_lvl3", "destino_final_lvl3",
        "trigger_porta_hold_final_lvl3", "boss_lvl3_particula", "spr_help_2", "spr_casinha_lvl3", "caminho_para_lvl3", "trigger_detecta_zm_fim_lvl3",
        "hitbox_nade_boss_lvl3"]
    },
    {level = "4", entityList = ["trigger_tp_estatua_lvl4", "tp_estatua_lvl4", "indica_lvl4", "spr_help_3", "tp_destino_final_lvl4", "trigger_tp_destino_final_lvl4",
    "destino_lvl_4", "botao_alavanca_porta_A_1", "alavanca_porta_A_1", "porta_A_1", "conta_trigger", "botao_alavanca_porta_B_1", "porta_B_1", "alavanca_porta_B_1", 
    "botao_alavanca_porta_A_2", "alavanca_porta_A_2", "alavanca_porta_A_2", "conta_trigger_2", "porta_B_2", "alavanca_porta_B_2", "botao_alavanca_porta_B_2", "alavanca_porta_B_inner"
    "porta_B_inner", "porta_A_inner", "alavanca_porta_A_inner", "porta_caminho_A", "porta_caminho_B", "trigger_zm_detectado_hold", "parede_fim_boss_lvl4", "previne_push_boss_lvl4", "trigger_colapsos",
    "tp_jail_zm_lvl4", "jail_zm_boss_lvl4", "gravity_boss_lvl4", "trigger_limpa_targetname", "push_boss_lvl4", "trigger_challenger_bossfight", "trigger_ct_vents", "vents_zm_boss_lvl4",
    "nuke_ct", "vidro_jail_zm", "caminho_boss_lvl4_derrotado", "hitbox_nade_boss_lvl4", "hitbox_boss_lvl4", "boss_lvl4_particula",
    "porta_fim_boss_lvl4", "teto_colapso_1", "teto_colapso_2", "conta_trigger_3", "plat_trigger", "shortcut_zm_lvl4", "tp_para_final_lvl4_ct", "trigger_verifica_fim_lvl4",
    "destino_parte_final_lvl4", "random_debris", "random_plat_zm", "plat_1_zm", "destino_plat_zm", "cria_debris_lvl4", "tpt_debris_lvl4", "tp_para_plat_zm",
    "tp_para_plat_zm_final", "destino_parte_final_lvl4_zm", "destino_ct_final_lvl4", "destino_zm_final_lvl4", "add_hp_boss_lvl4", "fecha_arena_boss_lvl4", 
    "localiza_landslide_boss_lvl4", "trigger_quebra_vidro", "vidro_fim_lvl4"]},
    {level = "5", entityList = []}
]

// what should be done for each level
LEVEL_ATTRS <- {
    ["1"] = function(){
        EntFire("tpt_damage_animation", "AddOutput", "origin -912 -3334 3280", 0.00, null);
        EntFire("lasers_tpt", "ForceSpawn", "", 0.02, null);
        EntFire("tpt_miniboss_lvl1", "AddOutput", "origin -912 -3334 3280", 0.00, null);
        EntFire("trigger_fim_lvl1", "Enable", "", 0.00, null);
    },
    ["2"] = function(){
        EntFire("tpt_damage_animation", "AddOutput", "origin -109248 7200 350", 0.00, null);
        EntFire("tp_inicio_aventura", "SetRemoteDestination", "destino_lvl_2_ct", 0.00, null);
        EntFire("tp_inicio_aventura_zm", "SetRemoteDestination", "destino_lvl_2_zm", 0.00, null);
        EntFire("lasers_tpt", "AddOutput", "origin -10847 6888 184", 0.00, null);
        EntFire("lasers_tpt", "ForceSpawn", "", 0.00, null);
        EntFire("tpt_boss_lvl2", "AddOutput", "origin -10848 7200 350", 0.00, null);
        EntFire("spr_help_1", "ShowSprite", "", 0.00, null);
    },
    ["3"] = function(){
        EntFire("tpt_damage_animation", "AddOutput", "origin -7576 -8904 376", 0.00, null);
        EntFire("tp_inicio_aventura", "SetRemoteDestination", "destino_aventura_lvl3", 0.00, null);
        EntFire("tp_inicio_aventura_zm", "SetRemoteDestination", "destino_aventura_lvl3", 0.00, null);
        EntFire("bloqueia_zm_fdp", "Toggle", "", 0.00, null);
        EntFire("trigger_fonte", "Enable", "", 0.00, null);
        EntFire("spr_help_2", "ShowSprite", "", 0.00, null);
        EntFire("spr_casinha_lvl3", "ShowSprite", "", 0.00, null);
        EntFire("areap_lvl3", "Open", "", 0.00, null);
    },
    ["4"] = function(){
        EntFire("tpt_damage_animation", "AddOutput", "origin 8608 -15109 -392", 0.00, null);
        EntFire("tp_inicio_aventura", "SetRemoteDestination", "destino_lvl_4_antesala", 0.00, null);
        EntFire("tp_inicio_aventura_zm", "SetRemoteDestination", "destino_lvl_4_antesala", 0.00, null);
        EntFire("porta_hold_final_lvl3", "Open", "", 0.00, null);
    }
}

function SetLevel(Level) {
    Level_str = Level.tostring();
    EntFire("comandos", "Command", "zr_ambientsounds 0", 0.00, null);
    EntFire("comandos", "Command", "zr_infect_spawntime_max 15", 0.00, null);
    EntFire("comandos", "Command", "zr_infect_spawntime_min 15", 0.00, null);
    EntFire("comandos", "Command", "mp_roundtime 60", 0.00, null);
    EntFire("comandos", "Command", "mp_startmoney 16000", 0.00, null);
    EntFire("comandos", "Command", "sv_falldamage_scale 0", 0.00, null);
    EntFire("comandos", "Command", "mp_freezetime 0", 0.00, null);
    EntFire("comandos", "Command", "mp_warmup_end", 0.00, null);
    EntFire("textura_stage", "SetTextureIndex", ""+(Level - 1).tostring(), 0.00, null);
    EntFire("comandos", "Command", "say ***STAGE "+Level_str+"***", 0.00, null);
    EntFire("tonemap", "SetBloomScale", "1.5", 0.00, null);
    EntFire("colorcorrection", "Enable", "", 0.00, null);
    ParticleWaterfall();
    EntFire("particula_spawn_agua1", "Start", "", 2.00, null);
    EntFire("comandos", "Command", "say MAP BY MK!NG", 2.00, null);
    EntFire("comandos", "Command", "say SPECIAL THANKS TO ZOMBIE RAGE SERVER FOR TESTING/HELPING", 4.00, null);
    EntFire("comandos", "Command", "say ADMIN ROOM LOCATED IN -> 9944 -1927 3028", 6.00, null);
    if(!TESTING_MATERIAS)SpawnMaterias(Level_str);
    if(TESTING_MATERIAS){
        ScriptPrintMessageCenterAll( "MATERIA SPAWN SET TO TESTING!!" );
        SpawnAllMaterias();
    }
    KillEntities(Level_str);
    LEVEL_ATTRS[Level_str]();
    EntFire("tpt_damage_animation", "ForceSpawn", "", 0.02, null);
    PlayMusic();
}

function SpawnMaterias(Level){
    local randomItemPos_ct = null;
    local randomItemLoc_ct = null;
    local materias_len_ct = MATERIAS_CT[Level].len();
    local ent = null;
    foreach(i, elem in COMMON_MATERIA_SPAWN_CT){
        ORIGINS_CT_MATERIAS[Level_str].push(elem);
    }
    for(local i = 0; i < materias_len_ct; i++){
        if(MATERIAS_CT[Level].len() > 1){
            randomItemPos_ct = RandomInt(0, MATERIAS_CT[Level].len() - 1);
        } else {
            randomItemPos_ct = 0;
        }
        if(ORIGINS_CT_MATERIAS[Level].len() > 1){
            randomItemLoc_ct = RandomInt(0, ORIGINS_CT_MATERIAS[Level].len() - 1);
        } else {
            randomItemLoc_ct = 0;
        }
        /*printl(MATERIAS_CT[Level][randomItemPos_ct]);
        printl(" em ");
        printl(ORIGINS_CT_MATERIAS[Level][randomItemLoc_ct]);
        printl("----");*/
        while( ( ent = Entities.FindByName( ent, MATERIAS_CT[Level][randomItemPos_ct] ) ) != null )
        {
            if(ORIGINS_CT_MATERIAS[Level][randomItemLoc_ct] == Vector(-8597, 1425, -1600)){
                EntFire("plat_possivel_materia", "Open", "", 0.00, null);
            }
            ent.SetOrigin(ORIGINS_CT_MATERIAS[Level][randomItemLoc_ct]);
            EntFire(MATERIAS_CT[Level][randomItemPos_ct], "ForceSpawn", "", 0.02, null);
        }
        
        //printl(" matéria "+MATERIAS_CT[Level][randomItemPos]+" spawnada em "+ORIGINS_CT_MATERIAS[Level][randomItemLoc]);
        ORIGINS_CT_MATERIAS[Level].remove(randomItemLoc_ct);
        MATERIAS_CT[Level].remove(randomItemPos_ct);
        
    }

    local randomItemPos_t = null;
    local randomItemLoc_t = null;
    local materias_len_t = MATERIAS_T[Level].len();
    local ent_t = null;
    for(local i = 0; i < materias_len_t; i++){
        if(MATERIAS_T[Level].len() > 1){
            randomItemPos_t = RandomInt(0, MATERIAS_T[Level].len() - 1);
        } else {
            randomItemPos_t = 0;
        }
        if(ORIGINS_T_MATERIAS[Level].len() > 1){
            randomItemLoc_t = RandomInt(0, ORIGINS_T_MATERIAS[Level].len() - 1);
        } else {
            randomItemLoc_t = 0;
        }
        while( ( ent = Entities.FindByName( ent, MATERIAS_T[Level][randomItemPos_t] ) ) != null )
        {
            ent.SetOrigin(ORIGINS_T_MATERIAS[Level][randomItemLoc_t]);
            EntFire(MATERIAS_T[Level][randomItemPos_t], "ForceSpawn", "", 0.02, null);
        }
    
        ORIGINS_T_MATERIAS[Level].remove(randomItemLoc_t);
        MATERIAS_T[Level].remove(randomItemPos_t);
        
    }
}

function KillEntities(Level){
    foreach(i, elem in UNIQUE_ENTITIES){
        if(elem.level != Level){
            foreach(j, ent in elem.entityList){
                EntFire(ent, "Kill", "", 0.00, null);
            }
        }
    }
}
//1 = 1, 0 = boss, 2 = second part
SEGMENT <- 1;

function PlayMusic(){
    if(SEGMENT == 1){
        EntFire("musica_lvl"+Level_str, "PlaySound", "", 1.00, null);
    } else if(SEGMENT == 2){
        EntFire("musica_lvl"+Level_str+"_2", "PlaySound", "", 1.00, null);
    } else {
        EntFire("musica_boss", "PlaySound", "", 1.00, null);
    }
}

ParticleWaterfallPos <- [
    "3232 -9200 673",
    "3232 -9328 673",
    "3232 -9456 673",
    "3232 -9584 673",
    "3232 -9712 673",
    "3232 -9840 673",
    "3232 -9968 673",
    "3232 -10096 673",
    "3232 -10224 673",
    "3232 -10352 673",
    "3232 -10864 673",
    "3232 -10992 673",
    "3232 -11120 673",
    "3232 -11248 673"
]

function ParticleWaterfall(){
    EntFire("cria_particle_waterfall", "ForceSpawn", "", 0.00, null);
    EntFire("particle_waterfall", "Start", "", 0.02, null);
    foreach(i, elem in ParticleWaterfallPos){
        EntFire("cria_particle_waterfall", "AddOutput", "Origin "+elem, 0.02, null);
        EntFire("cria_particle_waterfall", "ForceSpawn", "", 0.02, null);
        EntFire("particle_waterfall", "Start", "", 0.04, null);
    }
}


//used only for testing
function SpawnAllMaterias(){
    foreach(i, elem in MATERIAS_CT["3"]){
        EntFire(elem, "ForceSpawn", "", 0.02, null);
    }
    
    EntFire("speed_zm_tpt", "ForceSpawn", "", 0.02, null);
    EntFire("lure_zm_tpt", "ForceSpawn", "", 0.02, null);
    EntFire("freeze_zm_tpt", "ForceSpawn", "", 0.02, null);
    EntFire("warp_zm_tpt", "ForceSpawn", "", 0.02, null);
}

function Secret(ret){
    if(!ret){
        activator.SetOrigin(Vector(9888, -9424, 453));
        EntFire("som_secret", "PlaySound", "", 0.00, null);
        EntFire("musica_lvl_4", "volume 0.5", "", 0.00, null);
    } else {
        activator.SetOrigin(Vector(8007, -7697, 850));
    }
}