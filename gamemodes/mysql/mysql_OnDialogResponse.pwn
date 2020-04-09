
MruMySQL_ZapiszUprawnienia(playerid)
{
    new str[128];
    format(str, sizeof(str), "SELECT `UID` FROM `mru_uprawnienia` WHERE `UID`=%d", PlayerInfo[playerid][pUID]);
    mysql_query(str);
    mysql_store_result();
    if(mysql_num_rows()) format(str, sizeof(str), "UPDATE `mru_uprawnienia` SET `FLAGS`= b'%b' WHERE `UID`=%d", ACCESS[playerid], PlayerInfo[playerid][pUID]);
    else format(str, sizeof(str), "INSERT INTO `mru_uprawnienia` (`FLAGS`, `UID`) VALUES (b'%b', %d)", ACCESS[playerid], PlayerInfo[playerid][pUID]);
    mysql_free_result();
    mysql_query(str);
}

MruMySQL_PobierzStatystyki(playerid, nickoruid[])
{
    new lStr[300];
    new nick_escaped[MAX_PLAYER_NAME];
    mysql_real_escape_string(nickoruid, nick_escaped);
    new uid = strval(nickoruid);
    format(lStr, sizeof(lStr), "SELECT `Nick`, `Level`, `Admin`, `ZaufanyGracz`, `PAdmin`, `DonateRank`, `Money`, `Bank`, `PhoneNr`, `Job`, `BlokadaPisania`, `Member`, `FMember`, `Dom`, `Block`, `ZmienilNick`, `Warnings`, `UID` FROM `mru_konta` WHERE `Nick`='%s' OR `UID`='%d'", nick_escaped, uid);
    mysql_query(lStr);
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_fetch_row_format(lStr, "|");
        new pnickname[MAX_PLAYER_NAME], plvl, padmin, pzg, ppadmin, ppremium, pmoney, pbank, pnr, pjob, pbp, pmember, porg, pdom, pblock, pzn, pwarn, puid;
        sscanf(lStr, "p<|>s[24]ddddddddddddddddd", pnickname, plvl, padmin, pzg, ppadmin, ppremium, pmoney, pbank, pnr, pjob, pbp, pmember, porg, pdom, pblock, pzn, pwarn, puid);
        
        new query2[256], stringban[144];
        format(query2, sizeof(query2), "SELECT `typ`, `nadal`, `powod` FROM `mru_bany` WHERE `dostal`='%s' ORDER BY `czas` DESC LIMIT 1", pnickname);
        mysql_query(query2);
        mysql_store_result();

        if (mysql_num_rows())
        {
            mysql_fetch_row_format(query2, "|");
            mysql_free_result();
            new stringban[144], typ, powod[64], admin[32];
            sscanf(query2, "p<|>ds[32]s[64]", typ, admin, powod);

            if(typ == WARN_BAN)
            {
                format(stringban, sizeof(stringban), "{FF0000}(%s) od %s", powod, admin);
            }
            else
            {
                format(stringban, sizeof(stringban), "{00FF00}brak");
            }
        }
        else
        {
            format(stringban, sizeof(stringban), "{00FF00}brak");
        }

        format(lStr, sizeof(lStr), "> %s {FFFFFF}(UID: %d)", pnickname, puid);
        SendClientMessage(playerid, COLOR_RED, lStr);
        format(lStr, sizeof(lStr), "Level: %d ¦ Kasa: %d ¦ Bank: %d ¦ Numer tel.: %d ¦ ZN: %d ¦ Dom: %d", plvl, pmoney, pbank, pnr, pzn, pdom);
        SendClientMessage(playerid, -1, lStr);
        format(lStr, sizeof(lStr), "Admin: %d ¦ P@: %d ¦ ZG: %d ¦ BP: %d ¦ Block: %d ¦ Warny: %d | Ban: %s", padmin, ppadmin, pzg, pbp, pblock, pwarn, stringban);
        SendClientMessage(playerid, -1, lStr);
        format(lStr, sizeof(lStr), "Premium: %d ¦ Praca: %d ¦ Frakcja: %d ¦ Org.: %d", ppremium, pjob, pmember, porg);
        SendClientMessage(playerid, -1, lStr);
        SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------------------------------");
    }
    mysql_free_result();
}

MruMySQL_ZnajdzBanaPoIP(playerid, unescaped_ip[])
{
    new query[256],ip[16], str[800];
    mysql_real_escape_string(unescaped_ip, ip);
    format(query, sizeof(query), "SELECT `nadal_uid`, `nadal`, `powod`, `czas`, `dostal`, `dostal_uid`, `typ` FROM `mru_bany` WHERE `IP` = '%s' AND `typ`>1 ORDER BY `czas` DESC LIMIT 4", ip);
    mysql_query(query);
    mysql_store_result();
    if(mysql_num_rows())
    {
        while(mysql_fetch_row_format(query, "|"))
        {
            new powod[64], admin[32], id, czas[32], pid, nick[32], typ;
            sscanf(query, "p<|>ds[32]s[64]s[32]s[32]dd", id, admin, powod, czas,nick,pid, typ);
            new resultfit[80];
            if(strlen(powod) > 0)
                format(resultfit, sizeof(resultfit), "{079FE1}%s\n", powod);
            format(str, sizeof(str), "%s{FFFFFF}Gracz: %s\t\tPID: %d\tIP: %s\nNada³: %s\t\tPID: %d\n%sData: %s\tStatus: %s\n",str, nick,pid,ip,admin,id, resultfit, czas, (typ == WARN_BAN) ? ("{FF0000}BAN") : ("{00FF00}UNBAN"));
        }
        ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ_INFO, DIALOG_STYLE_LIST, "M-RP » Panel zarz¹dzania karami", str, "Wróæ", "");
    }
    else
    {
        ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ_INFO, DIALOG_STYLE_LIST, "M-RP » Panel zarz¹dzania karami", "Brak wyników", "Wróæ", "");
    }
    mysql_free_result();
}

MruMySQL_ZnajdzBanaPoNicku(playerid, unescaped_nick[])
{
    new query[256],nick[MAX_PLAYER_NAME], str[800];
    mysql_real_escape_string(unescaped_nick, nick);
    format(query, sizeof(query), "SELECT `nadal_uid`, `nadal`, `powod`, `czas`, `IP`, `dostal_uid`, `typ` FROM `mru_bany` WHERE `dostal` = '%s' AND `typ`>1 ORDER BY `czas` DESC LIMIT 4", nick);
    mysql_query(query);
    mysql_store_result();
    if(mysql_num_rows())
    {
        while(mysql_fetch_row_format(query, "|"))
        {
            new powod[64], admin[32], id, czas[32], ip[16], pid, typ;
            sscanf(query, "p<|>ds[32]s[64]s[32]s[16]dd", id, admin, powod, czas,ip, pid, typ);
            new resultfit[80];
            if(strlen(powod) > 0)
                format(resultfit, sizeof(resultfit), "{079FE1}%s\n", powod);
            format(str, sizeof(str), "%s{FFFFFF}Gracz: %s\t\tPID: %d\tIP: %s\nNada³: %s\t\tPID: %d\n%sData: %s\tStatus: %s\n",str, nick,pid,ip,admin,id, resultfit, czas, (typ == WARN_BAN) ? ("{FF0000}BAN") : ("{00FF00}UNBAN"));
        }
        ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ_INFO, DIALOG_STYLE_LIST, "M-RP » Panel zarz¹dzania karami", str, "Wróæ", "");
    }
    else
    {
        ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ_INFO, DIALOG_STYLE_LIST, "M-RP » Panel zarz¹dzania karami", "Brak wyników", "Wróæ", "");
    }
    mysql_free_result();
}

MruMySQL_UsunOrganizacje(id)
{
    new lStr[128];
    format(lStr, sizeof(lStr), "UPDATE `mru_konta` SET `FMember`=0, `Rank`=0 WHERE `FMember`='%d'", OrgInfo[id][o_UID]);
    mysql_query(lStr);

    format(lStr, sizeof(lStr), "DELETE FROM `mru_org` WHERE `UID`='%d'", OrgInfo[id][o_UID]);
    mysql_query(lStr);

    format(lStr, sizeof(lStr), "UPDATE `mru_strefy` SET `gang`=0 WHERE `gang`='%d'", OrgInfo[id][o_UID]);
    mysql_query(lStr);
}
