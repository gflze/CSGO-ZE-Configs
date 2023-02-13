::PerkShop <- self;
g_hTrigger <- null;

::HAVE_POINT <- "■";
::UNHAVE_POINT <- "□";

//CLASS TREE
{
	class class_tree
	{
		data = null;
		origin = null;
		angles = null;

		up = null;
		down = null;
		left = null;
		right = null;
	
		constructor(_data, _origin, _angles)
		{
			this.data = _data;
			this.origin = _origin;
			this.angles = _angles;
		}

		function Print()
		{
			
			local text = UNHAVE_POINT + ((this.GetUp() != null) ? HAVE_POINT : UNHAVE_POINT) + UNHAVE_POINT + "\n";
			text += ((this.GetLeft() != null) ? HAVE_POINT : UNHAVE_POINT) + HAVE_POINT + ((this.GetRight() != null) ? HAVE_POINT : UNHAVE_POINT) + "\n";
			text += UNHAVE_POINT + ((this.GetDown() != null) ? HAVE_POINT : UNHAVE_POINT) + UNHAVE_POINT + "\n";
			return text;
			
			return;
			local matrix = [
				1, 0, 0, 0, 5,
				6, 0, 0, 0, 10,
				11, 0, 0, 0, 15,
				16, 0, 0, 0, 20,
				21, 0, 0, 0, 25,
			];

			for (local i = 0; i < matrix.len(); i++)
			{
				print(matrix[i] + (((i + 1) % 5 == 0) ? "\n" : " "))
			}
		}

		function GetOrigin()
		{
			return this.origin;
		}

		function GetAngles()
		{
			return this.angles;
		}

		function GetData()
		{
			return this.data;
		}

		function GetUp()
		{
			return this.up;
		}

		function GetDown()
		{
			return this.down;
		}

		function GetRight()
		{
			return this.right;
		}

		function GetLeft()
		{
			return this.left;
		}
	}

	enum SIDE
	{
		UP,
		DOWN,
		LEFT,
		RIGHT,
	}
	DIST <- 50;
	ANG <- Vector(0, 180, 0);
	temp <- null;

	temp = Entities.FindByName(null, "Midle");
	temp = temp.GetOrigin() + temp.GetForwardVector() * DIST;
	g_TREE_Main <- class_tree("Midle", temp, ANG);

	temp = Entities.FindByName(null, "Left");
	temp = temp.GetOrigin() + temp.GetForwardVector() * DIST;
	g_TREE_Left <- class_tree("Left", temp, ANG);
	
	temp = Entities.FindByName(null, "Right");
	temp = temp.GetOrigin() + temp.GetForwardVector() * DIST;
	g_TREE_Right <- class_tree("Right", temp, ANG);
	
	temp = Entities.FindByName(null, "Up");
	temp = temp.GetOrigin() + temp.GetForwardVector() * DIST;
	g_TREE_Up <- class_tree("Up", temp, ANG);
	
	temp = Entities.FindByName(null, "Down");
	temp = temp.GetOrigin() + temp.GetForwardVector() * DIST;
	g_TREE_Down <- class_tree("Down", temp, ANG);
	
	temp = Entities.FindByName(null, "LeftLeft");
	temp = temp.GetOrigin() + temp.GetForwardVector() * DIST;
	g_TREE_LeftLeft <- class_tree("Left > Left", temp, ANG);
	
	temp = Entities.FindByName(null, "RightUp");
	temp = temp.GetOrigin() + temp.GetForwardVector() * DIST;
	g_TREE_RightUp <- class_tree("Right > Up", temp, ANG);

	temp = Entities.FindByName(null, "UpLeft");
	temp = temp.GetOrigin() + temp.GetForwardVector() * DIST;
	g_TREE_UpLeft <- class_tree("Up > Left", temp, ANG);

	temp = Entities.FindByName(null, "DownRight");
	temp = temp.GetOrigin() + temp.GetForwardVector() * DIST;
	g_TREE_DownRight <- class_tree("Down > Right", temp, ANG);

	function InitTree()
	{
		CreateTree(g_TREE_Left, g_TREE_LeftLeft, SIDE.LEFT);
		CreateTree(g_TREE_Right, g_TREE_RightUp, SIDE.UP);
		CreateTree(g_TREE_Up, g_TREE_UpLeft, SIDE.LEFT);
		CreateTree(g_TREE_Down, g_TREE_DownRight, SIDE.RIGHT);

		CreateTree(g_TREE_Main, g_TREE_Left, SIDE.LEFT);
		CreateTree(g_TREE_Main, g_TREE_Right, SIDE.RIGHT);
		CreateTree(g_TREE_Main, g_TREE_Up, SIDE.UP);
		CreateTree(g_TREE_Main, g_TREE_Down, SIDE.DOWN);
	}

	function CreateTree(value1, value2, connectside)
	{
		if (connectside == SIDE.UP)
		{
			value1.up = value2;
			value2.down = value1;
		}
		else if (connectside == SIDE.DOWN)
		{
			value1.down = value2;
			value2.up = value1;
		}
		else if (connectside == SIDE.LEFT)
		{
			value1.left = value2;
			value2.right = value1;
		}
		else if (connectside == SIDE.RIGHT)
		{
			value1.right = value2;
			value2.left = value1;
		}
		else printl("PIZDA POLOMAL");
	}
}


//CLASS DISPLAY
{
	::g_hFade <- Entities.CreateByClassname("env_fade");
	g_hFade.__KeyValueFromString("duration", "" + 0.1);
	g_hFade.__KeyValueFromString("holdtime", "" + 0.15);
	g_hFade.__KeyValueFromInt("renderamt", 255);
	g_hFade.__KeyValueFromInt("spawnflags", 5);
	g_hFade.__KeyValueFromVector("rendercolor", Vector(0, 0, 0));

	ga_hActivePlayers <- [];
	class class_display
	{
		player = null;

		game_ui = null;
		game_text = null;

		select = null;

		camera = null;

		constructor(_player, _select)
		{
			this.player = _player;
			this.select = _select;
			

			this.player.__KeyValueFromInt("movetype", 7);
			this.player.SetVelocity(Vector(0, 0, 0));
			EntFireByHandle(this.player, "SetHudVisibility", "0", 0, this.player, this.player);

			this.camera = Entities.CreateByClassname("point_viewcontrol");
			this.camera.__KeyValueFromInt("spawnflags", 128);
			this.MoveCamera();
			this.SetFov(false);

			//EntFireByHandle(this.camera, "Enable", "", 0, this.player, this.player);

			this.game_ui = Entities.CreateByClassname("game_ui");
			this.game_ui.__KeyValueFromInt("spawnflags", 480);

			EntFireByHandle(this.game_ui, "AddOutPut", "PressedAttack " + PerkShop.GetName() + ":RunScriptCode:PressedSelect(true):0:-1", 0.01, null, null);
			EntFireByHandle(this.game_ui, "AddOutPut", "PressedAttack2 " + PerkShop.GetName() + ":RunScriptCode:PressedSelect(false):0:-1", 0.01, null, null);
			
			EntFireByHandle(this.game_ui, "AddOutPut", "PressedForward " + PerkShop.GetName() + ":RunScriptCode:PressedUpDown(true):0:-1", 0.01, null, null);
			EntFireByHandle(this.game_ui, "AddOutPut", "PressedBack " + PerkShop.GetName() + ":RunScriptCode:PressedUpDown(false):0:-1", 0.01, null, null);
			EntFireByHandle(this.game_ui, "AddOutPut", "PressedMoveLeft " + PerkShop.GetName() + ":RunScriptCode:PressedLeftRight(true):0:-1", 0.01, null, null);
			EntFireByHandle(this.game_ui, "AddOutPut", "PressedMoveRight " + PerkShop.GetName() + ":RunScriptCode:PressedLeftRight(false):0:-1", 0.01, null, null);
			
			EntFireByHandle(this.game_ui, "AddOutPut", "PlayerOff " + PerkShop.GetName() + ":RunScriptCode:PressedOff():0:-1", 0.01, null, null);
			// EntFireByHandle(this.game_ui, "AddOutPut", "PlayerOn " + self.GetName() + ":RunScriptCode:ShowMenu():0:-1", 0.01, null, null);
			EntFireByHandle(this.game_ui, "Activate", "", 0.05, this.player, this.player);
			

			this.game_text = Entities.CreateByClassname("game_text");
            this.game_text.__KeyValueFromInt("spawnflags", 0);
            this.game_text.__KeyValueFromInt("channel", 3);
            this.game_text.__KeyValueFromVector("color", Vector(255, 255, 255));
            this.game_text.__KeyValueFromFloat("y", 0.6);
            this.game_text.__KeyValueFromFloat("x", -1.0);
            this.game_text.__KeyValueFromFloat("holdtime", 5.0);
		}

		function SelfDestroy()
		{
			if (this.game_ui != null && game_ui.IsValid())
				EntFireByHandle(this.game_ui, "Kill", "", 0, null, null);
			
			if (this.camera != null && camera.IsValid())
				EntFireByHandle(this.camera, "Kill", "", 0, null, null);
		}

		function MoveCamera()
		{
			local vOrigin = this.select.GetOrigin();
			this.camera.SetOrigin(vOrigin);
			this.player.SetOrigin(vOrigin);

			local vAngles = this.select.GetAngles();
			this.camera.SetAngles(vAngles.x, vAngles.y, vAngles.z);
		}

		function DrawMain()
		{
			local text = this.select.GetData();
			this.SetText(text);
		}

		function SetText(text)
		{
			EntFireByHandle(this.game_text, "SetText", text, 0.2, this.player, this.player);
            EntFireByHandle(this.game_text, "Display", "", 0.2, this.player, this.player);
		}

		function SetFov(Toggle)
		{
			
			local ifov;
			if (Toggle)
			{
				ifov = 40;
			}
			else
			{
				ifov = 120;
			}
			
			//EntFireByHandle(g_hFade, "Fade", "", 0, this.player, this.player);
			EntFireByHandle(this.camera, "AddOutPut", "fov " + ifov, 0.00, this.player, this.player);
			EntFireByHandle(this.camera, "Disable", "", 0, this.player, this.player);
			EntFireByHandle(this.camera, "Enable", "", 0.01, this.player, this.player);
		}
	}

	function ConnectPlayer()
	{
		local ID = GetDisplayByPlayer(activator);
		if (ID != -1)
			return;
		ga_hActivePlayers.push(class_display(activator, g_TREE_Main));
	}

	function PressedOff()
	{
		local ID = GetDisplayByPlayer(activator);
		if (ID == -1)
			return;
		
		DisConnectPlayer(ID, false);
	}

	function DisConnectPlayer(ID, Toggle)
	{
		if (Toggle)
		{
			EntFireByHandle(ga_hActivePlayers[ID], "Deactivate", "", 0, null, null);
		}

		ga_hActivePlayers[ID].player.SetOrigin(g_hTrigger.GetOrigin());
		ga_hActivePlayers[ID].player.__KeyValueFromInt("movetype", 2);
		EntFireByHandle(ga_hActivePlayers[ID].camera, "Disable", "", 0, null, null);
		EntFireByHandle(ga_hActivePlayers[ID].player, "SetHudVisibility", "1", 0, null, null);
		
		EntFireByHandle(self, "RunScriptCode", "DeleteFromArray()", 1, ga_hActivePlayers[ID].player, ga_hActivePlayers[ID].player);
		ga_hActivePlayers[ID].SelfDestroy();
		
	}

	function DeleteFromArray()
	{
		local ID = GetDisplayByPlayer(activator);
		if (ID == -1)
			return;
		ga_hActivePlayers.remove(ID);
	}

	function PressedUpDown(Toggle)
	{
		local ID = GetDisplayByPlayer(activator);
		if (ID == -1)
			return;

		if(Toggle)
		{
			if (ga_hActivePlayers[ID].select.GetUp() == null)
				return;
			ga_hActivePlayers[ID].select = ga_hActivePlayers[ID].select.GetUp();
		}
		else
		{
			if (ga_hActivePlayers[ID].select.GetDown() == null)
				return;
			ga_hActivePlayers[ID].select = ga_hActivePlayers[ID].select.GetDown();
		}

		ga_hActivePlayers[ID].MoveCamera();
	}

	function PressedLeftRight(Toggle)
	{
		local ID = GetDisplayByPlayer(activator);
		if (ID == -1)
			return;
		if(Toggle)
		{
			if (ga_hActivePlayers[ID].select.GetLeft() == null)
				return;
			ga_hActivePlayers[ID].select = ga_hActivePlayers[ID].select.GetLeft();
		}
		else
		{
			if (ga_hActivePlayers[ID].select.GetRight() == null)
				return;
			ga_hActivePlayers[ID].select = ga_hActivePlayers[ID].select.GetRight();
		}

		ga_hActivePlayers[ID].MoveCamera();
	}

	function PressedSelect(Toggle)
	{
		local ID = GetDisplayByPlayer(activator);
		if (ID == -1)
			return;

		ga_hActivePlayers[ID].SetFov(Toggle)
		if(Toggle)
			ga_hActivePlayers[ID].DrawMain();
	}

	function GetDisplayByPlayer(value)
	{
		for (local i = 0; i < ga_hActivePlayers.len(); i++)
		{
			if (value == ga_hActivePlayers[i].player)
			{
				return i;
			}
		}

		return -1;
	}
}

function Init()
{
	g_hTrigger = Entities.FindByClassnameNearest("trigger_multiple", self.GetOrigin(), 128);
	EntFireByHandle(g_hTrigger, "AddOutPut", "OnStartTouch " + PerkShop.GetName() + ":RunScriptCode:ConnectPlayer():0:-1", 0.01, null, null);

}

Init();
InitTree();