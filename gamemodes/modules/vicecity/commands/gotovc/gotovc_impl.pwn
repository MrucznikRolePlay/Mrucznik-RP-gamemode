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
	SetPlayerPos(playerid, 5183.5313,-1399.5190,5.3443);
	SetPlayerFacingAngle(playerid, 90);
	SetCameraBehindPlayer(playerid);

	SendClientMessage(playerid, 0xFF0000FF, "* You teleported to Vice City!");
	GameTextForPlayer(playerid, "~b~~h~Vice City", 3000, 3);
    return 1;
}

//end