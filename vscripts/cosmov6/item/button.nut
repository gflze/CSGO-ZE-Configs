au <- true;
useloc <- true;
loc <- true;
mainscript <- Entities.FindByName(null, "map_brush");

function filter()
{
    if(Activator == activator && au && loc && useloc)
    {
        EntFireByHandle(self, "FireUser4", "", 0, activator, activator);
    }
}

Activator <- null;
Ticking <- true;
Weapon <- null;

function SetWeapon()
{
    Weapon = caller;
    Activator = activator;
    Ticking = true;
    CheckItem();
}

function CheckItem()
{
    if(!Ticking)
        return;

    if(Weapon.GetOwner() != Activator)
    {
        EntFireByHandle(mainscript, "RunScriptCode", "DropItem();", 0.05, Activator, self);
        Ticking = false;
        Activator = null;
    }
    else 
        EntFireByHandle(self, "RunScriptCode", "CheckItem();", 0.05, null, null);
}

function GetStatus()
{
    if(!au || !loc || !useloc) 
    {
        return false;
    }
    else
    {
        return true;
    }
}

function OnPostSpawn()
{
    EntFireByHandle(MainScript, "RunScriptCode", "ITEM_OWNER.push(ItemOwner(caller))", 0.05, self, self);
}