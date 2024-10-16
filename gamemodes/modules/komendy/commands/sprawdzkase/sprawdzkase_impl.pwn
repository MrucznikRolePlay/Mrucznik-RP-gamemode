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
command_sprawdzkase_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if (IsAtCasino(playerid))
		{
			new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U�yj /sprawdzkase[playerid/Cz��Nicku]");
				return 1;
			}


			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(IsAtCasino(giveplayerid))
			        {
      					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string),"|__________________Wn�trze portfela %s:__________________|",giveplayer);
						SendClientMessage(playerid, COLOR_GREEN, string);
						format(string, sizeof(string), "Dolary ameryka�skie:[$%d]", kaska[giveplayerid]);
						SendClientMessage(playerid, COLOR_GREY, string);
						SendClientMessage(playerid, COLOR_GREEN,  "|________Nie graj o wi�cej ni� gracz ma w porfelu!________|");
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
			sendErrorMessage(playerid, "Nie jeste� w kasynie !");
		}
	}
	return 1;
}

//end
