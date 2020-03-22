//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                biznespomoc                                                //
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
// Autor: Mrucznik
// Data utworzenia: 20.08.2019


//

//------------------<[ Implementacja: ]>-------------------
command_biznespomoc_Impl(playerid)
{
	SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
	SendClientMessage(playerid, COLOR_WHITE,"*** BIZNES POMOC *** wpisz komende aby uzyskaæ wiêcej pomocy");
	SendClientMessage(playerid, COLOR_GRAD3,"*** BIZNES *** /bizinfo /wejdz /wyjdz /kupbiznes /sprzedajbiznes");
	SendClientMessage(playerid, COLOR_GRAD3, "*** BIZNES *** /bizlock /biz /obiz /bizpanel");
	SendClientMessage(playerid, COLOR_GRAD6,"*** INNE *** /telefonpomoc /dompomoc /wynajempomoc /pomoc /liderpomoc /rybypomoc /ircpomoc");
	return 1;
}

//end