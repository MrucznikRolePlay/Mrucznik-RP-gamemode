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
#include "createobject\createobject.pwn"
#include "destroyobject\destroyobject.pwn"
#include "dnobiekt\dnobiekt.pwn"
#include "dvobiekt\dvobiekt.pwn"
#include "editobject\editobject.pwn"
#include "profiler\profiler.pwn"
#include "setvregistration\setvregistration.pwn"
#include "shotobject\shotobject.pwn"
#include "specshow\specshow.pwn"
#include "zmienwiek\zmienwiek.pwn"


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