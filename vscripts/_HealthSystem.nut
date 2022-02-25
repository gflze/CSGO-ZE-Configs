//-----------Tick Stuff-----------\\
TICKRATE <- 0.5;

ticking <- false;
//--------------------------------\\


//-------Boss Health Stuff-------\\

canTakeDamage <- true;

healthCap <- 72000; // health which can't be gone over

healthPerChunk <- 1200;

playersHealth <- 0;

maxHealth <- 0; // maximum health that can be recovered by the bladekeeper

health <- 0; // current health of the bladekeeper

healthBarIcon <- "█"

//--------- Tune these values to change how the bladekeeper boss take damage ---------\\
damageModifer <- 1.6; // variable by player number

initalDamageModifer <- null;

damageToReducePerPlayer <- 0.037

minimumAllowedDamageModifer <- 0.15;
//------------------------------------------------------------------------------------\\

bossName <- "The Bladekeeper";

bladekeeperScript <- null;

humansHealthBar <- null;

humansFailed <- false;
function SetHumansHealthBar(){humansHealthBar = caller;}
//--------------------------------\\

function Start()
{
	if (!ticking)
	{
		ticking = true;
        bladekeeperScript = Entities.FindByName(null, "bladekeeper_npc_model").GetScriptScope()
        maxHealth = healthCap;
        playersHealth = healthCap / 2;
        health = maxHealth;
        initalDamageModifer = damageModifer;
        Settings();
        UpdateHealthBar();
		Tick();
	}
}

function Stop()
{
	if (ticking)
	{
		ticking = false;
	}
}

function Tick()
{
	if(ticking)
	{
		EntFireByHandle(self,"RunScriptCode","Tick();",TICKRATE,null,null);
        
        damageModifer = CalculateDamageModifier();
        UpdateHealthBar();
        if(playersHealth <= 0 && humansFailed == false)
        {
            humansFailed = true;
            HumansFailSequence();
        }
	}
}


function UpdateHealthBar()
{
    local healthBar = bossName+"\n\n";
    local _humansHealthBar = "Humans\n\n"
    for (local i = 0; i < health; i += healthPerChunk) {
        healthBar += healthBarIcon;
    }
    for (local i = 0; i < playersHealth; i += healthPerChunk) {
        _humansHealthBar += healthBarIcon;
    }
    if(health >= maxHealth)
    {
        healthBar += "X";
    }

    self.__KeyValueFromString("message", healthBar)
    humansHealthBar.__KeyValueFromString("message", _humansHealthBar)
    EntFireByHandle(self, "Display", "", 0.0, null, null);
    EntFireByHandle(humansHealthBar, "Display", "", 0.0, null, null);
}

function SubtractHealth(amount, player)
{
    if(canTakeDamage)
    {
        local scope = player.GetScriptScope();
        local plyDamageModifier = scope.damageModifer;
        // damage the bladekeeper based on the strength of the player
        local amount = (amount * plyDamageModifier) * damageModifer;
        health -= amount;
        playersHealth += amount;

        if(playersHealth > healthCap)
            playersHealth = healthCap;

        local percentage = (health / maxHealth) * 100;
        if(percentage <= 85 && percentage > 55 && bladekeeperScript.PHASE == 1 && !bladekeeperScript.isParried)
        {
            maxHealth = health;
            bladekeeperScript.TriggerPhase2();
        }
        if(percentage <= 55 && bladekeeperScript.PHASE == 2 && !bladekeeperScript.isParried)
        {
            maxHealth = health;
            bladekeeperScript.TriggerPhase3();
        }

        if(percentage <= 0 && bladekeeperScript.PHASE == 3 && !bladekeeperScript.isParried)
        {
            canTakeDamage = false;
            Stop();
            bladekeeperScript.TriggerPhase4();

        }
    }
}

function AddHealth(amount, player)
{
    local scope = player.GetScriptScope();
    local plyResistanceModifier = scope.damageResistance;
    // heal the bladekeeper based on the player's resistance
    local amount = (amount * plyResistanceModifier) * (damageModifer / 2);
    health += amount;
    playersHealth -= amount;

    if(playersHealth <= 0 && humansFailed == false)
    {
        humansFailed = true;
        HumansFailSequence();
    }

    // cap bladekeepr's health to the max
    if(health > maxHealth)
        health = maxHealth;
}

function CalculateDamageModifier()
{
    local finalNum = initalDamageModifer;
    
	local ply = null;
	while ( ply = Entities.FindByClassname(ply, "player") )
	{
        if(ply.GetTeam() == 3)
		{
            finalNum -= damageToReducePerPlayer
        }
    }
    if(finalNum < minimumAllowedDamageModifer)
        finalNum = minimumAllowedDamageModifer;

    return finalNum;
}

function Settings()
{
    self.__KeyValueFromFloat("x", 0.01)
    self.__KeyValueFromFloat("y", 0.60)
    self.__KeyValueFromString("color2", "0 165 244")

    humansHealthBar.__KeyValueFromFloat("x", 0.01)
    humansHealthBar.__KeyValueFromFloat("y", 0.70)
    humansHealthBar.__KeyValueFromString("color2", "0 165 244")
}

function HumansFailSequence()
{
    EntFire("finale_fail_fade", "Fade", null, 0.05, null)
    EntFire("finale_humans_fail_hurt", "Enable", null, 3, null)
}