// Made by "Berke" "STEAM_1:0:95142811" for "ze_mapeadores_museum_v1", version 1.
// Prevents other people from using the trap button you are standing near.

iOrigin <- self.GetOrigin(), hClaimer <- null;

function Think()
{
	if (hClaimer)
	{
		if (!hClaimer.IsValid() || !hClaimer.GetHealth() || !IsEyePositionInRange(hClaimer))
		{
			hClaimer = null;

			FindAClaimer();
		}
	}

	else
		FindAClaimer();

	return 0;
}

function InputUse()
{
	return activator == hClaimer;
}

function FindAClaimer()
{
	local hPlayer;

	while (hPlayer = Entities.FindByClassname(hPlayer, "player"))
		if (hPlayer && hPlayer.GetTeam() == 2 && hPlayer.GetHealth() && IsEyePositionInRange(hPlayer))
		{
			hClaimer = hPlayer;

			break;
		}
}

function IsEyePositionInRange(hPlayer)
{
	local flPlayerEyePosition = hPlayer.EyePosition();

	if (abs(iOrigin.x - flPlayerEyePosition.x) <= 64 && abs(iOrigin.y - flPlayerEyePosition.y) <= 64 && abs(iOrigin.z - flPlayerEyePosition.z) <= 128)
		return true;

	return false;
}

function StopClaiming()
{
	self.__KeyValueFromString("thinkfunction", "");

	delete iOrigin;
	delete hClaimer;

	delete InputUse;
	delete Think;
	delete FindAClaimer;
	delete IsEyePositionInRange;
	delete StopClaiming;
}