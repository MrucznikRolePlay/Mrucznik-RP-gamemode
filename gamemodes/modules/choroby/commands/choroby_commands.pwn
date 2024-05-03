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
#include "maseczka\maseczka.pwn"
#include "odpornosc\odpornosc.pwn"
#include "kuracja\kuracja.pwn"
#include "uleczall\uleczall.pwn"
#include "zaraz\zaraz.pwn"
#include "ulecz\ulecz.pwn"
#include "getimmunity\getimmunity.pwn"
#include "aulecz\aulecz.pwn"
#include "setimmunity\setimmunity.pwn"
#include "diagnozuj\diagnozuj.pwn"
#include "zastrzyk\zastrzyk.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_maseczka();
    command_odpornosc();
    command_kuracja();
    command_uleczall();
    command_zaraz();
    command_ulecz();
    command_getimmunity();
    command_aulecz();
    command_setimmunity();
    command_diagnozuj();
    command_zastrzyk();
    
}