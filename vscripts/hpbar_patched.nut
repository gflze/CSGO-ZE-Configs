dead <- false;
started <- false;
health <- 69;

function Start()
{
	started = true;
}

function AddHealth(hp)
{
	health += hp;
}

function Hit(hp)
{
	if (started && !dead)
	{
		health -= hp;
		if (health < 0)
		{
			health = 0;
		}

		ScriptPrintMessageCenterAll("<font color='#FF8080' class='fontSize-xl'>Microwave: " + health + " HP</font>");
	}

	if (health <= 0 && !dead)
	{
		EntFire("microwave_dead_relay", "Trigger", "", 0.0, null);
		dead = true;
	}
}