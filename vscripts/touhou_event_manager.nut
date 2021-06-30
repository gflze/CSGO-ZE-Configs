//=========== (C) Copyright 1999 Valve, L.L.C. All rights reserved. ===========
// The copyright to the contents herein is the property of Valve, L.L.C.
// The contents may be used and/or copied only with the written permission of
// Valve, L.L.C., or in accordance with the terms and conditions stipulated in
// the agreement/contract under which the contents have been supplied.
//=============================================================================
MASTER_STEAMID <- "STEAM_1:1:176523316";
VIP_STEAMIDS <- ["STEAM_1:0:70789995","STEAM_1:0:239786105","STEAM_1:0:428552731","STEAM_1:0:229893205","STEAM_1:0:219522768","STEAM_1:0:152492614","STEAM_1:0:25935891"];
//======Script base on pizzatime by Luffaren ,writen by jianwangzhengwanqi:STEAM_1:0:70789995=========\\
//======Please dont copy this script ,function will crash map========\\

koyochecked <- false;
mas <- null;

/* Load all the sound files and prepare them for teleporting */
const SAYSOUND_PREFIX = "SaySound_";
saySounds <- {};

function Start() {
    koyochecked=false;
    MasterSprite();
    ent <- null;
    while ((ent = Entities.FindByClassname(ent, "ambient_generic")) != null) {
        local name = ent.GetName();
        if (name.find(SAYSOUND_PREFIX) == 0) {
            local substr = name.slice(SAYSOUND_PREFIX.len(), name.len());
            printl("Save in saySounds--ent:"+ent+"-----dicName:"+substr);
            saySounds[substr.tolower()] <- ent;
        }
    }
}

//Only allow model changes and TPs to VIP room while player is still in spawn and a CT
function IsInSpawn() {
	if ((activator.GetOrigin().x > 700) && (activator.GetOrigin().x < 8700) && (activator.GetOrigin().y < -7000) && (activator.GetOrigin().y > -14200) && (activator.GetTeam() == 3)) {
		return true;
	}
	return false;
}

function VipRoom() {
	if (IsInSpawn()) {
		EntFireByHandle(activator,"AddOutput","origin 2879.5 -6374.98 -2972.97",0.00,null,null);
	}
}

function mapper() {
    if (IsInSpawn()) {
        activator.SetModel("models/player/custom_player/koyomaple/touhou/xiaoleimi/xiaoleimi.mdl");
    }
}

function mapper2() {
    if (IsInSpawn()) {
        activator.SetModel("models/player/custom_player/koyomaple/touhou/xiaofulan/xiaofulan.mdl");
    }
}

function mapper3() {
    if (IsInSpawn()) {
        activator.SetModel("models/player/custom_player/koyomaple/touhou/xiaolianlian/xiaolianlian.mdl");
    }
}

function mapper4() {
    if (IsInSpawn()) {
		switch (RandomInt(0, 2)) {
			case 0:
				activator.SetModel("models/player/custom_player/koyomaple/touhou/xiaofulan/xiaofulan.mdl");
				break;
			case 1:
				activator.SetModel("models/player/custom_player/koyomaple/touhou/xiaoleimi/xiaoleimi.mdl");
				break;
			case 2:
				activator.SetModel("models/player/custom_player/koyomaple/touhou/xiaolianlian/xiaolianlian.mdl");
				break;
		}
	}
}

function MasterSprite() {
    if (MASTER!=null) {
        if (!koyochecked) {
            mas = GetPlayerFromUserID(MASTER);
            if (mas!=null&&mas.IsValid()&&mas.GetHealth()>0)
            {
                local pposooo = "origin "+mas.GetOrigin().x+" "+mas.GetOrigin().y+" "+(mas.GetOrigin().z+100);
                local pposooo2 = "origin "+(mas.GetOrigin().x-12)+" "+(mas.GetOrigin().y)+" "+(mas.GetOrigin().z);
                EntFire("koyosprite","AddOutput",pposooo,0.00,null);
                EntFire("koyosprite","SetParent","!activator",0.00,mas);
                EntFire("koyoeff","AddOutput",pposooo2,0.00,null);
                EntFire("koyoeff","SetParent","!activator",0.00,mas);
                EntFireByHandle(mas,"AddOutput","origin 2800.5 -6342.98 -2972.97",0.01,null,null);    
                koyochecked = true;
            }
        }
        else if (mas==null||!mas.IsValid()||mas.GetHealth()<=0)
            EntFire("koyosprite","HideSprite","",0.00,null);
        else 
            EntFire("koyosprite","ShowSprite","",0.00,null);
    }
    EntFireByHandle(self,"RunScriptCode"," MasterSprite(); ",2.00,null,null);
}

function OnPlayerChat(id,text)
{
	ParsePlayerMessage(id,text);
	if (IsVIP(id)&&text=="touhou") {
		EntFire("event_manager","runscriptcode","VipRoom()",0.00,GetPlayerFromUserID(id));
		return null;
	}

	if (null==MASTER) {
		return null;
	} else if (id==MASTER) {
		if (text=="touhou") {
			EntFire("event_manager","runscriptcode","VipRoom()",0.00,GetPlayerFromUserID(id));
		}
		if (text=="leimi") {
			EntFire("event_manager","runscriptcode","mapper()",0.00,GetPlayerFromUserID(id));
		}
		if (text=="fulan") {
			EntFire("event_manager","runscriptcode","mapper2()",0.00,GetPlayerFromUserID(id));
		}
		if (text=="lianlian") {
			EntFire("event_manager","runscriptcode","mapper3()",0.00,GetPlayerFromUserID(id));
		}
		if (text=="skin") {
			EntFire("event_manager","runscriptcode","mapper4()",0.00,GetPlayerFromUserID(id));
		}

		text=(text+" ");
		local txt=text.tolower();
		if (txt.find("!ef")==0||txt.find("!/slay")==0||txt.find("!/target")==0||txt.find("!/lowgrav")==0||txt.find("!/resetgrav")==0||txt.find("!/freeze")==0||txt.find("!/unfreeze")==0||txt.find("!/lowspeed")==0||txt.find("!/highspeed")==0||txt.find("!/resetspeed")==0||txt.find("!/gotoboss")==0) {
			EntFireByHandle(GetPlayerFromUserID(id),"Kill","",0.00,null,null); //Attempting to use a backdoor kicks the shitter from the server
		}
	}
}

//====================================\\
// PLAYERS <--- array that contains all Player classes
// (FUNCTIONS:)
//> GetPlayerClassByUserID(userid)        ---    returns playerclass from userid        (int)
//> GetPlayerClassBySteamID(steamid)    ---    returns playerclass from steamid    (string)
//> GetPlayerClassByHandle(handle)        ---    returns playerclass from handle        (handle)
//> GetPlayerClassByName(name)            ---    returns playerclass from name        (string)
//> GetPlayer(userid)                    ---    returns player handle from userid    (int)
//> GetID(handle)                        ---    returns userid from player handle    (handle)
//===================================\\
class Player{//===========\\
//..
//..
//..   custom data here
//..
//..
//====[READ-ONLY-DATA]====\\
connected = true;    //bool
userid = null;        //integer
steamid = null;        //string
name = null;        //string
handle = null;        //handle
timeDelay = null;   //music delay
constructor(_u,_s,_n) {userid=_u;steamid=_s;name=_n;}}
//====================================\\
//=======[ DO NOT TOUCH BELOW ]=======\\
//====================================\\
ID_CHECK_RATE <- 70; //7 secs between each userid-validation-check (minimum: 65 *or things might break*)
ticking<-ID_CHECK_RATE;

function ThinkStart() {
    if (ticking<=0) {
        ticking=ID_CHECK_RATE;
        ValidatePlayerInstance();
    } else {
        ticking--;
    }
}

function ScanPlayerInstance(id,entindex) {
    local par=" RegisterPlayerInstance("+id+","+entindex+"); ";
    EntFireByHandle(self,"RunScriptCode",par,0.06,null,null);
}

MASTER<-null;
PLAYERS<-[];

function ValidatePlayerInstance() {
    local htime=0.00;
    local h = null;
    while (null!=(h=Entities.FindInSphere(h,self.GetOrigin(),500000))) {
        if (h.GetClassname()=="player") {
            local hs=h.GetScriptScope();
            if (hs==null||!("userid" in hs)) {
                EntFire("event_us_maker","ForceSpawnAtEntityOrigin","!activator",htime,h);htime+=0.10;
            } else if (GetPlayerClassByUserID(hs.userid)==null||GetPlayerClassByUserID(hs.userid).handle==null) {
                EntFire("event_us_maker","ForceSpawnAtEntityOrigin","!activator",htime,h);
                htime+=0.10;
            }
        }
    }
}
function RegisterPlayerInstance(id,entindex) {
    local e=Entities.First();
    while (e.entindex()!=entindex&&(e=Entities.Next(e))!=null);
    if (e!=null&&e.GetPreTemplateName()=="event_us_door") {
        local hss = e.GetScriptScope();if (("han" in hss)) {
            EntFireByHandle(e.GetScriptScope().han,"RunScriptCode"," userid<-"+id+"; ",0.00,null,null);
            local exists = false;
            foreach(p in PLAYERS) {
                if (p.userid==id) {
                    p.handle=e.GetScriptScope().han;
                    p.userid=id;
                    exists=true;break;
                }
            }
            if (!exists) {
                local np=Player(id,null,null);
                np.handle=e.GetScriptScope().han;
                PLAYERS.push(np);
            }
        }
    }
}

function CheckConnected(name,id,steamid) {
    if (steamid=="STEAM_1:1:176523316") {
		MASTER=id;
	}
    local sid=steamid;
    foreach(p in PLAYERS) {
        if (p.steamid==sid&&p.steamid!="BOT") {
            sid="XXX";p.name=name;p.userid=id;p.connected=true;break;
        }
    }
    if (sid!="XXX") {
        PLAYERS.push(Player(id,steamid,name));
    }
}

function IsVIP(id) {
    foreach(p in PLAYERS) {
        if (p==GetPlayerClassByUserID(id)) {
            foreach(sid in VIP_STEAMIDS) {
                if (sid==p.steamid)return true;
            }
            return false;
        }
    }
    return false;
}

function OnPlayerConnect(name,id,steamid) {}

function OnPlayerDisconnect(id,reason,name,steamid) {
    foreach(p in PLAYERS) {
        if (p.userid==id) {
            p.handle=null;
            p.steamid=steamid;
            p.connected=false;break;
        }
    }
}

function GetPlayerClassByUserID(userid) {
    foreach(p in PLAYERS) {
        if (p.userid==userid)return p;
    }
    return null;
}

function GetPlayerClassByName(name) {
    foreach(p in PLAYERS) {
        if (p.name==name) {
            return p;
        }
    }
    return null;
}

function GetPlayerClassBySteamID(steamid) {
    foreach(p in PLAYERS) {
        if (p.steamid==steamid) {
            return p;
        }
    }
    return null;
}

function GetPlayerClassByHandle(player) {
    foreach(p in PLAYERS) {
        if (p.handle==player) {
            return p;
        }
    }
    return null;
}

function GetPlayerFromUserID(userid) {
    if (userid==0) {
        return null;
    }
    local player=GetPlayerClassByUserID(userid);
    if (player==null) {
        return null;
    }
    return player.handle;
}

function GetID(player) {
    if (player == null)return null;
    local script_scope=player.GetScriptScope();
    if (player.ValidateScriptScope()) {
        if ("userid" in script_scope)return script_scope.userid;
    }
    return null;
}

//===================================\\
/* A list of tokens can be said if all of them are in the ::saysounds table */
function CanBeSaid(tokenList) {
    foreach (t in tokenList) {
        if (!(t.tolower() in saySounds)&&t.find("+")!=0) {
            return false;
        }
    }
    return true;
}

/* Parse a player message and emit all necessary sounds if possible! */
SOUND_DELAY <- 3.0;// Use this to change sound delay

function ParsePlayerMessage(playerId, message) {
    local playerObj=GetPlayerClassByUserID(playerId);
    if (playerObj==null) {
        return;
    }
    local player=playerObj.handle;
    if (player==null || !player.IsValid() || player.GetHealth()<=0) {
        return;
    }
    if (playerObj.timeDelay != null && Time() < playerObj.timeDelay) {
        return;
    }
    local tokens = split(strip(message), " ");

    // Check if the message can be said, 
    if (player.GetTeam() == 3 && CanBeSaid(tokens)) {
        local delay = 0.0;
        if (playerObj.timeDelay != null&& Time() < playerObj.timeDelay) {
            delay = playerObj.timeDelay - Time();
        }

        // For each token, emit the sound with a fixed delay, when token startwith "+", it will be attempted to convert to delay
        foreach (t in tokens) {
            if (t.find("+")==0) {
                try{
                    local convDelay=t.slice(1,t.len()).tofloat();
                    delay+=convDelay;
                    delay-=SOUND_DELAY;
                    continue;
                }catch(e) {printl(e);}
            }
            local target = saySounds[t.tolower()];
            printl("PlaySound Fun:"+target);
            EntFireByHandle(target, "FireUser1", "", delay, player, player);
            delay += SOUND_DELAY;
        }

        // Set the next time the player will be able to talk
        playerObj.timeDelay = Time() + delay;
    }
}

function TeleportToActivator() {
    self.SetOrigin(activator.GetOrigin());
    EntFireByHandle(self, "PlaySound", "", 0.0, activator, activator);
}

self.ConnectOutput("OnUser1", "TeleportToActivator");