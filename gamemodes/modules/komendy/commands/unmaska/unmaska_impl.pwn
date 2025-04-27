//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  unmaska                                                  //
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
// Autor: wiger
// Data utworzenia: 27.04.2025


//

//------------------<[ Implementacja: ]>-------------------
command_unmaska_Impl(playerid, giveplayerid)
{
    if (PlayerInfo[playerid][pAdmin] < 1) {
        noAccessMessage(playerid);
        return 1;
    }

    new string[128];
    SetPlayerColor(giveplayerid, TEAM_HIT_COLOR);
    RemovePlayerAttachedObject(giveplayerid, 1);
    format(string, sizeof(string), "Zdj¹³eœ maskê graczowi %s", GetNick(giveplayerid));
    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    format(string, sizeof(string), "Admin %s zdj¹³ ci maskê", GetNick(playerid));
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
    return 1;
}

//end