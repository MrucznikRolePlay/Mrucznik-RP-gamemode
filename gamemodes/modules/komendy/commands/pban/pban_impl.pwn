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
command_pban_Impl(playerid, params[256])
{
    new string[128];
    if(IsPlayerConnected(playerid))
    {
        if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
		    if(AntySpam[playerid] == 1)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }

	   		new nick[MAX_PLAYER_NAME], result[128];
			if( sscanf(params, "s[21]s[128]", nick, result))
			{
                sendTipMessage(playerid, "U�yj /pban [NICK GRACZA OFFLINE] [powod]");
                return 1;
            }
            new giveplayerid;
			sscanf(nick, "k<fix>", giveplayerid);
            if(IsPlayerConnected(giveplayerid))
			{
			    sendErrorMessage(playerid, "Nie mo�esz zbanowa� tego gracza (jest online (na serwerze))");
				return 1;
			}
            if(MruMySQL_DoesAccountExist(nick) != -1)
			{
				sendErrorMessage(playerid, "Brak pliku gracza, nie mo�na zbanowa� (konto nie istnieje).");
				return 1;
			}
			GivePBanForPlayer(nick, playerid, result);
			if(kary_TXD_Status == 1)
			{
				PBanPlayerTXD(nick, playerid, result);
            }
			else if(kary_TXD_Status == 0)
			{
				format(string, sizeof(string), "Admin %s zbanowa� %s (Offline). Pow�d: %s", GetNickEx(playerid), nick, result);
				SendPunishMessage(string, playerid); 
			}
		}
    }
	return 1;
}

//end
