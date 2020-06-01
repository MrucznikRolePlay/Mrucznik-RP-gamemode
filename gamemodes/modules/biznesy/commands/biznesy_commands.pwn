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
#include "zabierzbiznes\zabierzbiznes.pwn"
#include "gotobiz\gotobiz.pwn"
#include "usunbiznes\usunbiznes.pwn"
#include "quitbusiness\quitbusiness.pwn"
#include "kupbiznes\kupbiznes.pwn"
#include "panelbiznesu\panelbiznesu.pwn"
#include "stworzbiznes\stworzbiznes.pwn"
#include "biz\biz.pwn"
#include "edytujbiznes\edytujbiznes.pwn"
#include "zlomujbiznes\zlomujbiznes.pwn"
#include "sprzedajbiznes\sprzedajbiznes.pwn"
#include "dajbiznes\dajbiznes.pwn"
#include "bizlock\bizlock.pwn"
#include "obiz\obiz.pwn"
#include "biznespomoc\biznespomoc.pwn"
#include "bpracownicy\bpracownicy.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_bizinfo();
    command_zabierzbiznes();
    command_gotobiz();
    command_usunbiznes();
    command_quitbusiness();
    command_kupbiznes();
    command_panelbiznesu();
    command_stworzbiznes();
    command_biz();
    command_edytujbiznes();
    command_zlomujbiznes();
    command_sprzedajbiznes();
    command_dajbiznes();
    command_bizlock();
    command_obiz();
    command_biznespomoc();
    command_bpracownicy();
    
}