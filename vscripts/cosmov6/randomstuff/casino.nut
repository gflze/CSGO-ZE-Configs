Cappers <- [];
map_brush <- Entities.FindByName(null, "map_brush");
class Bet
{
    handle = null;
    bet = 0;
    color = null;
    constructor(_handle,_color)
    {
        handle = _handle;
        color = _color;
    }
    function GetColor()
    {
        if(this.color == -1) return "Cactus";
        if(this.color == 0) return "Moogle";
        else return "Chocobo";
    }
    function GetWinmoney()
    {
        if(color == -1) return this.bet + this.bet * 10;
        else return this.bet + this.bet * 0.5;
    }
}
int_array <- [0,32,15,19,4,21,2,25,17,34,
        6,27,13,36,11,30,8,23,10,5,
        24,16,33,1,20,14,31,9,22,18,
        29,7,28,12,35,3,26];
int <- 0;
alloy_bet <- true;
Rolling <- false;

Start <- false;

RollSpeed <- 8;

Colorbonus <- [10,0.5]
cash <- 500;
RollIter <- [2,4];
RollTime <- [3,4];

rolltimer <- null;
function OnPostSpawn()
{
    int = RandomInt(0,int_array.len()-1);
    SetColor()
    EntFireByHandle(self, "FireUser1", "" 0.05, null, null);
}

function ConnectToGame(i)
{
    if(cash < Cappers.len() * 250)
    {
        //printl("NO money")
        return;
    }
    if(!alloy_bet)
    {
        //printl("NOT alloy bet")
        return;
    }
    local pl = GetPlayerClassByHandle(activator)
    if(pl == null)
    {
        local p = Bet(activator,i)
        Cappers.push(p);
        //printl("NEW")
    }
    else
    {
        pl.color = i;
        //printl("CHANGE COLOR")
    }
    if(!Start)
    {
        Start = true;
        EntFireByHandle(self, "RunScriptCode", "StartRoll();", 5, activator, activator);
    }
    
    EntFireByHandle(self, "RunScriptCode", "Info();", 0, activator, activator);
}

function StartRoll()
{
    if(Cappers.len() == 0 || !alloy_bet)return Reset();
    alloy_bet = false;
    for (local i = 0; i < Cappers.len(); i++)
    {
        if(Cappers[i].bet == 0 || Cappers[i].color == null || !Cappers[i].handle.IsValid())
        {
            Cappers.remove(i);
        }
    }
    if(Cappers.len() == 0)return Reset();

    EntFire("sound_casino", "PlaySound", "", 0, null);

    rolltimer = Time(); 
    Rolling = true;
    local time = RandomInt(RollTime[0],RollTime[1]);
    EntFireByHandle(self, "RunScriptCode", "Roll();", 0.5, null, null);
    EntFireByHandle(self, "RunScriptCode", "StopRoll();", time, null, null);
}

function Reset()
{
    Start = false;
    alloy_bet = true;
    RollSpeed = 8;
    if(Cappers.len() == 0)return;
    Cappers.clear();
}

function Roll()
{
    if(int_array[int] == int_array[int_array.len()-1])int = 0;
    else int++;
    SetColor()
    if(Rolling)
    {
        EntFireByHandle(self, "RunScriptCode", "Roll();", (0.25 + GetSpeed()).tofloat(), null, null);
    }
}

function GetSpeed()
{
    local nspeed = RollSpeed / 50;
    RollSpeed++;
    return nspeed;
}

function StopRoll()
{
    Rolling = false;
    local time = 1;
    for (time; time < RandomInt(RollIter[0],RollIter[1]+1); time++)
    {
        EntFireByHandle(self, "RunScriptCode", "Roll();", time - 0.25, null, null);
    }
    EntFireByHandle(self, "RunScriptCode", "GetWinners();", time + 0.1, null, null);
}

function SetColor()
{

    local textb;
    local textm;
    local textf;

    if(int == 0)textb = int_array[int_array.len()-1]
    else textb = int_array[int - 1]

    if(textb == 0)EntFireByHandle(EntityGroup[1], "SetMaterialVar", "0", 0, null, null);
    else if(textb % 2 == 0)EntFireByHandle(EntityGroup[1], "SetMaterialVar", "1", 0, null, null);
    else EntFireByHandle(EntityGroup[1], "SetMaterialVar", "2", 0, null, null);


    textm = int_array[int];
    if(textm == 0)EntFireByHandle(EntityGroup[0], "SetMaterialVar", "0", 0, null, null);
    else if(textm % 2 == 0)EntFireByHandle(EntityGroup[0], "SetMaterialVar", "1", 0, null, null);
    else EntFireByHandle(EntityGroup[0], "SetMaterialVar", "2", 0, null, null);

    if(int == int_array.len()-1)textf = int_array[0]
    else textf = int_array[int + 1]

    if(textf == 0)EntFireByHandle(EntityGroup[2], "SetMaterialVar", "0", 0, null, null);
    else if(textf % 2 == 0)EntFireByHandle(EntityGroup[2], "SetMaterialVar", "1", 0, null, null);
    else EntFireByHandle(EntityGroup[2], "SetMaterialVar", "2", 0, null, null);
}

function GetWinners()
{
    local winColor = 0
    local bonus = Colorbonus[1];
    if(int_array[int] == 0)
    {
        bonus = Colorbonus[0];
        winColor = -1
        ScriptPrintMessageChatAll(Casino_pref + "Cactus win");
    }
    else if(int_array[int] % 2 == 0)
    {
        winColor = 1
        ScriptPrintMessageChatAll(Casino_pref + "Chocobo win");
    }
    else ScriptPrintMessageChatAll(Casino_pref + "Moogle win");


    foreach(p in Cappers)
    {
        if(p.handle.IsValid())
        {
            if(p.color == winColor)
            {
                local money = p.bet + p.bet * bonus;
                map_brush.GetScriptScope().GetPlayerClassByHandle(p.handle).Add_money(money);
                cash -= money;
                ShowText("You Win\n" + p.bet * bonus + Money_pref, p.handle);
            }
            else ShowText("You Lose\n" + p.bet + Money_pref, p.handle);
        }
    }
    EntFireByHandle(self, "RunScriptCode", "Reset();", 5, null, null);
}

function Info()
{
    local text = "Cosmo casino";
    local pl = GetPlayerClassByHandle(activator);
    local pl_money = map_brush.GetScriptScope().GetPlayerClassByHandle(activator).money;
    if(pl != null)
    {
        if(pl.color != null)
        {
            text += "\nColor : "+pl.GetColor();
            text += "\nBet : "+pl.bet
            if(pl.bet)
            {
                text += " -> "+pl.GetWinmoney();
            }
        }
    }
    text += "\n\nYour balance " + pl_money + Money_pref;
    ShowText(text, activator);
}

function SetBet(i)
{
    if(!alloy_bet)
    {
        ShowText("the game is already underway", activator);
        //printl("NOT alloy bet")
        return;
    }
    local pl = GetPlayerClassByHandle(activator);
    if(!pl)
    {
        ShowText("Сhoose color first", activator);
        //printl("NOT REG")
        return;
    }
    local money = map_brush.GetScriptScope().GetPlayerClassByHandle(activator).money;
    if(money - i >= 0)
    {
        pl.bet += i;
        cash += i;
        map_brush.GetScriptScope().GetPlayerClassByHandle(activator).Minus_money(i);
        EntFireByHandle(self, "RunScriptCode", "Info();", 0, activator, activator);
    }
    else
    {
        ShowText("You don't have enough money", activator);
        //printl("need more money");
    }
}

function GetPlayerClassByHandle(handle)
{
	foreach(p in Cappers)
	{
		if(p.handle == handle)
		{
            return p;
		}
	}
	return null;
}

function ShowText(text, activator)
{
    if(DisableHudHint)
        return MainScript.GetScriptScope().ShowPlayerText(activator, text);
    EntityGroup[3].__KeyValueFromString("message",text);
    EntFireByHandle(EntityGroup[3], "ShowHudHint", "", 0, activator, activator);
}