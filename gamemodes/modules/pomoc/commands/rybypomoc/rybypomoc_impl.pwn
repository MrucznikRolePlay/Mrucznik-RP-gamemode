//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 rybypomoc                                                 //
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
command_rybypomoc_Impl(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN, "______________________RYBY POMOC______________________");
    SendClientMessage(playerid, COLOR_WHITE, "*** Wpisz komendê, aby uzyskaæ wiêcej pomocy.");
    SendClientMessage(playerid, COLOR_WHITE, "** WÊDKOWANIE ** /wedkuj (próbujesz z³apaæ rybê) /ryby (pokazuje jakie ryby z³apa³emœ)");
    SendClientMessage(playerid, COLOR_WHITE, "** WÊDKOWANIE ** /wywalrybe (wywala ostatni¹ z³apan¹ rybê) /wywalryby (wywala wszystkie ryby)");
    SendClientMessage(playerid, COLOR_WHITE, "** WÊDKOWANIE ** /sprzedajrybe (sprzedaje wybran¹ rybê w sklepie 24/7)");
    SendClientMessage(playerid, COLOR_WHITE, "*** INNE *** /autopomoc /bizpomoc /dompomoc /ircpomoc /liderpomoc /opispomoc /telefonpomoc");
    SendClientMessage(playerid, COLOR_WHITE, "*** INNE *** /vopispomoc /wynajempomoc");
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    return 1;
}

//end