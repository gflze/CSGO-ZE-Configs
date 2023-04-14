//---------------------------------------------------------------------------------
// Problem:
//    players have found an exploit which gives them vscript-access
//    this could essentially be used to set cvars, cause mayhem, crash servers, etc
//    the following luffaren maps were initially affected by this issue:
//      - ze_pizzatime
//      - ze_best_korea
//      - ze_eternal_grove
//      - ze_drakelord_castle_b3
//    however, many other maps based their event script systems on these maps, including but not limited to:
//      - ze_japans_3rd_bombing_v8
//      - ze_noob_too_easy_v3_3a
//      - ze_ronald_v2
//      - ze_touhou_gensokyo_o4
// 
// Cause:
//    this is due to the older eventlistener setup in these maps, using EntFire/RunScriptCode to pass events
//    it can be done via text-injection through means such as:
//      - chat
//      - connect
//      - disconnect
//      - name change
//    thankfully newer luff-maps do not use this method to pass events, making them safe from injection
// 
// Solution:
//    this stripper + vscript combo replaces the EntFire/RunScriptCode method with a direct .GetScriptScope() call instead
//    this completely removes any user-input from being passed via a RunScriptCode-call, making it safe from injection
//    the same vscript can be used for all maps based on luffs system
//---------------------------------------------------------------------------------
//#####     PUT THIS FILE IN THIS FOLDER ON THE SERVER/HOST:
//#####          csgo/scripts/vscripts/gfl/inject_fix.nut
//---------------------------------------------------------------------------------
::injectfix_ent <- null;
function LuffInjectFixInit(scriptent)
{
	if(::injectfix_ent==null||!::injectfix_ent.IsValid())
	{
		::injectfix_ent = Entities.FindByName(null,scriptent);
	}
	if(::injectfix_ent==null||!::injectfix_ent.IsValid())					//just nullify all functions just in case
	{
		printl("LuffInjectFixInit ERROR : manager not found - logic might break as a result!");
		::OnGameEvent_player_say_raw<-function(p){}
		::OnGameEvent_player_connect_raw<-function(p){}
		::OnGameEvent_player_disconnect_raw<-function(p){}
		::OnGameEvent_player_changename_raw<-function(p){}
		return;
	}
	::OnGameEvent_player_say_raw<-function(p){
		::injectfix_ent.GetScriptScope().OnPlayerChat(p.userid,p.text);}
	::OnGameEvent_player_connect_raw<-function(p){
		::injectfix_ent.GetScriptScope().OnPlayerConnect(p.name,p.userid,p.networkid);}
	::OnGameEvent_player_disconnect_raw<-function(p){
		::injectfix_ent.GetScriptScope().OnPlayerDisconnect(p.userid,p.reason,p.name,p.networkid);}
	::OnGameEvent_player_changename_raw<-function(p){
		::injectfix_ent.GetScriptScope().OnPlayerChangeName(p.userid,p.oldname,p.newname);}
}
