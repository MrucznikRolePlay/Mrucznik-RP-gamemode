//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ rodzinny ]-----------------------------------------------//
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

YCMD:rodzinny(playerid, params[], help)
{
	new string[256];

    if(IsPlayerConnected(playerid))
    {
	    if(PlayerInfo[playerid][pMute] == 1)
		{
			sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz pisaæ poniewa¿ jesteœ wyciszony");
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! Pisz poprzez /fo [treœæ]");
			return 1;
		}
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/f)amily [tekst]");
			return 1;
		}
        if (GetPlayerOrg(playerid) != 0 || MozeMowicNaFamily(playerid) || PlayerInfo[playerid][pTajniak] >= 1)
		{
            new member = GetPlayerFraction(playerid);
		    if(member>0 && PlayerInfo[playerid][pTajniak] == 0)
		    {
                format(string, sizeof(string), "** %s %s: %s **", FracRang[member][PlayerInfo[playerid][pRank]],GetNickEx(playerid), params);
    			SendFamilyMessage(member, TEAM_AZTECAS_COLOR, string);

                //Tajniacy
                if(member == 5) SendTajniakMessage(3, TEAM_AZTECAS_COLOR, string);
                else if(member == 6) SendTajniakMessage(4, TEAM_AZTECAS_COLOR, string);
                else if(member == 12) SendTajniakMessage(1, TEAM_AZTECAS_COLOR, string);
                else if(13 <= member <= 14) SendTajniakMessage(2, TEAM_AZTECAS_COLOR, string);
            }
            else if(PlayerInfo[playerid][pTajniak] == 1)
			{
                format(string, sizeof(string), "** %s %s: %s **", FracRang[FRAC_GROOVE][PlayerInfo[playerid][pRank]],GetNickEx(playerid), params);
                SendFamilyMessage(FRAC_GROOVE, TEAM_AZTECAS_COLOR, string);
                SendTajniakMessage(1, TEAM_AZTECAS_COLOR, string);
			}
			else if(PlayerInfo[playerid][pTajniak] == 2)
			{
                format(string, sizeof(string), "** %s %s: %s **", FracRang[FRAC_BALLAS][PlayerInfo[playerid][pRank]],GetNickEx(playerid), params);
                SendFamilyMessage(FRAC_BALLAS, TEAM_AZTECAS_COLOR, string);
                SendTajniakMessage(2, TEAM_AZTECAS_COLOR, string);
			}
			else if(PlayerInfo[playerid][pTajniak] == 3)
			{
                format(string, sizeof(string), "** %s %s: %s **", FracRang[FRAC_LCN][PlayerInfo[playerid][pRank]],GetNickEx(playerid), params);
                SendFamilyMessage(FRAC_LCN, TEAM_AZTECAS_COLOR, string);
				SendTajniakMessage(3, TEAM_AZTECAS_COLOR, string);
			}
			else if(PlayerInfo[playerid][pTajniak] == 4)
			{
                format(string, sizeof(string), "** %s %s: %s **", FracRang[FRAC_YKZ][PlayerInfo[playerid][pRank]],GetNickEx(playerid), params);
                SendFamilyMessage(FRAC_YKZ, TEAM_AZTECAS_COLOR, string);
				SendTajniakMessage(4, TEAM_AZTECAS_COLOR, string);
			}
			else if(PlayerInfo[playerid][pTajniak] == 5)
			{
                format(string, sizeof(string), "** %s %s: %s **", FracRang[FRAC_VAGOS][PlayerInfo[playerid][pRank]],GetNickEx(playerid), params);
                SendFamilyMessage(FRAC_VAGOS, TEAM_AZTECAS_COLOR, string);
				SendTajniakMessage(5, TEAM_AZTECAS_COLOR, string);
			}
			else if(GetPlayerOrg(playerid) != 0)
		    {
                member = GetPlayerOrg(playerid);
                //Przypisane rangi
                if(strlen(FamRang[member][PlayerInfo[playerid][pRank]]) > 1) format(string, sizeof(string), "** %s %s: %s **", FamRang[member][PlayerInfo[playerid][pRank]],GetNickEx(playerid), params);
                //Rangi podstawowe
                else format(string, sizeof(string), "** %s %s: %s **", FamRang[0][PlayerInfo[playerid][pRank]],GetNickEx(playerid), params);
				SendNewFamilyMessage(member, TEAM_AZTECAS_COLOR, string);
			}
            format(string, sizeof(string), "%s mówi przez radio: %s", GetNickEx(playerid), params);
			ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			format(string, sizeof(string), "%s mówi przez radio: %s", GetNickEx(playerid), params);
			SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
	    	Log(chatLog, INFO, "%s radio rodziny %d IC: %s", GetPlayerLogName(playerid), GetPlayerOrg(playerid), params);
			return 1;
		}
        else if(GetPlayerFraction(playerid) == FRAC_GOV || GetPlayerFraction(playerid) == FRAC_BOR|| GetPlayerOrg(playerid) == 1) //DMV i BOR po³aczenie + S¹d
        {
            new member = GetPlayerFraction(playerid);
            format(string, sizeof(string), "** %s %s: %s **", FracRang[member][PlayerInfo[playerid][pRank]],GetNickEx(playerid), params);
    		SendFamilyMessage(FRAC_GOV, TEAM_AZTECAS_COLOR, string);
            SendFamilyMessage(FRAC_BOR, TEAM_AZTECAS_COLOR, string);
			SendNewFamilyMessage(FAMILY_SAD, TEAM_BLUE_COLOR, string);
	    	Log(chatLog, INFO, "%s radio frakcji %d IC: %s", GetPlayerLogName(playerid), GetPlayerFraction(playerid), params);
			
			format(string, sizeof(string), "%s mówi przez radio: %s", GetNickEx(playerid), params);
			ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			format(string, sizeof(string), "%s mówi przez radio: %s", GetNickEx(playerid), params);
			SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
        }
		else
		{
			sendTipMessageEx(playerid, COLOR_GRAD2, "Nie jesteœ we frakcji!");
			return 1;
		}
	}//not connected
	return 1;
}
