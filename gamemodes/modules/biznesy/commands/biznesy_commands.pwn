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
#include "panelbiznesu\panelbiznesu.pwn"
#include "quitbusiness\quitbusiness.pwn"
#include "zabierzbiznes\zabierzbiznes.pwn"
#include "gotobiz\gotobiz.pwn"
#include "kupbiznes\kupbiznes.pwn"
#include "usunbiznes\usunbiznes.pwn"
#include "zlomujbiznes\zlomujbiznes.pwn"
#include "biznespomoc\biznespomoc.pwn"
#include "bizlock\bizlock.pwn"
#include "sprzedajbiznes\sprzedajbiznes.pwn"
#include "bpracownicy\bpracownicy.pwn"
#include "obiz\obiz.pwn"
#include "bizinfo\bizinfo.pwn"
#include "dajbiznes\dajbiznes.pwn"
#include "biz\biz.pwn"
#include "edytujbiznes\edytujbiznes.pwn"
#include "stworzbiznes\stworzbiznes.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_panelbiznesu();
    command_quitbusiness();
    command_zabierzbiznes();
    command_gotobiz();
    command_kupbiznes();
    command_usunbiznes();
    command_zlomujbiznes();
    command_biznespomoc();
    command_bizlock();
    command_sprzedajbiznes();
    command_bpracownicy();
    command_obiz();
    command_bizinfo();
    command_dajbiznes();
    command_biz();
    command_edytujbiznes();
    command_stworzbiznes();
    
}