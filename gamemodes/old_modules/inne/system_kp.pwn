//
MRP_CheckLastBlock(playerid, &lasttime)
{
    new time=0, ip[16], nick[24];
    GetPlayerName(playerid, nick, 24);
    GetPlayerIp(playerid, ip, 16);
    new str[256];
    //Szukanie najnowszej œci¹gniêtej kary
    format(str, 256, "SELECT UNIX_TIMESTAMP(`czas`) a FROM `mru_bany` WHERE (`dostal_uid`='%d' OR `dostal`='%s' OR `IP`='%s') AND `typ`=21 ORDER BY a DESC LIMIT 1", PlayerInfo[playerid][pUID], nick, ip);
    mysql_query(str);
    mysql_store_result();
    if(mysql_num_rows())
    {
        time = mysql_fetch_int();
        mysql_free_result();
    }
    //Szukanie wczesniejszej kary nadanej przed unblockiem
    format(str, 256, "SELECT UNIX_TIMESTAMP(`czas`) a FROM `mru_bany` WHERE (`dostal_uid`='%d' OR `dostal`='%s' OR `IP`='%s') AND `typ`=2 ORDER BY a DESC LIMIT 1", PlayerInfo[playerid][pUID], nick, ip);
    mysql_query(str);
    mysql_store_result();
    if(mysql_num_rows())
    {
        lasttime = mysql_fetch_int();
        mysql_free_result();
    }
    if(time < lasttime) return -1; //Aktywna blokada, nie powinno sie wykonac
    return time;
}

//
