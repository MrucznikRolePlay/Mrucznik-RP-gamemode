//-------------------------------------------------------------------------------

stock GetPlayers() //By rapidZ
{
new i;
new player;
player = 0;
 for (i=0;i<MAX_PLAYERS;i++)
 {
  if(IsPlayerConnected(i))
  {
   player++;
  }
 }
 return player;
}
native GetPlayers();

//-------------------------------------------------------------------------------

stock PlaySoundForAll(soundid) //by Sacky
{
new Float:x;
new Float:y;
new Float:z;
 for(new i=0;i<MAX_PLAYERS;i++)
 {
  if(IsPlayerConnected(i))
  {
   GetPlayerPos(i,x,y,z);
   PlayerPlaySound(i,soundid,x,y,z);
  }
 }
}
native PlaySoundForAll(soundid);

//-------------------------------------------------------------------------------

stock SetAllColour(color) //by Sacky
{
	for(new i=0;i<MAX_PLAYERS;i++)
 {
		if(IsPlayerConnected(i))
  {
			SetPlayerColor(i,color);
		}
	}
}
native SetAllColour(color);

//-------------------------------------------------------------------------------

stock KickAll() //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i) && IsPlayerAdmin(i) == 0) {
        Kick(i);
     }
  }
}
native KickAll();

//-------------------------------------------------------------------------------

stock SetCheckpointForAll(Float:x,Float:y,Float:z,Float:size) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      SetPlayerCheckpoint(i,x,y,z,size);
    }
  }
}
native SetCheckpointForAll(Float:x,Float:y,Float:z,Float:size);

//-------------------------------------------------------------------------------

stock SetRaceCheckpointForAll(type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size) //by Smugller
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      SetPlayerRaceCheckpoint(i, type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size);
    }
  }
}
native SetRaceCheckpointForAll(type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size);

//-------------------------------------------------------------------------------

stock DisableAllPlayersCheckpoints() //by Smugller
{
	for(new i = 0; i < MAX_PLAYERS; i++)
 {
  if(IsPlayerConnected(i))
  {
   DisablePlayerCheckpoint(i);
  }
 }
}
native DisableAllPlayersCheckpoints();

//-------------------------------------------------------------------------------

stock DisableAllRaceCheckpoints() //by Smugller
{
	for(new i = 0; i < MAX_PLAYERS; i++)
 {
  if(IsPlayerConnected(i))
  {
   DisablePlayerRaceCheckpoint(i);
  }
 }
}
native DisablePlayersRaceCheckpoints();

//-------------------------------------------------------------------------------

stock ClearChat() //by Pixels^ and Xtreme
{
  for(new i=0; i<12; i++) {
    SendClientMessageToAll(0xFFFF00AA,"");
  }
}
native ClearChat();

//-------------------------------------------------------------------------------

stock SetAllWantedLevel(level) // By Luby
{ 
 new g;
 while(g<200){
  if(IsPlayerConnected(g))SetPlayerWantedLevel(g, level);
  g++;
 }
 return true;
}
native SetAllWantedLevel(level);

//-------------------------------------------------------------------------------

stock GetPlayersOnline() // By Luby
{ 
 new Ile;
 new g;
 while(g<GetMaxPlayers() && IsPlayerConnected(g)){
  Ile++;
  g++;
 }
 return Ile;
}
native GetPlayersOnline();

//-------------------------------------------------------------------------------

stock SetMapIcon(markertype, Float:x, Float:y, Float:z) // By Luby
{ 
 for(new g=0;g<200;g++)if(IsPlayerConnected(g)){
  SetPlayerMapIcon(g, 0, x, y, z, markertype, 0xFFFFFFFF);
 }
 return true;
}
native SetMapIcon(markertype, Float:x, Float:y, Float:z);

//-------------------------------------------------------------------------------

stock ShowMenuForAll(Menu:menuid) // By Luby
{
 for(new g;g<200;g++)if(IsPlayerConnected(g))ShowMenuForPlayer(menuid, g);
 return true;
}
native ShowMenuForAll(Menu:menuid);

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------
