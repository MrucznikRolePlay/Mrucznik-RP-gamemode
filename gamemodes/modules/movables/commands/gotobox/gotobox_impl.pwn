//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  gotobox                                                  //
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
// Data utworzenia: 22.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_gotobox_Impl(playerid, boxid)
{
    if(PlayerInfo[playerid][pAdmin] != 5000)
    {
        noAccessMessage(playerid);
        return 1;
    }

    if(boxid < 0 || boxid >= MAX_MOVABLES)
    {
        MruMessageFail(playerid, "ID obiektu musi byæ wiêksze od 0 i mniejsze od "#MAX_MOVABLES".");
        return 1;
    }

    if(!Boxes[boxid][box_used])
    {
        MruMessageFail(playerid, "Pod tym ID nie ma stworzonego obiektu.");
        return 1;
    }

    SetPlayerPos(playerid, Boxes[boxid][box_x], Boxes[boxid][box_y], Boxes[boxid][box_z]);
    MruMessageGoodInfoF(playerid, "Teleportowa³eœ siê do obiektu o ID %d.", boxid);
    return 1;
}

//end