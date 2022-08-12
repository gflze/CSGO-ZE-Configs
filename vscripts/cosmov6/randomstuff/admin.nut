map_brush <- Entities.FindByName(null, "map_brush");

//Хандлы
Owner <- null;
Menu_text <- [];

for(local i = 2; i <= 6; i++)
{
    Menu_text.push(EntityGroup[i]);
}

Menu_Title <- EntityGroup[0];
Menu_Description <- EntityGroup[1];
Controller <- EntityGroup[7];
Trigger_Controller <- EntityGroup[8];
//Классы
class menu_point
{
    input = null;
    name = null;
    description = null;
    constructor(_name, _input, _description)
    {
        this.name = _name;
        this.input = _input;
        this.description = _description;
    }
}
//Пункты меню
MainMenuPoint <- [
    menu_point("Set Stage", "menustage", "Set stage immediately"),
    //menu_point("Set Invalid", "menuinvalid", "Set Invalid"),
    menu_point("Set VIP", "menuvip", "Set VIP status"),
    //menu_point("Set Mapper", "menumapper", "Set Mapper status"),
    menu_point("Give Money", "menuaddmoney", "Give Money to players"),
    menu_point("Take Money", "menuremovemoney", "Take Money from players"),
    menu_point("Death Note", "menuslay", "It's death note"),
    menu_point("Special Settings", "menusetting", "Special Settings"),
    menu_point("Spawn Materias and Items", "menuspawnitem", "Spawn Materias and Items"),
    menu_point("Exit", "input:getout", "Exit the Admin Room")];

StageMenuPoint <- [
    menu_point("Normal", "input:stage:1", "Set Normal stage"),
    menu_point("Hard", "input:stage:2", "Set Hard stage"),
    menu_point("ZM", "input:stage:3", "Set ZM stage"),
    menu_point("Extreme", "input:stage:4", "Set Extreme stage"),
    menu_point("Inferno", "input:stage:5", "Set Inferno stage"),];

ItemsMenuPoint <- [
    menu_point("Bio", "input:spawnitem:" + TEMP_BIO, "Spawn Bio Materia"),
    menu_point("Earth", "input:spawnitem:" + TEMP_EARTH, "Spawn Earth Materia"),
    menu_point("Ice", "input:spawnitem:" + TEMP_ICE, "Spawn Ice Materia"),
    menu_point("Fire", "input:spawnitem:" + TEMP_FIRE, "Spawn Fire Materia"),
    menu_point("Summon", "input:spawnitem:" + TEMP_SUMMON, "Spawn Summon Materia"),
    menu_point("Electro", "input:spawnitem:" + TEMP_ELECTRO, "Spawn Electro Materia"),
    menu_point("Gravity", "input:spawnitem:" + TEMP_GRAVITY, "Spawn Gravity Materia"),
    menu_point("Heal", "input:spawnitem:" + TEMP_HEAL, "Spawn Heal Materia"),
    menu_point("Wind", "input:spawnitem:" + TEMP_WIND, "Spawn Wind Materia"),
    menu_point("Ultima", "input:spawnitem:" + TEMP_ULTIMATE, "Spawn Ultima Materia"),
    menu_point("Poison", "input:spawnitem:" + TEMP_POISON, "Spawn Poison Materia"),
    menu_point("Potion", "input:spawnitem:" + TEMP_POTION, "Spawn Potion Item"),
    menu_point("Ammo", "input:spawnitem:" + TEMP_AMMO, "Spawn Ammo Item"),
    menu_point("Phoenix", "input:spawnitem:" + TEMP_PHOENIX, "Spawn Phoenix Item"),
    ];

MoneyAddMenuPoint <- [
    menu_point("1", "input:moneyadd:1", "Give 1 Money"),
    menu_point("5", "input:moneyadd:5", "Give 5 Money"),
    menu_point("25", "input:moneyadd:25", "Give 25 Money"),
    menu_point("100", "input:moneyadd:100", "Give 100 Money"),
    menu_point("500", "input:moneyadd:500", "Give 500 Money"),];

MoneyRemoveMenuPoint <- [
    menu_point("1", "input:moneyremove:1", "Take 1 Money"),
    menu_point("5", "input:moneyremove:5", "Take 5 Money"),
    menu_point("25", "input:moneyremove:25", "Take 25 Money"),
    menu_point("100", "input:moneyremove:100", "Take 100 Money"),
    menu_point("500", "input:moneyremove:500", "Take 500 Money"),
    menu_point("All", "input:moneyremove:0", "Take All Money"),];

//Основные переменные
Active_Title <- "<>"
Active_Menu <- MainMenuPoint; //Активное меню
Active_ID <- 0;               //Активный айди
Back_Menu <- "Exit";          //Что будет при нажатии назад
//Подключение игрока
function Connect()
{
    Owner = activator;

    local player_class = map_brush.GetScriptScope().GetPlayerClassByHandle(activator);

    ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} used\x07 Admin Panel");

    EntFireByHandle(Trigger_Controller, "Disable", "", 0, null, null);
    EntFireByHandle(Controller, "Activate", "", 0, activator, activator);

    PrintMenu();
}
//Выход игрока
function DisConnect(gameui = false)
{
    Reset();

    if(gameui)
        EntFireByHandle(Controller, "Deactivate", "", 0, null, null);
    EntFireByHandle(Trigger_Controller, "Enable", "", 2, null, null);

    Owner = null;
    PrintMenu();
}
//Сброс пунктов
function Reset()
{
    Active_Title <- "<>"
    Active_Menu = MainMenuPoint;
    Active_ID = 0;
    Back_Menu = "Exit";
}
//Движение в меню
function MovePointer(bForward)
{
    if(bForward)
    {
        if(Active_ID == 0)
            Active_ID = Active_Menu.len() - 1;
        else
            Active_ID--;
    }
    else
    {
        if(Active_ID == Active_Menu.len() - 1)
            Active_ID = 0;
        else
            Active_ID++;
    }
    PrintMenu();
}
//Возращение в прошлый пункт
function Back()
{
    if(Back_Menu == "Exit")
    {
        DisConnect(true);
        return;
    }

    if(Back_Menu == "MainMenuPoint")
    {
        Reset();
    }

    else if(Back_Menu == "MoneyAddMenuPoint")
    {
        Active_Title = "< Give Money >"
        Back_Menu = "MainMenuPoint";
        Active_Menu = MoneyAddMenuPoint;
    }

    else if(Back_Menu == "MoneyRemoveMenuPoint")
    {
        Active_Title = "< Take Money >"
        Back_Menu = "MainMenuPoint";
        Active_Menu = MoneyRemoveMenuPoint;
    }
    Active_ID = 0;
    PrintMenu();
}

//Нажатие выбора
function Forward()
{
    local Point = Active_Menu[Active_ID].input;
    local toggle = true;
    if(Point == "menustage")
    {
        Active_Title = "< Set Stage >"
        Back_Menu = "MainMenuPoint";
        Active_Menu = StageMenuPoint;
    }

    else if(Point == "menuinvalid")
    {
        Active_Title = "< Set Invalid >"
        Back_Menu = "MainMenuPoint";
        Active_Menu = BuildMenu("invalid");
    }

    else if(Point == "menuvip")
    {
        Active_Title = "< Set VIP status >"
        Back_Menu = "MainMenuPoint";
        Active_Menu = BuildMenu("vip");
    }

    else if(Point == "menumapper")
    {
        Active_Title = "< Set Mapper status >"
        Back_Menu = "MainMenuPoint";
        Active_Menu = BuildMenu("mapper");
    }

    else if(Point == "menuslay")
    {
        Active_Title = "< Death Note >"
        Back_Menu = "MainMenuPoint";
        Active_Menu = BuildMenu("menuslay");
    }

    else if(Point == "menusetting")
    {
        Active_Title = "< Special Settings >"
        Back_Menu = "MainMenuPoint";
        Active_Menu = BuildMenu("settings");
    }

    else if(Point == "menuaddmoney")
    {
        Active_Title = "< Give Money >"
        Back_Menu = "MainMenuPoint";
        Active_Menu = MoneyAddMenuPoint;
        //Active_Menu = BuildMenu("menuaddmoney");
    }

    else if(Point == "menuremovemoney")
    {
        Active_Title = "< Take Money >"
        Back_Menu = "MainMenuPoint";
        Active_Menu = MoneyRemoveMenuPoint;
        //Active_Menu = BuildMenu("menuremovemoney");
    }

    else if(Point == "menuspawnitem")
    {
        Active_Title = "< Spawn Materias and Items >"
        Back_Menu = "MainMenuPoint";
        Active_Menu = ItemsMenuPoint;
    }
    //Инпуты
    else if(Point.find("input:") != null)
    {
        toggle = false;
        local array_split = split(Point, ":");
        if(array_split[1] == "stage")
        {
            map_brush.GetScriptScope().AdminSetStage(array_split[2].tointeger())
        }

        else if(array_split[1] == "getout")
        {
            Owner.SetOrigin(Vector(4886, -4551, 392));
            Owner.SetAngles(0, 90, 0);
            DisConnect(true);
        }

        else if(array_split[1] == "autoretry")
        {
            AUTO_RETRY_ENABLE = array_split[2].tointeger();
            Active_Menu = BuildMenu("settings");
        }

        else if(array_split[1] == "waffelcars")
        {
            WAFFEL_CAR_ENABLE = array_split[2].tointeger();
            Active_Menu = BuildMenu("settings");
        }

        else if(array_split[1] == "bhop")
        {
            BHOP_ENABLE = array_split[2].tointeger();
            SendToConsoleServerPS("sv_enablebunnyhopping " + array_split[2].tointeger());

            Active_Menu = BuildMenu("settings");
        }

        else if(array_split[1] == "dodje")
        {
            DODJE_ENABLE = array_split[2].tointeger();
            Active_Menu = BuildMenu("settings");
        }

        else if(array_split[1] == "glow")
        {
            ITEM_GLOW = array_split[2].tointeger();
            Active_Menu = BuildMenu("settings");
        }

        else if(array_split[1] == "ewteam")
        {
            ENT_WATCH_TEAM = array_split[2].tointeger();
            Active_Menu = BuildMenu("settings");
        }

        else if(array_split[1] == "color")
        {
            COLOR_ENABLE = array_split[2].tointeger();
            if(COLOR_ENABLE)
                EntFire("map_colorcorrection", "Enable", "", 0);
            else
                EntFire("map_colorcorrection", "Disable", "", 0);
            Active_Menu = BuildMenu("settings");
        }


        else if(array_split[1] == "removevip")
        {
            map_brush.GetScriptScope().GetPlayerClassByUserID(array_split[2].tointeger()).vip = false;
            Active_Menu = BuildMenu("vip");
        }

        else if(array_split[1] == "setvip")
        {
            map_brush.GetScriptScope().GetPlayerClassByUserID(array_split[2].tointeger()).vip = true;
            Active_Menu = BuildMenu("vip");
        }

        else if(array_split[1] == "removemapper")
        {
            map_brush.GetScriptScope().GetPlayerClassByUserID(array_split[2].tointeger()).mapper = false;
            Active_Menu = BuildMenu("mapper");
        }

        else if(array_split[1] == "setmapper")
        {
            map_brush.GetScriptScope().GetPlayerClassByUserID(array_split[2].tointeger()).mapper = true;
            Active_Menu = BuildMenu("mapper");
        }

        else if(array_split[1] == "removeinvalid")
        {
            map_brush.GetScriptScope().GetPlayerClassByUserID(array_split[2].tointeger()).invalid = false;
            Active_Menu = BuildMenu("invalid");
        }

        else if(array_split[1] == "setinvalid")
        {
            map_brush.GetScriptScope().GetPlayerClassByUserID(array_split[2].tointeger()).invalid = true;
            Active_Menu = BuildMenu("invalid");
        }

        else if(array_split[1] == "moneyremove")
        {
            Active_ID = 0;
            Back_Menu = "MoneyRemoveMenuPoint";
            if("0" != array_split[2])
            {
                Active_Title = "< Take "+array_split[2].tointeger()+" Money >"
            }
            else
            {
                Active_Title = "< Take All Money >"
            }
            Active_Menu = BuildMenu("menuremovemoney", array_split[2].tointeger());
        }

        else if(array_split[1] == "moneyadd")
        {
            Active_ID = 0;
            Active_Title = "< Give "+array_split[2].tointeger()+" Money >"
            Back_Menu = "MoneyAddMenuPoint";
            Active_Menu = BuildMenu("menuaddmoney", array_split[2].tointeger());
        }

        else if(array_split[1] == "removemoney")
        {
            Back_Menu = "MoneyRemoveMenuPoint";
            if("0" != array_split[3])
            {
                Active_Title = "< Take "+array_split[3]+" Money >"
                map_brush.GetScriptScope().GetPlayerClassByUserID(array_split[2].tointeger()).Minus_money(array_split[3].tointeger());
            }
            else
            {
                Active_Title = "< Take All Money >"
                map_brush.GetScriptScope().GetPlayerClassByUserID(array_split[2].tointeger()).money = 0;
            }

            Active_Menu = BuildMenu("menuremovemoney", array_split[3].tointeger());
        }
        else if(array_split[1] == "addmoney")
        {
            Active_Title = "< Give "+array_split[3].tointeger()+" Money >"
            Back_Menu = "MoneyAddMenuPoint";
            map_brush.GetScriptScope().GetPlayerClassByUserID(array_split[2].tointeger()).Add_money(array_split[3].tointeger(), false);
            Active_Menu = BuildMenu("menuaddmoney", array_split[3].tointeger());
        }

        else if(array_split[1] == "slay")
        {
            if(array_split[2] == "all")
            {
                local h = null;
                while(null != (h = Entities.FindByClassname(h, "player")))
                {
                    if(h == null)
                        continue;
                    if(!h.IsValid())
                        continue;
                    if(h.GetHealth() <= 0)
                        continue;
                    if(h.GetTeam() == 1)
                        continue;
                    EntFireByHandle(h, "SetHealth", "-1", 0, null, null);
                }
            }
            else if(array_split[2] == "ct")
            {
                local h = null;
                while(null != (h = Entities.FindByClassname(h, "player")))
                {
                    if(h == null)
                        continue;
                    if(!h.IsValid())
                        continue;
                    if(h.GetHealth() <= 0)
                        continue;
                    if(h.GetTeam() != 3)
                        continue;
                    EntFireByHandle(h, "SetHealth", "-1", 0, null, null);
                }
            }
            else if(array_split[2] == "t")
            {
                local h = null;
                while(null != (h = Entities.FindByClassname(h, "player")))
                {
                    if(h == null)
                        continue;
                    if(!h.IsValid())
                        continue;
                    if(h.GetHealth() <= 0)
                        continue;
                    if(h.GetTeam() != 2)
                        continue;
                    EntFireByHandle(h, "SetHealth", "-1", 0, null, null);
                }
            }
            else
            {
                local pl = map_brush.GetScriptScope().GetPlayerClassByUserID(array_split[2].tointeger());
                EntFireByHandle(pl.handle, "SetHealth", "-1", 0, null, null);
                ScriptPrintMessageChatAll("["+ RED +"Death Note\x01] " + GREEN + pl.name + "\x01 - Died of a heart attack");
            }
            Active_Menu = BuildMenu("menuslay");
        }
        else if(array_split[1] == "spawnitem")
        {
            local temp = Entities.FindByName(null, (array_split[2]));
            local maker = Entities.CreateByClassname("env_entity_maker");
            maker.__KeyValueFromString("EntityTemplate", (array_split[2]))
            maker.SpawnEntityAtLocation(Trigger_Controller.GetOrigin(), Vector(0, 0, 0));
            maker.Destroy();
        }
    }
    if(toggle)
        Active_ID = 0;
    PrintMenu();
}

//Меню с игроками
function BuildMenu(value, count = 0)
{
    local NewMenu = []
    local PL_array = map_brush.GetScriptScope().PLAYERS;
    if(value == "vip")
    {
        foreach(p in PL_array)
        {
            if(p.vip)
                NewMenu.push(menu_point(p.name + "[VIP]", "input:removevip:"+p.userid, "STEAM ID : "+p.steamid))
            else
                NewMenu.push(menu_point(p.name, "input:setvip:"+p.userid, "STEAM ID : "+p.steamid))
        }
    }
    if(value == "mapper")
    {
        foreach(p in PL_array)
        {
            if(p.mapper)
                NewMenu.push(menu_point(p.name + "[Mapper]", "input:removemapper:"+p.userid, "STEAM ID : "+p.steamid))
            else
                NewMenu.push(menu_point(p.name, "input:setmapper:"+p.userid, "STEAM ID : "+p.steamid))
        }
    }
    else if(value == "invalid")
    {
        foreach(p in PL_array)
        {
            if(p.invalid)
                NewMenu.push(menu_point(p.name + "[INVALID]", "input:removeinvalid:"+p.userid, "STEAM ID : "+p.steamid))
            else
                NewMenu.push(menu_point(p.name, "input:setinvalid:"+p.userid, "STEAM ID : "+p.steamid))
        }
    }
    else if(value == "menuremovemoney")
    {
        foreach(p in PL_array)
        {
            NewMenu.push(menu_point(p.name + "[" + p.money + "]", "input:removemoney:"+p.userid+":"+count.tointeger(), "STEAM ID : "+p.steamid))
        }
    }
    else if(value == "menuaddmoney")
    {
        foreach(p in PL_array)
        {
            NewMenu.push(menu_point(p.name + "[" + p.money + "]", "input:addmoney:"+p.userid+":"+count.tointeger(), "STEAM ID : "+p.steamid))
        }
    }
    else if(value == "menuslay")
    {
        NewMenu.push(menu_point("All", "input:slay:all", "All cringe"));
        NewMenu.push(menu_point("CT", "input:slay:ct", "All CT cringe"));
        NewMenu.push(menu_point("T", "input:slay:t", "All T cringe"));
        foreach(p in PL_array)
        {
            if(!p.handle.IsValid())
                continue;

            if(p.handle.GetHealth() <= 0)
                continue;

            if(p.handle.GetTeam() == 1)
                continue;

            NewMenu.push(menu_point(p.name + "[" + ((p.handle.GetTeam() == 3) ? "CT" : "T") + "]", "input:slay:"+p.userid, "STEAM ID : "+p.steamid))
        }
    }
    else if(value == "settings")
    {
        NewMenu.push(menu_point((AUTO_RETRY_ENABLE) ? "Auto retry[Enable]" : "Auto retry[Disable]", (AUTO_RETRY_ENABLE) ? "input:autoretry:0" : "input:autoretry:1", "Toggle auto retry"));
        NewMenu.push(menu_point((WAFFEL_CAR_ENABLE) ? "Waffel cars[Enable]" : "Waffel cars[Disable]", (WAFFEL_CAR_ENABLE) ? "input:waffelcars:0" : "input:waffelcars:1", "Toggle Waffel cars"));
        NewMenu.push(menu_point((BHOP_ENABLE) ? "BHOP[Enable]" : "BHOP[Disable]", (BHOP_ENABLE) ? "input:bhop:0" : "input:bhop:1", "Toggle BHOP"));
        //NewMenu.push(menu_point((DODJE_ENABLE) ? "DODJE[Enable]" : "DODJE[Disable]", (DODJE_ENABLE) ? "input:dodje:0" : "input:dodje:1", "Toggle DODJE"));
        NewMenu.push(menu_point((ITEM_GLOW) ? "ITEM GLOW[Enable]" : "ITEM GLOW[Disable]", (ITEM_GLOW) ? "input:glow:0" : "input:glow:1", "Toggle ITEM GLOW"));
        NewMenu.push(menu_point((ENT_WATCH_TEAM) ? "ENT_WATCH TEAM[Enable]" : "ENT_WATCH TEAM[Disable]", (ENT_WATCH_TEAM) ? "input:ewteam:0" : "input:ewteam:1", "Toggle ENT_WATCH TEAM"));
        NewMenu.push(menu_point((COLOR_ENABLE) ? "Color Correction[Enable]" : "Color CorrectionW[Disable]", (COLOR_ENABLE) ? "input:color:0" : "input:color:1", "Toggle Color Correction"));
    }
    return NewMenu
}

function PrintMenu()
{
    SetText(Menu_text[0], Active_Menu[GiveIDtoPrint(Active_ID - 2)].name);
    SetText(Menu_text[1], Active_Menu[GiveIDtoPrint(Active_ID - 1)].name);
    SetText(Menu_text[2], Active_Menu[GiveIDtoPrint(Active_ID)].name);
    SetText(Menu_text[3], Active_Menu[GiveIDtoPrint(Active_ID + 1)].name);
    SetText(Menu_text[4], Active_Menu[GiveIDtoPrint(Active_ID + 2)].name);

    SetText(Menu_Title, Active_Title);
    SetText(Menu_Description, Active_Menu[GiveIDtoPrint(Active_ID)].description);
}

function GiveIDtoPrint(id)
{
    if(id < 0)
        return GiveIDtoPrint(Active_Menu.len() + id);
    else if(id > Active_Menu.len() - 1)
        return GiveIDtoPrint(id % Active_Menu.len());
    else
        return id;
}
function SetText(handle, text)
{
    handle.__KeyValueFromString("message", (text).tostring());
}