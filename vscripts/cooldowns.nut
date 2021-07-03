// Intended for use with skyrim GFL strippers
// Adding proper cooldown support for human items (game_ui)
// Install as csgo/scripts/vscripts/gfl/cooldowns.nut

// Original idea/implementation by Hestia
// Script implementation by Vauff (from ze_lotr_isengard_csgo1), edited by sTc

PRIMARY_ATTACK <- "Attack Ready!";
SECONADRY_ATTACK <- "N/A Ready!";

DAEDRIC_NUKES <- 2;

function InitItem(item, level=0)
{
	if(item == 0)
	{
		SECONADRY_ATTACK = "";
	}
	else if(item == 1)
	{
		SECONADRY_ATTACK = "Heal Ready!";
	}
	else if(item == 2 && level == 2)
	{
		SECONADRY_ATTACK = "Fire Ready!";
	}
	else if(item == 2 && level == 3)
	{
		SECONADRY_ATTACK = "Freeze Ready!";		
	}
	else if(item == 2 && level == 4)
	{
		SECONADRY_ATTACK = "Push Ready!";
	}
	else if(item == 3)
	{
		SECONADRY_ATTACK = "Fire Ready!";		
	}
	else if(item == 4)
	{
		SECONADRY_ATTACK = "Nuke Ready! (" + DAEDRIC_NUKES.tostring() + "/2)";
	}
}

function UpdateCooldowns()
{
	EntFireByHandle(self, "SetText",  PRIMARY_ATTACK + "\n" + SECONADRY_ATTACK, 0.00, null, null);
}

function PrimaryCooldown(seconds)
{
	if (seconds != 0)
	{
		PRIMARY_ATTACK = "Attack Cooldown - " + seconds.tostring() + "s";
		EntFireByHandle(self, "RunScriptCode", "PrimaryCooldown(" + (seconds - 1).tostring() + ");", 1.00, null, null);
	}
	else
	{
		PRIMARY_ATTACK = "Attack Ready!";
	}
}

function SecondaryCooldown(item, seconds, level=0)
{
	if (seconds > 0)
	{
		if(item == 1)
		{
			SECONADRY_ATTACK = "Heal Cooldown - " + seconds.tostring() + "s";
		}
		else if(item == 2 && level == 2)
		{
			SECONADRY_ATTACK = "Fire Cooldown - " + seconds.tostring() + "s";		
		}
		else if(item == 2 && level == 3)
		{
			SECONADRY_ATTACK = "Freeze Cooldown - " + seconds.tostring() + "s";
		}
		else if(item == 2 && level == 4)
		{
			SECONADRY_ATTACK = "Push Cooldown - " + seconds.tostring() + "s";	
		}
		else if(item == 3)
		{
			SECONADRY_ATTACK = "Fire Cooldown - " + seconds.tostring() + "s";		
		}
		else if(item == 4)
		{
			if(DAEDRIC_NUKES <= 0)
			{
				seconds = 0;
			}
			else
			{
				SECONADRY_ATTACK = "Nuke Cooldown - " + seconds.tostring() + "s";
			}
		}
		EntFireByHandle(self, "RunScriptCode", "SecondaryCooldown(" + item.tostring() + ", " + (seconds - 1).tostring() + ", " + level.tostring() + ");", 1.00, null, null);
	}
	else
	{
		if(item == 1)
		{
			SECONADRY_ATTACK = "Heal Ready!";
		}
		else if(item == 2 && level == 2)
		{
			SECONADRY_ATTACK = "Fire Ready!";
		}
		else if(item == 2 && level == 3)
		{
			SECONADRY_ATTACK = "Freeze Ready!";		
		}
		else if(item == 2 && level == 4)
		{
			SECONADRY_ATTACK = "Push Ready!";
		}
		else if(item == 3)
		{
			SECONADRY_ATTACK = "Fire Ready!";
		}
		else if(item == 4)
		{
			if(DAEDRIC_NUKES <= 0)
			{
				SECONADRY_ATTACK = "Nuke Depleted!";
			}
			else
			{
				SECONADRY_ATTACK = "Nuke Ready! (" + DAEDRIC_NUKES.tostring() + "/2)";
			}
		}
	}
}