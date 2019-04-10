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

CMD:radio(playerid, params[]) return cmd_r(playerid, params);
CMD:r(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/r)adio [tekst]");
			return 1;
		}
        new member = GetPlayerFraction(playerid);
        if(0 < member <= 4 || member == 11 || member == 7 || member == 17)
	    {
            format(string, sizeof(string), "** %s %s: %s **", FracRang[member][PlayerInfo[playerid][pRank]],GetNick(playerid, true), params);
            SendRadioMessage(member, TEAM_BLUE_COLOR, string);
            format(string, sizeof(string), "%s mówi przez radio: %s", sendername, params);
			ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
            printf("%s", string);
			format(string, sizeof(string), "Radio: %s", params);
			SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
        }
        else if(GetPlayerOrg(playerid) == FAMILY_SAD) //SAD i BOR po³aczenie
        {
            member = GetPlayerOrg(playerid);
            format(string, sizeof(string), "** %s %s: %s **", FamRang[member][PlayerInfo[playerid][pRank]],GetNick(playerid, true), params);
            SendFamilyMessage(FRAC_BOR, TEAM_AZTECAS_COLOR, string);
            SendNewFamilyMessage(FAMILY_SAD, TEAM_BLUE_COLOR, string);
            format(string, sizeof(string), "%s mówi przez radio: %s", sendername, params);
			ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
            printf("%s", string);
            format(string, sizeof(string), "Radio: %s", params);
			SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
        }
		else
		{
			noAccessMessage(playerid);
			return 1;
		}
	}
	return 1;
}


