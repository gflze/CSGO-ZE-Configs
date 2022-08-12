//Main
{
    class stats
    {
        round_num = 0;
        round_winner = 0;
        stage = 0
        last_lock = "";
        ct_alive_count = 0;
        zm_alive_count = 0;
        ct_count = 0;
        zm_count = 0;
        item_array = "";
        constructor(_round_num,_stage)
        {
            round_num = _round_num;
            stage = _stage;
        }
        function Print()
        {
            printl(
                "round_num : "+round_num+"\n"+
                "round_winner : "+round_winner+"\n"+
                "stage : "+stage+"\n"+
                "last_lock : "+last_lock+"\n"+
                "ct_alive_count : "+ct_alive_count+"\n"+
                "zm_alive_count : "+zm_alive_count+"\n"+
                "ct_count : "+ct_count+"\n"+
                "zm_count : "+zm_count
            );
            if(item_array!=null)
            {
                printl("items : "+item_array);
            }
            printl("")
        }
        function PrintC()
        {
            print(
                "\n"+
                round_num+"|"+
                round_winner+"|"+
                stage+"|"+
                last_lock+"|"+
                ct_alive_count+"|"+
                zm_alive_count+"|"+
                ct_count+"|"+
                zm_count+"|"+
                item_array+"|"
            );
        }
        function SetItems(_items)
        {
            this.item_array = _items;
        }
    }

    function OnPostSpawn()
    {
        Start();
    }
  
    map_brush <- Entities.FindByName(null, "map_brush");

    function Start()
    {
        local Stage = map_brush.GetScriptScope().Stage;
        local new = stats(RoundPlayed,Stage);
        Stats.push(new);
    }

    function End()
    {
        RoundPlayed++;

        local winner = event_data.winner;
        //local winner = 2
        local items = [];
        local item = "";

        // if(last_user_bio!=null){items.push("0"+last_user_bio.bio_lvl)}
        // if(last_user_ice!=null){items.push("1"+last_user_ice.ice_lvl)}
        // if(last_user_poison!=null){items.push("2"+last_user_poison.poison_lvl)}
        // if(last_user_wind!=null){items.push("3"+last_user_wind.wind_lvl)}
        // if(last_user_summon!=null){items.push("4"+last_user_summon.summon_lvl)}
        // if(last_user_fire!=null){items.push("5"+last_user_fire.fire_lvl)}
        // if(last_user_electro!=null){items.push("6"+last_user_electro.electro_lvl)}
        // if(last_user_gravity!=null){items.push("7"+last_user_gravity.gravity_lvl)}
        // if(last_user_earth!=null){items.push("8"+last_user_earth.earth_lvl)}
        // if(last_user_ultimate!=null){items.push("9"+last_user_ultimate.ultimate_lvl)}
        // if(last_user_heal!=null){items.push("10"+last_user_heal.heal_lvl)}

        for (local i = 0; i < items.len(); i++)
        {
            if(i > 0){item += "_";}
            item += items[i];
        }

        if(item!="")
            Stats[Stats.len() - 1].SetItems(item);
        Stats[Stats.len() - 1].round_winner = winner;
        Stats[Stats.len() - 1].zm_alive_count = GetZMCount();
        Stats[Stats.len() - 1].zm_count = GetZMCount(false);
        Stats[Stats.len() - 1].ct_alive_count = GetCTCount();
        Stats[Stats.len() - 1].ct_count = GetCTCount(false);
    }
}
//Support
{
    function PrintStats()
    {
        for (local i = 0; i < Stats.len(); i++)
        {
            Stats[i].PrintC();
        }
    }

    function GetCTCount(alive = true)
    {
        local h = null;
        local count = 0;
        while(null != (h = Entities.FindByClassname(h, "player")))
        {
            if(h != null)
            {
                if(h.GetTeam() == 3)
                {
                    if(h.IsValid() && h.GetHealth() > 0)
                    {
                        if(alive)count++;
                    }
                    else
                    {
                        if(!alive)count++;
                    }
                }
            }
        }
        return count;
    }

    function GetZMCount(alive = true)
    {
        local h = null;
        local count = 0;
        while(null != (h = Entities.FindByClassname(h, "player")))
        {
            if(h != null)
            {
                if(h.GetTeam() == 2)
                {
                    if(h.IsValid() && h.GetHealth() > 0)
                    {
                        if(alive)count++;
                    }
                    else
                    {
                        if(!alive)count++;
                    }
                }
            }
        }
        return count;
    }
}