

//ze_best_korea


stage <- 1;

function Start()
{
	luffsprited = 1;
	grenadescale = 1.00;
	grenadeindex = 1;
	EntFireByHandle(self,"RunScriptCode"," StartMap(); ",8.00,null,null);
	EntFire("fade_from_black_spawn_all","Fade","",10.00,null);
	EntFire("fade_spawn_1","Fade","",0.00,null);
	EntFire("fade_spawn_2","Fade","",8.00,null);
	local screen = "r_screenoverlay XXX_nothing_XXX";
	if(stage==1)screen = "r_screenoverlay luffaren/nk_act_1";
	else if(stage==2)screen = "r_screenoverlay luffaren/nk_act_2";
	else if(stage==3)screen = "r_screenoverlay luffaren/nk_act_3";
	else if(stage==4)screen = "r_screenoverlay luffaren/nk_act_4";
	else if(stage==5)screen = "r_screenoverlay luffaren/nk_act_5";
	local h=null;while(null!=(h=Entities.FindInSphere(h,self.GetOrigin(),500000)))
	{
		if(h.GetClassname()=="player"&&h.GetHealth()>0)
		{
			EntFire("client","Command",screen,0.00,h);
			EntFire("client","Command","r_screenoverlay XXX_nothing_XXX",10.00,h);
		}
	}
}

function PlayerRespawn()
{
	if(roundstart)//on round start
	{
		EntFireByHandle(activator,"AddOutput","targetname player_newround",0.00,null,null);
		EntFireByHandle(activator,"AddOutput","gravity 1.0",0.00,null,null);
		EntFireByHandle(activator,"AddOutput","modelscale 1.0",0.00,null,null);
		EntFireByHandle(activator,"SetDamageFilter","",0.00,null,null);
		EntFire("client","Command","r_screenoverlay XXX_nothing_XXX",5.00,activator);
	}
}roundstart <- true;

function RoundEnd()
{
	EntFire("i_babysuicide_poopybutt*","Break","",3.00,null);
	EntFire("i_nksoldier_hp*","Break","",3.00,null);
	EntFire("i_nkbabysoldier_hp*","Break","",3.00,null);
	EntFire("i_mine_phys*","Break","",3.00,null);
	EntFire("s_patron_cover","AddOutput","targetname patron_cover",1.00,null);
	EntFire("patron*","Kill","",3.00,null);
	EntFire("KILLME","Kill","",3.00,null);
	EntFire("trigger_multiple","Kill","",3.00,null);
	EntFire("ambient_generic","Kill","",3.00,null);
	EntFire("func_breakable","Kill","",3.00,null);
	EntFire("trigger_hurt","Kill","",3.00,null);
	EntFire("trigger_teleport","Kill","",3.00,null);
	EntFire("func_button","Kill","",3.00,null);
}

function StartMap()
{
	roundstart = true;
	EntFire("shadow","AddOutput","maxshadowdistance 2048",0.00,null);
	EntFire("teleport_spawn","Enable","",1.00,null);
	EntFire("masterbutton","AddOutput","material 10",0.00,null);
	EntFire("masterbutton2","AddOutput","material 10",0.00,null);
	EntFireByHandle(self,"RunScriptCode"," roundstart = false; ",7.00,null,null);
	EntFire("teleport_relay","Enable","",7.00,null);
	EntFire("teleport_sprite","ToggleSprite","",7.00,null);
	EntFire("spawnmanager","RunScriptCode"," Start(); ",0.00,null);
	patronpos = Vector(0,0,9500);
	UpdateGrenades();
	if(stage==1)
	{
		EntFire("fog","TurnOn","",0.00,null);
		EntFire("spawnmanager","RunScriptCode"," Spawn(0,0.70); ",0.00,null);
		EntFire("patreon_button_parent","AddOutput","angles 0 300 0",0.00,null);
		EntFire("patreon_button_parent","AddOutput","origin -150 -11150 -590",0.00,null);
		EntFire("skybox_s2_fake","SetParent","skybox_parenter",5.00,null);
		EntFire("teleport_destination","AddOutput","origin -512 -14592 -600",0.00,null);
		EntFire("shadow","AddOutput","maxshadowdistance 1000",0.10,null);
		EntFire("teleport_destination","AddOutput","angles 0 90 0",0.00,null);
		EntFire("skybox_s2","Kill","",0.00,null);
		EntFire("music_solemn","PlaySound","",0.00,null);
		EntFire("server","command","sv_airaccelerate 12",0.00,null);
		EntFire("skybox_s3","AddOutput","angles 0 318 0",0.00,null);
		EntFire("skybox_s3","AddOutput","origin 12950 -12300 13750",0.00,null);
		EntFire("skybox_s3","SetParent","skybox_parenter",0.10,null);
	}
	else if(stage==2)
	{
		EntFire("spawnmanager","RunScriptCode"," Spawn(2,0.70); ",0.00,null);
		EntFire("patreon_button_parent","AddOutput","angles 0 270 0",0.00,null);
		EntFire("patreon_button_parent","AddOutput","origin -11120 -9675 -80",0.00,null);
		EntFire("skybox_s3","AddOutput","angles 0 8 0",0.00,null);
		EntFire("skybox_s3","AddOutput","origin 10980 -12395 14159",0.00,null);
		EntFire("fog","TurnOn","",0.00,null);
		EntFire("skybox_s2_fake","Kill","",0.00,null);
		EntFire("i_builder_hold_c4","AddOutput","modelscale 3.0",0.00,null);
		EntFire("shadow","AddOutput","maxshadowdistance 1500",0.10,null);
		EntFire("teleport_destination","AddOutput","origin -11776 -11776 40",0.00,null);
		EntFire("teleport_destination","AddOutput","angles 0 90 0",0.00,null);
		EntFire("skybox_groundmodel","AddOutput","angles 0 40 0",0.05,null);
		EntFire("skybox_groundmodel","AddOutput","origin 11064 -13330 14340",0.05,null);
		EntFire("music_stage2","PlaySound","",5.00,null);
		EntFire("town_start_entrancedoors","Open","",3.00,null);
		EntFire("server","command","sv_airaccelerate 12",0.00,null);
	}
	else if(stage==3)
	{
		EntFire("spawnmanager","RunScriptCode"," Spawn(3,0.70); ",0.00,null);
		EntFire("patreon_button_parent","AddOutput","angles 0 0 0",0.00,null);
		EntFire("patreon_button_parent","AddOutput","origin 11920 -15540 5170",0.00,null);
		EntFire("skybox_s2","Kill","",0.00,null);
		EntFire("skybox_s2_fake","Kill","",0.00,null);
		EntFire("fog","TurnOff","",0.00,null);
		EntFire("s3_excellentstart","Disable","",23.00,null);
		EntFire("s3_uppershortcut","Open","",0.00,null);
		EntFire("s3_hansen","Open","",0.00,null);
		EntFire("s3_hansen2","Open","",0.00,null);
		EntFire("s3_hansen3","Open","",0.00,null);
		EntFire("music_stage3_start","PlaySound","",1.00,null);
		EntFire("s3_gachi_gape_castle*","AddOutput","rendermode 2",0.00,null);
		EntFire("s3_gachi_gape_castle*","AddOutput","rendercolor 255 255 255 0",0.00,null);
		EntFire("s3_pringles_ladder","Open","",0.00,null);
		EntFire("s3_pringles_ladder2","Open","",0.00,null);
		EntFire("s3_gachi_springs","RunScriptCode"," function ORGSET(){activator.SetOrigin(self.GetOrigin());} ",0.00,null);
		EntFire("s1_airship","Kill","",0.00,null);
		EntFire("shadow","AddOutput","maxshadowdistance 1500",0.10,null);
		EntFire("skybox_s1","ClearParent","",1.00,null);
		EntFire("skybox_s1","AddOutput","origin 11000 -15250 14900",2.05,null);
		EntFire("teleport_destination","AddOutput","origin 11776 -15936 5130",0.00,null);
		EntFire("teleport_destination","AddOutput","angles 0 90 0",0.00,null);
		EntFire("skybox_groundmodel","AddOutput","modelscale 1.6",0.02,null);
		EntFire("skybox_groundmodel","AddOutput","angles 0 28 0",0.05,null);
		EntFire("skybox_groundmodel","AddOutput","origin 11664 -14552 14632",0.05,null);
		EntFire("s3_startdoor","Open","",3.00,null);
		EntFire("s3_start_tp_push","Enable","",25.00,null);
		EntFire("s3_start_z_surfprotect","Enable","",20.00,null);
		EntFire("server","command","say ***ZOMBIE SURF PROTECTOR IS NOW ACTIVE***",20.00,null);
		EntFire("server","command","sv_airaccelerate 100",0.00,null);
		EntFire("server","command","say ***DEFEND FOR SOME TIME***",45.00,null);
		EntFire("server","command","say ***THE GATES WILL OPEN IN BALANCED ORDER***",46.00,null);
		EntFire("s3_booster_lower","Enable","",70.00,null);
		EntFire("s3_gate_lower","Open","",90.00,null);
		EntFire("s3_gate_mid","Open","",74.00,null);
		EntFire("s3_gate_upper","Open","",70.00,null);
		EntFire("sound_horn1","PlaySound","",85.00,null);
	}
}

function StageWon()
{
	if(stage==1)stage=2;
	else if(stage==2)stage=3;
	else if(stage==3)stage=1;
}

function GiveModel(index)
{
	if(activator!=null&&activator.IsValid()&&activator.GetClassname()=="player"&&activator.GetTeam()==3&&activator.GetHealth()>0)
	{
		if(index==1)activator.SetModel("models/player/custom_player/luffaren/mister_muscle.mdl");
		else if(index==2)activator.SetModel("models/player/custom_player/luffaren/santa.mdl");
		else if(index==3)activator.SetModel("models/player/custom_player/luffaren/pizzaplayer.mdl");
		else if(index==4)activator.SetModel("models/player/custom_player/luffaren/jarjarbinks.mdl");
	}
}

grenadescale <- 1.00;
grenadeindex <- 1;
function UpdateGrenades()
{
	EntFire("hegrenade_projectile","AddOutput","modelscale "+grenadescale.tostring(),0.00,null);
	EntFireByHandle(self,"RunScriptCode"," UpdateGrenades(); ",0.05,null,null);
}
function SetGrenadeSize()
{
	if(grenadeindex<6){grenadeindex++;grenadescale+=1.00;EntFire("patron_hegrenade","AddOutput","modelscale "+grenadescale.tostring(),0.00,null);}
	else{grenadeindex=1;grenadescale=1.00;EntFire("patron_hegrenade","AddOutput","modelscale "+grenadescale.tostring(),0.00,null);}
}

function SpawnTemplate(tem,amount)
{
	if(activator==null||!activator.IsValid())return null;
	local pos=activator.GetOrigin();pos.z+=48;local time=0.02;
	local ppos="origin "+pos.x+" "+pos.y+" "+pos.z;EntFire(tem,"AddOutput",ppos,0.00,null);
	for(local i=0;i<amount;i++){EntFire(tem,"ForceSpawn","",time,null);time+=0.02;}
}

function BeatLight(force,iterations)
{
	local p = GetPlayerClassBySteamID("STEAM_1:0:95388502");
	if(p!=null&&p.handle!=null)
	{
		EntFireByHandle(p.handle,"IgniteLifeTime","10",0.00,null,null);
		local it = 0.00;
		for(local i=0;i<iterations;i++)
		{
			EntFireByHandle(p.handle,"AddOutput","basevelocity "+RandomInt(-force,force).tostring()+" "+
			RandomInt(-force,force).tostring()+" "+RandomInt(-force,force).tostring(),it,null,null);
			it+=0.45;
		}
	}
}

function CheckChewie()
{
	if(GetPlayerClassBySteamID("STEAM_1:0:71706935")!=null)
	{
		EntFire("server","Command","say chewie is a stupid malay",0.00,null);
		EntFire("server","Command","say chewie is a stupid malay",0.01,null);
		EntFire("server","Command","say chewie is a stupid malay",0.02,null);
		EntFire("server","Command","say chewie is a stupid malay",0.03,null);
		EntFire("server","Command","say chewie is a stupid malay",0.04,null);
	}
}

function DiddleWilford()
{
	local p = GetPlayerClassBySteamID("STEAM_1:0:59982706");
	if(p!=null&&p.handle!=null&&p.userid!=null)BabyBomb(p.userid);
}

function BabyBomb(id)
{
	local p = GetPlayerClassByUserID(id.tointeger());
	if(p!=null&&p.handle!=null)
	{
		EntFire("s_nkbabysoldier_maker","ForceSpawnAtEntityOrigin","!activator",0.00,p.handle);
		EntFire("s_nkbabysoldier_maker","ForceSpawnAtEntityOrigin","!activator",0.01,p.handle);
		EntFire("s_nkbabysoldier_maker","ForceSpawnAtEntityOrigin","!activator",0.02,p.handle);
		EntFire("s_nkbabysoldier_maker","ForceSpawnAtEntityOrigin","!activator",0.03,p.handle);
		EntFire("s_nkbabysoldier_maker","ForceSpawnAtEntityOrigin","!activator",0.04,p.handle);
		EntFire("s_nkbabysoldier_maker","ForceSpawnAtEntityOrigin","!activator",0.05,p.handle);
		EntFire("i_nkbabysoldier*","FireUser2","",0.10,p.handle);
	}
}

function KillAll()
{
	local h=null;while(null!=(h=Entities.FindInSphere(h,self.GetOrigin(),500000)))
	{if(h.GetClassname()=="player"&&h.GetHealth()>0)EntFireByHandle(h,"SetHealth","-69",0.00,null,null);}
}

luffsprited <- 1;
function RemoveLuffSprite()
{
	if(luffsprited>3)return null;
	if(activator!=null&&activator.IsValid()&&activator.GetClassname()=="player"&&activator.GetHealth()>0)
	{
		local pc = GetPlayerClassByHandle(activator);
		if(pc!=null&&pc.userid==MASTER)
		{
			luffsprited++;
			if(luffsprited==2)
			{
				EntFire("client","Command","r_screenoverlay XXX_nothing_XXX",0.00,pc.handle);
				EntFire("fade_from_green","Fade","",0.00,pc.handle);
			}
			else if(luffsprited==3)
			{
				luffsprited = 5;
				EntFire("fade_from_soldierslow","Fade","",0.00,pc.handle);
				EntFire("event_us_sprite","Kill","",0.00,null);
				EntFire("masterbutton2","Break","",0.00,null);
			}
		}
	}
}

function HealthBuff()
{
	local h=null;while(null!=(h=Entities.FindInSphere(h,self.GetOrigin(),500000)))
	{if(h.GetClassname()=="player"&&h.GetHealth()>0){if(h.GetHealth()<300)EntFireByHandle(h,"AddOutput","health 300",0.00,null,null);}}
}

//======================================================================================================\\
PATRONS<-["STEAM_1:1:22521282",	//Luffaren
//-------------------
"STEAM_1:0:48139771",			//NOTEN				http://steamcommunity.com/id/notlowenfels 
"STEAM_1:0:34155146",			//Thepie48			http://steamcommunity.com/profiles/76561198028576020
"STEAM_1:1:153776903",			//Qahnaarin			http://steamcommunity.com/id/rigelxi 
"STEAM_1:1:23249841",			//Nick(trlg)		http://steamcommunity.com/id/76561198006765411
"STEAM_1:0:33264736",			//Me-me				http://steamcommunity.com/profiles/76561198026795200 
"STEAM_1:0:40225637",			//Kikofly			http://steamcommunity.com/id/kikofly
"STEAM_1:1:50601153"			//Whim4life			http://steamcommunity.com/id/whim4life 
//-------------------
];function IsPatron(playerhandle){local pc = GetPlayerClassByHandle(playerhandle);
if(pc!=null&&pc.steamid!=null&&pc.handle!=null&&pc.handle.IsValid()&&pc.handle.GetHealth()>0)
{foreach(pat in PATRONS){if(pc.steamid==pat)return true;}}
return false;
}patronpos <- Vector(0,0,9500);
function SetPatronButtonPos(){patronpos = caller.GetOrigin();}
function TickPatron(){
if(activator!=null&&activator.IsValid()&&activator.GetHealth()>0)
{if(activator.GetName()=="player_patron_in"&&activator.GetHealth()>401)
{EntFireByHandle(self,"RunScriptCode"," ReturnPatron(); ",0.00,activator,activator);
EntFireByHandle(activator,"AddOutput","origin 0 0 9500",0.02,activator,activator);
EntFireByHandle(activator,"AddOutput","origin 0 0 9500",0.03,activator,activator);
EntFireByHandle(activator,"AddOutput","origin 0 0 9500",0.05,activator,activator);}
else EntFireByHandle(self,"RunScriptCode"," TickPatron(); ",0.03,activator,activator);}}
function CheckPatron(){if(IsPatron(activator)&&activator.GetHealth()<401){
local pos = activator.GetOrigin();EntFireByHandle(activator,"AddOutput","origin -288 0 9808",0.00,null,null);
EntFire("s_patron_stuff","FireUser1","",0.00,null);
EntFireByHandle(self,"RunScriptCode"," TickPatron(); ",0.02,activator,activator);
EntFireByHandle(activator,"AddOutput","targetname player_patron_in",0.10,null,null);
EntFireByHandle(self,"RunScriptCode"," ReturnPatron(); ",15.00,activator,activator);
EntFire("playermod","RunScriptCode"," SetVelocity(0,0,0); ",0.00,activator);}else EntFire("fade_from_soldierslow","Fade","",0.00,activator);}
function ReturnPatron(){if(activator!=null&&activator.IsValid()&&activator.GetClassname()=="player"&&activator.GetHealth()>0)
{if(activator.GetName()=="player_patron_in"){EntFireByHandle(activator,"AddOutput","targetname player_patreon",0.00,null,null);
EntFireByHandle(activator,"AddOutput","origin "+patronpos.x+" "+patronpos.y+" "+patronpos.z,0.02,null,null);
EntFire("playermod","RunScriptCode"," SetVelocity(0,0,0); ",0.00,activator);}}}
//===================================\\
// Map Manager script by Luffaren (STEAM_1:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/mapmanager/)
// (STORE PLAYER DATA BELOW IF NEEDED)
// PLAYERS <--- array that contains all Player classes
// (FUNCTIONS:)
//> GetPlayerClassByUserID(userid)		---	returns playerclass from userid		(int)
//> GetPlayerClassBySteamID(steamid)	---	returns playerclass from steamid	(string)
//> GetPlayerClassByHandle(handle)		---	returns playerclass from handle		(handle)
//> GetPlayerClassByName(name)			---	returns playerclass from name		(string)
//> GetPlayer(userid)					---	returns player handle from userid	(int)
//> GetID(handle)						---	returns userid from player handle	(handle)
//===================================\\
class Player{//===========\\
//..
//..
//..   custom data here
//..
//..
//====[READ-ONLY-DATA]====\\
connected = true;	//bool
userid = null;		//integer
steamid = null;		//string
name = null;		//string
handle = null;		//handle
constructor(_u,_s,_n){userid=_u;steamid=_s;name=_n;}}
//====================================\\
//=======[ DO NOT TOUCH BELOW ]=======\\
//====================================\\
ID_CHECK_RATE <- 70;//7 secs between each userid-validation-check (minimum: 65 *or things might break*)
ticking<-ID_CHECK_RATE; function ThinkStart(){if(ticking<=0){ticking=ID_CHECK_RATE;ValidatePlayerInstance();}else ticking--;}
function ScanPlayerInstance(id,entindex){local par=" RegisterPlayerInstance("+id+","+entindex+"); ";EntFireByHandle(self,"RunScriptCode",par,0.06,null,null);}
MASTER<-null;PLAYERS<-[];
function ValidatePlayerInstance()
{
	local htime=0.00;local h = null;while(null!=(h=Entities.FindInSphere(h,self.GetOrigin(),500000)))
	{if(h.GetClassname()=="player"){local hs=h.GetScriptScope();
	if(hs==null||!("userid" in hs)){EntFire("event_us_maker","ForceSpawnAtEntityOrigin","!activator",htime,h);htime+=0.10;}
	else if(GetPlayerClassByUserID(hs.userid)==null||GetPlayerClassByUserID(hs.userid).handle==null)
	{EntFire("event_us_maker","ForceSpawnAtEntityOrigin","!activator",htime,h);htime+=0.10;}}}
}
function RegisterPlayerInstance(id,entindex)
{
	local e=Entities.First();while(e.entindex()!=entindex&&(e=Entities.Next(e))!=null);
	if(e!=null&&e.GetPreTemplateName()=="event_us_door")
	{
		local hss = e.GetScriptScope();if(("han" in hss))
		{
			EntFireByHandle(e.GetScriptScope().han,"RunScriptCode"," userid<-"+id+"; ",0.00,null,null);
			local exists = false;
			foreach(p in PLAYERS){if(p.userid==id){p.handle=e.GetScriptScope().han;p.userid=id;exists=true;break;}}
			if(!exists){local np=Player(id,null,null);np.handle=e.GetScriptScope().han;PLAYERS.push(np);}
		}
	}
}
function TickMaster()
{
	local mas=GetPlayer(MASTER);if(mas!=null&&mas.IsValid()&&mas.GetHealth()>0){local spritepos = "origin "+mas.GetOrigin().x+" "+mas.GetOrigin().y+" "+(mas.GetOrigin().z+96);
	EntFireByHandle(mas,"AddOutput","origin -150 0 9790",0.50,mas,mas);
	EntFireByHandle(mas,"RunScriptCode"," self.SetAngles(0,180,0); ",0.50,mas,mas);
	EntFire("game_voidbuyset","Use","",0.00,mas);
	EntFire("event_us_sprite","AddOutput",spritepos,0.00,null);EntFire("event_us_sprite","SetParent","!activator",0.00,mas);EntFire("event_us_sprite","ToggleSprite","!activator",0.00,mas);
	EntFire("event_us_score","ApplyScore","",0.00,mas);}else EntFireByHandle(self,"RunScriptCode"," TickMaster(); ",5.00,null,null);
}
function CheckConnected(name,id,steamid)
{
	if(steamid=="STEAM_1:1:22521282")MASTER=id;local sid=steamid;
	foreach(p in PLAYERS){if(p.steamid==sid&&p.steamid!="BOT"){sid="XXX";p.name=name;p.userid=id;p.connected=true;break;}}
	if(sid!="XXX"){PLAYERS.push(Player(id,steamid,name));}
}
function OnPlayerConnect(name,id,steamid){}
function OnPlayerDisconnect(id,reason,name,steamid){foreach(p in PLAYERS){if(p.userid==id){p.handle=null;p.steamid=steamid;p.connected=false;break;}}}
function GetPlayerClassByUserID(userid){foreach(p in PLAYERS){if(p.userid==userid)return p;}return null;}
function GetPlayerClassByName(name){foreach(p in PLAYERS){if(p.name==name)return p;}return null;}
function GetPlayerClassBySteamID(steamid){foreach(p in PLAYERS){if(p.steamid==steamid)return p;}return null;}
function GetPlayerClassByHandle(player){foreach(p in PLAYERS){if(p.handle==player)return p;}return null;}
function GetPlayer(userid)
{
	if(userid==0)return null;player <- null;
	while((player=Entities.FindByClassname(player,"*"))!=null){if(player.GetClassname()=="player"){
	if(player.ValidateScriptScope()){local script_scope=player.GetScriptScope();
	if("userid" in script_scope && script_scope.userid==userid)return player;}}}return null
}
function GetID(player){if(player == null)return null;local script_scope=player.GetScriptScope();
if(player.ValidateScriptScope()){if("userid" in script_scope)return script_scope.userid;}
return null;}function OnDoorMoving(id,entindex){}
function OnPlayerChat(id,text)
{
	if(MASTER==null)return null;else if(id==MASTER)
	{
		//====================================\\
		//[CHAT CONTROL]
		//======>	full !ef (ent_fire) control
		//======>	set !activator of the output if needed by "/idX"
		//======>	call single/mass outputs directly to ents, players or groups of players
		//======>	or call outputs to ents with players/groups of players as !activator
		//======>	NOTE: quotation marks (") do not work, use (') as quotation marks instead
		//======>	NOTE: there is a character limit to what you can type, use with care
		//======>	[EXAMPLES]
		//======>	!ef func_rotating kill
		//======>	!ef boss_relay trigger
		//======>	!ef /id513 !activator sethealth 10
		//======>	!ef /idct !activator addoutput origin 0 0 0
		//======>	!ef /idt player_speedmod ModifySpeed 0.5
		//======>	!ef /idme !activator sethealth 50
		//======>	!ef /idme !activator runscriptcode mystring <- 'hello world';
		//======>	!ef /idme !activator runscriptcode printl(mystring);
		//======>	!ef /id!me !activator addoutput origin 0 0 0
		//======>	!ef /idt explosion_env_maker forcespawnatentityorigin !activator
		//======>	!ef /idrandom !activator sethealth 10
		//======>	!ef /idrandomct !activator ignitelifetime 10
		//======>	!ef /idrandomt !activator addoutput origin 0 0 0
		//==========================================================================\\
		text=(text+" ");local txt=text.tolower();if(txt.find("!ef")==0)
		{
			local compiledquote=false;while(!compiledquote){local qidx=text.find("'");if(qidx==null){compiledquote=true;}else{local qs=text.slice(0,qidx);local qe=text.slice(qidx+1,text.len());text=qs+"\""+qe;}}
			local ef=text;local eftarget=null;ef=ef+" ";
			ef=ef.slice(4,ef.len());local _tname="";local _oput="";local _pmeter="";local _pmeter2="";
			local cdx=ef.find(" ");if(cdx!=null){_tname=ef.slice(0,cdx);ef=ef.slice(cdx+1,ef.len());}
			cdx=ef.find(" ");if(cdx!=null){_oput=ef.slice(0,cdx);ef=ef.slice(cdx+1,ef.len()-1);_pmeter=ef;}
			cdx=ef.find(" ");if(cdx!=null){_pmeter=ef.slice(0,cdx);ef=ef.slice(cdx+1,ef.len());_pmeter2=ef;}
			local ef_activators=[];local eft="";local pickrand=false;if(_tname.find("/id")==0)
			{local myself=GetPlayer(id.tointeger());
				eft=_tname.slice(3,_tname.len());if(eft=="all"||eft=="ct"||eft=="t"||eft=="!me"||eft=="random"||eft=="randomct"||eft=="randomt")
				{if(eft=="random"||eft=="randomct"||eft=="randomt"){pickrand=true;if(eft=="random")eft="all";else if(eft=="randomct")eft="ct";else if(eft=="randomt")eft="t";}
				local h=null;while(null!=(h=Entities.FindInSphere(h,self.GetOrigin(),500000)))
				{if(h!=null&&h.IsValid()&&h.GetClassname()=="player"&&h.GetHealth()>0){
					if(eft=="all"){ef_activators.push(h);}else if(eft=="ct"&&h.GetTeam()==3){ef_activators.push(h);}
					else if(eft=="t"&&h.GetTeam()==2){ef_activators.push(h);}else if(eft=="!me"&&h!=myself){ef_activators.push(h);}				
				}}}else if(eft=="me"){eftarget = myself;}else{eftarget=GetPlayer(eft.tointeger());}
				_tname=_oput;_oput=_pmeter;_pmeter=_pmeter2;_pmeter=_pmeter.slice(0,_pmeter.len()-1);}else _pmeter=_pmeter+" "+_pmeter2;if(_pmeter==" ")_pmeter="";
			if(pickrand&&ef_activators.len()>0){eftarget=ef_activators[RandomInt(0,ef_activators.len()-1)];ef_activators.clear();}
			if(_tname!=""&&_oput!=""&&_tname!=null&&_oput!=null){if(ef_activators.len()>0){foreach(ac in ef_activators)
			{EntFire(_tname,_oput,_pmeter,0.00,ac);printl("ent_fire|/id"+eft+"|" + _tname + "|" + _oput + "|" + _pmeter + "|"+ac+"|");}}else
			{EntFire(_tname,_oput,_pmeter,0.00,eftarget);printl("ent_fire|/id"+eft+"|" + _tname + "|" + _oput + "|" + _pmeter + "|"+eftarget+"|");}}
		}
	}
}
//===================================\\