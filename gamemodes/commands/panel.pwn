//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ panel ]-------------------------------------------------//
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

CMD:panel(playerid, params[])
{
    if(!Uprawnienia(playerid, ACCESS_PANEL)) return noAccessMessage(playerid);
    new str[256];
    if(isnull(params))
    {
        new kary;
        if(Uprawnienia(playerid, ACCESS_KARY)) kary=0b10;
        SetPVarInt(playerid, "panel-upr", kary);
        DeletePVar(playerid, "panel-kary-continue");
        DeletePVar(playerid, "panel-powod");
        format(str, sizeof(str), "{FFFFFF}» PANEL KAR (%s{FFFFFF})\n{FFFFFF}» SprawdŸ konto gracza", (kary & 0b10) ? ("{00FF00}Uprawnienia") : ("{FF0000}Brak upr."));
        ShowPlayerDialogEx(playerid, D_PANEL_ADMINA, DIALOG_STYLE_LIST, "M-RP » Panel administracyjny", str, "Wybierz", "WyjdŸ");
    }
    else
    {
        new var[32], sub[32], powod[64];
        if(sscanf(params, "s[32]s[32]S()[64]", sub, var, powod)) return SendClientMessage(playerid, COLOR_GRAD2, "Parametry: unban [nick] | unbanip [IP] | ban [nick] [powód] | banip [IP] [powód] | unwarn [nick]");
        if(strcmp(sub, "unban", true) == 0)
        {
            if(!Uprawnienia(playerid, ACCESS_KARY_UNBAN))
            {
                sendErrorMessage(playerid, "Uprawnienia: Nie posiadasz wystarczaj¹cych uprawnieñ.");
                return 1;
            }
            if(strlen(var) < 1 || strlen(var) > MAX_PLAYER_NAME)
            {
                sendErrorMessage(playerid, "Niepoprawna d³ugosc!");
                return 1;
            }
            if(!MruMySQL_Odbanuj(var, "nieznane", playerid))
            {
                sendErrorMessage(playerid, "Nie mo¿na by³o wykonaæ zapytania do bazy!");
                return 1;
            }

            format(str, sizeof(str), "ADM: %s - odblokowano nick: %s", GetNick(playerid), var);
            SendClientMessage(playerid, COLOR_LIGHTRED, str);
            BanLog(str);
            return 1;
        }
        else if(strcmp(sub, "unbanip", true) == 0)
        {
            if(!Uprawnienia(playerid, ACCESS_KARY_UNBAN))
            {
                sendErrorMessage(playerid, "Uprawnienia: Nie posiadasz wystarczaj¹cych uprawnieñ.");
                return 1;
            }
            if(strlen(var) < 7 || strlen(var) > 16)
            {
                sendErrorMessage(playerid, "Niepoprawna d³ugosc IP!");
                return 1;
            }
            new count, cpos=0;
            while((cpos = strfind(var, ".", false, cpos)) != -1)
            {
                count++;
                cpos++;
            }
            if(count != 3)
            {
                sendErrorMessage(playerid, "Niepoprawny adres IP (dots)!");
                return 1;
            }
            if(!MruMySQL_Odbanuj("Brak", var, playerid))
            {
                sendErrorMessage(playerid, "Nie mo¿na by³o wykonaæ zapytania do bazy!");
                return 1;
            }

            format(str, sizeof(str), "ADM: %s - odblokowano IP: %s", GetNick(playerid), var);
            SendClientMessage(playerid, COLOR_LIGHTRED, str);
            BanLog(str);
            return 1;
        }
        else if(strcmp(sub, "ban", true) == 0)
        {
            if(!Uprawnienia(playerid, ACCESS_KARY_BAN))
            {
                sendErrorMessage(playerid, "Uprawnienia: Nie posiadasz wystarczaj¹cych uprawnieñ.");
                return 1;
            }
            if(strlen(var) < 1 || strlen(var) > MAX_PLAYER_NAME)
            {
                sendErrorMessage(playerid, "Niepoprawna d³ugosc!");
                return 1;
            }
            if(strlen(powod) < 1)
            {
                sendErrorMessage(playerid, "Podaj powód.");
                return 1;
            }
            MruMySQL_BanujOffline(var, powod, playerid);

            format(str, sizeof(str), "ADM: %s - zablokowano nick: %s powód: %s", GetNick(playerid), var, powod);
            SendClientMessage(playerid, COLOR_LIGHTRED, str);
            BanLog(str);
            return 1;
        }
        else if(strcmp(sub, "banip", true) == 0)
        {
            if(!Uprawnienia(playerid, ACCESS_KARY_BAN))
            {
                sendErrorMessage(playerid, "Uprawnienia: Nie posiadasz wystarczaj¹cych uprawnieñ.");
                return 1;
            }
            if(strlen(var) < 7 || strlen(var) > 16)
            {
                sendErrorMessage(playerid, "Niepoprawna d³ugosc IP!");
                return 1;
            }
            new count, cpos;
            while((cpos = strfind(var, ".", false, cpos)) != -1)
            {
                count++;
                cpos++;
            }
            if(count != 3)
            {
                sendErrorMessage(playerid, "Niepoprawny adres IP (dots)!");
                return 1;
            }
            MruMySQL_BanujOffline("Brak", powod, playerid, var);

            format(str, sizeof(str), "ADM: %s - zablokowano IP: %s powód: %s", GetNick(playerid), var, powod);
            SendClientMessage(playerid, COLOR_LIGHTRED, str);
            BanLog(str);
            return 1;
        }
        else if(strcmp(sub, "unwarn", true) == 0)
        {
            if(strlen(var) < 1 || strlen(var) > MAX_PLAYER_NAME)
            {
                SendClientMessage(playerid, COLOR_RED, "Niepoprawna d³ugosc!");
                return 1;
            }
			
			new id;
			if(!sscanf(var, "k<fix>", id) && id != INVALID_PLAYER_ID)
			{
                SendClientMessage(playerid, COLOR_RED, "Gracz jest online, u¿ywam komendy /unwarn");
				
				new txt[64];
				format(txt, sizeof(txt), "%d Panel /unwarn", id);
				cmd_unwarn(playerid, txt);
				return 1;
			}
			
            new warny = MruMySQL_GetAccInt("Warnings", var);
            if(warny > 0)
            {
				new escaped_nick[MAX_PLAYER_NAME];
				mysql_real_escape_string(var, escaped_nick);
                format(str, sizeof(str), "UPDATE `mru_konta` SET `Warnings` = `Warnings`-1 WHERE `Nick` = '%s'", escaped_nick);
    	        mysql_query(str);

                format(str, sizeof(str), "AdmCmd: Konto gracza %s zosta³o unwarnowane przez %s.", var, GetNick(playerid));
                ABroadCast(COLOR_YELLOW,str,1);
				if(!IsPlayerAdmin(playerid))
				{
					SendClientMessage(playerid, COLOR_YELLOW, str);
				}
                WarnLog(str);
            }
            else sendTipMessage(playerid, "Gracz nie posiada warnów");
            return 1;
        }
    }
    return 1;
}

