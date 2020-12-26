mathname <- "";
TotalHealth <- 0;
TEST <- false;

function StartBoss(hp)
{
    TotalHealth = 0;
    mathname = "map_boss_counter1";
    AddHealth(hp);
    TestPrintTotalhp();
}

function StartBossStage4(hp)
{
    TotalHealth = 0;
    mathname = "stage4_miniboss_counter1";
    AddHealth(hp);
    TestPrintTotalhp();
}

function StartBossStage5D1(hp)
{
    TotalHealth = 0;
    mathname = "stage5_n_death1_c1";
    AddHealth(hp);
    TestPrintTotalhp();
}

function StartBossStage5D2(hp)
{
    TotalHealth = 0;
    mathname = "stage5_n_death2_c1";
    AddHealth(hp);
    TestPrintTotalhp();
}

function AddHealth(add_amount)
{
	local p = null;
	while(null != (p = Entities.FindByClassname(p,"player")))
	{
	    if(p.GetTeam() == 3 && p.GetHealth() > 0 && p.IsValid())
		{
            if(TEST){TotalHealth += add_amount}
            EntFire(mathname, "Add", ""+add_amount, 0.00, p);
		}
	}
}

function TestPrintTotalhp()
{
    if(TEST){
        ScriptPrintMessageCenterAll("TOTAL HEALTH: "+TotalHealth);
        EntFireByHandle(self,"RunScriptCode","TestPrintTotalhp();",1.00,null,null);}
}
