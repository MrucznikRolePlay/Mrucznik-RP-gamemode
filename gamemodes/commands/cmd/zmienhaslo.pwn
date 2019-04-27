//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ zmienhaslo ]----------------------------------------------//
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

YCMD:zmienhaslo(playerid, params[], help)
{
	new string[256];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            sendErrorMessage(playerid, "Nie zalogowa³eœ siê!");
            return 1;
        }
        new tmppass[64], password[129];
		if(sscanf(params, "s[64]", tmppass))
		{
			sendTipMessage(playerid, "U¿yj /zmienhaslo [nowehaslo]");
			return 1;
		}
		
		if(strfind(params, "%") != -1)
		{
            sendErrorMessage(playerid, "Has³o nie mo¿e zawieraæ znaku procenta!");
            return 1;
		}
		
		sendErrorMessage(playerid, "Twoje has³o do konta w grze zosta³o zmienione!!!!");
		sendErrorMessage(playerid, "Jeœli wpisa³eœ t¹ komendê przypadkowo, nie wychodŸ z serwera i zmieñ has³o ponownie za pomoc¹ tej komendy");
		sendErrorMessage(playerid, "Nowe has³o:");
		SendClientMessage(playerid, COLOR_PANICRED, tmppass);

		
		WP_Hash(password, sizeof(password), tmppass);
		format(string, sizeof(string), "UPDATE `mru_konta` SET `Key` = '%s' WHERE `Nick` = '%s'", password, GetNick(playerid));
		mysql_query(string);
	}
	return 1;
}
