//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     op                                                    //
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
// Autor: Mrucznik
// Data utworzenia: 11.06.2019


//

//------------------<[ Implementacja: ]>-------------------
command_op_Impl(playerid)
{
    if( !(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == 2 || GetPlayerState(playerid) == 3))
    {
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Tej komendy mo¿esz u¿yæ tylko bêd¹c w pojeŸdzie");
        return 1;
    }

    if(!IsABike(GetPlayerVehicleID(playerid)))
    {
        new nick[MAX_PLAYER_NAME];
        new string[256];
        GetPlayerName(playerid, nick, sizeof(nick));
        format(string, sizeof(string), "* %s odpina pasy", nick);
        ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
        pasy[playerid] = 0;
    }
    else
    {
        SendClientMessage(playerid, COLOR_LIGHTBLUE,"Nie mo¿esz odpi¹æ pasów!");
    }
    return 1;
}


//end