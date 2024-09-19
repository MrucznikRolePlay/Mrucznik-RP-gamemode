//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 samppomoc                                                 //
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
// Data utworzenia: 19.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_samppomoc_Impl(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN, "______________________SAMP POMOC______________________");
    SendClientMessage(playerid, COLOR_WHITE, "*** Wpisz komendê, aby uzyskaæ wiêcej pomocy.");
    SendClientMessage(playerid, COLOR_WHITE, "** SAMP ** /pagesize /headmove /fpslimit /fontsize /ctd /nametagstatus");
    SendClientMessage(playerid, COLOR_WHITE, "** SAMP ** /save /rs /interior /timestamp /mem /dl /audiomsg /q");
    SendClientMessage(playerid, COLOR_WHITE, "*** INNE *** /autopomoc /bizpomoc /dompomoc /ircpomoc /liderpomoc /opispomoc /telefonpomoc");
    SendClientMessage(playerid, COLOR_WHITE, "*** INNE *** /orgpomoc /pracapomoc /vopispomoc /wynajempomoc");
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    return 1;
}

//end