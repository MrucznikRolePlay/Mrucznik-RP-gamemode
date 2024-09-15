//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_ticketend_Impl(playerid)
{
    if(PlayerInfo[playerid][pZG] == 0 && PlayerInfo[playerid][pNewAP] == 0 && PlayerInfo[playerid][pAdmin] == 0) return 1;
    if(GetPVarInt(playerid, "validticket") != 1) return 1;
    SetPVarInt(playerid, "validticket", 0);
    if(Unspec[playerid][Coords][0] != 0)
    {
        PlayerInfo[playerid][pInt] = Unspec[playerid][sPint];
    	PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
        SetPlayerInterior(playerid, Unspec[playerid][sPint]);
        SetPlayerVirtualWorld(playerid, Unspec[playerid][sPvw]);
    	SetPlayerPos(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
        Wchodzenie(playerid);
    }
    else
        SetPlayerSpawn(playerid);
    return 1;
}

//end
