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
    new Float:odpornosc = GetPlayerImmunity(playerid);
    new string[64];
    if(odpornosc < 1.0 && odpornosc > 0.5) SendClientMessage(playerid, COLOR_WHITE, "[==----------]");
    else if(odpornosc >= 1.0 && odpornosc < 5.0) SendClientMessage(playerid, COLOR_WHITE, "[====--------]");
    else if(odpornosc >= 5.0 && odpornosc < 10.0) SendClientMessage(playerid, COLOR_WHITE, "[======------]");
    else if(odpornosc >= 10.0 && odpornosc < 15.0) SendClientMessage(playerid, COLOR_WHITE, "[========----]");
    else if(odpornosc >= 15.0 && odpornosc < 20.0) SendClientMessage(playerid, COLOR_WHITE, "[==========--]");
    else if(odpornosc >= 20.0) SendClientMessage(playerid, COLOR_WHITE, "[============]");
    else SendClientMessage(playerid, COLOR_WHITE, "[------------]");
    return 1;
}

//end