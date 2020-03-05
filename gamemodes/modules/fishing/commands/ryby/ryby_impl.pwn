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
    format(string, sizeof(string), "** (1) Ryba: %s.   Waga: %d.", Fishes[playerid][pFish1], Fishes[playerid][pWeight1]);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "** (2) Ryba: %s.   Waga: %d.", Fishes[playerid][pFish2], Fishes[playerid][pWeight2]);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "** (3) Ryba: %s.   Waga: %d.", Fishes[playerid][pFish3], Fishes[playerid][pWeight3]);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "** (4) Ryba: %s.   Waga: %d.", Fishes[playerid][pFish4], Fishes[playerid][pWeight4]);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "** (5) Ryba: %s.   Waga: %d.", Fishes[playerid][pFish5], Fishes[playerid][pWeight5]);
    SendClientMessage(playerid, COLOR_GREY, string);
    SendClientMessage(playerid, COLOR_WHITE, "|__________________________________________|");

    return 1;
}

//end