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
#include "autopomoc\cmd_autopomoc.pwn"
#include "bizpomoc\cmd_bizpomoc.pwn"
#include "dompomoc\cmd_dompomoc.pwn"
#include "help\cmd_help.pwn"
#include "ircpomoc\cmd_ircpomoc.pwn"
#include "liderpomoc\cmd_liderpomoc.pwn"
#include "opispomoc\cmd_opispomoc.pwn"
#include "orgpomoc\cmd_orgpomoc.pwn"
#include "pracapomoc\cmd_pracapomoc.pwn"
#include "rybypomoc\cmd_rybypomoc.pwn"
#include "samppomoc\cmd_samppomoc.pwn"
#include "telefonpomoc\cmd_telefonpomoc.pwn"
#include "vopispomoc\cmd_vopispomoc.pwn"
#include "wynajempomoc\cmd_wynajempomoc.pwn"


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