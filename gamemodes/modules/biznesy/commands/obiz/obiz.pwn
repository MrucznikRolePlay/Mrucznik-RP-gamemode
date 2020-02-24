//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                    obiz                                                   //
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
#include "obiz_impl.pwn"

//-------<[ initialize ]>-------
command_obiz()
{
    new command = Command_GetID("obiz");

    //aliases
    Command_AddAlt(command, "ogloszeniebiznesowe");
    Command_AddAlt(command, "ogloszeniebiz");
    Command_AddAlt(command, "bizad");
    Command_AddAlt(command, "buisnessad");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:obiz(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Og³oszenie biznesowe.");
        return 1;
    }
    //fetching params
    new text[124];
    if(sscanf(params, "s[124]", text))
    {
        sendTipMessage(playerid, "U¿yj /obiz [og³oszenie] ");
        return 1;
    }
    
    //command body
    return command_obiz_Impl(playerid, text);
}