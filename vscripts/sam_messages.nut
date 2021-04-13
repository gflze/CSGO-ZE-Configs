//intended for use with the ze_S_A_M_v1_7 GFL stripper
//removes broken HTML formatting
//install as csgo/scripts/vscripts/gfl/sam_messages.nut

function SetZIceMessage()
{
	local entity = Entities.FindByName(null, "zice_text");
	entity.__KeyValueFromString("message", "[ZM]Ice - [E] Create a forward ice wall.CD:80s \n[Attack2] Freeze self and add hp \n[Attack1] Unfreeze self");
}

function SetZGravityMessage()
{
	local entity = Entities.FindByName(null, "zgravity_text");
	entity.__KeyValueFromString("message", "[ZM]Gravity - [E] Attract human in area.CD:80s \n[Attack2] Reduce human's speed in area");
}

function SetZStealthMessage()
{
	local entity = Entities.FindByName(null, "zstealth_text");
	entity.__KeyValueFromString("message", "[ZM]Stealth - [E] Self accelerating and stealth in 8s.CD:60s \n[Attack2] Confuse human's views.CD:60s \n[Attack1] Warp humans front sector area when in stealth");
}

function SetZShieldMessage()
{
	local entity = Entities.FindByName(null, "zshield_text");
	entity.__KeyValueFromString("message", "[ZM]Shield - [E] Ignore knockback and reflex damage in 4s.CD:80s \n[Attack2] Create a followed shield ahead self in 6s");
}

function SetAsunaMessage()
{
	local entity = Entities.FindByName(null, "asuna_text");
	entity.__KeyValueFromString("message", "Tip: Press DADAWSWS to use Superattack\nIn Stage 5 Limit: 1");
}

function SetZeroMessage()
{
	local entity = Entities.FindByName(null, "item_zero_text");
	entity.__KeyValueFromString("message", "Item: Zero - Transform effect per 10 sec \nDelay: 5 s - Cooldown: 80 s");
}

function SetTraceMessage()
{
	local entity = Entities.FindByName(null, "trace_text");
	entity.__KeyValueFromString("message", "Item: Trace - Trace last item \nDuration: none - Cooldown: 100 s");
}

function SetGravityMessage()
{
	local entity = Entities.FindByName(null, "gravity_text");
	entity.__KeyValueFromString("message", "Item: Gravity - Attract zombies then blast\nDuration: 5 s - Cooldown: 60 s");
}

function SetWindMessage()
{
	local entity = Entities.FindByName(null, "wind_text");
	entity.__KeyValueFromString("message", "Item: Tornado - Push zombies follow user \nDuration: 8s - Delay: 2 s - Cooldown: 68 s");
}

function SetEarthMessage()
{
	local entity = Entities.FindByName(null, "earth_text");
	entity.__KeyValueFromString("message", "Item: Earth - Create an earth barricade forward\nDuration: 6 s - Cooldown: 60 s");
}

function SetLightningMessage()
{
	local entity = Entities.FindByName(null, "lightning_text");
	entity.__KeyValueFromString("message", "Item: Lightning - Create a ring electric field\nDuration: 7 s - Cooldown: 60 s");
}

function SetHealMessage()
{
	local entity = Entities.FindByName(null, "heal_text");
	entity.__KeyValueFromString("message", "Item: Heal - Recover hp to 250 and infinite ammo\nDuration: 7 s - Delay: 5 s - Cooldown: 60 s");
}

function SetWaterMessage()
{
	local entity = Entities.FindByName(null, "water_text");
	entity.__KeyValueFromString("message", "Item: Water - Float zombies \nDuration: 6 s - Cooldown: 60 s");
}

function SetUltimaMessage()
{
	local entity = Entities.FindByName(null, "ultima_text");
	entity.__KeyValueFromString("message", "Item: Ultima - Kill zombies in area \nDelay: 20 s- Limit: 1");
}