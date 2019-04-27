//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ depo ]-------------------------------------------------//
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

YCMD:depo(playerid, params[], help)
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        GetPlayerName(playerid, sendername, sizeof(sendername));
        if(isnull(params))
        {
            sendTipMessage(playerid, "U¿yj /depo [tekst]");
            return 1;
        }
        if(gMuteDepo[playerid] == 1) return sendTipMessage(playerid, "Nie mo¿esz pisaæ na depo, zablokowa³eœ ten czat (U¿yj /togdepo)");
        new member = GetPlayerFraction(playerid);
        if(0 < member <= 4 || member == 17)// || GetPlayerOrg(playerid) == 12)
        {
			
			GetPVarString(playerid, "pAdminDutyNickOn", AdminName, sizeof(AdminName)); 
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				format(string, sizeof(string), "** (( %s [%d] %s: %s )) **", FracRang[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank],AdminName, params);
				SendTeamMessage(17, COLOR_ALLDEPT, string, 1);
				SendTeamMessage(4, COLOR_ALLDEPT, string, 1);
				SendTeamMessage(3, COLOR_ALLDEPT, string, 1);
				SendTeamMessage(2, COLOR_ALLDEPT, string, 1);
				SendTeamMessage(1, COLOR_ALLDEPT, string, 1);
				SendTeamMessage(18, COLOR_ALLDEPT, string, 1);
				printf("%s", string);
			}
			else
			{
				format(string, sizeof(string), "** (( %s [%d] %s: %s )) **", FracRang[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank],GetNick(playerid, true), params);
				SendTeamMessage(17, COLOR_ALLDEPT, string, 1);
				SendTeamMessage(4, COLOR_ALLDEPT, string, 1);
				SendTeamMessage(3, COLOR_ALLDEPT, string, 1);
				SendTeamMessage(2, COLOR_ALLDEPT, string, 1);
				SendTeamMessage(1, COLOR_ALLDEPT, string, 1);
				SendTeamMessage(18, COLOR_ALLDEPT, string, 1);
				printf("%s", string);
			
			
			}
		}
        else
        {
            noAccessMessage(playerid);
            return 1;
        }
    }
    return 1;
}
