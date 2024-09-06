//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ pr ]--------------------------------------------------//
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

YCMD:pr(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
        if(GetPlayerOrg(playerid) == 0)
        {
            sendErrorMessage(playerid, "Nie jestes w rodzinie !");
            return 1;
        }
        new org = GetPlayerOrg(playerid);
        if(IsPlayerOrgLeader(playerid))
		{
		    new x_nr[16];

			if( sscanf(params, "s[16]{s}",x_nr))
			{
				sendTipMessage(playerid, "U¯YJ: /PR(/PanelRodzinny) [nazwa]");
				sendTipMessage(playerid, "Dostêpne nazwy: Nazwa, MOTD, Spawn, Przyjmij, Zwolnij, Ranga, Kolor, Pracownicy");
				return 1;
			}
		    if(strcmp(x_nr,"name",true) == 0 || strcmp(x_nr,"nazwa",true) == 0)
			{
                new name[32];
			    if( sscanf(params, "{s[16]}s[32]",name))
				{
					sendTipMessage(playerid, "U¿yj /pr nazwa [Nazwa Rodziny]");
					return 1;
				}
                mysql_real_escape_string(name, name);
                if(SetOrgName(org, name)) sendTipMessageEx(playerid, COLOR_WHITE, "Zmieni³eœ nazwê swojej rodziny.");
				SaveOrg(org, ORG_SAVE_TYPE_DESC);
			}
			else if(strcmp(x_nr,"motd",true) == 0)
			{
                new lStr[128];
			    if( sscanf(params, "{s[16]}s[128]",lStr))
				{
					sendTipMessage(playerid, "U¿yj /pr MOTD [Tekst MOTD Rodziny]");
					return 1;
				}
                mysql_real_escape_string(lStr, lStr);
			    if(SetOrgMOTD(org, lStr)) sendTipMessageEx(playerid, COLOR_WHITE, "Zmieni³eœ MOTD rodziny.");
				SaveOrg(org, ORG_SAVE_TYPE_DESC);
			}
			else if(strcmp(x_nr,"color",true) == 0 || strcmp(x_nr,"kolor",true) == 0)
			{
			    new hexa;
			    if( sscanf(params, "{s[16]}h",hexa))
				{
					sendTipMessage(playerid, "U¿yj /pr kolor [Rodzinny Kolor Próbka: AABBCC]");
					return 1;
				}
				if(hexa <= 0x0 || hexa >= 0xFFFFFF)
				{
				    sendTipMessageEx(playerid, COLOR_GREY, "  Niepoprawny kolor (zakres od 0 do FFFFFF).");
				    return 1;
				}
                hexa = (hexa << 8);
                OrgInfo[org][o_Color] = hexa;
			    sendTipMessageEx(playerid, hexa, "Zmieni³eœ kolor rodziny.");
				SaveOrg(org, ORG_SAVE_TYPE_BASIC);
			}
			else if(strcmp(x_nr,"spawn",true) == 0)
			{
			    SetOrgSpawnAtPlayerPos(playerid, org);
			}
			else if(strcmp(x_nr,"invite",true) == 0 || strcmp(x_nr,"przyjmij",true) == 0)
			{
				new giveplayerid;
			    if( sscanf(params, "{s[16]}k<fix>",giveplayerid))
				{
				    sendTipMessage(playerid, "U¿yj /pr przyjmij [playerid/CzêœæNicku]");
				    return 1;
				}

				if(IsPlayerConnected(giveplayerid))
				{
					if(gPlayerLogged[giveplayerid] == 0)
                    {
                        sendTipMessageEx(playerid, COLOR_WHITE, " Gracz nie jest zalogowany.");
						return 1;
                    }
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				        if(GetPlayerOrg(giveplayerid) != 0 || GetPlayerFraction(giveplayerid) != 0)
				        {
				            sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz jest ju¿ w rodzinie !");
				            return 1;
				        }
				        format(string, sizeof(string), "* Przyj¹³eœ %s",GetNick(giveplayerid));
				        sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string);
				        format(string, sizeof(string), "* %s przyj¹³ Ciê do rodziny.",GetNick(playerid));
				        sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
                        InvitePlayerToOrg(giveplayerid, GetPlayerOrg(playerid));
						Log(serverLog, INFO, "Lider %s przyj¹³ %s do rodziny %d.", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), GetPlayerOrg(playerid));
				        return 1;
				    }
				}
				else
				{
				    sendErrorMessage(playerid, "Nie ma takiego gracza !");
				    return 1;
				}
			}
			else if(strcmp(x_nr,"uninvite",true) == 0 || strcmp(x_nr,"zwolnij",true) == 0)
			{

				new giveplayerid;
			    if( sscanf(params, "{s[16]}k<fix>",giveplayerid))
				{
				    sendTipMessage(playerid, "U¿yj /pr zwolnij [playerid/CzêœæNicku]");
				    return 1;
				}

				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				        if(GetPlayerOrg(giveplayerid) != GetPlayerOrg(playerid))
				        {
				            sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest w rodzinie!");
				            return 1;
				        }
                        if(IsPlayerOrgLeader(giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "Chcesz wyrzuciæ swojego pana?");
				        format(string, sizeof(string), "* Wyrzuci³eœ %s ze swojej rodziny.",GetNick(giveplayerid));
				        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				        format(string, sizeof(string), "* Lider %s wyrzuci³ ciê z rodziny.",GetNick(playerid));
				        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
                        RemovePlayerFromOrg(giveplayerid);
						Log(serverLog, INFO, "Lider %s wyrzuci³ %s z rodziny %d.", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), GetPlayerOrg(playerid));
				        return 1;
				    }
				}
				else
				{
				    sendErrorMessage(playerid, "Nie ma takiego gracza !");
				    return 1;
				}
			}
			else if(strcmp(x_nr,"rank",true) == 0 || strcmp(x_nr,"ranga",true) == 0)
			{

				new giveplayerid, rank;
			    if( sscanf(params, "{s[16]}k<fix>d",giveplayerid, rank))
				{
				    sendTipMessage(playerid, "U¿yj /pr ranga [playerid/CzêœæNicku] [Numer]");
				    return 1;
				}

				if(rank < 0 || rank > 9) { sendTipMessageEx(playerid, COLOR_GREY, "Ranga od 0 do 9 !"); return 1; }

				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				        if(GetPlayerOrg(giveplayerid) != GetPlayerOrg(playerid))
				        {
				            sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest w twojej rodzinie !");
				            return 1;
				        }

                        new bool:moze=false;
                        if(strlen(OrgRank[GetPlayerOrg(playerid)][rank]) > 1) moze=true;
                        else if(strlen(OrgRank[0][rank]) > 1) moze=true;
                        if(!moze) return sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Ta ranga nie jest stworzona!");
                        format(string, sizeof string, "Da³es %d rangê graczowi %s", rank, GetNick(giveplayerid));
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        GivePlayerOrgRank(giveplayerid, playerid, rank);
						Log(serverLog, INFO, "Lider %s rodziny %d da³ %s rangê %d.", GetPlayerLogName(playerid), GetPlayerOrg(playerid), GetPlayerLogName(giveplayerid), rank);
				        return 1;
				    }
				}
				else
				{
				    sendTipMessageEx(playerid, COLOR_GREY, "Nie ma takiego gracza !");
				    return 1;
				}
			}
			else if(strcmp(x_nr,"pracownicy",true) == 0 || strcmp(x_nr,"members",true) == 0)
			{
				VECTOR_clear(VMembersOrg[playerid]);
				new query[512];
				format(query, sizeof(query), "SELECT `UID`, `Nick`, `Rank`, `connected` FROM `mru_konta` WHERE `FMember`=%i ORDER BY `connected` DESC, `Rank` DESC", PlayerInfo[playerid][pOrg]);
				mysql_query(query);
				mysql_store_result();
				if(mysql_num_rows()) {
					while(mysql_fetch_row_format(query, "|")) {
						new uid, nick[MAX_PLAYER_NAME], rank, isconnected;
						sscanf(query, "p<|>is[24]ii", uid, nick, rank, isconnected);
						new lider = rank >= 1000;
						new str_rank[64];
						if(lider) {
							rank -= 1000;
							strcat(str_rank, "LIDER");
						} else {
							format(str_rank, sizeof(str_rank), "[%i] %s", rank, OrgRank[GetPlayerOrg(playerid)][rank]);
						}
						AddDialogListitem(playerid, "%s\t%s\t{%s}%s", nick, str_rank, isconnected ? ("00FF00") : ("FF0000"), isconnected ? ("ONLINE") : ("OFFLINE"));
						VECTOR_push_back_val(VMembersOrg[playerid], uid);
					}
					ShowPlayerDialogPages(playerid, "RodzinaPracownicy", DIALOG_STYLE_TABLIST, sprintf("Cz³onkowie %s", OrgInfo[org][o_Name]), "OK", "Zamknij", 15, "{888888}Nastêpna strona >>>", "{888888}<<< Poprzednia strona");
				}
				mysql_free_result();
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Z³a nazwa panelu!");
			    return 1;
			}
		}
		else
		{
		    sendErrorMessage(playerid, " Nie jesteœ liderem rodziny!");
		    return 1;
		}
    }
    return 1;
}


DialogPages:RodzinaPracownicy(playerid, response, listitem, inputtext[]) {
	new uid = VECTOR_get_val(VMembersOrg[playerid], listitem);
	VECTOR_clear(VMembersOrg[playerid]);
	if (!response) return 1;

	foreach(new i: Player) {
		if(PlayerInfo[i][pUID] == uid) {
			sendTipMessage(playerid, "Gracz jest online, uzyj /pr aby nim zarz¹dzaæ");
			Command_ReProcess(playerid, "pr pracownicy", false);
			return 1;
		}
	}

	// skopiowane z fpanel
	new nick[MAX_PLAYER_NAME], rank, rankName[32], lider;
	new str[1024];
               
    strcat(nick, MruMySQL_GetNameFromUID(uid));
    rank = MruMySQL_GetAccInt("Rank", nick);
    lider = rank > 1000;
	if (lider) {
		sendTipMessage(playerid, "Nie mo¿esz zarz¹dzaæ liderem!");
		Command_ReProcess(playerid, "pr pracownicy", false);
		return 1;
	}
	SetPVarInt(playerid, "prpanel_uid", uid);
	strcat(rankName, OrgRank[GetPlayerOrg(playerid)][rank]);
    format(str, sizeof(str), ""#KARA_STRZALKA"    »» "#KARA_TEKST"Nick: "#KARA_TEKST"%s", nick);
    format(str, sizeof(str), "%s\n"#KARA_STRZALKA"    »» "#KARA_TEKST"Ranga: "#KARA_TEKST"%s", str, rankName);
    format(str, sizeof(str), "%s\n ", str);
    format(str, sizeof(str), "%s\n"#HQ_COLOR_STRZALKA"    »» {dafc10}Wyrzuæ cz³onka", str);  
    format(str, sizeof(str), "%s\n"#HQ_COLOR_STRZALKA"    »» {dafc10}Zmieñ rangê", str);  
    ShowPlayerDialogEx(playerid, D_ORGMEMBER, DIALOG_STYLE_LIST, "Zarz¹dzanie cz³onkiem rodziny", str, "Ok", "Wstecz");
    return 1;
}