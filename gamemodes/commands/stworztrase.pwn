//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ stworztrase ]----------------------------------------------//
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

CMD:stworzwyscig(playerid) return cmd_stworztrase(playerid);
CMD:stworztrase(playerid)
{
	new string[128];

	if(GUIExit[playerid] == 0)
	{
		if(IsANoA(playerid))
		{
			if(PlayerInfo[playerid][pRank] >= 4)
			{
				new ow = IsAWyscigTworzony();
				if(ow == -1)
				{
					new wklej[70];
					new trasy[512];
					for(new i=0; i<sizeof(Wyscig); i++)
					{
						if(Wyscig[i][wStworzony] == 1)
						{
							format(wklej, sizeof(wklej), "%s\n", Wyscig[i][wNazwa]);
							strcat(trasy, wklej);
						}
						else
						{
							strcat(trasy, "Wolny\n");
						}
					}
					ShowPlayerDialogEx(playerid, 1420, DIALOG_STYLE_LIST, "Kreator wyœcigów: Wybierz slot", trasy, "Wybierz", "Anuluj");
				}
				else
				{
					printf("%d", ow);
					format(string, sizeof(string), "Gracz [%d] %s jest w trakcie tworzenia wyscigu. Poczekaj a¿ skoñczy", ow, GetNick(ow));
					sendTipMessage(playerid, string);
				}
			}
			else
			{
				sendErrorMessage(playerid, "Potrzebujesz 4 rangi by tworzyæ wyœcigi!");
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ z NoA!");
		}
	}
	return 1;
}

