//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ skick ]-------------------------------------------------//
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

YCMD:skick(playerid, params[], help)
{
	new string[256];

    if(IsPlayerConnected(playerid))
    {
    	new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /skick [playerid/CzêœæNicku]");
			return 1;
		}

		if (PlayerInfo[playerid][Admin] >= 5000 || PlayerInfo[playerid][HalfAdmin] == 4 || PlayerInfo[playerid][Admin] == 7)
		{
		    if(AntySpam[playerid] == 1)
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(PlayerInfo[giveplayerid][Admin] >= 1 || PlayerInfo[giveplayerid][HalfAdmin] >= 1 || PlayerInfo[giveplayerid][pZG] >= 4)
		            {
		                sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zkickowaæ Admina !");
		                return 1;
		            }
					Log(punishmentLog, INFO, "Admin %s ukara³ %s kar¹ cichego kicka", 
						GetPlayerLogName(playerid),
						GetPlayerLogName(giveplayerid));
					KickEx(giveplayerid);
					SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
					AntySpam[playerid] = 1;
			    }
			}
		}
		else
		{
			format(string, sizeof(string), "   Gracz o ID %d nie istnieje.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}
