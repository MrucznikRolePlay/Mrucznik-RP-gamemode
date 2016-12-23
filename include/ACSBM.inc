#if defined _ACSBM_included
	#endinput
#endif
#define _ACSBM_included

#include <a_samp>
//#pragma tabsize 0

new kaska[MAX_PLAYERS];

forward Ac_OnGameModeInit();
public Ac_OnGameModeInit()//anty cheat
{
	SetTimer("AntyCheatSystemByMrucznik", 1000, 1);
	return 1;
}

forward Ac_OnPlayerConnect(playerid);
public Ac_OnPlayerConnect(playerid)
{
	kaska[playerid]=0;	
	return 1;
}

forward AntyCheatSystemByMrucznik();
public AntyCheatSystemByMrucznik()
{
    for(new i = 0, p = GetMaxPlayers(); i < p; i++)
    {
		if(GetPlayerMoney(i) != kaska[i])
		{
			if(IsPlayerConnected(i))
			{
				ResetPlayerMoney(i);
				GivePlayerMoney(i,kaska[i]);
			}
		}
	}
	return 1;
}

forward DajKase(playerid,pieniadze);
public DajKase(playerid,pieniadze)
{
	kaska[playerid]+=pieniadze;
	GivePlayerMoney(playerid,pieniadze);
	if(kaska[playerid] < -10000000)
	{
		new st23r[256], nickbrusz[MAX_PLAYER_NAME];
		GetPlayerName(playerid, nickbrusz, sizeof(nickbrusz));
		SendClientMessage(playerid, 0xFF0000FF, "Zosta³eœ zbanowany!");
		format(st23r, sizeof(st23r), "%s mial mniej niz -10 000 000", nickbrusz);
		new entry[256];
		format(entry, sizeof(entry), "%s\n",st23r);
		new File:hFile;
		hFile = fopen("ban.log", io_append);
		fwrite(hFile, entry);
		fclose(hFile);
		Ban(playerid);
	}
	return 1;
}

forward ZabierzKase(playerid, money);
public ZabierzKase(playerid, money)
{
	if(money <= 0)
	{
		printf("ERROR: funkcja ZabierzKase miala ujemna wartosc dla playerid: %s[%d] Wartosc: %d", GetNick(playerid), playerid, money);
		return 1;
	}
	kaska[playerid] -= money;
	GivePlayerMoney(playerid, -money);
	return 1;
}

forward ResetujKase(playerid);
public ResetujKase(playerid)
{
	kaska[playerid]=0;
	ResetPlayerMoney(playerid);
	return 1;
}