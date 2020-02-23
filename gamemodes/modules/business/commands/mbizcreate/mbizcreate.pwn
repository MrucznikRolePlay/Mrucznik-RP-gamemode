//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 mbizcreate                                                //
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
#include "mbizcreate_impl.pwn"

//-------<[ initialize ]>-------
command_mbizcreate()
{
    new command = Command_GetID("mbizcreate");

    //aliases
    Command_AddAlt(command, "mbizstworz");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:mbizcreate(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda, która pozwala stworzyæ biznes");
        return 1;
    }
    //fetching params
    new bCost, bName[64];
    if(sscanf(params, "ds[64]", bCost, bName))
    {
        sendTipMessage(playerid, "U¿yj /mbizcreate [Koszt biznesu] [Nazwa biznesu [64z]] ");
        return 1;
    }
    
    //command body
    return command_mbizcreate_Impl(playerid, bCost, bName);
}