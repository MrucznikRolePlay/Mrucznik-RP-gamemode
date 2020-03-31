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
// Data utworzenia: 03.03.2020


//

//------------------<[ Implementacja: ]>-------------------
command_rybypomoc_Impl(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
	SendClientMessage(playerid, COLOR_WHITE,"*** RYBY POMOC *** wpisz komende aby uzyskaæ wiêcej pomocy");
	SendClientMessage(playerid, COLOR_GRAD3,"*** WEDKOWANIE *** /wedkuj (Próbujesz z³apaæ rybê)   /ryby (Pokazuje jakie ryby z³apa³eœ)");
	SendClientMessage(playerid, COLOR_GRAD3,"*** WEDKOWANIE *** /wywalrybe (Wywala ostatni¹ z³apan¹ rybe)   /wywalryby");
	SendClientMessage(playerid, COLOR_GRAD3,"*** WEDKOWANIE *** /wypuscrybe (Wypuszcza wybran¹ rybê)");
	SendClientMessage(playerid, COLOR_GRAD3,"*** WEDKOWANIE *** [NOWE] /sprzedajrybe (sprzedajesz wybran¹ rybê w 24/7)");
	SendClientMessage(playerid, COLOR_GRAD6,"*** INNE *** /telefonpomoc /dompomoc /wynajempomoc /bizpomoc /liderpomoc /pomoc /ircpomoc");
    return 1;
}

//end