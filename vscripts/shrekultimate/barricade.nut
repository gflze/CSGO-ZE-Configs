MaxAlpha <- 220;
MinAlpha <- 100;
AlphaNow <- 100;
TickCountAlpha <- 10;
tickrate <- 0.1;
ticking <- true;
FullAlpha <- true;


function OnPostSpawn()
{
    Tick();
}
function Tick()
{
//    printl("AlphaNow"+AlphaNow);
	if (!ticking)
        return;
    if (!FullAlpha)
    {
        AlphaNow += TickCountAlpha;
        EntFireByHandle(self, "Alpha", "" + AlphaNow, 0,null,null);

        if(AlphaNow >= MaxAlpha)
            FullAlpha = true;
    }
    else
    {
        AlphaNow -= TickCountAlpha;
        EntFireByHandle(self, "Alpha", "" + AlphaNow, 0,null,null);
        if(AlphaNow <= MinAlpha)
            FullAlpha = false;
    }

    EntFireByHandle(self, "RunScriptCode", "Tick();", tickrate, null, null);
}
