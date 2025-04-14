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
#include "carcolors\carcolors.pwn"
#include "felga\felga.pwn"
#include "felgi\felgi.pwn"
#include "hydraulika\hydraulika.pwn"
#include "malunek\malunek.pwn"
#include "malunki\malunki.pwn"
#include "napraw\napraw.pwn"
#include "naprawpojazd\naprawpojazd.pwn"
#include "nitro\nitro.pwn"
#include "sprawdzneon\sprawdzneon.pwn"
#include "sprzedajzestaw\sprzedajzestaw.pwn"
#include "tankowanie\tankowanie.pwn"
#include "zderzaki\zderzaki.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_carcolors();
    command_felga();
    command_felgi();
    command_hydraulika();
    command_malunek();
    command_malunki();
    command_napraw();
    command_naprawpojazd();
    command_nitro();
    command_sprawdzneon();
    command_sprzedajzestaw();
    command_tankowanie();
    command_zderzaki();
    
}