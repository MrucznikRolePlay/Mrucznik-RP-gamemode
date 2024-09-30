//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                createobject                                               //
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
#include "createobject_impl.pwn"

//-------<[ initialize ]>-------
command_createobject()
{
    new command = Command_GetID("createobject");

    //aliases
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:createobject(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Tworzenie obiektu.");
        return 1;
    }
    //fetching params
    new model, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz;
    if(sscanf(params, "dfffF(0.0)F(0.0)F(0.0)", model, x, y, z, rx, ry, rz))
    {
        sendTipMessage(playerid, "U¿yj /createobject [model] [x] [y] [z] [rx] [ry] [rz] ");
        return 1;
    }
    
    //command body
    return command_createobject_Impl(playerid, model, x, y, z, rx, ry, rz);
}