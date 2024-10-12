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
command_setcarint_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
        new plo;
        if( sscanf(params, "d", plo))
        {
            sendTipMessage(playerid, "U¿yj /setcarint [carid]");
            return 1;
        }
        if (PlayerInfo[playerid][pAdmin] >= 1 || Uprawnienia(playerid, ACCESS_PANEL) || IsAScripter(playerid))
        {
            LinkVehicleToInterior(plo, GetPlayerInterior(playerid));

            _MruAdmin(playerid, sprintf("Ustawi³eœ interior auta %d na %d", plo, GetPlayerInterior(playerid)));

        }
        else
        {
            noAccessMessage(playerid);
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREY, "B³¹d!");
    }
    return 1;
}

//end
