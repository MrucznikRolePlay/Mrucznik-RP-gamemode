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
#include "naprawpojazd\naprawpojazd.pwn"
#include "nitro\nitro.pwn"
#include "sprawdzneon\sprawdzneon.pwn"
#include "malunek\malunek.pwn"
#include "malunki\malunki.pwn"
#include "sprzedajzestaw\sprzedajzestaw.pwn"
#include "tankowanie\tankowanie.pwn"
#include "hydraulika\hydraulika.pwn"
#include "napraw\napraw.pwn"
#include "carcolors\carcolors.pwn"
#include "zderzaki\zderzaki.pwn"
#include "felgi\felgi.pwn"
#include "felga\felga.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_naprawpojazd();
    command_nitro();
    command_sprawdzneon();
    command_malunek();
    command_malunki();
    command_sprzedajzestaw();
    command_tankowanie();
    command_hydraulika();
    command_napraw();
    command_carcolors();
    command_zderzaki();
    command_felgi();
    command_felga();
    
}