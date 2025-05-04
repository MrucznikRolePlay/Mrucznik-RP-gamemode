//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  cziterzy                                                 //
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
command_cziterzy_Impl(playerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid) || IsAZaufanyGracz(playerid))
    {
        if(IsPotentialCheatersTxdVisible[playerid])
        {
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wy��czy�e� list� potencjalnych cziter�w.");
            HidePotentialCheatersTxd(playerid);
        }
        else
        {
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "W��czy�e� list� potencjalnych cziter�w.");
            ShowPotentialCheatersTxd(playerid);
        }
    }
    return 1;
}

//end