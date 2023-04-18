DoIncludeScript("kitchen/fly_functions", self.GetScriptScope());

target <- null;
dead <- false;
started <- false;
health <- 1000;
players_in_arena <- 0;
retarget <- 8;

previous_distance_to_target <- -1;
current_distance_to_target <- -1;

grabbed_player <- false;
grabbed_players <- [];
grabbed_players_dead <- [];
return_to_toaster <- false;
spawn_eggs <- false;
eggs_currently_spawned <- 0;
max_spawned_eggs <- 0;

speed <- 7;
rotation_speed <- 0.01;

ROTATION_SPEED_MIN <- 0.005;
ROTATION_SPEED_MAX <- 0.02;
ROTATION_SPEED_ACCELERATION <- 0.0001;
ROTATION_ERROR <- 0.03;
SPEED_ACCELERATION <- 0.05;
MAX_SPEED <- 15;
TOASTER_POSITION <- Vector(7063, 2329, -360);


function Start()
{
	max_spawned_eggs = players_in_arena / 6;
	started = true;
	EntFireByHandle(self, "SetAnimation", "fly", 0.00, null, null);
	EntFireByHandle(self, "RunScriptCode", " Tick();", 0.01, null, null);
}

function SetReturn(state)
{
	return_to_toaster = state;
}

function AddHealth(hp)
{
	health += hp;
	players_in_arena++;
}

function Hit()
{
	if (started && !dead)
	{
		health--;
		ScriptPrintMessageCenterAll("<font color='#FF8080' class='fontSize-xl'>Fly: " + health + " HP</font>");
	}

	if (health == 0 && !dead)
	{
		EntFire("fly_dead_relay", "Trigger", "", 0.0, null);
		dead = true;
		local flyPos = self.GetOrigin();
		TeleportGrabbedPlayers(Vector(flyPos.x, flyPos.y, flyPos.z+160));
		grabbed_player = false;
		grabbed_players.clear();
		speed = 0;
	}
}

function IsValidTarget()
{
	return IsValidPlayer(target) && !IsElementInArray(target, grabbed_players) && !IsElementInArray(target, grabbed_players_dead)
}


function Tick()
{
	local flyPos = self.GetOrigin();
	local distToFloor = TraceLine(flyPos, Vector(flyPos.x, flyPos.y, flyPos.z-300), self);

	/*****************************/
	/*** Stuff done every tick ***/
	/*****************************/

	/*** Grab a near player ***/
	local playerNear;
	if(!dead && (playerNear = Entities.FindByClassnameWithin(playerNear, "player", flyPos+self.GetForwardVector()*(80), 64)) != null && playerNear.GetTeam() == 3)
	{
		if(!IsElementInArray(playerNear, grabbed_players) && !IsElementInArray(playerNear, grabbed_players_dead))
		{
			grabbed_players.push(playerNear);
			grabbed_players_dead.push(playerNear);

			if ((target = GetNewTarget()) == null || !IsValidTarget())
				return_to_toaster = true;
			else if (!grabbed_player)
				EntFireByHandle(self, "RunScriptCode", "SetReturn(true)", 15.0, null, null);

			if (playerNear == target)
				target = null;

			grabbed_player = true;
		}
	}

	/*** Teleport grabbed players ***/
	if (!dead)
	{
		TeleportGrabbedPlayers(Vector(flyPos.x, flyPos.y, flyPos.z-40));
	}

	/*** Random chance to spawn an egg ***/
	if (!grabbed_player && eggs_currently_spawned != max_spawned_eggs && RandomInt(0, 500) == 0 && distToFloor > 0.1)
	{
		spawn_eggs = true;
	}

	/*************************/
	/*** Decide what to do ***/
	/*************************/

	/*** Fly died - fall to the ground ***/
	if (dead)
	{

		if (distToFloor < 0.05)
		{
			EntFire("fly_dead", "RunScriptCode", "TeleportToFly();", 0.00, null);
			EntFire("fly", "kill", "", 0.02, null);
		}
		else
		{
			MoveDir(Vector(0, 0, -1));
			EntFireByHandle(self, "RunScriptCode", " Tick() ", 0.01, null, null);
		}
	}

	/*** Move to the floor to spawn eggs ***/
	else if (!grabbed_player && spawn_eggs && eggs_currently_spawned < max_spawned_eggs && distToFloor < 1.0 && speed < MAX_SPEED / 2)
	{
		spawn_eggs = false;
		eggs_currently_spawned++;
		local eggSpawner;
		eggSpawner = Entities.FindByName(eggSpawner, "fly_egg_maker");
		eggSpawner.SpawnEntityAtLocation(flyPos, Vector(0,0,0));
		EntFireByHandle(self, "RunScriptCode", " Tick() ", 0.01, null, null);
	}

	/*** Move towards a targetted player ***/
	else if(!return_to_toaster && IsValidPlayer(target))
	{
		ChasePlayer(flyPos);
		EntFireByHandle(self, "RunScriptCode", " Tick()", 0.01, null, null);
	}

	/*** Take the grabbed player(s) above the toaster ***/
	else if(return_to_toaster)
	{
		// Fast approx of distance without needing sqrt
		current_distance_to_target = fabs(TOASTER_POSITION.x - flyPos.x) + fabs(TOASTER_POSITION.y - flyPos.y);

		local distToToaster = Vector(flyPos.x - TOASTER_POSITION.x, flyPos.y - TOASTER_POSITION.y, flyPos.z - TOASTER_POSITION.z);
		if (fabs(distToToaster.x) < 80 && fabs(distToToaster.y) < 80 && fabs(distToToaster.z) < 80)
		{
			grabbed_player = false;
			return_to_toaster = false;
			grabbed_players.clear();
			previous_distance_to_target = -1;
		}
		else
		{
			MoveTowardsTarget(flyPos, TOASTER_POSITION);
			previous_distance_to_target = current_distance_to_target;
		}
		EntFireByHandle(self, "RunScriptCode", " Tick()", 0.01, null, null);
	}

	/*** Search for a target player ***/
	else
	{
		target = GetNewTarget();
		if (!IsValidTarget())
			target = null;

		if (target == null && TraceLine(flyPos, Vector(flyPos.x, flyPos.y, flyPos.z+100), self) >= 1.0)
			MoveDir(Vector(0, 0, 1));

		EntFireByHandle(self, "RunScriptCode", " Tick()", 0.01, null, null);
	}


}

function MoveTowardsTarget(fly, target)
{
	local targetDir = Vector(target.x - fly.x, target.y - fly.y, target.z - fly.z);
	local length = targetDir.Norm();
	local currentDir = self.GetForwardVector();
	local dir = GetNewDir(targetDir, currentDir);
	self.SetForwardVector(Vector(dir.x, dir.y, targetDir.z));
	MoveForward(60, 170);
}

function IncrementEggCount(count)
{
	eggs_currently_spawned += count;
}
