//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ wyscig_stop ]----------------------------------------------//
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

YCMD:wyscig_stop(playerid, params[], help)
{
    if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_RACE))
    {
		if(PlayerInfo[playerid][pRank] >= 2)
		{
			if(Scigamy != 666)
            {
				SendClientMessage(playerid, COLOR_LIGHTGREEN, "Wyscig zatrzymany. Wszyscy uczestnicy zostali poinformowani.");
				KoniecWyscigu(playerid);
			}
			else
			{
				sendErrorMessage(playerid, "¯aden wyœcig nie jest w tej chwili organizowany");
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie posiadasz uprawnieñ (wymagana 2 ranga)");
		}
	}
	else
	{
		sendErrorMessage(playerid, "Twoja organizacja nie posiada biznesu Toru wyœcigowego");
	}
	return 1;
}
