
MruMySQL_ClearZone(zoneid)
{
    new str[64];
    format(str, 64, "UPDATE `mru_strefy` SET `gang`='0' WHERE `id`='%d'", zoneid);
    mysql_query(str);
}

MruMySQL_CzyjToNumer(playerid, number)
{
    new string[128], string_two[144], connected_status, selectedplayer = INVALID_PLAYER_ID, nick[MAX_PLAYER_NAME];
    format(string, sizeof(string), "SELECT `Nick`, `connected` FROM mru_konta WHERE `PhoneNr`='%d'", number);
    mysql_query(string);
    mysql_store_result();
    if(mysql_num_rows())
    {
        while(mysql_fetch_row_format(string, "|"))
        {
            sscanf(string, "p<|>s[24]d", nick, connected_status);
            if(connected_status)
            {
                foreach(new i : Player)
                {
                    if(gPlayerLogged[i] != 0)
                    {
                        if(strcmp(GetNickEx(i), nick, true, strlen(nick)) == 0)
                        {
                            selectedplayer = i;
                        }
                    }
                }
            }
            format(string_two, sizeof(string_two), "{%s}(%s) {FFFFFF}%s%s", 
                connected_status > 0 ? "00FF00" : "FF0000",
                connected_status > 0 ? "Online" : "Offline",
                nick,
                selectedplayer != INVALID_PLAYER_ID ? sprintf(" [%d]", selectedplayer) : ""
            );
            
            SendClientMessage(playerid, COLOR_WHITE, string_two);
            selectedplayer = INVALID_PLAYER_ID;
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
    new nick[24];
    while(mysql_fetch_row_format(string, "|"))
    {
        sscanf(string, "p<|>s[24]", nick);
        SendClientMessage(playerid, -1, nick);
    }
    mysql_store_result();
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

MruMySQL_SetZoneControl(frac, id)
{
    new str[128];
    format(str, 128, "UPDATE `mru_strefy` SET `gang`='%d' WHERE `id`='%d'", frac, id);
    mysql_query(str);
}

MruMySQL_ChangePassword(nick[], password[])
{
    new string[256];
    new escaped_nick[MAX_PLAYER_NAME];
    new hashedPassword[WHIRLPOOL_LEN], salt[SALT_LENGTH];
    randomString(salt, sizeof(salt));
    WP_Hash(hashedPassword, sizeof(hashedPassword), sprintf("%s%s%s", ServerSecret, password, salt));
    mysql_real_escape_string(nick, escaped_nick);
    format(string, sizeof(string), "UPDATE `mru_konta` SET `Key` = '%s', `Salt` = '%s' WHERE `Nick` = '%s'", hashedPassword, salt, escaped_nick);
    mysql_query(string);
}

MruMySQL_ZoneDelay(zoneid)
{
    new str[64];
    format(str, sizeof(str), "UPDATE `mru_config` SET `gangtimedelay`='%d'", zoneid);
    mysql_query(str);
}
