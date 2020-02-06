//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  mbizedit                                                 //
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
#include "mbizedit_impl.pwn"

//-------<[ initialize ]>-------
command_mbizedit()
{
    new command = Command_GetID("mbizedit");

    //aliases
    Command_AddAlt(command, "bizedit");
    Command_AddAlt(command, "edytujbiznes");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:mbizedit(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Pozwala zarz¹dzaæ biznesem");
        return 1;
    }
    //fetching params
    new bIDE;
    if(sscanf(params, "d", bIDE))
    {
        sendTipMessage(playerid, "U¿yj /mbizedit [Numer tID biznesu] ");
        return 1;
    }
    
    //command body
    return command_mbizedit_Impl(playerid, bIDE);
}