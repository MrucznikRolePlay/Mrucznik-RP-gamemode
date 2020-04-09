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
#include "quitbusiness\quitbusiness.pwn"
#include "bizlock\bizlock.pwn"
#include "biz\biz.pwn"
#include "sprzedajbiznes\sprzedajbiznes.pwn"
#include "usunbiznes\usunbiznes.pwn"
#include "dajbiznes\dajbiznes.pwn"
#include "panelbiznesu\panelbiznesu.pwn"
#include "zlomujbiznes\zlomujbiznes.pwn"
#include "kupbiznes\kupbiznes.pwn"
#include "obiz\obiz.pwn"
#include "edytujbiznes\edytujbiznes.pwn"
#include "biznespomoc\biznespomoc.pwn"
#include "bizinfo\bizinfo.pwn"
#include "bpracownicy\bpracownicy.pwn"
#include "gotobiz\gotobiz.pwn"
#include "zabierzbiznes\zabierzbiznes.pwn"
#include "stworzbiznes\stworzbiznes.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_quitbusiness();
    command_bizlock();
    command_biz();
    command_sprzedajbiznes();
    command_usunbiznes();
    command_dajbiznes();
    command_panelbiznesu();
    command_zlomujbiznes();
    command_kupbiznes();
    command_obiz();
    command_edytujbiznes();
    command_biznespomoc();
    command_bizinfo();
    command_bpracownicy();
    command_gotobiz();
    command_zabierzbiznes();
    command_stworzbiznes();
    
}