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
	if(!IsAKox(playerid) && !IsAMCGiver(playerid)) 
	{
		return noAccessMessage(playerid);
	}

	if(IsAMCGiver(playerid)) 
	{
		new mc = GetAvaibleMC();
		if(value > mc) 
		{
			sendErrorMessage(playerid, sprintf("W bud¿ecie MC jest dostêpne tylko %dMC", mc));
			return 1;
		}

		TakeMCFromBudget(value);
	}

	PremiumInfo[giveplayerid][pMC] += value;
	MruMySQL_SaveMc(giveplayerid);

	Log(premiumLog, INFO, "Admin %s doda³ %s %dMC", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), value);
	_MruAdmin(playerid, sprintf("Doda³eœ %d MC graczowi %s [ID: %d]", value, GetNickEx(giveplayerid), giveplayerid));
	if(giveplayerid != playerid) _MruAdmin(giveplayerid, sprintf("Dosta³eœ %d dodatkowych MC od Admina %s [ID: %d]", value, GetNickEx(playerid), playerid));
	return 1;
}
//end