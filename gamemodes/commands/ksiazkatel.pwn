//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ ksiazkatel ]----------------------------------------------//
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

CMD:number(playerid, params[]) return cmd_ksiazkatel(playerid, params);
CMD:numer(playerid, params[]) return cmd_ksiazkatel(playerid, params);
CMD:sprawdznumber(playerid, params[]) return cmd_ksiazkatel(playerid, params);
CMD:ksiazka(playerid, params[]) return cmd_ksiazkatel(playerid, params);
CMD:ksiazkatel(playerid, params[])
{
	new string[64];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pPhoneBook] == 1)
		{
			new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /numer [playerid/CzêœæNicku]");
				return 1;
			}


			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					GetPlayerName(giveplayerid, sendername, sizeof(sendername));
					format(string, 64, "Nick: %s, Numer: %d",sendername,PlayerInfo[giveplayerid][pPnumber]);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie ma takiego gracza !");
			}
		}
		else
		{
			sendTipMessage(playerid, "Nie posiadasz Ksi¹¿ki Telefonicznej !");
		}
	}
	return 1;
}

