//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ kb ]--------------------------------------------------//
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

YCMD:kb(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 1)
        {
			new giveplayer[MAX_PLAYER_NAME];
			new string[128];
			if(PlayerInfo[playerid][pLevel] >= 3)
			{
				if(IsAtBank(playerid))
				{
					GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "Konto Bankowe >> %s", giveplayer);
					ShowPlayerDialogEx(playerid, 1067, DIALOG_STYLE_LIST, string, "Stan konta\n\nWp³aæ\nWyp³aæ\nPrzelew\n>>Frakcyjne\n>>Organizacyjne", "Wybierz", "WyjdŸ");
				}
				else
				{
					sendErrorMessage(playerid, "Nie jesteœ w banku!");
				}
			}
			else
			{
				sendErrorMessage(playerid, "Aby móc zarz¹dzaæ swoim kontem bankowym i dokonywaæ przelewów musisz osi¹gn¹æ 3 lvl");
			}
		}
	}
	return 1;
}
