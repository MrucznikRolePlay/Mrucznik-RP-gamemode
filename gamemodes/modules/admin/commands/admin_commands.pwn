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
#include "createobject\cmd_createobject.pwn"
#include "destroyobject\cmd_destroyobject.pwn"
#include "dnobiekt\cmd_dnobiekt.pwn"
#include "dvobiekt\cmd_dvobiekt.pwn"
#include "editobject\cmd_editobject.pwn"
#include "profiler\cmd_profiler.pwn"
#include "setvregistration\cmd_setvregistration.pwn"
#include "shotobject\cmd_shotobject.pwn"
#include "specshow\cmd_specshow.pwn"
#include "zmienwiek\cmd_zmienwiek.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_createobject();
    command_destroyobject();
    command_dnobiekt();
    command_dvobiekt();
    command_editobject();
    command_profiler();
    command_setvregistration();
    command_shotobject();
    command_specshow();
    command_zmienwiek();
    
}