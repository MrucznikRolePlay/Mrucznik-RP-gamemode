//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  camsave                                                  //
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
#include "camsave_impl.pwn"

//-------<[ initialize ]>-------
command_camsave()
{
    new command = Command_GetID("camsave");

    //aliases
    Command_AddAlt(command, "camerasave");
    Command_AddAlt(command, "savecamera");
    Command_AddAlt(command, "savecam");
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:camsave(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Zapisuje pozycje kamery do scriptfiles/camera.txt");
        return 1;
    }
    //fetching params
    new comment[128];
    if(sscanf(params, "S()[128]", comment))
    {
        sendTipMessage(playerid, "U¿yj /camsave [komentarz] ");
        return 1;
    }
    
    //command body
    return command_camsave_Impl(playerid, comment);
}