//Intended use of Heal game_text fix on ze_alien_shooter_gp1_3 GFL Stripper
//Fix a incorrect message on heal game_text when picking up heal
//Install as csgo/scripts/vscripts/gfl/game_text_fix.nut

function InitGameTexts(){

	theGameText <- Entities.FindByName(null,"Item_Bio_text")
	if (theGameText != null)
	{
		TextOfTheMessage <- "Item: Bio" +
		  "\nEffect: Freezes Zombies" +
		  "\nDuration: 6 seconds" +
		  "\nCooldown: 50 seconds"
		
		theGameText.__KeyValueFromString("message", TextOfTheMessage) 
	}
	
	theGameText <- null
	TextOfTheMessage <- null

	theGameText <- Entities.FindByName(null,"Item_Electro_text") 
	if (theGameText != null)
	{
		TextOfTheMessage <- "Item: Electro" +
		  "\nEffect: Deals damage to Zombies" +
		  "\nDuration: 10 seconds" +
		  "\nCooldown: 55 seconds"
		theGameText.__KeyValueFromString("message", TextOfTheMessage)
	}

	theGameText <- null
	TextOfTheMessage <- null

	theGameText <- Entities.FindByName(null,"Item_Fire_text") 
	if (theGameText != null)
	{
		TextOfTheMessage <- "Item: Fire" +
		  "\nEffect: Deals damage to Zombies and sets fire to them" +
		  "\nDuration: 9 seconds" +
		  "\nCooldown: 50 seconds"
		theGameText.__KeyValueFromString("message", TextOfTheMessage)
	}

	theGameText <- null
	TextOfTheMessage <- null

	theGameText <- Entities.FindByName(null,"Item_Heal_text") 
	if (theGameText != null)
	{
		TextOfTheMessage <- "Item: Heal" +
		  "\nEffect: Gives 250 hp and protects against Zombies" +
		  "\nDuration: 6 seconds" +
		  "\nCooldown: 50 seconds"
		theGameText.__KeyValueFromString("message", TextOfTheMessage)
	}

	theGameText <- null
	TextOfTheMessage <- null

	theGameText <- Entities.FindByName(null,"Item_Wind_text") 
	if (theGameText != null)
	{
		TextOfTheMessage <- "Item: Wind" +
		  "\nEffect: Push the Zombies" +
		  "\nDuration: 7 seconds" +
		  "\nCooldown: 50 seconds"
		theGameText.__KeyValueFromString("message", TextOfTheMessage)
	}

	theGameText <- null
	TextOfTheMessage <- null
}
