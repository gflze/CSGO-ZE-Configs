g_aMask <- [
// "models/player/holiday/facemasks/facemask_anaglyph.mdl",
// "models/player/holiday/facemasks/facemask_chains.mdl",
// "models/player/holiday/facemasks/facemask_dallas.mdl",
// "models/player/holiday/facemasks/facemask_devil_plastic.mdl",
// "models/player/holiday/facemasks/facemask_hoxton.mdl",
// "models/player/holiday/facemasks/facemask_porcelain_doll_kabuki.mdl",
// "models/player/holiday/facemasks/facemask_samurai.mdl",
// "models/player/holiday/facemasks/facemask_sheep_model.mdl",
// "models/player/holiday/facemasks/facemask_tiki.mdl",
// "models/player/holiday/facemasks/facemask_zombie_fortune_plastic.mdl",
// "models/player/holidayporcelain_doll.mdl",

// "models/player/holiday/facemasks/facemask_bunny_gold.mdl",  g
// "models/player/holiday/facemasks/facemask_sheep_gold.mdl",  g
// "models/player/holiday/facemasks/facemask_skull_gold.mdl",  g

"models/player/holiday/facemasks/evil_clown.mdl",           //випка
"models/player/holiday/facemasks/facemask_battlemask.mdl",  //випка
"models/player/holiday/facemasks/facemask_pumpkin.mdl",      //випка
"models/player/holiday/facemasks/facemask_sheep_bloody.mdl", //випка
"models/player/holiday/facemasks/facemask_template.mdl",     //випка

"models/player/holiday/facemasks/facemask_chicken.mdl",      //Майк

"models/player/holiday/facemasks/facemask_skull.mdl",       //solo

"models/player/holiday/facemasks/facemask_boar.mdl",        //Самый богатый

"models/player/holiday/facemasks/facemask_bunny.mdl",         //быстрый взлом

"models/player/holiday/facemasks/facemask_wolf.mdl",        //Топ заражение
];

for(local i = 0; i < g_aMask.len(); i++){self.PrecacheModel(g_aMask[i])};


function SetMask(ID, button = true) 
{
    
    local player_class = MainScript.GetScriptScope().GetPlayerClassByHandle(activator);
    if(player_class == null)
        return;
    if(button)
    {
        if(!player_class.mapper)
        {
            if(ID < 5)
            {
                if(!player_class.vip)
                    return EntFire("fade_red", "Fade", "", 0, activator);
            }
            else if(ID == 7)
            {
                if(MainScript.GetScriptScope().GetPlayerClassByMoney() != player_class)
                    return EntFire("fade_red", "Fade", "", 0, activator);
            }
            else if(ID == 8)
            {
                if(!(RED_CHEST_RECORD_CLASS == player_class || GREEN_CHEST_RECORD_CLASS == player_class))
                    return EntFire("fade_red", "Fade", "", 0, activator);
            }
            else return EntFire("fade_red", "Fade", "", 0, activator);
        }
        
        EntFire("fade_white", "Fade", "", 0, activator);
    }
    local ent = Entities.FindByName(null, "mask_" + player_class.userid);
    if(ent == null)
    {
        ent = Entities.CreateByClassname("prop_dynamic")
        ent.__KeyValueFromInt("solid", 0);
        ent.__KeyValueFromInt("rendermode", 1);
        ent.__KeyValueFromInt("renderamt", 0);
        ent.__KeyValueFromInt("disableshadows", 1);
        ent.__KeyValueFromInt("disableflashlight", 1);
        ent.__KeyValueFromInt("disableshadowdepth", 1);
        ent.__KeyValueFromString("targetname", "mask_" + player_class.userid);
        ent.SetModel(g_aMask[ID]);

        EntFireByHandle(ent,"SetParent","!activator",0.00,activator,activator);
        EntFireByHandle(ent,"setparentattachment","facemask",0.05,activator,activator);
    }
    else 
        ent.SetModel(g_aMask[ID]);
}