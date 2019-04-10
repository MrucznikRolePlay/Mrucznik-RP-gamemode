//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ pblok ]-------------------------------------------------//
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

CMD:pblock(playerid, params[]) return cmd_pblok(playerid, params);
CMD:pblok(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 1  || PlayerInfo[playerid][pNewAP] == 5)
		{
		    if(AntySpam[playerid] == 1)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
	   		new nick[MAX_PLAYER_NAME], result[128];
			if( sscanf(params, "s[24] s[128]", nick, result))
			{
				sendTipMessage(playerid, "U¿yj /pblock [NICK GRACZA OFFLINE] [powod]");
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
				sendErrorMessage(playerid, "Brak gracza w bazie, nie mo¿na zablokowaæ (konto nie istnieje).");
				return 1;
			}
            GetPlayerName(playerid, sendername, sizeof(sendername));
            format(string, sizeof(string), "AdmCmd: Konto gracza OFFLINE %s zostalo zablokowane przez %s, Powod: %s", nick, sendername, (result));
       		BanLog(string);
            SendPunishMessage(string);
			MruMySQL_Blockuj(nick, playerid, result);
			SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
			AntySpam[playerid] = 1;
		}
	}
	return 1;
}

