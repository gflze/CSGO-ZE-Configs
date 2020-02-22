//#####################################################################
//Patched version intended for use with GFL ze_v0u0v_a6_csgo1 stripper
//Removes HTML formatting broken/non-functional after Shattered Web Update.
//Install as csgo/scripts/vscripts/vouov/vouov_boss_patched.nut
//#####################################################################

BossHpBar <- 10;

ticking <- false;

TickRate <- 0.05;

HPHUD <- "◼◼◼◼◼◼◼◼◼◼";

BossHealth <- 0.00;

ChangeHealth <- 0.00;

HudHealth <- 0.00;


function AddHealth(add_amount)
{
	local p = null;
	while(null != (p = Entities.FindByClassname(p, "player")))
	{
	    if(p.GetTeam() == 3 && p.GetHealth() > 0 && p.IsValid())
		{
		    BossHealth += add_amount;
			ChangeHealth += add_amount;
		}
	}
	HudHealth = ChangeHealth * BossHpBar;
}

// function HpBarFrame(Frame){if(BossHpBar==0)BossHpBar = Frame;}

function ChangeHp()
{
	if(BossHealth <= 0){HpBar();BossHpBar--;BossHealth += ChangeHealth;}
	else if(BossHpBar<=0){BossKill();ticking=false;}
}

function HpBar()
{
	for(local i = BossHpBar; i >= 0; i--)
	{
	    if(BossHpBar == 10){HPHUD = "◼◼◼◼◼◼◼◼◼◻";}
	    if(BossHpBar == 9){HPHUD = "◼◼◼◼◼◼◼◼◻◻";}
	    if(BossHpBar == 8){HPHUD = "◼◼◼◼◼◼◼◻◻◻";}
	    if(BossHpBar == 7){HPHUD = "◼◼◼◼◼◼◻◻◻◻";}
	    if(BossHpBar == 6){HPHUD = "◼◼◼◼◼◻◻◻◻◻";}
	    if(BossHpBar == 5){HPHUD = "◼◼◼◼◻◻◻◻◻◻";}
	    if(BossHpBar == 4){HPHUD = "◼◼◼◻◻◻◻◻◻◻";}
	    if(BossHpBar == 3){HPHUD = "◼◼◻◻◻◻◻◻◻◻";}
	    if(BossHpBar == 2){HPHUD = "◼◻◻◻◻◻◻◻◻◻";}
		if(BossHpBar == 1){HPHUD = "◻◻◻◻◻◻◻◻◻◻";}
		return;
	}
}

function CheckHpHud(){
	ScriptPrintMessageCenterAll("[BOSS: " + "" + HudHealth + "" + "]" + "\n" + HPHUD);
}

function Start(){ticking = true;Tick();}

function Tick()
{
	if(ticking)
	{
		EntFireByHandle(self, "RunScriptCode", "Tick()", TickRate, null, null);
		EntFireByHandle(self, "RunScriptCode", "ChangeHp()", 0.00, null, null);
		EntFireByHandle(self, "RunScriptCode", "CheckHpHud()", 0.00, null, null);
	}
}

function SubtractHealth(){BossHealth--;HudHealth--;}

function GrenadeDamage(he){BossHealth-=he;HudHealth-=he;}

function SubHpIt(i){BossHealth-=i;HudHealth-=i;}

function BossKill()
{
	if(self.GetName() == "bosslvl1_hit" || self.GetName() == "bosslvl4_hit")
	{
		local bosskill_lvl1_4 = Entities.FindByName(null,"bosslvl1_4_counter3");
		EntFireByHandle(bosskill_lvl1_4, "Trigger", "", 0.00, null, null);
	}
	if(self.GetName() == "bosslvl2_5_hit")
	{
		local bosskill_lvl2_5 = Entities.FindByName(null,"bosslvl2_5_counter3");
		EntFireByHandle(bosskill_lvl2_5, "Trigger", "", 0.00, null, null);
	}
	if(self.GetName() == "bosslvl3_2_hit")
	{
		local bosskill_lvl3_2 = Entities.FindByName(null,"bosslvl3_2_counter3");
		EntFireByHandle(bosskill_lvl3_2, "Trigger", "", 0.00, null, null);
	}
	if(self.GetName() == "bosslvl3_hit" && BOSSSTAGE == 1)
	{
		local bosskill_lvl3_6 = Entities.FindByName(null,"bosslvl3_6_counter3");
		EntFireByHandle(bosskill_lvl3_6, "Trigger", "", 0.00, null, null);
		BOSSSTAGE++;
		BossHpBar = 10;
		BossHealth = 0.00;
        ChangeHealth = 0.00;
        HudHealth = 0.00;
	}
	else if(self.GetName() == "bosslvl3_hit" && BOSSSTAGE == 2)
	{
		local bosskill_lvl3_6 = Entities.FindByName(null,"bosslvl3_6_counter6");
		EntFireByHandle(bosskill_lvl3_6, "Trigger", "", 0.00, null, null);
	}
	if(self.GetName() == "bosslvl6_hit")
	{
		local bosskill_lvl6 = Entities.FindByName(null,"bosslvl6_counter3");
		EntFireByHandle(bosskill_lvl6, "Trigger", "", 0.00, null, null);
	}
}

//////////////////////////////////////
//////////////////////////////////////
//////////////////////////////////////

BOSSSTAGE <- 1;
VisualHP <- 1;

function VisyalAddHp()
{
	CheckHpHud();
	if(VisualHP == 11){HPHUD = "◼◼◼◼◼◼◼◼◼◼";}
	if(VisualHP == 10){HPHUD = "◼◼◼◼◼◼◼◼◼◻";}
	if(VisualHP == 9){HPHUD = "◼◼◼◼◼◼◼◼◻◻";}
	if(VisualHP == 8){HPHUD = "◼◼◼◼◼◼◼◻◻◻";}
	if(VisualHP == 7){HPHUD = "◼◼◼◼◼◼◻◻◻◻";}
	if(VisualHP == 6){HPHUD = "◼◼◼◼◼◻◻◻◻◻";}
	if(VisualHP == 5){HPHUD = "◼◼◼◼◻◻◻◻◻◻";}
	if(VisualHP == 4){HPHUD = "◼◼◼◻◻◻◻◻◻◻";}
	if(VisualHP == 3){HPHUD = "◼◼◻◻◻◻◻◻◻◻";}
	if(VisualHP == 2){HPHUD = "◼◻◻◻◻◻◻◻◻◻";}
	if(VisualHP == 1){HPHUD = "◻◻◻◻◻◻◻◻◻◻";}
	VisualHP++;
}

//////////////////////////////////////
//////////////////////////////////////
//////////////////////////////////////










