//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ nastepnylevel ]---------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:nastepnylevel(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		if (gPlayerLogged[playerid] != 0)
		{
		    PlayerInfo[playerid][BankMoney] = kaska[playerid];
			if(PlayerInfo[playerid][Level] >= 0)
			{
				new nxtlevel = PlayerInfo[playerid][Level]+1;
				new costlevel = nxtlevel*levelcost;//10k for testing purposes
				new expamount = nxtlevel*levelexp;
				new infostring[128];
				if (PlayerInfo[playerid][Exp] < expamount)
				{
					format(infostring, 128, "Potrzebujesz %d punktów Respektu, aktualnie posiadasz tylko %d!",expamount,PlayerInfo[playerid][Exp]);
					sendTipMessageEx(playerid, COLOR_GRAD1, infostring);
					return 1;
				}
				else
				{
					format(string, sizeof(string), "~g~LEVEL UP~n~~w~Posiadasz teraz %d level", nxtlevel);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					PlayerPlayMusic(playerid);
					DajKase(playerid, (costlevel));
					PlayerInfo[playerid][Level]++;
					if(IsPlayerPremiumOld(playerid))
					{
					    PlayerInfo[playerid][Exp] -= expamount;
					    new total = PlayerInfo[playerid][Exp];
					    if(total > 0)
					    {
					        PlayerInfo[playerid][Exp] = total;
					    }
					    else
					    {
					        PlayerInfo[playerid][Exp] = 0;
					    }
					}
					else
					{
						PlayerInfo[playerid][Exp] = 0;
					}
					PlayerInfo[playerid][UpgradeLvl] = PlayerInfo[playerid][UpgradeLvl]+2;
					GameTextForPlayer(playerid, string, 5000, 1);
					format(infostring, 128, "Masz teraz %d level, dosta³eœ bonus $%d, u¿yj /ulepszenia aby zobaczyæ bonusy", nxtlevel, costlevel);
					sendTipMessageEx(playerid, COLOR_GRAD1, infostring);
					format(infostring, 128, "Dosta³eœ bonus %d punktów Ulepszenia",PlayerInfo[playerid][UpgradeLvl]);
					sendTipMessageEx(playerid, COLOR_GRAD2, infostring);
				}
			}
			return 1;
		}
	}
	return 1;
}
