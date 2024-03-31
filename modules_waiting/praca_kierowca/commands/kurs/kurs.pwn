//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                    kurs                                                   //
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
#include "kurs_impl.pwn"

//-------<[ initialize ]>-------
command_kurs()
{
    new command = Command_GetID("kurs");

    //aliases
    Command_AddAlt(command, "fare");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:kurs(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Ustaw stawkê za kilometr na swoim taksometrze.");
        return 1;
    }
    //fetching params
    new cena;
    if(sscanf(params, "d", cena))
    {
        sendTipMessage(playerid, "U¿yj /kurs [cena] ");
        return 1;
    }
    
    //command body
    return command_kurs_Impl(playerid, cena);
}