//
//		OFFICIAL ZE_SANTASSINATION_V3 STRIPPER SOLUTION
//		UPDATED: 2020-08-20 (#9)
//		CONTACT: https://steamcommunity.com/id/LuffarenPer/
//
//============================================================================\\
//	[PROBLEM]
// only a certain amount of item-hits are actually registered to the bosses
//
//	[SOLUTION]
// this script-solution will ensure that hits are always registered
// this script will also prevent triggering a double-hit as well
//
//	[NOTE]
// since the bosses will take full damage from items now, the values have been lowered
// this is to prevent the bosses from dying way too fast
// it should still serve as a vast improvement
// and when it *does* hit by the OG-trigger, it will deal full damage
// so instead of hits of 	[0, 0, 0, 375, 0, 375, 0, 0]
// it would deal like this: [150, 150, 150, 375, 150, 375, 150, 150]
// you could basically see the "true" hits as some form of "crit" damage i guess
//
// ---------------------->
// EDIT #2(2019-06-22)
//		now the values are tweaked to match the original trigger damage
//		the bosses will now also react to direct rocket hits and not just explosion-damage
//		the bosses will give you a small time-window before it starts moving (allowing for more nades to land)
//		a point_worldtext in ACT3-spawn has been added (to ensure/show people that the stripper is active)
// ---------------------->
// EDIT #6(2019-10-18)
// NERFED ITEM DAMAGE IN GENERAL THROUGH STRIPPER:
// > nerfed minicannon damage 	(from 125 to 50)
// > nerfed beam-cannon damage 	(from 375 to 250)
// > nerfed rocket damage 		(from 1000 to 500)	*direct rocket hit*
// > nerfed explosion damage 	(from 500 to 300)	*general explosions, including when rocket hits*
// ---------------------->
//----------------------------------------------------------------------------\\
//DO NOT ALTER THESE VALUES, if something seems off, contact me (Luffaren):
//>>>>>		https://steamcommunity.com/id/LuffarenPer/
//----------------------------------------------------------------------------\\
DAMAGE_MINIGUN <- 50;		//the actual trigger would damage 50	(minigun > ticks really fast, 	0.07s cooldown)
DAMAGE_BEAM <- 250;			//the actual trigger would damage 250	(laser > ticks at each fire, 	1.00s cooldown)
DAMAGE_EXPLOSION <- 300;	//the actual trigger would damage 300	(explosion > from rocket,		7.50s cooldown)
DAMAGE_ROCKET <- 500;		//the actual trigger would damage 500	(rocket direct hit,				7.50s cooldown)
//============================================================================\\
ticking <- false;
lastrocket <- null;
worldtext <- false;
bossfight <- false;
bosstarget <- null;
bossindex <- 0;
bossplayertargethandle <- null;
socratesthruster <- null;
socratesphys <- null;
socratesthruster_cd <- 0;
function SetBossTarget(index)
{
	bossfight = true;
	bossindex = index;
	if(index==1)
		bosstarget = Entities.FindByName(null,"bosss_hp");
	else if(index==2)
		bosstarget = Entities.FindByName(null,"bosss_hp1");
	else if(index==3)
		bosstarget = Entities.FindByName(null,"bosss_hp2");
	ticking = true;
	lastrocket = null;
	TickRocketCheck();
}
function ClearBossTarget()
{
	socratesthruster = null;
	socratesphys = null;
	bossfight = false;
	bosstarget = null;
	bossindex = 0;
	ticking = false;
	lastrocket = null;
	if(!worldtext)
	{
		worldtext = true;
		local e = Entities.CreateByClassname("point_worldtext");
		EntFireByHandle(e,"AddOutput","message LUFFAREN OFFICIAL STRIPPER #9 (2020-08-20)",0.00,null,null);
		EntFireByHandle(e,"AddOutput","textsize 8",0.00,null,null);
		EntFireByHandle(e,"AddOutput","origin -4605 -7015 -5100",0.00,null,null);
		EntFireByHandle(e,"AddOutput","angles 0 180 0",0.00,null,null);
		speederallowed = false;
		//local sst = "say |S#6|m"+DAMAGE_MINIGUN.tostring()+"|b"+DAMAGE_BEAM.tostring()+"|e"+DAMAGE_EXPLOSION.tostring()+"|r"+DAMAGE_ROCKET.tostring()+"|";
		//EntFire("server","Command",sst,0.00,null);	(removed in #6, a bit confusing for people)
		EntFire("npctarget","AddOutput","targetname notarget",1.00,null);	//ADDED IN EDIT #8
	}
	ClearBossPlayerTarget();
}
//cooldown is 7s by default
//notarget		>	doesn't attract boss + npc's
//npctarget		>	attracts boss + npc's			
bossplayertarget <- null;
function ClearBossPlayerTarget()
{
	if(bossplayertarget!=null&&bossplayertarget.IsValid())
		EntFireByHandle(bossplayertarget,"AddOutput","targetname notarget",0.00,null,null);
	bossplayertarget = null;
	EntFire("npctarget","AddOutput","targetname notarget",0.00,null);
	bossplayertargethandle = null;
}
function NewBossPlayerTarget()
{
	ClearBossPlayerTarget();
	local hlist = [];
	local h = null;
	while(null!=(h=Entities.FindByClassname(h,"player")))
	{
		if(h.GetTeam()==3 && h.GetHealth() > 0)
			hlist.push(h);
		else
			EntFireByHandle(h,"AddOutput","targetname notarget",0.00,null,null);
	}
	if(hlist.len()==1)
		bossplayertarget = hlist[0];
	else if(hlist.len()>0)
	{
		bossplayertarget = hlist[RandomInt(0,hlist.len()-1)];
		if(bossindex == 3)
		{
			if(socratesphys==null||!socratesphys.IsValid())
			{
				socratesphys = Entities.FindByName(null,"bosss_phys2");
				if(socratesphys!=null&&socratesphys.IsValid())
				{
					local ss_start = socratesphys.GetOrigin();
					local ss_end = bossplayertarget.GetOrigin();
					ss_start.z = 0;
					ss_end.z = 0;
					for(local i=0;i<10;i++)
					{
						if(GetDistance(ss_start,ss_end) > 4000)
						{
							bossplayertarget = hlist[RandomInt(0,hlist.len()-1)];
							continue;
						}
						break;
					}
				}
			}
		}
	}
	if(bossplayertarget!=null&&bossplayertarget.IsValid())
	{
		EntFireByHandle(bossplayertarget,"AddOutput","targetname npctarget",0.01,null,null);
		EntFireByHandle(bossplayertarget,"AddOutput","targetname notarget",6.99,null,null);
		bossplayertargethandle = bossplayertarget;
	}
}
function TickBossPlayerTarget()
{
	if(bossplayertarget == null || !bossplayertarget.IsValid())
		NewBossPlayerTarget();
	else if(bossplayertarget.GetTeam() !=3 || bossplayertarget.GetHealth() <= 0)
		NewBossPlayerTarget();
	else
	{
		EntFireByHandle(bossplayertarget,"AddOutput","targetname npctarget",0.00,null,null);
		if(bossindex == 3)
		{
			//1) check distance between player target and boss
			//2) if above 4000, set direction of "stripper_fboss_thrust" and Activate it
			//   else Deactivate "stripper_fboss_thrust"
			if(socratesthruster==null||!socratesthruster.IsValid())
			{
				socratesthruster = Entities.FindByName(null,"stripper_fboss_thrust");
				if(socratesthruster==null||!socratesthruster.IsValid())
					return;
			}
			if(socratesphys==null||!socratesphys.IsValid())
			{
				socratesphys = Entities.FindByName(null,"bosss_phys2");
				if(socratesphys==null||!socratesphys.IsValid())
					return;
			}
			if(bossplayertargethandle!=null&&bossplayertargethandle.IsValid()&&
			bossplayertargethandle.GetHealth()>0&&bossplayertargethandle.GetTeam()==3)
			{
				local ss_start = socratesphys.GetOrigin();
				local ss_end = bossplayertargethandle.GetOrigin();
				ss_start.z = 0;
				ss_end.z = 0;
				if(GetDistance(ss_start,ss_end) > 4000)
				{
					socratesthruster_cd--;
					if(socratesthruster_cd < 0)
					{
						socratesthruster_cd = 3;
						local ss_dir = (ss_end - ss_start);
						ss_dir.Norm();
						socratesthruster.SetForwardVector(ss_dir);
						EntFireByHandle(socratesthruster,"Deactivate","",0.00,null,null);
					}
					EntFireByHandle(socratesthruster,"Activate","",0.00,null,null);
				}
				else
					EntFireByHandle(socratesthruster,"Deactivate","",0.00,null,null);
			}
			else
				EntFireByHandle(socratesthruster,"Deactivate","",0.00,null,null);
		}
	}
}
extremeModeAct3HealsAllowed <- false;
function ExtremeModeAct3HealsPre(){extremeModeAct3HealsAllowed = true;}
function ExtremeModeAct3Heals()
{
	if(!extremeModeAct3HealsAllowed)return;	//not extreme mode, abort!
	//else spawn extra healthkits
	
	EntFire("s_item_healthkit","AddOutput","origin -360 -8080 -3576",0.00,null);	//behind container after first door on tram-path
	EntFire("s_item_healthkit","ForceSpawn","",0.05,null);
	
	EntFire("s_item_healthkit","AddOutput","origin -176 -7816 1064",0.10,null);		///first outside, hidden in the back after first staircase up
	EntFire("s_item_healthkit","ForceSpawn","",0.15,null);
	
	EntFire("s_item_healthkit","AddOutput","origin -1376 -6688 -3960",0.20,null);	//start of mid-path, reachable by strafe-jumping down from tram-path
	EntFire("s_item_healthkit","ForceSpawn","",0.25,null);
}

function TickRocketCheck()
{
	if(!ticking)
	{
		EntFire("npctarget","AddOutput","targetname notarget",0.00,null);
		bossplayertarget = null;
		return;
	}
	EntFireByHandle(self,"RunScriptCode"," TickRocketCheck(); ",0.01,null,null);
	TickBossPlayerTarget();
	if(bosstarget==null||!bosstarget.IsValid())return;
	local range = 330;
	if(bossindex==1)range = 120;
	else if(bossindex==2)range = 150;
	else if(bossindex==3)range = 500;
	local r = Entities.FindByNameNearest("projectile_particle_1*",bosstarget.GetOrigin(),range);
	if(r==null||!r.IsValid()||r==lastrocket)return;
	lastrocket = r;
	EntFireByHandle(bosstarget,"RemoveHealth",DAMAGE_ROCKET.tostring(),0.00,null,null);
	EntFireByHandle(r,"FireUser1","",0.00,r,r);
	printl("ROCKET DIRECT HIT");
}

minigun_hit <- null;
function Used_Minigun()
{
	if(!bossfight)return;
	if(minigun_hit==null||!minigun_hit.IsValid())
	{
		print("MINIGUN - MISS (actual trigger), calculating manually..........");
		if(bosstarget!=null&&bosstarget.IsValid())
		{
			local bosshit = null;
			if(bossindex==1)bosshit = IsItemHitting(caller,6,100);
			else if(bossindex==2)bosshit = IsItemHitting(caller,10,90);
			else if(bossindex==3)bosshit = IsItemHitting(caller,15,300);
			if(bosshit)
			{
				EntFireByHandle(bosstarget,"RemoveHealth",DAMAGE_MINIGUN.tostring(),0.00,null,null);
				printl("HIT");
			}
			else printl("MISS");
		}
		else printl("MISS");
	}
	else printl("MINIGUN - HIT (actual trigger)");
	minigun_hit = null;
}
function Hit_Minigun()
{
	if(!bossfight)return;
	if(activator==null||!activator.IsValid())return;
	if(activator.GetClassname()=="func_physbox_multiplayer")
	{if(activator.GetName()=="bosss_hp"||activator.GetName()=="bosss_hp1"||activator.GetName()=="bosss_hp2")
		minigun_hit = activator;}
}

beam_hit <- null;
function Used_Beam()
{
	if(!bossfight)return;
	if(beam_hit==null||!beam_hit.IsValid())
	{
		print("BEAM - MISS (actual trigger), calculating manually..........");
		if(bosstarget!=null&&bosstarget.IsValid())
		{
			local bosshit = null;
			if(bossindex==1)bosshit = IsItemHitting(caller,6,100);
			else if(bossindex==2)bosshit = IsItemHitting(caller,10,90);
			else if(bossindex==3)bosshit = IsItemHitting(caller,15,300);
			if(bosshit)
			{
				EntFireByHandle(bosstarget,"RemoveHealth",DAMAGE_BEAM.tostring(),0.00,null,null);
				printl("HIT");
			}
			else printl("MISS");
		}
		else printl("MISS");
	}
	else printl("BEAM - HIT (actual trigger)");
	beam_hit = null;
}
function Hit_Beam()
{
	if(!bossfight)return;
	if(activator==null||!activator.IsValid())return;
	if(activator.GetClassname()=="func_physbox_multiplayer")
	{if(activator.GetName()=="bosss_hp"||activator.GetName()=="bosss_hp1"||activator.GetName()=="bosss_hp2")
		beam_hit = activator;}
}

explosion_hit <- null;
function Used_Explosion()
{
	if(!bossfight)return;
	if(explosion_hit==null||!explosion_hit.IsValid())
	{
		print("EXPLOSION - MISS (actual trigger), calculating manually..........");
		if(bosstarget!=null&&bosstarget.IsValid())
		{
			local bosshit = false;
			if(bossindex==1 && GetDistance(caller.GetOrigin(),bosstarget.GetOrigin()) <= (300+100))bosshit = true;
			else if(bossindex==2 && GetDistance(caller.GetOrigin(),bosstarget.GetOrigin()) <= (300+100))bosshit = true;
			else if(bossindex==3 && GetDistance(caller.GetOrigin(),bosstarget.GetOrigin()) <= (300+400))bosshit = true;
			if(bosshit)
			{
				EntFireByHandle(bosstarget,"RemoveHealth",DAMAGE_EXPLOSION.tostring(),0.00,null,null);
				printl("HIT");
			}
			else printl("MISS");
		}
		else printl("MISS");
	}
	else printl("EXPLOSION - HIT (actual trigger)");
	explosion_hit = null;
}
function Hit_Explosion()
{
	if(!bossfight)return;
	if(activator==null||!activator.IsValid())return;
	if(activator.GetClassname()=="func_physbox_multiplayer")
	{if(activator.GetName()=="bosss_hp"||activator.GetName()=="bosss_hp1"||activator.GetName()=="bosss_hp2")
		explosion_hit = activator;}
}

function GetDistance(v1,v2){return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));}
function GetTargetYaw(start,target)
{
	local yaw = 0.00;
	local v = Vector(start.x-target.x,start.y-target.y,start.z-target.z);
	local vl = sqrt(v.x*v.x+v.y*v.y);
	yaw = 180*acos(v.x/vl)/3.14159;
	yaw-=180;if(v.y<0)yaw=-yaw;return yaw;
}
function IsItemHitting(itemhandle,angularlimit,zheight)
{
	if(itemhandle==null||!itemhandle.IsValid||bosstarget==null||!bosstarget.IsValid())return false;
	if(abs(itemhandle.GetOrigin().z-bosstarget.GetOrigin().z)>zheight)return false;
	local angdif = GetTargetYaw(itemhandle.GetOrigin(),bosstarget.GetOrigin()) - itemhandle.GetAngles().y;
	if(angdif>=0.00&&angdif<angularlimit||angdif<0.00&&angdif>(-angularlimit))return true;
	if(angdif<= -360&&angdif>(-360 + (-angularlimit))||angdif> -360&&angdif< (-360 + (angularlimit)))return true;
	return false;
}

speederallowed <- false;
function SetItemFilter(speeder=false)
{
	caller.ValidateScriptScope();
	local sc = caller.GetScriptScope();
	if("itemowner" in sc)
		sc.itemowner = activator;
	else
		sc.itemowner <- activator;
	if(speeder)
	{
		if("speeder" in sc)
			sc.speeder = true;
		else
			sc.speeder <- true;
	}
	//printl("ITEM-SET: " + caller + "    |     "+activator);
}
function CheckItemFilter()
{
	caller.ValidateScriptScope();
	local sc = caller.GetScriptScope();
	if("itemowner" in sc)
	{
		if("speeder" in sc && !speederallowed)
			return;
		if(activator==sc.itemowner)
			EntFireByHandle(caller,"FireUser1","",0.00,activator,activator);
	}
	//printl("ITEM-CHECK: " + caller + "    |     "+activator);
}

function TruthStartZcageExploitFix()
{
	local h = null;
	while(null!=(h=Entities.FindByClassname(h,"player")))
	{
		if(h.GetTeam()==2 && h.GetHealth() > 0)
		{
			if(h.GetOrigin().z > -11200)
			{
				EntFireByHandle(h,"AddOutput","origin 2170 -13305 -11275",0.00,null,null);
				h.SetVelocity(Vector(0,0,0));
			}
		}
	}
}

function CleanHealAfterUse()
{
	if(caller==null||!caller.IsValid())
		return;
	local par = caller.GetMoveParent();
	if(par==null||!par.IsValid())
		return;
	EntFireByHandle(par,"Kill","",0.00,null,null);
}


