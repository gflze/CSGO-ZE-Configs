// By Berke "STEAM_0:0:95142811"

::strTemplateWildcard <- "&*",
::hManagerScriptScope <- this, hMapEntities <- [null, null, null], UserIDQueuePlayers <- [], SavedPlayerInfos <- [], ::bIsStage3Boss <- false, bDidZombiesSpawnOnStage5 <- false, bShouldTrackZombieDamage <- true,
CurrentPlayerInfos <-
{
	hPlayer = null,
	iUserID = 0
},
::__ <- " ",
::_ <- delegate
{
	function _get(strKey)
	{
		return strKey;
	}
}
: {};

local hEventListener;

while (hEventListener = Entities.FindByName(hEventListener, "map1eventlistener*"))
{
	hEventListener.__KeyValueFromString("classname", "info_ladder");

	local strEventName = "Player";

	switch (hEventListener.GetName().slice(17).tointeger())
	{
		case 1:
		{
			strEventName += "Connect";

			break;
		}

		case 2:
		{
			strEventName += "Activate";

			break;
		}

		case 3:
		{
			strEventName += "Say";

			break;
		}

		case 4:
		{
			strEventName += "Info";

			break;
		}

		case 5:
		{
			strEventName += "Disconnect";

			break;
		}

		case 6:
			strEventName += "ZombieHurt";
	}

	hEventListener.__KeyValueFromString("targetname", "map1registeredeventlistener1");

	hEventListener.ValidateScriptScope();

	local hScriptScope = hEventListener.GetScriptScope();

	hScriptScope.strEventName <- strEventName;

	delegate
	{
		function _newslot(strKey, Values)
		{
			hManagerScriptScope[strEventName](Values);
		}
	}
	: hScriptScope;
}

EntFireByHandle(self, "FireUser1", "", -1, null, null);

function RoundSpawn()
{
	hMapEntities = [null, null, null], bIsStage3Boss = false, bDidZombiesSpawnOnStage5 = false, bShouldTrackZombieDamage = true, CurrentPlayerInfos.hPlayer = null, CurrentPlayerInfos.iUserID = 0;

	UserIDQueuePlayers.clear();

	local hEventListener;

	while (hEventListener = Entities.FindByName(hEventListener, "map1eventlistener*"))
		hEventListener.Destroy();

	foreach (SavedPlayerInfo in SavedPlayerInfos)
		SavedPlayerInfo.iStage5Damage = 0;
}

function Think()
{
	if (UserIDQueuePlayers.len())
	{
		local UserIDQueuePlayerFirst = UserIDQueuePlayers.remove(0), hUserIDQueuePlayerFirst = UserIDQueuePlayerFirst.hPlayer;

		CurrentPlayerInfos.hPlayer = hUserIDQueuePlayerFirst, CurrentPlayerInfos.iUserID = UserIDQueuePlayerFirst.iUserID;

		EntFireByHandle(GetUserIDEventGenerator(), "GenerateGameEvent", "", -1, hUserIDQueuePlayerFirst, null);
	}

	if (bDidZombiesSpawnOnStage5)
	{
		local hPlayer;

		while (hPlayer = Entities.FindByClassname(hPlayer, "player"))
			if (hPlayer.GetTeam() == 2 && hPlayer.GetHealth() > 900)
				hPlayer.SetHealth(900);

		hPlayer = null;

		while (hPlayer = Entities.FindByClassname(hPlayer, "cs_bot"))
			if (hPlayer.GetTeam() == 2 && hPlayer.GetHealth() > 900)
				hPlayer.SetHealth(900);
	}

	return -1;
}

function PlayerConnect(EventData)
{
	local strSteamID = EventData.networkid;

	if (strSteamID == "BOT")
		SavedPlayerInfos.push(
		{
			hPlayer = null,
			strName = EventData.name,
			iUserID = EventData.userid,
			strSteamID = "",
			iCompletedEvents = 0,
			iStage5Damage = 0,
			bIsSoloBanned = false
		});

	else
	{
		strSteamID = strSteamID.slice(8);

		local bIsPlayerInfoUnsaved = true;

		foreach (SavedPlayerInfo in SavedPlayerInfos)
			if (SavedPlayerInfo.strSteamID == strSteamID)
			{
				SavedPlayerInfo.strName = EventData.name, SavedPlayerInfo.iUserID = EventData.userid, bIsPlayerInfoUnsaved = false;

				break;
			}

		if (bIsPlayerInfoUnsaved)
			SavedPlayerInfos.push(
			{
				hPlayer = null,
				strName = EventData.name,
				iUserID = EventData.userid,
				strSteamID = strSteamID,
				iCompletedEvents = 0,
				iStage5Damage = 0,
				bIsSoloBanned = false
			});
	 }
}

function PlayerActivate(EventData)
{
	local iUserID = EventData.userid, bIsPlayerUnregistered = true;

	foreach (SavedPlayerInfo in SavedPlayerInfos)
		if (SavedPlayerInfo.iUserID == iUserID)
		{
			bIsPlayerUnregistered = false;

			break;
		}

	if (bIsPlayerUnregistered)
		SavedPlayerInfos.push(
		{
			hPlayer = null,
			strName = "",
			iUserID = EventData.userid,
			strSteamID = "",
			iCompletedEvents = 0,
			iStage5Damage = 0,
			bIsSoloBanned = false
		});

	bIsPlayerUnregistered = true;

	local hPlayer;

	while (hPlayer = Entities.FindByClassname(hPlayer, "player"))
	{
		bIsPlayerUnregistered = true;

		foreach (SavedPlayerInfo in SavedPlayerInfos)
			if (SavedPlayerInfo.hPlayer == hPlayer)
			{
				bIsPlayerUnregistered = false;

				break;
			}

		if (bIsPlayerUnregistered)
		{
			UserIDQueuePlayers.push(
			{
				hPlayer = hPlayer,
				iUserID = EventData.userid
			});

			break;
		}
	}

	if (!bIsPlayerUnregistered)
	{
		hPlayer = null;

		while (hPlayer = Entities.FindByClassname(hPlayer, "cs_bot"))
		{
			bIsPlayerUnregistered = true;

			foreach (SavedPlayerInfo in SavedPlayerInfos)
				if (SavedPlayerInfo.hPlayer == hPlayer)
				{
					bIsPlayerUnregistered = false;

					break;
				}

			if (bIsPlayerUnregistered)
			{
				UserIDQueuePlayers.push(
				{
					hPlayer = hPlayer,
					iUserID = EventData.userid
				});

				break;
			}
		}
	}
}

function PlayerSay(EventData)
{
	if (rstrip(EventData.text).tolower() == "!showmapstats")
	{
		local iUserID = EventData.userid;

		foreach (SavedPlayerInfo in SavedPlayerInfos)
			if (SavedPlayerInfo.iUserID == iUserID)
			{
				local hPlayer = SavedPlayerInfo.hPlayer, strText = "Completed events: " + SavedPlayerInfo.iCompletedEvents;

				if (bDidZombiesSpawnOnStage5 && bShouldTrackZombieDamage && hPlayer.GetTeam() == 3 && hPlayer.GetHealth())
					strText += "\n Stage 5 damage: " + SavedPlayerInfo.iStage5Damage;

				PrintStatsText(SavedPlayerInfo.hPlayer, strText);

				break;
			}
	}
}

function PlayerInfo(EventData)
{
	if (CurrentPlayerInfos.iUserID)
	{
		foreach (SavedPlayerInfo in SavedPlayerInfos)
			if (SavedPlayerInfo.iUserID == CurrentPlayerInfos.iUserID)
			{
				SavedPlayerInfo.hPlayer = CurrentPlayerInfos.hPlayer;

				break;
			}

		if (!UserIDQueuePlayers.len())
			CurrentPlayerInfos.hPlayer = null, CurrentPlayerInfos.iUserID = 0;
	}
}

function PlayerDisconnect(EventData)
{
	local iUserID = EventData.userid;

	foreach (iOrder, UserIDQueuePlayer in UserIDQueuePlayers)
		if (UserIDQueuePlayer.iUserID == iUserID)
		{
			UserIDQueuePlayers.remove(iOrder);

			break;
		}

	foreach (iOrder, SavedPlayerInfo in SavedPlayerInfos)
		if (SavedPlayerInfo.iUserID == iUserID)
		{
			if (SavedPlayerInfo.strSteamID == "")
				SavedPlayerInfos.remove(iOrder);

			else
				SavedPlayerInfo.strName = "", SavedPlayerInfo.iUserID = 0, SavedPlayerInfo.hPlayer = null;

			break;
		}
}

function PlayerZombieHurt(EventData)
{
	if (bDidZombiesSpawnOnStage5 && bShouldTrackZombieDamage)
	{
		local iAttackerUserID = EventData.attacker;

		if (iAttackerUserID)
			foreach (SavedPlayerInfo in SavedPlayerInfos)
				if (SavedPlayerInfo.iUserID == iAttackerUserID)
				{
					local hPlayer = SavedPlayerInfo.hPlayer;

					if (hPlayer.GetTeam() == 3)
					{
						local flOrigin = hPlayer.GetOrigin(), flOriginX = flOrigin.x, flOriginY = flOrigin.y;

						if (flOriginX >= -1024 && flOriginX <= 10240 && flOriginY >= -10240 && flOriginY <= 1024)
						{
							local strName = hPlayer.GetName();

							SavedPlayerInfo.iStage5Damage += strName == "human_mech" || strName == "driver1" ? EventData.dmg_health / 10 : EventData.dmg_health;
						}
					}

					break;
				}
	}
}

function PlayerCompletedEvent(hPlayer = null)
{
	if (!hPlayer)
		hPlayer = activator;

	if (hPlayer && hPlayer.GetTeam() == 3)
		foreach (SavedPlayerInfo in SavedPlayerInfos)
			if (SavedPlayerInfo.hPlayer == hPlayer)
			{
				SavedPlayerInfo.iCompletedEvents++;

				PrintStatsText(activator, "You have completed an event!\nCompleted events: " + SavedPlayerInfo.iCompletedEvents);

				break;
			}
}

function DiedOnStage5()
{
	if (activator.IsValid() && activator.GetTeam() == 3)
		foreach(SavedPlayerInfo in SavedPlayerInfos)
			if (SavedPlayerInfo.hPlayer == activator)
			{
				if (bShouldTrackZombieDamage)
					SavedPlayerInfo.iStage5Damage = 0;

				break;
			}
}

function StopTrackingZombieDamage()
{
	bShouldTrackZombieDamage = false;

	foreach (SavedPlayerInfo in SavedPlayerInfos)
		SavedPlayerInfo.iStage5Damage = 0;
}

function Stage5Ended()
{
	foreach (SavedPlayerInfo in SavedPlayerInfos)
		SavedPlayerInfo.iCompletedEvents = 0, SavedPlayerInfo.bIsSoloBanned = false;
}

function PrintStatsText(hPlayer, strText)
{
	local hStatsText = GetStatsText();

	hStatsText.__KeyValueFromInt("spawnflags", hPlayer ? 0 : 1);

	hStatsText.__KeyValueFromString("message", strText);

	EntFireByHandle(hStatsText, "Display", "", -1, hPlayer, null);
}

function CheckKnifeStrip(iItemType = 0)
{
	local bCanStrip = false;

	if (iItemType != 2)
	{
		if (!iItemType)
		{
			if (activator.GetTeam() == 2 && activator.GetName().find("zombie_") != 0)
				bCanStrip = true;
		}

		else if (activator.GetTeam() == 3)
				bCanStrip = true;
	}

	else
		bCanStrip = true;

	if (bCanStrip)
		for (local hKnife = activator.FirstMoveChild(); hKnife; hKnife = hKnife.NextMovePeer())
			if (hKnife.GetClassname() == "weapon_knife")
			{
				if (!hKnife.FirstMoveChild())
					hKnife.Destroy();

				break;
			}
}

function TakeDamage(iDamage, iDamageType, strKillIcon = "Default", Killer = "Owner")
{
	if (typeof Killer == "string")
		Killer = Killer == "Owner" ? caller.GetMoveParent().GetOwner() : Entities.FindByName(null, Killer);

	if (!Killer || activator.GetTeam() == Killer.GetTeam())
	{
		local iNewHealth = activator.GetHealth() - iDamage;

		EntFireByHandle(activator, "SetHealth", iNewHealth < 0 ? "0" : iNewHealth.tostring(), -1, null, null);
	}

	else
	{
		local hTakeDamageEntity = GetTakeDamageEntity();

		hTakeDamageEntity.__KeyValueFromInt("Damage", iDamage);

		hTakeDamageEntity.__KeyValueFromInt("DamageType", iDamageType);

		if (strKillIcon == "Default")
			strKillIcon = "point_hurt";

		hTakeDamageEntity.__KeyValueFromString("classname", strKillIcon);

		local strOldName = activator.GetName();

		activator.__KeyValueFromString("targetname", "map1takedamagevictim1");

		EntFireByHandle(hTakeDamageEntity, "Hurt", "", -1, Killer, null);

		EntFireByHandle(activator, "RunScriptCode", "if (self.IsValid() && self.GetName() == \"map1takedamagevictim1\") EntFireByHandle(self, \"AddOutput\", \"targetname " + strOldName + "\", -1, null, null);", -1, null, null);
	}
}

function PickLastManStanding()
{
	local PotentialSoloers = [], iPotentialSoloersLength = 0, iLoopCount = 0;

	while (!iPotentialSoloersLength && iLoopCount < 2)
	{
		PotentialSoloers.clear();

		foreach (SavedPlayerInfo in SavedPlayerInfos)
		{
			local hPlayer = SavedPlayerInfo.hPlayer;

			if (hPlayer.GetTeam() == 3)
			{
				local bCanSolo = true;

				if (!SavedPlayerInfo.bIsSoloBanned || iLoopCount)
				{
					local flOrigin = hPlayer.GetOrigin(), flOriginX = flOrigin.x, flOriginY = flOrigin.y;

					if (flOriginX >= -1024 && flOriginX <= 10240 && flOriginY >= -10240 && flOriginY <= 1024 && flOrigin.z >= 12288)
					{
						local iStage5Damage = SavedPlayerInfo.iStage5Damage, iCompletedEvents = SavedPlayerInfo.iCompletedEvents;

						PotentialSoloers.push(
						{
							hPlayer = SavedPlayerInfo.hPlayer,
							strName = SavedPlayerInfo.strName,
							iCompletedEvents = iCompletedEvents,
							iStage5Damage = iStage5Damage,
							flTotalPoints = iStage5Damage + iStage5Damage / 25.0 * iCompletedEvents,
							iPlacement = 1,
						});
					}
				}
			}
		}

		iLoopCount++, iPotentialSoloersLength = PotentialSoloers.len();
	}

	StopTrackingZombieDamage();

	if (iPotentialSoloersLength)
	{
		local SoloPlayerInfo = {};

		if (iPotentialSoloersLength == 1)
			SoloPlayerInfo = PotentialSoloers[0];

		else
		{
			PotentialSoloers.sort(SortSoloByTotalPoints);

			local LuckBox = [];
			
			foreach (iOrder, PotentialSoloer in PotentialSoloers)
			{
				PotentialSoloer.iPlacement = iOrder + 1;

				local iRepeatAmount = 1;

				if (!iOrder)
					iRepeatAmount = 5;

				else if (iOrder == 1 || iOrder == 2)
					iRepeatAmount = 4;
					
				else if (iOrder == 3 || iOrder == 4)
					iRepeatAmount = 3;
					
				else if (iOrder > 4 || iOrder <= 14)
					iRepeatAmount = 2;

				local iSecondOrder = 0;

				while (iSecondOrder < iRepeatAmount)
				{
					LuckBox.push(PotentialSoloer)

					iSecondOrder++;
				}

				SoloPlayerInfo = LuckBox[RandomInt(0, LuckBox.len() - 1)];
			}
		}

		local strName = SoloPlayerInfo.strName, iPlacement = SoloPlayerInfo.iPlacement;

		PrintStatsText(null, (strName == "" ? "A player" : "Player " + strName) + " has been chosen for the solo ending!\nCompleted " + SoloPlayerInfo.iCompletedEvents + " events and did " + SoloPlayerInfo.iStage5Damage + " damage on stage 5.\nResulting in " + SoloPlayerInfo.flTotalPoints + " points." + (iPotentialSoloersLength == 1 ? "" : "\nPlaced " + iPlacement + GetOrdinalNumberSuffix(iPlacement) + " out of " + PotentialSoloers.len() + "."));

		local hSoloPlayer = SoloPlayerInfo.hPlayer;

		foreach (SavedPlayerInfo in SavedPlayerInfos)
			if (SavedPlayerInfo.hPlayer == hSoloPlayer)
			{
				SavedPlayerInfo.bIsSoloBanned = true;

				break;
			}

		local hPlayer;

		while (hPlayer = Entities.FindByClassname(hPlayer, "player"))
			if (hPlayer != hSoloPlayer)
				EntFireByHandle(hPlayer, "SetHealth", "0", -1, null, null);

		hPlayer = null;

		while (hPlayer = Entities.FindByClassname(hPlayer, "cs_bot"))
			if (hPlayer != hSoloPlayer)
				EntFireByHandle(hPlayer, "SetHealth", "0", -1, null, null);

		local hExits = [], hExit;

		while (hExit = Entities.FindByName(hExit, "last_man_standing_tpdest"))
			hExits.push(hExit);

		hExit = hExits[RandomInt(0, hExits.len() - 1)];

		hSoloPlayer.SetOrigin(hExit.GetOrigin());
		hSoloPlayer.SetAngles(0, hExit.GetAngles().y, 0);
		hSoloPlayer.SetVelocity(Vector());
	}

	else
	{
		PrintStatsText(null, "No valid players were found, no one gets the solo!");

		local hPlayer;

		while (hPlayer = Entities.FindByClassname(hPlayer, "player"))
			EntFireByHandle(hPlayer, "SetHealth", "0", -1, null, null);

		hPlayer = null;

		while (hPlayer = Entities.FindByClassname(hPlayer, "cs_bot"))
			EntFireByHandle(hPlayer, "SetHealth", "0", -1, null, null);
	}
}

function SortSoloByTotalPoints(First, Second)
{
	local flFirstTotalPoint = First.flTotalPoints, flSecondTotalPoint = Second.flTotalPoints, iReturn = 0;

	if (flFirstTotalPoint > flSecondTotalPoint)
		iReturn = -1;

	else if (flFirstTotalPoint < flSecondTotalPoint)
		iReturn = 1;

	return iReturn;
}

function GetOrdinalNumberSuffix(iNumber)
{
	local strSuffix = "th";

	if (iNumber <= 3 || iNumber > 20)
		switch (iNumber % 10)
		{
			case 1:
			{
				strSuffix = "st";

				break;
			}

			case 2:
			{
				strSuffix = "nd";

				break;
			}

			case 3:
				strSuffix = "rd";
		}

	return strSuffix;
}

function GetTakeDamageEntity()
{
	return GetEntity(0, "takedamage1");
}

function GetStatsText()
{
	return GetEntity(1, "statstext1");
}

function GetUserIDEventGenerator()
{
	return GetEntity(2, "eventgenerator1");
}

function GetEntity(iOrder, strName)
{
	return hMapEntities[iOrder] ? hMapEntities[iOrder] : hMapEntities[iOrder] = Entities.FindByName(null, "map1" + strName);
}