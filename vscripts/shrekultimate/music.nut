class class_music
{
    path = "";
    constructor(_path,)
    {
        this.path = _path;
    }
}

::Music_1_1 <- class_music("SHREK/music/Bad_Reputation.mp3"); self.PrecacheScriptSound( Music_1_1.path );
::Music_1_2 <- class_music("SHREK/music/It_Is_You.mp3"); self.PrecacheScriptSound( Music_1_2.path );
::Music_1_3 <- class_music("SHREK/music/Self_Stay_Home.mp3"); self.PrecacheScriptSound( Music_1_3.path );
::Music_1_4 <- class_music("SHREK/music/Shrek_2_Livin_la_vida_loca.mp3"); self.PrecacheScriptSound( Music_1_4.path );
::Music_1_5 <- class_music("SHREK/music/Shrek_2_Soundtrack_5.mp3"); self.PrecacheScriptSound( Music_1_5.path );
::Music_1_6 <- class_music("SHREK/music/Smash_Mouth.mp3"); self.PrecacheScriptSound( Music_1_6.path );
::Music_2 <- class_music("SHREK/music/Hallelujah.mp3"); self.PrecacheScriptSound( Music_2.path );
::Music_3 <- class_music("SHREK/music/Shrek_2_Soundtrack_14.mp3"); self.PrecacheScriptSound( Music_3.path );

::mg1 <- class_music("SHREK/music/mg1.mp3"); self.PrecacheScriptSound( mg1.path );
::mg2 <- class_music("SHREK/music/mg2.mp3"); self.PrecacheScriptSound( mg2.path );
::mg3 <- class_music("SHREK/music/mg3.mp3"); self.PrecacheScriptSound( mg3.path );

::Music_Some_body_slowed <- class_music("SHREK/music/Some_body(slowed).mp3"); self.PrecacheScriptSound( Music_Some_body_slowed.path );
::Music_Some_body_stretch <- class_music("SHREK/music/Some_body(stretch).mp3"); self.PrecacheScriptSound( Music_Some_body_stretch.path );
::Music_Some_body_clasic <- class_music("SHREK/music/Some_body.mp3"); self.PrecacheScriptSound( Music_Some_body_clasic.path );

Current_Sound <- null;

function SetMusic(Name)
{
    Current_Sound = Name;

    EntFireByHandle(self,"StopSound", "",0,null,null);
    EntFireByHandle(self,"Volume", "0",0,null,null);
    EntFireByHandle(self,"AddOutPut", "message " + Name.path, 0.02,null,null);
    EntFireByHandle(self,"PlaySound", "", 0.05,null,null);   
}

function GetRandomMusic()
{
    local rand = (RandomInt(1,6))
    if (rand == 1)
        SetMusic(Music_1_1)

    else if(rand == 2)
        SetMusic(Music_1_2)

    else if(rand == 3)
        SetMusic(Music_1_3)

    else if(rand == 4)
        SetMusic(Music_1_4)

    else if(rand == 5)
        SetMusic(Music_1_5)

    else if(rand == 6)
        SetMusic(Music_1_6)
}