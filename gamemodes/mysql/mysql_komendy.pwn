
MruMySQL_ClearZone(zoneid)
{
    new str[64];
    format(str, 64, "UPDATE `mru_strefy` SET `gang`='0' WHERE `id`='%d'", zoneid);
    mysql_query(str);
}

MruMySQL_CzyjToNumer(playerid, number)
{
    new string[128];
    format(string, sizeof(string), "SELECT `Nick` FROM mru_konta WHERE `PhoneNr`='%d'", number);
    mysql_query(string);
    mysql_store_result();
    if(mysql_num_rows())
    {
        while(mysql_fetch_row_format(string, "|"))
        {
            new nick[MAX_PLAYER_NAME];
            sscanf(string, "p<|>s[24]", nick);
            SendClientMessage(playerid, COLOR_WHITE, nick);
        }
    }
    mysql_free_result();
}

MruMySQL_ListaLiderow(playerid, family)
{
    new string[128];
    SendClientMessage(playerid, COLOR_RED, "================ LISTA LIDERÓW ================");
    format(string, sizeof(string), "SELECT `Nick` FROM `mru_konta` WHERE `FMember`='%d' AND `Rank`>1000", family);
    mysql_query(string);
    mysql_store_result();
    new nick[24];
    while(mysql_fetch_row_format(string, "|"))
    {
        sscanf(string, "p<|>s[24]", nick);
        SendClientMessage(playerid, -1, nick);
    }
    SendClientMessage(playerid, COLOR_RED, "================ KONIEC ================");
}

MruMySQL_Gangzone(zoneid)
{
    new str[64];
    format(str, sizeof(str), "UPDATE `mru_config` SET `gangzone`='%d'", zoneid);
    mysql_query(str);
}

MruMySQL_KodStanowca(code)
{
    new lStr[64];
    format(lStr, sizeof(lStr), "UPDATE `mru_config` SET `stanowe_key`='%d'", code);
    mysql_query(lStr);
}
MruMySQL_Unwarn(nick[])
{
    new str[128];
    new escaped_nick[MAX_PLAYER_NAME];
    mysql_real_escape_string(nick, escaped_nick);
    format(str, sizeof(str), "UPDATE `mru_konta` SET `Warnings` = `Warnings`-1 WHERE `Nick` = '%s'", escaped_nick);
    mysql_query(str);
}

MruMySQL_UpdateFamily(id, nazwa[])
{
    new query[75];
	new nazwa_escaped[32];
	mysql_real_escape_string(nazwa, nazwa_escaped);
    format(query, sizeof(query), "UPDATE `mru_rodziny` SET `id`=%d WHERE `name`='%s'", id, nazwa_escaped);
    mysql_query(query);
}

MruMySQL_SetZoneControl(frac, id)
{
    new str[128];
    format(str, 128, "UPDATE `mru_strefy` SET `gang`='%d' WHERE `id`='%d'", frac, id);
    mysql_query(str);
}

MruMySQL_ChangePassword(nick[], password[])
{
    new string[128];
    new escaped_nick[MAX_PLAYER_NAME];
    mysql_real_escape_string(nick, escaped_nick);
    format(string, sizeof(string), "UPDATE `mru_konta` SET `Key` = '%s' WHERE `Nick` = '%s'", password, escaped_nick);
    mysql_query(string);
}

MruMySQL_ZoneDelay(zoneid)
{
    new str[64];
    format(str, sizeof(str), "UPDATE `mru_config` SET `gangtimedelay`='%d'", zoneid);
    mysql_query(str);
}
