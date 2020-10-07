//#####################################################################
//Patched version intended for use with GFL ze_surf_shonyudo_v3_1 stripper
//Translate japanese msgs into english
//Install as csgo/scripts/vscripts/ze_surf_shonyudo/ze_surf_shonyudo_patched.nut
//#####################################################################

function text01()
{
ScriptPrintMessageChatAll(" \x05:: Hamon ::\x01")
ScriptPrintMessageChatAll(" \x10 The new settlement seems to be a further limestone cave.")
ScriptPrintMessageChatAll(" \x10 The seventh cave is no longer accessible due to flooding.")
ScriptPrintMessageChatAll(" \x10 All the work we did on route B is now under water...")
ScriptPrintMessageChatAll(" \x10 We can only hope that this place thrives too.");
}

function Hiteminfo01()
{
ScriptPrintMessageChatAll(" \x05:: ITEM_INFO ::\x01")
ScriptPrintMessageChatAll(" \x10【Name】\x01 Hellfire")
ScriptPrintMessageChatAll(" \x10【Effect】\x01 Flame-Attribute/Medium Damage + Burn")
ScriptPrintMessageChatAll(" \x10【Details】\x01 Reusable after \x02 50 \x01 seconds -- \x02 Range \x01");
}
