//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  dnobiekt                                                 //
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
#include "dnobiekt_impl.pwn"

//-------<[ initialize ]>-------
command_dnobiekt()
{
    new command = Command_GetID("dnobiekt");

    //aliases
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:dnobiekt(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Doczepia obiekt do gracza.");
        return 1;
    }
    //fetching params
    new giveplayerid, index, model, bone, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz, materialcolor1, materialcolor2;
    if(sscanf(params, "rdddF(0.0)F(0.0)F(0.0)F(0.0)F(0.0)F(0.0)F(1.0)F(1.0)F(1.0)D(0)D(0)", giveplayerid, index, model, bone, x, y, z, rx, ry, rz, sx, sy, sz, materialcolor1, materialcolor2))
    {
        sendTipMessage(playerid, "U¿yj /dnobiekt [Nick/ID] [index] [model] [kosc] [x] [y] [z] [rx] [ry] [rz] [sx] [sy] [sz] [materialcolor1] [materialcolor2] ");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_dnobiekt_Impl(playerid, giveplayerid, index, model, bone, x, y, z, rx, ry, rz, sx, sy, sz, materialcolor1, materialcolor2);
}