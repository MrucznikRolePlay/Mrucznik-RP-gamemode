//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  togvopis                                                  //
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
// Autor: NikodemBanan
// Data utworzenia: 25.02.2024


//

//------------------<[ Implementacja: ]>-------------------
command_togvopis_Impl(playerid)
{
    areVehicleDescTurnedOn[playerid] = !areVehicleDescTurnedOn[playerid];

    foreach(new v : Vehicle)
    {
        if(Car3dTextDesc[v] == Text3D:INVALID_3DTEXT_ID)
        {
            continue;
        }

        if(areVehicleDescTurnedOn[playerid])
        {
            Streamer_AppendArrayData(STREAMER_TYPE_3D_TEXT_LABEL, Car3dTextDesc[v], E_STREAMER_PLAYER_ID, playerid);
        }
        else
        {
            Streamer_RemoveArrayData(STREAMER_TYPE_3D_TEXT_LABEL, Car3dTextDesc[v], E_STREAMER_PLAYER_ID, playerid);
        }
    }

    if(areVehicleDescTurnedOn[playerid])
    {
        MSGBOX_Show(playerid, "Opisy pojazdow ~g~wlaczone!", MSGBOX_ICON_TYPE_OK);
    }
    else
    {
        MSGBOX_Show(playerid, "Opisy pojazdow ~r~wylaczone!", MSGBOX_ICON_TYPE_ERROR);
    }

    Streamer_Update(playerid);

    return 1;
}

//end