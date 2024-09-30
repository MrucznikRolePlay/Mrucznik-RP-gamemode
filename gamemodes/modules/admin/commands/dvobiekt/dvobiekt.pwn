//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  dvobiekt                                                 //
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
#include "dvobiekt_impl.pwn"

//-------<[ initialize ]>-------
command_dvobiekt()
{
    new command = Command_GetID("dvobiekt");

    //aliases
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:dvobiekt(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Przyczepia obiekt do pojazdu.");
        return 1;
    }
    //fetching params
    new model, vehicleid, Float:ox, Float:oy, Float:oz, Float:rx, Float:ry, Float:rz;
    if(sscanf(params, "ddffffff", model, vehicleid, ox, oy, oz, rx, ry, rz))
    {
        sendTipMessage(playerid, "U¿yj /dvobiekt [model] [veh] [ox] [oy] [oz] [rx] [ry] [rz] ");
        return 1;
    }
    
    //command body
    return command_dvobiekt_Impl(playerid, model, vehicleid, ox, oy, oz, rx, ry, rz);
}