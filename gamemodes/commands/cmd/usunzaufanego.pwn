//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ usunzaufanego ]--------------------------------------------//
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

YCMD:usunzaufanego(playerid, params[], help)
{
    if(Uprawnienia(playerid, ACCESS_ZG))
    {
		new para1;
        new string[128];
    	new giveplayer[MAX_PLAYER_NAME];
    	new sendername[MAX_PLAYER_NAME];
		if(sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /usunzaufanego [playerid/CzêœæNicku]");
			return 1;
		}
	    if(IsPlayerConnected(para1))
	    {
            if(!PlayerInfo[para1][pZG])
                return sendErrorMessage(playerid, "Ten gracz nie jest zaufanym graczem");
            GetPlayerName(para1, giveplayer, sizeof(giveplayer));
            GetPlayerName(playerid, sendername, sizeof(sendername));
            format(string, sizeof(string), "Nie jesteœ ju¿ zaufanym graczem przez %s", sendername);
            SendClientMessage(para1, COLOR_LIGHTBLUE, string);
            format(string, sizeof(string), "Usun¹³eœ %s zaufanego gracza.", giveplayer);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            Log(adminLog, INFO, "Admin %s usun¹³ %s status zaufanego", GetPlayerLogName(playerid), GetPlayerLogName(para1));

            PlayerInfo[para1][pZG] = 0;
		} else {
            mysql_real_escape_string(params,giveplayer);
            new lStr[128];
            format(lStr, sizeof(lStr), "SELECT `UID` FROM `mru_konta` WHERE `Nick`='%s'", giveplayer);
            mysql_query(lStr);
            mysql_store_result();
            if(mysql_num_rows()) {
                mysql_fetch_row_format(lStr, "|");
                new uid = strval(lStr);
                format(string, sizeof(string), "Usun¹³eœ offline %s zaufanego gracza.", giveplayer);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                Log(adminLog, INFO, "Admin %s usun¹³ {Player: %s[%d]} status zaufanego", GetPlayerLogName(playerid), giveplayer, uid);
                format(lStr, sizeof(lStr), "UPDATE `mru_konta` SET `ZaufanyGracz`=0 WHERE `UID`='%i'", uid);
                mysql_query(lStr);
            } else
                sendErrorMessage(playerid, "Gracz jest offline i nie znaleziono go w bazie");
            mysql_free_result();
        }
	}
	return 1;
}
