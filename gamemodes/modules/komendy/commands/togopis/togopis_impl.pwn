//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  togopis                                                  //
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
command_togopis_Impl(playerid)
{
    arePlayerDescTurnedOn[playerid] = !arePlayerDescTurnedOn[playerid];

    foreach(new p : Player)
    {
        if(arePlayerDescTurnedOn[playerid])
        {
            Streamer_AppendArrayData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerInfo[p][pDescLabel], E_STREAMER_PLAYER_ID, playerid);
        }
        else
        {
            Streamer_RemoveArrayData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerInfo[p][pDescLabel], E_STREAMER_PLAYER_ID, playerid);
        }
    }

    if(arePlayerDescTurnedOn[playerid])
    {
        MSGBOX_Show(playerid, "Opisy graczy ~g~wlaczone!", MSGBOX_ICON_TYPE_OK);
    }
    else
    {
        MSGBOX_Show(playerid, "Opisy graczy ~r~wylaczone!", MSGBOX_ICON_TYPE_ERROR);
    }

    Streamer_Update(playerid);

    return 1;
}

//end