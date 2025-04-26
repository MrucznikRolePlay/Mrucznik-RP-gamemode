//------------------------------------------<< Generated source >>-------------------------------------------//
//-----------------------------------------------[ Commands ]------------------------------------------------//
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
// Kod wygenerowany automatycznie narzêdziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN¥ NADPISANE PO WYWO£ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


#include <YSI\y_hooks>

//-------<[ include ]>-------
#include "businfo\cmd_businfo.pwn"
#include "busroute\cmd_busroute.pwn"
#include "busstop\cmd_busstop.pwn"
#include "kurs\cmd_kurs.pwn"
#include "trasa\cmd_trasa.pwn"
#include "zakoncztrase\cmd_zakoncztrase.pwn"
#include "zd\cmd_zd.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_businfo();
    command_busroute();
    command_busstop();
    command_kurs();
    command_trasa();
    command_zakoncztrase();
    command_zd();
    
}