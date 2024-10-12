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
command_obrazenia_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
		new giveplayerid, param[24];
		if( sscanf(params, "s[24]k<fix>", param, giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /obrazenia o(otrzymane) z(zadane) [playerid/CzêœæNicku]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
				if(strcmp(param, "o", true) == 0 || strcmp(param, "otrzymane", true) == 0) ShowPlayerDamaged(giveplayerid, playerid);
				else if(strcmp(param, "z", true) == 0 || strcmp(param, "zadane", true) == 0) ShowPlayerDamage(giveplayerid, playerid);
				else sendErrorMessage(playerid, "Niepoprawny argument (otrzymane/zadane)");
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

//end
