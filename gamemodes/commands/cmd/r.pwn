//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ r ]---------------------------------------------------//
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

YCMD:r(playerid, params[], help)
{
	new string[256];

    if(IsPlayerConnected(playerid))
    {
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/r)adio [tekst]");
			return 1;
		}
		if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz pisaæ poniewa¿ jesteœ wyciszony");
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! Pisz poprzez /ro [treœæ]");
			return 1;
		}
        new member = GetPlayerFraction(playerid);
        if(0 < member <= 4 || member == 11 || member == 7 || member == 17)
	    {
            format(string, sizeof(string), "** %s %s: %s **", FracRang[member][PlayerInfo[playerid][pRank]],GetNick(playerid), params);
            SendRadioMessage(member, TEAM_BLUE_COLOR, string);
            format(string, sizeof(string), "%s mówi przez radio: %s", GetNick(playerid), params);
			ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			format(string, sizeof(string), "Radio: %s", params);
			SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
        }
		else
		{
			noAccessMessage(playerid);
			return 1;
		}
		Log(chatLog, INFO, "%s radio policyjne %d IC: %s", GetPlayerLogName(playerid), member, params);
	}
	return 1;
}
