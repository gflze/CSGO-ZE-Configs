# ZE-Configs

A collection of entWatch, stripper and BossHud configs for GFL CS:GO ZE, please be aware that the entWatch and stripper configs are not an extensive list of everything used on our server.

# How to Contribute

For making any of these configs, you'll want a tool like [VIDE](http://www.riintouge.com/VIDE/)'s entity lump editor, or [entSpy](http://www.bagthorpe.org/bob/cofrdrbob/entspy.html) to navigate the entities in a map. You can also compare maps with current configs in this repository and see how it has already been done if you're looking for functional examples of things.

**_IMPORTANT:_** Make sure the filename of the config matches the map name on the server.

## BossHud

Search for **math_counter**, **func_breakable**, **func_physbox** or **func_physbox_multiplayer** entities as a starting point when creating these. For each boss you're going to want a new block, make sure the blocks are numbered correctly if you're copy/pasting them. The format is available below.

```
"math_counter"
{
	"0"
	{
		//math_counter example
		"HP_counter"		""//targetname of the hp math_counter
		"HPbar_counter"		""//targetname of the math_counter that handles a hp bar (if applicable)
		"HPinit_counter"	""//targetname of the math_counter that inits the hp math_counter (if applicable)
		"CustomText"		""//custom name to show in the hud
		"HPbar_min"			""//min value of the math_counter that handles a hp bar (if applicable)
		"HPbar_max"			""//max value of the math_counter that handles a hp bar (if applicable)
		"HPbar_default"		""//startvalue of the hpbar math_counter (if applicable)
		"HPbar_mode"		""//which mode the hpbar math_counter runs on, 1=OnHitMin outputs 2=OnHitMax outputs (if applicable)
	}
	"1"
	{
		//func_breakable, func_physbox or func_physbox_multiplayer example
		"Type"				"breakable"
		"BreakableName"		""//targetname of the func_breakable, func_physbox or func_physbox_multiplayer
		"CustomText"		""//custom name to show in the hud
	}
}
```

## Stripper

Stripper is quite a complicated beast and unfortunately a single template is not really going to help you too much. If you're looking for a good starting point to learn Stripper, you can check the plugins page [here](http://www.bailopan.net/stripper/) which goes over the file format and block types available to you. If you have any questions regarding stripper creation you can always join our [#mapping channel](https://discord.gg/zh2CVSM) on Discord for assistance.

## entWatch

Find entity classnames that start with "weapon_" as a starting point for creating these. For each item you're going to want a new block, make sure the blocks are numbered correctly if you're copy/pasting them. The format is available below.

```
"entities"
{
    "0"
    {
        "name"              ""//name of the item to show in chat
        "shortname"         ""//name of the item to show in scoreboard
        "color"             ""//colour to use in chat (refer to the colour list below)
        "buttonclass"       "func_button"//leave as is
        "filtername"        ""//targetname of the filter (if applicable, see below)
        "hasfiltername"     ""//true if the item uses a filter entity to check the user, false otherwise
        "blockpickup"       "false"//always false
        "allowtransfer"     ""//true for human items, false for zm items
        "forcedrop"         ""//true for human items, false for zm items
        "chat"              "true"//always true
        "hud"               "true"//always true
        "hammerid"          ""//hammerid of the weapon_ entity for the item
        "mode"              ""//1 = spam protection only, 2 = cooldown, 3 = limited uses, 4 = limited uses with cooldown, 5 = cooldown that only gets triggered after all maxuses are used
        "maxuses"           ""//max uses of the item (if applicable)
        "cooldown"          ""//cooldown of the item (if applicable)
        "maxamount"         ""//how many instances of this item can exist
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