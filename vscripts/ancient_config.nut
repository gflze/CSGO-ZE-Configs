self.__KeyValueFromString("targetname", "ancient_config");

function OnPostSpawn()
{
	FixAmmoGText();
}

function FixAmmoGText()
{
	local f_ent = Entities.FindByName(null, "weapon_flamethrower_button");
	if (f_ent != null && f_ent.IsValid())
	{
		printl("FOUND FLAMETHROWER");
		local NewPickUpFire = function()
		{
			if (FLAMETHROWER_WEAPON == null)
				FLAMETHROWER_WEAPON = caller;

			if (FLAMETHROWER_FTEXT == null)
				FLAMETHROWER_FTEXT = Entities.FindByName(null, "fuel_text");

			if (FLAMETHROWER_GTEXT == null)
				FLAMETHROWER_GTEXT = Entities.FindByName(null, "weapon_flamethrower_game_text1");

			if (FLAMETHROWER_TPOS == null)
				FLAMETHROWER_TPOS = Entities.FindByName(null, "item_flamethr_trigpos");

			if (FLAMETHROWER_MEASURE == null)
				FLAMETHROWER_MEASURE = Entities.FindByName(null, "item_flamethro_measure");

			if (FLAMETHROWER_OWNER == null)
				ScriptPrintMessageChatAll(" \x07>>> PLAYER HAS PICKED UP ACID LAUNCHER <<<");

			FLAMETHROWER_FTEXT.__KeyValueFromFloat("holdtime", 0.10);
			FLAMETHROWER_OWNER = activator;
			FLAMETHROWER_OWNER.__KeyValueFromString("targetname", "item_bow_" + split("" + FLAMETHROWER_OWNER, "player(")[0]);
			EntFireByHandle(FLAMETHROWER_MEASURE, "SetMeasureTarget", "item_bow_" + split(""+FLAMETHROWER_OWNER, "player(")[0], 0.00, FLAMETHROWER_OWNER, null);
			if (FLAMETHROWER_GTEXT != null && FLAMETHROWER_GTEXT.IsValid())
			{
				FLAMETHROWER_GTEXT.__KeyValueFromString("message", "Acid Launcher \nThrows boiling acid that burns zombies \nDuration: 15 Seconds \nFuel: "+abs(FLAMETHROWER_FUEL));
				EntFireByHandle(FLAMETHROWER_GTEXT, "Display", "", 0.00, FLAMETHROWER_OWNER, null);
			}

			if (!FLAMETHROWER_TICK_BOOL)
			{
				FLAMETHROWER_TICK_BOOL = true;
				FlameThrowerTick();
			}
		}
		f_ent.GetScriptScope().PickUpFire <- NewPickUpFire;
		return;
	}
	EntFireByHandle(self, "RunScriptCode", "FixAmmoGText();", 1.00, null, null);
}