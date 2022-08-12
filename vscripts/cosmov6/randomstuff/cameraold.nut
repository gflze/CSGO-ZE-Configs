
Fade <- Entities.FindByName(null, "Cutscene_Fade_Out");
Overlay <- "Rafuron/LMS_Other/cinematic_overlay"

function SpawnCameras(o1, a1, time1, o2, a2, time2, flytime)
{
    local viewcontrol = Entities.CreateByClassname("point_viewcontrol_multiplayer");
    local viewtarget = Entities.CreateByClassname("info_target");
    viewcontrol.__KeyValueFromString("targetname", "viewcontrol");
    viewtarget.__KeyValueFromString("targetname", "viewtarget");
    viewtarget.SetAngles(a2.x, a2.y, a2.z);
    viewtarget.SetOrigin(o2);
    viewcontrol.SetAngles(a1.x, a1.y, a1.z);
    viewcontrol.SetOrigin(o1);
    viewcontrol.__KeyValueFromString("target_entity", "viewtarget");
    EntFireByHandle(viewcontrol, "Enable", "", 0, viewcontrol, viewcontrol);
    viewcontrol.__KeyValueFromFloat("interp_time", flytime);
    EntFireByHandle(viewcontrol, "StartMovement", "", 0.01 + time1, viewcontrol, viewcontrol);
    EntFireByHandle(viewcontrol, "Disable", "", time1+time2+flytime - 0.01, viewcontrol, viewcontrol);
    EntFireByHandle(viewcontrol, "Kill", "", time1+time2+flytime, viewcontrol, viewcontrol);
    EntFireByHandle(viewtarget, "Kill", "", time1+time2+flytime, viewtarget, viewtarget);
}

function SetOverLay(OverLayName = "clear")
{
    local handle = null;
    while(null != (handle = Entities.FindByClassname(handle, "player")))
	{
		if(handle == null)
            continue;
        if(!handle.IsValid())
            continue;
        if(OverLayName == "clear")
            EntFireByHandle(Fade, "Fade", "", 0.00, handle, handle);
        EntFire("point_clientcommand", "Command", "r_screenoverlay " + OverLayName, 0, handle); 
    }
}


