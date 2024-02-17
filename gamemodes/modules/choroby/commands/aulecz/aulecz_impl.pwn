//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  uleczall                                                 //
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
// Autor: Sandal
// Data utworzenia: 23.01.2024


//

//------------------<[ Implementacja: ]>-------------------
command_aulecz_Impl(playerid, giveplayerid)
{
    if(PlayerInfo[playerid][pAdmin] < 1 && !IsAScripter(playerid))
    {
        noAccessMessage(playerid);
        return 1;
    }

    CureFromAllDiseases(giveplayerid);

    Log(adminLog, INFO, "Admin %s wyleczy³ gracza %s z wszystkich chorób.", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "Zosta³eœ uleczony z wszystkich chorób przez admina.");
    SendClientMessage(playerid, COLOR_WHITE, sprintf("Uleczy³eœ %s z wszystkich chorób.", GetNick(giveplayerid)));
    return 1;
}

//end