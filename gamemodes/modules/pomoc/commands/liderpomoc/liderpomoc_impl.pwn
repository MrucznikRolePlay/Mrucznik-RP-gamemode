//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 liderpomoc                                                //
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
command_liderpomoc_Impl(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN, "______________________LIDER POMOC______________________");
    SendClientMessage(playerid, COLOR_WHITE, "*** Wpisz komendê, aby uzyskaæ wiêcej pomocy.");
    SendClientMessage(playerid, COLOR_WHITE, "** FRAKCJA ** /awans /dajrange /degraduj /sejf /lidercar /liderranga /pracownicy /przyjmij /zwolnij");
    SendClientMessage(playerid, COLOR_WHITE, "** ORGANIZACJA ** /orgpanel /orgbiz /sejf /lidercar /liderranga /pracownicy");
    SendClientMessage(playerid, COLOR_WHITE, "*** INNE *** /autopomoc /bizpomoc /dompomoc /ircpomoc /opispomoc /rybypomoc /telefonpomoc");
    SendClientMessage(playerid, COLOR_WHITE, "*** INNE *** /orgpomoc /pracapomoc /vopispomoc /wynajempomoc /samppomoc");
    SendClientMessage(playerid, COLOR_GREEN, "_______________________________________________________");
    return 1;
}

//end