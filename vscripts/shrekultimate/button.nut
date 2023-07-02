function filter() 
{
	if (self.GetMoveParent().GetOwner() == activator)
		EntFireByHandle(self, "FireUser4", "", 0.0, activator, activator)
}