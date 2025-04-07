//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 odpornosc                                                 //
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
// Autor: Sanda³
// Data utworzenia: 18.06.2020


//

//------------------<[ Implementacja: ]>-------------------
command_odpornosc_Impl(playerid)
{
    if(Odpornosc_PlayerBarToggle[playerid] == 0)
    {
        MruMessageGoodInfo(playerid, "Pasek odpornoœci w³¹czony.");
        ShowPlayerProgressBar(playerid, PlayerImmunityBar[playerid]);
        Odpornosc_PlayerBarToggle[playerid] = 1;
        Redis_SetInt(RedisClient, sprintf("player:%d:immunity-bar", PlayerInfo[playerid][pUID]), 1);
    }
    else
    {
        MruMessageBadInfo(playerid, "Pasek odpornoœci wy³¹czony.");
        HidePlayerProgressBar(playerid, PlayerImmunityBar[playerid]);
        Odpornosc_PlayerBarToggle[playerid] = 0;
        Redis_SetInt(RedisClient, sprintf("player:%d:immunity-bar", PlayerInfo[playerid][pUID]), 0);
    }
    return 1;
}

//end