counter <- 0;
maxtouch <- 4;

platphorm <- self.GetMoveParent();

function test() 
{
	counter++;
	if (counter == 1)
	{
		EntFireByHandle(platphorm, "Color", "255 128 64", 0, null, null);
	}
	if (counter >= maxtouch)
	{
		EntFireByHandle(platphorm, "Color", "255 0 0", 0, null, null);
		EntFireByHandle(platphorm, "Break", "", 0.6, null, null);
		EntFireByHandle(self, "kill", "", 0, null, null);
	}
}

//ломающие рандомно со временем
//только дамаг
//от 2х касаний