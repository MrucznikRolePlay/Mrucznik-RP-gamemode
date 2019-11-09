//-----------------------------------------------<< Source >>------------------------------------------------//
//                                             createconvoyactor                                             //
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
// Data utworzenia: 31.10.2019


//

//------------------<[ Implementacja: ]>-------------------
command_createconvoyactor_Impl(playerid, skin)
{
    if(PlayerInfo[playerid][pAdmin] < 1) {
        noAccessMessage(playerid);
        return 1;
    }

	new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    new actorid = CreateConvoyActor(skin, x, y, z, a); 
    if(actorid == -1) {
        sendErrorMessage(playerid, "Nie uda³o siê stworzyæ aktora - przekroczony limit aktorów");
        return 1;
    }
    SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Pomyœlnie stworzy³eœ aktora o ID %d.", actorid));
    return 1;
}

//end