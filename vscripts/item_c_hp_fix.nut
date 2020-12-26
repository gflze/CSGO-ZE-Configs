ZMITEMLVLUP <- 0;
ITEM_DISABLE <- true;
ZOMBIE_ITEM_DISABLE <- true;
////////////////////////////////
PROTEGOACT <- null;
PROTEGOCALL <- null;
PROTEGOONCE <- true;
PROTEGOLEVEL <- 0;
////////////////////////////////

////////////////////////////////
////////////PROTEGO/////////////
////////////////////////////////

function PickUpProtego()
{
    PROTEGOACT = activator;
    PROTEGOCALL = caller;
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, PROTEGOACT);
    EntFire("!activator", "AddOutput", "rendercolor 249 197 15", 0.30, PROTEGOACT);
    EntFireByHandle(self,"RunScriptCode","ProtegoItemM();",2.00,null,null);
    if(PROTEGOONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11456 9456 13630", 0.10, PROTEGOACT);
        EntFire("!activator", "RunScriptCode", "GetItemLevelProtego();", 0.00, PROTEGOACT);
        EntFireByHandle(self,"RunScriptCode","ProtegoReceivedLevel();",0.01,null,null);
        EntFire("map_equip_guns", "Use", "", 0.40, PROTEGOACT);
        PROTEGOONCE = false;
    }
}

function ProtegoReceivedLevel()
{
    if(PROTEGOLEVEL == 0)
    {
        EntFire("spx_effect_upgrade_protego","Start","",0.00,null);
        EntFire("spx_effect_upgrade_protego","Stop","",1.00,null);
        EntFire("spx_effect_upgrade_protego","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_protego","Kill","",2.00,null);
        EntFire("spx_protego_spwnr_template2","Kill","",2.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(0, 0);",3.00,PROTEGOACT);
		EntFire("console","Command","sm_setcooldown 8979602 60",3.00,null);
    }
    else if(PROTEGOLEVEL == 1)
    {
        ProtegoItemLevel1M();
        EntFire("spx_effect_upgrade_protego","Start","",0.00,null);
        EntFire("spx_effect_upgrade_protego","Stop","",1.00,null);
        EntFire("spx_effect_upgrade_protego","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_protego","Kill","",2.00,null);
        EntFire("spx_protego_spwnr_template2","Kill","",2.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(0, 1);",3.00,PROTEGOACT);
		EntFire("console","Command","sm_setcooldown 8979602 60",3.00,null);
    }
    else if(PROTEGOLEVEL == 2)
    {
        ProtegoItemLevel2M();
        ZMITEMLVLUP++;
        EntFire("spx_effect_upgrade_protego","Start","",0.00,null);
        EntFire("spx_effect_upgrade_protego","Stop","",1.00,null);
        EntFire("spx_effect_upgrade_protego","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_protego","Kill","",2.00,null);
        EntFire("spx_protego_spwnr_template2","Kill","",2.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(0, 2);",3.00,PROTEGOACT);
		EntFire("console","Command","sm_setcooldown 8979602 55",3.00,null);
    }
    else if(PROTEGOLEVEL == 3)
    {
        ProtegoItemLevel3M();
        ZMITEMLVLUP++;
        EntFire("spx_effect_upgrade_protego","Start","",0.00,null);
        EntFire("spx_effect_upgrade_protego","Stop","",1.00,null);
        EntFire("spx_effect_upgrade_protego","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_protego","Kill","",2.00,null);
        EntFire("spx_protego_spwnr_template2","Kill","",2.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(0, 3);",3.00,PROTEGOACT);
		EntFire("console","Command","sm_setcooldown 8979602 55",3.00,null);
    }
    else if(PROTEGOLEVEL == 4)
    {
        ProtegoItemLevel4M();
        ZMITEMLVLUP++;
        EntFire("spx_effect_upgrade_protego","Start","",0.00,null);
        EntFire("spx_effect_upgrade_protego","Stop","",1.00,null);
        EntFire("spx_effect_upgrade_protego","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_protego","Kill","",2.00,null);
        EntFire("spx_protego_spwnr_template","Kill","",2.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(0, 4);",3.00,PROTEGOACT);
		EntFire("console","Command","sm_setcooldown 8979602 50",3.00,null);
    }
}

function UseItemProtego()
{
    if(activator.GetTeam() == 3 && activator == PROTEGOACT && !ITEM_DISABLE)
    { 
        EntFire("spx_protego_button","Lock","", 0.00, null);
        EntFire("spx_protego_spwnr_temp*","ForceSpawn","", 0.00, null);
		EntFire("spx_effect_wand_protego","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spx_protego_spwnr_d*","ClearParent","", 1.00, null);
		EntFire("spx_protego_spwnr_p*","ClearParent","", 1.00, null);
		EntFire("spx_protego_spwnr_tr*","ClearParent","", 1.00, null);
        EntFire("spx_protego_spwnr_d*","Kill","", 2.00, null);
		EntFire("spx_protego_spwnr_tr*","Kill","", 8.00, null);
        EntFire("spx_protego_wandprop","Color","255 28 28", 0.00, null);
        if(PROTEGOLEVEL == 0)
        {
            EntFire("spx_protego_spwnr_prop*","Break","",4.00,null);
            EntFire("spx_protego_spwnr_trig*","Disable","",4.00,null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",40.00,PROTEGOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",50.00,PROTEGOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",60.00,PROTEGOACT);
            EntFire("spx_protego_wandprop","Color","17 255 77",60.00,null);
            EntFire("spx_effect_wand_protego","Start","",60.00,null);
            EntFire("spx_protego_button","UnLock","",60.00,null);
        }
        else if(PROTEGOLEVEL == 1)
        {
            EntFire("spx_protego_spwnr_prop*","Break","",5.00,null);
            EntFire("spx_protego_spwnr_trig*","Disable","",5.00,null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",40.00,PROTEGOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",50.00,PROTEGOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",60.00,PROTEGOACT);
            EntFire("spx_protego_wandprop","Color","17 255 77",60.00,null);
            EntFire("spx_effect_wand_protego","Start","",60.00,null);
            EntFire("spx_protego_button","UnLock","",60.00,null);
        }
        else if(PROTEGOLEVEL == 2)
        {
            EntFire("spx_protego_spwnr_prop*","Break","",5.00,null);
            EntFire("spx_protego_spwnr_trig*","Disable","",5.00,null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",35.00,PROTEGOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",45.00,PROTEGOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",55.00,PROTEGOACT);
            EntFire("spx_protego_wandprop","Color","17 255 77",55.00,null);
            EntFire("spx_effect_wand_protego","Start","",55.00,null);
            EntFire("spx_protego_button","UnLock","",55.00,null);
        }
        else if(PROTEGOLEVEL == 3)
        {
            EntFire("spx_protego_spwnr_prop*","Break","",6.00,null);
            EntFire("spx_protego_spwnr_trig*","Disable","",6.00,null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",35.00,PROTEGOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",45.00,PROTEGOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",55.00,PROTEGOACT);
            EntFire("spx_protego_wandprop","Color","17 255 77",55.00,null);
            EntFire("spx_effect_wand_protego","Start","",55.00,null);
            EntFire("spx_protego_button","UnLock","",55.00,null);
        }
        else if(PROTEGOLEVEL == 4)
        {
            EntFire("spx_protego_spwnr_prop*","Break","",6.00,null);
            EntFire("spx_protego_spwnr_trig*","Disable","",6.00,null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,PROTEGOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,PROTEGOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,PROTEGOACT);
            EntFire("spx_protego_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_protego","Start","",50.00,null);
            EntFire("spx_protego_button","UnLock","",50.00,null);
        }
    }
}

function ProtegoItemM()
{
    ScriptPrintMessageChatAll("ITEM PICKUP: \x10>>> PROTEGO SPELL HAS BEEN PICKED UP <<<");
}

function ProtegoItemLevel1M()
{
    ScriptPrintMessageChatAll(" \x10>>> APPLYING 1 YEAR EXPERIENCE TO PROTEGO [1/4] <<<");
}

function ProtegoItemLevel2M()
{
    ScriptPrintMessageChatAll(" \x10>>> APPLYING 2 YEARS EXPERIENCE TO PROTEGO [2/4] <<<");
}

function ProtegoItemLevel3M()
{
    ScriptPrintMessageChatAll(" \x10>>> APPLYING 3 YEARS EXPERIENCE TO PROTEGO [3/4] <<<");
}

function ProtegoItemLevel4M()
{
    ScriptPrintMessageChatAll(" \x10>>> APPLYING 4 YEARS EXPERIENCE TO PROTEGO [4/4] <<<");
}
//OnUser1 spx_protego_activator:Trigger::0:1
////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
REPAIROACT <- null;
REPAIROCALL <- null;
REPAIROONCE <- true;
REPAIROLEVEL <- 0;
////////////////////////////////

////////////////////////////////
////////////REPAIRO/////////////
////////////////////////////////

function PickUpRepairo()
{
    REPAIROACT = activator;
    REPAIROCALL = caller;
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, REPAIROACT);
    EntFire("!activator", "AddOutput", "rendercolor 0 255 0", 0.30, REPAIROACT);
    EntFireByHandle(self,"RunScriptCode","RepairoItemM();",2.00,null,null);
    if(REPAIROONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11456 9456 13630", 0.10, REPAIROACT);
        EntFire("!activator", "RunScriptCode", "GetItemLevelRepairo();", 0.00, REPAIROACT);
        EntFireByHandle(self,"RunScriptCode","RepairoReceivedLevel();",0.01,null,null);
        EntFire("map_equip_guns", "Use", "", 0.40, REPAIROACT);
        REPAIROONCE = false;
    }
}

function RepairoReceivedLevel()
{
    if(REPAIROLEVEL == 0)
    {
        EntFire("stage5_boss_h_healer","AddOutput","OnStartTouch !activator:AddOutput:health 125:0.2:-1",0.20,null);
        EntFire("spx_effect_upgrade_repairo","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_repairo","Stop","",1.00,null);
        EntFire("spx_repairo_trigger1","ClearParent","",2.00,null);
        EntFire("spx_repairo_trigger2","ClearParent","",2.00,null);
        EntFire("spx_repairo_trigger3","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active1","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_repairo","Kill","",2.00,null);
        EntFire("spx_repairo_trigger1","Kill","",3.00,null);
        EntFire("spx_repairo_trigger2","Kill","",3.00,null);
        EntFire("spx_repairo_trigger3","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active1","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active2","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(1, 0);",3.00,REPAIROACT);
		EntFire("console","Command","sm_setcooldown 8978959 50",3.00,null);
    }
    else if(REPAIROLEVEL == 1)
    {
        RepairoItemLevel1M();
        EntFire("stage5_boss_h_healer","AddOutput","OnStartTouch !activator:AddOutput:health 135:0.2:-1",0.20,null);
        EntFire("spx_effect_upgrade_repairo","Start","",0.00,null);
        EntFire("spx_effect_upgrade_repairo","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_repairo","Stop","",1.00,null);
        EntFire("spx_repairo_trigger","ClearParent","",2.00,null);
        EntFire("spx_repairo_trigger2","ClearParent","",2.00,null);
        EntFire("spx_repairo_trigger3","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_repairo","Kill","",3.00,null);
        EntFire("spx_repairo_trigger","Kill","",3.00,null);
        EntFire("spx_repairo_trigger2","Kill","",3.00,null);
        EntFire("spx_repairo_trigger3","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active2","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(1, 1);",3.00,REPAIROACT);
        EntFire("console","Command","sm_setcooldown 8978959 50",3.00,null);
    }
    else if(REPAIROLEVEL == 2)
    {
        RepairoItemLevel2M();
        ZMITEMLVLUP++;
        EntFire("stage5_boss_h_healer","AddOutput","OnStartTouch !activator:AddOutput:health 140:0.2:-1",0.20,null);
        EntFire("spx_effect_upgrade_repairo","Start","",0.00,null);
        EntFire("spx_effect_upgrade_repairo","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_repairo","Stop","",1.00,null);
        EntFire("spx_repairo_trigger","ClearParent","",2.00,null);
        EntFire("spx_repairo_trigger1","ClearParent","",2.00,null);
        EntFire("spx_repairo_trigger3","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active1","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_repairo","Kill","",3.00,null);
        EntFire("spx_repairo_trigger","Kill","",3.00,null);
        EntFire("spx_repairo_trigger1","Kill","",3.00,null);
        EntFire("spx_repairo_trigger3","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active1","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(1, 2);",3.00,REPAIROACT);
        EntFire("console","Command","sm_setcooldown 8978959 45",3.00,null);
    }
    else if(REPAIROLEVEL == 3)
    {
        RepairoItemLevel3M();
        ZMITEMLVLUP++;
        EntFire("stage5_boss_h_healer","AddOutput","OnStartTouch !activator:AddOutput:health 145:0.2:-1",0.20,null);
        EntFire("spx_repairo_trigger*","AddOutput","OnStartTouch !activator:AddOutput:health 145:0.2:-1",0.20,null);
        EntFire("spx_effect_upgrade_repairo","Start","",0.00,null);
        EntFire("spx_effect_upgrade_repairo","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_repairo","Stop","",1.00,null);
        EntFire("spx_repairo_trigger","ClearParent","",2.00,null);
        EntFire("spx_repairo_trigger1","ClearParent","",2.00,null);
        EntFire("spx_repairo_trigger2","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active1","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_repairo","Kill","",3.00,null);
        EntFire("spx_repairo_trigger","Kill","",3.00,null);
        EntFire("spx_repairo_trigger1","Kill","",3.00,null);
        EntFire("spx_repairo_trigger2","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active1","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active2","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(1, 3);",3.00,REPAIROACT);
       EntFire("console","Command","sm_setcooldown 8978959 45",3.00,null);
    }
    else if(REPAIROLEVEL == 4)
    {
        RepairoItemLevel4M();
        ZMITEMLVLUP++;
        EntFire("stage5_boss_h_healer","AddOutput","OnStartTouch !activator:AddOutput:health 150:0.2:-1",0.20,null);
        EntFire("spx_repairo_trigger*","AddOutput","OnStartTouch !activator:AddOutput:health 150:0.2:-1",0.20,null);
        EntFire("spx_effect_upgrade_repairo","Start","",0.00,null);
        EntFire("spx_effect_upgrade_repairo","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_repairo","Stop","",1.00,null);
        EntFire("spx_repairo_trigger","ClearParent","",2.00,null);
        EntFire("spx_repairo_trigger1","ClearParent","",2.00,null);
        EntFire("spx_repairo_trigger2","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active1","ClearParent","",2.00,null);
        EntFire("spx_repairo_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_repairo","Kill","",3.00,null);
        EntFire("spx_repairo_trigger","Kill","",3.00,null);
        EntFire("spx_repairo_trigger1","Kill","",3.00,null);
        EntFire("spx_repairo_trigger2","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active1","Kill","",3.00,null);
        EntFire("spx_repairo_effect_active2","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(1, 4);",3.00,REPAIROACT);
		EntFire("console","Command","sm_setcooldown 8978959 40",3.00,null);
    }
}

function UseItemRepairo()
{
    if(activator.GetTeam() == 3 && activator == REPAIROACT && !ITEM_DISABLE)
    { 
        EntFire("spx_repairo_button","Lock","", 0.00, null);
        EntFire("spx_repairo_trigger*","Enable","", 0.00, null);
		EntFire("spx_effect_wand_repairo","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spx_repairo_effect_active*","Start","", 0.00, null);
		EntFire("stage5_boss_h_healer","Enable","", 0.00, null);
        EntFire("spx_repairo_wandprop","Color","255 28 28", 0.00, null);
        if(REPAIROLEVEL == 0)
        {
            EntFire("spx_repairo_effect_active*","Stop","",4.00,null);
            EntFire("spx_repairo_t*","Disable","",4.00,null);
            EntFire("stage5_boss_h_healer*","Disable","",4.00,null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,REPAIROACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,REPAIROACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,REPAIROACT);
            EntFire("spx_repairo_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_repairo","Start","",50.00,null);
            EntFire("spx_repairo_button","UnLock","",50.00,null);
        }
        else if(REPAIROLEVEL == 1)
        {
            EntFire("spx_repairo_effect_active*","Stop","",5.00,null);
            EntFire("spx_repairo_t*","Disable","",5.00,null);
            EntFire("stage5_boss_h_healer*","Disable","",5.00,null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,REPAIROACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,REPAIROACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,REPAIROACT);
            EntFire("spx_repairo_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_repairo","Start","",50.00,null);
            EntFire("spx_repairo_button","UnLock","",50.00,null);
        }
        else if(REPAIROLEVEL == 2)
        {
            EntFire("spx_repairo_effect_active*","Stop","",5.00,null);
            EntFire("spx_repairo_t*","Disable","",5.00,null);
            EntFire("stage5_boss_h_healer*","Disable","",5.00,null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",25.00,REPAIROACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",35.00,REPAIROACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",45.00,REPAIROACT);
            EntFire("spx_repairo_wandprop","Color","17 255 77",45.00,null);
            EntFire("spx_effect_wand_repairo","Start","",45.00,null);
            EntFire("spx_repairo_button","UnLock","",45.00,null);
        }
        else if(REPAIROLEVEL == 3)
        {
            EntFire("spx_repairo_effect_active*","Stop","",6.00,null);
            EntFire("spx_repairo_t*","Disable","",6.00,null);
            EntFire("stage5_boss_h_healer*","Disable","",6.00,null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",25.00,REPAIROACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",35.00,REPAIROACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",45.00,REPAIROACT);
            EntFire("spx_repairo_wandprop","Color","17 255 77",45.00,null);
            EntFire("spx_effect_wand_repairo","Start","",45.00,null);
            EntFire("spx_repairo_button","UnLock","",45.00,null);
        }
        else if(REPAIROLEVEL == 4)
        {
            EntFire("spx_repairo_effect_active*","Stop","",6.00,null);
            EntFire("spx_repairo_t*","Disable","",6.00,null);
            EntFire("stage5_boss_h_healer*","Disable","",6.00,null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",20.00,REPAIROACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",30.00,REPAIROACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",40.00,REPAIROACT);
            EntFire("spx_repairo_wandprop","Color","17 255 77",40.00,null);
            EntFire("spx_effect_wand_repairo","Start","",40.00,null);
            EntFire("spx_repairo_button","UnLock","",40.00,null);
        }
    }
}

function RepairoItemM()
{
    ScriptPrintMessageChatAll("ITEM PICKUP: \x04>>> REPARO SPELL HAS BEEN PICKED UP <<<");
}

function RepairoItemLevel1M()
{
    ScriptPrintMessageChatAll(" \x04>>> APPLYING 1 YEAR EXPERIENCE TO REPARO [1/4] <<<");
}

function RepairoItemLevel2M()
{
    ScriptPrintMessageChatAll(" \x04>>> APPLYING 2 YEAR EXPERIENCE TO REPARO [2/4] <<<");
}

function RepairoItemLevel3M()
{
    ScriptPrintMessageChatAll(" \x04>>> APPLYING 3 YEAR EXPERIENCE TO REPARO [3/4] <<<");
}

function RepairoItemLevel4M()
{
    ScriptPrintMessageChatAll(" \x04>>> APPLYING 4 YEAR EXPERIENCE TO REPARO [4/4] <<<");
}
//OnUser1 spx_Repairo_activator:Trigger::0:1
////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
AVADAACT <- null;
AVADACALL <- null;
AVADAONCE <- true;
AVADALEVEL <- 0;
AVADAMAXUSES <- 2;
AVADAUSES <- 0;
////////////////////////////////

////////////////////////////////
/////////////AVADA//////////////
////////////////////////////////

function PickUpAvada()
{
    AVADAACT = activator;
    AVADACALL = caller;
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, AVADAACT);
    EntFire("!activator", "AddOutput", "rendercolor 232 0 232", 0.30, AVADAACT);
    EntFireByHandle(self,"RunScriptCode","AvadaItemM();",2.00,null,null);
    if(AVADAONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11456 9456 13630", 0.10, AVADAACT);
        EntFire("!activator", "RunScriptCode", "GetItemLevelAvada();", 0.00, AVADAACT);
        EntFireByHandle(self,"RunScriptCode","AvadaReceivedLevel();",0.01,null,null);
        EntFire("map_equip_guns", "Use", "", 0.40, AVADAACT);
        AVADAONCE = false;
    }
}

function AvadaReceivedLevel()
{
    if(AVADALEVEL == 0)
    {
        EntFire("spx_effect_upgrade_avada","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_avada","Stop","",1.00,null);
        EntFire("spx_avada_trigger2","ClearParent","",2.00,null);
        EntFire("spx_avada_trigger3","ClearParent","",2.00,null);
        EntFire("spx_avada_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_avada_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_avada","Kill","",2.00,null);
        EntFire("spx_avada_trigger2","Kill","",3.00,null);
        EntFire("spx_avada_trigger3","Kill","",3.00,null);
        EntFire("spx_avada_effect_active2","Kill","",3.00,null);
        EntFire("spx_avada_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(2, 0);",3.00,AVADAACT);
		EntFire("console","Command","sm_setcooldown 8977961 140",3.00,null);
    }
    else if(AVADALEVEL == 1)
    {
        AvadaItemLevel1M();
        AVADAMAXUSES = 3;
        EntFire("spx_effect_upgrade_avada","Start","",0.00,null);
        EntFire("spx_effect_upgrade_avada","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_avada","Stop","",1.00,null);
        EntFire("spx_avada_trigger2","ClearParent","",2.00,null);
        EntFire("spx_avada_trigger3","ClearParent","",2.00,null);
        EntFire("spx_avada_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_avada_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_avada","Kill","",2.00,null);
        EntFire("spx_avada_trigger2","Kill","",3.00,null);
        EntFire("spx_avada_trigger3","Kill","",3.00,null);
        EntFire("spx_avada_effect_active2","Kill","",3.00,null);
        EntFire("spx_avada_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(2, 1);",3.00,AVADAACT);
		EntFire("console","Command","sm_setcooldown 8977961 135",3.00,null);
        
    }
    else if(AVADALEVEL == 2)
    {
        AvadaItemLevel2M();
        ZMITEMLVLUP++;
        AVADAMAXUSES = 3;
        EntFire("spx_effect_upgrade_avada","Start","",0.00,null);
        EntFire("spx_effect_upgrade_avada","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_avada","Stop","",1.00,null);
        EntFire("spx_avada_trigger","ClearParent","",2.00,null);
        EntFire("spx_avada_trigger3","ClearParent","",2.00,null);
        EntFire("spx_avada_effect_active","ClearParent","",2.00,null);
        EntFire("spx_avada_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_avada","Kill","",2.00,null);
        EntFire("spx_avada_trigger","Kill","",3.00,null);
        EntFire("spx_avada_trigger3","Kill","",3.00,null);
        EntFire("spx_avada_effect_active","Kill","",3.00,null);
        EntFire("spx_avada_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(2, 2);",3.00,AVADAACT);
        EntFire("console","Command","sm_setcooldown 8977961 130",3.00,null);
    }
    else if(AVADALEVEL == 3)
    {
        AvadaItemLevel3M();
        ZMITEMLVLUP++;
        AVADAMAXUSES = 3;
        EntFire("spx_effect_upgrade_avada","Start","",0.00,null);
        EntFire("spx_effect_upgrade_avada","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_avada","Stop","",1.00,null);
        EntFire("spx_avada_trigger","ClearParent","",2.00,null);
        EntFire("spx_avada_trigger2","ClearParent","",2.00,null);
        EntFire("spx_avada_effect_active","ClearParent","",2.00,null);
        EntFire("spx_avada_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_avada","Kill","",2.00,null);
        EntFire("spx_avada_trigger","Kill","",3.00,null);
        EntFire("spx_avada_trigger2","Kill","",3.00,null);
        EntFire("spx_avada_effect_active","Kill","",3.00,null);
        EntFire("spx_avada_effect_active2","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(2, 3);",3.00,AVADAACT);
		EntFire("console","Command","sm_setcooldown 8977961 125",3.00,null);
    }
    else if(AVADALEVEL == 4)
    {
        AvadaItemLevel4M();
        ZMITEMLVLUP++;
        AVADAMAXUSES = 3;
        EntFire("spx_effect_upgrade_avada","Start","",0.00,null);
        EntFire("spx_effect_upgrade_avada","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_avada","Stop","",1.00,null);
        EntFire("spx_avada_trigger","ClearParent","",2.00,null);
        EntFire("spx_avada_trigger2","ClearParent","",2.00,null);
        EntFire("spx_avada_effect_active","ClearParent","",2.00,null);
        EntFire("spx_avada_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_avada","Kill","",2.00,null);
        EntFire("spx_avada_trigger","Kill","",3.00,null);
        EntFire("spx_avada_trigger2","Kill","",3.00,null);
        EntFire("spx_avada_effect_active","Kill","",3.00,null);
        EntFire("spx_avada_effect_active2","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(2, 4);",3.00,AVADAACT);
		EntFire("console","Command","sm_setcooldown 8977961 120",3.00,null);
    }
}

function UseItemAvada()
{
    if(activator.GetTeam() == 3 && activator == AVADAACT && AVADAUSES <= AVADAMAXUSES && !ITEM_DISABLE)
    { 
        AVADAUSES++;
        EntFire("spx_avada_effect_active*","Start","", 0.00, null);
        EntFire("spx_avada_button","Lock","", 0.00, null);
		EntFire("spx_effect_wand_avada","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spx_avada_wandprop","Color","255 28 28", 0.00, null);
        EntFire("spx_avada_zms_exit","Kill","", 1.00, null);
        EntFire("spx_avada_zms_light","TurnOff","", 2.00, null);
        EntFire("!activator","RunScriptCode","AvadaUsedText();",4.99,AVADAACT);
        EntFireByHandle(self, "RunScriptCode", "SaveAvadaZmTp();", 9.00, null, null);
        EntFire("spx_avada_trigger*","Enable","", 10.00, null);
        EntFire("spx_avada_effect_active*","DestroyImmediately","", 11.00, null);
        EntFire("spx_avada_trigger*","Disable","", 11.00, null);
        if(AVADALEVEL == 0)
        {
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",120.00,AVADAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",130.00,AVADAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",140.00,AVADAACT);
            EntFire("spx_avada_wandprop","Color","17 255 77",140.00,null);
            EntFire("spx_effect_wand_avada","Start","",140.00,null);
            EntFire("spx_avada_button","UnLock","",140.00,null);
        }
        else if(AVADALEVEL == 1)
        {
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",115.00,AVADAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",125.00,AVADAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",135.00,AVADAACT);
            EntFire("spx_avada_wandprop","Color","17 255 77",135.00,null);
            EntFire("spx_effect_wand_avada","Start","",135.00,null);
            EntFire("spx_avada_button","UnLock","",135.00,null);
        }
        else if(AVADALEVEL == 2)
        {
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",110.00,AVADAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",120.00,AVADAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",130.00,AVADAACT);
            EntFire("spx_avada_wandprop","Color","17 255 77",130.00,null);
            EntFire("spx_effect_wand_avada","Start","",130.00,null);
            EntFire("spx_avada_button","UnLock","",130.00,null);
        }
        else if(AVADALEVEL == 3)
        {
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",105.00,AVADAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",115.00,AVADAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",125.00,AVADAACT);
            EntFire("spx_avada_wandprop","Color","17 255 77",125.00,null);
            EntFire("spx_effect_wand_avada","Start","",125.00,null);
            EntFire("spx_avada_button","UnLock","",125.00,null);
        }
        else if(AVADALEVEL == 4)
        {
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",100.00,AVADAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",110.00,AVADAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",120.00,AVADAACT);
            EntFire("spx_avada_wandprop","Color","17 255 77",120.00,null);
            EntFire("spx_effect_wand_avada","Start","",120.00,null);
            EntFire("spx_avada_button","UnLock","",120.00,null);
        }
        if(AVADAUSES >= AVADAMAXUSES)
        {
            EntFire("spx_avada_button","Lock","", 0.00, null);
            EntFire("spx_effect_wand_avada","Stop","", 0.00, null);
            EntFire("spx_avada_button","ClearParent","", 18.00, null);
            EntFire("spx_avada_trigger*","ClearParent","", 18.00, null);
            EntFire("spx_effect_wand_avada","ClearParent","", 18.00, null);
            EntFire("spx_avada_effect_active*","ClearParent","", 18.00, null);
            EntFire("spx_avada_trigger*","Disable","", 19.00, null);
            EntFire("spx_avada_effect_active*","Stop","", 19.00, null);
            EntFire("spx_avada_zms_light","TurnOff","", 19.00, null);
            EntFire("spx_avada_telefix","Kill","", 19.50, null);
            EntFire("spx_avada_button","Kill","", 19.50, null);
            EntFire("spx_avada_trigger*","Kill","", 20.00, null);
            EntFire("spx_avada_zms_*","Kill","", 20.00, null);
            EntFire("spx_effect_wand_avada","Kill","", 20.50, null);
            EntFire("spx_avada_effect_active*","Kill","", 20.50, null);
        }
    }
}

function SaveAvadaZmTp()
{
    local h = null;
	while(null != (h = Entities.FindInSphere(h,AVADAACT.GetOrigin(),1000)))
	{
		if(h.GetTeam() == 2 && h.GetHealth() > 0 && h.IsValid())
		{
            EntFireByHandle(h,"addoutput","origin -256 1888 -1936",0.00,null,null);
            EntFire("item_speedmod","ModifySpeed","0",0.00,h);
            EntFire("spx_avada_zms_light","TurnOn","",0.00,null);
            EntFire("item_speedmod","ModifySpeed","0",0.50,h);
            EntFire("spx_avada_telefix","ForceSpawn","",4.00,null);
            EntFire("spx_avada_zms_exit","Kill","",6.00,null);
            EntFire("spx_avada_zms_light","TurnOff","",7.00,null);
			return;
		}
	}
}

function AvadaItemM()
{
    ScriptPrintMessageChatAll("ITEM PICKUP: \x03>>> AVADA SPELL HAS BEEN PICKED UP <<<");
}

function AvadaItemLevel1M()
{
    ScriptPrintMessageChatAll(" \x03>>> APPLYING 1 YEAR EXPERIENCE TO AVADA [1/4] <<<");
}

function AvadaItemLevel2M()
{
    ScriptPrintMessageChatAll(" \x03>>> APPLYING 2 YEAR EXPERIENCE TO AVADA [2/4] <<<");
}

function AvadaItemLevel3M()
{
    ScriptPrintMessageChatAll(" \x03>>> APPLYING 3 YEAR EXPERIENCE TO AVADA [3/4] <<<");
}

function AvadaItemLevel4M()
{
    ScriptPrintMessageChatAll(" \x03>>> APPLYING 4 YEAR EXPERIENCE TO AVADA [4/4] <<<");
}
//OnUser1 spx_avada_activator:Trigger::0:1
////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
FLIPENDOACT <- null;
FLIPENDOCALL <- null;
FLIPENDOONCE <- true;
FLIPENDOLEVEL <- 0;
////////////////////////////////

////////////////////////////////
////////////FLIPENDO////////////
////////////////////////////////

function PickUpFlipendo()
{
    FLIPENDOACT = activator;
    FLIPENDOCALL = caller;
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, FLIPENDOACT);
    EntFire("!activator", "AddOutput", "rendercolor 207 207 207", 0.30, FLIPENDOACT);
    EntFireByHandle(self,"RunScriptCode","FlipendoItemM();",2.00,null,null);
    if(FLIPENDOONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11456 9456 13630", 0.10, FLIPENDOACT);
        EntFire("!activator", "RunScriptCode", "GetItemLevelFlipendo();", 0.00, FLIPENDOACT);
        EntFireByHandle(self,"RunScriptCode","FlipendoReceivedLevel();",0.01,null,null);
        EntFire("map_equip_guns", "Use", "", 0.40, FLIPENDOACT);
        FLIPENDOONCE = false;
    }
}

function FlipendoReceivedLevel()
{
    if(FLIPENDOLEVEL == 0)
    {
        EntFire("spx_effect_upgrade_flipendo","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_flipendo","Stop","",1.00,null);
        EntFire("spx_flipendo_trigger2","ClearParent","",2.00,null);
        EntFire("spx_flipendo_trigger3","ClearParent","",2.00,null);
        EntFire("spx_flipendo_trigger4","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active4","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_flipendo","Kill","",2.00,null);
        EntFire("spx_flipendo_trigger2","Kill","",3.00,null);
        EntFire("spx_flipendo_trigger3","Kill","",3.00,null);
        EntFire("spx_flipendo_trigger4","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active2","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active3","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active4","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(3, 0);",3.00,FLIPENDOACT);
		EntFire("console","Command","sm_setcooldown 8977321 60",3.00,null);
    }
    else if(FLIPENDOLEVEL == 1)
    {
        FlipendoItemLevel1M();
        EntFire("spx_effect_upgrade_flipendo","Start","",0.00,null);
        EntFire("spx_effect_upgrade_flipendo","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_flipendo","Stop","",1.00,null);
        EntFire("spx_flipendo_trigger2","ClearParent","",2.00,null);
        EntFire("spx_flipendo_trigger3","ClearParent","",2.00,null);
        EntFire("spx_flipendo_trigger4","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active4","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_flipendo","Kill","",2.00,null);
        EntFire("spx_flipendo_trigger2","Kill","",3.00,null);
        EntFire("spx_flipendo_trigger3","Kill","",3.00,null);
        EntFire("spx_flipendo_trigger4","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active2","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active3","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active4","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(3, 1);",3.00,FLIPENDOACT);
		EntFire("console","Command","sm_setcooldown 8977321 55",3.00,null);
    }
    else if(FLIPENDOLEVEL == 2)
    {
        FlipendoItemLevel2M();
        ZMITEMLVLUP++;
        EntFire("spx_effect_upgrade_flipendo","Start","",0.00,null);
        EntFire("spx_effect_upgrade_flipendo","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_flipendo","Stop","",1.00,null);
        EntFire("spx_flipendo_trigger","ClearParent","",2.00,null);
        EntFire("spx_flipendo_trigger3","ClearParent","",2.00,null);
        EntFire("spx_flipendo_trigger4","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active4","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_flipendo","Kill","",2.00,null);
        EntFire("spx_flipendo_trigger","Kill","",3.00,null);
        EntFire("spx_flipendo_trigger3","Kill","",3.00,null);
        EntFire("spx_flipendo_trigger4","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active3","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active4","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(3, 2);",3.00,FLIPENDOACT);
		EntFire("console","Command","sm_setcooldown 8977321 55",3.00,null);
    }
    else if(FLIPENDOLEVEL == 3)
    {
        FlipendoItemLevel3M();
        ZMITEMLVLUP++;
        EntFire("spx_effect_upgrade_flipendo","Start","",0.00,null);
        EntFire("spx_effect_upgrade_flipendo","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_flipendo","Stop","",1.00,null);
        EntFire("spx_flipendo_trigger","ClearParent","",2.00,null);
        EntFire("spx_flipendo_trigger2","ClearParent","",2.00,null);
        EntFire("spx_flipendo_trigger4","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active4","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_flipendo","Kill","",2.00,null);
        EntFire("spx_flipendo_trigger","Kill","",3.00,null);
        EntFire("spx_flipendo_trigger2","Kill","",3.00,null);
        EntFire("spx_flipendo_trigger4","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active2","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active4","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(3, 3);",3.00,FLIPENDOACT);
		EntFire("console","Command","sm_setcooldown 8977321 50",3.00,null);
    }
    else if(FLIPENDOLEVEL == 4)
    {
        FlipendoItemLevel4M();
        ZMITEMLVLUP++;
        EntFire("spx_effect_upgrade_flipendo","Start","",0.00,null);
        EntFire("spx_effect_upgrade_flipendo","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_flipendo","Stop","",1.00,null);
        EntFire("spx_flipendo_trigger","ClearParent","",2.00,null);
        EntFire("spx_flipendo_trigger2","ClearParent","",2.00,null);
        EntFire("spx_flipendo_trigger3","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_flipendo_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_flipendo","Kill","",2.00,null);
        EntFire("spx_flipendo_trigger","Kill","",3.00,null);
        EntFire("spx_flipendo_trigger2","Kill","",3.00,null);
        EntFire("spx_flipendo_trigger3","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active2","Kill","",3.00,null);
        EntFire("spx_flipendo_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(3, 4);",3.00,FLIPENDOACT);
		EntFire("console","Command","sm_setcooldown 8977321 45",3.00,null);
    }
}

function UseItemFlipendo()
{
    if(activator.GetTeam() == 3 && activator == FLIPENDOACT && !ITEM_DISABLE)
    { 
        EntFire("spx_flipendo_button","Lock","", 0.00, null);
        EntFire("spx_flipendo_trigger*","Enable","", 0.00, null);
        EntFire("spx_effect_wand_flipendo","Stop","", 0.00, null);
        EntFire("spx_flipendo_effect_active*","Start","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spx_flipendo_wandprop","Color","255 28 28", 0.00, null);
        if(FLIPENDOLEVEL == 0)
        {
            EntFire("spx_flipendo_effect_active*","Stop","", 4.00, null);
            EntFire("spx_flipendo_trigger*","Disable","", 4.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",40.00,FLIPENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",50.00,FLIPENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",60.00,FLIPENDOACT);
            EntFire("spx_flipendo_wandprop","Color","17 255 77",60.00,null);
            EntFire("spx_effect_wand_flipendo","Start","",60.00,null);
            EntFire("spx_flipendo_button","UnLock","",60.00,null);
        }
        else if(FLIPENDOLEVEL == 1)
        {
            EntFire("spx_flipendo_effect_active*","Stop","", 4.00, null);
            EntFire("spx_flipendo_trigger*","Disable","", 4.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",35.00,FLIPENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",45.00,FLIPENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",55.00,FLIPENDOACT);
            EntFire("spx_flipendo_wandprop","Color","17 255 77",55.00,null);
            EntFire("spx_effect_wand_flipendo","Start","",55.00,null);
            EntFire("spx_flipendo_button","UnLock","",55.00,null);
        }
        else if(FLIPENDOLEVEL == 2)
        {
            EntFire("spx_flipendo_effect_active*","Stop","", 5.00, null);
            EntFire("spx_flipendo_trigger*","Disable","", 5.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",35.00,FLIPENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",45.00,FLIPENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",55.00,FLIPENDOACT);
            EntFire("spx_flipendo_wandprop","Color","17 255 77",55.00,null);
            EntFire("spx_effect_wand_flipendo","Start","",55.00,null);
            EntFire("spx_flipendo_button","UnLock","",55.00,null);
        }
        else if(FLIPENDOLEVEL == 3)
        {
            EntFire("spx_flipendo_effect_active*","Stop","", 5.00, null);
            EntFire("spx_flipendo_trigger*","Disable","", 5.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,FLIPENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,FLIPENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,FLIPENDOACT);
            EntFire("spx_flipendo_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_flipendo","Start","",50.00,null);
            EntFire("spx_flipendo_button","UnLock","",50.00,null);
        }
        else if(FLIPENDOLEVEL == 4)
        {
            EntFire("spx_flipendo_effect_active*","Stop","", 5.00, null);
            EntFire("spx_flipendo_trigger*","Disable","", 5.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",25.00,FLIPENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",35.00,FLIPENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",45.00,FLIPENDOACT);
            EntFire("spx_flipendo_wandprop","Color","17 255 77",45.00,null);
            EntFire("spx_effect_wand_flipendo","Start","",45.00,null);
            EntFire("spx_flipendo_button","UnLock","",45.00,null);
        }
    }
}

function FlipendoItemM()
{
    ScriptPrintMessageChatAll("ITEM PICKUP: \x08>>> FLIPENDO SPELL HAS BEEN PICKED UP <<<");
}

function FlipendoItemLevel1M()
{
    ScriptPrintMessageChatAll(" \x08>>> APPLYING 1 YEAR EXPERIENCE TO FLIPENDO [1/4] <<<");
}

function FlipendoItemLevel2M()
{
    ScriptPrintMessageChatAll(" \x08>>> APPLYING 2 YEAR EXPERIENCE TO FLIPENDO [2/4] <<<");
}

function FlipendoItemLevel3M()
{
    ScriptPrintMessageChatAll(" \x08>>> APPLYING 3 YEAR EXPERIENCE TO FLIPENDO [3/4] <<<");
}

function FlipendoItemLevel4M()
{
    ScriptPrintMessageChatAll(" \x08>>> APPLYING 4 YEAR EXPERIENCE TO FLIPENDO [4/4] <<<");
}
//OnUser1 spx_flipendo_activator:Trigger::0:1
////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
IMPEDIMENTAACT <- null;
IMPEDIMENTACALL <- null;
IMPEDIMENTAONCE <- true;
IMPEDIMENTALEVEL <- 0;
////////////////////////////////

////////////////////////////////
///////////IMPEDIMENTA//////////
////////////////////////////////

function PickUpImpedimenta()
{
    IMPEDIMENTAACT = activator;
    IMPEDIMENTACALL = caller;
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, IMPEDIMENTAACT);
    EntFire("!activator", "AddOutput", "rendercolor 0 112 166", 0.30, IMPEDIMENTAACT);
    EntFireByHandle(self,"RunScriptCode","ImpedimentaItemM();",2.00,null,null);
    if(IMPEDIMENTAONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11456 9456 13630", 0.10, IMPEDIMENTAACT);
        EntFire("!activator", "RunScriptCode", "GetItemLevelImpedimenta();", 0.00, IMPEDIMENTAACT);
        EntFireByHandle(self,"RunScriptCode","ImpedimentaReceivedLevel();",0.01,null,null);
        EntFire("map_equip_guns", "Use", "", 0.40, IMPEDIMENTAACT);
        IMPEDIMENTAONCE = false;
    }
}

function ImpedimentaReceivedLevel()
{
    if(IMPEDIMENTALEVEL == 0)
    {
        EntFire("spx_impedimenta_spwnr_entmaker","AddOutput","EntityTemplate spx_impedimenta_spwnr_template",0.00,null);
        EntFire("spx_effect_upgrade_impedimenta","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Stop","",1.00,null);
        EntFire("spx_impedimenta_trig_zombies2","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies3","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active4","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Kill","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies2","Kill","",3.00,null);
        EntFire("spx_impedimenta_trig_zombies3","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active2","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active3","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active4","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(4, 0);",3.00,IMPEDIMENTAACT);
		EntFire("console","Command","sm_setcooldown 8975848 70",3.00,null);
    }
    else if(IMPEDIMENTALEVEL == 1)
    {
        ImpedimentaItemLevel1M();
        EntFire("spx_impedimenta_spwnr_entmaker","AddOutput","EntityTemplate spx_impedimenta_spwnr_template2",0.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Start","",0.00,null);
        EntFire("spx_effect_upgrade_impedimenta","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Stop","",1.00,null);
        EntFire("spx_impedimenta_trig_zombies","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies3","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies4","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active4","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Kill","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies","Kill","",3.00,null);
        EntFire("spx_impedimenta_trig_zombies3","Kill","",3.00,null);
        EntFire("spx_impedimenta_trig_zombies4","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active3","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active4","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(4, 1);",3.00,IMPEDIMENTAACT);
		EntFire("console","Command","sm_setcooldown 8975848 65",3.00,null);
    }
    else if(IMPEDIMENTALEVEL == 2)
    {
        ImpedimentaItemLevel2M();
        ZMITEMLVLUP++;
        EntFire("spx_impedimenta_spwnr_entmaker","AddOutput","EntityTemplate spx_impedimenta_spwnr_template3",0.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Start","",0.00,null);
        EntFire("spx_effect_upgrade_impedimenta","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Stop","",1.00,null);
        EntFire("spx_impedimenta_trig_zombies","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies2","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies4","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active4","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Kill","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies","Kill","",3.00,null);
        EntFire("spx_impedimenta_trig_zombies2","Kill","",3.00,null);
        EntFire("spx_impedimenta_trig_zombies4","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active2","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active4","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(4, 2);",3.00,IMPEDIMENTAACT);
		EntFire("console","Command","sm_setcooldown 8975848 60",3.00,null);
    }
    else if(IMPEDIMENTALEVEL == 3)
    {
        ImpedimentaItemLevel3M();
        ZMITEMLVLUP++;
        EntFire("spx_impedimenta_spwnr_entmaker","AddOutput","EntityTemplate spx_impedimenta_spwnr_template4",0.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Start","",0.00,null);
        EntFire("spx_effect_upgrade_impedimenta","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Stop","",1.00,null);
        EntFire("spx_impedimenta_trig_zombies","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies2","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies3","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Kill","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies","Kill","",3.00,null);
        EntFire("spx_impedimenta_trig_zombies2","Kill","",3.00,null);
        EntFire("spx_impedimenta_trig_zombies3","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active2","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(4, 3);",3.00,IMPEDIMENTAACT);
		EntFire("console","Command","sm_setcooldown 8975848 55",3.00,null);
    }
    else if(IMPEDIMENTALEVEL == 4)
    {
        ImpedimentaItemLevel4M();
        ZMITEMLVLUP++;
        EntFire("spx_impedimenta_spwnr_entmaker","AddOutput","EntityTemplate spx_impedimenta_spwnr_template4",0.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Start","",0.00,null);
        EntFire("spx_effect_upgrade_impedimenta","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Stop","",1.00,null);
        EntFire("spx_impedimenta_trig_zombies","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies2","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies3","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_impedimenta_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_impedimenta","Kill","",2.00,null);
        EntFire("spx_impedimenta_trig_zombies","Kill","",3.00,null);
        EntFire("spx_impedimenta_trig_zombies2","Kill","",3.00,null);
        EntFire("spx_impedimenta_trig_zombies3","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active2","Kill","",3.00,null);
        EntFire("spx_impedimenta_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(4, 4);",3.00,IMPEDIMENTAACT);
		EntFire("console","Command","sm_setcooldown 8975848 50",3.00,null);
    }
}

function UseItemImpedimenta()
{
    if(activator.GetTeam() == 3 && activator == IMPEDIMENTAACT && !ITEM_DISABLE)
    { 
        EntFire("spx_impedimenta_spwnr_entmaker","ForceSpawn","", 0.00, null);
        EntFire("spx_impedimenta_button","Lock","", 0.00, null);
        EntFire("spx_effect_wand_impedimenta","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spx_impedimenta_wandprop","Color","255 28 28", 0.00, null);
        EntFire("spx_impedimenta_effect_active*","Kill","", 15.00, null);
        EntFire("spx_impedimenta_trig_*","Kill","", 15.00, null);
        if(IMPEDIMENTALEVEL == 0)
        {
            EntFire("spx_impedimenta_effect_active*","Stop","", 4.00, null);
            EntFire("spx_impedimenta_trig_*","Disable","", 4.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",50.00,IMPEDIMENTAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",60.00,IMPEDIMENTAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",70.00,IMPEDIMENTAACT);
            EntFire("spx_impedimenta_wandprop","Color","17 255 77",70.00,null);
            EntFire("spx_effect_wand_impedimenta","Start","",70.00,null);
            EntFire("spx_impedimenta_button","UnLock","",70.00,null);
        }
        else if(IMPEDIMENTALEVEL == 1)
        {
            EntFire("spx_impedimenta_effect_active*","Stop","", 4.00, null);
            EntFire("spx_impedimenta_trig_*","Disable","", 4.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",45.00,IMPEDIMENTAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",55.00,IMPEDIMENTAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",65.00,IMPEDIMENTAACT);
            EntFire("spx_impedimenta_wandprop","Color","17 255 77",65.00,null);
            EntFire("spx_effect_wand_impedimenta","Start","",65.00,null);
            EntFire("spx_impedimenta_button","UnLock","",65.00,null);
        }
        else if(IMPEDIMENTALEVEL == 2)
        {
            EntFire("spx_impedimenta_effect_active*","Stop","", 5.00, null);
            EntFire("spx_impedimenta_trig_*","Disable","", 5.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",40.00,IMPEDIMENTAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",50.00,IMPEDIMENTAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",60.00,IMPEDIMENTAACT);
            EntFire("spx_impedimenta_wandprop","Color","17 255 77",60.00,null);
            EntFire("spx_effect_wand_impedimenta","Start","",60.00,null);
            EntFire("spx_impedimenta_button","UnLock","",60.00,null);
        }
        else if(IMPEDIMENTALEVEL == 3)
        {
            EntFire("spx_impedimenta_effect_active*","Stop","", 5.00, null);
            EntFire("spx_impedimenta_trig_*","Disable","", 5.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",35.00,IMPEDIMENTAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",45.00,IMPEDIMENTAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",55.00,IMPEDIMENTAACT);
            EntFire("spx_impedimenta_wandprop","Color","17 255 77",55.00,null);
            EntFire("spx_effect_wand_impedimenta","Start","",55.00,null);
            EntFire("spx_impedimenta_button","UnLock","",55.00,null);
        }
        else if(IMPEDIMENTALEVEL == 4)
        {
            EntFire("spx_impedimenta_effect_active*","Stop","", 5.00, null);
            EntFire("spx_impedimenta_trig_*","Disable","", 5.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,IMPEDIMENTAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,IMPEDIMENTAACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,IMPEDIMENTAACT);
            EntFire("spx_impedimenta_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_impedimenta","Start","",50.00,null);
            EntFire("spx_impedimenta_button","UnLock","",50.00,null);
        }
    }
}

function ImpedimentaItemM()
{
    ScriptPrintMessageChatAll("ITEM PICKUP: \x0C>>> IMPEDIMENTA SPELL HAS BEEN PICKED UP <<<");
}

function ImpedimentaItemLevel1M()
{
    ScriptPrintMessageChatAll(" \x0C>>> APPLYING 1 YEAR EXPERIENCE TO IMPEDIMENTA [1/4] <<<");
}

function ImpedimentaItemLevel2M()
{
    ScriptPrintMessageChatAll(" \x0C>>> APPLYING 2 YEAR EXPERIENCE TO IMPEDIMENTA [2/4] <<<");
}

function ImpedimentaItemLevel3M()
{
    ScriptPrintMessageChatAll(" \x0C>>> APPLYING 3 YEAR EXPERIENCE TO IMPEDIMENTA [3/4] <<<");
}

function ImpedimentaItemLevel4M()
{
    ScriptPrintMessageChatAll(" \x0C>>> APPLYING 4 YEAR EXPERIENCE TO IMPEDIMENTA [4/4] <<<");
}
//OnUser1 spx_impedimenta_activator:Trigger::0:1
////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
INCENDIOACT <- null;
INCENDIOCALL <- null;
INCENDIOONCE <- true;
INCENDIOLEVEL <- 0;
////////////////////////////////

////////////////////////////////
////////////INCENDIO////////////
////////////////////////////////

function PickUpIncendio()
{
    INCENDIOACT = activator;
    INCENDIOCALL = caller;
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, INCENDIOACT);
    EntFire("!activator", "AddOutput", "rendercolor 255 34 34", 0.30, INCENDIOACT);
    EntFireByHandle(self,"RunScriptCode","IncendioItemM();",2.00,null,null);
    if(INCENDIOONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11456 9456 13630", 0.10, INCENDIOACT);
        EntFire("!activator", "RunScriptCode", "GetItemLevelIncendio();", 0.00, INCENDIOACT);
        EntFireByHandle(self,"RunScriptCode","IncendioReceivedLevel();",0.01,null,null);
        EntFire("map_equip_guns", "Use", "", 0.40, INCENDIOACT);
        INCENDIOONCE = false;
    }
}

function IncendioReceivedLevel()
{
    if(INCENDIOLEVEL == 0)
    {
        EntFire("spx_incendio_spwnr_entmaker","AddOutput","EntityTemplate spx_incendio_spwnr_template",0.00,null);
        EntFire("spx_effect_upgrade_incendio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_incendio","Stop","",1.00,null);
        EntFire("spx_incendio_trigger1","ClearParent","",2.00,null);
        EntFire("spx_incendio_trigger2","ClearParent","",2.00,null);
        EntFire("spx_incendio_trigger3","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active1","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_incendio","Kill","",2.00,null);
        EntFire("spx_incendio_trigger1","Kill","",3.00,null);
        EntFire("spx_incendio_trigger2","Kill","",3.00,null);
        EntFire("spx_incendio_trigger3","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active1","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active2","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(5, 0);",3.00,INCENDIOACT);
		EntFire("console","Command","sm_setcooldown 8974097 55",3.00,null);
    }
    else if(INCENDIOLEVEL == 1)
    {
        IncendioItemLevel1M();
        EntFire("spx_incendio_spwnr_entmaker","AddOutput","EntityTemplate spx_incendio_spwnr_template1",0.00,null);
        EntFire("spx_effect_upgrade_incendio","Start","",0.00,null);
        EntFire("spx_effect_upgrade_incendio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_incendio","Stop","",1.00,null);
        EntFire("spx_incendio_trigger","ClearParent","",2.00,null);
        EntFire("spx_incendio_trigger2","ClearParent","",2.00,null);
        EntFire("spx_incendio_trigger3","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_incendio","Kill","",2.00,null);
        EntFire("spx_incendio_trigger","Kill","",3.00,null);
        EntFire("spx_incendio_trigger2","Kill","",3.00,null);
        EntFire("spx_incendio_trigger3","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active2","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(5, 1);",3.00,INCENDIOACT);
		EntFire("console","Command","sm_setcooldown 8974097 50",3.00,null);
    }
    else if(INCENDIOLEVEL == 2)
    {
        IncendioItemLevel2M();
        ZMITEMLVLUP++;
        EntFire("spx_incendio_spwnr_entmaker","AddOutput","EntityTemplate spx_incendio_spwnr_template2",0.00,null);
        EntFire("spx_effect_upgrade_incendio","Start","",0.00,null);
        EntFire("spx_effect_upgrade_incendio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_incendio","Stop","",1.00,null);
        EntFire("spx_incendio_trigger","ClearParent","",2.00,null);
        EntFire("spx_incendio_trigger1","ClearParent","",2.00,null);
        EntFire("spx_incendio_trigger3","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active1","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_incendio","Kill","",2.00,null);
        EntFire("spx_incendio_trigger","Kill","",3.00,null);
        EntFire("spx_incendio_trigger1","Kill","",3.00,null);
        EntFire("spx_incendio_trigger3","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active1","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(5, 2);",3.00,INCENDIOACT);
		EntFire("console","Command","sm_setcooldown 8974097 50",3.00,null);
    }
    else if(INCENDIOLEVEL == 3)
    {
        IncendioItemLevel3M();
        ZMITEMLVLUP++;
        EntFire("spx_incendio_spwnr_entmaker","AddOutput","EntityTemplate spx_incendio_spwnr_template3",0.00,null);
        EntFire("spx_effect_upgrade_incendio","Start","",0.00,null);
        EntFire("spx_effect_upgrade_incendio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_incendio","Stop","",1.00,null);
        EntFire("spx_incendio_trigger","ClearParent","",2.00,null);
        EntFire("spx_incendio_trigger1","ClearParent","",2.00,null);
        EntFire("spx_incendio_trigger2","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active1","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_incendio","Kill","",2.00,null);
        EntFire("spx_incendio_trigger","Kill","",3.00,null);
        EntFire("spx_incendio_trigger1","Kill","",3.00,null);
        EntFire("spx_incendio_trigger2","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active1","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active2","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(5, 3);",3.00,INCENDIOACT);
		EntFire("console","Command","sm_setcooldown 8974097 50",3.00,null);
    }
    else if(INCENDIOLEVEL == 4)
    {
        IncendioItemLevel4M();
        ZMITEMLVLUP++;
        EntFire("spx_incendio_spwnr_entmaker","AddOutput","EntityTemplate spx_incendio_spwnr_template3",0.00,null);
        EntFire("spx_effect_upgrade_incendio","Start","",0.00,null);
        EntFire("spx_effect_upgrade_incendio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_incendio","Stop","",1.00,null);
        EntFire("spx_incendio_trigger","ClearParent","",2.00,null);
        EntFire("spx_incendio_trigger1","ClearParent","",2.00,null);
        EntFire("spx_incendio_trigger2","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active1","ClearParent","",2.00,null);
        EntFire("spx_incendio_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_incendio","Kill","",2.00,null);
        EntFire("spx_incendio_trigger","Kill","",3.00,null);
        EntFire("spx_incendio_trigger1","Kill","",3.00,null);
        EntFire("spx_incendio_trigger2","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active1","Kill","",3.00,null);
        EntFire("spx_incendio_effect_active2","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(5, 4);",3.00,INCENDIOACT);
		EntFire("console","Command","sm_setcooldown 8974097 45",3.00,null);
    }
}

function UseItemIncendio()
{
    if(activator.GetTeam() == 3 && activator == INCENDIOACT && !ITEM_DISABLE)
    { 
        EntFire("spx_incendio_spwnr_entmaker","ForceSpawn","", 0.00, null);
        EntFire("spx_incendio_button","Lock","", 0.00, null);
        EntFire("spx_effect_wand_incendio","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spx_incendio_wandprop","Color","255 28 28", 0.00, null);
        EntFire("spx_incendio_effect_active*","Kill","", 15.00, null);
        EntFire("spx_incendio_trigger*","Kill","", 15.00, null);
        if(INCENDIOLEVEL == 0)
        {
            EntFire("spx_incendio_effect_active*","Stop","", 4.00, null);
            EntFire("spx_incendio_trigger*","Disable","", 4.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",35.00,INCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",45.00,INCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",55.00,INCENDIOACT);
            EntFire("spx_incendio_wandprop","Color","17 255 77",55.00,null);
            EntFire("spx_effect_wand_incendio","Start","",55.00,null);
            EntFire("spx_incendio_button","UnLock","",55.00,null);
        }
        else if(INCENDIOLEVEL == 1)
        {
            EntFire("spx_incendio_effect_active*","Stop","", 4.00, null);
            EntFire("spx_incendio_trigger*","Disable","", 4.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,INCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,INCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,INCENDIOACT);
            EntFire("spx_incendio_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_incendio","Start","",50.00,null);
            EntFire("spx_incendio_button","UnLock","",50.00,null);
        }
        else if(INCENDIOLEVEL == 2)
        {
            EntFire("spx_incendio_effect_active*","Stop","", 5.00, null);
            EntFire("spx_incendio_trigger*","Disable","", 5.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,INCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,INCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,INCENDIOACT);
            EntFire("spx_incendio_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_incendio","Start","",50.00,null);
            EntFire("spx_incendio_button","UnLock","",50.00,null);
        }
        else if(INCENDIOLEVEL == 3)
        {
            EntFire("spx_incendio_effect_active*","Stop","", 6.00, null);
            EntFire("spx_incendio_trigger*","Disable","", 6.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,INCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,INCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,INCENDIOACT);
            EntFire("spx_incendio_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_incendio","Start","",50.00,null);
            EntFire("spx_incendio_button","UnLock","",50.00,null);
        }
        else if(INCENDIOLEVEL == 4)
        {
            EntFire("spx_incendio_effect_active*","Stop","", 6.00, null);
            EntFire("spx_incendio_trigger*","Disable","", 6.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",25.00,INCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",35.00,INCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",45.00,INCENDIOACT);
            EntFire("spx_incendio_wandprop","Color","17 255 77",45.00,null);
            EntFire("spx_effect_wand_incendio","Start","",45.00,null);
            EntFire("spx_incendio_button","UnLock","",45.00,null);
        }
    }
}

function IncendioItemM()
{
    ScriptPrintMessageChatAll("ITEM PICKUP: \x02>>> INCENDIO SPELL HAS BEEN PICKED UP <<<");
}

function IncendioItemLevel1M()
{
    ScriptPrintMessageChatAll(" \x02>>> APPLYING 1 YEAR EXPERIENCE TO INCENDIO [1/4] <<<");
}

function IncendioItemLevel2M()
{
    ScriptPrintMessageChatAll(" \x02>>> APPLYING 2 YEAR EXPERIENCE TO INCENDIO [2/4] <<<");
}

function IncendioItemLevel3M()
{
    ScriptPrintMessageChatAll(" \x02>>> APPLYING 3 YEAR EXPERIENCE TO INCENDIO [3/4] <<<");
}

function IncendioItemLevel4M()
{
    ScriptPrintMessageChatAll(" \x02>>> APPLYING 4 YEAR EXPERIENCE TO INCENDIO [4/4] <<<");
}
//OnUser1 spx_incendio_activator:Trigger::0:1
////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
ACCIOACT <- null;
ACCIOCALL <- null;
ACCIOONCE <- true;
ACCIOLEVEL <- 0;
ACCIOAMMO <- 0;
////////////////////////////////

////////////////////////////////
/////////////ACCIO//////////////
////////////////////////////////

function PickUpAccio()
{
    ACCIOACT = activator;
    ACCIOCALL = caller;
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, ACCIOACT);
    EntFire("!activator", "AddOutput", "rendercolor 215 215 0", 0.30, ACCIOACT);
    EntFireByHandle(self,"RunScriptCode","AccioItemM();",2.00,null,null);
    if(ACCIOONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11456 9456 13630", 0.10, ACCIOACT);
        EntFire("!activator", "RunScriptCode", "GetItemLevelAccio();", 0.00, ACCIOACT);
        EntFireByHandle(self,"RunScriptCode","AccioReceivedLevel();",0.01,null,null);
        EntFire("map_equip_guns", "Use", "", 0.40, ACCIOACT);
        ACCIOONCE = false;
    }
}

function AccioReceivedLevel()
{
    if(ACCIOLEVEL == 0)
    {
        ACCIOAMMO = 150;
        EntFire("spx_effect_upgrade_accio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_accio","Stop","",1.00,null);
        EntFire("spx_accio_trigger3","ClearParent","",2.00,null);
        EntFire("spx_accio_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_accio","Kill","",2.00,null);
        EntFire("spx_accio_spwnr_count","SetValueNoFire","2",2.00,null);
        EntFire("spx_accio_trigfix_end","Kill","",2.50,null);
        EntFire("spx_accio_trigger3","Kill","",3.00,null);
        EntFire("spx_accio_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(6, 0);",3.00,ACCIOACT);
		EntFire("console","Command","sm_setcooldown 17845448 50",3.00,null);
    }
    else if(ACCIOLEVEL == 1)
    {
        AccioItemLevel1M();
        ACCIOAMMO = 175;
        EntFire("spx_effect_upgrade_accio","Start","",0.00,null);
        EntFire("spx_effect_upgrade_accio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_accio","Stop","",1.00,null);
        EntFire("spx_accio_trigger3","ClearParent","",2.00,null);
        EntFire("spx_accio_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_accio","Kill","",2.00,null);
        EntFire("spx_accio_spwnr_count","SetValueNoFire","3",2.00,null);
        EntFire("spx_accio_trigfix_end","Kill","",2.50,null);
        EntFire("spx_accio_trigger3","Kill","",3.00,null);
        EntFire("spx_accio_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(6, 1);",3.00,ACCIOACT);
		EntFire("console","Command","sm_setcooldown 17845448 50",3.00,null);
    }
    else if(ACCIOLEVEL == 2)
    {
        AccioItemLevel2M();
        ZMITEMLVLUP++;
        ACCIOAMMO = 200;
        EntFire("spx_effect_upgrade_accio","Start","",0.00,null);
        EntFire("spx_effect_upgrade_accio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_accio","Stop","",1.00,null);
        EntFire("spx_accio_trigger3","ClearParent","",2.00,null);
        EntFire("spx_accio_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_accio","Kill","",2.00,null);
        EntFire("spx_accio_spwnr_count","SetValueNoFire","4",2.00,null);
        EntFire("spx_accio_trigfix_end","Kill","",2.50,null);
        EntFire("spx_accio_trigger3","Kill","",3.00,null);
        EntFire("spx_accio_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(6, 2);",3.00,ACCIOACT);
		EntFire("console","Command","sm_setcooldown 17845448 45",3.00,null);
    }
    else if(ACCIOLEVEL == 3)
    {
        AccioItemLevel3M();
        ZMITEMLVLUP++;
        ACCIOAMMO = 250;
        EntFire("spx_effect_upgrade_accio","Start","",0.00,null);
        EntFire("spx_effect_upgrade_accio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_accio","Stop","",1.00,null);
        EntFire("spx_accio_trigger","ClearParent","",2.00,null);
        EntFire("spx_accio_effect_active","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_accio","Kill","",2.00,null);
        EntFire("spx_accio_spwnr_count","SetValueNoFire","5",2.00,null);
        EntFire("spx_accio_trigfix_end","Kill","",2.50,null);
        EntFire("spx_accio_trigger","Kill","",3.00,null);
        EntFire("spx_accio_effect_active","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(6, 3);",3.00,ACCIOACT);
		EntFire("console","Command","sm_setcooldown 17845448 40",3.00,null);
    }
    else if(ACCIOLEVEL == 4)
    {
        AccioItemLevel4M();
        ZMITEMLVLUP++;
        ACCIOAMMO = 300;
        EntFire("spx_effect_upgrade_accio","Start","",0.00,null);
        EntFire("spx_effect_upgrade_accio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_accio","Stop","",1.00,null);
        EntFire("spx_accio_trigger","ClearParent","",2.00,null);
        EntFire("spx_accio_effect_active","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_accio","Kill","",2.00,null);
        EntFire("spx_accio_spwnr_count","SetValueNoFire","6",2.00,null);
        EntFire("spx_accio_trigfix_end","Kill","",2.50,null);
        EntFire("spx_accio_trigger","Kill","",3.00,null);
        EntFire("spx_accio_effect_active","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(6, 4);",3.00,ACCIOACT);
		EntFire("console","Command","sm_setcooldown 17845448 40",3.00,null);
    }
}

function UseItemAccio()
{
    if(activator.GetTeam() == 3 && activator == ACCIOACT && !ITEM_DISABLE)
    { 
        EntFire("spx_accio_button","Lock","", 0.00, null);
        GiveAmmoAccio();
        EntFire("spx_accio_effect_active*","Start","", 0.00, null);
        EntFire("spx_effect_wand_accio","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spx_accio_spwnr_relay","Enable","", 0.00, null);
        EntFire("spx_accio_wandprop","Color","255 28 28", 0.00, null);
        EntFire("spx_accio_timer","Enable","", 0.50, null);
        if(ACCIOLEVEL == 0)
        {
            EntFire("spx_accio_effect_active*","Stop","", 4.00, null);
            EntFireByHandle(self,"RunScriptCode","GiveAmmoAccio();",2.00,null,null);
            EntFireByHandle(self,"RunScriptCode","GiveAmmoAccio();",4.00,null,null);
            EntFire("spx_accio_t*","Disable","", 4.00, null);
            EntFire("spx_accio_spwnr_relay","Disable","", 4.00, null);
            EntFire("spx_accio_spwnr_count","SetValueNoFire","2", 48.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,ACCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,ACCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,ACCIOACT);
            EntFire("spx_accio_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_accio","Start","",50.00,null);
            EntFire("spx_accio_button","UnLock","",50.00,null);
        }
        else if(ACCIOLEVEL == 1)
        {
            EntFire("spx_accio_effect_active*","Stop","", 5.00, null);
            EntFireByHandle(self,"RunScriptCode","GiveAmmoAccio();",2.50,null,null);
            EntFireByHandle(self,"RunScriptCode","GiveAmmoAccio();",5.00,null,null);
            EntFire("spx_accio_t*","Disable","", 5.00, null);
            EntFire("spx_accio_spwnr_relay","Disable","", 5.00, null);
            EntFire("spx_accio_spwnr_count","SetValueNoFire","3", 48.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,ACCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,ACCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,ACCIOACT);
            EntFire("spx_accio_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_accio","Start","",50.00,null);
            EntFire("spx_accio_button","UnLock","",50.00,null);
        }
        else if(ACCIOLEVEL == 2)
        {
            EntFire("spx_accio_effect_active*","Stop","", 5.00, null);
            EntFireByHandle(self,"RunScriptCode","GiveAmmoAccio();",2.50,null,null);
            EntFireByHandle(self,"RunScriptCode","GiveAmmoAccio();",5.00,null,null);
            EntFire("spx_accio_t*","Disable","", 5.00, null);
            EntFire("spx_accio_spwnr_relay","Disable","", 5.00, null);
            EntFire("spx_accio_spwnr_count","SetValueNoFire","4", 48.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",25.00,ACCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",35.00,ACCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",45.00,ACCIOACT);
            EntFire("spx_accio_wandprop","Color","17 255 77",45.00,null);
            EntFire("spx_effect_wand_accio","Start","",45.00,null);
            EntFire("spx_accio_button","UnLock","",45.00,null);
        }
        else if(ACCIOLEVEL == 3)
        {
            EntFire("spx_accio_effect_active*","Stop","", 6.00, null);
            EntFireByHandle(self,"RunScriptCode","GiveAmmoAccio();",3.00,null,null);
            EntFireByHandle(self,"RunScriptCode","GiveAmmoAccio();",6.00,null,null);
            EntFire("spx_accio_t*","Disable","", 6.00, null);
            EntFire("spx_accio_spwnr_relay","Disable","", 6.00, null);
            EntFire("spx_accio_spwnr_count","SetValueNoFire","5", 38.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",20.00,ACCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",30.00,ACCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",40.00,ACCIOACT);
            EntFire("spx_accio_wandprop","Color","17 255 77",40.00,null);
            EntFire("spx_effect_wand_accio","Start","",40.00,null);
            EntFire("spx_accio_button","UnLock","",40.00,null);
        }
        else if(ACCIOLEVEL == 4)
        {
            EntFire("spx_accio_effect_active*","Stop","", 7.00, null);
            EntFireByHandle(self,"RunScriptCode","GiveAmmoAccio();",1.50,null,null);
            EntFireByHandle(self,"RunScriptCode","GiveAmmoAccio();",3.00,null,null);
            EntFireByHandle(self,"RunScriptCode","GiveAmmoAccio();",4.50,null,null);
            EntFireByHandle(self,"RunScriptCode","GiveAmmoAccio();",6.00,null,null);
            EntFireByHandle(self,"RunScriptCode","GiveAmmoAccio();",7.50,null,null);
            EntFire("spx_accio_t*","Disable","", 7.00, null);
            EntFire("spx_accio_spwnr_relay","Disable","", 7.00, null);
            EntFire("spx_accio_spwnr_count","SetValueNoFire","6", 38.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",20.00,ACCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",30.00,ACCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",40.00,ACCIOACT);
            EntFire("spx_accio_wandprop","Color","17 255 77",40.00,null);
            EntFire("spx_effect_wand_accio","Start","",40.00,null);
            EntFire("spx_accio_button","UnLock","",40.00,null);
        }
    }
}

function GiveAmmoAccio()
{
    local ammo = null;
    while(null != (ammo = Entities.FindByClassnameWithin(ammo,"weapon_*",ACCIOACT.GetOrigin(),768)))
    {
        if(ammo.GetOwner() != null &&
        ammo.GetClassname() != "weapon_axe" && 
        ammo.GetClassname() != "weapon_knife" &&
        ammo.GetClassname() != "weapon_breachcharge" &&
        ammo.GetClassname() != "weapon_c4" &&
        ammo.GetClassname() != "weapon_decoy" &&
        ammo.GetClassname() != "weapon_diversion" &&
        ammo.GetClassname() != "weapon_flashbang" &&
        ammo.GetClassname() != "weapon_healthshot" &&
        ammo.GetClassname() != "weapon_hegrenade" &&
        ammo.GetClassname() != "weapon_incgrenade" &&
        ammo.GetClassname() != "weapon_hammer" &&
        ammo.GetClassname() != "weapon_knifegg" &&
        ammo.GetClassname() != "weapon_molotov" &&
        ammo.GetClassname() != "weapon_smokegrenade" &&
        ammo.GetClassname() != "weapon_snowball" &&
        ammo.GetClassname() != "weapon_spanner" &&
        ammo.GetClassname() != "weapon_tagrenade" &&
        ammo.GetClassname() != "weapon_taser" &&
        ammo.GetClassname() != "weapon_bumpmine")
        {
            EntFireByHandle(ammo,"SetAmmoAmount",""+ACCIOAMMO,0.00,null,null);
        }  
	}
}

function AccioItemM()
{
    ScriptPrintMessageChatAll("ITEM PICKUP: \x09>>> ACCIO SPELL HAS BEEN PICKED UP <<<");
}

function AccioItemLevel1M()
{
    ScriptPrintMessageChatAll(" \x09>>> APPLYING 1 YEAR EXPERIENCE TO ACCIO [1/4] <<<");
}

function AccioItemLevel2M()
{
    ScriptPrintMessageChatAll(" \x09>>> APPLYING 2 YEAR EXPERIENCE TO ACCIO [2/4] <<<");
}

function AccioItemLevel3M()
{
    ScriptPrintMessageChatAll(" \x09>>> APPLYING 3 YEAR EXPERIENCE TO ACCIO [3/4] <<<");
}

function AccioItemLevel4M()
{
    ScriptPrintMessageChatAll(" \x09>>> APPLYING 4 YEAR EXPERIENCE TO ACCIO [4/4] <<<");
}
//OnUser1 spx_accio_activator:Trigger::0:1
////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
CRUCIOACT <- null;
CRUCIOCALL <- null;
CRUCIOONCE <- true;
CRUCIOLEVEL <- 0;
////////////////////////////////

////////////////////////////////
/////////////CRUCIO/////////////
////////////////////////////////

function PickUpCrucio()
{
    CRUCIOACT = activator;
    CRUCIOCALL = caller;
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, CRUCIOACT);
    EntFire("!activator", "AddOutput", "rendercolor 240 120 0", 0.30, CRUCIOACT);
    EntFireByHandle(self,"RunScriptCode","CrucioItemM();",2.00,null,null);
    if(CRUCIOONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11456 9456 13630", 0.10, CRUCIOACT);
        EntFire("!activator", "RunScriptCode", "GetItemLevelCrucio();", 0.00, CRUCIOACT);
        EntFireByHandle(self,"RunScriptCode","CrucioReceivedLevel();",0.01,null,null);
        EntFire("map_equip_guns", "Use", "", 0.40, CRUCIOACT);
        CRUCIOONCE = false;
    }
}

function CrucioReceivedLevel()
{
    if(CRUCIOLEVEL == 0)
    {
        EntFire("spx_crucio_spwnr_entmaker","AddOutput","EntityTemplate spx_crucio_spwnr_template",0.00,null);
        EntFire("spx_effect_upgrade_crucio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_crucio","Stop","",1.00,null);
        EntFire("spx_crucio_trigger2","ClearParent","",2.00,null);
        EntFire("spx_crucio_trigger3","ClearParent","",2.00,null);
        EntFire("spx_crucio_trigger4","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active4","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_crucio","Kill","",2.00,null);
        EntFire("spx_crucio_trigger2","Kill","",3.00,null);
        EntFire("spx_crucio_trigger3","Kill","",3.00,null);
        EntFire("spx_crucio_trigger4","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active2","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active3","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active4","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template2","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template3","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template4","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(7, 0);",3.00,CRUCIOACT);
		EntFire("console","Command","sm_setcooldown 17845738 60",3.00,null);
    }
    else if(CRUCIOLEVEL == 1)
    {
        CrucioItemLevel1M();
        EntFire("spx_crucio_spwnr_entmaker","AddOutput","EntityTemplate spx_crucio_spwnr_template2",0.00,null);
        EntFire("spx_effect_upgrade_crucio","Start","",0.00,null);
        EntFire("spx_effect_upgrade_crucio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_crucio","Stop","",1.00,null);
        EntFire("spx_crucio_trigger","ClearParent","",2.00,null);
        EntFire("spx_crucio_trigger3","ClearParent","",2.00,null);
        EntFire("spx_crucio_trigger4","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active4","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_crucio","Kill","",2.00,null);
        EntFire("spx_crucio_trigger","Kill","",3.00,null);
        EntFire("spx_crucio_trigger3","Kill","",3.00,null);
        EntFire("spx_crucio_trigger4","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active3","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active4","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template3","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template4","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(7, 1);",3.00,CRUCIOACT);
		EntFire("console","Command","sm_setcooldown 17845738 55",3.00,null);
    }
    else if(CRUCIOLEVEL == 2)
    {
        CrucioItemLevel2M();
        ZMITEMLVLUP++;
        EntFire("spx_crucio_spwnr_entmaker","AddOutput","EntityTemplate spx_crucio_spwnr_template3",0.00,null);
        EntFire("spx_effect_upgrade_crucio","Start","",0.00,null);
        EntFire("spx_effect_upgrade_crucio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_crucio","Stop","",1.00,null);
        EntFire("spx_crucio_trigger","ClearParent","",2.00,null);
        EntFire("spx_crucio_trigger2","ClearParent","",2.00,null);
        EntFire("spx_crucio_trigger4","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active4","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_crucio","Kill","",2.00,null);
        EntFire("spx_crucio_trigger","Kill","",3.00,null);
        EntFire("spx_crucio_trigger2","Kill","",3.00,null);
        EntFire("spx_crucio_trigger4","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active2","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active4","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template2","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template4","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(7, 2);",3.00,CRUCIOACT);
		EntFire("console","Command","sm_setcooldown 17845738 50",3.00,null);
    }
    else if(CRUCIOLEVEL == 3)
    {
        CrucioItemLevel3M();
        ZMITEMLVLUP++;
        EntFire("spx_crucio_spwnr_entmaker","AddOutput","EntityTemplate spx_crucio_spwnr_template4",0.00,null);
        EntFire("spx_effect_upgrade_crucio","Start","",0.00,null);
        EntFire("spx_effect_upgrade_crucio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_crucio","Stop","",1.00,null);
        EntFire("spx_crucio_trigger","ClearParent","",2.00,null);
        EntFire("spx_crucio_trigger2","ClearParent","",2.00,null);
        EntFire("spx_crucio_trigger3","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_crucio","Kill","",2.00,null);
        EntFire("spx_crucio_trigger","Kill","",3.00,null);
        EntFire("spx_crucio_trigger2","Kill","",3.00,null);
        EntFire("spx_crucio_trigger3","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active2","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active3","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template2","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(7, 3);",3.00,CRUCIOACT);
		EntFire("console","Command","sm_setcooldown 17845738 50",3.00,null);
    }
    else if(CRUCIOLEVEL == 4)
    {
        CrucioItemLevel4M();
        ZMITEMLVLUP++;
        EntFire("spx_crucio_spwnr_entmaker","AddOutput","EntityTemplate spx_crucio_spwnr_template4",0.00,null);
        EntFire("spx_crucio_spwnr_entmaker","AddOutput","OnEntitySpawned spx_crucio_trigger*:SetDamage:1500:0.20:-1",0.00,null);
        EntFire("spx_effect_upgrade_crucio","Start","",0.00,null);
        EntFire("spx_effect_upgrade_crucio","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_crucio","Stop","",1.00,null);
        EntFire("spx_crucio_trigger","ClearParent","",2.00,null);
        EntFire("spx_crucio_trigger2","ClearParent","",2.00,null);
        EntFire("spx_crucio_trigger3","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_crucio_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_crucio","Kill","",2.00,null);
        EntFire("spx_crucio_trigger","Kill","",3.00,null);
        EntFire("spx_crucio_trigger2","Kill","",3.00,null);
        EntFire("spx_crucio_trigger3","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active2","Kill","",3.00,null);
        EntFire("spx_crucio_effect_active3","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template2","Kill","",3.00,null);
        EntFire("spx_crucio_spwnr_template3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(7, 4);",3.00,CRUCIOACT);
		EntFire("console","Command","sm_setcooldown 17845738 45",3.00,null);
    }
}

function UseItemCrucio()
{
    if(activator.GetTeam() == 3 && activator == CRUCIOACT && !ITEM_DISABLE)
    { 
        EntFire("spx_crucio_button","Lock","", 0.00, null);
        EntFire("spx_crucio_spwnr_entmaker","ForceSpawn","", 0.00, null);
        EntFire("spx_effect_wand_crucio","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spx_crucio_wandprop","Color","255 28 28", 0.00, null);
        EntFire("spx_crucio_effect_active*","Kill","", 10.00, null);
        EntFire("spx_crucio_trigger*","Kill","", 10.00, null);
        if(CRUCIOLEVEL == 0)
        {
            EntFire("spx_crucio_effect_active*","Stop","", 4.00, null);
            EntFire("spx_crucio_trigger*","Disable","", 4.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",40.00,CRUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",50.00,CRUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",60.00,CRUCIOACT);
            EntFire("spx_crucio_wandprop","Color","17 255 77",60.00,null);
            EntFire("spx_effect_wand_crucio","Start","",60.00,null);
            EntFire("spx_crucio_button","UnLock","",60.00,null);
        }
        else if(CRUCIOLEVEL == 1)
        {
            EntFire("spx_crucio_effect_active*","Stop","", 4.00, null);
            EntFire("spx_crucio_trigger*","Disable","", 4.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",35.00,CRUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",45.00,CRUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",55.00,CRUCIOACT);
            EntFire("spx_crucio_wandprop","Color","17 255 77",55.00,null);
            EntFire("spx_effect_wand_crucio","Start","",55.00,null);
            EntFire("spx_crucio_button","UnLock","",55.00,null);
        }
        else if(CRUCIOLEVEL == 2)
        {
            EntFire("spx_crucio_effect_active*","Stop","", 4.00, null);
            EntFire("spx_crucio_trigger*","Disable","", 4.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,CRUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,CRUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,CRUCIOACT);
            EntFire("spx_crucio_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_crucio","Start","",50.00,null);
            EntFire("spx_crucio_button","UnLock","",50.00,null);
        }
        else if(CRUCIOLEVEL == 3)
        {
            EntFire("spx_crucio_effect_active*","Stop","", 5.00, null);
            EntFire("spx_crucio_trigger*","Disable","", 5.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,CRUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,CRUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,CRUCIOACT);
            EntFire("spx_crucio_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_crucio","Start","",50.00,null);
            EntFire("spx_crucio_button","UnLock","",50.00,null);
        }
        else if(CRUCIOLEVEL == 4)
        {
            EntFire("spx_crucio_effect_active*","Stop","", 5.00, null);
            EntFire("spx_crucio_trigger*","Disable","", 5.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",25.00,CRUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",35.00,CRUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",45.00,CRUCIOACT);
            EntFire("spx_crucio_wandprop","Color","17 255 77",45.00,null);
            EntFire("spx_effect_wand_crucio","Start","",45.00,null);
            EntFire("spx_crucio_button","UnLock","",45.00,null);
        }
    }
}

function CrucioItemM()
{
    ScriptPrintMessageChatAll("ITEM PICKUP: \x10>>> CRUCIO SPELL HAS BEEN PICKED UP <<<");
}

function CrucioItemLevel1M()
{
    ScriptPrintMessageChatAll(" \x10>>> APPLYING 1 YEAR EXPERIENCE TO CRUCIO [1/4] <<<");
}

function CrucioItemLevel2M()
{
    ScriptPrintMessageChatAll(" \x10>>> APPLYING 2 YEAR EXPERIENCE TO CRUCIO [2/4] <<<");
}

function CrucioItemLevel3M()
{
    ScriptPrintMessageChatAll(" \x10>>> APPLYING 3 YEAR EXPERIENCE TO CRUCIO [3/4] <<<");
}

function CrucioItemLevel4M()
{
    ScriptPrintMessageChatAll(" \x10>>> APPLYING 4 YEAR EXPERIENCE TO CRUCIO [4/4] <<<");
}
//OnUser1 spx_crucio_activator:Trigger::0:1
////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
AGUAMENTIACT <- null;
AGUAMENTICALL <- null;
AGUAMENTIONCE <- true;
AGUAMENTILEVEL <- 0;
////////////////////////////////

////////////////////////////////
///////////AGUAMENTI////////////
////////////////////////////////

function PickUpAguamenti()
{
    AGUAMENTIACT = activator;
    AGUAMENTICALL = caller;
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, AGUAMENTIACT);
    EntFire("!activator", "AddOutput", "rendercolor 0 230 230", 0.30, AGUAMENTIACT);
    EntFireByHandle(self,"RunScriptCode","AguamentiItemM();",2.00,null,null);
    if(AGUAMENTIONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11456 9456 13630", 0.10, AGUAMENTIACT);
        EntFire("!activator", "RunScriptCode", "GetItemLevelAguamenti();", 0.00, AGUAMENTIACT);
        EntFireByHandle(self,"RunScriptCode","AguamentiReceivedLevel();",0.01,null,null);
        EntFire("map_equip_guns", "Use", "", 0.40, AGUAMENTIACT);
        AGUAMENTIONCE = false;
    }
}

function AguamentiReceivedLevel()
{
    if(AGUAMENTILEVEL == 0)
    {
        EntFire("spx_effect_upgrade_aguamenti","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_aguamenti","Stop","",1.00,null);
        EntFire("spx_aguamenti_triggers2","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_triggers3","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_aguamenti","Kill","",2.00,null);
        EntFire("spx_aguamenti_triggers2","Kill","",3.00,null);
        EntFire("spx_aguamenti_triggers3","Kill","",3.00,null);
        EntFire("spx_aguamenti_effect_active2","Kill","",3.00,null);
        EntFire("spx_aguamenti_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(8, 0);",3.00,AGUAMENTIACT);
		EntFire("console","Command","sm_setcooldown 17845811 60",3.00,null);
    }
    else if(AGUAMENTILEVEL == 1)
    {
        AguamentiItemLevel1M();
        EntFire("spx_effect_upgrade_aguamenti","Start","",0.00,null);
        EntFire("spx_effect_upgrade_aguamenti","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_aguamenti","Stop","",1.00,null);
        EntFire("spx_aguamenti_triggers*","SetDamage","400",1.20,null);
        EntFire("spx_aguamenti_triggers2","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_triggers3","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_aguamenti","Kill","",2.00,null);
        EntFire("spx_aguamenti_triggers2","Kill","",3.00,null);
        EntFire("spx_aguamenti_triggers3","Kill","",3.00,null);
        EntFire("spx_aguamenti_effect_active2","Kill","",3.00,null);
        EntFire("spx_aguamenti_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(8, 1);",3.00,AGUAMENTIACT);
		EntFire("console","Command","sm_setcooldown 17845811 55",3.00,null);
    }
    else if(AGUAMENTILEVEL == 2)
    {
        AguamentiItemLevel2M();
        ZMITEMLVLUP++;
        EntFire("spx_effect_upgrade_aguamenti","Start","",0.00,null);
        EntFire("spx_effect_upgrade_aguamenti","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_aguamenti","Stop","",1.00,null);
        EntFire("spx_aguamenti_triggers","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_triggers3","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_effect_active","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_effect_active3","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_aguamenti","Kill","",2.00,null);
        EntFire("spx_aguamenti_triggers","Kill","",3.00,null);
        EntFire("spx_aguamenti_triggers3","Kill","",3.00,null);
        EntFire("spx_aguamenti_effect_active","Kill","",3.00,null);
        EntFire("spx_aguamenti_effect_active3","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(8, 2);",3.00,AGUAMENTIACT);
		EntFire("console","Command","sm_setcooldown 17845811 55",3.00,null);
    }
    else if(AGUAMENTILEVEL == 3)
    {
        AguamentiItemLevel3M();
        ZMITEMLVLUP++;
        EntFire("spx_effect_upgrade_aguamenti","Start","",0.00,null);
        EntFire("spx_effect_upgrade_aguamenti","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_aguamenti","Stop","",1.00,null);
        EntFire("spx_aguamenti_triggers","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_triggers2","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_effect_active","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_aguamenti","Kill","",2.00,null);
        EntFire("spx_aguamenti_triggers","Kill","",3.00,null);
        EntFire("spx_aguamenti_triggers2","Kill","",3.00,null);
        EntFire("spx_aguamenti_effect_active","Kill","",3.00,null);
        EntFire("spx_aguamenti_effect_active2","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(8, 3);",3.00,AGUAMENTIACT);
		EntFire("console","Command","sm_setcooldown 17845811 50",3.00,null);
    }
    else if(AGUAMENTILEVEL == 4)
    {
        AguamentiItemLevel4M();
        ZMITEMLVLUP++;
        EntFire("spx_effect_upgrade_aguamenti","Start","",0.00,null);
        EntFire("spx_effect_upgrade_aguamenti","ClearParent","",1.00,null);
        EntFire("spx_effect_upgrade_aguamenti","Stop","",1.00,null);
        EntFire("spx_aguamenti_triggers*","SetDamage","1000",1.20,null);
        EntFire("spx_aguamenti_triggers","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_triggers2","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_effect_active","ClearParent","",2.00,null);
        EntFire("spx_aguamenti_effect_active2","ClearParent","",2.00,null);
        EntFire("spx_effect_upgrade_aguamenti","Kill","",2.00,null);
        EntFire("spx_aguamenti_triggers","Kill","",3.00,null);
        EntFire("spx_aguamenti_triggers2","Kill","",3.00,null);
        EntFire("spx_aguamenti_effect_active","Kill","",3.00,null);
        EntFire("spx_aguamenti_effect_active2","Kill","",3.00,null);
        EntFire("!activator","RunScriptCode","PersonalItemText(8, 4);",3.00,AGUAMENTIACT);
		EntFire("console","Command","sm_setcooldown 17845811 50",3.00,null);
    }
}

function UseItemAguamenti()
{
    if(activator.GetTeam() == 3 && activator == AGUAMENTIACT && !ITEM_DISABLE)
    { 
        EntFire("spx_aguamenti_button","Lock","", 0.00, null);
        EntFire("spx_aguamenti_triggers*","Enable","", 0.00, null);
        EntFire("spx_aguamenti_effect_active*","Start","", 0.00, null);
        EntFire("spx_effect_wand_aguamenti","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spx_aguamenti_wandprop","Color","255 28 28", 0.00, null);
        if(AGUAMENTILEVEL == 0)
        {
            EntFire("spx_aguamenti_effect_active*","Stop","", 4.00, null);
            EntFire("spx_aguamenti_triggers*","Disable","", 4.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",40.00,AGUAMENTIACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",50.00,AGUAMENTIACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",60.00,AGUAMENTIACT);
            EntFire("spx_aguamenti_wandprop","Color","17 255 77",60.00,null);
            EntFire("spx_effect_wand_aguamenti","Start","",60.00,null);
            EntFire("spx_aguamenti_button","UnLock","",60.00,null);
        }
        else if(AGUAMENTILEVEL == 1)
        {
            EntFire("spx_aguamenti_effect_active*","Stop","", 4.00, null);
            EntFire("spx_aguamenti_triggers*","Disable","", 4.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",35.00,AGUAMENTIACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",45.00,AGUAMENTIACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",55.00,AGUAMENTIACT);
            EntFire("spx_aguamenti_wandprop","Color","17 255 77",55.00,null);
            EntFire("spx_effect_wand_aguamenti","Start","",55.00,null);
            EntFire("spx_aguamenti_button","UnLock","",55.00,null);
        }
        else if(AGUAMENTILEVEL == 2)
        {
            EntFire("spx_aguamenti_effect_active*","Stop","", 5.00, null);
            EntFire("spx_aguamenti_triggers*","Disable","", 5.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",35.00,AGUAMENTIACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",45.00,AGUAMENTIACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",55.00,AGUAMENTIACT);
            EntFire("spx_aguamenti_wandprop","Color","17 255 77",55.00,null);
            EntFire("spx_effect_wand_aguamenti","Start","",55.00,null);
            EntFire("spx_aguamenti_button","UnLock","",55.00,null);
        }
        else if(AGUAMENTILEVEL == 3)
        {
            EntFire("spx_aguamenti_effect_active*","Stop","", 5.00, null);
            EntFire("spx_aguamenti_triggers*","Disable","", 5.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,AGUAMENTIACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,AGUAMENTIACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,AGUAMENTIACT);
            EntFire("spx_aguamenti_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_aguamenti","Start","",50.00,null);
            EntFire("spx_aguamenti_button","UnLock","",50.00,null);
        }
        else if(AGUAMENTILEVEL == 4)
        {
            EntFire("spx_aguamenti_effect_active*","Stop","", 6.00, null);
            EntFire("spx_aguamenti_triggers*","Disable","", 6.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,AGUAMENTIACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,AGUAMENTIACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,AGUAMENTIACT);
            EntFire("spx_aguamenti_wandprop","Color","17 255 77",50.00,null);
            EntFire("spx_effect_wand_aguamenti","Start","",50.00,null);
            EntFire("spx_aguamenti_button","UnLock","",50.00,null);
        }
    }
}

function AguamentiItemM()
{
    ScriptPrintMessageChatAll("ITEM PICKUP: \x0C>>> AGUAMENTI SPELL HAS BEEN PICKED UP <<<");
}

function AguamentiItemLevel1M()
{
    ScriptPrintMessageChatAll(" \x0C>>> APPLYING 1 YEAR EXPERIENCE TO AGUAMENTI [1/4] <<<");
}

function AguamentiItemLevel2M()
{
    ScriptPrintMessageChatAll(" \x0C>>> APPLYING 2 YEAR EXPERIENCE TO AGUAMENTI [2/4] <<<");
}

function AguamentiItemLevel3M()
{
    ScriptPrintMessageChatAll(" \x0C>>> APPLYING 3 YEAR EXPERIENCE TO AGUAMENTI [3/4] <<<");
}

function AguamentiItemLevel4M()
{
    ScriptPrintMessageChatAll(" \x0C>>> APPLYING 4 YEAR EXPERIENCE TO AGUAMENTI [4/4] <<<");
}
//OnUser1 spx_aguamenti_activator:Trigger::0:1
////////////////////////////////
////////////////////////////////
////////////////////////////////

function ProtectWandPick()
{
    if(activator == PROTEGOACT || 
    activator == REPAIROACT ||
    activator == AVADAACT ||
    activator == FLIPENDOACT ||
    activator == IMPEDIMENTAACT ||
    activator == INCENDIOACT ||
    activator == ACCIOACT ||
    activator == CRUCIOACT ||
    activator == AGUAMENTIACT)
    {
        EntFireByHandle(activator,"AddOutput","origin 9153 9128 13465",0.00,activator,activator);
    }
}

////////////////////////////////
// BroomAct <- [];
////////////////////////////////

function PickUpBroomStick()
{
    if(activator.GetTeam() == 2 &&
    activator != EXPULSOACT &&
    activator != DEPRIMOACT &&
    activator != CONFUNDUSACT &&
    activator != EMENDOACT &&
    activator != ZMINCENDIOACT &&
    activator != DISILLUSIONMENTACT &&
    activator != CONJUNCTIVITUSACT &&
    activator != DELETRIUSACT &&
    activator != REDUCIOACT)
    {
        EntFire("item_stripper","StripWeaponsAndSuit","",0.00,activator);
		EntFireByHandle(caller, "FireUser4", "", 0.01, null, null);
    }
}

function PrintArr()
{
    ScriptPrintMessageChatAll(""+BroomAct);
}

function ToggleItemUse()
{
    if(!ITEM_DISABLE){ITEM_DISABLE = true;}
    if(ITEM_DISABLE){ITEM_DISABLE = false;}
}

function StopWandWorks()
{
    ZOMBIE_ITEM_DISABLE = false;
    EntFire("spxZM_expulso_effect_active", "Stop", "", 0.00, null);
    EntFire("spxZM_expulso_trigger", "Disable", "", 0.00, null);
    EntFire("spxZM_deprimo_effect_active", "Stop", "", 0.00, null);
    EntFire("spxZM_deprimo_trigger", "Disable", "", 0.00, null);
    EntFire("spxZM_confundus_effect_active", "Stop", "", 0.00, null);
    EntFire("spxZM_confundus_trigger", "Disable", "", 0.00, null);
    EntFire("spxZM_incendio_effect_active", "Stop", "", 0.00, null);
    EntFire("spxZM_incendio_trigger", "Disable", "", 0.00, null);
    EntFire("spxZM_conjunct_effect_active", "Stop", "", 0.00, null);
    EntFire("spxZM_conjunct_trigger", "Disable", "", 0.00, null);
}

function StartWandWorks()
{
    ZOMBIE_ITEM_DISABLE = true;
}

function EnableZombieWands()
{
    ZOMBIE_ITEM_DISABLE=true;
}

////////////////////////////////

////////////////////////////////
////////////////////////////////
////////////////////////////////
////////////ZM ITEMS////////////
////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
EXPULSOACT <- null;
EXPULSOCALL <- null;
EXPULSOONCE <- true;
TickCheckExpulso <- true;
////////////////////////////////

////////////////////////////////
////////////EXPULSO/////////////
////////////////////////////////

function PickUpExpulso()
{
    EXPULSOACT = activator;
    EXPULSOCALL = caller;
    TickCheckExpulso = true;
    EntFire("spxZM_effect_wand_expulso", "Start", "", 1.00, null);
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, EXPULSOACT);
    EntFireByHandle(self,"RunScriptCode","ExpulsoItemM();",2.00,null,null);
    EntFireByHandle(self,"RunScriptCode","CheckOwnerExpulso();",5.00,null,null);
    if(EXPULSOONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, EXPULSOACT);
        EntFireByHandle(self,"RunScriptCode","ExpulsoReceivedLevel();",0.01,null,null);
        EXPULSOONCE = false;
    }
}

function CheckOwnerExpulso()
{
    if(TickCheckExpulso)
    {
		try
		{
			if(EXPULSOCALL.GetMoveParent() != EXPULSOACT)
			{
				TickCheckExpulso = false;
				EXPULSOACT = null;
				EXPULSOONCE = true;
				EntFire("spxZM_expulso_trigger", "Disable", "", 0.00, null);
				EntFire("spxZM_effect_static_expulso", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_wand_expulso", "Stop", "", 0.10, null);
				EntFire("spxZM_expulso_e*", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_wand_expulso", "Kill", "", 0.20, null);
				EntFire("spxZM_expulso_button", "Kill", "", 0.20, null);
				EntFire("spxZM_expulso_e*", "Kill", "", 0.20, null);
				EntFire("spxZM_expulso_knife", "Kill", "", 0.20, null);
				EntFire("spxZM_expulso_trigger", "Kill", "", 0.20, null);
				EntFire("spxZM_expulso_wandprop", "Kill", "", 0.20, null);
				EntFire("itemZM_expulso_entree", "Kill", "", 0.30, null);
				EntFire("spxZM_effect_static_expulso", "Kill", "", 0.30, null);
				if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_expulso_template", "ForceSpawn", "", 80.40, null);}
			}
		} catch(exception)
		{
			TickCheckExpulso = false;
			EXPULSOACT = null;
			EXPULSOONCE = true;
			EntFire("spxZM_expulso_trigger", "Disable", "", 0.00, null);
			EntFire("spxZM_effect_static_expulso", "Stop", "", 0.10, null);
			EntFire("spxZM_effect_wand_expulso", "Stop", "", 0.10, null);
			EntFire("spxZM_expulso_e*", "Stop", "", 0.10, null);
			EntFire("spxZM_effect_wand_expulso", "Kill", "", 0.20, null);
			EntFire("spxZM_expulso_button", "Kill", "", 0.20, null);
			EntFire("spxZM_expulso_e*", "Kill", "", 0.20, null);
			EntFire("spxZM_expulso_knife", "Kill", "", 0.20, null);
			EntFire("spxZM_expulso_trigger", "Kill", "", 0.20, null);
			EntFire("spxZM_expulso_wandprop", "Kill", "", 0.20, null);
			EntFire("itemZM_expulso_entree", "Kill", "", 0.30, null);
			EntFire("spxZM_effect_static_expulso", "Kill", "", 0.30, null);
			if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_expulso_template", "ForceSpawn", "", 80.40, null);}
		}
        
        EntFireByHandle(self,"RunScriptCode","CheckOwnerExpulso();",5.00,null,null);
    }
}

function ExpulsoReceivedLevel()
{
    if(ZMITEMLVLUP < 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(9, 0);",3.00,EXPULSOACT);
		EntFire("console","Command","sm_setcooldown 9129450 80",3.00,null);
    }
    else if(ZMITEMLVLUP >= 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(9, 1);",3.00,EXPULSOACT);
		EntFire("console","Command","sm_setcooldown 9129450 75",3.00,null);
    }
}

function UseItemExpulso()
{
    if(activator.GetTeam() == 2 && activator == EXPULSOACT && ZOMBIE_ITEM_DISABLE)
    { 
        EntFire("spxZM_expulso_button","Lock","", 0.00, null);
        EntFire("spxZM_expulso_effect_active","Start","", 0.00, null);
        EntFire("spxZM_effect_wand_expulso","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spxZM_expulso_wandprop","Color","255 28 28", 0.00, null);
        EntFire("spxZM_expulso_trigger","Enable","", 8.00, null);
        EntFire("spxZM_expulso_effect_active","Stop","", 9.00, null);
        EntFire("spxZM_expulso_trigger","Disable","", 9.00, null);
        if(ZMITEMLVLUP < 7)
        {
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",60.00,EXPULSOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",70.00,EXPULSOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",80.00,EXPULSOACT);
            EntFire("spxZM_expulso_wandprop","Color","17 255 77",80.00,null);
            EntFire("spxZM_effect_wand_expulso","Start","",80.00,null);
            EntFire("spxZM_expulso_button","UnLock","",80.00,null);
        }
        else if(ZMITEMLVLUP >= 7)
        {
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",55.00,EXPULSOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",65.00,EXPULSOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",75.00,EXPULSOACT);
            EntFire("spxZM_expulso_wandprop","Color","17 255 77",75.00,null);
            EntFire("spxZM_effect_wand_expulso","Start","",75.00,null);
            EntFire("spxZM_expulso_button","UnLock","",75.00,null);
        }
    }
}

function ExpulsoItemM()
{
    ScriptPrintMessageChatAll("ZOMBIE ITEM PICKUP: >>> EXPULSO SPELL HAS BEEN PICKED UP <<<");
}

////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
DEPRIMOACT <- null;
DEPRIMOCALL <- null;
DEPRIMOONCE <- true;
TickCheckDeprimo <- true;
////////////////////////////////

////////////////////////////////
////////////DEPRIMO/////////////
////////////////////////////////

function PickUpDeprimo()
{
    DEPRIMOACT = activator;
    DEPRIMOCALL = caller;
    TickCheckDeprimo = true;
    EntFire("spxZM_effect_wand_deprimo", "Start", "", 1.00, null);
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, DEPRIMOACT);
    EntFireByHandle(self,"RunScriptCode","DeprimoItemM();",2.00,null,null);
    EntFireByHandle(self,"RunScriptCode","CheckOwnerDeprimo();",5.00,null,null);
    if(DEPRIMOONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, DEPRIMOACT);
        EntFireByHandle(self,"RunScriptCode","DeprimoReceivedLevel();",0.01,null,null);
        DEPRIMOONCE = false;
    }
}

function CheckOwnerDeprimo()
{
    if(TickCheckDeprimo)
    {
		try
		{
			if(DEPRIMOCALL.GetMoveParent() != DEPRIMOACT)
			{
				TickCheckDeprimo = false;
				DEPRIMOONCE = true;
				DEPRIMOACT = null;
				EntFire("spxZM_deprimo_trig*", "Disable", "", 0.00, null);
				EntFire("spxZM_deprimo_e*", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_wand_deprimo", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_static_deprimo", "Stop", "", 0.10, null);
				EntFire("spxZM_deprimo_trig*", "Kill", "", 0.20, null);
				EntFire("spxZM_deprimo_button", "Kill", "", 0.20, null);
				EntFire("spxZM_deprimo_e*", "Kill", "", 0.20, null);
				EntFire("spxZM_deprimo_knife", "Kill", "", 0.20, null);
				EntFire("spxZM_deprimo_wandprop", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_wand_deprimo", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_static_deprimo", "Kill", "", 0.30, null);
				EntFire("itemZM_deprimo_entree", "Kill", "", 0.30, null);
				if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_deprimo_template", "ForceSpawn", "", 60.40, null);}
			}
		} catch(exception)
		{
			TickCheckDeprimo = false;
            DEPRIMOONCE = true;
            DEPRIMOACT = null;
            EntFire("spxZM_deprimo_trig*", "Disable", "", 0.00, null);
            EntFire("spxZM_deprimo_e*", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_wand_deprimo", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_static_deprimo", "Stop", "", 0.10, null);
            EntFire("spxZM_deprimo_trig*", "Kill", "", 0.20, null);
            EntFire("spxZM_deprimo_button", "Kill", "", 0.20, null);
            EntFire("spxZM_deprimo_e*", "Kill", "", 0.20, null);
            EntFire("spxZM_deprimo_knife", "Kill", "", 0.20, null);
            EntFire("spxZM_deprimo_wandprop", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_wand_deprimo", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_static_deprimo", "Kill", "", 0.30, null);
            EntFire("itemZM_deprimo_entree", "Kill", "", 0.30, null);
            if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_deprimo_template", "ForceSpawn", "", 60.40, null);}
		}
        
        EntFireByHandle(self,"RunScriptCode","CheckOwnerDeprimo();",5.00,null,null);
    }
}

function DeprimoReceivedLevel()
{
    if(ZMITEMLVLUP < 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(10, 0);",3.00,DEPRIMOACT);
		EntFire("console","Command","sm_setcooldown 9128865 60",3.00,null);
    }
    else if(ZMITEMLVLUP >= 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(10, 1);",3.00,DEPRIMOACT);
		EntFire("console","Command","sm_setcooldown 9128865 55",3.00,null);
    }
}

function UseItemDeprimo()
{
    if(activator.GetTeam() == 2 && activator == DEPRIMOACT && ZOMBIE_ITEM_DISABLE)
    { 
        EntFire("spxZM_deprimo_button","Lock","", 0.00, null);
        EntFire("spxZM_deprimo_effect_active","Start","", 0.00, null);
        EntFire("spxZM_effect_wand_deprimo","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spxZM_deprimo_wandprop","Color","255 28 28", 0.00, null);
        EntFire("spxZM_deprimo_trigger","Enable","", 0.00, null);
        if(ZMITEMLVLUP < 7)
        {
            EntFire("spxZM_deprimo_effect_active","Stop","", 5.00, null);
            EntFire("spxZM_deprimo_trigger","Disable","", 5.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",40.00,DEPRIMOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",50.00,DEPRIMOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",60.00,DEPRIMOACT);
            EntFire("spxZM_deprimo_wandprop","Color","17 255 77",60.00,null);
            EntFire("spxZM_effect_wand_deprimo","Start","",60.00,null);
            EntFire("spxZM_deprimo_button","UnLock","",60.00,null);
        }
        else if(ZMITEMLVLUP >= 7)
        {
            EntFire("spxZM_deprimo_effect_active","Stop","", 7.00, null);
            EntFire("spxZM_deprimo_trigger","Disable","", 7.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",35.00,DEPRIMOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",45.00,DEPRIMOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",55.00,DEPRIMOACT);
            EntFire("spxZM_deprimo_wandprop","Color","17 255 77",55.00,null);
            EntFire("spxZM_effect_wand_deprimo","Start","",55.00,null);
            EntFire("spxZM_deprimo_button","UnLock","",55.00,null);
        }
    }
}

function DeprimoItemM()
{
    ScriptPrintMessageChatAll("ZOMBIE ITEM PICKUP: >>> DEPRIMO SPELL HAS BEEN PICKED UP <<<");
}

////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
CONFUNDUSACT <- null;
CONFUNDUSCALL <- null;
CONFUNDUSONCE <- true;
TickCheckConfundus <- true;
////////////////////////////////

////////////////////////////////
///////////CONFUNDUS////////////
////////////////////////////////

function PickUpConfundus()
{
    CONFUNDUSACT = activator;
    CONFUNDUSCALL = caller;
    TickCheckConfundus = true;
    EntFire("spxZM_effect_wand_confundus", "Start", "", 1.00, null);
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, CONFUNDUSACT);
    EntFireByHandle(self,"RunScriptCode","ConfundusItemM();",2.00,null,null);
    EntFireByHandle(self,"RunScriptCode","CheckOwnerConfundus();",5.00,null,null);
    if(CONFUNDUSONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, CONFUNDUSACT);
        EntFireByHandle(self,"RunScriptCode","ConfundusReceivedLevel();",0.01,null,null);
        CONFUNDUSONCE = false;
    }
}

function CheckOwnerConfundus()
{
    if(TickCheckConfundus)
    {
		try
		{
			if(CONFUNDUSCALL.GetMoveParent() != CONFUNDUSACT)
			{
				TickCheckConfundus = false;
				CONFUNDUSONCE = true;
				CONFUNDUSACT = null;
				EntFire("spxZM_confundus_trig*", "Disable", "", 0.00, null);
				EntFire("spxZM_confundus_e*", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_wand_confundus", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_static_confundus", "Stop", "", 0.10, null);
				EntFire("spxZM_confundus_trig*", "Kill", "", 0.20, null);
				EntFire("spxZM_confundus_button", "Kill", "", 0.20, null);
				EntFire("spxZM_confundus_e*", "Kill", "", 0.20, null);
				EntFire("spxZM_confundus_knife", "Kill", "", 0.20, null);
				EntFire("spxZM_confundus_wandprop", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_wand_confundus", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_static_confundus", "Kill", "", 0.30, null);
				EntFire("itemZM_confundus_entree", "Kill", "", 0.30, null);
				if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_confundus_template", "ForceSpawn", "", 40.40, null);}
			}
		} catch(exception)
		{
			TickCheckConfundus = false;
            CONFUNDUSONCE = true;
            CONFUNDUSACT = null;
            EntFire("spxZM_confundus_trig*", "Disable", "", 0.00, null);
            EntFire("spxZM_confundus_e*", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_wand_confundus", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_static_confundus", "Stop", "", 0.10, null);
            EntFire("spxZM_confundus_trig*", "Kill", "", 0.20, null);
            EntFire("spxZM_confundus_button", "Kill", "", 0.20, null);
            EntFire("spxZM_confundus_e*", "Kill", "", 0.20, null);
            EntFire("spxZM_confundus_knife", "Kill", "", 0.20, null);
            EntFire("spxZM_confundus_wandprop", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_wand_confundus", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_static_confundus", "Kill", "", 0.30, null);
            EntFire("itemZM_confundus_entree", "Kill", "", 0.30, null);
            if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_confundus_template", "ForceSpawn", "", 40.40, null);}
		}
        EntFireByHandle(self,"RunScriptCode","CheckOwnerConfundus();",5.00,null,null);
    }
}

function ConfundusReceivedLevel()
{
    if(ZMITEMLVLUP < 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(11, 0);",3.00,CONFUNDUSACT);
		EntFire("console","Command","sm_setcooldown 9128126 40",3.00,null);
    }
    else if(ZMITEMLVLUP >= 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(11, 1);",3.00,CONFUNDUSACT);
		EntFire("console","Command","sm_setcooldown 9128126 35",3.00,null);
    }
}

function UseItemConfundus()
{
    if(activator.GetTeam() == 2 && activator == CONFUNDUSACT && ZOMBIE_ITEM_DISABLE)
    { 
        EntFire("spxZM_confundus_button","Lock","", 0.00, null);
        EntFire("spxZM_confundus_effect_active","Start","", 0.00, null);
        EntFire("spxZM_effect_wand_confundus","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spxZM_confundus_wandprop","Color","255 28 28", 0.00, null);
        EntFire("spxZM_confundus_trigger","Enable","", 0.00, null);
        if(ZMITEMLVLUP < 7)
        {
            EntFire("spxZM_confundus_effect_active","Stop","", 4.00, null);
            EntFire("spxZM_confundus_trigger","Disable","", 4.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",20.00,CONFUNDUSACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",30.00,CONFUNDUSACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",40.00,CONFUNDUSACT);
            EntFire("spxZM_confundus_wandprop","Color","17 255 77",40.00,null);
            EntFire("spxZM_effect_wand_confundus","Start","",40.00,null);
            EntFire("spxZM_confundus_button","UnLock","",40.00,null);
        }
        else if(ZMITEMLVLUP >= 7)
        {
            EntFire("spxZM_confundus_effect_active","Stop","", 6.00, null);
            EntFire("spxZM_confundus_trigger","Disable","", 6.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",15.00,CONFUNDUSACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",25.00,CONFUNDUSACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",35.00,CONFUNDUSACT);
            EntFire("spxZM_confundus_wandprop","Color","17 255 77",35.00,null);
            EntFire("spxZM_effect_wand_confundus","Start","",35.00,null);
            EntFire("spxZM_confundus_button","UnLock","",35.00,null);
        }
    }
}

function ConfundusItemM()
{
    ScriptPrintMessageChatAll("ZOMBIE ITEM PICKUP: >>> CONFUNDUS SPELL HAS BEEN PICKED UP <<<");
}

////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
EMENDOACT <- null;
EMENDOCALL <- null;
EMENDOONCE <- true;
TickCheckEmendo <- true;
////////////////////////////////

////////////////////////////////
/////////////EMENDO/////////////
////////////////////////////////

function PickUpEmendo()
{
    EMENDOACT = activator;
    EMENDOCALL = caller;
    TickCheckEmendo = true;
    EntFire("spxZM_effect_wand_emendo", "Start", "", 1.00, null);
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, EMENDOACT);
    EntFireByHandle(self,"RunScriptCode","EmendoItemM();",2.00,null,null);
    EntFireByHandle(self,"RunScriptCode","CheckOwnerEmendo();",5.00,null,null);
    if(EMENDOONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, EMENDOACT);
        EntFireByHandle(self,"RunScriptCode","EmendoReceivedLevel();",0.01,null,null);
        EMENDOONCE = false;
    }
}

function CheckOwnerEmendo()
{
    if(TickCheckEmendo)
    {
		try
		{
			if(EMENDOCALL.GetMoveParent() != EMENDOACT)
			{
				TickCheckEmendo = false;
				EMENDOONCE = true;
				EMENDOACT = null;
				EntFire("spxZM_emendo_trig*", "Disable", "", 0.00, null);
				EntFire("spxZM_emendo_e*", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_wand_emendo", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_static_emendo", "Stop", "", 0.10, null);
				EntFire("spxZM_emendo_trig*", "Kill", "", 0.20, null);
				EntFire("spxZM_emendo_button", "Kill", "", 0.20, null);
				EntFire("spxZM_emendo_e*", "Kill", "", 0.20, null);
				EntFire("spxZM_emendo_knife", "Kill", "", 0.20, null);
				EntFire("spxZM_emendo_wandprop", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_wand_emendo", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_static_emendo", "Kill", "", 0.30, null);
				EntFire("itemZM_emendo_entree", "Kill", "", 0.30, null);
				if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_emendo_template", "ForceSpawn", "", 50.40, null);}
			}
		} catch(exception)
		{
			TickCheckEmendo = false;
            EMENDOONCE = true;
            EMENDOACT = null;
            EntFire("spxZM_emendo_trig*", "Disable", "", 0.00, null);
            EntFire("spxZM_emendo_e*", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_wand_emendo", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_static_emendo", "Stop", "", 0.10, null);
            EntFire("spxZM_emendo_trig*", "Kill", "", 0.20, null);
            EntFire("spxZM_emendo_button", "Kill", "", 0.20, null);
            EntFire("spxZM_emendo_e*", "Kill", "", 0.20, null);
            EntFire("spxZM_emendo_knife", "Kill", "", 0.20, null);
            EntFire("spxZM_emendo_wandprop", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_wand_emendo", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_static_emendo", "Kill", "", 0.30, null);
            EntFire("itemZM_emendo_entree", "Kill", "", 0.30, null);
            if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_emendo_template", "ForceSpawn", "", 50.40, null);}
		}
        EntFireByHandle(self,"RunScriptCode","CheckOwnerEmendo();",5.00,null,null);
    }
}

function EmendoReceivedLevel()
{
    if(ZMITEMLVLUP < 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(12, 0);",3.00,EMENDOACT);
		EntFire("console","Command","sm_setcooldown 9127617 50",3.00,null);
    }
    else if(ZMITEMLVLUP >= 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(12, 1);",3.00,EMENDOACT);
		EntFire("console","Command","sm_setcooldown 9127617 45",3.00,null);
    }
}

function UseItemEmendo()
{
    if(activator.GetTeam() == 2 && activator == EMENDOACT && ZOMBIE_ITEM_DISABLE)
    { 
        EntFire("spxZM_emendo_button","Lock","", 0.00, null);
        EntFire("spxZM_emendo_effect_active","Start","", 0.00, null);
        EntFire("spxZM_effect_wand_emendo","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spxZM_emendo_wandprop","Color","255 28 28", 0.00, null);
        EntFire("spxZM_emendo_trigger","Enable","", 0.00, null);
        if(ZMITEMLVLUP < 7)
        {
            EntFire("spxZM_emendo_effect_active","Stop","", 4.00, null);
            EntFire("spxZM_emendo_trigger","Disable","", 4.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,EMENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,EMENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,EMENDOACT);
            EntFire("spxZM_emendo_wandprop","Color","17 255 77",50.00,null);
            EntFire("spxZM_effect_wand_emendo","Start","",50.00,null);
            EntFire("spxZM_emendo_button","UnLock","",50.00,null);
        }
        else if(ZMITEMLVLUP >= 7)
        {
            EntFire("spxZM_emendo_effect_active","Stop","", 6.00, null);
            EntFire("spxZM_emendo_trigger","Disable","", 6.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",25.00,EMENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",35.00,EMENDOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",45.00,EMENDOACT);
            EntFire("spxZM_emendo_wandprop","Color","17 255 77",45.00,null);
            EntFire("spxZM_effect_wand_emendo","Start","",45.00,null);
            EntFire("spxZM_emendo_button","UnLock","",45.00,null);
        }
    }
}

function EmendoItemM()
{
    ScriptPrintMessageChatAll("ZOMBIE ITEM PICKUP: >>> EMENDO SPELL HAS BEEN PICKED UP <<<");
}

////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
ZMINCENDIOACT <- null;
ZMINCENDIOCALL <- null;
ZMINCENDIOONCE <- true;
TickCheckIncendio <- true;
////////////////////////////////

////////////////////////////////
////////////INCENDIO////////////
////////////////////////////////

function PickUpZMIncendio()
{
    ZMINCENDIOACT = activator;
    ZMINCENDIOCALL = caller;
    TickCheckIncendio = true;
    EntFire("spxZM_effect_wand_incendio", "Start", "", 1.00, null);
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, ZMINCENDIOACT);
    EntFireByHandle(self,"RunScriptCode","ZMIncendioItemM();",2.00,null,null);
    EntFireByHandle(self,"RunScriptCode","CheckOwnerZMIncendio();",5.00,null,null);
    if(ZMINCENDIOONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, ZMINCENDIOACT);
        EntFireByHandle(self,"RunScriptCode","ZMIncendioReceivedLevel();",0.01,null,null);
        ZMINCENDIOONCE = false;
    }
}

function CheckOwnerZMIncendio()
{
    if(TickCheckIncendio)
    {
		try
		{
			if(ZMINCENDIOCALL.GetMoveParent() != ZMINCENDIOACT)
			{
				TickCheckIncendio = false;
				ZMINCENDIOONCE = true;
				ZMINCENDIOACT = null;
				EntFire("spxZM_incendio_trig*", "Disable", "", 0.00, null);
				EntFire("spxZM_incendio_e*", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_wand_incendio", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_static_incendio", "Stop", "", 0.10, null);
				EntFire("spxZM_incendio_trig*", "Kill", "", 0.20, null);
				EntFire("spxZM_incendio_button", "Kill", "", 0.20, null);
				EntFire("spxZM_incendio_e*", "Kill", "", 0.20, null);
				EntFire("spxZM_incendio_knife", "Kill", "", 0.20, null);
				EntFire("spxZM_incendio_wandprop", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_wand_incendio", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_static_incendio", "Kill", "", 0.30, null);
				EntFire("itemZM_incendio_entree", "Kill", "", 0.30, null);
				if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_incendio_template", "ForceSpawn", "", 60.40, null);}
			}
		} catch(exception)
		{
			TickCheckIncendio = false;
            ZMINCENDIOONCE = true;
            ZMINCENDIOACT = null;
            EntFire("spxZM_incendio_trig*", "Disable", "", 0.00, null);
            EntFire("spxZM_incendio_e*", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_wand_incendio", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_static_incendio", "Stop", "", 0.10, null);
            EntFire("spxZM_incendio_trig*", "Kill", "", 0.20, null);
            EntFire("spxZM_incendio_button", "Kill", "", 0.20, null);
            EntFire("spxZM_incendio_e*", "Kill", "", 0.20, null);
            EntFire("spxZM_incendio_knife", "Kill", "", 0.20, null);
            EntFire("spxZM_incendio_wandprop", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_wand_incendio", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_static_incendio", "Kill", "", 0.30, null);
            EntFire("itemZM_incendio_entree", "Kill", "", 0.30, null);
            if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_incendio_template", "ForceSpawn", "", 60.40, null);}
		}
        EntFireByHandle(self,"RunScriptCode","CheckOwnerZMIncendio();",5.00,null,null);
    }
}

function ZMIncendioReceivedLevel()
{
    if(ZMITEMLVLUP < 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(13, 0);",3.00,ZMINCENDIOACT);
		EntFire("console","Command","sm_setcooldown 9125676 60",3.00,null);
    }
    else if(ZMITEMLVLUP >= 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(13, 1);",3.00,ZMINCENDIOACT);
		EntFire("console","Command","sm_setcooldown 9125676 55",3.00,null);
    }
}

function UseItemZMIncendio()
{
    if(activator.GetTeam() == 2 && activator == ZMINCENDIOACT && ZOMBIE_ITEM_DISABLE)
    { 
        EntFire("spxZM_incendio_button","Lock","", 0.00, null);
        EntFire("spxZM_incendio_effect_active","Start","", 0.00, null);
        EntFire("spxZM_effect_wand_incendio","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spxZM_incendio_wandprop","Color","255 28 28", 0.00, null);
        EntFire("spxZM_incendio_trigger","Enable","", 0.00, null);
        if(ZMITEMLVLUP < 7)
        {
            EntFire("spxZM_incendio_effect_active","Stop","", 7.00, null);
            EntFire("spxZM_incendio_trigger","Disable","", 7.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",40.00,ZMINCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",50.00,ZMINCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",60.00,ZMINCENDIOACT);
            EntFire("spxZM_incendio_wandprop","Color","17 255 77",60.00,null);
            EntFire("spxZM_effect_wand_incendio","Start","",60.00,null);
            EntFire("spxZM_incendio_button","UnLock","",60.00,null);
        }
        else if(ZMITEMLVLUP >= 7)
        {
            EntFire("spxZM_incendio_effect_active","Stop","", 9.00, null);
            EntFire("spxZM_incendio_trigger","Disable","", 9.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",35.00,ZMINCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",45.00,ZMINCENDIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",55.00,ZMINCENDIOACT);
            EntFire("spxZM_incendio_wandprop","Color","17 255 77",55.00,null);
            EntFire("spxZM_effect_wand_incendio","Start","",55.00,null);
            EntFire("spxZM_incendio_button","UnLock","",55.00,null);
        }
    }
}

function ZMIncendioItemM()
{
    ScriptPrintMessageChatAll("ZOMBIE ITEM PICKUP: >>> INCENDIO SPELL HAS BEEN PICKED UP <<<");
}

////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
DISILLUSIONMENTACT <- null;
DISILLUSIONMENTCALL <- null;
DISILLUSIONMENTONCE <- true;
TickCheckDisillusionment <- true;
////////////////////////////////

////////////////////////////////
/////////DISILLUSIONMENT////////
////////////////////////////////

function PickUpDisillusionment()
{
    DISILLUSIONMENTACT = activator;
    DISILLUSIONMENTCALL = caller;
    TickCheckDisillusionment = true;
    EntFire("spxZM_effect_wand_disillu", "Start", "", 1.00, null);
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, DISILLUSIONMENTACT);
    EntFireByHandle(self,"RunScriptCode","DisillusionmentItemM();",2.00,null,null);
    EntFireByHandle(self,"RunScriptCode","CheckOwnerDisillusionment();",5.00,null,null);
    if(DISILLUSIONMENTONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, DISILLUSIONMENTACT);
        EntFireByHandle(self,"RunScriptCode","DisillusionmentReceivedLevel();",0.01,null,null);
        DISILLUSIONMENTONCE = false;
    }
}

function CheckOwnerDisillusionment()
{
    if(TickCheckDisillusionment)
    {
		try
		{
			if(DISILLUSIONMENTCALL.GetMoveParent() != DISILLUSIONMENTACT)
			{
				TickCheckDisillusionment = false;
				DISILLUSIONMENTONCE = true;
				DISILLUSIONMENTACT = null;
				EntFire("spxZM_disillu_trig*", "Disable", "", 0.00, null);
				EntFire("spxZM_disillu_e*", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_wand_disillu", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_static_disillu", "Stop", "", 0.10, null);
				EntFire("spxZM_disillu_trig*", "Kill", "", 0.20, null);
				EntFire("spxZM_disillu_button", "Kill", "", 0.20, null);
				EntFire("spxZM_disillu_e*", "Kill", "", 0.20, null);
				EntFire("spxZM_disillu_knife", "Kill", "", 0.20, null);
				EntFire("spxZM_disillu_wandprop", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_wand_disillu", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_static_disillu", "Kill", "", 0.30, null);
				EntFire("itemZM_disillu_entree", "Kill", "", 0.30, null);
				if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_disillu_template", "ForceSpawn", "", 50.40, null);}
			}
		} catch(exception)
		{
			TickCheckDisillusionment = false;
            DISILLUSIONMENTONCE = true;
            DISILLUSIONMENTACT = null;
            EntFire("spxZM_disillu_trig*", "Disable", "", 0.00, null);
            EntFire("spxZM_disillu_e*", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_wand_disillu", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_static_disillu", "Stop", "", 0.10, null);
            EntFire("spxZM_disillu_trig*", "Kill", "", 0.20, null);
            EntFire("spxZM_disillu_button", "Kill", "", 0.20, null);
            EntFire("spxZM_disillu_e*", "Kill", "", 0.20, null);
            EntFire("spxZM_disillu_knife", "Kill", "", 0.20, null);
            EntFire("spxZM_disillu_wandprop", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_wand_disillu", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_static_disillu", "Kill", "", 0.30, null);
            EntFire("itemZM_disillu_entree", "Kill", "", 0.30, null);
            if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_disillu_template", "ForceSpawn", "", 50.40, null);}
		}
        EntFireByHandle(self,"RunScriptCode","CheckOwnerDisillusionment();",5.00,null,null);
    }
}

function DisillusionmentReceivedLevel()
{
    if(ZMITEMLVLUP < 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(14, 0);",3.00,DISILLUSIONMENTACT);
		EntFire("console","Command","sm_setcooldown 17845958 50",3.00,null);
    }
    else if(ZMITEMLVLUP >= 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(14, 1);",3.00,DISILLUSIONMENTACT);
		EntFire("console","Command","sm_setcooldown 17845958 45",3.00,null);
    }
}

function UseItemDisillusionment()
{
    if(activator.GetTeam() == 2 && activator == DISILLUSIONMENTACT && ZOMBIE_ITEM_DISABLE)
    { 
        EntFire("spxZM_disillu_button","Lock","", 0.00, null);
        EntFire("spxZM_disillu_effect_active","Start","", 0.00, null);
        EntFire("spxZM_effect_wand_disillu","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spxZM_disillu_wandprop","Color","255 28 28", 0.00, null);
        EntFire("spxZM_disillu_trigger","Enable","", 0.00, null);
        EntFire("spxZM_disillu_effect_active","Stop","", 2.00, null);
        if(ZMITEMLVLUP < 7)
        {
            EntFire("spxZM_disillu_trigger","Disable","", 6.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",30.00,DISILLUSIONMENTACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",40.00,DISILLUSIONMENTACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",50.00,DISILLUSIONMENTACT);
            EntFire("spxZM_disillu_wandprop","Color","17 255 77",50.00,null);
            EntFire("spxZM_effect_wand_disillu","Start","",50.00,null);
            EntFire("spxZM_disillu_button","UnLock","",50.00,null);
        }
        else if(ZMITEMLVLUP >= 7)
        {
            EntFire("spxZM_disillu_trigger","Disable","", 8.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",25.00,DISILLUSIONMENTACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",35.00,DISILLUSIONMENTACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",45.00,DISILLUSIONMENTACT);
            EntFire("spxZM_disillu_wandprop","Color","17 255 77",45.00,null);
            EntFire("spxZM_effect_wand_disillu","Start","",45.00,null);
            EntFire("spxZM_disillu_button","UnLock","",45.00,null);
        }
    }
}

function DisillusionmentItemM()
{
    ScriptPrintMessageChatAll("ZOMBIE ITEM PICKUP: >>> DISILLUSIONMENT SPELL HAS BEEN PICKED UP <<<");
}

////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
CONJUNCTIVITUSACT <- null;
CONJUNCTIVITUSCALL <- null;
CONJUNCTIVITUSONCE <- true;
TickCheckConjunctivitus <- true;
////////////////////////////////
 
////////////////////////////////
/////////CONJUNCTIVITUS/////////
////////////////////////////////

function PickUpConjunctivitus()
{
    CONJUNCTIVITUSACT = activator;
    CONJUNCTIVITUSCALL = caller;
    TickCheckConjunctivitus = true;
    EntFire("spxZM_effect_wand_conjunct", "Start", "", 1.00, null);
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, CONJUNCTIVITUSACT);
    EntFireByHandle(self,"RunScriptCode","ConjunctivitusItemM();",2.00,null,null);
    EntFireByHandle(self,"RunScriptCode","CheckOwnerConjunctivitus();",5.00,null,null);
    if(CONJUNCTIVITUSONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, CONJUNCTIVITUSACT);
        EntFireByHandle(self,"RunScriptCode","ConjunctivitusReceivedLevel();",0.01,null,null);
        CONJUNCTIVITUSONCE = false;
    }
}

function CheckOwnerConjunctivitus()
{
    if(TickCheckConjunctivitus)
    {
		try
		{
			if(CONJUNCTIVITUSCALL.GetMoveParent() != CONJUNCTIVITUSACT)
			{
				TickCheckConjunctivitus = false;
				CONJUNCTIVITUSONCE = true;
				CONJUNCTIVITUSACT = null;
				EntFire("spxZM_conjunct_trig*", "Disable", "", 0.00, null);
				EntFire("spxZM_conjunct_e*", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_wand_conjunct", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_static_conjunct", "Stop", "", 0.10, null);
				EntFire("spxZM_conjunct_trig*", "Kill", "", 0.20, null);
				EntFire("spxZM_conjunct_button", "Kill", "", 0.20, null);
				EntFire("spxZM_conjunct_e*", "Kill", "", 0.20, null);
				EntFire("spxZM_conjunct_knife", "Kill", "", 0.20, null);
				EntFire("spxZM_conjunct_wandprop", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_wand_conjunct", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_static_conjunct", "Kill", "", 0.30, null);
				EntFire("itemZM_conjunct_entree", "Kill", "", 0.30, null);
				if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_conjunct_template", "ForceSpawn", "", 40.40, null);}
			}
		} catch(exception)
		{
			TickCheckConjunctivitus = false;
			CONJUNCTIVITUSONCE = true;
			CONJUNCTIVITUSACT = null;
			EntFire("spxZM_conjunct_trig*", "Disable", "", 0.00, null);
			EntFire("spxZM_conjunct_e*", "Stop", "", 0.10, null);
			EntFire("spxZM_effect_wand_conjunct", "Stop", "", 0.10, null);
			EntFire("spxZM_effect_static_conjunct", "Stop", "", 0.10, null);
			EntFire("spxZM_conjunct_trig*", "Kill", "", 0.20, null);
			EntFire("spxZM_conjunct_button", "Kill", "", 0.20, null);
			EntFire("spxZM_conjunct_e*", "Kill", "", 0.20, null);
			EntFire("spxZM_conjunct_knife", "Kill", "", 0.20, null);
			EntFire("spxZM_conjunct_wandprop", "Kill", "", 0.20, null);
			EntFire("spxZM_effect_wand_conjunct", "Kill", "", 0.20, null);
			EntFire("spxZM_effect_static_conjunct", "Kill", "", 0.30, null);
			EntFire("itemZM_conjunct_entree", "Kill", "", 0.30, null);
			if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_conjunct_template", "ForceSpawn", "", 40.40, null);}
		}
        EntFireByHandle(self,"RunScriptCode","CheckOwnerConjunctivitus();",5.00,null,null);
    }
}

function ConjunctivitusReceivedLevel()
{
    if(ZMITEMLVLUP < 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(15, 0);",3.00,CONJUNCTIVITUSACT);
		EntFire("console","Command","sm_setcooldown 17846183 40",3.00,null);
    }
    else if(ZMITEMLVLUP >= 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(15, 1);",3.00,CONJUNCTIVITUSACT);
		EntFire("console","Command","sm_setcooldown 17846183 35",3.00,null);
    }
}

function UseItemConjunctivitus()
{
    if(activator.GetTeam() == 2 && activator == CONJUNCTIVITUSACT && ZOMBIE_ITEM_DISABLE)
    { 
        EntFire("spxZM_conjunct_button","Lock","", 0.00, null);
        EntFire("spxZM_conjunct_effect_active","Start","", 0.00, null);
        EntFire("spxZM_effect_wand_conjunct","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spxZM_conjunct_wandprop","Color","255 28 28", 0.00, null);
        EntFire("spxZM_conjunct_trigger","Enable","", 0.00, null);
        if(ZMITEMLVLUP < 7)
        {
            EntFire("spxZM_conjunct_effect_active","Stop","", 6.00, null);
            EntFire("spxZM_conjunct_trigger","Disable","", 6.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",20.00,CONJUNCTIVITUSACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",30.00,CONJUNCTIVITUSACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",40.00,CONJUNCTIVITUSACT);
            EntFire("spxZM_conjunct_wandprop","Color","17 255 77",40.00,null);
            EntFire("spxZM_effect_wand_conjunct","Start","",40.00,null);
            EntFire("spxZM_conjunct_button","UnLock","",40.00,null);
        }
        else if(ZMITEMLVLUP >= 7)
        {
            EntFire("spxZM_conjunct_effect_active","Stop","", 8.00, null);
            EntFire("spxZM_conjunct_trigger","Disable","", 8.00, null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",15.00,CONJUNCTIVITUSACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",25.00,CONJUNCTIVITUSACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",35.00,CONJUNCTIVITUSACT);
            EntFire("spxZM_conjunct_wandprop","Color","17 255 77",35.00,null);
            EntFire("spxZM_effect_wand_conjunct","Start","",35.00,null);
            EntFire("spxZM_conjunct_button","UnLock","",35.00,null);
        }
    }
}

function ConjunctivitusItemM()
{
    ScriptPrintMessageChatAll("ZOMBIE ITEM PICKUP: >>> CONJUNCTIVITUS SPELL HAS BEEN PICKED UP <<<");
}

////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
DELETRIUSACT <- null;
DELETRIUSCALL <- null;
DELETRIUSONCE <- true;
TickCheckDeletrius <- true;
////////////////////////////////

////////////////////////////////
////////////DELETRIUS///////////
////////////////////////////////

function PickUpDeletrius()
{
    DELETRIUSACT = activator;
    DELETRIUSCALL = caller;
    TickCheckDeletrius = true;
    EntFire("spxZM_effect_wand_deletrius", "Start", "", 1.00, null);
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, DELETRIUSACT);
    EntFireByHandle(self,"RunScriptCode","DeletriusItemM();",2.00,null,null);
    EntFireByHandle(self,"RunScriptCode","CheckOwnerDeletrius();",5.00,null,null);
    if(DELETRIUSONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, DELETRIUSACT);
        EntFireByHandle(self,"RunScriptCode","DeletriusReceivedLevel();",0.01,null,null);
        DELETRIUSONCE = false;
    }
}

function CheckOwnerDeletrius()
{
    if(TickCheckDeletrius)
    {
		try
		{
			if(DELETRIUSCALL.GetMoveParent() != DELETRIUSACT)
			{
				TickCheckDeletrius = false;
				DELETRIUSONCE = true;
				DELETRIUSACT = null;
				EntFire("spxZM_deletrius_e*", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_wand_deletrius", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_static_deletrius", "Stop", "", 0.10, null);
				EntFire("spxZM_deletrius_button", "Kill", "", 0.20, null);
				EntFire("spxZM_deletrius_e*", "Kill", "", 0.20, null);
				EntFire("spxZM_deletrius_knife", "Kill", "", 0.20, null);
				EntFire("spxZM_deletrius_wandprop", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_wand_deletrius", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_static_deletrius", "Kill", "", 0.30, null);
				EntFire("itemZM_deletrius_entree", "Kill", "", 0.30, null);
				if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_deletrius_template", "ForceSpawn", "", 0.40, null);}
			}
		} catch(exception)
		{
			TickCheckDeletrius = false;
            DELETRIUSONCE = true;
            DELETRIUSACT = null;
            EntFire("spxZM_deletrius_e*", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_wand_deletrius", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_static_deletrius", "Stop", "", 0.10, null);
            EntFire("spxZM_deletrius_button", "Kill", "", 0.20, null);
            EntFire("spxZM_deletrius_e*", "Kill", "", 0.20, null);
            EntFire("spxZM_deletrius_knife", "Kill", "", 0.20, null);
            EntFire("spxZM_deletrius_wandprop", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_wand_deletrius", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_static_deletrius", "Kill", "", 0.30, null);
            EntFire("itemZM_deletrius_entree", "Kill", "", 0.30, null);
            if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_deletrius_template", "ForceSpawn", "", 0.40, null);}
		}
        EntFireByHandle(self,"RunScriptCode","CheckOwnerDeletrius();",5.00,null,null);
    }
}

function DeletriusReceivedLevel()
{
    if(ZMITEMLVLUP < 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(16, 0);",3.00,DELETRIUSACT);
    }
    else if(ZMITEMLVLUP >= 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(16, 1);",3.00,DELETRIUSACT);
    }
}

function UseItemDeletrius()
{
    if(activator.GetTeam() == 2 && activator == DELETRIUSACT && ZOMBIE_ITEM_DISABLE)
    { 
        local rnd = RandomInt(1,10);
        {
            if(rnd <= 6)
            {
                EntFire("spxZM_deletrius_effect_*", "Stop", "", 1.00, null);
	            EntFire("spxZM_deletrius_button", "Lock", "", 1.00, null);
	            EntFire("spx_protego_spwnr_prop*", "Break", "", 0.00, null);
	            EntFire("spx_accio_t*", "Disable", "", 0.00, null);
	            EntFire("spx_aguamenti_triggers*", "Disable", "", 0.00, null);
	            EntFire("spx_crucio_trigger*", "Disable", "", 0.00, null);
	            EntFire("spx_repairo_trigger*", "Disable", "", 0.00, null);
	            EntFire("spx_flipendo_trigger*", "Disable", "", 0.00, null);
	            EntFire("spx_impedimenta_trig_*", "Disable", "", 0.00, null);
	            EntFire("spx_incendio_trigger*", "Disable", "", 0.00, null);
	            EntFire("spx_accio_effect_active*", "Stop", "", 0.30, null);
	            EntFire("spx_aguamenti_effect_active*", "Stop", "", 0.30, null);
	            EntFire("spx_crucio_effect_active*", "Stop", "", 0.30, null);
	            EntFire("spx_repairo_effect_active*", "Stop", "", 0.30, null);
	            EntFire("spx_flipendo_effect_active*", "Stop", "", 0.30, null);
	            EntFire("spx_impedimenta_effect_active*", "Stop", "", 0.30, null);
	            EntFire("spx_incendio_effect_active*", "Stop", "", 0.30, null);
	            EntFire("spxZM_deletrius_effect_active", "Start", "", 0.20, null);
	            EntFire("spxZM_effect_wand_deletrius", "Stop", "", 0.40, null);
	            EntFire("map_sound_wands", "PlaySound", "", 0.10, null);
	            EntFire("spx_avada_effect_active*", "Stop", "", 0.30, null);
	            EntFire("spx_avada_trigger*", "Disable", "", 0.00, null);
	            EntFire("respawn_deletrius_*", "Kill", "", 0.50, null);
	            EntFire("spxZM_effect_wand_deletrius", "Kill", "", 3.00, null);
	            EntFire("spxZM_deletrius_wandprop", "Kill", "", 3.00, null);
	            EntFire("spxZM_deletrius_effect_*", "Kill", "", 3.00, null);
	            EntFire("spxZM_deletrius_case", "Kill", "", 3.00, null);
	            EntFire("spxZM_deletrius_button", "Kill", "", 3.00, null);
	            EntFire("spxZM_effect_wand_deletrius", "ClearParent", "", 2.00, null);
	            EntFire("spxZM_deletrius_wandprop", "ClearParent", "", 2.00, null);
	            EntFire("spxZM_deletrius_button", "ClearParent", "", 2.00, null);
	            EntFire("spxZM_deletrius_effect_*", "ClearParent", "", 2.00, null);
	            EntFire("respawn_deletrius_template", "Kill", "", 0.20, null);
	            EntFire("spxZM_deletrius_wandprop", "Color", "255 28 28", 0.20, null);
            }
            else 
            {
                EntFire("spxZM_deletrius_effect_failed", "Start", "", 0.00, null);
                EntFire("spxZM_deletrius_effect_active", "Stop", "", 0.00, null);
                EntFire("spxZM_effect_wand_deletrius", "Stop", "", 0.00, null);
                EntFire("spxZM_deletrius_button", "Lock", "", 0.00, null);
                EntFire("respawn_deletrius_template", "Kill", "", 0.20, null);
                EntFire("respawn_deletrius_*", "Kill", "", 0.50, null);
                EntFire("spxZM_deletrius_effect_*", "Stop", "", 1.00, null);
                EntFire("spxZM_deletrius_effect_*", "ClearParent", "", 1.50, null);
                EntFire("spxZM_deletrius_button", "ClearParent", "", 1.50, null);
                EntFire("spxZM_deletrius_wandprop", "ClearParent", "", 1.50, null);
                EntFire("spxZM_effect_wand_deletrius", "ClearParent", "", 1.50, null);
                EntFire("spxZM_deletrius_button", "Kill", "", 2.00, null);
                EntFire("spxZM_deletrius_effect_*", "Kill", "", 2.00, null);
                EntFire("spxZM_deletrius_wandprop", "Kill", "", 2.00, null);
                EntFire("spxZM_effect_wand_deletrius", "Kill", "", 2.00, null);
            }
        }
    }
}

function DeletriusItemM()
{
    ScriptPrintMessageChatAll("ZOMBIE ITEM PICKUP: >>> DELETRIUS SPELL HAS BEEN PICKED UP <<<");
}

////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
REDUCIOACT <- null;
REDUCIOCALL <- null;
REDUCIOONCE <- true;
TickCheckReducio <- true;
////////////////////////////////

////////////////////////////////
////////////REDUCIO/////////////
////////////////////////////////

function PickUpReducio()
{
    REDUCIOACT = activator;
    REDUCIOCALL = caller;
    TickCheckReducio = true;
    EntFire("spxZM_effect_wand_reducio", "Start", "", 1.00, null);
    EntFire("!activator", "RunScriptCode", "UpDateHandle();", 0.00, REDUCIOACT);
    EntFireByHandle(self,"RunScriptCode","ReducioItemM();",2.00,null,null);
    EntFireByHandle(self,"RunScriptCode","CheckOwnerReducio();",5.00,null,null);
    if(REDUCIOONCE)
    {
        EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, REDUCIOACT);
        EntFireByHandle(self,"RunScriptCode","ReducioReceivedLevel();",0.01,null,null);
        REDUCIOONCE = false;
    }
}

function CheckOwnerReducio()
{
    if(TickCheckReducio)
    {
		try
		{
			if(REDUCIOCALL.GetMoveParent() != REDUCIOACT)
			{
				TickCheckReducio = false;
				REDUCIOONCE = true;
				REDUCIOACT = null;
				EntFire("spxZM_reducio_e*", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_wand_reducio", "Stop", "", 0.10, null);
				EntFire("spxZM_effect_static_reducio", "Stop", "", 0.10, null);
				EntFire("spxZM_reducio_button", "Kill", "", 0.20, null);
				EntFire("spxZM_reducio_e*", "Kill", "", 0.20, null);
				EntFire("spxZM_reducio_knife", "Kill", "", 0.20, null);
				EntFire("spxZM_reducio_wandprop", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_wand_reducio", "Kill", "", 0.20, null);
				EntFire("spxZM_effect_static_reducio", "Kill", "", 0.30, null);
				EntFire("itemZM_reducio_entree", "Kill", "", 0.30, null);
				if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_reducio_template", "ForceSpawn", "", 105.40, null);}
			}
		} catch(exception)
		{
			TickCheckReducio = false;
            REDUCIOONCE = true;
            REDUCIOACT = null;
            EntFire("spxZM_reducio_e*", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_wand_reducio", "Stop", "", 0.10, null);
            EntFire("spxZM_effect_static_reducio", "Stop", "", 0.10, null);
            EntFire("spxZM_reducio_button", "Kill", "", 0.20, null);
            EntFire("spxZM_reducio_e*", "Kill", "", 0.20, null);
            EntFire("spxZM_reducio_knife", "Kill", "", 0.20, null);
            EntFire("spxZM_reducio_wandprop", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_wand_reducio", "Kill", "", 0.20, null);
            EntFire("spxZM_effect_static_reducio", "Kill", "", 0.30, null);
            EntFire("itemZM_reducio_entree", "Kill", "", 0.30, null);
            if(ZOMBIE_ITEM_DISABLE){EntFire("respawn_reducio_template", "ForceSpawn", "", 105.40, null);}
		}
        EntFireByHandle(self,"RunScriptCode","CheckOwnerReducio();",5.00,null,null);
    }
}

function ReducioReceivedLevel()
{
    if(ZMITEMLVLUP < 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(17, 0);",3.00,REDUCIOACT);
		EntFire("console","Command","sm_setcooldown 20869434 105",3.00,null);
    }
    else if(ZMITEMLVLUP >= 7)
    {
        EntFire("!activator","RunScriptCode","PersonalItemText(17, 1);",3.00,REDUCIOACT);
		EntFire("console","Command","sm_setcooldown 20869434 100",3.00,null);
    }
}

function UseItemReducio()
{
    if(activator.GetTeam() == 2 && activator == REDUCIOACT && ZOMBIE_ITEM_DISABLE)
    { 
        local zmsm = null;
	    while(null != (zmsm = Entities.FindInSphere(zmsm,REDUCIOACT.GetOrigin(),550)))
	    {
		    if(zmsm.GetTeam() == 2 && zmsm.GetHealth() > 0 && zmsm.IsValid())
		    {
                zmsm.SetModel("models/player/gozombie_rescale.mdl");
		    }
	    }
        EntFire("spxZM_reducio_button","Lock","", 0.00, null);
        EntFire("spxZM_reducio_effect_active","Start","", 0.00, null);
        EntFire("spxZM_effect_wand_reducio","Stop","", 0.00, null);
        EntFire("map_sound_wands","PlaySound","", 0.00, null);
        EntFire("spxZM_reducio_wandprop","Color","255 28 28", 0.00, null);
        EntFire("spxZM_reducio_effect_active","Stop","", 2.00, null);
        if(ZMITEMLVLUP < 7)
        {
            EntFireByHandle(self,"RunScriptCode","ResetModel();",5.00,null,null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",85.00,REDUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",95.00,REDUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",105.00,REDUCIOACT);
            EntFire("spxZM_reducio_wandprop","Color","17 255 77",105.00,null);
            EntFire("spxZM_effect_wand_reducio","Start","",105.00,null);
            EntFire("spxZM_reducio_button","UnLock","",105.00,null);
        }
        else if(ZMITEMLVLUP >= 7)
        {
            EntFireByHandle(self,"RunScriptCode","ResetModel();",7.00,null,null);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(0)",80.00,REDUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(1)",90.00,REDUCIOACT);
            EntFire("!activator","RunScriptCode","COOLDOWNITEM(2)",100.00,REDUCIOACT);
            EntFire("spxZM_reducio_wandprop","Color","17 255 77",100.00,null);
            EntFire("spxZM_effect_wand_reducio","Start","",100.00,null);
            EntFire("spxZM_reducio_button","UnLock","",100.00,null);
        }
    }
}

function ResetModel()
{
    local zmrm = null;
	while(null != (zmrm = Entities.FindByClassname(zmrm,"player")))
	{
		if(zmrm.GetTeam() == 2 && zmrm.GetHealth() > 0 && zmrm.IsValid())
		{
            zmrm.SetModel("models/player/zombie_harry.mdl");
		}
	}
}

function ReducioItemM()
{
    ScriptPrintMessageChatAll("ZOMBIE ITEM PICKUP: >>> REDUCIO SPELL HAS BEEN PICKED UP <<<");
}

////////////////////////////////
////////////////////////////////
////////////////////////////////

////////////////////////////////
/////FIX ZM Double ITEMS////////
////////////////////////////////
function CheckZMPickUpItemsFix()
{
	if(activator==EXPULSOACT)
	{
		EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, EXPULSOACT);
		EntFire("personal_text", "SetText", "You already have ZM Item\nEXPULSO", 0.00, activator);
		EntFire("personal_text", "Display", "", 0.01, activator);
	}
	if(activator==DEPRIMOACT)
	{
		EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, DEPRIMOACT);
		EntFire("personal_text", "SetText", "You already have ZM Item\nDEPRIMO", 0.00, activator);
		EntFire("personal_text", "Display", "", 0.01, activator);
	}
	if(activator==CONFUNDUSACT)
	{
		EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, CONFUNDUSACT);
		EntFire("personal_text", "SetText", "You already have ZM Item\nCONFUNDUS", 0.00, activator);
		EntFire("personal_text", "Display", "", 0.01, activator);
	}
	if(activator==EMENDOACT)
	{
		EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, EMENDOACT);
		EntFire("personal_text", "SetText", "You already have ZM Item\nEMENDO", 0.00, activator);
		EntFire("personal_text", "Display", "", 0.01, activator);
	}
	if(activator==ZMINCENDIOACT)
	{
		EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, ZMINCENDIOACT);
		EntFire("personal_text", "SetText", "You already have ZM Item\nZMINCENDIO", 0.00, activator);
		EntFire("personal_text", "Display", "", 0.01, activator);
	}
	if(activator==DISILLUSIONMENTACT)
	{
		EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, DISILLUSIONMENTACT);
		EntFire("personal_text", "SetText", "You already have ZM Item\nDISILLUSIONMENT", 0.00, activator);
		EntFire("personal_text", "Display", "", 0.01, activator);
	}
	if(activator==CONJUNCTIVITUSACT)
	{
		EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, CONJUNCTIVITUSACT);
		EntFire("personal_text", "SetText", "You already have ZM Item\nCONJUNCTIVITUS", 0.00, activator);
		EntFire("personal_text", "Display", "", 0.01, activator);
	}
	if(activator==DELETRIUSACT)
	{
		EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, DELETRIUSACT);
		EntFire("personal_text", "SetText", "You already have ZM Item\nDELETRIUS", 0.00, activator);
		EntFire("personal_text", "Display", "", 0.01, activator);
	}
	if(activator==REDUCIOACT)
	{
		EntFire("!activator", "AddOutput", "origin 11458 9416 13614", 0.10, REDUCIOACT);
		EntFire("personal_text", "SetText", "You already have ZM Item\nREDUCIO", 0.00, activator);
		EntFire("personal_text", "Display", "", 0.01, activator);
	}
}
////////////////////////////////
/////Glow Invisible ZM//////////
////////////////////////////////
Dz_GlowDelete_Allow<-true;
////////////////////////////////
function Dz_Glow_Invisible_ZM()
{
	if(activator.GetTeam() == 2 && activator == DISILLUSIONMENTACT && ZOMBIE_ITEM_DISABLE)
    { 
		local zmsm = null;
		while(null != (zmsm = Entities.FindByClassname(zmsm,"player")))
		{
			if(zmsm.GetTeam() == 2 && zmsm.GetHealth() > 0 && zmsm.IsValid())
			{
				local pos = zmsm.GetOrigin();
				local posorig = "origin "+pos.x+" "+pos.y+" "+(pos.z+73);
				EntFire("dzfix_PT_glowzm_invis","ForceSpawn","",0.00,null);
				EntFire("dzfix_glowzm_invis","AddOutput",posorig,0.00,null);
				EntFire("dzfix_glowzm_invis","SetParent","!activator",0.00,zmsm);
				EntFire("dzfix_glowzm_invis","AddOutput","targetname dzfix_glowzm_USEDinvis",0.00,null);
			}
		}
		if(Dz_GlowDelete_Allow==true)
		{
			EntFire("dzfix_glowzm_USEDinvis", "Kill", "", 10.00, null);
		}
	}
}

function Dz_Glow_ZM_Delete()
{
	Dz_repiter_Glow_ZM_Set=false;
	Dz_GlowDelete_Allow=true;
	EntFire("dzfix_glowzm_USEDinvis", "Kill", "", 0.00, null);
}

Dz_repiter_Glow_ZM_Set<-false;

function Dz_Glow_ZM_Set()
{
	Dz_repiter_Glow_ZM_Set=true;
	EntFireByHandle(self,"RunScriptCode","Dz_Glow_ZM_Fucn_Set();",1.00,null,null);
}

function Dz_Glow_ZM_Fucn_Set()
{
	if(Dz_repiter_Glow_ZM_Set==true)
	{
		Dz_GlowDelete_Allow=false;
		EntFire("dzfix_glowzm_USEDinvis", "Kill", "", 0.00, null);
		local zmsm = null;
		while((zmsm = Entities.FindByClassname(zmsm,"player")) != null)
		{
			if(zmsm.GetTeam() == 2 && zmsm.GetHealth() > 0 && zmsm.IsValid())
			{
				local pos = zmsm.GetOrigin();
				local posorig = "origin "+pos.x+" "+pos.y+" "+(pos.z+73);
				EntFire("dzfix_PT_glowzm_invis","ForceSpawn","",0.00,null);
				EntFire("dzfix_glowzm_invis","AddOutput",posorig,0.00,null);
				EntFire("dzfix_glowzm_invis","SetParent","!activator",0.00,zmsm);
				EntFire("dzfix_glowzm_invis","AddOutput","targetname dzfix_glowzm_USEDinvis",0.00,null);
			}
		}
		EntFireByHandle(self,"RunScriptCode","Dz_Glow_ZM_Fucn_Set();",5.00,null,null);
	}
}