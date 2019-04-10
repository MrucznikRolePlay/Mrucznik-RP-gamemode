//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ radiostacja ]----------------------------------------------//
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

CMD:radiostacja(playerid)
{
    if(IsPlayerInRangeOfPoint(playerid,20,651.4651,-1367.8018,28.5072) ||
        IsPlayerInRangeOfPoint(playerid,20,652.9285,-1383.2341,28.4672) ||
        IsPlayerInRangeOfPoint(playerid,20,669.9277,-1380.8677,28.4672) ||
        IsPlayerInRangeOfPoint(playerid,20,648.9404,-1379.7324,28.4672) ||
        IsPlayerInRangeOfPoint(playerid,20,651.7086,-1367.8019,28.5072))
    {
        if(IsPlayerInFraction(playerid, FRAC_SN))
	    {
            if(PlayerInfo[playerid][pRank] < 3) return sendTipMessageEx(playerid, COLOR_GREY, "Od 3 rangi!");
            ShowPlayerDialogEx(playerid, 667, DIALOG_STYLE_LIST, "Wybierz nag³oœniê", "R SAN 01\nR SAN 02", "Wybierz", "Anuluj");
        }
        else return sendErrorMessage(playerid, "Nie nale¿ysz do SN!");
	}
	else
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w Studiu nagrañ albo drukarni!");
	}

	return 1;
}

