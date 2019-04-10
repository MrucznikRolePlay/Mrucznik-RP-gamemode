//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ dajlideraorg ]---------------------------------------------//
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

CMD:dajlideraorg(playerid, params[])
{
    if(!Uprawnienia(playerid, ACCESS_MAKELEADER)) return 1;
    new id=-1, family;
	if( sscanf(params, "dK<fix>(-1)", family, id)) return sendTipMessage(playerid, "U¿yj /dajlideraorg [ORG ID] [ID/Nick]");
    if(family < 0 || family > MAX_ORG-1) return 1;
    if(id != -1)
    {
        if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Brak takiego gracza!");
        if(GetPlayerFraction(id) != 0 || GetPlayerOrg(id) != 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz ma frakcje lub rodzine!");
        orgInvitePlayer(id, family);
        gPlayerOrgLeader[id] = true;
    }
    new str[128];
    if(id != -1)
    {
		new orgUID = orgID(family);
		if(orgUID != 0xFFFF)
		{
			format(str, sizeof(str), "Admin %s da³ Tobie kontrolê nad rodzin¹ %s (%d) - /pr", GetNick(playerid), OrgInfo[orgUID][o_Name], family);
			SendClientMessage(id, COLOR_LIGHTBLUE, str);
			format(str, sizeof(str), "Da³eœ kontrolê nad rodzin¹ %s (%d) graczowi %s", OrgInfo[orgUID][o_Name], family, GetNick(id));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, str);
			
			//logi
			format(str, sizeof(str), "%s dal kontrole nad rodzina %d graczowi %s", GetNick(playerid), family, GetNick(id));
			ActionLog(str);
			
			PlayerInfo[id][pTeam] = 5;
			gTeam[id] = 5;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "ERROR! Wyst¹pi³ b³¹d, zg³oœ okolicznoœci do Mrucznika na slacku.");
		}
    }
    else
    {
        SendClientMessage(playerid, COLOR_RED, "================ LISTA LIDERÓW ================");
        format(str, 128, "SELECT `Nick` FROM `mru_konta` WHERE `FMember`='%d' AND `Rank`>1000", family);
        mysql_query(str);
        mysql_store_result();
        new nick[24];
        while(mysql_fetch_row_format(str, "|"))
        {
            sscanf(str, "p<|>s[24]", nick);
            SendClientMessage(playerid, -1, nick);
        }
        SendClientMessage(playerid, COLOR_RED, "================ KONIEC ================");
    }
    return 1;
}

