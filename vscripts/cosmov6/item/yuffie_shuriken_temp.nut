::Maker_Shuriken <- Entities.CreateByClassname("env_entity_maker")
Maker_Shuriken.__KeyValueFromString("EntityTemplate", self.GetName());
::Shuriken_Logic <- self;

::TEMP_Shuriken_Owner <- null;
::TEMP_Shuriken_Dir <- Vector();
::TEMP_Shuriken_Materia <- -1;
::TEMP_Shuriken_HitBox <- -1;

::CreateShuriken <- function(hOwner, hHitBox, vecDir = Vector(0, -1, 0), iMateriaStatus = -1)
{
	TEMP_Shuriken_Owner = hOwner;
	TEMP_Shuriken_Dir = vecDir;
	TEMP_Shuriken_Materia = iMateriaStatus;
	TEMP_Shuriken_HitBox = hHitBox;

	Maker_Shuriken.SetOrigin(hOwner.EyePosition())
	Maker_Shuriken.SpawnEntity();
}

function PreSpawnInstance( entityClass, entityName )
{
	if (entityClass == "prop_dynamic_glow")
	{
		if (TEMP_Shuriken_Materia > -1)
		{
			return {glowcolor = DATA_SHURIKEN[TEMP_Shuriken_Materia].color};
		}
	}
	else if (entityClass == "info_particle_system")
	{
		if (TEMP_Shuriken_Materia > -1)
		{
			return {effect_name = DATA_SHURIKEN[TEMP_Shuriken_Materia].particle};
		}
	}
	else if (entityClass == "light_dynamic")
	{
		if (TEMP_Shuriken_Materia > -1)
		{
			return {_light = DATA_SHURIKEN[TEMP_Shuriken_Materia].color + " 100"};
		}
	}
	return {};
}

function PostSpawn(entities)
{
	foreach (entity in entities)
	{
		if (entity.GetClassname() == "prop_dynamic_glow")
		{
			if (TEMP_Shuriken_Materia > -1)
			{
				EntFireByHandle(entity, "SetGlowEnabled", "", 0, null, null);
			}
			entity.GetScriptScope().Init(TEMP_Shuriken_Owner, TEMP_Shuriken_HitBox, TEMP_Shuriken_Dir, TEMP_Shuriken_Materia);
		}
		else if (entity.GetClassname() == "info_particle_system")
		{
			if (TEMP_Shuriken_Materia > -1)
			{
				EntFireByHandle(entity, "Start", "", 0, null, null);
			}
			else
			{
				EntFireByHandle(entity, "Kill", "", 0, null, null);
			}
		}
		else if (entity.GetClassname() == "light_dynamic")
		{
			if (TEMP_Shuriken_Materia < 0)
			{
				EntFireByHandle(entity, "Kill", "", 0, null, null);
			}
		}
	}

	TEMP_Shuriken_Owner = null;
	TEMP_Shuriken_Dir = Vector();
	TEMP_Shuriken_Materia = -1;
	TEMP_Shuriken_HitBox = null;
}

::SetShuriken_Effect <- function(aDATA)
{
	// printl("DATA: " + aDATA.activator+ " : " +aDATA.materia+ " : " +aDATA.owner+ " : " +aDATA.shuriken);
	if (aDATA.materia == 0) //GRAVITY
	{
		local dir = aDATA.gravity+ Vector(0, 0, 50) - aDATA.activator.GetCenter();
		dir.Norm();
		aDATA.activator.SetVelocity(Vector(dir.x * 500, dir.y * 500, dir.z * 350));
	}
	if (aDATA.materia == 1) //Fire
	{
		EntFireByHandle(MainScript, "RunScriptCode", "DamagePlayer(200,::item)", 0, aDATA.activator, aDATA.activator);
		EntFireByHandle(MainScript, "RunScriptCode", "SlowPlayer(0.2,0.1)", 0, aDATA.activator, aDATA.activator);
		EntFireByHandle(aDATA.activator,"IgniteLifeTime", "1.0" ,0, null, null);
	}
	if (aDATA.materia ==2) //WIND
	{
		local dir = aDATA.activator.GetCenter() - aDATA.owner.GetCenter();
		dir.Norm();
		aDATA.activator.SetVelocity(Vector(dir.x * 250, dir.y * 250, dir.z * 300));
	}
	if (aDATA.materia == 3) //poison
	{
		EntFireByHandle(MainScript, "RunScriptCode", "DamagePlayer(150,::item)", 0, aDATA.activator, aDATA.activator);
		EntFireByHandle(MainScript, "RunScriptCode", "SlowPlayer(0.3,0.25)", 0, aDATA.activator, aDATA.activator);
	}
	if (aDATA.materia == 4) //Ice
	{
		EntFireByHandle(MainScript, "RunScriptCode", "SlowPlayer(1,1.5)", 0, aDATA.activator, aDATA.activator);
	}
	if (aDATA.materia == 5) //electro
	{
		aDATA.activator.SetVelocity(Vector());
		EntFireByHandle(MainScript, "RunScriptCode", "DamagePlayer(150,::item)", 0, aDATA.activator, aDATA.activator);
		EntFireByHandle(MainScript, "RunScriptCode", "SlowPlayer(0.15,0.25)", 0, aDATA.activator, aDATA.activator);
	}
}

::GetItemNameIndexByOwner <- function(owner)
{
	local array = MainScript.GetScriptScope().ITEM_OWNER;
	foreach (item in array)
	{
		if (item.owner != owner)
		{
			continue;
		}

		if (item.name_right == "gravity")
		{
			return 0;
		}
		if (item.name_right == "fire")
		{
			return 1;
		}
		if (item.name_right == "wind")
		{
			return 2;
		}
		if (item.name_right == "poison")
		{
			return 3;
		}
		if (item.name_right == "ice")
		{
			return 4;
		}
		if (item.name_right == "electro")
		{
			return 5;
		}
	}
	return -1;
}

::DATA_SHURIKEN <- [
	{
		particle = "custom_particle_017",
		color = "160 66 255",
	}, //Gravity
	{
		particle = "custom_particle_014",
		color = "231 102 24",
	}, //fire
	{
		particle = "custom_particle_001",
		color = "72 249 130",
	}, //wind
	{
		particle = "custom_particle_032",
		color = "221 251 76",
	}, //poison
	{
		particle = "custom_particle_029",
		color = "128 255 255",
	}, //ice
	{
		particle = "custom_particle_011",
		color = "7 50 248",
	}, //electro
];

function Test()
{
	local h;
	local count = 0;
	local temp = Vector();
	while ((h = Entities.FindByClassnameWithin(h, "cs_bot", activator.GetOrigin(), 1024)) != null)
	{
		DrawAxis(h.GetOrigin(), 16, true, 16);
		temp += h.GetOrigin();
		count++
	}
	DrawAxisX(Vector(temp.x / count, temp.y / count, temp.z / count), 64, true, 16);
}

function DrawAxis(pos,s = 16,nocull = true,time = 1)
{
	DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 0, 255, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y,pos.z-s), Vector(pos.x,pos.y,pos.z+s), 0, 0, 255, nocull, time);
}


function DrawAxisX(pos,s = 16,nocull = true,time = 1)
{
	DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 255, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 255, 0, 255, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y,pos.z-s), Vector(pos.x,pos.y,pos.z+s), 255, 0, 255, nocull, time);
}

