// *********** include vs_library stuff
IncludeScript("ze_cruelty_squad/vs_library");
IncludeScript("ze_cruelty_squad/vs_math");

// *********** mother zombie timer
::ct_models<-true;

// *********** sfx 
::night_creep_pain<-"cruelty_squad/noises/night_creep_pain_1.mp3";

::russian_sfx_counter<-0;

::sh2_sfx<-{
    [0] = "silent_hill/silent_hill_2_room_c2_crash.mp3",
    [1] = "silent_hill/silent_hill_2_whisper.mp3",
    [2] = "silent_hill/silent_hill_2_hangman.mp3",
    [3] = "silent_hill/silent_hill_2_elevator_breath.mp3",
    [4] = "silent_hill/silent_hill_2_lakeview_hotel_sobbing.mp3",
    [5] = "silent_hill/silent_hill_2_hallway_running.mp3",  
    [6] = "silent_hill/silent_hill_2_bathroom_crash.mp3",
    [7] = "silent_hill/silent_hill_2_chainsaw_battle.mp3"
}

::sh2_sfx_freak<-{
    [0] = "silent_hill/silent_hill_2_0719.mp3",
    [1] = "silent_hill/silent_hill_2_0476.mp3",
    [2] = "silent_hill/silent_hill_2_0283.mp3",
    [3] = "silent_hill/silent_hill_2_0767.mp3"
}

::sfx_index<--1;

::spinner<--1;

// *********** queue a random sfx from the russian sfx array
function russian_sfx(){
    if(russian_sfx_counter>russian_sounds.len()-1){
        russian_sfx_counter=0;
    }
    Entities.FindByName(null, "sfx_russian").__KeyValueFromString("message", russian_sounds[russian_sfx_counter]);  
    Entities.FindByName(null, "sfx_russian").__KeyValueFromInt("pitch", RandomInt(1,255));   
    EntFire("sfx_russian", "PlaySound", "", RandomInt(0,1500), "");    
    russian_sfx_counter++;
}

// *********** play random sound on trigger in the spawn hallways
function hallway_ambience(){
    if (!activator) return false;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (activator == player){  
            if (sfx_index<0 || sfx_index>sh2_sfx.len()-1){
                sfx_index=RandomInt(0, sh2_sfx.len()-1);
            }   
            sfx_play_ambience("sfx",player.GetOrigin(), sh2_sfx[sfx_index].tostring(), 5000, 0, 10, player.GetName(), 48);
            sfx_index++;
        }
    }
}

// *********** play random sound when one of the 4 walls break in the freak area
function tunnel_ambience(entity_number){
    local entity_name = "freak_tunnel_" + entity_number.tostring();
    local entity = Entities.FindByName(null, entity_name.tostring());
    sfx_play_ambience("sfx",entity.GetOrigin(), sh2_sfx_freak[entity_number-1].tostring(), 5000, 0, 10, "", 48);
}

// *********** everytime someone falls down into the spikes, reverse direction of func_rotating
function random_spinner(){
    local freak_spinner = Entities.FindByName(null, "freak_spinner");
    EntFireByHandle(freak_spinner, "SetSpeed", spinner, 0, "", "");
    spinner=spinner*-1;
}

// *********** check for targetname of longus, set origin to admin room if found
function gorbinos_tp(){
    local location = Entities.FindByName(null, "admin_room_tp").GetOrigin();
    local longus = Entities.FindByName(null, "longus");
    longus.SetOrigin(location);
}

// *********** set fumo model if activator
function set_fumo_activator(){
    local random_fumo = null;    
    if (!activator) return false;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (activator == player){ 
            random_fumo = fumos[RandomInt(0,fumos.len()-1)];
            player.SetModel(random_fumo);  
        }
    }      
}

// *********** for zombie tps, set zombie model on trigger
function set_zombie_activator(){
    if (!activator) return false;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (activator == player){ 
            set_zombie(player);    
        }
    }    
}

// *********** for human killer triggers, kill player
function kill_delayer(){
    if (!activator) return false;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (player==activator){
            kill_player(player);
        }     
    }
}

// *********** set player models to fumos
function everyone_fumos(){
    local random_fumo = null;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        random_fumo = fumos[RandomInt(0,fumos.len()-1)];
        player.SetModel(random_fumo);
    }    
}

// *********** booster jump sound effect
function jumpboost_sfx(){
    if (!activator) return false;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (activator == player){ 
            //sfx_play("sfx", player.GetOrigin(), jumpboost, 2500, 0, 10, player.GetName(), 48); 
            EntFireByHandle(client_command,"Command","playgamesound " + jumpboost.tostring(),0,player,player);       
        }
    }
}

// *********** set zombies to low hp inside the vents when they get too close, play sound effect
function zm_vents_sus(){
    if (!activator) return false;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (activator == player){ 
            if(player.GetHealth()>666){
                player.SetHealth(666);
                sfx_play("sfx", player.GetOrigin(), night_creep_pain, 2500, 0, 10, player.GetName(), 48); 
            }
        }
    }    
}

// *********** after vents are over, set zombies back to max hp
function zm_vents_unsus(){
    if (!activator) return false;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (activator == player){ 
            player.SetHealth(player.GetMaxHealth());
        }
    }    
}

// *********** check if zombie triggered - if so, kill all humans
function trigger_check(){
    if (!activator) return false;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (activator == player && player.GetTeam()==2){ 
            kill_all_humans();
        }
    }    
}

// *********** if mission failed, kill all humans
function mission_failure(){
    kill_all_humans();
}

// *********** handles setting all human models at the beginning of the round - UNUSED (I THINK)
function human_models(){
    if(ct_models==false)return false;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (player.GetModelName()==crusguy)continue;
        else if(player.GetModelName()==zombie)continue;
        else if(player.GetModelName().find("fumo.mdl"))continue;
        player.SetModel(crusguy);
    }        
}

// *********** toggles the human models off - UNUSED (I THINK)
function human_models_off(){
    ct_models=false;
}

// *********** time for mother zombies :DDDDDDDD FUGGGGGG
::mother_zombies<-false;
::mz_found<-false;
::mz_checker<-false;
function mother_zombie_time(){
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player==null)return;
        if ((player.GetTeam()==2) && (player.GetHealth()>7000)){
            mz_found=true;
            mother_zombies=true;
            mz_checker=true;
            VS.EventQueue.CancelEventsByInput(mother_zombie_time);
            break;
        }
    }    
    if(mz_checker==false){
        VS.EventQueue.AddEvent(mother_zombie_time,2,[this]);
        VS.EventQueue.AddEvent(mother_zombie_time,4,[this]);
        VS.EventQueue.AddEvent(mother_zombie_time,6,[this]);
        VS.EventQueue.AddEvent(mother_zombie_time,8,[this]);
        VS.EventQueue.AddEvent(mother_zombie_time,10,[this]);                
        mz_checker=true;
    }
    if(mz_found==true){
        mother_zombie_found();
    }
}

// *********** time for mother zombies
function mother_zombie_found(){
    EntFire("mz_spawn_tp_trigger", "Enable", "", 0, "");
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player==null)return;
        if (player.GetTeam()==2 && player.GetHealth()>7000 && mother_zombies==true){
            VS.EventQueue.AddEvent(set_zombie,0.5,[this,player]);
            VS.EventQueue.AddEvent(set_zombie,1,[this,player]);
            VS.EventQueue.AddEvent(set_zombie,3,[this,player]);        
            return;
        }
    }    
}



// *********** weapon slots logic - play sound effects
::handler_gamble_message<-"charging 25% of your soul as a restocking fee";
::sfx_jackpot<-"cruelty_squad/noises/jackpot.mp3";
::sfx_health<-"cruelty_squad/noises/pickup_health.mp3";
function weapon_slot(){
    if (!activator) return false;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (activator == player && player.GetTeam()==3){ 
            handler_popup(handler_gamble_message,player);
            player.SetMaxHealth((player.GetMaxHealth()*0.75).tointeger());
            player.SetHealth(player.GetMaxHealth());
            sfx_play("vending_machine_sfx", player.GetOrigin(), sfx_jackpot, 2500, 0, 10, "", 48);         
            sfx_play("vending_machine_sfx", player.GetOrigin(), sfx_health, 2500, 2.5, 10, player.GetName(), 48);                
            give_random_weapons(player,2.5);
        }
    }      
}

// *********** overlay timer - keep setting player overlays 
function player_overlays(){
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if(player==null)continue;
        if(player.GetHealth()==0)continue;
        if(mother_zombies==true){
            if(player.GetTeam()==2)death(player);
        }
        else if(player.GetTeam()==3)life(player);
    }
}
//*************************************
//handler functions and variables
//*************************************

//ScriptPrintMessageChatAll("Test");
/*
TextColor
{
	Normal = 1,   // white
	Red,          // red
	Purple,       // purple
	Location,     // lime green
	Achievement,  // light green
	Award,        // green
	Penalty,      // light red
	Silver,       // grey
	Gold,         // yellow
	Common,       // grey blue
	Uncommon,     // light blue
	Rare,         // dark blue
	Mythical,     // dark grey
	Legendary,    // pink
	Ancient,      // orange red
	Immortal      // orange
}
*/
game_text<-Entities.FindByName(null, "handler_game_text");
env_message<-Entities.FindByName(null, "handler_env_message");

// *********** lore messages
::queue<-0;
::handler<-TextColor.Location + "handler: ";
::handler_message<-{
	[0] = TextColor.Legendary + "buckle up, it's your first day on the job... we'll be doing some soul purification throughout the " + TextColor.Immortal + "city of stinktinkio",
	[1] = TextColor.Legendary + "courtesy of " + TextColor.Immortal + "r&d" + TextColor.Legendary + ", you'll be trying a new " + TextColor.Red + "tactical implant",
	[2] = TextColor.Legendary + "to enable streamlined and nonstop combat, you " + TextColor.Red + "never have to reload again" + TextColor.Legendary + "...",
	[3] = TextColor.Legendary + "however, this comes at the cost of " + TextColor.Red + "your very flesh " + TextColor.Legendary + "- don't overexert yourself",
	[4] = TextColor.Legendary + "according to" + TextColor.Immortal + " r&d" + TextColor.Legendary + ", this is the most effective loadout for your skill level",
	[5] = TextColor.Legendary + "since you're still new you don't have a " + TextColor.Red + "company card" + TextColor.Legendary + ", so be grateful we're even giving you anything",
	[6] = TextColor.Legendary + "rebuys? the fuck are you talking about? you can't pull guns outta your ass - albeit that's a great idea to invest on - nonetheless, you better not somehow lose your equipment",
	[7] = TextColor.Red + "company card restricted! ",
	[8] = TextColor.Legendary + "one more thing... " + TextColor.Immortal + "r&d" + TextColor.Legendary + " wants you to field test these new " + TextColor.Red + "'fumo nades'",
	[9] = TextColor.Legendary + "... wait what? those " + TextColor.Immortal + "fuckers in r&d" + TextColor.Legendary + "! wasting company resources for stupid shit all the god damn time",
	[10] = TextColor.Legendary + "alright, starting off easy - " + TextColor.Immortal + "you see that soul over there?" + TextColor.Legendary + " this, and more, will be your objectives",
	[11] = TextColor.Legendary + "this city is all sorts of fucked up - these souls can't pass onto the afterlife because of their debts, and are interferring with instrastructure and operations of " + TextColor.Immortal + "stinktinkio",
	[12] = TextColor.Immortal + "mayor cumbin " + TextColor.Legendary + "(lol) is freakin' pissed off, so we've been contracted a pretty penny to clean up this mess, and one " + TextColor.Red + "even bigger issue" + TextColor.Legendary + "...",
	[13] = TextColor.Legendary + "our competitor " + TextColor.Immortal + "stanko corp. " + TextColor.Legendary + "developed an airborne virus for the military that more or less makes you " + TextColor.Red + "immortal",
	[14] = TextColor.Legendary + "they got the formula wrong though, and their compound blew up in an accident and infected the city - so we've got quite literal zombies",
	[15] = TextColor.Legendary + "normally, we'd just nuke the jimmies outta everything, but then we wouldn't get paid for a) purifying these sorry bastards and b) reallocating their debts to surviving family members",
	[16] = TextColor.Legendary + "alright, that's enough exposition - " + TextColor.Red + "you've got to hold here" + TextColor.Legendary + " according to hq, the way out is down below",
	[17] = TextColor.Legendary + "4 souls shall reveal the path - power, virtue, strength, and purity",
	[18] = TextColor.Legendary + "well isn't that convenient - use your brain we're paying you to use and split up into four groups and hold 'em off",
	[19] = TextColor.Legendary + "souls purified - choose the virtue you identify with and split up four ways",
	[20] = TextColor.Legendary + "oh shit! forecast just came in, it's raining zombies - get inside",
	[21] = TextColor.Legendary + "one more soul awaits here - what do you get when you combine power, virtue, strength, and purity?",
	[22] = TextColor.Legendary + "don't look at me, that was a rhetorical question, i don't fuckin' know - anyways, the " + TextColor.Red + "helldoors await",
	[23] = TextColor.Legendary + "the four spiritual pillars shall soon shatter",
	[24] = TextColor.Legendary + "i'll need some of you to move on ahead and find the path, we'll highlight the exit on your hud as they are found",
	[25] = TextColor.Legendary + "octagon shall perish in 20 seconds",
	[26] = TextColor.Legendary + "hexadecagon shall perish in 30 seconds",
	[27] = TextColor.Legendary + "icosidodecagon shall perish in 40 seconds",
	[28] = TextColor.Legendary + "hexacontatetragon shall perish in 50 seconds",
	[29] = TextColor.Legendary + "rhombicosidodecahedron shall perish in 60 seconds",
	[30] = TextColor.Legendary + "shit! looks like we've got bad intel, find and purify the helldoors soul here asap, i'll make some phonecalls and get y'all outta there...",
	[31] = TextColor.Legendary + "we're paying the helldoors soul to buy you some time - looks like you guys got split up, stick together - i'd be cautious about letting 'em get to close",
	[32] = TextColor.Legendary + "HVAC soul purified - the toxic fog here should help pacify the zombies if they get to close, but that's your last resort",
	[33] = TextColor.Legendary + "luckily you guys have the tactical lung enhancement or you'd be fucked! hahahahaha! keep an eye on those pillars, let the squad know when to get back",
	[34] = TextColor.Legendary + "dead or alive, we still have to pay you, i'd rather you help keep each other alive so we can avoid severance paperwork...",
	[35] = TextColor.Legendary + "get out of there quick - i hear 'em stumbling about not too far behind",
	[36] = TextColor.Legendary + "got to love all of this beautiful office equipment and everyone's remote - lazy bastards!",
	[37] = TextColor.Legendary + "the divinity of the office is restored, we should be able to close the emergency shutters",
	[38] = TextColor.Legendary + "all i can say is that this is par for stanko corp - libtard hipster defense contractors making everything abstract and complicated",
	[39] = TextColor.Legendary + "one of you with the best brain implant should take a stab at this, looks like the room follows the cube",
	[40] = TextColor.Legendary + "your sheer presence has shattered and owned the timid puzzle soul, god bless testosterone",
	[41] = TextColor.Legendary + "man i don't even know what to do from here, i've got to take a piss too - figure it out",
	[42] = TextColor.Legendary + "that looked fun - okay, we've got our path forward, do your thing",
	[43] = TextColor.Legendary + "oh baby, i love this song - this dungeon probably has some tricks up its sleeve...",
	[44] = TextColor.Legendary + "intel from " + TextColor.Immortal + "mayor cumbin " + TextColor.Legendary + "says the three spirits of his secretaries possess this area",
	[45] = TextColor.Legendary + "oh wait i wasn't supposed to tell you that part... anyways - just purify 'em",
	[46] = TextColor.Legendary + "the profaned doors will open here in a bit, keep an eye out for any weird shit",
	[47] = TextColor.Legendary + "12 souls remain which represent the cardinal sins of true pain",
	[48] = TextColor.Legendary + "return on investment, synergy, agile, S&P500, paradigm shift, stakeholders, dividends, diversity & inclusion, email, webex, liver cancer, funko pops",
	[49] = TextColor.Legendary + "that's schizo shit man! i sure love our job, nothing beats good ole manual labor",
	[50] = TextColor.Legendary + "alright - souls purified and debts reallocated, that's it for the day, let's blow this joint",
	[51] = TextColor.Legendary + "unbelievable - this is why i hate subcontracting shit, the getaway vendor doesn't know where their driver's at - hold out until we find it",
	[52] = TextColor.Legendary + "uhh oh yeah, these backroads are cursed, better not step directly on them, this shit'll suck your soul out in not the good way",
	[53] = TextColor.Legendary + "holy fuck! dying on the job is worse than sleeping on the job... consider him fired when we get back - one sec, i'll hit the remote start",
	[54] = TextColor.Legendary + "alright, debts reallocated and souls purified, our work is done - hq will nuke those sorry bastards",
	[55] = TextColor.Legendary + "congrats on surviving your first day, well to those of you who did that is - welcome to cruelty squad",
	[56] = TextColor.Legendary + "if they get inside just stick together and keep 'em back",
	[57] = TextColor.Legendary + "shit, almost forgot, this is important, if you stray off from the group and stay behind, your intercranial explosive will detonate",
	[58] = TextColor.Red + "warning - activating anti-immortal-biosoldier break-in system",
	[59] = TextColor.Legendary + "holy balls, i didn't even see that one - poor guy overdosed on painkillers at his desk, looks like he'll help us out of here"
}

// *********** messages when humans type rtv
::handler_rtv_messages<-{
	[0] = "hey schizo! you have a job to finish - take these pills",
	[1] = "don't be a pussy, finish the mission! maybe this will help",
	[2] = "skimmed the t&c? well, here's an incentive to keep going",
	[3] = "all that soylent went to your head - have some steroids",
	[4] = "come on, pharmafrx latest product will perk you up",
	[5] = "your wife got a boyfriend? have some condolences",
	[6] = "how many times do i have to teach you this lesson old man!",
	[7] = "good lord man, you are a crybaby! here's you baby bottle",
	[8] = "eat this fat burger, it's on the house, now give it another go",
	[9] = "okay little princess, have this t-supplement - go kill zombies"
}

// *********** messages when zm type rtv
::handler_rtv_messages_zm<-{
	[0] = "a competitor bribed me to give you a little speed boost",
	[1] = "one of them pissed me off, so i want you to kill them all",
	[2] = "i've a bet that they lose, so i'll give you some roids man",
	[3] = "man, i'm getting paid to help even you guys now",
	[4] = "chill out crybaby, i've already been paid, here's your speed",
	[5] = "peter what are you smoking? crack? crack!",
	[6] = "holy fuck, yeah i get it, being dead sucks... here ya go",
}

// *********** messages when mission failure
::handler_failure_messages<-{
	[0] = "congratulations on screwing the pooch on your first day",
	[1] = "we should have checked your references first...",
	[2] = "body reconstruction will come outta your pay",
	[3] = "maybe next time don't let zombies do your job",
	[4] = "you must believe to achieve, or something"
}

// *********** handler images
::handler_imgs<-{
	[0] = "<img src=\"https://raw.githubusercontent.com/TheBigBadMemeMan/ghostfap/main/image/handler_1.png\"/>",
	[1] = "<img src=\"https://raw.githubusercontent.com/TheBigBadMemeMan/ghostfap/main/image/handler_2.png\"/>",
	[2] = "<img src=\"https://raw.githubusercontent.com/TheBigBadMemeMan/ghostfap/main/image/handler_3.png\"/>",
	[3] = "<img src=\"https://raw.githubusercontent.com/TheBigBadMemeMan/ghostfap/main/image/handler_4.png\"/>"
}

// *********** handler sound effects
::handler_sounds<-{
	["a"] = "cruelty_squad/noises/a.mp3",
	["b"] = "cruelty_squad/noises/b.mp3",	
	["c"] = "cruelty_squad/noises/c.mp3",
	["d"] = "cruelty_squad/noises/d.mp3",	
	["e"] = "cruelty_squad/noises/e.mp3",
	["f"] = "cruelty_squad/noises/f.mp3",	
	["g"] = "cruelty_squad/noises/g.mp3",
	["h"] = "cruelty_squad/noises/h.mp3",	
	["i"] = "cruelty_squad/noises/i.mp3",
	["j"] = "cruelty_squad/noises/j.mp3",	
	["k"] = "cruelty_squad/noises/k.mp3",
	["l"] = "cruelty_squad/noises/l.mp3",	
	["m"] = "cruelty_squad/noises/m.mp3",
	["n"] = "cruelty_squad/noises/n.mp3",	
	["o"] = "cruelty_squad/noises/o.mp3",
	["p"] = "cruelty_squad/noises/p.mp3",								
	["q"] = "cruelty_squad/noises/q.mp3",
	["r"] = "cruelty_squad/noises/r.mp3",		
	["s"] = "cruelty_squad/noises/s.mp3",
	["t"] = "cruelty_squad/noises/t.mp3",		
	["u"] = "cruelty_squad/noises/u.mp3",
	["v"] = "cruelty_squad/noises/v.mp3",		
	["w"] = "cruelty_squad/noises/w.mp3",
	["x"] = "cruelty_squad/noises/x.mp3",		
	["y"] = "cruelty_squad/noises/y.mp3",
	["z"] = "cruelty_squad/noises/z.mp3",		
}

// *********** say a given message
function handler_say_this(message){
	Chat(handler + (TextColor.Legendary + message.tolower()));
}

// *********** say an indexed message from handler_message
function handler_say(index){
	Chat(handler + handler_message[index]);
}

// *********** play sound
function handler_rtv_queue(player){
	//game_text.__KeyValueFromString("message", handler_rtv_messages[index]);
	//EntFireByHandle(game_text, "Display", "", 0, player, player);
	local handler_img = handler_imgs[RandomInt(0,handler_imgs.len()-1)];
	set_message(handler_img);
	show_message(player);
	local handler_string = null;
	if(player.GetTeam()==3){
		handler_string = handler_rtv_messages[RandomInt(0,handler_rtv_messages.len()-1)].tolower();
	}
	else{
		handler_string = handler_rtv_messages_zm[RandomInt(0,handler_rtv_messages_zm.len()-1)].tolower();
	}
	VS.EventQueue.AddEvent(set_message,0.05,[this,"<font color='#40EB34'>handler: \n</font><font color='#EB34AB'>" + handler_string + "</font>\n" + handler_img.tostring()]);	
	VS.EventQueue.AddEvent(show_message,0.4,[this,player]);
    handler_sfx(handler_string, player);
}	

function handler_failure_queue(index, player){
	local handler_img = handler_imgs[RandomInt(0,handler_imgs.len()-1)];
	set_message(handler_img);
	show_message(player);
	VS.EventQueue.AddEvent(set_message,0.05,[this,"<font color='#40EB34'>handler: \n</font><font color='#EB34AB'>" + handler_failure_messages[index].tostring() + "</font>\n" + handler_img.tostring()]);	
	VS.EventQueue.AddEvent(show_message,0.4,[this,player]);
	local handler_string = handler_failure_messages[index].tolower();
    handler_sfx(handler_string, player);
}	

function handler_popup(message,player){
	local handler_img = handler_imgs[RandomInt(0,handler_imgs.len()-1)];
	set_message(handler_img);
	show_message(player);
	VS.EventQueue.AddEvent(set_message,0.05,[this,"<font color='#40EB34'>handler: \n</font><font color='#EB34AB'>" + message + "</font>\n" + handler_img.tostring()]);	
	VS.EventQueue.AddEvent(show_message,0.4,[this,player]);
    handler_sfx(message, player);
}

function handler_popup_nosound(message,player){
	local handler_img = handler_imgs[RandomInt(0,handler_imgs.len()-1)];
	set_message(handler_img);
	show_message(player);
	VS.EventQueue.AddEvent(set_message,0.05,[this,"<font color='#40EB34'>handler: \n</font><font color='#EB34AB'>" + message + "</font>\n" + handler_img.tostring()]);	
	VS.EventQueue.AddEvent(show_message,0.4,[this,player]);
}

function handler_sfx(message, player){
    local handler_dec = 0;
	local handler_letter = "";
	local handler_sound = "";
	for (local i = 0; i<message.len();){
		handler_dec = message[i];
		if(handler_dec < 97 || handler_dec > 122){i++;continue;}
		handler_letter = handler_dec.tochar();
		handler_sound = handler_sounds[handler_letter].tostring();
		EntFireByHandle(client_command, "Command", "playgamesound " + handler_sound, i*0.05, player, player);
		i++;
	}	
}

function set_message(message){
	env_message.__KeyValueFromString("message",message);
}

function show_message(player){
	EntFireByHandle(env_message, "ShowMessage", "", 0, player, player);	
}

function handler_queue(index, delay){
	if (queue==0){
		VS.EventQueue.AddEvent(handler_say,delay,[this, index]);		
		queue = Time() + delay;
	}
	else if (queue - (Time()+delay) < 0){
		VS.EventQueue.AddEvent(handler_say,delay,[this, index]);
		queue = Time() + delay;
	}
	else {
		VS.EventQueue.AddEvent(handler_say,delay+queue-Time(),[this, index]);
	}
}

//**********************************
//weapon_fire shit
//**********************************
eject_sfx<-"cruelty_squad/noises/slots.mp3";
error_sfx<-"cruelty_squad/noises/ui_selection.mp3";
heartbeat_1_sfx<-"cruelty_squad/noises/heartbeat_1.mp3";
heartbeat_2_sfx<-"cruelty_squad/noises/heartbeat_2.mp3";
heartbeat_3_sfx<-"cruelty_squad/noises/heartbeat_3.mp3";
heartbeat_4_sfx<-"cruelty_squad/noises/heartbeat_4.mp3";
heartbeat_5_sfx<-"cruelty_squad/noises/heartbeat_5.mp3";
gibbing_sfx<-"cruelty_squad/noises/gibbing_3.mp3";
weapon<-"";
::fumo_nades<-false;
time<-0;
delay<-1;
::heartbeats_sfx<-{
    [0] = heartbeat_1_sfx,
    [1] = heartbeat_2_sfx,
    [2] = heartbeat_3_sfx,
    [3] = heartbeat_4_sfx,
    [4] = heartbeat_5_sfx
}

// *********** table of weapons
::weapons<-{
    [0] ="weapon_ak47",
    [1] = "weapon_aug",
    [2] = "weapon_awp",
    [3] = "weapon_bizon",
    [4] = "weapon_cz75a",
    [5] = "weapon_deagle",
    [6] = "weapon_elite",
    [7] = "weapon_famas",
    [8] = "weapon_fiveseven",
    [9] = "weapon_g3sg1",
    [10] = "weapon_galilar",
    [11] = "weapon_glock",
    [12] = "weapon_hkp2000",
    [13] = "weapon_m249",
    [14] = "weapon_m4a1",
    [15] = "weapon_m4a1_silencer",
    [16] = "weapon_mac10",
    [17] = "weapon_mag7",
    [18] = "weapon_mp5sd",
    [19] = "weapon_mp7",
    [20] = "weapon_mp9",
    [21] = "weapon_negev",
    [22] = "weapon_nova",
    [23] = "weapon_p250",
    [24] = "weapon_p90",
    [25] = "weapon_revolver",
    [26] = "weapon_sawedoff",
    [27] = "weapon_scar20",
    [28] = "weapon_sg556",
    [29] = "weapon_ssg08",
    [30] = "weapon_tec9",
    [31] = "weapon_ump45",
    [32] = "weapon_usp_silencer",
    [33] = "weapon_xm1014"
}

// *********** cost in hp to shoot each weapon
::hp<-{
    ["weapon_ak47"] = 3,
    ["weapon_aug"] = 3,
    ["weapon_awp"] = 20,
    ["weapon_bizon"] = 2,
    ["weapon_cz75a"] = 1,
    ["weapon_deagle"] = 1,
    ["weapon_elite"] = 1,
    ["weapon_famas"] = 3,
    ["weapon_fiveseven"] = 1,
    ["weapon_g3sg1"] = 9,
    ["weapon_galilar"] = 3,
    ["weapon_glock"] = 1,
    ["weapon_hkp2000"] = 1,
    ["weapon_m249"] = 2,
    ["weapon_m4a1"] = 3,
    ["weapon_m4a1_silencer"] = 3,
    ["weapon_mac10"] = 2,
    ["weapon_mag7"] = 17,
    ["weapon_mp5sd"] = 2,
    ["weapon_mp7"] = 2,
    ["weapon_mp9"] = 2,
    ["weapon_negev"] = 2,
    ["weapon_nova"] = 13,
    ["weapon_p250"] = 1,
    ["weapon_p90"] = 2,
    ["weapon_revolver"] = 8,
    ["weapon_sawedoff"] = 17,
    ["weapon_scar20"] = 9,
    ["weapon_sg556"] = 3,
    ["weapon_ssg08"] = 17,
    ["weapon_tec9"] = 1,
    ["weapon_ump45"] = 2,
    ["weapon_usp_silencer"] = 1,
    ["weapon_xm1014"] = 7   
}

// *********** things to keep track of goyslop spawned
::goyslop_count<-0;
::goyslop_total<-0;
::goyslop_max<-64;
::goyslop_total_max<-1000;
chips_maker<-Entities.FindByName(null,"chips_maker");
pizza_maker<-Entities.FindByName(null,"pizza_maker");
soda_maker<-Entities.FindByName(null,"soda_maker");
goyslop_makers<-{
    [0] = chips_maker,
    [1] = pizza_maker,
    [2] = soda_maker
}

// *********** weapon_fire event handler
handler_health_deplete<-"intercranial explosive device activated";
VS.ListenToGameEvent( "weapon_fire", function(event){ 
    local player = VS.GetPlayerByUserid(event.userid);
    if(player==null)return;
    if (player.GetTeam()==2)return;
    local weapon = event.weapon;
    local hp = find_weapon(weapon);
    if (hp==null)return;
    else{
        local player_hp = player.GetHealth();
        local player_maxhp = player.GetMaxHealth();         
        if(player_hp-hp<1){
            if(player_hp==0)return;
            fix_hp(player);             
            kill_player(player);
            handler_popup_nosound(handler_health_deplete,player);
            return;
        }
        else if(player_hp==6666){
            return;
        }
        else{
            if(player_hp<50){
                if (player_hp-hp<=hp*11){
                    if (player_hp-hp<=hp*11 && player_hp-hp>hp*9){
                        EntFireByHandle(client_command,"Command","playgamesound " + heartbeat_1_sfx.tostring(),0,player,player);                
                    }
                    else if (player_hp-hp<=hp*9 && player_hp-hp>hp*7){
                        EntFireByHandle(client_command,"Command","playgamesound " + heartbeat_2_sfx.tostring(),0,player,player);                
                    }   
                    else if (player_hp-hp<=hp*7 && player_hp-hp>hp*5){
                        EntFireByHandle(client_command,"Command","playgamesound " + heartbeat_3_sfx.tostring(),0,player,player);                
                    }
                    else if (player_hp-hp<=hp*5 && player_hp-hp>hp*3){
                        EntFireByHandle(client_command,"Command","playgamesound " + heartbeat_4_sfx.tostring(),0,player,player);                
                    }
                    else if (player_hp-hp<=hp*3 && player_hp-hp>hp){
                        EntFireByHandle(client_command,"Command","playgamesound " + heartbeat_5_sfx.tostring(),0,player,player);                
                    }      
                    EntFire("ouch", "Fade", "", 0, player);   
                }        
            }                          
            player.SetHealth(player_hp-hp);
        }
    }    
}.bindenv(this), "weapon_fire_async", 0 );

// *********** when a player is to be killed, set their hp to keep track of them
function fix_hp(player){
    player.SetHealth(6666);
}

// *********** find the player's weapon hp value
function find_weapon(weapon){
    foreach (item in weapons){
        if (weapon==item){           
            return hp[item];

        }
    }
    return null;
}

// *********** function to toggle fumo nades, sets global var
function fumo_nades_toggle(){
    if (fumo_nades==false){
        fumo_nades=true;
    }
    else{
        fumo_nades=false;
    }
}

// *********** grenade_thrown event handler
::VS.ListenToGameEvent("grenade_thrown",function(event){
    if (fumo_nades==true){
        local fumo = fumos.len()-1;
        for (local nade = null; nade = Entities.FindByClassname(nade, "hegrenade_projectile");){
            nade.SetModel(fumos[fumo]);
        }
    }
    local player = VS.GetPlayerByUserid(event.userid);
    if (player==null)return;
    //printl(nade_count);
    if(event.weapon=="hegrenade"){
        if(!nade_count.rawin(player.GetName())){
            nade_count[player.GetName()]<-0;
        }
        nade_count[player.GetName()]++;
        if(nade_count[player.GetName()]>=2){
            local he = Entities.FindByClassnameNearest("weapon_hegrenade", player.GetOrigin(), 0);
            EntFireByHandle(he, "Kill","",0,null,null);
            EntFireByHandle(client_command,"Command","invnext",0.05,player,player);
        }
    }
    else if(event.weapon=="molotov"){
        if(!molly_count.rawin(player.GetName())){
            molly_count[player.GetName()]<-0;
        }        
        molly_count[player.GetName()]++;
        if(molly_count[player.GetName()]>=2){
            local molly = Entities.FindByClassnameNearest("weapon_molotov", player.GetOrigin(), 0);
            EntFireByHandle(molly, "Kill","",0,null,null);
            EntFireByHandle(client_command,"Command","invnext",0.05,player,player);
        }        
    }
    for (local fuck_decoys = null; fuck_decoys = Entities.FindByClassname(fuck_decoys, "weapon_decoy");){
        EntFireByHandle(fuck_decoys, "Kill","",0,null,null); 
    }
}.bindenv(this), "grenade_thrown_sync", 1);

// *********** player_use event handler - for goyslop purposes to give hp
::VS.ListenToGameEvent("player_use",function(event){
    local player = VS.GetPlayerByUserid(event.userid);
    if(player==null)return;
    local ent_index = event.entity;
    local ent_used = null;
    for (local snack = null; snack = Entities.FindByClassname(snack, "prop_physics*");){
        if (ent_index == snack.entindex()){
            ent_used = snack.GetName();
            if (ent_used == "pizza" || ent_used == "soda" || ent_used == "chips"){
                if (player.GetTeam()==3){
                    //sfx_play("vending_machine_sfx",snack.GetOrigin(), consume_sfx, 5000, 0, 10, player.GetName(), 48); 
                    EntFireByHandle(client_command,"Command","playgamesound " + consume_sfx.tostring(),0,player,player);
                    yum(player);
                    EntFireByHandle(snack, "Break", "", 0.01, "", "");
                    goyslop_count--;
                    return;
                }
                return;
            }            
        }
    }
}.bindenv(this), "player_use_sync",1);

// *********** dispense goyslop from the vending machines
function dispense(){
    local vm_eject = Entities.FindByNameNearest("vending_machine_eject*", activator.GetOrigin(), 250);
    local vending_machine = Entities.FindByNameNearest("vending_machine&*", activator.GetOrigin(), 250);
    local fucking_vector = vm_eject.GetOrigin(); 
    local name = "";
    local goyslop_to_wake=null;
    name = vending_machine.GetName().tolower();
    if (goyslop_count>goyslop_max || goyslop_total>goyslop_total_max || activator.GetTeam()==2){
        sfx_play("vending_machine_sfx", fucking_vector, error_sfx, 2500, 0, 10, name, 48);        
    }     
    else{
        sfx_play("vending_machine_sfx",fucking_vector, eject_sfx, 2500, 0, 10, name, 48);   
        goyslop_makers[RandomInt(0,goyslop_makers.len()-1)].SpawnEntityAtLocation(fucking_vector,Vector(0, RandomFloat(0,360),0));
        goyslop_to_wake=Entities.FindByClassnameNearest("prop_physics_override", fucking_vector, 16);
        EntFireByHandle(goyslop_to_wake, "Wake", "", 0, "", "");
        EntFireByHandle(goyslop_to_wake, "EnableMotion", "", 0, "", "");   
        //EntFireByHandle(vm_eject, "Impact", "", 0.05, "", "");
        goyslop_count++;
        goyslop_total++;         
    }
}

// *********** give hp to player when they eat goyslop, sets max hp and heals little bit of health
function yum(player){
    local goyslop = 0;
    local bound = (crusguy_hp/5).tointeger();
    if (player.GetMaxHealth()<crusguy_hp*2){
        goyslop = RandomInt(1,bound);
    }
    else if (player.GetMaxHealth()>=crusguy_hp*2){
        goyslop = RandomInt(-bound,bound);
    }
    player.SetMaxHealth(player.GetMaxHealth()+goyslop);
    if(player.GetHealth()+25<player.GetMaxHealth()){
        player.SetHealth(player.GetHealth()+25);
    }
    else{
        player.SetHealth(player.GetMaxHealth());
    }
    
}

// *********** teleport all goyslop to the punishment tunnel, enable their motion so they hit the trigger_push and spread out
function goyslop_helldoors_enable_motion(){
    EntFire("soda","EnableMotion","",0,""); 
    EntFire("chips","EnableMotion","",0.05,"");     
    EntFire("pizza","EnableMotion","",0.1,"");      
    local tp_location = Entities.FindByName(null, "zm_teleport_2_half").GetOrigin();
    for (local snack = null; snack = Entities.FindByClassname(snack, "prop_physics*");){
        if (snack.GetName() == "pizza" || snack.GetName() == "soda" || snack.GetName() == "chips"){
            snack.SetOrigin(tp_location+Vector(RandomInt(-40, 40),RandomInt(-40, 40),RandomInt(-250, 0)));
        }
    }
    local more=0;
    local random_xd=null;
    while (more<150){
        random_xd=tp_location+Vector(RandomInt(-40, 40),RandomInt(-40, 40),RandomInt(-250, 250));
        goyslop_makers[RandomInt(0,goyslop_makers.len()-1)].SpawnEntityAtLocation(random_xd,Vector(0, RandomFloat(0,360),0));                 
        more++;
    }
}

// *********** when new vending machines are spawned, clean up all uneaten goyslop elsewhere
function goyslop_clean(){
    for (local snack = null; snack = Entities.FindByClassname(snack, "prop_physics*");){
        if (snack.GetName() == "pizza" || snack.GetName() == "soda" || snack.GetName() == "chips"){
            EntFireByHandle(snack, "Kill", "", 0, "", "");
        }
    }
    goyslop_count=0;
}

// *********** remove spawned vending machines and weapon slots when they are no longer needed
function clean_machines(name){
    local machine_maker = Entities.FindByName(null,name);
    local cool_vector = machine_maker.GetOrigin();
    local vm_to_clean = Entities.FindByClassnameNearest("prop_dynamic*", cool_vector, 128);
    if(vm_to_clean.GetModelName().find("vendingmachine.mdl")){
        EntFireByHandle(vm_to_clean, "Kill", "", 0, "", "");
        vm_to_clean = Entities.FindByNameNearest("vending_machine_button*", cool_vector, 128);     
        if(vm_to_clean!=null){EntFireByHandle(vm_to_clean, "Kill", "", 0, "", "");}
        vm_to_clean = Entities.FindByNameNearest("vending_machine_eject*", cool_vector, 128); 
        if(vm_to_clean!=null){EntFireByHandle(vm_to_clean, "Kill", "", 0, "", "");}
        vm_to_clean = Entities.FindByNameNearest("vending_machine_sound_hum*", cool_vector, 128);   
        if(vm_to_clean!=null){EntFireByHandle(vm_to_clean, "Kill", "", 0, "", "");}
    }
    else if(vm_to_clean.GetModelName().find("weaponslot.mdl")){
        EntFireByHandle(vm_to_clean, "Kill", "", 0, "", "");
        vm_to_clean = Entities.FindByNameNearest("weapon_slot_button*", cool_vector, 128); 
        if(vm_to_clean!=null){EntFireByHandle(vm_to_clean, "Kill", "", 0, "", "");}
    }     
}

//spawn functinos for weapon slots and vending machines
//look for relay position, spawn shit there
//name of relay is used to look for what to clean (for rng purposes)
function vending_machine_spawn(name, cool_angles){
    local vm_maker = Entities.FindByName(null,"vending_machine_maker");
    local cool_vector = Entities.FindByName(null,name).GetOrigin();
    vm_maker.SpawnEntityAtLocation(cool_vector,cool_angles);
}

function weapon_slot_spawn(name,cool_angles){
    local ws_maker = Entities.FindByName(null,"weapon_slot_maker");
    local cool_vector = Entities.FindByName(null,name).GetOrigin();
    ws_maker.SpawnEntityAtLocation(cool_vector,cool_angles); 
}


//freak area stuff - weapon slots
function weapon_slots_freak(){
    local cool_angles = Vector(0,-90,0);
    for(local i=1; i<5; i++){
        weapon_slot_spawn("weapon_slots_freak_" + i.tostring(),cool_angles);
        cool_angles = cool_angles + Vector(0,-90,0);
    }        
}

function weapon_slots_freak_clean(){
    clean_machines("weapon_slots_freak_1");
    clean_machines("weapon_slots_freak_2");
    clean_machines("weapon_slots_freak_3");
    clean_machines("weapon_slots_freak_4");
}

//helldoors area stuff - vending machines and weapon slots
function weapon_slots_helldoors(){
    local cool_angles = Vector(0,-90,0);
    for(local i=1; i<5; i++){
        weapon_slot_spawn("weapon_slot_helldoors_" + i.tostring(),cool_angles);
        cool_angles = cool_angles + Vector(0,-90,0);
    }        
}

function vending_machines_helldoors(){
    vending_machine_spawn("helldoors_vending_maker_1",Vector(0,45,0));     
    vending_machine_spawn("helldoors_vending_maker_2",Vector(0,-45,0));
    vending_machine_spawn("helldoors_vending_maker_3",Vector(0,-135,0));     
    vending_machine_spawn("helldoors_vending_maker_4",Vector(0,135,0));
}

function vending_machines_helldoors_destroy(){
    clean_machines("helldoors_vending_maker_1");
    clean_machines("helldoors_vending_maker_2");
    clean_machines("helldoors_vending_maker_3");
    clean_machines("helldoors_vending_maker_4");   
    clean_machines("weapon_slot_helldoors_1");
    clean_machines("weapon_slot_helldoors_2");
    clean_machines("weapon_slot_helldoors_3");
    clean_machines("weapon_slot_helldoors_4");     
}

//vents area stuff - rng vending machines and weapon slots
function weapons_and_snacks_vents(){
    local roll = 0;
    local angles = Vector(0,-90,0); 
    for(local i=1; i<5; i++){
        roll = RandomInt(0,666);
        if(roll<333){
            vending_machine_spawn("vents_maker_" + i.tostring(),angles);
        }
        else{
            weapon_slot_spawn("vents_maker_" + i.tostring(),angles);
        }
        angles = angles + Vector(0,-90,0);
    }
    goyslop_clean();   
}

function vending_machines_vents_destroy(){
    clean_machines("vents_maker_1");
    clean_machines("vents_maker_2");
    clean_machines("vents_maker_3");
    clean_machines("vents_maker_4");
} 

//office area makers - rng vending machines and weapon slots
function weapons_and_snacks_office(){
    local roll = 0;
    local angles = Vector(0,90,0);   
    for(local i=1; i<5; i++){
        roll = RandomInt(0,666);
        if(roll<333){
            vending_machine_spawn("office_maker_" + i.tostring(),angles);
        }
        else{
            weapon_slot_spawn("office_maker_" + i.tostring(),angles);
        }
    }
    goyslop_clean(); 
}

function vending_machines_office_destroy(){
    clean_machines("office_maker_1");
    clean_machines("office_maker_2");
    clean_machines("office_maker_3");
    clean_machines("office_maker_4");
}

//dungeon area makers
function vending_machines_puzzle_path(){
    vending_machine_spawn("dungeon_maker_1",Vector(0,0,0));    
    vending_machine_spawn("dungeon_maker_2",Vector(0,180,0));   
    goyslop_clean();  
}

function vending_machines_puzzle_path_destroy(){
    clean_machines("dungeon_maker_1");
    clean_machines("dungeon_maker_2");
    EntFire("puzzle_machine_light_1","TurnOff","",0,"");
    EntFire("puzzle_machine_light_2","TurnOff","",0,"");   
}

//city area makers
function vending_machines_city(){
    vending_machine_spawn("city_maker_1",Vector(0,-203,0)); 
    weapon_slot_spawn("city_maker_2",Vector(0,37,0));  
    goyslop_clean();    
}

//*****************************************
//player_spawn shit
//*****************************************
::client_command<-Entities.FindByName(null,"client_command");
::broadcast_client_command<-Entities.FindByName(null,"broadcast_client_command");
longus<-"STEAM_1:1:90927558";
russian<-"STEAM_1:0:2327387";
yuuka_fumo<-"models/cruelty_squad/props/touhou/yuuka/yuuka_fumo.mdl";
youmu_fumo<-"models/cruelty_squad/props/touhou/youmu/youmu_fumo.mdl";
remilia_fumo<-"models/cruelty_squad/props/touhou/remilia/remilia_fumo.mdl";
shion_fumo<-"models/cruelty_squad/props/touhou/shion/shion_fumo.mdl";
nitori_fumo<-"models/cruelty_squad/props/touhou/nitori/nitori_fumo.mdl";
miko_fumo<-"models/cruelty_squad/props/touhou/miko/miko_fumo.mdl";
kokoro_fumo<-"models/cruelty_squad/props/touhou/kokoro/kokoro_fumo.mdl";
yuyuko_fumo<-"models/cruelty_squad/props/touhou/yuyuko/yuyuko_fumo.mdl";
ran_fumo<-"models/cruelty_squad/props/touhou/ran/ran_fumo.mdl";
mokou_fumo<-"models/cruelty_squad/props/touhou/mokou/mokou_fumo.mdl";
sanae_fumo<-"models/cruelty_squad/props/touhou/sanae/sanae_fumo.mdl";
crusguy<-"models/player/custom_player/cruelty_squad/crusguy/crusguy.mdl";
zombie<-"models/player/custom_player/cruelty_squad/zombie/zombie.mdl";
russian_head<-"cruelty_squad/noises/russian_head.mp3";
jumpboost<-"cruelty_squad/noises/jumpboost.mp3";
consume_sfx<-"cruelty_squad/noises/consume.mp3";
you_were_there_1<-"cruelty_squad/noises/you_were_there_1.mp3";
you_were_there_2<-"cruelty_squad/noises/you_were_there_2.mp3";
you_were_there_3<-"cruelty_squad/noises/you_were_there_3.mp3";
russian_despair_1<-"cruelty_squad/noises/russian_despair_1.mp3";
russian_despair_2<-"cruelty_squad/noises/russian_despair_2.mp3";
shellbert_thighs<-"cruelty_squad/noises/shellbert_thighs.mp3";
sfx_spawn_laugh<-"cruelty_squad/noises/ied_hollow_laugh.mp3";
mutant_pain_1<-"cruelty_squad/noises/mutant_pain_1.mp3";
mutant_pain_2<-"cruelty_squad/noises/mutant_pain_2.mp3";
mutant_pain_3<-"cruelty_squad/noises/mutant_pain_3.mp3";
mutant_pain_4<-"cruelty_squad/noises/mutant_pain_4.mp3";
::crusguy_pain<-"cruelty_squad/noises/player_pain_1.mp3";
::meth<-Entities.FindByName(null,"methamphetamine");
::nade_count<-{}
::molly_count<-{}
pain_sfx_timer<-0.0;
pain_sfx_time<-0.0;
::pain_sfx_nuke<-false;
::crusguy_hp<-150;
::human_heal<-Entities.FindByName(null,"human_heal");
::human_heal_tick<--10;
::human_heal_buff<-1;
::death_count<-0;

// *********** fumo models
::fumos<-{
    [0] = yuuka_fumo,
    [1] = youmu_fumo,
    [2] = remilia_fumo,
    [3] = shion_fumo,
    [4] = nitori_fumo,
    [5] = miko_fumo,
    [6] = kokoro_fumo,
    [7] = yuyuko_fumo,
    [8] = ran_fumo,
    [9] = mokou_fumo,
    [10] = sanae_fumo
}

// *********** russian sound effects
::russian_sounds<-{
    [0] = russian_head,
    [1] = you_were_there_1,
    [2] = you_were_there_2,
    [3] = you_were_there_3,
    [4] = russian_despair_1,
    [5] = russian_despair_2,
    [6] = shellbert_thighs
}

// *********** zombie death sound effects
::zombie_pain<-{
    [0] = mutant_pain_1,
    [1] = mutant_pain_2,
    [2] = mutant_pain_3,
    [3] = mutant_pain_4
}

::pistol_count<-0;
::pistol<-0;
::smg_count<-0;
::smg<-0;
::rifle_count<-0;
::rifle<-0;

// *********** pistols
::weapons_pistol<-{
    [0] = "weapon_cz75a",
    [1] = "weapon_deagle",
    [2] = "weapon_elite",   
    [3] = "weapon_fiveseven",         
    [4] = "weapon_glock",  
    [5] = "weapon_hkp2000",  
    [6] = "weapon_p250",    
    [7] = "weapon_revolver",  
    [8] = "weapon_tec9",      
    [9] = "weapon_usp_silencer"
}

// *********** smgs
::weapons_smg<-{
    [0] = "weapon_bizon",
    [1] = "weapon_mac10",
    [2] = "weapon_mp5sd",
    [3] = "weapon_mp7",
    [4] = "weapon_mp9",    
    [5] = "weapon_p90",
    [6] = "weapon_ump45"   
}

// *********** heavy weapons
::weapons_heavy<-{
    [0] = "weapon_m249",
    [1] = "weapon_negev"
}

// *********** rifles
::weapons_rifle<-{
    [0] ="weapon_ak47",
    [1] = "weapon_aug",
    [2] = "weapon_famas",  
    [3] = "weapon_galilar",  
    [4] = "weapon_m4a1",
    [5] = "weapon_m4a1_silencer",
    [6] = "weapon_sg556"
}

// *********** shotguns
::weapons_shotgun<-{
    [0] = "weapon_mag7",
    [1] = "weapon_nova",
    [2] = "weapon_sawedoff",    
    [3] = "weapon_xm1014"    
}

// *********** snipers
::weapons_sniper<-{
    [0] = "weapon_awp",
    [1] = "weapon_g3sg1",
    [2] = "weapon_scar20",
    [3] = "weapon_ssg08",    
}

// *********** toggles nuke sfx to avoid earrape when everyone is to be killed at the same time
function nuke_sfx_toggle(){
    pain_sfx_nuke=true;
}

// *********** set john cruelty player model if not already set
function set_crusguy(player){
    if(player==null)return;
    if (player.GetModelName()!=crusguy){
        if(player.GetModelName()==zombie)return;
        if(player.GetModelName().find("fumo"))return;
        player.SetModel(crusguy);
    }
}

// *********** set zombie player model if not already set
function set_zombie(player){
    if(player==null)return;
    if(player.GetModelName()==zombie)return;
    player.SetModel(zombie);
    EntFireByHandle(meth, "ModifySpeed", zm_speed, 0, player, player);
}

// *********** set john cruelty overlay
function life(player){
    if(player==null)return;
    EntFireByHandle(client_command, "Command", "r_screenoverlay crustex/overlays/life", 0.5, player, "");
}

// *********** set zombie overlay
function death(player){
    if(player==null)return;
    EntFireByHandle(client_command, "Command", "r_screenoverlay crustex/overlays/death", 0.5, player, "");      
}

// *********** randomly give player weapons, spawn a weapon_equip
function give_random_weapons(player, delay){
    weapon_equip <- Entities.CreateByClassname("game_player_equip");
    weapon_equip.__KeyValueFromInt(weapons_pistol[RandomInt(0,weapons_pistol.len()-1)],1);
    local random_primary = RandomFloat(0, 1);
    if(random_primary<0.20&&random_primary>=0){
        weapon_equip.__KeyValueFromInt(weapons_smg[RandomInt(0,weapons_smg.len()-1)],1);
    }
    else if(random_primary<0.40&&random_primary>=0.20){
        weapon_equip.__KeyValueFromInt(weapons_rifle[RandomInt(0,weapons_rifle.len()-1)],1);        
    }
    else if(random_primary<0.60&&random_primary>=0.40){
        weapon_equip.__KeyValueFromInt(weapons_heavy[RandomInt(0,weapons_heavy.len()-1)],1);        
    }
    else if(random_primary<0.80&&random_primary>=0.60){
        weapon_equip.__KeyValueFromInt(weapons_shotgun[RandomInt(0,weapons_shotgun.len()-1)],1);        
    }
    else{
        weapon_equip.__KeyValueFromInt(weapons_sniper[RandomInt(0,weapons_sniper.len()-1)],1);        
    }
    weapon_equip.__KeyValueFromInt("weapon_hegrenade", 1);    
    weapon_equip.__KeyValueFromInt("spawnflags", 5);
    EntFireByHandle(weapon_equip, "Use", "", delay, player, player);
    EntFireByHandle(weapon_equip, "Destroy", "", delay + 0.01, "", "")
    //weapon_equip.Destroy();
}

// *********** remove all money from players
function taxes(player){
    local money=16000;
    local time_buffer=0.5;
    while(money>1000){
        EntFire("taxman", "SetMoneyAmount", money, time_buffer,player);
        EntFire("taxman","SpendMoneyFromPlayer", "" , time_buffer,player);
        money=money-1000;
        time_buffer=time_buffer+0.01;
    }
    money=money-50;
    while(money>0){
        EntFire("taxman", "SetMoneyAmount", money, time_buffer,player);
        EntFire("taxman","SpendMoneyFromPlayer", "" , time_buffer,player);
        money=money-50;
        time_buffer=time_buffer+0.01;
    }
}

// *********** player_spawn event handler
::VS.ListenToGameEvent("player_spawn",function(event){
    local player = VS.GetPlayerByUserid(event.userid);
    if (player==null)return;
    local extended_player = ToExtendedPlayer(player);
    player_overlays();
    if (player.GetTeam()==2 && player.GetHealth()>7000 && mother_zombies==true){
        VS.EventQueue.AddEvent(set_zombie,0.5,[this,player]);
        VS.EventQueue.AddEvent(set_zombie,1,[this,player]);
        VS.EventQueue.AddEvent(set_zombie,3,[this,player]);        
        return;
    }
    else{
        EntFire("fade","Fade","",0,player);
        EntFireByHandle(client_command,"Command","playgamesound " + sfx_spawn_laugh.tostring(),0,player,player);
        if (player.GetName()!="longus"){
            if (!player.GetName().find("crusguy")){
                EntFireByHandle(player,"AddOutput","targetname crusguy_" + event.userid,0.01,"",""); 
            }   
        }
    }  
    VS.EventQueue.AddEvent(set_crusguy,0.5,[this,player]);
    VS.EventQueue.AddEvent(set_crusguy,1,[this,player]);
    VS.EventQueue.AddEvent(set_crusguy,3,[this,player]); 
    nade_count[player.GetName()]<-0;
    molly_count[player.GetName()]<-0;
    player.SetMaxHealth(crusguy_hp);
    player.SetHealth(crusguy_hp);
    taxes(player);
    EntFire("loadout_checker", "Use", "", 1, player);
    give_random_weapons(player,15);
    EntFireByHandle(client_command,"Command","playgamesound " + sfx_health.tostring(),15,player,player);
    
}.bindenv(this), "player_spawn_async", 0);

// *********** player_jump event handler - if crusguy, play jumping sfx
::VS.ListenToGameEvent("player_jump",function(event){
    local player = VS.GetPlayerByUserid(event.userid);
    if(player==null)return;
    else if(player.GetTeam()==3){
        sfx_play_jump("sfx",player.GetOrigin(), jump_sfx, 500, 0, 10, player.GetName(), 48);
    }
}.bindenv(this), "player_jump_sync",0);

// *********** player_death event handler
::VS.ListenToGameEvent("player_death",function(event){
    local player = VS.GetPlayerByUserid(event.userid);
    if (player==null)return;
    else if(player.GetTeam()==2){
        if(pain_sfx_nuke==false){
            sfx_play("sfx", player.GetOrigin(), zombie_pain[RandomInt(0,zombie_pain.len()-1)], 2500, 0, 10, player.GetName(), 48); 
        }
        else{
            EntFireByHandle(client_command,"Command","playgamesound " + zombie_pain[RandomInt(0,zombie_pain.len()-1)].tostring(),0,player,player);
        }
    }
    else if(player.GetTeam()==3){
        if(pain_sfx_nuke==false){
            sfx_play("sfx", player.GetOrigin(), crusguy_pain, 2500, 0, 10, player.GetName(), 48); 
            death_count++;
            if(!(death_count%6)){
                human_heal_tick=human_heal_tick+human_heal_buff;
                if(human_heal_tick>0)human_heal_tick=-1;
                EntFireByHandle(human_heal, "SetDamage", human_heal_tick, 0, "", "");
            }
        }
        else{
            EntFireByHandle(client_command,"Command","playgamesound " + crusguy_pain.tostring(),0,player,player);
        }        
        death(player);
        if(event.attacker==0){
            return;
        }
        VS.EventQueue.AddEvent(set_zombie,0.5,[this,player]);
        VS.EventQueue.AddEvent(set_zombie,1,[this,player]);
        VS.EventQueue.AddEvent(set_zombie,2,[this,player]);
    }
}.bindenv(this), "player_death_async", 0);

// *********** player_connect event handler, assign targetname to mapper
::VS.ListenToGameEvent("player_connect",function(event){
    if(event.networkid==longus){
        local player = VS.GetPlayerByUserid(event.userid);
        EntFireByHandle(player, "AddOutput", "targetname longus", 10, "", "");
    }
}.bindenv(this), "player_connect_async", 0);


//*********************
//player_say shit
//*********************
::self_destruction<-"cruelty_squad/noises/self_destruction.mp3";
//sfx_sd_timer<-0.0;
//sfx_sd_time<-5.246;
::zm_speed<-1.06;
::human_speed<-1;
::rtv_buff<-1.5;
::rtvs<-[];
::rtvs_zm<-[];
::mission_failed<-false;

function rtvd(player){
    foreach (rtv in rtvs){
        if (player.GetName() == rtv){
            return true;
        }   
    }    
    return false;
}

function rtvd_zm(player){
    foreach (rtv in rtvs_zm){
        if (player.GetName() == rtv){
            return true;
        }   
    }    
    return false;
}

function kill_player(player){
    death_imminent(player);   
	EntFireByHandle(player, "SetHealth", 0, 5.246, "","" );  
    for(local i=0; i<10; i++){
        if(player==null)continue;
        EntFire("ouch", "Fade", "", i.tofloat()/2, player);
    } 
    sfx_play("vending_machine_sfx",player.GetOrigin(), self_destruction, 2500, 0, 10, player.GetName(), 48);           
}

function kill_all_humans(){
    EntFire("cs_cc_death","Enable","",0,"");
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (player.GetTeam()==3){
            if(mission_failed==false){
                EntFire("sfx_self_destruction","PlaySound","",3,"");  
                mission_failed=true;
            }
            speed_mod_delay(player,0.25,3); 
            EntFireByHandle(player, "SetHealth", 0, 8.246, "","" );
            handler_failure_queue(RandomInt(0,handler_failure_messages.len()-1),player);            
        } 
    }
}

::rtv_trigger_words<-["rtv","!rtv","/rtv","this map sucks"];
VS.ListenToGameEvent( "player_say", function(event){ 
    local player = VS.GetPlayerByUserid( event.userid );
    if (player==null){
        return;
    }
    local txt = event.text.tolower();
    foreach(word in rtv_trigger_words){
    if(txt!=word)continue;
    if(player.GetHealth()==6666||player.GetHealth()==0)continue;
        if(player.GetTeam()==3){
            if(rtvd(player)==false){
                handler_rtv_queue(player);
                player.SetMaxHealth((player.GetMaxHealth()*rtv_buff).tointeger());
                player.SetHealth(player.GetMaxHealth());
                rtvs.push(player.GetName());
            }            
        }
        else if(player.GetTeam()==2){
            if(rtvd_zm(player)==false){
                handler_rtv_queue(player);
                rtvs_zm.push(player.GetName());
                zm_speed=zm_speed+0.005*rtvs_zm.len();
                for (local player = null; player = Entities.FindByClassname(player, "player");){
                    if (player.GetTeam()==2){ 
                        speed_mod(player,zm_speed);
                    }
                }                    
            }   
        }
    break;
    }
}.bindenv(this),"player_say_async",0);

function death_imminent(player){
    local k=0;
    while(k<4){
        speed_mod_delay(player,k+1,k);
        k++;
    }
    speed_mod_delay(player, zm_speed, 5.2);  
}

function speed_mod(player,speed){
    EntFire("methamphetamine", "ModifySpeed", speed, 0, player);
}

function speed_mod_delay(player,speed,delay){
    EntFire("methamphetamine", "ModifySpeed", speed, delay, player);
}

//*****************************
//music shit
//****************************
::dmc<-0;

function music_rent_due(option,value){
	EntFire("music_rent_due",option,value,0,"");
}

function music_combat_cocktail(option,value){
    EntFire("music_combat_cocktail",option,value,0,"");
}

function music_pharmacreep(option,value){
    EntFire("music_pharmacreep",option,value,0,"");
}

function music_sacrificial_mission(option, value){
    EntFire("music_sacrificial_mission",option,value,0,"");
}

function music_wheel_of_fortune(option, value){
    EntFire("music_wheel_of_fortune",option,value,0,"");
}

function music_dmc_psycho_siren(option, value){
    EntFire("music_dmc_psycho_siren",option,value,0,"");
}

function music_dmc3_m14_end(option, value){
    EntFire("music_dmc3_m14_end",option,value,0,"");
}

function music_dmc_lock_and_load(option, value){
    EntFire("music_dmc_lock_and_load",option,value,0,"");
}

function music_dmc3_devils_never_cry(option, value){
    EntFire("music_dmc3_devils_never_cry",option,value,0,"");
}

function music_controlled_depopulation(option, value){
    EntFire("music_controlled_depopulation",option,value,0,"");
} 

function music_sovereign_citizen(option, value){
    EntFire("music_sovereign_citizen",option,value,0,"");
} 

// function music_divinity_of_the_office(option, value){
//     EntFire("music_divinity_of_the_office",option,value,0,"");
// } 

function music_cancer_city_megamall(option,value){
    EntFire("music_cancer_city_megamall",option,value,0,"");
}

function music_chunkopops(option,value){
    EntFire("music_chunkopops",option,value,0,"");    
}

function music_tool_parabola(option, value){
    EntFire("music_tool_parabola",option,value,0,"");
}

function music_daughters_trthm(option, value){
    EntFire("music_daughters_trthm",option,value,0,"");
}

function music_leviathan_tsott(option, value){
    EntFire("music_leviathan_tsott",option,value,0,"");
}

function music_kowloon_walled_city_wsoh(option, value){
    EntFire("music_kowloon_walled_city_wsoh",option,value,0,"");
}

function music_nedaj_mortem(option, value){
    EntFire("music_nedaj_mortem",option,value,0,"");
}

function music_viper_ywsmdcomh(option, value){
    EntFire("music_viper_ywsmdcomh",option,value,0,"");
}

function music_queue(song){
    if (song==music_rent_due){
        music_rent_due("PlaySound","");  
        VS.EventQueue.AddEvent( song, 190, [this,"PlaySound",""]);  
    }
    else if (song==music_combat_cocktail){      
        music_combat_cocktail("PlaySound","");
        VS.EventQueue.AddEvent( song, 108, [this,"PlaySound",""]);   
        VS.EventQueue.AddEvent( song, 216, [this,"PlaySound",""]);                 
    }
    else if(song==music_pharmacreep){     
        music_pharmacreep("PlaySound","");
        VS.EventQueue.AddEvent( song, 88, [this,"PlaySound",""]);
        VS.EventQueue.AddEvent( song, 176, [this,"PlaySound",""]);  
        VS.EventQueue.AddEvent( song, 264, [this,"PlaySound",""]);       
    }  
    else if(song==music_wheel_of_fortune){
        music_wheel_of_fortune("PlaySound","");
        VS.EventQueue.AddEvent( song, 122, [this,"PlaySound",""]);  
    }
    else if(song==music_sacrificial_mission){
        music_sacrificial_mission("PlaySound","");
        VS.EventQueue.AddEvent( song, 111, [this,"PlaySound",""]);        
    }
    else if(song==music_dmc_psycho_siren){
        dmc=1;
        music_dmc_psycho_siren("PlaySound","");
    }
    else if(song==music_dmc3_m14_end){
        dmc=3;
        music_dmc3_m14_end("PlaySound","");
    }
    else if(song==music_dmc_lock_and_load){
        music_dmc_lock_and_load("PlaySound","");
    }
    else if(song==music_dmc3_devils_never_cry){
        music_dmc3_devils_never_cry("PlaySound","");
    }
    else if(song==music_controlled_depopulation){
        music_controlled_depopulation("PlaySound","");
        VS.EventQueue.AddEvent( song, 155, [this,"PlaySound",""]);
    }
    // else if(song==music_divinity_of_the_office){
    //     music_divinity_of_the_office("PlaySound","");
    //     VS.EventQueue.AddEvent( song, 163, [this,"PlaySound",""]);
    //     VS.EventQueue.AddEvent( song, 326, [this,"PlaySound",""]);
    // }
    else if(song==music_cancer_city_megamall){
        music_cancer_city_megamall("PlaySound","");
        VS.EventQueue.AddEvent( song, 168, [this,"PlaySound",""]);
    }    
    else if(song==music_chunkopops){
        music_chunkopops("PlaySound","");
        VS.EventQueue.AddEvent( song, 81, [this,"PlaySound",""]);
        VS.EventQueue.AddEvent( song, 162, [this,"PlaySound",""]);
        VS.EventQueue.AddEvent( song, 243, [this,"PlaySound",""]);        
    }
    else if(song==music_sovereign_citizen){
        music_sovereign_citizen("PlaySound","");
        VS.EventQueue.AddEvent( song, 124, [this,"PlaySound",""]);      
        VS.EventQueue.AddEvent( song, 248, [this,"PlaySound",""]);           
    }
    else if(song==music_tool_parabola){
        music_tool_parabola("PlaySound","");
    }
    else if(song==music_daughters_trthm){
        music_daughters_trthm("PlaySound","");
    }
    else if(song==music_leviathan_tsott){
        music_leviathan_tsott("PlaySound","");
    }    
    else if(song==music_kowloon_walled_city_wsoh){
        music_kowloon_walled_city_wsoh("PlaySound","");
    }      
    else if(song==music_nedaj_mortem){
        music_nedaj_mortem("PlaySound","");
    }    
    else if(song==music_viper_ywsmdcomh){
        music_viper_ywsmdcomh("PlaySound","");
    }        
}

function music_queue_dmc(){
    if (dmc==1){
        music_dmc_lock_and_load("PlaySound","");
    }
    else if(dmc==3){
        music_dmc3_devils_never_cry("PlaySound","");
    }
}

function music_queue_clear(song){
    VS.EventQueue.CancelEventsByInput( song );    
    song("Volume","0");
}
 
function siren_on(){
    local i=0;
    while(i<10){
        VS.EventQueue.AddEvent(sfx_siren, 14.405*i, [this, "PlaySound",""]);
        i++;
    }        
}

function siren_off(){
    VS.EventQueue.CancelEventsByInput(sfx_siren);
    VS.EventQueue.AddEvent( sfx_siren, 0, [this,"Volume","0"]);       
}

function sfx_siren(param, param2){
    EntFire("sfx_copcar_siren",param,param2,0,"");
}

//*****************************
//helldoors shit
//*****************************
::z_human<--150 ;
::z_zm<--100;
::jump_sfx<-"cruelty_squad/noises/jump.mp3";
::kickgrunt_sfx<-"cruelty_squad/noises/kickgrunt.mp3";

//randomly generate the orientation of the hell doors
function helldoors_angles(){
    local rhom = RandomFloat(0,360);
    local maker = Entities.FindByName(null, "octagon_maker");
    local fucking_vector = maker.GetOrigin();
    maker.SpawnEntityAtLocation(fucking_vector,Vector(0, RandomFloat(0,360),0));
    //
    maker = Entities.FindByName(null, "hexadecagon_maker");
    maker.SpawnEntityAtLocation(fucking_vector,Vector(0,RandomFloat(0,360),0));
    //
    maker = Entities.FindByName(null, "icosidodecagon_maker");
    maker.SpawnEntityAtLocation(fucking_vector,Vector(0,RandomFloat(0,360),0));
    //
    maker = Entities.FindByName(null, "hexacontatetragon_maker");
    maker.SpawnEntityAtLocation(fucking_vector,Vector(0,RandomFloat(0,360),0));
    //
    maker = Entities.FindByName(null, "rhombicosidodecahedron_maker");
    maker.SpawnEntityAtLocation(fucking_vector,Vector(0,rhom,0)); 
    //
    maker = Entities.FindByName(null, "helldoors_exit_maker");
    maker.SpawnEntityAtLocation(fucking_vector,Vector(0,rhom+RandomFloat(90, 270),0));     
} 

function hellspeed_human(x,y){
    if (!activator) return false;
    x = x*1984;
    y = y*1984;
    local speed = null;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (player==activator){
            if (player.GetVelocity().z>250){
                speed = Vector(x*0.5,y*0.5,z_human*2);
            }
            else{
                speed = Vector(x,y,player.GetVelocity().z+z_human);
            }
            player.SetVelocity(speed);
            EntFireByHandle(client_command, "Command", "playgamesound " + kickgrunt_sfx.tostring(), 0.05, player, player);
        }
    } 
}

function hellspeed_zombie(x,y){
    if (!activator) return false;
    x = x*1984;
    y = y*1984;
    local speed = null;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (player==activator){
            if (player.GetVelocity().z<0){
                speed = Vector(x,y,z_zm*2);
            }            
            else{
                speed = Vector(x,y,player.GetVelocity().z+z_zm);
            }
            player.SetVelocity(speed);
            EntFireByHandle(client_command, "Command", "playgamesound " + night_creep_pain.tostring(), 0, player, player);
        }
    } 
}

function zombie_speed_reset(){
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (player.GetTeam()==2){
            speed_mod(player,zm_speed);
        }
    }
}

function human_speed_reset(){
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (player.GetTeam()==3){
            speed_mod(player,human_speed);
        }
    }
}

//*******************************
//dungeon shit
//*******************************
//dungeon v-script to place a random path with some traps sprinkled in
normal<-Entities.FindByName(null, "evil_dungeon_normal_maker");
deathpit<-Entities.FindByName(null, "evil_dungeon_deathpit_maker");
quadpath<-Entities.FindByName(null, "evil_dungeon_quadpath_maker");
octajumps<-Entities.FindByName(null, "evil_dungeon_octajumps_maker");
spinning<-Entities.FindByName(null, "evil_dungeon_spinning_maker");
goyslop_vector_og<-normal.GetOrigin();
goyslop_vector<-null;
funni_number<-384;
sfx_timer<-0.0;
::zm_boost_sfx<-"silent_hill/silent_hill_2_01428.wav";

function dungeon_generate(){
    normal.SpawnEntityAtLocation(goyslop_vector_og,Vector(0,0,0));
    local deez_max = 7;
    local deez = 0;
    local deez_env = 0;
    local deez_env_max = 21;
    local deez_left = null;
    local deez_right = null;
    local deez_left_max = -(deez_max-1)/2;
    local deez_right_max = (deez_max-1)/2;
    while(deez<deez_max){
        if(deez==0){
            deez_left = 0;
            deez_right = 0;            
            while(deez_left>deez_left_max){
                deez_left--;                
                spawn_deez(deez_left*funni_number,0,0);
            }
            while(deez_right<deez_right_max){
                deez_right++;                
                spawn_deez(deez_right*funni_number,0,0);

            }
        }
        else if(deez==(deez_max-1)/2){
            deez_left = 0;
            deez_right = 0;
            spawn_deez(deez_left*funni_number,deez*funni_number,0);                 
            while(deez_left>deez_left_max){
                deez_left--;                
                spawn_deez(deez_left*funni_number,deez*funni_number,0);
            }  
            while(deez_right<deez_right_max){
                deez_right++;                
                spawn_deez(deez_right*funni_number,deez*funni_number,0);
            }                     
        }
        else if(deez==deez_max-1){ 
            deez_left = 0;
            deez_right = 0;
            spawn_deez(deez_left*funni_number,deez*funni_number,0);                  
            while(deez_left>deez_left_max){
                deez_left--;                
                spawn_deez(deez_left*funni_number,deez*funni_number,0);
            }  
            while(deez_right<deez_right_max){
                deez_right++;                
                spawn_deez(deez_right*funni_number,deez*funni_number,0);
            }     
        }
        else{
            spawn_deez(deez_left*funni_number,deez*funni_number,0);
            spawn_deez(deez_right*funni_number,deez*funni_number,0);
            spawn_deez(0,deez*funni_number,0);
        }
        deez++; 
    }
    while(deez_env<deez_env_max){
        deez_left = -10;
        deez_right = 10;
        spawn_spinning(deez_left*funni_number,deez_env*funni_number,0);
        spawn_spinning(deez_right*funni_number,deez_env*funni_number,0);
        spawn_spinning((deez_left+2)*funni_number,deez_env*funni_number,0);
        spawn_spinning((deez_right-2)*funni_number,deez_env*funni_number,0);
        spawn_spinning((deez_left+4)*funni_number,deez_env*funni_number,0);
        spawn_spinning((deez_right-4)*funni_number,deez_env*funni_number,0);        
        if (deez_env==20 || deez_env==0){
            spawn_spinning((deez_left+6)*funni_number,deez_env*funni_number,0);
            spawn_spinning((deez_right-6)*funni_number,deez_env*funni_number,0);   
            spawn_spinning((deez_left+8)*funni_number,deez_env*funni_number,0);
            spawn_spinning((deez_right-8)*funni_number,deez_env*funni_number,0);                         
        }
        deez_env = deez_env+2;        
    }
} 

function spawn_deez(x,y,z){
    goyslop_vector=goyslop_vector_og+Vector(x,y,z);
    if(RandomInt(-666,666 )>0){
        normal.SpawnEntityAtLocation(goyslop_vector,Vector(0,0,0));
    }
    else if(RandomInt(-666,666)>0){
        quadpath.SpawnEntityAtLocation(goyslop_vector,Vector(0,0,0));
    }
    else if(RandomInt(-666,666)>0){
        octajumps.SpawnEntityAtLocation(goyslop_vector,Vector(0,0,0));
    }
    else{
        deathpit.SpawnEntityAtLocation(goyslop_vector,Vector(0,0,0));
    }
} 

function spawn_spinning(x,y,z){
    goyslop_vector=goyslop_vector_og+Vector(x,y,z)-Vector(0,4096,0);
    spinning.SpawnEntityAtLocation(goyslop_vector,Vector(0,0,0));
}

function zm_shooter(){
    if (!activator) return false;
    local x = RandomInt(-500,500);
    local y = 750;
    local z = 1984;
    local speed = null;
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (player==activator){
            speed = Vector(x,y,z);
            player.SetVelocity(speed);
        }
    } 
}

function zm_outta_muh_car(direction){
    if (!activator) return false;
    local x = direction * 1000;
    local y = RandomInt(-500,500);
    local z = 1500;
    local speed = null;
    local sound_ent = null;
    local sfx_time = 1.5; 
    for (local player = null; player = Entities.FindByClassname(player, "player");){
        if (player==activator && player.GetTeam()==2){
            speed = Vector(x,y,z);
            player.SetVelocity(speed);
            sfx_play("sfx", player.GetOrigin(), zm_boost_sfx, 2500, 0, 10, player.GetName(), 48); 
        }
    } 
}

//*****************************
//player tp sorting for vents
//*****************************
::counter<-0;
tp_1<-Entities.FindByName(null, "vents_tp_1");
tp_2<-Entities.FindByName(null, "vents_tp_2");
tp_3<-Entities.FindByName(null, "vents_tp_3");
tp_4<-Entities.FindByName(null, "vents_tp_4");
tp_trigger<-Entities.FindByName(null, "helldoors_funnel_tp_trigger");
//
zm_tp_1<-Entities.FindByName(null, "zm_teleport_2_1");
zm_tp_2<-Entities.FindByName(null, "zm_teleport_2_2");
zm_tp_3<-Entities.FindByName(null, "zm_teleport_2_3");
zm_tp_4<-Entities.FindByName(null, "zm_teleport_2_4");
zm_tp_trigger<-Entities.FindByName(null, "zm_teleport_trigger_2");

function player_sort(){
    counter++;
    if(counter==1){
        tp_trigger.__KeyValueFromString("target", "vents_tp_1");
    }
    else if(counter==2){
        tp_trigger.__KeyValueFromString("target", "vents_tp_2");
    }
    else if(counter==3){
        tp_trigger.__KeyValueFromString("target", "vents_tp_3");
    }
    else if(counter==4){
        tp_trigger.__KeyValueFromString("target", "vents_tp_4");
        counter=0;
    }
}

function zombie_sort(){
    counter++;
    if(counter==1){
        zm_tp_trigger.__KeyValueFromString("target", "zm_teleport_2_1");
    }
    else if(counter==2){
        zm_tp_trigger.__KeyValueFromString("target", "zm_teleport_2_2");
    }
    else if(counter==3){
        zm_tp_trigger.__KeyValueFromString("target", "zm_teleport_2_3");
    }
    else if(counter==4){
        zm_tp_trigger.__KeyValueFromString("target", "zm_teleport_2_4");
        counter=0;
    }
}

//******************************
//puzzle cube shit
//******************************
::puzzle_number<-0;
::puzzles<-{
    [1] = "puzzle_path_trigger_1",
    [2] = "evil_dungeon_generator"
}

// *********** spawn all the puzzle cube shit, x is which puzzle it is (there are only two)
function initialize(x){
    cube_animation_pitch<-0;
    pitch<-0;
    roll<-0;
    yaw<-0; 
    offset<-0.05;
    delay<-2.3;
    puzzle_room_generate(x);    
    pitch_up<-Entities.FindByName(null, "puzzle_cube_pitch_up");
    pitch_down<-Entities.FindByName(null, "puzzle_cube_pitch_down");
    roll_left<-Entities.FindByName(null, "puzzle_cube_roll_left");
    roll_right<-Entities.FindByName(null, "puzzle_cube_roll_right");    
    yaw_left<-Entities.FindByName(null, "puzzle_cube_yaw_left");
    yaw_right<-Entities.FindByName(null, "puzzle_cube_yaw_right");
    pitch_up_sprite<-Entities.FindByName(null, "pitch_up_sprite");
    pitch_down_sprite<-Entities.FindByName(null, "pitch_down_sprite");
    roll_left_sprite<-Entities.FindByName(null, "roll_left_sprite");
    roll_right_sprite<-Entities.FindByName(null, "roll_right_sprite");    
    yaw_left_sprite<-Entities.FindByName(null, "yaw_left_sprite");
    yaw_right_sprite<-Entities.FindByName(null, "yaw_right_sprite");  
    solved_sprite<-Entities.FindByName(null, "solved_sprite");          
    puzzle_cube<-Entities.FindByName(null, "puzzle_cube");
    puzzle_cube_func_door<-Entities.FindByName(null, "puzzle_cube_func_door");
    rotating_puzzle_room<-Entities.FindByName(null, "rotating_puzzle_room");
    rotating_puzzle_room_trigger<-Entities.FindByName(null, "rotating_puzzle_room_trigger");
    puzzle_room_roll_left<-Entities.FindByName(null, "puzzle_room_roll_left");
    puzzle_room_roll_right<-Entities.FindByName(null, "puzzle_room_roll_right");
    puzzle_room_yaw_left<-Entities.FindByName(null, "puzzle_room_yaw_left");
    puzzle_room_yaw_right<-Entities.FindByName(null, "puzzle_room_yaw_right");
    puzzle_room_pitch_up<-Entities.FindByName(null, "puzzle_room_pitch_up");
    puzzle_room_pitch_down<-Entities.FindByName(null, "puzzle_room_pitch_down");
    intialize_sprites();
    puzzle_number=x;
}

// *********** generate the puzzle room, x is which puzzle it is
function puzzle_room_generate(x){
    local puzzle = Entities.FindByName(null, "puzzle_cube_maker_"+x);
    local arrows = Entities.FindByName(null, "puzzle_cube_arrows_maker_"+x);
    local fucking_vector = puzzle.GetOrigin();  
    local z=0;  
    if(x==2){
        z=90;
    }
    puzzle.SpawnEntityAtLocation(fucking_vector,Vector(0,0,0));
    arrows.SpawnEntityAtLocation(fucking_vector,Vector(0,0,0));
    local room = Entities.FindByName(null, "rotating_puzzle_room_maker_"+x);
    local doors = Entities.FindByName(null, "puzzle_room_func_doors_maker_"+x);
    fucking_vector = room.GetOrigin();
    local fucking_funny_vector = Vector(0,RandomInt(1,3)*z,0);
    room.SpawnEntityAtLocation(fucking_vector,fucking_funny_vector);
    doors.SpawnEntityAtLocation(fucking_vector,Vector(0,0,0));
}

// *********** lockout the buttons when one is pressed while shit is happening
function lock_all(){
    EntFireByHandle(pitch_up_sprite,"HideSprite","",0,"","");
    EntFireByHandle(pitch_down_sprite,"HideSprite","",0,"","");
    EntFireByHandle(yaw_left_sprite,"HideSprite","",0,"","");
    EntFireByHandle(yaw_right_sprite,"HideSprite","",0,"","");   
    EntFireByHandle(pitch_up,"Lock","",0,"","");
    EntFireByHandle(pitch_down,"Lock","",0,"","");
    EntFireByHandle(yaw_left,"Lock","",0,"","");
    EntFireByHandle(yaw_right,"Lock","",0,"","");   
    EntFire("pitch_up_arrow*","HideSprite","",0,"");
    EntFire("pitch_down_arrow*","HideSprite","",0,"");
    EntFire("yaw_right_arrow*","HideSprite","",0,"");
    EntFire("yaw_left_arrow*","HideSprite","",0,"");
    boost_on();    
}

// *********** turn on booster inside cube and enable teleport so people don't get stuck
function boost_on(){
    EntFire("puzzle_cube_boost*", "Enable", "", 0.01, "");
    EntFire("puzzle_cube_tp_trigger","Enable","",0.1,"");
    boost_off();
}

// *********** turn off booster and tp
function boost_off(){
    EntFire("puzzle_cube_boost*", "Disable", "", 2, "");
    EntFire("puzzle_cube_tp_trigger","Disable","",2.1,"");
}

// *********** unlock all the buttons after the delay
function unlock_all(unlock_delay){
    EntFireByHandle(pitch_up_sprite,"ShowSprite","",unlock_delay,"","");
    EntFireByHandle(pitch_down_sprite,"ShowSprite","",unlock_delay,"","");
    EntFireByHandle(yaw_left_sprite,"ShowSprite","",unlock_delay,"","");
    EntFireByHandle(yaw_right_sprite,"ShowSprite","",unlock_delay,"","");   
    EntFireByHandle(pitch_up,"Unlock","",unlock_delay,"","");
    EntFireByHandle(pitch_down,"Unlock","",unlock_delay,"","");
    EntFireByHandle(yaw_left,"Unlock","",unlock_delay,"","");
    EntFireByHandle(yaw_right,"Unlock","",unlock_delay,"","");   
    EntFire("yaw_right_arrow_right_sprite","ShowSprite","",unlock_delay,"");
    EntFire("yaw_left_arrow_left_sprite","ShowSprite","",unlock_delay,"");    

    if(yaw==90){
        EntFire("pitch_up_arrow_left_sprite","ShowSprite","",unlock_delay,"");  
        EntFire("pitch_down_arrow_right_sprite","ShowSprite","",unlock_delay,"");
    }
    else if(yaw==180){
        EntFire("pitch_up_arrow_down_sprite","ShowSprite","",unlock_delay,"");  
        EntFire("pitch_down_arrow_up_sprite","ShowSprite","",unlock_delay,"");        
    }
    else if(yaw==270){
        EntFire("pitch_up_arrow_right_sprite","ShowSprite","",unlock_delay,"");  
        EntFire("pitch_down_arrow_left_sprite","ShowSprite","",unlock_delay,"");        
    }
    else{
        EntFire("pitch_up_arrow_up_sprite","ShowSprite","",unlock_delay,"");  
        EntFire("pitch_down_arrow_down_sprite","ShowSprite","",unlock_delay,"");        
    }

}

// *********** show the sprites for the buttons
function intialize_sprites(){
    EntFireByHandle(pitch_up_sprite,"ShowSprite","",0,"","");
    EntFireByHandle(pitch_down_sprite,"ShowSprite","",0,"","");
    EntFireByHandle(yaw_left_sprite,"ShowSprite","",0,"","");
    EntFireByHandle(yaw_right_sprite,"ShowSprite","",0,"","");    
    EntFire("pitch_up_arrow_up_sprite","ShowSprite","",0,"");      
    EntFire("pitch_down_arrow_down_sprite","ShowSprite","",0,"");
    EntFire("yaw_left_arrow_left_sprite","ShowSprite","",0,"");  
    EntFire("yaw_right_arrow_right_sprite","ShowSprite","",0,"");
}

// YES THESE ARE FUCKED BUT IT'S EVEN MORE FUCKED TO FIX IT RIGHT NOW
// PITCH UP, YAW RIGHT, ROLL LEFT = POSITIVE
// PITCH DOWN, YAW LEFT, ROLL RIGHT = NEGATIVE

// *********** rotate the puzzle cube by the parameter
function rotate(how){
    EntFireByHandle(rotating_puzzle_room_trigger,"Disable","",0,"","");
    EntFireByHandle(rotating_puzzle_room, "SetParent", how, 0, "", "");
    EntFire(how, "Open", "" , 2*offset, "");
    EntFireByHandle(rotating_puzzle_room, "ClearParent", "", delay, "", "");
    EntFire(how, "Close", "" , delay + 2*offset, "");
    EntFire(puzzles[puzzle_number].tostring(),"Wake","",delay-0.02);
    EntFire(puzzles[puzzle_number].tostring(),"Wake","",delay-0.01);  
    EntFire(puzzles[puzzle_number].tostring(),"Wake","",delay);    
    EntFireByHandle(rotating_puzzle_room_trigger,"Enable","",delay,"","");   
    unlock_all(5);    
}

// *********** rotate pitch up
function rotate_room_pitch_up(){
    lock_all();
    pitch=pitch+90;
    if(pitch>=360){
        pitch=0;
    }
    rotate("puzzle_room_pitch_up");
}

// *********** rotate pitch down
function rotate_room_pitch_down(){ 
    lock_all();    
    pitch=pitch-90;
    if(pitch<0){
        pitch=270;
    }    
    rotate("puzzle_room_pitch_down");
}

// *********** rotate yaw right
function rotate_room_yaw_right(){
    lock_all();       
    yaw=yaw+90;
    if(yaw>=360){
        yaw=0;
    }    
    rotate("puzzle_room_yaw_right"); 
}

// *********** rotate yaw left
function rotate_room_yaw_left(){
    lock_all();       
    yaw=yaw-90;
    if(yaw<0){
        yaw=270;
    }    
    rotate("puzzle_room_yaw_left");    
}

// *********** rotate roll left
function rotate_room_roll_left(){
    lock_all();      
    roll=roll+90;
    if(pitch>=360){
        roll=0;
    }            
    rotate("puzzle_room_roll_left");      
}

// *********** rotate roll right
function rotate_room_roll_right(){
    lock_all();      
    roll=roll-90;
    if(roll<0){
        roll=270;
    }       
    rotate("puzzle_room_roll_right");  
}

// *********** rotate the puzzle itself
function rotate_puzzle(){
    EntFireByHandle(puzzle_cube, "SetParent", "puzzle_cube_func_door", 0, "", "");
    EntFireByHandle(puzzle_cube_func_door, "Open", "" , 0, "", "");
    EntFireByHandle(puzzle_cube, "ClearParent", "", delay, "", "");
    EntFireByHandle(puzzle_cube_func_door, "Close", "" , delay, "", "");
}

// *********** change the puzzle animation to match up with the given command
function cube_puzzle_pitch_up(){ 
    cube_animation_pitch=cube_animation_pitch+90;
    if(cube_animation_pitch>=360){
        cube_animation_pitch=0;
    }
    if(yaw==0){
        rotate_room_pitch_up();
    } 
    else if(yaw==90){
        rotate_room_roll_left();
    }
    else if(yaw==180){     
        rotate_room_pitch_down();
    }
    else if(yaw==270){
        rotate_room_roll_right()
    }
    if(cube_animation_pitch==90){
        EntFireByHandle(puzzle_cube, "SetAnimation", "spin_head_0r", 0, "", "");
        EntFireByHandle(puzzle_cube, "SetAnimation", "idle_head_0r", 1, "", "");
    }
    else if(cube_animation_pitch==180){
        EntFireByHandle(puzzle_cube, "SetAnimation", "spin_head_1r", 0, "", "");
        EntFireByHandle(puzzle_cube, "SetAnimation", "idle_head_1r", 1, "", "");
    }
    else if(cube_animation_pitch==270){
        EntFireByHandle(puzzle_cube, "SetAnimation", "spin_head_2r", 0, "", "");
        EntFireByHandle(puzzle_cube, "SetAnimation", "idle_head_2r", 1, "", "");
    }
    else if(cube_animation_pitch==0){
        EntFireByHandle(puzzle_cube, "SetAnimation", "spin_head_3r", 0, "", "");
        EntFireByHandle(puzzle_cube, "SetAnimation", "idle_head_3r", 1, "", "");
    } 
}

// *********** change the puzzle animation to match up with the given command
function cube_puzzle_pitch_down(){
    cube_animation_pitch=cube_animation_pitch-90;
    if(cube_animation_pitch<0){
        cube_animation_pitch=270;
    }
    if(yaw==0){ 
        rotate_room_pitch_down();
    } 
    else if(yaw==90){
        rotate_room_roll_right();
    }
    else if(yaw==180){
        rotate_room_pitch_up();
    }
    else if(yaw==270){
        rotate_room_roll_left()
    }
    if(cube_animation_pitch==270){
        EntFireByHandle(puzzle_cube, "SetAnimation", "spin_head_0", 0, "", "");
        EntFireByHandle(puzzle_cube, "SetAnimation", "idle_head_0", 1, "", "");
    }
    else if(cube_animation_pitch==180){
        EntFireByHandle(puzzle_cube, "SetAnimation", "spin_head_1", 0, "", "");
        EntFireByHandle(puzzle_cube, "SetAnimation", "idle_head_1", 1, "", "");
    }
    else if(cube_animation_pitch==90){
        EntFireByHandle(puzzle_cube, "SetAnimation", "spin_head_2", 0, "", "");
        EntFireByHandle(puzzle_cube, "SetAnimation", "idle_head_2", 1, "", "");
    }
    else if(cube_animation_pitch==0){
        EntFireByHandle(puzzle_cube, "SetAnimation", "spin_head_3", 0, "", "");
        EntFireByHandle(puzzle_cube, "SetAnimation", "idle_head_3", 1, "", "");
    }
}

// *********** rotates the puzzle through a func_door
function cube_puzzle_yaw_right(){
    puzzle_cube_func_door.SetAngles(0,0,0);
    rotate_puzzle();
    rotate_room_yaw_right();   
}

// *********** rotates the puzzle through a func_door
function cube_puzzle_yaw_left(){
    puzzle_cube_func_door.SetAngles(0,180,0);
    rotate_puzzle();
    rotate_room_yaw_left();
}

// *********** remove sprites
function clean_up(){
    EntFireByHandle(solved_sprite,"ShowSprite","",0,"","");
    pitch_up_sprite.Destroy();
    pitch_down_sprite.Destroy();
    yaw_left_sprite.Destroy();
    yaw_right_sprite.Destroy(); 
    EntFireByHandle(pitch_up,"Kill", "", 0, "", "");
    EntFireByHandle(pitch_down,"Kill", "", 0, "", "");
    EntFireByHandle(yaw_left,"Kill", "", 0, "", "");
    EntFireByHandle(yaw_right,"Kill", "", 0, "", "");  
    EntFire("pitch_up_arrow*","Kill","",0,"");    
    EntFire("pitch_down_arrow*","Kill","",0,"");
    EntFire("yaw_left_arrow*","Kill","",0,"");
    EntFire("yaw_right_arrow*","Kill","",0,"");
}

// *********** buttons and unneeded entities
function clean_all(){
    EntFireByHandle(rotating_puzzle_room, "Break", "", 0,"","");
    EntFire("puzzle_cube_boost*","Kill","",0,""); 
    EntFireByHandle(puzzle_room_pitch_down,"Kill","",0,"","");
    EntFireByHandle(puzzle_room_pitch_up,"Kill","",0,"","");
    EntFireByHandle(puzzle_room_roll_left,"Kill","",0,"","");
    EntFireByHandle(puzzle_room_roll_right,"Kill","",0,"","");
    EntFireByHandle(puzzle_room_yaw_left,"Kill","",0,"","");
    EntFireByHandle(puzzle_room_yaw_right,"Kill","",0,"","");  
    EntFire("puzzle_room_sound","Kill","",0,"");
    EntFire("rotating_puzzle_room_trigger","Kill","",0,"");
    solved_sprite.Destroy();
    EntFireByHandle(puzzle_cube,"Kill","",0,"","");
    EntFireByHandle(puzzle_cube_func_door,"Kill","",0,"","");
    EntFire("puzzle_cube_sound","Kill","",0,"");
    EntFire("puzzle_cube_tp_trigger","Kill","",0,"");
    EntFire("puzzle_cube_tp","Kill","",0.01,"");
}

// *********** remove last of entities after last puzzle is solved
function final_clean_up(){
    EntFireByHandle(solved_sprite,"HideSprite","",0,"","");
    EntFireByHandle(puzzle_cube,"Kill","",0,"","");    
}

// *********** fogvolume functions
function office_backroom_smokevolume_funny(){
    local smoke_vol = Entities.FindByName(null,"office_backroom_smokevolume");
    //local particle_width = RandomInt(1,256);
    //local particle_spacing = RandomInt(256,512);
    local rotation = RandomInt(1,180);
    local speed = RandomInt(1,100);
    local density = RandomFloat(0.1,1);
    //smoke_vol.__KeyValueFromInt("ParticleDrawWidth",particle_width);
    //smoke_vol.__KeyValueFromInt("ParticleSpacingDistance",particle_spacing);
    smoke_vol.__KeyValueFromInt("RotationSpeed",rotation);
    smoke_vol.__KeyValueFromInt("MovementSpeed",speed);
    EntFireByHandle(smoke_vol, "SetDensity", density, 0, "", "");
}

function spawn_smokevolume_funny(){
    local smoke_vol = Entities.FindByName(null,"spawn_smokevolume");
    //local particle_width = RandomInt(32,64);
    //local particle_spacing = RandomInt(128,256);
    local rotation = RandomInt(1,10);
    local speed = RandomInt(1,10);
    local density = RandomFloat(0.5,1);
    //smoke_vol.__KeyValueFromInt("ParticleDrawWidth",particle_width);
    //smoke_vol.__KeyValueFromInt("ParticleSpacingDistance",particle_spacing);
    smoke_vol.__KeyValueFromInt("RotationSpeed",rotation);
    smoke_vol.__KeyValueFromInt("MovementSpeed",speed);
    smoke_vol.__KeyValueFromString("Color1",RandomInt(0,255).tostring() + " " + RandomInt(0,255).tostring() + " " + RandomInt(0,255).tostring());
    smoke_vol.__KeyValueFromString("Color2",RandomInt(0,255).tostring() + " " + RandomInt(0,255).tostring() + " " + RandomInt(0,255).tostring());
    EntFireByHandle(smoke_vol, "SetDensity", density, 0, "", "");
}