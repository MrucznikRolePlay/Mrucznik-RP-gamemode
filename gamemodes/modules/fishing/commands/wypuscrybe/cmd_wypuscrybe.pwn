//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 wypuscrybe                                                //
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
#include "wypuscrybe_impl.pwn"

//-------<[ initialize ]>-------
command_wypuscrybe()
{
    new command = Command_GetID("wypuscrybe");

    //aliases
    Command_AddAlt(command, "wywalrybe");
    Command_AddAlt(command, "throwfish");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:wypuscrybe(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Wypuszczasz z³owion¹ rybê.");
        return 1;
    }
    //fetching params
    new fishid;
    if(sscanf(params, "d", fishid))
    {
        sendTipMessage(playerid, "U¿yj /wypuscrybe [id ryby] ");
        return 1;
    }
    
    //command body
    return command_wypuscrybe_Impl(playerid, fishid);
}