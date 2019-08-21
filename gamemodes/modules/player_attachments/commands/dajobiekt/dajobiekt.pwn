//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 dajobiekt                                                 //
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
#include "dajobiekt_impl.pwn"

//-------<[ initialize ]>-------
command_dajobiekt()
{
    new command = Command_GetID("dajobiekt");

    //aliases
    Command_AddAlt(command, "giveobject");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:dajobiekt(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Daje obiekt graczowi.");
        return 1;
    }
    //fetching params
    new giveplayerid, bone, model, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz, materialcolor1, materialcolor2;
    if(sscanf(params, "rddF(0.0)F(0.0)F(0.0)F(0.0)F(0.0)F(0.0)F(1.0)F(1.0)F(1.0)D(0)D(0)", giveplayerid, bone, model, x, y, z, rx, ry, rz, sx, sy, sz, materialcolor1, materialcolor2))
    {
        sendTipMessage(playerid, "U¿yj /dajobiekt [Nick/ID] [koœæ] [obiekt] [x] [y] [z] [rx] [ry] [rz] [sx] [sy] [sz] [materialcolor1] [materialcolor2] ");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_dajobiekt_Impl(playerid, giveplayerid, bone, model, x, y, z, rx, ry, rz, sx, sy, sz, materialcolor1, materialcolor2);
}