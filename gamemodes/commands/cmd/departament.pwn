//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ departament ]----------------------------------------------//
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

YCMD:departament(playerid, params[], help)
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(OnDuty[playerid] == 1 || JobDuty[playerid] == 1)
        {
            GetPlayerName(playerid, sendername, sizeof(sendername));
            if(isnull(params))
            {
                SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: (/d)epartament [tekst]");
                return 1;
            }
            if(PlayerInfo[playerid][Mute] == 1)
            {
                sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz pisaæ poniewa¿ jesteœ wyciszony");
                return 1;
            }
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! Pisz poprzez /depo [treœæ]");
				return 1;
			}
            new member = GetPlayerFraction(playerid);
			
            if(0 < member <= 4 || member == FRAC_BOR)// || GetPlayerOrg(playerid) == 12 && OnDuty[playerid] == 1)
            {
                format(string, sizeof(string), "** %s %s: %s **", FracRang[member][PlayerInfo[playerid][pRank]],GetNick(playerid), params);
                SendTeamMessage(4, COLOR_ALLDEPT, string);
                SendTeamMessage(3, COLOR_ALLDEPT, string);
                SendTeamMessage(2, COLOR_ALLDEPT, string);
                SendTeamMessage(1, COLOR_ALLDEPT, string);
                SendTeamMessage(FRAC_BOR, COLOR_ALLDEPT, string); 
				
                format(string, sizeof(string), "%s mówi przez radio: %s", sendername, params);
                ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
                format(string, sizeof(string), "%s mówi przez radio: %s", sendername, params);
                SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
		        Log(chatLog, INFO, "%s departament %d IC: %s", GetPlayerLogName(playerid), member, params);
            }
            else
            {
                SendClientMessage(playerid, COLOR_GRAD2, "Nie jesteœ w dru¿ynie !");
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GRAD2, "Nie jesteœ na s³u¿bie !");
            return 1;
        }
    }
    return 1;
}
