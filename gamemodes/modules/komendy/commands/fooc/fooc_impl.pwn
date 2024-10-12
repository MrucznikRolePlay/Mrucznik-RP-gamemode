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
command_fooc_Impl(playerid, params[256])
{
    new string[256];

    if(IsPlayerConnected(playerid))
    {
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/fo)oc [tekst]");
			return 1;
		}
		if (CheckFamilyChatPermission(playerid))
		{
		    new member = GetPlayerFraction(playerid);
            if(member > 0)
            {
                format(string, sizeof(string), "** (( %s [%d] %s: %s )) **", FracRang[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], GetNickEx(playerid), params);
    			SendFamilyMessage(member, TEAM_AZTECAS_COLOR, string);
				SendDiscordFracMessage(member, string);
            }
			else if(GetPlayerOrg(playerid) != 0)
		    {
                member = GetPlayerOrg(playerid);
                //Przypisane rangi
                if(strlen(OrgRank[member][PlayerInfo[playerid][pRank]]) > 1) format(string, sizeof(string), "** (( %s [%d] %s: %s. )) **", OrgRank[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], GetNickEx(playerid), params);
                //Rangi podstawowe
                else format(string, sizeof(string), "** (( %s [%d] %s: %s )) **", OrgRank[0][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], GetNickEx(playerid), params);
                SendOrgMessage(member, TEAM_AZTECAS_COLOR, string);
				SendDiscordOrgMessage(member, string);
			}
            Log(chatLog, INFO, "%s radio organizacji %d OOC: %s", GetPlayerLogName(playerid), member, params);
			return 1;
		}
        else if(GetPlayerFraction(playerid) == FRAC_GOV || GetPlayerFraction(playerid) == FRAC_BOR|| GetPlayerOrg(playerid) == 1) //DMV i BOR po³aczenie
        {
            new member = GetPlayerFraction(playerid);
            format(string, sizeof(string), "** (( %s [%d] %s: %s )) **", FracRang[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], GetNickEx(playerid), params);
    		SendFamilyMessage(FRAC_GOV, TEAM_AZTECAS_COLOR, string);
            SendFamilyMessage(FRAC_BOR, TEAM_AZTECAS_COLOR, string);
            Log(chatLog, INFO, "%s radio frakcji %d OOC: %s", GetPlayerLogName(playerid), member, params);
        }
		else
		{
			sendTipMessageEx(playerid, COLOR_GRAD2, "Nie jesteœ we frakcji/organizacji!");
			return 1;
		}
	}
	return 1;
}

//end
