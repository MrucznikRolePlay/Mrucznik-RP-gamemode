//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ obrazenia ]-----------------------------------------------//
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
// Autor: werem
// Data utworzenia: 5.04.2020

// Opis:
/*

*/


// Notatki skryptera:
/*
	
*/
YCMD:obrazenia(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new giveplayerid, param[24];
		if( sscanf(params, "s[24]k<fix>", param, giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /obrazenia o(otrzymane) z(zadane) [playerid/CzêœæNicku]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 100)
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
				if(strcmp(param, "o", true) == 0 || strcmp(param, "otrzymane", true) == 0) ShowPlayerDamaged(giveplayerid, playerid);
				else if(strcmp(param, "z", true) == 0 || strcmp(param, "zadane", true) == 0) ShowPlayerDamage(giveplayerid, playerid);
				else sendErrorMessage(playerid, "Niepoprawny argument (otrzymane/zadane)");
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}