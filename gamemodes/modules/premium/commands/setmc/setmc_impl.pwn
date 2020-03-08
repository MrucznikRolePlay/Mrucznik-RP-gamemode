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
		MruMySQL_SaveMc(giveplayerid);

		Log(premiumLog, INFO, "Admin %s da³ %s %dMC, poprzedni stan: %dMC", 
			GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), value, PremiumInfo[giveplayerid][pMC]-value
		);
		_MruAdmin(playerid, sprintf("Da³eœ %d MC graczowi %s [ID: %d]", value, GetNickEx(giveplayerid), giveplayerid));
		if(giveplayerid != playerid) _MruAdmin(giveplayerid, sprintf("Dosta³eœ %d MC od Admina %s [ID: %d]", value, GetNickEx(playerid), playerid));

		return 1;

	}
	else return noAccessMessage(playerid);
}


//end