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
#include "aulecz\cmd_aulecz.pwn"
#include "diagnozuj\cmd_diagnozuj.pwn"
#include "getimmunity\cmd_getimmunity.pwn"
#include "kuracja\cmd_kuracja.pwn"
#include "maseczka\cmd_maseczka.pwn"
#include "odpornosc\cmd_odpornosc.pwn"
#include "setimmunity\cmd_setimmunity.pwn"
#include "ulecz\cmd_ulecz.pwn"
#include "uleczall\cmd_uleczall.pwn"
#include "zaraz\cmd_zaraz.pwn"
#include "zastrzyk\cmd_zastrzyk.pwn"


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