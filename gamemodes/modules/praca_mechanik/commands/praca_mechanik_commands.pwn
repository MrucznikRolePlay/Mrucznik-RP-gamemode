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
#include "carcolors\cmd_carcolors.pwn"
#include "felga\cmd_felga.pwn"
#include "felgi\cmd_felgi.pwn"
#include "hydraulika\cmd_hydraulika.pwn"
#include "malunek\cmd_malunek.pwn"
#include "malunki\cmd_malunki.pwn"
#include "napraw\cmd_napraw.pwn"
#include "naprawpojazd\cmd_naprawpojazd.pwn"
#include "nitro\cmd_nitro.pwn"
#include "sprawdzneon\cmd_sprawdzneon.pwn"
#include "sprzedajzestaw\cmd_sprzedajzestaw.pwn"
#include "tankowanie\cmd_tankowanie.pwn"
#include "zderzaki\cmd_zderzaki.pwn"


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