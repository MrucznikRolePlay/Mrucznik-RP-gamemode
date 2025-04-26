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
#include "setvregistration\setvregistration.pwn"
#include "dvobiekt\dvobiekt.pwn"
#include "zmienwiek\zmienwiek.pwn"
#include "destroyobject\destroyobject.pwn"
#include "shotobject\shotobject.pwn"
#include "editobject\editobject.pwn"
#include "profiler\profiler.pwn"
#include "specshow\specshow.pwn"
#include "dnobiekt\dnobiekt.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_createobject();
    command_setvregistration();
    command_dvobiekt();
    command_zmienwiek();
    command_destroyobject();
    command_shotobject();
    command_editobject();
    command_profiler();
    command_specshow();
    command_dnobiekt();
    
}