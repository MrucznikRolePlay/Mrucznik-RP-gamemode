//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   setmc                                                   //
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
command_setmc_Impl(playerid, giveplayerid, value)
{
    if(IsAKox(playerid))
	{
		PremiumInfo[giveplayerid][pMC] = value;
		premium_saveMc(giveplayerid);

		Log(premiumLog, INFO, "Admin %s da³ %s %dMC", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), value);
		_MruAdmin(playerid, sprintf("Da³eœ %d MC graczowi %s [ID: %d]", value, GetNick(giveplayerid, true), giveplayerid));
		if(giveplayerid != playerid) _MruAdmin(giveplayerid, sprintf("Dosta³eœ %d MC od Admina %s [ID: %d]", value, GetNick(playerid, true), playerid));

		return 1;

	}
	else return noAccessMessage(playerid);
}


//end