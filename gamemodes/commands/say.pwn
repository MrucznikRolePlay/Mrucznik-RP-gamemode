//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ say ]--------------------------------------------------//
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

CMD:local(playerid, params[]) return cmd_say(playerid, params);
CMD:l(playerid, params[]) return cmd_say(playerid, params);
CMD:say(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            return 1;
        }
        if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessage(playerid, "Nie mo¿esz pisaæ poniewa¿ jesteœ wyciszony", TEAM_CYAN_COLOR);
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /(l)ocal [tekst]");
			return 1;
		}
		/*format(string, sizeof(string), "%s mówi: %s", sendername, params);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		printf("%s", string); */
        if(strlen(params) < 78)
        {
            format(string, sizeof(string), "%s mówi: %s", GetNick(playerid, true), params);
            ProxDetector(10.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
            SetPlayerChatBubble(playerid,params,COLOR_FADE1,10.0,8000);
        }
        else
        {
            new pos = strfind(params, " ", true, strlen(params) / 2);
            if(pos != -1)
            {
                new text2[64];

                strmid(text2, params, pos + 1, strlen(params));
                strdel(params, pos, strlen(params));

                format(string, sizeof(string), "%s mówi: %s [.]", GetNick(playerid, true), params);
                ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);

                format(string, sizeof(string), "[.] %s", text2);
                ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
            }
        }
		//Text 3 D
		format(string, sizeof(string), "mówi: %s", params);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1,20.0,8000);
	}
	return 1;
}

