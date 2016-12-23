/*
 *
 *	Additional Functions
 *	© Copyright 2007, 50p
 *
 */

#if defined _50af_include
#endinput
#endif

#define _50af_include

forward SendClientMessageToOthers(playerid, color, msg[]);
forward SetPlayerPosEx(playerid,Float:X,Float:Y,Float:Z,Float:Ang,Int);

public SendClientMessageToOthers(playerid, color, msg[])
{
	for(new i; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && i!= playerid)
	    {
	        SendClientMessage(i, color, msg);
		}
	}
}


public SetPlayerPosEx(playerid,Float:X,Float:Y,Float:Z,Float:Ang,Int) //By Kamazy
{
	SetPlayerInterior(playerid,Int);
	SetPlayerFacingAngle(playerid,Ang);
	SetPlayerPos(playerid,X,Y,Z);
	SetCameraBehindPlayer(playerid);
}


TimeOfToday() {
  new tmp[255];
  new hour, minuta, sekunda, dzien, miesiac, rok;
  new sMinuta[3], sSekunda[3], sMiesiac[3];
  gettime(hour, minuta, sekunda);
  getdate(rok, miesiac, dzien);
  if(minuta > 9) format(sMinuta, 3, "%d", minuta);
  else if(minuta <= 9) format(sMinuta, 3, "0%d", minuta);
  if(sekunda > 9) format(sSekunda, 3, "%d", sekunda);
  else if(sekunda <= 9) format(sSekunda, 3, "0%d", sekunda);
  if(miesiac > 9) format(sMiesiac, 3, "%d", miesiac);
  else if(miesiac <= 9) format(sMiesiac, 3, "0%d", miesiac);

  format(tmp, sizeof(tmp), "(%d.%s.%s)(%d.%s.%d)", hour, sMinuta, sSekunda, dzien, sMiesiac, rok);

  return tmp;
}



