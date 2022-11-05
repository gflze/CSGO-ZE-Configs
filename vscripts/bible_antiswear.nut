//#####################################################################
//Intended for use with GFL ze_Bible_Adventure_OT_v1_5 stripper
//Slay people who swear, most logic taken from ze_space_flight
//Install as csgo/scripts/vscripts/gfl/bible_antiswear.nut
//#####################################################################

::swearWords <- ["fuck", "fucking", "fucker", "fucked", "motherfucker", "crap", "shit", "bullshit", "horseshit", "ass", "arse", "asshole", "arsehole", "damn", "goddamn", "hell", "satan", "bastard", "bitch", "dick", "dickhead", "penis", "cock", "cocksucker", "cunt", "pussy", "vagina", "piss", "slut", "whore", "puta", "twat", "wanker", "fag", "faggot", "zeddy", "zeddys", "zed", "mapea", "mapeadores"];

function ContainsSwear(tokenList)
{
	foreach (t in tokenList)
	{
		foreach (s in swearWords)
		{
			if (s == t.tolower())
				return true;
		}
	}

	return false;
}

function ParsePlayerMessage(player, message)
{
	if (player == null)
		return;

	local tokens = split(strip(message), " ");

	if ((player.GetTeam() == 2 || player.GetTeam() == 3) && player.GetHealth() > 0 && ContainsSwear(tokens))
	{
		EntFire("Display", "Command", "say God does not approve of swearing enjoy hell loser!!!!", 0.0, player);
		EntFire("SwearText", "Display", "", 0.0, player);
		EntFireByHandle(player, "SetHealth", "0", 0.0, player, player);
	}
}

function CheckMessage()
{
	local player = ::userIDMapper[event_data.userid];
	local message = event_data.text;
	ParsePlayerMessage(player, message);
}