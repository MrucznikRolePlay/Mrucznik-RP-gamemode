//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ warn ]-------------------------------------------------//
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

CMD:warn(playerid, params[])
{
	new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
    	new giveplayerid, result[64];
		if( sscanf(params, "k<fix>s[64]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U¿yj /warn [playerid/CzêœæNicku] [reason]");
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

		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
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
					new str[128];
		            if(PlayerInfo[giveplayerid][pAdmin] >= 1)
		            {
		                sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zwarnowaæ Admina !");
		                return 1;
		            }
                    if(gPlayerLogged[giveplayerid] == 0)
                    {
                        sendTipMessageEx(playerid, COLOR_WHITE, " Gracz nie jest zalogowany, u¿yj kicka.");
						return 1;
                    }
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[giveplayerid][pWarns] += 1;
					if(PlayerInfo[giveplayerid][pWarns] >= 3)
					{
					    if(gPlayerLogged[giveplayerid] != 0)
						{
						    SendClientMessage(giveplayerid, COLOR_NEWS, "SprawdŸ czy otrzymana kara jest zgodna z list¹ kar i zasad, znajdziesz j¹ na www.Mrucznik-RP.pl");
							format(string, sizeof(string), "AdmCmd: %s zosta³ zbanowany przez Admina %s (3 warny), powód: %s", giveplayer, sendername, (result));
							BanLog(string);
							format(string, sizeof(string), "AdmCmd: %s zosta³ zbanowany przez Admina %s (3 Ostrze¿enia), powód: %s", giveplayer, sendername, (result));
                            SendPunishMessage(string, giveplayerid);
							//adminowe logi
					        format(str, sizeof(str), "Admini/%s.ini", sendername);
					        dini_IntSet(str, "Ilosc_Warnow", dini_Int(str, "Ilosc_Warnow")+1 );
							MruMySQL_Banuj(giveplayerid, result, playerid);
							KickEx(giveplayerid);
							return 1;
						}
					}
					format(str, sizeof(str), "Da³eœ warna %s, powód: %s", giveplayer, (result));
					SendClientMessage(playerid, COLOR_LIGHTRED, str);
					format(str, sizeof(str), "Dosta³eœ warna od %s, powód: %s", sendername, (result));
					SendClientMessage(giveplayerid, COLOR_LIGHTRED, str);
					format(string, sizeof(string), "AdmCmd: %s zostal zwarnowany przez Admina %s, powód: %s", giveplayer, sendername, (result));
                    SendPunishMessage(string, giveplayerid);
					/*format(str,sizeof(str),"~p~Warn Info (Ban):~n~~r~Osoba zwarnowana: ~w~%s~n~~r~Powod: ~w~%s ~n~~r~Nalozyl: ~w~%s", giveplayer ,(result), sendername);
				    NapisText(str); */
					WarnLog(string);
					SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
	    			AntySpam[playerid] = 1;
	    			KickEx(giveplayerid);
					return 1;
				}
			}//not connected
            else
            {
                format(string, sizeof(string), "Gracz o ID %d nie jest po³aczony.", giveplayerid);
			    sendErrorMessage(playerid, string);
            }
		}
        else {
            return noAccessMessage(playerid);
        }
		/*else
		{
			format(string, sizeof(string), "   Gracz o ID %d nie istnieje.", giveplayerid);
			SendClientMessage(playerid, COLOR_GRAD1, string);
		}*/
	}
	return 1;
} 


