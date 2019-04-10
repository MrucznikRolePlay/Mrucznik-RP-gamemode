//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ kick ]-------------------------------------------------//
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

CMD:kick(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
    	new giveplayerid, result[128];
		if( sscanf(params, "k<fix>s[128]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U¿yj /kick [playerid/CzêœæNicku] [reason]");
			return 1;
		}
		if(giveplayerid == 65535)
		{
			if(sscanf(params, "ds[64]", giveplayerid, result)) 
			{
				sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz ma zbugowane ID. Wpisz jego ID zamiast nicku aby go zbanowaæ.");
				return 1;
			}
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG] >= 1)
		{
		    if(AntySpam[playerid] == 1)
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
			if(IsPlayerConnected(giveplayerid) || true)//bug z id
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
                    if(PlayerInfo[giveplayerid][pAdmin] >= 1) return sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zkickowaæ Admina !");
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
  					if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pZG] >= 2 || PlayerInfo[playerid][pNewAP] >= 1)
  					{
      					SendClientMessage(giveplayerid, COLOR_NEWS, "SprawdŸ czy otrzymana kara jest zgodna z list¹ kar i zasad, znajdziesz j¹ na www.Mrucznik-RP.pl");
						format(string, sizeof(string), "AdmCmd: Admin %s zkickowa³ %s, Powód: %s", sendername, giveplayer, (result));
						KickLog(string);
						format(string, sizeof(string), "AdmCmd: Admin %s zkickowa³ %s, Powód: %s", sendername, giveplayer, (result));
                        SendPunishMessage(string, giveplayerid);
						//adminowe logi
						if (PlayerInfo[playerid][pZG] >= 1)
					    {
					        format(string, sizeof(string), "Zaufani/%s.ini", sendername);
					        dini_IntSet(string, "Ilosc_Kickow", dini_Int(string, "Ilosc_Kickow")+1 );
					    }
					    else
					    {
							format(string, sizeof(string), "Admini/%s.ini", sendername);
					     	dini_IntSet(string, "Ilosc_Kickow", dini_Int(string, "Ilosc_Kickow")+1 );
						}
						KickEx(giveplayerid);
						SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
	    				AntySpam[playerid] = 1;
						return 1;
					}
				}
			}
		}
		else
		{
			format(string, sizeof(string), "Gracz o ID %d nie istnieje.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}

