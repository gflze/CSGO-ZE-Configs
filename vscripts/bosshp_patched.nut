//#####################################################################
//Patched version intended for use with GFL ze_SUMAI_facility_v1a stripper
//Removes HTML formatting broken after Shattered Web Update.
//Install as csgo/scripts/vscripts/gfl/bosshp_patched.nut
//#####################################################################

//Used by Darnias in ze_SUMAI_facility

maxhealth <- 0;
bar <- null;
hp <- null;
threshold <- 15;
threshold_relay <- "boss1_ability_enrage"
threshold_reached <- 0;

function GetMaxHealth(){
	if(caller == null) return;
	maxhealth = caller.GetHealth();
}

function SetThreshold(percent){
	threshold = percent;
}

function OnThresholdReached(){
	EntFire(threshold_relay, "Trigger", "");
	threshold_reached = 1;
}

function DisplayHP_Alert(){
	if(caller == null) return;
	local health = caller.GetHealth();
	local percent = 100 * health / maxhealth;
	
	if(percent <= threshold && threshold_reached == 0){
		OnThresholdReached();
	}
	
	//local rgb_difference = 2.55 * (100 - percent);
	//local red = 0 + rgb_difference;
	//local green = 255 - rgb_difference;
	
	//local hex_red = decToHex(red);
	//local hex_green = decToHex(green);
	//local hex_blue = decToHex(0);
	
	local HPDisplay = "Boss Health: " + health + " [" + percent + "%]";
	ScriptPrintMessageCenterAll(HPDisplay);
}

//function decToHex(val)
//{
//	val = floor(val);
//	local left = floor(val/16)
//	if(left >= 10)
//	{
//	left = (65+(left-10)).tochar()
//	}
//	local right = val-16*floor(val/16)
//	if(right >= 10)
//	{
//	right = (65+(right-10)).tochar()
//	}
//	return left.tostring()+right
//}