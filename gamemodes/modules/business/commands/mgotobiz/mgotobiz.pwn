//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  mgotobiz                                                 //
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
#include "mgotobiz_impl.pwn"

//-------<[ initialize ]>-------
command_mgotobiz()
{
    new command = Command_GetID("mgotobiz");

    //aliases
    Command_AddAlt(command, "gotobiz");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:mgotobiz(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda, która pozwala teleportowaæ siê do biznesu");
        return 1;
    }
    //fetching params
    new bIDE;
    if(sscanf(params, "d", bIDE))
    {
        sendTipMessage(playerid, "U¿yj /mgotobiz [ID biznesu] ");
        return 1;
    }
    
    //command body
    return command_mgotobiz_Impl(playerid, bIDE);
}