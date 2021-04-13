//#####################################################################
//Patched version intended for use with GFL ze_fe8_sacred_stones_v1_10 stripper
//Removes refire time modification after Formortiis enters second phase.
//Install as csgo/scripts/vscripts/gfl/level5_boss_controller_patched.nut
//#####################################################################

//current hp and others
formortiis_hp <- 0;
canhit <- 1;

//reference variable
full_hp <- 0;
each_bar <- 0;
formortiis_can_heal <- true;
function scaleHp(mode) {
	//0 = more hp, weaker attack
	//1 = less hp, stronger attack
	if (mode == 0) {
		formortiis_hp += 1800;
		full_hp += 1800;
		EntFire("formortiis_hp", "Add", "1800", 0.00);
		EntFire("level1_boss_counter_txt", "AddOutput", "message Formortiis: " + formortiis_hp, 0.00, null);
		EntFire("level1_boss_counter_txt", "Display", "", 0.00, null);
	}
	else {//for other purpose i can't think of
		formortiis_hp += 1800;
		full_hp += 1800;
		EntFire("formortiis_hp", "Add", "1800", 0.00);
	}
}

function halveBossHp() {
	formortiis_hp /= 2;
	EntFire("formortiis_hp", "SetValue", formortiis_hp.tostring(), 0.00);
	EntFire("level1_boss_counter_txt", "AddOutput", "message Formortiis: " + formortiis_hp, 0.00, null);
	EntFire("level1_boss_counter_txt", "Display", "", 0.00, null);
	each_bar = formortiis_hp / 4;
}

//subtract two if weak, else one
function onHit() {
	if (canhit == 1) {
		formortiis_hp -= 2;
		EntFire("formortiis_hp", "Subtract", "2", 0.00);
		printl(formortiis_hp.tostring());
		EntFire("level1_boss_counter_txt", "AddOutput", "message Formortiis: " + formortiis_hp, 0.00, null);
		EntFire("level1_boss_counter_txt", "Display", "", 0.00, null);
		checkIfBreak();
		if (formortiis_hp <= 0) {
			EntFire("formortiis_fire_1", "Stop", null, 0.00, null);
		}
	}
	else {
		formortiis_hp += 4;//to prevent trolling
		EntFire("formortiis_hp", "Add", "4", 0.00);
		EntFire("level1_boss_counter_txt", "AddOutput", "message Formortiis: " + formortiis_hp, 0.00, null);
		EntFire("level1_boss_counter_txt", "Display", "", 0.00, null);
		printl(formortiis_hp.tostring());
		checkIfRestore();
	}
}

//test this, change this to if and else
function checkIfBreak() {
	switch(formortiis_hp) {
		case (each_bar * 0) :
			EntFire("formortiis_fire_1", "Stop", null, 0.00, null);
			break;
		case (each_bar * 1) :
			EntFire("formortiis_fire_2", "Stop", null, 0.00, null);
			break;
		case (each_bar * 2) :
			if (formortiis_can_heal) {
				formortiis_can_heal = false;
				formortiis_hp += 1000;
				EntFire("formortiis_fire_3", "Stop", null, 0.00, null);
				EntFire("formortiis", "Skin", "1", 0.00, null);
				EntFire("formortiis", "AddOutput", "rendercolor 255 0 6", 0.00, null);
				EntFire("Server", "Command", "say <<<Hah, do you really think your guns can hurt me?>>>", 1.00, null);
				EntFire("Server", "Command", "say <<<***All damage increased! Attack frequency increased!***>>>", 2.00, null);
				EntFire("Server", "Command", "say <<<***Formortiis has healed himself***>>>", 3.00, null);
				EntFire("formortiis_hp", "Add", "1000", 0.00);
				EntFire("formortiis_light_hurt", "AddOutput", "damage 80", 0.00, null);
				EntFire("contagious_mist_trig", "AddOutput", "damage 28", 0.00, null);
				EntFire("contagious_mist_trig2", "AddOutput", "damage 28", 0.00, null);
				//EntFire("devil_bring_timer", "AddOutput", "RefireTime 1", 0.00, null);
				//EntFire("level5_mini_timer", "Enable", null, 1.00, null);
			}
			else {
				EntFire("formortiis_fire_3", "Stop", null, 0.00, null);
			}
			break;
		case (each_bar * 3) :
			EntFire("formortiis_fire_4", "Stop", null, 0.00, null);
			break;
	}
}

function checkIfRestore() {
	
}

function setHitVar(value) {
	canhit = value;
}

function addHp(value) {
	formortiis_hp += value;
	EntFire("formortiis_hp", "Add", value.tostring(), 0.00);
}