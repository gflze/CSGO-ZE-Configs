Act <- null;
Ticking <- true;
Weapon <- null;
mainscript <- Entities.FindByName(null, "map_brush");

function SetWeapon()
{
    Weapon = caller;
    Act = activator;
    Ticking = true;
    CheckItem();
}

function CheckItem()
{
    if(Ticking)
    {
        if(Act != null)
        {
            if(Weapon.GetRootMoveParent() != Act)
            {
                Ticking = false;
                EntFireByHandle(mainscript, "RunScriptCode", "GetItemByOwner(activator).RemoveOwner(true);", 0.05, Act, self);
                Act = false;
            }
            else
            {
                EntFireByHandle(self, "RunScriptCode", "CheckItem();", 0.1, null, null);
            }
        }
    }
}
