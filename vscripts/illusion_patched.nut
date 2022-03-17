//#####################################################################
//Patched version intended for use with GFL ze_silent_hill_3_dawn_v2 stripper
//Translates the map
//Install as csgo/scripts/vscripts/gfl/illusion_patched.nut
//#####################################################################

s1 <- null;
s2 <- null;

function Msg1(){
	s1 = "Defend for "
	s2 = " seconds"
	CountdownTimer(40);
}

function Msg2(){
	s1 = "Zombies teleport in "
	s2 = " seconds"
	CountdownTimer2(10);
}

function Msg3(){
	s1 = "Zombie cage opens in "
	s2 = " seconds"
	CountdownTimer2(15);
}

function Msg4(){
	s1 = "Zombie cage opens in "
	s2 = " seconds"
	CountdownTimer2(10);
}

function Msg5(){
	s1 = "Defend for "
	s2 = " seconds"
	CountdownTimer(30);
}

function Msg6(){
	s1 = "Zombie cage opens in "
	s2 = " seconds"
	CountdownTimer2(5);
}

function Msg7(){
	s1 = "Defend for "
	s2 = " seconds"
	CountdownTimer(20);
}

function Msg8(){
	s1 = "Zombie cage opens in "
	s2 = " seconds"
	CountdownTimer2(40);
}

function Msg9(){
	s1 = "Defend for "
	s2 = " seconds"
	CountdownTimer(60);
}

function Msg10(){
	s1 = "Zombie cage opens in "
	s2 = " seconds"
	CountdownTimer2(30);
}

function Msg11s(){
	s1 = "Hold! Metal gate opens in "
	s2 = " seconds"
	CountdownTimer(45);
}

function Msg13(){
	s1 = "Zombies teleport to the door in "
	s2 = " seconds"
	CountdownTimer2(10);
}

function Msg14(){
	s1 = "White box will break in "
	s2 = " seconds"
	CountdownTimer(25);
}

function Msg15(){
	s1 = "Zombies teleport to the walkway in "
	s2 = " seconds"
	CountdownTimer2(15);
}

function Msg16(){
	s1 = "Metal door opens in "
	s2 = " seconds \nQuickly exit the room and regroup"
	CountdownTimer(25);
}

function Msg17(){
	s1 = "Zombies teleport to the corridor in "
	s2 = " seconds"
	CountdownTimer2(10);
}

function Msg18(){
	s1 = "Stone platform rises in "
	s2 = " seconds \nPrepare to enter the corridor leading to the pool"
	CountdownTimer(25);
}

function Msg19(){
	s1 = "Zombies drop in "
	s2 = " seconds! \nWatch your backs!"
	CountdownTimer2(10);
}

function Msg20(){
	s1 = "Metal fence breaks in "
	s2 = " seconds"
	CountdownTimer(20);
}

function Msg21(){
	s1 = "Zombies teleport by the white box in "
	s2 = " seconds"
	CountdownTimer2(10);
}

function Msg22(){
	s1 = "Sunken platforms rises in "
	s2 = " seconds \nDo not edge!"
	CountdownTimer(20);
}

function Msg23(){
	s1 = "Zombies teleport above the stairs in "
	s2 = " seconds"
	CountdownTimer2(10);
}

function Msg23s(){
	s1 = "Metal fence breaks in "
	s2 = " seconds \nThrow some nades and retreat"
	CountdownTimer(20);
}

function Msg24(){
	s1 = "Hidden path appears in "
	s2 = " seconds"
	CountdownTimer(10);
}

function Msg25(){
	s1 = "White boxes break in "
	s2 = " second"
	CountdownTimer(15);
}

function Msg26(){
	s1 = "Defend for "
	s2 = " seconds \nDo not edge!"
	CountdownTimer(25);
}

function Msg26s(){
	s1 = "Zombies teleport to the small room below in "
	s2 = " seconds"
	CountdownTimer2(15);
}

function Msg27(){
	s1 = "Zombies teleport behind in "
	s2 = " seconds"
	CountdownTimer2(10);
}

function Msg28(){
	s1 = "Defend! Metal wire breaks in "
	s2 = " seconds"
	CountdownTimer(15);
}

function Msg29(){
	s1 = "Elevator starts in "
	s2 = " seconds \nThen level one is completed!"
	CountdownTimer(25);
}

function Msg30(){
	s1 = "Zombies teleport below in "
	s2 = " seconds \nHead up and break the wall"
	CountdownTimer2(10);
}

function Msg31(){
	s1 = "Ritual has been lit! \nObstacles clearing in "
	s2 = " seconds."
	CountdownTimer(50);
}

function Msg32(){
	s1 = "Defend the doorway! \nHumans teleport to the world in "
	s2 = " seconds"
	CountdownTimer(20);
}

function Msg32s(){
	s1 = "Zombies teleport behind in "
	s2 = " seconds"
	CountdownTimer2(10);
}

function Msg33(){
	s1 = "Door opens in "
	s2 = " seconds"
	CountdownTimer(25);
}

function Msg34(){
	s1 = "White room obstacles clearing in "
	s2 = " seconds"
	CountdownTimer2(30);
}

function Msg35(){
	s1 = "Defend! Door closes in "
	s2 = " seconds"
	CountdownTimer3(10);
}

function Msg35s(){
	s1 = "Zombies teleport to the white room in "
	s2 = " seconds"
	CountdownTimer2(5);
}

function Msg36(){
	s1 = "Metal door behind the black room opens in "
	s2 = " seconds"
	CountdownTimer(25);
}

function Msg37(){
	s1 = "Stay on the walkway! \nTeleporting humans to the dark world in "
	s2 = " seconds"
	CountdownTimer(20);
}

function Msg37s(){
	s1 = "Zombies teleport behind in "
	s2 = " seconds"
	CountdownTimer2(5);
}

function Msg38(){
	s1 = "Ritual has been lit! \nZombies teleport under the stairs in "
	s2 = " seconds"
	CountdownTimer(15);
}

function Msg38s(){
	s1 = "Boards break in "
	s2 = " seconds. Prepare to enter the pathway"
	CountdownTimer(30);
}

function Msg39(){
	s1 = "Ritual has been lit! \nWooden boards at both sides will break in "
	s2 = " seconds \nPrepare to enter the sewers"
	CountdownTimer(25);
}

function Msg40(){
	s1 = "Teleporting humans in "
	s2 = " seconds. Stay in the sewers!"
	CountdownTimer(20);
}

function Msg40s(){
	s1 = "Zombies teleport to the sewers in "
	s2 = " seconds"
	CountdownTimer2(5);
}

function Msg42(){
	s1 = "Teleporting humans to the blood factory in "
	s2 = " seconds"
	CountdownTimer(20);
}

function Msg42s(){
	s1 = "Zombies teleport behind in "
	s2 = " seconds"
	CountdownTimer2(5);
}

function Msg43(){
	s1 = "Defend while the metal door opens in "
	s2 = " seconds"
	CountdownTimer(25);
}
function Msg44(){
	s1 = "Zombies teleport below in "
	s2 = " seconds"
	CountdownTimer2(10);
}

function Msg44s(){
	s1 = "Defend while the metal door opens in "
	s2 = " seconds"
	CountdownTimer(25);
}

function Msg45(){
	s1 = "Zombies teleport to the metal walkway in "
	s2 = " seconds"
	CountdownTimer2(15);
}

function Msg46(){
	s1 = "Metal door leading to elevators open in "
	s2 = " seconds"
	CountdownTimer(25);
}

function Msg47(){
	s1 = "Elevator starts in "
	s2 = " seconds"
	CountdownTimer(25);
}

function Msg48(){
	s1 = "Zombies teleport to the metal platform in "
	s2 = " seconds"
	CountdownTimer2(10);
}

function Msg50(){
	s1 = "Stage selection buttons unlock in "
	s2 = " seconds"
	CountdownTimer3(10);
}

function Msg52(){
	s1 = "Launching nuke in "
	s2 = " seconds"
	CountdownTimer3(30);
}

function Msg53(){
	s1 = "Zombies teleport above in "
	s2 = " seconds"
	CountdownTimer(10);
}

function Msg54(){
	s1 = "Zombie protection deactivates in "
	s2 = " seconds"
	CountdownTimer4(3);
}

function Msg55(){
	s1 = "Zombie protection deactivates in "
	s2 = " seconds"
	CountdownTimer4(5);
}

function Msg56(){
	s1 = "Zombie protection deactivates in "
	s2 = " seconds"
	CountdownTimer4(5);
}

function Msg57(){
	s1 = "Zombie protection deactivates in "
	s2 = " seconds"
	CountdownTimer4(5);
}

function Msg58(){
	s1 = "Zombie teleport behind in "
	s2 = " seconds"
	CountdownTimer2(5);
}

function Msg59(){
	s1 = "Teleporting humans in "
	s2 = " seconds"
	CountdownTimer(20);
}

function Msg60(){
	s1 = "Head up after metal door opens in "
	s2 = " seconds"
	CountdownTimer(30);
}

function Msg61(){
	s1 = "Zombies teleport below in "
	s2 = " seconds"
	CountdownTimer2(10);
}

function Msg62(){
	s1 = "Boxes break in "
	s2 = " seconds"
	CountdownTimer(30);
}

function Msg63(){
	s1 = "Zombies teleport to the platform in "
	s2 = " seconds"
	CountdownTimer2(10);
}

function Msg64(){
	s1 = "Defend for "
	s2 = " seconds until the stone door closes"
	CountdownTimer3(30);
}

function CountdownTimer(amount)
{
	local i = amount;
	local j;
	for(j = amount;j > 0;j--)
	{
		EntFire("Channel 1","SetText",s1 + j.tostring() + s2,i-j);
		EntFire("Channel 1","Display","",i-j);
	}
}

function CountdownTimer2(amount)
{
	local i = amount;
	local j;
	for(j = amount;j > 0;j--)
	{
		EntFire("Channel 2","SetText",s1 + j.tostring() + s2,i-j);
		EntFire("Channel 2","Display","",i-j);
	}
}

function CountdownTimer3(amount)
{
	local i = amount;
	local j;
	for(j = amount;j > 0;j--)
	{
		EntFire("Channel 3","SetText",s1 + j.tostring() + s2,i-j);
		EntFire("Channel 3","Display","",i-j);
	}
}

function CountdownTimer4(amount)
{
	local i = amount;
	local j;
	for(j = amount;j > 0;j--)
	{
		EntFire("channel 3 grey","SetText",s1 + j.tostring() + s2,i-j);
		EntFire("channel 3 grey","Display","",i-j);
	}
}

function MT1(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext2")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT2(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext2")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Retreat" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT3(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n 《Silent Hill 3: Dawn》" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT4(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Place the batteries" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT5(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Charging..." + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT6(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Charged 50%" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT7(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Charged 100%" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT8(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n This area is protected from the nuke" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT9(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Wait for the surf path to trigger the nuke" + 
			"\n"
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT10(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Chapter 1" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT13(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext3")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n" +
			"\n"
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}

function MT14(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext3")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Only the dark side can break the wooden boards" +
			"\n Both sides must defend before regrouping" +
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT15(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Triggered secret easter egg（1/1)" +
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT16(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Drawn by: 港村村长" +
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT17(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext3")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Pixiv homepage:" + 
			"\n https://www.pixiv.net/users/12413989" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT18(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Difficulty: Normal" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT19(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Difficulty: Hard" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT20(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n The Second Week" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT21(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Unlocked new BGM: Promise" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT23(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Map has been cleared!" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT24(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Stage selection next: Starts from week 2" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT25(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Hint: This stage has no zombie protection" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT26(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Secret Easter Egg Ending" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}

function MT27(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n True Ending: Escape" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
	}
}