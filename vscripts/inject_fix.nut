//---------------------------------------------------------------------------------
// Problem:
//    players have found an exploit which gives them vscript-access
//    this could essentially be used to set cvars, cause mayhem, crash servers, etc
//    the following maps are affected by this issue:
//      - ze_pizzatime
//      - ze_best_korea
//      - ze_eternal_grove
// 
// Cause:
//    this is due to the older eventlistener setup in these^ 3 maps, using EntFire/RunScriptCode to pass events
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
//    the same stripper+vscript can be used for all 3 maps, just copy and rename the .cfg to the actual mapname(s)
//---------------------------------------------------------------------------------
//#####     PUT THIS FILE IN THIS FOLDER ON THE SERVER/HOST:
//#####          csgo/scripts/vscripts/luffaren/inject_fix.nut
//---------------------------------------------------------------------------------
::injectfix_man <- null;
function LuffInjectFixInit()
{
	if(::injectfix_man==null||!::injectfix_man.IsValid())
	{
		::injectfix_man = Entities.FindByName(null,"mapmanager");			//ze_best_korea + ze_eternal_grove
		if(::injectfix_man==null||!::injectfix_man.IsValid())
			::injectfix_man = Entities.FindByName(null,"event_manager");	//ze_pizzatime
	}
	if(::injectfix_man==null||!::injectfix_man.IsValid())					//just nullify all functions just in case
	{
		printl("LuffInjectFixInit ERROR : manager not found - logic might break as a result!");
		::OnGameEvent_player_say_raw<-function(p){}
		::OnGameEvent_player_connect_raw<-function(p){}
		::OnGameEvent_player_disconnect_raw<-function(p){}
		::OnGameEvent_player_changename_raw<-function(p){}
		return;
	}
	::OnGameEvent_player_say_raw<-function(p){
		::injectfix_man.GetScriptScope().OnPlayerChat(p.userid,p.text);}
	::OnGameEvent_player_connect_raw<-function(p){
		::injectfix_man.GetScriptScope().OnPlayerConnect(p.name,p.userid,p.networkid);}
	::OnGameEvent_player_disconnect_raw<-function(p){
		::injectfix_man.GetScriptScope().OnPlayerDisconnect(p.userid,p.reason,p.name,p.networkid);}
	::OnGameEvent_player_changename_raw<-function(p){
		::injectfix_man.GetScriptScope().OnPlayerChangeName(p.userid,p.oldname,p.newname);}
}
LuffInjectFixInit();
