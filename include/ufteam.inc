//--------------------------- TEAM FUNCTION -------------------------------------
#if defined gTeam
stock GameTextForTeam(team, text[], time, style) //By Alex "Y_Less" Cole
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (gTeam[i] == team && IsPlayerConnected(i)) GameTextForPlayer(i, text, time, style);
	}
}
native GameTextForTeam(team, text[], time, style);

//-------------------------------------------------------------------------------

stock SendClientMessageToTeam(team, color, text[]) //By Alex "Y_Less" Cole
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (gTeam[i] == team && IsPlayerConnected(i)) SendClientMessage(i, color, text);
	}
}
native SendClientMessageToTeam(team, color, text[]);

//-------------------------------------------------------------------------------

stock SetTeamScore(team, score) // by Hellomy
{
 for (new i = 0; i < MAX_PLAYERS; i++)
 {
  if (gTeam[i] == team && IsPlayerConnected(i)) SetPlayerScore(i, score);
 }
}
native SetTeamScore(team, score);

//-------------------------------------------------------------------------------

stock GiveTeamMoney(team, amount) // by Hellomy
{
 for (new i = 0; i < MAX_PLAYERS; i++)
 {
  if (gTeam[i] == team && IsPlayerConnected(i)) GivePlayerMoney(i, amount);
 }
}
native GiveTeamMoney(team, amount);

//-------------------------------------------------------------------------------

stock SetTeamMoney(team,howmuch) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        GivePlayerMoney(playerid,howmuch-GetPlayerMoney(i));
      }
    }
  }
}
native SetTeamMoney(team,howmuch);

//-------------------------------------------------------------------------------

stock HowManyPlayersInTeam(team) //by 50p
{
 new players;
 for(new i; i<MAX_PLAYERS; i++)
 {
  if(IsPlayerConnected(i))
  {
   if(gTeam[i] == team)
   {
    players++;
   }
  }
 }
 return players;
}
native HowManyPlayersInTeam(team);

//-------------------------------------------------------------------------------

stock GetPlayerTeamEx(playerid) //by 50p
{
 return gTeam[playerid];
}
native GetPlayerTeamEx(playerid);

//-------------------------------------------------------------------------------

stock SendClientMessageToTeamsBut(team,color,message[]) //by Pixels^ (Correct Sacky)
{
 for(new i=0;i<MAX_PLAYERS;i++)
 {
  if(IsPlayerConnected(i) && gTeam[i] != team)
  {
   SendClientMessage(i,color,message);
  }
 }
}
native SendClientMessageToTeamsBut(team,color,message[]);

//-------------------------------------------------------------------------------

stock IsTeamDead(Team) //by Pixels^
{
     for(new t=0; t<MAX_PLAYERS; t++) {
           if(gTeam[t] == Team) {
                new Float:iHealth,members,dead;
                members++;
                GetPlayerHealth(t,iHealth);
                if(iHealth <= 0) {
                     dead++;
                }
                if(members == dead) {
                     return true;
                }
           }
      }
      return false;
}
native IsTeamDead(Team);

//-------------------------------------------------------------------------------

stock TextDrawShowForTeam(team, Text:text) //by Smugller
{
 for (new i = 0; i < MAX_PLAYERS; i++)
 {
  if (gTeam[i] == team)
  {
   if(IsPlayerConnected(i)))
   {
    TextDrawShowForPlayer(i, Text:text);
   }
  }
 }
}
native TextDrawShowForTeam(team, Text:text);

//-------------------------------------------------------------------------------

stock TextDrawHideForTeam(team, Text:text) //by Smugller
{
 for (new i = 0; i < MAX_PLAYERS; i++)
 {
  if (gTeam[i] == team)
  {
   if(IsPlayerConnected(i)))
   {
    TextDrawHideForPlayer(i, Text:text);
   }
  }
 }
}
native TextDrawHideForTeam(team, Text:text);

//-------------------------------------------------------------------------------

stock TextDrawShowForTeamsBut(team, Text:text) //by Smugller
{
 for (new i = 0; i < MAX_PLAYERS; i++)
 {
  if (gTeam[i] == !team)
  {
   if(IsPlayerConnected(i)))
   {
    TextDrawShowForPlayer(i, Text:text);
   }
  }
 }
}
native TextDrawShowForTeamsBut(team, Text:text);

//-------------------------------------------------------------------------------

stock TextDrawHideForTeamsBut(team, Text:text) //by Smugller
{
 for (new i = 0; i < MAX_PLAYERS; i++)
 {
  if (gTeam[i] == !team)
  {
   if(IsPlayerConnected(i)))
   {
    TextDrawHideForPlayer(i, Text:text);
   }
  }
 }
}
native TextDrawHideForTeamsBut(team, Text:text);

//-------------------------------------------------------------------------------

stock SetPlayerPosAndTeam(playerid,team,Float:x,Float:y,Float:z) //by Pixels^
{
 SetPlayerPos(playerid,x,y,z);
 SetPlayerTeam(playerid,team);
 return 1;
}
native SetPlayerPosAndTeam(playerid,team,Float:x,Float:y,Float:z);

//-------------------------------------------------------------------------------

stock SetTeamPos(team,Float:x,Float:y,Float:z) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerPos(i,x,y,z);
      }
    }
  }
}
native SetTeamPos(team,Float:x,Float:y,Float:z);

//-------------------------------------------------------------------------------

stock SetTeamInterior(team,interiorid) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerInterior(i,interiorid);
      }
    }
  }
}
native SetTeamInterior(team,interiorid);

//-------------------------------------------------------------------------------

stock SetTeamHealth(team,Float:Health) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerHealth(i,Health);
      }
    }
  }
}
native SetTeamHealth(team,Float:Health);

//-------------------------------------------------------------------------------

stock KillTeam(team) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerHealth(i,0);
      }
    }
  }
}
native KillTeam(team);

//-------------------------------------------------------------------------------

stock SetgTeam(playerid,team) //by Pixels^ and Xtreme
{
  if(IsPlayerConnected(playerid)) {
    gTeam[playerid] = team;
  }
  else {
    return false;
}
native SetgTeam(playerid,team);

//-------------------------------------------------------------------------------

stock SetTeamColor(team,color) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerColor(i,color);
      }
    }
  }
}
native SetTeamColor(team,color);

//-------------------------------------------------------------------------------

stock SetTeamCheckpoint(team,Float:x,Float:y,Float:z,Float:size) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerCheckpoint(i,x,y,z,size);
      }
    }
  }
}
native SetTeamCheckpoint(team,Float:x,Float:y,Float:z,Float:size);

//-------------------------------------------------------------------------------

stock DisableTeamCheckpoint(team) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        DisablePlayerCheckpoint(i);
      }
    }
  }
}
native DisableTeamCheckpoint(team);

//-------------------------------------------------------------------------------

stock SetRaceCheckpointForTeam(type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size) //by Smugller
{
 for(new i=0; i<MAX_PLAYERS; i++)
 {
  if(IsPlayerConnected(i))
  {
   if(gTeam[i] == team)
   {
    SetPlayerRaceCheckpoint(i, type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size);
   }
  }
 }
}
native SetRaceCheckpointForTeam(type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size);


//-------------------------------------------------------------------------------

stock DisableTeamRaceCheckpoints() //by Smugller
{
	  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        DisablePlayerRaceCheckpoint(i);
      }
    }
  }
}
native DisableTeamRaceCheckpoints();

//-------------------------------------------------------------------------------

stock ResetTeamMoney(team) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        GivePlayerMoney(playerid,-GetPlayerMoney(i));
      }
    }
  }
}
native ResetTeamMoney(team);

//-------------------------------------------------------------------------------

stock PlaySoundForTeam(team,soundid) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        PlayerPlaySound(playerid,soundid,0,0,0);
      }
    }
  }
}
native PlaySoundForTeam(team,soundid);

//-------------------------------------------------------------------------------

stock GiveTeamWeapon(team,w1,a1) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        GivePlayerWeapon(i,w1,a1);
      }
    }
  }
}
native GiveTeamWeapon(team,w1,a1);

//-------------------------------------------------------------------------------

stock SetTeamCameraPos(team,Float:x,Float:y,Float:z) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerCameraPos(i,x,y,z);
      }
    }
  }
}
native SetTeamCameraPos(team,Float:x,Float:y,Float:z);

//-------------------------------------------------------------------------------

stock FreezeTeam(team,bool:toggle) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        if(toggle == true) {
          TogglePlayerControllable(i,0);
        }
        else {
          TogglePlayerControllable(i,1);
        }
      }
    }
  }
}
native FreezeTeam(team,bool:toggle);

//-------------------------------------------------------------------------------

stock ToggleTeamVisibility(team,bool:visible) //by Pixels^ and Xtreme
{
  new color = GetPlayerColor(i);
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        if(toggle == true) {
          SetPlayerColor(i,0xFF000000);
        }
        else {
          SetPlayerColor(i,color);
        }
      }
    }
}
native ToggleTeamVisibility(team,bool:visible);

//-------------------------------------------------------------------------------

stock SpamTeam(team) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        for(new s=0; s<12; s++) {
          SendClientMessage(i,0xFFFF00AA,"spam spam spam spam");
        }
      }
    }
  }
native SpamTeam(team);

//-------------------------------------------------------------------------------

stock KickTeam(team) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          Kick(i);
        }
      }
    }
  }
native KickTeam(team);

//-------------------------------------------------------------------------------

stock BanTeam(team) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          Ban(i);
      }
    }
  }
}
native BanTeam(team);

//-------------------------------------------------------------------------------

Stock SetTeamSpawnInfo(team,modelid,Float:x,Float:y,Float:z,Float:angle,w1,a1,w2,a2,w3,a3) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          SetSpawnInfo(i,-1,modelid,x,y,z,angle,w1,a1,w2,a2,w3,a3);
      }
    }
  }
}
native SetTeamSpawnInfo(team,modelid,Float:x,Float:y,Float:z,Float:angle,w1,a1,w2,a2,w3,a3);

//-------------------------------------------------------------------------------

stock IsTeamInCheckpoint(team) //by Pixels^ and Xtreme
{
  new t = 0;
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          if(IsPlayerInCheckpoint(i) {
            t++;
          }
        }
      }
    }
  return t;
}
native IsTeamInCheckpoint(team);

//-------------------------------------------------------------------------------

stock SetTeamWorldBounds(team,Float:xmin,Float:xmax,Float:ymin,Float:ymax) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          SetPlayerWorldBounds(i,xmin,xmax,ymin,ymax);
        }
      }
    }
}
native SetTeamWorldBounds(team,Float:xmin,Float:xmax,Float:ymin,Float:ymax);

//-------------------------------------------------------------------------------

stock ResetTeamWorldBounds(team) //by Smugller
{
  for(new i=0; i<MAX_PLAYERS; i++)
   {
    if(IsPlayerConnected(i))
    {
      if(gTeam[i] == team)
      {
          SetPlayerWorldBounds(i,20000.0, -20000.0, 20000.0, -20000.0);
      }
    }
   }
}
native ResetTeamWorldBounds(team);

//-------------------------------------------------------------------------------

stock SetTeamFacingAngle(team,Float:angle) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          SetPlayerFacingAngle(i,angle);
        }
      }
    }
  }
native SetTeamFacingAngle(team,Float:angle);

//-------------------------------------------------------------------------------

stock SetVehicleParamsForTeam(team,vehicleid,objective,locked) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          SetVehicleParamsForPlayer(vehicleid,i,objective,locked);
        }
      }
    }
  }
native SetVehicleParamsForTeam(team,vehicleid,objective,locked);

//-------------------------------------------------------------------------------

stock IsgTeam(playerid,team) //by Pixels^ and Xtreme
{
  if(gTeam[playerid] == team) {
    return true;
  }
  else {
    return false;
  }
}
native IsgTeam(playerid,team);
#endif
//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

