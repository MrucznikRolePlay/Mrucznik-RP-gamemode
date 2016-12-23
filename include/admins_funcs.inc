/*
 *
 *     Funkcje dla adminow
 *     © Copyright 2006, 50p
 *
 */

#if defined _admins_include
   #endinput
#endif
#define _admins_included

forward SendClientMessageToAdmins(color, const message[]);
forward SendClientMessageToOtherAdmins(playerid, color, const message[]);

public SendClientMessageToAdmins(color, const message[])
{
	for(new a=0; a<MAX_PLAYERS; a++) {
	    if(IsPlayerConnected(a) && IsPlayerAdmin(a)) {
	            SendClientMessage(a, color, message);
		}
	}
}

public SendClientMessageToOtherAdmins(playerid, color, const message[])
{
	for(new a; a<MAX_PLAYERS; a++)
	{
	    if(IsPlayerConnected(a) && IsPlayerAdmin(a) && a != playerid)
	    {
	        SendClientMessage(a, color, message);
		}
	}
}
