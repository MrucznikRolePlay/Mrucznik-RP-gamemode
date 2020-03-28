//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ undemorgan ]----------------------------------------------//
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

YCMD:undemorgan(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 35 || IsAScripter(playerid))
        {
            
        
			new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /prisonoff [id/nick]");
				return 1;
			}

			if(IsPlayerConnected(giveplayerid))
			{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "* Uwolni³eœ %s z Fortu DeMorgan.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
					format(string, sizeof(string), "* Zosta³eœ uwolniony z DeMorgan przez admina %s.", sendername);
					SendClientMessage(giveplayerid, COLOR_LIGHTRED, string);
					format(string, sizeof(string), "* %s zosta³ uwolniony z DeMorgan przez admina %s.",giveplayer, sendername);
					SendPunishMessage(string, giveplayerid);
					UnJailDeMorgan(giveplayerid);
					poscig[giveplayerid] = 0;
				}
			}
			else
			{
				sendErrorMessage(playerid, "Ten gracz jest offline!");
				return 1;
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
    }
    return 1;
}
