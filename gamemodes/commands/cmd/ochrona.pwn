//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ ochrona ]------------------------------------------------//
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

YCMD:ochrona(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(PlayerInfo[playerid][pJob] != 8)
    {
		sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ ochroniarzem!");
		return 1;
    }
	new giveplayerid, money;
	if( sscanf(params, "k<fix>d", giveplayerid, money))
	{
		sendTipMessage(playerid, "U¿yj /ochrona [playerid/CzêœæNicku] [cena]");
		return 1;
	}

	if(money < 5000 || money > 15000) { sendTipMessageEx(playerid, COLOR_GREY, "Cena od 5000 do 15000!"); return 1; }
	if(IsPlayerConnected(giveplayerid))
	{
	    if(giveplayerid != INVALID_PLAYER_ID)
	    {
	        if(ProxDetectorS(8.0, playerid, giveplayerid) && Spectate[giveplayerid] == INVALID_PLAYER_ID)
			{
                if(gettime() < GetPVarInt(playerid, "armoryTimeLimit"))
                {
                    return sendErrorMessage(playerid, "Kamizelki oferowaæ mo¿esz co 45 sekundy");
                }
			    if(giveplayerid == playerid)
			    {
			        if(gettime() < GetPVarInt(playerid, "selfArmorLimit")) {
                        return sendErrorMessage(playerid, "Mo¿esz oferowaæ kamizelke samemu sobie co 15 minut");
                    }
                    SetPVarInt(playerid, "selfArmorLimit", gettime() + 900);
                    SetPlayerArmour(playerid, 90);

                    sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Da³eœ sobie samemu kamizelkê");
			        return 1;
			    }
			    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
			    format(string, sizeof(string), "* Oferujesz ochronê %s za $%d.", giveplayer, money);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Ochroniarz %s oferuje ci kamielkê za $%d, (wpisz /akceptuj ochrona) aby akceptowaæ", sendername, money);
				SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				GuardOffer[giveplayerid] = playerid;
				GuardPrice[giveplayerid] = money;

                SetPVarInt(playerid, "armoryTimeLimit", gettime() + 45);
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
			}
		}
	}
	else
	{
	    sendErrorMessage(playerid, "Nie ma takiego gracza!");
	}
	return 1;
}
