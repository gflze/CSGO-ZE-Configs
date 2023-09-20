// By Berke "STEAM_0:0:95142811"

::strTemplateWildcard <- "&*",
::hManagerScriptScope <- this, hMapEntities <- array(3), UserIDQueuePlayers <- array(0), hPlayers <- array(0), SavedPlayerInfos <- array(0), ::bIsStage3Boss <- false, bDidZombiesSpawnOnStage5 <- false, bShouldTrackZombieDamage <- true,
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

	hEventListener.__KeyValueFromString("targetname", "");

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
	hMapEntities = array(3), bIsStage3Boss = false, bDidZombiesSpawnOnStage5 = false, bShouldTrackZombieDamage = true, CurrentPlayerInfos.hPlayer = null, CurrentPlayerInfos.iUserID = 0;

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
		foreach (hPlayer in hPlayers)
			if (hPlayer.GetTeam() == 2 && hPlayer.GetHealth() > 900  && hPlayer.GetName().find("zombie_") != 0)
				hPlayer.SetHealth(900);

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
	local hPlayer, bIsPlayerUnsaved = false;

	while (hPlayer = Entities.FindByClassname(hPlayer, "player"))
	{
		bIsPlayerUnsaved = true;

		foreach (hStoredPlayer in hPlayers)
			if (hPlayer == hStoredPlayer)
			{
				bIsPlayerUnsaved = false;

				break;
			}

		if (bIsPlayerUnsaved)
		{
			hPlayers.push(hPlayer);

			break;
		}
	}

	if (!bIsPlayerUnsaved)
	{
		hPlayer = null;

		while (hPlayer = Entities.FindByClassname(hPlayer, "cs_bot"))
		{
			bIsPlayerUnsaved = true;

			foreach (hStoredPlayer in hPlayers)
				if (hPlayer == hStoredPlayer)
				{
					bIsPlayerUnsaved = false;

					break;
				}

			if (bIsPlayerUnsaved)
			{
				hPlayers.push(hPlayer);

				break;
			}
		}
	}

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

	foreach (hPlayer in hPlayers)
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

function PlayerSay(EventData)
{
	if (rstrip(EventData.text).tolower() == "!showmapstats")
	{
		local iUserID = EventData.userid;

		foreach (SavedPlayerInfo in SavedPlayerInfos)
			if (SavedPlayerInfo.iUserID == iUserID)
			{
				local hPlayer = SavedPlayerInfo.hPlayer;
				
				if (hPlayer)
				{
					local strText = "Completed events: " + SavedPlayerInfo.iCompletedEvents;

					if (bDidZombiesSpawnOnStage5 && bShouldTrackZombieDamage && hPlayer.GetTeam() == 3 && hPlayer.GetHealth())
						strText += "\\nStage 5 damage: " + SavedPlayerInfo.iStage5Damage;

					PrintStatsText(hPlayer, strText);
				}

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
	EntFireByHandle(self, "CallScriptFunction", "RemoveDisconnectPlayer", -1, null, null);

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

function RemoveDisconnectPlayer()
{
	foreach (iOrder, hPlayer in hPlayers)
		if (!hPlayer.IsValid())
		{
			hPlayers.remove(iOrder);

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

					if (hPlayer && hPlayer.GetTeam() == 3)
					{
						local flOrigin = hPlayer.GetOrigin(), flOriginX = flOrigin.x, flOriginY = flOrigin.y;

						if (flOriginX >= -1024 && flOriginX <= 10240 && flOriginY >= -10240 && flOriginY <= 1024)
						{
							local strName = hPlayer.GetName();

							SavedPlayerInfo.iStage5Damage += strName == "human_mech" || strName == "driver1" ? EventData.dmg_health / 25 : EventData.dmg_health;
						}
					}

					break;
				}
	}
}

function PlayerCompletedEvent(Player = "")
{
	Player = (activator ? activator.GetClassname() == "player" : false) ? activator : Entities.FindByName(null, Player);

	if (Player && Player.GetTeam() == 3)
		foreach (SavedPlayerInfo in SavedPlayerInfos)
			if (SavedPlayerInfo.hPlayer == Player)
			{
				SavedPlayerInfo.iCompletedEvents++;

				PrintStatsText(Player, "You have completed an event!\\nCompleted events: " + SavedPlayerInfo.iCompletedEvents);

				break;
			}
}

function DiedOnStage5()
{
	if (activator.IsValid() && activator.GetTeam() == 3)
		foreach (SavedPlayerInfo in SavedPlayerInfos)
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

	EntFireByHandle(hStatsText, "AddOutput", "spawnflags " + (hPlayer ? 0 : 1), -1, null, null);

	EntFireByHandle(hStatsText, "RunScriptCode", "self.__KeyValueFromString(\"message\", \"" + strText + "\");", -1, null, null);

	EntFireByHandle(hStatsText, "Display", "", -1, hPlayer, null);
}

function CheckKnifeStrip(iItemType = 0)
{
	if (iItemType == 2 ? true : (iItemType ? (activator.GetTeam() == 3 ? true : false) : (activator.GetTeam() == 2 && activator.GetName().find("zombie_") != 0 ? true : false)))
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

		EntFireByHandle(hTakeDamageEntity, "AddOutput", "Damage " + iDamage, -1, null, null);

		EntFireByHandle(hTakeDamageEntity, "AddOutput", "DamageType " + iDamageType, -1, null, null);

		if (strKillIcon == "Default")
			strKillIcon = "point_hurt";

		EntFireByHandle(hTakeDamageEntity, "AddOutput", "classname " + strKillIcon, -1, null, null);

		local strOldTargetName = activator.GetName();

		EntFireByHandle(activator, "AddOutput", "targetname map1takedamagevictim1", -1, null, null);

		EntFireByHandle(hTakeDamageEntity, "Hurt", "", -1, Killer, null);

		EntFireByHandle(activator, "RunScriptCode", "if (self.IsValid() && self.GetName() == \"map1takedamagevictim1\") self.__KeyValueFromString(\"targetname\", \"" + strOldTargetName + "\");", -1, null, null);
	}
}

function PickLastManStanding()
{
	local PotentialSoloers = array(0), iPotentialSoloersLength = 0;

	for (local iLoopCount = 0; !iPotentialSoloersLength && iLoopCount < 2; iLoopCount++)
	{
		iPotentialSoloersLength = 0;

		PotentialSoloers.clear();

		foreach (SavedPlayerInfo in SavedPlayerInfos)
		{
			local hPlayer = SavedPlayerInfo.hPlayer;

			if (hPlayer.GetTeam() == 3 && hPlayer.GetHealth() > 0 && (!SavedPlayerInfo.bIsSoloBanned || iLoopCount))
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
						iTotalPoints = iStage5Damage + 150 * iCompletedEvents,
						iPlacement = 1
					});

					iPotentialSoloersLength++;
				}
			}
		}
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

			local iLuckBox = array(0);

			foreach (iOrder, PotentialSoloer in PotentialSoloers)
			{
				PotentialSoloer.iPlacement = iOrder + 1;

				local iRepeatAmount = 1;

				if (iOrder <= 14)
					switch (iOrder)
					{
						case 0:
						{
							iRepeatAmount = 5;

							break;
						}

						case 1:
						case 2:
						{
							iRepeatAmount = 4;

							break;
						}

						case 3:
						case 4:
						{
							iRepeatAmount = 3;

							break;
						}

						default:
							iRepeatAmount = 2;
					}

				for (local iSecondOrder = 0; iSecondOrder < iRepeatAmount; iSecondOrder++)
					iLuckBox.push(iOrder);
			}

			SoloPlayerInfo = PotentialSoloers[iLuckBox[RandomInt(0, iLuckBox.len() - 1)]];
		}

		local strName = SoloPlayerInfo.strName, iPlacement = SoloPlayerInfo.iPlacement;

		PrintStatsText(null, (strName == "" ? "A human" : "Human " + strName) + " has been chosen for the solo ending!\\nCompleted " + SoloPlayerInfo.iCompletedEvents + " events and did " + SoloPlayerInfo.iStage5Damage + " damage on stage 5.\\nResulting in " + SoloPlayerInfo.iTotalPoints + " points." + (iPotentialSoloersLength == 1 ? "" : "\\nPlaced " + iPlacement + GetOrdinalNumberSuffix(iPlacement) + " out of " + PotentialSoloers.len() + "."));

		local hSoloPlayer = SoloPlayerInfo.hPlayer;

		foreach (SavedPlayerInfo in SavedPlayerInfos)
			if (SavedPlayerInfo.hPlayer == hSoloPlayer)
			{
				SavedPlayerInfo.bIsSoloBanned = true;

				break;
			}

		local hExit = Entities.FindByName(null, "fuckedoffzombies");

		foreach (hPlayer in hPlayers)
			if (hPlayer.GetHealth())
			{
				if (hPlayer.GetTeam() == 3)
				{
					if (hPlayer != hSoloPlayer)
						EntFireByHandle(hPlayer, "SetHealth", "0", -1, null, null);
				}

				else
				{
					hPlayer.SetOrigin(hExit.GetOrigin());
					hPlayer.SetAngles(0, hExit.GetAngles().y, 0);
					hPlayer.SetVelocity(Vector());
				}
			}

		local hExits = array(0);

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

		foreach (hPlayer in hPlayers)
			if (hPlayer.GetTeam() == 3 && hPlayer.GetHealth())
				EntFireByHandle(hPlayer, "SetHealth", "0", -1, null, null);
	}
}

function SortSoloByTotalPoints(First, Second)
{
	local flFirstTotalPoint = First.iTotalPoints, flSecondTotalPoint = Second.iTotalPoints, iReturn = 0;

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
