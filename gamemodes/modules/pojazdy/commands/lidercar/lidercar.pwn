//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  lidercar                                                 //
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
#include "lidercar_impl.pwn"

//-------<[ initialize ]>-------
command_lidercar()
{
    new command = Command_GetID("lidercar");

    //aliases
    Command_AddAlt(command, "liderveh");
    Command_AddAlt(command, "leadercar");
    Command_AddAlt(command, "leaderveh");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:lidercar(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda dla liderów frakcji i organizacji pozwalaj¹ca zarz¹dzaæ ich pojazdem.");
        return 1;
    }
    //fetching params
    new akcja[16], opcje[256];
    if(sscanf(params, "s[16]S()[256]", akcja, opcje))
    {
        sendTipMessage(playerid, "U¿yj /lidercar [parkuj/przemaluj/ranga/przejmij] [opcje specyficzne dla wybranej akcji] ");
        return 1;
    }
    
    //command body
    return command_lidercar_Impl(playerid, akcja, opcje);
}