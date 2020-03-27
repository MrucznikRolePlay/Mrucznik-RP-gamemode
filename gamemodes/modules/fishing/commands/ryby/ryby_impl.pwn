//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    ryby                                                   //
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
// Data utworzenia: 03.03.2020


//

//------------------<[ Implementacja: ]>-------------------
command_ryby_Impl(playerid)
{

	new string[128];

    SendClientMessage(playerid, COLOR_WHITE, "|__________________ Ryby __________________|");
    format(string, sizeof(string), "** (1) Ryba: %s.   Waga: %d.", PlayerFishes[playerid][pFish1], PlayerFishes[playerid][pWeight1]);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "** (2) Ryba: %s.   Waga: %d.", PlayerFishes[playerid][pFish2], PlayerFishes[playerid][pWeight2]);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "** (3) Ryba: %s.   Waga: %d.", PlayerFishes[playerid][pFish3], PlayerFishes[playerid][pWeight3]);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "** (4) Ryba: %s.   Waga: %d.", PlayerFishes[playerid][pFish4], PlayerFishes[playerid][pWeight4]);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "** (5) Ryba: %s.   Waga: %d.", PlayerFishes[playerid][pFish5], PlayerFishes[playerid][pWeight5]);
    SendClientMessage(playerid, COLOR_GREY, string);
    SendClientMessage(playerid, COLOR_WHITE, "|__________________________________________|");

    return 1;
}

//end