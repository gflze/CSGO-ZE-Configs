//#####################################################################
//Patched version intended for use with GFL ze_abandoned_project_v1_2_csgo stripper
//Removes HTML formatting broken after Shattered Web Update.
//Install as csgo/scripts/vscripts/abandoned/hud_v_patched.nut
//#####################################################################

//S NS//
HUD <- true;
Valve01 <- 0;
Valve02 <- 0;
PHUD01 <- "";
PHUD02 <- "";

function PreStart()
{   
	PrintHud();
	SetHud();
}

function SetHud()
{
	if(HUD){
    if(Valve01 == 0){PHUD01 = "V1: " + "▢ ▢ ▢ ▢ ▢ ▢ ▢ ▢ ▢ ✩\n";}
	if(Valve01 == 1){PHUD01 = "V1: " + "▣ ▢ ▢ ▢ ▢ ▢ ▢ ▢ ▢ ✩\n";}
	if(Valve01 == 2){PHUD01 = "V1: " + "▣ ▣ ▢ ▢ ▢ ▢ ▢ ▢ ▢ ✩\n";}
	if(Valve01 == 3){PHUD01 = "V1: " + "▣ ▣ ▣ ▢ ▢ ▢ ▢ ▢ ▢ ✩\n";}
	if(Valve01 == 4){PHUD01 = "V1: " + "▣ ▣ ▣ ▣ ▢ ▢ ▢ ▢ ▢ ✩\n";}
	if(Valve01 == 5){PHUD01 = "V1: " + "▣ ▣ ▣ ▣ ▣ ▢ ▢ ▢ ▢ ✩\n";}
	if(Valve01 == 6){PHUD01 = "V1: " + "▣ ▣ ▣ ▣ ▣ ▣ ▢ ▢ ▢ ✩\n";}
	if(Valve01 == 7){PHUD01 = "V1: " + "▣ ▣ ▣ ▣ ▣ ▣ ▣ ▢ ▢ ✩\n";}
	if(Valve01 == 8){PHUD01 = "V1: " + "▣ ▣ ▣ ▣ ▣ ▣ ▣ ▣ ▢ ✩\n";}
	if(Valve01 == 9){PHUD01 = "V1: " + "▣ ▣ ▣ ▣ ▣ ▣ ▣ ▣ ▣ ✩\n";}
	if(Valve02 == 0){PHUD02 = "V2: " + "▢ ▢ ▢ ▢ ▢ ▢ ▢ ▢ ▢ ✩";}
	if(Valve02 == 1){PHUD02 = "V2: " + "▣ ▢ ▢ ▢ ▢ ▢ ▢ ▢ ▢ ✩";}
	if(Valve02 == 2){PHUD02 = "V2: " + "▣ ▣ ▢ ▢ ▢ ▢ ▢ ▢ ▢ ✩";}
	if(Valve02 == 3){PHUD02 = "V2: " + "▣ ▣ ▣ ▢ ▢ ▢ ▢ ▢ ▢ ✩";}
	if(Valve02 == 4){PHUD02 = "V2: " + "▣ ▣ ▣ ▣ ▢ ▢ ▢ ▢ ▢ ✩";}
	if(Valve02 == 5){PHUD02 = "V2: " + "▣ ▣ ▣ ▣ ▣ ▢ ▢ ▢ ▢ ✩";}
	if(Valve02 == 6){PHUD02 = "V2: " + "▣ ▣ ▣ ▣ ▣ ▣ ▢ ▢ ▢ ✩";}
	if(Valve02 == 7){PHUD02 = "V2: " + "▣ ▣ ▣ ▣ ▣ ▣ ▣ ▢ ▢ ✩";}
	if(Valve02 == 8){PHUD02 = "V2: " + "▣ ▣ ▣ ▣ ▣ ▣ ▣ ▣ ▢ ✩";}
	if(Valve02 == 9){PHUD02 = "V2: " + "▣ ▣ ▣ ▣ ▣ ▣ ▣ ▣ ▣ ✩";}
	EntFireByHandle(self, "RunScriptCode", " SetHud(); ", 0.20, null, null);}
    CheckH();
}

function PrintHud()
{
	if(HUD){
		ScriptPrintMessageCenterAll(""+PHUD01+""+PHUD02);
	EntFireByHandle(self, "RunScriptCode", " PrintHud(); ", 0.20, null, null);}
	CheckH();
}
 
function CheckH()
{
	if(Valve01 >= 9 && Valve02 >= 9 && HUD){HUD = false;EntFireByHandle(self, "RunScriptCode", "EventUse();", 0.10, null, null);}
    if(Valve01 == 9){EntFireByHandle(self, "RunScriptCode", " HidePartHud(1); ", 1.05, null, null);}
    if(Valve02 == 9){EntFireByHandle(self, "RunScriptCode", " HidePartHud(2); ", 1.05, null, null);}
}

function HidePartHud(n)
{
    if(n == 1){PHUD01 = "";}
    if(n == 2){PHUD02 = "";}
}

function HideHud()
{

    ScriptPrintMessageCenterAll("");
	EntFireByHandle(self, "RunScriptCode", " HideHud(); ", 0.10, null, null);
	EntFireByHandle(self, "Kill", "", 1.00, null, null);
}

function EventUse()
{
	EntFire("relay_valves","Trigger","",0.00,null);
	EntFire("puerta_valvula","Open","",15.00,null);
	EntFire("valvulas_agua","Open","",20.00,null);
	HideHud();
}