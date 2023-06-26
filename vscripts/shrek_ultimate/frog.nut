function Touch()
{
	local vec1 = activator.GetVelocity()

	if (vec1.z < -400)
		activator.SetVelocity(Vector(vec1.x, vec1.y, 750));

	else if (vec1.z >= 0) 	
		activator.SetVelocity(Vector(vec1.x, vec1.y, 512));

	else
		activator.SetVelocity(Vector(vec1.x, vec1.y, 620));
}

function InitPitch()
{
	EntFireByHandle(caller, "Pitch", ""+(RandomInt(0, 1) ? RandomInt(75, 90) : RandomInt(115, 130)), 0, null, null);
}