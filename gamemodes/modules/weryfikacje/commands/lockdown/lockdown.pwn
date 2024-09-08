//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  lockdown                                                 //
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
#include "lockdown_impl.pwn"

//-------<[ initialize ]>-------
command_lockdown()
{
    new command = Command_GetID("lockdown");

    //aliases
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:lockdown(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "W³¹cza przetrzymywanie nowo zarejestrowanych kont w innym virtual wordzie do czasu /zweryfikuj od admina.");
        return 1;
    }
    //fetching params
    new typ;
    if(sscanf(params, "D(-1)", typ))
    {
        sendTipMessage(playerid, "U¿yj /lockdown [0 = Wy³¹czenie, 1 = W³¹czenie dla kont z 0h, 2 = W³¹czenie dla kont z mniej ni¿ 3h] ");
        return 1;
    }
    
    //command body
    return command_lockdown_Impl(playerid, typ);
}