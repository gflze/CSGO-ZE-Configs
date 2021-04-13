//#####################################################################
//Patched version intended for use with GFL ze_tyranny_v5_2k3 stripper
//Removes HTML formatting broken after Shattered Web Update.
//Install as csgo/scripts/vscripts/gfl/hud_killer_patched.nut
//#####################################################################

Tick <- true;
i <- 0;
a <- 0;
sa <- 0;
maxa <- 0;
b <- 0;

function Start(count, param01)
{
    Tick = true;
    a = count;
    sa = count;
    maxa = count;
    b = param01
    Ticking();
}

function Ticking()
{
    if(Tick)
    {
        if(i == maxa && b == 0){Stop();}
        if(sa == 0 && b == 1){Stop();}
        EntFireByHandle(self, "RunScriptCode", " ShowHudText("+a+","+b+");", 0.00, null, null);
        EntFireByHandle(self, "RunScriptCode", " Ticking(); ", 1.00, null, null);
    }
}

function Stop()
{
    Tick = false;
    b = 0;
    EntFireByHandle(self, "RunScriptCode", " i =  0; ", 1.00, null, null);
    EntFireByHandle(self, "RunScriptCode", " a =  0; ", 1.00, null, null);
    EntFireByHandle(self, "RunScriptCode", " sa =  0; ", 1.00, null, null);
    EntFireByHandle(self, "RunScriptCode", " maxa =  0; ", 1.00, null, null);
    EntFireByHandle(self, "RunScriptCode", " Tick = true; ", 1.10, null, null);
    HideHud();
}

function HideHud()
{
    if(!Tick){
    ScriptPrintMessageCenterAll("");
    EntFireByHandle(self, "RunScriptCode", " HideHud(); ", 0.10, null, null);}
}

function ShowHudText(incount, setti)
{
    if(setti == 0)
    {
        ScriptPrintMessageCenterAll("Casting Killer: "+increment()+"/"+maxa);
    }
    else if(setti == 1)
    {
        ScriptPrintMessageCenterAll("Casting Killer: "+(decrement()+1));
    }
}

function increment()
{
    i++;
    return i;
}

function decrement()
{
    sa--;
    return sa;
}