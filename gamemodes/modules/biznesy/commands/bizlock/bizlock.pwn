//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  bizlock                                                  //
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


//-------<[ include ]>-------
#include "bizlock_impl.pwn"

//-------<[ initialize ]>-------
command_bizlock()
{
    new command = Command_GetID("bizlock");

    //aliases
    Command_AddAlt(command, "zamknijbiznes");
    Command_AddAlt(command, "otworzbiznes");
    Command_AddAlt(command, "businesslock");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:bizlock(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Pozwala zamkn¹æ b¹dŸ otworzyæ twój biznes. Mo¿e j¹ u¿yæ zarówno cz³onek jak i w³asciciel biznesu.");
        return 1;
    }
    
    
    //command body
    return command_bizlock_Impl(playerid);
}