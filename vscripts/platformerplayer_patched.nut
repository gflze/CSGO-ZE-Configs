//#####################################################################
//Patched version intended for use with GFL ze_platformer_b6 stripper
//Removes HTML formatting broken after Shattered Web Update.
//Install as csgo/scripts/vscripts/Cuniczek/platformer/platformerplayer_patched.nut
//#####################################################################

Coins <- 0
Test <- null
Name <- "Playerbank_" + UniqueString()
Maker <- null
Maker <- Entities.FindByName(Maker, "bank_maker")
Duration <- 0
self.__KeyValueFromString("targetname", Name)

function SetName(){
self.__KeyValueFromString("targetname", Name)
}

function SpawnSprite(){
self.__KeyValueFromString("targetname", Name)
self.SetAngles(0,0,0)
EntFire("bank_template", "forcespawn", "", 0.0, null)

SpriteName <- self.GetName() + "_sprite"

SetFrame(Coins)
ShowSprite(Duration)
self.SetMaxHealth(Coins)

HideDelay <- 0

printl("Players name: " + self.GetName())
printl("Sprites name: " + SpriteName)
printl("Players origin: " + self.GetOrigin())
printl("Players angles: " + self.GetAngles())
printl("Player " + Name + " has " + Coins + " coins")
}

function SetFrame(n){
Toggle <- null
Toggle = Entities.CreateByClassname("env_texturetoggle")
Toggle.__KeyValueFromString("target", SpriteName)

n += ""

EntFireByHandle(Toggle,"SetTextureIndex",n,0.0,null,null)
Toggle.Destroy()
}

function PlayerCoins(n){
Coins += n
if (Coins > 100){Coins = 100}
if (Coins < 0){Coins = 0}
printl("Player " + Name + " has " + Coins + " coins")

SetFrame(Coins)
ShowSprite(Duration)
self.SetMaxHealth(Coins)
}

function GiveAlivePlayersCoins(n){
if (self.GetHealth() > 0){PlayerCoins(n)}
}

function ShowSprite(n){
EntFire(SpriteName,"ShowSprite","",0.0,null)
if (n > 0){HideDelay += 1; EntFireByHandle(self, "RunScriptCode", "HideSpriteWithDelay()", n, null, null)}
}

function HideSpriteWithDelay(){
HideDelay -= 1
if (HideDelay == 0) {EntFire(SpriteName,"HideSprite","",0.0,null)}
}

function HideSprite(){
EntFire(SpriteName,"HideSprite","",0.0,null)
}

function CheckAlive(){
local dead
if (self.GetHealth() <= 0){HideSprite(); dead = true}
if (dead == true && self.GetHealth() > 0){ShowSprite(Duration); dead = false}
}

UnlockRocket 		<- false
UnlockLadder 		<- false
UnlockZbuilder		<- false
UnlockMine 			<- false

UnlockPushgun 		<- false
UnlockFlame 		<- false
UnlockBuilder		<- false
UnlockTrampoline 	<- false
UnlockJetpack 		<- false
UnlockCoingun 		<- false

ItemsText 	<- "Your unlocked items: "

function CheckUnlock(typ,telex,teley,telez){
if (typ == 1 && UnlockRocket == false)		{RelativeTeleport(telex,teley,telez);Message("You have not purchased this item")}
if (typ == 2 && UnlockLadder == false)		{RelativeTeleport(telex,teley,telez);Message("You have not purchased this item")}
if (typ == 3 && UnlockZbuilder == false)	{RelativeTeleport(telex,teley,telez);Message("You have not purchased this item")}
if (typ == 4 && UnlockMine == false)		{RelativeTeleport(telex,teley,telez);Message("You have not purchased this item")}
if (typ == 5 && UnlockPushgun == false)		{RelativeTeleport(telex,teley,telez);Message("You have not purchased this item")}
if (typ == 6 && UnlockFlame == false)		{RelativeTeleport(telex,teley,telez);Message("You have not purchased this item")}
if (typ == 7 && UnlockBuilder == false)		{RelativeTeleport(telex,teley,telez);Message("You have not purchased this item")}
if (typ == 8 && UnlockTrampoline == false)	{RelativeTeleport(telex,teley,telez);Message("You have not purchased this item")}
if (typ == 9 && UnlockJetpack == false)		{RelativeTeleport(telex,teley,telez);Message("You have not purchased this item")}
if (typ == 10 && UnlockCoingun == false)	{RelativeTeleport(telex,teley,telez);Message("You have not purchased this item")}
}

function CheckUnlockButton(typ){
if (typ == 1) {if (UnlockRocket == false && Coins >= 15){
			UnlockRocket = true; PlayerCoins(-15);Message("You have unlocked RocketLauncher");ItemsText += "Rocket ";PlaySound(1)}		else {Message("You don't have enough coins or you already have this item</b>")}}
if (typ == 2) {if (UnlockLadder == false && Coins >= 7){
			UnlockLadder = true; PlayerCoins(-7);Message("You have unlocked Ladder");ItemsText += "Ladder ";PlaySound(1)}				else {Message("You don't have enough coins or you already have this item")}}
if (typ == 3) {if (UnlockZbuilder == false && Coins >= 7){
			UnlockZbuilder = true; PlayerCoins(-7);Message("You have unlocked ZM Builder");ItemsText += "zmBuilder ";PlaySound(1)}		else {Message("You don't have enough coins or you already have this item")}}
if (typ == 4) {if (UnlockMine == false && Coins >= 4){
			UnlockMine = true; PlayerCoins(-4);Message("You have unlocked Mine");ItemsText += "Mine ";PlaySound(1)} 						else {Message("You don't have enough coins or you already have this item")}}
if (typ == 5) {if (UnlockPushgun == false && Coins >= 5){
			UnlockPushgun = true; PlayerCoins(-5);Message("You have unlocked Push Gun");ItemsText += "Push ";PlaySound(1)} 				else {Message("You don't have enough coins or you already have this item")}}
if (typ == 6) {if (UnlockFlame == false && Coins >= 5){
			UnlockFlame = true; PlayerCoins(-5);Message("You have unlocked Flamethrower");ItemsText += "Flame ";PlaySound(1)} 			else {Message("You don't have enough coins or you already have this item")}}
if (typ == 7) {if (UnlockBuilder == false && Coins >= 5){
			UnlockBuilder = true; PlayerCoins(-5);Message("You have unlocked CT Builder");ItemsText += "ctBuilder ";PlaySound(1)} 		else {Message("You don't have enough coins or you already have this item")}}
if (typ == 8) {if (UnlockTrampoline == false && Coins >= 10){
			UnlockTrampoline = true; PlayerCoins(-10);Message("You have unlocked Trampoline");ItemsText += "Trampoline ";PlaySound(1)}	else {Message("You don't have enough coins or you already have this item")}}
if (typ == 9) {if (UnlockJetpack == false && Coins >= 25){
			UnlockJetpack = true; PlayerCoins(-25);Message("You have unlocked Jetpack");ItemsText += "Jetpack ";PlaySound(1)}			else {Message("You don't have enough coins or you already have this item")}}
if (typ == 10) {if (UnlockCoingun == false && Coins >= 30){
			UnlockCoingun = true; PlayerCoins(-30);Message("You have unlocked Coin Gun");ItemsText += "Coingun ";PlaySound(1)} 			else {Message("You don't have enough coins or you already have this item")}}
}

function PlaySound(s){
if (s == 1){self.PrecacheSoundScript("cuniczek/coin.mp3");self.EmitSound("cuniczek/coin.mp3");}
}

function RelativeTeleport(telex,teley,telez){
self.SetOrigin(self.GetOrigin() + Vector(telex,teley,telez))
}

function Message(msg){
Hud <- null
HudName <- null
Output <- null
Output1 <- null

Hud = Entities.CreateByClassname("env_hudhint")
Hud.__KeyValueFromString("message", msg)
HudName = Name + "_hud"
Hud.__KeyValueFromString("targetname", HudName)

EntFire(HudName,"ShowHudHint","",0.01,null)
EntFire(HudName,"Kill","",0.01,null)
}