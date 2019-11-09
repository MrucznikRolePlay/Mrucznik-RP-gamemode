//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  specshow                                                 //
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
#include "specshow_impl.pwn"

//-------<[ initialize ]>-------
command_specshow()
{
    new command = Command_GetID("specshow");

    //aliases
    Command_AddAlt(command, "specshow");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:specshow(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda, która pozwala spojrzeæ kogo podgl¹da dany administrator.");
        return 1;
    }
    //fetching params
    new valueSpec;
    if(sscanf(params, "d", valueSpec))
    {
        sendTipMessage(playerid, "U¿yj /specshow [ID] ");
        return 1;
    }
    
    //command body
    return command_specshow_Impl(playerid, valueSpec);
}