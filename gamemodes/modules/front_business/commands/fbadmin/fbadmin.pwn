//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  fbadmin                                                  //
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
#include "fbadmin_impl.pwn"

//-------<[ initialize ]>-------
command_fbadmin()
{
    new command = Command_GetID("fbadmin");

    //aliases
    

    //permissions
    Group_SetCommand(Group_GetID("global"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:fbadmin(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Administracja biznesami przykrywkami.");
        return 1;
    }
    //fetching params
    new bizId, action[32], param[256];
    if(sscanf(params, "ds[32]S()[256]", bizId, action, param))
    {
        sendTipMessage(playerid, "U¿yj /fbadmin [id biznesu] [opcja (takeover/give)] [parametry] ");
        return 1;
    }
    
    //command body
    return command_fbadmin_Impl(playerid, bizId, action, param);
}