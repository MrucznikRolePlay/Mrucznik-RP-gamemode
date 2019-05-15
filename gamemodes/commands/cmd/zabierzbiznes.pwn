//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ zabierzbiznes ]---------------------------------------------//
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

YCMD:zabierzbiznes(playerid, params[], help)
{
	if (PlayerInfo[playerid][pAdmin] == 5000 || PlayerInfo[playerid][pAdmin] == 5001)
	{
		new gracz;
		if(sscanf(params, "d", gracz)) return sendTipMessage(playerid, "U¿yj /zabierzbiznes [playerid/CzêœæNicku]");
		if(IsPlayerConnected(gracz))
		{
			new string[128];
			PlayerInfo[gracz][pPbiskey] = 255;
			MruMySQL_SaveAccount(playerid);
			format(string, sizeof(string),"AdmCmd: %s zabral biznes graczowi %s.", GetNick(playerid), GetNick(gracz));
            Log(biznesLog, INFO, string);
            _MruAdmin(playerid, sprintf("Zabra³eœ biznes graczowi %s [ID: %d]", GetNick(gracz, true), gracz));
            if(gracz != playerid) _MruAdmin(gracz, sprintf("Biznes zosta³ zabrany przez Admina %s [ID: %d]", GetNick(playerid, true), playerid));
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
