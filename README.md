# GFLClan CS:GO ZE Configs

| Sync Status |
|:-----------:|
| [![Sync Files To CS:GO Server](https://github.com/gflze/ZE-Configs/actions/workflows/ci-master-main.yml/badge.svg)](https://github.com/gflze/ZE-Configs/actions) |


A collection of the BossHud, entWatch, SaveLevel, MusicName and stripper configs used on GFL's CS:GO ZE server, please be aware that [some private configs](https://github.com/gflze/ZE-Configs/blob/master/.gitignore#L1) are not included in this repository.

Everything in this repository is auto-synced to our CS:GO server on a new commit/push.

# How to Contribute

For making any of these configs, you'll want a tool like [VIDE](http://www.riintouge.com/VIDE/)'s entity lump editor, or [entSpy](https://gamebanana.com/tools/5876) to navigate the entities in a map. You can also compare maps with current configs in this repository and see how it has already been done if you're looking for functional examples of things.

**_IMPORTANT:_** Make sure the filename of the config matches the map name on the server.

## BossHud

Search for **math_counter**, **func_breakable**, **func_physbox**, **func_physbox_multiplayer**, **prop_physics**, or **prop_dynamic** entities as a starting point when creating these. For each boss you're going to want a new block, make sure the blocks are numbered correctly if you're copy/pasting them. The format is available below.

**__IMPORTANT:__** If you want to make sure you are using the right boss entity, you can use [this plugin](https://github.com/gflze/bhud-debugger) with a test server to find out.

```
"math_counter"
{
	"config" //OPTIONAL
	{
		"HitMarkerOnly"			"" //Only shows HitMarkers + BossDamage Ranking. Useful for maps with built-in BossHud. 1 for enable.
		"BossBeatenShowTopDamage"	"" //Whether to show the top damagers of boss after it dies. 0 to disable.
	}
	"0"
	{
		//math_counter example
		"HP_counter"		"" //targetname of the hp math_counter
		"HPbar_counter"		"" //targetname of the math_counter that handles a hp bar (if applicable)
		"HPinit_counter"	"" //targetname of the math_counter that inits the hp math_counter (if applicable)
		"CustomText"		"" //custom name to show in the hud
		"HPbar_min"		"" //min value of the math_counter that handles a hp bar (if applicable)
		"HPbar_max"		"" //max value of the math_counter that handles a hp bar (if applicable)
		"HPbar_default"		"" //startvalue of the hpbar math_counter (if applicable)
		"HPbar_mode"		"" //which mode the hpbar math_counter runs on, 1=OnHitMin outputs 2=OnHitMax outputs (if applicable)
	}
	"1"
	{
		//other entities example
		"Type"			"breakable"
		"BreakableName"		"" //targetname of the func_breakable, func_physbox or func_physbox_multiplayer
		"CustomText"		"" //custom name to show in the hud
	}
}
```

## entWatch

Find entity classnames that start with "weapon_" as a starting point for creating these. For each item you're going to want a new block, make sure the blocks are numbered correctly if you're copy/pasting them. The format is available below.

```
"entities"
{
    "0"
    {
        "name"              "" //name of the item to show in chat
        "shortname"         "" //name of the item to show in scoreboard
        "color"             "" //colour to use in chat (refer to the colour list below)
        "buttonclass"       "" //what classname the button entity uses, usually just func_button
        "filtername"        "" //filtername that the items filter entity uses (if applicable, see below)
        "hasfiltername"     "" //true if the item uses a filter entity to check the user, false otherwise
        "blockpickup"       "" //always false
        "allowtransfer"     "" //true for pistol items, false for knife items
        "forcedrop"         "" //true for pistol items, false for knife items
        "chat"              "" //always true
        "hud"               "" //always true
        "hammerid"          "" //hammerid of the weapon_ entity for the item
        "buttonid"          "" //OPTIONAL: hammerid of the button, only necessary when auto detection fails
        "mathid"            "" //OPTIONAL: hammerid of the math_counter. Only available for modes 6 & 7
        "mode"              "" //0 = nothing 1 = spam protection only, 2 = cooldown, 3 = limited uses, 4 = limited uses with cooldown, 5 = cooldown that only gets triggered after all maxuses are used, 6 = math_counter - stops when minimum reached, 7 = math_counter-  stops when maximum reached
        "maxuses"           "" //max uses of the item (if applicable)
        "cooldown"          "" //cooldown of the item (if applicable)
        "maxamount"         "" //how many instances of this item can exist
        "physbox"           "" //OPTIONAL: "true" if this item is a physbox so it would allow bullets/knife to shoot/knife through. If it's false, dont bother adding this line.
        "trigger"           "" //OPTIONAL: hammerid of the trigger that gives a player the item if one exists
    }
}
```

### entWatch Colour List

```
{default}
{darkred}
{pink}
{green}
{lightgreen}
{lime}
{red}
{grey}
{olive}
{lightblue}
{blue}
{purple}
{darkorange}
{orange}
```

## SaveLevel

The SaveLevel plugin is unlike the other configs in this repository in that it uses datamaps. A full list of datamaps can be found by using "sm_dump_datamaps datamaps.txt" in your own server with SourceMod installed or you can view [Mapeadores's datamap dump](https://github.com/Mapeadores/CSGO-Dumps/blob/master/datamaps.txt) (This may or may not be up to date depending on when you access their dump).

The datamaps most commonly used for SaveLevel will generally be the following:
```
m_iFrags     - The number of kills a player has
m_iName      - The targetname of an entity
m_OnUser#    - An OnUser# output attached to an entity. Ranges from m_OnUser1 to m_OnUser4.
```

The general template of a SaveLevel config will be as follows:

ze_map_name.cfg
```
"levels"
{
    "0" //Number of the level, starting at 0 and increasing by 1 per level. In general level 0 should be set to as if it were a newly joined player with no levels.
    {
        "name" ""     //The name of the level to be used with the sm_level command. Typically Level 0, Level 1, Level 2, etc.
        "match"       //Block used to detect which level a player is. If this is the default/unset level, this block is unneeded.
        {
            //Use only 1 of outputs, math, or props in a match block. The set one determines which method is used to check entities for the level.
            "math"       //Matches an output's number parameter on an add or subtract input.
            {
                "" ""    //Datamap to check. Typically used with m_OnUser# (ie. "m_OnUser1" "leveling_counter,Add,1" would check against a 1 there).
            }
            "props"      //Matches a networked property of an entity.
            {
                "" ""    //Datamap to check. Typically used with m_iName. (ie. "m_iName" "1" checks for a targetname of 1)
            }
            "outputs"    //Matches an output. Typically use math or props instead of outputs if possible.
            {
                "" ""    //Datamap to check. May use any output datamap.
            }
        }
        "restore"     //Block used to set datamaps, add outputs, and/or delete outputs upon level restoration (client reconnect or sm_level usage). Only use 1 restore block per level, but you may use multiple output additions, deletions, or datamap changes in the block.
        {
            "AddOutput" ""       //Used to add an output on an entity. Works in roughly the same way AddOutput works in hammer. Have the second parameter in the format of "Output target,input,input parameter,delay,max refires" (input parameter may be blank, but keep its comma if it is)
            "DeleteOutput" ""    //Used to remove an output from an entity. Typically only use for the default/unset level of the map. Have the second parameter in the format of "Output_datamap target,input,input parameter". The target, input, and input parameter may be unset from right to left (ie. if input parameter is set, input must be set as well, but not vice versa) (if they are unset, do not include the comma right before them). If not all of them are set, it will delete ALL outputs that match what is set (ie. "m_OnUser4 score10,ApplyScore" would delete ALL OnUser4 outputs that target score10 with the ApplyScore input) (ie. "m_OnUser1 leveling_counter" would delete ALL OnUser1 outputs that target leveling_counter entity)
            "" ""                //Datamap to set. First parameter is the datamap, second is the value for it (ie. "m_iName" "1" or "m_iFrags" "100"). Do not use this method for output datamaps as they can have multiples under the same datamap.
        }
    }
}
```

## MusicNames

Use the file name or file path of the music with their respective music name and add it as a keyvalue to the config.

**Note:** You can specify only the file name to identify the music. However, if there are two files of the same name in different directories, you **must** specify the full path to differentiate between the two. See the example in the template below.

The general template of a MusicName config will be as follows:

ze_map_name.cfg
```
"music"
{
    "key1"      "value1"        //key1 will be the filename or file path. value1 will be the actual music name that will be shown when using !nowplaying etc.

    // Examples
    "rick_roll.mp3"                 "Rick Astley - Never Gonna Give You Up"
    "pendulum.mp3"                  "Pendulum - Tarantula"

    // Two files of the same name in different directories
    "sound/folder1/music.mp3"       "Pendulum - Blood Sugar"
    "sound/folder2/music.mp3"       "Queen – Bohemian Rhapsody"
}
```

## Stripper

**WARNING: Filenames for Stripper configs must be all lower case!**

Stripper is quite a complicated beast and unfortunately a single template is not really going to help you too much. If you're looking for a good starting point to learn Stripper, you can check out [this tutorial](https://gflclan.com/forums/topic/47449-stripper-cfgs-guide/). If you have any questions regarding stripper creation, you can always join our [#mapping channel](https://discord.gg/zh2CVSM) on Discord for assistance.

## VScripts

Loose VScripts are always directly tied to an existing stripper config, and are similar in that a template will not help you. However you can use the [Squirrel Reference Manual](http://www.squirrel-lang.org/squirreldoc/stdlib/index.html) for language syntax, and this [Valve wiki article](https://developer.valvesoftware.com/wiki/List_of_Counter-Strike:_Global_Offensive_Script_Functions) for CS:GO specific functions.

For the auto-sync to work properly on these files, all external VScripts must be referred to by stripper configs as "gfl/scriptname.nut". In absolute path, these scripts are located at "csgo/scripts/vscripts/gfl/scriptname.nut".

## ZombieReloaded Configs

These are basic CS:GO config files containing cvars/commands that get executed on map start by ZR. mapname.cfg is executed [OnAutoConfigsBuffered()](https://sourcemod.dev/#/sourcemod/function.OnAutoConfigsBuffered), mapname.post.cfg is executed [OnConfigsExecuted()](https://sourcemod.dev/#/sourcemod/function.OnConfigsExecuted).

Some common GFL plugin cvars that you may want to adjust are listed below with their functionalities.
```
mce_extend			//Number of extends for the map
sm_thirdperson_enabled 0	//Disables third person for the map
triggerpushlagfix_enable 0	//Disables the trigger_push lag fix, some maps don't play well with it
zr_antiboost_enabled 0		//Disables the antiboost functionality that certain weapons have
zr_infect_mzombie_ratio		//Every n-th player is infected as a mother zombie
zr_infect_mzombie_respawn 0	//Enables classic spawn for the map
zr_infect_spawntime_max		//Maximum range in seconds for mother zombie infection countdown
zr_infect_spawntime_min		//Minimum range in seconds for mother zombie infection countdown
zr_restrict			//Restrict a weapon or weapon group
```