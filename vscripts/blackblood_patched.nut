//#####################################################################
//Patched version intended for use with GFL ze_silent_hill_blackblood_f6 stripper
//Translates the map
//Install as csgo/scripts/vscripts/gfl/blackblood_patched.nut
//#####################################################################

s1 <- null;
s2 <- null;

function Msg2(){
	s1 = "Defend for "
	s2 = " seconds until wooden boards break"
	CountdownTimer(25);
}

function Msg3(){
	s1 = "Fall back when wooden boards break in "
	s2 = " seconds"
    CountdownTimer(20);
}

function Msg4(){
	s1 = "Zombies teleport behind humans in "
	s2 = " seconds"
    CountdownTimer2(12);
}

function Msg5(){
	s1 = "Zombies teleport below the stairs in "
	s2 = " stairs"
    CountdownTimer2(15);
}
function Msg6(){
	s1 = "Defend until obstacles clear in "
	s2 = " seconds"
    CountdownTimer(40);
}

function Msg7(){
	s1 = "Zombies teleport to the pathway in "
	s2 = " seconds"
    CountdownTimer2(10);
}

function Msg8(){
	s1 = "Metal door opens in "
	s2 = " seconds"
    CountdownTimer(30);
}

function Msg9(){
	s1 = "Zombies teleport behind in "
	s2 = " seconds"
    CountdownTimer2(12);
}

function Msg10(){
	s1 = "Metal fence and boxes break in "
	s2 = " seconds. Watch your backs!"
    CountdownTimer(35);
}

function Msg11(){
	s1 = "Obstacles clear in "
	s2 = " seconds"
    CountdownTimer(20);
}

function Msg12(){
	s1 = "Zombies teleport behind in "
	s2 = " seconds"
    CountdownTimer2(10);
}

function Msg13(){
	s1 = "Metal door opens in "
	s2 = " seconds"
    CountdownTimer(30);
}

function Msg14(){
	s1 = "Zombies teleport to the stairs in "
	s2 = " seconds"
    CountdownTimer2(15);
}

function Msg15(){
	s1 = "Defend for "
	s2 = " seconds until boxes break"
    CountdownTimer(30);
}

function Msg16(){
	s1 = "Zombies teleport behind in "
	s2 = " seconds"
    CountdownTimer2(10);
}

function Msg17(){
	s1 = "Zombies teleport between the rocks in "
	s2 = " seconds"
    CountdownTimer2(15);
}

function Msg18(){
	s1 = "Defend for "
	s2 = " seconds until metal door opens"
    CountdownTimer(20);
}

function Msg18s(){
	s1 = "Defend for "
	s2 = " seconds until metal door closes"
    CountdownTimer(10);
}

function Msg19(){
	s1 = "Prepare to enter the elevator in "
	s2 = " seconds and move to the next level"
    CountdownTimer(7);
}

function Msg21(){
	s1 = "Backdoor opens in "
	s2 = " seconds"
    CountdownTimer(25);
}

function Msg22(){
	s1 = "Defend the crouch spot for "
	s2 = " seconds until metal door opens"
    CountdownTimer(20);
}

function Msg23(){
	s1 = "Zombies teleport above in "
	s2 = " seconds"
    CountdownTimer2(5);
}

function Msg24(){
	s1 = "Zombies teleport behind the wall in "
	s2 = " seconds"
    CountdownTimer2(10);
}

function Msg25(){
	s1 = "Defend for "
	s2 = " seconds until metal door opens"
    CountdownTimer(45);
}

function Msg26(){
	s1 = "Zombies teleport below the stairs in "
	s2 = " seconds, opening the shortcut"
    CountdownTimer2(10);
}

function Msg27(){
	s1 = "Defend for "
	s2 = " seconds until metal door opens"
    CountdownTimer(20);
}

function Msg28(){
	s1 = "Zombie shortcut open, metal door opens in "
	s2 = " seconds"
    CountdownTimer(20);
}

function Msg29(){
	s1 = "Obstacles clear in "
	s2 = " seconds. Prepare to head up"
    CountdownTimer(25);
}

function Msg30(){
	s1 = "Zombies teleport to the platform below in "
	s2 = " secons. Break the wall above"
    CountdownTimer2(10);
}

function Msg31(){
	s1 = "Zombies teleport above the stairs in "
	s2 = " seconds. Beware of shortcut above"
    CountdownTimer2(10);
}

function Msg32(){
	s1 = "Defend for "
	s2 = " seconds until elevator rises"
    CountdownTimer(20);
}

function Msg33(){
	s1 = "Wooden boards break in "
	s2 = " seconds. Prepare to jump down the hole"
    CountdownTimer(5);
}

function Msg34(){
	s1 = "Zombies teleport behind in "
	s2 = " seconds"
    CountdownTimer2(15);
}

function Msg35(){
	s1 = "Platform rises in "
	s2 = " seconds"
    CountdownTimer(30);
}

function Msg36(){
	s1 = "Defend for "
	s2 = " until metal door opens. Zombies are held back"
    CountdownTimer(15);
}

function Msg37(){
	s1 = "Zombies start chasing in "
	s2 = " seconds"
    CountdownTimer2(4);
}

function Msg38(){
	s1 = "Zombies teleport by the boxes in "
	s2 = " seconds"
    CountdownTimer2(10);
}

function Msg39(){
	s1 = "Clearing obstacles in "
	s2 = " seconds"
    CountdownTimer(30);
}

function Msg40(){
	s1 = "Clearing obstacles in "
	s2 = " seconds. Prepare to doorhug"
    CountdownTimer(25);
}

function Msg41(){
	s1 = "Zombies teleport by the ramp in "
	s2 = " seconds. Watch your back!"
    CountdownTimer2(10);
}

function Msg42(){
	s1 = "Zombies teleport to the metal fence in "
	s2 = " seconds"
    CountdownTimer2(15);
}

function Msg43(){
	s1 = "Defend for "
	s2 = " seconds until metal door opens"
    CountdownTimer(25);
}
function Msg44(){
	s1 = "Zombies teleport behind in "
	s2 = " seconds"
    CountdownTimer(15);
}

function Msg45(){
	s1 = "Zombies teleport behind in "
	s2 = " seconds"
    CountdownTimer2(15);
}

function Msg46(){
	s1 = "Last defense! Elevator rises in "
	s2 = " seconds"
    CountdownTimer(30);
}

function Msg47(){
	s1 = "First  zombie teleport activates in "
	s2 = " seconds"
    CountdownTimer(30);
}

function Msg48(){
	s1 = "Second zombie teleport activates in "
	s2 = " seconds"
    CountdownTimer2(35);
}

function Msg49(){
	s1 = "Third zombie teleport activates in "
	s2 = " seconds"
    CountdownTimer3(35);
}

function Msg50(){
	s1 = "Fourth zombie teleport activates in "
	s2 = " seconds"
    CountdownTimer(40);
}

function Msg51(){
	s1 = "Fifth zombie teleport activates in "
	s2 = " seconds"
    CountdownTimer2(40);
}

function Msg52(){
	s1 = "Final teleport activates in "
	s2 = " seconds"
    CountdownTimer3(45);
}

function Msg53(){
	s1 = "Try to survive humans! Nuking zombies in "
	s2 = " seconds"
    CountdownTimer(93);
}

function Msg54(){
	s1 = "Zombies teleport below in "
	s2 = " seconds"
    CountdownTimer2(10);
}

function Msg55(){
	s1 = "Zombies teleport behind in "
	s2 = " seconds"
    CountdownTimer2(15);
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

function MT2(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext2")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Retreat " + 
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
			"\n 《Silent Hill 1: Black Blood》" + 
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
			"\n Mapper：港村村長" + 
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
			"\n Stage 1: Overworld" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}

function MT6(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext3")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Hint: Overdefend the stairs instead of doorhugging" + 
			"\n" +
			"\n Throw nades and fall back when 5 seconds remain"+
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}

function MT7(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext3")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Hint: Overdefenders fall back when 16 seconds remain" + 
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
			"\n Hint: Get in the elevator or die to the nuke" + 
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
			"\n Stage 2: Underworld" + 
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
			"\n Found secret room (1/4)" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}

function MT11(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Found secret room (2/4)" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}

function MT12(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Found secret room (3/4)" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}

function MT13(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Discovered easter egg room (1/1)" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}

function MT14(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Found secret room (4/4)" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}

function MT15(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext3")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Hint: Continue to defend even until the next timer" + 
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
			"\n Hint: Do not touch the water" + 
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
			"\n Triggered easter egg button:" + 
			"\n Secret stage activated once map is cleared" +
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
			"\n Activated secret stage" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}

function MT19(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext3")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Black Blood chapter complete" +
			"\n Next is《Silent Hill 2: Illusion》" + 
			"\n This is just the beginning..." +
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
			"\n Secret Stage: Mario's World" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}

function MT21(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext3")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Hint: Learn to surf by visiting BiliBili and searching 'How to surf'" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}

function MT22(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Activated hidden defense point" + 
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
			"\n Unlocked new BGM" + 
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
			"\n Drawn by: 港村村長" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}

function MT25(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext3")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Pixiv HomePage" + 
			"\n https://www.pixiv.net/users/12413989" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}

function MT26(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext3")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Special thanks to Kinlkm for testing and assistance" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}