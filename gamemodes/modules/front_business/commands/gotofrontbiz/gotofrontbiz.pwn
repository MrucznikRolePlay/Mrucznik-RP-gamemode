//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                gotofrontbiz                                               //
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
#include "gotofrontbiz_impl.pwn"

//-------<[ initialize ]>-------
command_gotofrontbiz()
{
    new command = Command_GetID("gotofrontbiz");

    //aliases
    Command_AddAlt(command, "gotofb");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:gotofrontbiz(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Teleportuje Ciê do biznesu-przykrywki.");
        return 1;
    }
    //fetching params
    new bizid, position;
    if(sscanf(params, "dd", bizid, position))
    {
        sendTipMessage(playerid, "U¿yj /gotofrontbiz [id biznesu] [id pozycji] ");
        return 1;
    }
    
    //command body
    return command_gotofrontbiz_Impl(playerid, bizid, position);
}