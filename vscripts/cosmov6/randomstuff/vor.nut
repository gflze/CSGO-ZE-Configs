mainscript <- Entities.FindByName(null, "map_brush");

owner <- null;
button <- null;
ui <- null;

otm <- null;
otm_defpos <- Vector(0,0,0)
hpbox <- null;
light <- null;

camera <- Entities.CreateByClassname("point_viewcontrol");
camera.__KeyValueFromInt("fov", 80);
camera.SetAngles(5,0,0);
camera.SetOrigin(self.GetOrigin())

huinya_array <- [];
otm_lim_z <- [];

lim_yz <- [];

select <- -1;

class huinya
{
    handle = null;
    defpos = null;
    level = 0;
    maxlevel = 0;
    done = false;
    rotor = false;
    constructor(_handle,_defpos)
    {
        this.handle = _handle;
        this.defpos = _defpos;
        this.maxlevel = RandomInt(2,4);
    }
    function Check()
    {
        if(this.rotor)
            return false;
        
        if(this.level + 1 <= this.maxlevel)
        {
            this.level++;
            if(this.level == this.maxlevel)this.done = true;
            return true;
        }
        else
        {
            return false;
        }
    }
    function SetDefPos()
    {
        this.level = 0;
        this.done = false;
        this.handle.SetOrigin(defpos);
    }
    function Rotor()
    {
        this.rotor = true;
        local lvl = this.level.tofloat() / this.maxlevel.tofloat() * 100;
        local modif = (100 - lvl) * 0.01;
        if(modif == 0)
            modif = 0.1;
        local time = 0.008 * (modif);

        for (local i = 0; i < 180; i += 1)
        {
            EntFireByHandle(this.handle, "RunScriptCode", "self.SetAngles(0, "+i+", 0)", time * i, null, null);
        }

        return time * 181;
    }
}

StartTime <- null;

function Start()
{
    if(owner != null)return;
    owner = activator;
    button = caller;

    StartTime = Time();

    for (local i = 0; i < huinya_array.len(); i++)
    {
        huinya_array[i].SetDefPos();
    }
    lim_yz.reverse();
    huinya_array.reverse();
    otm.SetOrigin(otm_defpos);

    hpbox.SetOrigin(owner.GetOrigin());
    EntFireByHandle(hpbox,"SetDamageFilter",(owner.GetTeam() == 2) ? "filter_no_zombie" : "filter_no_humans",0.01,owner,owner);
    EntFireByHandle(hpbox,"SetParent","!activator",0.01,owner,owner);
    EntFireByHandle(camera,"Enable","",0,owner,owner);
    EntFireByHandle(ui,"Activate","",0,owner,owner);
}
ticking <- true;

function Stop(ui_off = false)
{   
    if(!ticking)
        return;
    ticking = false;
    EntFireByHandle(button,"UnLock","",0.5,null,null);
    owner = null;
    button = null;

    EntFireByHandle(camera,"Disable","",0,null,null);
    if(!ui_off)
        EntFireByHandle(ui,"Deactivate","",0,null,null);
    EntFireByHandle(self,"RunScriptCode","SelfDestroy()",0.05,null,null);
}

function SelfDestroy()
{
    for (local i = 0; i < huinya_array.len(); i++)
    {
        EntFireByHandle(huinya_array[i].handle,"Kill","",0,null,null);
    }

    EntFireByHandle(light,"Kill","",0,null,null);
    EntFireByHandle(hpbox,"Kill","",0,null,null);
    EntFireByHandle(ui,"Kill","",0,null,null);
    EntFireByHandle(camera,"Kill","",0,null,null);
    EntFireByHandle(otm,"Kill","",0,null,null);
    EntFireByHandle(self,"Kill","",0.05,null,null);
}

function Press_W()
{
    if(select == -1)
        return;
    local otm_origin = otm.GetOrigin();
    otm.SetOrigin(Vector(otm_origin.x, lim_yz[select], otm_lim_z[1]));
}
function Press_S()
{
    if(select == -1)
        return;
    local otm_origin = otm.GetOrigin();
    local huinya_obj = huinya_array[select];
    local huinya_handle = huinya_array[select].handle;

    if(huinya_obj.Check())
    {
        EntFireByHandle(self,"RunScriptCode","CheckVzom(" + select + ")", huinya_obj.Rotor(),null,null);

        huinya_handle.SetOrigin(huinya_handle.GetOrigin() - Vector(0,0,1));
        otm.SetOrigin(huinya_handle.GetOrigin() + Vector(0,0,1));
    }
    else
    {
        mainscript.GetScriptScope().GetPlayerClassByHandle(activator).otm--;
        EntFire("fade_red", "Fade", "", 0, activator);
        Stop();
    }
}

function Press_A()
{
    if(select > 0)
    {
        local otm_origin = otm.GetOrigin();

        select--;

        otm.SetOrigin(Vector(otm_origin.x, lim_yz[select], otm_lim_z[1]));
    }
}
function Press_D()
{
    if(select < lim_yz.len() - 1)
    {
        local otm_origin = otm.GetOrigin();

        select++;

        otm.SetOrigin(Vector(otm_origin.x, lim_yz[select], otm_lim_z[1]));
    }
}

function CheckVzom(select)
{
    for (local i = 0; i < huinya_array.len(); i++)
    {
        if(!huinya_array[i].done)
        {
            huinya_array[select].rotor = false;
            return;
        }  
    }
    
    EntFire("fade_white", "Fade", "", 0, owner);
    EntFireByHandle(button,"fireuser1","", 0,owner,owner);

    local chest_ct = Entities.FindByName(null, "zamok_ct");    
    chest_ct.GetScriptScope().CheckRecord(owner, huinya_array.len(), (Time() - StartTime));
    Stop();
}

function SetHandle()
{
    local name = caller.GetName();
    if(name.find("_s") != null)
    {
        local handle = caller;
        local origin = Vector(handle.GetOrigin().x.tointeger(),handle.GetOrigin().y.tointeger(),handle.GetOrigin().z.tointeger());
        local obj = huinya(handle,origin);

        huinya_array.push(obj);
        lim_yz.push(origin.y);
    }
    if(name.find("_o") != null)
    {
        otm = caller;
        otm_defpos = Vector(otm.GetOrigin().x.tointeger(),otm.GetOrigin().y.tointeger(),otm.GetOrigin().z.tointeger());
        otm_lim_z = [otm_defpos.z - 6,otm_defpos.z];
    }
    if(caller.GetClassname() == "light_spot")light = caller;
    if(caller.GetClassname() == "game_ui")ui = caller;
    if(caller.GetClassname() == "func_physbox_multiplayer")hpbox = caller;
}

function OnPostSpawn()
{
    EntFire("zamok_ct", "RunScriptCode", "Connect()", 0, self);
}