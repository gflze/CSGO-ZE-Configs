
PointHurtTemplate <- Entities.FindByName(null,"attributes_pointhurt_maker");
SpeedModifierEntity <- Entities.FindByName(null,"speedmodfreeze");
MapManager <- Entities.FindByName(null, "mapmanager");
SpellsManager <- Entities.FindByName(null, "SpellsHandler")

humanHealBasedDrops <- [1/*Remedy*/]

bladekeeperDrops <- [0/*swords of light*/]

function AddPlayerAttributes()
{
	local ply = activator;
	ply.ValidateScriptScope();
	if(!("hasStats" in ply.GetScriptScope()))
	{
 		//player doesn't have variables, initialize them
 		//**Permanent values per session.
		local scope = ply.GetScriptScope();
		scope.hasStats <- true;// dummy stat, just to check if player has got stats or not.

		//--------------------STATS--------------------------
		scope.level <- 1;
		scope.points <- 0;
		scope.damageModifer <- 1;
		scope.damageResistance <- 1;
		scope.speedModifier <- 1;
		scope.intellect <- 1;
		scope.canLevelUp <- true;
		//---------------------------------------------------
		
		//--------------------Spells-------------------------
		scope.spells <- [];
		scope.zombieSpells <- [];
		scope.canCastSpell <- true;
		//---------------------------------------------------

		//--------------------RESET--------------------------
		//**has to be reset each round.
		//Check Stats
		scope.canCheckSelfStats <- true;
		//Liberary Stuff
		scope.canTakeLiberaryBuff <- true;
		scope.canUnlockBlueSeal <- false;
		scope.canUnlockRedSeal <- false;
		scope.canFixSpeed <- true;
		scope.canBeNuked <- true;
		scope.canResetPoints <- true;
		//---------------------------------------------------

		//item stuff
		scope.hasItem <- false;

		if(MapManager.GetScriptScope().shouldGivePointsToLateJoiners)
			CompensatePoints(ply);
	}
}

function CompensatePoints(player)
{
	// loop through all players and get the highest points + levels amount
	local highestLevel = 0;
	
	local ent = null;
    while ( ent = Entities.FindByClassname(ent, "player"))
    {
		ent.ValidateScriptScope();
		local playerScope = ent.GetScriptScope();
		if(("hasStats" in playerScope))
		{
			local total = playerScope.points + playerScope.level;
			if(total > highestLevel)
				highestLevel = total;
		}
    }
	
	// give the player the third floor of that value
	local pointsToCompensate = floor(highestLevel / 3);
	player.ValidateScriptScope();
	player.GetScriptScope().points = pointsToCompensate;
	printl(pointsToCompensate)
}

function OnPostSpawn()
{	
	local ply = null;
	while(ply = Entities.FindByClassname(ply, "player"))
	{
		ply.ValidateScriptScope();
		if(("hasStats" in ply.GetScriptScope()))
		{
			//reset some of the player's stats if the player already took them.

			local ply_scope = ply.GetScriptScope();
			ply_scope.canCheckSelfStats = true;
			ply_scope.canTakeLiberaryBuff = true;
			ply_scope.canUnlockBlueSeal = false;
			ply_scope.canUnlockRedSeal = false;
			ply_scope.canCastSpell = true;
			ply_scope.hasItem = false;
			ply_scope.canFixSpeed = true;
			ply_scope.canBeNuked = true;
			ply_scope.canLevelUp = true;

			EntFireByHandle(self, "RunScriptCode", "FixSpeed()", 0.05, ply, null);
			EntFireByHandle(self, "RunScriptCode", "FixSpeed()", 2.00, ply, null);
			EntFireByHandle(self, "RunScriptCode", "FixSpeed()", 5.00, ply, null);

			//reinstantiate spells
			if(ply_scope.spells.len() > 0)
			{
				foreach(_spell in ::HumanSpells){
					for(local i = 0; i < ply_scope.spells.len();i++){
						if(ply_scope.spells[i].spellName == _spell[0]){
							ply_scope.spells[i].maker = _spell[1]
							break;
						}
					}
				}
			}
			if(ply_scope.zombieSpells.len() > 0)
			{
				foreach(_spell in ::ZombieSpells){
					for(local i = 0; i < ply_scope.zombieSpells.len();i++){
						if(ply_scope.zombieSpells[i].spellName == _spell[0]){
							ply_scope.zombieSpells[i].maker = _spell[1]
							break;
						}
					}
				}
			}
		}
	}
}

function DamagePlayer(damage)
{
	activator.ValidateScriptScope()
	local resistanceModifierAttribute = activator.GetScriptScope().damageResistance;
	//activator.SetHealth(activator.GetHealth() - damage * resistanceModifierAttribute);


	PointHurtTemplate.SpawnEntityAtEntityOrigin(activator);
	local thisPlayerPointHurt = Entities.FindByClassnameWithin(null,"point_hurt",activator.GetOrigin(),5);
	thisPlayerPointHurt.__KeyValueFromInt("Damage", damage * resistanceModifierAttribute);
	EntFireByHandle(thisPlayerPointHurt,"Hurt","",0.05,activator,null);
	EntFireByHandle(thisPlayerPointHurt,"Kill","",0.06,null,null);
}



function PrintAttributes()
{
	local damageModifierAttribute = activator.GetScriptScope().damageModifer;
	local resistanceModifierAttribute = activator.GetScriptScope().damageResistance;
	printl(activator.GetName()+ " has damage modifier of " +damageModifierAttribute + " and damage resistance of " + resistanceModifierAttribute);
}


//Upgrade Functions

function PowerupResistance(value)
{
	activator.ValidateScriptScope()
	activator.GetScriptScope().damageResistance -= value;
}

function PowerupDamage(value)
{
	activator.ValidateScriptScope()
	activator.GetScriptScope().damageModifer += value;
}

function PowerupSpeed(value)
{
	activator.ValidateScriptScope()
	activator.GetScriptScope().speedModifier += value;

	local speedModifierAttribute = activator.GetScriptScope().speedModifier;
	EntFireByHandle(SpeedModifierEntity,"ModifySpeed"," "+speedModifierAttribute.tostring(),0.05,activator,null);
}
function PowerupIntellect(value)
{
	activator.ValidateScriptScope()
	activator.GetScriptScope().intellect += value;
}


function ChangeSpeed(value=1)
{
	activator.ValidateScriptScope()
	local scope = activator.GetScriptScope()
	local speedModifierAttribute = scope.speedModifier;

	EntFireByHandle(SpeedModifierEntity,"ModifySpeed"," "+(speedModifierAttribute * value).tostring(),0.05,activator,null);
	scope.canLevelUp = false;
	scope.canFixSpeed = false;
	scope.canResetPoints = false;

}

function FixSpeed()
{
	activator.ValidateScriptScope()
	local scope = activator.GetScriptScope()
	local speedModifierAttribute = scope.speedModifier;
	EntFireByHandle(SpeedModifierEntity,"ModifySpeed"," "+speedModifierAttribute.tostring(),0.05,activator,null);

	scope.canLevelUp = true;
	scope.canFixSpeed = true;
	scope.canResetPoints = true;
}

function RemoveAbilityToFixSpeed()
{
	activator.ValidateScriptScope()
	activator.GetScriptScope().canFixSpeed = false;
}

function MakeAliveHumansSafe()
{
	local saferoomDestination = Entities.FindByName(null, "saferoom_destination")
	local ent = null;
	while ( ent = Entities.FindByClassname(ent, "player") )
	{
		if(ent.GetTeam() == 3)
		{
			// tp to save room
			ent.SetOrigin(saferoomDestination.GetOrigin());
		}

	}
}

AttributesTextTemplate <- Entities.FindByName(null,"attributes_text_spawner");

enum ENCOUNTERS {
    easy = 1,
    medium = 2,
    hard = 3,
	escape = 4,
	crystalKeeper = 5,
	cerberus = 6,
	flameKeeper = 7,
	bladeKeeper = 8
};

function EncounterComplete(difficulty = ENCOUNTERS.easy)
{
	// play encounter complete sound

	local ply = null;
	
	EntFire("sfx_encounter_complete", "PlaySound", null, 0.1, null);
	while ( ply = Entities.FindByClassname(ply, "player") )
	{
		ply.ValidateScriptScope()

		if((ply.GetTeam() == 3 || ply.GetTeam() == 2) && "hasStats" in ply.GetScriptScope())
		{
			local thisPlayerTempText = Entities.CreateByClassname("game_text")

			// Apply settings
			thisPlayerTempText.__KeyValueFromInt("x", -1);
			thisPlayerTempText.__KeyValueFromFloat("y", 0.2);
			thisPlayerTempText.__KeyValueFromVector("color", Vector(0,128,192));
			thisPlayerTempText.__KeyValueFromVector("color2", Vector(0,128,192));
			thisPlayerTempText.__KeyValueFromInt("holdtime", 7)
			//-----------------
			
			if(ply.GetTeam() == 2){
				thisPlayerTempText.__KeyValueFromVector("color", Vector(255,0,0));
				thisPlayerTempText.__KeyValueFromVector("color2", Vector(255,0,0));
			}
			
			thisPlayerTempText.__KeyValueFromInt("x", -1);
			thisPlayerTempText.__KeyValueFromFloat("y", 0.2);
			local lootString = AwardPlayer(ply, difficulty);

			thisPlayerTempText.__KeyValueFromString("message", 
													"<---Encounter Complete--->"+
													"\n"+
													"\n"+
													"++ Loot: "+
													"\n"+
													"\n"+
													lootString)

			EntFireByHandle(thisPlayerTempText,"Display","",0.05,ply,null);
			EntFireByHandle(thisPlayerTempText,"Kill","",7.05,null,null);
		}
	}
}

function AwardPlayer(player, difficulty)
{
	local loot = ""
	player.ValidateScriptScope()
	local scope = player.GetScriptScope();
	SpellsManager.ValidateScriptScope()
	local spellsScope = SpellsManager.GetScriptScope();

	// reward atleast 1 point
	local luckyNum = RandomInt(1, 10);
	local earnedPoints = null;
	if(luckyNum == 10 || difficulty == ENCOUNTERS.bladeKeeper || difficulty == ENCOUNTERS.flameKeeper || difficulty == ENCOUNTERS.crystalKeeper){
		earnedPoints = 2;
	}
	else{
		earnedPoints = 1;
	}

	scope.points += earnedPoints;
	// reward a spell based on the difficulty || maybe other things.
	local spellsLooted = "Spells:\n\n";

	//any encounter reward
	if( player.GetTeam() == 3 )
	{
		local luckyNum2 = RandomInt(1,10)
		if(luckyNum2 == 10)
		{
			local spellToReward = humanHealBasedDrops[RandomInt(0, humanHealBasedDrops.len()-1)]
			EntFireByHandle(SpellsManager,"RunScriptCode","PickupSpell("+spellToReward.tostring()+")",0.0,player,null);
			spellsLooted += "++"+spellsScope.GetSpellName(spellToReward, player.GetTeam())+"\n\n"
		}
	}



	//bladekeeper specific
	if(difficulty == ENCOUNTERS.bladeKeeper && player.GetTeam() == 3)
	{
		local luckyNum3 = RandomInt(1,10)
		if(luckyNum3 == 10)
		{
			local spellToReward = bladekeeperDrops[RandomInt(0, bladekeeperDrops.len()-1)]
			EntFireByHandle(SpellsManager,"RunScriptCode","PickupSpell("+spellToReward.tostring()+")",0.0,player,null);
			spellsLooted += "++"+spellsScope.GetSpellName(spellToReward, player.GetTeam())+"\n\n"
		}
	}

	if(spellsLooted == "Spells:\n\n")
		spellsLooted = "Spells:\n\nNone"

	loot += " + "+earnedPoints.tostring()+"Point(s)\n\n"+spellsLooted
	return loot;
}

function ResetPlayerStats()
{
	local scope = activator.GetScriptScope()

	if(!scope.canResetPoints)
		return;

	scope.canLevelUp = false;

	scope.points += scope.level;
	scope.level = 1;

	scope.damageModifer = 1;
	scope.damageResistance = 1;
	scope.speedModifier = 1;
	scope.intellect = 1;

	EntFireByHandle(self,"RunScriptCode","FixSpeed()",0.0,activator,null);
	scope.canLevelUp = true;
}


function ShowMapCommandsToAll(timeToKill=19)
{
	local gameTextEnt = Entities.FindByName(null, "MapCommandsText")
	// apply settings
	gameTextEnt.__KeyValueFromFloat("x", 0.07)
	gameTextEnt.__KeyValueFromFloat("y", 0.5)
	gameTextEnt.__KeyValueFromFloat("holdtime", timeToKill)
	// write message
	local message = "Map Commands: \n\n"+
					"!mystats    		 ->    Show your stats.\n"+
					"!levelup stat_name  ->    Upgrade this stat.\n"+
					"!statsinfo          ->    Show all information related to stats.\n"+
					"!myspells           ->    Show all spells and abilites you have.\n"+
					"!cast spell_name    ->    Use the specified spell/ability.\n"+
					"!fixspeed           ->    Reset your player's speed.\n"+
					"!resetpoints        ->    Reset your points usage.\n";
	gameTextEnt.__KeyValueFromString("message",message)
	// display the text
	EntFireByHandle(gameTextEnt,"Display","",0.05,null,null);
	// kill the entity
	EntFireByHandle(gameTextEnt,"Kill","",timeToKill,null,null);
}