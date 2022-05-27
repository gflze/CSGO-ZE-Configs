iStage <- 1;
flMarathonNeededCTCount <- 0.0;
iMarathonCurrentCTCount <- 0;
iMarathonSavedCT <- [];

::iPlayerUserID <- [];
::iPlayerHandle <- [];
::iMapperUserID <- [null, null, null];
::strMapperName <- [null, null, null];
::iCurrentPlayerHandle <- null;

EntFire("server", "Command", "mp_roundtime 15");

function NewRound()
{
	flMarathonNeededCTCount = 0.0;
	iMarathonCurrentCTCount = 0;
	iMarathonSavedCT.clear();
	iPlayerUserID.clear();
	iPlayerHandle.clear();

	EntFire("stage" + iStage + "_relay", "Trigger");

	local iPlayer = null;
	local flDelay = 0.00;

	while ((iPlayer = Entities.FindByClassname(iPlayer, "player")) != null)
	{
		EntFire("map1manager1", "RunScriptCode", "iCurrentPlayerHandle = activator", flDelay, iPlayer);
		EntFire("map1eventgenerator1", "GenerateGameEvent", "", flDelay, iPlayer);

		flDelay += 0.02;
	}

	EntFire("map1manager1", "RunScriptCode", "CheckMapper()", flDelay);
}

function SetStage(stage)
{
	iStage = stage;

	switch (stage)
	{
		case 1:
		case 2:
		case 3:
		{
			EntFire("server", "Command", "mp_roundtime 15");

			break;
		}

		case 4:
		{
			EntFire("server", "Command", "mp_roundtime 5");

			break;
		}

		case 5:
			EntFire("server", "Command", "mp_roundtime 45");
	}
}

::SetStageMessage <- function(mapperid, stage)
{
	EntFire("server", "Command", "say ***" + strMapperName[mapperid] + " has set the map to " + stage + "!***");
}

function CheckMapper()
{
	local iPosition = 0;

	foreach (playeruserid in iPlayerUserID)
	{
		switch (playeruserid)
		{
			case iMapperUserID[0]:
			{
				MapperTag(iPlayerHandle[iPosition], 1);

				break;
			}

			case iMapperUserID[1]:
			{
				MapperTag(iPlayerHandle[iPosition], 2);

				break;
			}

			case iMapperUserID[2]:
				MapperTag(iPlayerHandle[iPosition], 3);
		}

		iPosition++;
	}
}

function MapperTag(mapperid, tag)
{
	local iMapperTag = "mappertag" + tag;

	EntFire(iMapperTag, "SetParent", "!activator", 0, mapperid);
	EntFire(iMapperTag, "SetParentAttachment", "facemask", 0);
}

function CheckAdminRoomAccess()
{
	local iPosition1 = 0;

	foreach (playerhandle in iPlayerHandle)
	{
		if (playerhandle == activator)
		{
			local iPosition2 = 0;

			foreach (mapperuserid in iMapperUserID)
			{
				if (iPlayerUserID[iPosition1] == mapperuserid)
					EnterAdminRoom(iPosition2);

				iPosition2++;
			}
		}

		iPosition1++;
	}
}

::EnterAdminRoom <- function(mapperid, handle = 0)
{
	if (!handle)
		EntFire("admin_dest", "Teleport", "", 0, activator);

	else
		EntFire("admin_dest", "Teleport", "", 0, handle);

	EntFire("server", "Command", "say ***" + strMapperName[mapperid] + " has entered the Admin Room!***");
}

function KillTeam(team)
{
	if (team == 1)
	{
		EntFire("player", "SetHealth", "-1");
		EntFire("map1tkiller1", "Enable");
	}
	else
	{
		local iPlayer = null;

		while ((iPlayer = Entities.FindByClassname(iPlayer, "player")) != null)
			if (iPlayer.GetTeam() == team && iPlayer.GetHealth() > 0)
				EntFireByHandle(iPlayer, "SetHealth", "-1", 0.0, null, null);

		if (team == 2)
			EntFire("map1tkiller1", "Enable");
	}
}

function HealCT(stage)
{
	local iPlayer = null;
	local iExtraHealth = stage * 50;

	while ((iPlayer = Entities.FindByClassname(iPlayer, "player")) != null)
		if (iPlayer.GetTeam() == 3 && iPlayer.GetHealth() > 0)
		{
			local iNewHealth = iPlayer.GetHealth() + iExtraHealth;

			EntFireByHandle(iPlayer, "AddOutput", "health " + iNewHealth, 0, null, null);
			iPlayer.SetHealth(iNewHealth);
		}

	EntFire("server", "Command", "say ***Humans have been awarded with extra " + iExtraHealth + " health for winning the Stage " + stage + " in Marathon Mode!***");
}

function MarathonCountCT()
{
	EntFire("server", "Command", "say ***Want to skip to Marathon Mode? You can step on this plate!***");

	local iPlayer = null;

	while ((iPlayer = Entities.FindByClassname(iPlayer, "player")) != null)
		if (iPlayer.GetTeam() == 3 && iPlayer.GetHealth() > 0)
			flMarathonNeededCTCount++;

	flMarathonNeededCTCount = ((flMarathonNeededCTCount / 10) * 8).tointeger();

	if (flMarathonNeededCTCount < 1)
		flMarathonNeededCTCount = 1;

	EntFire("marathon1text1", "AddOutput", "message 0/" + flMarathonNeededCTCount);
}

function MarathonCheck()
{
	foreach (marathonsavedct in iMarathonSavedCT)
		if (marathonsavedct == activator)
			return;

	iMarathonSavedCT.push(activator);

	iMarathonCurrentCTCount++;

	EntFire("maranoise", "PlaySound");

	EntFire("marathon1text1", "AddOutput", "message " + iMarathonCurrentCTCount + "/" + flMarathonNeededCTCount);

	if (iMarathonCurrentCTCount >= flMarathonNeededCTCount)
	{
		caller.Destroy();
		EntFire("marathon1timer1", "Enable");
		EntFire("server", "Command", "say ***Marathon Mode has been activated!***");
		EntFire("map1manager1", "RunScriptCode", "SetStage(5)", 4);
		EntFire("tension", "StopSound");
		EntFire("maranoise2", "PlaySound");
		EntFire("map1manager1", "RunScriptCode", "KillTeam(1)", 4);
		EntFire("maranoise2", "StopSound", "", 12);
	}
}

function ApplyScoreCT(score)
{
	local iPlayer = null;

	while ((iPlayer = Entities.FindByClassname(iPlayer, "player")) != null)
		if (iPlayer.GetTeam() == 3 && iPlayer.GetHealth() > 0)
			EntFire("map1score" + score, "ApplyScore", "", 0, iPlayer);

	if (score)
		EntFire("server", "Command", "say ***Humans have been awarded with 100 kills for beating the Marathon Mode!***");

	else
		EntFire("server", "Command", "say ***Humans have been awarded with 500 kills for beating the Marathon Mode with the Secret Laser Boss!***");
}

function BossHealthScale(bossnumber, hpperct)
{
	local iPlayer = null;
	local iCTAmount = 0;

	while ((iPlayer = Entities.FindByClassname(iPlayer, "player")) != null)
		if (iPlayer.GetTeam() == 3 && iPlayer.GetHealth() > 0)
			iCTAmount++;

	EntFire("ze_map_boss_bar_boss" + bossnumber, "AddHealth", (hpperct * iCTAmount).tostring());
}