//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ pwarn ]-------------------------------------------------//
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

CMD:pwarn(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
		{
		    if(AntySpam[playerid] == 1)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }

	   		new nick[MAX_PLAYER_NAME], result[64];
			if( sscanf(params, "s[21]s[64]", nick, result))
			{
                sendTipMessage(playerid, "U¿yj /pwarn [NICK GRACZA OFFLINE] [powod]");
                return 1;
            }
			new giveplayerid;
			sscanf(nick, "k<fix>", giveplayerid);
            if(IsPlayerConnected(giveplayerid))
			{
			    sendErrorMessage(playerid, "Nie mo¿esz zablokowaæ tego gracza (jest online (na serwerze))");
				return 1;
			}

			if(!MruMySQL_DoesAccountExist(nick))
			{
				sendErrorMessage(playerid, "Brak pliku gracza, nie mo¿na zwarnowaæ (konto nie istnieje).");
				return 1;
			}

            GetPlayerName(playerid, sendername, sizeof(sendername));
            format(string, sizeof(string), "AdmCmd: Konto gracza OFFLINE %s zostalo zwarnowane przez %s, Powod: %s", nick, sendername, (result));
            SendPunishMessage(string);
       		WarnLog(string);
			format(string, sizeof(string), "AdmCmd: Konto gracza offline %s zostalo zwarnowane przez %s, Powod: %s", nick, sendername, (result));
            //ABroadCast(COLOR_LIGHTRED,string,1);
            MruMySQL_SetAccInt("Warnings", nick, MruMySQL_GetAccInt("Warnings", nick)+1);
			SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
			AntySpam[playerid] = 1;
		}
    }
	return 1;
}

