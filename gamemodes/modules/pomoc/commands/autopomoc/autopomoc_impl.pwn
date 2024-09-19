//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 autopomoc                                                 //
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
command_autopomoc_Impl(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN, "_______________________AUTO POMOC_______________________");
    SendClientMessage(playerid, COLOR_WHITE, "*** Wpisz komendê, aby uzyskaæ wiêcej pomocy.");
    SendClientMessage(playerid, COLOR_WHITE, "**AUTO ** /auto /autok /dr /kupauto /kupheli /kuplodz /lock /mojeauta /parkuj /spawnall");
    SendClientMessage(playerid, COLOR_WHITE, "**AUTO ** /sprzedajauto /wymiana /wywal /wywalklucze /zabierzkluczyki /zp");
    ShowHelpCommands(playerid, COLOR_WHITE, "/autopomoc");
    SendClientMessage(playerid, COLOR_GREEN, "_______________________________________________________");
    return 1;
}

//end