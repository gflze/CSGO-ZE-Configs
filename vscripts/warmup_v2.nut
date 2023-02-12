IncludeScript("ze_cruelty_squad/gorbinos_magic_v2");

WARMUP_TIME <- 30.00;
if(!("WARMUP_DONE" in this)){  
    EntFire("mother_zombie_relay","Trigger","",15,"");        
    VS.EventQueue.AddEvent(handler_say_this,0,[this, "corporate says you need to do some stretches before beginning your first day"]);
    VS.EventQueue.AddEvent(handler_say_this,WARMUP_TIME-5,[this, "well, fuck corporate, we better end this before we have to pay you for dicking around"]);
    EntFireByHandle(self,"RunScriptCode","::WARMUP_DONE <- true;",WARMUP_TIME,null,null);
    VS.EventQueue.AddEvent(nuke_sfx_toggle,29,[this]);
    EntFire("kill_all_trigger","Enable","",WARMUP_TIME,null);
    EntFire("music_depression_nap","PlaySound","",0,"");
    EntFire("sfx_self_destruction","PlaySound","",24.754,"");       
    for(local h;h=Entities.FindByClassname(h,"cs_bot");){h.__KeyValueFromString("targetname","botplayer");}
}
else{
    for(local h;h=Entities.FindByClassname(h,"cs_bot");){h.__KeyValueFromString("targetname","botplayer");}
    EntFire("level_1_relay","Enable","",0,"");    
    EntFire("level_1_relay","Trigger","",0,"");  
    EntFire("mother_zombie_relay","Trigger","",15,"");    
    siren_on();
    return;
}