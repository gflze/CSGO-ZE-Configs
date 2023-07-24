//////////////////////////////////////////////////////////////
/*
	Author: Hez https://steamcommunity.com/id/Hez-Max/
	这个脚本用于 ze_border_b1
	Map information
	地图信息文档

	Update time: 2023/6/3
*/
//////////////////////////////////////////////////////////////

/*
-------------------------
	Colours
	x01 White 白
	x02 Red 红
	x03 Purple 紫
	x04 Vibrant Green 鲜绿色
	x05 Faded Green 湖滨绿
	x06 Less faded Green 淡湖滨绿？我瞎猜的 >_<
	x07 Faded Red 淡红
	x08 Gray 灰色
	x09 Faded Yellow 淡黄
	x10 Brownish Orange 桔棕色
	x0A Very Faded Blue 非常淡的蓝色
	x0B Faded Blue 淡蓝
	x0C Dark Blue 深蓝
-------------------------
TextColor
{
	Normal = 1,   // white
	Red,          // red
	Purple,       // purple
	Location,     // lime green
	Achievement,  // light green
	Award,        // green
	Penalty,      // light red
	Silver,       // grey
	Gold,         // yellow
	Common,       // grey blue
	Uncommon,     // light blue
	Rare,         // dark blue
	Mythical,     // dark grey
	Legendary,    // pink
	Ancient,      // orange red
	Immortal      // orange
}
-------------------------
*/



IncludeScript("vs_library")
function chat(meassage) {
    return Chat(meassage)
}

TEXT_BEFOR <- " \x06 >>> "
TEXT_AFTER <- " <<<"

test_meaaage_1 <- "\x01 >>> White白 <<< \x02 >>> Red红 <<< \x03 >>> Purple紫 <<< \x04 >>> Vibrant Green鲜绿色 <<< \x05 >>> Faded Green湖滨绿 \x06 >>> Less faded Green淡湖滨绿 <<< "
test_meaaage_2 <- "\x07 >>> Faded Red淡红 <<< \x08 >>> Gray灰色 <<< \x09 >>> Faded Yellow淡黄 <<< \x10 >>> Brownish Orange桔棕色 <<< \x0A >>> Very Faded Blue非常淡的蓝色 <<< \x0B >>> Faded Blue淡蓝 <<< \x0C >>> Dark Blue深蓝 <<< "
test_meaaage_3 <- TextColor.Red + "RED" + TextColor.Gold + " YELLOW" + TextColor.Normal + " WHITE"
map_message_warmup4 <- TEXT_BEFOR + "Thanks to \x04 Paranoid\x06 for translating into English" + TEXT_AFTER

//map_message_mapname <- TEXT_BEFOR + "Map\x04 BORDER \x06" + TEXT_AFTER

//map_message_mapname <- TEXT_BEFOR + "Map\x04 BORDER \x06" + TEXT_AFTER
map_message_mapname <- TEXT_BEFOR + "Map\x04 BORDER \x06" + TEXT_AFTER

map_message_mapper <- TEXT_BEFOR + "Map by\x04 Hez \x06" + TEXT_AFTER
map_message_warmup1 <- TEXT_BEFOR + "Warm UP" + TEXT_AFTER
map_message_warmup2 <- TEXT_BEFOR + "Thanks to \x04 G-Villagehead\x06 for providing with some inspiration on scene creating" + TEXT_AFTER
map_message_warmup3 <- TEXT_BEFOR + "Thanks to \x04 7ychu5\x06 for suggestion on compilation software" + TEXT_AFTER

map_message_1 <- TEXT_BEFOR + "Current Location: \x04UNKOWN\x06" + TEXT_AFTER
map_message_2 <- TEXT_BEFOR + "Real-time Location：\x04UNKOWN\x06" + TEXT_AFTER
map_message_3 <- TEXT_BEFOR + "Your Duty：\x04Volunteers for Flesh-element Test\x06" + TEXT_AFTER

    map_message_lv1 <- TEXT_BEFOR + "\x04The First Level\x06" + TEXT_AFTER
map_message_lv2 <- TEXT_BEFOR + "\x04The Second Level\x06" + TEXT_AFTER
map_message_lv3 <- TEXT_BEFOR + "\x04The Third Level\x06" + TEXT_AFTER

admin_l1 <- TEXT_BEFOR + "\x04The First Level is Chosen by Admin\x06" + TEXT_AFTER
admin_l2 <- TEXT_BEFOR + "\x04The Second Level is Chosen by Admin\x06" + TEXT_AFTER
admin_l3 <- TEXT_BEFOR + "\x04The Third Level is Chosen by Admin\x06" + TEXT_AFTER
admin_rtv <- TEXT_BEFOR + "\x04The RTV Level is Chosen by Admin\x06" + TEXT_AFTER



//////////////////////////////////////////////
///////////////////// item ///////////////////
//////////////////////////////////////////////

Item_Wall1_Pistol <- TEXT_BEFOR + "A player picks up the Item_Wall" + TEXT_AFTER
Item_Extinguisher_Pistol <- TEXT_BEFOR + "A player picks up the Item_Extinguisher" + TEXT_AFTER
Item_Fire_Pistol <- TEXT_BEFOR + "A player picks up the Item_Fire" + TEXT_AFTER
Item_Unstable_Element_Pistol <- TEXT_BEFOR + "A player picks up the Item_Unstable_Element" + TEXT_AFTER
Item_Stable_Element_Pistol <- TEXT_BEFOR + "A player picks up the Item_Stable_Element" + TEXT_AFTER
Item_Ammo_Pistol <- TEXT_BEFOR + "A player picks up the Item_Ammunition" + TEXT_AFTER



///////////////////////////////////////////////////////////
/////////////////// l1 <- TEXT_BEFOR + "" + TEXT_AFTER///////////////////
///////////////////////////////////////////////////////////

l1_door0 <- TEXT_BEFOR + "The door of the bathroom is locked. We have to blow it. The way will be passable in\x04 10 seconds" + TEXT_AFTER
l1_door1 <- TEXT_BEFOR + "The gate will be opened in \x04 25 seconds" + TEXT_AFTER
l1_element_room_1 <- TEXT_BEFOR + "There seems no way to leave here now. Come up an idea!" + TEXT_AFTER
l1_element_room_2 <- TEXT_BEFOR + "The button in security room can be used to open the iron gate. However, the button is locked now" + TEXT_AFTER
l1_element_room_3 <- TEXT_BEFOR + "It seems to be the element laboratory next door. Maybe we can use the sudden power surge of it to unlock the gates" + TEXT_AFTER
l1_element_room_4 <- TEXT_BEFOR + "The door of laboratory is opened, hurry up" + TEXT_AFTER

l1_element_room_door1 <- TEXT_BEFOR + "The door of laboratory is openning in \x04 35 seconds" + TEXT_AFTER
l1_element_room_door1_1 <- TEXT_BEFOR + "The door of laboratory is openning in \x04 10 seconds" + TEXT_AFTER
l1_element_room_door1_back <- TEXT_BEFOR + "The door of laboratory is openning in \x04 25 seconds" + TEXT_AFTER

l1_door2 <- TEXT_BEFOR + "The wire mesh door is openning in \x04 20 seconds" + TEXT_AFTER

l1_ob1_1 <- TEXT_BEFOR + "The road is blocked with concrete. Use the explosive!" + TEXT_AFTER
l1_ob1_2 <- TEXT_BEFOR + "The explosive is ready. Please be far from it" + TEXT_AFTER
l1_ob1_3 <- TEXT_BEFOR + "Keep for extra\x04 30 seconds \x06before the explosion" + TEXT_AFTER
l1_ob1_4 <- TEXT_BEFOR + "The fire is too strong to pass. Hurry to find the fire fighting buttons..." + TEXT_AFTER
l1_ob1_insert <- TEXT_BEFOR + "The way is blocked by crates. Defend for \x04 15 seconds \x06for explosion" + TEXT_AFTER

l1_door3 <- TEXT_BEFOR + "The way is passable in \x04 20 seconds" + TEXT_AFTER
l1_ob2 <- TEXT_BEFOR + "Defending for extra \x04 15 seconds \x06before the explosion" + TEXT_AFTER


l1_elevator1 <- TEXT_BEFOR + "Defending for \x04 15 seconds \x06until the lift arriving" + TEXT_AFTER
l1_elevator1_door <- TEXT_BEFOR + "The lift door will close in \x04 5 seconds" + TEXT_AFTER
l1_door5 <- TEXT_BEFOR + "Pay attention to the zombia way in \x04 5 seconds" + TEXT_AFTER

l1_door6_door7 <- TEXT_BEFOR + "Defending for \x04 25 seconds \x06until the rollong shutter door opens" + TEXT_AFTER

l1_ob3_1 <- TEXT_BEFOR + "We have arrived in the back door, which seems to be fragile. Let's prepare for a explosion party now!" + TEXT_AFTER
l1_ob3_2 <- TEXT_BEFOR + "Defending for \x04 8 seconds \x06until the explosion" + TEXT_AFTER
l1_ob3_3 <- TEXT_BEFOR + "The explosive hiden in the wall of the maintenance access is also detonated. Fucking somebody hid!" + TEXT_AFTER


l1_wire_0 <- TEXT_BEFOR + "No way forward. Retreat to the safe house" + TEXT_AFTER
l1_wire_1 <- TEXT_BEFOR + "We need to connect the wire to unlock the security door!" + TEXT_AFTER
l1_wire_2 <- TEXT_BEFOR + "Well done, the power will restart later, Defending for extra\x04 30 seconds!" + TEXT_AFTER

l1_wire_3 <- TEXT_BEFOR + "The power restart, hurry to open the security door" + TEXT_AFTER
l1_final_door1 <- TEXT_BEFOR + "Defending for \x04 20 seconds \x06until the security door close" + TEXT_AFTER

////////////////////////////////////////////////////////////
/////////////////// l2 <- TEXT_BEFOR + "" + TEXT_AFTER////////////////////
///////////////////////////////////////////////////////////

l2_start1 <- TEXT_BEFOR + "We have to access to the institute or we can't leave here. Check the main entrance." + TEXT_AFTER
l2_start2 <- TEXT_BEFOR + "It is locked just like predicted. We need to go to the control room on the closure to open it." + TEXT_AFTER
l2_start3 <- TEXT_BEFOR + "There should be the guide nextdoor" + TEXT_AFTER

l2_door1 <- TEXT_BEFOR + "The door of control room is opening in \x04 20 seconds" + TEXT_AFTER

l2_button2_1 <- TEXT_BEFOR + "Checking the limits of authority... Checking the state of the main entrance... preparing for open the main entrance" + TEXT_AFTER
l2_button2_2 <- TEXT_BEFOR + "Defending for\x04 10 secnonds \x06to open the main entrance" + TEXT_AFTER
l2_button2_3 <- TEXT_BEFOR + "Nop，the level of the limits is not enough! we fail to open the main entrance from the security room" + TEXT_AFTER
l2_button2_4 <- TEXT_BEFOR + "Our explosive can't do damage to the security door, we need to find another way" + TEXT_AFTER
l2_button2_5 <- TEXT_BEFOR + "The plan has changed, let's access it from the piping and maintence access" + TEXT_AFTER
l2_button2_tp1 <- TEXT_BEFOR + "Defending for\x04 30 seconds \x06until the zombie teleport" + TEXT_AFTER
l2_button2_tp2 <- TEXT_BEFOR + "The zombies has been teleported, hurry to the upper floor from the outside surfance of the piping" + TEXT_AFTER

l2_ob3 <- TEXT_BEFOR + "Defending for \x04 15 seconds \x06until the fence breaks" + TEXT_AFTER
l2_button3_1 <- TEXT_BEFOR + "pipong is openning in \x04 35 seconds" + TEXT_AFTER
l2_button3_2 <- TEXT_BEFOR + "zombies teleporting in \x04 15 seconds" + TEXT_AFTER

l2_ob8_1 <- TEXT_BEFOR + "The way is blocked by the crates. They are left here during the refugees evacuting" + TEXT_AFTER
l2_ob8_2 <- TEXT_BEFOR + "Hurry up. It seems that we should have an extra explosion party today!" + TEXT_AFTER
l2_ob8_3 <- TEXT_BEFOR + "Defending for \x04 10 seconds \x06before the explosion" + TEXT_AFTER

l2_door2 <- TEXT_BEFOR + "The office door unlock in \x04 30 seconds" + TEXT_AFTER
l2_door2_zm1 <- TEXT_BEFOR + "The teleportation outsides has closed, zombia can offense from the main entrance" + TEXT_AFTER
l2_door2_zm2 <- TEXT_BEFOR + "The main entrance and the office door unlock in meantime" + TEXT_AFTER
l2_door2_zm3 <- TEXT_BEFOR + "Zombies can offense from the secret passage" + TEXT_AFTER
l2_elevator1_1 <- TEXT_BEFOR + "lift button is pressed" + TEXT_AFTER
l2_elevator1_2 <- TEXT_BEFOR + "Defending for \x04 15 seconds \x06until the lift arrive" + TEXT_AFTER
l2_elevator1_3 <- TEXT_BEFOR + "lift door close in \x04 15 seconds" + TEXT_AFTER

l2_upper_ob1 <- TEXT_BEFOR + "barriers clears in \x04 15 seconds" + TEXT_AFTER

l2_hel_1 <- TEXT_BEFOR + "Great! There still exist a helicopter. It seems intact" + TEXT_AFTER
l2_hel_2 <- TEXT_BEFOR + "Before take on it, we need to refuel" + TEXT_AFTER
l2_hel_3 <- TEXT_BEFOR + "There is an oil pipline in the nearby storage. We can take it into use" + TEXT_AFTER

l2_button_oil_1 <- TEXT_BEFOR + "Refueling start, Defending until these five cans are filled in" + TEXT_AFTER
l2_button_oil_2 <- TEXT_BEFOR + "Well, these cans are ready. It is enough to leave here" + TEXT_AFTER
l2_button_oil_3 <- TEXT_BEFOR + "Retreat! Taking with these cans! We are about to leave the fucking place" + TEXT_AFTER

l2_hel_leave_1 <- TEXT_BEFOR + "Refueling complete" + TEXT_AFTER
l2_hel_leave_2 <- TEXT_BEFOR + "The helicopter is leaving in \x04 30 seconds" + TEXT_AFTER


////////////////////////////////////////////////////////////
/////////////////// l3 <- TEXT_BEFOR + "" + TEXT_AFTER////////////////////
///////////////////////////////////////////////////////////


l3_ob1 <- TEXT_BEFOR + "Defending for \x04 30 seconds \x06until the iron net breaks" + TEXT_AFTER
l3_door1 <- TEXT_BEFOR + "Defending for \x04 25 seconds \x06to open the door" + TEXT_AFTER
l3_door2 <- TEXT_BEFOR + "zombie passage door is opening in \x04 5 seconds" + TEXT_AFTER
l3_ob2 <- TEXT_BEFOR + "Defending for \x04 15 seconds \x06until the iron net breaks" + TEXT_AFTER
l3_elev1 <- TEXT_BEFOR + "lift is leaving in\x04 35 seconds" + TEXT_AFTER

l3_door3 <- TEXT_BEFOR + "The gate is opening in \x04 30 seconds" + TEXT_AFTER
l3_elev2 <- TEXT_BEFOR + "The lift is leaving in \x04 20 seconds" + TEXT_AFTER
l3_elev3 <- TEXT_BEFOR + "The lift in tunnels is leaving in \x04 35 seconds" + TEXT_AFTER

l3_door4 <- TEXT_BEFOR + "The gate open in \x04 20 seconds" + TEXT_AFTER
l3_elev4 <- TEXT_BEFOR + "The lift is leaving in \x04 20 seconds" + TEXT_AFTER

l1_elev_add1 <- TEXT_BEFOR + "The freight elevator is leaving in \x04 30 seconds" + TEXT_AFTER

l3_elev_ground <- TEXT_BEFOR + "The lift towards surface is leaving in\x04 30 seconds" + TEXT_AFTER

l3g_door1 <- TEXT_BEFOR + "The gate of the parking apron is openning in \x04 20 seconds" + TEXT_AFTER
l3g_ob_case1 <- TEXT_BEFOR + "The road is passable in \x04 20 seconds" + TEXT_AFTER
l3g_door2 <- TEXT_BEFOR + "The gate of the laboratory is opening in \x04 30 seconds" + TEXT_AFTER

lab_plat <- TEXT_BEFOR + "The platform rise in \x04 10 seconds" + TEXT_AFTER
lab_door2 <- TEXT_BEFOR + "The secret door is opening in \x04 20 seconds" + TEXT_AFTER

lab_door5 <- TEXT_BEFOR + "The door opens in \x04 40 seconds" + TEXT_AFTER
lab_door6 <- TEXT_BEFOR + "The door opens in \x04 10 seconds" + TEXT_AFTER

lab_door8 <- TEXT_BEFOR + "The gate of the core laboratory is opening in \x04 15 seconds" + TEXT_AFTER

lab_end1 <- TEXT_BEFOR + "The core teleporting experiment start several seconds later核心迁跃实验即将启动" + TEXT_AFTER
lab_end2 <- TEXT_BEFOR + "That's our last station! life or death!" + TEXT_AFTER
lab_end3 <- TEXT_BEFOR + "the teleportation equipment is openning in \x04 45 seconds" + TEXT_AFTER


rtv_end <- TEXT_BEFOR + "\x04 60 seconds \x06" + TEXT_AFTER
