//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ endround ]-----------------------------------------------//
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

CMD:endround(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
  		if (IsAHeadAdmin(playerid))
		{
            SendClientMessage(playerid, COLOR_GRAD1, "(usuniêto)");
			//GameModeInitExitFunc();
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}



/*CMD:zaufani(playerid, params[])
{
	new string[64];
	new sendername[MAX_PLAYER_NAME];

	SendClientMessage(playerid, COLOR_GRAD1, "Lista ZG:");
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pZG] == 1)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Opiekun IC: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 2)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Nowy Zaufany gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 3)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Zwyk³y zaufany gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 4)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Zaufany Gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 5)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Przyzwoity Zaufany Gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 6)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Dobry Zaufany Gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 7)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Bardzo Dobry Zaufany Gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 8)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Œwietny Zaufany Gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 9)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Znakomity Zaufany Gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 10)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Æwieræ Admin: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
		}
	}
	return 1;
}*/


