//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    kask                                                   //
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
command_kask_Impl(playerid)
{
    if( !(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == 2 || GetPlayerState(playerid) == 3))
    {
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Tej komendy mo¿esz u¿yæ tylko bêd¹c w pojeŸdzie");
        return 1;
    }
    
    if(IsABike(GetPlayerVehicleID(playerid)))
    {
        new nick[MAX_PLAYER_NAME];
        new string[256];
        GetPlayerName(playerid, nick, sizeof(nick));
        if(kask[playerid] == 1)
        {
            format(string, sizeof(string), "* %s œci¹ga kask z g³owy.", nick);
            ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
            RemovePlayerAttachedObject(playerid, 3);
            kask[playerid] = 0;
        }
        else if(kask[playerid] != 1)
        {
            format(string, sizeof(string), "* %s zak³ada kask na g³owê.", nick);
            ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
            SetPlayerAttachedObject(playerid,3 , 18645, 2, 0.07, 0.017, 0, 88, 75, 0);
            kask[playerid] = 1;
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_LIGHTBLUE,"Nie mo¿esz za³o¿yæ kasku!");
    }
    return 1;
}


//end