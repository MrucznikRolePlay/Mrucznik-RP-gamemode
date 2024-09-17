//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 autopomoc                                                 //
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
#include "autopomoc_impl.pwn"

//-------<[ initialize ]>-------
command_autopomoc()
{
    new command = Command_GetID("autopomoc");

    //aliases
    Command_AddAlt(command, "carhelp");
    Command_AddAlt(command, "vehiclehelp");
    Command_AddAlt(command, "pojazdpomoc");
    Command_AddAlt(command, "samochodpomoc");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:autopomoc(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komendy dotycz¹ce pojazdów.");
        return 1;
    }
    
    
    //command body
    return command_autopomoc_Impl(playerid);
}