MINIGAME_DATA <- [Vector(1228, -5120, -6720), Vector(0, 180, 0), "mg_laser_trigger"];
MINIGAME_WON_DATA <- [Vector(1798, -5120, -6768), Vector(0, 180, 0)];

MINIGAME_PLAYER <- null;
MINIGAME_WINNERS <- [];
MINIGAME_IS_WORKING <- true;
MINIGAME_T_ENT <- Entities.FindByName(null, MINIGAME_DATA[MINIGAME_DATA.len()-1]);
MINIGAME_T_POS <- function()
{
    local ent_chenter = MINIGAME_T_ENT.GetOrigin();
    local bbox_max = MINIGAME_T_ENT.GetBoundingMaxs();
    local bbox_min = MINIGAME_T_ENT.GetBoundingMins();
    local xyz_max = Vector(ent_chenter.x + bbox_max.x, ent_chenter.y + bbox_max.y, ent_chenter.z + bbox_max.z);
    local xyz_min = Vector(ent_chenter.x + bbox_min.x, ent_chenter.y + bbox_min.y, ent_chenter.z + bbox_min.z);
    return {max = xyz_max, min = xyz_min}
}

function StartGame()
{
    if(MINIGAME_T_ENT == null || MINIGAME_T_ENT != null && !MINIGAME_T_ENT.IsValid())
    {
        printl("NOT FOUND "+MINIGAME_DATA[MINIGAME_DATA.len()-1]);
        return;
    }
    if(MINIGAME_IS_WORKING)
    {
        EntFireByHandle(self, "RunScriptCode", "StartGame();", 1.00, null, null);
        if(MINIGAME_PLAYER != null && MINIGAME_PLAYER.IsValid())
        {
            return;
        }
        local players = [];
        local suc_pl = [];
        local h = null;
        local bot = null;
        while(null != (h = Entities.FindByClassname(h, "player")))
        {
            if(h.IsValid() && h.GetHealth() > 0 && h.GetTeam() == 3)
            {
                players.push(h);
            }
        }
        while(null != (bot = Entities.FindByClassname(bot, "cs_bot")))
        {
            if(bot.IsValid() && bot.GetHealth() > 0 && bot.GetTeam() == 3)
            {
                players.push(bot);
            }
        }
        if(MINIGAME_WINNERS.len() > 0)
        {
            for(local a = 0; a < players.len(); a++)
            {
                local exist_p = false;
                for(local i = 0; i < MINIGAME_WINNERS.len(); i++)
                {
                    if(players[a] == MINIGAME_WINNERS[i])
                    {
                        exist_p = true;
                        continue;
                    }
                }
                if(!exist_p)
                {
                    suc_pl.push(players[a]);
                }
            }
        }
        else
        {
            suc_pl = players.slice(0);
        }
        if(suc_pl.len() > 0)
        {
            MINIGAME_PLAYER = suc_pl[RandomInt(0, suc_pl.len()-1)];
            if(MINIGAME_PLAYER != null && MINIGAME_PLAYER.IsValid())
            {
                MINIGAME_PLAYER.SetOrigin(MINIGAME_DATA[0]);
                MINIGAME_PLAYER.SetAngles(MINIGAME_DATA[1].x, MINIGAME_DATA[1].y, MINIGAME_DATA[1].z);
                EntFireByHandle(self, "FireUser2", "", 0.00, MINIGAME_PLAYER, null);
                MiniGameCheckPlayer();
            }
        }
        else
        {
            EntFireByHandle(self, "FireUser1", "", 0.00, null, null);
            ScriptPrintMessageChatAll("\x01[CHECKER] \x02WAITING ROOM IS EMPTY, MINIGAME OVER!");
            return MINIGAME_IS_WORKING = false;
        }
    }
}

function MiniGameCheckPlayer()
{
    
    if(MINIGAME_PLAYER == null ||
    MINIGAME_PLAYER != null && !MINIGAME_PLAYER.IsValid() ||
    MINIGAME_PLAYER != null && MINIGAME_PLAYER.IsValid() && MINIGAME_PLAYER.GetHealth() <= 0 ||
    MINIGAME_PLAYER != null && MINIGAME_PLAYER.IsValid() && MINIGAME_PLAYER.GetTeam() != 3 ||
    MINIGAME_PLAYER != null && MINIGAME_PLAYER.IsValid() && !InTriggerPos(MINIGAME_PLAYER.GetOrigin(), MINIGAME_T_POS().max, MINIGAME_T_POS().min))
    {
        DisableMiniGame();
        EntFireByHandle(self, "RunScriptCode", "EnableMiniGame();", 1.05, null, null);
        EntFireByHandle(self, "RunScriptCode", "StartGame();", 2.00, null, null);
        MINIGAME_PLAYER = null;
        return;
    }
    EntFireByHandle(self, "RunScriptCode", "MiniGameCheckPlayer();", 0.05, null, null);
}

function MiniGamePlayerWon()
{
    if(MINIGAME_PLAYER != null && MINIGAME_PLAYER.IsValid())
    {
        MINIGAME_PLAYER.SetOrigin(MINIGAME_WON_DATA[0]);
        MINIGAME_PLAYER.SetAngles(MINIGAME_WON_DATA[1].x, MINIGAME_WON_DATA[1].y, MINIGAME_WON_DATA[1].z);
        MINIGAME_WINNERS.push(MINIGAME_PLAYER);
        MINIGAME_PLAYER = null;
    }
}

function DisableMiniGame()
{
    MINIGAME_IS_WORKING = false;
}

function EnableMiniGame()
{
    MINIGAME_IS_WORKING = true;
}

function InTriggerPos(obj_pos, pos_max, pos_min)
{
    if(obj_pos.x <= pos_max.x &&  obj_pos.x >= pos_min.x && obj_pos.y <= pos_max.y &&  obj_pos.y >= pos_min.y && obj_pos.z <= pos_max.z &&  obj_pos.z >= pos_min.z)
    {
        return true;
    }
    return false;
}