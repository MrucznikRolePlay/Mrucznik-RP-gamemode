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
		new string[90];
		format(string, sizeof(string), "AdmCmd: %s dal %s %d mrucznik coinsow", GetNick(playerid), GetNick(giveplayerid), value);

		Log(ckLog, INFO, string);
		PremiumInfo[giveplayerid][pMC] = value;
		premium_saveMc(giveplayerid);

		_MruAdmin(playerid, sprintf("Da³eœ %d MC graczowi %s [ID: %d]", value, GetNick(giveplayerid, true), giveplayerid));
		if(giveplayerid != playerid) _MruAdmin(giveplayerid, sprintf("Dosta³eœ %d MC od Admina %s [ID: %d]", value, GetNick(playerid, true), playerid));

		return 1;

	}
	else return noAccessMessage(playerid);
}


//end