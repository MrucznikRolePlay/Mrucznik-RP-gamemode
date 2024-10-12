//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    help                                                   //
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
command_help_Impl(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN, "________________________POMOC_______________________________");
    SendClientMessage(playerid, COLOR_WHITE, " *** KONTO *** /czas /stats /skill /nextlevel /ulepszenia /resetulepszen(100k) /personalizuj /zmienspawn /kp(premium)");
    SendClientMessage(playerid, COLOR_WHITE, " *** PREMIUM *** /dodatki /zdejmij /skiny /premiumskin /kp");
    SendClientMessage(playerid, COLOR_WHITE, " *** CMD *** /id /plac /datek /upusc /wezwij /pobij /lotto /kup /licencje /pl(pokazlicencje) /opis /vopis /ss(screenshot)");
    SendClientMessage(playerid, COLOR_WHITE, " *** CMD *** /akceptuj /anuluj /zaznacz /apteczka /kanister /kontrakt /muzyka /naprawpojazd /pancerz /pij /tankuj /ugotuj");
    SendClientMessage(playerid, COLOR_WHITE, " *** CMD *** /orgs(organizacje /anim(animacje) /stopanim /wb(wyrzucbronie) /wywalmaterialy /wywaldragi /wyœcigi");
    SendClientMessage(playerid, COLOR_WHITE, " *** BANK *** /stan /wplac /wyplac /bank /przelew /kb(kontobankowe)");
    SendClientMessage(playerid, COLOR_WHITE, " *** CHAT *** (/w)iadomosc (/cb)radio (/k)rzyk (/s)zept (/og)loszenie (/l)ocal (/b) (/n)ewbie (/o)oc /me /do /spróbuj");
    SendClientMessage(playerid, COLOR_WHITE, " *** BLOKADY *** /togooc /togdepo /togfam /togw /togtel /toglicznik /tognewbie /togadmin /togopis /togvopis");
    ShowHelpCommands(playerid, COLOR_WHITE, "/pomoc");
    SendClientMessage(playerid, COLOR_WHITE, " *** INNE *** Wsparcie i zg³oszenia graczy: /zapytaj /report");
    SendClientMessage(playerid, COLOR_GREEN, "_______________________________________________________");
    return 1;
}

//end