//#####################################################################
//Patched version intended for use with GFL ze_silent_hill_3_dawn_v2 stripper
//Translates the map
//Install as csgo/scripts/vscripts/gfl/illusion_patched.nut
//#####################################################################

s1 <- null;
s2 <- null;

function Msg1() {
	s1 = "Defend for "
	s2 = "s"
	CountdownTimer(40);
}

function Msg2() {
	s1 = "Zombies teleport in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg3() {
	s1 = "Zombie cage opens in "
	s2 = "s"
	CountdownTimer2(15);
}

function Msg4() {
	s1 = "Zombie cage opens in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg5() {
	s1 = "Defend for "
	s2 = "s"
	CountdownTimer(30);
}

function Msg6() {
	s1 = "Zombie cage opens in "
	s2 = "s"
	CountdownTimer2(5);
}

function Msg7() {
	s1 = "Defend for "
	s2 = "s"
	CountdownTimer(20);
}

function Msg9() {
	s1 = "Defend for "
	s2 = "s"
	CountdownTimer(60);
}

function Msg10() {
	s1 = "Zombie cage opens in "
	s2 = "s"
	CountdownTimer2(30);
}

function CountdownTimer(amount) {
	local i = amount;
	local j;
	for (j = amount; j > 0; j--) {
		EntFire("Channel 1", "SetText", s1 + j.tostring() + s2, i - j);
		EntFire("Channel 1", "Display", "", i - j);
	}
}

function CountdownTimer2(amount) {
	local i = amount;
	local j;
	for (j = amount; j > 0; j--) {
		EntFire("Channel 2", "SetText", s1 + j.tostring() + s2, i - j);
		EntFire("Channel 2", "Display", "", i - j);
	}
}

function CountdownTimer3(amount) {
	local i = amount;
	local j;
	for (j = amount; j > 0; j--) {
		EntFire("Channel 3", "SetText", s1 + j.tostring() + s2, i - j);
		EntFire("Channel 3", "Display", "", i - j);
	}
}

function CountdownTimer4(amount) {
	local i = amount;
	local j;
	for (j = amount; j > 0; j--) {
		EntFire("channel 3 grey", "SetText", s1 + j.tostring() + s2, i - j);
		EntFire("channel 3 grey", "Display", "", i - j);
	}
}

function MT2() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext2")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Retreat"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT3() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "《Silent Hill 3: Dawn》"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT4() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Place the batteries"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT5() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Charging..."
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT6() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Charged 50%"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT7() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Charged 100%"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT9() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Wait for the surf path to trigger the nuke"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}
