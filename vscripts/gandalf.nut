//original idea/implementation by hestia
//script implementation by vauff

LIGHT_COOLDOWN <- "Light Ready!";
PUSH_COOLDOWN <- "Push Ready!";

function UpdateCooldowns()
{
	EntFireByHandle(self, "SetText", LIGHT_COOLDOWN + "\n" + PUSH_COOLDOWN, 0.00, null, null);
}

function PushCooldown(seconds)
{
	if (seconds != 0)
	{
		PUSH_COOLDOWN = "Push Cooldown - " + seconds.tostring() + "s";
		EntFireByHandle(self, "RunScriptCode", "PushCooldown(" + (seconds - 1).tostring() + ");", 1.00, null, null);
	}
	else
	{
		PUSH_COOLDOWN = "Push Ready!";
	}
}

function LightCooldown(seconds)
{
	if (seconds != 0)
	{
		LIGHT_COOLDOWN = "Light Cooldown - " + seconds.tostring() + "s";
		EntFireByHandle(self, "RunScriptCode", "LightCooldown(" + (seconds - 1).tostring() + ");", 1.00, null, null);
	}
	else
	{
		LIGHT_COOLDOWN = "Light Ready!";
	}
}