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
	SetPlayerPos(playerid, 5642.7227,-1217.4832,13.2865);
	SetPlayerFacingAngle(playerid, 180);
	SetCameraBehindPlayer(playerid);

	SendClientMessage(playerid, 0xFF0000FF, "* You teleported to Vice City!");
	GameTextForPlayer(playerid, "~b~~h~Vice City", 3000, 3);
    return 1;
}

//end