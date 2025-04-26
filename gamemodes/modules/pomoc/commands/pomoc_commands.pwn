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
#include "autopomoc\autopomoc.pwn"
#include "bizpomoc\bizpomoc.pwn"
#include "dompomoc\dompomoc.pwn"
#include "help\help.pwn"
#include "ircpomoc\ircpomoc.pwn"
#include "liderpomoc\liderpomoc.pwn"
#include "opispomoc\opispomoc.pwn"
#include "orgpomoc\orgpomoc.pwn"
#include "pracapomoc\pracapomoc.pwn"
#include "rybypomoc\rybypomoc.pwn"
#include "samppomoc\samppomoc.pwn"
#include "telefonpomoc\telefonpomoc.pwn"
#include "vopispomoc\vopispomoc.pwn"
#include "wynajempomoc\wynajempomoc.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_autopomoc();
    command_bizpomoc();
    command_dompomoc();
    command_help();
    command_ircpomoc();
    command_liderpomoc();
    command_opispomoc();
    command_orgpomoc();
    command_pracapomoc();
    command_rybypomoc();
    command_samppomoc();
    command_telefonpomoc();
    command_vopispomoc();
    command_wynajempomoc();
    
}