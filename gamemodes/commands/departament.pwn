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

CMD:d(playerid, params[]) return cmd_departament(playerid, params);
CMD:departament(playerid, params[])
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
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! Pisz poprzez /depo [treœæ]");
				return 1;
			}
            new member = GetPlayerFraction(playerid);
			
            if(0 < member <= 4 || member == 17)// || GetPlayerOrg(playerid) == 12 && OnDuty[playerid] == 1)
            {
                format(string, sizeof(string), "** %s %s: %s **", FracRang[member][PlayerInfo[playerid][pRank]],GetNick(playerid, true), params);
                SendTeamMessage(17,COLOR_ALLDEPT,string);
                SendTeamMessage(4, COLOR_ALLDEPT, string);
                SendTeamMessage(3, COLOR_ALLDEPT, string);
                SendTeamMessage(2, COLOR_ALLDEPT, string);
                SendTeamMessage(1, COLOR_ALLDEPT, string);
				
                format(string, sizeof(string), "%s mówi przez radio: %s", sendername, params);
                ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
                printf("%s", string);
                format(string, sizeof(string), "%s mówi przez radio: %s", sendername, params);

                SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
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

