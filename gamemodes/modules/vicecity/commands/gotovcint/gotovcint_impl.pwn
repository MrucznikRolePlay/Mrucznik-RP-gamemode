//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 gotovcint                                                 //
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
// Data utworzenia: 18.08.2024


//

//------------------<[ Implementacja: ]>-------------------
command_gotovcint_Impl(playerid, intnum, inout)
{
    if(PlayerInfo[playerid][pAdmin] < 1)
    {
        noAccessMessage(playerid);
        return 1;
    }

    new maxnum = sizeof(VC_interiors) - 1;
    if(intnum < 0 || intnum > maxnum)
    {
        MruMessageFailF(playerid, "Numery interioru od 0 do %d", maxnum);
        return 1;
    }

    if(inout != 0 && inout != 1)
    {
        MruMessageFail(playerid, "Drugi argument przyjmuje tylko warianty: 0 - Wejœcie, 1 - Wyjœcie");
        return 1;
    }

	// Set player position 
    if(inout) 
    {
	    SetPlayerPos(playerid, VC_interiors[intnum][enexX1], VC_interiors[intnum][enexY1], VC_interiors[intnum][enexZ1]);
        SetPlayerInterior(playerid, VC_interiors[intnum][enexInt1]);
    } 
    else 
    {
	    SetPlayerPos(playerid, VC_interiors[intnum][enexX2], VC_interiors[intnum][enexY2], VC_interiors[intnum][enexZ2]);
        SetPlayerInterior(playerid, VC_interiors[intnum][enexInt2]);
    }
    #if VICECITY_VWORLD <= -1 || VICECITY_VWORLD == 0
	   SetPlayerVirtualWorld(playerid, 0);
    #else
       SetPlayerVirtualWorld(playerid, VICECITY_VWORLD);
    #endif
	SetCameraBehindPlayer(playerid);

    MruMessageGoodInfoF(playerid, "Teleportowa³eœ siê do interioru nr %d, wariant: %d", intnum, inout);
    return 1;
}

//end