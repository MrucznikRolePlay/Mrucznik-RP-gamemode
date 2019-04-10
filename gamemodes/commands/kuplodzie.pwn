//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ kuplodzie ]-----------------------------------------------//
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

CMD:kuplodz(playerid) return cmd_kuplodzie(playerid);
CMD:kupstatek(playerid) return cmd_kuplodzie(playerid);
CMD:buyboat(playerid) return cmd_kuplodzie(playerid);
CMD:kuplodzie(playerid)
{
    if(IsPlayerInRangeOfPoint(playerid, 5.0, 857.3464,-2100.0881,9.8666))
    {
        if(PlayerInfo[playerid][pLodz] == 0)
	    {
	        if(GUIExit[playerid] == 0)
	    	{
		        ShowPlayerDialogEx(playerid, 400, DIALOG_STYLE_LIST, "Kupowanie ≥odzi", "Ponton\t\t2 250 000$\nKuter\t\t3 700 000$\nCoastguard\t8 500 000$\nLaunch\t\t11 000 000$\nSpeeder\t13 500 000$\nJetmax\t\t20 000 000$\nTropic\t\t25 000 000$\nSquallo\t\t25 000 000$\nJacht\t\t40 000 000$", "Wybierz", "Wyjdü");
            }
	    }
	    else
	    {
	        sendErrorMessage(playerid, "Posiadasz juø ≥Ûdü.");
	    }
	}
	else
	{
	    sendErrorMessage(playerid, "Nie jesteú przy stoczni.");
	}
	return 1;
}




