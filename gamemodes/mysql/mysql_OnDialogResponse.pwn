MruMySQL_ZapiszUprawnienia(playerid)
{
    new str[128];
    mysql_format(mruMySQL_Connection, str, sizeof(str), "SELECT `UID` FROM `mru_uprawnienia` WHERE `UID`=%d", PlayerInfo[playerid][pUID]);
    new Cache:result = mysql_query(mruMySQL_Connection, str, true);

	if(cache_is_valid(result))
    {
        if(cache_num_rows() > 0)
        {
            mysql_format(mruMySQL_Connection, str, sizeof(str), "UPDATE `mru_uprawnienia` SET `FLAGS`= b'%b' WHERE `UID`=%d", ACCESS[playerid], PlayerInfo[playerid][pUID]);
        }
        else
        {
            mysql_format(mruMySQL_Connection, str, sizeof(str), "INSERT INTO `mru_uprawnienia` (`FLAGS`, `UID`) VALUES (b'%b', %d)", ACCESS[playerid], PlayerInfo[playerid][pUID]);
        }
		cache_delete(result);

        mysql_tquery(mruMySQL_Connection, str);
    }
}

MruMySQL_PobierzStatystyki(playerid, nickoruid[])
{
    new lStr[256];
    new nick_escaped[MAX_PLAYER_NAME];
    mysql_escape_string(nickoruid, nick_escaped);
    new uid = strval(nickoruid);
    mysql_format(mruMySQL_Connection, lStr, sizeof(lStr), "SELECT `Level`, `Admin`, `ZaufanyGracz`, `PAdmin`, `DonateRank`, `Money`, `Bank`, `PhoneNr`, `Job`, `BlokadaPisania`, `Member`, `FMember`, `Dom`, `Block`, `ZmienilNick`, `Warnings`, `UID` FROM `mru_konta` WHERE `Nick`='%e' OR `UID`='%d'", nick_escaped, uid);
    new Cache:result = mysql_query(mruMySQL_Connection, lStr, true);
    if(cache_is_valid(result))
    {
        if(cache_num_rows() > 0)
        {
            new plvl, padmin, pzg, ppadmin, ppremium, pmoney, pbank, pnr, pjob, pbp, pmember, porg, pdom, pblock, pzn, pwarn, puid;
            cache_get_value_index_int(0, 0, plvl); 
            cache_get_value_index_int(0, 1, padmin);
            cache_get_value_index_int(0, 2, pzg);
            cache_get_value_index_int(0, 3, ppadmin); 
            cache_get_value_index_int(0, 4, ppremium);
            cache_get_value_index_int(0, 5, pmoney);
            cache_get_value_index_int(0, 6, pbank);
            cache_get_value_index_int(0, 7, pnr);
            cache_get_value_index_int(0, 8, pjob);
            cache_get_value_index_int(0, 9, pbp);
            cache_get_value_index_int(0, 10, pmember);
            cache_get_value_index_int(0, 11, porg);
            cache_get_value_index_int(0, 12, pdom);
            cache_get_value_index_int(0, 13, pblock);
            cache_get_value_index_int(0, 14, pzn);
            cache_get_value_index_int(0, 15, pwarn);
            cache_get_value_index_int(0, 16, puid);
        }
		cache_delete(result);
            sscanf(query2, "p<|>ds[32]s[64]", typ, admin, powod);
    }

    new banstring[144]; 
    format(lStr, sizeof(lStr), "SELECT `typ`, `nadal`, `powod` FROM `mru_bany` WHERE `dostal`='%s' ORDER BY `czas` DESC LIMIT 1", pnickname);
    result = mysql_query(mruMySQL_Connection, lStr, true);
    if(cache_is_valid(result))
    {
        if(cache_num_rows() > 0)
        {
            new typ, powod[64], admin[32];
            cache_get_value_index_int(0, 0, typ);
            cache_get_value_index(0, 1, admin);
            cache_get_value_index(0, 2, powod);
            if(typ == WARN_BAN)
            {
                format(stringban, sizeof(stringban), "{FF0000}(%s) od %s", powod, admin);
            }
            else
            {
                format(stringban, sizeof(stringban), "{00FF00}brak");
            }
        }
        cache_delete(result);
    }

    format(lStr, sizeof(lStr), "> %s {FFFFFF}(UID: %d)", nick_escaped, puid);
    SendClientMessage(playerid, COLOR_RED, lStr);
    format(lStr, sizeof(lStr), "Level: %d ¦ Kasa: %d ¦ Bank: %d ¦ Numer tel.: %d ¦ ZN: %d ¦ Dom: %d", plvl, pmoney, pbank, pnr, pzn, pdom);
    SendClientMessage(playerid, -1, lStr);
    format(lStr, sizeof(lStr), "Admin: %d ¦ P@: %d ¦ ZG: %d ¦ BP: %d ¦ Block: %d ¦ Warny: %d ¦ Ban: %s", padmin, ppadmin, pzg, pbp, pblock, pwarn, banstring);
    SendClientMessage(playerid, -1, lStr);
    format(lStr, sizeof(lStr), "Premium: %d ¦ Praca: %d ¦ Frakcja: %d ¦ Org.: %d", ppremium, pjob, pmember, porg);
    SendClientMessage(playerid, -1, lStr);
    SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------------------------------");
}

MruMySQL_ZnajdzBanaPoIP(playerid, ip[])
{
    new query[256], str[800];
    mysql_format(mruMySQL_Connection, query, sizeof(query), "SELECT `nadal_uid`, `nadal`, `powod`, `czas`, `dostal`, `dostal_uid`, `typ` FROM `mru_bany` WHERE `IP` = '%e' AND `typ`>1 ORDER BY `czas` DESC LIMIT 4", ip);
    new Cache:result = mysql_query(mruMySQL_Connection, query, true);
    if(cache_is_valid(result))
    {
        for(new i; i < cache_num_rows(); i++)
        {
            new powod[64], admin[32], id, czas[32], pid, nick[32], typ;
            cache_get_value_index_int(i, 0, id);
            cache_get_value_index(i, 1, admin);
            cache_get_value_index(i, 2, powod);
            cache_get_value_index(i, 3, czas);
            cache_get_value_index(i, 4, nick);
            cache_get_value_index_int(i, 5, pid);
            cache_get_value_index_int(i, 6, typ);
            new resultfit[80];
            if(strlen(powod) > 0)
                format(resultfit, sizeof(resultfit), "{079FE1}%s\n", powod);
            format(str, sizeof(str), "%s{FFFFFF}Gracz: %s\t\tPID: %d\tIP: %s\nNada?: %s\t\tPID: %d\n%sData: %s\tStatus: %s\n",str, nick,pid,ip,admin,id, resultfit, czas, (typ == WARN_BAN) ? ("{FF0000}BAN") : ("{00FF00}UNBAN"));
        }

        if(isnull(str)) 
        {
            ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ_INFO, DIALOG_STYLE_LIST, "M-RP » Panel zarz?dzania karami", "Brak wyników", "Wró?", "");
        }
        else
        {
            ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ_INFO, DIALOG_STYLE_LIST, "M-RP » Panel zarz?dzania karami", str, "Wró?", "");
        }
		cache_delete(result);
    }
}

MruMySQL_ZnajdzBanaPoNicku(playerid, nick[])
{
    new query[256], str[800];
    mysql_format(mruMySQL_Connection, query, sizeof(query), "SELECT `nadal_uid`, `nadal`, `powod`, `czas`, `IP`, `dostal_uid`, `typ` FROM `mru_bany` WHERE `dostal` = '%e' AND `typ`>1 ORDER BY `czas` DESC LIMIT 4", nick);
    new Cache:result = mysql_query(mruMySQL_Connection, query, true);
    if(cache_is_valid(result))
    {
        for(new i; i < cache_num_rows(); i++)
        {
            new powod[64], admin[32], id, czas[32], ip[16], pid, typ;
            cache_get_value_index_int(i, 0, id); 
            cache_get_value_index(i, 1, admin); 
            cache_get_value_index(i, 2, powod); 
            cache_get_value_index(i, 3, czas); 
            cache_get_value_index(i, 4, ip); 
            cache_get_value_index_int(i, 5, pid); 
            cache_get_value_index_int(i, 6, typ); 

            new resultfit[80];
            if(strlen(powod) > 0)
                format(resultfit, sizeof(resultfit), "{079FE1}%s\n", powod);
        }

        if(isnull(str)) 
        {
            ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ_INFO, DIALOG_STYLE_LIST, "M-RP » Panel zarz?dzania karami", "Brak wyników", "Wró?", "");
        }
        else
        {
            ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ_INFO, DIALOG_STYLE_LIST, "M-RP » Panel zarz?dzania karami", str, "Wró?", "");
        }
        cache_delete(result);
    }
}

MruMySQL_UsunOrganizacje(id)
{
    new lStr[128];
    format(lStr, sizeof(lStr), "UPDATE `mru_konta` SET `FMember`=0, `Rank`=0 WHERE `FMember`='%d'", OrgInfo[id][o_UID]);
    mysql_pquery(mruMySQL_Connection, lStr);

    format(lStr, sizeof(lStr), "DELETE FROM `mru_org` WHERE `UID`='%d'", OrgInfo[id][o_UID]);
    mysql_pquery(mruMySQL_Connection, lStr);

    format(lStr, sizeof(lStr), "UPDATE `mru_strefy` SET `gang`=0 WHERE `gang`='%d'", OrgInfo[id][o_UID]);
    mysql_pquery(mruMySQL_Connection, lStr);
}