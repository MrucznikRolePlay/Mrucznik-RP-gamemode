//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 shotobject                                                //
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
#include "shotobject_impl.pwn"

//-------<[ initialize ]>-------
command_shotobject()
{
    new command = Command_GetID("shotobject");

    //aliases
    Command_AddAlt(command, "shootobject");
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:shotobject(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Tworzysz obiekt w miejscu strza³u.");
        return 1;
    }
    //fetching params
    new model, comment[128];
    if(sscanf(params, "dS()[128]", model, comment))
    {
        sendTipMessage(playerid, "U¿yj /shotobject [model] [comment] ");
        return 1;
    }
    
    //command body
    return command_shotobject_Impl(playerid, model, comment);
}