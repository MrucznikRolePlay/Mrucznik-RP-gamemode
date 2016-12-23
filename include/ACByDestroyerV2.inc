#if defined _ACByDestroyerV2_included
	#endinput
#endif
#define _ACByDestroyerV2_included

#include <a_samp>
#pragma tabsize 0

new kaska[MAX_PLAYERS];

forward Ac_OnGameModeInit();
public Ac_OnGameModeInit()//anty cheat
{
	SetTimer("AntyCheatSystemByDestroyer", 1000, 1);
	return 1;
}

forward Ac_OnPlayerConnect(playerid);
public Ac_OnPlayerConnect(playerid)
{
	kaska[playerid]=0;	
	return 1;
}

forward AntyCheatSystemByDestroyer();
public AntyCheatSystemByDestroyer()
{

        for(new i = 0, p = GetMaxPlayers(); i < p; i++)
        {
		if(GetPlayerMoney(i) > kaska[i])
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
public DajKase(playerid,pieniadze){
kaska[playerid]+=pieniadze;
GivePlayerMoney(playerid,pieniadze);
return 1;
}

forward ResetujKase(playerid);
public ResetujKase(playerid){
kaska[playerid]=0;
ResetPlayerMoney(playerid);
return 1;
}