//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ restart ]------------------------------------------------//
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

YCMD:restart(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		if (PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
		{
			new string[128];
			new playerNick[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playerNick, sizeof(playerNick));
			format(string, sizeof(string), "%s zarz¹dzi³ restart serwera! Trwa próba ponownego po³¹czenia", playerNick);
			foreach(new i : Player)
			{
				TogglePlayerControllable(i, 0);
				MruMySQL_SaveAccount(i);
				sendErrorMessage(i, string);
			}
			ZapiszDomy();
			SendRconCommand("gmx");
		}
		else
		{
			sendErrorMessage(playerid, "BRAK UPRAWNIEÑ!");
			return 1;
		}
	}
	return 1;
}
