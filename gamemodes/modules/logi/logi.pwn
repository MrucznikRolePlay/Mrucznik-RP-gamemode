//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    logi                                                   //
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
// Autor: Mrucznik
// Data utworzenia: 04.05.2019
//Opis:
/*
	Narzêdzia do obs³ugi logów.
*/

//

//-----------------<[ Funkcje: ]>-------------------
MRP_CheckLastLogin(uid, &time, ip[])
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

MRP_PlayerLog(playerid)
{
    new str[128], ip[16], GPCI[128];
    GetPlayerIp(playerid, ip, 16);
    gpci(playerid, GPCI, 128);
    mysql_real_escape_string(GPCI, GPCI);
    format(str, 128, "INSERT INTO `mru_logowania` (`PID`, `time`, `IP`, `gpci`) VALUES ('%d', NOW(), '%s', '%s')", PlayerInfo[playerid][pUID], ip, GPCI);
    mysql_query(str);
    return 1;
}


//end