//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                wynajempomoc                                               //
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
// Data utworzenia: 17.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_wynajempomoc_Impl(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN, "____________________WYNAJEM POMOC____________________");
    SendClientMessage(playerid, COLOR_WHITE, "*** Wpisz komend�, aby uzyska� wi�cej pomocy.");
    SendClientMessage(playerid, COLOR_WHITE, "** WYNAJEM ** /wynajmij(rentroom) /niewynajmuj(unrent) /dom /wejd� /wyjdz");
    ShowHelpCommands(playerid, COLOR_WHITE, "/wynajempomoc");
    SendClientMessage(playerid, COLOR_GREEN, "_____________________________________________________");
    return 1;
}

//end