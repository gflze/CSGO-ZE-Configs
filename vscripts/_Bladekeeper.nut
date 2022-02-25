//--BLADEKEEPER ANIMATIONS--\\
Sit <- "Sit_Idle";
Walk <- "Walk";
Run <- "run";
Falling <- "falling";
Dying <- "dying_from_front";
Idle <- "idle";
Idle2 <- "Idle_2";
StandIdle <- "Stand_Idle";
Threat <- "dullahan_threat";
NegateDamage <- "dullahan_ghost_escape";
SpecialWide <- "dullahan_attack_sword_wide_special";
Swing360 <- "dullahan_attack_swing360";
IceboltStart <- "dullahan_attack_icebolt_right";
IceboltDuring <- "dullahan_attack_icebolt_during";
IceboltEnd <- "dullahan_attack_icebolt_end";
Combo2 <- "dullahan_attack_2combo";
Combo3 <- "dullahan_attack_3combo";
ParryOne <- "parry_one";
Collapse <- "collapse";

//--------Variables--------\\
canAttack <- true;

canBeParried <- false;
isParried<- false;

walkSpeed <- 0.45;
runSpeed <- 0.68;
phase3Speed <- 0.80;
defaultTurnSpeed <- 0.55;

PHASE <- 1;

playMusic <- true;

bladekeeperHealth <- null;

damageMultiplier <- 2;

bossDetector <- null;
function SetBossDetector(){bossDetector=caller}

Phase1Attacks <- null;
function SetPhase1Attacks(){Phase1Attacks=caller}

Phase2Attacks <- null;
function SetPhase2Attacks(){Phase2Attacks=caller}

Phase3Attacks <- null;
function SetPhase3Attacks(){Phase3Attacks=caller}

BossMover <- null;
function SetMover(){BossMover=caller}

SwordSwingCase <- null;//not in use currently.
function SetSwordSwingCase(){SwordSwingCase=caller}

maxPhase4Hits <- 12;

phase4HitsCount <- 0;

//-------------------------\\

//--SWORD ANIMATIONS--\\
SwordOn <- "sword_on";
SwordOff <- "sword_off";

NormalAngles <- "90 0 0";
ParryAngles <- "0 90 90";

FirstSword <- null;
function SetFirstSword(){FirstSword=caller} 
FirstSword2 <- null;
function SetFirstSword2(){FirstSword2=caller}

FirstSwordParrySword <- null;
function SetFirstSwordParrySword(){FirstSwordParrySword=caller} 

FirstSwordParrySwordMover <- null;
function SetFirstSwordParrySwordMover(){FirstSwordParrySwordMover=caller} 

SwordBreakEffect <- null;
function SetSwordBreakEffect(){SwordBreakEffect=caller};

SwordSpawnEffect <- null;
function SetSwordSpawnEffect(){SwordSpawnEffect=caller};

CollisionOneSpawner <- null;
function SetCollisionOneSpawner(){CollisionOneSpawner=caller}



//-------------------------\\

function Start()
{
	bladekeeperHealth = Entities.FindByName(null, "bladekeeper_healthbar")
	EntFireByHandle(bladekeeperHealth, "RunScriptCode", "Start()", 11.0, null, null)
	
	EntFireByHandle(SwordSpawnEffect, "SetParentAttachment", "ValveBiped.Anim_Attachment_RH", 0.0, null, null)
	EntFireByHandle(SwordBreakEffect, "SetParentAttachment", "ValveBiped.Anim_Attachment_RH", 0.0, null, null)
	EntFire("voice_bladekeeper_gained_enough", "PlaySound", null, 0.01, null)
	EntFire("bladekeeper_i_start_particles", "Start", null, 5.0, null)
	EntFire("EntitiesMaker", "runscriptcode", "CreateBladekeeperSkyboxStatueParticles()", 5.0, null)
	EntFire("bladekeeper_i_start_particles_explode", "Start", null, 7.00, null)
	EntFire("bladekeeper_i_start_fade", "Fade", null, 7.00, null)
	EntFire("bladekeeper_i_start_fade", "FadeReverse", null, 8.50, null)
	
	EntFire("bladekeeper_i_cape_particles", "Start", null, 10, null)
	//Add SFX
	EntFire("bladekeeper_i_start_particles_explode", "Kill", null, 9, null)
	EntFire("bladekeeper_i_start_particles", "Kill", null, 10, null)
	
	if(playMusic)
		EntFire("Finale_LoopMusicManager", "RunScriptCode", "LoopMusic(4,5,64)", 5, null)

	EntFireByHandle(FirstSwordParrySwordMover,"Open","",0.05,null,null)
	EntFireByHandle(self,"SetDefaultAnimation",Idle2,7.55,null,null)
	EntFireByHandle(self,"SetAnimation",Idle2,7.60,null,null)
	EntFireByHandle(FirstSword, "SetParentAttachment", "ValveBiped.Anim_Attachment_RH", 7.61, null, null)
	EntFireByHandle(FirstSword, "AddOutPut", "angles "+NormalAngles, 7.62, null, null)
	EntFireByHandle(FirstSword2, "SetParentAttachment", "ValveBiped.Anim_Attachment_RH", 7.61, null, null)
	EntFireByHandle(FirstSword2, "AddOutPut", "angles "+NormalAngles, 7.62, null, null)


	EntFireByHandle(FirstSword, "Enable", "", 7, null, null)
	EntFire("bladekeeper_i_dummy_sword*", "Kill", null, 7, null)

	EntFireByHandle(self,"SetDefaultAnimation",Walk,10.80,null,null)
	EntFireByHandle(self,"SetAnimation",Walk,11,null,null)

	EntFireByHandle(BossMover,"RunScriptCode","Start();",11.1,null,null)
	EntFireByHandle(bossDetector,"Enable","",11.4,null,null)
	SetBossSpeed(walkSpeed)
}


function Attack()
{
	if(!canAttack)
		return;

	if(canAttack)
	{
		canAttack = false;
		
		if(PHASE == 1)
		{
			EntFireByHandle(Phase1Attacks,"PickRandomShuffle","",0.01,null,null);
		}
		else if(PHASE == 2)
		{
			EntFireByHandle(Phase2Attacks,"PickRandomShuffle","",0.01,null,null);
		}
		else if(PHASE == 3)
		{
			EntFireByHandle(Phase3Attacks,"PickRandomShuffle","",0.01,null,null);
		}
	}
}


function SetBossSpeed(newSpeed)
{
	EntFireByHandle(BossMover,"RunScriptCode","SPEED_FORWARD = "+newSpeed.tostring(),0.0,null,null)
	if(newSpeed==0.1 || 0)
		EntFireByHandle(BossMover,"RunScriptCode","SPEED_TURNING = "+newSpeed.tostring(),0.0,null,null)
	else
		EntFireByHandle(BossMover,"RunScriptCode","SPEED_TURNING = "+defaultTurnSpeed.tostring(),0.0,null,null)
}


function CancelAttacks()
{
	if(PHASE == 1)
	{
		EntFire("bladekeeper_i_phase1_attack1_relay", "CancelPending", null, 0.0, null);
		EntFire("bladekeeper_i_phase1_attack2_relay", "CancelPending", null, 0.0, null);
		EntFire("bladekeeper_i_phase1_attack3_relay", "CancelPending", null, 0.0, null);
	}
	else if(PHASE == 2)
	{
		EntFire("bladekeeper_i_phase2_attack1_relay", "CancelPending", null, 0.0, null);
		EntFire("bladekeeper_i_phase2_attack2_relay", "CancelPending", null, 0.0, null);
		EntFire("bladekeeper_i_phase2_attack3_relay", "CancelPending", null, 0.0, null);
		EntFire("bladekeeper_i_phase2_attack4_relay", "CancelPending", null, 0.0, null);
		EntFire("bladekeeper_i_phase2_attack_beams", "CancelPending", null, 0.0, null);
		EntFire("bladekeeper_i_beam_particles_SFX", "Volume", "0", 0.0, null);
		EntFire("bladekeeper_i_beam_particles_*", "Stop", null, 0.0, null);
		
		
	}
	else if(PHASE == 3)
	{
		EntFire("bladekeeper_i_phase3_attack1_relay", "CancelPending", null, 0.0, null);
		EntFire("bladekeeper_i_phase3_attack2_relay", "CancelPending", null, 0.0, null);
		EntFire("bladekeeper_i_phase3_attack3_relay", "CancelPending", null, 0.0, null);
		EntFire("bladekeeper_i_phase3_attack4_relay", "CancelPending", null, 0.0, null);
		EntFire("bladekeeper_i_phase3_attack_beams", "CancelPending", null, 0.0, null);
		EntFire("bladekeeper_i_beam_particles_SFX", "Volume", "0", 0.0, null);
		EntFire("bladekeeper_i_beam_golden_particles_*", "Stop", null, 0.0, null);
	}
	EntFire("bladekeeper_i_hurt_*", "Disable", null, 0.0, null);
}


function SetParryState(duration)
{
	CancelAttacks()
	canBeParried = false;
	isParried = true;
	SetBossSpeed(0.1)
	if(true /*PHASE==1 ||  PHASE==2*/)
	{
		FirstSword2.SetAngles(0, 90, 90)
		EntFireByHandle(FirstSword, "Disable", "", 0.0, null, null)
		EntFireByHandle(FirstSword2, "Enable", "", 0.0, null, null)
		EntFireByHandle(CollisionOneSpawner, "ForceSpawn", "", 0.4, null, null)
		
	}
	EntFireByHandle(FirstSwordParrySwordMover,"Close","",0.02,null,null)
	EntFireByHandle(self,"SetAnimation",ParryOne,0,null,null)
	EntFireByHandle(self,"RunScriptCode","SetNormalState()",duration,null,null)

	// maybe put this in a relay later?
	EntFire("bladekeeper_i_SFX_stagger_1*", "PlaySound", null, 5.75, null)
	if(PHASE == 3)
	{
		EntFire("bladekeeper_i_sword_particles", "Stop", null, 5.77, null)
		EntFireByHandle(FirstSword, "SetAnimation", "idle", 6.52, null, null)
	}
	EntFireByHandle(FirstSword2, "Disable", "", 5.77, null, null)//5.68
	EntFireByHandle(SwordBreakEffect, "ForceSpawn", "", 5.77, null, null)

	EntFireByHandle(FirstSword, "Enable", "", 6.51, null, null)
	EntFireByHandle(FirstSword, "SetGlowEnabled", "", 6.51, null, null)
	EntFireByHandle(SwordSpawnEffect, "ForceSpawn", "", 6.51, null, null)
	EntFireByHandle(FirstSword, "SetGlowDisabled", "", 8.51, null, null)
}

function SetNormalState()
{
	EntFireByHandle(self,"SetAnimation",Idle2,0.0,null,null)
	EntFireByHandle(FirstSwordParrySwordMover,"Open","",0.02,null,null)

	if(PHASE==1)
	{
		EntFireByHandle(self,"SetAnimation",Walk,0.5,null,null)
		EntFireByHandle(self,"RunScriptCode","SetBossSpeed("+walkSpeed.tostring()+")",0.6,null,null)
		//---------------------------------
		canAttack=true;
	}
	else if (PHASE == 2)
	{
		EntFireByHandle(self,"SetAnimation",Run,0.5,null,null)
		EntFireByHandle(self,"RunScriptCode","SetBossSpeed("+runSpeed.tostring()+")",0.6,null,null)
		//---------------------------------
		canAttack=true;
	}
	else if (PHASE == 3)
	{
		EntFireByHandle(self,"SetAnimation",Run,0.5,null,null)
		EntFireByHandle(self,"RunScriptCode","SetBossSpeed("+phase3Speed.tostring()+")",0.6,null,null)
	}

	EntFireByHandle(self,"RunScriptCode","isParried=false;",0.7,null,null)
	EntFireByHandle(self,"RunScriptCode","canAttack=true;",0.7,null,null)
	
}

function TriggerPhase2()
{
	CancelAttacks()
	bladekeeperHealth.GetScriptScope().canTakeDamage = false;
	EntFireByHandle(Phase1Attacks,"Kill","",0.0,null,null)
	canAttack = false;
	EntFireByHandle(self,"RunScriptCode","SetBossSpeed(0.1)",0.11,null,null)
	PHASE = 2;
	EntFireByHandle(self,"SetDefaultAnimation",Run,0.11,null,null)
	
	if(playMusic)
		EntFire("FinalBoss_Phase1to2_music_transtion", "Trigger", null, 0.1, null);

	EntFire("bladekeeper_i_SFX_stagger_2", "PlaySound", null, 0.11, null);
	EntFireByHandle(self,"SetAnimation",Threat,0.1,null,null)
	EntFireByHandle(self,"SetAnimation",Run,5.77,null,null)
	EntFireByHandle(self,"RunScriptCode","SetBossSpeed("+runSpeed.tostring()+")",5.77,null,null)
	EntFireByHandle(self,"RunScriptCode","canAttack=true",5.77,null,null)
	EntFireByHandle(bladekeeperHealth,"RunScriptCode","canTakeDamage=true",5.77,null,null)
}

function TriggerPhase3()
{
	bladekeeperHealth.GetScriptScope().canTakeDamage = false;
	CancelAttacks()
	EntFireByHandle(Phase2Attacks,"Kill","",0.0,null,null)
	canAttack = false;
	
	EntFire("FinalBoss_Phase1to2_music_transtion", "CancelPending", null, 0.01, null);
	EntFire("M_BossPhase1_to_2", "Volume", "0", 0.02, null);
	EntFire("bladekeeper_i_SFX_stagger_2", "PlaySound", null, 0.03, null);
	EntFireByHandle(self,"RunScriptCode","SetBossSpeed(0.1)",0.11,null,null) // collapse 8.57 // threat 5.77
	EntFireByHandle(self,"SetDefaultAnimation",Idle2,0.11,null,null)
	
	PHASE = 3;

	if(playMusic)
		EntFire("FinalBoss_Phase2to3_music_transtion", "Trigger", null, 0.1, null);

	EntFireByHandle(self,"SetAnimation",Collapse,0.1,null,null)
	EntFireByHandle(self,"SetAnimation",Threat,11.1,null,null)


	// activate particles
	EntFire("bladekeeper_i_cape_particles", "Kill", null, 13, null)
	EntFireByHandle(self, "SetGlowEnabled", "", 13.01, null, null)
	EntFire("bladekeeper_i_cape_particles_golden", "Start", null, 13.01, null)
	EntFire("bladekeeper_i_head_particles", "Kill", null, 13, null)
	EntFire("bladekeeper_i_final_fade", "FadeReverse", null, 13, null)

	EntFire("EntitiesMaker", "RunScriptCode", "CreateSkyboxBladecage()", 13.01, null)
	EntFire("skybox_bladecage_rotater", "Start", null, 13.02, null)
	
	EntFire("tonemap", "setbloomscale", "4", 13, null)
	EntFire("bladekeeper_i_head_particles_golden", "Start", null, 13.01, null)
	EntFire("bladekeeper_i_phase3_start_particles", "Start", null, 12.22, null)
	EntFire("bladekeeper_i_phase3_start_particles", "Kill", null, 16.0, null)

	// play voice dialog
	EntFire("voice_bladekeeper_defeated_at_last", "PlaySound", null, 0.1, null);
	EntFire("voice_bladekeeper_feel_my_strength", "PlaySound", null, 12.22, null);

	EntFireByHandle(self,"SetDefaultAnimation",Run,16.80,null,null)
	EntFireByHandle(self,"SetAnimation",Run,16.87,null,null)
	EntFireByHandle(self,"RunScriptCode","SetBossSpeed("+phase3Speed.tostring()+")",16.87,null,null)
	EntFireByHandle(self,"RunScriptCode","canAttack=true",16.87,null,null)
	EntFireByHandle(bladekeeperHealth,"RunScriptCode","canTakeDamage=true",17,null,null)
}

function TriggerPhase4()
{
	CancelAttacks()
	canAttack = false;
	EntFireByHandle(Phase3Attacks,"Kill","",0.0,null,null)
	EntFireByHandle(bossDetector,"Kill","",0.0,null,null)
	
	PHASE = 3;
	
	EntFire("parrysword_button*", "RunScriptCode", "state=2;", 0.0, null)
	EntFire("bladekeeper_i_SFX_stagger_2", "PlaySound", null, 0.02, null);
	SetBossSpeed(0.1)
	EntFireByHandle(self,"SetAnimation",Threat,0.03,null,null)
	EntFire("bladekeeper_i_sword_particles", "Kill", null, 0.03, null)
	EntFire("bladekeeper_i_up_mover", "SetSpeed", "512", 1, null);
	EntFireByHandle(self,"RunScriptCode","SetBossSpeed(0.1)",1,null,null)
	EntFireByHandle(self,"RunScriptCode","SetBossSpeed(0.1)",2,null,null)
	EntFireByHandle(self,"RunScriptCode","SetBossSpeed(0.1)",3,null,null)
	EntFire("bladekeeper_i_up_mover", "Open", null, 1, null);
	EntFire("voice_bladekeeper_tear_your_souls", "PlaySound", null, 0.5, null);
	EntFireByHandle(self,"Disable","",3.07,null,null)
	EntFireByHandle(FirstSword,"Disable","",3.07,null,null)
	EntFire("bladekeeper_i_cape_particles_golden", "Stop", null, 3.07, null)
	EntFire("bladekeeper_i_head_particles_golden", "Stop", null, 3.07, null)

	EntFire("EntitiesMaker", "runscriptcode", "CreateSkyboxBladekeeperSpawners()", 2.5, null)

	EntFire("skybox_bladekeeper_maker_timer", "Enable", null, 3, null)
	EntFire("tonemap", "setbloomscale", "7", 3, null)
	
}
function Faint()
{
	CancelAttacks()
	canAttack = false;
	EntFireByHandle(Phase3Attacks,"Kill","",0.0,null,null)
	EntFireByHandle(bossDetector,"Kill","",0.0,null,null)
	SetBossSpeed(0)
	// just to be sure
	EntFireByHandle(self,"RunScriptCode","SetBossSpeed(0)",1,null,null)
	EntFireByHandle(self,"RunScriptCode","SetBossSpeed(0)",2,null,null)
	EntFireByHandle(self,"RunScriptCode","SetBossSpeed(0)",3,null,null)
	EntFireByHandle(self,"RunScriptCode","SetBossSpeed(0)",4,null,null)
	EntFireByHandle(self,"RunScriptCode","SetBossSpeed(0)",5,null,null)
	//-----------------------------------------------------------------\\

	EntFire("tonemap", "setbloomscale", "7", 1, null);

	BossMover.SetOrigin(Entities.FindByName(null, "bladekeeper_die_destination").GetOrigin())
	EntFire("bladekeeper_i_up_mover", "Close", null, 1, null);
	EntFireByHandle(self,"Enable","",1,null,null)
	EntFireByHandle(FirstSword,"Enable","",1,null,null)
	EntFireByHandle(FirstSword,"SetAnimation",SwordOff,1.07,null,null)
	EntFire("bladekeeper_i_cape_particles_golden", "Start", null, 1, null)
	EntFire("bladekeeper_i_head_particles_golden", "Start", null, 1, null)
	EntFireByHandle(self,"SetDefaultAnimation","collapse_idle",1.01,null,null)
	EntFireByHandle(self,"SetAnimation","collapse_idle",1.02,null,null)

	EntFire("voice_bladekeeper_finish_what_you_started", "PlaySound", null, 3, null)
	

	
	EntFire("bladekeeper_i_slaytext_maker", "ForceSpawn", null, 12, null)
}

function Slay()
{
	SetBossSpeed(0);
	EntFire("slaybutton", "Kill", null, 0.0, null)

	EntFire("bladekeeper_i_detector_mover", "Kill", null, 0.05, null)
	EntFire("bladekeeper_i_detector", "Kill", null, 0.05, null)

	EntFire("bladekeeper_i_slayswords_spawner_timer", "Enable", null, 0.05, null)
	EntFire("bladekeeper_i_slayswords_spawner_timer", "Disable", null, 11.50, null)

	// EntFire("bladekeeper_i_final_fade", "Fade", null, 7.10, null)
	EntFire("bladekeeper_i_final_fade", "FadeReverse", null, 10.04, null)
	EntFireByHandle(FirstSword,"Kill","",10.05,null,null)
	EntFireByHandle(self,"SetAnimation",Dying,10.05,null,null)

	
	EntFire("bladekeeper_i_cape_particles_golden", "Kill", null, 18.38, null)
	EntFireByHandle(self, "SetPlaybackRate", "0", 24.0, null, null) 
	EntFireByHandle(self, "SetGlowDisabled", "", 24.0, null, null) 
	EntFireByHandle(self, "ClearParent", "", 24.0, null, null) 
	EntFire("bladekeeper_i_head_particles_golden", "Kill", null, 24.01, null)
	EntFire("Finale_LoopMusicManager", "RunScriptCode", "StopCurrentlyLoopedMusic()", 24.01, null)
	EntFire("tonemap", "setbloomscale", "3.2", 24.01, null);
	EntFire("skybox_bladecage", "FadeAndKill", null, 24.01, null);
	EntFire("skybox_statues_crown_particles", "Kill", null, 24.01, null);
	EntFire("bladekeeper_i_SFX_stagger_*", "Kill", null, 24.02, null);
	EntFire("attributes_script", "RunScriptCode", "EncounterComplete(8)", 24.1, null);
	EntFire("MapManager", "RunScriptCode", "DecideEnding()", 26, null);
	
	
	

	EntFire("bladekeeper_npc_physbox", "Kill", null, 24.05, null)
	
}	

function AddP4Hit(amount)
{
	phase4HitsCount += amount

	if(phase4HitsCount >= maxPhase4Hits)
	{
		EntFire("skybox_bladekeeper_maker_timer", "Disable", null, 0.0, null);
		EntFire("skybox_bladekeeper_maker_timer", "Kill", null, 0.01, null);
		EntFireByHandle(self,"RunScriptCode","Faint();",3,null,null);
		
	}
}

function Damage(value = 10)
{
	bladekeeperHealth.GetScriptScope().SubtractHealth(value, activator)
}

function Heal(value = 10)
{
	bladekeeperHealth.GetScriptScope().AddHealth(value, activator)
}

lightAttackDamage <- 150 * damageMultiplier;
mediumAttackDamage <- 200 * damageMultiplier;
mediumAttack2Damage <- 250 * damageMultiplier;
heavyAttackDamage <- 350 * damageMultiplier;

p3_lightAttackDamage <- 250 * damageMultiplier;
p3_mediumAttackDamage <- 300 * damageMultiplier;
p3_mediumAttack2Damage <- 450 * damageMultiplier;
p3_heavyAttackDamage <- 350 * damageMultiplier;

function DamageTrigger(attackType=0)
{
    // putting this in a function to save on entities
    // 0 = 2Combo

    // 1 = 3Combo First slash / Third Slash
    // 2 = 3Combo Second Slash

    // 3 = Spin Combo

	// 4 = Wide Special

	// 5 = Beams

    if(PHASE == 1 || PHASE == 2)
    {
		switch (attackType) {
        case 1:
			EntFireByHandle(self,"RunScriptCode","Heal("+mediumAttack2Damage.tostring()+")",0.0,activator,null) 
            break;
		case 2:
			EntFireByHandle(self,"RunScriptCode","Heal("+lightAttackDamage.tostring()+")",0.0,activator,null)
			break;
		case 3:
			EntFireByHandle(self,"RunScriptCode","Heal("+lightAttackDamage.tostring()+")",0.0,activator,null)
			break;
		case 4:
			EntFireByHandle(self,"RunScriptCode","Heal("+heavyAttackDamage.tostring()+")",0.0,activator,null)
			break;
		case 5:
			EntFireByHandle(self,"RunScriptCode","Heal("+mediumAttackDamage.tostring()+")",0.0,activator,null)
			break;
        default:
			EntFireByHandle(self,"RunScriptCode","Heal("+mediumAttackDamage.tostring()+")",0.0,activator,null)
			break;
		} 
    }
    else if(PHASE == 3)
    {
		switch (attackType) {
        case 1:
			EntFireByHandle(self,"RunScriptCode","Heal("+p3_mediumAttack2Damage.tostring()+")",0.0,activator,null) 
            break;
		case 2:
			EntFireByHandle(self,"RunScriptCode","Heal("+p3_lightAttackDamage.tostring()+")",0.0,activator,null)
			break;
		case 3:
			EntFireByHandle(self,"RunScriptCode","Heal("+p3_lightAttackDamage.tostring()+")",0.0,activator,null)
			break;
		case 4:
			EntFireByHandle(self,"RunScriptCode","Heal("+p3_heavyAttackDamage.tostring()+")",0.0,activator,null)
			break;
		case 5:
			EntFireByHandle(self,"RunScriptCode","Heal("+p3_mediumAttackDamage.tostring()+")",0.0,activator,null)
			break;
        default:
			EntFireByHandle(self,"RunScriptCode","Heal("+p3_mediumAttackDamage.tostring()+")",0.0,activator,null)
			break;
		} 
    }
}