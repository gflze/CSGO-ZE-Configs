Time_KillZM <- 5;
Time_KillZM = 0.00 + Time_KillZM; 

Time_GlobalNuke <- 4;
Time_GlobalNuke = 0.00 + Time_GlobalNuke; 

PrintMessage <- false;
ZombiesInside <- false;

tickrate <- 0.2;

DEBUG_GlobalNuke <- Time_GlobalNuke;

PLAYERS <- [];
PLAYERS_GIVE <- [];


function Start(time_nuke, time_zm)
{
    Time_GlobalNuke = time_nuke;
    Time_KillZM = time_zm;
    DEBUG_GlobalNuke = Time_GlobalNuke;
    
    EntFireByHandle(self, "Disable", "", 0.00, null, null);
    EntFireByHandle(self, "RunScriptCode", "StartTick();", Time_GlobalNuke, null, null); 

    self.ConnectOutput("OnStartTouch", "Touch");
    self.ConnectOutput("OnEndTouch", "EndTouch");
    
    EntFireByHandle(self, "Enable", "", 0.01, null, null);

    //Debug();
}

function Debug()
{
    ScriptPrintMessageCenterAll("NUKE TIME : " + DEBUG_GlobalNuke + "\nKILL ZM TIME : " + Time_KillZM + "\nZM INSIDE :" + ZombiesInside);
    if(DEBUG_GlobalNuke - tickrate <= 0)
    {
        DEBUG_GlobalNuke = 0.00;
    }
    else DEBUG_GlobalNuke -= tickrate;
    EntFireByHandle(self, "RunScriptCode", "Debug();", tickrate, null, null);
}

function StartTick()
{
    Tick();
}

function HaveAlive()
{
    if(PLAYERS.len() == 0)
        EntFireByHandle(caller, "FireUser4", "", 0, null, null);
    else
        EntFireByHandle(caller, "FireUser3", "", 0, null, null);
}

function Tick()
{
    ZombiesInside = false;
    if(PLAYERS.len() > 0)
    {
        foreach(p in PLAYERS)
        {
            if(!p.IsValid())
                continue;
            if(p.GetHealth() <= 0)
                continue;
            if(p.GetTeam() == 2)
                ZombiesInside = true;
        }
    }
    if(ZombiesInside)
    {
        if(!PrintMessage)
        {
            ScriptPrintMessageChatAll(Chat_pref + "YOU MUST TO KILL ALL THE ZOMBIES TO WIN");
            PrintMessage = true;
        }

        if(Time_KillZM - tickrate <= 0.00)
        {
            Nuke(3);
            return;
        }
        else Time_KillZM -= tickrate;
    }
    else
    {
        Nuke(2);
        return;
    }

    EntFireByHandle(self, "RunScriptCode", "Tick(); ", tickrate, null, null);
}

function GetWinner()
{
    return PLAYERS_GIVE;
}


function Nuke(Team = 2)
{
    local fade = Entities.FindByName(null, "Nuke_fade");
    local g_round = Entities.FindByName(null, "round_end");
    local handle = null;
    local alive = false;
    
    EntFire("zamok_ct", "RunScriptCode", "Stop()", 0);
    
    if(Team == 2)
    {
        while((handle = Entities.FindByClassname(handle, "player")) != null)
        {
            if(handle == null)
                continue;
            if(!handle.IsValid())
                continue;
            if(handle.GetTeam() == 1)
                continue;
            if(handle.GetHealth() <= 0)
                continue;
            if(InArray(handle))
            {
                alive = true;
                PLAYERS_GIVE.push(handle);
                continue;
            }  

            EntFireByHandle(handle, "SetDamageFilter", "", 0.9, null, null);
            EntFireByHandle(handle, "SetHealth", "-1", 2.0, null, null);
        }

    }
    else
    {
        while((handle = Entities.FindByClassname(handle, "player")) != null)
        {
            if(handle == null)
                continue;
            if(!handle.IsValid())
                continue;
            if(handle.GetHealth() <= 0)
                continue;
            if(handle.GetTeam() == 2 || handle.GetTeam() == 1)
                continue;

            EntFireByHandle(handle, "SetDamageFilter", "", 0.9, null, null);
            EntFireByHandle(handle, "SetHealth", "-1", 2.0, null, null);
        }
    }

    EntFireByHandle(fade, "Fade", "", 2, null, null);

    if(alive)
    {
        EntFireByHandle(self, "FireUser3", "", 0.00, null, null);
        EntFireByHandle(g_round, "EndRound_CounterTerroristsWin", "6", 1.8, null, null);
        MainScript.GetScriptScope().Show_Credits_Passed();
    }
    else 
    {
        EntFireByHandle(self, "FireUser4", "", 0.00, null, null);
        EntFireByHandle(g_round, "EndRound_TerroristsWin", "6", 1.8, null, null);
        MainScript.GetScriptScope().Show_Credits_Failed();
    }

}

function Touch()
{
    PLAYERS.push(activator);
}

function InArray(handle)
{
    if(PLAYERS.len() > 0)
    {
        foreach(p in PLAYERS)
        {
            if(p == handle)
            {
                return true;
            }
        }
    }
    else
    {
        printl("CLEAR");
    }
    return false;
}

function EndTouch()
{
    if(PLAYERS.len() > 0)
    {
        for (local i = 0; i < PLAYERS.len(); i++)
        {
            if(PLAYERS[i] == activator)
            {
                PLAYERS.remove(i);
                return;
            }
        }
    }
}

function PrintArray()
{
    if(PLAYERS.len() > 0)
    {
        for (local i = 0; i < PLAYERS.len(); i++)
        {
           printl(PLAYERS[i]);
        }
    }
    else
    {
        printl("CLEAR");
    }
}