//#####################################################################
//Patched version intended for use with GFL ze_TESV_Skyrim_kr2 stripper
//Uses ?level as the main level check command to fix the misleading SM "no permission" response due to savelevel
//Install as csgo/scripts/vscripts/gfl/SavePlayersTargetname_patched.nut
//#####################################################################

/*
	https://github.com/darnias/Vscripts/blob/master/scripts/player_class.nut
	
	modified by godPY
	https://steamcommunity.com/id/asHYTPOASJGPONPOG/
	https://github.com/godPY
	About:
		modified player_class.nut for saving targetname when player retry.(ex. saving level)
		
	Required entities:
		logic_eventlistener:
			Targetname: listen_join
			Entity Scripts: player_class.nut
			Script think function: GenerateUserID
			Event Name: player_connect
			Fetch Event Data: Yes
				OnEventFired > listen_join > RunScriptCode > PlayerConnect(event_data)
		logic_eventlistener:
			Targetname: listen_disconnect
			Event Name: player_disconnect
			Fetch Event Data: Yes
				OnEventFired > listen_disconnect > RunScriptCode > PlayerDisconnect(event_data)	
		logic_eventlistener:
			Targetname: listen_info
			Event Name: player_info
			Fetch Event Data: Yes
				OnEventFired > listen_info > RunScriptCode > PlayerInfo(event_data)	
		logic_eventlistener:
			Targetname: listen_say
			Event Name: player_say
			Fetch Event Data: Yes
				OnEventFired > listen_say > RunScriptCode > PlayerSay(event_data)	
		game_round_end
			Targetname: listen_roundend
				OnRoundEnded > listen_join > RunScriptCode > RoundEnd()
				// Do not use !self on this entity, it will not worked.
*/

::Player <- class{
	name = null;
	index = null;
	userid = null;
	steamid = null;
	handle = null;
	constructor(i_name, i_entindex, i_userid, i_networkid, i_handle){
		name = i_name;
		index = i_entindex;
		userid = i_userid;
		steamid = i_networkid;
		handle = i_handle;
	}
	function DumpValues(){
		printl("------------");
		printl("Name: " + this.name);
		printl("Entindex: " + this.index);
		printl("UserID: " + this.userid);
		printl("SteamID: " + this.steamid);
		printl("Handle: " + this.handle);
		printl(" ");		
	}
	function setName(name){
		return this.name = name
	}
	function setIndex(entindex){
		return this.index = entindex
	}
	function setUserID(userid){
		return this.userid = userid
	}
	function setSteamID(steamid){
		return this.steamid = steamid
	}	
	function setHandle(handle){
		return this.handle = handle
	}
}

// ========================= Init & Debug =========================

function OnPostSpawn(){ // Called each time entity spawns (new round)
if (!("Players" in getroottable())){ // Create Table Players only once
	::Players <- {};
	::BackupPlayers <- {};
	}
if (!("event_proxy" in getroottable()) || !(::event_proxy.IsValid())){ // Create event proxy
	::event_proxy <- Entities.CreateByClassname("info_game_event_proxy");
	::event_proxy.__KeyValueFromString("event_name", "player_info");	
	}
}

::RestoreLevel <- function(player,targetname)
{
	player.__KeyValueFromString("targetname",targetname);
	if (targetname == "") {
            EntFire("ClientActivator", "Command", "r_screenoverlay KR/SCREENOVERLAY_level0", 0.0, player);
        } else if (targetname == "1") {
            EntFire("Score_Level1", "ApplyScore", "", 0.0, player);
			EntFire("ClientActivator", "Command", "r_screenoverlay KR/SCREENOVERLAY_level1", 0.0, player);
        } else if (targetname == "2") {
            EntFire("Score_Level2", "ApplyScore", "", 0.0, player);
			EntFire("ClientActivator", "Command", "r_screenoverlay KR/SCREENOVERLAY_level2", 0.0, player);
        } else if (targetname == "3") {
            EntFire("Score_Level3", "ApplyScore", "", 0.0, player);
			EntFire("ClientActivator", "Command", "r_screenoverlay KR/SCREENOVERLAY_level3", 0.0, player);
        } else if (targetname == "4") {
            EntFire("Score_Level4", "ApplyScore", "", 0.0, player);
			EntFire("ClientActivator", "Command", "r_screenoverlay KR/SCREENOVERLAY_level4", 0.0, player);
        }
	EntFire("ClientActivator", "Command", "r_screenoverlay additional_textures/none_screenoverlay", 15, player);
	DebugPrint("[DEBUG] restore targetname ["+targetname+"]");
}

::DEBUG <- false;
::DebugPrint <- function(text){ // Print misc debug text
	if (!DEBUG)return
	printl(text);
}

function DumpPlayers(){ // Dumps all players that are in Players table
	foreach (player in Players){
		player.DumpValues()
	}
}

// ========================= Event Functions =========================

::PlayerConnect <- function(event){
	if(event.networkid in BackupPlayers)
	{
	Players[event.userid] <- Player(BackupPlayers[event.networkid], null, event.userid, event.networkid, null); // entindex is null for now, event returns a 0
	DebugPrint("[PlayerConnect] - Add Player with backuped targetname");
	}
	else
	{
	Players[event.userid] <- Player("", null, event.userid, event.networkid, null); // entindex is null for now, event returns a 0
	DebugPrint("[PlayerConnect] - Add Player with None");
	}
}

::PlayerDisconnect <- function(event){
	BackupPlayers[event.networkid] <- Players[event.userid].name;
	try{
		DebugPrint("[PlayerDisconnect] - Deleted table entry " + Players[event.userid]);
		delete Players[event.userid];
	}
	catch(error){
		DebugPrint("[PlayerDisconnect] - Couldn't delete because " + error);
	}
}

::PlayerSay <- function(event){
    //modify this for printing level. (ex. entfire overlay)
    if(event.text == "!level" || event.text == "?level")
    {
        pl <- GetPlayerByUserID(event.userid)
        if (pl.GetName() == "") {
            EntFire("ClientActivator", "Command", "r_screenoverlay KR/SCREENOVERLAY_level0", 0.0, pl);
        } else if (pl.GetName() == "1") {
            EntFire("ClientActivator", "Command", "r_screenoverlay KR/SCREENOVERLAY_level1", 0.0, pl);
        } else if (pl.GetName() == "2") {
            EntFire("ClientActivator", "Command", "r_screenoverlay KR/SCREENOVERLAY_level2", 0.0, pl);
        } else if (pl.GetName() == "3") {
            EntFire("ClientActivator", "Command", "r_screenoverlay KR/SCREENOVERLAY_level3", 0.0, pl);
        } else if (pl.GetName() == "4") {
            EntFire("ClientActivator", "Command", "r_screenoverlay KR/SCREENOVERLAY_level4", 0.0, pl);
        }
		EntFire("ClientActivator", "Command", "r_screenoverlay additional_textures/none_screenoverlay", 5, pl);
        printl("Your level is " + Players[event.userid].name);
    }
}

::RoundEnd <- function(){
	DebugPrint("[RoundEnd] - Backup players level");
	try{
		foreach (player in Players){
			player.name = player.handle.GetName();
			DebugPrint("[RoundEnd] - Backup "+ player +" level "+player.name);
		}
	}
	catch(error){
		DebugPrint("[RoundEnd] - Couldn't backup because " + error);
	}
}

// ========================= Find Functions =========================

::GetPlayerByUserID <- function(userid){ // Returns players handle if the userid matches
	try{
		return Players[userid].handle
	}
	catch(error){
		return null
	}
}

::GetPlayerByIndex <- function(entindex){ // Returns players handle if the entindex matches
	foreach (player in Players){
		if (player.index == entindex){
			return player.handle
		}
	}
	return null
}

::GetPlayerBySteamID <- function(steamid){ // Returns players handle if the steamid matches
	foreach (player in Players){
		if (player.steamid == steamid){
			return player.handle
		}
	}
	return null
}

// ========================= Data Collection and Distribution =========================

::PlayerInfo <- function(event){ // Assigns class values to players script scope
	local generated_scope = generated_player.GetScriptScope();
	DebugPrint("[PlayerInfo] - Trying to add UserID " + event.userid + " to Players");
	if (!(event.userid in Players)){ // Player doesn't exist in the table	
		Players[event.userid] <- Player("", generated_player.entindex(), event.userid, null, generated_player);
		generated_scope.name <- "";
		generated_scope.index <- Players[event.userid].index;
		generated_scope.userid <- Players[event.userid].userid;
		generated_scope.steamid <- null;
		generated_scope.handle <- Players[event.userid].handle;
		DebugPrint("[PlayerInfo] - UserID " + event.userid + " (index " + generated_player.entindex() + ") added to Players");
	}
	else if (event.userid in Players && Players[event.userid].index == null){ // Player added through PlayerConnect, but we still need to add Index and Handle
		Players[event.userid].setIndex(generated_player.entindex());
		Players[event.userid].setHandle(generated_player);
		generated_scope.name <- Players[event.userid].name;
		generated_scope.index <- Players[event.userid].index;
		generated_scope.userid <- Players[event.userid].userid;
		generated_scope.steamid <- Players[event.userid].steamid;
		generated_scope.handle <- Players[event.userid].handle;
		DebugPrint("[PlayerInfo] - UserID " + event.userid + " already in table, setting index to " + generated_player.entindex() + " and handle to " + generated_player +" with Restore level");
		RestoreLevel(Players[event.userid].handle,Players[event.userid].name);
	}
	else if (event.userid in Players && Players[event.userid].index != null){ // Player exists in table and his entindex is set
		DebugPrint("[PlayerInfo] - UserID " + event.userid + " is already in Players");
	}	
}

function GenerateUserID(){ // Looping Think function, assigns 1 player per loop
	local p = null;
	while (p = Entities.FindByClassname(p, "*")){
		if (p.GetClassname() == "player" || p.GetClassname() == "cs_bot"){
			if (p.ValidateScriptScope()){
				local script_scope = p.GetScriptScope();
				if (!("GeneratedUserID" in script_scope)){
					::generated_player <- p;
					script_scope.GeneratedUserID <- true;
					EntFireByHandle(event_proxy, "GenerateGameEvent", "", 0, p, null);
					DebugPrint("[GenerateUserID] - Generated UserID for " + p);
					break
				}
			}else
			{
				
			}
		}
	}
}