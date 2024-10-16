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
command_kb_Impl(playerid)
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
					ShowPlayerDialogEx(playerid, 1067, DIALOG_STYLE_LIST, string, "Stan konta\n\nWp�a�\nWyp�a�\nPrzelew\n>>Frakcyjne\n>>Organizacyjne", "Wybierz", "Wyjd�");
				}
				else
				{
					sendErrorMessage(playerid, "Nie jeste� w banku!");
				}
			}
			else
			{
				sendErrorMessage(playerid, "Aby m�c zarz�dza� swoim kontem bankowym i dokonywa� przelew�w musisz osi�gn�� 3 lvl");
			}
		}
	}
	return 1;
}

//end
