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
#include "bizinfo\bizinfo.pwn"
#include "biznespomoc\biznespomoc.pwn"
#include "quitbusiness\quitbusiness.pwn"
#include "dajbiznes\dajbiznes.pwn"
#include "stworzbiznes\stworzbiznes.pwn"
#include "kupbiznes\kupbiznes.pwn"
#include "sprzedajbiznes\sprzedajbiznes.pwn"
#include "bizlock\bizlock.pwn"
#include "edytujbiznes\edytujbiznes.pwn"
#include "bpracownicy\bpracownicy.pwn"
#include "obiz\obiz.pwn"
#include "usunbiznes\usunbiznes.pwn"
#include "zabierzbiznes\zabierzbiznes.pwn"
#include "gotobiz\gotobiz.pwn"
#include "biz\biz.pwn"
#include "zlomujbiznes\zlomujbiznes.pwn"
#include "panelbiznesu\panelbiznesu.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_bizinfo();
    command_biznespomoc();
    command_quitbusiness();
    command_dajbiznes();
    command_stworzbiznes();
    command_kupbiznes();
    command_sprzedajbiznes();
    command_bizlock();
    command_edytujbiznes();
    command_bpracownicy();
    command_obiz();
    command_usunbiznes();
    command_zabierzbiznes();
    command_gotobiz();
    command_biz();
    command_zlomujbiznes();
    command_panelbiznesu();
    
}