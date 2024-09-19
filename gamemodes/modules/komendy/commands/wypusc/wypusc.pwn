//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   wypusc                                                  //
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
#include "wypusc_impl.pwn"

//-------<[ initialize ]>-------
command_wypusc()
{
    new command = Command_GetID("wypusc");

    //aliases
    Command_AddAlt(command, "free");
    Command_AddAlt(command, "uwolnij");
    

    //permissions
    Group_SetCommand(Group_GetID("global"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:wypusc(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "");
        return 1;
    }
    //fetching params
    new param[256];
    if(sscanf(params, "S()[256]", param))
    {
        sendTipMessage(playerid, "U¿yj /wypusc [] ");
        return 1;
    }
    
    //command body
    return command_wypusc_Impl(playerid, param);
}