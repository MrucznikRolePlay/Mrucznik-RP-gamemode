//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ ticketend ]-----------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:ticketend(playerid, params[], help)
{
    if(PlayerInfo[playerid][pZG] == 0 && PlayerInfo[playerid][HalfAdmin] == 0 && PlayerInfo[playerid][Admin] == 0) return 1;
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
