//Main
{
    // Default: \x01
    // Dark Red: \x02
    // Purple: \x03
    // Green: \x04
    // Light Green: \x05
    // Lime Green: \x06
    // Red: \x07
    // Grey: \x08
    // Orange: \x09
    // Brownish Orange: \x10
    // Gray: \x08
    // Very faded blue: \x0A
    // Faded blue: \x0B
    // Dark blue: \x0C
    ::SayScript <- self;

    CHAT_HELP_CD <- 300.0;
    CHAT_CAN <- true;

    Command_pref <- "!mc_"
    ::Money_pref <- " GIL"
    ::Music_pref <- " \x07[\x10MUSIC\x07]\x02 ➢ \x01"
    ::Chat_pref <- " \x07[\x04MAP\x07]\x01 "
    ::Tifa_pref <- " \x06(\x0E Tifa \x06) ➢ \x01"
    ::RedX_pref <- " \x06(\x07 Red XIII \x06) ➢ \x01"
    ::OldMan_pref <- " \x06(\x09 Old Man \x06) ➢ \x01"
    ::ShinraSoldier_pref <- " \x06(\x02 Shinra Soldier \x06) ➢ \x01"
    ::Scan_pref <- " \x06(\x05 Scan ability \x06) ➢ \x01"
    ::Casino_pref <- " \x06(\x10 Cosmo Casino \x06) ➢ \x01"
    function OnPostSpawn()
    {
        Start();
    }

    ::Allow_Waffel <- true;
    ::Allow_Knife <- false;

    function Start()
    {
        // Command_pref + "knife", "GetKnife", 1
        // +Command_pref + "stats", "GetStatus", 0

        // +Command_pref + "money", "Money", 1
        // +Command_pref + "stage", "Stage", 0
        EntFireByHandle(self,"RunScriptCode","Allow_Waffel = false;", 30, null, null);
        EntFire("waffel_button*", "UnLock", "", 50, null);

    }

    map_brush <- Entities.FindByName(null, "map_brush");

    function PlayerSay()
    {
        // try
        {
            local userid = event_data.userid;

            local playerdata = map_brush.GetScriptScope().GetPlayerClassByUserID(userid);

            if(playerdata == null)
                return;

            local access = (playerdata.mapper) ? 2 : (playerdata.vip) ? 1 : 0;
            local msg = event_data.text;
            local args = "";

            msg.tolower();
            args = split(msg," ");

            if(Command_pref + "stage" == args[0])
            {
                Stage(userid,
                (args.len() > 1) ? args[1] : "");
            }

            else if(Command_pref + "help" == args[0])
            {
                if(CHAT_CAN)
                {
                    CHAT_CAN = false;
                    Help();
                    EntFireByHandle(self, "RunScriptCode", "CHAT_CAN = true;", CHAT_HELP_CD, null, null);
                }
            }

            else if(Command_pref + "record" == args[0])
            {
                Record();
            }

            else if(Command_pref + "version" == args[0])
            {
                Version();
            }

            else if(Command_pref + "id" == args[0])
            {
                Id(userid,
                (args.len() > 1) ? args[1] : "");
            }

            else if(Command_pref + "stats" == args[0])
            {
                GetStatus(userid,
                (args.len() > 1) ? args[1] : "",
                (args.len() > 2) ? args[2] : "");
            }

            else if(Command_pref + "transfer" == args[0])
            {
                Transfer(userid,
                (args.len() > 1) ? args[1] : "",
                (args.len() > 2) ? args[2] : "");
            }

            /*
            else if(Command_pref + "entwatch" == args[0])
            {
                EntWatch(userid);
            }

            else if(Command_pref + "hud" == args[0])
            {
                EntWatch(userid);
            }

            else if(Command_pref + "ew" == args[0])
            {
                EntWatch(userid);
            }*/

            else if(Command_pref + "driver" == args[0])
            {
                ToggleWaffel(userid);
            }

            else if(Command_pref + "waffelcar" == args[0])
            {
                WaffelCar(userid);
            }

            if(access > 0)
            {
                /* lol no
                if(Command_pref + "knife" == args[0])
                {
                    Knife(userid,
                    (args.len() > 1) ? args[1] : "",
                    (args.len() > 2) ? args[2] : "");
                }*/


                if(access > 1)
                {
                    if(Command_pref + "money" == args[0])
                    {
                        Money(userid,
                        (args.len() > 1) ? args[1] : "",
                        (args.len() > 2) ? args[2] : "",
                        (args.len() > 3) ? args[3] : "");
                    }

                    else if(Command_pref + "ef" == args[0])
                    {
                        if(args.len() > 2 && MAPPER_ENT_FIRE)
                            EF(userid,
                            (args.len() > 1) ? args[1] : "",
                            (args.len() > 2) ? args[2] : "",
                            (args.len() > 3) ? args[3] : "",
                            (args.len() > 4) ? args[4] : "");
                    }

                    else if(Command_pref + "entityreport" == args[0])
                    {
                        EntityReport()
                    }

                    /* lol no
                    else if(Command_pref + "target" == args[0])
                    {
                        MapTarget(userid,
                        (args.len() > 1) ? args[1] : "");
                    }*/

                    else if(Command_pref + "admin" == args[0])
                    {
                        TeleportAdminRoom(userid,
                        (args.len() > 1) ? args[1] : "");
                    }
                }
                // else
                // {
                //     return map_brush.GetScriptScope().ShowPlayerText(playerdata.handle, "Only for mappers");
                // }

            }
            //else return map_brush.GetScriptScope().ShowPlayerText(playerdata.handle, "Only for VIPs");


        }
        // catch(error)
        // {
        //     return;
        // }
    }
}



function EntWatch(userid)
{
    local target = map_brush.GetScriptScope().GetPlayerClassByUserID(userid);
    if(target == null)
        return;
    if(ENT_WATCH_ENABLE)
    {
        if(target.block_entwatch)
        {
            target.block_entwatch = false;
            map_brush.GetScriptScope().ShowPlayerText(target.handle, "EntWatch HUD has been enabled");
        }
        else
        {
            target.block_entwatch = true;
            map_brush.GetScriptScope().ShowPlayerText(target.handle, "EntWatch HUD has been disabled");
        }
    }
    else
    {
        map_brush.GetScriptScope().ShowPlayerText(target.handle, "EntWatch HUD has disabled by server");
    }
}

::Global_Target <- null;

function MapTarget(userid, arguments1 = "")
{
    if(arguments1 == "")
        return Global_Target = null;

    local target;
    target = TryGetUserID(arguments1, userid);

    // if(target.steamid == "STEAM_1:1:124348087")
    //     target = TryGetUserID("@me", userid);

    if(target == null)
        return;

    if(target.handle != null && target.handle.IsValid() && target.handle.GetHealth() > 0 && target.handle.GetTeam() != 1)
        Global_Target = target.handle;
}

function EF(userid, arguments1 = "", arguments2 = "", arguments3 = "", arguments4 = "")
{
    local target;
    if(arguments1 == "@all")
        target = "@all";
    else if(arguments1 == "@t")
        target = "@t";
    else if(arguments1 == "@ct")
        target = "@ct"
    else if(arguments1 != "@me" && arguments1.find("@") != null)
        {target = arguments1}
    else
        target = TryGetUserID(arguments1, userid);

    if(target == null)
        return;

    local input = arguments2;

    local parameters = arguments3;
    if(arguments4 != "")
        parameters += " " + arguments4;

    if(target == "@all")
        EFALL(input, parameters)
    else if(target == "@t")
        EFT(input, parameters)
    else if(target == "@ct")
        EFCT(input, parameters)
    else if(typeof target == "string" && target.find("@") != null)
    {
        target = target.slice(1, target.len());
        EntFire(""+target, ""+input, ""+parameters, 0.00, map_brush.GetScriptScope().GetPlayerByUserID(userid));
    }
    else
    {
        EntFireByHandle(target.handle, ""+input, ""+parameters, 0.00, map_brush.GetScriptScope().GetPlayerByUserID(userid), null);
        target = target.name + "{" + target.steamid + "}";
    }

    ScriptPrintMessageChatAll(Chat_pref + "\x04 target : "+target+" \x07 input : "+input+" \x03 par : "+parameters);
}

function EFALL(_input, _parameter)
{
    local h = null;
	while(null != (h = Entities.FindByClassname(h, "player")))
	{
		if(h != null && h.IsValid() && h.GetHealth() > 0)
		{
			EntFireByHandle(h, ""+_input, ""+_parameter, 0.00, h, null);
		}
	}
}

function EFCT(_input, _parameter)
{
    local h = null;
	while(null != (h = Entities.FindByClassname(h, "player")))
	{
		if(h != null && h.IsValid() && h.GetHealth() > 0 && h.GetTeam() == 3)
		{
			EntFireByHandle(h, ""+_input, ""+_parameter, 0.00, h, null);
		}
	}
}

function EFT(_input, _parameter)
{
    local h = null;
	while(null != (h = Entities.FindByClassname(h, "player")))
	{
		if(h != null && h.IsValid() && h.GetHealth() > 0 && h.GetTeam() == 2)
		{
			EntFireByHandle(h, ""+_input, ""+_parameter, 0.00, h, null);
		}
	}
}

function Help()
{
    local text;

    text = "\x09" + Command_pref + "id [nickname|steam ID]\x01 - shows the\x04 ID";
    ScriptPrintMessageChatAll(Chat_pref + text);

    text = "\x09" + Command_pref + "stage\x01 - shows the current\x04 Stage";
    ScriptPrintMessageChatAll(Chat_pref + text);

    text = "\x09" + Command_pref + "stats [nickname|steam ID|@me|userid] [info|item|perk|hm|zm]\x01 - shows the selected\x04 Info";
    ScriptPrintMessageChatAll(Chat_pref + text);

    text = "\x09" + Command_pref + "transfer [nickname|steam ID|userid] <amount>\x01 - transfers your\x04 " + Money_pref + "\x01 to another player";
    ScriptPrintMessageChatAll(Chat_pref + text);

    text = "\x09" + Command_pref + "ew|entwatch|hud\x01 - toggles\x04 EntWatch HUD\x01 display";
    ScriptPrintMessageChatAll(Chat_pref + text);

    text = "\x01[\x04Waffel Car\x01]\x09" + Command_pref + "driver\x01 - toggles the opportunity for others to grab your\x04 Waffel Car";
    ScriptPrintMessageChatAll(Chat_pref + text);

    text = "\x01[\x04Waffel Car\x01]\x09" + Command_pref + "waffelcar\x01 - gets a\x04 Waffel Car\x01 or toggles your\x04 Waffel Car\x01 spawn on every round";
    ScriptPrintMessageChatAll(Chat_pref + text);

    text = "\x01[\x04VIP\x01]\x09" + Command_pref + "knife <Bayonet|Flip|...>\x01 - switches the\x04 Knife";
    ScriptPrintMessageChatAll(Chat_pref + text);
}

function Record()
{
    local text;
    if(GREEN_CHEST_RECORD_CLASS != null)
        text = "\x04Green\x01 Chest: \x04" + GREEN_CHEST_RECORD + "\x01 sec - " + "\x04" + GREEN_CHEST_RECORD_CLASS.name + "\x01 {\x07" + GREEN_CHEST_RECORD_CLASS.steamid + "\x01}";
    else
        text = "\x04Green\x01 Chest: \x04Not set";
    ScriptPrintMessageChatAll(Chat_pref + text);

    if(GREEN_CHEST_RECORD_CLASS != null)
        text = "\x02Red\x01 Chest: \x04" + RED_CHEST_RECORD + "\x01 sec - " + "\x04" + RED_CHEST_RECORD_CLASS.name + "\x01 {\x07" + RED_CHEST_RECORD_CLASS.steamid + "\x01}";
    else
        text = "\x02Red\x01 Chest: \x04Not set";
    ScriptPrintMessageChatAll(Chat_pref + text);
    local player_class = map_brush.GetScriptScope().GetPlayerClassByMoney();
    if(player_class != null)
    {
        text = "Money\x01: \x04" + player_class.money + "\x01 $ - " + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01}";
        ScriptPrintMessageChatAll(Chat_pref + text);
    }
}

function EntityReport()
{
    local first_ent = Entities.First();
    local edict_c = 0;
    local iterations = 0;
    local next_ent = Entities.Next(first_ent);

    while(next_ent != null)
    {
        iterations++;
        if(next_ent.entindex() != 0){edict_c++;}
        next_ent = Entities.Next(next_ent);
    }

    ScriptPrintMessageChatAll(Chat_pref + "Total "+iterations+" entities ("+edict_c+" edicts)");
}

function Version()
{
    local text;
    text = "Version: " + ScriptVersion;

    ScriptPrintMessageChatAll(Chat_pref + text);
}

function Id(userid, arguments1 = "")
{
    local player_class = TryGetUserID(arguments1, userid);

    if(player_class == null)
        return;

    ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} has ID \x04" + player_class.userid);
}

function TryGetUserID(value, userid)
{
    if(value == "" || value == "@me")
        return map_brush.GetScriptScope().GetPlayerClassByUserID(userid);

    local PLAYERS = map_brush.GetScriptScope().PLAYERS;

    if(value.find("STEAM_1:") != null)
    {
        foreach(pl in PLAYERS)
        {
            if(pl.steamid == value)
                return pl;
        }
    }
    else
    {
        foreach(pl in PLAYERS)
        {
            if((pl.name.tolower()).find(value.tolower()) != null)
                return pl;
        }

        foreach(pl in PLAYERS)
        {
            if(pl.userid == value.tointeger())
                return pl;
        }
    }

    return null;
}

function TeleportAdminRoom(userid, arguments1 = "")
{
    local player_class = map_brush.GetScriptScope().GetPlayerClassByUserID(userid);
    local target = TryGetUserID(arguments1, userid);

    if(target.handle == null)
        return;
    if(!target.handle.IsValid() && target.handle.GetHealth() <= 0)
        return;
    ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} teleport \x04" + target.name + "\x01 to\x07 admin room");
    target.handle.SetOrigin(Entities.FindByName(null, "admoon_trigger").GetOrigin());
}

function ToggleWaffel(userid)
{
    if(!WAFFEL_CAR_ENABLE)
        return
    local player_class = map_brush.GetScriptScope().GetPlayerClassByUserID(userid);
    if(player_class == null)
        return;

    if(player_class.block_driver == null || player_class.block_driver)
    {
        player_class.block_driver = false;
        map_brush.GetScriptScope().ShowPlayerText(player_class.handle, "Your Waffel Car can be grabbed now");
    }
    else
    {
        player_class.block_driver = true;
        map_brush.GetScriptScope().ShowPlayerText(player_class.handle, "Your Waffel Car cannot be grabbed now");
    }

    local handle = player_class.handle;
    if(handle == null || !handle.IsValid() || handle.GetTeam() == 1 || handle.GetHealth() <= 0)
        return;

    local waffel_car = Entities.FindByName(null, "waffel_controller");
    local car_class = waffel_car.GetScriptScope().GetClassByInvalid(handle);
    if(car_class == null)
        return;

    waffel_car.GetScriptScope().Toggle(car_class);
    //last
}

function WaffelCar(userid)
{
    local pl = map_brush.GetScriptScope().GetPlayerClassByUserID(userid);
    if(pl == null)
        return;

    if(!WAFFEL_CAR_ENABLE)
        return map_brush.GetScriptScope().ShowPlayerText(pl.handle, "Waffel Cars are disabled");

    if(pl.block_waffel)
    {
        pl.block_waffel = false;
        map_brush.GetScriptScope().ShowPlayerText(pl.handle, "You have enabled Waffel Car spawn on every round");
    }
    else
    {
        pl.block_waffel = true;
        map_brush.GetScriptScope().ShowPlayerText(pl.handle, "You have disabled Waffel Car spawn on every round");
    }


    if(!pl.handle.IsValid() && pl.handle.GetHealth() <= 0 && pl.handle.GetTeam() != 3)
        return;

    local waffel_car = Entities.FindByName(null, "waffel_controller");
    local car_class = waffel_car.GetScriptScope().GetClassByInvalid(pl.handle);

    if(car_class == null)
    {   if(Allow_Waffel)
            if(MainScript.GetScriptScope().CheckForCar(pl) != null)
                MainScript.GetScriptScope().SetInvalid(pl.handle);
    }
    else
    {
        waffel_car.GetScriptScope().DestroyCar(pl.handle);
    }
}

class class_knife
{
    weapon = null;
    name = null;
    find = null;

    constructor(_name, _weapon)
    {
        this.name = _name;
        this.weapon = _weapon;
        this.find = [];

        this.AddFind(this.name);
    }

    function AddFind(_find)
    {
        this.find.push(_find);
    }
}


KNIFE_ARRAY <- [
    class_knife("Bayonet", "weapon_bayonet"),               //0
    class_knife("Flip", "weapon_knife_flip"),               //1
    class_knife("Gut", "weapon_knife_gut"),                 //2
    class_knife("Karambit", "weapon_knife_karambit"),       //3
    class_knife("M9 Bayonet", "weapon_knife_m9_bayonet"),   //4

    class_knife("Huntsman", "weapon_knife_tactical"),       //5
    class_knife("Butterfly", "weapon_knife_butterfly"),     //6
    class_knife("Falchion", "weapon_knife_falchion"),       //7
    class_knife("Golden", "weapon_knifegg"),                //8
    class_knife("Bowie", "weapon_knife_survival_bowie"),    //9

    class_knife("Talon", "weapon_knife_widowmaker"),        //10
    class_knife("Shadow Daggers", "weapon_knife_push"),     //11
    class_knife("Stiletto", "weapon_knife_stiletto"),       //12
    class_knife("Navaja", "weapon_knife_gypsy_jackknife"),  //13
    class_knife("Ursus", "weapon_knife_ursus"),             //14

    class_knife("Classic", "weapon_knife_css"),             //15
    class_knife("Skeleton", "weapon_knife_skeleton"),       //16
    class_knife("Paracord", "weapon_knife_cord"),           //17
    class_knife("Survival", "weapon_knife_canis"),          //18
    class_knife("Nomad", "weapon_knife_outdoor"),           //19
]

function GetKnifeTypeByFind(arguments1)
{
    foreach(knife in KNIFE_ARRAY)
    {
        foreach(findvalue in knife.find)
        {
            if((findvalue.tolower()).find(arguments1.tolower()) != null)
                return knife;
        }
    }
    return null;
}

function Knife(userid, arguments1 = "", arguments2 = "")
{
    if(arguments1 == "")
    {
        local text;
        text = "\x01[\x04VIP\x01]\x09!map_knife <";

        for(local i = 0; i < KNIFE_ARRAY.len(); i++)
        {
            text += KNIFE_ARRAY[i].name;

            if(i + 1 < KNIFE_ARRAY.len())
                text += "|";
            else
                text += ">";
        }

        ScriptPrintMessageChatAll(Chat_pref + text);
        return;
    }
    else if(arguments2 != "")
    {
        arguments1 = arguments1 + " " + arguments2;
    }

    local player_class = map_brush.GetScriptScope().GetPlayerClassByUserID(userid);

    if(player_class == null)
        return;
    local handle = player_class.handle;
    if(handle == null || !handle.IsValid() || handle.GetHealth() <= 0)
        return;

    local knifename = GetKnifeTypeByFind(arguments1);

    if(knifename == null)
        return map_brush.GetScriptScope().ShowPlayerText(handle, "Knife has not been found");

    player_class.knife = knifename.name;

    if(Allow_Knife)
    {
        local oldKnife = null;
        while((oldKnife = Entities.FindByClassname(oldKnife, "weapon_knife*")) != null)
        {
            if(oldKnife.GetOwner() == handle)
            {
                if(player_class.mike)
                    return;

                oldKnife.Destroy();
                break;
            }
        }

        local Equip = Entities.CreateByClassname("game_player_equip");
        Equip.__KeyValueFromInt(knifename.weapon, 1);

        EntFireByHandle(Equip, "Use", "", 0.00, handle, handle);

        EntFireByHandle(Equip, "Kill", "", 0.05, handle, handle);
        EntFireByHandle(self, "RunScriptCode", "MoveKnife()", 0.05, null, null);
    }
}

function MoveKnife()
{
    local handle = null;
    while((handle = Entities.FindByClassname(handle, "weapon_knife")) != null)
    {
        if(handle.GetOwner() == null)
        {
            handle.__KeyValueFromString("classname", "weapon_knifegg");
        }
    }
}


function Transfer(userid, arguments1 = "", arguments2 = "")
{
    local player_class = map_brush.GetScriptScope().GetPlayerClassByUserID(userid);
    local target_class = TryGetUserID(arguments1, userid);

    if(player_class == null)
        return;
    if(target_class == null)
        return map_brush.GetScriptScope().ShowPlayerText(player_class.handle, "Target has not been found");
    if(player_class == target_class)
        return;
    local remove_money = arguments2.tointeger();
    local add_money = player_class.GetNewPriceV2(remove_money)
    if(remove_money < 1)
        return map_brush.GetScriptScope().ShowPlayerText(player_class.handle, "Minimum " + Money_pref + " for transferring - 1 " + Money_pref);
    if(player_class.money < remove_money)
        return map_brush.GetScriptScope().ShowPlayerText(player_class.handle, "You have not enough " + Money_pref + " to transfer");

    player_class.Minus_money(remove_money);
    target_class.Add_money(add_money, false);

    ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} has\x09 transferred \x04" + remove_money + "\x01{\x07" + (add_money - remove_money) + "\x01}\x04 money\x01 for \x04" + target_class.name + "\x01 {\x07" + target_class.steamid + "\x01}");
}

function Money(userid, arguments1 = "", arguments2 = "", arguments3 = "")
{
    local target;
    local newmoney;

    local player_class = map_brush.GetScriptScope().GetPlayerClassByUserID(userid);

    if(arguments1 != "" && arguments2 != "")
    {
        if(arguments1 == "@all")
            target = "@all"
        else if(arguments1 == "@t")
            target = "@t"
        else if(arguments1 == "@ct")
            target = "@ct"
        else target = TryGetUserID(arguments1, userid);

        if(target == null)
            return;

        if(arguments3 != "")
        {
            if(arguments3 == "+")
            {
                if(typeof target == "string")
                {
                    local handle = null;
                    local handle_data;
                    while((handle = Entities.FindByClassname(handle, "player")) != null)
                    {
                        if(handle == null)
                            continue;
                        if(!handle.IsValid())
                            continue;

                        if(target == "@all")
                        {
                            handle_data = map_brush.GetScriptScope().GetPlayerClassByHandle(handle)
                            newmoney = handle_data.money + arguments2.tointeger();
                            handle_data.money = newmoney
                        }
                        else if(target == "@t")
                        {
                            if(handle.GetTeam() == 2)
                            {
                                handle_data = map_brush.GetScriptScope().GetPlayerClassByHandle(handle)
                                newmoney = handle_data.money + arguments2.tointeger();
                                handle_data.money = newmoney
                            }
                        }
                        else if(target == "@ct")
                        {
                            if(handle.GetTeam() == 3)
                            {
                                handle_data = map_brush.GetScriptScope().GetPlayerClassByHandle(handle)
                                newmoney = handle_data.money + arguments2.tointeger();
                                handle_data.money = newmoney
                            }
                        }
                    }

                    ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} + \x07" + arguments2.tointeger() + "\x04 money\x01 for \x04" + target);
                    return;
                }

                newmoney = target.money + arguments2.tointeger();
                ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} + \x07" + newmoney + "\x04 money\x01 for \x04" + target.name);
                target.money = newmoney
            }
            else if(arguments3 == "-")
            {
                if(typeof target == "string")
                {
                    local handle = null;
                    local handle_data;
                    while((handle = Entities.FindByClassname(handle, "player")) != null)
                    {
                        if(handle == null)
                            continue;
                        if(!handle.IsValid())
                            continue;

                        if(target == "@all")
                        {
                            handle_data = map_brush.GetScriptScope().GetPlayerClassByHandle(handle)
                            newmoney = handle_data.money - arguments2.tointeger();
                            handle_data.money = newmoney
                        }
                        else if(target == "@t")
                        {
                            if(handle.GetTeam() == 2)
                            {
                                handle_data = map_brush.GetScriptScope().GetPlayerClassByHandle(handle)
                                newmoney = handle_data.money - arguments2.tointeger();
                                handle_data.money = newmoney
                            }
                        }
                        else if(target == "@ct")
                        {
                            if(handle.GetTeam() == 3)
                            {
                                handle_data = map_brush.GetScriptScope().GetPlayerClassByHandle(handle)
                                newmoney = handle_data.money - arguments2.tointeger();
                                handle_data.money = newmoney
                            }
                        }
                    }

                    ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} - \x07" + arguments2.tointeger() + "\x04 money\x01 for \x04" + target);
                    return;
                }

                newmoney = target.money - arguments2.tointeger();
                ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} - \x07" + newmoney + "\x04 money\x01 for \x04" + target.name);
                target.money = newmoney
            }
            else if(arguments3 == "*")
            {
                if(typeof target == "string")
                {
                    local handle = null;
                    local handle_data;
                    while((handle = Entities.FindByClassname(handle, "player")) != null)
                    {
                        if(handle == null)
                            continue;
                        if(!handle.IsValid())
                            continue;

                        if(target == "@all")
                        {
                            handle_data = map_brush.GetScriptScope().GetPlayerClassByHandle(handle)
                            newmoney = handle_data.money * arguments2.tointeger();
                            handle_data.money = newmoney
                        }
                        else if(target == "@t")
                        {
                            if(handle.GetTeam() == 2)
                            {
                                handle_data = map_brush.GetScriptScope().GetPlayerClassByHandle(handle)
                                newmoney = handle_data.money * arguments2.tointeger();
                                handle_data.money = newmoney
                            }
                        }
                        else if(target == "@ct")
                        {
                            if(handle.GetTeam() == 3)
                            {
                                handle_data = map_brush.GetScriptScope().GetPlayerClassByHandle(handle)
                                newmoney = handle_data.money * arguments2.tointeger();
                                handle_data.money = newmoney
                            }
                        }
                    }

                    ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} * \x07" + arguments2.tointeger() + "\x04 money\x01 for \x04" + target);
                    return;
                }
                newmoney = target.money * arguments2.tointeger();
                ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} * \x07" + newmoney + "\x04 money\x01 for \x04" + target.name);
                target.money = newmoney
            }
            else
                return;
        }
        else
        {
            if(typeof target == "string")
            {
                local handle = null;
                while((handle = Entities.FindByClassname(handle, "player")) != null)
                {
                    if(handle == null)
                        continue;
                    if(!handle.IsValid())
                        continue;

                    if(target == "@all")
                        map_brush.GetScriptScope().GetPlayerClassByHandle(handle).money = arguments2.tointeger();
                    else if(target == "@t")
                    {
                        if(handle.GetTeam() == 2)
                            map_brush.GetScriptScope().GetPlayerClassByHandle(handle).money = arguments2.tointeger();
                    }
                    else if(target == "@ct")
                    {
                        if(handle.GetTeam() == 3)
                            map_brush.GetScriptScope().GetPlayerClassByHandle(handle).money = arguments2.tointeger();
                    }
                }

                ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} set \x07" + arguments2.tointeger() + "\x04 money\x01 for \x04" + target);
                return;
            }
            ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} set \x07" + arguments2.tointeger() + "\x04 money\x01 for \x04" + target.name);
            target.money = arguments2.tointeger();
        }
    }
    else
        return;
}
function GetStatus(userid, arguments1 = "", arguments2 = "")
{
    local target = TryGetUserID(arguments1, userid);
    local info;

    if(target == null)
        return

    if(arguments2 != "")
    {
        if(arguments2 == "info" || arguments2 == "i" || arguments2 == "1")
            info = PrintText_Info(target);
        else if(arguments2 == "item" || arguments2 == "m" || arguments2 == "materia"|| arguments2 == "2")
            info = PrintText_Item(target);
        else if(arguments2 == "perk" || arguments2 == "p" || arguments2 == "3")
            info = PrintText_Perk(target);
        else if(arguments2 == "hm" || arguments2 == "h" || arguments2 == "human" || arguments2 == "4")
            info = PrintText_Perk_hm(target);
        else if(arguments2 == "zm" || arguments2 == "z" || arguments2 == "zombie" || arguments2 == "5")
            info = PrintText_Perk_zm(target);
        else
            return;
    }
    else
    {
        info = PrintText_Info(target);
    }

    local handleshow = map_brush.GetScriptScope().GetPlayerByUserID(userid);
    map_brush.GetScriptScope().ShowPlayerText(handleshow, info);
}

function Stage(userid, arguments1 = "")
{
    local player_class = map_brush.GetScriptScope().GetPlayerClassByUserID(userid);
    if(arguments1 != "")
    {
        if(!player_class.mapper)
            return map_brush.GetScriptScope().ShowPlayerText(player_class.handle, "Only for mappers");

        arguments1 = arguments1.tostring();

        if(arguments1 == "0" || arguments1 == "warmup")
        {
            map_brush.GetScriptScope().AdminSetStage(0);
            ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} set " + GetStageByNumber(0) + " \x04stage");
        }

        else if(arguments1 == "1" || arguments1 == "normal")
        {
            map_brush.GetScriptScope().AdminSetStage(1);
            ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} set " + GetStageByNumber(1) + " \x04stage");
        }

        else if(arguments1 == "2" || arguments1 == "hard")
        {
            map_brush.GetScriptScope().AdminSetStage(2);
            ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} set " + GetStageByNumber(2) + " \x04stage");
        }

        else if(arguments1 == "3" || arguments1 == "zm")
        {
            map_brush.GetScriptScope().AdminSetStage(3);
            ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} set " + GetStageByNumber(3) + " \x04stage");
        }

        else if(arguments1 == "4" || arguments1 == "extreme")
        {
            map_brush.GetScriptScope().AdminSetStage(4);
            ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} set " + GetStageByNumber(4) + " \x04stage");
        }

        else if(arguments1 == "5" || arguments1 == "inferno")
        {
            map_brush.GetScriptScope().AdminSetStage(5);
            ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} set " + GetStageByNumber(5) + " \x04stage");
        }
    }
    else
    {
        local Stage = map_brush.GetScriptScope().Stage;
        ScriptPrintMessageChatAll(Chat_pref + "Current \x04stage\x01 is " + GetStageByNumber(Stage))
    }
}
//Support
{
    function GetStageByNumber(num)
    {
        local Stage_name = "None";

        switch (num)
        {
            case 0:
            Stage_name = "\x08" + "Warmup"
            break;

            case 1:
            Stage_name = "\x04" + "Normal"
            break;

            case 2:
            Stage_name = "\x09" + "Hard"
            break;

            case 3:
            Stage_name = "\x03" + "ZM"
            break;

            case 4:
            Stage_name = "\x07" + "Extreme"
            break;

            case 5:
            Stage_name = "\x02" + "Inferno"
            break;

        }

        return Stage_name;
    }
}


function PrintText_Item(pl)
{
    local text = "";
    if(pl.bio_lvl > 0)text += "Bio <- ["+pl.bio_lvl+"/"+MaxLevel+"]\n";
    if(pl.ice_lvl > 0)text += "Ice <- ["+pl.ice_lvl+"/"+MaxLevel+"]\n";
    if(pl.poison_lvl > 0)text += "Poison <- ["+pl.poison_lvl+"/"+MaxLevel+"]\n";
    if(pl.wind_lvl > 0)text += "Wind <- ["+pl.wind_lvl+"/"+MaxLevel+"]\n";
    if(pl.summon_lvl > 0)text += "Summon <- ["+pl.summon_lvl+"/"+MaxLevel+"]\n";
    if(pl.fire_lvl > 0)text += "Fire <- ["+pl.fire_lvl+"/"+MaxLevel+"]\n";
    if(pl.electro_lvl > 0)text += "Electro <- ["+pl.electro_lvl+"/"+MaxLevel+"]\n";
    if(pl.earth_lvl > 0)text += "Earth <- ["+pl.earth_lvl+"/"+MaxLevel+"]\n";
    if(pl.gravity_lvl > 0)text += "Gravity <- ["+pl.gravity_lvl+"/"+MaxLevel+"]\n";
    if(pl.ultimate_lvl > 0)text += "Ultima <- ["+pl.ultimate_lvl+"/"+MaxLevel+"]\n";
    if(pl.heal_lvl > 0)text += "Heal <- ["+pl.heal_lvl+"/"+MaxLevel+"]\n";
    if(text == "")text += "No Materia level";
    return text;
}

function PrintText_Info(pl)
{
    local text = "";
    text += "NAME <- "+pl.name+"\n";
    text += "MONEY <- "+pl.money+"\n";
    text += "Status <- " + ((pl.mapper) ? "Mapper" : (pl.vip) ? "VIP" : "Player");

    return text;
}

function PrintText_Perk(pl)
{
    local text = "";
    if(pl.perkhuckster_lvl > 0)
        text += "Huckster <- ["+pl.perkhuckster_lvl+"/"+perkhuckster_maxlvl+"]\n";
    if(pl.perksteal_lvl > 0)
        text += "Thief("+pl.otm+") <- ["+pl.perksteal_lvl+"/"+perksteal_maxlvl+"]\n";
    if(pl.perkluck_lvl > 0)
        text += "Lucky Warrior <- ["+pl.perkluck_lvl+"/"+perkluck_maxlvl+"]\n";
    if(text == "")
        text += "No perks";
    return text;
}

function PrintText_Perk_zm(pl)
{
    local text = "";
    if(pl.perkhp_zm_lvl > 0)
        text += "Zombie HP <- ["+pl.perkhp_zm_lvl+"/"+400+"]\n";
    if(pl.perkspeed_lvl > 0)
        text += "Zombie Speed <- ["+pl.perkspeed_lvl+"/"+perkspeed_maxlvl+"]\n";
    if(pl.perkchameleon_lvl > 0)
        text += "Zombie Chameleon <- ["+pl.perkchameleon_lvl+"/"+perkchameleon_maxlvl+"]\n";
    if(pl.perkresist_zm_lvl > 0)
        text += "Human Materia Resist <- ["+pl.perkresist_zm_lvl+"/"+50+"]\n";
    if(text == "")
        text += "No Zombie perks";
    return text;
}

function PrintText_Perk_hm(pl)
{
    local text = "";
    if(pl.perkhp_hm_lvl > 0)
        text += "Human HP <- ["+pl.perkhp_hm_lvl+"/"+400+"]\n";
    if(pl.perkresist_hm_lvl > 0)
        text += "Attack Resist <- ["+pl.perkresist_hm_lvl+"/"+perkresist_hm_maxlvl+"]\n";
    if(pl.item_buff_radius || pl.item_buff_last || pl.item_buff_recovery || pl.item_buff_turbo || pl.item_buff_doble)
        text += "Support Materia <- "+((pl.item_buff_radius) ? "All" : (pl.item_buff_last) ? "Final Attack" : (pl.item_buff_recovery) ? "Recovery" : (pl.item_buff_last) ? "MP turbo" : "W-magic")+"\n";
    if(text == "")
        text += "No Human perks";
    return text;
}