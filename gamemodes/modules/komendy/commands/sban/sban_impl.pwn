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
command_sban_Impl(playerid, params[256])
{
    new string[256];

    if(IsPlayerConnected(playerid))
    {
    	new giveplayerid, result[128];
		if( sscanf(params, "k<fix>s[128]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U�yj /sban [playerid/Cz��Nicku] [reason]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] == 4)
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
					if(PlayerInfo[giveplayerid][pAdmin] >= 1)
					{
						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zbanowa� Admina!");
						return 1;
					}
					
					Log(punishmentLog, INFO, "Admin %s ukara� %s kar� cichego bana, pow�d: %s", 
						GetPlayerLogName(playerid),
						GetPlayerLogName(giveplayerid),
						result);
					format(string, sizeof(string), "Admin %s ukara� %s kar� cichego bana, pow�d: %s", 
						GetNick(playerid), GetNick(giveplayerid), result);
					SendAdminMessage(COLOR_PANICRED, string);
				    MruMySQL_Banuj(giveplayerid, result, playerid);
					KickEx(giveplayerid, "ban");
					SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
					AntySpam[playerid] = 1;
					return 1;
				}
			}//not connected
		}
		else
		{
			format(string, sizeof(string), "   Gracz o ID %d nie istnieje.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}

//end
