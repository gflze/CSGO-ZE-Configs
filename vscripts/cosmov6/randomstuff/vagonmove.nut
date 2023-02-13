bMove_Forvard <- true;

function Move()
{
    if(bMove_Forvard)
    {
        EntFire("Ebaniy_Freind_Move","StartForward","", 3,null);
        CloseDoor(1);
        bMove_Forvard = false;
    }
    else
    {
        EntFire("Ebaniy_Freind_Move","StartBackward","", 3,null);
        CloseDoor(1);
        bMove_Forvard = true;
    }
}

function CloseDoor(time)
{
    EntFire("Ebaniy_Freind_Door_*", "Close", "",time, null);
}

function OpenDoor(time)
{
    EntFire("Ebaniy_Freind_Door_*", "open", "",time, null);
}