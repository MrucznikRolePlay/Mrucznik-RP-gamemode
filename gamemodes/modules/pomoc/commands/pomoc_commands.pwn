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
#include "rybypomoc\rybypomoc.pwn"
#include "telefonpomoc\telefonpomoc.pwn"
#include "orgpomoc\orgpomoc.pwn"
#include "bizpomoc\bizpomoc.pwn"
#include "dompomoc\dompomoc.pwn"
#include "autopomoc\autopomoc.pwn"
#include "samppomoc\samppomoc.pwn"
#include "vopispomoc\vopispomoc.pwn"
#include "pracapomoc\pracapomoc.pwn"
#include "wynajempomoc\wynajempomoc.pwn"
#include "liderpomoc\liderpomoc.pwn"
#include "ircpomoc\ircpomoc.pwn"
#include "help\help.pwn"
#include "opispomoc\opispomoc.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_rybypomoc();
    command_telefonpomoc();
    command_orgpomoc();
    command_bizpomoc();
    command_dompomoc();
    command_autopomoc();
    command_samppomoc();
    command_vopispomoc();
    command_pracapomoc();
    command_wynajempomoc();
    command_liderpomoc();
    command_ircpomoc();
    command_help();
    command_opispomoc();
    
}