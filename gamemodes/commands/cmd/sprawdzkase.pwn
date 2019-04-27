//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ sprawdzkase ]----------------------------------------------//
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

YCMD:sprawdzkase(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if (IsPlayerInRangeOfPoint(playerid, 50.0, 1038.22924805,-1090.59741211,-67.52223969))
		{
			new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /sprawdzkase[playerid/CzêœæNicku]");
				return 1;
			}


			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(IsPlayerInRangeOfPoint(giveplayerid, 50.0, 1038.22924805,-1090.59741211,-67.52223969))
			        {
      					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string),"|__________________Wnêtrze portfela %s:__________________|",giveplayer);
						SendClientMessage(playerid, COLOR_GREEN, string);
						format(string, sizeof(string), "Dolary amerykañskie:[$%d]", kaska[giveplayerid]);
						SendClientMessage(playerid, COLOR_GREY, string);
						SendClientMessage(playerid, COLOR_GREEN,  "|________Nie graj o wiêcej ni¿ gracz ma w porfelu!________|");
					}
					else
					{
					    sendErrorMessage(playerid, "Ten gracz nie jest w kasynie");
					}
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie ma takiego gracza");
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ w kasynie !");
		}
	}
	return 1;
}
