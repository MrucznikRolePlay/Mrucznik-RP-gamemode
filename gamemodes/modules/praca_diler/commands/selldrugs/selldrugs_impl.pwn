//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 selldrugs                                                 //
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
// Data utworzenia: 06.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_selldrugs_Impl(playerid, giveplayerid, weight, price)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
	    if(PlayerInfo[playerid][pJob] != 4)
	    {
			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ Dilerem Dragów!");
			return 1;
	    }
        if(GetPVarInt(playerid, "wydragowany") > 0) return sendErrorMessage(playerid, "Dragi mo¿esz sprzedawaæ raz na minutê!");
		if(weight < 1 || weight > 99) { SendClientMessage(playerid, COLOR_GREY, "   Iloœæ gram od 1 do 60!"); return 1; }
		if(price < 1 || price > 9999) { SendClientMessage(playerid, COLOR_GREY, "   Cena od 1 do 9999!"); return 1; }
		if(weight > PlayerInfo[playerid][pDrugs]) { SendClientMessage(playerid, COLOR_GREY, "   Nie masz a¿ tylu narkotyków przy sobie !"); return 1; }
		if(IsPlayerConnected(giveplayerid))
		{
		    if(giveplayerid != INVALID_PLAYER_ID)
		    {
				if (ProxDetectorS(8.0, playerid, giveplayerid))
				{
				    if(giveplayerid == playerid)
				    {
				        sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz sprzedaæ dragów samemu sobie!");
				        return 1;
				    }
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
				    format(string, sizeof(string), "* Oferujesz %s sprzeda¿ %d gram za $%d .", giveplayer, weight, price);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Diler Dragów %s oferuje sprzeda¿ %d gram narkotyków za $%d, (wpisz /akceptuj dragi) aby kupiæ.", sendername, weight, price);
					SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
					DrugOffer[giveplayerid] = playerid;
					DrugPrice[giveplayerid] = price;
					DrugGram[giveplayerid] = weight;
				}
				else
				{
				    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
				}
			}
		}
		else
		{
		    sendErrorMessage(playerid, "   Nie ma takiego gracza.");
		}
	}
	return 1;
}

//end