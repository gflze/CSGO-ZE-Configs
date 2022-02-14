//#####################################################################
//Patched version intended for use with GFL ze_surf_happy_b7 stripper
//Translates the map
//Install as csgo/scripts/vscripts/gfl/happy_patched.nut
//#####################################################################

s1 <- null;
s2 <- null;

function Msg2(){
	s1 = "Humanity"
	s2 = "Transmission after seconds"
	CountdownTimer(10);
}

function Msg3(){
	s1 = "cage"
	s2 = "Release in seconds"
    CountdownTimer2(15);
}

function Msg4(){
	s1 = "Defense"
	s2 = "Human teleport after seconds"
    CountdownTimer(60);
}

function Msg5(){
	s1 = "cage"
	s2 = "Liberated after seconds"
    CountdownTimer2(20);
}

function Msg6(){
	s1 = ""
	s2 = "Broken bridge after seconds"
    CountdownTimer(65);
}

function Msg7(){
	s1 = ""
	s2 = "Transmission starts in seconds"
    CountdownTimer2(20);
}

function Msg8(){
	s1 = ""
	s2 = "Collective teleportation in seconds"
    CountdownTimer2(30);
}

function Msg9(){
	s1 = ""
	s2 = "Collective teleportation in seconds"
    CountdownTimer2(40);
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
			"\n 《Happy Gliding》" + 
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
			"\n Author：港村村长" + 
			"\n  " +
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
			"\n Zombies can not take the secret passage" + 
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
			"\n Choose to brush your score on the side" + 
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
			"\n Second level: white room" + 
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
			"\n  Tip: You need to defend three zombie attack routes" + 
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
			"\n  Tip: The answer to the maze route is hidden under your feet" + 
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
			"\n  The third level: white and black" + 
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
			"\n       One side can not hold, the zombie will overtake" +
            "\n  Both roads need to go to the average person defense, the end of the rendezvous" +			
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

function MT22(){
	theGameText <- Entities.FindByName(null,"channel 4 maptext")
	if(theGameText != null)
	{
		local temp1 = theGameText.GetName();
		
		Text <- "\n" +
			"\n Unlock the new Bgm: Theme of Laura" + 
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
			"\n   Bad ending: dead end" + 
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