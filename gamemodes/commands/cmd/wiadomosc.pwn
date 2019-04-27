//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ wiadomosc ]-----------------------------------------------//
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

YCMD:wiadomosc(playerid, params[], help)
{
    if(gPlayerLogged[playerid] == 0)
    {
        return 1;
    }

    new giveplayerid, text[128];
    if( sscanf(params, "k<fix>s[128]", giveplayerid, text))
    {
        sendTipMessage(playerid, "U¿yj /(w)iadomosc [playerid/CzêœæNicku] [tekst]");
        return 1;
    }

    if (IsPlayerConnected(giveplayerid) && giveplayerid != INVALID_PLAYER_ID)
    {
        if(gPlayerLogged[giveplayerid] == 0)
        {
        	sendTipMessage(playerid, "Nie mo¿esz napisaæ prywatnej wiadomoœci, bo ten gracz aktualnie loguje siê do gry.");
			return 1;
       	}
        if(HidePM[giveplayerid] > 0)
        {
            sendTipMessage(playerid, "Ten gracz blokuje wiadomoœci!");
            return 1;
        }
        if(HidePM[playerid] > 0)
        {
            sendTipMessage(playerid, "Masz zablokowane wiadomoœci, u¿yj /togw aby je odblokowaæ !");
            return 1;
        }
        if(PlayerInfo[playerid][pBW] > 0 && GetDistanceBetweenPlayers(playerid, giveplayerid) > 50.0 && (PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pNewAP] > 0 || PlayerInfo[playerid][pZG] > 0)) {
            return sendErrorMessage(playerid, "Gdy masz BW mo¿esz wysy³aæ wiadomoœci jedynie na ma³¹ odleg³oœæ");
        }
        new giveplayer[MAX_PLAYER_NAME];
        new sendername[MAX_PLAYER_NAME];
        new string[128];
        GetPlayerName(playerid, sendername, sizeof(sendername));
        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));

        if(giveplayerid == playerid) //easter egg
        {
            format(string, sizeof(string), "* %s mruczy (jak Mrucznik) coœ pod nosem.", sendername);
            ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            //return 1;
        }

        if (AntyReklama(text) != 0)
        {
            SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
            format(string, sizeof(string), "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,text);
            ABroadCast(COLOR_LIGHTRED,string,1);
            CzitLog(string);
            return 1;
        }
        if (AntyCzitText(text))
        {
            format(string, sizeof(string), "AdmWarning: [%d]%s mówi coœ o cheat'ach do[%s]: %s",playerid,sendername, giveplayer,text);
            ABroadCast(COLOR_LIGHTRED,string,1);
            CzitLog(string);
        }

        //wiadomoœci:
        //format(string, sizeof(string), "» %s (ID: %d) wiadomoœæ: %s", sendername, playerid, tekst);
        //SendClientMessage(giveplayerid, COLOR_NEWS, string);

        //new isplayerafk;
        //format(string, sizeof(string), "« Wiadomoœæ wys³ana do %s (ID: %d)%s: %s", giveplayer, giveplayerid, (!IsPlayerPaused(giveplayerid)) ? (""): (" [AFK] "),tekst); //IS PLAYER AFK
        //SendClientMessage(playerid,  COLOR_YELLOW, string);
		
        if(strlen(params) < 78)
        {
			GetPVarString(playerid, "pAdminDutyNickOn", AdminName, sizeof(AdminName)); 
			
			if(GetPlayerAdminDutyStatus(playerid) == 0)
			{
				format(string, sizeof(string), "«« %s (%d%s): %s", GetNick(giveplayerid, true), giveplayerid, (!IsPlayerPaused(giveplayerid)) ? (""): (", AFK"), text);
				SendClientMessage(playerid, COLOR_YELLOW, string);
				
				format(string, sizeof(string), "»» %s (%d): %s", GetNick(playerid, true), playerid, text);
				SendClientMessage(giveplayerid, COLOR_NEWS, string);
				if(GetPlayerAdminDutyStatus(giveplayerid) == 1)
				{
					iloscInWiadomosci[giveplayerid] = iloscInWiadomosci[giveplayerid]+1;
				}
				
			}
			else
			{
				format(string, sizeof(string), "«« %s (%d%s): %s", AdminName, giveplayerid, (!IsPlayerPaused(giveplayerid)) ? (""): (", AFK"), text);
				SendClientMessage(playerid, COLOR_YELLOW, string);
				
				format(string, sizeof(string), "»» %s (%d): %s", AdminName, playerid, text);
				SendClientMessage(giveplayerid, COLOR_NEWS, string);
				iloscOutWiadomosci[playerid] = iloscOutWiadomosci[playerid]+1;
				if(GetPlayerAdminDutyStatus(giveplayerid) == 1)
				{
					iloscInWiadomosci[giveplayerid] = iloscInWiadomosci[giveplayerid]+1;
				}
			
			}
        } else {
            new pos = strfind(params, " ", true, strlen(params) / 2);
            if(pos != -1)
            {
                new text2[64];
				if(GetPlayerAdminDutyStatus(playerid) == 0)
				{
					strmid(text2, text, pos, strlen(text));
					strdel(text, pos, strlen(text));

					format(string, sizeof(string), "«« %s (%d%s): %s [.]", GetNick(giveplayerid, true), giveplayerid, (!IsPlayerPaused(giveplayerid)) ? (""): (", AFK"), text);
					SendClientMessage(playerid, COLOR_YELLOW, string);
				
					format(string, sizeof(string), "[.] %s", text2);
					SendClientMessage(playerid, COLOR_YELLOW, string);
					
					
					format(string, sizeof(string), "«« %s (%d): %s [.]", GetNick(playerid, true), playerid, text);
					SendClientMessage(giveplayerid, COLOR_NEWS, string);
					
					format(string, sizeof(string), "[.] %s", text2);
					SendClientMessage(giveplayerid, COLOR_NEWS, string);
					if(GetPlayerAdminDutyStatus(giveplayerid) == 1)
					{
						iloscInWiadomosci[giveplayerid] = iloscInWiadomosci[giveplayerid]+1;
					}
				}
				else
				{
					strmid(text2, text, pos, strlen(text));
					strdel(text, pos, strlen(text));

					format(string, sizeof(string), "«« %s (%d%s): %s [.]", GetNick(giveplayerid), giveplayerid, (!IsPlayerPaused(giveplayerid)) ? (""): (", AFK"), text);
					SendClientMessage(playerid, COLOR_YELLOW, string);
				
					format(string, sizeof(string), "[.] %s", text2);
					SendClientMessage(playerid, COLOR_YELLOW, string);
					
					
					format(string, sizeof(string), "«« %s (%d): %s [.]", GetNick(playerid), playerid, text);
					SendClientMessage(giveplayerid, COLOR_NEWS, string);
					
					format(string, sizeof(string), "[.] %s", text2);
					SendClientMessage(giveplayerid, COLOR_NEWS, string);
					iloscOutWiadomosci[playerid] = iloscOutWiadomosci[playerid]+1;
					if(GetPlayerAdminDutyStatus(giveplayerid) == 1)
					{
						iloscInWiadomosci[giveplayerid] = iloscInWiadomosci[giveplayerid]+1;
					}
				
				
				}
            }
        }

        //dŸwiêki
        PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
        PlayerPlaySound(giveplayerid, 1057, 0.0, 0.0, 0.0);
        lastMsg[giveplayerid] = playerid;
        //podgl¹d
        if(PlayerInfo[playerid][pPodPW] == 1 || PlayerInfo[giveplayerid][pPodPW] == 1)
        {
            format(string, sizeof(string), "AdmCmd -> %s(%d) /w -> %s(%d): %s", sendername, playerid, giveplayer, giveplayerid, text);
            ABroadCast2(COLOR_LIGHTGREEN,string,1);
        }
    }
    else
    {
        sendErrorMessage(playerid, "Nie ma na serwerze takiego gracza!");
    }
    return 1;
}
