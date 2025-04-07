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
command_sblok_Impl(playerid, params[256])
{
    new string[128];

    if(IsPlayerConnected(playerid))
    {
        new giveplayerid, result[64];
        if( sscanf(params, "k<fix>s[64]", giveplayerid, result))
        {
            sendTipMessage(playerid, "U¿yj /sblock [id/nick] [powod]");
            return 1;
        }

		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] == 4)
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
	                Log(punishmentLog, INFO, "Admin %s ukara³ %s kar¹ cichego blocka, powód: %s", 
						GetPlayerLogName(playerid),
						GetPlayerLogName(giveplayerid),
						result);
		            PlayerInfo[giveplayerid][pBlock] = 1;
					SendClientMessage(giveplayerid, COLOR_NEWS, "Twoje konto zosta³o zablokowane. Jeœli block jest nies³uszny wejdŸ na www.Mrucznik-RP.pl i napiœ proœbê o UN BLOCK");
					KickEx(giveplayerid, "block");
					SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
	    			AntySpam[playerid] = 1;
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscBan[playerid] = iloscBan[playerid]+1;
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

//end
