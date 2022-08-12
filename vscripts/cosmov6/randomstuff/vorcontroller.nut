mainscript <- Entities.FindByName(null, "map_brush");

difficult_temp <-[
    Entities.FindByName(null, "lock_three_temp"),
    Entities.FindByName(null, "lock_four_temp"),];
FirstPos <- Vector(3358,1904,-2236) + Vector(-8,-16,16)
//FirstPos <- Vector(1999.5,1999.5,1776.5) + Vector(-8,-16,16)
PT_Body <- Vector(0,-54,16);
//0 46 32
owner <- null;
button <- null;
//CheckPos <- Vector()
//0 120|68
function Create(first = true)
{
    local pl = mainscript.GetScriptScope().GetPlayerClassByHandle(activator)
    if(pl.otm <= 0 || (first && pl.perksteal_lvl < 2))
    {
        EntFire("fade_red", "Fade", "", 0, activator);
        return;
    }
        
    local temp = difficult_temp[0];
    if(first)
        temp = difficult_temp[1];
    temp.SetOrigin(CheckOrigin());
    owner = activator;
    button = caller;
    EntFireByHandle(button,"Lock","",0,null,null);
    EntFireByHandle(temp,"ForceSpawn","",0,null,null);
}

function Connect()
{
    EntFireByHandle(activator,"RunScriptCode","Start()",0.1,owner,button);
    owner = null;
    button = null;
}

function CheckOrigin()
{
    local origin = FirstPos;

    for (local i = 0; i < 10; i++)
    {
        local body_origin = origin + PT_Body;
        if(InSight(body_origin,body_origin + Vector(-16,0,0)))
            break;
        origin += Vector(0,-120,0);
    }

    return origin;
}

function CheckRecord(handle, chest_type, time)
{
    if(chest_type == 3)
    {
        if(GREEN_CHEST_RECORD > time)
        {
            local pl = MainScript.GetScriptScope().GetPlayerClassByHandle(handle);
            ScriptPrintMessageChatAll(Chat_pref + "" + pl.name + " has set a new Record hacking the \x04Green\x01 Chest: \x04" + (time) + "\x01 sec. Previous Record was \x02" + GREEN_CHEST_RECORD + "\x01 sec (\x02-" + (GREEN_CHEST_RECORD - time) + "\x01 sec)")
            GREEN_CHEST_RECORD = time;
            GREEN_CHEST_RECORD_CLASS = pl;
        }
        if(GREEN_CHEST_RECORD == 0.00)
        {
            local pl = MainScript.GetScriptScope().GetPlayerClassByHandle(handle);
            ScriptPrintMessageChatAll(Chat_pref + "" + pl.name + " has set the First Record hacking the \x04Green\x01 Chest: \x04" + (time) + "\x01 sec");
            GREEN_CHEST_RECORD = time;
            GREEN_CHEST_RECORD_CLASS = pl;
        }
    }
    else if(chest_type == 4)
    {
        if(RED_CHEST_RECORD > time)
        {
            local pl = MainScript.GetScriptScope().GetPlayerClassByHandle(handle);
            ScriptPrintMessageChatAll(Chat_pref + "" + pl.name + " has set a new Record hacking the \x02Red\x01 Chest: \x04" + (time) + "\x01 sec. Previous Record was \x02" + RED_CHEST_RECORD + "\x01 sec (\x02-" + (RED_CHEST_RECORD - time) + "\x01 sec)")
            RED_CHEST_RECORD = time;
            RED_CHEST_RECORD_CLASS = pl;
        }
        if(RED_CHEST_RECORD == 0.00)
        {
            local pl = MainScript.GetScriptScope().GetPlayerClassByHandle(handle);
            ScriptPrintMessageChatAll(Chat_pref + "" + pl.name + " has set the First Record hacking the \x02Red\x01 Chest: \x04" + (time) + "\x01 sec");
            RED_CHEST_RECORD = time;
            RED_CHEST_RECORD_CLASS = pl;
        }
    }
}
IsStop <- false;

function Stop()
{
    if(IsStop)
        return;
    IsStop = true;
    EntFire("lock_four_body*", "RunScriptCode", "Stop()", 0);
    EntFire("lock_three_body*", "RunScriptCode", "Stop()", 0);

    EntFire("chest_0_button*", "Kill", "", 0);
    EntFire("chest_3_button*", "Kill", "", 0);
    EntFire("chest_4_button*", "Kill", "", 0); 
}

function InSight(start,target)
{
    if(TraceLine(start,target,null)<1.00)
    {
        //DebugDrawLine(start, target, 255,0,0, true, 5)
        return false;
    }
    //DebugDrawLine(start, target, 0,0,255, true, 5)
    return true;
}

// function DrawBox(origin,size,color,time)
// {
//     DebugDrawBox(origin, Vector(size,size,size), Vector(size,size,size)*-1, color.x, color.y, color.z, 50, time)
// }
