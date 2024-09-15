//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
//----------------------------------------------------*------------------------------------------------------//
//----[                                                                                                 ]----//
//----[         |||||             |||||                       ||||||||||       ||||||||||               ]----//
//----[        ||| |||           ||| |||                      |||     ||||     |||     ||||             ]----//
//----[       |||   |||         |||   |||                     |||       |||    |||       |||            ]----//
//----[       ||     ||         ||     ||                     |||       |||    |||       |||            ]----//
//----[      |||     |||       |||     |||                    |||     ||||     |||     ||||             ]----//
//----[      ||       ||       ||       ||     __________     ||||||||||       ||||||||||               ]----//
//----[     |||       |||     |||       |||                   |||    |||       |||                      ]----//
//----[     ||         ||     ||         ||                   |||     ||       |||                      ]----//
//----[    |||         |||   |||         |||                  |||     |||      |||                      ]----//
//----[    ||           ||   ||           ||                  |||      ||      |||                      ]----//
//----[   |||           ||| |||           |||                 |||      |||     |||                      ]----//
//----[  |||             |||||             |||                |||       |||    |||                      ]----//
//----[                                                                                                 ]----//
//----------------------------------------------------*------------------------------------------------------//
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_szukani_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
		if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLider] == 1)
		{
			new x;
			SendClientMessage(playerid, COLOR_GREEN, "Lista Poszukiwanych:");
		    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
				    //if(PoziomPoszukiwania[i] >= 2 && PoziomPoszukiwania[i] <= 5 || PoziomPoszukiwania[i] == 10) // tymczasowo off bo nie ma FBI
					if(PoziomPoszukiwania[i] >= 1)
				    {
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "%s%s: %d", string,giveplayer,PoziomPoszukiwania[i]);
						x++;
						if(x > 3) {
						    SendClientMessage(playerid, COLOR_YELLOW, string);
						    x = 0;
							format(string, sizeof(string), "");
						} else {
							format(string, sizeof(string), "%s, ", string);
						}
					}
				}
			}
			if(x <= 3 && x > 0) {
				string[strlen(string)-2] = '.';
			    SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		}
		else if(PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pLider] == 2)
		{
			new x;
			SendClientMessage(playerid, COLOR_GREEN, "Lista Poszukiwanych:");
		    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
				    if(PoziomPoszukiwania[i] >= 6)
				    {
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "%s%s: %d", string,giveplayer,PoziomPoszukiwania[i]);
						x++;
						if(x > 3) {
						    SendClientMessage(playerid, COLOR_YELLOW, string);
						    x = 0;
							format(string, sizeof(string), "");
						} else {
							format(string, sizeof(string), "%s, ", string);
						}
					}
				}
			}
			if(x <= 3 && x > 0)
			{
				string[strlen(string)-2] = '.';
			    SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		}
		else if(PlayerInfo[playerid][pJob] == 1)
		{
		    if(PlayerToPoint(5.0,playerid,325.0463,306.9240,999.1484))
		    {
			    if(PlayerInfo[playerid][pDetSkill] < 50)
			    {
			        new x;
					SendClientMessage(playerid, COLOR_GREEN, "Poszukiwani ¯ywi lub Martwi:");
				    foreach(new i : Player)
					{
					    if(IsPlayerConnected(i))
						{
							if(PoziomPoszukiwania[i] == 2 || PoziomPoszukiwania[i] == 10)
					    	{
								new deadReward = PoziomPoszukiwania[i] * 5000;
								new liveReward = PoziomPoszukiwania[i] * 10000;
					    	    GetPlayerName(i, giveplayer, sizeof(giveplayer));
								format(string, sizeof(string), "%s%s, Nagroda: ¿ywy - %d$, martwy - %d$", string,giveplayer, liveReward, deadReward);
								x++;
								if(x > 3)
								{
								    SendClientMessage(playerid, COLOR_YELLOW, string);
								    x = 0;
									format(string, sizeof(string), "");
								}
								else
								{
									format(string, sizeof(string), "%s, ", string);
								}
							}
						}
					}
					if(x <= 3 && x > 0)
					{
						string[strlen(string)-2] = '.';
					    SendClientMessage(playerid, COLOR_YELLOW, string);
					}
					SendClientMessage(playerid, COLOR_GREEN, "Aby wzi¹æ zlecenie na kogoœ wpisz /zlecenie");
					SendClientMessage(playerid, COLOR_GRAD1, "Wy¿szy skill £owcy Nagród, wiêksze nagrody");
				}
				else if(PlayerInfo[playerid][pDetSkill] >= 50 && PlayerInfo[playerid][pDetSkill] < 100)
			    {
			        new x;
					SendClientMessage(playerid, COLOR_GREEN, "Poszukiwani ¯ywi lub Martwi:");
				    foreach(new i : Player)
					{
					    if(IsPlayerConnected(i))
						{
							if(PoziomPoszukiwania[i] >= 2 && PoziomPoszukiwania[i] <= 3 || PoziomPoszukiwania[i] == 10)
					    	{
								new deadReward = PoziomPoszukiwania[i] * 5000;
								new liveReward = PoziomPoszukiwania[i] * 10000;
					    	    GetPlayerName(i, giveplayer, sizeof(giveplayer));
								format(string, sizeof(string), "%s%s, Nagroda: ¿ywy - %d$, martwy - %d$", string,giveplayer, liveReward, deadReward);
								x++;
								if(x > 3)
								{
								    SendClientMessage(playerid, COLOR_YELLOW, string);
								    x = 0;
									format(string, sizeof(string), "");
								}
								else
								{
									format(string, sizeof(string), "%s, ", string);
								}
							}
						}
   					}
					if(x <= 3 && x > 0)
					{
						string[strlen(string)-2] = '.';
					    SendClientMessage(playerid, COLOR_YELLOW, string);
   					}
   					SendClientMessage(playerid, COLOR_GREEN, "Aby wzi¹æ zlecenie na kogoœ wpisz /zlecenie");
   					SendClientMessage(playerid, COLOR_GRAD1, "Wy¿szy skill £owcy Nagród, wiêksze nagrody");
				}
				else if(PlayerInfo[playerid][pDetSkill] >= 100 && PlayerInfo[playerid][pDetSkill] < 200)
			    {
			        new x;
					SendClientMessage(playerid, COLOR_GREEN, "Poszukiwani ¯ywi lub Martwi:");
				    foreach(new i : Player)
					{
					    if(IsPlayerConnected(i))
						{
							if(PoziomPoszukiwania[i] >= 2 && PoziomPoszukiwania[i] <= 4 || PoziomPoszukiwania[i] == 10)
					    	{
								new deadReward = PoziomPoszukiwania[i] * 5000;
								new liveReward = PoziomPoszukiwania[i] * 10000;
					    	    GetPlayerName(i, giveplayer, sizeof(giveplayer));
								format(string, sizeof(string), "%s%s, Nagroda: ¿ywy - %d$, martwy - %d$", string,giveplayer, liveReward, deadReward);
								x++;
								if(x > 3)
								{
								    SendClientMessage(playerid, COLOR_YELLOW, string);
								    x = 0;
									format(string, sizeof(string), "");
								}
								else
								{
									format(string, sizeof(string), "%s, ", string);
								}
							}
						}
					}
					if(x <= 3 && x > 0)
					{
						string[strlen(string)-2] = '.';
					    SendClientMessage(playerid, COLOR_YELLOW, string);
					}
					SendClientMessage(playerid, COLOR_GREEN, "Aby wzi¹æ zlecenie na kogoœ wpisz /zlecenie");
					SendClientMessage(playerid, COLOR_GRAD1, "Wy¿szy skill £owcy Nagród, wiêksze nagrody");
				}
				else if(PlayerInfo[playerid][pDetSkill] >= 200 && PlayerInfo[playerid][pDetSkill] < 400)
			    {
			        new x;
					SendClientMessage(playerid, COLOR_GREEN, "Poszukiwani ¯ywi lub Martwi:");
				    foreach(new i : Player)
					{
					    if(IsPlayerConnected(i))
						{
							if(PoziomPoszukiwania[i] >= 2 && PoziomPoszukiwania[i] <= 5 || PoziomPoszukiwania[i] == 10)
					    	{
								new deadReward = PoziomPoszukiwania[i] * 5000;
								new liveReward = PoziomPoszukiwania[i] * 10000;
					    	    GetPlayerName(i, giveplayer, sizeof(giveplayer));
								format(string, sizeof(string), "%s%s, Nagroda: ¿ywy - %d$, martwy - %d$", string,giveplayer, liveReward, deadReward);
								x++;
								if(x > 3)
								{
								    SendClientMessage(playerid, COLOR_YELLOW, string);
								    x = 0;
									format(string, sizeof(string), "");
								}
								else
								{
									format(string, sizeof(string), "%s, ", string);
     							}
							}
						}
					}
					if(x <= 3 && x > 0)
					{
						string[strlen(string)-2] = '.';
					    SendClientMessage(playerid, COLOR_YELLOW, string);
					}
					SendClientMessage(playerid, COLOR_GREEN, "Aby wzi¹æ zlecenie na kogoœ wpisz /zlecenie");
					SendClientMessage(playerid, COLOR_GRAD1, "Wy¿szy skill £owcy Nagród, wiêksze nagrody");
				}
				else if(PlayerInfo[playerid][pDetSkill] >= 400)
			    {
			        new x;
					SendClientMessage(playerid, COLOR_GREEN, "Poszukiwani ¯ywi lub Martwi:");
				    foreach(new i : Player)
					{
					    if(IsPlayerConnected(i))
						{
							if(PoziomPoszukiwania[i] >= 2 && PoziomPoszukiwania[i] <= 7 || PoziomPoszukiwania[i] == 10)
					    	{
								new deadReward = PoziomPoszukiwania[i] * 5000;
								new liveReward = PoziomPoszukiwania[i] * 10000;
					    	    GetPlayerName(i, giveplayer, sizeof(giveplayer));
								format(string, sizeof(string), "%s%s, Nagroda: ¿ywy - %d$, martwy - %d$", string,giveplayer, liveReward, deadReward);
								x++;
								if(x > 3)
								{
								    SendClientMessage(playerid, COLOR_YELLOW, string);
								    x = 0;
									format(string, sizeof(string), "");
								}
								else
								{
									format(string, sizeof(string), "%s, ", string);
								}
							}
						}
					}
					if(x <= 3 && x > 0)
					{
						string[strlen(string)-2] = '.';
					    SendClientMessage(playerid, COLOR_YELLOW, string);
					}
					SendClientMessage(playerid, COLOR_GREEN, "Aby wzi¹æ zlecenie na kogoœ wpisz /zlecenie");
					SendClientMessage(playerid, COLOR_GRAD1, "Wy¿szy skill £owcy Nagród, wiêksze nagrody");
				}
			}
			else
			{
 				SendClientMessage(playerid, COLOR_YELLOW, "Nie jesteœ w biurze £owcy Nagród");
			}
		}
		else if(PlayerInfo[playerid][pJob] == 2)
		{
			new x;
			SendClientMessage(playerid, COLOR_GREEN, "Lista potencjalnych klientów:");
		    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
				    if(PoziomPoszukiwania[i] >= 2)
				    {
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "%s%s: %d", string,giveplayer,PoziomPoszukiwania[i]);
						x++;
						if(x > 3) {
						    SendClientMessage(playerid, COLOR_YELLOW, string);
						    x = 0;
							format(string, sizeof(string), "");
						} else {
							format(string, sizeof(string), "%s, ", string);
						}
					}
				}
			}
			if(x <= 3 && x > 0) {
				string[strlen(string)-2] = '.';
			    SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		}
		else
		{
		   	new x;
			SendClientMessage(playerid, COLOR_GREEN, "Najbardziej poszukiwani przestêpcy:");
		    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
				    if(PoziomPoszukiwania[i] >= 10)
				    {
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "%s%s: %d", string,giveplayer,PoziomPoszukiwania[i]);
						x++;
						if(x > 3) {
						    SendClientMessage(playerid, COLOR_YELLOW, string);
						    x = 0;
							format(string, sizeof(string), "");
						} else {
							format(string, sizeof(string), "%s, ", string);
						}
					}
				}
			}
			if(x <= 3 && x > 0) {
				string[strlen(string)-2] = '.';
			    SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		}
	}//not connected
	return 1;
}

//end
