MruMySQL_ClearZone(zoneid)
{
    new str[64];
    format(str, 64, "UPDATE `mru_strefy` SET `gang`='0' WHERE `id`='%d'", zoneid);
    mysql_tquery(mruMySQL_Connection, str);
}

MruMySQL_CzyjToNumer(playerid, number)
{
    new query[128];
    format(query, sizeof(query), "SELECT `Nick` FROM mru_konta WHERE `PhoneNr`='%d'", number);
    new Cache:result = mysql_query(mruMySQL_Connection, query, true);
    if(cache_is_valid(result))
    {
        for(new i; i < cache_num_rows(); i++)
        {
            new nick[MAX_PLAYER_NAME];
            cache_get_value_index(i, 0, nick);
            SendClientMessage(playerid, COLOR_WHITE, nick);
        }
		cache_delete(result);
    }
}

MruMySQL_ListaLiderow(playerid, family)
{
    new query[128];
    SendClientMessage(playerid, COLOR_RED, "================ LISTA LIDERÓW ================");
    format(query, sizeof(query), "SELECT `Nick` FROM `mru_konta` WHERE `FMember`='%d' AND `Rank`>1000", family);
    new Cache:result = mysql_query(mruMySQL_Connection, query, true);

    if(cache_is_valid(result))
    {
        for(new i; i < cache_num_rows(); i++)
        {
            new nick[MAX_PLAYER_NAME];
            cache_get_value_index(i, 0, nick);
            SendClientMessage(playerid, -1, nick);
        }
        SendClientMessage(playerid, COLOR_RED, "================ KONIEC ================");
		cache_delete(result);
    }
}

MruMySQL_Gangzone(zoneid)
{
    new str[64];
    mysql_format(mruMySQL_Connection, str, sizeof(str), "UPDATE `mru_config` SET `gangzone`='%d'", zoneid);
    mysql_tquery(mruMySQL_Connection, str);
}

MruMySQL_KodStanowca(code)
{
    new lStr[64];
    mysql_format(mruMySQL_Connection, lStr, sizeof(lStr), "UPDATE `mru_config` SET `stanowe_key`='%d'", code);
    mysql_tquery(mruMySQL_Connection, lStr);
}

MruMySQL_Unwarn(nick[])
{
    new str[128];
    mysql_format(mruMySQL_Connection, str, sizeof(str), "UPDATE `mru_konta` SET `Warnings` = `Warnings`-1 WHERE `Nick` = '%e'", nick);
    mysql_tquery(mruMySQL_Connection, str);
}

MruMySQL_UpdateFamily(id, nazwa[])
{
    new query[75];
    mysql_format(mruMySQL_Connection, query, sizeof(query), "UPDATE `mru_rodziny` SET `id`=%d WHERE `name`='%e'", id, nazwa);
    mysql_tquery(mruMySQL_Connection, query);
}

MruMySQL_SetZoneControl(frac, id)
{
    new str[128];
    format(str, 128, "UPDATE `mru_strefy` SET `gang`='%d' WHERE `id`='%d'", frac, id);
    mysql_tquery(mruMySQL_Connection, str);
}

MruMySQL_ChangePassword(nick[], password[])
{
    new string[256];
    new escaped_nick[MAX_PLAYER_NAME];
    new hashedPassword[WHIRLPOOL_LEN], salt[SALT_LENGTH];
    randomString(salt, sizeof(salt));
    WP_Hash(hashedPassword, sizeof(hashedPassword), sprintf("%s%s%s", ServerSecret, password, salt));
    mysql_format(mruMySQL_Connection, string, sizeof(string), "UPDATE `mru_konta` SET `Key` = '%s' WHERE `Nick` = '%e'", password, nick);
    mysql_tquery(mruMySQL_Connection, string);
}

MruMySQL_ZoneDelay(zoneid)
{
    new str[64];
    format(str, sizeof(str), "UPDATE `mru_config` SET `gangtimedelay`='%d'", zoneid);
    mysql_tquery(mruMySQL_Connection, str);
}
