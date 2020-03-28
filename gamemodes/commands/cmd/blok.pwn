//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ blok ]-------------------------------------------------//
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

YCMD:blok(playerid, params[], help)
{
	new string[128];
    if(IsPlayerConnected(playerid))
    {
        new giveplayerid, result[128];
        if( sscanf(params, "k<fix>s[128]", giveplayerid, result))
        {
            sendTipMessage(playerid, "U¿yj /block [id/nick] [powod]");
            return 1;
        }

		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pZG] >= 4 || (PlayerInfo[playerid][pHalfAdmin] >= 1 && PlayerInfo[playerid][pHalfAdmin] <= 3) || IsAScripter(playerid))
		{
		    if(AntySpam[playerid] == 1)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
        	if(IsPlayerConnected(giveplayerid))
        	{
            	if(giveplayerid != INVALID_PLAYER_ID)
            	{
            	    if(PlayerInfo[giveplayerid][pAdmin] >= 1)
		            {
		                sendErrorMessage(playerid, "Nie mozesz zablokowaæ Admina !");
		                return 1;
		            }
		            if(PlayerInfo[giveplayerid][pHalfAdmin] >= 1 && PlayerInfo[playerid][pZG] >= 4)
		            {
		                sendErrorMessage(playerid, "Nie mozesz zablokowaæ P@!");
		                return 1;
		            }
		            if(PlayerInfo[playerid][pZG] >= 4 && PlayerInfo[playerid][pZG] < 8 && PlayerInfo[giveplayerid][Level] > 1)
		            {
		                sendErrorMessage(playerid, "Nie mozesz zablokowaæ gracza z lvl wiekszym niz 1!");
		                return 1;
		            }
					GiveBlockForPlayer(giveplayerid, playerid, (result));
					if(kary_TXD_Status == 0)
					{
						format(string, sizeof(string), "Admin %s zablokowa³ konto gracza %s. Powód: %s", GetNickEx(playerid), GetNick(giveplayerid), (result)); 
						SendPunishMessage(string, giveplayerid);
					}
					else if(kary_TXD_Status == 1)
					{
						BlockPlayerTXD(giveplayerid, playerid, (result));
					}
	              
		            return 1;
	            }
   			}
  		}
  		else
	 	{
			format(string, sizeof(string), " %d nie jest aktywnym graczem.", giveplayerid);
      		sendErrorMessage(playerid, string);
		}
	}
	return 1;
}
