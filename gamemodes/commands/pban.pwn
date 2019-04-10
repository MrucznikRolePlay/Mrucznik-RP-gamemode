//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ pban ]-------------------------------------------------//
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

CMD:pban(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] == 5)
		{
		    if(AntySpam[playerid] == 1)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }

	   		new nick[MAX_PLAYER_NAME], result[128];
			if( sscanf(params, "s[21]s[128]", nick, result))
			{
                sendTipMessage(playerid, "U¿yj /pban [NICK GRACZA OFFLINE] [powod]");
                return 1;
            }
            new giveplayerid;
			sscanf(nick, "k<fix>", giveplayerid);
            if(IsPlayerConnected(giveplayerid))
			{
			    sendErrorMessage(playerid, "Nie mo¿esz zablokowaæ tego gracza (jest online (na serwerze))");
				return 1;
			}
            if(MruMySQL_DoesAccountExist(nick) != -1)
			{
				sendErrorMessage(playerid, "Brak pliku gracza, nie mo¿na zbanowaæ (konto nie istnieje).");
				return 1;
			}
            GetPlayerName(playerid, sendername, sizeof(sendername));
            format(string, sizeof(string), "AdmCmd: Konto gracza OFFLINE %s zostalo zbanowane przez %s, Powod: %s ", nick, sendername, (result));
       		BanLog(string);
            SendPunishMessage(string);
            MruMySQL_BanujOffline(nick, result, playerid);
			SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
			AntySpam[playerid] = 1;
		}
    }
	return 1;
}

