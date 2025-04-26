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
#include "wynajempomoc\wynajempomoc.pwn"
#include "pracapomoc\pracapomoc.pwn"
#include "dompomoc\dompomoc.pwn"
#include "bizpomoc\bizpomoc.pwn"
#include "opispomoc\opispomoc.pwn"
#include "vopispomoc\vopispomoc.pwn"
#include "ircpomoc\ircpomoc.pwn"
#include "telefonpomoc\telefonpomoc.pwn"
#include "orgpomoc\orgpomoc.pwn"
#include "liderpomoc\liderpomoc.pwn"
#include "help\help.pwn"
#include "samppomoc\samppomoc.pwn"
#include "rybypomoc\rybypomoc.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_autopomoc();
    command_wynajempomoc();
    command_pracapomoc();
    command_dompomoc();
    command_bizpomoc();
    command_opispomoc();
    command_vopispomoc();
    command_ircpomoc();
    command_telefonpomoc();
    command_orgpomoc();
    command_liderpomoc();
    command_help();
    command_samppomoc();
    command_rybypomoc();
    
}