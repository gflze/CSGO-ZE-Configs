//#####################################################################
//Patched version intended for use with GFL ze_silent_hill_2_illusion_b5 stripper
//Translates the map
//Install as csgo/scripts/vscripts/gfl/sh2_patched.nut
//#####################################################################

s1 <- null;
s2 <- null;

function Msg2() {
	s1 = "Red blood door opens in "
	s2 = "s"
	CountdownTimer(40);
}

function Msg3() {
	s1 = "Humans teleport in "
	s2 = "s"
	CountdownTimer1(9);
}

function Msg4() {
	s1 = "Boxes break in "
	s2 = "s\nBeware of zombies coming from the side door!"
	CountdownTimer(40);
}

function Msg5() {
	s1 = "This is all an illusion~\nTeleporting humans back to reality in "
	s2 = "s"
	CountdownTimer(10);
}

function Msg7() {
	s1 = "Zombies teleport to the storage room in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg8() {
	s1 = "Boxes break in "
	s2 = "s"
	CountdownTimer(20);
}

function Msg9() {
	s1 = "Zombies teleport to the stairs in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg10() {
	s1 = "Wooden boards break in "
	s2 = "s\nPrepare to enter the dark world..."
	CountdownTimer(15);
}

function Msg11() {
	s1 = "Zombies teleport behind in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg12() {
	s1 = "Zombies teleport to the metal boards in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg12s() {
	s1 = "Metal door opens in "
	s2 = "s"
	CountdownTimer(45);
}

function Msg13() {
	s1 = "Zombies teleport to the door in "
	s2 = "s\nRun!"
	CountdownTimer2(10);
}

function Msg14() {
	s1 = "The boxes break in "
	s2 = "s"
	CountdownTimer(25);
}

function Msg15() {
	s1 = "Zombies teleport to the walkway in "
	s2 = "s"
	CountdownTimer2(15);
}

function Msg16() {
	s1 = "Metal door opens in "
	s2 = "s\nQuickly exit the room and regroup"
	CountdownTimer(25);
}

function Msg17() {
	s1 = "Zombies teleport to the walkway in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg18() {
	s1 = "Bridge rises in "
	s2 = "s\nPrepare to drop down to the pool"
	CountdownTimer(25);
}

function Msg19() {
	s1 = "Zombies teleport above in "
	s2 = "s\nWatch your backs!"
	CountdownTimer2(10);
}

function Msg20() {
	s1 = "Breaking the metal fence in "
	s2 = "s"
	CountdownTimer(20);
}

function Msg21() {
	s1 = "Zombies teleport to the white box in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg22() {
	s1 = "Sunken platforms rise in "
	s2 = "s\nDo not edge!"
	CountdownTimer(20);
}

function Msg23() {
	s1 = "Zombies teleport above the stairs in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg23s() {
	s1 = "Metal fence breaks in "
	s2 = "s"
	CountdownTimer(20);
}

function Msg24() {
	s1 = "Hidden path appears in "
	s2 = "s"
	CountdownTimer(10);
}

function Msg25() {
	s1 = "White boxes break in "
	s2 = "s"
	CountdownTimer(15);
}

function Msg26() {
	s1 = "Defend for "
	s2 = "s\nDo not edge!"
	CountdownTimer(25);
}

function Msg26s() {
	s1 = "Zombies teleport to the small room below in "
	s2 = "s"
	CountdownTimer2(15);
}

function Msg27() {
	s1 = "Zombies teleport behind in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg28() {
	s1 = "Metal fence breaks in "
	s2 = "s"
	CountdownTimer(15);
}

function Msg29() {
	s1 = "Elevator starts in "
	s2 = "s\nLevel complete afterwards!"
	CountdownTimer(25);
}

function Msg31() {
	s1 = "Ritual lit! Obstacles clear in "
	s2 = "s"
	CountdownTimer(50);
}

function Msg32() {
	s1 = "Humans teleport to the world in "
	s2 = "s"
	CountdownTimer(20);
}

function Msg32s() {
	s1 = "Zombies teleport behind in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg33() {
	s1 = "Door opens in "
	s2 = "s"
	CountdownTimer(25);
}

function Msg34() {
	s1 = "White room obstacles clearing in "
	s2 = "s"
	CountdownTimer2(30);
}

function Msg35() {
	s1 = "Door closes in "
	s2 = "s"
	CountdownTimer3(10);
}

function Msg35s() {
	s1 = "Zombies teleport to the white room in "
	s2 = "s"
	CountdownTimer2(5);
}

function Msg36() {
	s1 = "Metal door behind the black room opens in "
	s2 = "s"
	CountdownTimer(25);
}

function Msg37() {
	s1 = "Stay off the walkway!\nTeleporting humans in "
	s2 = "s"
	CountdownTimer(20);
}

function Msg37s() {
	s1 = "Zombies teleport behind in "
	s2 = "s"
	CountdownTimer2(5);
}

function Msg38() {
	s1 = "Ritual lit!\nZombies teleport in "
	s2 = "s"
	CountdownTimer(15);
}

function Msg38s() {
	s1 = "Wooden boards break in "
	s2 = "s\nPrepare to enter the pathway"
	CountdownTimer(30);
}

function Msg39() {
	s1 = "Ritual lit! Wooden boards break in "
	s2 = "s\nPrepare to enter the sewers"
	CountdownTimer(25);
}

function Msg40() {
	s1 = "Teleporting humans in "
	s2 = "s!\nStay in the sewers!"
	CountdownTimer(20);
}

function Msg40s() {
	s1 = "Zombies teleport to the sewers in "
	s2 = "s"
	CountdownTimer2(5);
}

function Msg42() {
	s1 = "Teleporting humans in "
	s2 = "s"
	CountdownTimer(20);
}

function Msg42s() {
	s1 = "Zombies teleport behind in "
	s2 = "s"
	CountdownTimer2(5);
}

function Msg43() {
	s1 = "Metal door opens in "
	s2 = "s"
	CountdownTimer(25);
}
function Msg44() {
	s1 = "Zombies teleport below in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg44s() {
	s1 = "Metal door opens in "
	s2 = "s"
	CountdownTimer(25);
}

function Msg45() {
	s1 = "Zombies teleport to the metal walkway in "
	s2 = "s"
	CountdownTimer2(15);
}

function Msg46() {
	s1 = "Metal doors open in "
	s2 = "s"
	CountdownTimer(25);
}

function Msg47() {
	s1 = "Elevator starts in "
	s2 = "s"
	CountdownTimer(25);
}

function Msg48() {
	s1 = "Zombies teleport to the metal platform in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg50() {
	s1 = "Stage selection buttons unlocks in "
	s2 = "s"
	CountdownTimer3(10);
}

function Msg52() {
	s1 = "Launching nuke in "
	s2 = "s"
	CountdownTimer3(30);
}

function Msg53() {
	s1 = "Zombies teleport above in "
	s2 = "s"
	CountdownTimer(10);
}

function Msg54() {
	s1 = "Zombie protection deactivates in "
	s2 = "s"
	CountdownTimer4(3);
}

function Msg55() {
	s1 = "Zombie protection deactivates in "
	s2 = "s"
	CountdownTimer4(5);
}

function Msg56() {
	s1 = "Zombie protection deactivates in "
	s2 = "s"
	CountdownTimer4(5);
}

function Msg57() {
	s1 = "Zombie protection deactivates in "
	s2 = "s"
	CountdownTimer4(5);
}

function Msg58() {
	s1 = "Zombie teleport behind in "
	s2 = "s"
	CountdownTimer2(5);
}

function Msg59() {
	s1 = "Teleporting humans in "
	s2 = "s"
	CountdownTimer(20);
}

function Msg60() {
	s1 = "Metal door opens in "
	s2 = "s"
	CountdownTimer(30);
}

function Msg61() {
	s1 = "Zombies teleport below in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg62() {
	s1 = "Boxes break in "
	s2 = "s"
	CountdownTimer(30);
}

function Msg63() {
	s1 = "Zombies teleport to the platform in "
	s2 = "s"
	CountdownTimer2(10);
}

function Msg64() {
	s1 = "Door closes in "
	s2 = "s"
	CountdownTimer3(30);
}

function CountdownTimer(amount)
{
	local i = amount;
	local j;
	for (j = amount; j > 0; j--) {
		EntFire("Channel 1", "SetText", s1 + j.tostring() + s2, i - j);
		EntFire("Channel 1", "Display", "", i - j);
	}
}

function CountdownTimer2(amount)
{
	local i = amount;
	local j;
	for (j = amount; j > 0; j--) {
		EntFire("Channel 2", "SetText", s1 + j.tostring() + s2, i - j);
		EntFire("Channel 2", "Display", "", i - j);
	}
}

function CountdownTimer3(amount)
{
	local i = amount;
	local j;
	for (j = amount; j > 0; j--) {
		EntFire("Channel 3", "SetText", s1 + j.tostring() + s2, i - j);
		EntFire("Channel 3", "Display", "", i - j);
	}
}

function CountdownTimer4(amount)
{
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
		Text <- "Retreat!"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT3() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "《Silent Hill 2: Illusion》"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT4() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Mapper: 港村村長"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT5() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Stage 1: Chaos"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT7() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext3")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Easter Egg discovered"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT8() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Stage 2: White Room"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT9() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Hint: Defend all three paths"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT10() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Hint: Maze path is under your feet!"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT12() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Stage 3: White and Black"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT13() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext3")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Zombies get ahead if one side falls" +
			"\nBoth sides defend until regrouping"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT14() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext3")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Only the dark path can light the ritual" +
			"\nBoth sides must defend until all paths open!"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT15() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Easter egg triggered (1/1)"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT16() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Drawn by : 港村村长"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT17() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext3")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Pixiv: https://www.pixiv.net/users/12413989"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT18() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Normal Difficulty"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT19() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Hard Difficulty"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT20() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Week 2"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT21() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "New BGM unlocked: Promise"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT23() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Map cleared!"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT24() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Stage selection next!" +
			"\n Starts from Week 2!"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT25() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Hint : This stage has no zombie protection"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT26() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "Bad Ending : Dead End"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}

function MT27() {
	theGameText <- Entities.FindByName(null, "channel 4 maptext")
	if (theGameText != null) {
		local temp1 = theGameText.GetName();
		Text <- "True Ending : Escape"
		theGameText.__KeyValueFromString("message", Text)
		EntFire(temp1, "Display", "", 0.10, null)
	}
}