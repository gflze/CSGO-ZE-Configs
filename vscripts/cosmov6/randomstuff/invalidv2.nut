//lastpos <- self.GetOrigin();
ts <- null;
tf <- null;
tu <- null;
ui <- null;
button <- null;
invalid <- null;

Press_w <- false;
Press_s <- false;
Press_a <- false;
Press_d <- false;

loopzone <- false;	//true when entering loops (to prevent upright-correction)
grounded <- false;
ticking <- false;
tickrate <- 0.05;

jumpamount <- 0.00;
forward_speed <- 5500;
backward_speed <- 1600;
side_speed <- 140;

speedmod <- 1.00;
gravity <- 1.00;

function PressButton()
{
    if(activator == null ||
    !activator.IsValid() ||
    activator.GetClassname() != "player" ||
    activator.GetHealth() <= 0)return;

    if(invalid == null)
    EntFireByHandle(ui, "Activate", "", 0.00, activator, activator);
}

function SetSpeed(f,b,s)
{
    forward_speed = f;
    backward_speed = b;
    side_speed = s;
    ts.__KeyValueFromInt("force",side_speed.tointeger());
}

function SetInvalid(can = true)
{
    if(can)
    {
        invalid = activator;

        // lastpos = self.GetOrigin();
        ParentPlayer(activator);
        tf.__KeyValueFromInt("force",(forward_speed * speedmod));
	    ts.__KeyValueFromInt("force",side_speed.tointeger());
        if(!ticking)
        {
            ChangeMoveType(true);
            ChangeMoveType(false);
            ticking = true;
            Tick();
        }
    }
    else
    {
        if(invalid == null || !invalid.IsValid())
        {
            invalid = null
            EntFireByHandle(ui,"Deactivate", "", 0.00, activator, activator);
            EntFireByHandle(tf,"Deactivate","",0.00,null,null);
		    EntFireByHandle(ts,"Deactivate","",0.00,null,null);
            ChangeMoveType(true);
            ChangeMoveType(false);
        }
    }

}

function ParentPlayer(handle)
{
	local pos = self.GetOrigin();
	EntFire("speedmod","ModifySpeed","0.00",0.00,activator);
	EntFireByHandle(handle,"AddOutput","movetype 0",0.00,null,null);
	handle.SetOrigin(pos);
	EntFireByHandle(handle,"ClearParent","",0.00,null,null);
	EntFireByHandle(handle,"SetParent","!activator",0.01,self,self);
}

function Tick()
{
    EntFireByHandle(self,"RunScriptCode"," Tick(); ",tickrate,null,null);

    if(TraceLine(self.GetOrigin(), self.GetOrigin() + Vector(0, 0, -15), self) < 1.00)
    {
        DebugDrawLine(self.GetOrigin(), self.GetOrigin() + Vector(0, 0, -15), 0, 255, 0, true, 0.5)
        grounded = true;
    }
	else if(TraceLine(self.GetOrigin() + self.GetForwardVector() * 30, self.GetOrigin() + self.GetForwardVector() * 30 + Vector(0, 0, -30), self) < 1.00)
    {
        DebugDrawLine(self.GetOrigin() + self.GetForwardVector() * 30, self.GetOrigin() + self.GetForwardVector() * 30 + Vector(0, 0, -30), 0, 0, 255, true, 0.5)
        grounded = true;
    }
	else
    {
        DebugDrawLine(self.GetOrigin() + self.GetForwardVector() * 30, self.GetOrigin() + self.GetForwardVector() * 30 + Vector(0, 0, -30), 255, 0, 0, true, 0.5)
        grounded = false;
    }
    TickGravity()
    ScriptPrintMessageCenterAll(
        "w: "+Press_w.tostring()+
        "\ns: "+Press_s.tostring()+
        "\na: "+Press_a.tostring()+
        "\nd: "+Press_d.tostring()+
        "\n"+jumpamount.tostring())
}

function SetHandle()
{
    local name = caller.GetName();
    if(name.find("waffel_t_s") == 0)
    {
        ts = caller;
    }

    if(name.find("waffel_t_f") == 0)
    {
        tf = caller;
    }

    if(name.find("waffel_t_u") == 0)
    {
        tu = caller;
    }

    if(name.find("waffel_b") == 0)
    {
        button = caller;
    }

    if(name.find("waffel_ui") == 0)
    {
        ui = caller;
    }
}

function Control(i)
{
    local movetype = false;
    switch (i)
    {
        case 0:
        Press_w = true;
        movetype = true;
        break;

        case 1:
        Press_w = false;
        movetype = true;
        break;

        case 2:
        Press_s = true;
        movetype = true;
        break;

        case 3:
        Press_s = false;
        movetype = true;
        break;

        case 4:
        Press_a = true;
        break;

        case 5:
        Press_a = false;
        break;

        case 6:
        Press_d = true;
        break;

        case 7:
        Press_d = false;
        break;
    }
    ChangeMoveType(movetype)
}

function ChangeMoveType(movetype)
{
    if(movetype)
    {
        EntFireByHandle(tf,"Deactivate","",0.00,null,null);
        if((Press_w && !Press_s) || (!Press_w && Press_s))
        {
			if(Press_w)
			{
				tf.__KeyValueFromVector("angles",Vector(0,0,0));
				tf.__KeyValueFromInt("force",(forward_speed * speedmod));
				if(Press_a || Press_d)
                {
                    ChangeMoveType(false);
                }
			}
			else
			{
				tf.__KeyValueFromVector("angles",Vector(0,180,0));
				tf.__KeyValueFromInt("force",(backward_speed * speedmod));
				if(Press_a || Press_d)
                {
                    ChangeMoveType(false);
                }
			}
            EntFireByHandle(tf,"Activate","",0.01,null,null);
        }
    }
    else
    {
        EntFireByHandle(ts,"Deactivate","",0.00,null,null);
        if((Press_a && !Press_d) || (!Press_a && Press_d))
        {
			if(Press_s)
			{
				if(Press_a)ts.__KeyValueFromVector("angles",Vector(0,270,0));
				else ts.__KeyValueFromVector("angles",Vector(0,90,0));
			}
			else
			{
				if(Press_a)ts.__KeyValueFromVector("angles",Vector(0,90,0));
				else ts.__KeyValueFromVector("angles",Vector(0,270,0));
			}
            EntFireByHandle(ts,"Activate","",0.01,null,null);
        }
    }
}

function TickGravity()
{
	if(jumpamount > 0.00 || !grounded)
	{
		jumpamount -= (tickrate * (gravity * 50000));
		local vertspeed = jumpamount;
		EntFireByHandle(tu,"Deactivate","",0.00,null,null);
		EntFireByHandle(tu,"Activate","",0.01,null,null);

        if(jumpamount<=0)
        {
            vertspeed *= -1;
            tu.__KeyValueFromVector("angles",Vector(90,0,0));
        }
        else tu.__KeyValueFromVector("angles",Vector(-90,0,0));

        tu.__KeyValueFromInt("force",vertspeed.tointeger());
	}
	else
	{
		EntFireByHandle(tu,"Deactivate","",0.00,null,null);
		tu.__KeyValueFromInt("force",0);
		jumpamount = 0.00;
	}
}