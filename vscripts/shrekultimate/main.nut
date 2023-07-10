Language <- true;
Chat_pref <- " \x07[\x04MAP\x07]\x09 ";
Shrek_pref <- " \x07[\x04SHREK\x07]\x09 "
Donkey_pref <- " \x07[\x04DONKEY\x07]\x09 ";

CT_MODEL <-     "models/player/custom_player/kuristaja/shrek/shrek.mdl";
T_MODELS <- [   "models/player/custom_player/kodua/xmas_gorefiend/xmas_gorefiend.mdl",
                "models/player/custom_player/kodua/xmas_gorefast/xmas_gorefast.mdl",];

self.PrecacheModel(CT_MODEL);
self.PrecacheModel(T_MODELS[0]);
self.PrecacheModel(T_MODELS[1]);

Spawner <- Entities.FindByName(null, "map_spawner");

iHealth <- 10000; //hp zombie
::SpeedMod    <- null;
g_iTicrate <- 1.0;
g_bTicing <- true;
g_bFravity <- false;
g_bSpeed <- false;

g_iTime <- 120;

ArrRU <- [];
ArrEU <- [];
::PLAYERS <- [];

function Touch_Ru()
{
   local index = InRU(activator);
   if (index != -1)
   {
      return;
   }
   index = InEU(activator);
   if (index != -1)
   {
      ArrEU.remove(index);
   }
   ArrRU.push(activator);
   Fade_Green(activator);
}
function Touch_Eu()
{
   local index = InEU(activator);
   if (index != -1)
   {
      return;
   }
   index = InRU(activator);
   if (index != -1)
   {
      ArrRU.remove(index);
   }
   ArrEU.push(activator);
   Fade_Green(activator);
}
function InRU(player)
{
   foreach (index, value in ArrRU)
   {
      if (player == value)
      {
         return index;
      }
   }
   return -1;
}
function InEU(player)
{
   foreach (index, value in ArrEU)
   {
      if (player == value)
      {
         return index;
      }
   }
   return -1;
}


Teleport_Arr <- [
    Vector(-2530.526367, -1391.263916, -51.199356),
    Vector(-1273.924194, -3050.422363, -28.695904),
    Vector(694.670410, -2843.542480, 38.693134),
    Vector(1605.417847, -1682.423706, 31.984467),
    Vector(-177.361053, 1379.694946, -11.839714),
    Vector(-1614.171997, 2032.861450, 48.603062),
    Vector(-2549.151855, 1541.769531, 8.322521),
    Vector(-2638.563721, 798.130737, -3.063805),
    Vector(-2667.730713, 185.646805, -41.820236),
    Vector(-2721.655273, -492.070435, 4.424897),
    Vector(-3392.894287, 1358.135010, -0.551202),
    Vector(-5071.037598, 1082.884521, -18.381134),
    Vector(-5075.615723, 3.900975, -19.464581),
    Vector(-3134.966064, -1086.830933, 19.337404),
    Vector(-468.275330, 2581.395264, 8.856607),
]; //for humman tp after toilet

function MapTeleport()
{
    activator.SetOrigin(Vector(RandomInt(-6480, -6160),RandomInt(13008,13232),118));
    activator.SetAngles(0,-90,0);
}

function MapStart()
{
    local text;

    text = "Welcome to Shrek's Swamp"
    ServerChat(Chat_pref + text);

    text = "Map by \x04 Biba\x05(\x07Kondik\x05)\x09 & \x04 Boba\x05(\x07HaRyDe\x05)"
    ServerChat(Chat_pref + text);

    text = "Thx \x04LeXeR \x09& \x04Headsh \x09& \x04Kotya \x09&\x04 Friend"
    ServerChat(Chat_pref + text);

    SetModel();
    EntFire("Home_Fire", "startfire","",5);
    EntFire("Spawn_Fire", "startfire","",5);
    EntFire("Temp_SWAMP", "ForceSpawn","",5);
    EntFire("Map_TP", "Enable","",10);
    EntFire("map_tone", "FireUser4","",10);
    EntFire("Item_DONKEY_Temp", "ForceSpawn","",10);
    EntFire("Music", "RunScriptCode","GetRandomMusic();",10);
    EntFireByHandle(self, "RunScriptCode", "SelectLanguage();", 9.9,null,null);
    EntFireByHandle(self, "RunScriptCode", "Hold();", 20.1,null,null);
    EntFireByHandle(self, "RunScriptCode", "SpawnZMItem(0);", 20,null,null);
    EntFireByHandle(self, "RunScriptCode", "SpawnZMItem(0);", 20,null,null);
    EntFireByHandle(self, "RunScriptCode", "SpawnZMItem(1);", 20,null,null);
    EntFireByHandle(self, "RunScriptCode", "SpawnZMItem(1);", 20,null,null);
}


function SelectLanguage()
{
    // printl(""+ArrEU.len());
    // printl(""+ArrRU.len());
    local text;
    if(ArrEU.len() >= ArrRU.len())
    {
        Language = true;

        text = "The selected language is English"
        ServerChat(Chat_pref + text);
    }
    else
    {
        Language = false;
        text = "Выбран русский язык"
        ServerChat(Chat_pref + text);
    }
    //printl("RU : " + ArrRU.len() + " | ENG : " + ArrEU.len()); 
}

function Hold()
{
    local time = 120;
    local text;

    if(!Language)
    text = "\x02 Крестная Фея решила покончить со Шреком раз и навсегда, она превратила местных деревенщин в ходячих пряников, сможете ли вы защитить болото Шрека и спасти принцессу Фиону?"
    else
    text = "\x02 The Fairy Godmother has decided to end with Shrek once and for all, she has turned the local hillbillies into the walking Gingerbread Man, can you defend the Shrek's swamp and save the princess Fiona?"
    ServerChat(Chat_pref + text);

    EntFire("SHREK_Sound", "PlaySound","",10);
    EntFire("Donkey_Train", "FireUser1","",0);
}

function Start()
{
    local text;

    text = "\x02 ( ͡° ͜ʖ ͡°) ( ͡° ͜ʖ ͡°) ( ͡° ͜ʖ ͡°)"
    ServerChat(Chat_pref + text);

    if(!Language)
    text = "Ждем ОСЛА!!!"
    else
    text = "Waiting for the donkey"
    ServerChat(Chat_pref + text, 5);
}

function home()
{
    local text;
    local time = 90;

    EntFire("Music", "Volume","0");
    EntFire("Music", "RunScriptCode","GetRandomMusic();",0.1);
    EntFire("Map_TD", "FireUser1");

        if(!Language)
        text = "Зомби уже на болоте, приготовтесь к обороне дома"
        else
        text = "Zombies are already in the swamp, get ready to defend the house"
        ServerChat(Chat_pref + text);

        if(!Language)
        text = "Дверь в дом скоро откроется"
        else
        text = "The door to the house will open in a ..."
        ServerChat(Chat_pref + text,0.1);

        if(!Language)
        text = "Дом открыт, отступаем"
        else
        text = "The house is open, we retreat"
        ServerChat(Chat_pref + text,40);
        
    EntFireByHandle(self, "RunScriptCode", "iHealth = 1000;", 30, null, null)  
    EntFire("Home_Door_Main", "Open","",30);
    EntFire("Home_ZM_Trigger", "Enable","",35);

        if(!Language)
        text = "Обороняйте дом"
        else
        text = "Protect the house"
        ServerChat(Chat_pref + text,30.1);

    EntFire("Home_Door_Main", "Close","",60);

        if(!Language)
        text = "Мы больше не можем удерживать этот дом..."
        else
        text = "We can no longer hold this house..."
        ServerChat(Chat_pref + text,62);

        if(!Language)
        text = "Отходим в тайное место"
        else
        text = "Let's go to a secret place"
        ServerChat(Chat_pref + text,63);

    EntFire("Temp_Shark", "FireUser1","",60);  
    EntFire("TD_Hurt", "Enable","",60);
    EntFire("Home_Door_Main", "Close","",60);
    EntFire("Home_Door_Back", "Open","",65);
    EntFire("Home_Window_Break", "Break","",67);
    EntFire("Music", "RunScriptCode","SetMusic(Music_2);",67);
    EntFire("Map_Wall_Block1", "kill","",72);
    EntFire("Map_Wall_Block2", "kill","",85);
    EntFire("Map_Wall_Block3", "kill","",95);
}

function Toilet()
{ 
    local text;
    local time = 25;

    if(!Language)
    text = "Похоже мы нашли это тайно место... Осталось открыть дверь"
    else
    text = "Looks like we found this secret place... Just wait for the door to open"
    ServerChat(Chat_pref + text);

    if(!Language)
    text = "Дверь открыта, заходим"
    else
    text = "The door is open, let's go"
    ServerChat(Chat_pref + text,30);

    if(!Language)
    text = "Дверь закроется через 30 секунд"
    else
    text = "The door will close in 30 seconds"
    ServerChat(Chat_pref + text,30);

    if(!Language)
    text = "Дверь закроется через 5 секунд"
    else
    text = "The door will close in 5 seconds"
    ServerChat(Chat_pref + text,55);

    if(!Language)
    text = "Дверь закрывается"
    else
    text = "Closing the door..."
    ServerChat(Chat_pref + text,60);

    if(!Language)
    text = "Быстрее бежим пока зомби в замешательстве"
    else
    text = "Run fast while the zombies are confused"
    ServerChat(Chat_pref + text,63+time);

    EntFire("Map_TD", "FireUser2","",10);
    EntFire("Toilet_Break", "Break","",22);
    EntFire("Map_Wall_Block4", "kill","",20);
    EntFire("Toilet_Props", "kill","",20);
    EntFire("Toilet_Door_Fix", "Open","",30);
    EntFire("Toilet_Door_Fix", "Close","",60);
    EntFire("Toilet_Door", "Open","",65+time);
    EntFire("Music", "RunScriptCode","SetMusic(Music_Some_body_stretch);",64+time);
    EntFire("SHREK_Toilet_sound", "PlaySound","",65);
    EntFire("Music", "Volume","0",65);
    EntFire("Map_TD", "FireUser1","",65);
    EntFireByHandle(self, "RunScriptCode", "StartTpZm();", 65.1+time, null, null);
    EntFireByHandle(self, "RunScriptCode", "ChekCTa();", 65+time, null, null);
    EntFireByHandle(self, "RunScriptCode", "StartDragon();", 67+time, null, null);
    EntFire("Toilet_Button", "Unlock","0",67 + time);

    if(RandomInt(0, 1))
        EntFire("Temp_Shark_Toilet", "ForceSpawn","",66 + time);
}

function StartDragon()
{
    iHealth = 400;

    local time = 30;
    local text;

    if(!Language)
    text = "Слышно рев дракона, где же он?"
    else
    text = "Hear the roar of the dragon, where is he?"
    ServerChat(Chat_pref + text);

    if(!Language)
    text = "Похоже дракон собирается приземлиться на крышу дома"
    else
    text = "The dragon is going to land on the roof of the house"
    ServerChat(Chat_pref + text,10 + time);

    if(!Language)
    text = "Дракон прилетел на крышу дома, это наш шанс спастись"
    else
    text = "The dragon flew to the roof of the house, this is our chance to escape"
    ServerChat(Chat_pref + text,20 + time);

    if(!Language)
    text = "Дракон улетает"
    else
    text = "The dragon flies away"
    ServerChat(Chat_pref + text,50 + time);

    EntFire("cmd", "Command","sv_enablebunnyhopping 1",0);
    EntFire("Music", "RunScriptCode","SetMusic(Music_3);",0);
    EntFire("temp_fly", "ForceSpawn","",0);
    EntFire("Home_Dragon", "Enable","",15+time);
    EntFire("Dragon_Sound", "PlaySound","",0);
    EntFire("Dragon_Sound", "PlaySound","",45);
    EntFire("Home_Train", "StartForward","",15+time);
    EntFire("fly_train*", "StartForward","",40+time);
    EntFire("Cover_train*", "StartForward","",35+time);

    EntFire("Home_Train", "SetSpeed","300",50+time);
    EntFire("Map_TD", "FireUser3","",50+time);
    EntFireByHandle(self, "RunScriptCode", "g_bFravity = true;", 50+time, null, null);
    EntFireByHandle(self, "RunScriptCode", "iHealth = 50;", 50+time, null, null)  
    
}

function Final()
{
    local text;
    g_bTicing = false;
    g_bFravity <-false;
    if((CountAlive()) == 1)
    {
        //printl("SOLO WIN")
        text = "SOLO WIN"
        ServerChat(Chat_pref + text);
        EntFire("Fade_White", "Fade","",4);
	    EntFireByHandle(self, "RunScriptCode", "SlayT();", 5, null, null);
        return;
    }

    switch((RandomInt(1, 3))) 
    {
        case 1: //плиты
        {
            printl("CASE 1")
            EntFire("mg_plat_temp", "FireUser1");
            EntFire("map_gText", "AddOutput","message Last SHREK standing");
            EntFire("map_gText", "FireUser1","",0.1);
            local handle = null;
            EntFire("TD_Hurt", "AddOutPut", "OnStartTouch !activator:AddOutPut:origin 1183 -1351 10620:0:-1");
            while((handle = Entities.FindByClassname(handle, "player")) != null)
            {
                if(!handle.IsValid())
                    continue;
                if(handle.GetHealth() < 1)
                    continue;
                if(handle.GetTeam() == 2)
                {
                    handle.SetOrigin(Vector(1183, -1351, 10620));
                    handle.SetHealth(10000);
                }
                if(handle.GetTeam() == 3)
                {
                    handle.SetOrigin(Vector(990, 5, 10596));
                    handle.SetHealth(1000);
                }
                handle.__KeyValueFromFloat("gravity", 1);
            }
        } break;

        case 2: //скакалка
        {
            printl("CASE 2")
            EntFire("mg_rot_temp", "FireUser1");
            EntFire("map_gText", "AddOutput","message Fall guys");
            EntFire("map_gText", "FireUser1","",0.1);
            local handle = null;
            EntFire("TD_Hurt", "AddOutPut", "OnStartTouch !activator:AddOutPut:origin 4771 -4806 10620:0:-1");
            while((handle = Entities.FindByClassname(handle, "player")) != null)
            {
                if(!handle.IsValid())
                    continue;
                if(handle.GetHealth() < 1)
                    continue;
                if(handle.GetTeam() == 2)
                {
                    handle.SetOrigin(Vector(3864, -3456, 9800));
                    handle.SetHealth(10000);
                    EntFireByHandle(handle, "SetDamageFilter", "filter_humans_ignore", 0, null, null);
                }
                if(handle.GetTeam() == 3)
                {
                    handle.SetOrigin(Vector(5104, -3456, 9800));
                    handle.SetHealth(1000);
                    EntFireByHandle(handle, "SetDamageFilter", "filter_zombies_ignore", 0, null, null);
                }
                handle.__KeyValueFromFloat("gravity", 1);
            }
        } break;

        case 3://вентиляторы+лава
        {
            g_bTicing = true;
            iHealth = 500;
            SetModel();

            EntFire("map_gText", "AddOutput","message Floor this is lava");
            EntFire("map_gText", "FireUser1","",0.1);

            printl("Case = 3")
            EntFire("MG_lava_temp", "FireUser1");
            EntFire("TD_Hurt", "AddOutPut", "OnStartTouch !activator:AddOutPut:origin 3135 -390 10981:0:-1");
            local handle = null;
            while((handle = Entities.FindByClassname(handle, "player")) != null)
            {
                if(!handle.IsValid())
                    continue;
                if(handle.GetHealth() < 1)
                    continue;
                if(handle.GetTeam() == 2)
                {
                    handle.SetOrigin(Vector(3135, -390, 10981));
                    handle.SetHealth(iHealth);
                }
                if(handle.GetTeam() == 3)
                {
                    handle.SetOrigin(Vector(5824, -328, 10981));
                    handle.SetHealth(1000);
                }
                handle.__KeyValueFromFloat("gravity", 1);
            }
        } break;
    }
}

function Button()
{
    EntFire("Toilet_Wall", "kill","",1);
    EntFire("poo_big_models", "kill","",1);
    EntFire("Smiv_sound", "PlaySound","",0);
    EntFire("Toilet_Button", "kill","",0.1);
}

function RandomTp()
{
    local id = RandomInt(0, Teleport_Arr.len() -1);
    activator.SetOrigin(Teleport_Arr[id]);

    local vec = (Vector(0,0,0))
    vec.Norm();
    activator.SetVelocity(Vector((vec.x * -50), (vec.y * -50), (500)));
}

function SlayT() {
    local handle = null;
    while((handle = Entities.FindByClassname(handle, "player")) != null)
    {
        if(handle == null)
            continue;
        if(!handle.IsValid())
            continue;
        if(handle.GetHealth() < 1)
            continue;
        if(handle.GetTeam() == 2)
        {
            EntFireByHandle(handle, "SetHealth", "-1", 0.00, null, null);
        }
    }
    EntFireByHandle(self, "RunScriptCode", "SlayT();", 1, null, null);
}

function StartTpZm()
{
    local handle = null;
    while((handle = Entities.FindByClassname(handle, "player")) != null)
    {
        if(handle == null)
            continue;
        if(!handle.IsValid())
            continue;
        if(handle.GetHealth() <= 0)
            continue;
        if(handle.GetTeam() == 2)
        {
            handle.SetOrigin(Vector(-6952, 6620, 572));
            handle.SetVelocity(Vector(0,-45,0));
        }
    }
}

Chat_Buffer <- [];

function ServerChat(text, delay = 0.00)
{
	if(delay > 0.00)
	{
		Chat_Buffer.push(text);
		EntFireByHandle(self, "RunScriptCode", "ServerChatText(" + (Chat_Buffer.len() - 1) + ")", delay, null, null);
	}
	else
		ScriptPrintMessageChatAll(text);
}

function ServerChatText(ID)
{
	ScriptPrintMessageChatAll(Chat_Buffer[ID]);
}

function ChekCTa()
{
    local handle = null;
    local origin = Vector(-3898, -4984, 1350);
    while (null != (handle = Entities.FindByClassname(handle, "player")))
    {
        if(handle.IsValid() && handle.GetHealth() > 0 && handle.GetTeam() == 3 && !IsVectorInSphere(origin,300,handle.GetOrigin()))
		{
			EntFireByHandle(handle, "SetHealth", "-1", 0.00, null, null);
		}
    }
}

IsVectorInSphere <- function(v1, radius, v2)
{
	if (pow(v2.x - v1.x, 2.00) + pow(v2.y - v1.y, 2.00) + pow(v2.z - v1.z, 2.00) < pow(radius, 2))
	{
		return true;
	}
	return false;
}

function CountAlive(TEAM = 3)
{
    local handle = null;
    local counter = 0;
    while(null != (handle = Entities.FindByClassname(handle,"player")))
    {
        if(handle.GetTeam() == TEAM && handle.GetHealth() > 0)counter++;
    }
    return counter;
}

function SetModel() 
{        
    local handle = null;

    if(!g_bTicing)
        return;

    while((handle = Entities.FindByClassname(handle, "player")) != null)
    {
        if(!handle.IsValid())
        continue;
        if(handle.GetHealth() < 1)
        continue;
        if(handle.GetTeam() == 2 && handle.GetHealth() > (iHealth / 2) )
        {
            if(g_bFravity)
            {
                handle.__KeyValueFromFloat("gravity", 0.05)
            }
            if(!(handle.GetModelName() == T_MODELS[0] || handle.GetModelName() == T_MODELS[1]))
            {
                printl(""+handle.GetModelName())
                handle.SetModel(T_MODELS[RandomInt(0, 1)]);
            }
            if(handle.GetTeam() == 2 && handle.GetHealth() > iHealth)
            {
                handle.SetHealth(iHealth);
                continue;
            }
        }
        //if (handle.GetTeam() == 3 && handle.GetHealth() < 500 && handle.GetModelName() != CT_MODEL){handle.SetModel(CT_MODEL);}
    }
    EntFireByHandle(self, "RunScriptCode", "SetModel();", g_iTicrate, null, null)
}

function SetShrekModel()
{
    if(activator.GetHealth() < 500 && activator.GetModelName() != CT_MODEL)
    {
        activator.SetModel(CT_MODEL);
        Fade_Green(activator);
    }
}

function bananaTick()
{
    local NewArr = [];
    foreach (index, banana in BANANA_ARR)
    {
        if(!ValidTestMoveParent(banana[1],banana[0],2))
        {
            NewArr.push(index);
        }
    }
    if(NewArr.len() > 0)
    {
        NewArr.reverse()
        foreach (banana in NewArr)
        {
            BANANA_ARR.remove(banana)
            EntFireByHandle(self, "RunScriptCode", "SpawnZMItem(0);", 0,null,null);
        }
    }
    if(BANANA_ARR.len()>0)
        EntFireByHandle(self, "RunScriptCode", "bananaTick();", g_iTicrate * 5, null, null)
}

function ChesnokTick()
{
    local NewArr = [];
    foreach (index, Chesnok in CHESNOK_ARR)
    {
        if(!ValidTestMoveParent(Chesnok[1],Chesnok[0],2))
        {
            NewArr.push(index);
        }
    }
    if(NewArr.len() > 0)
    {
        NewArr.reverse()
        foreach (Chesnok in NewArr)
        {
            CHESNOK_ARR.remove(Chesnok)
            EntFireByHandle(self, "RunScriptCode", "SpawnZMItem(1);", 0,null,null);
        }
    }
    if(CHESNOK_ARR.len()>0)
        EntFireByHandle(self, "RunScriptCode", "ChesnokTick();", g_iTicrate * 5, null, null)
}

::ValidTestMoveParent <- function(handle_move, owner, team) 
{
    try
    {
        if(handle_move.GetMoveParent() != null && handle_move.GetMoveParent() == owner && owner.GetTeam() == team){return true;}
        else{return false;}
    }
    catch(error){return false;}
}

BANANA_ARR <- [];
CHESNOK_ARR <- [];
FROG_OWNER <- null;

function FrogPick()
{

}

function BananaPick()
{
    BANANA_ARR.push([activator,caller]);
    if(BANANA_ARR.len()== 1)
    {
        bananaTick()
    }
}

function ChesnokPick()
{
    CHESNOK_ARR.push([activator,caller]);
    if(CHESNOK_ARR.len()== 1)
    {
        ChesnokTick()
    }
}

function ChekItem()
{
    foreach(index, p in BANANA_ARR)
    {
        if (activator == p[0])
        {printl("FIND IN ARR BANANA")
            return;}
    }

    foreach(index, p in CHESNOK_ARR)
    {
        if (activator == p[0])
        {printl("FIND IN ARR CHESNOK")
            return;}
    }
    EntFireByHandle(caller, "FireUser1", "", 0, activator, caller);
}

ITEM_S <- ["Temp_Item_Banana", "Item_WOTG_Temp"];

function SpawnZMItem(item) //Item_WOTG_Temp  //Temp_Item_Banana
{
        Spawner.__KeyValueFromString("EntityTemplate", ""+ITEM_S[item]);
        Spawner.SpawnEntityAtLocation(Vector(RandomInt(-6464, -6176),13280,128), Vector(0,270,0));
}

function Fade_White(handle)
{
	EntFire("fade_white", "Fade", "", 0, handle);
}

function Fade_Green(handle)
{
	EntFire("Map_Fade", "Fade", "", 0, handle);
}


function Donkey_Push()
{
    local handle = null;
    local sprite = Entities.FindByName(null, "Donkey_Spryte");
    local origin = sprite.GetOrigin();
    local radius = 1000;
    while (null != (handle = Entities.FindInSphere(handle, origin, radius)))
    {
        if(handle == null)
            continue;

        if(!handle.IsValid())
            continue;

        if(handle.GetHealth() < 1)
            continue;

        Push(handle, origin);
    }
}

function Push(Handle, origin)
{
    local push_speed = 1000;
    //local spos = Vector(-3944, -5016, 1000);
    local tpos = Handle.GetOrigin();
    local vec = origin - tpos;
    vec.Norm();
    Handle.SetVelocity(Vector((vec.x * -push_speed), (vec.y * -push_speed), (400)));
}