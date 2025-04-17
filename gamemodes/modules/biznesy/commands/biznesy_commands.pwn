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
#include "biz\biz.pwn"
#include "bizinfo\bizinfo.pwn"
#include "bizlock\bizlock.pwn"
#include "bpracownicy\bpracownicy.pwn"
#include "dajbiznes\dajbiznes.pwn"
#include "edytujbiznes\edytujbiznes.pwn"
#include "gotobiz\gotobiz.pwn"
#include "kupbiznes\kupbiznes.pwn"
#include "obiz\obiz.pwn"
#include "panelbiznesu\panelbiznesu.pwn"
#include "quitbusiness\quitbusiness.pwn"
#include "sprzedajbiznes\sprzedajbiznes.pwn"
#include "stworzbiznes\stworzbiznes.pwn"
#include "usunbiznes\usunbiznes.pwn"
#include "zabierzbiznes\zabierzbiznes.pwn"
#include "zlomujbiznes\zlomujbiznes.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_biz();
    command_bizinfo();
    command_bizlock();
    command_bpracownicy();
    command_dajbiznes();
    command_edytujbiznes();
    command_gotobiz();
    command_kupbiznes();
    command_obiz();
    command_panelbiznesu();
    command_quitbusiness();
    command_sprzedajbiznes();
    command_stworzbiznes();
    command_usunbiznes();
    command_zabierzbiznes();
    command_zlomujbiznes();
    
}