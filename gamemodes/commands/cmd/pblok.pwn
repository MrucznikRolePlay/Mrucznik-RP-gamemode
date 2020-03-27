//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ pblok ]-------------------------------------------------//
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

YCMD:pblok(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][Admin] >= 1)
		{
		    if(AntySpam[playerid] == 1)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
	   		new nick[MAX_PLAYER_NAME], result[128];
			if( sscanf(params, "s[24] s[128]", nick, result))
			{
				sendTipMessage(playerid, "U¿yj /pblock [NICK GRACZA OFFLINE] [powod]");
				return 1;
			}

			new giveplayerid;
			sscanf(nick, "k<fix>", giveplayerid);
            if(IsPlayerConnected(giveplayerid))
			{
			    sendErrorMessage(playerid, "Nie mo¿esz zablokowaæ tego gracza (jest online (na serwerze))");
				return 1;
			}

			if(MruMySQL_DoesAccountExist(nick) != -1)
			{
				sendErrorMessage(playerid, "Brak gracza w bazie, nie mo¿na zablokowaæ (konto nie istnieje).");
				return 1;
			}
			else
			{
				if(MruMySQL_GetAccInt("Block", nick) != 0) return sendErrorMessage(playerid, "Gracz ma ju¿ aktywn¹ blokadê postaci.");
			}
			
			GivePBlockForPlayer((nick), playerid, (result));
			if(kary_TXD_Status == 1)
			{
				PBlockPlayerTXD((nick), playerid, (result));
            }
			else if(kary_TXD_Status == 0)
			{
				format(string, sizeof(string), "Admin %s zablokowa³ (offline) konto gracza %s. Powód: %s", GetNickEx(playerid), nick, result);
				SendPunishMessage(string, playerid); 
			}
		}
	}
	return 1;
}
