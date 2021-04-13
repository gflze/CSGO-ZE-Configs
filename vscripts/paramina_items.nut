// Intended for use with the ze_FFXII_Paramina_Rift_r4 GFL stripper
// Allows all the item level game_text to run on a single channel
// Install as csgo/scripts/vscripts/gfl/paramina_items.nut

MESSAGE <- "";
ICE <- "";
HEAL <- "";
FIRE <- "";
POISON <- "";
WIND <- "";
displaying <- false;

function Display()
{
	if (!displaying)
	{
		displaying = true;
		EntFireByHandle(self, "FireUser1", "", 0.00, null, null);
	}
}

function UpdateMessage()
{
	MESSAGE = "";

	if (ICE != "")
		MESSAGE = MESSAGE + ICE + "\n";

	if (HEAL != "")
		MESSAGE = MESSAGE + HEAL + "\n";

	if (FIRE != "")
		MESSAGE = MESSAGE + FIRE + "\n";

	if (POISON != "")
		MESSAGE = MESSAGE + POISON + "\n";

	if (WIND != "")
		MESSAGE = MESSAGE + WIND;

	EntFireByHandle(self, "SetText", MESSAGE, 0.00, null, null);
}

function SetIceLevel(level)
{
	ICE = "Ice - Level " + level;
	UpdateMessage();
}

function SetHealLevel(level)
{
	HEAL = "Heal - Level " + level;
	UpdateMessage();
}

function SetFireLevel(level)
{
	FIRE = "Fire - Level " + level;
	UpdateMessage();
}

function SetPoisonLevel(level)
{
	POISON = "Poison - Level " + level;
	UpdateMessage();
}

function SetWindLevel(level)
{
	WIND = "Wind - Level " + level;
	UpdateMessage();
}