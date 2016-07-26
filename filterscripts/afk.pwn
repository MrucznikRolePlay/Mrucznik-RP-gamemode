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
	
	if(afktime > 600)
	{
		SendClientMessage(playerid, 0xFF0000AA, "Zostałeś skickowany za zbyt długie AFK (powyżej 10 minut)");
		SetTimerEx("KickEx", 500, false, "i", playerid);
	}
	else if(afktime > 300)
	{
		SetPlayerChatBubble(playerid, caption, 0xAA3333AA, 20.0, 1500);
	}
	else
	{
		SetPlayerChatBubble(playerid, caption, 0xAA3333AA, 20.0, 1500);
	}
	
	if(IsPlayerPaused(playerid))
	{
		afk_timer[playerid] = SetTimerEx("PlayerAFK", 1000, false, "iii", playerid, afktime+1, 0);
	}
	else
	{
		if(breaktime > afktime || breaktime > 180)
		{
			printf("%d byl afk przez %d", playerid, afktime);
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
