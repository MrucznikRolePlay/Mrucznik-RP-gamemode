//------------------------------------------<< Generated source >>-------------------------------------------//
//                                              setvregistration                                             //
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
#include "setvregistration_impl.pwn"

//-------<[ initialize ]>-------
command_setvregistration()
{
    new command = Command_GetID("setvregistration");

    //aliases
    Command_AddAlt(command, "setcarreg");
    Command_AddAlt(command, "setrg");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:setvregistration(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Ustawia rejestracje wozu, w którym aktualnie siê znajdujesz.");
        return 1;
    }
    //fetching params
    new registerText[32];
    if(sscanf(params, "s[32]", registerText))
    {
        sendTipMessage(playerid, "U¿yj /setvregistration [Nowa rejestracja] ");
        return 1;
    }
    
    //command body
    return command_setvregistration_Impl(playerid, registerText);
}