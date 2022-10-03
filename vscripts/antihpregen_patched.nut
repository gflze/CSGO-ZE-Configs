//#####################################################################
//Patched version intended for use with GFL ze_undertale_g_v1_3_fix1 stripper
//Implements a redesigned antihpregen.nut due to old script infinitely growing the plist array, causing increasingly larger lag spikes as round progressed
//Install as csgo/scripts/vscripts/gfl/antihpregen_patched.nut
//#####################################################################

//========================================================================================================\\
// Anti Hp Regen script by Luffaren (STEAM_1:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/antihpregen/)
//========================================================================================================\\
// This script is made to nullify server hp-regen in zombie escape (if required to balance things better)
// It only requires a single entity (logic_relay)
// 
// [HOW TO USE]
// Open antihpregen.vmf and copy+paste the logic_relay called "luffaren_antihpregen" into your map .vmf
// Put antihpregen.nut In: csgo/scripts/vscripts/luffaren/antihpregen/
// All you need to pack into the .bsp is scripts/vscripts/luffaren/antihpregen/antihpregen.nut
// The rest will handle itself
//========================================================================================================\\
initialized <- false;
function Tick()
{
	if(!initialized)
	{
		initialized = true;
		Initialize();
	}
}
function TickHealthCheck()
{
	EntFireByHandle(self,"RunScriptCode","TickHealthCheck();",0.45,null,null);
	for(local h;h=Entities.FindByClassname(h,"player");)
	{
		if(h==null||!h.IsValid()||h.GetHealth()<=0||h.GetTeam()!=3)continue;
		h.ValidateScriptScope();
		if(!("ahr_hp" in h.GetScriptScope()))
			h.GetScriptScope().ahr_hp <- activator.GetHealth();
		if(h.GetHealth() > h.GetScriptScope().ahr_hp)
			EntFireByHandle(h,"AddOutput","health "+(h.GetScriptScope().ahr_hp).tostring(),0.00,null,null);
		else if(h.GetHealth() < h.GetScriptScope().ahr_hp)
			h.GetScriptScope().ahr_hp = h.GetHealth();
	}
}
function SetHealth(amount)
{
	if(activator==null||!activator.IsValid()||activator.GetClassname()!="player")return;
	activator.ValidateScriptScope();
	if(!("ahr_hp" in activator.GetScriptScope()))
		activator.GetScriptScope().ahr_hp <- activator.GetHealth();
	activator.GetScriptScope().ahr_hp = amount;
	EntFireByHandle(activator,"AddOutput","health "+(activator.GetScriptScope().ahr_hp).tostring(),0.00,null,null);
}
function AddHealth(amount)
{
	if(activator==null||!activator.IsValid()||activator.GetClassname()!="player")return;
	activator.ValidateScriptScope();
	if(!("ahr_hp" in activator.GetScriptScope()))
		activator.GetScriptScope().ahr_hp <- activator.GetHealth();
	activator.GetScriptScope().ahr_hp += amount;
	EntFireByHandle(activator,"AddOutput","health "+(activator.GetScriptScope().ahr_hp).tostring(),0.00,null,null);
}
function Initialize()
{
	for(local h;h=Entities.FindByClassname(h,"player");)
	{
		if(h==null||!h.IsValid())continue;
		h.ValidateScriptScope();
		h.GetScriptScope().ahr_hp <- 100;
		EntFireByHandle(h,"AddOutput","health 100",0.00,null,null);
	}
	EntFireByHandle(self, "RunScriptCode", " TickHealthCheck(); ", 1.00, null, null);
}
