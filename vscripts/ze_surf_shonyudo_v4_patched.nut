//#####################################################################
//Patched version intended for use with GFL ze_surf_shonyudo_v4_1 stripper
//Translate japanese msgs into english
//Install as csgo/scripts/vscripts/gfl/ze_surf_shonyudo_v4_patched.nut
//#####################################################################

function text01()
{
ScriptPrintMessageChatAll(" \x05:: Hamon ::\x01")
ScriptPrintMessageChatAll(" \x10 The new settlement seems to be a further limestone cave.")
ScriptPrintMessageChatAll(" \x10 The seventh cave is no longer accessible due to flooding.")
ScriptPrintMessageChatAll(" \x10 All the work we did on route B is now under water...")
ScriptPrintMessageChatAll(" \x10 We can only hope that this place thrives too.");
}

function text02()
{
ScriptPrintMessageChatAll(" \x05:: Hamon ::\x01")
ScriptPrintMessageChatAll(" \x10 Something is wrong with him...")
ScriptPrintMessageChatAll(" \x10 I can feel a tremendous current coming from underneath the cave, but...")
ScriptPrintMessageChatAll(" \x10 You guys want to go check it out for a minute?");
}

function Hiteminfo01()
{
ScriptPrintMessageChatAll(" \x05:: ITEM_INFO ::\x01")
ScriptPrintMessageChatAll(" \x10【Name】\x01 Hellfire")
ScriptPrintMessageChatAll(" \x10【Effect】\x01 Flame-Attribute/Medium Damage + Burn")
ScriptPrintMessageChatAll(" \x10【Details】\x01 Reusable after \x02 50 \x01 seconds -- \x02 Range \x01");
}

function Secretinfo01()
{
ScriptPrintMessageChatAll(" \x05:: SYSTEM_INFO ::\x01")
ScriptPrintMessageChatAll(" \x10【Regenerative Fluids Lv1】\x01 The land came to life！");
}

function Secretinfo02()
{
ScriptPrintMessageChatAll(" \x05:: SYSTEM_INFO ::\x01")
ScriptPrintMessageChatAll(" \x10【Regenerative Fluids Lv2】\x01 The Sacred Darkness Crosses！");
}

function Secretinfo03()
{
ScriptPrintMessageChatAll(" \x05:: SYSTEM_INFO ::\x01")
ScriptPrintMessageChatAll(" \x10【Regenerative Fluids Lv3】\x01 I heard something crumbling...");
}

function Secretinfo04()
{
ScriptPrintMessageChatAll(" \x05:: SYSTEM_INFO ::\x01")
ScriptPrintMessageChatAll(" \x10 The one-time blood-tribe mode is lifted！\x01");
}