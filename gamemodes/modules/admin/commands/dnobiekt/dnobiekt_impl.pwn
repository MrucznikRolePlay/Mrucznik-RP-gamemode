//-----------------------------------------------<< Source >>------------------------------------------------//
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
// Autor: Mrucznik
// Data utworzenia: 21.08.2019


//

//------------------<[ Implementacja: ]>-------------------
command_dnobiekt_Impl(playerid, giveplayerid, index, model, bone, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz, materialcolor1, materialcolor2)
{
    if(!IsAHeadAdmin(playerid) && !IsAScripter(playerid))
    {
        sendErrorMessage(playerid, "Nie jesteœ uprawniony!");
        return 1;
    }

    SetPlayerAttachedObject(giveplayerid, index, model, bone, x, y, z, rx, ry, rz, sx, sy, sz, materialcolor1, materialcolor2);
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("Otrzyma³eœ przyczepialny obiekt tymczasowy od admina %s", GetNickEx(playerid)));
    return 1;
}

//end