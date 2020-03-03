//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  gotowane                                                 //
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
command_gotowane_Impl(playerid)
{
	new string[128];
    SendClientMessage(playerid, COLOR_WHITE, "|__________________ Gotowanie __________________|");
    format(string, sizeof(string), "** (1) Potrawa: %s.   Waga: %d.", Cooking[playerid][pCook][0], Cooking[playerid][pCWeight1]);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "** (2) Potrawa: %s.   Waga: %d.", Cooking[playerid][pCook][1], Cooking[playerid][pCWeight2]);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "** (3) Potrawa: %s.   Waga: %d.", Cooking[playerid][pCook][2], Cooking[playerid][pCWeight3]);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "** (4) Potrawa: %s.   Waga: %d.", Cooking[playerid][pCook][3], Cooking[playerid][pCWeight4]);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "** (5) Potrawa: %s.   Waga: %d.", Cooking[playerid][pCook][4], Cooking[playerid][pCWeight5]);
    SendClientMessage(playerid, COLOR_GREY, string);
    SendClientMessage(playerid, COLOR_WHITE, "|____________________________________________|");
    return 1;
}

//end