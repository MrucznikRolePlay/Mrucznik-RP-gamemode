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

/*
native SendClientMessageToOther(playerid, color, msg[]);
narive SetPlayerPosEx(playerid, Float:X, Float:Y, Float:Z, Float:Ang, Int);
native TimeOfTotay();
native IsValidSkin(skinid);
*/

forward SendClientMessageToOthers(playerid, color, msg[]);
forward SetPlayerPosEx(playerid,Float:X,Float:Y,Float:Z,Float:Ang,Int);
forward TimeOfToday();
forward IsValidSkin(skinid);

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


stock TimeOfToday() {
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

stock IsValidSkin(skinid)
{
	#define	MAX_BAD_SKINS   22

	new badSkins[MAX_BAD_SKINS] = {
		3, 4, 5, 6, 8, 42, 65, 74, 86,
		119, 149, 208, 265, 266, 267,
		268, 269, 270, 271, 272, 273, 289
	};

	if  (skinid < 0 || skinid > 299) return false;
	for (new i = 0; i < MAX_BAD_SKINS; i++) {
	    if (skinid == badSkins[i]) return false;
	}

	#undef MAX_BAD_SKINS
	return true;
}




