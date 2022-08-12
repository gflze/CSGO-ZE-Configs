num_max <- "1";
num_need <- 10;

texture <- [];
ignore <- null;
function OnPostSpawn()
{
    for (local i = 1; i <= 2; i++)
    {
        texture.push(Entities.FindByName(null, "texture_"+i));

        num_max += "0";
    }
    num_max = num_max.tointeger();
    texture.reverse();

    tick();
}

function add_toblock()
{
    ignore = activator;
}

function add_score(i = 1)
{

    if(activator.GetClassname() == "hegrenade_projectile")
    {
        if (activator == ignore)
        {
            return;
        }
    }

    ScoreBass += i;

    if (ScoreBass > num_max)
    {
       ScoreBass = 0;
    }

    MainScript.GetScriptScope().AddCashAll(1);
    
    tick(true);
}

function tick(up = false)
{
    local lim = 10;
	local temp_num = ScoreBass;

	for (local i = 0; i < texture.len(); i++)
	{
		local set = (temp_num % lim) + "";

        EntFireByHandle(texture[i], "SetMaterialVar", set, 0, null, null);

		temp_num = temp_num / lim;
	}
    if(up)
    {
        if(ScoreBass % num_need == 0)
        {
            EntFireByHandle(self, "FireUser1", "", 0, null, null);
        }
    }
}