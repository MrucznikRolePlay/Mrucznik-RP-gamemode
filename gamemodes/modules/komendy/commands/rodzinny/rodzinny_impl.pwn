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
command_rodzinny_Impl(playerid, params[256])
{
    new string[256];

    if(IsPlayerConnected(playerid))
    {
	    if(PlayerInfo[playerid][pMuted] == 1)
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
        if (CheckFamilyChatPermission(playerid))
		{
            new member = GetPlayerFraction(playerid);
		    if(member>0)
		    {
                format(string, sizeof(string), "** %s %s: %s **", FracRang[member][PlayerInfo[playerid][pRank]],GetNick(playerid), params);
    			SendFamilyMessage(member, TEAM_AZTECAS_COLOR, string);
            }
			else if(GetPlayerOrg(playerid) != 0)
		    {
                member = GetPlayerOrg(playerid);
                //Przypisane rangi
                if(strlen(OrgRank[member][PlayerInfo[playerid][pRank]]) > 1) format(string, sizeof(string), "** %s %s: %s **", OrgRank[member][PlayerInfo[playerid][pRank]],GetNick(playerid), params);
                //Rangi podstawowe
                else format(string, sizeof(string), "** %s %s: %s **", OrgRank[0][PlayerInfo[playerid][pRank]],GetNick(playerid), params);
				SendOrgMessage(member, TEAM_AZTECAS_COLOR, string);
			}
            format(string, sizeof(string), "%s mówi przez radio: %s", GetNick(playerid), params);
			ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			format(string, sizeof(string), "%s mówi przez radio: %s", GetNick(playerid), params);
			SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
	    	Log(chatLog, INFO, "%s radio organizacji %d IC: %s", GetPlayerLogName(playerid), GetPlayerOrg(playerid), params);
			return 1;
		}
        else if(GetPlayerFraction(playerid) == FRAC_GOV || GetPlayerFraction(playerid) == FRAC_BOR) //DMV i BOR
        {
            new member = GetPlayerFraction(playerid);
            format(string, sizeof(string), "** %s %s: %s **", FracRang[member][PlayerInfo[playerid][pRank]], GetNick(playerid), params);
    		SendFamilyMessage(FRAC_GOV, TEAM_AZTECAS_COLOR, string);
            SendFamilyMessage(FRAC_BOR, TEAM_AZTECAS_COLOR, string);
	    	Log(chatLog, INFO, "%s radio frakcji %d IC: %s", GetPlayerLogName(playerid), GetPlayerFraction(playerid), params);
			
			format(string, sizeof(string), "%s mówi przez radio: %s", GetNick(playerid), params);
			ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			format(string, sizeof(string), "%s mówi przez radio: %s", GetNick(playerid), params);
			SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
        }
		else
		{
			sendTipMessageEx(playerid, COLOR_GRAD2, "Nie jesteœ we frakcji/organizacji!");
			return 1;
		}
	}//not connected
	return 1;
}

//end
