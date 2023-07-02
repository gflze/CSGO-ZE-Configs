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
    }

    map_brush <- Entities.FindByName(null, "map_brush");

    function Start()
    {
        SpawnItems(4);
        SpawnBaricade(16);
        SpawnFrogs();
        EntFire("UFO_maker","ForceSpawn");
        EntFire("Pila_Maker","ForceSpawn");
    }
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
            "Temp_Item_Human_Heal", 
            "Temp_Item_Human_Fire", 
            "Temp_Item_Human_Water", 
            "Temp_Item_Human_Wind", 
            // weapon_saw_templ,
            // Item_UFO_Temp,
        ];

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

    BaricadeRandomSpawn <- RandomSpawn();
    
    function SpawnBaricade(count)
    {
        BaricadeRandomSpawn.ClearPosition();

        local temp;
        local maker;
        local baricade_list = [
        "Item_Human_Br1_Temp", 
        "Item_Human_Br2_Temp", 
        "Item_Human_Br3_Temp", 
        "Item_Human_Br4_Temp", 
        "Item_Human_Br5_Temp", 
        "Item_Human_Br6_Temp", 
        "Item_Human_Br7_Temp", 
        "Item_Human_Br8_Temp", 
        "Item_Human_Br9_Temp", 
        "Item_Human_Br10_Temp",
        "Item_Human_Br11_Temp",
        ];


        for(local i = 0; i < baricade_list.len(); i++)
        {
            temp = Entities.FindByName(null, baricade_list[i]);
            maker = Entities.CreateByClassname("env_entity_maker");
            maker.__KeyValueFromString("EntityTemplate", baricade_list[i])
            BaricadeRandomSpawn.AddHandle(maker);
        }

        for (local i = 0; i < BaricadeOrigin.len(); i++)
        {
            BaricadeRandomSpawn.AddPos(BaricadeOrigin[i]);
        }
        local pos
        for(local i = 0; i < count; i++)
        {
            pos = BaricadeRandomSpawn.GetRandomSpawn();
            //DebugDrawCircle(pos.origin, Vector(255,0,0), 64, 16, true, 180);
            BaricadeRandomSpawn.SpawnOnPositionTwo(BaricadeRandomSpawn.GetRandomHandle(false),pos);
        }
    }

    function SpawnFrogs()
    {
        local maker = Entities.FindByName(null, "Frog_Spawner");
        for(local i = 0; i < FrogOrigin.len(); i++)
        {
            Spawner(maker,FrogOrigin[i]);         
        }
    }

    function Spawner(handle,_postion)
        {
            handle.SpawnEntityAtLocation(_postion.origin, _postion.angles);
        }

    ItemOrigin <-
    [
        FullPos(Vector(-1440,896,146),Vector(0,0,0)),
        FullPos(Vector(-3636,2097,82),Vector(0,0,0)),
        FullPos(Vector(-5395,1520,18),Vector(0,0,0)),
        FullPos(Vector(-448,-4704,123),Vector(0,0,0)),
    ];


    BaricadeOrigin <-
    [
        FullPos(Vector(-384,192,24),Vector(0,90,0)),
        FullPos(Vector(-384,64,24),Vector(0,90,0)),
        FullPos(Vector(-512,192,24),Vector(0,90,0)),
        FullPos(Vector(-512,64,24),Vector(0,90,0)),
        FullPos(Vector(-640,192,24),Vector(0,90,0)),
        FullPos(Vector(-640,64,24),Vector(0,90,0)),
        FullPos(Vector(-768,192,24),Vector(0,90,0)),
        FullPos(Vector(-768,64,24),Vector(0,90,0)),

        FullPos(Vector(-384,-512,24),Vector(0,-90,0)),
        FullPos(Vector(-384,-384,24),Vector(0,-90,0)),
        FullPos(Vector(-512,-512,24),Vector(0,-90,0)),
        FullPos(Vector(-512,-384,24),Vector(0,-90,0)),
        FullPos(Vector(-640,-512,24),Vector(0,-90,0)),
        FullPos(Vector(-640,-384,24),Vector(0,-90,0)),
        FullPos(Vector(-768,-512,24),Vector(0,-90,0)),
        FullPos(Vector(-768,-384,24),Vector(0,-90,0)),
    ];

    FrogOrigin <-
    [
        FullPos(Vector(-1060, -2896, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(-1344, -3244, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(-1392, -2812, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(288, -3595, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(-2320, -1412, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(-2636, -1272, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(-2416, -1040, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(-2156, -1160, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(-2932, 1280, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(-2628, 1128, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(-2560, 1488, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(-2296, 1392, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(-308, 1408, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(68, 1392, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(-132, 1572, -64),Vector(0,(RandomInt(0, 360)),0)),
        FullPos(Vector(-2208, 1092, -64),Vector(0,(RandomInt(0, 360)),0)),
    ];
}
