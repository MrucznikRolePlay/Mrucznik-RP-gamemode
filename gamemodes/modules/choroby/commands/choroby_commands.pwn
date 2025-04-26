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
// Kod wygenerowany automatycznie narz�dziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN� NADPISANE PO WYWO�ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


#include <YSI\y_hooks>

//-------<[ include ]>-------
#include "aulecz\aulecz.pwn"
#include "diagnozuj\diagnozuj.pwn"
#include "getimmunity\getimmunity.pwn"
#include "kuracja\kuracja.pwn"
#include "maseczka\maseczka.pwn"
#include "odpornosc\odpornosc.pwn"
#include "setimmunity\setimmunity.pwn"
#include "ulecz\ulecz.pwn"
#include "uleczall\uleczall.pwn"
#include "zaraz\zaraz.pwn"
#include "zastrzyk\zastrzyk.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_aulecz();
    command_diagnozuj();
    command_getimmunity();
    command_kuracja();
    command_maseczka();
    command_odpornosc();
    command_setimmunity();
    command_ulecz();
    command_uleczall();
    command_zaraz();
    command_zastrzyk();
    
}