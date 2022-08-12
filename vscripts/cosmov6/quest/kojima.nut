::g_aChest <- ["models/props/crates/csgo_drop_crate_shadow.mdl"];
self.PrecacheModel(g_aChest[0]);
::Kojima <- self;
{
    class loader
    {
        handle = null;
        chests = null;
        userid = 0;

        location = -1;

        constructor(_handle, _userid, _location, count)
        {
            this.handle = _handle;
            this.chests = [];
            this.userid = _userid;
            this.location = _location;

            EntFireByHandle(MainScript, "RunScriptCode", "GetPlayerClassByHandle(activator).invalid = true;", 0, this.handle, this.handle);

            this.AddChest(count);

            EntFireByHandle(MainScript, "RunScriptCode", "SlowPlayer(-" + g_fChest_Speed * count + ",-1)", 0, this.handle, this.handle);
        }

        function AddChest(count) 
        {

            if(count <= g_aBonus.len())
            {
                for(local i = 0; i < count; i++)
                {
                    this.chests.push(this.CreateChest());
                }

                this.ChestPos();
            }
        }

        function ChestPos() 
        {
            local start = 5;
            local modif = 24;

            for(local i = 0; i < this.chests.len(); i++)
            {
                if(this.chests[i].GetMoveParent() == null)
                {
                    local pos = this.handle.GetOrigin() + Vector();
                    local movedir = this.handle.GetForwardVector() * -28;
                    local ang = this.handle.GetAngles();

                    this.chests[i].SetOrigin(pos + movedir + Vector(0, 0, start + modif * ((this.chests.len() == 1) ? 1 : i)));
                    this.chests[i].SetAngles(0, ang.y + -90, 0);

                    EntFireByHandle(this.chests[i], "SetParent", "!activator", 0, this.handle, this.handle);
                }
            }
        }

        function CreateChest() 
        {
            local ent = Entities.CreateByClassname("prop_dynamic_glow")
            ent.__KeyValueFromInt("solid", 0);
            ent.__KeyValueFromInt("rendermode", 1);

            if (this.location == 0)
            {
                ent.__KeyValueFromString("glowcolor", "255 0 0");
            }
            else if (this.location == 1)
            {
                ent.__KeyValueFromString("glowcolor", "0 255 0");
            }
            else if (this.location == 2)
            {
                ent.__KeyValueFromString("glowcolor", "0 0 255");
            }
            else if (this.location == 3)
            {
                ent.__KeyValueFromString("glowcolor", "255 255 255");
            }

            ent.__KeyValueFromInt("glowstyle", 1);
            ent.__KeyValueFromInt("glowdist", 1024);
            ent.__KeyValueFromInt("glowenabled", 1);
            
            ent.__KeyValueFromInt("renderamt", 0);
            ent.__KeyValueFromInt("disableshadows", 1);
            ent.__KeyValueFromString("targetname", "kojima_chest_" + this.userid);
            ent.SetModel(g_aChest[0]);
            return ent;
        }

        function Destroy() 
        {
            local count = this.chests.len();
            for(local i = 0; i < count; i++)
                if(this.chests[i].IsValid())
                    EntFireByHandle(this.chests[i], "FadeAndKill", "", 0.00, null, null);
            return count
        }
    }

    g_iAllow_Kojima <- 3;
    ::g_fChest_Speed <- 0.12;
    g_iChest_Money <- 5;
    g_aLoaders <- [];
    ::g_aBonus <- [4.0, 1.5, 1.75, 2.5];

    function Create(location, count) 
    {
        if(GetLoaderClassByHandle(activator) != null || activator.GetTeam() == 2 || g_iAllow_Kojima <= 0)
            return;
        
        local id = null;
        id = MainScript.GetScriptScope().GetPlayerClassByHandle(activator); 
        if(id == null)
            id = 0;
        else 
            id = id.userid;

        EntFire("kojima_particle_0"+location, "Start", "", 1.00, null);

        g_iAllow_Kojima--;
        g_aLoaders.push(loader(activator, id, location, count));

        local player_class = MainScript.GetScriptScope().GetPlayerClassByHandle(activator);
        ScriptPrintMessageChatAll(Chat_pref + "\x04" + player_class.name + "\x01 {\x07" + player_class.steamid + "\x01} took\x04 " + count + "\x01 crates to the\x04 " + ((location == 0) ? "Chocobo farm" : (location == 1) ? "Bar" : (location == 2) ? "After Bar" : "Cave"));  
    }


    function Touch(ID) 
    {
        local loader_class = GetLoaderClassByHandle(activator);
        if(loader_class == null || loader_class.handle.GetTeam() == 2)
            return;
        if(loader_class.location != ID)
            return;
        
        local result = loader_class.Destroy();

        for(local i = 0; i < g_aLoaders.len(); i++)
        {
            if(g_aLoaders[i].handle == activator)
            {
                g_aLoaders.remove(i);
            }
        }

        if (GetCountOfChestLocation(ID) < 1)
        {
            EntFire("kojima_particle_0"+ID, "Kill", "", 1.00, null);
            EntFire("kojima_trigger_0"+ID, "Kill", "", 1.00, null);
        }
        

        EntFireByHandle(MainScript, "RunScriptCode", "GetPlayerClassByHandle(activator).invalid = false;", 0, activator, activator);
        EntFireByHandle(MainScript, "RunScriptCode", "SlowPlayer(" + g_fChest_Speed * result + ",-1)", 0, activator, activator);

        MainScript.GetScriptScope().AddCashAll(result * g_iChest_Money * g_aBonus[ID], 3)
    }

    function GetCountOfChestLocation(ID)
    {
        local count = 0;
        for (local i = 0; i < g_aLoaders.len(); i++)
        {
            if (g_aLoaders[i].location == ID)
            {
                if (g_aLoaders[i].handle.IsValid() && 
                g_aLoaders[i].handle.GetTeam() == 3 && 
                g_aLoaders[i].handle.GetHealth() > 0)
                {
                    count++;
                }
            }
        }
        return count;
    }

    function GetLoaderClassByHandle(value)
    {
        foreach(nvalue in g_aLoaders)
        {
            if(nvalue.handle == value)
                return nvalue;
        }
        return null;
    }
}

{
    class menu_point 
    {
        name = null;
        input = null;
        
        constructor(_name, _input)
        {
            this.name = _name;
            this.input = _input;
        }
    }

    ::Location_menu <- [
        menu_point("Select Location", ""),
        
        menu_point("Chocobo farm", "chocobo"),
        menu_point("Bar", "bar"),
        menu_point("After Bar", "afterbar"),
        menu_point("Cave", "cave"),

        menu_point("Exit", "getout"),
    ];

    ::Chest_menu <- [
        menu_point("Select Count", ""),
        
        menu_point("1", "chest1"),
        menu_point("2", "chest2"),
        menu_point("3", "chest3"),
        menu_point("4", "chest4"),

        menu_point("Exit", "location"),
    ];

    PLAYERS_DISPLAY <- [];

    class player_display
    {
        player = null;

        game_ui = null;
        game_text = null;

        active_ID = 1;
        active_menu = Location_menu;
        back_menu = "Exit";

        intput1 = 0;
    
        constructor(handle)
        {
            this.player = handle;

            this.game_ui = Entities.CreateByClassname("game_ui");
            this.game_ui.__KeyValueFromInt("spawnflags", 480);

            EntFireByHandle(this.game_ui, "AddOutPut", "PressedAttack " + Kojima.GetName() + ":RunScriptCode:MoveMenu(true):0:-1", 0.01, null, null);
            EntFireByHandle(this.game_ui, "AddOutPut", "PressedAttack2 " + Kojima.GetName() + ":RunScriptCode:MoveMenu(false):0:-1", 0.01, null, null);
            EntFireByHandle(this.game_ui, "AddOutPut", "PressedForward " + Kojima.GetName() + ":RunScriptCode:MovePointer(true):0:-1", 0.01, null, null);
            EntFireByHandle(this.game_ui, "AddOutPut", "PressedBack " + Kojima.GetName() + ":RunScriptCode:MovePointer(false):0:-1", 0.01, null, null);
            EntFireByHandle(this.game_ui, "AddOutPut", "PlayerOff " + Kojima.GetName() + ":RunScriptCode:Disconnect():0:-1", 0.01, null, null);
            EntFireByHandle(this.game_ui, "AddOutPut", "PlayerOn " + Kojima.GetName() + ":RunScriptCode:ShowMenu():0:-1", 0.01, null, null);
        
            EntFireByHandle(this.game_ui, "Activate", "", 0.05, this.player, this.player);

            this.game_text = Entities.CreateByClassname("game_text");
            this.game_text.__KeyValueFromInt("spawnflags", 0);
            this.game_text.__KeyValueFromInt("channel", 3);
            this.game_text.__KeyValueFromVector("color", Vector(255, 255, 255));
            this.game_text.__KeyValueFromFloat("y", 0.6);
            this.game_text.__KeyValueFromFloat("x", -1.0);
            this.game_text.__KeyValueFromFloat("holdtime", 5.0);
        }

        function MoveMenu(bForward) 
        {
            if(bForward)
            {   
                local Point = this.active_menu[this.active_ID].input;

                if(Point == "chocobo")
                {
                    this.intput1 = 0;
                    this.active_menu = Chest_menu;
                    this.back_menu = "Loc";
                }
                else if(Point == "bar")
                {
                    this.intput1 = 1;
                    this.active_menu = Chest_menu;
                    this.back_menu = "Loc";
                }
                else if(Point == "afterbar")
                {
                    this.intput1 = 2;
                    this.active_menu = Chest_menu;
                    this.back_menu = "Loc";
                }
                else if(Point == "cave")
                {
                    this.intput1 = 3;
                    this.active_menu = Chest_menu;
                    this.back_menu = "Loc";
                }
                else if(Point == "getout")
                {
                    return true;
                }
                else if(Point == "chest1")
                {
                    EntFireByHandle(Kojima, "RunScriptCode", "Create(" + this.intput1 + ",1);", 0, this.player, this.player);
                    return true;
                }
                else if(Point == "chest2")
                {
                    EntFireByHandle(Kojima, "RunScriptCode", "Create(" + this.intput1 + ",2);", 0, this.player, this.player);
                    return true;
                }
                else if(Point == "chest3")
                {
                    EntFireByHandle(Kojima, "RunScriptCode", "Create(" + this.intput1 + ",3);", 0, this.player, this.player);
                    return true;
                }
                else if(Point == "chest4")
                {
                    EntFireByHandle(Kojima, "RunScriptCode", "Create(" + this.intput1 + ",4);", 0, this.player, this.player);
                    return true;
                }
                else if(Point == "location")
                {
                    this.intput1 = null;
                    this.active_menu = Location_menu;
                    this.back_menu = "Exit";
                }
            }
            else
            {
                if(this.back_menu == "Exit")
                    return true;

                if(this.back_menu == "Loc")
                {
                    this.intput1 = null;
                    this.active_menu = Location_menu;
                }
                    
            }

            this.active_ID = 1;

            this.DisplayMenu();
            
            return false; 
        }

        function MovePointer(bForward) 
        {
            if(bForward)
            {
                if(this.active_ID == 1)
                    this.active_ID = this.active_menu.len() - 1;
                else
                    this.active_ID--;
            }
            else
            {
                if(this.active_ID == this.active_menu.len() - 1)
                    this.active_ID = 1;
                else
                    this.active_ID++;
            }

            this.DisplayMenu();
        }

        function DisplayMenu() 
        {
            local text = " >> " + this.active_menu[0].name + " <<\n\n";

            for(local i = 1; i < this.active_menu.len(); i++)
            {
                if(this.active_ID == i)
                    text += "> ";

                text += this.active_menu[i].name;

                if(this.active_ID == i)
                    text += " <";

                if(i + 1 < this.active_menu.len())
                    text += "\n";
            }
            
            this.PrintMenu(text); 
        }

        function PrintMenu(text) 
        {
            this.game_text.__KeyValueFromString("message", text);
            EntFireByHandle(this.game_text, "Display", "", 0, this.player, this.player);
        }

        function Destroy() 
        {
            if(this.game_text.IsValid())
            {
                this.PrintMenu(""); 
                this.game_text.Destroy();
            }
            if(this.game_ui.IsValid())
                this.game_ui.Destroy();
        }
    }

    function MoveMenu(bForward)
    {
        local player_display_class = GetPlayerDisplayByPlayer(activator);
        if(player_display_class == null)
            return;
        if(player_display_class.MoveMenu(bForward))
        {
            EntFireByHandle(caller, "Deactivate", "", 0, activator, activator);
        }
    }

    function MovePointer(bForward) 
    {
        local player_display_class = GetPlayerDisplayByPlayer(activator);
        if(player_display_class == null)
            return;

        player_display_class.MovePointer(bForward);
    }

    function Disconnect()
    {
        PlayerDisplayDestroy(activator);
    }

    function ShowMenu() 
    {
        local player_display_class = GetPlayerDisplayByPlayer(activator);
        if(player_display_class == null)
            return;
        
        player_display_class.DisplayMenu();
    }

    function Connect() 
    {
        local player_display_class = GetPlayerDisplayByPlayer(activator);
        local waffel_car = Entities.FindByName(null, "waffel_controller");
        local waffel_class = waffel_car.GetScriptScope().GetClassByInvalid(activator)
        if(player_display_class != null || waffel_class != null)
            return;
            

        if(GetLoaderClassByHandle(activator) != null || activator.GetTeam() == 2)
            return;
    
        PLAYERS_DISPLAY.push(player_display(activator));
    }

    function PlayerDisplayDestroy(activator) 
    {
        for(local i = 0; i < PLAYERS_DISPLAY.len(); i++)
        {
            if(PLAYERS_DISPLAY[i].player == activator)
            {
                PLAYERS_DISPLAY[i].Destroy();
                PLAYERS_DISPLAY.remove(i);
                return;
            }
        } 
    }

    function GetPlayerDisplayByPlayer(value) 
    {
        foreach(nvalue in PLAYERS_DISPLAY)
        {
            if(nvalue.player == value)
                return nvalue;
        }
        return null;
    }
}