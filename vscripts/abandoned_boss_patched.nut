//#####################################################################
//Patched version intended for use with GFL ze_abandoned_project_v1_2_csgo stripper
//Removes HTML formatting broken after Shattered Web Update.
//Install as csgo/scripts/vscripts/gfl/abandoned_boss_patched.nut
//#####################################################################

ticking <- false;
BossHealth <- 0.00;
PercentHp <- 0.00;
TotalHp <- 0.00;


function Start()
{
    ticking = true;
	Tick();
}


function AddHealth(add_amount)
{
	local p = null;
	BossHealth = 800.00;
	while(null != (p = Entities.FindByClassname(p,"player")))
	{
	    if(p.GetTeam() == 3 && p.GetHealth() > 0)
		{
		    BossHealth += add_amount;
		}
	}
	TotalHp = BossHealth;
}

function Tick()
{
	if(ticking == true)
	{
		PercentHp = (BossHealth * 100)/TotalHp;
		EntFireByHandle(self, "RunScriptCode", " CheckHP() ", 0.02, null, null);
		EntFireByHandle(self, "RunScriptCode", " Tick() ", 0.05, null, null);
	}
}

function Subtract()
{
	BossHealth-=RandomFloat(1,2);
}

function CheckHP()
{
	ScriptPrintMessageCenterAll("BOSS HEALTH: " + "" + BossHealth + " (" + PercentHp + "%)");
	if(BossHealth <= 0){BossKill();}
}

function BossKill()
{
	ticking = false;
	EntFire("modelo","SetAnimation","dead1",0.00,null);
	EntFire("modelo","SetAnimation","dead2",1.00,null);
	EntFire("modelo","SetDefaultAnimation","dead2",1.00,null);
	EntFire("bossmuertobrekable","Break","",7.90,null);
	EntFire("explosion_boss_muerto","Start","",8.00,null);
	EntFire("boss_muerto_jail","Break","",13.00,null);
	EntFire("puertafinal_phy","Kill","",7.80,null);
	EntFire("explosion_boss_muerto_phy","Enable","",8.00,null);
	EntFire("jefemov","DisableMotion","",1.00,null);
	EntFire("explosion_boss_muerto_phy","Disable","",8.50,null);
	EntFire("shakekillboss","StartShake","",8.00,null);
	EntFire("musica_extremo_3boss","Kill","",3.00,null);
	EntFire("musica_extremo_4","PlaySound","",3.00,null);
	EntFire("danyo_score","Kill","",0.00,null);
	EntFire("trigger_boss1","Kill","",0.00,null);
	EntFire("bosshurt","Kill","",0.00,null);
	EntFire("jefemov","RunScriptCode","Stop();",0.00,null);
	ScriptPrintMessageCenterAll("");
}









