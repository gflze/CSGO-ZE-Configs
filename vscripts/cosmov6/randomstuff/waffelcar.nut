
SpeedMod <- Entities.FindByName(null, "speedMod");
self.PrecacheModel("models/props/coop_kashbah/wheelchair/wheelchair.mdl");
g_Array_Car <- [];
g_Array_CheckCar <- [];

::g_Array_Sounds <- ["cosmov6/randomsounds/cringe1.mp3", "cosmov6/randomsounds/cringe2.mp3"]

ticking <- false;
tickrate <- 0.01;
tickrate_sound <- 20.0;
forwarddist <- 50;
class car
{
    text = null;
    textmessage = null;
    textscale = 6;
    textcolor = Vector(255, 255, 255);

    invalid = null;
    driver = null;

    speed = -0.05;

    model = null;
    sound = null;

    driverbutton = null;
    allowdriver = true;
    allowjump = false;

    lastpos = null;

    constructor(invalid_, model_, driverbutton_)
    {
        this.invalid = invalid_;
        this.model = model_;
        this.driverbutton = driverbutton_;
        this.sound = Entities.FindByName(null, "waffel_Sound"+driverbutton.GetName().slice(driverbutton.GetPreTemplateName().len(),driverbutton.GetName().len()));
    }

    //thanks luff for this code

    function SetTextCreate()
    {
        if(this.text != null)
            this.text.Destroy();
        
        this.text = Entities.CreateByClassname("point_worldtext");
        this.text.__KeyValueFromVector("color", this.textcolor);
        this.text.__KeyValueFromFloat("textsize", this.textscale);
    }

    function SetTextMessage(newtext)
    {
        this.textmessage = newtext.tostring();
        this.SetTextCreate();
        
        this.text.__KeyValueFromString("message", this.textmessage);
        this.SetTextPos();
    }

    function SetTextColor(newcolor)
    {
        if(this.text == null || textmessage == null)
            return;
        this.textcolor = newcolor;
        this.text.__KeyValueFromVector("color", this.textcolor);
    }

    function SetTextScale(newscale)
    {
        if(this.text == null || textmessage == null)
            return;
        this.textscale = newscale;
        this.text.__KeyValueFromFloat("textsize", this.textscale);

        this.SetTextPos();
    }

    function SetTextPos()
    {
        if(this.text == null || textmessage == null)
            return;
        this.text.SetOrigin(this.invalid.GetOrigin() + (this.invalid.GetUpVector() * 80) + (this.invalid.GetLeftVector() * ((this.textmessage.len() * 3.0) * (this.textscale * 0.1))) + (this.invalid.GetForwardVector() * 7));
        this.text.SetAngles(0, this.invalid.GetAngles().y + 180, 0);
        EntFireByHandle(this.text, "SetParent", "!activator", 0.01, this.invalid, this.invalid);
    }

    function SetDriver(handle)
    {
        this.driver = handle;
    }

    function SetSpeed(i)
    {
        this.speed = i;
    }

    function SetColor(newcolor)
    {
        this.model.__KeyValueFromVector("rendercolor", newcolor);
        this.invalid.__KeyValueFromVector("rendercolor", newcolor);
    }

    function SetGlowColor(newcolor, type = 1)
    {
        this.model.__KeyValueFromVector("glowcolor", newcolor);
        this.model.__KeyValueFromInt("glowstyle", type);
        this.model.__KeyValueFromInt("glowdist", 128);
        this.model.__KeyValueFromInt("glowenabled", 1);
    }

    function SetAllowDriver(allow)
    {
        this.allowdriver = allow;
    }

    function SetAllowJump(allow = false)
    {
        this.allowjump = allow;
    }

    function SelfDestroy()
    {
        if(this.text != null && this.text.IsValid())
            this.text.Destroy();
        if(this.model != null && this.model.IsValid())
            this.model.Destroy();
        if(this.sound != null && this.sound.IsValid())
            this.sound.Destroy();
        // if(this.driverbutton.GetMoveParent() != null && this.driverbutton.GetMoveParent().IsValid())
        //     this.driverbutton.GetMoveParent().Destroy();
        if(this.driverbutton != null && this.driverbutton.IsValid())
            this.driverbutton.Destroy();
        if(this.invalid.IsValid())
        {
            this.invalid.__KeyValueFromInt("MoveType", 2);
            this.invalid.__KeyValueFromVector("rendercolor", Vector(255,255,255));
        }
        if(this.lastpos != null)
            this.invalid.SetOrigin(this.lastpos);
    }

    function SetLastPos(newlastpos)
    {
        this.lastpos = newlastpos;
    }

    function ActivateDriver(driver)
    {
        this.driver = driver;
        this.invalid.__KeyValueFromInt("MoveType", 7);
    }

    function DeactivateDriver()
    {
        this.driver = null;
        this.invalid.SetOrigin(this.lastpos);
        this.invalid.__KeyValueFromInt("MoveType", 2);
        //EntFireByHandle(this.model, "RunScriptCode", "self.SetAngles(0, activator.GetAngles().y, 0)", 0.05, this.invalid, this.invalid);
    }

    function PlaySound()
    {
        EntFireByHandle(this.sound,"AddOutPut", "message "+g_Array_Sounds[RandomInt(0, g_Array_Sounds.len() - 1)], 0,null,null);
        EntFireByHandle(this.sound, "PlaySound", "", RandomFloat(0.01, 5.00), null, null);
    }
}

function OnPostSpawn()
{
    Start();
}

function Start()
{
    local maker = Entities.CreateByClassname("env_entity_maker");
    maker.__KeyValueFromString("EntityTemplate", self.GetName());
    maker.__KeyValueFromString("targetname", "waffel_controller_spawner");
}

function AddCar()
{
    local Preset = GetClassByInvalid(activator);
    if(Preset != null)
        return;
    
    local ent = Entities.CreateByClassname("prop_dynamic_glow")
    ent.__KeyValueFromInt("solid", 0);
    ent.__KeyValueFromInt("rendermode", 1);
    ent.__KeyValueFromInt("renderamt", 254);
    ent.SetModel("models/props/coop_kashbah/wheelchair/wheelchair.mdl");
    ent.SetOrigin(activator.GetOrigin() + activator.GetLeftVector() * -5);
    ent.SetAngles(0, activator.GetAngles().y, 0);
    EntFireByHandle(ent, "SetParent", "!activator", 0.01, activator, activator);

    local fix = caller.GetMoveParent();
    fix.SetOrigin(activator.GetOrigin() + activator.GetForwardVector() * -10 + activator.GetUpVector() * 25 + activator.GetLeftVector() * -5);
    fix.SetAngles(0, activator.GetAngles().y, 0);
    EntFireByHandle(fix, "Disable", "", 0, null, null);
    EntFireByHandle(fix, "SetParent", "!activator", 0.02, ent, ent);

    g_Array_Car.push(GetPresent(car(activator, ent, caller)));
    if(g_Array_Car.len() == 1)
        Tick_Sound();
}

function GetPresent(Car_Class)
{
    local Preset = MainScript.GetScriptScope().GetInvalidClass(Car_Class.invalid);
    local player_class = MainScript.GetScriptScope().GetPlayerClassByHandle(Car_Class.invalid);
    if(Preset == 0)
    {
        Car_Class.SetTextMessage("Waffel");
    }
    else if(Preset == 1)
    {
        Car_Class.SetSpeed(0.05);
        Car_Class.SetAllowDriver(false);
        Car_Class.SetAllowJump(true);

        Car_Class.SetTextMessage("Kotya");
        
        Car_Class.SetGlowColor(Vector(0,40,80), 0);
        Car_Class.SetTextColor(Vector(0,128,255));
        Car_Class.SetColor(Vector(0,128,255));
    }
    else if(Preset == 2)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowDriver(false);
        Car_Class.SetAllowJump(true);

        Car_Class.SetTextMessage("Original Waffel");
        Car_Class.SetTextColor(Vector(255,255,0));
        Car_Class.SetColor(Vector(255,255,0));    
    }
    else if(Preset == 3)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowDriver(false);
        Car_Class.SetAllowJump(true);

        Car_Class.SetTextMessage("memories");
        Car_Class.SetTextColor(Vector(255,0,0));
        Car_Class.SetColor(Vector(225,0,0));    
    }
    else if(Preset == 4)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowDriver(false);
        Car_Class.SetAllowJump(true);

        Car_Class.SetTextMessage("Mr. Bump");
        Car_Class.SetTextColor(Vector(255,255,0));
        Car_Class.SetColor(Vector(255,255,0)); 
    }
    else if(Preset == 5)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowDriver(false);
        Car_Class.SetAllowJump(true);

        Car_Class.SetTextMessage("Champagne");
        Car_Class.SetTextColor(Vector(255,255,0));
        Car_Class.SetColor(Vector(255,255,0)); 
    }
    else if(Preset == 6)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowDriver(false);
        Car_Class.SetAllowJump(true);

        Car_Class.SetTextMessage("Krinjita");
        Car_Class.SetTextColor(Vector(255,0,255));
        Car_Class.SetColor(Vector(255,0,255)); 
    }
    else if(Preset == 7)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowDriver(true);
        Car_Class.SetAllowJump(true);

        Car_Class.SetTextMessage("Loh ebani");
        Car_Class.SetTextColor(Vector(255,0,0));
        Car_Class.SetColor(Vector(255,0,0)); 
    }
    else if(Preset == 8)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowDriver(true);
        Car_Class.SetAllowJump(true);

        Car_Class.SetTextMessage("Mist");
        Car_Class.SetTextColor(Vector(255,0,0));
        Car_Class.SetColor(Vector(255,0,0));
    }
    else if(Preset == 9)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("Sushi Banana");
        Car_Class.SetTextColor(Vector(255,255,255));
        Car_Class.SetColor(Vector(255,255,255));
    }
    else if(Preset == 10)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("spx");
        Car_Class.SetTextColor(Vector(255,16,240));
        Car_Class.SetColor(Vector(0,255,255));
    }
    else if(Preset == 11)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("xiaodi");
        Car_Class.SetTextColor(Vector(0,255,255));
        Car_Class.SetColor(Vector(0 255 0));
    }
    else if(Preset == 12)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("lia");
        Car_Class.SetTextColor(Vector(255,16,240));
        Car_Class.SetColor(Vector(0,255,255));
    }
    else if(Preset == 13)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("Takoro");
        Car_Class.SetTextColor(Vector(252,75,69));
        Car_Class.SetColor(Vector(74,91,253));
    }
    else if(Preset == 14)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("Sify");
        Car_Class.SetTextColor(Vector(0,255,255));
        Car_Class.SetColor(Vector(255,255,255));
    }
    else if(Preset == 15)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("Shizuka");
        Car_Class.SetTextColor(Vector(255,0,0));
        Car_Class.SetColor(Vector(255,0,0));
    }
    else if(Preset == 16)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("Tupu");
        Car_Class.SetTextColor(Vector(255,255,0));
        Car_Class.SetColor(Vector(255,0,0));
    }
    else if(Preset == 17)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("Try natural");
        Car_Class.SetTextColor(Vector(0,255,255));
        Car_Class.SetColor(Vector(153,50,204));
    }
    else if(Preset == 18)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(true);

        Car_Class.SetTextMessage("try");
        Car_Class.SetTextColor(Vector(0,255,0));
        Car_Class.SetColor(Vector(128,128,255));
    }
    else if(Preset == 19)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("Bulavator");
        Car_Class.SetTextColor(Vector(255,255,255));
        Car_Class.SetColor(Vector(255,255,255));
    }
    else if(Preset == 20)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("UMAD");
        Car_Class.SetTextColor(Vector(255,215,0));
    }
    else if(Preset == 21)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("genshin sucks");
        Car_Class.SetTextColor(Vector(255,0,0));
        Car_Class.SetColor(Vector(255,0,0));
    }
    else if(Preset == 22)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(true);

        Car_Class.SetTextMessage("Hideo Kringerino");
        Car_Class.SetTextColor(Vector(255,255,255));
        Car_Class.SetColor(Vector(100,100,100));
    }
    else if(Preset == 23)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("ump-9");
        Car_Class.SetTextColor(Vector(0,0,255));
        Car_Class.SetColor(Vector(0,0,255));
    }
    else if(Preset == 24)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("K.NEMO");
        Car_Class.SetTextColor(Vector(255,0,0));
        Car_Class.SetColor(Vector(255,255,255));
    }
    else if(Preset == 25)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("FPTyel");
        Car_Class.SetTextColor(Vector(255,255,255));
        Car_Class.SetColor(Vector(128,0,128));
    }
    else if(Preset == 26)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("Ushastik");
        Car_Class.SetTextColor(Vector(255,0,255));
        Car_Class.SetColor(Vector(255,0,255));
    }
    else if(Preset == 27)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);
    }
    else if(Preset == 28)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("Tilgep");
        Car_Class.SetTextColor(Vector(255,255,255));
        Car_Class.SetColor(Vector(255,255,255));
    }
    else if(Preset == 29)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("Ambitious");
        Car_Class.SetTextColor(Vector(255,255,255));
        Car_Class.SetColor(Vector(255,255,255));
    }
    else if(Preset == 29)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("Ambitious");
        Car_Class.SetTextColor(Vector(255,255,255));
        Car_Class.SetColor(Vector(255,255,255));
    }
    else if(Preset == 30)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(false);

        Car_Class.SetTextMessage("Bonesaw");
        Car_Class.SetTextColor(Vector(255,0,0));
        Car_Class.SetColor(Vector(100,100,100));
    }
    else if(Preset == 31)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(true);

        Car_Class.SetTextMessage("MercaXlv");

        Car_Class.SetGlowColor(Vector(42,0,42), 0);
        Car_Class.SetTextColor(Vector(0,255,255));
        Car_Class.SetColor(Vector(140,0,140));
    }
    else if(Preset == 32)
    {
        Car_Class.SetSpeed(0);
        Car_Class.SetAllowJump(true);
        Car_Class.SetAllowDriver(true);

        Car_Class.SetTextMessage("cron");
        Car_Class.SetTextColor(Vector(10,10,250));
        Car_Class.SetColor(Vector(128,0,128));
    }
    
    if(player_class.block_driver != null)
        Car_Class.SetAllowDriver(((player_class.block_driver) ? false : true));

    else if(Car_Class.allowdriver)
        player_class.block_driver = false;
    else 
        player_class.block_driver = true;

    if(!Car_Class.allowjump)
        MainScript.GetScriptScope().GetPlayerClassByHandle(activator).invalid = true;
    EntFireByHandle(MainScript, "RunScriptCode", "SlowPlayer(" + Car_Class.speed + ", -1)", 1.00, activator, activator);
    return Car_Class;
}

function DestroyCar(handle)
{
    for(local i = 0; i < g_Array_Car.len(); i++)
    {
        if(g_Array_Car[i].invalid == handle)
        {
            g_Array_Car[i].SelfDestroy();

            g_Array_Car.remove(i);

            local player_class = MainScript.GetScriptScope().GetPlayerClassByHandle(handle);
            player_class.invalid = false;

            player_class.speed = 1.0;
            player_class.speed_default = 1.0;

            EntFireByHandle(SpeedMod, "ModifySpeed", "1.0", 0, handle, handle);
            
            return;
        }
    }
}

function PressDriverButton()
{
    local car_class = GetClassByButton(caller);
    local driver_class = GetClassByInvalid(activator);
    
    if(driver_class != null || car_class == null)
        return;

    if(!car_class.allowdriver)
        return;

    if(car_class.invalid.GetTeam() != activator.GetTeam())
        return;

    if(car_class.driver == null)
    {
        SetDriver(car_class, activator);
    }
    else if(car_class.driver == activator)
    {
        UnSetDriver(car_class);
    }
}

function SetDriver(car_class, activator)
{
    car_class.ActivateDriver(activator);

    g_Array_CheckCar.push(car_class);

    if(g_Array_CheckCar.len() <= 1)
    {
        ticking = true;
        Tick();
    }
}

function UnSetDriver(car_class)
{
    car_class.DeactivateDriver();

    if(g_Array_CheckCar.len() <= 1)
    {
        ticking = false;
    }

    for(local i = 0; i < g_Array_CheckCar.len(); i++)
    {
        if(g_Array_CheckCar[i].invalid == car_class.invalid)
        {
            g_Array_CheckCar.remove(i);
            break;
        }
    }
}

function Tick()
{
    foreach(car_class in g_Array_CheckCar)
	{
        if(!car_class.driver == null    ||
            !car_class.driver.IsValid() || 
            car_class.driver.GetHealth() <= 0.00 || 
            car_class.driver.GetTeam() != car_class.invalid.GetTeam())
        {
            UnSetDriver(car_class);
        }
        else 
        {
            car_class.invalid.SetOrigin(car_class.driver.GetOrigin() + car_class.driver.GetForwardVector() * forwarddist);
            //car_class.model.SetAngles(0, car_class.driver.GetAngles().y, 0);
            car_class.SetLastPos(car_class.driver.GetOrigin());
        }
	}
    if(ticking)
        EntFireByHandle(self, "RunScriptCode", "Tick();", tickrate, null, null);
}

function Toggle(car_class)
{
    if(car_class.allowdriver)
    {
        car_class.allowdriver = false;
    }
    else
    {
        car_class.allowdriver = true;
    }
        
    if(car_class.driver != null)
    {
        car_class.DeactivateDriver();

        if(g_Array_CheckCar.len() <= 1)
        {
            ticking = false;
        }

        for(local i = 0; i < g_Array_CheckCar.len(); i++)
        {
            if(g_Array_CheckCar[i].invalid == car_class.invalid)
            {
                g_Array_CheckCar.remove(i);
                break;
            }
        }
    }
}

function Tick_Sound()
{
    if(g_Array_Car.len() == 0)
        return;

    foreach(car_class in g_Array_Car)
    {
        car_class.PlaySound();
    }
    
    EntFireByHandle(self, "RunScriptCode", "Tick_Sound();", tickrate_sound, null, null);
}

function GetClassByInvalid(handle)
{
    foreach(p in g_Array_Car)
	{
		if(p.invalid == handle)
		{
			return p;
		}
	}
	return null;
}

function GetClassByButton(handle)
{
    foreach(p in g_Array_Car)
	{
		if(p.driverbutton == handle)
		{
			return p;
		}
	}
	return null;
}