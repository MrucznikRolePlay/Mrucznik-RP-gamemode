//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ streamer ]-----------------------------------------------//
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

YCMD:streamer(playerid, params[], help)
{
    if(!Uprawnienia(playerid, ACCESS_OWNER)) return 1;
    new var[32], p1[32], p2[32];
    if(sscanf(params, "s[32]S(0)[32]S(0)[32]", var, p1, p2))
    {
        //SendClientMessage(playerid, -1, "/streamer [VAR] [param] [param]");
        sendTipMessage(playerid, "/streamer [VAR] [param] [param]");
        sendTipMessage(playerid, "SetMaxItems int int | SetVisibleItems int int | SetCellDistance float | SetCellSize float | CountItems int | CountVisibleItems int");
        sendTipMessage(playerid, "GetTickRate | SetTickRate int");
        return 1;
    }
    if(strcmp(var, "SetMaxItems", true) == 0)
    {
        if(strval(p2) == 0) return 1;
        Streamer_SetMaxItems(strval(p1), strval(p2));
        SendClientMessage(playerid, -1, "OK");
    }
    else if(strcmp(var, "SetVisibleItems", true) == 0)
    {
        if(strval(p2) == 0) return 1;
        Streamer_SetVisibleItems(strval(p1), strval(p2));
        SendClientMessage(playerid, -1, "OK");
    }
    else if(strcmp(var, "SetCellDistance", true) == 0)
    {
        if(floatstr(p1) == 0) return 1;
        Streamer_SetCellDistance(floatstr(p1));
        SendClientMessage(playerid, -1, "OK");
    }
    else if(strcmp(var, "SetCellSize", true) == 0)
    {
        if(floatstr(p1) == 0) return 1;
        Streamer_SetCellSize(floatstr(p1));
        SendClientMessage(playerid, -1, "OK");
    }
    else if(strcmp(var, "CountItems", true) == 0)
    {
        new cont = Streamer_CountItems(strval(p1));
        format(var, 32, "%d", cont);
        SendClientMessage(playerid, -1, var);
    }
    else if(strcmp(var, "CountVisibleItems", true) == 0)
    {
        new cont = Streamer_CountVisibleItems(strval(p1), strval(p2));
        format(var, 32, "%d", cont);
        SendClientMessage(playerid, -1, var);
    }
    else if(strcmp(var, "GetTickRate", true) == 0)
    {
        new cont = Streamer_GetTickRate();
        format(var, 32, "%d", cont);
        SendClientMessage(playerid, -1, var);
    }
    else if(strcmp(var, "SetTickRate", true) == 0)
    {
        if(strval(p1) < 1) return 1;
        Streamer_SetTickRate(strval(p1));
        SendClientMessage(playerid, -1, "OK");
    }
    return 1;
}
