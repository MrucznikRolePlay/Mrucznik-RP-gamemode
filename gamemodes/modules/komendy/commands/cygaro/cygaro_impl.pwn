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
command_cygaro_Impl(playerid, params[256])
{
    if(IsPlayerInRangeOfPoint(playerid, 3.5, 833.8511,-1391.2689,-17.6433))
	{
		if(kaska[playerid] < 1000)
		{
			sendErrorMessage(playerid, "Nie masz wystarczaj¹co gotówki!"); 
			return 1;
		}
		sendTipMessage(playerid, "Jesteœ VIP - otrzymujesz cygaro za 1000 dolców!"); 
		ZabierzKase(playerid, 1000); 
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
		Sejf_Add(FRAC_SN, 1000);
		Sejf_Save(FRAC_SN); 
		return 1;
	}
	if(PlayerInfo[playerid][pCygaro] >= 1)
    {
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
		PlayerInfo[playerid][pCygaro] -= 1;
    }
	else
	{
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Musisz kupiæ cygaro aby móc je paliæ, idŸ do dilera lub 24/7");
	}
	return 1;
}

//end
