//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ sex ]--------------------------------------------------//
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

YCMD:sex(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
        if(PlayerInfo[playerid][pJob] == 3)
		{
		    if(!IsPlayerInAnyVehicle(playerid))
		    {
				sendTipMessageEx(playerid, COLOR_GREY, "Mo¿esz oferowaæ sex tylko w pojeŸdzie !");
				return 1;
		    }
		    new Car = GetPlayerVehicleID(playerid);
			new giveplayerid, money;
			if( sscanf(params, "k<fix>d", giveplayerid, money))
			{
				sendTipMessage(playerid, "U¿yj /sex [playerid/CzêœæNicku] [cena]");
				return 1;
			}
            if(GetPVarInt(playerid, "wysekszony") > 0) return sendErrorMessage(playerid, "Stosunek mo¿esz uprawiaæ raz na dwie minuty!");
			if(money < 1 || money > 9999) { sendTipMessageEx(playerid, COLOR_GREY, "Cena od 1$ do 9999$!"); return 1; }
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					if (ProxDetectorS(8.0, playerid, giveplayerid))
					{
					    if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz oferowaæ sexu temu graczowi!"); return 1; }
					    if(IsPlayerInAnyVehicle(playerid) && IsPlayerInVehicle(giveplayerid, Car))
					    {
						    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
							format(string, sizeof(string), "* Oferujesz %s uprawianie sexu z tob¹ za $%d.", giveplayer, money);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* Prostytutka %s oferuje uprawianie sexu z ni¹ za $%d (wpisz /akceptuj sex) aby siê zgodziæ.", sendername, money);
							SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				            SexOffer[giveplayerid] = playerid;
				            SexPrice[giveplayerid] = money;
			            }
			            else
			            {
			                sendTipMessageEx(playerid, COLOR_GREY, "Musicie byæ w pojeŸdzie aby to zrobiæ !");
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
				sendErrorMessage(playerid, "Nie ma takiego gracza!");
				return 1;
			}
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ prostytutk¹ !");
		}
	}//not connected
	return 1;
}
