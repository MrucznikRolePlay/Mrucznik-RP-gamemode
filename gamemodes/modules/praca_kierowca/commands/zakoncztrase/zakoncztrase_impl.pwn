//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                zakoncztrase                                               //
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
// Data utworzenia: 06.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_zakoncztrase_Impl(playerid)
{
	if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10 || GetPlayerJob(playerid) == JOB_DRIVER)
	{
		if(IsPlayerConnected(playerid))
		{
			DisablePlayerCheckpoint(playerid);
			CP[playerid] = 0;
			PlayerInfo[playerid][pLinia55] = 0;
			PlayerInfo[playerid][pLinia72] = 0;
			PlayerInfo[playerid][pLinia82] = 0;
			PlayerInfo[playerid][pLinia96] = 0;
			PlayerInfo[playerid][pNatrasiejest] = 0;
			Przystanek(playerid, COLOR_YELLOW, "° Komunikacja miejska °");
			sendTipMessage(playerid, "Zakoñczy³eœ trasê i wygasi³eœ tablice");
			return 1;
		}
	}
	else
	{
	    sendErrorMessage(playerid, "Nie jesteœ kierowc¹ lub pracownikiem Korporacji Transportowej!");
	}
    return 1;
}

//end