//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ ulepsz ]------------------------------------------------//
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

YCMD:ulepsz(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new gunid[16];
		if( sscanf(params, "s[16] ", gunid))
		{
			format(string, sizeof(string), "U¯YJ: /ulepsz [nazwaulepszenia] (Posiadasz %d Punktów Ulepszenia)",PlayerInfo[playerid][gPupgrade]);
			SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
			SendClientMessage(playerid, COLOR_WHITE,"*** ULEPSZENIA ***");
			sendTipMessage(playerid,string);
			if(PlayerInfo[playerid][pLevel] == 2)
			{
				SendClientMessage(playerid, COLOR_GRAD3, "Level 2 Ulepszen: Alkoholik, Cpun");
			}
			else if(PlayerInfo[playerid][pLevel] == 3)
			{
				SendClientMessage(playerid, COLOR_GRAD3, "Level 3 Ulepszen: Alkoholik, Cpun, Matsiarz");
			}
			else if(PlayerInfo[playerid][pLevel] == 3)
			{
				SendClientMessage(playerid, COLOR_GRAD3, "Level 4 Ulepszen: Alkoholik, Cpun, Matsiarz, Handlowiec");
			}
			else if(PlayerInfo[playerid][pLevel] >= 5)
			{
				SendClientMessage(playerid, COLOR_GRAD3, "Level 5 Ulepszen: Alkoholik, Cpun, Matsiarz, Handlowiec, Lekoman");
			}
			SendClientMessage(playerid, COLOR_GRAD5, "Super Zycie: HP");
			SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
			return 1;
		}
		if (PlayerInfo[playerid][gPupgrade] > 1)
		{
			if (PlayerInfo[playerid][pLevel] >= 1 && (strcmp(gunid, "hp", true, strlen(gunid)) == 0))
			{
				if (PlayerInfo[playerid][pSHealth] < 50)
				{
					PlayerInfo[playerid][pSHealth] = PlayerInfo[playerid][pSHealth]+5.0;
					format(string, 128, "Nowe Ulepszenie: Teraz bêdziesz siê spawnowa³ z %.2f ¯yciem (+5)",PlayerInfo[playerid][pSHealth]+50);
				}
				else
				{
					SendClientMessage(playerid, COLOR_GRAD6, "Masz maksymaln¹ iloœæ HP na spawnie");
					return 1;
				}
			}
			else if (PlayerInfo[playerid][pLevel] >= 2 && (strcmp(gunid, "alkoholik", true, strlen(gunid)) == 0))
			{
				if (PlayerInfo[playerid][pAlcoholPerk] < 3)
				{
					PlayerInfo[playerid][pAlcoholPerk] += 1;
					format(string, 128, "Nowe Ulepszenie: Twój poziom Alkoholika wynosi teraz %d.",PlayerInfo[playerid][pAlcoholPerk]);
					PlayerInfo[playerid][gPupgrade]--;
				}
				else
				{
					SendClientMessage(playerid, COLOR_GRAD6, "Masz maksymalny poziom Alkoholika !");
					return 1;
				}
			}
			else if (PlayerInfo[playerid][pLevel] >= 2 && (strcmp(gunid, "cpun", true, strlen(gunid)) == 0))
			{
				if (PlayerInfo[playerid][pDrugPerk] < 3)
				{
					PlayerInfo[playerid][pDrugPerk] += 1;
					format(string, 128, "Nowe Ulepszenie: Twój poziom Cpuna wynosi teraz %d.",PlayerInfo[playerid][pDrugPerk]);
					PlayerInfo[playerid][gPupgrade]--;
				}
				else
				{
					SendClientMessage(playerid, COLOR_GRAD6, "Masz maksymalny poziom Cpuna !");
					return 1;
				}
			}
			else if (PlayerInfo[playerid][pLevel] >= 3 && (strcmp(gunid, "matsiarz", true, strlen(gunid)) == 0))
			{
				if (PlayerInfo[playerid][pMiserPerk] < 3)
				{
					PlayerInfo[playerid][pMiserPerk] += 1;
					format(string, 128, "Nowe Ulepszenie: Twój poziom matsiarz wynosi teraz %d.",PlayerInfo[playerid][pMiserPerk]);
					PlayerInfo[playerid][gPupgrade]--;
				}
				else
				{
					SendClientMessage(playerid, COLOR_GRAD6, "Masz maksymalny poziom Sk¹pca !");
					return 1;
				}
			}
			else if (PlayerInfo[playerid][pLevel] >= 4 && (strcmp(gunid, "handlowiec", true, strlen(gunid)) == 0))
			{
				if (PlayerInfo[playerid][pTraderPerk] < 3)
				{
					PlayerInfo[playerid][pTraderPerk] += 1;
					format(string, 128, "Nowe Ulepszenie: Twój poziom Handlowca wynosi teraz %d.",PlayerInfo[playerid][pTraderPerk]);
					PlayerInfo[playerid][gPupgrade]--;
				}
				else
				{
					SendClientMessage(playerid, COLOR_GRAD6, "Masz maksymalny poziom Handlowca !");
					return 1;
				}
			}
			else if (PlayerInfo[playerid][pLevel] >= 5 && (strcmp(gunid, "Lekoman", true, strlen(gunid)) == 0))
			{
				if (PlayerInfo[playerid][pPainPerk] < 3)
				{
					PlayerInfo[playerid][pPainPerk] += 1;
					format(string, 128, "Nowe Ulepszenie: Twój poziom Lekomana wynosi teraz %d.",PlayerInfo[playerid][pPainPerk]);
					PlayerInfo[playerid][gPupgrade]--;
				}
				else
				{
					SendClientMessage(playerid, COLOR_GRAD6, "Masz maksymalny poziom Lekomana !");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD6, "Nierozpoznane ulepszenie");
				return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GRAD6, "Masz 0 Punktów Ulepszenia");
			return 1;
		}
		SendClientMessage(playerid, COLOR_GRAD6, string);
		PlayerInfo[playerid][gPupgrade]--;
	}
	return 1;
}
