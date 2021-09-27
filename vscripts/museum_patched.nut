//#####################################################################
//Patched version intended for use with GFL ze_mapeadores_museum_v1 stripper
//Disables Final Funtasy level
//Install as csgo/scripts/vscripts/gfl/museum_patched.nut
//#####################################################################

// ------------------------------------------------------------------------------
// Mapeadores Museum - Vscript functions
//
// This is a self-contained vscript file to define all the maps in the museum.
// It provides randomization and minimal setup of the maps.
// ------------------------------------------------------------------------------
const NONE = "";
const SERVER_COMMAND = "Console";
const PAINTING_POSITION_ENTS_PREFIX = "MuseumPaintingPosition";
const PAINTING_PREFIX = "MapPainting";
const MAP_NAME_DISPLAY_PREFIX = "MuseumPaintingName";
const AUTHOR_DISPLAY_PREFIX = "MuseumPaintingAuthor";
const VOTE_COUNT_PREFIX = "MuseumPaintingVotes";
const HUMAN_AREA_TELEPORT = "MuseumHumanTeleport";
const ZOMBIE_AREA_TELEPORT = "MuseumZombieTeleport";
const TELEPORT_EFFECT_RELAY = "MuseumTeleportEffect";
const NUM_PAINTINGS = 4;
mapover <- false;

class Map {
    name = null;
    author = null;
    humanDestination = null;
    zombieDestination = null;
    zombieDelay = null;
    relay = null;
    index = null;

    constructor(_name, _author, _humanDestination, _zombieDestination, _zombieDelay=5.0, _relay=NONE) {
        name = _name;
        author = _author;
        relay = _relay;
        humanDestination = _humanDestination;
        zombieDestination = _zombieDestination;
        zombieDelay = (_zombieDelay <= 12.0) ? _zombieDelay : 12.0;
    }
}

// ------------------------------------------------------------------------------
// Functional programming helpers
// ------------------------------------------------------------------------------
::any <- function(arr, f) {
    local newArr = [];
    foreach (index, value in arr) {
        if (f(value)) {
            return true;
        }
    }
    return false;
}

::all <- function(arr, f) {
    local newArr = [];
    foreach (index, value in arr) {
        if (!f(value)) {
            return false;
        }
    }
    return true;
}

::filter <- function(arr, f) {
    local newArr = [];
    foreach (index, value in arr) {
        if (f(value)) {
            newArr.push(value);
        }
    }
    return newArr;
}

::filterNot <- function(arr, f) {
    local newArr = [];
    foreach (index, value in arr) {
        if (!f(value)) {
            newArr.push(value);
        }
    }
    return newArr;
}

::map <- function(arr, f) {
    local newArr = [];
    foreach (index, value in arr) {
        newArr.push(f(value));
    }
    return newArr;
}

::identity <- function (x) {
    return x;
}

// ------------------------------------------------------------------------------
// Randomization helpers
// ------------------------------------------------------------------------------
function sampleWithoutReplacement(input, numSamples) {
    if (input.len() < numSamples) {
        return sampleWithoutReplacement(input, input.len())
    }

    local inputClone = ::map(input, ::identity);
    local samples = []
    for (local i = 0 ; i < numSamples ; i++) {
        local maxValue = inputClone.len();
        local randomIndex = RandomInt(0, maxValue - 1);
        local returnedSample = inputClone.remove(randomIndex);
        samples.push(returnedSample);
    }
    return samples;
}

// ------------------------------------------------------------------------------
// Set up the museum area
// ------------------------------------------------------------------------------
::PLAYED_MAPS <- [];
::CURRENT_VOTE <- [];
::VOTE_COUNTS <- [];
::TOTAL_VOTES <- 0;
::CHOSEN_MAP <- null;

function initializeVotes() {
	if(mapover)return;
    ::CHOSEN_MAP <- null;
    ::VOTE_COUNTS.clear();
    ::TOTAL_VOTES <- 0;
    for (local index = 0; index < NUM_PAINTINGS ; index++) {
        ::VOTE_COUNTS.push(0);
    }
}

function addVoteForMapIndex(index) {
	if(mapover)return;
    ::VOTE_COUNTS[index - 1] += 1;
    ::TOTAL_VOTES += 1;
}

function updateVoteDisplay() {
	if(mapover)return;
    local votes = ::map(::VOTE_COUNTS, function (x) { return (100 * x / (::TOTAL_VOTES > 0? ::TOTAL_VOTES : 1)).tointeger().tostring(); })
    local currentWinner = getCurrentWinner();
    for (local index = 1; index <= NUM_PAINTINGS ; index++) {
        local voteDisplay = Entities.FindByName(null, VOTE_COUNT_PREFIX + index);
        if (index > ::CURRENT_VOTE.len()) {
            voteDisplay.__KeyValueFromString("message", "");
        } else {
            local voteCount = votes[index - 1];
            local displayString = voteCount + "%";
            if (index - 1 == currentWinner) {
                displayString = displayString + " (leading)";
            }
            voteDisplay.__KeyValueFromString("message", displayString);
        }
    }
}

function getCurrentWinner() {
	if(mapover)return;
    local maxVoteIndex = 0;
    foreach (idx, value in ::VOTE_COUNTS) {
        if (value > ::VOTE_COUNTS[maxVoteIndex]) {
            maxVoteIndex = idx;
        }
    }
    return maxVoteIndex;
}

function disableTeleports() {
	if(mapover)return;
    //local humanTp = Entities.FindByName(null, HUMAN_AREA_TELEPORT);			//multiple human triggers now (test5)
    local zombieTp = Entities.FindByName(null, ZOMBIE_AREA_TELEPORT);
    EntFire(HUMAN_AREA_TELEPORT, "Disable", "", 0.0, self);
    EntFireByHandle(zombieTp, "Disable", "", 0.0, self, self);
}

function selectWinningMap() {
	if(mapover)return;
    if (::CHOSEN_MAP == null) {
        local maxVoteIndex = getCurrentWinner();
        ::CHOSEN_MAP = ::CURRENT_VOTE[maxVoteIndex];
		::PLAYED_MAPS.push(::CHOSEN_MAP.name);

        // Trigger the stuff in the map
        local message = "We will visit " + ::CHOSEN_MAP.name + " by " + ::CHOSEN_MAP.author + "!";
        local serverCommand = Entities.FindByName(null, SERVER_COMMAND);
        //local humanTp = Entities.FindByName(null, HUMAN_AREA_TELEPORT);		//multiple human triggers now (test5)
        local zombieTp = Entities.FindByName(null, ZOMBIE_AREA_TELEPORT);
        EntFireByHandle(serverCommand, "Command", "say ** " + message + " **", 1.0, self, self);

        // Set the teleport effects
        if (::CHOSEN_MAP.humanDestination != NONE) {
			EntFire(HUMAN_AREA_TELEPORT, "SetRemoteDestination", ::CHOSEN_MAP.humanDestination, 0.0, self);
			EntFire(HUMAN_AREA_TELEPORT, "Enable", "", 0.02, self);
            EntFire(TELEPORT_EFFECT_RELAY, "Trigger", "", 0.0, self);
        }

        if (::CHOSEN_MAP.zombieDestination != NONE) {
            zombieTp.__KeyValueFromString("target", ::CHOSEN_MAP.zombieDestination);
            EntFireByHandle(zombieTp, "Enable", "", ::CHOSEN_MAP.zombieDelay, self, self);
        }

        // Trigger the relay if needed
        if (::CHOSEN_MAP.relay != NONE) {
            EntFire(::CHOSEN_MAP.relay, "Trigger", "", 0.0, self);
        }

        // Move paintings back to where they belong
        foreach (index, map in ::CURRENT_VOTE) {
            local toMove = Entities.FindByName(null, PAINTING_PREFIX + map.index);
            EntFireByHandle(toMove, "RunScriptCode", "self.SetOrigin(oldOrigin);", ::CHOSEN_MAP.zombieDelay, self, self);
            EntFireByHandle(toMove, "RunScriptCode", "self.SetAngles(0, 0, 0);", ::CHOSEN_MAP.zombieDelay, self, self);
        }
    }
}

function hasBeenPlayed(map) {
    foreach (i, name in ::PLAYED_MAPS) {
        if (name == map.name) {
            return true;
        }
    }
    return false;
}

function selectMaps(maps) {
	if(mapover)return;
    local unplayedMaps = ::filterNot(maps, hasBeenPlayed);
    local mapsToVote = sampleWithoutReplacement(unplayedMaps, NUM_PAINTINGS);
    ::CURRENT_VOTE <- mapsToVote;

    // Initialize the maps
    initializeVotes();
    disableTeleports();

    // Iterate through the pictures and set them up
    foreach (index, map in mapsToVote) {
        local indexShifted = index + 1;
        local target = Entities.FindByName(null, PAINTING_POSITION_ENTS_PREFIX + indexShifted);
        local nameDisplay = Entities.FindByName(null, MAP_NAME_DISPLAY_PREFIX + indexShifted);
        local authorDisplay = Entities.FindByName(null, AUTHOR_DISPLAY_PREFIX + indexShifted);
        local toMove = Entities.FindByName(null, PAINTING_PREFIX + map.index);
        local currentPos = toMove.GetCenter();
        local position = target.GetCenter();
        local angles = target.GetAngles();

        // Move the painting, set the display texts
        toMove.SetOrigin(target.GetCenter());
        toMove.SetAngles(angles.x, angles.y, angles.z);
        nameDisplay.__KeyValueFromString("message", map.name);
        authorDisplay.__KeyValueFromString("message", map.author);
        EntFireByHandle(toMove, "RunScriptCode", "oldOrigin <- Vector(" + currentPos.x + ", " + currentPos.y + ", " + currentPos.z + ")", 0.0, self, self);
    }

    // Clean up the titles of art that can't be shown
    for (local index = mapsToVote.len() ; index < NUM_PAINTINGS ; index++) {
        local indexShifted = index + 1;
        local nameDisplay = Entities.FindByName(null, MAP_NAME_DISPLAY_PREFIX + indexShifted);
        local authorDisplay = Entities.FindByName(null, AUTHOR_DISPLAY_PREFIX + indexShifted);
        nameDisplay.__KeyValueFromString("message", "");
        authorDisplay.__KeyValueFromString("message", "");
		EntFire("MuseumPaintingTrigger" + indexShifted, "Disable", "", 0.0, self);
    }
}

function StageWinCheck()
{
	local text = Entities.FindByName(null,"secretlobbytextindic");
	local perm = Entities.FindByName(null,"permstage");
	perm.ValidateScriptScope();
	if(!("stagecount" in perm.GetScriptScope()))perm.GetScriptScope().stagecount <- 4;
	EntFireByHandle(text,"AddOutput","message Exhibitions to visit - "+perm.GetScriptScope().stagecount.tostring(),0.00,null,null);
	EntFire("NumMapsPerRound","AddOutput","max "+perm.GetScriptScope().stagecount.tostring(),0.00,null);
}
EntFireByHandle(self,"RunScriptCode"," StageWinCheck(); ",0.10,null,null);
function WonTheMap()
{
	local perm = Entities.FindByName(null,"permstage");
	perm.ValidateScriptScope();
	if(!("stagecount" in perm.GetScriptScope()))perm.GetScriptScope().stagecount <- 4;
	perm.GetScriptScope().stagecount++;
	EntFire("Console","Command","say ***YOU HAVE WON***",0.00,null);
	EntFire("Console","Command","say ***YOU HAVE WON***",0.01,null);
	EntFire("Console","Command","say ***YOU HAVE WON***",0.02,null);
	EntFire("Console","Command","say ***EXHIBITION VISITS INCREASED TO "+perm.GetScriptScope().stagecount.tostring()+"***",1.10,null);
	if(perm.GetScriptScope().stagecount >= 24)
	{
		perm.GetScriptScope().stagecount = 23;
		EntFire("Console","Command","say ***YOU HAVE BEATEN EVERYTHING IN ONE ROUND***",2.20,null);
		EntFire("Console","Command","say ***YOU'RE COMPLETELY INSANE***",3.21,null);
		EntFire("Console","Command","say ***MAP IS OVER - RTV***",4.22,null);
	}
	else
		EntFire("Console","Command","say ***HOW FAR CAN YOU TAKE IT?***",2.20,null);
}
function ResetPlayerStates()
{
	local h=null;while(null!=(h=Entities.FindByClassname(h,"player")))
	{
		if(h==null||!h.IsValid())continue;
		EntFireByHandle(h,"AddOutput","gravity 1.0",0.00,null,null);
		EntFireByHandle(h,"AddOutput","rendermode 0",0.00,null,null);
		EntFire("global_speeder","ModifySpeed","1.00",0.00,h);
		EntFireByHandle(h,"SetDamageFilter","",0.00,null,null);
		EntFireByHandle(h,"SetDamageFilter","",0.50,null,null);
		EntFireByHandle(h,"SetDamageFilter","",1.00,null,null);
		EntFireByHandle(h,"SetDamageFilter","",1.50,null,null);
		EntFireByHandle(h,"SetDamageFilter","",2.00,null,null);
		EntFireByHandle(h,"AddOutput","movetype 2",0.00,null,null);
	}
}

// ------------------------------------------------------------------------------
// Define your map here:
// ------------------------------------------------------------------------------
// - Map name.
// - Author.
// - Human teleport destination target.
// - Zombie teleport destination target.
// - Zombie teleport delay.
// - Relay (logic_relay) name to execute. Leave empty if you don't run anything.
// ------------------------------------------------------------------------------
maps <- [
	Map("Puzzler", "Envi", "td_PuzzlerInputTeleport", "td_PuzzlerInputTeleport", 5.0, "sr_puzzler"),						//0
	Map("Hallwaython Depot", "Envi", "td_HallwaythonHumanTp", "td_HallwaythonZombieTp", 0.0, "sr_hallwaython"),				//1
	Map("Rushdrake Tower","Luffaren","stage_luffaren_teleport_in","stage_luffaren_teleport_in",7.0,"stage_luffaren_start"),	//2
	Map("Vortal Coil", "Mavis", "td_MAVIS2048_Human_Start", "td_MAVIS2048_Zombie_Start", 5.0, "sr_mavis"),					//3
	Map("Clusterfuck", "chinny", "td_chinny_begin", "td_chinny_begin_zm", 0.0, "sr_chinny"),								//4
	Map("Oublithus", "Soft Serve", "td_softserve", "td_softserve", 7.0, "sr_softserve"),									//5
	Map("Fun House", "Pompje", "td_pompje_tpin_ct", "td_pompje_tpin_t", 5.0, "sr_pompje"),									//6
	Map("Action Sack", "The Ordiaxer", "td_ordaction_sack_CT", "td_ordaction_sack_T", 0.0, "sr_ord"),						//7
	Map("Deathrun", "Spaick", "td_spaicktp_ct", "td_spaicktp_t", 0.0, "sr_spaick"),											//8
	Map("SAD PEPE", "a sad green frog", "td_PP_START_HUMAN_TP", "td_PP_START_ZOMBIE_TP", 5.0, "sr_pp"),						//9
	Map("Ihcras_annoying_climbing_room", "Ihcra", "td_Ihcra_TeleportStart", "td_Ihcra_TeleportStartZM", 0.0, "sr_ihcra"),	//10
	Map("Colorful Mess", "T3RM1N4T0R :D", "td_termi_human_start", "td_termi_zombie_start", 0.0, "sr_termi"),				//11
	Map("Sauna Perkele", "Soft Serve", "td_sauna", "td_sauna", 5.0, "sr_sauna"),											//12
	Map("Spin Spiral Scene", "qazlll456", "td_qaz_tpp_spawn", "td_qaz_tpp_spawn", 7.0, "sr_qaz"),							//13
	Map("GOLEVATOR", "Hichatu", "td_hich_gol_tpin_ct", "td_hich_gol_tpin_t", 2.0, "sr_hich_gol"),							//14
	Map("Dystopia", "Hichatu", "td_hich_neon_tpin_ct", "td_hich_neon_tpin_ct", 4.0, "sr_hich_neon"),						//15
	Map("SSS-Lite", "Hichatu", "td_hich_sss_tpin_ct", "td_hich_sss_tpin_t", 3.5, "sr_hich_sss"),							//16
	Map("Dust2 Rush", "ZpLit", "td_zplit_TPstart", "td_zplit_TPstart", 5.0, "sr_zplit"),									//17
	Map("Zombie Shower", "Telo", "td_telo_humans_entry", "td_telo_zombies_entry", 5.0, "sr_telo"),							//18
    Map("AAAAAAAAAATIX", "chinny", "td_ynnihc", "td_ynnihc", 12.0 , "sr_ynnihc"),											//19
    Map("SuperSinkShow", "Envi", "td_SuperSinkShowTPDestination", "td_SuperSinkShowTPDestination",7.5,"sr_supersinkshow"),	//20
	//Map("Final Funtasy","Luffaren","stage_lff_tp_in","stage_lff_tp_in",0.50,"stage_lff_manager"),							//21
	Map("Quizmo Boner","Luffaren","stage_lqq_tp_in_h","stage_lqq_tp_in_z",0.0,"stage_lqq_manager"),							//21
    Map("Absolute Power","Mojonero","td_Mojo_human_start_destination","td_Mojo_zm_start_destination",1.0,"sr_mojo"),		//22
]
//TO TEST A STAGE:
//1) restart round
//2) type this into console while in the fountain-lobby-area:			ent_fire MuseumManagerScript RunScriptCode "maps <- [maps[4]];"
//		'4' would be "Clusterfuck", check the list above, change the number to the stage you want to test
//3) enter the vote-room by playing normally, it's now the only stage available to vote for

// Assign the index of each map to map it to the pictures
foreach (idx, m in maps) {
    m.index = idx + 1;
}

//This is a secret
//hi, how u doin
//u r disappoint
//i .nutted here, get the towel before mom finds it
