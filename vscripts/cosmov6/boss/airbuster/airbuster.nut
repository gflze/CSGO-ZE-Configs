/*
Script by Kotya[STEAM_1:1:124348087]
update 01.04.2021

　　　　　　　　　　　　　　;' ':;,,　　　　 ,;'':;,
　　　　　　　　　　　　　;'　　 ':;,.,.,.,.,.,,,;'　　';,
　　ー　　　　　　　　 ,:'　　　　　　　　 　::::::::､
　_＿　　　　　　　　,:' ／ 　 　　　　＼ 　　::::::::', oh hell
　　　　　二　　　　:'　 ●　　　　　 ●　 　　 ::::::::i.
　　￣　　　　　　　i　 '''　(__人_)　　'''' 　　 ::::::::::i
　　　　-‐　　　　　 :　 　　　　　　　　　 　::::::::i
　　　　　　　　　　　`:,､ 　　　　　 　 　 :::::::::: /
　　　　／　　　　　　 ,:'　　　　　　　 : ::::::::::::｀:､
　　　　　　　　　　　 ,:'　　　　　　　　 : : ::::::::::｀:､
*/




////////////////////////
//HANDLE
////////////////////////
BossMover <- null;
BossModel <- null;
////////////////////////
//ATTACK CASE
////////////////////////
allow_fire            <- true;
allow_heal            <- true;
allow_wind            <- true;
allow_silence         <- true;
allow_poison          <- true;
allow_minion          <- true;

allow_gravity         <- true;
allow_shield          <- true;

allow_fireNova        <- true;
allow_superattack     <- true;

cancast_fire          <- false;
cancast_heal          <- false;
cancast_wind          <- false;
cancast_silence       <- false;
cancast_poison        <- false;

cancast_gravity       <- false;
cancast_shield        <- false;

cancast_fireNova      <- false;
cancast_superattack   <- false;
////////////////////////
//Smart
////////////////////////
smart_system        <- false;
Status              <- "";

Stanned             <- false;
StanTime            <- 10;
StanDamage          <- 5;
Protect             <- false;


NadeCount <- 0;
NadeNeed <- 10;
NadeShow <- NadeNeed * (20.0 /100);

NadeTickRate <- 0;
NadeTime <- 5;

HP <- 0;
HP_INIT <- 0;
HP_BARS <- 16;

////////////////////////
//ORIGINS
////////////////////////
CenterArea <- Vector(-1888, 5120, 276);
InArena_Radius <- 704;
NearBoss_Radius <- 350;
/*
say **Gi Nattak is using fire**
say **Gi Nattak has healed**  |на 2 уровне доп хп
say **Gi Nattak is using wind**
say **Gi Nattak is using silence**
say **Gi Nattak is using poison**
say **Gi Nattak is using minion**

say **Gi Nattak is using gravity**
say **Gi Nattak is using shield**

say **Gi Nattak is using Fire Nova!!! Get out of middle**
say **GI NATTAK USES LAVA SUPERATTACK**


say **GI NATTAK IS USING ULTIMA. KILL HIM FASTER!!**
*/


//EntFire(string target, string action, "", 0);
ticking <- false;


tickrate <- 0.2;

tickrate_use <- 0;
tickrate_minion <- 0;

cd_use <- 16.0;
cd_use_d <- cd_use / 17;
function SetHP(i)
{
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

function SetCDUse(i)
{
    cd_use = i;
    cd_use_d = i / 17;
}

function AddHP(i)
{
    while(HP + i >= HP_INIT)
    {
        HP_BARS++;
        i -= HP_INIT;
    }
    if(HP_BARS <= 16)
    {
        local id = 16 - HP_BARS;
        EntFire("Special_HealthTexture", "SetTextureIndex", ""+id, 0.00);
    }
    else EntFire("Special_HealthTexture", "SetTextureIndex", "0", 0.00);
    HP += i;
}

function ItemDamage(i)
{
    if(Protect)
        return;

    SubtractHP(i);
}

function NadeDamage()
{
    if(Protect)
        return;

    NadeCount++
    NadeTickRate += NadeTime;

    if(!Stanned)
    {
        if(NadeCount >= NadeNeed)
            SetStanned();
    }

    SubtractHP(80);
}

function SetStanned()
{
    NadeTickRate += StanTime;
    NadeCount = 0;
    Stanned = true;
}

function ShootDamgae()
{
    if(Protect)
        return;

    SubtractHP(1);
}

function SubtractHP(i)
{
    if(Stanned)i *= StanDamage;
    HP -= i;
}

/*

1st 500 * 40 20000
2st 800 * 40 32000
3st 1100 * 40 44000

120

poison heal     300 500 700
fire heal   1bar 2bar 3bar

electro     damage  150 250 350
wind        damage  200 300 400 haste 1 2 3
gravity     damage  300 450 600
bio         damage  600 800 1000     замедляет
ice max     damage  700 1000 1300    останавливает
phoenix     damage  2000
ultimate    damage  3bar 4bar 5bar
*/

function UpDateHP()
{
    if(HP <= 0)
    {
        HP += HP_INIT;
        HP_BARS--;

        if(HP_BARS <= 16)
        {
            local id = 16 - HP_BARS;
            EntFire("Special_HealthTexture", "SetTextureIndex", ""+id, 0.00);
        }

    }
    if(HP_BARS <= 0)
    {
        if(smart_system)Status = "DEAD";
        else Status = "FADE";
        ticking = false;
        BossDead();
    }
}

function UpDateCasttime()
{
    if(!ticking)
        return;


    local id;
    for (local a = 0; a <= 16; a++)
    {
        //id = a * cd_use_d;
        id = (a+1) * cd_use_d;

        if(id >= tickrate_use)
        {
            EntFire("timer_texture", "SetTextureIndex", ""+(a-1), 0.00);
            break;
        }
    }

    // if()
    // {
    //     EntFire("timer_texture", "SetTextureIndex", ""+tickrate_use.tointeger(), 0.00);
    // }

    // if()
    // local id = 0;
    // EntFire("timer_texture", "SetTextureIndex", ""+id, 0.00);
}

function ShowBossStatus()
{
    if(!ticking)
        return;

    if(NadeTickRate > 0)
    {
        NadeTickRate -= tickrate;
        if(NadeTickRate <= 0)
        {
            if(Stanned)
                Stanned = false;
            NadeCount = 0;
            NadeTickRate = 0;
        }
    }

    if(!Stanned)
    {
        if(Protect) Status = "Protected";
        else Status = "Casting";
    }
    else Status = "Stanned[dmg x"+StanDamage+"]";

    local message = "[GI Nattak] : Status : "+Status+"\n";
    for (local i = 1; i <= HP_BARS; i++)
    {
        message += "▰";
    }
    for (local i = HP_BARS; i < 16; i++)
    {
        message += "▱";
    }


    if(!Stanned && NadeCount >=NadeShow)
    {
        local proccent = 0.0 + NadeCount;
        message += "\nStanStatus : "+((proccent / NadeNeed) * 100)+"%";
    }
    ScriptPrintMessageCenterAll(message)
}

function Init()
{
    EntFire("Gi_Nattak_Move", "Open", "", 10.05);
    EntFire("Gi_Nattak_Dark_Push", "SetParent", "Gi_Nattak_Model", 0);
    EntFire("Gi_Nattak_Hurt", "SetParent", "Gi_Nattak_Model", 0);
    EntFire("Gi_Nattak_Nade", "SetParent", "Gi_Nattak_Model", 0);
    EntFire("Gi_Nattak_Phys", "SetParent", "Gi_Nattak_Nade", 0);
    EntFire("Boss_HP_Bar", "SetParent", "Gi_Nattak_Model", 0);
    EntFire("Gi_Nattak_Effect", "SetParent", "Gi_Nattak_Model", 0);
    EntFire("Gi_Nattak_Silence_Effect", "SetParent", "Gi_Nattak_Model", 0);
    EntFire("Gi_Nattak_Heal_Effect", "SetParent", "Gi_Nattak_Model", 0);
    EntFire("Gi_Nattak_Wind_Effect", "SetParent", "Gi_Nattak_Model", 0);
    EntFire("Gi_Nattak_Appear", "SetParent", "Gi_Nattak_Model", 0);
    EntFire("Gi_Nattak_Shield_Effect", "SetParent", "Gi_Nattak_Model", 0);
    EntFire("Gi_Nattak_Dark_Effect", "SetParent", "Gi_Nattak_Model", 0);
    EntFire("Gi_Nattak_Rot1", "Open", "", 10);
    EntFire("GI_Nattak_Rot_Move", "Open", "", 10);
    EntFire("Credits_Game_Text", "AddOutput", "message Gi Nattak", 0);
    EntFire("cmd", "Command", "say **SOME OF YOUR ITEMS CAN DAMAGE THE BOSS**", 12)
    EntFire("Boss_Dicks_Move", "Close", "", 10);
    EntFire("Boss_Push", "Kill", "", 10);
    EntFire("Credits_Game_Text", "Display", "", 10);
    EntFire("cmd", "Command", "say **GRENADES DO A LOT OF DAMAGE. USE THEM!**", 10);
    EntFire("Gi_Nattak_Effect", "Start", "", 10);
    EntFire("Gi_Nattak_Model", "FireUser1", "", 13);
    EntFire("Gi_Nattak_Nade_Explode", "SetParent", "Gi_Nattak_Model", 0);

    EntFire("Name_Texture", "FireUser1", "", 0);
    EntFire("Timer_Texture", "FireUser1", "", 0);
    EntFire("Special_HealthTexture", "FireUser1", "", 0);

    BossModel = Entities.FindByName(null,"Gi_Nattak_Model");
}

function InitEnd()
{
    EntFire("Boss_HP_Bar", "ShowSprite", "", 0.01);
    EntFire("Boss_Name_Bar", "ShowSprite", "", 0.01);
    EntFire("Boss_Timer_Bar", "ShowSprite", "", 0.01);

    EntFire("Gi_Nattak_Background_Fire", "Start", "", 0);
    EntFire("Gi_Nattak_Model", "SetParent", "GI_Nattak_Rot1", 0.01);
    EntFire("Gi_Nattak_Model", "ClearParent", "", 0);

    EntFire("Gi_Nattak_Nade", "Enable", "", 0);
    EntFire("Gi_Nattak_Phys", "SetDamageFilter", "filter_humans", 0);


    SetHP(1000);
    StartTick();

    EntFireByHandle(self, "RunScriptCode", "UseUltima()", 120, null, null);
}


function StartTick()
{
    ticking = true;
    Tick();
}

function Tick()
{
    if(!ticking)
        return;

    TickUse();
    TickMinion();
    UpDateCasttime();

    UpDateHP();
    ShowBossStatus();
    DrawTriggers();

    EntFireByHandle(self, "RunScriptCode", "Tick()", tickrate, null, null);
}

function TickUse()
{
    if(tickrate_use + tickrate >= cd_use)
    {
        tickrate_use = 0;
        if(!smart_system)
            Use();
        else
            UseSmart();
        GetRandomAnimation();
    }
    else tickrate_use += tickrate;
//     ScriptPrintMessageCenterAll(
// (tickrate_use + tickrate)+" >= "+cd_use);
}

use_array <- [];

function Use()
{
    if(use_array.len() <= 0)
    {
        if(allow_fire)
            cancast_fire = true;

        if(allow_heal)
            cancast_heal = true;

        if(allow_wind)
            cancast_wind = true;

        if(allow_silence)
            cancast_silence = true;

        if(allow_gravity)
            cancast_gravity = true;

        if(allow_shield)
            cancast_shield = true;

        if(allow_fireNova)
            cancast_fireNova = true;

        if(allow_superattack)
            cancast_superattack = true;
    }

    if(cancast_fire)
        use_array.push("Fire");
    if(cancast_heal)
        use_array.push("Heal");
    if(cancast_wind)
        use_array.push("Wind");
    if(cancast_silence)
        use_array.push("Silence");
    if(cancast_gravity)
        use_array.push("Gravity");
    if(cancast_shield)
        use_array.push("Shiled");
    if(cancast_fireNova)
        use_array.push("FireNova");
    if(cancast_superattack)
        use_array.push("SuperAttack");

    local use_random_index = RandomInt(0, use_array.len() - 1);

    ScriptPrintMessageChatAll("Use"+use_array[use_random_index]+"();");
    EntFireByHandle(self, "RunScriptCode", "Use"+use_array[use_random_index]+"();", 0, null, null);
    use_array.remove(use_random_index);
}

function UseSmart()
{

}

function UseFire()
{
    //cancast_fire = false;


    ScriptPrintMessageChatAll("UseFire");
    EntFire("Gi_Nattak_Fire_Sound", "PlaySound", "", 0);

    EntFire("Gi_Nattak_Fire_Hurt", "Enable", "", 0);
    EntFire("Gi_Nattak_Fire_Effect", "Start", "", 0);

    EntFire("Gi_Nattak_Fire_Effect", "Stop", "", 3.5);
    EntFire("Gi_Nattak_Fire_Hurt", "Disable", "",  3.5);
    //EntFire(cmd Command say **Gi Nattak is using fire** 0)
}

function UseHeal()
{
    cancast_heal = false;

    ScriptPrintMessageChatAll("UseHeal");
    EntFire("Gi_Nattak_Heal_Sound", "PlaySound", "", 0);

    EntFire("Gi_Nattak_Heal_Effect", "Start", "", 0);
    EntFire("Gi_Nattak_Heal_Effect", "Stop", "", 3);

    local hp = ((50 * CountAlive()) / 7).tostring();

    EntFireByHandle(self, "RunScriptCode", "AddHP("+hp+")", 0.5, null, null);
    EntFireByHandle(self, "RunScriptCode", "AddHP("+hp+")", 1, null, null);

    EntFireByHandle(self, "RunScriptCode", "AddHP("+hp+")", 1.5, null, null);
    EntFireByHandle(self, "RunScriptCode", "AddHP("+hp+")", 2, null, null);

    EntFireByHandle(self, "RunScriptCode", "AddHP("+hp+")", 2.5, null, null);
    EntFireByHandle(self, "RunScriptCode", "AddHP("+hp+")", 3, null, null);
    //test
    //EntFire("Special_Health", "Add", 600 0);

    //EntFire(cmd Command say **Gi Nattak has healed** 0);
}

//test
function UseWind()
{
    cancast_wind = false;

    ScriptPrintMessageChatAll("UseWind");
    EntFire("Gi_Nattak_Wind_Sound", "PlaySound", "", 0);

    EntFire("Gi_Nattak_Wind_Push", "Enable", "", 1.25);
    EntFire("Gi_Nattak_Wind_Push", "Disable", "", 4.75);

    EntFire("Gi_Nattak_Wind_Flow", "Start", "", 0);
	EntFire("Gi_Nattak_Wind_Flow", "Stop", "", 4.5);

	EntFire("Gi_Nattak_Wind_Effect", "Start", "", 0);
    EntFire("Gi_Nattak_Wind_Effect", "Stop", "", 4.75);

    //EntFire("cmd Command say **Gi Nattak is using wind** 0);
}

function UseSilence()
{
    cancast_silence = false;

    ScriptPrintMessageChatAll("UseSilence");
    EntFire("Gi_Nattak_Silence_Effect", "Stop", "", 15);
    EntFire("Gi_Nattak_Silence_Effect", "Start", "", 0);
    EntFire("map_brush", "RunScriptCode", "UseSilence(15)", 0);
    //Звук сайленса
    //EntFire("cmd Command say **Gi Nattak is using silence** 0);
}
/*Minion
35 - 50
30 - 38
25 - 35
*/

function UsePoison()
{
    cancast_poison = false;

    ScriptPrintMessageChatAll("UsePoison");
}

minion_use <- RandomInt(15, 20);
function TickMinion()
{
    if(tickrate_minion + tickrate >= minion_use)
    {
        minion_use = RandomInt(15, 20);
        tickrate_minion = 0;
        UseMinion();
    }
    else tickrate_minion += tickrate;
}

RightMinion <- true;
LeftMinion <- true;

function UseMinion()
{
    if(!RightMinion && !LeftMinion)
        return;

    local origin;
    if(RightMinion && LeftMinion)
    {
        if(RandomInt(0,1))
        {
            RightMinion = false;
            EntFireByHandle(self, "RunScriptCode", "RightMinion = true;", 20, null, null);

            origin = BossModel.GetOrigin() + Vector(0, 0, 500) + (BossModel.GetLeftVector() * -235);
        }
        else
        {
            LeftMinion = false;
            EntFireByHandle(self, "RunScriptCode", "LeftMinion = true;", 20, null, null);

            origin = BossModel.GetOrigin() + Vector(0, 0, 500) + (BossModel.GetLeftVector() * 235);
        }
    }
    else if(RightMinion)
    {
        RightMinion = false;
        EntFireByHandle(self, "RunScriptCode", "RightMinion = true;", 20, null, null);

        origin = BossModel.GetOrigin() + Vector(0, 0, 500) + (BossModel.GetLeftVector() * -235);
    }
    else
    {
        LeftMinion = false;
        EntFireByHandle(self, "RunScriptCode", "LeftMinion = true;", 20, null, null);

        origin = BossModel.GetOrigin() + Vector(0, 0, 500) + (BossModel.GetLeftVector() * 235);
    }

    EntFire("Minion_Temp", "AddOutPut", "origin "+origin.x+" "+origin.y+" "+origin.z, 0);
    EntFire("Minion_Temp", "ForceSpawn", "", 0.02);

    ScriptPrintMessageChatAll("UseMinion");
}

//Gravity
function UseGravity()
{
    cancast_gravity = false;

    EntFire("Gi_Nattak_Dark_Push", "Enable", "", 1.25);
    EntFire("Gi_Nattak_Dark_Push", "Disable", "", 4.75);

    EntFire("Gi_Nattak_Dark_Effect", "Start", "", 0);
	EntFire("Gi_Nattak_Dark_Effect", "Stop", "", 4.5);

    ScriptPrintMessageChatAll("UseGravity");
}

//Shield
function UseShiled()
{
    cancast_shield = false;

    ScriptPrintMessageChatAll("UseShiled");

    EntFire("Gi_Nattak_Shield_Effect", "Start", "", 0);
	EntFire("Gi_Nattak_Shield_Effect", "Stop", "", 9.5);

    EntFireByHandle(self, "RunScriptCode", "Protect = true;", 0.5, null, null);
    EntFireByHandle(self, "RunScriptCode", "Protect = false;", 10, null, null);
}

//FireNova

function UseFireNova()
{
    cancast_fireNova = false;

    ScriptPrintMessageChatAll("UseFireNova");
   	EntFire("Map_Shake", "StartShake", "", 0);

	EntFire("Gi_Nattak_Nova_Hurt", "Enable", "", 5);
    EntFire("Gi_Nattak_Nova_Hurt", "Disable", "", 8);

	EntFire("Gi_Nattak_Nova_Effect", "Start", "", 0);
    EntFire("Gi_Nattak_Nova_Effect", "Stop", "", 8);

    EntFire("Gi_Nattak_Fire_Sound", "PlaySound", "", 5);

	//EntFire(cmd Command say **Gi Nattak is using Fire Nova!!! Get out of middle** 0);
}

function UseSuperAttack()
{
    cancast_superattack = false;

    ScriptPrintMessageChatAll("UseSuperAttack");
    EntFireByHandle(self, "RunScriptCode", "GetRockForSuperattack()", 0, null, null);
    EntFireByHandle(self, "RunScriptCode", "GetRockForSuperattack()", 0.1, null, null);


    EntFire("Gi_Nattak_Background_Fire", "Start", "", 0);
    EntFire("Gi_Nattak_Background_Fire", "Stop", "", 15);


    EntFire("Gi_Nattak_Superattack_Effect", "Start", "", 0);
    EntFire("Gi_Nattak_Superattack_Effect", "Kill", "", 15);

    EntFire("Gi_Nattak_Superattack_Move", "Open", "", 0);
    EntFire("Gi_Nattak_Superattack_Move" "Kill", "", 15);


    EntFire("Gi_Nattak_Superattack_Hurt", "Enable", "", 0);
    EntFire("Gi_Nattak_Superattack_Hurt", "Kill", "", 15);


    EntFire("Boss_Timer_Bar", "HideSprite", "", cd_use);
    EntFire("Boss_Timer_Bar", "ShowSprite", "", cd_use);


    //EntFire(cmd Command say **GI NATTAK USES LAVA SUPERATTACK** 0);
    //EntFire(cmd Command say **Get on the rocks to get saved!!!** 1);
}
Rock_array <- ["1","2","3","4","5"];
function GetRockForSuperattack()
{
    local rock_random_index = RandomInt(0, Rock_array.len() - 1);

    EntFire("Gi_Nattak_Superattack_Move_"+Rock_array[rock_random_index], "Open");

    Rock_array.remove(rock_random_index);
}

IdleAnim <- "idle";
Attack1Anim <- "attack1";
Attack2Anim <- "attack2";
Attack3Anim <- "attack3";

function GetRandomAnimation()
{
    switch (RandomInt(0,2))
    {
        case 0:
        {
            SetBossAnimation(Attack1Anim);
            SetBossAnimation(IdleAnim,3.3);
        }
        break;

        case 1:
        {
            SetBossAnimation(Attack2Anim);
            SetBossAnimation(IdleAnim,4.55);
        }
        break;

        case 2:
        {
            SetBossAnimation(Attack3Anim);
            SetBossAnimation(IdleAnim,5.25);
        }
        break;
    }
}

function SetBossAnimation(animationName,time = 0)
{
	EntFireByHandle(BossModel,"SetAnimation",animationName,time,null,null);
}
function UseUltima()
{
    if(!ticking)
        return;
   	EntFire("Gi_Nattak_Ultima_Hurt", "Enable", "", 15);
   	EntFire("Map_Fade", "Fade", "", 15);
   	EntFire("Gi_Nattak_Ultima_Sound", "PlaySound", "", 15);
   	EntFire("Map_Shake", "StartShake", "", 13);
   	EntFire("Map_Shake", "StartShake", "", 8);
   	EntFire("Gi_Nattak_Fire*", "Kill", "", 0);
   	EntFire("Gi_Nattak_Heal*", "Kill", "", 0);
   	EntFire("Gi_Nattak_Wind*", "Kill", "", 0);
   	EntFire("Gi_Nattak_Dark*", "Kill", "", 0);
   	EntFire("Map_Shake", "StartShake", "", 0);
   	EntFire("Gi_Nattak_Ultima_Effect", "Start", "", 0);
   	EntFire("cmd", "Command", "say **GI NATTAK IS USING ULTIMA. KILL HIM FASTER!!**", 0);
}

function BossDead()
{
    local message = "[GI Nattak] : Status "+Status+"\n";
    for (local i = 1; i <= 16; i++)
    {
        message += "▱";
    }
    ScriptPrintMessageCenterAll(message)

    EntFire("Map_Shake_7_Sec", "StartShake", "", 12);

    EntFire("cmd", "Command", "say **Now you can get out of Cave of Gi**", 6.5);
    EntFire("Boss_Cage", "Kill", "", 6.5);
    EntFire("Skip_Wall", "Toggle", "", 5);
    EntFire("stage1_relay_end", "Trigger", "", 5);
    EntFire("Boss_ZM_Dicks_Move", "Open", "", 5);

    EntFire("Boss_Timer_Bar", "Kill", "", 0);
    EntFire("Boss_Name_Bar", "Kill", "", 0);

    EntFire("Gi_Nattak_Model", "FireUser2", "", 0);


    EntFire("Gi_Nattak_Nova*", "Kill", "", 0);
    EntFire("Gi_Nattak_Dark*", "Kill", "", 0);
    EntFire("Gi_Nattak_Fire*", "Kill", "", 0);
    EntFire("Gi_Nattak_Wind*", "Kill", "", 0);
    EntFire("Gi_Nattak_Heal*", "Kill", "", 0);

    EntFire("Map_Shake", "StartShake", "", 0);
    EntFire("Hold_End_Trigger", "Enable", "", 0);
    EntFire("Boss_Dicks_Move", "Open", "", 0);
    EntFire("Gi_Nattak_Superattack*", "Kill", "", 0);
    EntFire("Boss_HP_Bar", "Kill", "", 0);
    EntFire("Hold6_Rock", "Kill", "", 0);
    EntFire("Normal_End_Wall", "Toggle", "", 5);
    EntFire("Normal_Crates_End", "Enable", "", 5);
    EntFire("Map_TP_5", "Disable", "", 0);
    EntFire("Map_TP_4", "Disable", "", 0);
    EntFire("Normal_End_Trigger", "Enable", "", 5);
}

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

function MidleHp(TEAM = 3)
{
	local handle = null;
	local counter = 0;
	local hp = 0;
	while(null != (handle = Entities.FindByClassname(handle,"player")))
	{
		if(handle.GetTeam() == TEAM && handle.GetHealth() > 0)
		{
			hp += handle.GetHealth();
			counter++;
		}
	}
	return hp / counter;
}

function InArena(TEAM = 3)
{
	local handle = null;
	local counter = 0;
	while (null != (handle = Entities.FindInSphere(handle , CenterArea, InArena_Radius)))
	{
		if(handle.GetTeam() == TEAM && handle.GetHealth() > 0)counter++;
	}
	return counter;
}

function OutArena(TEAM = 3)return CountAlive(TEAM) - InArena(TEAM);

function NearBoss(TEAM = 3)
{
	local handle = null;
	local counter = 0;
	while (null != (handle = Entities.FindInSphere(handle , BossModel.GetOrigin(), NearBoss_Radius)))
	{
		if(handle.GetTeam() == TEAM && handle.GetHealth() > 0)counter++;
	}
	return counter;
}

function DrawTriggers()
{
    local ent = null;
    ent = Entities.FindByName(null, "Gi_Nattak_Phys");
    DrawBoundingBox(ent);
    ent = Entities.FindByName(null, "Gi_Nattak_Nade");
    DrawBoundingBox(ent);
    ent = Entities.FindByName(null, "Gi_Nattak_Dark_Push");
    DrawBoundingBox(ent);
}

function DrawBoundingBox(ent)
{
    local origin = ent.GetOrigin();

    local max = ent.GetBoundingMaxs();
    local min = ent.GetBoundingMins();

    local rV = ent.GetLeftVector();
    local fV = ent.GetForwardVector();
    local uV = ent.GetUpVector();

    local TFR = origin + uV * max.z + rV * max.y + fV * max.x;
    local TFL = origin + uV * max.z + rV * min.y + fV * max.x;

    local TBR = origin + uV * max.z + rV * max.y + fV * min.x;
    local TBL = origin + uV * max.z + rV * min.y + fV * min.x;

    local BFR = origin + uV * min.z + rV * max.y + fV * max.x;
    local BFL = origin + uV * min.z + rV * min.y + fV * max.x;

    local BBR = origin + uV * min.z + rV * max.y + fV * min.x;
    local BBL = origin + uV * min.z + rV * min.y + fV * min.x;


    DebugDrawLine(TFR, TFL, 0, 0, 255, true, tickrate + 0.01);
    DebugDrawLine(TBR, TBL, 0, 0, 255, true, tickrate + 0.01);

    DebugDrawLine(TFR, TBR, 0, 0, 255, true, tickrate + 0.01);
    DebugDrawLine(TFL, TBL, 0, 0, 255, true, tickrate + 0.01);

    DebugDrawLine(TFR, BFR, 0, 0, 255, true, tickrate + 0.01);
    DebugDrawLine(TFL, BFL, 0, 0, 255, true, tickrate + 0.01);

    DebugDrawLine(TBR, BBR, 0, 0, 255, true, tickrate + 0.01);
    DebugDrawLine(TBL, BBL, 0, 0, 255, true, tickrate + 0.01);

    DebugDrawLine(BFR, BBR, 0, 0, 255, true, tickrate + 0.01);
    DebugDrawLine(BFL, BBL, 0, 0, 255, true, tickrate + 0.01);

    DebugDrawLine(BFR, BFL, 0, 0, 255, true, tickrate + 0.01);
    DebugDrawLine(BBR, BBL, 0, 0, 255, true, tickrate + 0.01);
}