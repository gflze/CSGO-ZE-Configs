//intended for use with the ze_dark_souls_ptd_v0_4_csgo7 GFL stripper
//patches the PickUpZmItem() function
//install as csgo/scripts/vscripts/dark/item_c_patched.nut
AEFACT <- null;
AEFCALL <- null;
ChStACT <- null;
ChStCALL <- null;
DaStACT <- null;
DaStCALL <- null;
DOACT <- null;
DOCALL <- null;
EFACT <- null;
EFCALL <- null;
GHSAACT <- null;
GHSACALL <- null;
HiBoACT <- null;
HiBoCALL <- null;
LSACT <- null;
LSCALL <- null;
SaladACT <- null;
SaladCALL <- null;
SSACT <- null;
SSCALL <- null;
WDBACT <- null;
WDBCALL <- null;
WOTGACT <- null;
WOTGCALL <- null;
///////////
//ZM ITEM//
///////////
BFACT <- null;
BFCALL <- null;
///////////
PMACT <- null;
PMCALL <- null;
///////////
PWACT <- null;
PWCALL <- null;
///////////

TickAEF <- true;
TickChSt <- true;
TickDaSt <- true;
TickDO <- true;
TickEF <- true;
TickGHSA <- true;
TickHiBo <- true;
TickLS <- true;
TickSalad <- true;
TickSS <- true;
TickWDB <- true;
TickWOTG <- true;
///////////
//ZM ITEM//
///////////
TickBF <- true;
///////////
TickPM <- true;
///////////
TickPW <- true;
///////////

MaxUsesAEF <- 3;
UsedAEF <- 0;
//////
MaxUsesChSt <- 3;
UsedChSt <- 0;
//////
MaxUsesDaSt <- 2;
UsedDaSt <- 0;
//////
MaxUsesDO <- 3;
UsedDO <- 0;
//////
MaxUsesEF <- 5;
UsedEF <- 0;
//////
MaxUsesGHSA <- 10;
UsedGHSA <- 0;
//////
MaxUsesHiBo <- 2;
UsedHiBo <- 0;
//////
MaxUsesLS <- 7;
UsedLS <- 0;
//////
MaxUsesSalad <- 3;
UsedSalad <- 0;
//////
MaxUsesSS <- 3;
UsedSS <- 0;
//////
MaxUsesWDB <- 4;
UsedWDB <- 0;
//////
MaxUsesWOTG <- 6;
UsedWOTG <- 0;
///////////
//ZM ITEM//
///////////
MaxUsesBF <- 10;
UsedBF <- 0;
///////////
MaxUsesPM <- 10;
UsedPM <- 0;
///////////
MaxUsesPW <- 10;
UsedPW <- 0;
///////////

function PrintVariable()
{
	printl("MaxUsesAEF: "+
	MaxUsesAEF+
	"\nUsedAEF: "+
	UsedAEF+
	"\nMaxUsesChSt: "+
	MaxUsesChSt+
	"\nUsedChSt: "+
	UsedChSt+
	"\nMaxUsesDaSt: "+
	MaxUsesDaSt+
	"\nUsedDaSt: "+
	UsedDaSt+
	"\nMaxUsesDO: "+
	MaxUsesDO+
	"\nUsedDO: "+
	UsedDO+
	"\nMaxUsesEF: "+
	MaxUsesEF+
	"\nUsedEF: "+
	UsedEF+
	"\nMaxUsesGHSA: "+
	MaxUsesGHSA+
	"\nUsedGHSA: "+
	UsedGHSA+
	"\nMaxUsesHiBo: "+
	MaxUsesHiBo+
	"\nUsedHiBo: "+
	UsedHiBo+
	"\nMaxUsesLS: "+
	MaxUsesLS+
	"\nUsedLS: "+
	UsedLS+
	"\nMaxUsesSalad: "+
	MaxUsesSalad+
	"\nUsedSalad: "+
	UsedSalad+
	"\nMaxUsesSS: "+
	MaxUsesSS+
	"\nUsedSS: "+
	UsedSS+
	"\nMaxUsesWDB: "+
	MaxUsesWDB+
	"\nUsedWDB: "+
	UsedWDB+
	"\nMaxUsesWOTG: "+
	MaxUsesWOTG+
	"\nUsedWOTG: "+
	UsedWOTG);
}

//////////////////////////////////////////
////////////AEF ITEM/////////////////////
/////////////////////////////////////////

function PickUpAEF()
{
	AEFACT = activator;
	AEFCALL = caller;
    EntFire("Item_AEF_Gametext","SetText","Item: Ashen Estus Flask\nEffect: Gives one more use to all of human items",0.00,null);
	EntFire("Item_AEF_Gametext","Display","",0.05,AEFACT);
	EntFireByHandle(self, "RunScriptCode", " UsesAEF(); ", 5.00, null, null);  
}

function UsesAEF()
{
	if(TickAEF && AEFCALL.GetMoveParent() == AEFACT)
	{
		if(UsedAEF <= MaxUsesAEF)
	    {
		    EntFire("Item_AEF_Gametext","SetText","AEF("+UsedAEF+"/"+MaxUsesAEF+")",0.00,null);
	        EntFire("Item_AEF_Gametext","Display","",0.05,AEFACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesAEF(); ", 1.00, null, null);  
	    }
	    if(UsedAEF == MaxUsesAEF)
	    {
			TickAEF = false;
		    EntFire("Item_AEF_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_AEF_Gametext","Display","",1.05,AEFACT);
		    EntFire("Item_AEF_Gametext","Kill","",6.00,null);
	    }
	}
}

function UseAEF()
{
	if(UsedAEF <= MaxUsesAEF)
	{
		EntFire("Item_AEF_Use","PlaySound","",0.00,null);
	    EntFire("AEF_AEFfect","Start","",0.00,null);
	    EntFire("Item_AEF_Button","Lock","",0.00,null);
	    EntFire("AEF_AEFfect","Stop","",3.00,null);
	    EntFire("Item_AEF_Button","UnLock","",4.50,null);
		AddUsedItemAEF();
		UsedAEF++;
	}
	if(UsedAEF == MaxUsesAEF)
	{
		EntFire("Item_AEF_Button","Kill","",0.05,null);
		EntFire("Item_AEF_Pic","Kill","",6.00,null);
	}
}

function AddUsedItemAEF()
{
	if(ChStCALL != null)
	{
		MaxUsesChSt++;
	}
	if(DaStCALL != null)
	{
		MaxUsesDaSt++;
	}
	if(DOCALL != null)
	{
		MaxUsesDO++;
	}
	if(EFCALL != null)
	{
		MaxUsesEF++;
	}
	if(GHSACALL != null)
	{
		MaxUsesGHSA++;
	}
	if(HiBoCALL != null)
	{
		MaxUsesHiBo++;
	}
	if(LSCALL != null)
	{
		MaxUsesLS++;
	}
	if(SaladCALL != null)
	{
		MaxUsesSalad++;
	}
	if(SSCALL != null)
	{
		MaxUsesSS++;
	}
	if(WDBCALL != null)
	{
		MaxUsesWDB++;
	}
	if(WOTGCALL != null)
	{
		MaxUsesWOTG++;
	}
}
//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

//////////////////////////////////////////
/////////////////FIRE/////////////////////
//////////////////////////////////////////

function PickUpChSt()
{
	ChStACT = activator;
	ChStCALL = caller;
    EntFire("Item_ChSt_Gametext","SetText","Item: Chaos Storm\nEffect: Casts fire pillars that damages zombies\nDuration: 6 seconds",0.00,null);
	EntFire("Item_ChSt_Gametext","Display","",0.05,ChStACT);
	EntFireByHandle(self, "RunScriptCode", " UsesChSt(); ", 5.00, null, null);  
}

//////////////////////
///BOSS ITEM DAMAGE///
//////////////////////////
///////////////////////////////
///Gwyndolin 1950/////
///////////////////////////////
///////////////////////////
///Golem 1625/////
///////////////////////////

function UsesChSt()
{
	if(TickChSt && ChStCALL.GetMoveParent() == ChStACT)
	{
		if(UsedChSt <= MaxUsesChSt)
	    {
		    EntFire("Item_ChSt_Gametext","SetText","Fire("+UsedChSt+"/"+MaxUsesChSt+")",0.00,null);
	        EntFire("Item_ChSt_Gametext","Display","",0.05,ChStACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesChSt(); ", 1.00, null, null);  
	    }
	    if(UsedChSt == MaxUsesChSt)
	    {
			TickChSt = false;
		    EntFire("Item_ChSt_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_ChSt_Gametext","Display","",1.05,ChStACT);
		    EntFire("Item_ChSt_Gametext","Kill","",6.00,null);
	    }
	}
}

function UseChSt()
{
	if(UsedChSt <= MaxUsesChSt)
	{
		UsedChSt++;
		EntFire("Item_ChSt_Use","PlaySound","",0.00,null);
	    EntFire("Item_ChSt_Button","Lock","",0.00,null);
	    EntFire("Item_ChSt_Spawner","ForceSpawn","",0.01,null);
	    EntFire("Item_ChSt_Button","UnLock","",10.0,null);
	}
	if(UsedChSt == MaxUsesChSt)
	{
		EntFire("Item_ChSt_Button","Kill","",0.05,null);
		EntFire("Item_ChSt_Pic","Kill","",6.00,null);
		EntFire("Item_ChSt_Spawner","Kill","",6.00,null);
		EntFire("ChSt_Temp","Kill","",6.00,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

//////////////////////////////////////////
/////////////////WIND/////////////////////
/////////////////////////////////////////

function PickUpDaSt()
{
	DaStACT = activator;
	DaStCALL = caller;
    EntFire("Item_DaSt_Gametext","SetText","Item: Darkstorm\nEffect: Creates the magic wall that ignites and push zombies away\nDuration: 5 seconds",0.00,null);
	EntFire("Item_DaSt_Gametext","Display","",0.05,DaStACT);
	EntFireByHandle(self, "RunScriptCode", " UsesDaSt(); ", 5.00, null, null);  
}

function UsesDaSt()
{
	if(TickDaSt && DaStCALL.GetMoveParent() == DaStACT)
	{
		if(UsedDaSt <= MaxUsesDaSt)
	    {
		    EntFire("Item_DaSt_Gametext","SetText","Wind("+UsedDaSt+"/"+MaxUsesDaSt+")",0.00,null);
	        EntFire("Item_DaSt_Gametext","Display","",0.05,DaStACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesDaSt(); ", 1.00, null, null);  
	    }
	    if(UsedDaSt == MaxUsesDaSt)
	    {
			TickDaSt = false;
		    EntFire("Item_DaSt_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_DaSt_Gametext","Display","",1.05,DaStACT);
		    EntFire("Item_DaSt_Gametext","Kill","",6.00,null);
	    }
	}
}

function UseDaSt()
{
	if(UsedDaSt <= MaxUsesDaSt)
	{
		UsedDaSt++;
		EntFire("Item_DaSt_Use","PlaySound","",0.00,null);
	    EntFire("Item_DaSt_Button","Lock","",0.00,null);
		EntFire("Item_DaSt_Spawner","AddOutput","angles 0 0 0",0.00,null);
	    EntFire("Item_DaSt_Spawner","ForceSpawn","",0.02,null);
	    EntFire("Item_DaSt_Button","UnLock","",10.0,null);
	}
	if(UsedDaSt == MaxUsesDaSt)
	{
		EntFire("Item_DaSt_Button","Kill","",0.05,null);
		EntFire("Item_DaSt_Pic","Kill","",6.00,null);
		EntFire("Item_DaSt_Spawner","Kill","",6.00,null);
		EntFire("DaSt_Temp","Kill","",6.00,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

//////////////////////////////////////////
////////////////DARK ORB/////////////////
/////////////////////////////////////////

function PickUpDO()
{
	DOACT = activator;
	DOCALL = caller;
    EntFire("Item_DO_Gametext","SetText","Item: Dark Orb\nEffect: Making the orb that damages zombies\nDuration: 1 second",0.00,null);
	EntFire("Item_DO_Gametext","Display","",0.05,DOACT);
	EntFireByHandle(self, "RunScriptCode", " UsesDO(); ", 5.00, null, null);  
}
//////////////////////
///BOSS ITEM DAMAGE///
//////////////////////////
//////////////////////////
///ORNSTEIN 3000///
//////////////////////////
//////////////////////////
///Gwyn 3250/////
//////////////////////////
///////////////////////////////
///Gwyndolin 3500/////
///////////////////////////////
///////////////////////////
///Golem 2600/////
///////////////////////////
function UsesDO()
{
	if(TickDO && DOCALL.GetMoveParent() == DOACT)
	{
		if(UsedDO <= MaxUsesDO)
	    {
		    EntFire("Item_DO_Gametext","SetText","DarkOrb("+UsedDO+"/"+MaxUsesDO+")",0.00,null);
	        EntFire("Item_DO_Gametext","Display","",0.05,DOACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesDO(); ", 1.00, null, null);  
	    }
	    if(UsedDO == MaxUsesDO)
	    {
			TickDO = false;
		    EntFire("Item_DO_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_DO_Gametext","Display","",1.05,DOACT);
		    EntFire("Item_DO_Gametext","Kill","",6.00,null);
	    }
	}
}

function UseDO()
{
	if(UsedDO <= MaxUsesDO)
	{
		UsedDO++;
		EntFire("Item_DO_Use","PlaySound","",0.00,null);
	    EntFire("Item_DO_Button","Lock","",0.00,null);
	    EntFire("Item_DO_Spawner","ForceSpawn","",0.01,null);
	    EntFire("Item_DO_Button","UnLock","",2.50,null);
	}
	if(UsedDO == MaxUsesDO)
	{
		EntFire("Item_DO_Button","Kill","",0.05,null);
		EntFire("Item_DO_Pic","Kill","",6.00,null);
		EntFire("Item_DO_Spawner","Kill","",6.00,null);
		EntFire("DO_Temp","Kill","",6.00,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

//////////////////////////////////////////
////////////////Estus////////////////////
/////////////////////////////////////////

function PickUpEF()
{
	EFACT = activator;
	EFCALL = caller;
    EntFire("Item_EF_Gametext","SetText","Item: Estus Flask\nEffect: Heals nearby players\nDuration: 3 seconds",0.00,null);
	EntFire("Item_EF_Gametext","Display","",0.05,EFACT);
	EntFireByHandle(self, "RunScriptCode", " UsesEF(); ", 5.00, null, null);  
}

function UsesEF()
{
	if(TickEF && EFCALL.GetMoveParent() == EFACT)
	{
		if(UsedEF <= MaxUsesEF)
	    {
		    EntFire("Item_EF_Gametext","SetText","Estus("+UsedEF+"/"+MaxUsesEF+")",0.00,null);
	        EntFire("Item_EF_Gametext","Display","",0.05,EFACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesEF(); ", 1.00, null, null);  
	    }
	    if(UsedEF == MaxUsesEF)
	    {
			TickEF = false;
		    EntFire("Item_EF_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_EF_Gametext","Display","",1.05,EFACT);
		    EntFire("Item_EF_Gametext","Kill","",6.00,null);
	    }
	}
}

function UseEF()
{
	if(UsedEF <= MaxUsesEF)
	{
		UsedEF++;
		EntFire("Item_EF_Use","PlaySound","",0.00,null);
		EntFire("EF_Effect","Start","",0.00,null);
		EntFire("EF_Trigger","Enable","",0.00,null);
	    EntFire("Item_EF_Button","Lock","",0.00,null);
		EntFire("EF_Effect","Stop","",3.00,null);
		EntFire("EF_Trigger","Disable","",3.00,null);
	    EntFire("Item_EF_Button","UnLock","",4.50,null);
	}
	if(UsedEF == MaxUsesEF)
	{
		EntFire("Item_EF_Button","Kill","",0.05,null);
		EntFire("Item_EF_Pic","Kill","",6.00,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

//////////////////////////////////////////////////////////
////////////////Great Heavy Soul Arrow////////////////////
//////////////////////////////////////////////////////////

function PickUpGHSA()
{
	GHSAACT = activator;
	GHSACALL = caller;
    EntFire("Item_GHSA_Gametext","SetText","Item: Great Heavy Soul Arrow\nEffect: Making the spear that damages zombies\nDuration: 1 second",0.00,null);
	EntFire("Item_GHSA_Gametext","Display","",0.05,GHSAACT);
	EntFireByHandle(self, "RunScriptCode", " UsesGHSA(); ", 5.00, null, null);  
}

//////////////////////
///BOSS ITEM DAMAGE///
//////////////////////////
///////////////////////////////
///Ornstein 1200/////
///////////////////////////////
///////////////////////////
///Golem 1250/////
///////////////////////////
///////////////////////////
///Broadhead 1300/////
///////////////////////////

function UsesGHSA()
{
	if(TickGHSA && GHSACALL.GetMoveParent() == GHSAACT)
	{
		if(UsedGHSA <= MaxUsesGHSA)
	    {
		    EntFire("Item_GHSA_Gametext","SetText","Great Heavy Soul Arrow("+UsedGHSA+"/"+MaxUsesGHSA+")",0.00,null);
	        EntFire("Item_GHSA_Gametext","Display","",0.05,GHSAACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesGHSA(); ", 1.00, null, null);  
	    }
	    if(UsedGHSA == MaxUsesGHSA)
	    {
			TickGHSA = false;
		    EntFire("Item_GHSA_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_GHSA_Gametext","Display","",1.05,GHSAACT);
		    EntFire("Item_GHSA_Gametext","Kill","",6.00,null);
	    }
	}
}

function UseGHSA()
{
	if(UsedGHSA <= MaxUsesGHSA)
	{
		UsedGHSA++;
		EntFire("Item_GHSA_Use","PlaySound","",0.00,null);
	    EntFire("Item_GHSA_Button","Lock","",0.00,null);
		EntFire("Item_GHSA_Spawner","ForceSpawn","",0.01,null);
	    EntFire("Item_GHSA_Button","UnLock","",2.50,null);
	}
	if(UsedGHSA == MaxUsesGHSA)
	{
		EntFire("Item_GHSA_Button","Kill","",0.05,null);
		EntFire("Item_GHSA_Spawner","Kill","",6.00,null);
	    EntFire("GHSA_Temp","Kill","",6.00,null);
		EntFire("Item_GHSA_Pic","Kill","",6.00,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

//////////////////////////////////////////////
////////////////Hiden Body////////////////////
/////////////////////////////////////////////

function PickUpHiBo()
{
	HiBoACT = activator;
	HiBoCALL = caller;
    EntFire("Item_HiBo_Gametext","SetText","Item: Hidden Body\nEffect: Makes players invisible and gives immunity against zombies\nDuration: 7 seconds",0.00,null);
	EntFire("Item_HiBo_Gametext","Display","",0.05,HiBoACT);
	EntFireByHandle(self, "RunScriptCode", " UsesHiBo(); ", 5.00, null, null);  
}

function UsesHiBo()
{
	if(TickHiBo && HiBoCALL.GetMoveParent() == HiBoACT)
	{
		if(UsedHiBo <= MaxUsesHiBo)
	    {
		    EntFire("Item_HiBo_Gametext","SetText","Hidden Body("+UsedHiBo+"/"+MaxUsesHiBo+")",0.00,null);
	        EntFire("Item_HiBo_Gametext","Display","",0.05,HiBoACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesHiBo(); ", 1.00, null, null);  
	    }
	    if(UsedHiBo == MaxUsesHiBo)
	    {
			TickHiBo = false;
		    EntFire("Item_HiBo_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_HiBo_Gametext","Display","",1.05,HiBoACT);
		    EntFire("Item_HiBo_Gametext","Kill","",6.00,null);
	    }
	}
}

function UseHiBo()
{
	if(UsedHiBo <= MaxUsesHiBo)
	{
		UsedHiBo++;
		EntFire("Item_HiBo_Use","PlaySound","",0.00,null);
	    EntFire("Item_HiBo_Button","Lock","",0.00,null);
		EntFire("HiBo_Effect","Start","",0.00,null);
		EntFire("HiBo_Trigger","Enable","",0.04,null);
		EntFire("HiBo_Effect","Stop","",7.00,null);
		EntFire("HiBo_Trigger","Disable","",7.00,null);
	    EntFire("Item_HiBo_Button","UnLock","",7.50,null);
	}
	if(UsedHiBo == MaxUsesHiBo)
	{
		EntFire("Item_HiBo_Button","Kill","",0.05,null);
		EntFire("Item_HiBo_Pic","Kill","",6.00,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

///////////////////////////////////////////////////
////////////////Lightning Spear////////////////////
///////////////////////////////////////////////////

function PickUpLS()
{
	LSACT = activator;
	LSCALL = caller;
    EntFire("Item_LS_Gametext","SetText","Item: Lightning Spear\nEffect: Making the spear that damages and slows zombies\nDuration: 1 second",0.00,null);
	EntFire("Item_LS_Gametext","Display","",0.05,LSACT);
	EntFireByHandle(self, "RunScriptCode", " UsesLS(); ", 5.00, null, null);  
}

//////////////////////
///BOSS ITEM DAMAGE///
//////////////////////////
///////////////////////////////
///Gwyndolin 1000/////////
///////////////////////////////
///////////////////////////
///Broadhead 900/////
///////////////////////////
///////////////////////////
///Asylum Demon 1500/////
///////////////////////////

function UsesLS()
{
	if(TickLS && LSCALL.GetMoveParent() == LSACT)
	{
		if(UsedLS <= MaxUsesLS)
	    {
		    EntFire("Item_LS_Gametext","SetText","Lightning Spear("+UsedLS+"/"+MaxUsesLS+")",0.00,null);
	        EntFire("Item_LS_Gametext","Display","",0.05,LSACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesLS(); ", 1.00, null, null);  
	    }
	    if(UsedLS == MaxUsesLS)
	    {
			TickLS = false;
		    EntFire("Item_LS_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_LS_Gametext","Display","",1.05,LSACT);
		    EntFire("Item_LS_Gametext","Kill","",6.00,null);
	    }
	}
}

function UseLS()
{
	if(UsedLS <= MaxUsesLS)
	{
		UsedLS++;
		EntFire("Item_LS_Use","PlaySound","",0.00,null);
	    EntFire("Item_LS_Button","Lock","",0.00,null);
		EntFire("Item_LS_Spawner","ForceSpawn","",0.01,null);
	    EntFire("Item_LS_Button","UnLock","",2.50,null);
	}
	if(UsedLS == MaxUsesLS)
	{
		EntFire("Item_LS_Button","Kill","",0.05,null);
		EntFire("Item_LS_Spawner","Kill","",6.00,null);
	    EntFire("LS_Temp","Kill","",6.00,null);
		EntFire("Item_LS_Pic","Kill","",6.00,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

//////////////////////////////////////////////////////
////////////////Green Blossom/////////////////////////
//////////////////////////////////////////////////////

function PickUpSalad()
{
	SaladACT = activator;
	SaladCALL = caller;
    EntFire("Item_Salad_Gametext","SetText","Item: Green Blossom\nEffect: Gives speed to all nearby humans\nDuration: 4 seconds",0.00,null);
	EntFire("Item_Salad_Gametext","Display","",0.05,SaladACT);
	EntFireByHandle(self, "RunScriptCode", " UsesSalad(); ", 5.00, null, null);  
}

function UsesSalad()
{
	if(TickSalad && SaladCALL.GetMoveParent() == SaladACT)
	{
		if(UsedSalad <= MaxUsesSalad)
	    {
		    EntFire("Item_Salad_Gametext","SetText","Green Blossom("+UsedSalad+"/"+MaxUsesSalad+")",0.00,null);
	        EntFire("Item_Salad_Gametext","Display","",0.05,SaladACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesSalad(); ", 1.00, null, null);  
	    }
	    if(UsedSalad == MaxUsesSalad)
	    {
			TickSalad = false;
		    EntFire("Item_Salad_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_Salad_Gametext","Display","",1.05,SaladACT);
		    EntFire("Item_Salad_Gametext","Kill","",6.00,null);
	    }
	}
}

function UseSalad()
{
	if(UsedSalad <= MaxUsesSalad)
	{
		UsedSalad++;
	    EntFire("Item_Salad_Button","Lock","",0.00,null);
		EntFire("Salad_Saladfect","Start","",0.00,null);
		EntFire("Salad_Trigger","Enable","",0.00,null);
		EntFire("Salad_Saladfect","Stop","",3.00,null);
		EntFire("Salad_Trigger","Disable","",4.00,null);
	    EntFire("Item_Salad_Button","UnLock","",4.50,null);
	}
	if(UsedSalad == MaxUsesSalad)
	{
		EntFire("Item_Salad_Button","Kill","",0.05,null);
		EntFire("Item_Salad_Pic","Kill","",6.00,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

/////////////////////////////////////////////////////
////////////////Soothing Sunlight////////////////////
////////////////////////////////////////////////////

function PickUpSS()
{
	SSACT = activator;
	SSCALL = caller;
    EntFire("Item_SS_Gametext","SetText","Item: Soothing Sunlight\nEffect: Heals nearby humans\nDuration: 15 seconds",0.00,null);
	EntFire("Item_SS_Gametext","Display","",0.05,SSACT);
	EntFireByHandle(self, "RunScriptCode", " UsesSS(); ", 5.00, null, null);  
}

function UsesSS()
{
	if(TickSS && SSCALL.GetMoveParent() == SSACT)
	{
		if(UsedSS <= MaxUsesSS)
	    {
		    EntFire("Item_SS_Gametext","SetText","Soothing Sunlight("+UsedSS+"/"+MaxUsesSS+")",0.00,null);
	        EntFire("Item_SS_Gametext","Display","",0.05,SSACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesSS(); ", 1.00, null, null);  
	    }
	    if(UsedSS == MaxUsesSS)
	    {
			TickSS = false;
		    EntFire("Item_SS_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_SS_Gametext","Display","",1.05,SSACT);
		    EntFire("Item_SS_Gametext","Kill","",6.00,null);
	    }
	}
}

function UseSS()
{
	if(UsedSS <= MaxUsesSS)
	{
		UsedSS++;
		EntFire("Item_SS_Use","PlaySound","",0.00,null);
	    EntFire("Item_SS_Button","Lock","",0.00,null);
		EntFire("Item_SS_Spawner","ForceSpawn","",0.01,null);
	    EntFire("Item_SS_Button","UnLock","",15.00,null);
	}
	if(UsedSS == MaxUsesSS)
	{
		EntFire("Item_SS_Button","Kill","",0.05,null);
		EntFire("Item_SS_Spawner","Kill","",6.00,null);
		EntFire("SS_Temp","Kill","",6.00,null);
		EntFire("Item_SS_Pic","Kill","",6.00,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

/////////////////////////////////////////////////////////
/////////////////White Dragon Breath/////////////////////
/////////////////////////////////////////////////////////

function PickUpWDB()
{
	WDBACT = activator;
	WDBCALL = caller;
    EntFire("Item_WDB_Gametext","SetText","Item: White Dragon Breath\nEffect: Throws ice spikes arrow\nDuration: 6 seconds",0.00,null);
	EntFire("Item_WDB_Gametext","Display","",0.05,WDBACT);
	EntFireByHandle(self, "RunScriptCode", " UsesWDB(); ", 5.00, null, null);  
}

////////////////////////////////////////////////
///BOSS ITEM DAMAGE/////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////
///Broadhead 1300 4s////////////////////////////
///Broadhead_Phys DisableMotion/////////////////
///Broadhead_Spikes Enable//////////////////////
///Broadhead_Attack_Timer  ResetTimer///////////
///Broadhead_Phys EnableMotion 4s///////////////
///Broadhead_Spikes Disable 4s//////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////
///Golem 1500 4s////////////////////////////////
///Golem_Phys DisableMotion/////////////////////
///Golem_Model SetAnimation almostdied//////////
///Golem_Model SetDefaultAnimation almostdied///
///Golem_WDB_Spikes Enable//////////////////////
///Golem_Timer  ResetTimer//////////////////////
///Golem_Model SetAnimation walk1  4s///////////
///Golem_Model SetDefaultAnimation walk1  4s////
///Golem_Phys EnableMotion 4s///////////////////
///Golem_WDB_Spikes Disable 4s//////////////////
////////////////////////////////////////////////

function UsesWDB()
{
	if(TickWDB && WDBCALL.GetMoveParent() == WDBACT)
	{
		if(UsedWDB <= MaxUsesWDB)
	    {
		    EntFire("Item_WDB_Gametext","SetText","White Dragon Breath("+UsedWDB+"/"+MaxUsesWDB+")",0.00,null);
	        EntFire("Item_WDB_Gametext","Display","",0.05,WDBACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesWDB(); ", 1.00, null, null);  
	    }
	    if(UsedWDB == MaxUsesWDB)
	    {
			TickWDB = false;
		    EntFire("Item_WDB_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_WDB_Gametext","Display","",1.05,WDBACT);
		    EntFire("Item_WDB_Gametext","Kill","",6.00,null);
	    }
	}
}

function UseWDB()
{
	if(UsedWDB <= MaxUsesWDB)
	{
		UsedWDB++;
		EntFire("Item_WDB_Use","PlaySound","",0.00,null);
	    EntFire("Item_WDB_Button","Lock","",0.00,null);
	    EntFire("Item_WDB_Spawner","ForceSpawn","",0.01,null);
	    EntFire("Item_WDB_Button","UnLock","",7.0,null);
	}
	if(UsedWDB == MaxUsesWDB)
	{
		EntFire("Item_WDB_Button","Kill","",0.05,null);
		EntFire("Item_WDB_Pic","Kill","",6.00,null);
		EntFire("Item_WDB_Spawner","Kill","",6.00,null);
		EntFire("WDB_Temp","Kill","",6.00,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

///////////////////////////////////////////////////////
/////////////////Wrath of The Gods/////////////////////
///////////////////////////////////////////////////////

function PickUpWOTG()
{
	WOTGACT = activator;
	WOTGCALL = caller;
    EntFire("Item_WOTG_Gametext","SetText","Item: Wrath of The Gods\nEffect: Pushes zombies away\nDuration: 1 second",0.00,null);
	EntFire("Item_WOTG_Gametext","Display","",0.05,WOTGACT);
	EntFireByHandle(self, "RunScriptCode", " UsesWOTG(); ", 5.00, null, null);  
}

function UsesWOTG()
{
	if(TickWOTG && WOTGCALL.GetMoveParent() == WOTGACT)
	{
		if(UsedWOTG <= MaxUsesWOTG)
	    {
		    EntFire("Item_WOTG_Gametext","SetText","Wrath of The Gods("+UsedWOTG+"/"+MaxUsesWOTG+")",0.00,null);
	        EntFire("Item_WOTG_Gametext","Display","",0.05,WOTGACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesWOTG(); ", 1.00, null, null);  
	    }
	    if(UsedWOTG == MaxUsesWOTG)
	    {
			TickWOTG = false;
		    EntFire("Item_WOTG_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_WOTG_Gametext","Display","",1.05,WOTGACT);
		    EntFire("Item_WOTG_Gametext","Kill","",6.00,null);
	    }
	}
}

function UseWOTG()
{
	if(UsedWOTG <= MaxUsesWOTG)
	{
		UsedWOTG++;
	    EntFire("Item_WOTG_Button","Unlock","",1.05,null);
		EntFire("WOTG_Effect","Stop","",1.00,null);
		EntFire("WOTG_Push","Disable","",1.00,null);
		EntFire("Item_WOTG_Phys","AddOutput","angles 0 0 0",0.75,null);
		EntFire("Item_WOTG_Phys","AddOutput","angles 0 0 0",0.50,null);
		EntFire("Item_WOTG_Phys","AddOutput","angles 0 0 0",0.25,null);
		EntFire("Item_WOTG_Phys","AddOutput","angles 0 0 0",0.00,null);
		EntFire("Item_WOTG_Use","PlaySound","",0.00,null);
		EntFire("WOTG_Push","Enable","",0.00,null);
		EntFire("WOTG_Effect","Start","",0.00,null);
		EntFire("Item_WOTG_Button","Lock","",0.00,null);
	}
	if(UsedWOTG == MaxUsesWOTG)
	{
		EntFire("Item_WOTG_Button","Kill","",0.05,null);
		EntFire("Item_WOTG_Pic","Kill","",6.00,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

///////////////////////////////////////////////////////
/////////////////Black Flame///////////////////////////
///////////////////////////////////////////////////////

function PickUpBF()
{
	BFACT = activator;
	BFCALL = caller;
    EntFire("Item_BF_Gametext","SetText","Item: Black Flame\nEffect: Making the fire orb that damages humans\nDuration: 1 second",0.00,null);
	EntFire("Item_BF_Gametext","Display","",0.05,BFACT);
	EntFireByHandle(self, "RunScriptCode", " UsesBF(); ", 5.00, null, null);  
}

function UsesBF()
{
	if(TickBF && BFCALL.GetMoveParent() == BFACT)
	{
		if(UsedBF <= MaxUsesBF)
	    {
		    EntFire("Item_BF_Gametext","SetText","Black Flame("+UsedBF+"/"+MaxUsesBF+")",0.00,null);
	        EntFire("Item_BF_Gametext","Display","",0.05,BFACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesBF(); ", 1.00, null, null);  
	    }
	    if(UsedBF == MaxUsesBF)
	    {
			TickBF = false;
		    EntFire("Item_BF_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_BF_Gametext","Display","",1.05,BFACT);
		    EntFire("Item_BF_Gametext","Kill","",6.00,null);
	    }
	}
}

function UseBF()
{
	if(UsedBF <= MaxUsesBF)
	{
		UsedBF++;
		EntFire("Item_BF_Use","PlaySound","",0.00,null);
		EntFire("Item_BF_Button","Lock","",0.00,null);
		EntFire("Item_BF_Spawner","ForceSpawn","",0.01,null);
	    EntFire("Item_BF_Button","Unlock","",2.50,null);
	}
	if(UsedBF == MaxUsesBF)
	{
		EntFire("Item_BF_Button","Kill","",0.05,null);
		EntFire("BF_Temp","Kill","",6.00,null);
		EntFire("Item_BF_Spawner","Kill","",6.00,null);
		EntFire("Item_BF_Pic","Kill","",6.00,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

///////////////////////////////////////////////////////
/////////////////Toxic Mist////////////////////////////
///////////////////////////////////////////////////////

function PickUpPM()
{
	PMACT = activator;
	PMCALL = caller;
    EntFire("Item_PM_Gametext","SetText","Item: Toxic Mist\nEffect: Damages nearby humans\nDuration: 7 seconds",0.00,null);
	EntFire("Item_PM_Gametext","Display","",0.05,PMACT);
	EntFireByHandle(self, "RunScriptCode", " UsesPM(); ", 5.00, null, null);  
}

function UsesPM()
{
	if(TickPM && PMCALL.GetMoveParent() == PMACT)
	{
		if(UsedPM <= MaxUsesPM)
	    {
		    EntFire("Item_PM_Gametext","SetText","Toxic Mist("+UsedPM+"/"+MaxUsesPM+")",0.00,null);
	        EntFire("Item_PM_Gametext","Display","",0.05,PMACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesPM(); ", 1.00, null, null);  
	    }
	    if(UsedPM == MaxUsesPM)
	    {
			TickPM = false;
		    EntFire("Item_PM_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_PM_Gametext","Display","",1.05,PMACT);
		    EntFire("Item_PM_Gametext","Kill","",6.00,null);
	    }
	}
}

function UsePM()
{
	if(UsedPM <= MaxUsesPM)
	{
		UsedPM++;
		EntFire("Item_PM_Use","PlaySound","",0.00,null);
		EntFire("PM_Effect","Start","",0.00,null);
		EntFire("PM_Trigger","Enable","",0.00,null);
		EntFire("Item_PM_Button","Lock","",0.00,null);
		EntFire("PM_Effect","Stop","",7.00,null);
		EntFire("PM_Trigger","Disable","",7.00,null);
	    EntFire("Item_PM_Button","Unlock","",15.00,null);
	}
	if(UsedPM == MaxUsesPM)
	{
		EntFire("Item_PM_Button","Kill","",0.05,null);
		EntFire("Item_PM_Pic","Kill","",6.00,null);
		EntFire("PM_Trigger","Kill","",7.10,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

/////////////////////////////////////////////////////////
/////////////////Power Within////////////////////////////
/////////////////////////////////////////////////////////

function PickUpPW()
{
	PWACT = activator;
	PWCALL = caller;
    EntFire("Item_PW_Gametext","SetText","Item: Power Within\nEffect: Zombies become really stronger for a few seconds\nDuration: 3 seconds",0.00,null);
	EntFire("Item_PW_Gametext","Display","",0.05,PWACT);
	EntFireByHandle(self, "RunScriptCode", " UsesPW(); ", 5.00, null, null);  
}

function UsesPW()
{
	if(TickPW && PWCALL.GetMoveParent() == PWACT)
	{
		if(UsedPW <= MaxUsesPW)
	    {
		    EntFire("Item_PW_Gametext","SetText","Power Within("+UsedPW+"/"+MaxUsesPW+")",0.00,null);
	        EntFire("Item_PW_Gametext","Display","",0.05,PWACT);
		    EntFireByHandle(self, "RunScriptCode", " UsesPW(); ", 1.00, null, null);  
	    }
	    if(UsedPW == MaxUsesPW)
	    {
			TickPW = false;
		    EntFire("Item_PW_Gametext","SetText","ALL SPELLS USED",1.00,null);
		    EntFire("Item_PW_Gametext","Display","",1.05,PWACT);
		    EntFire("Item_PW_Gametext","Kill","",6.00,null);
	    }
	}
}

function UsePW()
{
	if(UsedPW <= MaxUsesPW)
	{
		UsedPW++;
		EntFire("Item_PW_Use","PlaySound","",0.00,null);
		EntFire("PW_Effect","Start","",0.00,null);
		EntFire("PW_Trigger","Enable","",0.00,null);
		EntFire("Item_PW_Button","Lock","",0.00,null);
		EntFire("PW_Effect","Stop","",3.00,null);
		EntFire("PW_Trigger","Disable","",3.00,null);
	    EntFire("Item_PW_Button","Unlock","",15.00,null);
	}
	if(UsedPW == MaxUsesPW)
	{
		EntFire("Item_PW_Button","Kill","",0.05,null);
		EntFire("Item_PW_Pic","Kill","",6.00,null);
	}
}

//////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

function PickUpZmItem()
{
	if(activator.GetHealth() >= 1000 && activator.GetTeam() == 2 && activator != PMACT && activator != BFACT && activator != PWACT)
	{
		EntFire("Map_Stripper","StripWeaponsAndSuit","",0.00,activator);
		EntFireByHandle(caller, "FireUser4", "", 0.01, null, null);
	}
}

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

//////////////////////////////////////////
///////////////Uses ITEM UP///////////////
//////////////////////////////////////////
DaOr <- 0;
LiS <- 0;
WhD <- 0;
PoW <- 0;
//////////////////////////////////////////

function DarkOrbUsUp()
{
	MaxUsesDO++;
	DaOr++;
}

function DivineUsUp()
{
	MaxUsesLS++;
	MaxUsesSS++;
	MaxUsesWOTG++;
	LiS++;
}

function SorceryUsUp()
{
	MaxUsesWDB++;
	MaxUsesHiBo++;
	MaxUsesGHSA++;
	WhD++;
}

function PyromancyUsUp()
{
	MaxUsesChSt++;
	MaxUsesPW++;
	MaxUsesPM++;
	PoW++;
}

function ReturnItemUs()
{
    if(DaOr == 1){return 1;}
	if(LiS == 1){return 2;}
	if(WhD == 1){return 3;}
	if(PoW == 1){return 4;}
}

function SetItemUsNR()
{
	local nr = ReturnItemUs();
	if(nr == 1){EntFire("dark_brush","RunScriptCode","UpUsesItemDarkOrb();",0.00,null);}
	else if(nr == 2){EntFire("dark_brush","RunScriptCode","UpUsesItemDivine();",0.00,null);}
	else if(nr == 3){EntFire("dark_brush","RunScriptCode","UpUsesItemSorcery();",0.00,null);}
	else if(nr == 4){EntFire("dark_brush","RunScriptCode","UpUsesItemPyromancy();",0.00,null);}
}

function UpDo(doi)
{
	MaxUsesDO += doi;
}

function UpDiv(Diva)
{
	MaxUsesLS += Diva;
	MaxUsesSS += Diva;
	MaxUsesWOTG += Diva;
}

function UpSorc(Sorce)
{
	MaxUsesWDB += Sorce;
	MaxUsesHiBo += Sorce;
	MaxUsesGHSA += Sorce;
}

function UpPir(Piro)
{
	MaxUsesChSt += Piro;
	MaxUsesPW += Piro;
	MaxUsesPM += Piro;
}


//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

function ChangeItUses()
{
	MaxUsesAEF = 1000000;
    MaxUsesChSt = 1000000;
    MaxUsesDaSt = 1000000;
    MaxUsesDO = 1000000;
    MaxUsesEF = 1000000;
    MaxUsesGHSA = 1000000;
	MaxUsesHiBo = 1000000;
	MaxUsesLS = 1000000;
    MaxUsesSalad = 1000000;
    MaxUsesSS = 1000000;
	MaxUsesWDB = 1000000;
	MaxUsesWOTG = 1000000;
    MaxUsesBF = 1000000;
	MaxUsesPM = 1000000;
	MaxUsesPW = 1000000;
}