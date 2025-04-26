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
#include "edytujbiznes\edytujbiznes.pwn"
#include "quitbusiness\quitbusiness.pwn"
#include "bpracownicy\bpracownicy.pwn"
#include "gotobiz\gotobiz.pwn"
#include "bizlock\bizlock.pwn"
#include "panelbiznesu\panelbiznesu.pwn"
#include "stworzbiznes\stworzbiznes.pwn"
#include "usunbiznes\usunbiznes.pwn"
#include "zlomujbiznes\zlomujbiznes.pwn"
#include "zabierzbiznes\zabierzbiznes.pwn"
#include "obiz\obiz.pwn"
#include "dajbiznes\dajbiznes.pwn"
#include "bizinfo\bizinfo.pwn"
#include "sprzedajbiznes\sprzedajbiznes.pwn"
#include "kupbiznes\kupbiznes.pwn"
#include "biz\biz.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_edytujbiznes();
    command_quitbusiness();
    command_bpracownicy();
    command_gotobiz();
    command_bizlock();
    command_panelbiznesu();
    command_stworzbiznes();
    command_usunbiznes();
    command_zlomujbiznes();
    command_zabierzbiznes();
    command_obiz();
    command_dajbiznes();
    command_bizinfo();
    command_sprzedajbiznes();
    command_kupbiznes();
    command_biz();
    
}