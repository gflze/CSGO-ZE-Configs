event_server_cvar <- Entities.FindByName(null, "event_server_cvar");

function CheckIceskates() {
  local data = event_server_cvar.GetScriptScope().event_data;
  if (data.cvarname == "sv_friction") {
    if (data.cvarvalue != "0") {
      EntFire("console","Command","sv_water_swim_mode 1",0,null);
    } else {
      EntFire("console","Command","sv_water_swim_mode 0",0,null);
    }
  }
} 