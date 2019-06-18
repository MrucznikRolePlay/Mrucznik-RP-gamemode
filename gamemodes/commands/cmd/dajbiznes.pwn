//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ dajbiznes ]-----------------------------------------------//
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

YCMD:dajbiznes(playerid, params[], help)
{
	if (PlayerInfo[playerid][pAdmin] == 5000 || PlayerInfo[playerid][pAdmin] == 5001)
	{
		new gracz, wartosc;
		if(sscanf(params, "k<fix>d", gracz, wartosc)) return sendTipMessage(playerid, "U¿yj /dajbiznes [playerid/CzêœæNicku] [ID Biznesu]");
		if(IsPlayerConnected(gracz))
		{
			PlayerInfo[gracz][pPbiskey] = wartosc;
			MruMySQL_SaveAccount(playerid);
            Log(adminLog, INFO, "Admin %s da³ %s biznes %s", GetPlayerLogName(playerid), GetPlayerLogName(gracz), GetBusinessLogName(wartosc));
            _MruAdmin(playerid, sprintf("Da³eœ biznes %s (ID %d) graczowi %s [ID: %d]", BizData[wartosc][eBizName], wartosc, GetNick(gracz, true), gracz));
            if(gracz != playerid) _MruAdmin(gracz, sprintf("Dosta³eœ biznes %s (ID %d) Admina %s [ID: %d]", BizData[wartosc][eBizName], wartosc, GetNick(playerid, true), playerid));
		}
		else
		{
			sendErrorMessage(playerid, "Ten gracz jest offline!");
		}

	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
