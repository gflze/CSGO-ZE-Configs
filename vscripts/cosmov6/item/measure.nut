Owner <- null;
Center <- null;

function ClearParent()
{
    EntFireByHandle(self, "FireUser4", "", 0, null, null);
    Owner.__KeyValueFromString("targetname", "player");
    Owner = null;
}

function SetHandle()
{
    if(caller.GetClassname() == "func_door")Center = caller;
}

function SetParent()
{
    Owner = activator;
    Owner.__KeyValueFromString("targetname", "Owner"+(self.GetName().slice(self.GetPreTemplateName().len(),self.GetName().len())).tostring());
    Center.SetOrigin(activator.EyePosition())
    EntFireByHandle(self, "SetMeasureTarget", Owner.GetName().tostring(), 0.02, Owner, Owner);
    EntFireByHandle(self, "Enable", "", 0.02, Owner, Owner);
    //EntFireByHandle(self, "RunScriptCode", "Center.SetOrigin(Owner.EyePosition())", 0.02, Owner, Owner);
}