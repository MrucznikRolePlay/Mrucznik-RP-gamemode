//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   dajkp                                                   //
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
// Autor: Mrucznik
// Data utworzenia: 09.06.2019


//

//------------------<[ Implementacja: ]>-------------------
command_dajkp_Impl(playerid, giveplayerid, time)
{
    if(IsAKox(playerid))
	{
		if(time == 0)
		{
			DajKP(giveplayerid, 0, true);
		}
		else
		{
			DajKP(giveplayerid, gettime()+time, true);
		}

		Log(premiumLog, INFO, "Admin %s da³ %s konto premium na %d sekund", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), time);
		_MruAdmin(playerid, sprintf("Da³eœ KP graczowi %s [ID: %d] na czas %d.", GetNick(giveplayerid, true), giveplayerid, time));
		if(giveplayerid != playerid) _MruAdmin(giveplayerid, sprintf("Dosta³eœ KP od Admina %s [ID: %d]", GetNick(playerid, true), playerid));
		return 1;
	}
	else return noAccessMessage(playerid);
}


//end