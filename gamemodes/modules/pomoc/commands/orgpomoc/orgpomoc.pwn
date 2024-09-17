//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  orgpomoc                                                 //
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
#include "orgpomoc_impl.pwn"

//-------<[ initialize ]>-------
command_orgpomoc()
{
    new command = Command_GetID("orgpomoc");

    //aliases
    Command_AddAlt(command, "orghelp");
    Command_AddAlt(command, "organizacjapomoc");
    Command_AddAlt(command, "organizationhelp");
    Command_AddAlt(command, "frachelp");
    Command_AddAlt(command, "fractionhelp");
    Command_AddAlt(command, "fracpomoc");
    Command_AddAlt(command, "frakcjapomoc");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:orgpomoc(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komendy dotycz¹ce frakcji/organizacji.");
        return 1;
    }
    
    
    //command body
    return command_orgpomoc_Impl(playerid);
}