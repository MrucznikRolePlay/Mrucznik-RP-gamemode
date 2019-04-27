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

CMD:buylevel(playerid) return cmd_nastepnylevel(playerid);
CMD:kuplevel(playerid) return cmd_nastepnylevel(playerid);
CMD:nextlevel(playerid) return cmd_nastepnylevel(playerid);
CMD:nastepnylevel(playerid)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		if (gPlayerLogged[playerid] != 0)
		{
		    PlayerInfo[playerid][pCash] = kaska[playerid];
			if(PlayerInfo[playerid][pLevel] >= 0)
			{
				new nxtlevel = PlayerInfo[playerid][pLevel]+1;
				new costlevel = nxtlevel*levelcost;//10k for testing purposes
				new expamount = nxtlevel*levelexp;
				new infostring[128];
				if (PlayerInfo[playerid][pExp] < expamount)
				{
					format(infostring, 128, "Potrzebujesz %d punktów Respektu, aktualnie posiadasz tylko %d!",expamount,PlayerInfo[playerid][pExp]);
					sendTipMessageEx(playerid, COLOR_GRAD1, infostring);
					return 1;
				}
				else
				{
					format(string, sizeof(string), "~g~LEVEL UP~n~~w~Posiadasz teraz %d level", nxtlevel);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					PlayerPlayMusic(playerid);
					DajKase(playerid, (costlevel));
					PlayerInfo[playerid][pLevel]++;
					if(PlayerInfo[playerid][pDonateRank] > 0)
					{
					    PlayerInfo[playerid][pExp] -= expamount;
					    new total = PlayerInfo[playerid][pExp];
					    if(total > 0)
					    {
					        PlayerInfo[playerid][pExp] = total;
					    }
					    else
					    {
					        PlayerInfo[playerid][pExp] = 0;
					    }
					}
					else
					{
						PlayerInfo[playerid][pExp] = 0;
					}
					PlayerInfo[playerid][gPupgrade] = PlayerInfo[playerid][gPupgrade]+2;
					GameTextForPlayer(playerid, string, 5000, 1);
					format(infostring, 128, "Masz teraz %d level, dosta³eœ bonus $%d, u¿yj /ulepszenia aby zobaczyæ bonusy", nxtlevel, costlevel);
					sendTipMessageEx(playerid, COLOR_GRAD1, infostring);
					format(infostring, 128, "Dosta³eœ bonus %d punktów Ulepszenia",PlayerInfo[playerid][gPupgrade]);
					sendTipMessageEx(playerid, COLOR_GRAD2, infostring);
				}
			}
			return 1;
		}
	}
	return 1;
}

