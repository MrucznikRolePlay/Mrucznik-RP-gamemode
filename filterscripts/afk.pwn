#include <a_samp>
#include <fixes2>
#include <callbacks>

new afk_timer[MAX_PLAYERS];

//-------------------------------[ Timers ]-------------------------------
forward PlayerAFK(playerid, afktime, breaktime);
public PlayerAFK(playerid, afktime, breaktime)
{
	new caption[32];
	if(afktime > 60)
		format(caption, sizeof(caption), "[AFK] %d sekund.", afktime);
	else
		format(caption, sizeof(caption), "[AFK] %d minut %d sekund.", afktime/60, afktime%60);
	
	if(afktime > 300)
	{
		SendClientMessage(playerid, 0xAA3333AA, "Zostałeś skickowany za zbyt długie AFK (powyżej 5 minut)");
		SetTimerEx("KickEx", 500, false, "i", playerid);
	}
	else
	{
		SetPlayerChatBubble(playerid, caption, 0x33AA33AA, 20.0, 1500);
	}
	
	if(IsPlayerPaused(playerid))
	{
		afk_timer[playerid] = SetTimerEx("PlayerAFK", 1000, false, "iii", playerid, afktime+1, 0);
	}
	else
	{
		if(breaktime > afktime || breaktime > 180)
		{
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
			printf("%s byl afk przez %d", name, afktime);
			afk_timer[playerid] = -1;
		}
		else
		{
			afk_timer[playerid] = SetTimerEx("PlayerAFK", 1000, false, "iii", playerid, afktime, breaktime+1);
		}
	}
	return 1;
}

forward KickEx(playerid);
public KickEx(playerid)
{
	Kick(playerid);
	return 1;
}

//-------------------------------[ Callbacks ]-------------------------------
public OnFilterScriptInit()
{
	for(new i; i<MAX_PLAYERS; i++)
		afk_timer[i] = -1;
	return 1;
}

public OnFilterScriptExit()
{
	for(new i; i<MAX_PLAYERS; i++)
	{
		if(afk_timer[i] != -1)
			KillTimer(afk_timer[i]);
	}
}

public OnPlayerDisconnect(playerid, reason)
{
	if(afk_timer[playerid] != -1)
	{
		KillTimer(afk_timer[playerid]);
		afk_timer[playerid] = -1;
	}
	return 1;
}

public OnPlayerPause(playerid)
{
	if(afk_timer[playerid] == -1)
	{
		afk_timer[playerid] = SetTimerEx("PlayerAFK", 1000, false, "iii", playerid, 1, 0);
	}
	return 1;
}
