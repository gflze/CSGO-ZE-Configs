//MAP_LOGO

Maplogo <- [
	{
		message = "Map by Hmn\nSpecial Thanks coboldon and Lupercalia Server"
		holdtime = 3
		fadein = true
		fadeout = true
	},
	{
		message = "EPISODE 02: Watagi Tunnel"
		holdtime = 3
		fadein = true
		fadeout = true
	},
];

function DisplayMaplogo(idx) {
	local gameText = Entities.FindByName(null, "[ENDING]MAP_LOGO");

	if (gameText == null) {
		return;
	}

	gameText.__KeyValueFromString("message", Maplogo[idx].message);
	gameText.__KeyValueFromFloat("holdtime", Maplogo[idx].holdtime <= 0 ? 100 : Maplogo[idx].holdtime);
	gameText.__KeyValueFromFloat("fadein", Maplogo[idx].fadein ? 0.5 : 0);
	gameText.__KeyValueFromFloat("fadeout", Maplogo[idx].fadeout ? 0.8 : 0);

	EntFireByHandle(gameText, "Display", "", 0, gameText, gameText);
}

//MAP_GM

Mapgm <- [
	{
		message = "「Suicide Bridge」\nDanger - ★★☆☆☆☆\n\nConstant suicides occur at a certain bridge.\nGetting too close will get you pulled into the other world\n\nStay away from any scattered shoes..."
		holdtime = 8
		fadein = true
		fadeout = true
	},
	{
		message = "「Pit of the Abyss」\nDanger - ★★★☆☆☆\n\nA chair used by suicide victims is near the maintenance room.\nApproaching it gives you suicidal impulses and is lured to the other side...\nC\nuriosity killed the cat..."
		holdtime = 8
		fadein = true
		fadeout = true
	},
	{
		message = "「Watagi Inn」\nDanger - ★★★★★★\n\nRumors of a demolished inn appeared in the tunnel\nPsychotic people have visited the tunnel but have not found the inn.\n\nThe center of hatred..."
		holdtime = 8
		fadein = true
		fadeout = true
	},
];

function DisplayMapgm(idx) {
	local gameText = Entities.FindByName(null, "[ENDING]MAP_GM");

	if (gameText == null) {
		return;
	}

	gameText.__KeyValueFromString("message", Mapgm[idx].message);
	gameText.__KeyValueFromFloat("holdtime", Mapgm[idx].holdtime <= 0 ? 100 : Mapgm[idx].holdtime);
	gameText.__KeyValueFromFloat("fadein", Mapgm[idx].fadein ? 0.5 : 0);
	gameText.__KeyValueFromFloat("fadeout", Mapgm[idx].fadeout ? 0.8 : 0);

	EntFireByHandle(gameText, "Display", "", 0, gameText, gameText);
}

//STORY

Story <- [
	{
		message = "The Watagi Incident (October 5th, 1980)\nA horrific incident caused by the cult group \"Deiasu Meeting\" at the Watagi Inn.\n5 people were killed for a ritual where female bodies were enshrined as deity.\nThe rest were dismembered and left at the lake."
		holdtime = 20
		fadein = true
		fadeout = true
	},
	{
		message = "Heisei Era Mass Suicide\nLargest recorded mass suicide at Heisei in 2007.\nA death row inmate, the main suspect, was found hanged in prison.\nA succession of disappearrances also occurred at the same time,\nall of which were found to be members of the \"Deiasu Meeting\" cult\nThe manager of Yotsuba Dam reported many bodies floating in the lake 2 months later"
		holdtime = 20
		fadein = true
		fadeout = true
	},
	{
		message = "Watagi mystery:After the incident, a series of bizarre phenomena occurred in the Watagi area.The related tunnels and dams were completely sealed off by the Kanto Regional Development Bureau, and the limestone caves of Okitsu, which had been a popular tourist attraction, were partially closed. It is called "forbidden land" by local residents, and it is said that anyone who sets foot in the area can never return. In fact, there seems to be no end to the number of disappearances and suicides."
		holdtime = 18
		fadein = true
		fadeout = true
	},
];

function DisplayStory(idx) {
	local gameText = Entities.FindByName(null, "[SYSTEM]STORY_TEXT");

	if (gameText == null) {
		return;
	}

	gameText.__KeyValueFromString("message", Story[idx].message);
	gameText.__KeyValueFromFloat("holdtime", Story[idx].holdtime <= 0 ? 100 : Story[idx].holdtime);
	gameText.__KeyValueFromFloat("fadein", Story[idx].fadein ? 0.5 : 0);
	gameText.__KeyValueFromFloat("fadeout", Story[idx].fadeout ? 0.8 : 0);

	EntFireByHandle(gameText, "Display", "", 0, gameText, gameText);
}

Story1 <- [
	{
		message = "Subsequent investigations by authorities led to all bodies recovered,\nbut the woman's body is still missing\nThe Watagi Inn was taken down after the incident."
		holdtime = 20
		fadein = true
		fadeout = true
	},
	{
		message = "Autopsy of the recovered bodies reveal all died of exsanguination.\nThe scars suggest all committed suicide by cutting their own necks as they jumped into the lake.\nSeveral \"We are saved\" notes lay scattered by the dam lake."
		holdtime = 20
		fadein = true
		fadeout = true
	},
	{
		message = "What were they worshipping?\nDoes this mean the cycle continues...?"
		holdtime = 18
		fadein = true
		fadeout = true
	},
];

function DisplayStory1(idx) {
	local gameText = Entities.FindByName(null, "[SYSTEM]STORY_TEXT2");

	if (gameText == null) {
		return;
	}

	gameText.__KeyValueFromString("message", Story1[idx].message);
	gameText.__KeyValueFromFloat("holdtime", Story1[idx].holdtime <= 0 ? 100 : Story1[idx].holdtime);
	gameText.__KeyValueFromFloat("fadein", Story1[idx].fadein ? 0.5 : 0);
	gameText.__KeyValueFromFloat("fadeout", Story1[idx].fadeout ? 0.8 : 0);

	EntFireByHandle(gameText, "Display", "", 0, gameText, gameText);
}