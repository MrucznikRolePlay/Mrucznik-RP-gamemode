//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ mandacik ]-----------------------------------------------//
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

YCMD:mandacik(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(!IsAPolicja(playerid))
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ policjantem!");
		    return 1;
		}
        if(OnDuty[playerid] != 1 && IsAPolicja(playerid))
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ na s³u¿bie!");
		    return 1;
		}
    	new giveplayerid, moneys, karne, result[128];
		if( sscanf(params, "k<fix>dds[128]", giveplayerid, moneys, karne, result))
		{
			sendTipMessage(playerid, "U¿yj /mandat [playerid/CzêœæNicku] [Stawki dzienne] [Punkty karne] [Powód]");
			return 1;
		}

		if(moneys < 1 || moneys > 50)
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Stawka dzienna od 1 do 50 !");
			sendTipMessageEx(playerid, COLOR_GREY, "Je¿eli nie wiesz jaka kara grozi za dany czyn wpisz /taryfikator");
			return 1;
		}
        if(karne < 0 || karne > 7)
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Punkty karne od 0 do 7 !");
			return 1;
		}
		if(IsPlayerConnected(giveplayerid))
		{
  			if(giveplayerid != INVALID_PLAYER_ID)
		    {
				if(giveplayerid == playerid)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "Nie mo¿esz daæ samemu sobie mandat.");
					return 1;
				}
		        if (ProxDetectorS(8.0, playerid, giveplayerid))
				{
					new stawki = moneys;
					moneys = (PlayerInfo[giveplayerid][pLevel] > 21) ? (stawki*3080) : (stawki*(PlayerInfo[giveplayerid][pLevel]*180));
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "* Da³eœ %s mandat $%d (%dSD), %d PK, powód: %s", giveplayer, moneys, stawki, karne, (result));
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Policjant %s da³ Tobie mandat w wysokoœci $%d (%d0\% twojej wyp³aty), powód: %s", sendername, moneys, stawki, (result));
					SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
                    if(karne > 0)
                    {
                        format(string, sizeof(string), "* Mandat zawiera równie¿ punkty karne w iloœci %d.", karne);
    					SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
                    }
					SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "* Wpisz /akceptuj mandat, aby akceptowaæ.");
					TicketOffer[giveplayerid] = playerid;
					TicketMoney[giveplayerid] = moneys;
                    SetPVarInt(giveplayerid, "mandat_punkty", karne);
					return 1;
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
	return 1;
}
