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
#include "biz\cmd_biz.pwn"
#include "bizinfo\cmd_bizinfo.pwn"
#include "bizlock\cmd_bizlock.pwn"
#include "bpracownicy\cmd_bpracownicy.pwn"
#include "dajbiznes\cmd_dajbiznes.pwn"
#include "edytujbiznes\cmd_edytujbiznes.pwn"
#include "gotobiz\cmd_gotobiz.pwn"
#include "kupbiznes\cmd_kupbiznes.pwn"
#include "obiz\cmd_obiz.pwn"
#include "panelbiznesu\cmd_panelbiznesu.pwn"
#include "quitbusiness\cmd_quitbusiness.pwn"
#include "sprzedajbiznes\cmd_sprzedajbiznes.pwn"
#include "stworzbiznes\cmd_stworzbiznes.pwn"
#include "usunbiznes\cmd_usunbiznes.pwn"
#include "zabierzbiznes\cmd_zabierzbiznes.pwn"
#include "zlomujbiznes\cmd_zlomujbiznes.pwn"


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