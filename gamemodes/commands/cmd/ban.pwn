//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ ban ]--------------------------------------------------//
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

YCMD:ban(playerid, params[], help)
{
	new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid)) 
    {
    	new giveplayerid, result[64];
		if( sscanf(params, "k<fix>s[64]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U¿yj /ban [playerid/CzêœæNicku] [powód]");
			return 1;
		}
		
	    if(AntySpam[playerid] == 1)
	    {
	        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
	        return 1;
	    }
	    if(IsPlayerConnected(giveplayerid))
	    {
	        if(giveplayerid != INVALID_PLAYER_ID)
	        {
	            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				new str[128];
	            if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pZG] >= 4 || IsAScripter(playerid))
	            {
					if(IsPlayerAdmin(giveplayerid) || Uprawnienia(giveplayerid, ACCESS_OWNER))
					{
						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zabanowaæ Head Admina !");
						return 1;
					}
					if( (PlayerInfo[giveplayerid][pAdmin] >= 1 || PlayerInfo[giveplayerid][pHalfAdmin] >= 1 || PlayerInfo[giveplayerid][pZG] >= 4) && PlayerInfo[playerid][pZG] >= 4)
					{
						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zabanowaæ Admina, P@ i ZG!");
						return 1;
					}
					if(PlayerInfo[giveplayerid][pLevel] > 1 && PlayerInfo[playerid][pZG] >= 4 && PlayerInfo[playerid][pZG] < 6)
					{
						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zabanowaæ gracza z levelem wiekszym niz 1!");
						return 1;
					}
                    if(gPlayerLogged[giveplayerid] == 0)
                    {
                        sendTipMessageEx(playerid, COLOR_WHITE, " Gracz nie jest zalogowany, u¿yj kicka.");
						return 1;
                    }
					SendClientMessage(giveplayerid, COLOR_NEWS, "Jeœli uwa¿asz ze ban jest nies³uszny wejdŸ na www.Mrucznik-RP.pl i z³ó¿ prosbê o UN-BAN");
					Log(punishmentLog, INFO, "Admin %s ukara³ %s kar¹ bana, powód: %s", 
						GetPlayerLogName(playerid),
						GetPlayerLogName(giveplayerid),
						result);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscBan[playerid]++;
					}
					else if(GetPlayerAdminDutyStatus(playerid) == 0)
					{
						iloscPozaDuty[playerid]++; 
					}
					if(kary_TXD_Status == 0)
					{
						format(string, sizeof(string), "AdmCmd: Admin %s zbanowa³ %s, powód: %s",  GetNickEx(playerid), giveplayer, result);
						SendPunishMessage(string, giveplayerid);
					}
					if(kary_TXD_Status == 1)
					{
						BanPlayerTXD(giveplayerid, playerid, result);
					}
					//adminowe logi
			        format(str, sizeof(str), "Admini/%s.ini", GetNickEx(playerid));
			        dini_IntSet(str, "Ilosc_Banow", dini_Int(str, "Ilosc_Banow")+1 );
					MruMySQL_Banuj(giveplayerid, result, playerid);
					KickEx(giveplayerid);
					if(PlayerInfo[giveplayerid][pAdmin] >= 1)
					{
					    MruMySQL_Banuj(playerid, result, giveplayerid);
						Log(punishmentLog, INFO, "Admin %s zosta³ zbanowany za zbanowanie admina %s", 
							GetPlayerLogName(playerid),
							GetPlayerLogName(giveplayerid));
					    KickEx(playerid);
					}
					else
					{
					    SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
					    AntySpam[playerid] = 1;
					}
					return 1;
			  	}
				else
				{
				    if(PlayerInfo[playerid][pHalfAdmin] >= 1 && PlayerInfo[playerid][pHalfAdmin] <= 3)
				    {
                        if(IsPlayerAdmin(giveplayerid) || Uprawnienia(giveplayerid, ACCESS_OWNER))
    					{
    						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zabanowaæ Head Admina !");
    						return 1;
    					}
						if(PlayerInfo[giveplayerid][pAdmin] >= 1)
						{
							sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zabanowaæ Admina !");
							return 1;
						}
                        if(gPlayerLogged[giveplayerid] == 0)
                        {
                            sendTipMessageEx(playerid, COLOR_WHITE, " Gracz nie jest zalogowany, u¿yj kicka.");
							return 1;
                        }
						if(GetPlayerAdminDutyStatus(playerid) == 1)
						{
							iloscBan[playerid]++;
						}
						else if(GetPlayerAdminDutyStatus(playerid) == 0)
						{
							iloscPozaDuty[playerid]++; 
						}
						format(string, sizeof(string), "AdmCmd: Pó³Admin %s zbanowa³ %s, powód: %s",  GetNickEx(playerid), giveplayer, (result));
                        SendPunishMessage(string, giveplayerid);
						if(kary_TXD_Status == 1)
						{
							BanPlayerTXD(giveplayerid, playerid, result);
						}
						SendClientMessage(giveplayerid, COLOR_NEWS, "Jeœli uwa¿asz ze ban jest nies³uszny wejdŸ na www.Mrucznik-RP.pl i z³ó¿ prosbê o UN-BAN");
						Log(punishmentLog, INFO, "Pó³Admin %s ukara³ %s kar¹ bana, powód: %s", 
							GetPlayerLogName(playerid),
							GetPlayerLogName(giveplayerid),
							result);
						MruMySQL_Banuj(giveplayerid, result, playerid);
						KickEx(giveplayerid);
						return 1;
					}
					else
					{
					    noAccessMessage(playerid);
					}
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
