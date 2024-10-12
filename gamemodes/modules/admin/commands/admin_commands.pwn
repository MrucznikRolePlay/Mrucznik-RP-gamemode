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
#include "profiler\profiler.pwn"
#include "setvregistration\setvregistration.pwn"
#include "specshow\specshow.pwn"
#include "shotobject\shotobject.pwn"
#include "dvobiekt\dvobiekt.pwn"
#include "zmienwiek\zmienwiek.pwn"
#include "editobject\editobject.pwn"
#include "dnobiekt\dnobiekt.pwn"
#include "destroyobject\destroyobject.pwn"
#include "createobject\createobject.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_profiler();
    command_setvregistration();
    command_specshow();
    command_shotobject();
    command_dvobiekt();
    command_zmienwiek();
    command_editobject();
    command_dnobiekt();
    command_destroyobject();
    command_createobject();
    
}