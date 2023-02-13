
Status <- "";

ticking <- false;
tickrate <- 0.1;

cd_use_CAN <- true;
tickrate_use <- 0;

cd_use <- 8.0;
cd_use_d <- cd_use / 17;

stage <- false;
bChek <- false;
bHP_bars8 <- false;
bHP_bars4 <- false;

HP <- 0;
HP_INIT <- 0;
HP_BARS <- 16;
HP_BARS_MAX <- HP_BARS;

Sound   <- null;
bSound <- false;
Reno_Script <- self.GetScriptScope();

function SetCDUse(i)
{
    cd_use = 0.00 + i;
    cd_use_d = i / 17;
}

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
    if(!stage)
    {
        SubtractHP(50);
    }
    else
    {
        SubtractHP(25);
    }

    // NadeCount++
    // NadeTickRate += NadeTime;

    // if(!Stanned)
    // {
    //     if(NadeCount >= NadeNeed)
    //         SetStanned();
    // }
}
function ShootDamage()
{
    SubtractHP(1);
    MainScript.GetScriptScope().GetPlayerClassByHandle(activator).ShootTick(Shoot_OneMoney);
}

function SubtractHP(i)
{
    HP -= i;
}
//Sounds
{
    Sound_Laser1 <- "cosmov6/boss/reno/laser_random1.mp3"; self.PrecacheScriptSound( Sound_Laser1 );
    Sound_Laser2 <- "cosmov6/boss/reno/laser_random2.mp3"; self.PrecacheScriptSound( Sound_Laser2 );
    Sound_Laser3 <- "cosmov6/boss/reno/laser_random3.mp3"; self.PrecacheScriptSound( Sound_Laser3 );
    Sound_Laser4 <- "cosmov6/boss/reno/laser_random4.mp3"; self.PrecacheScriptSound( Sound_Laser4 );
    Sound_Laser5 <- "cosmov6/boss/reno/laser_random5.mp3"; self.PrecacheScriptSound( Sound_Laser5 );
    Sound_Laser6 <- "cosmov6/boss/reno/laser_random6.mp3"; self.PrecacheScriptSound( Sound_Laser6 );
    Sound_Laser7 <- "cosmov6/boss/reno/laser_random7.mp3"; self.PrecacheScriptSound( Sound_Laser7 );
    Sound_Laser8 <- "cosmov6/boss/reno/laser_random8.mp3"; self.PrecacheScriptSound( Sound_Laser8 );
//когда прыгает по камням, сверху звуки убрать
    Sound_LaserF1 <- "cosmov6/boss/reno/last/laser_final_random1.mp3"; self.PrecacheScriptSound( Sound_LaserF1 );
    Sound_LaserF2 <- "cosmov6/boss/reno/last/laser_final_random2.mp3"; self.PrecacheScriptSound( Sound_LaserF2 );
    Sound_LaserF3 <- "cosmov6/boss/reno/last/laser_final_random3.mp3"; self.PrecacheScriptSound( Sound_LaserF3 );
    Sound_LaserF4 <- "cosmov6/boss/reno/last/laser_final_random5.mp3"; self.PrecacheScriptSound( Sound_LaserF4 );
    Sound_LaserF5 <- "cosmov6/boss/reno/last/laser_final_random6.mp3"; self.PrecacheScriptSound( Sound_LaserF5 );
    Sound_LaserF6 <- "cosmov6/boss/reno/last/laser_final_random7.mp3"; self.PrecacheScriptSound( Sound_LaserF6 );
//юз итема
    Sound_Shit <- "cosmov6/boss/reno/last/materia_on_reno.mp3"; self.PrecacheScriptSound( Sound_Shit );
//как снесли 50%
    Sound_Phase1 <- "cosmov6/boss/reno/last/phase2_start_random1.mp3"; self.PrecacheScriptSound( Sound_Phase1 );
    Sound_Phase2 <- "cosmov6/boss/reno/last/phase2_start_random2.mp3"; self.PrecacheScriptSound( Sound_Phase2 );
//как снесли 25%
    Sound_Phase3 <- "cosmov6/boss/reno/last/phase3_start_random1.mp3"; self.PrecacheScriptSound( Sound_Phase3 );
    Sound_Phase4 <- "cosmov6/boss/reno/last/phase3_start_random2.mp3"; self.PrecacheScriptSound( Sound_Phase4 );
    Sound_Phase5 <- "cosmov6/boss/reno/last/phase3_start_random3.mp3"; self.PrecacheScriptSound( Sound_Phase5 );
//как убили в епрвый раз
    Sound_Death1 <- "cosmov6/boss/reno/last/reno_death_random1.mp3"; self.PrecacheScriptSound( Sound_Death1 );
    Sound_Death2 <- "cosmov6/boss/reno/last/reno_death_random2.mp3"; self.PrecacheScriptSound( Sound_Death2 );
//как убили в самом конце
    Sound_Death3 <- "cosmov6/boss/reno/last/reno_final_phase_death.mp3"; self.PrecacheScriptSound( Sound_Death3 );
//проигрываеться в начале
    Sound_Schene1 <- "cosmov6/boss/reno/last/start_schene_phase1_random1.mp3"; self.PrecacheScriptSound( Sound_Schene1 );
    Sound_Schene2 <- "cosmov6/boss/reno/last/start_schene_phase1_random2.mp3"; self.PrecacheScriptSound( Sound_Schene2 );
    Sound_Schene3 <- "cosmov6/boss/reno/last/start_schene_phase1_random3.mp3"; self.PrecacheScriptSound( Sound_Schene3 );
//катсена прыга по камням
    Sound_ScheneF1 <- "cosmov6/boss/reno/last/final_scene_random1.mp3"; self.PrecacheScriptSound( Sound_ScheneF1 );
    Sound_ScheneF2 <- "cosmov6/boss/reno/last/final_scene_random2.mp3"; self.PrecacheScriptSound( Sound_ScheneF2 );
//после оканчания катсены
    Sound_ScheneMove1 <- "cosmov6/boss/reno/last/final_scene_after_movie_random1.mp3"; self.PrecacheScriptSound( Sound_ScheneMove1 );
    Sound_ScheneMove2 <- "cosmov6/boss/reno/last/final_scene_after_movie_random2.mp3"; self.PrecacheScriptSound( Sound_ScheneMove2 );
//фразы во время прыжка, друг за другом все три, если убьют, то фразы останавливаются
    Sound_Jump1 <- "cosmov6/boss/reno/last/final_jump1.mp3"; self.PrecacheScriptSound( Sound_Jump1 );
    Sound_Jump2 <- "cosmov6/boss/reno/last/final_jump2.mp3"; self.PrecacheScriptSound( Sound_Jump2 );
    Sound_Jump3 <- "cosmov6/boss/reno/last/final_jump3.mp3"; self.PrecacheScriptSound( Sound_Jump3 );
//если все сдохли
    Sound_AllDeath1 <- "cosmov6/boss/reno/last/all_death_random1.mp3"; self.PrecacheScriptSound( Sound_AllDeath1 );
    Sound_AllDeath2 <- "cosmov6/boss/reno/last/all_death_random2.mp3"; self.PrecacheScriptSound( Sound_AllDeath2 );
    Sound_AllDeath3 <- "cosmov6/boss/reno/last/all_death_random3.mp3"; self.PrecacheScriptSound( Sound_AllDeath3 );
    Sound_AllDeath4 <- "cosmov6/boss/reno/last/all_death_random4.mp3"; self.PrecacheScriptSound( Sound_AllDeath4 );

    function PlaySound(Name, i, a, time)
    {
        if(i)
            bSound = false;
        if(!bSound)
        {
            if(i == 1){EntFireByHandle(self,"RunScriptCode", "bSound = true;", 0 ,null,null);}
        EntFireByHandle(Sound,"AddOutPut", "message "+Name, 0.00 +time,null,null);
        EntFireByHandle(Sound,"PlaySound", "", 0.05 +time,null,null);

        EntFireByHandle(self,"RunScriptCode", "bSound = false;", 0 +a ,null,null);
        printl("PlaySoundTest: "+Name);
        }
    }
}

lastpos <- "Reno_Path_x6"; //Reno_Path_x1_Array
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

    Reno_Path_x1_Array <- [
        laser_preset(Vector(-12363,-1616,1855), Vector(0,38,0)),
        //laser_preset(Vector(-12363,-1616,1873), Vector(0,38,0)),
        laser_preset(Vector(-12363,-1616,1891), Vector(0,38,0)),];

    Reno_Path_x2_Array <- [
        laser_preset(Vector(-12625,-739,1855), Vector(0,347,0)),
        //laser_preset(Vector(-12625,-739,1873), Vector(0,347,0)),
        laser_preset(Vector(-12625,-739,1891), Vector(0,347,0)),];

    Reno_Path_x3_Array <- [
        laser_preset(Vector(-12145,-56,1855), Vector(0,308,0)),
        //laser_preset(Vector(-12145,-56,1873), Vector(0,308,0)),
        laser_preset(Vector(-12145,-56,1891), Vector(0,308,0)),];

    Reno_Path_x4_Array <- [
        laser_preset(Vector(-11299,7,1855), Vector(0,261,0)),
       // laser_preset(Vector(-11299,7,1873), Vector(0,261,0)),
        laser_preset(Vector(-11299,7,1891), Vector(0,261,0)),];

    Reno_Path_x5_Array <- [
        laser_preset(Vector(-10742,-228,1855), Vector(0,225,0)),
       // laser_preset(Vector(-10742,-228,1873), Vector(0,225,0)),
        laser_preset(Vector(-10742,-228,1891), Vector(0,225,0)),];

    Reno_Path_x6_Array <- [
        laser_preset(Vector(-10294,-927,1855), Vector(0,-180,0)),
      //  laser_preset(Vector(-10294,-927,1873), Vector(0,-180,0)),
        laser_preset(Vector(-10294,-927,1891), Vector(0,-180,0)),];

    Reno_Path_x7_Array <- [
        laser_preset(Vector(-10810,-1671,1855), Vector(0,130,0)),
       // laser_preset(Vector(-10810,-1671,1873), Vector(0,130,0)),
        laser_preset(Vector(-10810,-1671,1891), Vector(0,130,0)),];

    Reno_Path_x8_Array <- [
        laser_preset(Vector(-11568,-2032,1855), Vector(0,84,0)),
      //  laser_preset(Vector(-11568,-2032,1873), Vector(0,84,0)),
        laser_preset(Vector(-11568,-2032,1891), Vector(0,84,0)),];

    Laser_Array <- [

        laser_preset(Vector(-11300,-928,1830), Vector(0,0,0)),
        laser_preset(Vector(-11300,-928,1855), Vector(0,0,0)),
        laser_preset(Vector(-11300,-928,1880), Vector(0,0,0)),
        laser_preset(Vector(-11300,-928,1895), Vector(0,0,0)),
        laser_preset(Vector(-11300,-928,1862), Vector(0,0,9.5)),
        laser_preset(Vector(-11300,-928,1862), Vector(0,0,-9.5)),
    ];
    Laser_Origin <- [
        Vector(-11300,-928,1830), //Нижний
        Vector(-11300,-928,1855), //Нижний
        Vector(-11300,-928,1880), //Средний
    ];
    Laser_Ang <- [
        Vector(0,0,9.5),    //нижний
        Vector(0,0,-9.5),    //слева на право
    ];

    RenoPath <- [
    "Reno_Path_x1",
    "Reno_Path_x2",
    "Reno_Path_x3",
    "Reno_Path_x4",
    "Reno_Path_x5",
    "Reno_Path_x7",
    "Reno_Path_x8",
    ];

    lasereua <- [
    [RenoPath[0], Reno_Path_x1_Array],
    [RenoPath[1], Reno_Path_x2_Array],
    [RenoPath[2], Reno_Path_x3_Array],
    [RenoPath[3], Reno_Path_x4_Array],
    [RenoPath[4], Reno_Path_x5_Array],
    [lastpos, Reno_Path_x6_Array],
    [RenoPath[5], Reno_Path_x7_Array],
    [RenoPath[6], Reno_Path_x8_Array],
    ];
}


function Start()
{
    EntFire("End_Move*", "Open", "", 0);
    Sound = Entities.FindByName(null, "Reno_Sound");
    EntFire("Reno_Name_Bar", "FireUser1", "", 0);
    EntFire("Credits_Game_Text", "AddOutput", "message Reno", 1);
    EntFire("Name_Texture", "AddOutPut", "target Reno_Name_Bar", 1);
    EntFire("Timer_Texture", "AddOutPut", "target Reno_Timer_Bar", 1);
    EntFire("Special_HealthTexture", "AddOutPut", "target Reno_HP_Bar", 1);
    EntFire("Credits_Game_Text", "Display", "", 2)
    EntFire("Reno_Name_Bar", "ShowSprite", "", 3);
    EntFire("Reno_HP_Bar", "ShowSprite", "", 3);
    EntFire("Reno_Timer_Bar", "ShowSprite", "", 3);
    EntFire("Reno_Phys", "SetDamageFilter", "filter_humans", 3);
    EntFire("Reno_Nade", "Enable", "", 3);
    EntFire("Map_Shake", "StartShake", "", 4);
    EntFire("Reno_Model_Effect", "Start", "", 0);
    EntFire("Reno_Model_Effect", "SetParentAttachment", "C_Rob_End", 0);
    EntFireByHandle(self, "RunScriptCode", "Init();", 1, null, null);
}

function Init()
{
    Model = Entities.FindByName(null, "Reno_Final_Model");
    Laser_Maker = Entities.FindByName(null, "Laser_maker");
    ticking = true;
    MainScript.GetScriptScope().Active_Boss = "Reno";
    EntFireByHandle(self, "RunScriptCode", "Tick();", 2, null, null);
    SetHP(100);
    PlaySound(((RandomInt(0,2) == 2) ? Sound_Schene1 : (RandomInt(0,1) == 1) ? Sound_Schene2 : Sound_Schene3), 1, 1, 0);
}

function BossDead()
{
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
    EntFire("EndReno_Shield*", "kill", "", 8);
    ticking = false;
    EntFire("End_Clip", "kill", "", 0);
    EntFire("End_Platform_Trigger", "kill", "", 0);
    EntFire("End_Platform_Move", "FireUser1", "", 5);
    EntFire("Reno_HP_Bar", "HideSprite", "", 0);
    EntFire("Reno_Name_Bar", "HideSprite", "", 0);
    EntFire("Reno_Timer_Bar", "kill", "", 0);
    SetBossAnimation(Anim_Die,0);
    SetBossAnimation(Anim_Die_Idle,1.3);
    EntFire("Reno_Phys", "Disable", "", 0);
    EntFire("Reno_Nade", "Disable", "", 0);
    EntFire("Camera_old", "RunScriptCode", "SpawnCameras(Vector(-10448,-1168,1922),Vector(8,90,0),3.6,Vector(-10100,-928,1976),Vector(8,180,0),6.4,0)", 12);
    SetBossAnimation(Anim_WakeUp,10.4+3);
    SetBossAnimation(Anim_Idle,12.2+3);
    Rotate(180, 15.6, 15.6);
    EntFire("Reno_Final_Move", "MoveToPathNode","Reno_Path_x2", 17, null);
    SetBossAnimation(Anim_Laser1,17);
    SetBossAnimation(Anim_Laser1,19);
    EntFire("Reno_Final_Effect_Maker", "ForceSpawn", "", 17);
    EntFire("Reno_Path_x6", "AddOutPut", "OnPass R_Final_Effect*:Kill::0:1", 0, null);
//    EntFireByHandle(self, "RunScriptCode", "PlaySound((RandomInt(0,1) ? Sound_ScheneF1 : Sound_ScheneF2), 1, 3)", 16);
    PlaySound((RandomInt(0,1) ? Sound_Death1 : Sound_Death2), 1, 1, 0);
    PlaySound((RandomInt(0,1) ? Sound_ScheneF1 : Sound_ScheneF2), 1, 1, 13);
    EntFire("Camera_old", "RunScriptCode", "SetOverLay(Overlay)", 12);
    EntFire("Camera_old", "RunScriptCode", "SetOverLay()", 22);
    EntFire("Reno_Path_x2", "AddOutPut", "OnPass Reno_Final_Move:MoveToPathNode:Reno_Path_x6:0:1", 0, null);
    EntFireByHandle(self, "RunScriptCode", "DeadStart();", 23, null, null);
}

function DeadStart()
{
    MainScript.GetScriptScope().Active_Boss = "Reno";
    HP = 0;
    HP_INIT = 0;
    HP_BARS = 16;
    SetHP(60);
    stage = true;
    ticking = true;
    EntFire("Special_HealthTexture", "SetTextureIndex","0", 0.00);
    EntFireByHandle(self, "RunScriptCode", "Tick();", 1, null, null);
    EntFire("Reno_Final_Move", "FrieUser4", "", 0); //вижен камням
    EntFire("Reno_Final_Move", "FrieUser4", "", 0);
    EntFire("Reno_HP_Bar", "ShowSprite", "", 1);
    EntFire("Reno_Name_Bar", "ShowSprite", "", 1);
    EntFire("Reno_Phys", "Enable", "", 1);
    EntFire("Reno_Nade", "Enable", "", 1);
    EntFire("Reno_Final_Rock_Model_*", "Enable", "", 1);
    EntFire("Reno_Rock_Movelinear", "Open", "", 4);
    EntFireByHandle(self, "RunScriptCode", "NewAttack();", 3, null, null);
    EntFireByHandle(self, "RunScriptCode", "bChek = true;", 20, null, null);
    PlaySound((RandomInt(0,1) ? Sound_ScheneMove1 : Sound_ScheneMove2), 1, 2, 0);
}

function StartMove()
{
    if(RandomInt(0,1))  //направление движения рандомно
    {
        EntFire("Reno_Final_Move", "StartForward", "", 0);
    }
    else
    {
        EntFire("Reno_Final_Move", "StartBackward", "", 0);
    }
    SetBossAnimation(Anim_Laser1);
    EntFire("Reno_Final_Effect_Maker", "ForceSpawn", "", 0);
    EntFire("Reno_Final_Move", "SetSpeed", "2000", 0.2);
    EntFire("Reno_Final_Move", "SetMaxSpeed", "2000", 0.2);
}

function NewAttack()
{
    if(!ticking)return;
    if (!bChek)
    {
        if(RandomInt(0,2)>0)
        {
            EntFireByHandle(self,"RunScriptCode","StartMove();",0,null,null);
            local random = RandomInt(0,RenoPath.len()-1);
            EntFire("Reno_Final_Move", "MoveToPathNode", RenoPath[random], 0, null);
            EntFire(RenoPath[random], "AddOutPut", "OnPass Temp_Reno:runscriptcode:EbashuLaser():0.5:1", 0, null);
            EntFire(RenoPath[random], "AddOutPut", "OnPass R_Final_Effect*:Kill::0:1", 0, null);
            RenoPath.push(lastpos);
            lastpos = RenoPath[random];
            RenoPath.remove(random);
        }
        else
        {
            EntFireByHandle(self,"RunScriptCode","EbashuLaser();",0,null,null);
        }
    }
    else
    {
        if (lastpos == "Reno_Path_x6")
        {
            EntFire("Reno_Final_Move", "MoveToPathNode","Reno_Path_Final_4", 0, null);
            Lose();
        }
        else
        {
            EntFire("Reno_Final_Move", "MoveToPathNode","Reno_Path_x6", 0, null);
            EntFire("Reno_Path_x6", "AddOutPut", "OnPass R_Final_Effect*:Kill::0:1", 0, null);
            EntFire("Reno_Path_x6", "AddOutPut", "OnPass Temp_Reno:runscriptcode:Lose():0:1", 0, null);
        }
    }
}

function EbashuLaser()
{
    if(!ticking)return;

    local id = null;
    local myarray = null;

    if (lastpos == "Reno_Path_x1")
    {
        myarray = Reno_Path_x1_Array.slice();
    }
    else if (lastpos == "Reno_Path_x2")
    {
        myarray = Reno_Path_x2_Array.slice();
    }
    else if (lastpos == "Reno_Path_x3")
    {
        myarray = Reno_Path_x3_Array.slice();
    }
    else if (lastpos == "Reno_Path_x4")
    {
        myarray = Reno_Path_x4_Array.slice();
    }
    else if (lastpos == "Reno_Path_x5")
    {
        myarray = Reno_Path_x5_Array.slice();
    }
    else if (lastpos == "Reno_Path_x6")
    {
        myarray = Reno_Path_x6_Array.slice();
    }
    else if (lastpos == "Reno_Path_x7")
    {
        myarray = Reno_Path_x7_Array.slice();
    }
    else if (lastpos == "Reno_Path_x8")
    {
        myarray = Reno_Path_x8_Array.slice();
    }

    if (myarray == null)
    {
        return;
    }
    id = (RandomInt(0, myarray.len() - 1))
    Laser_Maker.SpawnEntityAtLocation(myarray[id].origin, myarray[id].angles);
    GetRandomAnimationForLaser();
    GetRandomSoundForLaser();
    EntFireByHandle(self,"RunScriptCode","NewAttack();",0.9,null,null);
}

function Lose()
{
    PlaySound(Sound_Jump1, 1, 0.2, 0)
    EntFire("Reno_Path_x6", "ToggleAlternatePath","",1,null);
    EntFire("Reno_Path_Final_*", "ClearParent", "", 0);
    EntFire("Reno_Final_Move", "SetSpeed", "0", 0);
    EntFire("Reno_Final_Move", "SetSpeed", "1200", 1.01);
    EntFire("Reno_Final_Move", "SetMaxSpeed", "1200", 1);
    SetPlayBackRate(0.6,1);
    SetBossAnimation(Anim_Jump);
    EntFireByHandle(self,"RunScriptCode","Chek();",1.7,null,null);
    PlaySound(Sound_Jump3, 1, 1, 2.5)
    //PlaySound(Sound_Jump1);
}

function Chek()
{
    if(!ticking)return;
    if (bChek)
    {
        ticking = false;
        EntFire("End_End", "RunScriptCode", "Nuke(3);", 0);
        EntFire("Reno_HP_Bar", "HideSprite", "", 0);
        EntFire("Reno_Name_Bar", "HideSprite", "", 0);
    }
}

g_vMidle <- Vector(-11500,-924,1830);
g_iPushRadius <- 328;
g_vPushPower <- Vector(500, 500, 400);

function Punch()
{
    local Handle;
    local vVelocity;
    //DebugDrawCircle(g_vMidle, Vector(255,255,255), g_iPushRadius, 12, true, 5);
    while (null != (Handle = Entities.FindInSphere(Handle, g_vMidle, g_iPushRadius)))
    {
        if(!Handle.IsValid())
            continue;

        if(Handle.GetHealth() <= 0)
            continue;

        vVelocity = Handle.GetOrigin() - g_vMidle;
        vVelocity.Norm();

        Handle.SetVelocity(vVelocity.x * g_vPushPower.x,
                                        vVelocity.y * g_vPushPower.y,
                                        g_vPushPower.z);
    }
}

function Tick()
{
//    printl("tick: " + Time());
    if(!ticking)
        return;

    UpDateHP();
    ShowBossStatus();
    ChekAlive();

    if(!stage)
    {
        UpDateCasttime();
        TickUse(); //каст атак
        TickLaser();
    }
    EntFireByHandle(self, "RunScriptCode", "Tick();", tickrate, null, null);
}

function ChekAlive()
{
    if(!ticking)
        return;

    if(CountAlive() <= 0)
    {
        ticking = false;
        GetRandomSoundForAllDead();
        EntFire("map_brush", "RunScriptCode", "Trigger_Lose()", 1);
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

        if(!stage)
        {
            printl("BossDead");
            BossDead();
        }
        else
        {
            bChek = false;
            EntFire("Reno_HP_Bar", "HideSprite", "", 0);
            EntFire("Reno_Name_Bar", "HideSprite", "", 0);
            SetBossAnimation(Anim_Die,0);
            SetBossAnimation(Anim_Die_Idle,1.3);
            EntFire("Reno_Phys", "kill", "", 0);
            EntFire("Reno_Nade", "kill", "", 0);
            PlaySound(Sound_Death3, 1, 1, 0);
            EntFire("End_End","RunScriptCode","Start(2,0)",0);
        }
        MainScript.GetScriptScope().Active_Boss = null;
    }
}

function TickUse()
{
    if(!cd_use_CAN)
        return;
    if(tickrate_use + tickrate >= cd_use)
    {
        tickrate_use = 0;
        Use();
    }
    else tickrate_use += tickrate;
}

function Use()
{
    if(RandomInt(0,1))
        Cast_Heal();
    else
        Cast_Shield();
}

function ShowBossStatus()
{
    if(!ticking)
        return;

    local message;

    message = "[Reno] : Status : " + Status + "\n";
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

    // if(!Stanned)
    // {
    //     if(NadeCount >= NadeShow)
    //     {
    //         local proccent = 0.0 + NadeCount;
    //         message += "\nStanStatus : " + ((proccent / NadeNeed) * 100) + "%";
    //     }
    // }
    // else
    // {
    // message += "\nStanTime : " + (NadeTickRate).tointeger()  ;
    // }

    ScriptPrintMessageCenterAll(message);
}

function ShowBossDeadStatus()
{
    local message;
    message = "[Reno] : Status : Dead\n";

    for(local i = HP_BARS; i < 16; i++)
    {
        message += "◇";
    }

    ScriptPrintMessageCenterAll(message);
}
//Attack
{
    //HEAL
    function Cast_Heal()
    {
//        SetAnimation(Heal_Anim);
        AddHP(CountAlive()*10);
        EntFire("Reno_Final_Heal_Effect", "Start", "", 0);
        EntFire("Reno_Final_Heal_Effect", "Stop", "", 3);
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
        Shield_FullRotate <- 3.0;
        Shield_Count <- [4, 6, 8, 16];
        //Shield_Count <- [8];
        Shield_Health <- 50.0;

        Shield_Rot <- Entities.FindByName(null, "EndReno_Shield_Rotate");
        EntFireByHandle(Shield_Rot, "AddOutPut", "maxspeed " + (360.0 / Shield_FullRotate), 0.00, null, null);

        Shield_Maker  <- Entities.FindByName(null, "EndReno_Shield_Spawner");
        //Shield_Anim <- "attack_hover";

        function RegShield()
        {
            local model = caller;
            local hbox = Entities.FindByName(null, "EndReno_Shield_Hbox" + caller.GetName().slice(caller.GetPreTemplateName().len(),caller.GetName().len()));
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
            //SetAnimation(Shield_Anim);
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
}
cd_laser <- 1.5;
tickrate_laser <- 0;
function TickLaser()
{
    if (HP_BARS == 16)
        cd_laser = 1.5;

    else if (HP_BARS == 14)
        cd_laser = 1.4;

    else if (HP_BARS == 12)
        cd_laser = 1.3;

    else if (HP_BARS == 10)
        cd_laser = 1.2;

    else if (HP_BARS == 8)
    {
        cd_laser = 1.1;
        if(!bHP_bars8)
        {
            PlaySound((RandomInt(0,1) ? Sound_Phase1 : Sound_Phase2), 1, 2, 0);
            bHP_bars8 = true;
        }
    }
    else if (HP_BARS == 6)
        cd_laser = 1;

    else if (HP_BARS == 5)
        cd_laser = 0.95;

    else if (HP_BARS == 4)
        cd_laser = 0.9;

    else if (HP_BARS == 4)
    {
        cd_laser = 0.82;
        if(!bHP_bars4)
        {
            PlaySound((RandomInt(0,2 == 2) ? Sound_Phase3 : ((RandomInt(0,1) == 1) ? Sound_Phase4 : Sound_Phase5)), 1, 3, 0);
            bHP_bars4 = true;
        }
    }
    else if (HP_BARS == 3)
        cd_laser = 0.75;

    else if (HP_BARS == 2)
        cd_laser = 0.7;

    else if (HP_BARS == 1)
        cd_laser = 0.65;

    if(tickrate_laser + tickrate >= cd_laser)
    {
        tickrate_laser = 0;
        LaserAttack();
    }
    else tickrate_laser += tickrate;
}
{
    Laser_Maker <- null;

g_aiLaserForVertRandomInt <- [1, 4];
g_iLaserForVert <- RandomInt(g_aiLaserForVertRandomInt[0], g_aiLaserForVertRandomInt[1]);

g_iLaserCounterForVert <- 0

function LaserAttack()
{
    GetRandomAnimationForLaser();
    GetRandomSoundForLaser();
    GetRandomLaser();
    if (HP_BARS <= 8)
    {
        if (g_iLaserCounterForVert++ >= g_iLaserForVert)
        {
            g_iLaserForVert = RandomInt(g_aiLaserForVertRandomInt[0], g_aiLaserForVertRandomInt[1]);
            g_iLaserCounterForVert = 0;

            SpawnDelayYLaser();
        }
    }
}

function DeadOnLaser()
{
    local min = 50;
    local max = 75;
    local CONS = (max - min) / HP_BARS_MAX; // 60/16=4
    local damage = (HP_BARS_MAX - HP_BARS) * CONS + min;  //(16-10)

    if (!bChek)
    {
        if (damage < min)
        damage = min;
    else if (damage > max)
        damage = max;
    SubtractHP(damage);
    }
    else
    {
       SubtractHP(40);
    }
}

    //Sound     LaserSound_Array.extend(LaserSound_ArrayFinal);
    //          LaserSound_Array.remove(LaserSound_Array.len);
    {
        LaserSoundF_Array <- [
            Sound_LaserF1,
            Sound_LaserF2,
            Sound_LaserF3,
            Sound_LaserF4,
            Sound_LaserF5,
            Sound_LaserF6,
        ]

        LaserSoundF_Array_Backup <- [
            Sound_LaserF1,
            Sound_LaserF2,
            Sound_LaserF3,
            Sound_LaserF4,
            Sound_LaserF5,
            Sound_LaserF6,
        ]

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

        LaserSound_Array_Backup <- [
            Sound_Laser1,
            Sound_Laser2,
            Sound_Laser3,
            Sound_Laser4,
            Sound_Laser5,
            Sound_Laser6,
            Sound_Laser7,
            Sound_Laser8,
        ]

        DeadSound_Array <- [
            Sound_AllDeath1,
            Sound_AllDeath2,
            Sound_AllDeath3,
            Sound_AllDeath4,
        ]

        function GetRandomSoundForLaser()
        {
            local rand;
            if(stage)
            {
                if (LaserSoundF_Array.len() <= 0)
                {
                    LaserSoundF_Array.extend(LaserSoundF_Array_Backup);
                    return;
                }
                else
                {
                    rand = GetRandomSoundID();
                    PlaySound(LaserSoundF_Array[rand], 0 ,0, 0);
                    LaserSoundF_Array.remove(rand);
                }
            }
            else
            {
                if (LaserSound_Array.len() <= 0)
                {
                    LaserSound_Array.extend(LaserSound_Array_Backup);
                    return;
                }

                else
                {
                    if(RandomInt(0,2) == 0)
                    {
                        rand = GetRandomSoundID();
                        PlaySound(LaserSound_Array[rand], 0, 0, 0);
                        LaserSound_Array.remove(rand);
                    }
                }
            }
        }

        function GetRandomSoundID()
        {
            if(!stage)
            {
                return RandomInt(0, LaserSound_Array.len() - 1);
            }
            else
            {
                return RandomInt(0, LaserSoundF_Array.len() - 1);

            }
        }

        function GetRandomSoundForAllDead()
        {
            PlaySound(DeadSound_Array[GetRandomSoundIDForDead()],1,1,0);
        }

        function GetRandomSoundIDForDead()
        {
            return RandomInt(0, DeadSound_Array.len() - 1);
        }

    }
    //Anim
    {
        Anim_Laser1 <- "karateguy";
        Anim_Laser2 <- "attack2";
        Anim_Die <- "die";
        Anim_WakeUp <- "wakeup";
        Anim_Idle <- "idle";
        Anim_Die_Idle <- "die_idle";
        Anim_Jump <- "jumpattack";

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
                local origin = Entities.FindByName(null, "Reno_Final_Model").GetOrigin();
                local handle = null;
                while(null != (handle = Entities.FindByClassnameWithin(handle, "player", origin, 3000)))
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
                y = GetTwoVectYaw(Vector(-11300,-928,1830), array[RandomInt(0, array.len() - 1)].GetOrigin())
            else if(array1.len() > 0)
            {
                y = GetTwoVectYaw(Vector(-11300,-928,1830), array1[RandomInt(0, array1.len() - 1)].GetOrigin())
            }
            Laser_Maker.SpawnEntityAtLocation(Vector(-11300,-928,1830), Vector(180, y, 90));
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
    Model <- null;
    function SetBossAnimation(animationName,time = 0)EntFireByHandle(Model,"SetAnimation",animationName,time,null,null);
}
//Support   Rotate(180, 0, 1);
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

    function Fade_Black(handle)
    {
        EntFire("travel_fade", "Fade", "", 0, handle);
    }
}
