//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  bizpomoc                                                 //
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
#include "bizpomoc_impl.pwn"

//-------<[ initialize ]>-------
command_bizpomoc()
{
    new command = Command_GetID("bizpomoc");

    //aliases
    Command_AddAlt(command, "biznespomoc");
    Command_AddAlt(command, "bizhelp");
    

    //permissions
    Group_SetCommand(Group_GetID("global"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:bizpomoc(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komendy dotycz¹ce biznesów.");
        return 1;
    }
    
    
    //command body
    return command_bizpomoc_Impl(playerid);
}