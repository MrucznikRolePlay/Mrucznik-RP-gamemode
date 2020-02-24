//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ rozkuj ]------------------------------------------------//
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

YCMD:rozkuj(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
    {
		if(gTeam[playerid] == 2 || IsACop(playerid) || IsABOR(playerid))
		{
		    new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /rozkuj [playerid/CzêœæNicku]");
				return 1;
			}
			if(IsPlayerConnected(giveplayerid))
			{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
				    if (ProxDetectorS(8.0, playerid, giveplayerid))
					{
					    if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz odkuæ samego siebie!"); return 1; }
						if(PlayerCuffed[giveplayerid] == 2 || zakuty[giveplayerid] >= 1)
						{
							UnCuffedAction(playerid, giveplayerid);
						}
						else
						{
						    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest skuty !");
						    return 1;
						}
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
					    return 1;
					}
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza !");
			    return 1;
			}
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ z Policji / FBI / SASD /BOR !");
		}
	}//not connected
	return 1;
}
