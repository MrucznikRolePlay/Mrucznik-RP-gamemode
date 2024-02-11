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
#include "diagnozuj\diagnozuj.pwn"
#include "zaraz\zaraz.pwn"
#include "kuracja\kuracja.pwn"
#include "odpornosc\odpornosc.pwn"
#include "uleczall\uleczall.pwn"
#include "ulecz\ulecz.pwn"
#include "aulecz\aulecz.pwn"
#include "zastrzyk\zastrzyk.pwn"
#include "setimmunity\setimmunity.pwn"
#include "getimmunity\getimmunity.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_maseczka();
    command_diagnozuj();
    command_zaraz();
    command_kuracja();
    command_odpornosc();
    command_uleczall();
    command_ulecz();
    command_aulecz();
    command_zastrzyk();
    command_setimmunity();
    command_getimmunity();
    
}