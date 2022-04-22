::ice <- 0;::fire <- 0;::gravity <- 0;::ammo <- 0;::heal <- 0;::electric <- 0;::earth <- 0;::thunder <- 0;::wind <- 0;::bookbutton <- 0;::bookc <- 0;
function windset(value){wind = value;}
function healset(value){heal = value;}
function iceset(value){ice = value;}
function fireset(value){fire = value;}
function electricset(value){electric = value;}
function ammoset(value){ammo = value;}
function earthset(value){earth = value;}
function thunderset(value){thunder = value;}
function gravityset(value){gravity = value;}
function bookbuttonset(value){bookbutton = value;}
function book(){
	local weapon = self.GetMoveParent();
	if(weapon == null||weapon.GetOwner()!=activator){
		return;
	}
	EntFire("item_shu_branch","Test","",0);
}

function book2(){
	local weapon = self.GetMoveParent();
	if(weapon == null||weapon.GetOwner()!=activator){
		return;
	}
	EntFire("item_shu2_branch","Test","",0);
}

function bookcase(){
	EntFire("item_shu_case","PickRandomShuffle","",0);
}

function caseice(){
	local ent1 = Entities.FindByName(null,"item_ice_button");
	bookc += 1;
	if(ent1!=null&&ice==1){
		local pp = null;
		while((pp = Entities.FindByClassnameWithin(pp,"player",ent1.GetOrigin(),500))!=null){
			if(pp.GetTeam()==3){
			if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
			return;
			}
		}
		iceset(0);
		EntFire("item_ice_button","kill","",0);EntFire("item_ice_ready","kill","",0);
		EntFire("item_ice_trigger","kill","",0);EntFire("item_ice_used","kill","",0);
		EntFire("item_shu_maker","AddOutput","EntityTemplate item_ice_template",0)
		EntFire("item_shu_maker","ForceSpawn","",0.1);
		if(bookbutton==1){
			EntFire("item_shu_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu_model","kill","",0);EntFire("item_shu_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book to exchange ice***",0.1);
		}else if(bookbutton=2){
			EntFire("item_shu2_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu2_model","kill","",0);EntFire("item_shu2_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book2 to exchange ice***",0.1);
			}
		bookc = 0;
	}else if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
}

function casefire(){
	local ent1 = Entities.FindByName(null,"item_slowfire_button");
	bookc += 1;
	if(ent1!=null&&fire==1){
		local pp = null;
		while((pp = Entities.FindByClassnameWithin(pp,"player",ent1.GetOrigin(),500))!=null){
			if(pp.GetTeam()==3){
			if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
			return;
			}
		}
		fireset(0);
		EntFire("item_slowfire_button","kill","",0);EntFire("item_slowfire_ready","kill","",0);
		EntFire("item_slowfire_trigger","kill","",0);EntFire("item_slowfire_used","kill","",0);
		EntFire("item_shu_maker","AddOutput","EntityTemplate item_slowfire_template",0)
		EntFire("item_shu_maker","ForceSpawn","",0.1);
		if(bookbutton==1){
			EntFire("item_shu_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu_model","kill","",0);EntFire("item_shu_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book to exchange slowfire***",0.1);
		}else if(bookbutton=2){
			EntFire("item_shu2_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu2_model","kill","",0);EntFire("item_shu2_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book2 to exchange slowfire***",0.1);
			}
		bookc = 0;
	}else if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
}

function casegravity(){
	local ent1 = Entities.FindByName(null,"item_gravity_button");
	bookc += 1;
	if(ent1!=null&&gravity==1){
		local pp = null;
		while((pp = Entities.FindByClassnameWithin(pp,"player",ent1.GetOrigin(),500))!=null){
			if(pp.GetTeam()==3){
			if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
			return;
			}
		}
		gravityset(0);
		EntFire("item_gravity_button","kill","",0);EntFire("item_gravity_ready","kill","",0);
		EntFire("item_gravitysd_tp","kill","",0);
		EntFire("item_shu_maker","AddOutput","EntityTemplate item_gravity_template",0)
		EntFire("item_shu_maker","ForceSpawn","",0.1);
		if(bookbutton==1){
			EntFire("item_shu_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu_model","kill","",0);EntFire("item_shu_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book to exchange gravity***",0.1);
		}else if(bookbutton=2){
			EntFire("item_shu2_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu2_model","kill","",0);EntFire("item_shu2_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book2 to exchange gravity***",0.1);
			}
		bookc = 0;
	}else if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
}

function caseammo(){
	local ent1 = Entities.FindByName(null,"item_ammo_button");
	bookc += 1;
	if(ent1!=null&&ammo==1){
		local pp = null;
		while((pp = Entities.FindByClassnameWithin(pp,"player",ent1.GetOrigin(),500))!=null){
			if(pp.GetTeam()==3){
			if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
			return;
			}
		}
		ammoset(0);
		EntFire("item_ammo_button","kill","",0);EntFire("item_ammo_ready","kill","",0);
		EntFire("item_ammo_trigger","kill","",0);EntFire("item_ammo_used","kill","",0);
		EntFire("item_shu_maker","AddOutput","EntityTemplate item_ammo_template",0)
		EntFire("item_shu_maker","ForceSpawn","",0.1);
		if(bookbutton==1){
			EntFire("item_shu_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu_model","kill","",0);EntFire("item_shu_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book to exchange ammo***",0.1);
		}else if(bookbutton=2){
			EntFire("item_shu2_tp","TeleportToCurrentPos","",0);
			EntFire("itedwm_shu2_model","kill","",0);EntFire("item_shu2_button","kill","",0);
			EntFire("Cmd",w"Command","say ***Player used Magic Book2 to exchange ammo***",0.1);
			}
		bookc = 0;
	}else if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
}

function caseheal(){
	local ent1 = Entities.FindByName(null,"item_heal_button");
	bookc += 1;
	if(ent1!=null&&heal==1){
		local pp = null;
		while((pp = Entities.FindByClassnameWithin(pp,"player",ent1.GetOrigin(),500))!=null){
			if(pp.GetTeam()==3){
			if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
			return;
			}
		}
		healset(0);
		EntFire("item_heal_button","kill","",0);EntFire("item_heal_ready","kill","",0);
		EntFire("item_heal_trigger","kill","",0);EntFire("item_heal_used","kill","",0);
		EntFire("item_shu_maker","AddOutput","EntityTemplate item_heal_template",0)
		EntFire("item_shu_maker","ForceSpawn","",0.1);
		if(bookbutton==1){
			EntFire("item_shu_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu_model","kill","",0);EntFire("item_shu_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book to exchange heal***",0.1);
		}else if(bookbutton=2){
			EntFire("item_shu2_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu2_model","kill","",0);EntFire("item_shu2_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book2 to exchange heal***",0.1);
			}
		bookc = 0;
	}else if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
}

function caseelectric(){
	local ent1 = Entities.FindByName(null,"item_electric_button");
	bookc += 1;
	if(ent1!=null&&electric==1){
		local pp = null;
		while((pp = Entities.FindByClassnameWithin(pp,"player",ent1.GetOrigin(),500))!=null){
			if(pp.GetTeam()==3){
			if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
			return;
			}
		}
		electricset(0);
		EntFire("item_electric_button","kill","",0);EntFire("item_electric_ready","kill","",0);
		EntFire("item_electric_used_maker","kill","",0);
		EntFire("item_shu_maker","AddOutput","EntityTemplate item_electric_template",0)
		EntFire("item_shu_maker","ForceSpawn","",0.1);
		if(bookbutton==1){
			EntFire("item_shu_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu_model","kill","",0);EntFire("item_shu_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book to exchange electric***",0.1);
		}else if(bookbutton=2){
			EntFire("item_shu2_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu2_model","kill","",0);EntFire("item_shu2_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book2 to exchange electric***",0.1);
			}
		bookc = 0;
	}else if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
}

function caseearth(){
	local ent1 = Entities.FindByName(null,"item_earth_button");
	bookc += 1;
	if(ent1!=null&&earth==1){
		local pp = null;
		while((pp = Entities.FindByClassnameWithin(pp,"player",ent1.GetOrigin(),500))!=null){
			if(pp.GetTeam()==3){
			if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
			return;
			}
		}
		earthset(0);
		EntFire("item_earth_button","kill","",0);EntFire("item_earth_ready","kill","",0);
		EntFire("item_earth_maker_used","kill","",0);
		EntFire("item_shu_maker","AddOutput","EntityTemplate item_earth_template",0)
		EntFire("item_shu_maker","ForceSpawn","",0.1);
		if(bookbutton==1){
			EntFire("item_shu_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu_model","kill","",0);EntFire("item_shu_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book to exchange earth***",0.1);
		}else if(bookbutton=2){
			EntFire("item_shu2_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu2_model","kill","",0);EntFire("item_shu2_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book2 to exchange earth***",0.1);
			}
		bookc = 0;
	}else if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
}

function casethunder(){
	local ent1 = Entities.FindByName(null,"item_godthunder_button");
	bookc += 1;
	if(ent1!=null&&thunder==1){
		local pp = null;
		while((pp = Entities.FindByClassnameWithin(pp,"player",ent1.GetOrigin(),500))!=null){
			if(pp.GetTeam()==3){
			if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
			return;
			}
		}
		thunderset(0);
		EntFire("item_godthunder_button","kill","",0);EntFire("item_godthunder_ready","kill","",0);
		EntFire("item_godthunder_rotating1_maker","kill","",0);
		EntFire("item_shu_maker","AddOutput","EntityTemplate item_godthunder_template",0)
		EntFire("item_shu_maker","ForceSpawn","",0.1);
		if(bookbutton==1){
			EntFire("item_shu_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu_model","kill","",0);EntFire("item_shu_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book to exchange godthunder***",0.1);
		}else if(bookbutton=2){
			EntFire("item_shu2_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu2_model","kill","",0);EntFire("item_shu2_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book2 to exchange godthunder***",0.1);
			}
		bookc = 0;
	}else if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
}

function casewind(){
	local ent1 = Entities.FindByName(null,"item_wind_button");
	bookc += 1;
	if(ent1!=null&&wind==1){
		local pp = null;
		while((pp = Entities.FindByClassnameWithin(pp,"player",ent1.GetOrigin(),500))!=null){
			if(pp.GetTeam()==3){
			if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
			return;
			}
		}
		windset(0);
		EntFire("item_wind_button","kill","",0);EntFire("item_wind_ready","kill","",0);
		EntFire("item_wind_push","kill","",0);EntFire("item_wind_used","kill","",0);
		EntFire("item_wind_teleport","kill","",0);
		EntFire("item_shu_maker","AddOutput","EntityTemplate item_wind_template",0)
		EntFire("item_shu_maker","ForceSpawn","",0.1);
		EntFire("item_wind_branch","SetValue","1",0);
		if(bookbutton==1){
			EntFire("item_shu_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu_model","kill","",0);EntFire("item_shu_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book to exchange wind***",0.1);
		}else if(bookbutton=2){
			EntFire("item_shu2_tp","TeleportToCurrentPos","",0);
			EntFire("item_shu2_model","kill","",0);EntFire("item_shu2_button","kill","",0);
			EntFire("Cmd","Command","say ***Player used Magic Book2 to exchange wind***",0.1);
			}
		bookc = 0;
	}else if(bookc<9){EntFire("item_shu_case","PickRandomShuffle","",0);}else{bookc = 0;}
}