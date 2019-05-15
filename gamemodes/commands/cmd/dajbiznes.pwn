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
			new string[128];
			PlayerInfo[gracz][pPbiskey] = wartosc;
			MruMySQL_SaveAccount(playerid);
			format(string, sizeof(string),"AdmCmd: %s dal biznes %s (ID %d) graczowi %s.", GetNick(playerid), BizData[wartosc][eBizName], wartosc, GetNick(gracz));
            Log(biznesLog, INFO, string);
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
