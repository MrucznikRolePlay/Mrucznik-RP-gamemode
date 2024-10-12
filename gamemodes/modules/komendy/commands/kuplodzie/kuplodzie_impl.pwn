//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_kuplodzie_Impl(playerid)
{
    if(IsPlayerInRangeOfPoint(playerid, 5.0, 857.3464,-2100.0881,9.8666) || 
	IsPlayerInRangeOfPoint(playerid, 5.0, -4430.3613, 949.4258, 3.5730) || // Vice City Beach
	IsPlayerInRangeOfPoint(playerid, 5.0, -4841.2861, 764.7393, 8.2627)) // Vice City Doki
    {
		if(IsPlayerInAnyVehicle(playerid))
		{
			sendErrorMessage(playerid, "Aby tego u¿yæ musisz wyjœæ z pojazdu"); 
			return 1;
		}
        if(PlayerInfo[playerid][pLodz] == 0)
	    {
	        if(GUIExit[playerid] == 0)
	    	{
		        ShowPlayerDialogEx(playerid, 400, DIALOG_STYLE_LIST, "Kupowanie ³odzi", "Ponton\t\t500 000$\nKuter\t\t370 000$\nCoastguard\t850 000$\nLaunch\t\t1 100 000$\nSpeeder\t1 350 000$\nJetmax\t\t2 000 000$\nTropic\t\t2 500 000$\nSquallo\t\t2 500 000$\nJacht\t\t4 000 000$", "Wybierz", "WyjdŸ");
            }
	    }
	    else
	    {
	        sendErrorMessage(playerid, "Posiadasz ju¿ ³ódŸ.");
	    }
	}
	else
	{
	    sendErrorMessage(playerid, "Nie jesteœ przy stoczni.");
	}
	return 1;
}

//end
