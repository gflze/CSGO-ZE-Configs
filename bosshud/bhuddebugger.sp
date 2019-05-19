#define PLUGIN_NAME           "Bhud Debugger"
#define PLUGIN_AUTHOR         "Snowy"
#define PLUGIN_DESCRIPTION    "Shows the func_physbox/func_physbox_multiplayer/func_breakable/math_counter you are shooting at"
#define PLUGIN_VERSION        "1.0"
#define PLUGIN_URL            "https://github.com/gflclan-cs-go-ze/"

#include <sourcemod>
#include <sdktools>

#pragma semicolon 1

#pragma newdecls required

ConVar g_cBHUDenabled = null;
bool g_bBHUDenabled;

public Plugin myinfo =
{
	name = PLUGIN_NAME,
	author = PLUGIN_AUTHOR,
	description = PLUGIN_DESCRIPTION,
	version = PLUGIN_VERSION,
	url = PLUGIN_URL
};

public void OnPluginStart()
{
	g_cBHUDenabled = CreateConVar("bhud_debug", "1", "Enables/Disables debugging ent names");
	
	HookEntityOutput("func_physbox", "OnHealthChanged", OnHealthChanged);
	HookEntityOutput("func_physbox_multiplayer", "OnHealthChanged", OnHealthChanged);
	HookEntityOutput("func_breakable", "OnHealthChanged", OnHealthChanged);
	HookEntityOutput("math_counter", "OutValue", CounterOutValue);
	
	g_cBHUDenabled.AddChangeHook(ConVarChange);
	g_bBHUDenabled = g_cBHUDenabled.BoolValue;
}

public void ConVarChange(ConVar CVar, const char[] oldVal, const char[] newVal)
{
	g_bBHUDenabled = g_cBHUDenabled.BoolValue;
}

public void OnHealthChanged(const char[] output, int entity, int activator, float delay)
{
	if (activator > 0)
	{
		char targetname[32];
		int HPvalue;
		
		GetEntPropString(entity, Prop_Data, "m_iName", targetname, sizeof(targetname));
		HPvalue = GetEntProp(entity, Prop_Data, "m_iHealth");
		
		if(strlen(targetname) == 0)
		Format(targetname, sizeof(targetname), "This Ent has no name!");
		
		if (g_bBHUDenabled)
		{
			PrintToChatAll(" \x04Breakable: \x10%s  \x04HP: \x10%d", targetname, HPvalue);
		}
	}
}

public void CounterOutValue(const char[] output, int entity, int activator, float delay)
{
	if ((IsValidEntity(entity) || IsValidEdict(entity)) && activator > 0)
	{
		char targetname[32];
		int HPvalue;
		
		GetEntPropString(entity, Prop_Data, "m_iName", targetname, sizeof(targetname));
		HPvalue = RoundToNearest(GetEntDataFloat(entity, FindDataMapInfo(entity, "m_OutValue")));
		
		if(strlen(targetname) == 0)
		Format(targetname, sizeof(targetname), "This Ent has no name!");
		
		if (g_bBHUDenabled)
		{
			PrintToChatAll(" \x04MathCounter: \x10%s  \x04HP: \x10%d", targetname, HPvalue);
		}
	}
}