//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ banip ]-------------------------------------------------//
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

YCMD:banip(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
    	new var[32];
    	new powod[32];
    	if(sscanf(params, "s[32]s[32]", var, powod))
		{
			sendTipMessage(playerid, "U¿yj /banip [ip] [powod]");
			return 1;
		}
	    if(AntySpam[playerid] == 1)
	    {
	        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
	        return 1;
	    }
		new str[128];
	    if(PlayerInfo[playerid][Admin] >= 1)
        {
            if(strlen(var) < 7 || strlen(var) > 16)
            {
                sendErrorMessage(playerid, "Niepoprawna d³ugosc IP!");
                return 1;
            }
            new count, cpos;
            while((cpos = strfind(var, ".", false, cpos)) != -1)
            {
                count++;
                cpos++;
            }
            if(count != 3)
            {
                sendErrorMessage(playerid, "Niepoprawny adres IP (dots)!");
                return 1;
            }
            format(str, sizeof(str), "ADM: %s - zablokowal IP: %s powód: %s", GetNickEx(playerid), var, powod);
            SendCommandLogMessage(str);
            MruMySQL_BanujOffline("Brak", powod, playerid, var);
            format(str, sizeof(str), "ADM: %s - zablokowano IP: %s powód: %s", GetNickEx(playerid), var, powod);
            SendClientMessage(playerid, COLOR_LIGHTRED, str);
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscBan[playerid] = iloscBan[playerid]+1;
				
			}
            Log(punishmentLog, INFO, "Admin %s zablokowa³ ip %s, powód: %s", 
                GetPlayerLogName(playerid),
                var,
                powod);
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
