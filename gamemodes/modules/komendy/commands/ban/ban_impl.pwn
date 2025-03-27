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
command_ban_Impl(playerid, params[256])
{
    new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid)) 
    {
    	new giveplayerid, result[64];
		if( sscanf(params, "k<fix>s[64]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U�yj /ban [playerid/Cz��Nicku] [pow�d]");
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
	            if(PlayerInfo[playerid][pAdmin] >= 1 || Zaufany(playerid) || IsAScripter(playerid))
	            {
					if(IsPlayerAdmin(giveplayerid) || Uprawnienia(giveplayerid, ACCESS_OWNER))
					{
						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zbanowa� Head Admina !");
						return 1;
					}
					if( (PlayerInfo[giveplayerid][pAdmin] >= 1 || PlayerInfo[giveplayerid][pNewAP] >= 1 || PlayerInfo[giveplayerid][pZG] >= 4) && PlayerInfo[playerid][pZG] >= 4)
					{
						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zbanowa� Admina, P@ i ZG!");
						return 1;
					}
                    if(gPlayerLogged[giveplayerid] == 0)
                    {
                        sendTipMessageEx(playerid, COLOR_WHITE, " Gracz nie jest zalogowany, u�yj kicka.");
						return 1;
                    }
					SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
					AntySpam[playerid] = 1;
					SetPVarInt(playerid, "PunishBanPlayer", giveplayerid);
					SetPVarString(playerid, "PunishBanPlayer_Reason", result);
					format(string, sizeof string, "{FFFFFF}Czy podj��e� dialog z graczem {B7EB34}%s{FFFFFF}?\nJe�eli to mo�liwe, mo�esz ukara� gracza l�ejsz� kar�.", GetNick(giveplayerid));
					ShowPlayerDialogEx(playerid, 9522, DIALOG_STYLE_MSGBOX, "Nadawanie bana", string, "Ban :(", "Anuluj kar�");
					return 1;
			  	}
				else
				{
				    if(PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3)
				    {
                        if(IsPlayerAdmin(giveplayerid) || Uprawnienia(giveplayerid, ACCESS_OWNER))
    					{
    						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zbanowa� Head Admina !");
    						return 1;
    					}
						if(PlayerInfo[giveplayerid][pAdmin] >= 1)
						{
							sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zbanowa� Admina !");
							return 1;
						}
                        if(gPlayerLogged[giveplayerid] == 0)
                        {
                            sendTipMessageEx(playerid, COLOR_WHITE, " Gracz nie jest zalogowany, u�yj kicka.");
							return 1;
                        }
						SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
						AntySpam[playerid] = 1;
						if(GetPlayerAdminDutyStatus(playerid) == 1)
						{
							iloscBan[playerid]++;
						}
						else if(GetPlayerAdminDutyStatus(playerid) == 0)
						{
							iloscPozaDuty[playerid]++; 
						}
						format(string, sizeof(string), "AdmCmd: Administrator zbanowa� %s, pow�d: %s", giveplayer, (result));
                        SendPunishMessage(string, giveplayerid);
						if(kary_TXD_Status == 1)
						{
							BanPlayerTXD(giveplayerid, result);
						}
						SendClientMessage(giveplayerid, COLOR_NEWS, "Je�li uwa�asz ze ban jest nies�uszny wejd� na www.Mrucznik-RP.pl i z�� prosb� o UN-BAN");
						Log(punishmentLog, INFO, "P�Admin %s ukara� %s kar� bana, pow�d: %s", 
							GetPlayerLogName(playerid),
							GetPlayerLogName(giveplayerid),
							result);
						MruMySQL_Banuj(giveplayerid, result, playerid);
						KickEx(giveplayerid, "ban");
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

//end
