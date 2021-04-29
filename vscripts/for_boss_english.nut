
MOVINGRATE		<- 	0.10;
TARGET_DISTANCE <- 	5000;
RETARGET_TIME 	<- 	8.00;
SPEED_FORWARD 	<- 	1.00;
SPEED_TURNING 	<- 	1.00;
MAX_SPEED		<- 	40;
MAX_STOP_TIME	<- 	2.00;
ZHONGXIN <- Vector(10148,-6832,3704);// PUSH 2040 3072 116            之前的 Vector(2048,3072,40) 之后的         10148 -6832 3780  10148 -6832 3704


p <- null;
tf <- null;
ts <- null;
yundong <- null;
lastpos <- self.GetOrigin();
ttime <- 0.00;
tianfa_qiang_maker <- null;
tianfa_longche_maker <- null;
paodu_anquan_maker <- null;
time_anquan <- 0 ;
boss_alive <- null;
target_human <- null;
timer_for_jineng <- 0.0;
lfkb_boss_zhongxin <- null;
boss_hp <- 800;
boss_hp_max_half <- 1;
boss_hp_sub_Enable <- false;
boss_meibaofaguo <- true;
timer_for_longche <- 0.0;
fuzi_origin <- null;
fuzi_originl <- null;
fuzi_sound_enable <-true;


function turning()
{
	local sa = self.GetAngles().y;
	local ta = GetTargetYaw(self.GetOrigin(),p.GetOrigin());
	local ang = ((ta-sa+360)%360);
	while(ang > 180)
		ang = ang - 360;
	while(ang < -180)
		ang = ang + 360;
	//printl(((3*SPEED_TURNING)*ang).tostring());
	EntFireByHandle(ts,"Deactivate","",0.00,null,null);
	EntFireByHandle(tf,"Deactivate","",0.00,null,null);
	if(target_human)
	{
		if(p == null || p.GetHealth() <= 0.00 || p.GetTeam() != 3 || ttime >= RETARGET_TIME)
		{
			return SearchTarget();
		}
	}
	ttime+=MOVINGRATE;
	//printl((ttime).tostring());
	EntFireByHandle(tf,"AddOutput","angles 0 "+(ang).tostring()+" 0",0.01,null,null);
	if(ang > 0)
		EntFireByHandle(ts,"AddOutput","angles 0 270 0",0.01,null,null);
	else 
		EntFireByHandle(ts,"AddOutput","angles 0 90 0",0.01,null,null);
	ang = abs(ang);
	if(ang > 40 && ang < 90)
		ang = ang * 2;
	EntFireByHandle(ts,"AddOutput","force "+((3*SPEED_TURNING)*ang).tostring(),0.01,null,null);
	EntFireByHandle(ts,"Activate","",0.02,null,null);
	if((self.GetOrigin().x-p.GetOrigin().x)*(self.GetOrigin().x-p.GetOrigin().x)+(self.GetOrigin().y-p.GetOrigin().y)*(self.GetOrigin().y-p.GetOrigin().y) < 5000)
	{
		EntFireByHandle(tf,"AddOutput","force 0",0.01,null,null);
	}
	else
	{
		EntFireByHandle(tf,"AddOutput","force 1400",0.01,null,null);
	}
	if(GetDistance(self.GetOrigin(),lastpos) > MAX_SPEED || ang > 90)
	{
		EntFireByHandle(tf,"Deactivate","",0.00,null,null);
	}
	else
	{
		EntFireByHandle(tf,"Activate","",0.02,null,null);
	}
	lastpos = self.GetOrigin();
	
	
	return;
}

function SetThruster1()
{
	tf=caller;
	return;
}
function SetThruster2()
{
    ts=caller;
	return;
}
function Set_tianfa_qiang_maker()
{
    tianfa_qiang_maker=caller;
	return;
}
function Set_tianfa_longche_maker()
{
	tianfa_longche_maker=caller;
	return;
}
function Set_paodu_anquan_maker()
{
	paodu_anquan_maker=caller;
	return;
}
function Set_lfkb_boss_zhongxin()
{
	lfkb_boss_zhongxin=caller;
	return;
}
function Set_fuzi_origin()
{
	fuzi_origin=caller;
	fuzi_originl=fuzi_origin.GetOrigin();
	test_fuzi_speed();
	return;
}



function test_fuzi_speed()
{
	if(boss_alive)
	{
		if(GetDistance(fuzi_origin.GetOrigin(),fuzi_originl)>=200 && fuzi_sound_enable)
		{
			EntFire("lfkb_huiwu_sound","PlaySound","",0,null);
			//printl(GetDistance(fuzi_origin.GetOrigin(),fuzi_originl).tostring());
			fuzi_sound_enable = false;
			EntFireByHandle(self,"RunScriptCode","fuzi_sound_enable = true;",0.8,null,null);
		}
		fuzi_originl=fuzi_origin.GetOrigin();
		EntFireByHandle(self,"RunScriptCode","test_fuzi_speed();",0.1,null,null);
	}	
	return;
		
}




function start()
{
	yundong = true;
	target_human = true;
	boss_alive = true;
	timer_for_jineng = -6.0;
	timer_for_jineng_add();
	EntFireByHandle(self,"RunScriptCode","jineng();",5,null,null);
	EntFireByHandle(self,"RunScriptCode","moving();",MOVINGRATE,null,null);
	EntFireByHandle(ts,"Activate","",0.02,null,null);
	EntFireByHandle(tf,"AddOutput","force 1400",0.01,null,null);
	
	EntFire("lfkb_boss_hpshow", "SetText", "RaphaKumpa HP: ?????", 0.00, null);
	EntFire("lfkb_boss_hpshow","Display","",0,null);
	p=null;
	while(null != (p = Entities.FindInSphere(p,self.GetOrigin(),TARGET_DISTANCE)))
	{
		if(p.GetClassname()=="player" && p.GetTeam()==3 && p.GetHealth()>0)
		{
			boss_hp = boss_hp + 600;
		}
	}
	p=null;
	SearchTarget();
	boss_hp_max_half = boss_hp/2;
	local i = 1.0;
	local boss_hp_tem=0;

	while(boss_hp_tem<boss_hp)
	{
		
		EntFire("lfkb_boss_hpshow", "SetText", "RaphaKumpa HP: "+(boss_hp_tem).tostring(), 1+i/100.0, null);
		EntFire("lfkb_boss_hpshow","Display","",1+i/100.0,null);
		i=i+1;
		boss_hp_tem=boss_hp_tem+100;
	}
	EntFire("lfkb_boss_hpshow", "SetText", "RaphaKumpa HP: "+(boss_hp_tem).tostring(), 1+(i+1)/100.0, null);
	EntFire("lfkb_boss_hpshow","Display","",1+(i+3)/100.0,null);
	EntFireByHandle(self,"RunScriptCode","boss_hp_sub_Enable=true;",1+(i+3)/100.0,null,null);
	
	return;
}

function diaoxue()
{
	if(boss_hp_sub_Enable)
	{	if(boss_hp>0)
			boss_hp = boss_hp - 1;
		EntFire("lfkb_boss_hpshow", "SetText", "RaphaKump HP: "+(boss_hp).tostring(), 0.01, null);
		EntFire("lfkb_boss_hpshow","Display","",0.02,null);
	}
	return;
}


function timer_for_jineng_add()
{
	if(boss_alive)
	{
		timer_for_jineng = timer_for_jineng + 1
		EntFireByHandle(self,"RunScriptCode","timer_for_jineng_add();",1.0,null,null);
		printl(timer_for_jineng.tostring());
		EntFire("lfkb_boss_hpshow","Display","",0,null);
		if(!boss_meibaofaguo)
		{
			timer_for_longche = timer_for_longche + 1;
			if(timer_for_longche == 5)
			{
				Make_lfkb_longche();
				EntFireByHandle(self,"RunScriptCode","Make_lfkb_longche();",0.5,null,null);
				timer_for_longche = 0;
			}
		}
	}
	return;
}





function moving()
{
	if(boss_alive)
	{
		EntFireByHandle(self,"RunScriptCode","moving();",MOVINGRATE,null,null);
	}	
	if(yundong)
	{
		turning();
	}
	else
	{
		EntFireByHandle(ts,"Deactivate","",0.00,null,null);
		EntFireByHandle(tf,"Deactivate","",0.00,null,null);
	}
	return;
}

function SearchTarget()
{
    ttime = 0.00;
	while(null != (p = Entities.FindInSphere(p,self.GetOrigin(),TARGET_DISTANCE)))
	{
		if(p.GetClassname()=="player" && p.GetTeam()==3 && p.GetHealth()>0)
		{
			local geto = p.GetOrigin();
		    //local origin = "origin "+geto.x+" "+geto.y+" "+(geto.z+96);
			//EntFire("target","AddOutput",origin,0.00,null);
			//EntFire("target","SetParent","!activator",0.00,p);
			return;
		}
	}
	if(null == (p = Entities.FindInSphere(p,self.GetOrigin(),TARGET_DISTANCE)))
	{
		p = null;
	}
	return;
}

function GetTargetYaw(start,target)
{
	local yaw = 0.00;
	local v = Vector(target.x-start.x,target.y-start.y,target.z-start.z);
	local vl = sqrt(v.x*v.x+v.y*v.y);
	yaw = 180*acos(v.x/vl)/3.14159;
	if(v.y<0)
		yaw=-yaw;
	return yaw;
}

function GetDistance(v1,v2)
{
    return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));
}





function Make_lfkb_tianfa_qiang()
{
   
	local r1,r2,r3;
	r1 = rand()%8;
	while((r2 = rand()%8)==r1);
	while((r3 = rand()%8)==r1||(r3 = rand()%8)==r2);
	r1 = r1*70+200;
	r2 = r2*70+200;
	r3 = r3*70+200;
	local j1,j2,j3;
	j1 = PI*(rand()%360)/180;
	j2 = PI*(rand()%360)/180;
	j3 = PI*(rand()%360)/180;
	
	//printl(j3.tostring());	
	local v1 = Vector(ZHONGXIN.x+r1*cos(j1),ZHONGXIN.y+r1*sin(j1),ZHONGXIN.z);
	local v2 = Vector(ZHONGXIN.x+r2*cos(j2),ZHONGXIN.y+r2*sin(j2),ZHONGXIN.z);
	local v3 = Vector(ZHONGXIN.x+r3*cos(j3),ZHONGXIN.y+r3*sin(j3),ZHONGXIN.z);
	EntFireByHandle(tianfa_qiang_maker,"AddOutput","angles 0 "+(j1*180/PI).tostring()+" 0",0.00,null,null);
	EntFireByHandle(tianfa_qiang_maker,"AddOutput","origin "+(v1.x).tostring()+" "+(v1.y).tostring()+" "+(v1.z).tostring(),0.00,null,null);
	EntFireByHandle(tianfa_qiang_maker,"ForceSpawn","",0.02,null,null);
	
	EntFireByHandle(tianfa_qiang_maker,"AddOutput","angles 0 "+(j2*180/PI).tostring()+" 0",1.00,null,null);
	EntFireByHandle(tianfa_qiang_maker,"AddOutput","origin "+(v2.x).tostring()+" "+(v2.y).tostring()+" "+(v2.z).tostring(),1.00,null,null);
	EntFireByHandle(tianfa_qiang_maker,"ForceSpawn","",1.02,null,null);
	
	EntFireByHandle(tianfa_qiang_maker,"AddOutput","angles 0 "+(j3*180/PI).tostring()+" 0",2.00,null,null);
	EntFireByHandle(tianfa_qiang_maker,"AddOutput","origin "+(v3.x).tostring()+" "+(v3.y).tostring()+" "+(v3.z).tostring(),2.00,null,null);
	EntFireByHandle(tianfa_qiang_maker,"ForceSpawn","",2.02,null,null);
	
	EntFire("lfkb_tianfa_sound","PlaySound","",7,null);
	EntFire("lfkb_tianfa_particle_2","Start","",7,null);
	EntFire("lfkb_tianfa_fade","Fade","",7,null);
	EntFire("lfkb_tianfa_disable*","Enable","",7.5,null);
	EntFire("lfkb_tianfa_hurt","Enable","",7.6,null);
	EntFire("lfkb_tianfa_hurt","Disable","",7.7,null);
	
	EntFire("lfkb_tianfa_disable*","kill","",8,null);
	EntFire("lfkb_tianfa_qiang_model*","kill","",8,null);
	EntFire("lfkb_tianfa_move*","kill","",8,null);
	EntFire("lfkb_tianfa_particle_1*","kill","",8,null);
	
	
	EntFire("lfkb_tianfa_sound","Volume",0.tostring,13,null);
	
	
	EntFire("lfkb_tianfa_particle_2","Stop","",10,null);
	return;
	
}


function Make_lfkb_longche()
{
	local j1 = PI*(rand()%360)/180;
	local r1 = 1200;
	local v1 = Vector(ZHONGXIN.x+r1*cos(j1),ZHONGXIN.y+r1*sin(j1),ZHONGXIN.z+40);
	EntFireByHandle(tianfa_longche_maker,"AddOutput","angles 0 "+(j1*180/PI+180).tostring()+" 0",0.00,null,null);
	EntFireByHandle(tianfa_longche_maker,"AddOutput","origin "+(v1.x).tostring()+" "+(v1.y).tostring()+" "+(v1.z).tostring(),0.00,null,null);
	EntFireByHandle(tianfa_longche_maker,"ForceSpawn","",0.02,null,null);
	return;
}

function chilongche()
{
	activator.SetVelocity(Vector(0, 0, 300));
	EntFire("lfkb_punch_sound","PlaySound","",0,null);
	local health = activator.GetHealth();
	if (health>31)
	{
		EntFireByHandle(activator,"IgniteLifetime","6",0.00,null,null);
	}
	else 
	{
		EntFireByHandle(activator,"SetHealth","-69",0.00,null,null);
	}
	return;
}

function Make_lfkb_longche_3()
{
	local i=0
	while(i<=7)
	{
		EntFireByHandle(self,"RunScriptCode","Make_lfkb_longche()",i,null,null);
		i=i+1;
	}
	return;
}

function paodu()
{
	local i = 0;
	while(i<24)
	{
		EntFire("lfkb_paodu_hurt","Enable","",4+i,null);
		EntFire("lfkb_paodu_hurt","Disable","",4.1+i,null);
		i=i+1;
	}
	EntFire("lfkb_paodu_particle_1","start","",4.00,null);
	EntFireByHandle(self,"RunScriptCode","anquan_time_sub();",0.95,null,null);
	EntFire("lfkb_paodu_sound","PlaySound","",3.5,null);
	EntFireByHandle(self,"RunScriptCode","make_anquan();",0,null,null);
	EntFireByHandle(self,"RunScriptCode","make_anquan();",7,null,null);
	EntFireByHandle(self,"RunScriptCode","make_anquan();",14,null,null);
	EntFireByHandle(self,"RunScriptCode","make_anquan();",21,null,null);
	EntFire("lfkb_paodu_particle_1","stop","",28,null);
	EntFire("lfkb_paodu_sound","Volume",0.tostring,32,null);

	return;
}

function make_anquan()
{
	local j1 = PI*(rand()%360)/180;
	Set_anquan_time();
	local r1 = 500;
	local v1 = Vector(ZHONGXIN.x+r1*cos(j1),ZHONGXIN.y+r1*sin(j1),ZHONGXIN.z+40);
	EntFireByHandle(paodu_anquan_maker,"AddOutput","origin "+(v1.x).tostring()+" "+(v1.y).tostring()+" "+(v1.z).tostring(),0.00,null,null);
	EntFireByHandle(paodu_anquan_maker,"ForceSpawn","",0.02,null,null);
	return;
}

function Set_paodu_anquan()
{
	local i = time_anquan - 1;
	while(i>=0)
	{
		EntFireByHandle(activator,"SetDamageFilter","noburn",i,null,null);
		i = i - 1;
	}
	EntFireByHandle(activator,"SetDamageFilter","nofall",time_anquan,null,null);
	return;
}

function Set_anquan_time()
{
	time_anquan = 11.0;
	return;
}
function anquan_time_sub()
{
	if(time_anquan > 0)
	{
		time_anquan = time_anquan - 1;
		EntFireByHandle(self,"RunScriptCode","anquan_time_sub();",1.0,null,null);
	}
	return;
}

function fuzi_hurt()
{
	local health = activator.GetHealth();
	if (health>11)
	{
		activator.SetHealth(health-10);
	}
	else 
	{
		EntFireByHandle(activator,"SetHealth","-69",0.00,null,null);
	}
	EntFire("lfkb_slash_sound","PlaySound","",0,null);
	
	return;
}



function lfkb_push()
{
	local v1 = Vector(activator.GetOrigin().x-self.GetOrigin().x,activator.GetOrigin().y-self.GetOrigin().y,0);
	local r1 = sqrt(v1.x*v1.x+v1.y*v1.y);
	local v2 = Vector(400*v1.x/r1,400*v1.y/r1,300);
	activator.SetVelocity(v2);
	return;
}


function jineng()
{

	local shuzi = rand()%4;
	if(boss_hp<=0)
	{
		boss_alive = false;
		EntFire("lfkb_model","SetAnimation","stun",0,null);
		EntFire("lfkb_model","SetDefaultAnimation","stun",0,null);
		local i=0;
		while(i<=1.5)
		{
			EntFireByHandle(ts,"Deactivate","",i,null,null);
			EntFireByHandle(tf,"Deactivate","",i,null,null);
			i=i+0.1;
		}
		printl("qwq");
		EntFire("lfkb_boss_telep", "Disable", "", 0, null);
		EntFire("lfkb_boss_telep_2", "Turnoff", "", 0, null);
		EntFire("lfkb_boss_sound", "Volume", "6", 0, null);
		EntFire("lfkb_boss_sound", "Volume", "3", 0.5, null);
		EntFire("lfkb_boss_sound", "Volume", "0", 1, null);
		return;
	}
	
	if(boss_hp<boss_hp_max_half && boss_meibaofaguo)
	{
		timer_for_jineng = -12;
		boss_meibaofaguo = false;
		ScriptPrintMessageCenterAll("Free your souls!\nLet it disappear like your useless bodies!");
		EntFire("lfkb_boss_jineng_show", "SetText", "Free your souls!\nLet it disappear like your useless bodies!", 3.01, null);
		//EntFire("lfkb_ziyou_sound","PlaySound","",3,null);
		EntFire("lfkb_boss_jineng_show","Display","",3.1,null);
		EntFire("lfkb_model","SetAnimation","attack1",0,null);
		EntFire("lfkb_fuzi_particle","start","",3,null);
		EntFire("lfkb_fuzi_hurt_2","Enable","",3,null);
		EntFireByHandle(self,"RunScriptCode","yundong = false;",3,null,null);
		EntFire("lfkb_model","SetAnimation","attack5",3,null);
		EntFire("lfkb_model","SetAnimation","attack3",6.5,null);
		EntFire("lfkb_banxue_hurt","Enable","",7.7,null);
		EntFire("lfkb_banxue_hurt","Disable","",7.73,null);
		EntFire("lfkb_banxue_particle","Start","",7.7,null);
		EntFire("lfkb_banxue_particle","Stop","",10,null);
		EntFireByHandle(self,"RunScriptCode","yundong = true;",12,null,null);
		EntFireByHandle(self,"RunScriptCode","jineng();",12,null,null);
		return;
	}
	if(timer_for_jineng>12)
	{
			if(shuzi==0)
	{
		timer_for_jineng = -32;
		target_human = false;
		p = lfkb_boss_zhongxin;
		ScriptPrintMessageCenterAll("You criminals~\nshall burn to ashes with your sins!");
		EntFire("lfkb_boss_jineng_show", "SetText", "You criminals~\nshall burn to ashes with your sins!", 3.01, null);
		//EntFire("lfkb_zuie_sound","PlaySound","",3,null);
		EntFire("lfkb_boss_jineng_show","Display","",3.1,null);
		EntFireByHandle(self,"RunScriptCode","paodu();",3,null,null);
		EntFire("lfkb_model","SetDefaultAnimation","attack1",3.02,null);
		EntFire("lfkb_model","SetAnimation","attack1",3,null);
		EntFireByHandle(self,"RunScriptCode","target_human = true;",31,null,null);
		EntFireByHandle(self,"RunScriptCode","SearchTarget();",31.02,null,null);
		EntFire("lfkb_model","SetDefaultAnimation","run",31.02,null);
		EntFire("lfkb_model","SetAnimation","run",31,null);
		EntFireByHandle(self,"RunScriptCode","jineng();",32,null,null);
		return;
	}
	if(shuzi==1)
	{	
		timer_for_jineng = -16;
		target_human = false;
		p = lfkb_boss_zhongxin;
		ScriptPrintMessageCenterAll("Come my conquerors!\nDestroy those filthy bugs!");
		EntFire("lfkb_boss_jineng_show", "SetText", "Come my conquerors!\nDestroy those filthy bugs!", 3.01, null);
		//EntFire("lfkb_zfz_sound","PlaySound","",3,null);
		EntFire("lfkb_boss_jineng_show","Display","",3.1,null);
		EntFireByHandle(self,"RunScriptCode","Make_lfkb_longche_3()",3,null,null);
		EntFire("lfkb_model","SetDefaultAnimation","attack1",3.02,null);
		EntFire("lfkb_model","SetAnimation","attack1",3,null);
		EntFireByHandle(self,"RunScriptCode","target_human = true;",15,null,null);
		EntFireByHandle(self,"RunScriptCode","SearchTarget();",15.02,null,null);
		EntFire("lfkb_model","SetDefaultAnimation","run",15.02,null);
		EntFire("lfkb_model","SetAnimation","run",15,null);
		EntFireByHandle(self,"RunScriptCode","jineng();",16,null,null);
		return;
	}
	if(shuzi==2)
	{	
		timer_for_jineng = -16;
		target_human = false;
		p = lfkb_boss_zhongxin;
		ScriptPrintMessageCenterAll( "This is my true power!\nCome dance around like little bugs!");
		EntFire("lfkb_boss_jineng_show", "SetText", "This is my true power!\nCome dance around like little bugs!", 3.01, null);
		//EntFire("lfkb_liliang_sound","PlaySound","",3,null);
		EntFire("lfkb_boss_jineng_show","Display","",3.1,null);
		EntFire("lfkb_paidiban_relay","Trigger","",3.00,null);
		EntFireByHandle(self,"RunScriptCode","target_human = true;",15,null,null);
		EntFireByHandle(self,"RunScriptCode","SearchTarget();",15.02,null,null);
		EntFireByHandle(self,"RunScriptCode","jineng();",16,null,null);
		return;
	}
	
	if(shuzi==3)
	{
		timer_for_jineng = -14;
		target_human = false;
		p = lfkb_boss_zhongxin;
		ScriptPrintMessageCenterAll( "This is divine punishment for you crminals!\nI shall burn you till nothing is left!");
		EntFire("lfkb_boss_jineng_show", "SetText", "This is diving punishment for you criminals!\nI shall burn you till nothing is left!", 3.01, null);
		//EntFire("lfkb_tianfa2_sound","PlaySound","",3,null);
		EntFire("lfkb_boss_jineng_show","Display","",3.1,null);
		EntFireByHandle(self,"RunScriptCode","Make_lfkb_tianfa_qiang();",3,null,null);
		EntFire("lfkb_model","SetDefaultAnimation","attack1",3.02,null);
		EntFire("lfkb_model","SetAnimation","attack1",3,null);
		EntFireByHandle(self,"RunScriptCode","target_human = true;",13,null,null);
		EntFireByHandle(self,"RunScriptCode","SearchTarget();",13.02,null,null);
		EntFire("lfkb_model","SetDefaultAnimation","run",13.02,null);
		EntFire("lfkb_model","SetAnimation","run",13,null);
		EntFireByHandle(self,"RunScriptCode","jineng();",15,null,null);
		return;
	}
	}
	if(shuzi == 0)
	{
		jineng_pingA1();
	}
	if(shuzi == 1)
	{
		jineng_pingA1();
	}
	if(shuzi == 2)
	{
		jineng_pingA1();
	}
	if(shuzi == 3)
	{
		jineng_pingA2();
	}
	return;
}

function jineng_pingA1()
{
	EntFire("lfkb_model","SetAnimation","attack1",0,null);
	EntFireByHandle(self,"RunScriptCode","jineng();",5,null,null);
}
function jineng_pingA2()
{
	EntFire("lfkb_model","SetAnimation","attack2",0,null);
	EntFireByHandle(self,"RunScriptCode","yundong = false;",0.5,null,null);
	EntFireByHandle(self,"RunScriptCode","yundong = true;",1.7,null,null);
	EntFireByHandle(self,"RunScriptCode","jineng();",4,null,null);
}
function touming()
{
	EntFire("lfkb_model","AddOutput","rendermode 1",0,null);
	local i = 3;
	while(i<=255)
	{
		EntFire("lfkb_model","Alpha",i.tostring(),i/100.0,null);
		i=i+1;
	}
}