//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   addmc                                                   //
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
// Data utworzenia: 02.07.2019


//

//------------------<[ Implementacja: ]>-------------------
command_addmc_Impl(playerid, giveplayerid, value)
{
    if(IsAKox(playerid))
	{
		PremiumInfo[giveplayerid][pMC] += value;
		premium_saveMc(giveplayerid);

		Log(premiumLog, INFO, "Admin %s doda³ %s %dMC", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), value);
		_MruAdmin(playerid, sprintf("Doda³eœ %d MC graczowi %s [ID: %d]", value, GetNick(giveplayerid, true), giveplayerid));
		if(giveplayerid != playerid) _MruAdmin(giveplayerid, sprintf("Dosta³eœ %d dodatkowych MC od Admina %s [ID: %d]", value, GetNick(playerid, true), playerid));

		return 1;

	}
	else return noAccessMessage(playerid);
}

//end