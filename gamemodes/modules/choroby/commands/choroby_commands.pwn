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
#include "getimmunity\getimmunity.pwn"
#include "ulecz\ulecz.pwn"
#include "zaraz\zaraz.pwn"
#include "odpornosc\odpornosc.pwn"
#include "kuracja\kuracja.pwn"
#include "diagnozuj\diagnozuj.pwn"
#include "zastrzyk\zastrzyk.pwn"
#include "setimmunity\setimmunity.pwn"
#include "aulecz\aulecz.pwn"
#include "uleczall\uleczall.pwn"
#include "maseczka\maseczka.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_getimmunity();
    command_ulecz();
    command_zaraz();
    command_odpornosc();
    command_kuracja();
    command_diagnozuj();
    command_zastrzyk();
    command_setimmunity();
    command_aulecz();
    command_uleczall();
    command_maseczka();
    
}