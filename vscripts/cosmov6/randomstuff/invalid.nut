map_brush <- Entities.FindByName(null, "map_brush");
SpeedMod <- Entities.FindByName(null, "speedMod");
drivering <- false;
invalid <- null;
driver <- null;
model <- self.GetMoveParent();
lastPos <- Vector(0,0,0);
defaultSpeed <- "0.85";
forwarddist <- 50;

function SetInvalid()
{
    invalid = activator;
    EntFireByHandle(invalid, "AddOutput", "MoveType 2", 0, null, null);
    EntFireByHandle(SpeedMod, "ModifySpeed", defaultSpeed, 0, invalid, invalid);
}

function Tick()
{
    if(driver != null)
    {
        if(!driver.IsValid() || driver.GetHealth() <= 0.00 || driver.GetTeam() != invalid.GetTeam())
        {
            AutoPilot()
        }
        else
        {
            invalid.SetOrigin(driver.GetOrigin() + driver.GetForwardVector() * forwarddist);
            model.SetAngles(0,driver.GetAngles().y,0);
            lastPos = driver.GetOrigin();
        }
        EntFireByHandle(self, "RunScriptCode", "Tick();", 0.01, null, null);
    }
}

function ToggleWaffel()
{
    if(invalid == activator)return;
    if(invalid == null)return;
    if(map_brush.GetScriptScope().GetPlayerClassByHandle(activator).invalid)return;
    if(driver == null)
    {
        if(activator.GetTeam() != invalid.GetTeam())return;
        driver = activator;
    }
    else if(driver != activator)return;
    if(drivering)
    {
        AutoPilot();
    }
    else
    {
        SetPilot();
        Tick();
    }
}

function AutoPilot()
{
    driver = null;
    drivering = false;
    EntFireByHandle(self, "RunScriptCode", "model.SetAngles(0,invalid.GetAngles().y,0);", 0.5, null, null);
    EntFireByHandle(invalid, "AddOutput", "MoveType 2", 0, null, null);
    EntFireByHandle(self, "RunScriptCode", "invalid.SetOrigin(lastPos);", 0, null, null);
    EntFireByHandle(SpeedMod, "ModifySpeed", defaultSpeed, 0, invalid, invalid);
}

function SetPilot()
{
    drivering = true;
    EntFireByHandle(invalid, "AddOutput", "MoveType 7", 0, null, null);
    EntFireByHandle(SpeedMod, "ModifySpeed", "0", 0, invalid, invalid);
}