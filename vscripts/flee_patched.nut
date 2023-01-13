//#####################################################################
//Patched version intended for use with GFL ze_silent_hill_3_flee_v4 stripper
//Translates the map
//Install as csgo/scripts/vscripts/gfl/flee_patched.nut
//#####################################################################

s1 <- null;
s2 <- null;

function Msg1() {
	s1 = "Defend for "
	s2 = "s"
	CountdownTimer(40);
}

function Msg5() {
	s1 = "Defend for "
	s2 = "s"
	CountdownTimer(30);
}

function Msg8() {
	s1 = "Defend for "
	s2 = "s"
	CountdownTimer(45);
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
		Text <- "Fall back!"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT3() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
        Text <- "《Silent Hill 3: Flee》"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT4() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Medium Difficulty"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT5() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Extreme Difficulty"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT6() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Normal Difficulty"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}
