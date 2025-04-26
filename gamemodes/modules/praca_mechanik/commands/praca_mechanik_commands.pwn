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
#include "sprawdzneon\sprawdzneon.pwn"
#include "nitro\nitro.pwn"
#include "zderzaki\zderzaki.pwn"
#include "tankowanie\tankowanie.pwn"
#include "napraw\napraw.pwn"
#include "malunki\malunki.pwn"
#include "naprawpojazd\naprawpojazd.pwn"
#include "felga\felga.pwn"
#include "felgi\felgi.pwn"
#include "carcolors\carcolors.pwn"
#include "sprzedajzestaw\sprzedajzestaw.pwn"
#include "hydraulika\hydraulika.pwn"
#include "malunek\malunek.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_sprawdzneon();
    command_nitro();
    command_zderzaki();
    command_tankowanie();
    command_napraw();
    command_malunki();
    command_naprawpojazd();
    command_felga();
    command_felgi();
    command_carcolors();
    command_sprzedajzestaw();
    command_hydraulika();
    command_malunek();
    
}