model_v <- "models/weapons/n4a/giantsword/v_giantsword.mdl"; self.PrecacheModel(model_v);
model_w <- "models/weapons/n4a/giantsword/w_giantsword.mdl"; self.PrecacheModel(model_w);
weapon <- null;

function SetWeapon() 
{
}

function Tick() 
{
    printl("Tick");
    local w = null;
    while(null != (w = Entities.FindByClassname(w, "predicted_viewmodel")))
    {        
        if(w.GetModelName() == "models/weapons/v_knife_default_ct.mdl")
        {
            printl(w.GetMoveParent())
            w.SetModel(model_v);
            printl(w);
        }
    }

    while(null != (w = Entities.FindByClassname(w, "weaponworldmodel"))) 
    {       
        if(w.GetModelName() == "models/weapons/w_knife_default_ct.mdl")
        {
            printl(w.GetMoveParent())
            w.SetModel(model_w);
            printl(w);
        }
    }
}