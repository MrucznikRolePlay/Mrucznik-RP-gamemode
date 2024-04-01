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
#include "tankowanie\tankowanie.pwn"
#include "nos\nos.pwn"
#include "zderzaki\zderzaki.pwn"
#include "napraw\napraw.pwn"
#include "malunek\malunek.pwn"
#include "carcolors\carcolors.pwn"
#include "felgi\felgi.pwn"
#include "sprzedajzestaw\sprzedajzestaw.pwn"
#include "sprawdzneon\sprawdzneon.pwn"
#include "hydraulika\hydraulika.pwn"
#include "naprawpojazd\naprawpojazd.pwn"
#include "felga\felga.pwn"
#include "malunki\malunki.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_tankowanie();
    command_nos();
    command_zderzaki();
    command_napraw();
    command_malunek();
    command_carcolors();
    command_felgi();
    command_sprzedajzestaw();
    command_sprawdzneon();
    command_hydraulika();
    command_naprawpojazd();
    command_felga();
    command_malunki();
    
}