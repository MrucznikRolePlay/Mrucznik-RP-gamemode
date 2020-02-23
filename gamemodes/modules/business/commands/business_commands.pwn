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
#include "bizback\bizback.pwn"
#include "mbizbuy\mbizbuy.pwn"
#include "mbizcreate\mbizcreate.pwn"
#include "mbizedit\mbizedit.pwn"
#include "mbizinfo\mbizinfo.pwn"
#include "mbizmoney\mbizmoney.pwn"
#include "mbiznesy\mbiznesy.pwn"
#include "mbizpanel\mbizpanel.pwn"
#include "mgotobiz\mgotobiz.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_bizback();
    command_mbizbuy();
    command_mbizcreate();
    command_mbizedit();
    command_mbizinfo();
    command_mbizmoney();
    command_mbiznesy();
    command_mbizpanel();
    command_mgotobiz();
    
}