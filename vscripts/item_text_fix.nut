text_welcome <- Entities.FindByName(null,"text_welcome");
text_ammo <- Entities.FindByName(null,"text_ammo");
text_fire <- Entities.FindByName(null,"text_fire");
text_ballista <- Entities.FindByName(null,"text_ballista");
text_crystal <- Entities.FindByName(null,"text_crystal");
text_heal <- Entities.FindByName(null,"text_heal");
text_bible <- Entities.FindByName(null,"text_bible");
text_venom <- Entities.FindByName(null,"text_venom");
text_grav <- Entities.FindByName(null,"text_grav");
text_tornado <- Entities.FindByName(null,"text_tornado");
text_sacred <- Entities.FindByName(null,"text_sacred");

function Precache()
{
	text_welcome.__KeyValueFromString("message", "ZE Tyranny - Part 2\nMap created by Moray and Nano\n-----------\n5 Stages so far\n5 extremes modes will be added in a future");
	text_ammo.__KeyValueFromString("message", "Item: Ammo\nDescription: Static radius of infinite ammo\nCooldown: 60 seconds\nDuration: 10 seconds");
	text_fire.__KeyValueFromString("message", "Item: Meteor\nDescription: It will set zombies on fire (+Big damage)\nCooldown: 50 seconds");
	text_ballista.__KeyValueFromString("message", "Item: Ballista\nDescription: Throw multiple arrows with effects\nTIP: There are multiple powers that you can choose\nCooldown: 60 seconds\nDuration: Long");
	text_crystal.__KeyValueFromString("message", "Item: Crystal\nDescription: (Ice) Freeze zombies - (Electro) Then hurt them\nTIP: Two effects in the same item\nCooldown: 75 seconds");
	text_heal.__KeyValueFromString("message", "Item: Heal\nDescription: Heal humans in a big radius\nTIP: It doesn't give immunity against zombies\nCooldown: 60 seconds\nDuration: 8 seconds");
	text_bible.__KeyValueFromString("message", "Item: Bible\nDescription: It gives immunity against zombies\nCooldown: 70 seconds\nDuration: 8 seconds");
	text_venom.__KeyValueFromString("message", "Item: Venom\nDescription: Slow down zombies\nTIP: The effect will follow your crosshair\nTIP 2: You can look up and down while you are using it\nCooldown: 60 seconds\nDuration: 8 seconds");
	text_grav.__KeyValueFromString("message", "Item: Shade\nDescription: Pull zombies\nTIP: Teleport zombies back in the last 2 seconds\nCooldown: 60 seconds\nDuration: 8 seconds of gravity | 2 seconds of teleport\nMax uses: 2");
	text_tornado.__KeyValueFromString("message", "Item: Tornado\nDescription: Push zombies away\nCooldown: 60 seconds\nDuration: 8 seconds");
	text_sacred.__KeyValueFromString("message", "Item: Sacred\nDescription: Kill all zombies inside of the effect\nDuration: 10 seconds\nCooldown: 60 seconds\nMax uses: 2");
}
