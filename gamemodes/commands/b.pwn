//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ b ]---------------------------------------------------//
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

CMD:b(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            return 1;
        }
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /b [CZAT OOC]");
			return 1;
		}
		//format(string, sizeof(string), "%s [%d] Czat OOC: (( %s ))", sendername, playerid, params);
		//ProxDetector(25.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		
		//Text 3 D
        if(strlen(params) < 78)
        {
            format(string, sizeof(string), "%s [%d] Czat OOC: (( %s ))", GetNick(playerid, true), playerid, params);
            ProxDetector(25.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
        }
        else
        {
            new pos = strfind(params, " ", true, strlen(params) / 2);
            if(pos != -1)
            {
                new text[64];

                strmid(text, params, pos + 1, strlen(params));
                strdel(params, pos, strlen(params));

                //format(string, sizeof(string), "%s szepcze: %s", GetNick(playerid, true), params);
                //ProxDetector(5.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
                format(string, sizeof(string), "%s [%d] Czat OOC: (( %s [.]", GetNick(playerid, true), playerid, params);
                ProxDetector(25.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
                //format(string, sizeof(string), "[.] %s", text);
                //ProxDetector(5.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
                format(string, sizeof(string), "[.] %s ))", text);
                ProxDetector(25.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
            }
        }
	    format(string, sizeof(string), "(( %s Napisa³: %s ))", GetNick(playerid, false), params);
        printf("%s", string);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1,25.0,8000);
	}
	return 1;
}

