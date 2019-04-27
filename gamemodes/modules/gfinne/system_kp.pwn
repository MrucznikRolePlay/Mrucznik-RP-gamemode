//
forward MRP_SaveMC(playerid);
forward MRP_GiveKP(playerid, time);

stock MRP_LoadPremium(playerid)
{
    if(!MYSQL_ON) return false;

	new query[256], lMC, lEnd, lStart, lLast, lHours;
	format(query, sizeof(query), "SELECT `mc`, UNIX_TIMESTAMP(`end`), UNIX_TIMESTAMP(`start`), UNIX_TIMESTAMP(`last_check`), `hours` FROM `mru_premium` WHERE `puid`='%d'", PlayerInfo[playerid][pUID]);
	mysql_query(query);
	mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_fetch_row_format(query, "|");
        mysql_free_result();
        sscanf(query, "p<|>ddddd", lMC, lEnd, lStart, lLast, lHours);
        if(PlayerInfo[playerid][pDonateRank] == 10)
        {
            new lVal = lEnd-(gettime()+3600);
            if(lEnd != 0 && lVal <= 0) //Premium czasowe
            {
                /*PlayerInfo[playerid][pDonateRank] = 0;
                SendClientMessage(playerid, COLOR_YELLOW, "Twoje konto premium wygas³o. {FFFFFF}Zapraszamy do kolejnego zakupu!");*/
            }
            if(lEnd == 0 && lStart != 0)
            {
                //Sprawdzanie aktywnosci i godzin online
                if(gettime() > lLast+MRP_PREMIUM_TIME)
                {
                    if(lHours < MRP_PREM_HOURS) //Brak odpowiedniej liczby godzin
                    {
                        new bantime, unbantime;
                        unbantime = MRP_CheckLastBlock(playerid, bantime);
                        new logintime, ip[16];
                        MRP_CheckLastLogin(PlayerInfo[playerid][pUID], logintime, ip);
                        if(unbantime == -1)
                        {
                            /*SendClientMessage(playerid, COLOR_RED, "Napotkano konflikt, gdzie kara nie zostala zdjeta prawid³owo. Skontaktuj siê z administracj¹.");
                            SendClientMessage(playerid, COLOR_RED, "W tym wypadku, Konto Premium zosta³o odebrane.");
                            PlayerInfo[playerid][pDonateRank] = 0;*/
                        }
                        if(logintime <= bantime && bantime != 0 && unbantime != 0) //Ostatnie logowanie bylo przed kar¹
                        {
                            new anntime=0;
                            if(unbantime > lLast+MRP_PREMIUM_TIME) //TEST: OK?
                            {
                                if(lLast+MRP_PREMIUM_TIME < bantime)
                                {
                                    /*SendClientMessage(playerid, COLOR_YELLOW, "Twoje konto premium wygas³o. {FFFFFF}Zapraszamy do kolejnego zakupu!");
                                    PlayerInfo[playerid][pDonateRank] = 0;*/
                                }
                                else
                                {
                                    unbantime -= (lLast+MRP_PREMIUM_TIME)-bantime;
                                    anntime = unbantime - gettime();
                                }
                            }
                            else //TEST: OK
                            {
                                unbantime-=bantime;
                                anntime = unbantime;
                            }
                            //Zwracanie czasu podczas aktywnej kary:
                            if(anntime > 0)
                            {
                                format(query, 128, "Przed³u¿ono Twoje premium o %d dni i %d godzin.", floatround(floatdiv(anntime, 86400), floatround_floor), floatround(floatdiv(anntime, 3600), floatround_floor)%24);
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, query);

                                format(query, sizeof(query), "UPDATE `mru_premium` SET `last_check`=FROM_UNIXTIME(%d) WHERE `puid`='%d'", lLast+unbantime, PlayerInfo[playerid][pUID]);
                                mysql_query(query);
                            }
                            else
                            {
                                /*SendClientMessage(playerid, COLOR_YELLOW, "Twoje konto premium wygas³o. {FFFFFF}Zapraszamy do kolejnego zakupu!");
                                PlayerInfo[playerid][pDonateRank] = 0;*/
                            }
                        }
                        else //Gracz nie posiadal kary, odbieramy
                        {
                            /*PlayerInfo[playerid][pDonateRank] = 0;
                            SendClientMessage(playerid, COLOR_YELLOW, "Twoje konto premium wygas³o, nie przegra³es wymaganej ilosci godzin. {FFFFFF}Zapraszamy do kolejnego zakupu!");
							*/
						}
                    }
                    else
                    {
                        //Czysty miesiac, KP pozostaje
                        format(query, sizeof(query), "UPDATE `mru_premium` SET `last_check`=NOW(), `hours`=0 WHERE `puid`='%d'", PlayerInfo[playerid][pUID]);
                        mysql_query(query);
                    }
                }
                else if(GetPVarInt(playerid, "kp_readd") == 1)
                {
                    new bantime, unbantime;
                    unbantime = MRP_CheckLastBlock(playerid, bantime);
                    new logintime, ip[16];
                    MRP_CheckLastLogin(PlayerInfo[playerid][pUID], logintime, ip);
                    if(logintime <= bantime && bantime != 0 && unbantime != 0)
                    {
                        unbantime-=bantime;
                        if(unbantime < 0)
                        {
                            SendClientMessage(playerid, COLOR_RED, "Napotkano konflikt, gdzie kara nie zostala zdjeta prawid³owo. Skontaktuj siê z administracj¹.");
                        }
                        else
                        {
                            format(query, 128, "Przed³u¿ono Twoje premium o %d dni i %d godzin.", floatround(floatdiv(unbantime, 86400), floatround_floor), floatround(floatdiv(unbantime, 3600), floatround_floor)%24);
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, query);

                            format(query, sizeof(query), "UPDATE `mru_premium` SET `last_check`=FROM_UNIXTIME(%d) WHERE `puid`='%d'", lLast+unbantime, PlayerInfo[playerid][pUID]);
                            mysql_query(query);
                        }
                    }
                    SetPVarInt(playerid, "kp_readd", 0);
                }
                else
                {
                    if(lHours < MRP_PREM_HOURS)
                    {
                        format(query, 128, "PREMIUM: Potrzebujesz jeszcze %d godzin, aby zachowaæ Konto Premium.", MRP_PREM_HOURS-lHours);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, query);
                    }
                }
            }
        }
        if(lMC > 0) PlayerMC[playerid] = lMC;
    }
    //Konwersja ze starego na nowy system.
    if(PlayerInfo[playerid][pDonateRank] < 4 && PlayerInfo[playerid][pDonateRank] > 0)
    {
        //Dodatkowe MruCoiny
        PlayerMC[playerid]+=200*PlayerInfo[playerid][pDonateRank];
        PlayerInfo[playerid][pCarSlots] += clamp(PlayerInfo[playerid][pDonateRank], 1, 2);
        if(PlayerInfo[playerid][pGaraz] > 0) PlayerInfo[playerid][pCarSlots]++;
        MRP_GiveKP(playerid, 0);

    }
    return 1;
}

stock MRP_CheckLastBlock(playerid, &lasttime)
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

stock MRP_CheckLastLogin(uid, &time, ip[])
{
    new str[256];
    format(str, 256, "SELECT UNIX_TIMESTAMP(`time`) a, `IP` FROM `mru_logowania` WHERE `PID`='%d' ORDER BY a DESC LIMIT 1", uid);
    mysql_query(str);
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_fetch_row_format(str, "|");
        sscanf(str, "p<|>ds[16]", time, ip);
        mysql_free_result();
    }
    return 1;
}

stock MRP_PlayerLog(playerid)
{
    new str[128], ip[16];
    GetPlayerIp(playerid, ip, 16);
    format(str, 128, "INSERT INTO `mru_logowania` (`PID`, `time`, `IP`) VALUES ('%d', NOW(), '%s')", PlayerInfo[playerid][pUID], ip);
    mysql_query(str);
    return 1;
}

public MRP_SaveMC(playerid)
{
    if(!MYSQL_ON) return false;
    new query[128];
    format(query, sizeof(query), "SELECT `UID` FROM `mru_premium` WHERE `puid`='%d'", PlayerInfo[playerid][pUID]);
	mysql_query(query);
	mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_free_result();
        if(PlayerInfo[playerid][pDonateRank] > 0)
            format(query, sizeof(query), "UPDATE `mru_premium` SET `mc`='%d', `hours`=`hours`+'%d' WHERE `puid`='%d'", PlayerMC[playerid], MRP_PremiumHours[playerid],PlayerInfo[playerid][pUID]);
        else
            format(query, sizeof(query), "UPDATE `mru_premium` SET `mc`='%d' WHERE `puid`='%d'", PlayerMC[playerid],PlayerInfo[playerid][pUID]);
        mysql_query(query);
    }
    else
    {
        mysql_free_result();
        if(PlayerMC[playerid] > 0)
        {
            format(query, sizeof(query), "INSERT INTO `mru_premium` (`mc`, `hours`, `puid`) VALUES('%d', '%d', '%d')", PlayerMC[playerid], MRP_PremiumHours[playerid], PlayerInfo[playerid][pUID]);
            mysql_query(query);
        }
    }
    return 1;
}

public MRP_GiveKP(playerid, time)
{
    if(IsPlayerConnected(playerid))
    {
        new query[128];
        format(query, sizeof(query), "SELECT `UID` FROM `mru_premium` WHERE `puid`='%d'", PlayerInfo[playerid][pUID]);
    	mysql_query(query);
    	mysql_store_result();
        if(mysql_num_rows())
        {
            format(query, sizeof(query), "UPDATE `mru_premium` SET `end`='%d', `start`=NOW(), `last_check`=NOW() WHERE `puid`='%d'", time, PlayerInfo[playerid][pUID]);
            mysql_query(query);
        }
        else
        {
            format(query, sizeof(query), "INSERT INTO `mru_premium` (`end`, `puid`, `last_check`, `start`) VALUES('%d', '%d', NOW(), NOW())", time, PlayerInfo[playerid][pUID]);
            mysql_query(query);
        }
        mysql_free_result();
        new lVal = time-(gettime()+3600);
        if(lVal > 0 && time != 0)
        {
            format(query, 128, "Otrzyma³es Konto Premium, które wygasa za: %d dni i %d godzin.", floatround(floatdiv(lVal, 86400), floatround_floor), floatround(floatdiv(lVal, 3600), floatround_floor)%24);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, query);
            PlayerInfo[playerid][pDonateRank] = 10;
        }
        else if(time == 0)
        {
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "Otrzyma³es Konto Premium na czas nieokreœlony.");
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "Pamiêtaj, ¿e wymagamy przegrania 15 godzin w ci¹gu 3 miesi¹cy!");
            PlayerInfo[playerid][pDonateRank] = 0;
        }
        else
        {
            /*PlayerInfo[playerid][pDonateRank] = 0;
            SendClientMessage(playerid, KOLOR_FILOETOWY, "Twoje konto premium wygas³o. {FFFFFF}Zapraszamy do kolejnego zakupu!");*/
        }
    }
    return 1;
}
//
