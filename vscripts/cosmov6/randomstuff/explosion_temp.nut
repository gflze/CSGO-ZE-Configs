
radius <- 128;
damage <- 0
filter <- 2;
filtername <- [
"filter_humans",
"filter_zombies",
"",]
ignore <- false;

effect <- 1
effectname <-[
    "explosion_c4_500",//256
    "explosion_basic",]//1

//                                                (место положение, радиус, урон)
//ent_fire explosion runscriptcode "CreateExplosion(Vector(200,0,20),256,100,0  )"
function CreateExplosion(iorigin,iradius,idamage,iignore = false,ifilter = 2)
{
    self.SetOrigin(iorigin - Vector(0, 0, 45));
    radius = iradius;
    damage = idamage;
    filter = ifilter;
    ignore = iignore;
    EntFireByHandle(self, "ForceSpawn", "", 0, null, null);
}                                                   

function PreSpawnInstance( entityClass, entityName )
{
	local keyvalues = {};
    if(entityClass == "env_shake")
    {
        keyvalues["radius"] <- radius * 1.5;
    }
    if(entityClass == "ambient_generic")
    {
        keyvalues["radius"] <- radius * 2;
    }
    if(entityClass == "trigger_multiple")
    {
        if(filtername[filter] != "")
        keyvalues["filtername"] <- filtername[filter];
    }
    if(entityClass == "info_particle_system")
    {
        keyvalues["effect_name"] <- effectname[(radius < 256) ? 1 : 0];
    }
	return keyvalues
}

function PostSpawn( ents )
{
    local classname;
    foreach(targetname, handle in ents)
    {
        classname = handle.GetClassname();
        if(classname == "trigger_multiple")
        {
            handle.GetScriptScope().dist = radius * 1.5;
            handle.GetScriptScope().power = damage;
            handle.GetScriptScope().ignore = ignore;
        }
    }
    DebugDrawCircle(self.GetOrigin(), Vector(255,255,255), radius, 36, true, 3)
}

function DebugDrawCircle(Vector_Center, Vector_RGB, radius, parts, zTest, duration) //0 -32 80
{
    local u = 0.0;
    local vec_end = [];
    local parts_l = parts;
    local radius = radius;
    local a = PI / parts * 2;
    while(parts_l > 0)
    {
        local vec = Vector(Vector_Center.x+cos(u)*radius, Vector_Center.y+sin(u)*radius, Vector_Center.z);
        vec_end.push(vec);
        u += a;
        parts_l--;
    }
    for(local i = 0; i < vec_end.len(); i++)
    {
        if(i < vec_end.len()-1){DebugDrawLine(vec_end[i], vec_end[i+1], Vector_RGB.x, Vector_RGB.y, Vector_RGB.z, zTest, duration);}
        else{DebugDrawLine(vec_end[i], vec_end[0], Vector_RGB.x, Vector_RGB.y, Vector_RGB.z, zTest, duration);}
    }
}