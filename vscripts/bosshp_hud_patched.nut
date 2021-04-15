//Patched version intended for use with GFL ze_lotr_isengard_csgo1 stripper
//Removes broken HTML formatting from the bhud
//install as csgo/scripts/vscripts/gfl/bosshp_hud_patched.nut
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

function CheckHpHud()
{
	ScriptPrintMessageCenterAll("[BOSS: " + HudHealth + "]" + "\n" + HPHUD);
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

function SubtractHealth(){BossHealth--;HudHealth--;if(HudHealth <= 0){HudHealth=0;}}

function GrenadeDamage(he){BossHealth -= he;HudHealth -= he;if(HudHealth <= 0){HudHealth=0;}}

function SubHpIt(i){BossHealth -= i;HudHealth -= i;if(HudHealth <= 0){HudHealth=0;}}

function BossKill(){EntFireByHandle(self, "FireUser1", "", 0.00, null, null);}

/////////////////////////////////////////////////////////////////////////////////

function AddHealthDamba(add_amount)
{
	local p = null;
	while(null != (p = Entities.FindByClassname(p, "player")))
	{
	    if(p.GetTeam() == 3 && p.GetHealth() > 0 && p.IsValid())
		{
		    BossHealth += add_amount;
		}
	}
	EntFireByHandle(self, "SetHealth", ""+BossHealth, 0.00, null, null);
}