#include <a_samp>
#include <callbacks>

#undef MAX_PLAYERS
#define MAX_PLAYERS 500

new afkCzas[MAX_PLAYERS];

forward oneSecond();
public oneSecond()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i) && IsPlayerPaused(i))
		{
		    //if(afkCzas[i] >= 600)
			//{
			//	Kick(i);
			//}
			if(afkCzas[i] >= 300)
			{
				new caption[32];
				format(caption, sizeof(caption), "[AFK] PONAD 5 MINUT!");
				SetPlayerChatBubble(i, caption, 0xAA3333AA, 20.0, 1500);
			}
			else if(afkCzas[i] >= 240 && afkCzas[i] < 300)
			{
				new caption[32];
				format(caption, sizeof(caption), "[AFK] 4 min. %02d sekund.", (afkCzas[i]-240));
				SetPlayerChatBubble(i, caption, 0x33AA33AA, 20.0, 1500);
			}
			else if(afkCzas[i] >= 180 && afkCzas[i] < 240)
			{
				new caption[32];
				format(caption, sizeof(caption), "[AFK] 3 min. %02d sekund.", (afkCzas[i]-180));
				SetPlayerChatBubble(i, caption, 0x33AA33AA, 20.0, 1500);
			}
			else if(afkCzas[i] >= 120 && afkCzas[i] < 180)
			{
				new caption[32];
				format(caption, sizeof(caption), "[AFK] 2 min. %02d sekund.", (afkCzas[i]-120));
				SetPlayerChatBubble(i, caption, 0x33AA33AA, 20.0, 1500);
			}
			else if(afkCzas[i] >= 60 && afkCzas[i] < 120)
			{
				new caption[32];
				format(caption, sizeof(caption), "[AFK] 1 min. %02d sekund.", (afkCzas[i]-60));
				SetPlayerChatBubble(i, caption, 0x33AA33AA, 20.0, 1500);
			}
			else if(afkCzas[i] >= 30 && afkCzas[i] < 60)
			{
				new caption[32];
				format(caption, sizeof(caption), "[AFK] %02d sekund.", afkCzas[i]);
				SetPlayerChatBubble(i, caption, 0x33AA33AA, 20.0, 1500);
			}
			afkCzas[i]++;
		}
	}

	return 1;
}

public OnFilterScriptInit()
{
	SetTimer("oneSecond", 1000, true);

	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	afkCzas[playerid] = 0;

	return 1;
}

public OnPlayerConnect(playerid)
{
	afkCzas[playerid] = 0;

	return 1;
}
