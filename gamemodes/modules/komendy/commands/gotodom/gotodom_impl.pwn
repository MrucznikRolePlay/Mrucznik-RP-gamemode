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
command_gotodom_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
		if(IsAScripter(playerid) || PlayerInfo[playerid][pAdmin] >= 1 )
		{
		    new domid;
			if( sscanf(params, "d", domid))
			{
				sendTipMessage(playerid, "U¿yj /gotodom [domid]");
				return 1;
			}

			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, Dom[domid][hWej_X], Dom[domid][hWej_Y], Dom[domid][hWej_Z]);
			}
			else
			{
				SetPlayerPos(playerid, Dom[domid][hWej_X], Dom[domid][hWej_Y], Dom[domid][hWej_Z]);
			}
			_MruAdmin(playerid, "Zosta³eœ teleportowany");
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

//end
