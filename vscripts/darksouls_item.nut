// Intended for use with the ze_dark_souls_ptd_csgo2 GFL stripper
// Used to add to counters added via stripper so that entwatch can check uses left
// Install as csgo/scripts/vscripts/gfl/darksouls_item.nut

/////////////////////////////////////
//////////////ZM ITEMS///////////////
/////////////////////////////////////

// Default: \x01
// Dark Red: \x02
// Purple: \x03
// Green: \x04
// Light Green: \x05
// Lime Green: \x06
// Red: \x07
// Grey: \x08
// Orange: \x09
// Brownish Orange: \x10 
// Gray: \x08 
// Very faded blue: \x0A 
// Faded blue: \x0B 
// Dark blue: \x0C 

ZM_ITEM_OWNERS <- [];
W_STRIP <- null;
boss_s <- null;
Auto_Update_Message <- false; //true on // not used, text can blink if channel 2 used on server

function OnPostSpawn()
{
    W_STRIP = Entities.FindByName(null, "Map_Stripper");
    boss_s = Entities.FindByName(null, "boss_health");
    UpdateItemText();
}

/////////////////////////////////////
/////////////Toxic Mist//////////////
/////////////////////////////////////

//Ember_Flame_Case Up Item 

Toxic_Owner <- null;
Toxic_Button <- null;
Toxic_Counter <- null;
Toxic_Text <- null;
Toxic_Max_Use <- 10; //10 Default
Toxic_Used <- 0;

function PickUpToxic()
{
    ZM_ITEM_OWNERS.push(activator);
    Toxic_Owner = activator;
    Toxic_Text = Entities.FindByName(null, "Item_PM_Gametext");
    Toxic_Button = Entities.FindByName(null, "Item_PM_Button");
    Toxic_Counter = Entities.FindByName(null, "Toxic_Counter");
    ScriptPrintMessageChatAll(" \x06 **A player has picked up Toxic Mist**");
    Toxic_Text.__KeyValueFromString("message", "Item: Toxic Mist\nEffect: Damages nearby humans\nDuration: 7 seconds");
    EntFireByHandle(Toxic_Text, "Display", "", 0.00, activator, null);
}

function UseToxic()
{
    if(PlayerValidationT(activator, Toxic_Owner))
    {
        Toxic_Used++;
        EntFireByHandle(Toxic_Counter, "SetValue", "" + "" + Toxic_Used, 0.00, null, null);
        local Toxic_Text_B = "TOXIC MIST("+Toxic_Used+"/"+Toxic_Max_Use+")";
        if(Toxic_Used >= Toxic_Max_Use)
        {
            Toxic_Text_B += "\nALL SPELLS USED"
            Toxic_Text.__KeyValueFromString("message", Toxic_Text_B);
            EntFireByHandle(Toxic_Text, "Display", "", 0.00, Toxic_Owner, null);
            EntFireByHandle(Toxic_Button, "FireUser2", "", 0.00, null, null);
        }
        if(Toxic_Used < Toxic_Max_Use)
        {
            Toxic_Text.__KeyValueFromString("message", Toxic_Text_B);
            EntFireByHandle(Toxic_Text, "Display", "", 0.00, Toxic_Owner, null);
        }
        EntFireByHandle(Toxic_Button, "FireUser1", "", 0.00, null, null);
    }
}

/////////////////////////////////////
////////////Power Within/////////////
/////////////////////////////////////

//Ember_Flame_Case Up Item 

Within_Owner <- null;
Within_Button <- null;
Within_Counter <- null;
Within_Text <- null;
Within_Max_Use <- 10; //10 Default
Within_Used <- 0;

function PickUpWithin()
{
    ZM_ITEM_OWNERS.push(activator);
    Within_Owner = activator;
    Within_Text = Entities.FindByName(null, "Item_PW_Gametext");
    Within_Button = Entities.FindByName(null, "Item_PW_Button");
    Within_Counter = Entities.FindByName(null, "Within_Counter");
    ScriptPrintMessageChatAll(" \x07 **A player has picked up Power Within**");
    Within_Text.__KeyValueFromString("message", "Item: Power Within\nEffect: Zombies become really stronger for a few seconds\nDuration: 3 seconds");
    EntFireByHandle(Within_Text, "Display", "", 0.00, activator, null);
}

function UseWithin()
{
    if(PlayerValidationT(activator, Within_Owner))
    {
        Within_Used++;
        EntFireByHandle(Within_Counter, "SetValue", "" + Within_Used, 0.00, null, null);
        local Within_Text_B = "POWER WITHIN("+Within_Used+"/"+Within_Max_Use+")";
        if(Within_Used >= Within_Max_Use)
        {
            Within_Text_B += "\nALL SPELLS USED"
            Within_Text.__KeyValueFromString("message", Within_Text_B);
            EntFireByHandle(Within_Text, "Display", "", 0.00, Within_Owner, null);
            EntFireByHandle(Within_Button, "FireUser2", "", 0.00, null, null);
        }
        if(Within_Used < Within_Max_Use)
        {
            Within_Text.__KeyValueFromString("message", Within_Text_B);
            EntFireByHandle(Within_Text, "Display", "", 0.00, Within_Owner, null);
        }
        EntFireByHandle(Within_Button, "FireUser1", "", 0.00, null, null);
    }
}

function HealZm()
{
    if(activator.GetTeam() == 2 && activator.IsValid() && activator.GetHealth() < 6000)
    {
        EntFireByHandle(activator, "AddOutput", "health 6000", 0.00, null, null);
    }
}

/////////////////////////////////////
/////////////Poison Mist/////////////
/////////////////////////////////////

Poisoned_Humans <- [];

Poison_Owner <- null;
Poison_Button <- null;
Poison_Counter <- null;
Poison_Text <- null;
Poison_Max_Use <- 10; //10 Default
Poison_Used <- 0;

function PickUpPoison()
{
    ZM_ITEM_OWNERS.push(activator);
    Poison_Owner = activator;
    Poison_Text = Entities.FindByName(null, "Item_ZMPoison_Gametext");
    Poison_Counter = Entities.FindByName(null, "Poison_Counter");
    Poison_Button = Entities.FindByName(null, "Item_ZMPoison_Button");
    ScriptPrintMessageChatAll(" \x04 **A player has picked up Poison Mist**");
    Poison_Text.__KeyValueFromString("message", "Item: Poison\nEffect: Gets nearby humans poisoned\nDuration: 7 seconds");
    EntFireByHandle(Poison_Text, "Display", "", 0.00, activator, null);
}

function UsePoison()
{
    if(PlayerValidationT(activator, Poison_Owner))
    {
        Poison_Used++;
          EntFireByHandle(Poison_Counter, "SetValue", "" + Poison_Used, 0.00, null, null);
        local Poison_Text_B = "POISON MIST("+Poison_Used+"/"+Poison_Max_Use+")";
        if(Poison_Used >= Poison_Max_Use)
        {
            Poison_Text_B += "\nALL SPELLS USED"
            Poison_Text.__KeyValueFromString("message", Poison_Text_B);
            EntFireByHandle(Poison_Text, "Display", "", 0.00, Poison_Owner, null);
            EntFireByHandle(Poison_Button, "FireUser2", "", 0.00, null, null);
        }
        if(Poison_Used < Poison_Max_Use)
        {
            Poison_Text.__KeyValueFromString("message", Poison_Text_B);
            EntFireByHandle(Poison_Text, "Display", "", 0.00, Poison_Owner, null);
        }
        EntFireByHandle(Poison_Button, "FireUser1", "", 0.00, null, null);
        EntFireByHandle(self, "RunScriptCode", "HurtPoisonedHumans();", 0.05, null, null);
        EntFireByHandle(self, "RunScriptCode", "HurtPoisonedHumans();", 1.05, null, null);
        EntFireByHandle(self, "RunScriptCode", "HurtPoisonedHumans();", 2.05, null, null);
        EntFireByHandle(self, "RunScriptCode", "HurtPoisonedHumans();", 3.05, null, null);
        EntFireByHandle(self, "RunScriptCode", "HurtPoisonedHumans();", 4.05, null, null);
        EntFireByHandle(self, "RunScriptCode", "HurtPoisonedHumans();", 5.05, null, null);
        EntFireByHandle(self, "RunScriptCode", "HurtPoisonedHumans();", 6.05, null, null);
        EntFireByHandle(self, "RunScriptCode", "HurtPoisonedHumans();", 7.05, null, null);
        if(Poisoned_Humans.len() > 0){EntFireByHandle(self, "RunScriptCode", "Poisoned_Humans.clear();", 8.00, null, null);}
    }
}

function HurtPoisonedHumans()
{
    if(Poisoned_Humans.len() > 0)
    {
        for(local i = 0; i < Poisoned_Humans.len(); i++)
        {
            if(Poisoned_Humans[i].IsValid() && Poisoned_Humans[i].GetTeam() == 3 && Poisoned_Humans[i].GetHealth() >= 10)
            {
                Poisoned_Humans[i].SetHealth(Poisoned_Humans[i].GetHealth() * 0.85);
            }
        } 
    }
}

function PoisonedAdd()
{
    if(activator.GetTeam() == 3 && CheckPArr(activator) && activator.IsValid())
    {
        Poisoned_Humans.push(activator);
    }
}

function CheckPArr(act_p)
{
    foreach (p in Poisoned_Humans) 
    {
        if(p == act_p)
        {
            return false;
        }
    }
    return true;
}

/////////////////////////////////////
/////////////BlackFlame//////////////
/////////////////////////////////////

BlackFlame_Owner <- null;
BlackFlame_Button <- null;
BlackFlame_Counter <- null;
BlackFlame_Text <- null;
BlackFlame_Max_Use <- 10; //10 Default
BlackFlame_Used <- 0;

function PickUpBlackFlame()
{
    ZM_ITEM_OWNERS.push(activator);
    BlackFlame_Owner = activator;
    BlackFlame_Text = Entities.FindByName(null, "Item_BF_Gametext");
    BlackFlame_Counter = Entities.FindByName(null, "BlackFlame_Counter");
    BlackFlame_Button = Entities.FindByName(null, "Item_BF_Button");
    ScriptPrintMessageChatAll(" \x09 **A player has picked up Black Flame**");
    BlackFlame_Text.__KeyValueFromString("message", "Item: Black Flame\nEffect: Making the fire orb that damages humans\nDuration: 1 second");
    EntFireByHandle(BlackFlame_Text, "Display", "", 0.00, activator, null);
}

function UseBlackFlame()
{
    if(PlayerValidationT(activator, BlackFlame_Owner))
    {
        BlackFlame_Used++;
          EntFireByHandle(BlackFlame_Counter, "SetValue", "" + BlackFlame_Used, 0.00, null, null);
        local BlackFlame_Text_B = "BLACK FLAME("+BlackFlame_Used+"/"+BlackFlame_Max_Use+")";
        if(BlackFlame_Used >= BlackFlame_Max_Use)
        {
            BlackFlame_Text_B += "\nALL SPELLS USED";
            BlackFlame_Text.__KeyValueFromString("message", BlackFlame_Text_B);
            EntFireByHandle(BlackFlame_Text, "Display", "", 0.00, BlackFlame_Owner, null);
            EntFireByHandle(BlackFlame_Button, "FireUser2", "", 0.00, null, null);
        }
        if(BlackFlame_Used < BlackFlame_Max_Use)
        {
            BlackFlame_Text.__KeyValueFromString("message", BlackFlame_Text_B);
            EntFireByHandle(BlackFlame_Text, "Display", "", 0.00, BlackFlame_Owner, null);
        }
        EntFireByHandle(BlackFlame_Button, "FireUser1", "", 0.00, null, null);
    }
}

/////////////////////////////////////
//////////////HU ITEMS///////////////
/////////////////////////////////////

/////////////////////////////////////
/////////////AshenEstus//////////////
/////////////////////////////////////

AEF_OWNER <- null;
AEF_BUTTON <- null;
AEF_Counter <- null;
AEF_WEAPON <- null;
AEF_TEXT <- null;
AEF_MAX_USE <- 3;
AEF_USED <- 0;

function PickUpAef()
{
    AEF_OWNER = activator;
    if(AEF_BUTTON == null){AEF_BUTTON = Entities.FindByName(null, "Item_AEF_Button");}
    if(AEF_TEXT == null){AEF_TEXT = Entities.FindByName(null, "Item_AEF_Gametext");}
     if(AEF_Counter == null){AEF_Counter = Entities.FindByName(null, "AEF_Counter");}
    if(AEF_WEAPON == null){AEF_WEAPON = caller;}
    if(!AEF_BUTTON.IsValid())return;
    ScriptPrintMessageChatAll(" \x0A **A player has picked up Ashen Estus Flask**");
    AEF_TEXT.__KeyValueFromString("message", "Item: Ashen Estus Flask\nEffect: Gives one more use to all of human items");
    EntFireByHandle(AEF_TEXT, "Display", "", 0.00, activator, null);
}

function UseAef()
{
    if(PlayerValidationCT(activator, AEF_OWNER))
    {
        AEF_USED++;
          EntFireByHandle(AEF_Counter, "SetValue", "" + AEF_USED, 0.00, null, null);
        local AEF_TEXT_B = "ASHEN ESTUS("+AEF_USED+"/"+AEF_MAX_USE+")";
        if(AEF_USED >= AEF_MAX_USE)
        {
            AEF_TEXT_B += "\nALL SPELLS USED"
            AEF_TEXT.__KeyValueFromString("message", AEF_TEXT_B);
            EntFireByHandle(AEF_TEXT, "Display", "", 0.00, AEF_OWNER, null);
            EntFireByHandle(AEF_BUTTON, "FireUser2", "", 0.00, null, null);
        }
        if(AEF_USED < AEF_MAX_USE)
        {
            AEF_TEXT.__KeyValueFromString("message", AEF_TEXT_B);
            EntFireByHandle(AEF_TEXT, "Display", "", 0.00, AEF_OWNER, null);
        }
        EntFireByHandle(AEF_BUTTON, "FireUser1", "", 0.00, null, null);
        AddUseItems();
    }
}

function AddUseItems()
{
    if(ItemValidation(ChaosStorm_Owner, ChaosStorm_Weapon, ChaosStorm_Button))
    {
        ChaosStorm_Max_Use++;
        EntFireByHandle(ChaosStorm_Counter, "AddOutput", "max " + ChaosStorm_Max_Use, 0.00, null, null);
        EntFireByHandle(ChaosStorm_Text, "Display", "", 0.00, ChaosStorm_Owner, null);
    }
    if(ItemValidation(Darkstorm_Owner, Darkstorm_Weapon, Darkstorm_Button))
    {
        Darkstorm_Max_Use++;
        EntFireByHandle(Darkstorm_Counter, "AddOutput", "max " + Darkstorm_Max_Use, 0.00, null, null);
        EntFireByHandle(Darkstorm_Text, "Display", "", 0.00, Darkstorm_Owner, null);
    }
    if(ItemValidation(DarkOrb_Owner, DarkOrb_Weapon, DarkOrb_Button))
    {
        DarkOrb_Max_Use++;
        EntFireByHandle(DarkOrb_Counter, "AddOutput", "max " + DarkOrb_Max_Use, 0.00, null, null);
        EntFireByHandle(DarkOrb_Text, "Display", "", 0.00, DarkOrb_Owner, null);
    }
    if(ItemValidation(EstusFlask_Owner, EstusFlask_Weapon, EstusFlask_Button))
    {
        EstusFlask_Max_Use++;
          EntFireByHandle(EstusFlask_Counter, "AddOutput", "max " + EstusFlask_Max_Use, 0.00, null, null);
        EntFireByHandle(EstusFlask_Text, "Display", "", 0.00, EstusFlask_Owner, null);
    }
    if(ItemValidation(GHSA_Owner, GHSA_Weapon, GHSA_Button))
    {
        GHSA_Max_Use++;
        EntFireByHandle(GHSA_Counter, "AddOutput", "max " + GHSA_Max_Use, 0.00, null, null);
        EntFireByHandle(GHSA_Text, "Display", "", 0.00, GHSA_Owner, null);
    }
    if(ItemValidation(HiBo_Owner, HiBo_Weapon, HiBo_Button))
    {
        HiBo_Max_Use++;
        EntFireByHandle(HiBo_Counter, "AddOutput", "max " + HiBo_Max_Use, 0.00, null, null);
        EntFireByHandle(HiBo_Text, "Display", "", 0.00, HiBo_Owner, null);
    }
    if(ItemValidation(LS_Owner, LS_Weapon, LS_Button))
    {
        LS_Max_Use++;
        EntFireByHandle(LS_Counter, "AddOutput", "max " + LS_Max_Use, 0.00, null, null);
        EntFireByHandle(LS_Text, "Display", "", 0.00, LS_Owner, null);
    }
    if(ItemValidation(GreenBlossom_Owner, GreenBlossom_Weapon, GreenBlossom_Button))
    {
        GreenBlossom_Max_Use++;
          EntFireByHandle(GreenBlossom_Counter, "AddOutput", "max " + GreenBlossom_Max_Use, 0.00, null, null);
        EntFireByHandle(GreenBlossom_Text, "Display", "", 0.00, GreenBlossom_Owner, null);
    }
    if(ItemValidation(SS_Owner, SS_Weapon, SS_Button))
    {
        SS_Max_Use++;
        EntFireByHandle(SS_Counter, "AddOutput", "max " + SS_Max_Use, 0.00, null, null);
        EntFireByHandle(SS_Text, "Display", "", 0.00, SS_Owner, null);
    }
    if(ItemValidation(WDB_Owner, WDB_Weapon, WDB_Button))
    {
        WDB_Max_Use++;
        EntFireByHandle(WDB_Counter, "AddOutput", "max " + WDB_Max_Use, 0.00, null, null);
        EntFireByHandle(WDB_Text, "Display", "", 0.00, WDB_Owner, null);
    }
    if(ItemValidation(WOTG_Owner, WOTG_Weapon, WOTG_Button))
    {
        WOTG_Max_Use++;
        EntFireByHandle(WOTG_Counter, "AddOutput", "max " + WOTG_Max_Use, 0.00, null, null);
        EntFireByHandle(WOTG_Text, "Display", "", 0.00, WOTG_Owner, null);
    }
}

/////////////////////////////////////
/////////////ChaosStorm//////////////
/////////////////////////////////////

ChaosStorm_Owner <- null;
ChaosStorm_Button <- null;
ChaosStorm_Counter <- null;
ChaosStorm_Weapon <- null;
ChaosStorm_Text <- null;
ChaosStorm_Max_Use <- 3;
ChaosStorm_Used <- 0;

function PickUpChaosStorm()
{
    ChaosStorm_Owner = activator;
    if(ChaosStorm_Button == null){ChaosStorm_Button = Entities.FindByName(null, "Item_ChSt_Button");}
    if(ChaosStorm_Text == null){ChaosStorm_Text = Entities.FindByName(null, "Item_ChSt_Gametext");}
    if(ChaosStorm_Counter == null){ChaosStorm_Counter = Entities.FindByName(null, "ChaosStorm_Counter");}
    if(ChaosStorm_Weapon == null){ChaosStorm_Weapon = caller;}
    if(!ChaosStorm_Button.IsValid())return;
    ScriptPrintMessageChatAll(" \x09 **A player has picked up Chaos Storm**");
    ChaosStorm_Text.__KeyValueFromString("message", "Item: Chaos Storm\nEffect: Casts fire pillars that damages zombies\nDuration: 6 seconds");
    EntFireByHandle(ChaosStorm_Text, "Display", "", 0.00, activator, null);
}

function UseChaosStorm()
{
    if(PlayerValidationCT(activator, ChaosStorm_Owner))
    {
        ChaosStorm_Used++;
        EntFireByHandle(ChaosStorm_Counter, "SetValue", "" + ChaosStorm_Used, 0.00, null, null);
        local ChaosStorm_Text_B = "CHAOS STORM("+ChaosStorm_Used+"/"+ChaosStorm_Max_Use+")";
        if(IsBossFight())
        {
            local n_mcx = (ChaosStorm_Owner.GetOrigin().x + 200).tointeger(); //400 unit box with center player owned item
            local n_mcy = (ChaosStorm_Owner.GetOrigin().y + 200).tointeger();
            local n_micx = (ChaosStorm_Owner.GetOrigin().x - 200).tointeger();
            local n_micy = (ChaosStorm_Owner.GetOrigin().y - 200).tointeger();
            DebugDrawBox(ChaosStorm_Owner.GetOrigin(), Vector(-200,-200,0), Vector(200,200,200), 250, 0, 0, 250, 1);
            local boss_scope = boss_s.GetScriptScope();
            local Gwyndolin_B = Entities.FindByName(null, "Gwyndolin_Phys_Body");
            if(boss_scope.BOSS_HITBOX != null && boss_scope.BOSS_HITBOX.IsValid())
            {
                if(boss_scope.BOSS_HITBOX.GetName() == "Golem_Phys_Body")
                {
                    local golem_s = Entities.FindByName(null, "npc_script_golem");
                    if(golem_s != null && golem_s.GetScriptScope().npc_move.IsValid())
                    {
                        local golem_m_pos = golem_s.GetScriptScope().npc_move.GetOrigin();
                        if(golem_m_pos.x <= n_mcx && golem_m_pos.x >= n_micx && golem_m_pos.y <= n_mcy && golem_m_pos.y >= n_micy)
                        {
                            boss_s.GetScriptScope().SubHpIt(125);
                            ChaosStorm_Text_B += "\nIron Golem -150 HP";
                        }
                    }
                }
                if(boss_scope.BOSS_HITBOX.GetName() == "Broadhead_Phys_Body")
                {
                    local Broadhead_s = Entities.FindByName(null, "npc_script_broadhead");
                    if(Broadhead_s != null && Broadhead_s.GetScriptScope().npc_move.IsValid())
                    {
                        local Broadhead_m_pos = Broadhead_s.GetScriptScope().npc_move.GetOrigin();
                        if(Broadhead_m_pos.x <= n_mcx && Broadhead_m_pos.x >= n_micx && Broadhead_m_pos.y <= n_mcy && Broadhead_m_pos.y >= n_micy)
                        {
                            boss_s.GetScriptScope().SubHpIt(100);
                            ChaosStorm_Text_B += "\nBroadhead -100 HP";
                        }
                    }
                }
            }
            if(boss_scope.BOSS_HITBOX == null && Gwyndolin_B != null && Gwyndolin_B.IsValid())
            {
                local Gwyndolin_s = Entities.FindByName(null, "npc_script_gwyndolin");
                if(Gwyndolin_s != null && Gwyndolin_s.GetScriptScope().npc_move.IsValid())
                {
                    local Gwyndolin_m_pos = Gwyndolin_s.GetScriptScope().npc_move.GetOrigin();
                    if(Gwyndolin_m_pos.x <= n_mcx && Gwyndolin_m_pos.x >= n_micx && Gwyndolin_m_pos.y <= n_mcy && Gwyndolin_m_pos.y >= n_micy)
                    {
                        Gwyndolin_B.GetScriptScope().SubHpIt(150);
                        ChaosStorm_Text_B += "\nGwyndolin -150 HP";
                    }
                }
            }
        }
        if(ChaosStorm_Used >= ChaosStorm_Max_Use)
        {
            ChaosStorm_Text_B += "\nALL SPELLS USED"
            ChaosStorm_Text.__KeyValueFromString("message", ChaosStorm_Text_B);
            EntFireByHandle(ChaosStorm_Text, "Display", "", 0.00, ChaosStorm_Owner, null);
            EntFireByHandle(ChaosStorm_Button, "FireUser2", "", 0.00, null, null);
        }
        if(ChaosStorm_Used < ChaosStorm_Max_Use)
        {
            ChaosStorm_Text.__KeyValueFromString("message", ChaosStorm_Text_B);
            EntFireByHandle(ChaosStorm_Text, "Display", "", 0.00, ChaosStorm_Owner, null);
        }
        EntFireByHandle(ChaosStorm_Button, "FireUser1", "", 0.00, null, null);
    }
}

/////////////////////////////////////
//////////////Darkstorm//////////////
/////////////////////////////////////

Darkstorm_Owner <- null;
Darkstorm_Button <- null;
Darkstorm_Counter <- null;
Darkstorm_Weapon <- null;
Darkstorm_Text <- null;
Darkstorm_Max_Use <- 2;
Darkstorm_Used <- 0;

function PickUpDarkstorm()
{
    Darkstorm_Owner = activator;
    if(Darkstorm_Button == null){Darkstorm_Button = Entities.FindByName(null, "Item_DaSt_Button");}
    if(Darkstorm_Text == null){Darkstorm_Text = Entities.FindByName(null, "Item_DaSt_Gametext");}
    if(Darkstorm_Counter == null){Darkstorm_Counter = Entities.FindByName(null, "Darkstorm_Counter");}
    if(Darkstorm_Weapon == null){Darkstorm_Weapon = caller;}
    if(!Darkstorm_Button.IsValid())return;
    ScriptPrintMessageChatAll(" \x03 **A player has picked up Darkstorm**");
    Darkstorm_Text.__KeyValueFromString("message", "Item: Darkstorm\nEffect: Creates the magic wall that ignites and push zombies away\nDuration: 5 seconds");
    EntFireByHandle(Darkstorm_Text, "Display", "", 0.00, activator, null);
}

function UseDarkstorm()
{
    if(PlayerValidationCT(activator, Darkstorm_Owner))
    {
        Darkstorm_Used++;
        EntFireByHandle(Darkstorm_Counter, "SetValue", "" + Darkstorm_Used, 0.00, null, null);
        local Darkstorm_Text_B = "DARK STORM("+Darkstorm_Used+"/"+Darkstorm_Max_Use+")";
        if(Darkstorm_Used >= Darkstorm_Max_Use)
        {
            Darkstorm_Text_B += "\nALL SPELLS USED"
            Darkstorm_Text.__KeyValueFromString("message", Darkstorm_Text_B);
            EntFireByHandle(Darkstorm_Text, "Display", "", 0.00, Darkstorm_Owner, null);
            EntFireByHandle(Darkstorm_Button, "FireUser2", "", 0.00, null, null);
        }
        if(Darkstorm_Used < Darkstorm_Max_Use)
        {
            Darkstorm_Text.__KeyValueFromString("message", Darkstorm_Text_B);
            EntFireByHandle(Darkstorm_Text, "Display", "", 0.00, Darkstorm_Owner, null);
        }
        EntFireByHandle(Darkstorm_Button, "FireUser1", "", 0.00, null, null);
    }
}

/////////////////////////////////////
///////////////DarkOrb///////////////
/////////////////////////////////////

DarkOrb_Owner <- null;
DarkOrb_Button <- null;
DarkOrb_Counter <- null;
DarkOrb_Weapon <- null;
DarkOrb_Text <- null;
DarkOrb_Max_Use <- 3;
DarkOrb_Used <- 0;

function PickUpDarkOrb()
{
    DarkOrb_Owner = activator;
    if(DarkOrb_Button == null){DarkOrb_Button = Entities.FindByName(null, "Item_DO_Button");}
    if(DarkOrb_Text == null){DarkOrb_Text = Entities.FindByName(null, "Item_DO_Gametext");}
    if(DarkOrb_Counter == null){DarkOrb_Counter = Entities.FindByName(null, "DarkOrb_Counter");}
    if(DarkOrb_Weapon == null){DarkOrb_Weapon = caller;}
    if(!DarkOrb_Button.IsValid())return;
    ScriptPrintMessageChatAll(" \x03 **A player has picked up Dark Orb**");
    DarkOrb_Text.__KeyValueFromString("message", "Item: Dark Orb\nEffect: Making the orb that damages zombies\nDuration: 1 second");
    EntFireByHandle(DarkOrb_Text, "Display", "", 0.00, activator, null);
}

function UseDarkOrb()
{
    if(PlayerValidationCT(activator, DarkOrb_Owner))
    {
        DarkOrb_Used++;
        EntFireByHandle(DarkOrb_Counter, "SetValue", "" + DarkOrb_Used, 0.00, null, null);
        local DarkOrb_Text_B = "DARK ORB("+DarkOrb_Used+"/"+DarkOrb_Max_Use+")";
        if(IsBossFight())
        {
            local boss_scope = boss_s.GetScriptScope();
            local Gwyndolin_B = Entities.FindByName(null, "Gwyndolin_Phys_Body");
            local Ornstein_B = Entities.FindByName(null, "Ornstein_Phys_Body");
            if(boss_scope.BOSS_HITBOX != null && boss_scope.BOSS_HITBOX.IsValid())
            {
                if(boss_scope.BOSS_HITBOX.GetName() == "Golem_Phys_Body" && DistanceCheck(DarkOrb_Owner, boss_scope.BOSS_HITBOX) <= GOLEM_DIST)
                {
                    DarkOrb_Owner.SetVelocity(Vector(2,2,0));
                    if(DamageBoss(DarkOrb_Button, 200, 10) == "HIT"){DarkOrb_Text_B += "\nIron Golem -200 HP";}
                }
                if(boss_scope.BOSS_HITBOX.GetName() == "Gwyn_Phys_Body" && DistanceCheck(DarkOrb_Owner, boss_scope.BOSS_HITBOX) <= GWYN_DIST)
                {
                    DarkOrb_Owner.SetVelocity(Vector(2,2,0));
                    if(DamageBoss(DarkOrb_Button, 250, 10) == "HIT"){DarkOrb_Text_B += "\nGwyn -250 HP";}
                }
            }
            if(boss_scope.BOSS_HITBOX == null && Gwyndolin_B != null && Gwyndolin_B.IsValid() && DistanceCheck(DarkOrb_Owner, Gwyndolin_B) <= GWYNDOLIN_DIST)
            {
                DarkOrb_Owner.SetVelocity(Vector(2,2,0));
                if(DamageBoss(DarkOrb_Button, 300, 10, Gwyndolin_B) == "HIT"){DarkOrb_Text_B += "\nGwyndolin -300 HP";}
            }
            if(boss_scope.BOSS_HITBOX == null && Ornstein_B != null && Ornstein_B.IsValid() && DistanceCheck(DarkOrb_Owner, Ornstein_B) <= ORNSTEIN_DIST)
            {
                DarkOrb_Owner.SetVelocity(Vector(2,2,0));
                if(DamageBoss(DarkOrb_Button, 250, 10, Ornstein_B) == "HIT"){DarkOrb_Text_B += "\nOrnstein -250 HP";}
            }
        }
        if(DarkOrb_Used >= DarkOrb_Max_Use)
        {
            DarkOrb_Text_B += "\nALL SPELLS USED"
            DarkOrb_Text.__KeyValueFromString("message", DarkOrb_Text_B);
            EntFireByHandle(DarkOrb_Text, "Display", "", 0.00, DarkOrb_Owner, null);
            EntFireByHandle(DarkOrb_Button, "FireUser2", "", 0.00, null, null);
        }
        if(DarkOrb_Used < DarkOrb_Max_Use)
        {
            DarkOrb_Text.__KeyValueFromString("message", DarkOrb_Text_B);
            EntFireByHandle(DarkOrb_Text, "Display", "", 0.00, DarkOrb_Owner, null);
        }
        EntFireByHandle(DarkOrb_Button, "FireUser1", "", 0.00, null, null);
    }
}

/////////////////////////////////////
//////////////EstusFlask/////////////
/////////////////////////////////////

EstusFlask_Owner <- null;
EstusFlask_Button <- null;
EstusFlask_Counter <- null;
EstusFlask_Weapon <- null;
EstusFlask_Text <- null;
EstusFlask_Max_Use <- 5;
EstusFlask_Used <- 0;

function PickUpEstusFlask()
{
    EstusFlask_Owner = activator;
    if(EstusFlask_Button == null){EstusFlask_Button = Entities.FindByName(null, "Item_EF_Button");}
    if(EstusFlask_Text == null){EstusFlask_Text = Entities.FindByName(null, "Item_EF_Gametext");}
    if(EstusFlask_Counter == null){EstusFlask_Counter = Entities.FindByName(null, "EstusFlask_Counter");}
    if(EstusFlask_Weapon == null){EstusFlask_Weapon = caller;}
    if(!EstusFlask_Button.IsValid())return;
    ScriptPrintMessageChatAll(" \x09 **A player has picked up Estus Flask**");
    EstusFlask_Text.__KeyValueFromString("message", "Item: Estus Flask\nEffect: Heals nearby players\nDuration: 3 seconds");
    EntFireByHandle(EstusFlask_Text, "Display", "", 0.00, activator, null);
}

function UseEstusFlask()
{
    if(PlayerValidationCT(activator, EstusFlask_Owner))
    {
        EstusFlask_Used++;
        local EstusFlask_Text_B = "ESTUS FLASK("+EstusFlask_Used+"/"+EstusFlask_Max_Use+")";
        if(EstusFlask_Used >= EstusFlask_Max_Use)
        {
            EstusFlask_Text_B += "\nALL SPELLS USED"
            EstusFlask_Text.__KeyValueFromString("message", EstusFlask_Text_B);
            EntFireByHandle(EstusFlask_Text, "Display", "", 0.00, EstusFlask_Owner, null);
            EntFireByHandle(EstusFlask_Button, "FireUser2", "", 0.00, null, null);
        }
        if(EstusFlask_Used < EstusFlask_Max_Use)
        {
            EstusFlask_Text.__KeyValueFromString("message", EstusFlask_Text_B);
            EntFireByHandle(EstusFlask_Text, "Display", "", 0.00, EstusFlask_Owner, null);
        }
        EntFireByHandle(EstusFlask_Button, "FireUser1", "", 0.00, null, null);
    }
}

/////////////////////////////////////
////////////////GHSA/////////////////
/////////////////////////////////////

GHSA_Owner <- null;
GHSA_Button <- null;
GHSA_Counter <- null;
GHSA_Weapon <- null;
GHSA_Text <- null;
GHSA_Max_Use <- 10;
GHSA_Used <- 0;

function PickUpGHSA()
{
    GHSA_Owner = activator;
    if(GHSA_Button == null){GHSA_Button = Entities.FindByName(null, "Item_GHSA_Button");}
    if(GHSA_Text == null){GHSA_Text = Entities.FindByName(null, "Item_GHSA_Gametext");}
    if(GHSA_Counter == null){GHSA_Counter = Entities.FindByName(null, "GHSA_Counter");}
    if(GHSA_Weapon == null){GHSA_Weapon = caller;}
    if(!GHSA_Button.IsValid())return;
    ScriptPrintMessageChatAll(" \x0C **A player has picked up Great Heavy Soul Arrow**");
    GHSA_Text.__KeyValueFromString("message", "Item: Great Heavy Soul Arrow\nEffect: Making the spear that damages zombies\nDuration: 1 second");
    EntFireByHandle(GHSA_Text, "Display", "", 0.00, activator, null);
}

function UseGHSA()
{
    if(PlayerValidationCT(activator, GHSA_Owner))
    {
        GHSA_Used++;
        EntFireByHandle(GHSA_Counter, "SetValue", "" + GHSA_Used, 0.00, null, null);
        local GHSA_Text_B = "GHSA("+GHSA_Used+"/"+GHSA_Max_Use+")";
        if(IsBossFight())
        {
            local boss_scope = boss_s.GetScriptScope();
            local Ornstein_B = Entities.FindByName(null, "Ornstein_Phys_Body");
            if(boss_scope.BOSS_HITBOX != null && boss_scope.BOSS_HITBOX.IsValid())
            {
                if(boss_scope.BOSS_HITBOX.GetName() == "Golem_Phys_Body" && DistanceCheck(GHSA_Owner, boss_scope.BOSS_HITBOX) <= GOLEM_DIST)
                {
                    GHSA_Owner.SetVelocity(Vector(2,2,0));
                    if(DamageBoss(GHSA_Owner, 100, 20) == "HIT"){GHSA_Text_B += "\nIron Golem -100 HP";}
                }
            }
            if(boss_scope.BOSS_HITBOX == null && Ornstein_B != null && Ornstein_B.IsValid() && DistanceCheck(GHSA_Owner, Ornstein_B) <= ORNSTEIN_DIST)
            {
                GHSA_Owner.SetVelocity(Vector(2,2,0));
                if(DamageBoss(GHSA_Owner, 100, 10, Ornstein_B) == "HIT"){GHSA_Text_B += "\nOrnstein -100 HP";}
            }
        }
        if(GHSA_Used >= GHSA_Max_Use)
        {
            GHSA_Text_B += "\nALL SPELLS USED"
            GHSA_Text.__KeyValueFromString("message", GHSA_Text_B);
            EntFireByHandle(GHSA_Text, "Display", "", 0.00, GHSA_Owner, null);
            EntFireByHandle(GHSA_Button, "FireUser2", "", 0.00, null, null);
        }
        if(GHSA_Used < GHSA_Max_Use)
        {
            GHSA_Text.__KeyValueFromString("message", GHSA_Text_B);
            EntFireByHandle(GHSA_Text, "Display", "", 0.00, GHSA_Owner, null);
        }
        EntFireByHandle(GHSA_Button, "FireUser1", "", 0.00, null, null);
    }
}

/////////////////////////////////////
/////////////HiddenBody//////////////
/////////////////////////////////////

HiBo_Owner <- null;
HiBo_Button <- null;
HiBo_Counter <- null;
HiBo_Weapon <- null;
HiBo_Text <- null;
HiBo_Max_Use <- 2;
HiBo_Used <- 0;

function PickUpHiBo()
{
    HiBo_Owner = activator;
    if(HiBo_Button == null){HiBo_Button = Entities.FindByName(null, "Item_HiBo_Button");}
    if(HiBo_Text == null){HiBo_Text = Entities.FindByName(null, "Item_HiBo_Gametext");}
    if(HiBo_Counter == null){HiBo_Counter = Entities.FindByName(null, "HiBo_Counter");}
    if(HiBo_Weapon == null){HiBo_Weapon = caller;}
    if(!HiBo_Button.IsValid())return;
    ScriptPrintMessageChatAll(" \x09 **A player has picked up Hidden Body**");
    HiBo_Text.__KeyValueFromString("message", "Item: Hidden Body\nEffect: Makes players invisible and gives immunity against zombies\nDuration: 7 seconds");
    EntFireByHandle(HiBo_Text, "Display", "", 0.00, activator, null);
}

function UseHiBo()
{
    if(PlayerValidationCT(activator, HiBo_Owner))
    {
        HiBo_Used++;
        EntFireByHandle(HiBo_Counter, "SetValue", "" + HiBo_Used, 0.00, null, null);
        local HiBo_Text_B = "HIDDEN BODY("+HiBo_Used+"/"+HiBo_Max_Use+")";
        if(HiBo_Used >= HiBo_Max_Use)
        {
            HiBo_Text_B += "\nALL SPELLS USED"
            HiBo_Text.__KeyValueFromString("message", HiBo_Text_B);
            EntFireByHandle(HiBo_Text, "Display", "", 0.00, HiBo_Owner, null);
            EntFireByHandle(HiBo_Button, "FireUser2", "", 0.00, null, null);
        }
        if(HiBo_Used < HiBo_Max_Use)
        {
            HiBo_Text.__KeyValueFromString("message", HiBo_Text_B);
            EntFireByHandle(HiBo_Text, "Display", "", 0.00, HiBo_Owner, null);
        }
        EntFireByHandle(HiBo_Button, "FireUser1", "", 0.00, null, null);
        DisableZmPoison();
    }
}

function DisableZmPoison()
{
    if(Poisoned_Humans.len() > 0){Poisoned_Humans.clear();}
}

/////////////////////////////////////
///////////LightningSpear////////////
/////////////////////////////////////

LS_Owner <- null;
LS_Button <- null;
LS_Counter <- null;
LS_Weapon <- null;
LS_Text <- null;
LS_Max_Use <- 7;
LS_Used <- 0;

function PickUpLS()
{
    LS_Owner = activator;
    if(LS_Button == null){LS_Button = Entities.FindByName(null, "Item_LS_Button");}
    if(LS_Text == null){LS_Text = Entities.FindByName(null, "Item_LS_Gametext");}
    if(LS_Counter == null){LS_Counter = Entities.FindByName(null, "LS_Counter");}
    if(LS_Weapon == null){LS_Weapon = caller;}
    if(!LS_Button.IsValid())return;
    ScriptPrintMessageChatAll(" \x09 **A player has picked up Lightning Spear**");
    LS_Text.__KeyValueFromString("message", "Item: Lightning Spear\nEffect: Making the spear that damages and slows zombies\nDuration: 1 second");
    EntFireByHandle(LS_Text, "Display", "", 0.00, activator, null);
}

function UseLS()
{
    if(PlayerValidationCT(activator, LS_Owner))
    {
        LS_Used++;
        EntFireByHandle(LS_Counter, "SetValue", "" + LS_Used, 0.00, null, null);
        local LS_TEXT_B = "LIGHTNING SPEAR("+LS_Used+"/"+LS_Max_Use+")";
        if(IsBossFight())
        {
            local boss_scope = boss_s.GetScriptScope();
            local Gwyndolin_B = Entities.FindByName(null, "Gwyndolin_Phys_Body");
            if(boss_scope.BOSS_HITBOX != null && boss_scope.BOSS_HITBOX.IsValid())
            {
                if(boss_scope.BOSS_HITBOX.GetName() == "Asylum_Demon_Hitbox" && DistanceCheck(LS_Owner, boss_scope.BOSS_HITBOX) <= ASYLUM_DEMON_DIST)
                {
                    LS_Owner.SetVelocity(Vector(2,2,0));
                    if(DamageBoss(LS_Button, 150, 20) == "HIT"){LS_TEXT_B += "\nAsylum Demon -150 HP";}
                }
                if(boss_scope.BOSS_HITBOX.GetName() == "Broadhead_Phys_Body" && DistanceCheck(LS_Owner, boss_scope.BOSS_HITBOX) <= BROADHEAD_DIST)
                {
                    LS_Owner.SetVelocity(Vector(2,2,0));
                    if(DamageBoss(LS_Button, 50, 10) == "HIT"){LS_TEXT_B += "\nBroadhead -50 HP";}
                }
            }
            if(boss_scope.BOSS_HITBOX == null && Gwyndolin_B != null && Gwyndolin_B.IsValid() && DistanceCheck(LS_Owner, Gwyndolin_B) <= GWYNDOLIN_DIST)
            {
                LS_Owner.SetVelocity(Vector(2,2,0));
                if(DamageBoss(LS_Button, 75, 10, Gwyndolin_B) == "HIT"){LS_TEXT_B += "\nGwyndolin -75 HP";}
            }
        }
        if(LS_Used >= LS_Max_Use)
        {
            LS_TEXT_B += "\nALL SPELLS USED";
            LS_Text.__KeyValueFromString("message", LS_TEXT_B);
            EntFireByHandle(LS_Text, "Display", "", 0.00, LS_Owner, null);
            EntFireByHandle(LS_Button, "FireUser2", "", 0.00, null, null);
        }
        if(LS_Used < LS_Max_Use)
        {
            LS_Text.__KeyValueFromString("message", LS_TEXT_B);
            EntFireByHandle(LS_Text, "Display", "", 0.00, LS_Owner, null);
        }
        EntFireByHandle(LS_Button, "FireUser1", "", 0.00, null, null);
    }
}

/////////////////////////////////////
////////////GreenBlossom/////////////
/////////////////////////////////////

GreenBlossom_Owner <- null;
GreenBlossom_Button <- null;
GreenBlossom_Counter <- null;
GreenBlossom_Weapon <- null;
GreenBlossom_Text <- null;
GreenBlossom_Max_Use <- 3;
GreenBlossom_Used <- 0;

function PickUpGreenBlossom()
{
    GreenBlossom_Owner = activator;
    if(GreenBlossom_Button == null){GreenBlossom_Button = Entities.FindByName(null, "Item_Salad_Button");}
    if(GreenBlossom_Text == null){GreenBlossom_Text = Entities.FindByName(null, "Item_Salad_Gametext");}
     if(GreenBlossom_Counter == null){GreenBlossom_Counter = Entities.FindByName(null, "GreenBlossom_Counter");}
    if(GreenBlossom_Weapon == null){GreenBlossom_Weapon = caller;}
    if(!GreenBlossom_Button.IsValid())return;
    ScriptPrintMessageChatAll(" \x06 **A player has picked up Green Blossom**");
    GreenBlossom_Text.__KeyValueFromString("message", "Item: Green Blossom\nEffect: Gives speed to all nearby humans\nDuration: 4 seconds");
    EntFireByHandle(GreenBlossom_Text, "Display", "", 0.00, activator, null);
}

function UseGreenBlossom()
{
    if(PlayerValidationCT(activator, GreenBlossom_Owner))
    {
        GreenBlossom_Used++;
          EntFireByHandle(GreenBlossom_Counter, "SetValue", "" + GreenBlossom_Used, 0.00, null, null);
        local GreenBlossom_Text_B = "GREEN BLOSSOM("+GreenBlossom_Used+"/"+GreenBlossom_Max_Use+")";
        if(GreenBlossom_Used >= GreenBlossom_Max_Use)
        {
            GreenBlossom_Text_B += "\nALL SPELLS USED"
            GreenBlossom_Text.__KeyValueFromString("message", GreenBlossom_Text_B);
            EntFireByHandle(GreenBlossom_Text, "Display", "", 0.00, GreenBlossom_Owner, null);
            EntFireByHandle(GreenBlossom_Button, "FireUser2", "", 0.00, null, null);
        }
        if(GreenBlossom_Used < GreenBlossom_Max_Use)
        {
            GreenBlossom_Text.__KeyValueFromString("message", GreenBlossom_Text_B);
            EntFireByHandle(GreenBlossom_Text, "Display", "", 0.00, GreenBlossom_Owner, null);
        }
        EntFireByHandle(GreenBlossom_Button, "FireUser1", "", 0.00, null, null);
    }
}

/////////////////////////////////////
//////////SoothingSunlight///////////
/////////////////////////////////////

SS_Owner <- null;
SS_Button <- null;
SS_Counter <- null;
SS_Weapon <- null;
SS_Text <- null;
SS_Max_Use <- 3;
SS_Used <- 0;

function PickUpSS()
{
    SS_Owner = activator;
    if(SS_Button == null){SS_Button = Entities.FindByName(null, "Item_SS_Button");}
    if(SS_Text == null){SS_Text = Entities.FindByName(null, "Item_SS_Gametext");}
    if(SS_Counter == null){SS_Counter = Entities.FindByName(null, "SS_Counter");}
    if(SS_Weapon == null){SS_Weapon = caller;}
    if(!SS_Button.IsValid())return;
    ScriptPrintMessageChatAll(" \x10 **A player has picked up Soothing Sunlight**");
    SS_Text.__KeyValueFromString("message", "Item: Soothing Sunlight\nEffect: Heals nearby humans\nDuration: 15 seconds");
    EntFireByHandle(SS_Text, "Display", "", 0.00, activator, null);
}

function UseSS()
{
    if(PlayerValidationCT(activator, SS_Owner))
    {
        SS_Used++;
        EntFireByHandle(SS_Counter, "SetValue", "" + SS_Used, 0.00, null, null);
        local SS_Text_B = "SOOTHING SUNLIGHT("+SS_Used+"/"+SS_Max_Use+")";
        if(SS_Used >= SS_Max_Use)
        {
            SS_Text_B += "\nALL SPELLS USED";
            SS_Text.__KeyValueFromString("message", SS_Text_B);
            EntFireByHandle(SS_Text, "Display", "", 0.00, SS_Owner, null);
            EntFireByHandle(SS_Button, "FireUser2", "", 0.00, null, null);
        }
        if(SS_Used < SS_Max_Use)
        {
            SS_Text.__KeyValueFromString("message", SS_Text_B);
            EntFireByHandle(SS_Text, "Display", "", 0.00, SS_Owner, null);
        }
        EntFireByHandle(SS_Button, "FireUser1", "", 0.00, null, null);
    }
}

/////////////////////////////////////
//////////WhiteDragonBreath//////////
/////////////////////////////////////

WDB_Owner <- null;
WDB_Button <- null;
WDB_Counter <- null;
WDB_Weapon <- null;
WDB_Text <- null;
WDB_Max_Use <- 4;
WDB_Used <- 0;

function PickUpWDB()
{
    WDB_Owner = activator;
    if(WDB_Button == null){WDB_Button = Entities.FindByName(null, "Item_WDB_Button");}
    if(WDB_Text == null){WDB_Text = Entities.FindByName(null, "Item_WDB_Gametext");}
    if(WDB_Counter == null){WDB_Counter = Entities.FindByName(null, "WDB_Counter");}
    if(WDB_Weapon == null){WDB_Weapon = caller;}
    if(!WDB_Button.IsValid())return;
    ScriptPrintMessageChatAll(" \x0A **A player has picked up White Dragon Breath**");
    WDB_Text.__KeyValueFromString("message", "Item: White Dragon Breath\nEffect: Throws ice spikes arrow\nDuration: 6 seconds");
    EntFireByHandle(WDB_Text, "Display", "", 0.00, activator, null);
}

function UseWDB()
{
    if(PlayerValidationCT(activator, WDB_Owner))
    {
        WDB_Used++;
        EntFireByHandle(WDB_Counter, "SetValue", "" + WDB_Used, 0.00, null, null);
        local WDB_Text_B = "WHITE DRAGON BREATH("+WDB_Used+"/"+WDB_Max_Use+")";
        if(IsBossFight())
        {
            local boss_scope = boss_s.GetScriptScope();
            if(boss_scope.BOSS_HITBOX != null && boss_scope.BOSS_HITBOX.IsValid())
            {
                if(boss_scope.BOSS_HITBOX.GetName() == "Golem_Phys_Body" && DistanceCheck(WDB_Owner, boss_scope.BOSS_HITBOX) <= GOLEM_DIST)
                {
                    WDB_Owner.SetVelocity(Vector(2,2,0));
                    if(DamageBoss(WDB_Button, 100, 20) == "HIT"){WDB_Text_B += "\nIron Golem -100 HP";}
                }
                if(boss_scope.BOSS_HITBOX.GetName() == "Broadhead_Phys_Body" && DistanceCheck(WDB_Owner, boss_scope.BOSS_HITBOX) <= BROADHEAD_DIST)
                {
                    WDB_Owner.SetVelocity(Vector(2,2,0));
                    if(DamageBoss(WDB_Button, 100, 10) == "HIT"){WDB_Text_B += "\nBroadhead -100 HP";}
                }
            }
        }
        if(WDB_Used >= WDB_Max_Use)
        {
            WDB_Text_B += "\nALL SPELLS USED"
            WDB_Text.__KeyValueFromString("message", WDB_Text_B);
            EntFireByHandle(WDB_Text, "Display", "", 0.00, WDB_Owner, null);
            EntFireByHandle(WDB_Button, "FireUser2", "", 0.00, null, null);
        }
        if(WDB_Used < WDB_Max_Use)
        {
            WDB_Text.__KeyValueFromString("message", WDB_Text_B);
            EntFireByHandle(WDB_Text, "Display", "", 0.00, WDB_Owner, null);
        }
        EntFireByHandle(WDB_Button, "FireUser1", "", 0.00, null, null);
    }
}

/////////////////////////////////////
////////////WrathofTheGods///////////
/////////////////////////////////////

WOTG_Owner <- null;
WOTG_Button <- null;
WOTG_Counter <- null;
WOTG_Weapon <- null;
WOTG_Text <- null;
WOTG_Max_Use <- 6;
WOTG_Used <- 0;

function PickUpWOTG()
{
    WOTG_Owner = activator;
    if(WOTG_Button == null){WOTG_Button = Entities.FindByName(null, "Item_WOTG_Button");}
    if(WOTG_Text == null){WOTG_Text = Entities.FindByName(null, "Item_WOTG_Gametext");}
    if(WOTG_Counter == null){WOTG_Counter = Entities.FindByName(null, "WOTG_Counter");}
    if(WOTG_Weapon == null){WOTG_Weapon = caller;}
    if(!WOTG_Button.IsValid())return;
    ScriptPrintMessageChatAll(" \x01 **A player has picked up Wrath of The Gods**");
    WOTG_Text.__KeyValueFromString("message", "Item: Wrath of The Gods\nEffect: Pushes zombies away\nDuration: 1 second");
    EntFireByHandle(WOTG_Text, "Display", "", 0.00, activator, null);
}

function UseWOTG()
{
    if(PlayerValidationCT(activator, WOTG_Owner))
    {
        WOTG_Used++;
        EntFireByHandle(WOTG_Counter, "SetValue", "" + WOTG_Used, 0.00, null, null);
        local WOTG_Text_B = "WRATH OF THE GODS("+WOTG_Used+"/"+WOTG_Max_Use+")";
        if(WOTG_Used >= WOTG_Max_Use)
        {
            WOTG_Text_B += "\nALL SPELLS USED"
            WOTG_Text.__KeyValueFromString("message", WOTG_Text_B);
            EntFireByHandle(WOTG_Text, "Display", "", 0.00, WOTG_Owner, null);
            EntFireByHandle(WOTG_Button, "FireUser2", "", 0.00, null, null);
        }
        if(WOTG_Used < WOTG_Max_Use)
        {
            WOTG_Text.__KeyValueFromString("message", WOTG_Text_B);
            EntFireByHandle(WOTG_Text, "Display", "", 0.00, WOTG_Owner, null);
        }
        EntFireByHandle(WOTG_Button, "FireUser1", "", 0.00, null, null);
    }
}

/////////////////////////////////////
/////////////////////////////////////
/////////////////////////////////////

ASYLUM_DEMON_DIST <- 1500;
GOLEM_DIST <- 1000;
GWYN_DIST <- 1000;
BROADHEAD_DIST <- 1000;
GWYNDOLIN_DIST <- 1500;
ORNSTEIN_DIST <- 1500;

function WeaponStripper()
{
    if(activator.IsValid() && activator.GetTeam() == 2 && activator.GetHealth() >= 1000)
    {
        if(ZM_ITEM_OWNERS.len() == 0){EntFireByHandle(W_STRIP, "StripWeaponsAndSuit", "", 0.00, activator, null);}
        else
        {
            for(local i = 0; i < ZM_ITEM_OWNERS.len(); i++)
            {
                if(activator == ZM_ITEM_OWNERS[i]){return;}
            }
            EntFireByHandle(W_STRIP, "StripWeaponsAndSuit", "", 0.00, activator, null);
        }
    }
}

function PlayerValidationT(act, item_owner)
{
    if(act.IsValid() && act.GetTeam() == 2 && act.GetHealth() > 0 && act == item_owner)
    {
        return true;
    }
    return false;
}

function PlayerValidationCT(act, item_owner)
{
    if(act.IsValid() && act.GetTeam() == 3 && act.GetHealth() > 0 && act == item_owner)
    {
        return true;
    }
    return false;
}

function ItemValidation(item_owner, item_weapon, item_button)
{
    if(item_weapon != null && item_weapon.IsValid() && item_button.IsValid() && item_owner == item_weapon.GetMoveParent())
    {
        return true;
    }
    return false;
}

function UpdateItemText()
{
    if(Auto_Update_Message)
    {
        EntFireByHandle(self, "RunScriptCode", "UpdateItemText();", 1.00, null, null);
    }
    if(ItemValidation(AEF_OWNER, AEF_WEAPON, AEF_BUTTON))
    {
        EntFireByHandle(AEF_TEXT, "Display", "", 0.00, AEF_OWNER, null);
    }
    if(ItemValidation(ChaosStorm_Owner, ChaosStorm_Weapon, ChaosStorm_Button))
    {
        EntFireByHandle(ChaosStorm_Text, "Display", "", 0.00, ChaosStorm_Owner, null);
    }
    if(ItemValidation(Darkstorm_Owner, Darkstorm_Weapon, Darkstorm_Button))
    {
        EntFireByHandle(Darkstorm_Text, "Display", "", 0.00, Darkstorm_Owner, null);
    }
    if(ItemValidation(DarkOrb_Owner, DarkOrb_Weapon, DarkOrb_Button))
    {
        EntFireByHandle(DarkOrb_Text, "Display", "", 0.00, DarkOrb_Owner, null);
    }
    if(ItemValidation(EstusFlask_Owner, EstusFlask_Weapon, EstusFlask_Button))
    {
        EntFireByHandle(EstusFlask_Text, "Display", "", 0.00, EstusFlask_Owner, null);
    }
    if(ItemValidation(GHSA_Owner, GHSA_Weapon, GHSA_Button))
    {
        EntFireByHandle(GHSA_Text, "Display", "", 0.00, GHSA_Owner, null);
    }
    if(ItemValidation(HiBo_Owner, HiBo_Weapon, HiBo_Button))
    {
        EntFireByHandle(HiBo_Text, "Display", "", 0.00, HiBo_Owner, null);
    }
    if(ItemValidation(LS_Owner, LS_Weapon, LS_Button))
    {
        EntFireByHandle(LS_Text, "Display", "", 0.00, LS_Owner, null);
    }
    if(ItemValidation(GreenBlossom_Owner, GreenBlossom_Weapon, GreenBlossom_Button))
    {
        EntFireByHandle(GreenBlossom_Text, "Display", "", 0.00, GreenBlossom_Owner, null);
    }
    if(ItemValidation(SS_Owner, SS_Weapon, SS_Button))
    {
        EntFireByHandle(SS_Text, "Display", "", 0.00, SS_Owner, null);
    }
    if(ItemValidation(WDB_Owner, WDB_Weapon, WDB_Button))
    {
        EntFireByHandle(WDB_Text, "Display", "", 0.00, WDB_Owner, null);
    }
    if(ItemValidation(WOTG_Owner, WOTG_Weapon, WOTG_Button))
    {
        EntFireByHandle(WOTG_Text, "Display", "", 0.00, WOTG_Owner, null);
    }
}

function AddMaxUseDarkItem(n){
    DarkOrb_Max_Use += n;
    EntFireByHandle(DarkOrb_Counter, "AddOutput", "max " + DarkOrb_Max_Use, 0.00, null, null);
}

function AddMaxUseDivineItem(n)
{
    WOTG_Max_Use += n;
    EntFireByHandle(WOTG_Counter, "AddOutput", "max " + WOTG_Max_Use, 0.00, null, null);
    SS_Max_Use += n;
    EntFireByHandle(SS_Counter, "AddOutput", "max " + SS_Max_Use, 0.00, null, null);
    LS_Max_Use += n;
    EntFireByHandle(LS_Counter, "AddOutput", "max " + LS_Max_Use, 0.00, null, null);
}

function AddMaxUseMagicItem(n)
{
    WDB_Max_Use += n;
    EntFireByHandle(WDB_Counter, "AddOutput", "max " + WDB_Max_Use, 0.00, null, null);
    HiBo_Max_Use += n;
    EntFireByHandle(HiBo_Counter, "AddOutput", "max " + HiBo_Max_Use, 0.00, null, null);
    GHSA_Max_Use += n;
    EntFireByHandle(GHSA_Counter, "AddOutput", "max " + GHSA_Max_Use, 0.00, null, null);
}

function AddMaxUseFlameItem(n)
{
    Within_Max_Use += n;
    EntFireByHandle(Within_Counter, "AddOutput", "max " + Within_Max_Use, 0.00, null, null);
    Toxic_Max_Use += n;
    EntFireByHandle(Toxic_Counter, "AddOutput", "max " + Toxic_Max_Use, 0.00, null, null);
    ChaosStorm_Max_Use += n;
    EntFireByHandle(ChaosStorm_Counter, "AddOutput", "max " + ChaosStorm_Max_Use, 0.00, null, null);
}

function SetItemLevel(n)
{
    Toxic_Max_Use = n;
    EntFireByHandle(Toxic_Counter, "AddOutput", "max " + Toxic_Max_Use, 0.00, null, null);
    Within_Max_Use = n;
    EntFireByHandle(Within_Counter, "AddOutput", "max " + Within_Max_Use, 0.00, null, null);
    Poison_Max_Use = n;
     EntFireByHandle(Poison_Counter, "AddOutput", "max " + Poison_Max_Use, 0.00, null, null);
    BlackFlame_Max_Use = n;
     EntFireByHandle(BlackFlame_Counter, "AddOutput", "max " + BlackFlame_Max_Use, 0.00, null, null);
    AEF_MAX_USE = n;
     EntFireByHandle(AEF_Counter, "AddOutput", "max " + AEF_MAX_USE, 0.00, null, null);
    ChaosStorm_Max_Use = n;
    EntFireByHandle(ChaosStorm_Counter, "AddOutput", "max " + ChaosStorm_Max_Use, 0.00, null, null);
    Darkstorm_Max_Use = n;
    EntFireByHandle(Darkstorm_Counter, "AddOutput", "max " + Darkstorm_Max_Use, 0.00, null, null);
    DarkOrb_Max_Use = n;
    EntFireByHandle(DarkOrb_Counter, "AddOutput", "max " + DarkOrb_Max_Use, 0.00, null, null);
    EstusFlask_Max_Use = n;
     EntFireByHandle(EstusFlask_Counter, "AddOutput", "max " + EstusFlask_Max_Use, 0.00, null, null);
    GHSA_Max_Use = n;
    EntFireByHandle(GHSA_Counter, "AddOutput", "max " + GHSA_Max_Use, 0.00, null, null);
    HiBo_Max_Use = n;
    EntFireByHandle(HiBo_Counter, "AddOutput", "max " + HiBo_Max_Use, 0.00, null, null);
    LS_Max_Use = n;
    EntFireByHandle(LS_Counter, "AddOutput", "max " + LS_Max_Use, 0.00, null, null);
    GreenBlossom_Max_Use = n;
     EntFireByHandle(GreenBlossom_Counter, "AddOutput", "max " + GreenBlossom_Max_Use, 0.00, null, null);
    SS_Max_Use = n;
    EntFireByHandle(SS_Counter, "AddOutput", "max " + SS_Max_Use, 0.00, null, null);
    WDB_Max_Use = n;
    EntFireByHandle(WDB_Counter, "AddOutput", "max " + WDB_Max_Use, 0.00, null, null);
    WOTG_Max_Use = n;
    EntFireByHandle(WOTG_Counter, "AddOutput", "max " + WOTG_Max_Use, 0.00, null, null);
}

function IsBossFight()
{
    if(boss_s != null && boss_s.IsValid())
    {
        local b_scope = boss_s.GetScriptScope();
        if(b_scope.ItemDamage)
        {
            return true;
        }
        return false;
    }
    return false;
}

function DistanceCheck(owner, object)
{
    local dist = (owner.GetOrigin().x-object.GetOrigin().x)*(owner.GetOrigin().x-object.GetOrigin().x)+(owner.GetOrigin().y-object.GetOrigin().y)*(owner.GetOrigin().y-object.GetOrigin().y)+(owner.GetOrigin().z-owner.GetOrigin().z)*(owner.GetOrigin().z-owner.GetOrigin().z);
    return sqrt(dist);
}

/////////////////////
angularlimit <- 1;

function DamageBoss(item_b, d, ang_lim, boss_ns=null)
{
    angularlimit = ang_lim;
    local b_scope = boss_s.GetScriptScope();
    local target_rol = 0;
    if(b_scope.BOSS_HITBOX != null && b_scope.BOSS_HITBOX.IsValid())
    {
        target_rol = GetTargetYaw(item_b.GetOrigin(),b_scope.BOSS_HITBOX.GetOrigin()) - item_b.GetAngles().y;
    }
    if(boss_ns != null)
    {
        target_rol = GetTargetYaw(item_b.GetOrigin(),boss_ns.GetOrigin()) - item_b.GetAngles().y;
    }
    if(target_rol >= 0.00 && target_rol < angularlimit || target_rol < 0.00 && target_rol > (-angularlimit))
    {
        if(item_b.GetName() == "Item_WDB_Button")
        {
            local golem_model_s = Entities.FindByName(null, "npc_script_golem");
            local broadhead_model_s = Entities.FindByName(null, "npc_script_broadhead");
            if(golem_model_s != null && golem_model_s.GetScriptScope().npc_model != null && golem_model_s.GetScriptScope().npc_model.IsValid())
            {
                EntFireByHandle(golem_model_s.GetScriptScope().npc_model, "FireUser1", "", 0.00, null, null);
                return "HIT";
            }
            if(broadhead_model_s != null && broadhead_model_s.GetScriptScope().npc_model != null && broadhead_model_s.GetScriptScope().npc_model.IsValid())
            {
                EntFireByHandle(broadhead_model_s.GetScriptScope().npc_model, "FireUser1", "", 0.00, null, null);
                return "HIT";
            }
        }
        if(boss_ns != null)
        {
            boss_ns.GetScriptScope().SubHpIt(d);
            return "HIT";
        }
        b_scope.SubHpIt(d);
        return "HIT";
    }
    else if(target_rol <= -360 && target_rol > (-360 + (-angularlimit)) || target_rol > -360 && target_rol < (-360 + (angularlimit)))
    {
        if(item_b.GetName() == "Item_WDB_Button")
        {
            local golem_model_s = Entities.FindByName(null, "npc_script_golem");
            local broadhead_model_s = Entities.FindByName(null, "npc_script_broadhead");
            if(golem_model_s != null && golem_model_s.GetScriptScope().npc_model != null && golem_model_s.GetScriptScope().npc_model.IsValid())
            {
                EntFireByHandle(golem_model_s.GetScriptScope().npc_model, "FireUser1", "", 0.00, null, null);
                return "HIT";
            }
            if(broadhead_model_s != null && broadhead_model_s.GetScriptScope().npc_model != null && broadhead_model_s.GetScriptScope().npc_model.IsValid())
            {
                EntFireByHandle(broadhead_model_s.GetScriptScope().npc_model, "FireUser1", "", 0.00, null, null);
                return "HIT";
            }
        }
        if(boss_ns != null)
        {
            boss_ns.GetScriptScope().SubHpIt(d);
            return "HIT";
        }
        b_scope.SubHpIt(d);
        return "HIT";
    }
}

function GetTargetYaw(start,target)
{
    local yaw = 0.00;
    local v = Vector(start.x - target.x, start.y - target.y, start.z - start.z);
    local vl = sqrt(v.x * v.x + v.y * v.y);
    yaw = 180 * acos(v.x / vl) / 3.14159;
    yaw -= 180;
    if(v.y < 0)
    {
        yaw =- yaw;
    }
    return yaw;
}

function Test()
{
    // EntFireByHandle(self, "RunScriptCode", "Test();", 0.05, null, null);
    if(Poisoned_Humans.len() > 0)
    {
        ScriptPrintMessageCenterAll("PH: "+Poisoned_Humans.len());
    }    
    if(ChaosStorm_Weapon != null)
    {
        ScriptPrintMessageCenterAll("ChSt WOwner: "+ChaosStorm_Weapon.GetMoveParent());
    }
}