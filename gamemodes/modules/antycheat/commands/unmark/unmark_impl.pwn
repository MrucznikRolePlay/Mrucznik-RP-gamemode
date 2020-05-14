//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   unmark                                                  //
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
// Data utworzenia: 12.05.2020


//

//------------------<[ Implementacja: ]>-------------------
command_unmark_Impl(playerid, giveplayerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        UnmarkPotentialCheater(giveplayerid);
        SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Usun¹³eœ gracza %s z listy potencjalnych cziterów", GetNickEx(giveplayerid)));
        Log(adminLog, INFO, "Admin %s usun¹³ gracza %s z listy potencjalnych cziterów.", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
    } 
    else noAccessMessage(playerid);
    return 1;
}

//end