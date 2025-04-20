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
// Aktualizacja: 20.04.2025 by Sahari


//

//------------------<[ Implementacja: ]>-------------------
command_gotomark_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid) || Zaufany(playerid))
		{
			SetPlayerInterior(playerid,0);
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
			}
			else
			{
				SetPlayerPos(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
			}
			sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany!");
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

//end
