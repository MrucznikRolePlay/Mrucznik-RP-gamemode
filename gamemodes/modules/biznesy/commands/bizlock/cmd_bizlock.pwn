//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  bizlock                                                  //
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
// Kod wygenerowany automatycznie narz�dziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN� NADPISANE PO WYWO�ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------
#include "bizlock_impl.pwn"

//-------<[ initialize ]>-------
command_bizlock()
{
    new command = Command_GetID("bizlock");

    //aliases
    Command_AddAlt(command, "zamknijbiznes");
    Command_AddAlt(command, "otworzbiznes");
    Command_AddAlt(command, "businesslock");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:bizlock(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Pozwala zamkn�� b�d� otworzy� tw�j biznes. Mo�e j� u�y� zar�wno cz�onek jak i w�asciciel biznesu.");
        return 1;
    }
    
    
    //command body
    return command_bizlock_Impl(playerid);
}