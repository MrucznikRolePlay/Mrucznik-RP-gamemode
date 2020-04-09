//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   easter                                                  //
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
#include "easter_impl.pwn"

//-------<[ initialize ]>-------
command_easter()
{
    new command = Command_GetID("easter");

    //aliases
    Command_AddAlt(command, "easteregg");
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:easter(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "komenda do zarz¹dzania wielkanocnym eventem");
        return 1;
    }
    //fetching params
    new opcja[24], opcja2[24];
    if(sscanf(params, "s[24]S(none)[24]", opcja, opcja2))
    {
        sendTipMessage(playerid, "U¿yj /easter [wlacz, wylacz, setmc, setcash, stworz, usun, goto] [stworz -> typ (mc / cash), goto -> ID, setcash/setmc -> ilosc] ");
        return 1;
    }
    
    //command body
    return command_easter_Impl(playerid, opcja, opcja2);
}