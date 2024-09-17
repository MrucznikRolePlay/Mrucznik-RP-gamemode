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
#include "bizpomoc\bizpomoc.pwn"
#include "dompomoc\dompomoc.pwn"
#include "autopomoc\autopomoc.pwn"
#include "vopispomoc\vopispomoc.pwn"
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
    command_bizpomoc();
    command_dompomoc();
    command_autopomoc();
    command_vopispomoc();
    command_wynajempomoc();
    command_liderpomoc();
    command_ircpomoc();
    command_help();
    command_opispomoc();
    
}