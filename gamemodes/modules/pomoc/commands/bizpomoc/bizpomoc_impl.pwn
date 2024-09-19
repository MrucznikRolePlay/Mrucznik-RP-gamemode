//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  bizpomoc                                                 //
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
command_bizpomoc_Impl(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN, "_______________________BIZNES POMOC_______________________");
    SendClientMessage(playerid, COLOR_WHITE, "*** Wpisz komendê, aby uzyskaæ wiêcej pomocy.");
    SendClientMessage(playerid, COLOR_WHITE, "** BIZNES Los Santos ** /bizinfo /wejdz /wyjdz /kupbiznes /sprzedajbiznes");
    SendClientMessage(playerid, COLOR_WHITE, "** BIZNES Los Santos ** /bizlock /biz /obiz /bizpanel");
    SendClientMessage(playerid, COLOR_WHITE, "** BIZNES Vice City ** /orgbiz(orgbiznes)");
    SendClientMessage(playerid, COLOR_WHITE, "*** INNE *** /autopomoc /dompomoc /ircpomoc /liderpomoc /opispomoc /rybypomoc /telefonpomoc");
    SendClientMessage(playerid, COLOR_WHITE, "*** INNE *** /orgpomoc /pracapomoc /vopispomoc /wynajempomoc /samppomoc");
    SendClientMessage(playerid, COLOR_GREEN, "_______________________________________________________");
    return 1;
}

//end