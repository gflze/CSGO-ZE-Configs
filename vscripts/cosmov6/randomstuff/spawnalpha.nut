function Spawn(time)
{
    time = 0.00 + time;
    local startalpha = 0;
    local alpha = 5;
    local ticks = 250 / alpha;
    local ntime = time / ticks;

    EntFireByHandle(self, "alpha", "0", 0, null, null);
    EntFireByHandle(self, "Enable", "", 0.01, null, null);

    for(local i = 0; i < ticks; i++)
    {
        EntFireByHandle(self, "alpha", "" + startalpha, (i * ntime) + 0.02, null, null);
        startalpha += alpha;
    }
    EntFireByHandle(self, "alpha", "" + 255, time + 0.02, null, null);
}

function Hide(time)
{
    time = 0.00 + time;
    local startalpha = 255;
    local alpha = 5;
    local ticks = 250 / alpha;
    local ntime = time / ticks;

    for(local i = 0; i < ticks; i++)
    {
        EntFireByHandle(self, "alpha", "" + startalpha, (i * ntime) + 0.02, null, null);
        startalpha -= alpha;
    }
    EntFireByHandle(self, "Disable", "", time + 0.02, null, null);
}

function Kill(time)
{
    time = 0.00 + time;
    local startalpha = 255;
    local alpha = 5;
    local ticks = 250 / alpha;
    local ntime = time / ticks;

    for(local i = 0; i < ticks; i++)
    {
        EntFireByHandle(self, "alpha", "" + startalpha, (i * ntime) + 0.02, null, null);
        startalpha -= alpha;
    }
    EntFireByHandle(self, "kill", "", time + 0.02, null, null);
}