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
						if(PlayerCuffed[giveplayerid] == 2 || Kajdanki_JestemZakuty[giveplayerid] >= 1)
						{
							new string[128];
                            format(string, sizeof(string), "* Zosta³eœ rozkuty przez %s.", GetNick(playerid));
                            SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
                            format(string, sizeof(string), "* Rozku³eœ %s.", GetNick(giveplayerid));
							
							UnCuffedAction(playerid, giveplayerid);
						}
						else
						{
						    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest skuty !");
						}
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
					}
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza !");
			}
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ z Policji / FBI / SASD /BOR !");
		}
	}//not connected
	return 1;
}
