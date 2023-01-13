//#####################################################################
//Patched version intended for use with GFL ze_surf_happy_b7 stripper
//Translates the map
//Install as csgo/scripts/vscripts/gfl/happy_patched.nut
//#####################################################################

s1 <- null;
s2 <- null;

function Msg3() {
	s1 = "Zombie cage breaks in"
	s2 = "s"
	CountdownTimer2(15);
}

function Msg4() {
	s1 = "Defend until humans teleport in "
	s2 = "s"
	CountdownTimer(60);
}

function Msg6() {
	s1 = "Bridge breaks in "
	s2 = "s"
	CountdownTimer(65);
}

function Msg7() {
	s1 = "Teleporting in "
	s2 = "s"
	CountdownTimer2(20);
}

function Msg8() {
	s1 = "Teleporting everyone else in "
	s2 = "s"
	CountdownTimer2(30);
}

function Msg9() {
	s1 = "Teleporting everyone else in "
	s2 = "s"
	CountdownTimer2(40);
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

function MT3() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "《Surf Happy》"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT4() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Mapper: 港村村长"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}
