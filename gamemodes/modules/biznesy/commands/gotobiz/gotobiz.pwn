//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  gotobiz                                                  //
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
#include "gotobiz_impl.pwn"

//-------<[ initialize ]>-------
command_gotobiz()
{
    

    //aliases
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:gotobiz(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda, która teleportuje nas do biznesu.");
        return 1;
    }
    //fetching params
    new businessID;
    if(sscanf(params, "d", businessID))
    {
        sendTipMessage(playerid, "U¿yj /gotobiz [ID_BIZNESU] ");
        return 1;
    }
    
    //command body
    return command_gotobiz_Impl(playerid, businessID);
}