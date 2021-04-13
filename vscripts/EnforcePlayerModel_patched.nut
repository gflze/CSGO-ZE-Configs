//intended for use with the ze_space_flight_p3 GFL stripper
//removes custom human models
//install as csgo/scripts/vscripts/gfl/EnforcePlayerModel_patched.nut

function CheckForMotherZombieSpawn() {
    zombie <- null

    // Try to find the mother zombie
    while(zombie = Entities.FindByClassname(zombie, "player")){

        // If a terrorist with over 600hp is found (mother zombie), exit and stop checking
        if(zombie.GetTeam() == 2 && zombie.GetHealth() > 600){
            EntFire("MZMTimer", "FireUser1", "", 0.0, null)
            return
        }
    }
}