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
command_cygaro_Impl(playerid)
{
    if(IsPlayerInRangeOfPoint(playerid, 3.5, 833.8511,-1391.2689,-17.6433))
	{
		if(kaska[playerid] < 1000)
		{
			sendErrorMessage(playerid, "Nie masz wystarczaj�co got�wki!"); 
			return 1;
		}
		sendTipMessage(playerid, "Jeste� VIP - otrzymujesz cygaro za 1000 dolc�w!"); 
		ZabierzKase(playerid, 1000); 
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
		GenerateFrontBusinessIncome(40, 1000);
		return 1;
	}
	if(PlayerInfo[playerid][pCygaro] >= 1)
    {
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
		PlayerInfo[playerid][pCygaro] -= 1;
    }
	else
	{
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Musisz kupi� cygaro aby m�c je pali�, id� do dilera lub 24/7");
	}
	return 1;
}

//end
