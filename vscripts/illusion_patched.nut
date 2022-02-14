//#####################################################################
//Patched version intended for use with GFL ze_silent_hill_3_dawn_v2 stripper
//Translates the map
//Install as csgo/scripts/vscripts/gfl/illusion_patched.nut
//#####################################################################

s1 <- null;
s2 <- null;

function Msg1(){
	s1 = "Defense"
	s2 = "seconds"
	CountdownTimer(40);
}

function Msg2(){
	s1 = ""
	s2 = "Second zombie teleportation"
    CountdownTimer2(10);
}

function Msg3(){
	s1 = ""
	s2 = "Second body cage open"
    CountdownTimer2(15);
}

function Msg4(){
	s1 = ""
	s2 = "Second body cage open"
    CountdownTimer2(10);
}

function Msg5(){
	s1 = "Defense"
	s2 = "seconds"
    CountdownTimer(30);
}

function Msg6(){
	s1 = ""
	s2 = "Second body cage open"
    CountdownTimer2(5);
}

function Msg7(){
	s1 = "Defense"
	s2 = "seconds"
    CountdownTimer(20);
}

function Msg8(){
	s1 = ""
	s2 = "Second body cage open"
    CountdownTimer2(40);
}

function Msg9(){
	s1 = "Defense"
	s2 = "seconds"
    CountdownTimer(60);
}

function Msg10(){
	s1 = ""
	s2 = "Second body cage open"
    CountdownTimer2(30);
}

function Msg11s(){
	s1 = "Waiting"
	s2 = "Second iron door open"
    CountdownTimer(45);
}

function Msg13(){
	s1 = ""
	s2 = "Seconds after the zombie teleportation to the door position, run"
    CountdownTimer2(10);
}

function Msg14(){
	s1 = ""
	s2 = "Clear the small white box obstacle after seconds"
    CountdownTimer(25);
}

function Msg15(){
	s1 = ""
	s2 = "After seconds the zombie is teleported to the back of the narrow walkway"
    CountdownTimer2(15);
}

function Msg16(){
	s1 = ""
	s2 = "Seconds after the middle stairs of the iron door will open, quickly from the small dark room out of the middle rendezvous"
    CountdownTimer(25);
}

function Msg17(){
	s1 = ""
	s2 = "Seconds after the zombie teleportation to the dark corridor"
    CountdownTimer2(10);
}

function Msg18(){
	s1 = ""
	s2 = "After seconds the rock platform is completely raised and ready to go through the rotating corridor into the pool area"
    CountdownTimer(25);
}

function Msg19(){
	s1 = ""
	s2 = "After the zombie collective airborne from above, beware of tailgating"
    CountdownTimer2(10);
}

function Msg20(){
	s1 = ""
	s2 = "Clear the barbed wire barrier after seconds"
    CountdownTimer(20);
}

function Msg21(){
	s1 = ""
	s2 = "Second zombie teleportation to the white box next to"
    CountdownTimer2(10);
}

function Msg22(){
	s1 = ""
	s2 = "After seconds the sunken platform begins to rise, and keep a distance from the fence do not stick to the edge"
    CountdownTimer(20);
}

function Msg23(){
	s1 = ""
	s2 = "Seconds after the zombie teleportation to the top of the mahogany stairs"
    CountdownTimer2(10);
}

function Msg23s(){
	s1 = ""
	s2 = "After seconds, remove the barbed wire and prepare to throw mines to retreat"
    CountdownTimer(20);
}

function Msg24(){
	s1 = ""
	s2 = "Hidden channel appears after seconds"
    CountdownTimer(10);
}

function Msg25(){
	s1 = ""
	s2 = "After seconds the white box shattered, to the narrow passage into the bloody stairs"
    CountdownTimer(15);
}

function Msg26(){
	s1 = "Hold on"
	s2 = "Seconds, beware of edge-gripping feet"
    CountdownTimer(25);
}

function Msg26s(){
	s1 = ""
	s2 = "Seconds after the zombie teleportation below the small room"
    CountdownTimer2(15);
}

function Msg27(){
	s1 = ""
	s2 = "After seconds the zombie teleports to the back of the hanger"
    CountdownTimer2(10);
}

function Msg28(){
	s1 = "Hold on"
	s2 = "Seconds after the barbed wire barrier was removed"
    CountdownTimer(15);
}

function Msg29(){
	s1 = ""
	s2 = "After seconds the elevator starts, the first level is about to end"
    CountdownTimer(25);
}

function Msg30(){
	s1 = ""
	s2 = "Seconds after the zombie teleported to the human below the bloody small platform, up the stairs to play the broken plate"
    CountdownTimer2(10);
}

function Msg31(){
	s1 = "The Sunlight Halo icon is lit up."
	s2 = "The roadblock to the inner world will be lifted in seconds."
    CountdownTimer(50);
}

function Msg32(){
	s1 = "Defending the doorway"
	s2 = "Seconds after the human collective teleportation into the inner world"
    CountdownTimer(20);
}

function Msg32s(){
	s1 = ""
	s2 = "After seconds the zombie teleports to the back of the human"
    CountdownTimer2(10);
}

function Msg33(){
	s1 = ""
	s2 = "Door opens in seconds"
    CountdownTimer(25);
}

function Msg34(){
	s1 = ""
	s2 = "Second white room after the roadblock lifted"
    CountdownTimer2(30);
}

function Msg35(){
	s1 = "Enter the white room to defend"
	s2 = "Seconds to the door off, away from the door, the card door will be caught dead"
    CountdownTimer3(10);
}

function Msg35s(){
	s1 = ""
	s2 = "Seconds after the zombie teleport into the white room"
    CountdownTimer2(5);
}

function Msg36(){
	s1 = ""
	s2 = "Seconds after the black room behind the iron door open"
    CountdownTimer(25);
}

function Msg37(){
	s1 = "Stay in the dark room walkway."
	s2 = "Seconds after the human collective teleportation into the black world"
    CountdownTimer(20);
}

function Msg37s(){
	s1 = ""
	s2 = "Second zombie teleportation to behind the human"
    CountdownTimer2(5);
}

function Msg38(){
	s1 = "The sun's halo is illuminated and"
	s2 = "Seconds after the zombie teleportation to the stairs under"
    CountdownTimer(15);
}

function Msg38s(){
	s1 = ""
	s2 = "After seconds the plate is removed and access is gained"
    CountdownTimer(30);
}

function Msg39(){
	s1 = "The sun's halo is illuminated and"
	s2 = "Seconds both sides of the board at the same time was destroyed, ready to enter the black water channel"
    CountdownTimer(25);
}

function Msg40(){
	s1 = ""
	s2 = "Seconds after the human collective teleportation, stay in the black water channel do not go out"
    CountdownTimer(20);
}

function Msg40s(){
	s1 = ""
	s2 = "Seconds after the zombie then teleported into the black water channel"
    CountdownTimer2(5);
}

function Msg42(){
	s1 = ""
	s2 = "Seconds later humans teleported en masse, defended against the door and prepared to enter the plasma factory"
    CountdownTimer(20);
}

function Msg42s(){
	s1 = ""
	s2 = "Seconds after the zombie teleports behind the human"
    CountdownTimer2(5);
}

function Msg43(){
	s1 = "Defense"
	s2 = "After seconds the iron gate starts to rise"
    CountdownTimer(25);
}
function Msg44(){
	s1 = ""
	s2 = "Seconds after the zombie teleportation to the bottom"
    CountdownTimer2(10);
}

function Msg44s(){
	s1 = "Defense"
	s2 = "After seconds the iron door opens"
    CountdownTimer(25);
}

function Msg45(){
	s1 = ""
	s2 = "Seconds after the zombie teleportation to the barbed wire walkway"
    CountdownTimer2(15);
}

function Msg46(){
	s1 = ""
	s2 = "The iron door is about to open in seconds, leading to the elevator entrance"
    CountdownTimer(25);
}

function Msg47(){
	s1 = ""
	s2 = "Elevator starts in seconds"
    CountdownTimer(25);
}

function Msg48(){
	s1 = ""
	s2 = "Seconds after the zombie teleportation to the slope iron plate"
    CountdownTimer2(10);
}

function Msg50(){
	s1 = ""
	s2 = "Turn on the switch off button after seconds"
    CountdownTimer3(10);
}

function Msg52(){
	s1 = ""
	s2 = "After seconds all players eat nuclear explosion, enter the selected level"
    CountdownTimer3(30);
}

function Msg53(){
	s1 = ""
	s2 = "Second zombie teleportation to the bloody space above"
    CountdownTimer(10);
}

function Msg54(){
	s1 = "Zombie thrust left"
	s2 = "seconds"
    CountdownTimer4(3);
}

function Msg55(){
	s1 = "Zombie thrust left"
	s2 = "seconds"
    CountdownTimer4(5);
}

function Msg56(){
	s1 = "Zombie thrust left"
	s2 = "seconds"
    CountdownTimer4(5);
}

function Msg57(){
	s1 = "Zombie thrust left"
	s2 = "seconds"
    CountdownTimer4(5);
}

function Msg58(){
	s1 = ""
	s2 = "After seconds the zombie then teleports behind the human"
    CountdownTimer2(5);
}

function Msg59(){
	s1 = ""
	s2 = "After seconds humans start to teleport"
    CountdownTimer(20);
}

function Msg60(){
	s1 = ""
	s2 = "After seconds the iron door opens, the door opens and goes up"
    CountdownTimer(30);
}

function Msg61(){
	s1 = ""
	s2 = "Seconds after the zombie begins to teleport below"
    CountdownTimer2(10);
}

function Msg62(){
	s1 = ""
	s2 = "The box barrier will break down after seconds"
    CountdownTimer(30);
}

function Msg63(){
	s1 = ""
	s2 = "Second zombie teleportation to the intermediate platform"
    CountdownTimer2(10);
}

function Msg64(){
	s1 = "Defense"
	s2 = "seconds until the stone door is completely closed"
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
			"\n  " + 
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
			"\n     Placement of cube batteries" + 
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
			"\n       Being charged" + 
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
			"\n       Charging 50%" + 
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
			"\n       Charging 100%" + 
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
			"\n  The area is a nuclear explosion safety zone" + 
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
			"\n  Waiting for the glide path to trigger a nuclear explosion" + 
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
			"\n  Chapter 1" + 
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
			"\n   " +		
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
			"\n  Road closure planks can only pass the button of the Black Pass route" +			
			"\n  Triggered at the same time, both sides must be defended to the final confluence point" +
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
			"\n  Trigger the shibboleth egg（1/1)" +			
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
			"\n  Hand-painted by: 港村村长" +			
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
			"\n             pixiv homepage" + 
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
			"\n    Difficulty: Normal" + 
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
			"\n    Difficulty: Difficult" + 
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
			"\n   Second week" + 
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
			"\n Unlock the new Bgm: Promise" + 
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
			"\n The process is all cleared" + 
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
			"\n Next is the transfer link, open the second week" + 
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
			"\n Tip: The level has no zombie thrust" + 
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
			"\n       Egg ending" + 
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
			"\n   True ending: Escape" + 
			"\n"
			
		theGameText.__KeyValueFromString("message",Text)
		EntFire(temp1,"Display", "", 0.10,  null)
		
	}
}