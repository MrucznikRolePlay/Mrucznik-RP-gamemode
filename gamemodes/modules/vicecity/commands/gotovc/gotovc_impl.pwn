//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   gotovc                                                  //
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
// Data utworzenia: 13.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_gotovc_Impl(playerid)
{
    if(PlayerInfo[playerid][pAdmin] < 1)
    {
        noAccessMessage(playerid);
        return 1;
    }

    // Set the player interior and virtual world
	SetPlayerInterior(playerid, 0);
    #if VICECITY_VWORLD <= -1 || VICECITY_VWORLD == 0
	   SetPlayerVirtualWorld(playerid, 0);
    #else
       SetPlayerVirtualWorld(playerid, VICECITY_VWORLD);
    #endif

	// Set player position and facing angle
    if (GetPlayerState(playerid) == 2)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        SetVehiclePos(vehicleid, -4016.4687, 1800.4810, 5.3443);
        SetVehicleZAngle(vehicleid, 90.0);
    }
    else
    {
        SetPlayerPos(playerid, -4016.4687, 1800.4810, 5.3443);
	    SetPlayerFacingAngle(playerid, 90.0);
    }

	SetCameraBehindPlayer(playerid);
	SendClientMessage(playerid, 0xFF0000FF, "* You teleported to Vice City!");
	GameTextForPlayer(playerid, "~b~~h~Vice City", 3000, 3);
    return 1;
}

//end