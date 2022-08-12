//Main
{
    class FullPos
    {
        constructor(_origin, _angles)
        {
            this.angles = _angles;
            this.origin = _origin;
        }
        angles = Vector(0, 0, 0);
        origin = Vector(0, 0, 0);
    }

    class RandomSpawn
    {
        constructor()
        {
            this.handle = [];
            this.position = [];
        }

        handle = null;
        position = null;

        function AddPos(_position)
        {
            this.position.push(_position);
        }

        function AddHandle(_handle)
        {
            this.handle.push(_handle);
        }

        function SpawnOnPositionOne(_postion)
        {
            this.handle[0].SpawnEntityAtLocation(_postion.origin, _postion.angles);
        }


        function GetRandomSpawn()
        {
            local random = RandomInt(0, this.position.len() - 1);
            local handlePos = this.position[random];
            this.position.remove(random);
            return handlePos;
        }

        function GetRandomHandle(removehandle)
        {
            local random = RandomInt(0, this.handle.len() - 1);
            local handle = this.handle[random];
            if(removehandle && this.handle.len() > 1)
                this.handle.remove(random);
            return handle;
        }

        function SpawnOnPositionTwo(handle,_postion)
        {
            handle.SpawnEntityAtLocation(_postion.origin, _postion.angles);
        }

        function ClearPosition()
        {
            this.position.clear();
        }

        function ClearHandle()
        {
            this.handle.clear();
        }

        function Print()
        {
            print("---|");
            for (local i = 0; i < this.handle.len(); i++)
            {
                print(this.handle[i]);
            }
            printl("|---")
            for (local i = 0; i < this.position.len(); i++)
            {
                printl(format("%i) Vector(%f,%f,%f) : (%f, %f, %f)", i,
                this.position[i].origin.x, this.position[i].origin.y, this.position[i].origin.z,
                this.position[i].angles.x, this.position[i].angles.y, this.position[i].angles.z))
            }
        }
    }

    map_brush <- Entities.FindByName(null, "map_brush");

    function Start()
    {
        local stage = map_brush.GetScriptScope().Stage;

        if(stage == 1)
        {
            SpawnItems(9);
            SpawnUltima();

            SpawnChest(16);
        } 
        else if(stage == 2)
        {
            SpawnItems(8);
            SpawnUltima();

            SpawnChest(16);
        }
        else if(stage == 3)
        {
            SpawnItems(10);
            SpawnUltima();

            SpawnChest(14, 7, 7);
        }
        else if(stage == 4)
        {
            SpawnItems(7);
            SpawnUltima();

            SpawnChest(12, 6, 6);
        }
        else if(stage == 5)
        {
            SpawnItems(6);
            SpawnUltima();

            SpawnChest(10, 5, 5);
        }
        
        // for(local i = 0; i < ItemOrigin.len(); i++)
        // {
        //     DebugDrawCircle(ItemOrigin[i].origin, Vector(255,0,0), 64, 16, true, 180);
        // }
        // for(local i = 0; i < UltimaOrigin.len(); i++)
        // {
        //     DebugDrawCircle(UltimaOrigin[i], Vector(0,255,0), 64, 16, true, 180);
        // }
        // for(local i = 0; i < ChestOrigin.len(); i++)
        // {
        //     DebugDrawCircle(ChestOrigin[i].origin, Vector(255,0,0), 64, 16, true, 180);
        // }
        
    }
}
//Ultima
{
    function SpawnUltima()
    {
        UltimaRandomSpawn.ClearPosition();
        UltimaRandomSpawn.ClearHandle();

        local temp;
        local maker;

        temp = Entities.FindByName(null, TEMP_ULTIMATE);
        maker = Entities.CreateByClassname("env_entity_maker");
        maker.__KeyValueFromString("EntityTemplate", TEMP_ULTIMATE)
        UltimaRandomSpawn.AddHandle(maker);

        for (local i = 0; i < UltimaOrigin.len(); i++)
        {
            local origin = UltimaOrigin[i];
            local angles = Vector(0, 0, 0);
            local obj = FullPos(origin,angles);
            UltimaRandomSpawn.AddPos(obj);
        }

        local pos
        pos = UltimaRandomSpawn.GetRandomSpawn();
        //DebugDrawCircle(pos.origin, Vector(0,255,0), 64, 16, true, 180);
        UltimaRandomSpawn.SpawnOnPositionOne(pos);
    }

    UltimaRandomSpawn <- RandomSpawn();

    UltimaOrigin <-[
    //Vector(-4234,-4159,2381),
    Vector(-651,-1405,1381),
    Vector(-1377,1183,280),
    Vector(-6841,-1720,1653),
    Vector(-2140,-2299,1902),
    Vector(1023,-3718,583),
    Vector(-1995,-928,1886),
    Vector(162,5961,666),
    ]
}
//Items
{
    ItemRandomSpawn <- RandomSpawn();

    function SpawnItems(count)
    {
        ItemRandomSpawn.ClearPosition();
        ItemRandomSpawn.ClearHandle();

        local temp;
        local maker;
        local items_list = [
            TEMP_BIO, 
            TEMP_EARTH, 
            TEMP_ICE, 
            TEMP_FIRE, 
            TEMP_SUMMON, 
            TEMP_ELECTRO, 
            TEMP_GRAVITY, 
            TEMP_POISON, 
            TEMP_WIND, 
            TEMP_HEAL,];

        if (EVENT_EXTRAITEMS)
        {
            local random = RandomInt(EVENT_EXTRAITEMS_COUNT[0], EVENT_EXTRAITEMS_COUNT[1]);
            
            count += random;
            
            for (local i = 0; i < random; i++)
            {
                items_list.push(items_list[RandomInt(0, items_list.len()-1)]);
            }
        }
        for(local i = 0; i < items_list.len(); i++)
        {
            temp = Entities.FindByName(null, items_list[i]);
            maker = Entities.CreateByClassname("env_entity_maker");
            maker.__KeyValueFromString("EntityTemplate", items_list[i])
            ItemRandomSpawn.AddHandle(maker);
        }

        for (local i = 0; i < ItemOrigin.len(); i++)
        {
            ItemRandomSpawn.AddPos(ItemOrigin[i]);
        }

        local pos
        for(local i = 0; i < count; i++)
        {
            pos = ItemRandomSpawn.GetRandomSpawn();
            //DebugDrawCircle(pos.origin, Vector(255,0,0), 64, 16, true, 180);
            ItemRandomSpawn.SpawnOnPositionTwo(
            ItemRandomSpawn.GetRandomHandle(true),
            pos);
        }
    }

    ItemOrigin <-
    [
        FullPos(Vector(-3136,-961,1981),Vector(0,0,0)),
        FullPos(Vector(-3507,-4095,2058),Vector(0,0,0)),
        FullPos(Vector(-2627,1555,550),Vector(0,0,0)),
        FullPos(Vector(-1973,-986,1100),Vector(0,0,0)),
        FullPos(Vector(-956,-3311,1322),Vector(0,0,0)),
        FullPos(Vector(-1407,-3299,1235),Vector(0,0,0)),
        FullPos(Vector(-410,-4785,1486),Vector(0,0,0)),
        FullPos(Vector(385,-4568,590),Vector(0,0,0)),
        FullPos(Vector(3544,-3918,502),Vector(0,0,0)),
        FullPos(Vector(4733,-3566,606),Vector(0,0,0)),
        FullPos(Vector(5085,-3267,395),Vector(0,0,0)),
        FullPos(Vector(6239,-3622,339),Vector(0,180,0)),
        FullPos(Vector(-1777,-1552,1449),Vector(0,0,0)),
        FullPos(Vector(-1023,-3662,1307),Vector(0,0,0)),
        FullPos(Vector(-43,-2068,546),Vector(0,0,0)),
        FullPos(Vector(192,-2358,281),Vector(0,0,0)),
        FullPos(Vector(-2188,-1931,1758),Vector(0,0,0)),
        FullPos(Vector(-3304,-1882,1709),Vector(0,90,0)),
        FullPos(Vector(-4238,-4274,2038),Vector(0,0,0)),
        FullPos(Vector(-5930,-1308,2027),Vector(0,0,0)),
        FullPos(Vector(-3693,-1276,598),Vector(0,90,0)),
        FullPos(Vector(-1218,2569,299),Vector(0,0,0)),
        FullPos(Vector(6712,-4488,688),Vector(0,180,0)),
        FullPos(Vector(5445,-3034,242),Vector(0,0,0)),
        FullPos(Vector(4896,-4600,707),Vector(0,0,0)),
        FullPos(Vector(3978,-3671,120),Vector(0,90,0)),
        FullPos(Vector(3546,-2966,587),Vector(0,90,0)),
        FullPos(Vector(3246,-4610,543),Vector(0,0,0)),
        FullPos(Vector(2448,-2419,762),Vector(0,90,0)),
        FullPos(Vector(1723,-3632,619),Vector(0,0,0)),
        FullPos(Vector(1886,-4237,127),Vector(0,0,0)),
        FullPos(Vector(1870,-4542,883),Vector(0,180,0)),
        FullPos(Vector(920,-3760,124),Vector(0,0,0)),
        FullPos(Vector(552,-2656,670),Vector(0,0,0)),
        FullPos(Vector(939,-1270,1068),Vector(0,180,0)),
        FullPos(Vector(-510,-2728,932),Vector(0,0,0)),
        FullPos(Vector(-322,-3913,918),Vector(0,0,0)),
        FullPos(Vector(118,-4605,883),Vector(0,90,0)),
        FullPos(Vector(-345,-1269,618),Vector(0,0,0)),
        FullPos(Vector(-471,-780,1157),Vector(0,0,0)),
        FullPos(Vector(-1425,-717,1350),Vector(0,0,0)),
        FullPos(Vector(-1392,-1480,1226),Vector(0,0,0)),
        FullPos(Vector(-1592,-1248,1626),Vector(0,0,0)),
        FullPos(Vector(-1477,-2550,1174),Vector(0,0,0)),
        FullPos(Vector(-1259,-4688,1036),Vector(0,0,0)),
        FullPos(Vector(-2151,-3861,1209),Vector(0,0,0)),
        FullPos(Vector(-2024,-3449,1442),Vector(0,0,0)),
        FullPos(Vector(-2241,-2422,1402),Vector(0,0,0)),
        FullPos(Vector(-2461,-2581,1106),Vector(0,90,0)),
        FullPos(Vector(-2416,-3200,1067),Vector(0,0,0)),
        FullPos(Vector(-2145,-2768,1225),Vector(0,0,0)),
        FullPos(Vector(-1966,-309,1200),Vector(0,0,0)),
        FullPos(Vector(-1752,-552,1335),Vector(0,180,0)),
        FullPos(Vector(-2418,-1471,1417),Vector(0,0,0)),
        FullPos(Vector(-1597,-946,1067),Vector(0,0,0)),
        FullPos(Vector(-2510,-1471,1091),Vector(0,0,0)),
        FullPos(Vector(-2607,-950,1604),Vector(0,270,0)),
        FullPos(Vector(-3240,-2176,1809),Vector(0,0,0)),
        FullPos(Vector(-2256,-2624,1707),Vector(0,0,0)),
        FullPos(Vector(-2523,-3055,1891),Vector(0,70,0)),
        FullPos(Vector(-2198,-3598,1862),Vector(0,0,0)),
        FullPos(Vector(-2994,-3567,2034),Vector(0,0,0)),
        FullPos(Vector(-3759,-3087,1780),Vector(0,0,0)),
        FullPos(Vector(-4436,-3658,2002),Vector(0,0,0)),
        FullPos(Vector(-4360,-4247,2145),Vector(0,270,0)),
        FullPos(Vector(-7255,-3463,2007),Vector(0,0,0)),
        FullPos(Vector(-6712,-2256,2055),Vector(0,0,0)),
        FullPos(Vector(-6444,-216,2116),Vector(0,0,0)),
        FullPos(Vector(-7018,-498,2259),Vector(0,0,0)),
        FullPos(Vector(-7906,-213,1855),Vector(0,0,0)),
        FullPos(Vector(-5344,-1560,1931),Vector(0,0,0)),
        FullPos(Vector(-5630,-649,2218),Vector(0,0,0)),
        FullPos(Vector(-4750,-877,1862),Vector(0,0,0)),
        FullPos(Vector(-4824,-1110,512),Vector(0,0,0)),
        FullPos(Vector(-3725,764,526),Vector(0,0,0)),
        FullPos(Vector(-2317,1350,348),Vector(0,0,0)),
        FullPos(Vector(-2373,1723,104),Vector(0,0,0)),
        FullPos(Vector(-2258,3092,232),Vector(0,0,0)),
        FullPos(Vector(-405,4617,519),Vector(0,0,0)),
        FullPos(Vector(-271,5451,280),Vector(0,0,0)),
        FullPos(Vector(6986,-646,1181),Vector(0,0,0)),
        FullPos(Vector(4934,-3756,357),Vector(0,0,0)),
        FullPos(Vector(2678,-3885,410),Vector(0,180,0)),
        FullPos(Vector(-1990,-2859,1492),Vector(0,0,0)),
        FullPos(Vector(5078,-825,1055),Vector(0,0,0)),
        FullPos(Vector(2905,-1133,783),Vector(0,0,0)),
        FullPos(Vector(-1265,307,301),Vector(0,0,0)),
        FullPos(Vector(-8077,-1707,1821),Vector(0,0,0)),
        FullPos(Vector(-551,-4686,1117),Vector(0,0,0)),
        FullPos(Vector(4975,-4609,373),Vector(0,0,0)),
        FullPos(Vector(-675,3456,739),Vector(0,270,0)),
    ];
}
//Chest
{
    ChestRandomSpawn <- RandomSpawn();

    function SpawnChest(def = 0, green = 0, red = 0)
    {
        ChestRandomSpawn.ClearPosition();
        ChestRandomSpawn.ClearHandle();

        local temp;
        local maker;

        if (EVENT_EXTRACHEST)
        {
            local random = RandomInt(EVENT_EXTRACHEST_COUNT[0], EVENT_EXTRACHEST_COUNT[1]);
            def += RandomInt(0, random);
            green += RandomInt(0, random);
            red += RandomInt(0, random);
        }

        if(def > 0)
        {
            temp = Entities.FindByName(null, "chest_0");
            maker = Entities.CreateByClassname("env_entity_maker");
            maker.__KeyValueFromString("EntityTemplate", temp.GetName())
            ChestRandomSpawn.AddHandle(maker);
        }

        if(green > 0)
        {
            temp = Entities.FindByName(null, "chest_3");
            maker = Entities.CreateByClassname("env_entity_maker");
            maker.__KeyValueFromString("EntityTemplate", temp.GetName())
            ChestRandomSpawn.AddHandle(maker);
        }

        if(red > 0)
        {
            temp = Entities.FindByName(null, "chest_4");
            maker = Entities.CreateByClassname("env_entity_maker");
            maker.__KeyValueFromString("EntityTemplate", temp.GetName())
            ChestRandomSpawn.AddHandle(maker);
        }
        if(def > 0 || green > 0 || red > 0)
        {
            for(local i = 0; i < ChestOrigin.len(); i++)
            {
                ChestRandomSpawn.AddPos(ChestOrigin[i]);
            }

            local pos;
            for(local i = 0; i < def; i++)
            {
                pos = ChestRandomSpawn.GetRandomSpawn();
                ChestRandomSpawn.SpawnOnPositionTwo(
                ChestRandomSpawn.handle[0],
                pos);
            }
            for(local i = 0; i < green; i++)
            {
                pos = ChestRandomSpawn.GetRandomSpawn();
                ChestRandomSpawn.SpawnOnPositionTwo(
                ChestRandomSpawn.handle[1],
                pos);
            }
            for(local i = 0; i < red; i++)
            {
                pos = ChestRandomSpawn.GetRandomSpawn();
                ChestRandomSpawn.SpawnOnPositionTwo(
                ChestRandomSpawn.handle[2],
                pos);
            }
        }
    }

    ChestOrigin <-
    [
        FullPos(Vector(-3390,-934,1936),Vector(0,175,0)),
        FullPos(Vector(-3728,-4200,1820),Vector(0,355,0)),
        FullPos(Vector(-646,-1252,1022),Vector(0,265,0)),
        FullPos(Vector(5248,525,924),Vector(0,163.5,0)),
        FullPos(Vector(-1249,-190,1042),Vector(0,90,0)),
        FullPos(Vector(-1470,-3317,1024),Vector(0,227,0)),
        FullPos(Vector(-2459,-3031,1183),Vector(0,270,0)),
        FullPos(Vector(6254,-3564,72),Vector(0,180,0)),
        FullPos(Vector(2692,-4550,584),Vector(0,217,0)),
        FullPos(Vector(542,5054,598),Vector(0,323,0)),
        FullPos(Vector(755,5347,586),Vector(0,0,0)),
        FullPos(Vector(457,-2420,72),Vector(0,78,0)),
        FullPos(Vector(2414,-3009,701),Vector(0,352,0)),
        FullPos(Vector(5215,-3489,488),Vector(0,90,0)),
        FullPos(Vector(6599,-4375,328),Vector(0,90,0)),
        FullPos(Vector(3837,-3724,296),Vector(0,90,0)),
        FullPos(Vector(3366,-4636,328),Vector(0,90,0)),
        FullPos(Vector(502,-4204,83),Vector(-2,127,3)),
        FullPos(Vector(197,-3995,840),Vector(0,90,0)),
        FullPos(Vector(-2393,-2567,1346),Vector(0,5,0)),
        FullPos(Vector(-2399,-2786,1024),Vector(0,90,0)),
        FullPos(Vector(-2023,-1715,1024),Vector(0,180,0)),
        FullPos(Vector(-2070,-1028,920),Vector(0,90,0)),
        FullPos(Vector(-1990,-1224,1584),Vector(0,180,0)),
        FullPos(Vector(-2582,-1489,1183),Vector(0,180,0)),
        FullPos(Vector(-2190,-2133,1664),Vector(0,90,0)),
        FullPos(Vector(-2163,-2920,1664),Vector(0,90,0)),
        FullPos(Vector(-7167,-419,1824),Vector(0,0,0)),
        FullPos(Vector(-7299,-3465,1824),Vector(0,180,0)),
        FullPos(Vector(-5210,-1508,1880),Vector(0,90,0)),
        FullPos(Vector(-5448,-663,2176),Vector(0,90,0)),
        FullPos(Vector(-2775,622,492),Vector(0,180,0)),
        FullPos(Vector(-1264,1703,419),Vector(0,180,0)),
        FullPos(Vector(-4360,-945,1602),Vector(0,35,0)),
        FullPos(Vector(-2925,-3746,1664),Vector(0,90,0)),

        FullPos(Vector(6783,-1248,716),Vector(0,0,0)),
        FullPos(Vector(7204,-241,758),Vector(0,0,0)),
        FullPos(Vector(5889,-176,709),Vector(0,0,0)),
        FullPos(Vector(2885,-1548,750),Vector(0,0,0)),
        FullPos(Vector(-7690,-2839,1705),Vector(0,0,0)),
        FullPos(Vector(-8228,-2025,1773),Vector(0,0,0)),

        FullPos(Vector(-749,-4450,1010),Vector(0,0,0)),
        FullPos(Vector(5631,-2626,72),Vector(0,0,0)),
        FullPos(Vector(5381,-4633,328),Vector(0,90,0)),
        FullPos(Vector(3846,-3489,72),Vector(0,90,0)),
        FullPos(Vector(-1968,-3648,1328),Vector(0,0,0)),
        FullPos(Vector(-2186,-589,1184),Vector(0,0,0)),
        FullPos(Vector(-5841,-1323,1880),Vector(0,90,0)),
        FullPos(Vector(-753,-700,1024),Vector(0,90,0)),
        FullPos(Vector(-2117,-1595,1670),Vector(0,180,0)),
    ]
}
//Support
{
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
}

function GetNearChest()
{
    local a_origin = activator.GetOrigin();
    local best_dist = 100000;
    local best_id = 0
    local temp = 0;
    for(local i = 0; i < ItemOrigin.len(); i++)
    {
        temp = GetDistance(a_origin, ItemOrigin[i].origin);
        if(best_dist > temp)
        {
            best_dist = temp;
            best_id = i;
        }
    }
    local pos = ItemOrigin[best_id];
    debugPos = pos;
    ScriptPrintMessageChatAll("Array : " + best_id + "\n angles x: " + pos.angles.x);
    activator.SetOrigin(ItemOrigin[best_id].origin)
}
debugPos <- null;

function DebugPosition(x)
{
    local pos = FullPos(debugPos.origin, Vector(0, x, 0));
    ItemRandomSpawn.SpawnOnPositionTwo(
    ItemRandomSpawn.GetRandomHandle(true),
    pos);
    printl(debugPos.origin);
}

function GetDistance(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));

