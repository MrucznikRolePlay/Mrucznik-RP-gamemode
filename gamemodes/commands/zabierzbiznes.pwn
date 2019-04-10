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

CMD:zabierzbiznes(playerid, params[])
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
            BiznesLog(string);
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
/*CMD:bizmoneydebug(playerid)
{
	if(PlayerInfo[playerid][pPbiskey] >= 0 && PlayerInfo[playerid][pPbiskey] <= MAX_BIZNES && PlayerInfo[playerid][pAdmin] == 5000)
	{
	    new string[128];
		new bizid = PlayerInfo[playerid][pPbiskey];
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
		format(string, sizeof(string), "  Dochód z biznesu: $%d", BizData[bizid][eBizMoney]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "|________________________|");
		DajKase(playerid, BizData[bizid][eBizMoney]);
	}
	return 1;
}*/
