GlobalTimer <- [];
ticking <- false;

function Start()
{
    for(local i = 1; i <= 6; i++)
    {
        GlobalTimer.push(Entities.FindByName(null, "GlobalTimerChange_" + i));
    }
    GlobalTimer.reverse();

    ticking = true;
    TickGlobalTimer();
}

function TickGlobalTimer()
{
    if(!ticking)
        return;
    local nTime = Time();

    local h = ((nTime / 3600) % 60).tointeger();
    local m = ((nTime / 60) % 60).tointeger();
    local s = (nTime % 60).tointeger();

    local lim = 10;
	local temp_num = h.tointeger();

    local set

	for (local i = 4; i <= 5; i++)
	{
		set = (temp_num % lim) + "";

        EntFireByHandle(GlobalTimer[i], "SetMaterialVar", set, 0, null, null);

		temp_num = temp_num / lim;
	}

    temp_num = m.tointeger();

	for (local i = 2; i <= 3; i++)
	{
		set = (temp_num % lim) + "";

        EntFireByHandle(GlobalTimer[i], "SetMaterialVar", set, 0, null, null);

		temp_num = temp_num / lim;
	}

    temp_num = s.tointeger();

	for (local i = 0; i <= 1; i++)
	{
		set = (temp_num % lim) + "";

        EntFireByHandle(GlobalTimer[i], "SetMaterialVar", set, 0, null, null);

		temp_num = temp_num / lim;
	}

    EntFireByHandle(self, "RunScriptCode", "TickGlobalTimer();", 1, null, null);
}
