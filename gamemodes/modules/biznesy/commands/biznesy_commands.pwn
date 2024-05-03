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
#include "zabierzbiznes\zabierzbiznes.pwn"
#include "biz\biz.pwn"
#include "bpracownicy\bpracownicy.pwn"
#include "usunbiznes\usunbiznes.pwn"
#include "quitbusiness\quitbusiness.pwn"
#include "gotobiz\gotobiz.pwn"
#include "bizlock\bizlock.pwn"
#include "stworzbiznes\stworzbiznes.pwn"
#include "panelbiznesu\panelbiznesu.pwn"
#include "obiz\obiz.pwn"
#include "dajbiznes\dajbiznes.pwn"
#include "zlomujbiznes\zlomujbiznes.pwn"
#include "kupbiznes\kupbiznes.pwn"
#include "sprzedajbiznes\sprzedajbiznes.pwn"
#include "edytujbiznes\edytujbiznes.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_bizinfo();
    command_biznespomoc();
    command_zabierzbiznes();
    command_biz();
    command_bpracownicy();
    command_usunbiznes();
    command_quitbusiness();
    command_gotobiz();
    command_bizlock();
    command_stworzbiznes();
    command_panelbiznesu();
    command_obiz();
    command_dajbiznes();
    command_zlomujbiznes();
    command_kupbiznes();
    command_sprzedajbiznes();
    command_edytujbiznes();
    
}